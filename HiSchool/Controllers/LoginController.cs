using Core.Service;
using Core.Ultity;
using HiSchool.Models;
using Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebMatrix.WebData;

namespace HiSchool.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login
        #region private Attribute

        private readonly SysUserAction _userAction = new SysUserAction();

        #endregion private Attribute
        public ActionResult Login(Login model) //Đăng nhập
        {
            if (ModelState.IsValid)
            {
                if (WebSecurity.IsAuthenticated)
                {
                    return RedirectToAction("Index", "Home");
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
                    return RedirectToAction("Index", "Home");
                }
            }
            ModelState.AddModelError("UserName", "Tài khoản hoặc nhập khẩu không chính xác !");
            return View(model);
        }
        public ActionResult SignUp()
        {
            return View();
        }
        [HttpPost]
        public ActionResult SignUp(Login model)
        {
            return View();
        }
        public ActionResult LogOut() //Đăng nhập
        {
            return View();
        }
    }
}