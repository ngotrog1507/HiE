using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Core.Model;
using Core.Service;
using Framework;
using WebMatrix.WebData;

namespace Core.Ultity
{
    /// <summary>
    /// Class used authentication user when request
    /// </summary>
    public static class Authentication
    {
        /// <summary>
        /// Allow Anonymous User use this function 
        /// </summary>
        public class AnonymousUserAttribute : AuthorizeAttribute
        {
            protected override bool AuthorizeCore(HttpContextBase httpContext)
            {
                //httpContext.User.Identity.Name không chuẩn vì khi xóa user trong db mà chạy được và thông báo đăng nhập
                if (WebSecurity.CurrentUserId > 0)
                {
                    httpContext.Items["Logged"] = true;
                    return false;
                }
                return true;
            }

            protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
            {
                if (!filterContext.HttpContext.Items.Contains("Logged")) return;
                var routeValues = new RouteValueDictionary(new { controller = "Home", action = "Index" });
                filterContext.Result = new RedirectToRouteResult(routeValues);
            }
        }

        /// <summary>
        /// Allow Indentifer User use this function 
        /// </summary>
        public class IdentifierUserAttribute : AuthorizeAttribute
        {
            protected override bool AuthorizeCore(HttpContextBase httpContext)
            {
                if (string.IsNullOrEmpty(httpContext.User.Identity.Name))
                {
                    httpContext.Items["IdentifierUser"] = true;
                    return false;
                }
                return true;
            }

            protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
            {
                if (!filterContext.HttpContext.Items.Contains("IdentifierUser")) return;
                string url = CommonHelper.Convert.ConvertToString(filterContext.HttpContext.Request.Url);
                //if (!string.IsNullOrEmpty(url))
                //{
                //    try
                //    {
                //        url = CommonHelper.Url.EncryptDes(url, "12345678");
                //    }
                //    catch (Exception exception)
                //    {
                //        url = string.Empty;
                //        Ultity.TFunction.WriteToLog(exception);
                //    }
                //}
                var routeValues = new RouteValueDictionary(new { controller = "Admin", action = "Login" });
                filterContext.Result = new RedirectToRouteResult(routeValues);
            }
        }

        /// <summary>
        /// Check user have a permission view or access action 
        /// Example permission : View, Add, Edit, Delete , Export, Import....
        /// </summary>
        public class ViewPermissionFunctionUser : ActionFilterAttribute
        {
            public string View = string.Empty;
            public string Add = string.Empty;
            public string Edit = string.Empty;
            public string Delete = string.Empty;
            public string Accept = string.Empty;
            public string Export = string.Empty;
            public string Admin = string.Empty;
            public override void OnActionExecuting(ActionExecutingContext filterContext)
            {
                #region Get Current Url
                string url = Convert.ToString(filterContext.HttpContext.Request.Url);
                if (!string.IsNullOrEmpty(url))
                {
                    url = CommonHelper.Url.EncryptDes(url, "12345678");
                }
                #endregion

                var routeValuesLogin = new RouteValueDictionary(new { controller = "Admin", action = "Login", id = url });
                var routeValuesHome = new RouteValueDictionary(new { controller = "Admin", action = "Index", id = "" });

                #region Check User Login to system

                int userId = WebSecurity.CurrentUserId;
                if (userId < 1)
                {
                    filterContext.Result = new RedirectToRouteResult(routeValuesLogin);
                    return;
                }


                if ((string.IsNullOrEmpty(View) && string.IsNullOrEmpty(Add) && string.IsNullOrEmpty(Edit) && string.IsNullOrEmpty(Delete) && string.IsNullOrEmpty(Accept) && string.IsNullOrEmpty(Export)))
                {
                    filterContext.Result = new RedirectToRouteResult(routeValuesHome);
                    return;
                }

                #endregion

                #region Check User have  to action result

                int totalRowCount = 0;
                //Check permssion Edit
                if (!string.IsNullOrEmpty(Edit))
                {
                    totalRowCount = AuthorizeUser.IsAction(Ultity.Constant.Edit) ? 1 : totalRowCount;
                }

                ////Check permssion Add
                if (!string.IsNullOrEmpty(Add))
                {
                    totalRowCount = AuthorizeUser.IsAction(Ultity.Constant.Add) ? 1 : totalRowCount;
                }

                ////Check permssion Delete
                if (!string.IsNullOrEmpty(Delete))
                {
                    totalRowCount = AuthorizeUser.IsAction(Ultity.Constant.Delete) ? 1 : totalRowCount;
                }

                ////Check permssion Delete
                if (!string.IsNullOrEmpty(Accept))
                {
                    totalRowCount = AuthorizeUser.IsAction(Ultity.Constant.Accept) ? 1 : totalRowCount;
                }

                ////Check permssion Delete
                if (!string.IsNullOrEmpty(Export))
                {
                    totalRowCount = AuthorizeUser.IsAction(Ultity.Constant.Export) ? 1 : totalRowCount;
                }

                ////Check permssion View
                if (!string.IsNullOrEmpty(View))
                {
                    totalRowCount = AuthorizeUser.IsAction(Ultity.Constant.View) ? 1 : totalRowCount;
                }
                ////Check permssion View
                if (!string.IsNullOrEmpty(Admin))
                {
                    totalRowCount = AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll) ? 1 : totalRowCount;
                }

