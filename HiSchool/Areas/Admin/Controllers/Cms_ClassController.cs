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
    public class Cms_ClassController : Controller
    {
        #region Properties Class

        private readonly Cms_ClassAction _sysAction = new Cms_ClassAction();
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
            //ViewBag.TypeList = new SysAdminAction<Cms_ClassVideo>().List("a.UsedState=1 and a.Type=" + Ultity.Constant.Video, "a.Orders asc", 0, 100);

            ViewBag.Grade = new SysAdminAction<Ex_CategoryValue>().List("a.CatCode='KHOI'", "a.Orders desc", 0, 100);

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
            var objTemporary = new Cms_Class();
            try
            {
                int editId = id.HasValue ? id.Value : 0;
                if (editId > 0)
                {
                    objTemporary = new SysAdminAction<Cms_Class>().GetById(editId);
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
        public ActionResult Edit(Cms_Class sysModel)
        {
            try
            {
                #region Redirect Request

                int succcess = 0;
                if (sysModel.Id > 0)
                {
                    var objTemporary = new SysAdminAction<Cms_Class>().GetById(sysModel.Id);
                    if (AuthorizeUser.IsAction(Ultity.Constant.Edit) || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll))
                    {
                        sysModel.IdGuid = objTemporary.IdGuid;
                        sysModel.CreatedBy = objTemporary.CreatedBy;
                        sysModel.ModifiedDate = DateTime.Now;
                        sysModel.ModifiedBy = WebSecurity.CurrentUserId;
                        sysModel.CreatedDate = objTemporary.CreatedDate;
                        sysModel.TeacherId = objTemporary.TeacherId;
                        sysModel.UsedState = objTemporary.UsedState;
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
                        sysModel.CreatedDate = DateTime.Now;
                        sysModel.ModifiedDate = null;
                        sysModel.UsedState = Ultity.Constant.NotActive;
                        sysModel.TeacherId = WebSecurity.CurrentUserId;
                        sysModel.Star = 0;
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
        [Authentication.ViewPermissionFunctionUser(Delete = Ultity.Constant.sDelete, Admin = Ultity.Constant.sView)]
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
                        new SysAdminAction<Cms_Class>().Updates(sSet, sWhere);
                        return Json(new { status = "success", Message = Ultity.Constant.Change_Delete_Success });
                    }
                    else
                    {
                        new SysAdminAction<Cms_Class>().Updates(sSet,sWhere);
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

        public ActionResult GetSubjectByGrade(string grade)
        {
            try
            {
                var objTemporary = new Ex_SubjectAction().GetSubjectByGrade(grade);
                return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = objTemporary }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail }, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion Properties Class
    }
}