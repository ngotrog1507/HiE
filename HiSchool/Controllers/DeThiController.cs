using Core.Model;
using Core.Service;
using Core.Ultity;
using Framework;
using HiSchool.Handler;
using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebMatrix.WebData;

namespace HiSchool.Controllers
{
    public class DeThiController : Controller
    {
        // GET: DeThi
        public ActionResult Index()
        {
            var lstExam = new SysAdminAction<Ex_Exam>().List("a.UsedState=1 AND a.CreatedBy=3", "a.TotalStudent desc", 0, 20);
            #region SingalR Remove ticket notification
            IHubContext contextall = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
            NotificationHub hub = new NotificationHub();
            UserHubModels user = hub.GetUser(User.Identity.Name);
            if (user != null)
            {
                List<string> connectIds = user.ConnectionIds.ToList<string>();
                connectIds.ForEach(x =>
                {
                    contextall.Clients.Client(x).recieveNotificationFirstTime(lstExam);
                });
            }
            #endregion
            return View();
        }
        public ActionResult Detail(string ids)
        {

            var model = new Ex_Exam();
            Session["TimeExp"] = null;
            var exam = new SysAdminAction<Ex_Exam>().GetByGuidId(ids);
            if (exam.UsedState == 1)
            {
                ViewBag.LstExam = new SysAdminAction<Ex_Exam>().List("a.UsedState=1 AND a.CreatedBy=" + exam.CreatedBy, "a.TotalStudent desc", 0, 20);
                ViewBag.UserTeacher = new SysAdminAction<SysUser>().GetById(Convert.ToInt32(exam.CreatedBy));
                return View(exam);
            }
            return View(model);
        }
        public ActionResult VaoThi(string ids)
        {
            var model = new Ex_Exam();

            var exam = new SysAdminAction<Ex_Exam>().GetByGuidId(ids);
            if (exam.UsedState == 1)
            {
                ViewBag.LstExam = new SysAdminAction<Ex_Exam>().List("a.UsedState=1 AND a.CreatedBy=" + exam.CreatedBy, "a.TotalStudent desc", 0, 20);

                #region +Kiem tra de thi da ket thuc chua. De tao lai phien moi
                var examStudent = new SysAdminAction<Ex_ExamStudent>().List("a.StudentId=" + WebSecurity.CurrentUserId + " and a.ExamId='" + exam.Id + "'", "", 0, 2);
                if (examStudent.Count > 0)
                {
                    if (examStudent[0].UsedState == Ultity.Constant.NotActive)
                    {
                        if (Session["TimeExp"] == null)
                        {
                            Session["TimeExp"] = DateTime.Now.AddMinutes(exam.Time).ToString("yyyy/MM/dd HH:mm:ss");
                        }
                    }
                    else
                    {
                        Session["TimeExp"] = null;
                        return RedirectToAction("Detail", "DeThi", new { ids = ids });
                    }
                }

                #endregion

                ViewBag.TimeExp = Session["TimeExp"];
                return View(exam);
            }
            return View(model);
        }
        public ActionResult CheckThanhToan(string ids)
        {
            var model = new SysAdminAction<Ex_Exam>().GetByGuidId(ids);
            #region +Kiem tra hoc vien đóng tiền hay chưa

            var cms_HistoryPayment = new SysAdminAction<Cms_HistoryPayment>().Select("a.Code='" + model.IdGuid + "'", "a.Code desc", 0, 1);
            if (cms_HistoryPayment.Count > 0)
            {
                return Json(new { status = "ok", ids = ids });
            }
            return Json(new { status = "not", ids = ids });
            #endregion
        }
    }
}

