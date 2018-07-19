using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Model;
using Core.Service;
using Core.Ultity;
using Framework;
using WebMatrix.WebData;

namespace HiSchool.Areas.Admin.Controllers
{
    [Authentication.IdentifierUser]
    public class SysGroupController : Controller
    {
        #region Properties Class

        private readonly SysGroupAction _sysAction = new SysGroupAction();
        private readonly SysGroupUserAction _sysGroupUserAction = new SysGroupUserAction();
        private readonly int rowInPage = CommonHelper.Convert.ConvertToInt32(ConfigurationManager.AppSettings[Ultity.Constant.rowInPage]);

        #endregion Properties Class

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
            var list = new List<SysGroup>();
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
                    sWhere += "and  ( a.Name like N'%" + key + "%' or dbo.ConvertToNoSigned(a.Name) like  dbo.ConvertToNoSigned(N'%" + key + "%')) ";
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
            var objTemporary = new SysGroup();
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
        public ActionResult Edit(SysGroup sysModel)
        {
            try
            {
                #region Redirect Request

                int succcess;
                if (sysModel.Id > 0)
                {
                    var objTemporary = _sysAction.GetById(sysModel.Id);
                    if (AuthorizeUser.IsAction(Ultity.Constant.Edit) || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll))
                    {
                    sysModel.CreatedBy = objTemporary.CreatedBy;
                    sysModel.ModifiedDate = DateTime.Now;
                    sysModel.ModifiedBy = WebSecurity.CurrentUserId;
                    sysModel.CreatedDate = objTemporary.CreatedDate;
                    succcess = _sysAction.Update(sysModel.Id, sysModel.Name, sysModel.Summary, CommonHelper.Convert.ConvertToInt32(sysModel.UsedState), CommonHelper.Convert.ConvertToDateTime(sysModel.CreatedDate), CommonHelper.Convert.ConvertToInt32(sysModel.CreatedBy), sysModel.ModifiedDate, sysModel.ModifiedBy);
                    }
                    else { succcess = 1; }
                }
                else
                {
                    if (AuthorizeUser.IsAction(Ultity.Constant.Add) || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll))
                    {
                        sysModel.CreatedBy = WebSecurity.CurrentUserId;
                    sysModel.ModifiedBy = null;
                    sysModel.CreatedDate = DateTime.Now;
                    sysModel.ModifiedDate = null;
                    succcess = _sysAction.Insert(sysModel.Name, sysModel.Summary, CommonHelper.Convert.ConvertToInt32(sysModel.UsedState), CommonHelper.Convert.ConvertToDateTime(sysModel.CreatedDate), CommonHelper.Convert.ConvertToInt32(sysModel.CreatedBy), sysModel.ModifiedDate, sysModel.ModifiedBy);
                    }
                    else { succcess = 1; }
                }

                if (succcess > 0)
                {
                    return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success });
                }
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
                #endregion Redirect Request
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
            }

            return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
        }
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult GetListUser(int groupId, string name)
        {
            var obj = new List<SysUser>();
            try
            {
                obj = _sysAction.GetUserInGroup(groupId, name);
                return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = obj });
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new
                {
                    status = "fail",
                    Message = Ultity.Constant.Ajax_Fail
                });
            }
        }
        [Authentication.ViewPermissionFunctionUser(Delete = Ultity.Constant.sDelete, Admin = Ultity.Constant.sView)]
        public ActionResult DeleteGroupUser(int groupId, int userId)
        {
            try
            {
                if (groupId > 0 && userId > 0)
                {
                    var result = _sysGroupUserAction.DeleteGroupUser(groupId, userId);
                    return Json(new { status = result > 0 ? "success" : "fail", Message = Ultity.Constant.Ajax_Success, Data = result });
                }
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Success, Data = string.Empty });

            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new
                {
                    status = "fail",
                    Message = Ultity.Constant.Ajax_Fail
                });
            }
        }
        [Authentication.ViewPermissionFunctionUser(Add = Ultity.Constant.sAdd, Admin = Ultity.Constant.sView)]
        public ActionResult SaveGroupUser(int groupId, string user)
        {
            try
            {
                string[] listUserId = user.Split(',');
                if (listUserId.Length > 0)
                {
                    for (int i = 0; i < listUserId.Length; i++)
                    {
                        var model = new SysGroupUser();
                        model.CreatedBy = WebSecurity.CurrentUserId;
                        model.CreatedDate = DateTime.Now;
                        model.GroupId = groupId;
                        model.Orders = 2;
                        model.UserId = CommonHelper.Convert.ConvertToInt32(listUserId[i]);
                        model.UsedState = Ultity.Constant.Active;
                        _sysGroupUserAction.Add(model);
                    }

                }
                return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = string.Empty });
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new
                {
                    status = "fail",
                    Message = Ultity.Constant.Ajax_Fail
                });
            }
        }
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult GetListUserOutGroup(int groupId, string name)
        {
            var obj = new List<SysUser>();
            try
            {
                obj = _sysAction.GetUserNotInGroup(groupId, name);
                return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = obj });
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new
                {
                    status = "fail",
                    Message = Ultity.Constant.Ajax_Fail
                });
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
                        string sWhere = " Id IN (" + id.Trim() + ") ";
                        string sSet = "UsedState = " + Ultity.Constant.Request_Delete;
                        
                        if (!AuthorizeUser.IsHost())
                        {
                            new SysAdminAction<SysGroup>().Updates( sSet, sWhere);
                            return Json(new { status = "success", Message = Ultity.Constant.Change_Delete_Success });
                        }
                        else
                        {
                            if (id.Contains(","))
                            {
                                var idList = id.Split(',');
                                int checkErr = 0;
                                foreach (var item in idList)
                                {
                                    var modelUser = new SysGroupUserAction().GetByGroupId(CommonHelper.Convert.ConvertToInt32(item));
                                    var modelMenu = new SysGroupMenuAction().GetByGroupId(CommonHelper.Convert.ConvertToInt32(item));
                                    if (modelUser.Count > 0 || modelMenu.Count > 0)
                                    {
                                        checkErr++;
                                    }
                                    else
                                    {
                                        new SysAdminAction<SysGroup>().Deletes( "Id =" + item);
                                    }
                                }
                                if(checkErr>0) return Json(new { status = "warning", Message = Ultity.Constant.Delete_Success_Err });
                            }
                            else
                            {
                                var modelUser = new SysGroupUserAction().GetByGroupId(CommonHelper.Convert.ConvertToInt32(id));
                                var modelMenu = new SysGroupMenuAction().GetByGroupId(CommonHelper.Convert.ConvertToInt32(id));
                                if (modelUser.Count > 0 || modelMenu.Count > 0)
                                {
                                    return Json(new { status = "warning", Message = Ultity.Constant.Delete_Success_Err });
                                }
                                else
                                {
                                    new SysAdminAction<SysGroup>().Deletes( sWhere);
                                }
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
        #endregion Public Method

    }
}