using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web.Mvc;
using Core.Service;
using Framework;
using WebMatrix.WebData;

namespace Core.Ultity
{
    public class Common
    {
        public static class ConvertNameUrl
        {
            public static string CovnertName(string name)
            {
                if (!string.IsNullOrEmpty(name))
                {

                    name = name.ToLower().Trim();
                    name = name.Replace(".", "");
                    Regex regex = new Regex("\\p{IsCombiningDiacriticalMarks}+");
                    string temp = name.Normalize(NormalizationForm.FormD);
                    name = regex.Replace(temp, String.Empty).Replace('\u0111', 'd').Replace('\u0110', 'D');
                    name = Regex.Replace(name, @"[^0-9a-zA-Z:,]+", "-");
                    name = name.Replace(":", "-");
                    if (name.StartsWith("-"))
                    {
                        name = name.Substring(1);
                    }

                    if (name.EndsWith("-"))
                    {
                        name = name.Substring(0, name.Length - 1);
                    }

                    while (name.Contains("--"))
                    {
                        name = name.Replace("--", "-");
                    }
                   
                }

                return name;
            }


        }
        public static class CheckExists
        {
            public static bool CheckExistsEmail(string email, int? currentUserId)
            {
                if (string.IsNullOrWhiteSpace(email)) return true;
                try
                {
                    string sWhere = string.Concat("LOWER(a.Email) = LOWER('", email.Trim(), "') ");
                    if (currentUserId.HasValue && currentUserId.Value > 0)
                    {
                        sWhere += string.Concat(" AND a.SysUserId <> ", currentUserId.Value);
                    }
                    var sysUserAction = new SysUserAction();
                    var existsList = sysUserAction.List(sWhere, string.Empty, 0, 1);
                    return (existsList != null && existsList.Count > 0);
                }
                catch (Exception exception)
                {
                    Ultity.TFunction.WriteToLog(exception);
                    return true;
                }
            }

            public static bool CheckExistsPhoneNumber(string phoneNumber, int? currentUserId)
            {
                if (string.IsNullOrWhiteSpace(phoneNumber)) return true;
                try
                {
                    string sWhere = string.Concat("LOWER(a.Tel) = LOWER('", phoneNumber.Trim(), "') ");
                    if (currentUserId.HasValue && currentUserId.Value > 0)
                    {
                        sWhere += string.Concat(" AND a.SysUserId <> ", currentUserId.Value);
                    }
                    var sysUserAction = new SysUserAction();
                    var existsList = sysUserAction.List(sWhere, string.Empty, 0, 1);
                    return (existsList != null && existsList.Count > 0);
                }
                catch (Exception exception)
                {
                    Ultity.TFunction.WriteToLog(exception);
                    return true;
                }
            }
        }

        public static class UserCommon
        {
            //public static string GetUserName(int? userId)
            //{
            //    if (!userId.HasValue || userId.Value < 1)
            //    {
            //        return string.Empty;
            //    }
            //    var userModel = new SysUserAction().GetById(CommonHelper.Convert.ConvertToString(userId.Value));
            //    if (userModel != null && !string.IsNullOrWhiteSpace(userModel.Id))
            //    {
            //        return !string.IsNullOrWhiteSpace(userModel.LoginName) ? userModel.LoginName : userModel.UserName;
            //    }
            //    return string.Empty;
            //}
            public static void LogOut()
            {
                try
                {
                    //Logout your system
                    WebSecurity.Logout();
                    var sessionHelper = new CommonHelper.Session();
                    sessionHelper.Remove("oauthToken");
                    sessionHelper.Remove("Role");

                    //Logout facebook account
                    //var oauthToken = string.Empty;
                    //if (sessionHelper.Get("oauthToken", ref oauthToken))
                    //{
                    //    var fb = new Facebook.FacebookClient();
                    //    fb.GetLogoutUrl(new { access_token = oauthToken, next = Constants.Parameter.HttpDomain });
                    //    sessionHelper.Remove("oauthToken");
                    //}
                }
                catch (Exception exception)
                {
                    Ultity.TFunction.WriteToLog(exception);
                }
            }
        }

