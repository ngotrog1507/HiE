using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Framework;

namespace Core.Ultity
{
    public class Ultity
    {
        public class Constant
        {
            public static int userIdAdmin = 3;
            //Thanh toán
            public static string ThanhToanTienHoc = "Thanh toán tiền học";
            public static string ThanhToanTienHocChoAdmin = "Thanh toán tiền học cho Admin";
            public static string ThanhToanTienThi = "Thanh toán tiền đề thi";
            public static string ThanhToanTienThiChoAdmin = "Thanh toán tiền đề thi cho Admin";
            public static string NapTien = "Nạp tiền";
            public static string RutTien = "Rút tiền";
            public static string AdminRutTien = "Quản trị trừ tiền";
            public static string DeXuatRutTien = "Đề xuất rút tiền";

            public static int Video = 1;
            public static int TinTuc = 2;
            public static int Product = 3;
            public static string VideoString = "Video";
            public static string TinTucString = "Tin Tức";
            public static string ProductString = "Sản phẩm";

            public static int Facebook = 1;
            public static int Youtube = 2;
            public static int Google = 3;
            public static int Twwiter = 4;

            public static string Ajax_Success = "Thành công";
            public static string Ajax_Fail = "Xảy ra lỗi";
            public static string Delete_Success = "Xóa thành công";
            public static string Delete_Success_Err = "Không thể xóa bản ghi vì dữ liệu liên quan tại vị trí khác";
            public static string Change_Delete_Success = "Chờ xét duyệt của quản trị";
            //
            public static string rowInPage = "RowInPage";
            public static string UsedState_Active = "Đang kích hoạt";
            public static string UsedState_NotActive = "Bị khóa";
            public static string UsedState_Delete = "Yêu cầu xóa khỏi hệ thống";
            public static string UsedState_All = "Tất cả";
            public static string UsedState_NotAccept = "Chưa phê duyệt";
            public const int NotActive = 0;
            public const int Active = 1;
            public const int All = 2;
            public const int NotAccept = -1;
            public const int Request_Delete = -2;
            public static string Title_Edit = "Click to edit item";
            public static string Title_Delete = "Click to delete item";
            public static string SelectOptionDefault = "----- Select Item -----";

            //role  user
            public static string sHost = "Host";
            public static string sAdmin = "Admin";
            public static string sNormal = "Normal";
            public static int Host = 0;
            public static int Admin = 1;
            public static int Normal = 2;
            //role name
            public const string sView = "View";
            public const string sAdd = "Add";
            public const string sEdit = "Edit";
            public const string sDelete = "Delete";
            public const string sAccept = "Accept";
            public const string sExport = "Export";
            //role value      
            public const int Add = 1;
            public const int Edit = 2;
            public const int Delete = 3;
            public const int View = 4;
            public const int Accept = 5;
            public const int Export = 6;
            public const int ViewEditAll = 0;
        }
        public class TFunction
        {
            public static List<SelectListItem> GetAllUsedStateSelected(int usedState)
            {
                string[] str = { Constant.UsedState_Delete, Constant.UsedState_NotActive, Constant.UsedState_Active, Constant.UsedState_All };
                var itemsList = new List<SelectListItem>();
                for (int i = -1; i < str.Length - 1; i++)
                {
                    bool isSelected = false;
                    if (usedState == i)
                    {
                        isSelected = true;
                    }

                    var selectListItem = new SelectListItem { Text = str[i + 1], Value = CommonHelper.Convert.ConvertToString(i), Selected = isSelected };
                    itemsList.Add(selectListItem);
                }
                return itemsList;
            }
            public static List<SelectListItem> GetAllUsedStateSelectedNotAdmin(int usedState)
            {
                string[] str = { Constant.UsedState_NotAccept};
                var itemsList = new List<SelectListItem>();
                var selectListItem = new SelectListItem { Text = str[0], Value = CommonHelper.Convert.ConvertToString(-1), Selected = true };
                itemsList.Add(selectListItem);
                return itemsList;
            }
            public static List<SelectListItem> GetUsedStateSelected(int usedState)
            {
                string[] str = { Constant.UsedState_Delete, Constant.UsedState_NotActive, Constant.UsedState_Active };
                var itemsList = new List<SelectListItem>();
                for (int i = -1; i < str.Length - 1; i++)
                {
                    bool isSelected = false;
                    if (usedState == i)
                    {
                        isSelected = true;
                    }

                    var selectListItem = new SelectListItem { Text = str[i + 1], Value = CommonHelper.Convert.ConvertToString(i), Selected = isSelected };
                    itemsList.Add(selectListItem);
                }
                return itemsList;
            }
            public static List<SelectListItem> GetRoleUser(int role)
            {
                string[] str = { Constant.sHost, Constant.sAdmin, Constant.sNormal };
                var itemsList = new List<SelectListItem>();
                for (int i = 0; i < str.Length; i++)
                {
                    bool isSelected = false;
                    if (role == i)
                    {
                        isSelected = true;
                    }

                    var item = new SelectListItem { Text = str[i], Value = CommonHelper.Convert.ConvertToString(i), Selected = isSelected };
                    itemsList.Add(item);
                }
                return itemsList;
            }
            public static List<SelectListItem> GetRole(int roleId)
            {
                string[] str = { Constant.sAdd, Constant.sEdit, Constant.sDelete, Constant.sView };
                var itemList = new List<SelectListItem>();
                for (int i = 0; i < str.Length; i++)
                {
                    bool isSelected = false;
                    if (roleId == (i + 1))
                    {
                        isSelected = true;
                    }
                    var item = new SelectListItem { Text = str[i], Value = CommonHelper.Convert.ConvertToString(i + 1), Selected = isSelected };
                    itemList.Add(item);
                }
                return itemList;
            }
            public static void WriteToLog(object obj)
            {
                string year = DateTime.Now.Year.ToString();
                string month = DateTime.Now.Month.ToString();
                string date = DateTime.Now.Day.ToString();
                StringBuilder str = new StringBuilder();
                str.Append(date);
                str.Append(month);
                str.Append(year);
                Random rd = new Random();
                str.Append(rd.Next(1, 100000));
                string url = "/Logs/" + year + "/" + month + "/" + date + "/";
                string sPath = HttpContext.Current.Server.MapPath(url);
                ////Request special code


                if (!Directory.Exists(sPath))
                {
                    Directory.CreateDirectory(sPath);
                    string sFile = sPath + str + ".txt";
                    if (!File.Exists(sFile))
                    {
                        File.Create(sFile).Close();
                        using (var stream = File.Open(sFile, FileMode.Open, FileAccess.Write, FileShare.Read))
                        {
                            var reader = new StreamWriter(stream, Encoding.UTF8);
                            string txtContent = obj.ToString();
                            //  txtContent = "System IO  ";
                            reader.Write(txtContent);
                            reader.Close();
                            stream.Close();
                        }
                    }
                }
                else
                {
                    string sFile = sPath + str + ".txt";
                    if (!File.Exists(sFile))
                    {
                        File.Create(sFile).Close();
                        using (var stream = File.Open(sFile, FileMode.Open, FileAccess.Write, FileShare.Read))
                        {
                            var reader = new StreamWriter(stream, Encoding.UTF8);
                            string txtContent = obj.ToString();
                            //  txtContent = "System IO  ";
                            reader.Write(txtContent);
                            reader.Close();
                            stream.Close();
                        }
                    }
                }
            }
        }

    }
}
