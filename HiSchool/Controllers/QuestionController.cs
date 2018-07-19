using Core.Model;
using Core.Service;
using Framework;
using HiSchool.Handler;
using HiSchool.Models;
using Microsoft.AspNet.SignalR;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebMatrix.WebData;

namespace HiSchool.Controllers
{
    public class QuestionController : Controller
    {
        private static int currentPage = 1;
        public readonly string SqlConnection = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        // GET: Question
        public ActionResult Index(int? page, string txtSearch)
        {
            ViewBag.Subject = new SysAdminAction<Ex_Subject>().List("a.UsedState=1", "a.Name asc", 0, 100);

            string sWhere = " a.UsedState = 1 ";
            string sOrders = " a.TotalView desc ";
            if (!string.IsNullOrEmpty(txtSearch))
            {
                sWhere += " AND a.Summary like N'%" + txtSearch + "%' or dbo.ConvertToNoSigned(a.Summary) like  dbo.ConvertToNoSigned(N'%" + txtSearch + "%')";
            }

            var objRef = new object[5];
            objRef[0] = sWhere;
            objRef[1] = sOrders;
            objRef[2] = 0;
            objRef[3] = 10;
            objRef[4] = 0;

            var modelList = new Cms_QuestionAction().List(ref objRef);
            ViewBag.ListQuestion = modelList;
            return View();
        }
        public ActionResult Details(string ids)
        {
            #region +Update lượt View và Lấy thông tin Câu hỏi
            new SysAdminAction<Cms_Question>().Updates("TotalView=TotalView+1", "IdGuid='" + ids + "'");
            string sWhere = "a.UsedState = 1 and a.IdGuid='" + ids + "'";
            string sOrders = " a.TotalView desc ";

            var objRef = new object[5];
            objRef[0] = sWhere;
            objRef[1] = sOrders;
            objRef[2] = 0;
            objRef[3] = 1;
            objRef[4] = 0;

            var modelList = new Cms_QuestionAction().List(ref objRef);
            #endregion

            return View(modelList[0]);
        }
        public ActionResult GetAllComment(string ids, int from, int to)
        {
            var model = new SysAdminAction<Cms_QuestionComments>().List("a.IsActive=1 and a.QuestionId='" + ids + "'", " a.CreatedDate desc", from, to);
            model.ForEach(x =>
            {
                x.CreatedDateStr = ((DateTime)x.CreatedDate).ToString("dd/MM/yyyy HH:mm");
                var user = new SysAdminAction<SysUser>().GetById(x.UserId);
                x.FullName = user.FullName;
                x.ImageUrl = user.ImageUrl;
            });
            return Json(new { status = THelper.Ajax_Return.Ok, value = model });
        }
        public ActionResult AddComment(Cms_QuestionComments model)
        {
            #region + Thêm mới vào bảng QuestionComments
            int userId = WebSecurity.CurrentUserId;
            var userModel = new SysAdminAction<SysUser>().GetById((Convert.ToInt32(userId)));
            //Lấy thông tin lớp học
            if (!string.IsNullOrEmpty(model.QuestionId))
            {
                model.CreatedDate = DateTime.Now;
                model.QuestionId = model.QuestionId;
                model.Comments = model.Comments;
                model.IsActive = true;
                model.IdGuid = Guid.NewGuid().ToString();
                model.UserId = userId;
                model.CreatedBy = userId;
                model.FullName = userModel.FullName;
                model.ImageUrl = userModel.ImageUrl;
                model.IsShow = true;
                model.CreatedDateStr = DateTime.Now.ToString("dd/MM/yyyy HH:mm");

                new Cms_QuestionAction().Insert(model);
            }
            #endregion

            #region Gửi Hub đến các User khác
            //Lấy ra các User cần gửi thông báo
            string sql = "SELECT * FROM SysUser b ";
            sql += " WHERE b.UserId IN";
            sql += " (SELECT UserId FROM CMs_QuestionComments a";
            sql += " WHERE a.UserId != " + userId + " AND a.QuestionId = '" + model.QuestionId + "'";
            sql += " GROUP BY UserId)";
            var lstUser = SqlHelper.ExecuteList<SysUser>(SqlConnection, CommandType.Text, sql);

            var lstResult = new List<Cms_QuestionComments>();
            lstResult.Add(model);

            IHubContext contextall = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
            NotificationHub hub = new NotificationHub();
            lstUser.ForEach(u =>
            {
                UserHubModels user = hub.GetUser(u.UserName);
                if (user != null)
                {
                    List<string> connectIds = user.ConnectionIds.ToList<string>();
                    connectIds.ForEach(x =>
                    {
                        contextall.Clients.Client(x).bindingPreCommentDienDan(model.QuestionId, lstResult);
                    });
                }
            });
            #endregion


            return Json(new { status = THelper.Ajax_Return.Ok, value = model });
        }
        [HttpGet]
        public ActionResult Create()
        {
            ViewBag.Subject = new SysAdminAction<Ex_Subject>().List("a.UsedState=1", "a.Name asc", 0, 100);
            return View();
        }
        [HttpPost]
        public ActionResult Create(Cms_Question model)
        {
            ViewBag.Subject = new SysAdminAction<Ex_Subject>().List("a.UsedState=1", "a.Name asc", 0, 100);
            if (WebSecurity.CurrentUserId < 0)
            {
                ModelState.AddModelError("Login", "Vui lòng đăng nhập để tạo câu hỏi!");
                return View();
            }
            bool check = true;
            #region  Validate
            if (!IsValidateCaptcha())
            {
                ModelState.AddModelError("Captcha", "Mã captcha không đúng.");
                check = false;
            }
            if (string.IsNullOrEmpty(model.Summary))
            {
                ModelState.AddModelError("Username", "Nội dung câu hỏi không được để trống.");
                check = false;
            }
            #endregion

            #region Handler
            if (check)
            {
                if (ModelState.IsValid)
                {
                    try
                    {
                        int id = new Cms_QuestionAction().Insert(new Cms_Question()
                        {
                            IdGuid = Guid.NewGuid().ToString(),
                            Grade = string.Empty,
                            SubjectId = model.SubjectId,
                            TotalView = 0,
                            Summary = model.Summary,
                            UsedState = 1,
                            Orders = 1,
                            CreatedBy = WebSecurity.CurrentUserId,
                            CreatedDate = DateTime.Now
                        });
                        ModelState.AddModelError("Username", "Tạo câu hỏi thành công.");
                    }
                    catch (Exception)
                    {
                        ModelState.AddModelError("Username", "Tạo câu hỏi không thành công.");
                    }
                }
            }
            #endregion
            return View();
        }
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
    }
}