using Core.Model;
using Core.Service;
using Core.Ultity;
using Framework;
using HiSchool.Handler;
using HiSchool.Models;
using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebMatrix.WebData;

namespace HiSchool.Controllers
{
    public class KhoaHocController : Controller
    {
        public readonly string SqlConnection = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        public ActionResult Index()
        {
            var listClass = new SysAdminAction<Cms_Class>().List("a.UsedState=1", "a.Star desc , a.CreatedDate desc", 0, 50);
            ViewBag.ListClass = listClass;
            ViewBag.Grade = new SysAdminAction<Ex_CategoryValue>().List("a.CatCode='KHOI'", "a.Orders desc", 0, 100);
            return View();
        }
        public ActionResult Details(string ids)
        {
            var model = new SysAdminAction<Cms_Class>().GetByGuidId(ids);
            if (model.Id > 0)
            {
                ViewBag.LstClass = new SysAdminAction<Cms_Class>().List("a.UsedState=1 AND a.CreatedBy=" + model.CreatedBy, "a.CreatedDate desc", 0, 20);
                ViewBag.UserTeacher = new SysAdminAction<SysUser>().GetById(Convert.ToInt16(model.CreatedBy));
            }
            return View(model);
        }
        public ActionResult VaoHoc(string ids, int? mkh)
        {
            try
            {
                int userId = WebSecurity.CurrentUserId;

                if (userId > 0)
                {
                    if (!string.IsNullOrEmpty(ids) && mkh > 0)
                    {
                        Session["mkh"] = mkh;
                        var model = new SysAdminAction<Cms_Class>().GetByGuidId(ids);

                        #region Kiem tra phai Admin hay khong

                        if (!AuthorizeUser.IsHost() && userId != model.CreatedBy)
                        {
                            #region +Kiem tra hoc vien co trong lop hay chua

                            var cms_ClassStudent = new SysAdminAction<Cms_ClassStudent>().List("a.ClassId=" + model.Id + " and a.StudentId=" + userId, "", 0, 1);
                            if (cms_ClassStudent.Count == 0)
                            {
                                return RedirectToAction("Details", "KhoaHoc", new { ids = ids });
                            }
                            #endregion
                        }
                        #endregion

                        var lstVideoClass = new SysAdminAction<Cms_ClassVideo>().List("a.UsedState=1 and a.ClassId=" + model.Id, "a.Orders asc", 0, 50);
                        ViewBag.ClassName = model.Name;
                        ViewBag.LinkFile = model.LinkFile;
                        ViewBag.ListVideoClass = lstVideoClass;
                        return View();
                    }

                    var studentClass = new SysAdminAction<Cms_ClassStudent>().List("a.ClassGuid='" + ids + "' and a.StudentId=" + userId, "", 0, 1);
                    return RedirectToAction("VaoHoc", "KhoaHoc", new { ids = ids, mkh = (studentClass.Count > 0) ? studentClass[0].Id : userId });
                }
                return RedirectToAction("Login", "Account", new { url = Request.Url.PathAndQuery });
            }
            catch (Exception e)
            {
                return RedirectToAction("Details", "KhoaHoc", new { ids = ids, });
            }


        }
        public ActionResult BaiGiang()
        {
            return View();
        }
        public ActionResult GiaoVien()
        {
            return View();
        }
        public ActionResult AddComment(Cms_Comments model)
        {
            #region + Thêm mới vào bảng Comments
            int userId = WebSecurity.CurrentUserId;
            //Lấy thông tin lớp học
            var modelClass = new SysAdminAction<Cms_Class>().GetByGuidId(model.IdGuid);

            if (model.mkh != null)
            {
                model.CreatedDate = DateTime.Now;
                model.ClassStudentId = Convert.ToInt32(model.mkh.ToString());
                model.ClassId = modelClass.Id;
                model.ClassGuid = modelClass.IdGuid;
                model.IsActive = true;
                model.IdGuid = Guid.NewGuid().ToString();
                model.UserId = userId;
                model.CreatedBy = userId;
                model.UserName = new SysAdminAction<SysUser>().GetById((Convert.ToInt32(userId))).UserName;
                model.IsShow = (modelClass.CreatedBy == WebSecurity.CurrentUserId);
                model.CreatedDateStr = DateTime.Now.ToString("dd/MM/yyyy HH:mm");

                new Cms_CommentsActions().Insert(model);
            }
            #endregion

            #region Gửi thông báo cho những người trong nội dung chát đó. và giáo viên

            IHubContext contextall = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
            NotificationHub hub = new NotificationHub();
            var lstResult = new List<Cms_Comments>();
            var userLogin = new SysAdminAction<SysUser>().GetById(userId);
            model.FullName = userLogin.FullName;
            model.ImageUrl = userLogin.ImageUrl;
            lstResult.Add(model);
            if (model.mkh != null)
            {
                int makh = Convert.ToInt32(model.mkh.ToString());
                //Nếu giáo viên nhập đoạn trả lời =>Gửi đến User học viên
                if (modelClass.CreatedBy == WebSecurity.CurrentUserId)
                {
                    //Update tất cả là đã show
                    new SysAdminAction<Cms_Comments>().Updates("IsShow=1", "ClassStudentId=" + makh + " and UserId !=" + userId);
                    //Gửi đến học viên đoạn chát
                    var studentModel = new SysAdminAction<Cms_ClassStudent>().GetById(makh);
                    var userModel = new SysAdminAction<SysUser>().GetById(studentModel.StudentId);
                    UserHubModels user = hub.GetUser(userModel.UserName);
                    if (user != null)
                    {
                        List<string> connectIds = user.ConnectionIds.ToList<string>();
                        connectIds.ForEach(x =>
                        {
                            contextall.Clients.Client(x).bindingPreChatTeacher(makh, lstResult);
                        });
                    }
                }
                else
                {
                    new SysAdminAction<Cms_Comments>().Updates("IsShow=1", "ClassStudentId=" + makh + " and UserId !=" + userId);
                    var userModel = new SysAdminAction<SysUser>().GetById(Convert.ToInt32(modelClass.CreatedBy));
                    UserHubModels user = hub.GetUser(userModel.UserName);
                    if (user != null)
                    {
                        List<string> connectIds = user.ConnectionIds.ToList<string>();
                        connectIds.ForEach(x =>
                        {
                            contextall.Clients.Client(x).bindingPreChatTeacher(makh, lstResult);
                            contextall.Clients.Client(x).recieveNotificationChatTeacherAdmin(makh, lstResult);
                        });
                    }
                }
            }

            #endregion
            return Json(new { status = THelper.Ajax_Return.Ok, value = model });
        }
        public ActionResult GetAllComment(int mkh, int from, int to)
        {
            var model = new SysAdminAction<Cms_Comments>().List("a.IsActive=1 and a.ClassStudentId=" + mkh, "a.CreatedDate desc", from, to);
            model.ForEach(x =>
            {
                x.CreatedDateStr = ((DateTime)x.CreatedDate).ToString("dd/MM/yyyy HH:mm");
                var user = new SysAdminAction<SysUser>().GetById(x.UserId);
                x.FullName = user.FullName;
                x.ImageUrl = user.ImageUrl;
            });
            return Json(new { status = THelper.Ajax_Return.Ok, value = model });
        }
        public ActionResult ActiveAllComment(int check)
        {
            int userId = WebSecurity.CurrentUserId;

            string sql = "select a.*,b.IdGuid as ClassGuid,c.FullName  from Cms_Comments a";
            sql += " left join Cms_Class b  on a.ClassId = b.Id";
            sql += " left join SysUser c  on c.Id = a.UserId";
            sql += " where ClassId in(select Id from Cms_Class where CreatedBy = " + userId + ") and (a.IsShow=0  or a.IsShow is null) and a.UserId !=" + userId + " order by a.CreatedDate desc";
            var lstModel = SqlHelper.ExecuteList<Cms_Comments>(SqlConnection, CommandType.Text, sql);
            string classId = "";
            lstModel.ForEach(x =>
            {
                classId += x.ClassId + ",";
            });
            new SysAdminAction<Cms_Comments>().Updates("IsShow=1", "ClassId IN(" + classId + "0)");

            return Json(new { status = THelper.Ajax_Return.Ok });
        }
        public ActionResult CheckThanhToan(string ids)
        {
            var model = new SysAdminAction<Cms_Class>().GetByGuidId(ids);
            #region +Kiem tra hoc vien đóng tiền hay chưa
            var cms_ClassStudent = new SysAdminAction<Cms_ClassStudent>().List("a.ClassId=" + model.Id + " and a.StudentId=" + WebSecurity.CurrentUserId, "", 0, 1);
            if (cms_ClassStudent.Count > 0)
            {
                return Json(new { status = "ok", ids = ids });
            }
            return Json(new { status = "not", ids = ids });
            #endregion
        }
    }
}