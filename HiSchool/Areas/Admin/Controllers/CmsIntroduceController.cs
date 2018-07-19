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
    public class CmsIntroduceController : Controller
    {
        #region Properties Class

        private readonly CmsIntroduceAction _sysAction = new CmsIntroduceAction();
        private readonly int rowInPage = CommonHelper.Convert.ConvertToInt32(ConfigurationManager.AppSettings[Ultity.Constant.rowInPage]);

        #endregion Properties Class

        #region Public Method
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult Index()
        {
            ViewBag.Host = AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll);
            ViewBag.Edit = AuthorizeUser.IsAction(Ultity.Constant.Edit);
            var model = new CmsIntroduce();
            var list = new SysAdminAction<CmsIntroduce>().List(string.Empty, string.Empty, 0, 1);
            if (list.Count > 0) model = list[0];

            return View(model);
        }
        [Authentication.ViewPermissionFunctionUser(Edit = Ultity.Constant.sEdit, Add = Ultity.Constant.sAdd, Admin = Ultity.Constant.sView)]
        [HttpPost]
        public ActionResult Edit(CmsIntroduce sysModel)
        {
            try
            {
                #region Redirect Request

                int succcess = 0;
                if (sysModel.Id > 0)
                {
                    var objTemporary = _sysAction.GetById(sysModel.Id);
                    if (AuthorizeUser.IsAction(Ultity.Constant.Edit) || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll))
                    {
                        sysModel.CreatedBy = objTemporary.CreatedBy;
                        sysModel.ModifiedDate = DateTime.Now;
                        sysModel.UsedState = Ultity.Constant.Active;
                        sysModel.ModifiedBy = WebSecurity.CurrentUserId;
                        sysModel.CreatedDate = objTemporary.CreatedDate;
                        //sysModel.Name = objTemporary.Name;
                        succcess = _sysAction.Update(sysModel);
                    }
                    else { succcess = 1; }
                }
                else
                {
                    if (AuthorizeUser.IsAction(Ultity.Constant.Add) || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll))
                    {
                        sysModel.CreatedBy = WebSecurity.CurrentUserId;
                        sysModel.ModifiedBy = null;
                        sysModel.UsedState = Ultity.Constant.Active;
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
                        new SysAdminAction<CmsIntroduce>().Updates( sSet, sWhere);
                        return Json(new { status = "success", Message = Ultity.Constant.Change_Delete_Success });
                    }
                    else
                    {
                        new SysAdminAction<CmsIntroduce>().Deletes( sWhere);
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