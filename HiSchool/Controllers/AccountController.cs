using Core.Model;
using Core.Service;
using Core.Ultity;
using HiSchool.Handler;
using HiSchool.Models;
using Microsoft.AspNet.SignalR;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using WebMatrix.WebData;
using static HiSchool.Controllers.CommonController;

namespace HiSchool.Controllers
{
    public class AccountController : Controller
    {
        #region Properties Class

        private readonly SysUserAction _sysAction = new SysUserAction();

        #endregion Properties Class

        #region Function
        public ActionResult MyProfile()
        {
            int userId = WebSecurity.CurrentUserId;
            if (userId > 0)
            {
                var userLogin = new SysUserAction().GetById(userId);
                ViewBag.UserLogin = userLogin;

                #region + Lấy danh sách lớp đang học

                var classStudent = new SysAdminAction<Cms_ClassStudent>().List("a.StudentId=" + userId, "a.CreatedDate desc", 0, 20);
                var strClassStudent = string.Empty;
                if (classStudent.Count > 0)
                {
                    classStudent.ForEach(x =>
                    {
                        strClassStudent += x.ClassId + ",";
                    });
                }
                strClassStudent += "0";

                string sWhere = "a.UsedState = 1 and a.Id in(" + strClassStudent + ")";
                string sOrders = " a.CreatedDate desc ";

                var objRef = new object[5];
                objRef[0] = sWhere;
                objRef[1] = sOrders;
                objRef[2] = 0;
                objRef[3] = 20;
                objRef[4] = 0;

                var lstClass = new Cms_ClassAction().List(ref objRef);
                #endregion

                #region + Lấy danh sách đề thi đã thi
                var examStudent = new SysAdminAction<Ex_ExamStudent>().List("a.StudentId=" + userId, "a.CreatedDate desc", 0, 20);
                var strExamStudent = string.Empty;
                if (examStudent.Count > 0)
                {
                    examStudent.ForEach(x =>
                    {
                        strExamStudent += x.ExamId + ",";
                    });
                }
                strExamStudent += "0";

                sWhere = "a.UsedState = 1 and a.Id in(" + strExamStudent + ")";
                sOrders = " a.CreatedDate desc ";

                var objRef2 = new object[5];
                objRef2[0] = sWhere;
                objRef2[1] = sOrders;
                objRef2[2] = 0;
                objRef2[3] = 20;
                objRef2[4] = 0;

                var lstExam = new Ex_ExamAction().List(ref objRef2);
                #endregion

                ViewBag.LstClass = lstClass;
                ViewBag.LstExam = lstExam;
            }

            return View();
        }
        // GET: Account
        public ActionResult Login(string url)
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(Login model)
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
                    var userItemList = new SysUserAction().List("a.UserName = '" + model.UserName.Trim() + "'", string.Empty, 0, 1);
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
                        return RedirectToAction("LogOut", "Account");
                    }
                    string url = Request.QueryString["url"]; ;
                    if (!string.IsNullOrEmpty(url))
                    {
                        return Redirect(url);
                    }
                    return RedirectToAction("Index", "Home");
                }
            }
            ModelState.AddModelError("UserName", "Tài khoản hoặc nhập khẩu không chính xác !");
            return View(model);
        }
        public ActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Register(Register model)
        {
            bool check = true;
            #region  Validate
            if (!IsValidateCaptcha())
            {
                ModelState.AddModelError("Captcha", "Mã captcha không đúng.");
                check = false;
            }
            if (string.IsNullOrEmpty(model.UserName))
            {
                ModelState.AddModelError("Username", "Không được để trống Tên.");
                check = false;
            }
            if (string.IsNullOrEmpty(model.Email))
            {
                ModelState.AddModelError("Email", "Không được để trống Email.");
                check = false;
            }
            if (!string.IsNullOrEmpty(model.Email) && (!IsValidEmail(model.Email)))
            {
                ModelState.AddModelError("EmailValidate", "Email không đúng định dạng.");
                check = false;
            }
            if (model.Password != model.ConfirmPassword)
            {
                ModelState.AddModelError("EmailValidate", "Mật khẩu không khớp nhau.");
                check = false;
            }

            #endregion

            #region Handler
            if (check)
            {
                if (ModelState.IsValid)
                {
                    if (!WebSecurity.UserExists(model.UserName))
                    {
                        string user = WebSecurity.CreateUserAndAccount(model.UserName.Trim(), model.Password.Trim());
                        int userId = WebSecurity.GetUserId(model.UserName);
                        if (userId > 0)
                        {
                            try
                            {
                                //Thêm vào bangr User
                                var sysUser = new SysUser();
                                sysUser.Id = userId;
                                sysUser.UserId = userId;
                                sysUser.Token = Guid.NewGuid().ToString();
                                sysUser.UserName = model.UserName.Trim();
                                sysUser.FullName = model.UserName.Trim();
                                sysUser.Email = model.Email;
                                sysUser.Phone = string.Empty;
                                sysUser.BCoin = 0;
                                sysUser.ImageUrl = "/Uploads/CKFinder/files/images.jpg";
                                sysUser.UsedState = Ultity.Constant.NotActive;
                                sysUser.CreatedDate = DateTime.Now;
                                sysUser.CreatedBy = WebSecurity.CurrentUserId;
                                _sysAction.Insert(sysUser);
                                //Thêm vào bảng GroupUser với GroupId=20 là Học sinh

                                var sysGroupUser = new SysGroupUser();
                                sysGroupUser.CreatedDate = DateTime.Now;
                                sysGroupUser.CreatedBy = WebSecurity.CurrentUserId;
                                sysGroupUser.GroupId = 21;
                                sysGroupUser.Orders = 2;
                                sysGroupUser.UserId = userId;
                                sysGroupUser.UsedState = Ultity.Constant.Active;
                                new SysGroupUserAction().Add(sysGroupUser);
                                CheckSendMail(model.UserName,model.Email,model.Password, sysUser.Token);
                                ModelState.AddModelError("Success", "Đăng ký thành công. Vui lòng kiểm tra Email!");
                            }
                            catch (Exception exception)
                            {
                                ModelState.AddModelError("Success", exception.Message);
                                ((SimpleMembershipProvider)Membership.Provider).DeleteUser(model.UserName.Trim(), true);
                                new SysAdminAction<SysUser>().Deletes("UserId=" + userId);
                            }
                        }
                    }
                    else
                    {
                        ModelState.AddModelError("EmailValidate", "Đã tồn tại Username này trong hệ thống !");
                        return View();
                    }
                }
            }
            #endregion
            return View();
        }
        public ActionResult LogOut()
        {
            WebSecurity.Logout();
            return RedirectToAction("Index", "Home");
        }
        public ActionResult Payment(string ids, string url)
        {
            int userId = WebSecurity.CurrentUserId;
            if (userId > 0)
            {
                if (!string.IsNullOrEmpty(ids))
                {
                    try
                    {
                        var model = new SysAdminAction<Cms_Class>().GetByGuidId(ids);

                        #region Kiem tra phai Admin hay khong

                        if (AuthorizeUser.IsHost() || userId == model.CreatedBy)
                        {
                            return RedirectToAction("VaoHoc", "KhoaHoc", new { ids = ids });
                        }
                        #endregion

                        #region +Kiem tra hoc vien co trong lop hay chua

                        var cms_ClassStudent = new SysAdminAction<Cms_ClassStudent>().List("a.ClassId=" + model.Id + " and a.StudentId=" + userId, "", 0, 1);
                        if (cms_ClassStudent.Count > 0)
                        {
                            return RedirectToAction("VaoHoc", "KhoaHoc", new { ids = ids });
                        }

                        #endregion

                        var sysCurrentUser = new SysAdminAction<SysUser>().GetById(userId);
                        if (model.Id > 0)
                        {
                            #region +Kiem tra tien trong tai khoan
                            if (sysCurrentUser.BCoin < 0 || model.Price > sysCurrentUser.BCoin)
                            {
                                return View();
                            }
                            #endregion

                            if (model.Price > 0)
                            {
                                #region +Thanh toan tien

                                new SysAdminAction<SysUser>().Updates("BCoin=BCoin-" + model.Price, "UserId=" + userId);
                                new SysAdminAction<SysUser>().Updates("BCoin=BCoin+" + (model.Price * 0.7).ToString(), "UserId=" + model.CreatedBy);
                                new SysAdminAction<SysUser>().Updates("BCoin=BCoin+" + (model.Price * 0.3).ToString(), "UserId=" + Ultity.Constant.userIdAdmin);

                                #endregion

                                #region +Thêm vào lịch sử giao dịch
                                new SysAdminAction<Cms_HistoryPayment>().Payment(new Cms_HistoryPayment
                                {
                                    IdGuid = Guid.NewGuid().ToString(),
                                    FromUser = userId,
                                    Code = model.IdGuid,
                                    ToUser = model.CreatedBy.HasValue ? (Convert.ToInt32(model.CreatedBy)) : 0,
                                    BCoin = model.Price * 0.7,
                                    Summary = Ultity.Constant.ThanhToanTienHoc,
                                    CreatedDate = DateTime.Now,
                                    IsShow = false,
                                    IsActive = true,
                                });
                                new SysAdminAction<Cms_HistoryPayment>().Payment(new Cms_HistoryPayment
                                {
                                    IdGuid = Guid.NewGuid().ToString(),
                                    FromUser = userId,
                                    Code = model.IdGuid,
                                    ToUser = Ultity.Constant.userIdAdmin,
                                    BCoin = model.Price * 0.3,
                                    Summary = Ultity.Constant.ThanhToanTienHocChoAdmin,
                                    CreatedDate = DateTime.Now,
                                    IsShow = false,
                                    IsActive = true,
                                });
                                #endregion

                                #region Gửi thông báo cho Giáo viên và Admin
                                var lstUserInClass = new SysAdminAction<Cms_HistoryPayment>().GetHistoryPaymentNotShow(1, model.CreatedBy.HasValue ? (Convert.ToInt32(model.CreatedBy)) : 0);

                                IHubContext contextall = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
                                NotificationHub hub = new NotificationHub();
                                var userModel = new SysAdminAction<SysUser>().GetById((Convert.ToInt32(model.CreatedBy)));
                                UserHubModels user = hub.GetUser(userModel.UserName);
                                if (user != null)
                                {
                                    List<string> connectIds = user.ConnectionIds.ToList<string>();
                                    connectIds.ForEach(x =>
                                    {
                                        contextall.Clients.Client(x).recieveNotificationFirstTime(lstUserInClass);
                                    });
                                }
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
                            #region +Thêm học viên vào lớp

                            int idStudentClass = new Cms_ClassStudentAction().Insert(new Cms_ClassStudent
                            {
                                ClassId = model.Id,
                                StudentId = userId,
                                ClassGuid = model.IdGuid,
                                UsedState = Ultity.Constant.Active,
                                CreatedDate = DateTime.Now,
                                CreatedBy = userId
                            });
                            #endregion

                            return RedirectToAction("VaoHoc", "KhoaHoc", new { ids = ids, mkh = idStudentClass });
                        }
                    }

                    catch (Exception ex)
                    {
                        return Redirect(url);
                    }

                    return RedirectToAction("Index", "KhoaHoc");
                }
                return RedirectToAction("Index", "KhoaHoc");
            }
            return Redirect(url);
        }
        #endregion Properties Class

        public ActionResult PaymentExam(string ids, string url)
        {
            int userId = WebSecurity.CurrentUserId;
            CommonController.lstExamAuto = new List<ExamAuto>();
            if (userId > 0)
            {
                if (!string.IsNullOrEmpty(ids))
                {
                    try
                    {
                        var model = new SysAdminAction<Ex_Exam>().GetByGuidId(ids);

                        #region Kiem tra phai Admin hay khong

                        if (AuthorizeUser.IsHost() || userId == model.CreatedBy)
                        {
                            #region +Thêm mới học viên vào bảng Ex_ExamStudent
                            var examStudent = new SysAdminAction<Ex_ExamStudent>().List("a.StudentId=" + userId + " and a.ExamId='" + model.Id + "'", "", 0, 2);
                            if (examStudent.Count == 0)
                            {
                                new Ex_ExamStudentAction().Insert(new Ex_ExamStudent
                                {
                                    CreatedDate = DateTime.Now,
                                    CreatedBy = userId,
                                    UsedState = Ultity.Constant.NotActive,
                                    StudentId = userId,
                                    ExamId = model.Id
                                });
                            }
                            #endregion

                            #region +Update số lượng học viên tham gia đề thi tăng lên 1
                            new SysAdminAction<Ex_Exam>().Updates("TotalStudent=TotalStudent+1", "IdGuid='" + ids.Trim() + "'");
                            #endregion

                            #region + Update de thi la chua thi
                            new SysAdminAction<Ex_ExamStudent>().Updates("UsedState=0", "StudentId=" + WebSecurity.CurrentUserId + " and ExamId='" + model.Id + "'");
                            #endregion

                            return RedirectToAction("VaoThi", "DeThi", new { ids = ids });
                        }
                        #endregion

                        #region +Kiem tra hoc vien đóng tiền hay chưa

                        var cms_HistoryPayment = new SysAdminAction<Cms_HistoryPayment>().Select("a.Code='" + model.IdGuid + "'", "a.Code desc", 0, 1);
                        if (cms_HistoryPayment.Count > 0)
                        {
                            #region +Update số lượng học viên tham gia đề thi tăng lên 1
                            new SysAdminAction<Ex_Exam>().Updates("TotalStudent=TotalStudent+1", "IdGuid='" + ids.Trim() + "'");
                            #endregion

                            #region + Update de thi la chua thi
                            new SysAdminAction<Ex_ExamStudent>().Updates("UsedState=0", "StudentId=" + WebSecurity.CurrentUserId + " and ExamId='" + model.Id + "'");
                            #endregion
                            return RedirectToAction("VaoThi", "DeThi", new { ids = ids });
                        }

                        #endregion

                        var sysCurrentUser = new SysAdminAction<SysUser>().GetById(userId);
                        if (model.Id > 0)
                        {
                            #region +Kiem tra tien trong tai khoan
                            if (sysCurrentUser.BCoin < 0 || model.Price > sysCurrentUser.BCoin)
                            {
                                return View();
                            }
                            #endregion

                            if (model.Price > 0)
                            {
                                #region +Thanh toan tien

                                new SysAdminAction<SysUser>().Updates("BCoin=BCoin-" + model.Price, "UserId=" + userId);
                                new SysAdminAction<SysUser>().Updates("BCoin=BCoin+" + (model.Price * 0.7), "UserId=" + model.CreatedBy);
                                new SysAdminAction<SysUser>().Updates("BCoin=BCoin+" + (model.Price * 0.3), "UserId=" + Ultity.Constant.userIdAdmin);

                                #endregion

                                #region +Thêm vào lịch sử giao dịch
                                new SysAdminAction<Cms_HistoryPayment>().Payment(new Cms_HistoryPayment
                                {
                                    IdGuid = Guid.NewGuid().ToString(),
                                    Code = model.IdGuid,
                                    FromUser = userId,
                                    ToUser = model.CreatedBy.HasValue ? (Convert.ToInt32(model.CreatedBy)) : 0,
                                    BCoin = model.Price * 0.7,
                                    Summary = Ultity.Constant.ThanhToanTienThi,
                                    CreatedDate = DateTime.Now,
                                    IsShow = false,
                                    IsActive=true
                                });
                                new SysAdminAction<Cms_HistoryPayment>().Payment(new Cms_HistoryPayment
                                {
                                    IdGuid = Guid.NewGuid().ToString(),
                                    Code = model.IdGuid,
                                    FromUser = userId,
                                    ToUser = Ultity.Constant.userIdAdmin,
                                    BCoin = model.Price * 0.3,
                                    Summary = Ultity.Constant.ThanhToanTienThiChoAdmin,
                                    CreatedDate = DateTime.Now,
                                    IsShow = false,
                                    IsActive = true
                                });
                                #endregion

                                #region Gửi thông báo cho Giáo viên và Admin
                                var lstUserInClass = new SysAdminAction<Cms_HistoryPayment>().GetHistoryPaymentNotShow(1, model.CreatedBy.HasValue ? (Convert.ToInt32(model.CreatedBy)) : 0);

                                IHubContext contextall = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
                                NotificationHub hub = new NotificationHub();
                                var userModel = new SysAdminAction<SysUser>().GetById((Convert.ToInt32(model.CreatedBy)));
                                UserHubModels user = hub.GetUser(userModel.UserName);
                                if (user != null)
                                {
                                    List<string> connectIds = user.ConnectionIds.ToList<string>();
                                    connectIds.ForEach(x =>
                                    {
                                        contextall.Clients.Client(x).recieveNotificationFirstTime(lstUserInClass);
                                    });
                                }
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

                            #region +Thêm mới học viên vào bảng Ex_ExamStudent
                            var examStudent = new SysAdminAction<Ex_ExamStudent>().List("a.StudentId=" + userId + " and a.ExamId='" + model.Id + "'", "", 0, 2);
                            if (examStudent.Count == 0)
                            {
                                new Ex_ExamStudentAction().Insert(new Ex_ExamStudent
                                {
                                    CreatedDate = DateTime.Now,
                                    CreatedBy = userId,
                                    UsedState = Ultity.Constant.NotActive,
                                    StudentId = userId,
                                    ExamId = model.Id
                                });
                            }
                            #endregion

                            #region +Update số lượng học viên tham gia đề thi tăng lên 1
                            new SysAdminAction<Ex_Exam>().Updates("TotalStudent=TotalStudent+1", "IdGuid='" + ids.Trim() + "'");
                            #endregion

                            #region + Update de thi la chua thi
                            new SysAdminAction<Ex_ExamStudent>().Updates("UsedState=0", "StudentId=" + WebSecurity.CurrentUserId + " and ExamId='" + model.Id + "'");
                            #endregion
                            return RedirectToAction("VaoThi", "DeThi", new { ids = ids });
                        }
                        return Redirect(url);
                    }

                    catch (Exception ex)
                    {
                        return Redirect(url);
                    }
                }
                return RedirectToAction("Index", "DeThi");
            }
            return Redirect(url);
        }

        public ActionResult AccessAccount(string token)
        {
            if (!string.IsNullOrEmpty(token))
            {
                new SysAdminAction<SysUser>().Updates("UsedState=1", "Token='" + token + "'");
            }
            return RedirectToAction("Index", "Home");
        }
        #region Ultity
        private bool IsValidateCaptcha()
        {
            #region Check Captcha
            var response = Request["g-recaptcha-response"];
            string secretKey = ConfigurationManager.AppSettings["captcha"];
            var client = new WebClient();
            var result = client.DownloadString(string.Format("https://www.google.com/recaptcha/api/siteverify?secret={0}&response={1}", secretKey, response));
            var obj = JObject.Parse(result);
            var status = (bool)obj.SelectToken("success");
            return status;
            #endregion
        }
        bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }
        protected static void CheckSendMail(string userName,string email,string password,string token)
        {
            try
            {
                //Email nhận
                var toAddress = new MailAddress(email);
                //Setup nội dung và tiêu đề
                string subject = "Xác nhận đăng lý tài khoản HiSchool";
                string body = "Chào anh/chị <br> Bạn vừa đăng ký tài khoản có thông tin :<br> UserName:<b>" + userName + "</b><br> Mật khẩu :<b>"+password+"</b>Vui lòng click vào <a href='http://hischool.vn/Account/AccessAccount?token="+token+ "'>http://hischool.vn/Account/AccessAccount?token=" + token + "</a> để xác nhận tài khoản ";
                //Mail gửi
                var fromAddress = new MailAddress("trongnv.1995.2@gmail.com", subject);
                string fromPassword = "ngotrog1507";
                //Cấu hình Stmp
                var smtp = new SmtpClient
                {
                    Host = "smtp.gmail.com",
                    Port = 587,
                    EnableSsl = true,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    UseDefaultCredentials = false,
                    Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
                };
                //Cấu hình gửi mail
                using (var message = new MailMessage(fromAddress, toAddress)
                {
                    Subject = subject,
                    Body = body,
                    IsBodyHtml = true
                })
                { //Attach file đính kèm
                    smtp.Send(message);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Lỗi gửi email!");
                return;
            }
        }
        #endregion Properties Class
    }
}
