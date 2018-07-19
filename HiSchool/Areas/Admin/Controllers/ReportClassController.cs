using Core.Model;
using Core.Service;
using Core.Ultity;
using Framework;
using HiSchool.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebMatrix.WebData;

namespace HiSchool.Areas.Admin.Controllers
{
    public class ReportClassController : Controller
    {
        public readonly string SqlConnection =
       ConfigurationManager.ConnectionStrings["ConnectionString"]
           .ConnectionString;
        // GET: Admin/ReportClass
        public ActionResult Index()
        {
            bool checkRole = AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll);
            var lstUser = new List<SysUser>();
            var lstUserTeacher = new SysGroupAction().GetUserInGroup(20, string.Empty);
            if (checkRole)
            {
                var admin = new SysAdminAction<SysUser>().GetById(Ultity.Constant.userIdAdmin);
                lstUser.Add(new SysUser()
                {
                    UserId = admin.UserId,
                    UserName = admin.UserName
                });
                lstUserTeacher.ForEach(x =>
                {
                    lstUser.Add(new SysUser()
                    {
                        UserId = x.UserId,
                        UserName = x.UserName
                    });
                });
            }
            else
            {
                var user = new SysAdminAction<SysUser>().GetById(WebSecurity.CurrentUserId);
                lstUser.Add(new SysUser()
                {
                    UserId = user.UserId,
                    UserName = user.UserName
                });
            }
            var lstClass = new List<Cms_Class>();
            var lstExam = new List<Ex_Exam>();

            if (checkRole)
            {
                lstClass = new SysAdminAction<Cms_Class>().List("", "a.CreatedDate desc", 0, 100);
                lstExam = new SysAdminAction<Ex_Exam>().List("", "a.CreatedDate desc", 0, 100);
            }
            else
            {
                lstClass = new SysAdminAction<Cms_Class>().List("a.CreatedBy=" + WebSecurity.CurrentUserId, "a.CreatedDate desc", 0, 100);
                lstExam = new SysAdminAction<Ex_Exam>().List("a.CreatedBy=" + WebSecurity.CurrentUserId, "a.CreatedDate desc", 0, 100);
            }
            ViewBag.LstClass = lstClass;
            ViewBag.LstExam = lstExam;
            ViewBag.StartDate = DateTime.Now.ToString("dd/MM/yyy 00:00");
            ViewBag.EndDate = DateTime.Now.ToString("dd/MM/yyy 23:59");
            ViewBag.ListUser = lstUser;
            ViewBag.Host = checkRole;

            return View();
        }
        public ActionResult GetData(string fromDate, string toDate, int userId, bool chkKhoaHoc, bool chkDeThi, string ddlClass, string ddlExam)
        {
            DateTime dtFrom, dtTo;
            var lstResult = new List<ReportClassModel>();

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

            #region +Handler
            if (chkKhoaHoc)
            {                
                string sWhere = "1=1  and a.CreatedDate>='"+ dtFrom.ToString("MM/dd/yyy HH:mm") + "' and a.CreatedDate <='"+ dtTo.ToString("MM/dd/yyy HH:mm") + "'";
                sWhere = (userId == 0 && AuthorizeUser.IsHost()) ?  sWhere: (sWhere + "and a.CreatedBy=" + (userId == 0 ? WebSecurity.CurrentUserId : userId) + "");
                sWhere = (ddlClass == "0") ? sWhere : (sWhere + "and a.IdGuid='" + ddlClass + "'");
                string sql = "Select a.*,(select count(*) from Cms_ClassStudent where ClassGuid=a.IdGuid)as TongHS from Cms_Class a ";
                sql += " where " + sWhere;
                var lst = SqlHelper.ExecuteList<Cms_Class>(SqlConnection, CommandType.Text, sql);
                lst.ForEach(x =>
                {
                    lstResult.Add(new ReportClassModel
                    {
                        Time = Convert.ToDateTime(x.CreatedDate),
                        Loai = "Khóa học",
                        Ten = x.Name,
                        SoLuong = x.TongHS

                    });
                });
            }
            if (chkDeThi)
            {
                string sWhere = "1=1 and a.CreatedDate>='" + dtFrom.ToString("MM/dd/yyy HH:mm") + "' and a.CreatedDate <='" + dtTo.ToString("MM/dd/yyy HH:mm") + "'";
                sWhere = (userId == 0 && AuthorizeUser.IsHost()) ? sWhere : (sWhere + "and a.CreatedBy=" + (userId==0?WebSecurity.CurrentUserId:userId) + "");
                sWhere = (ddlExam == "0") ? sWhere : (sWhere + "and a.IdGuid='" + ddlExam + "'");
                var lst = new SysAdminAction<Ex_Exam>().List(sWhere, "a.CreatedDate desc", 0, 100);
                lst.ForEach(x =>
                {
                    lstResult.Add(new ReportClassModel
                    {
                        Time = Convert.ToDateTime(x.CreatedDate),
                        Loai = "Đề thi",
                        Ten = x.Name,
                        SoLuong = x.TotalStudent

                    });
                });

            }
            #endregion
            return Json(new { status = THelper.Ajax_Return.Ok, value = lstResult });

        }
        public ActionResult GetClassExam(int userId)
        {
            var lstClass = new SysAdminAction<Cms_Class>().List("a.CreatedBy=" + userId, "a.CreatedDate desc", 0, 100);
            var lstExam = new SysAdminAction<Ex_Exam>().List("a.CreatedBy=" + userId, "a.CreatedDate desc", 0, 100);
            return Json(new { status = THelper.Ajax_Return.Ok, lstClass = lstClass, lstExam = lstExam });
        }
        private class ReportClassModel
        {
            public DateTime Time { get; set; }
            public string Loai { get; set; }
            public string Ten { get; set; }
            public int SoLuong { get; set; }
        }
    }
}