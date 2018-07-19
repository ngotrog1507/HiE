using Core.Model;
using Core.Service;
using HiSchool.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebMatrix.WebData;

namespace HiSchool.Controllers
{
    public class BankController : Controller
    {
        // GET: Bank
        public ActionResult Index()
        {
            var userId = WebSecurity.CurrentUserId;
            if (userId > 0)
            {
                ViewBag.UserLogin = new SysUserAction().GetById(userId);
                return View();
            }
            ViewBag.StartDate = DateTime.Now.ToString("dd/MM/yyy 00:00");
            ViewBag.EndDate = DateTime.Now.ToString("dd/MM/yyy 23:59");
            return RedirectToAction("Index", "Home");
        }
        public ActionResult GetData(string fromDate, string toDate)
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
            var lst = new SysAdminAction<Cms_HistoryPayment>().HistoryPaymentStudent(dtFrom, dtTo, WebSecurity.CurrentUserId);
            return Json(new { status = THelper.Ajax_Return.Ok, value = lst });

            #endregion

        }
    }
}