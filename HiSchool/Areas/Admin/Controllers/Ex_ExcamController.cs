using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web.Mvc;
using Core.Model;
using Core.Service;
using Core.Ultity;
using Framework;
using WebMatrix.WebData;

namespace HiSchool.Areas.Admin.Controllers
{
    public class Ex_ExamController : Controller
    {
        #region Properties Class

        private readonly Ex_ExamAction _sysAction = new Ex_ExamAction();
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
            if (ViewBag.Host)
            {
                ViewBag.UsedStateAdd = Ultity.TFunction.GetUsedStateSelected(Ultity.Constant.Active);
            }
            else
            {
                ViewBag.UsedStateAdd = Ultity.TFunction.GetAllUsedStateSelectedNotAdmin(Ultity.Constant.Active);
            }
            ViewBag.UsedState = Ultity.TFunction.GetAllUsedStateSelected(Ultity.Constant.All);

            #region Danh sách môn học

            var lstSubeject = new SysAdminAction<Ex_Subject>().List("a.UsedState=1", "a.Orders desc", 0, 100);
            var itemsListSearch = new List<SelectListItem>();
            var itemsListEdit = new List<SelectListItem>();

            var selectListItemAll = new SelectListItem { Text = "Tất cả", Value = "", Selected = true };
            itemsListSearch.Add(selectListItemAll);
            if (lstSubeject != null)
            {
                for (int i = 0; i < lstSubeject.Count; i++)
                {
                    SelectListItem obj = new SelectListItem();
                    obj.Selected = false;
                    obj.Value = lstSubeject[i].Id.ToString();
                    obj.Text = lstSubeject[i].Name;
                    itemsListSearch.Add(obj);
                    itemsListEdit.Add(obj);
                }
            }

            ViewBag.ListSearch = itemsListSearch;
            ViewBag.EditSearch = itemsListEdit;
            ViewBag.Grade = new SysAdminAction<Ex_CategoryValue>().List("a.CatCode='KHOI'", "a.Orders desc", 0, 100);
            ViewBag.Level = new SysAdminAction<Ex_CategoryValue>().List("a.CatCode='DK'", "a.Orders desc", 0, 100);
            #endregion
            return View();
        }
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult GetData(int? page, int? pageSize, string key, int? sort, string usedState, string subjectId)
        {
            try
            {
                var objRef = new object[5];
                int currentPageIndex = page.HasValue ? page.Value - 1 : 0;
                if (currentPageIndex < 0) currentPageIndex = 0;
                pageSize = 100;
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
                if (!string.IsNullOrEmpty(subjectId))
                {
                    sWhere = string.IsNullOrEmpty(sWhere) ? "  a.SubjectId=" + subjectId + "" : (sWhere + " AND a.SubjectId=" + subjectId + " ");
                }
                string sSort = "a.CreatedDate DESC";
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
            var objTemporary = new Ex_Exam();
            try
            {
                int editId = id.HasValue ? id.Value : 0;
                if (editId > 0)
                {
                    objTemporary = new SysAdminAction<Ex_Exam>().GetById(editId);
                }
                return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = objTemporary });
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
        }
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult GetChuong(string key, string code)
        {
            try
            {
                string sWhere = (AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll)) ? " WHERE 1=1 " : " WHERE a.CreatedBy =" + WebSecurity.CurrentUserId;

                sWhere += " and a.Section like '%" + key + "%'";
                sWhere += " and a.ExamCode = '" + code.Trim() + "'";

                string sSort = " ORDER BY a.Orders DESC";
                var modelList = new Ex_ExamConfigAction().GetExamConfig(sWhere, sSort);

                //Check after deleted last item in page . Redirect page close have value smaller
                if (Request.IsAjaxRequest())
                {
                    return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = modelList });
                }
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
            return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
        }

        [Authentication.ViewPermissionFunctionUser(Edit = Ultity.Constant.sEdit, Add = Ultity.Constant.sAdd, Admin = Ultity.Constant.sView)]
        [HttpPost]
        public ActionResult Edit(Ex_Exam sysModel)
        {
            try
            {
                #region Redirect Request

                int succcess = 0;
                if (sysModel.Id > 0)
                {
                    var objTemporary = new SysAdminAction<Ex_Exam>().GetById(sysModel.Id);
                    if (AuthorizeUser.IsAction(Ultity.Constant.Edit) || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll))
                    {
                        sysModel.IdGuid = Guid.NewGuid().ToString();
                        sysModel.CreatedBy = objTemporary.CreatedBy;
                        sysModel.ModifiedDate = DateTime.Now;
                        sysModel.ModifiedBy = WebSecurity.CurrentUserId;
                        sysModel.CreatedDate = objTemporary.CreatedDate;
                        //sysModel.Name = objTemporary.Name;
                        if (!AuthorizeUser.IsHost())
                        {
                            sysModel.UsedState = objTemporary.UsedState;
                        }
                        succcess = _sysAction.Update(sysModel);
                    }
                    else { succcess = 1; }
                }
                else
                {
                    if (AuthorizeUser.IsAction(Ultity.Constant.Add) || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll))
                    {
                        sysModel.IdGuid = Guid.NewGuid().ToString();
                        sysModel.CreatedBy = WebSecurity.CurrentUserId;
                        sysModel.ModifiedBy = null;
                        sysModel.UsedState = Ultity.Constant.NotAccept;
                        sysModel.CreatedDate = DateTime.Now;
                        sysModel.ModifiedDate = null;
                        succcess = _sysAction.Insert(sysModel);
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
        //[Authentication.ViewPermissionFunctionUser(Delete = Ultity.Constant.sDelete)]
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView, Admin = Ultity.Constant.sView)]
        public ActionResult Delete(string id)
        {
            try
            {
                if (!string.IsNullOrEmpty(id))
                {
                    string sWhere = " Id IN (" + id.Trim() + ") ";
                    string sSet = "UsedState = " + Ultity.Constant.Request_Delete;

                    if (!AuthorizeUser.IsHost())
                    {
                        new SysAdminAction<Ex_Exam>().Updates(sSet, sWhere);
                        return Json(new { status = "success", Message = Ultity.Constant.Change_Delete_Success });
                    }
                    else
                    {
                        new SysAdminAction<Ex_Exam>().Deletes(sWhere);
                        return Json(new { status = "success", Message = Ultity.Constant.Delete_Success });
                    }
                    //Trigger auto to delete table related
                }
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
            catch (Exception exception)
            {
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
        }
        #endregion Properties Class
    }
}