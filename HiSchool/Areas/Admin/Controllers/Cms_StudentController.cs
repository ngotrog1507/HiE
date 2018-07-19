using System;
using System.Configuration;
using System.Web.Mvc;
using Core.Service;
using Core.Ultity;
using Framework;
using WebMatrix.WebData;

namespace HiSchool.Areas.Admin.Controllers
{
    public class Cms_StudentController : Controller
    {
        #region Properties Class

        private readonly SysUserAction _sysAction = new SysUserAction();
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
                objRef[0] = sWhere + " and b.GroupId=21";
                objRef[1] = sSort;
                objRef[2] = currentPageIndex;
                objRef[3] = pageSize;
                objRef[4] = 0;
                var modelList = _sysAction.GetMember(ref objRef);
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
        #endregion Properties Class
    }
}