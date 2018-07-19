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

namespace HiSchool.Areas.Admin.Controllers
{
    [Authentication.IdentifierUser]
    public class SysGroupMenuController : Controller
    {
        #region Properties Class

        private readonly SysGroupMenuAction _sysAction = new SysGroupMenuAction();
        private readonly SysGroupAction _sysGroupAction = new SysGroupAction();

        #endregion Properties Class

        #region Public Method
       
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult Index()
        {
            ViewBag.Host = AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll);
            ViewBag.Add = AuthorizeUser.IsAction(Ultity.Constant.Add);
            ViewBag.Edit = AuthorizeUser.IsAction(Ultity.Constant.Edit);
            ViewBag.Delete = AuthorizeUser.IsAction(Ultity.Constant.Delete);

            var objRef = new object[5];
            string sSort = "a.CreatedDate DESC";
            objRef[0] = "";
            objRef[1] = sSort;
            objRef[2] = 0;
            objRef[3] = 100;
            objRef[4] = 0;
            var modelList = _sysGroupAction.List(ref objRef);
            ViewBag.ListGroup = modelList;
            return View();
        }
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult GetMenuByGroupId(int groupId)
        {
            var list = new List<SysGroupMenuSort>();
            try
            {
                list = _sysAction.GetMenuByGroupId(groupId);
                return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = list });
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
        public ActionResult GetRoleByGroupMenu(int groupId,int menuId)
        {
            var obj = new GroupMenuObj();
            try
            {
                obj = _sysAction.GetRole(groupId, menuId);
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
        [Authentication.ViewPermissionFunctionUser(Add = Ultity.Constant.sAdd, Admin = Ultity.Constant.sView, Delete = Ultity.Constant.sDelete)]
        public ActionResult SaveRoleByGroupMenu(int groupId, int menuId,int add, int edit, int deletes,int accept,int export,int admin)
        {
            try
            {
                SysGroupMenu sysGroupMenu = new SysGroupMenu();
                sysGroupMenu.Orders = 1;
                sysGroupMenu.UsedState = 1;
                if (groupId != 0 && menuId != 0)
                {
                    #region Add
                    var modelAdd = _sysAction.FindByRole(groupId, menuId, Ultity.Constant.Add);
                    if (add == 1)
                    {
                        if (modelAdd.Id == 0) //Insert
                        {
                            sysGroupMenu.CreatedBy = 1;
                            sysGroupMenu.CreatedDate = DateTime.Now;
                            sysGroupMenu.GroupId = groupId;
                            sysGroupMenu.MenuId = menuId;
                            sysGroupMenu.RoleId = Ultity.Constant.Add;
                            sysGroupMenu.RoleName = Ultity.Constant.sAdd;
                            _sysAction.Insert(sysGroupMenu);
                        }
                    }
                    if (add == 0)
                    {
                        if (modelAdd.Id != 0)
                        {
                            _sysAction.Delete(modelAdd.Id);
                        }
                    }
                    #endregion

                    #region Edit
                    var modelEdit = _sysAction.FindByRole(groupId, menuId, Ultity.Constant.Edit);
                    if (edit == 1)
                    {
                        if (modelEdit.Id == 0) //Insert
                        {
                            sysGroupMenu.CreatedBy = 1;
                            sysGroupMenu.CreatedDate = DateTime.Now;
                            sysGroupMenu.GroupId = groupId;
                            sysGroupMenu.MenuId = menuId;
                            sysGroupMenu.RoleId = Ultity.Constant.Edit;
                            sysGroupMenu.RoleName = Ultity.Constant.sEdit;
                            _sysAction.Insert(sysGroupMenu);
                        }
                    }
                    if (edit == 0)
                    {
                        if (modelEdit.Id != 0)
                        {
                            _sysAction.Delete(modelEdit.Id);
                        }
                    }
                    #endregion

                    #region Delete
                    var modelDelete = _sysAction.FindByRole(groupId, menuId, Ultity.Constant.Delete);
                    if (deletes == 1)
                    {
                        if (modelDelete.Id == 0) //Insert
                        {
                            sysGroupMenu.CreatedBy = 1;
                            sysGroupMenu.CreatedDate = DateTime.Now;
                            sysGroupMenu.GroupId = groupId;
                            sysGroupMenu.MenuId = menuId;
                            sysGroupMenu.RoleId = Ultity.Constant.Delete;
                            sysGroupMenu.RoleName = Ultity.Constant.sDelete;
                            _sysAction.Insert(sysGroupMenu);
                        }
                    }
                    if (deletes == 0)
                    {
                        if (modelDelete.Id != 0)
                        {
                            _sysAction.Delete(modelDelete.Id);
                        }
                    }
                    #endregion

                    #region Accept
                    var modelAccept = _sysAction.FindByRole(groupId, menuId, Ultity.Constant.Accept);
                    if (accept == 1)
                    {
                        if (modelAccept.Id == 0) //Insert
                        {
                            sysGroupMenu.CreatedBy = 1;
                            sysGroupMenu.CreatedDate = DateTime.Now;
                            sysGroupMenu.GroupId = groupId;
                            sysGroupMenu.MenuId = menuId;
                            sysGroupMenu.RoleId = Ultity.Constant.Accept;
                            sysGroupMenu.RoleName = Ultity.Constant.sAccept;
                            _sysAction.Insert(sysGroupMenu);
                        }
                    }
                    if (accept == 0)
                    {
                        if (modelAccept.Id != 0)
                        {
                            _sysAction.Delete(modelAccept.Id);
                        }
                    }
                    #endregion

                    #region Export
                    var modelExport = _sysAction.FindByRole(groupId, menuId, Ultity.Constant.Export);
                    if (export == 1)
                    {
                        if (modelExport.Id == 0) //Insert
                        {
                            sysGroupMenu.CreatedBy = 1;
                            sysGroupMenu.CreatedDate = DateTime.Now;
                            sysGroupMenu.GroupId = groupId;
                            sysGroupMenu.MenuId = menuId;
                            sysGroupMenu.RoleId = Ultity.Constant.Export;
                            sysGroupMenu.RoleName = Ultity.Constant.sExport;
                            _sysAction.Insert(sysGroupMenu);
                        }
                    }
                    if (export == 0)
                    {
                        if (modelExport.Id != 0)
                        {
                            _sysAction.Delete(modelExport.Id);
                        }
                    }
                    #endregion

                    #region Admin
                    var modelAdmin = _sysAction.FindByRole(groupId, menuId, Ultity.Constant.ViewEditAll);
                    if (admin == 1)
                    {
                        if (modelAdmin.Id == 0) //Insert
                        {
                            sysGroupMenu.CreatedBy = 1;
                            sysGroupMenu.CreatedDate = DateTime.Now;
                            sysGroupMenu.GroupId = groupId;
                            sysGroupMenu.MenuId = menuId;
                            sysGroupMenu.RoleId = Ultity.Constant.ViewEditAll;
                            sysGroupMenu.RoleName = Ultity.Constant.sAdmin;
                            _sysAction.Insert(sysGroupMenu);
                        }
                    }
                    if (admin == 0)
                    {
                        if (modelAdmin.Id != 0)
                        {
                            _sysAction.Delete(modelAdmin.Id);
                        }
                    }
                    #endregion
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
        public ActionResult SaveShowMenu(string menu,int groupId)
        {
            SysGroupMenu sysModel = new SysGroupMenu();
            sysModel.Orders = 1;
            sysModel.UsedState = 1;
            try
            {
                if (groupId > 0)
                {
                    string[] listMenu = menu.Split(',');

                    for (int i = 0; i < listMenu.Length; i++)
                    {
                        var model = _sysAction.FindByRole(groupId, Convert.ToInt32(listMenu[i].Split('-')[0]),
                            Ultity.Constant.View);
                        if (Convert.ToInt32(listMenu[i].Split('-')[1]) > 0)
                        {
                            if (model.Id == 0)
                            {
                                sysModel.CreatedBy = 1;
                                sysModel.CreatedDate = DateTime.Now;
                                sysModel.GroupId = groupId;
                                sysModel.MenuId = Convert.ToInt32(listMenu[i].Split('-')[0]);
                                sysModel.RoleId = Ultity.Constant.View;
                                sysModel.RoleName = Ultity.Constant.sView;
                                _sysAction.Insert(sysModel);
                            }
                        }
                        else
                        {
                            var lstModel = _sysAction.FindByMenu(groupId, Convert.ToInt32(listMenu[i].Split('-')[0]));
                            if (lstModel != null && lstModel.Count() > 0)
                            {
                                for (int j = 0; j < lstModel.Count(); j++)
                                {
                                    if (lstModel[j].Id != 0)
                                    {
                                        _sysAction.Delete(lstModel[j].Id);
                                    }
                                }
                            }
                        }
                    }
                    return Json(new {status = "success", Message = Ultity.Constant.Ajax_Success, Data = ""});
                }
                else
                {
                    return Json(new
                    {
                        status = "fail",
                        Message = Ultity.Constant.Ajax_Fail
                    });
                }
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

        #endregion Properties
    }
}