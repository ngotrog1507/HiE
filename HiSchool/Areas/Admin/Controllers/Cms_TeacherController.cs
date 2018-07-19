using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web.Mvc;
using Core.Model;
using Core.Service;
using Core.Ultity;
using Framework;
using HiSchool.Handler;
using Microsoft.AspNet.SignalR;
using WebMatrix.WebData;

namespace HiSchool.Areas.Admin.Controllers
{
    public class Cms_TeacherController : Controller
    {
        // GET: Admin/Cms_Teacher
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
                objRef[0] = sWhere + " and b.GroupId=20";
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
        public ActionResult Payment(int userId, int type, int money)
        {
            string sWhere = "1=1";
            var modelUser = new SysUserAction().GetById(userId);
            if (AuthorizeUser.IsHost())
            {
                if (type == 1)
                {
                    new SysAdminAction<SysUser>().Updates("BCoin=BCoin+" + money, "UserId=" + userId);
                    #region +Thêm vào lịch sử giao dịch
                    new SysAdminAction<Cms_HistoryPayment>().Payment(new Cms_HistoryPayment
                    {
                        IdGuid = Guid.NewGuid().ToString(),
                        FromUser = Ultity.Constant.userIdAdmin,
                        Code = string.Empty,
                        ToUser = userId,
                        BCoin = money,
                        Summary = Ultity.Constant.NapTien,
                        CreatedDate = DateTime.Now,
                        IsShow = true,
                        IsActive = true,
                    });
                    #endregion
                }
                else
                {
                    if (modelUser.BCoin < money)
                    {
                        return Json(new { status = "money", Message = Ultity.Constant.Ajax_Fail });
                    }
                    new SysAdminAction<SysUser>().Updates("BCoin=BCoin-" + money, "UserId=" + userId);
                    #region +Thêm vào lịch sử giao dịch
                    new SysAdminAction<Cms_HistoryPayment>().Payment(new Cms_HistoryPayment
                    {
                        IdGuid = Guid.NewGuid().ToString(),
                        FromUser = Ultity.Constant.userIdAdmin,
                        Code = string.Empty,
                        ToUser = userId,
                        BCoin = money,
                        Summary = Ultity.Constant.AdminRutTien,
                        CreatedDate = DateTime.Now,
                        IsShow = true,
                        IsActive = true,
                    });
                    #endregion
                }
                #region Gửi mail thông báo giao dịch thành công
                var model = new SysUserAction().GetById(userId);
                if (type == 1)
                {
                    Models.THelper.SendMail(model.Email, model.FullName, String.Format("{0:0,0}", money), "Nạp tiền");
                }
                else
                {
                    Models.THelper.SendMail(model.Email, model.FullName, String.Format("{0:0,0}", money), "Rút tiền");
                }
                #endregion
            }
            else
            {
                if (WebSecurity.CurrentUserId > 0 && type == -1)
                {
                    if (modelUser.BCoin < money)
                    {
                        return Json(new { status = "money", Message = Ultity.Constant.Ajax_Fail });
                    }
                    #region +Thêm vào lịch sử giao dịch
                    var modelHis = new Cms_HistoryPayment
                    {
                        IdGuid = Guid.NewGuid().ToString(),
                        FromUser = WebSecurity.CurrentUserId,
                        Code = string.Empty,
                        ToUser = WebSecurity.CurrentUserId,
                        BCoin = money,
                        Summary = Ultity.Constant.DeXuatRutTien,
                        CreatedDate = DateTime.Now,
                        IsShow = false,
                        IsActive = false,
                    };
                    new SysAdminAction<Cms_HistoryPayment>().Payment(modelHis);
                    #endregion

                    #region Gửi thông báo cho Giáo viên và Admin
                    var lstUserInClass = new List<Cms_HistoryPayment>();

                    lstUserInClass.Add(modelHis);
                    lstUserInClass.ForEach(x =>
                    {
                        x.CreatedDateStr = Convert.ToDateTime(x.CreatedDate).ToString("dd/MM/yyy HH:mm");
                        x.FromUserStr = modelUser.FullName;
                    });
                    IHubContext contextall = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
                    NotificationHub hub = new NotificationHub();
                    //Gửi cho Admin
                    var userAd = new SysAdminAction<SysUser>().GetById((Convert.ToInt32(Ultity.Constant.userIdAdmin)));
                    UserHubModels userAdmin = hub.GetUser(userAd.UserName);
                    if (userAdmin != null)
                    {
                        List<string> connectIds = userAdmin.ConnectionIds.ToList<string>();
                        connectIds.ForEach(x =>
                        {
                            contextall.Clients.Client(x).recieveNotificationFirstTime(lstUserInClass);
                        });
                    }
                    #endregion
                }
            }

            return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success });
        }
        public ActionResult PheDuyetRutTien(string ids)
        {
            if (AuthorizeUser.IsHost())
            {
                var model = new SysAdminAction<Cms_HistoryPayment>().GetByGuidId(ids);
                new SysAdminAction<SysUser>().Updates("BCoin=BCoin-" + model.BCoin, "UserId=" + model.FromUser);
                new SysAdminAction<Cms_HistoryPayment>().Updates("Summary=N'" + Ultity.Constant.RutTien + "' , IsActive=1", "IdGuid='" + ids + "'");
                #region Gửi mail thông báo giao dịch thành công
                var modelEmail = new SysUserAction().GetById(model.FromUser);
                Models.THelper.SendMail(modelEmail.Email, modelEmail.FullName, String.Format("{0:0,0}", model.BCoin), "Rút tiền");
                #endregion
            }
            return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success });
        }
        #endregion Properties Class
    }
}