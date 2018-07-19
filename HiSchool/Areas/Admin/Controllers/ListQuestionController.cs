using Core.Model;
using Core.Service;
using Core.Ultity;
using Framework;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebMatrix.WebData;

namespace HiSchool.Areas.Admin.Controllers
{
    public class ListQuestionController : Controller
    {
        #region Properties Class

        private readonly Ex_QuestionAction _sysAction = new Ex_QuestionAction();
        private readonly int rowInPage = CommonHelper.Convert.ConvertToInt32(ConfigurationManager.AppSettings[Ultity.Constant.rowInPage]);

        #endregion Properties Class

        #region Public Method
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult Index(int? cauhoi)
        {
            ViewBag.Host = AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll);
            ViewBag.Add = AuthorizeUser.IsAction(Ultity.Constant.Add);
            ViewBag.Edit = AuthorizeUser.IsAction(Ultity.Constant.Edit);
            ViewBag.Delete = AuthorizeUser.IsAction(Ultity.Constant.Delete);
            ViewBag.UsedStateAdd = Ultity.TFunction.GetUsedStateSelected(Ultity.Constant.Active);
            //ViewBag.UsedState = Ultity.TFunction.GetAllUsedStateSelected(Ultity.Constant.All);

            ViewBag.Grade = new SysAdminAction<Ex_CategoryValue>().List("a.CatCode='KHOI'", "", 0, 100);
            ViewBag.DoKho = new SysAdminAction<Ex_CategoryValue>().List("a.CatCode='DK'", "", 0, 100);

            return View();
        }
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView, Admin = Ultity.Constant.sView)]
        public ActionResult GetData(int? page, int? pageSize, string key, string grade, int subjectId, string exam, int sectionId)
        {
            try
            {
                var objRef = new object[5];
                int currentPageIndex = page.HasValue ? page.Value - 1 : 0;
                if (currentPageIndex < 0) currentPageIndex = 0;
                pageSize = rowInPage;
                string sWhere = (AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll)) ? " 1=1 " : " a.CreatedBy =" + WebSecurity.CurrentUserId;
                if (!string.IsNullOrEmpty(key))
                {
                    key = key.Trim();
                    ViewBag.Search = key;
                    sWhere += "and  ( a.QuestionContent like N'%" + key + "%' or dbo.ConvertToNoSigned(a.QuestionContent) like  dbo.ConvertToNoSigned(N'%" + key + "%')) ";
                }

                if (!string.IsNullOrEmpty(grade))
                {
                    sWhere += " and  a.Grade ='" + grade.Trim() + "'";
                }
                if (subjectId > 0)
                {
                    sWhere += " and  a.SubjectId =" + subjectId + "";
                }
                if (!string.IsNullOrEmpty(exam))
                {
                    sWhere += " and  a.ExamId ='" + exam.Trim() + "'";
                }
                if (sectionId > 0)
                {
                    sWhere += " and  a.SectionId =" + sectionId + "";
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
                        new SysAdminAction<Ex_Question>().Updates(sSet, sWhere);
                        return Json(new { status = "success", Message = Ultity.Constant.Change_Delete_Success });
                    }
                    else
                    {
                        new SysAdminAction<Ex_Question>().Deletes(sWhere);
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