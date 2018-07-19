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
using static Core.Ultity.Ultity;

namespace HiSchool.Areas.Admin.Controllers
{
    public class AcceptClassController : Controller
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
            ViewBag.Accept = AuthorizeUser.IsAction(Ultity.Constant.Accept);
            ViewBag.UsedStateAdd = Ultity.TFunction.GetUsedStateSelected(Ultity.Constant.Active);
            //ViewBag.TypeList = new SysAdminAction<Cms_ClassVideo>().List("a.UsedState=1 and a.Type=" + Ultity.Constant.Video, "a.Orders asc", 0, 100);

            string[] str = { Constant.UsedState_Delete, Constant.UsedState_NotActive };
            var itemsList = new List<SelectListItem>();
            for (int i = -1; i < str.Length - 1; i++)
            {
                bool isSelected = false;
                if (i == Constant.NotActive)
                {
                    isSelected = true;
                }
                var selectListItem = new SelectListItem { Text = str[i + 1], Value = CommonHelper.Convert.ConvertToString(i), Selected = isSelected };
                itemsList.Add(selectListItem);
            }
            ViewBag.UsedState = itemsList;
            ViewBag.Grade = new SysAdminAction<Ex_CategoryValue>().List("a.CatCode='KHOI'", "a.Orders desc", 0, 100);

            return View();
        }
        [Authentication.ViewPermissionFunctionUser(Accept = Ultity.Constant.sAccept, View = Ultity.Constant.sView)]
        public ActionResult GetData(int? page, int? pageSize, string key, int? sort, string usedState)
        {
            try
            {
                var objRef = new object[5];
                int currentPageIndex = page.HasValue ? page.Value - 1 : 0;
                if (currentPageIndex < 0) currentPageIndex = 0;
                pageSize = pageSize.HasValue ? pageSize : rowInPage;
                string sWhere = (AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll) || AuthorizeUser.IsAction(Ultity.Constant.Accept)) ? " 1=1 " : " a.CreatedBy =" + WebSecurity.CurrentUserId;
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

        [Authentication.ViewPermissionFunctionUser(Accept = Ultity.Constant.sAccept)]
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
        [Authentication.ViewPermissionFunctionUser(Accept = Ultity.Constant.sAccept)]
        public ActionResult AcceptModel(int? id)
        {
            try
            {
                string sWhere = " Id IN (" + id + ") ";
                string sSet = "UsedState = " + Ultity.Constant.Active;
                new SysAdminAction<Cms_Class>().Updates(sSet, sWhere);
                return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success });
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
        }
        [Authentication.ViewPermissionFunctionUser(Accept = Ultity.Constant.sAccept, Admin = Ultity.Constant.sView)]
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
                        new SysAdminAction<Cms_Class>().Deletes(sWhere);
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

        [Authentication.ViewPermissionFunctionUser(Accept = Ultity.Constant.sAccept, View = Ultity.Constant.sView)]
        public ActionResult GetSubjectByGrade(string grade)
        {
            try
            {
                var objTemporary = new Ex_SubjectAction().GetSubjectByGrade(grade);
                return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = objTemporary });
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
        }
        #endregion Properties Class
    }
}