                if (totalRowCount < 1)
                {
                    filterContext.Result = new RedirectToRouteResult(routeValuesHome);
                }

                #endregion
                base.OnActionExecuting(filterContext);
            }
        }
    }
    public static class AuthorizeUser
    {
        public static bool IsHost()
        {
            bool isResult = false;
            try
            {
                int userId = WebSecurity.CurrentUserId;
                if (userId > 0)
                {
                    var userList = new SysUserAction().List(string.Concat("a.UserId = ", userId), string.Empty, 0, 1);
                    if (userList != null && userList.Count > 0)
                    {
                        isResult = userList[0].Host;
                    }
                }
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
            }
            return isResult;
        }

        public static bool IsAdminArea()
        {
            bool isResult = false;
            try
            {
                int userId = WebSecurity.CurrentUserId;
                if (userId > 0)
                {
                    var userList = new SysUserAction().List(string.Concat(@"a.SysUserId =", userId), string.Empty, 0, 1);
                    if (userList != null && userList.Count > 0)
                    {
                        isResult = userList[0].Host;
                    }
                }
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
            }
            return isResult;
        }

        public static bool IsAction(int roleId)
        {
            try
            {
                var userId = WebSecurity.CurrentUserId;
                if (userId > 0)
                {
                    var userList = new SysUserAction().List(string.Concat("a.UserId = ", userId), string.Empty, 0, 1);
                    if (userList != null && userList.Count > 0 && userList[0].Host)
                    {
                        var roleValue = userList[0].Host;
                        if (roleValue)
                        {
                            return true;
                        }
                    }
                }

                #region Check User have permission to action result
                //Get ControlId
                var controller = HttpContext.Current.Request.RequestContext.RouteData.Values["controller"].ToString();
                var result = new SysGroupMenuAction().GetRoleByUrl("/System/"+ controller, roleId,userId);

                if (result.Count>0)
                {
                    return true;
                }
                //if (permissionName.ToLower().Equals(ConstantGlobalization.Constant.HarCode.Permission.View.ToLower()))
                return false;

                #endregion

            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
            }
            return false;
        }


        public static SysUser UserModel
        {
            get
            {
                try
                {
                    if (WebSecurity.CurrentUserId > 0)
                    {
                        var userInfo = new SysUserAction().GetById(WebSecurity.CurrentUserId);
                        if (userInfo != null)
                        {
                            return userInfo;
                        }
                    }
                }
                catch (Exception exception)
                {
                    Ultity.TFunction.WriteToLog(exception);
                }
                return new SysUser();
            }
        }
    }


}
