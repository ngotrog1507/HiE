using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Core.Model;
using Core.Service;
using Core.Ultity;
using Framework;
using WebMatrix.WebData;

namespace HiSchool.Areas.Admin.Controllers
{
    [Authentication.IdentifierUser]
    public class SysUserController : Controller
    {
        #region Properties Class

        private readonly SysUserAction _sysAction = new SysUserAction();
        private readonly int rowInPage = CommonHelper.Convert.ConvertToInt32(ConfigurationManager.AppSettings[Ultity.Constant.rowInPage]);

        #endregion Properties Class
        // GET: Admin/SysUser
        #region Public Method
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult Index()
        {
            ViewBag.Host = AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll);
            ViewBag.Add = AuthorizeUser.IsAction(Ultity.Constant.Add);
            ViewBag.Edit = AuthorizeUser.IsAction(Ultity.Constant.Edit);
            ViewBag.Delete = AuthorizeUser.IsAction(Ultity.Constant.Delete);
            ViewBag.UsedStateAdd = Ultity.TFunction.GetUsedStateSelected(Ultity.Constant.Active);
            ViewBag.UsedState = Ultity.TFunction.GetAllUsedStateSelected(Ultity.Constant.All);
            return View();
        }
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult GetData(int? page, int? pageSize, string key, int? sort, string usedState)
        {
            try
            {
                var objRef = new object[5];
                int currentPageIndex = page.HasValue ? page.Value - 1 : 0;
                if (currentPageIndex < 0) currentPageIndex = 0;
                pageSize = pageSize.HasValue ? pageSize : rowInPage;
                string sWhere = (AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll)) ? " 1=1 " : " a.CreatedBy =" + WebSecurity.CurrentUserId;
                if (!string.IsNullOrEmpty(key))
                {
                    key = key.Trim();
                    ViewBag.Search = key;
                    sWhere += " and ( a.FullName like N'%" + key + "%' or dbo.ConvertToNoSigned(a.FullName) like  dbo.ConvertToNoSigned(N'%" + key + "%') ";
                    sWhere += " or  a.UserName like N'%" + key + "%' or dbo.ConvertToNoSigned(a.UserName) like  dbo.ConvertToNoSigned(N'%" + key + "%')) ";
                }

                if (!string.IsNullOrEmpty(usedState))
                {
                    if (!usedState.Equals(Ultity.Constant.All.ToString()))
                    {
                        ViewBag.UsedState = Ultity.TFunction.GetAllUsedStateSelected(CommonHelper.Convert.ConvertToInt32(usedState));
                        sWhere = string.IsNullOrEmpty(sWhere) ? " a.UsedState=" + usedState + "" : (sWhere + " AND a.UsedState=" + usedState + " ");
                    }
                }
                string sSort = "a.CreatedDate DESC";
                if (sort.HasValue)
                {
                    switch (sort.Value)
                    {
                        case 0:
                            sSort = "a.Name ASC";
                            ViewBag.SortName = "1";
                            break;

                        case 1:
                            sSort = "a.Name DESC";
                            ViewBag.SortName = "2";
                            break;

                        case 2:
                            ViewBag.SortName = "0";
                            sSort = "a.Orders ASC";
                            break;
                    }
                }
                else
                {
                    ViewBag.SortName = "0";
                }
                objRef[0] = sWhere;
                objRef[1] = sSort;
                objRef[2] = currentPageIndex;
                objRef[3] = pageSize;
                objRef[4] = 0;
                var modelList = _sysAction.List(ref objRef);
                int totalRow = CommonHelper.Convert.ConvertToInt32(objRef[4]);

                //Check after deleted last item in page . Redirect page close have value smaller
                if (Request.IsAjaxRequest())
                {
                    return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = modelList, TotalPage = totalRow, CurrentPage = currentPageIndex, PageSize = pageSize });
                }
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
            return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
        }
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult GetById(int? id)
        {
            var objTemporary = new SysUser();
            try
            {
                int editId = id.HasValue ? id.Value : 0;
                if (editId > 0)
                {
                    objTemporary = _sysAction.GetById(editId);
                }
                return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = objTemporary });
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }

        }
        [Authentication.ViewPermissionFunctionUser(Edit = Ultity.Constant.sEdit, Add = Ultity.Constant.sAdd, Admin = Ultity.Constant.sView)]
        [HttpPost]
        public ActionResult Edit(SysUser sysModel)
        {
            try
            {
                int id = CommonHelper.Convert.ConvertToInt32(sysModel.Id);
                int isSuc = 0;
                if (sysModel.Id == 0)
                {
                    sysModel.UserName = sysModel.UserName.Trim();
                    sysModel.FullName = string.IsNullOrEmpty(sysModel.FullName) ? string.Empty : sysModel.FullName.Trim();
                    if (!WebSecurity.UserExists(sysModel.UserName))
                    {
                        try
                        {
                            //Create User Membership
                            if (AuthorizeUser.IsAction(Ultity.Constant.Add) || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll))
                            {
                                WebSecurity.CreateUserAndAccount(sysModel.UserName.Trim(), sysModel.Password.Trim());

                                //Get UserByName
                                int userId = WebSecurity.GetUserId(sysModel.UserName);
                                if (userId > 0)
                                {
                                    //Create CoreSys User
                                    try
                                    {
                                        var model = new SysUser();
                                        model.Id = userId;
                                        model.UserId = userId;
                                        model.CreatedBy = WebSecurity.CurrentUserId;
                                        model.FullName = sysModel.FullName.Trim();
                                        model.UserName = sysModel.UserName.Trim();
                                        model.Email = sysModel.Email;
                                        model.Phone = sysModel.Phone;
                                        model.Host = sysModel.Host;
                                        model.Gender = sysModel.Gender;
                                        model.BCoin = 0;
                                        model.UsedState = sysModel.UsedState;
                                        model.CreatedDate = DateTime.Now;
                                        isSuc = _sysAction.Insert(model);
                                    }
                                    catch (Exception exception)
                                    {
                                        ((SimpleMembershipProvider)Membership.Provider).DeleteUser(sysModel.UserName.Trim(), true);
                                        new SysAdminAction<SysUser>().Deletes("UserId=" + userId);
                                    }
                                }
                            }
                            else { isSuc = 1; }
                        }
                        catch (Exception exception)
                        {
                            Ultity.TFunction.WriteToLog(exception);
                            return Json(new { status = "error", Message = "Đã tồn tại Username này trong hệ thống !" });
                        }
                    }
                    else
                    {
                        //return
                        return Json(new { status = "exits", Message = "Đã tồn tại Username này trong hệ thống !" });
                    }
                }
                else
                {
                    //Get User By Id
                    SysUser item = _sysAction.GetById(sysModel.Id);
                    if (item != null)
                    {
                        if (AuthorizeUser.IsAction(Ultity.Constant.Edit) || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll))
                        {
                            item.ModifiedBy = WebSecurity.CurrentUserId;
                            item.FullName = sysModel.FullName.Trim();
                            item.UserName = sysModel.UserName.Trim();
                            item.Email = sysModel.Email;
                            item.Phone = sysModel.Phone;
                            item.Host = sysModel.Host;
                            item.BCoin = sysModel.BCoin;
                            item.Gender = sysModel.Gender;
                            item.ImageUrl = sysModel.ImageUrl;
                            item.UsedState = sysModel.UsedState;
                            item.ModifiedDate = DateTime.Now;
                            item.CreatedDate = DateTime.Now;
                            isSuc = _sysAction.Update(item);
                        }
                        else { isSuc = 1; }
                    }
                }

                return Json(new { status = "success", Message = Ultity.Constant.Ajax_Fail });
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
        }
        [Authentication.ViewPermissionFunctionUser(Delete = Ultity.Constant.sDelete, Admin = Ultity.Constant.sView)]
        public ActionResult Delete(string id)
        {
            try
            {
                if (!string.IsNullOrEmpty(id))
                {
                    if (Request.IsAjaxRequest())
                    {
                        string sWhere = " UserId IN (" + id.Trim() + ") ";
                        string sSet = "UsedState = " + Ultity.Constant.Request_Delete;
                        string tableName = "SysUser";
                        if (!AuthorizeUser.IsHost())
                        {
                            new SysAdminAction<SysUser>().Updates(sSet, sWhere);
                            return Json(new { status = "success", Message = Ultity.Constant.Change_Delete_Success });
                        }
                        else
                        {
                            if (id.Contains(","))
                            {
                                var idList = id.Split(',');
                                foreach (var item in idList)
                                {
                                    var model = _sysAction.GetById(CommonHelper.Convert.ConvertToInt32(item));
                                    ((SimpleMembershipProvider)Membership.Provider).DeleteUser(model.UserName, true);
                                    new SysAdminAction<SysUser>().Deletes("UserId =" + item);
                                }
                            }
                            else
                            {
                                var model = _sysAction.GetById(CommonHelper.Convert.ConvertToInt32(id));
                                ((SimpleMembershipProvider)Membership.Provider).DeleteUser(model.UserName, true);
                                new SysAdminAction<SysUser>().Deletes(sWhere);
                            }

                            return Json(new { status = "success", Message = Ultity.Constant.Delete_Success });
                        }
                        //Trigger auto to delete table related
                    }
                }
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
            catch (Exception exception)
            {
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
        }
        [Authentication.ViewPermissionFunctionUser(Add = Ultity.Constant.sAdd, Admin = Ultity.Constant.sView)]
        public ActionResult AddTeacher(SysUser sysModel)
        {
            if (sysModel.Id == 0)
            {
                sysModel.UserName = sysModel.UserName.Trim();
                sysModel.FullName = string.IsNullOrEmpty(sysModel.FullName) ? string.Empty : sysModel.FullName.Trim();
                if (!WebSecurity.UserExists(sysModel.UserName))
                {
                    try
                    {
                        //Create User Membership
                        if (AuthorizeUser.IsAction(Ultity.Constant.Add) || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll))
                        {
                            WebSecurity.CreateUserAndAccount(sysModel.UserName.Trim(), sysModel.Password.Trim());

                            //Get UserByName
                            int userId = WebSecurity.GetUserId(sysModel.UserName);
                            if (userId > 0)
                            {
                                //Create CoreSys User
                                try
                                {
                                    #region + Thêm vào bảng SysUser
                                    var model = new SysUser();
                                    model.Id = userId;
                                    model.UserId = userId;
                                    model.CreatedBy = WebSecurity.CurrentUserId;
                                    model.FullName = sysModel.FullName.Trim();
                                    model.UserName = sysModel.UserName.Trim();
                                    model.Email = sysModel.Email;
                                    model.ImageUrl = sysModel.ImageUrl;
                                    model.Phone = sysModel.Phone;
                                    model.Summary = sysModel.Summary;
                                    model.Host = sysModel.Host;
                                    model.Gender = sysModel.Gender;
                                    model.BCoin = 0;
                                    model.UsedState = sysModel.UsedState;
                                    model.CreatedDate = DateTime.Now;
                                    _sysAction.Insert(model);
                                    #endregion

                                    #region +Thêm vào nhóm Giáo viên
                                    var sysGroupUser = new SysGroupUser();
                                    sysGroupUser.CreatedBy = WebSecurity.CurrentUserId;
                                    sysGroupUser.CreatedDate = DateTime.Now;
                                    sysGroupUser.GroupId = 20;
                                    sysGroupUser.Orders = 2;
                                    sysGroupUser.UserId = userId;
                                    sysGroupUser.UsedState = Ultity.Constant.Active;
                                    new SysGroupUserAction().Add(sysGroupUser);
                                    #endregion
                                }
                                catch (Exception exception)
                                {
                                    ((SimpleMembershipProvider)Membership.Provider).DeleteUser(sysModel.UserName.Trim(), true);
                                    new SysAdminAction<SysUser>().Deletes("UserId=" + userId);
                                }
                            }
                            return Json(new { status = "success" });
                        }
                        return Json(new { status = "error", Message = "Đã tồn tại Username này trong hệ thống !" });
                    }
                    catch (Exception exception)
                    {
                        Ultity.TFunction.WriteToLog(exception);
                        return Json(new { status = "error", Message = "Đã tồn tại Username này trong hệ thống !" });
                    }
                }
                else
                {
                    return Json(new { status = "exits", Message = "Đã tồn tại Username này trong hệ thống !" });
                }
            }
            else
            {
                //Get User By Id
                SysUser item = _sysAction.GetById(sysModel.Id);
                if (item != null)
                {
                    if (!string.IsNullOrEmpty(sysModel.Password))
                    {
                        var token = WebSecurity.GeneratePasswordResetToken(sysModel.UserName);
                        // link directed to an action with form to capture password
                        WebSecurity.ResetPassword(token, sysModel.Password);
                    }
                    if (AuthorizeUser.IsAction(Ultity.Constant.Edit) || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll))
                    {
                        item.ModifiedBy = WebSecurity.CurrentUserId;
                        item.FullName = sysModel.FullName.Trim();
                        item.Email = sysModel.Email;
                        item.Phone = sysModel.Phone;
                        item.Host = sysModel.Host;
                        item.BCoin = sysModel.BCoin;
                        item.Gender = sysModel.Gender;
                        item.Summary = sysModel.Summary;
                        item.ImageUrl = sysModel.ImageUrl;
                        item.UsedState = sysModel.UsedState;
                        item.ModifiedDate = DateTime.Now;
                        item.CreatedDate = DateTime.Now;
                         _sysAction.Update(item);
                    }
                }
            }

            return Json(new { status = "success", Message = Ultity.Constant.Ajax_Fail });
        }
        #endregion Properties Class
    }
}