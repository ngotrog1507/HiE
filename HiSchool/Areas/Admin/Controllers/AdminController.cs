using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Core.Service;
using Core.Ultity;
using Framework;
using WebMatrix.WebData;

namespace HiSchool.Areas.Admin.Controllers
{

    public class AdminController : Controller
    {
        #region private Attribute

        public readonly string SqlConnection = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        private readonly SysUserAction _userAction = new SysUserAction();

        #endregion private Attribute
        // GET: Admin/Login
        [Authentication.IdentifierUser]
        public ActionResult Index()
        {
            string sql = string.Empty;
            string sWhere = " 1=1 ";
            if (!AuthorizeUser.IsHost())
            {
                sWhere += " AND CreatedBy="+WebSecurity.CurrentUserId;
            }
            #region + Lấy thông tin Dashboard
            sql += " SELECT COUNT(*) AS TotalClass INTO #temp1 FROM Cms_Class WHERE "+sWhere;
            sql += " SELECT COUNT(*) AS TotalExam INTO #temp2 FROM Ex_Exam WHERE " + sWhere;
            sql += " SELECT COUNT(*) AS TotalTeacher INTO #temp3 FROM SysGroupUser";
            sql += " WHERE GroupId = 20";
            if (AuthorizeUser.IsHost())
            {
                sql += " SELECT  COUNT(*) AS TotalStudent INTO #temp4";
                sql += " FROM SysGroupUser WHERE GroupId = 21";
            }
            else
            {
                sql += " SELECT COUNT(*) AS TotalStudent INTO #temp4 FROM Cms_ClassStudent WHERE ClassId in(SELECT Id FROM Cms_Class WHERE " + sWhere+")";
            }
            if (AuthorizeUser.IsHost())
            {
                sql += " SELECT COUNT(*) AS TotalVideo INTO #temp5 FROM Cms_ClassVideo";
            }
            else
            {
                sql += " SELECT COUNT(*) AS TotalVideo INTO #temp5 FROM Cms_ClassVideo WHERE ClassId in(SELECT Id FROM Cms_Class WHERE " + sWhere + ")";
            }
            sql += " SELECT TotalClass,TotalExam,TotalTeacher,TotalStudent,TotalVideo";
            sql += " FROM #temp1,#temp2,#temp3,#temp4,#temp5";
            sql += " DROP TABLE #temp1, #temp2, #temp3, #temp4, #temp5";
            var totalClass = SqlHelper.ExecuteList<TotalInfoWebsite>(SqlConnection, CommandType.Text, sql);
            if (totalClass.Count > 0)
            {
                ViewBag.TotalInfoWebsite = totalClass[0];
            }
            else
            {
                ViewBag.TotalInfoWebsite = new TotalInfoWebsite();
            }

            #endregion
            ViewBag.Host = AuthorizeUser.IsHost();
            int id = WebSecurity.CurrentUserId;
            return View();
        }
        [HttpGet]
        public ActionResult Login(string id)
        {
            ViewBag.UrlRedirect = id;
            return View();
        }

        [HttpPost]
        public ActionResult Login(Models.Login model)
        {
            if (ModelState.IsValid)
            {
                if (WebSecurity.IsAuthenticated)
                {
                    return RedirectToAction("Index", "Admin");
                }
                if (string.IsNullOrEmpty(model.UserName) || string.IsNullOrEmpty(model.Password))
                {
                    ModelState.AddModelError("UserName", "Tài khoản hoặc mật khẩu không được trống");
                    return View(model);
                }

                model.UserName = model.UserName.Trim();
                model.Password = model.Password.Trim();
                bool isRemember = !string.IsNullOrEmpty(model.Remember) && model.Remember.Trim().ToLower().Equals("on");
                ViewBag.isRemember = isRemember;
                bool isLog = WebSecurity.Login(model.UserName, model.Password, isRemember);
                int id = WebSecurity.CurrentUserId;
                if (isLog)
                {
                    var userItemList = _userAction.List("a.UserName = '" + model.UserName.Trim() + "' AND a.UsedState = " + Ultity.Constant.Active, string.Empty, 0, 1);
                    if (userItemList != null && userItemList.Count > 0)
                    {
                        if (userItemList[0].UsedState == Ultity.Constant.NotActive)
                        {
                            ModelState.AddModelError("UserName", "Tài khoản đang bị khóa !");
                            return View(model);
                        }
                        Session.Add("Role", userItemList[0].Host);
                    }
                    else
                    {
                        return RedirectToAction("LogOut", "Admin");
                    }

                    if (!string.IsNullOrEmpty(model.UrlRedirect))
                    {
                        string url = CommonHelper.Url.DecryptDes(model.UrlRedirect, "12345678");

                        if (!string.IsNullOrEmpty(url))
                        {
                            return Redirect(url);
                        }
                    }
                    return RedirectToAction("Index", "Admin");
                }
            }
            ModelState.AddModelError("UserName", "Tài khoản hoặc nhập khẩu không chính xác !");
            return View(model);
        }
        public ActionResult LogOut()
        {
            Session["Menu"] = null;
            WebSecurity.Logout();
            return RedirectToAction("Login", "Admin");
        }
        public class TotalInfoWebsite
        {
            public int TotalClass { get; set; }
            public int TotalExam { get; set; }
            public int TotalTeacher { get; set; }
            public int TotalStudent { get; set; }
            public int TotalVideo { get; set; }
        }
    }
}