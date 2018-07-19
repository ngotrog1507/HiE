using Core.Model;
using Core.Service;
using HiSchool.Models;
using Framework;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using WebMatrix.WebData;
using Core.Ultity;

namespace HiSchool.Controllers
{
    public class CommonController : Controller
    {
        public readonly string SqlConnection =
       ConfigurationManager.ConnectionStrings["ConnectionString"]
           .ConnectionString;
        public static List<ExamAuto> lstExamAuto = new List<ExamAuto>();
        public static int examId = 0;
        // GET: Common
        public ActionResult GetClassByGradeSubject(string grade, int subjectId)
        {
            var objRef = new object[5];

            string sWhere = "a.UsedState = 1 ";
            sWhere = (!string.IsNullOrEmpty(grade)) ? sWhere + " and a.Grade='" + grade + "'" : sWhere;
            sWhere = (subjectId > 0) ? sWhere + "and a.SubjectId=" + subjectId.ToString() : sWhere;
            string sSort = "a.CreatedDate desc";

            objRef[0] = sWhere;
            objRef[1] = sSort;
            objRef[2] = 0;
            objRef[3] = 15;
            objRef[4] = 0;
            var modelList = new Cms_ClassAction().List(ref objRef);
            int totalRow = CommonHelper.Convert.ConvertToInt32(objRef[4]);
            return Json(new { status = THelper.Ajax_Return.Ok, value = modelList, total = totalRow }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetByTeacherName(string name)
        {
            var objRef = new object[5];

            string sql = string.Empty;
            sql += " SELECT a.*, u.UserName AS CreatedByName,c.Name as GradeName,s.Name as SubjectName,u.FullName as FullName";
            sql += " FROM[Cms_Class] a";
            sql += " LEFT JOIN SysUser u ON a.CreatedBy = u.UserId";
            sql += " LEFT JOIN Ex_CategoryValue c on c.TypeCode = a.Grade";
            sql += " LEFT JOIN Ex_Subject s on s.Id = a.SubjectId";
            sql += " WHERE u.FullName like N'%" + name + "%' or dbo.ConvertToNoSigned(u.FullName) like  dbo.ConvertToNoSigned(N'%" + name + "%')";
            sql += " OR u.UserName like N'%" + name + "%' or dbo.ConvertToNoSigned(u.UserName) like  dbo.ConvertToNoSigned(N'%" + name + "%')";

            var list = SqlHelper.ExecuteList<Cms_Class>(SqlConnection, CommandType.Text, sql);
            return Json(new { status = THelper.Ajax_Return.Ok, value = list }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetAllGrade()
        {
            var modelList = new SysAdminAction<Ex_CategoryValue>().List("a.UsedState = 1  AND a.CatCode='KHOI'", " a.NAME DESC", 0, 100); ;
            return Json(new { status = THelper.Ajax_Return.Ok, value = modelList }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetSubjectByGrade(string grade)
        {
            var modelList = new Ex_SubjectAction().GetSubjectByGrade(grade);
            return Json(new { status = THelper.Ajax_Return.Ok, value = modelList }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult GetTopNewClass(string type)
        {
            var modelList = new List<Cms_Class>();

            if (type == "new")
            {
                string sWhere = "a.UsedState = 1";
                string sOrders = " a.CreatedDate desc ";

                var objRef = new object[5];
                objRef[0] = sWhere;
                objRef[1] = sOrders;
                objRef[2] = 0;
                objRef[3] = 8;
                objRef[4] = 0;

                modelList = new Cms_ClassAction().List(ref objRef);
            }
            else
            {
                modelList = new Cms_ClassAction().GetTopClass(8);
            }
            return Json(new { status = THelper.Ajax_Return.Ok, value = modelList }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetTopTeacher()
        {
            string sql = string.Empty;
            sql += " SELECT  CreatedBy as UserId,Id as ClassId";
            sql += " INTO #temp1";
            sql += "  FROM Cms_Class";

            sql += " SELECT a.Id AS ClassId,count(b.StudentId) as TongHS";
            sql += " INTO #temp2";
            sql += " FROM Cms_Class a";
            sql += " LEFT JOIN Cms_ClassStudent b on b.ClassId = a.Id";
            sql += " WHERE a.Id = 20";
            sql += " GROUP BY a.Id";

            sql += " SELECT TOP 5 u.ImageUrl,a.UserId,COUNT(a.ClassId) as CountClass,SUM(b.TongHS) as CountStudent,u.FullName,u.UserName";
            sql += " FROM #temp1 a";
            sql += " LEFT JOIN #temp2 b on a.ClassId=b.ClassId";
            sql += " LEFT JOIN  SysUser u on u.UserId = a.UserId";
            sql += " GROUP BY a.UserId,u.FullName,u.UserName,u.ImageUrl";
            sql += " ORDER BY CountStudent DESC";

            sql += " drop table #temp1";
            sql += " drop table #temp2";

            var list = SqlHelper.ExecuteList<TopTeacher>(SqlConnection, CommandType.Text, sql);
            return Json(new { status = THelper.Ajax_Return.Ok, value = list }, JsonRequestBehavior.AllowGet);

        }
        public ActionResult GetListExam(string gradeId, int subjectId, int sort, bool notfee, bool fee, string nameTeacher, string nameExam)
        {
            string sql = string.Empty;
            sql += " SELECT a.* ,cat.Name as GradeName,sub.Name as SubjectName,u.FullName as CreatedByName FROM Ex_Exam a";
            sql += " LEFT JOIN Ex_CategoryValue cat ON cat.TypeCode=a.Grade";
            sql += " LEFT JOIN Ex_Subject sub ON sub.Id=a.SubjectId";
            sql += " LEFT JOIN SysUser u ON u.Id=a.CreatedBy";
            sql += " WHERE 1=1";

            if (!string.IsNullOrEmpty(gradeId)) sql += " AND a.Grade='" + gradeId.Trim() + "'";
            if (subjectId > 0) sql += " AND a.SubjectId=" + subjectId;
            if (!string.IsNullOrEmpty(nameTeacher)) sql += " AND u.FullName LIKE '%" + nameTeacher + "%'";
            if (!string.IsNullOrEmpty(nameExam)) sql += " AND a.Name LIKE '%" + nameExam + "%'";
            if (fee && !notfee) sql += " AND ( Price IS NOT NULL AND Price > 0 )";
            if (!fee && notfee) sql += " AND ( Price IS NULL OR Price = 0 )";
            if (sort == 1)
                sql += " Order by CreatedDate desc";
            else sql += " Order by TotalStudent desc, CreatedDate desc";
            var list = SqlHelper.ExecuteList<Ex_Exam>(SqlConnection, CommandType.Text, sql);
            return Json(new { status = THelper.Ajax_Return.Ok, value = list }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetExamAuto(string ids)
        {
            var examConfig = new Ex_ExamConfigAction().GetConfigByExam(ids);
            var lstQuestion = new List<Ex_Question>();

            var model = new SysAdminAction<Ex_Exam>().GetByGuidId(ids);
            examId = model.Id;

            var examStudent = new SysAdminAction<Ex_ExamStudent>().List("a.StudentId=" + WebSecurity.CurrentUserId + " and a.ExamId='" + model.Id + "'", "", 0, 2);
            if (examStudent.Count > 0)
            {
                if (examStudent[0].UsedState == Ultity.Constant.NotActive)
                {
                    if (lstExamAuto.Count > 0)
                    {
                        return Json(new { status = THelper.Ajax_Return.Ok, value = lstExamAuto }, JsonRequestBehavior.AllowGet);
                    }
                    else
                    {
                        GenarateExamAuto(ids, examConfig, lstQuestion);
                    }
                }
                else
                {
                    GenarateExamAuto(ids, examConfig, lstQuestion);
                }
            }

            #region Lưu vết đề thi
            //foreach (var item in lstExamAuto)
            //{

            //}
            #endregion
            return Json(new { status = THelper.Ajax_Return.Ok, value = lstExamAuto }, JsonRequestBehavior.AllowGet);
        }
        public void GenarateExamAuto(string ids, List<Ex_ExamConfig> examConfig, List<Ex_Question> lstQuestion)
        {
            lstExamAuto = new List<ExamAuto>();
            #region Tạo đề thi tự động

            foreach (var item in examConfig)
            {
                int count = 0;

                #region +Lặp while để lấy ra danh sách ngẫu nhiên có tổng số câu bằng với cấu hình của chương
                do
                {
                    Random rnd = new Random();
                    int rndInt = rnd.Next(1, item.TotalNumber + 1);

                    string sqlQuestion = string.Empty;
                    sqlQuestion += "SELECT TOP " + rndInt + " * ";
                    sqlQuestion += " FROM Ex_Question x";
                    sqlQuestion += " WHERE x.LevelDifficult = '" + item.LevelDifficult.Trim() + "' AND x.SectionId = " + item.Id + "";
                    sqlQuestion += "  ORDER BY newid()";

                    lstQuestion = SqlHelper.ExecuteList<Ex_Question>(SqlConnection, CommandType.Text, sqlQuestion);
                    count = 0;
                    lstQuestion.ForEach(x =>
                    {
                        count += x.SubQuestion;
                    });
                } while (item.TotalNumber != count);

                #endregion
                int sttCha = 0;
                foreach (var ques in lstQuestion)
                {
                    sttCha++;
                    #region +Lấy ra các câu hỏi con

                    StringBuilder sqlSubQuestion = new StringBuilder();

                    sqlSubQuestion.Append(" SELECT * FROM Ex_SubQuestion WHERE QuestionId in(" + ques.Id + ")");
                    var lstSubQuestion = SqlHelper.ExecuteList<Ex_SubQuestion>(SqlConnection, CommandType.Text, sqlSubQuestion.ToString());

                    #endregion

                    #region +Duyệt từng câu hỏi con lấy ra đáp án của câu hỏi con

                    int stt = 0;
                    foreach (var sub in lstSubQuestion)
                    {
                        stt++;
                        var lstSubQuestion_Answer = new List<SubQuestion_Answer>();

                        StringBuilder sqlAnswer = new StringBuilder();

                        sqlAnswer.Append(" SELECT * FROM Ex_Answer WHERE SubQuestionId in(" + sub.Id + ")");
                        var lstAnswer = SqlHelper.ExecuteList<Ex_Answer>(SqlConnection, CommandType.Text, sqlAnswer.ToString());
                        if (lstAnswer.Count > 0)
                        {
                            lstAnswer.ForEach(x =>
                            {
                                x.CorrectAnswer = false;
                            });
                            #region +Thêm vào danh sách lstSubQuestion_Answer
                            lstSubQuestion_Answer.Add(new SubQuestion_Answer
                            {
                                subQuestion = sub,
                                lstAnswer = lstAnswer
                            });
                            #endregion
                        }
                        #region +Thêm vào danh sách Return. Định dạng trả về kiểu :Object{Question, List<subQuestion,List<Answer>>}

                        lstExamAuto.Add(new ExamAuto
                        {
                            sectionName = (sttCha == 1 && stt == 1) ? item.Section : string.Empty,
                            question = ques,
                            questionName = (lstSubQuestion.Count > 1) ? ((sttCha == 1 && stt == 1)) ? (ques.QuestionContent + "<br><br>" + sub.SubQuestionName) : sub.SubQuestionName : ques.QuestionContent,
                            lstSubQuestion = lstSubQuestion_Answer
                        });
                        #endregion
                    }

                    #endregion
                }
            }

            #endregion
        }
        public ActionResult ChooseAnswer(int idQuestion, int idAnswer)
        {
            if (lstExamAuto.Count > 0)
            {
                foreach (var item in lstExamAuto)
                {
                    if (item.lstSubQuestion.Count > 0)
                    {
                        foreach (var itemSub in item.lstSubQuestion)
                        {
                            if (itemSub.subQuestion.Id == idQuestion)
                            {
                                foreach (var itemAns in itemSub.lstAnswer)
                                {
                                    if (itemAns.Id == idAnswer)
                                    {
                                        itemAns.Choosed = true;
                                    }
                                    else { itemAns.Choosed = false; }
                                }
                            }
                        }
                    }
                }
            }
            return Json(new { status = THelper.Ajax_Return.Ok }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult SubmitExam()
        {
            int totalRight = 0;
            if (lstExamAuto.Count > 0)
            {
                foreach (var item in lstExamAuto)
                {
                    if (item.lstSubQuestion.Count > 0)
                    {
                        foreach (var itemSub in item.lstSubQuestion)
                        {
                            //Laasy ra dap an dung cua SubQuestion
                            int idCorrect = 0;
                            StringBuilder sqlAnswer = new StringBuilder();

                            sqlAnswer.Append(" SELECT * FROM Ex_Answer WHERE SubQuestionId in(" + itemSub.subQuestion.Id + ") and CorrectAnswer=1");
                            var lstAnswer = SqlHelper.ExecuteList<Ex_Answer>(SqlConnection, CommandType.Text, sqlAnswer.ToString());
                            if (lstAnswer.Count > 0)
                            {
                                idCorrect = lstAnswer[0].Id;
                            }
                            foreach (var itemAns in itemSub.lstAnswer)
                            {
                                itemAns.CorrectAnswer = (itemAns.Id == idCorrect);
                                if (itemAns.Choosed)
                                {
                                    totalRight = (itemAns.Id == idCorrect) ? (totalRight + 1) : totalRight;
                                }
                            }

                        }
                    }
                }
            }
            var examStudent = new SysAdminAction<Ex_ExamStudent>().Updates("UsedState=1", "StudentId=" + WebSecurity.CurrentUserId + " and ExamId='" + examId + "'");
            return Json(new { status = THelper.Ajax_Return.Ok, value = lstExamAuto, totalRight = totalRight }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult GetNotificationQuestion()
        {
            int userId = WebSecurity.CurrentUserId;
            if (userId < 0)
            {
                return Json(new { status = "err" });
            }
            string sql = "select  IdGuid as QuestionId into #tmp from Cms_Question where CreatedBy=" + userId;
            sql += " union all";
            sql += " select QuestionId as QuestionId from CMs_QuestionComments where UserId = " + userId;
            sql += "  select *from CMs_QuestionComments where UserId != " + userId + " and QuestionId in(select QuestionId from #tmp)";
            sql += "order by CreatedDate desc";

            var lstResult = SqlHelper.ExecuteList<Cms_QuestionComments>(SqlConnection, CommandType.Text, sql);
            lstResult.ForEach(x =>
            {
                x.CreatedDateStr = Convert.ToDateTime(x.CreatedDate).ToString("dd/MM/yyy HH:mm");
            });
            return Json(new { status = "ok", value = lstResult });
        }
        #region Model
        public class TopTeacher
        {
            public int UserId { get; set; }
            public int CountClass { get; set; }
            public int CountStudent { get; set; }
            public string FullName { get; set; }
            public string UserName { get; set; }
            public string ImageUrl { get; set; }
        }
        public class ExamAuto
        {
            public string sectionName { get; set; }
            public Ex_Question question { get; set; }
            public string questionName { get; set; }
            public List<SubQuestion_Answer> lstSubQuestion { get; set; }
        }
        public class SubQuestion_Answer
        {
            public Ex_SubQuestion subQuestion { get; set; }
            public List<Ex_Answer> lstAnswer { get; set; }
        }
        #endregion
    }
}