        //public static List<SysPermissionKey> GetParameterByName(string parameterName)
        //{
        //    var paraList = new List<SysPermissionKey>();
        //    try
        //    {
        //        string sWhere = string.Concat("LOWER(a.Name)  = '", parameterName.ToLower(), "' AND a.UsedState = ",
        //                                      CommonHelper.Convert.ConvertToInt32((int)ConstantGlobalization.Enum.UsedState.Enable));
        //        var objRef = new object[5];
        //        objRef[0] = sWhere;
        //        objRef[1] = "a.Orders ASC";
        //        objRef[2] = 0;
        //        objRef[3] = 100;
        //        objRef[4] = 0;
        //        paraList = new SysPermissionKeyAction().List(ref objRef);
        //    }
        //    catch (Exception exception)
        //    {
        //        Ultity.TFunction.WriteToLog(exception);
        //    }
        //    return paraList;
        //}

        /// <summary>
        /// Get SysParameterModelList or SelectListItem
        /// </summary>
        /// <param name="focusValue">
        /// The value 0 is none focus
        /// </param>
        /// <param name="parameterName"></param>
        //public static List<SelectListItem> GetParameterByName(dynamic focusValue, string parameterName)
        //{
        //    var itemsList = new List<SelectListItem>();
        //    try
        //    {
        //        string sWhere = string.Concat("LOWER(a.Name)  = '", parameterName.ToLower(), "' AND a.UsedState = ", CommonHelper.Convert.ConvertToInt32((int)ConstantGlobalization.Enum.UsedState.Enable));
        //        var objRef = new object[5];
        //        objRef[0] = sWhere;
        //        objRef[1] = "a.Orders ASC";
        //        objRef[2] = 0;
        //        objRef[3] = 100;
        //        objRef[4] = 0;
        //        var parameterModels = new SysPermissionKeyAction().List(ref objRef);

        //        if (parameterModels != null && parameterModels.Count > 0)
        //        {
        //            //Focus to value send by parameter when call function
        //            for (int i = 0; i < parameterModels.Count; i++)
        //            {
        //                bool isSelected = false;
        //                if (focusValue != null)
        //                {
        //                    isSelected = parameterModels[i].Value.Equals(focusValue);
        //                }

        //                var selectListItem = new SelectListItem { Text = parameterModels[i].Note, Value = CommonHelper.Convert.ConvertToString(parameterModels[i].Value), Selected = isSelected };
        //                itemsList.Add(selectListItem);
        //            }
        //        }
        //    }
        //    catch (Exception exception)
        //    {
        //        Ultity.TFunction.WriteToLog(exception);
        //    }

        //    return itemsList;
        //}

        //public static string GetValueParameterByName(string parameterName)
        //{
        //    var itemsList = new List<SelectListItem>();
        //    try
        //    {
        //        string sWhere = string.Concat("LOWER(a.Name)  = '", parameterName.ToLower(), "' AND a.UsedState = ", CommonHelper.Convert.ConvertToInt32((int)ConstantGlobalization.Enum.UsedState.Enable));
        //        var objRef = new object[5];
        //        objRef[0] = sWhere;
        //        objRef[1] = "a.Orders ASC";
        //        objRef[2] = 0;
        //        objRef[3] = 100;
        //        objRef[4] = 0;
        //        var parameterModels = new SysPermissionKeyAction().List(ref objRef);

        //        if (parameterModels != null && parameterModels.Count > 0)
        //        {
        //            return parameterModels[0].Value.ToString();
        //        }
        //    }
        //    catch (Exception exception)
        //    {
        //        Ultity.TFunction.WriteToLog(exception);
        //    }

        //    return string.Empty;
        //}

        //public static string GetNoteParameterByName(string parameterName)
        //{
        //    var itemsList = new List<SelectListItem>();
        //    try
        //    {
        //        string sWhere = string.Concat("LOWER(a.Name)  = '", parameterName.ToLower(), "' AND a.UsedState = ", CommonHelper.Convert.ConvertToInt32((int)ConstantGlobalization.Enum.UsedState.Enable));
        //        var objRef = new object[5];
        //        objRef[0] = sWhere;
        //        objRef[1] = "a.Orders ASC";
        //        objRef[2] = 0;
        //        objRef[3] = 100;
        //        objRef[4] = 0;
        //        var parameterModels = new SysPermissionKeyAction().List(ref objRef);

        //        if (parameterModels != null && parameterModels.Count > 0)
        //        {
        //            return parameterModels[0].Note;
        //        }
        //    }
        //    catch (Exception exception)
        //    {
        //        Ultity.TFunction.WriteToLog(exception);
        //    }

        //    return string.Empty;
        //}
    }

}
