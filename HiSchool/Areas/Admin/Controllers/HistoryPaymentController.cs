using Core.Model;
using Core.Service;
using Core.Ultity;
using HiSchool.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebMatrix.WebData;

namespace HiSchool.Areas.Admin.Controllers
{
    [Authentication.IdentifierUser]
    public class HistoryPaymentController : Controller
    {
        // GET: Admin/HistoryPayment
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult Index()
        {
            bool checkRole = AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll);
            var lstUser = new List<SysUser>();
            var lstUserTeacher = new SysGroupAction().GetUserInGroup(20, string.Empty);
            if (checkRole)
            {
                var admin = new SysAdminAction<SysUser>().GetById(Ultity.Constant.userIdAdmin);
                lstUser.Add(new SysUser()
                {
                    UserId = admin.UserId,
                    UserName = admin.UserName
                });
                lstUserTeacher.ForEach(x =>
                {
                    lstUser.Add(new SysUser()
                    {
                        UserId = x.UserId,
                        UserName = x.UserName
                    });
                });
            }
            else
            {
                var user = new SysAdminAction<SysUser>().GetById(WebSecurity.CurrentUserId);
                lstUser.Add(new SysUser()
                {
                    UserId = user.UserId,
                    UserName = user.UserName
                });
            }

            ViewBag.StartDate = DateTime.Now.ToString("dd/MM/yyy 00:00");
            ViewBag.EndDate = DateTime.Now.ToString("dd/MM/yyy 23:59");
            ViewBag.ListUser = lstUser;
            ViewBag.Host = AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll);

            return View();
        }
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult GetData(string fromDate, string toDate, int userId, bool notAccept)
        {
            DateTime dtFrom, dtTo;

            #region +Validate
            if (string.IsNullOrEmpty(fromDate) || string.IsNullOrEmpty(toDate))
            {
                return Json(new { status = THelper.Ajax_Return.ErrSystem });
            }
            try
            {
                dtFrom = DateTime.ParseExact(fromDate, "dd/MM/yyyy HH:mm", null);
                dtTo = DateTime.ParseExact(toDate, "dd/MM/yyyy HH:mm", null);
            }
            catch (Exception e)
            {
                return Json(new { status = THelper.Ajax_Return.ErrSystem });
            }
            #endregion

            #region Handler
            if (AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll))
            {
                var lst = new SysAdminAction<Cms_HistoryPayment>().HistoryPayment(dtFrom, dtTo, userId);
                if (notAccept)
                {
                    lst = lst.Where(x => x.IsActive == false).ToList();
                }
                return Json(new { status = THelper.Ajax_Return.Ok, value = lst });
            }
            else
            {
                var lst = new SysAdminAction<Cms_HistoryPayment>().HistoryPayment(dtFrom, dtTo, WebSecurity.CurrentUserId);
                if (notAccept)
                {
                    lst = lst.Where(x => x.IsActive == false).ToList();
                }
                return Json(new { status = THelper.Ajax_Return.Ok, value = lst });
            }


            #endregion

        }
    }
}