using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web.Mvc;
using Core.Model;
using Core.Service;
using Core.Ultity;
using HiSchool.Models;
using Framework;
using Newtonsoft.Json;
using WebMatrix.WebData;

namespace HiSchool.Areas.Admin.Controllers
{
    public class Ex_QuestionController : Controller
    {
        #region Properties Class

        private readonly Ex_QuestionAction _sysAction = new Ex_QuestionAction();
        private readonly int rowInPage = CommonHelper.Convert.ConvertToInt32(ConfigurationManager.AppSettings[Ultity.Constant.rowInPage]);

        #endregion Properties Class

        #region Public Method
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult Index(int? cauhoi)
        {
            ViewBag.Host = AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll);
            ViewBag.Add = AuthorizeUser.IsAction(Ultity.Constant.Add);
            ViewBag.Edit = AuthorizeUser.IsAction(Ultity.Constant.Edit);
            ViewBag.Delete = AuthorizeUser.IsAction(Ultity.Constant.Delete);
            ViewBag.UsedStateAdd = Ultity.TFunction.GetUsedStateSelected(Ultity.Constant.Active);
            //ViewBag.UsedState = Ultity.TFunction.GetAllUsedStateSelected(Ultity.Constant.All);

            ViewBag.Grade = new SysAdminAction<Ex_CategoryValue>().List("a.CatCode='KHOI'", "", 0, 100);
            ViewBag.DoKho = new SysAdminAction<Ex_CategoryValue>().List("a.CatCode='DK'", "", 0, 100);

            var radom = new Random();
            var currentDate = DateTime.Now;

            //ViewBag.MaCauHoi = string.IsNullOrEmpty(cauhoi) ? code : cauhoi;

            return View();
        }
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult GetData(int? page, int? pageSize, string key, int? sort, string usedState)
        {
            try
            {
                var objRef = new object[5];
                int currentPageIndex = page.HasValue ? page.Value - 1 : 0;
                if (currentPageIndex < 0) currentPageIndex = 0;
                pageSize = 100;
                string sWhere = (AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll)) ? " 1=1 " : " a.CreatedBy =" + WebSecurity.CurrentUserId;
                if (!string.IsNullOrEmpty(key))
                {
                    key = key.Trim();
                    ViewBag.Search = key;
                    sWhere += "and  ( a.Name like N'%" + key + "%' or dbo.ConvertToNoSigned(a.Name) like  dbo.ConvertToNoSigned(N'%" + key + "%')) ";
                }

                if (!string.IsNullOrEmpty(usedState))
                {
                    if (!usedState.Equals(Ultity.Constant.All.ToString()))
                    {
                        ViewBag.UsedState = Ultity.TFunction.GetAllUsedStateSelected(CommonHelper.Convert.ConvertToInt32(usedState));
                        sWhere = string.IsNullOrEmpty(sWhere) ? " a.UsedState=" + usedState + "" : (sWhere + " AND a.UsedState=" + usedState + " ");
                    }
                }
                string sSort = "a.Orders DESC";
                objRef[0] = sWhere;
                objRef[1] = sSort;
                objRef[2] = currentPageIndex;
                objRef[3] = pageSize;
                objRef[4] = 0;
                var modelList = _sysAction.List(ref objRef);
                int totalRow = CommonHelper.Convert.ConvertToInt32(objRef[4]);

                //Check after deleted last item in page . Redirect page close have value smaller
                if (Request.IsAjaxRequest())
                {
                    return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = modelList, TotalPage = totalRow, CurrentPage = currentPageIndex, PageSize = pageSize });
                }
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
            return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
        }
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult GetChuong(string key, int id)
        {
            try
            {
                string sWhere = (AuthorizeUser.IsHost() || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll)) ? " 1=1 " : " a.CreatedBy =" + WebSecurity.CurrentUserId;

                sWhere += " and a.ParentId=" + id;
                sWhere += " and a.Section like '%" + key + "%'";

                string sSort = "a.Orders DESC";
                var modelList = new SysAdminAction<Ex_Question>().List(sWhere, sSort, 0, 100);

                //Check after deleted last item in page . Redirect page close have value smaller
                if (Request.IsAjaxRequest())
                {
                    return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = modelList });
                }
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
            return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
        }

        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult GetById(int? id)
        {
            var objTemporary = new Ex_Question();
            try
            {
                int editId = id.HasValue ? id.Value : 0;
                if (editId > 0)
                {
                    objTemporary = new SysAdminAction<Ex_Question>().GetById(editId);
                }
                return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = objTemporary });
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
        }

        [Authentication.ViewPermissionFunctionUser(Edit = Ultity.Constant.sEdit, Add = Ultity.Constant.sAdd, Admin = Ultity.Constant.sView)]
        [HttpPost]
        public ActionResult Edit(Ex_Question sysModel)
        {
            try
            {
                #region Redirect Request

                int succcess = 0;
                if (sysModel.Id > 0)
                {
                    var objTemporary = new SysAdminAction<Ex_Question>().GetById(sysModel.Id);
                    if (AuthorizeUser.IsAction(Ultity.Constant.Edit) || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll))
                    {
                        sysModel.CreatedBy = objTemporary.CreatedBy;
                        sysModel.ModifiedDate = DateTime.Now;
                        sysModel.ModifiedBy = WebSecurity.CurrentUserId;
                        sysModel.CreatedDate = objTemporary.CreatedDate;
                        sysModel.UsedState = objTemporary.UsedState;
                        //sysModel.Name = objTemporary.Name;
                        succcess = _sysAction.Update(sysModel);
                    }
                    else { succcess = 1; }
                }
                else
                {
                    if (AuthorizeUser.IsAction(Ultity.Constant.Add) || AuthorizeUser.IsAction(Ultity.Constant.ViewEditAll))
                    {
                        sysModel.CreatedBy = WebSecurity.CurrentUserId;
                        sysModel.ModifiedBy = null;
                        sysModel.CreatedDate = DateTime.Now;
                        sysModel.ModifiedDate = null;
                        sysModel.UsedState = Ultity.Constant.NotActive;
                        succcess = _sysAction.Insert(sysModel);
                    }
                    else { succcess = 1; }
                }

                if (succcess > 0)
                {
                    return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = succcess });
                }
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
                #endregion Redirect Request
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
            }

            return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
        }
        //[Authentication.ViewPermissionFunctionUser(Delete = Ultity.Constant.sDelete)]
        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView, Admin = Ultity.Constant.sView)]
        public ActionResult Delete(string id)
        {
            try
            {
                if (!string.IsNullOrEmpty(id))
                {
                    string sWhere = " Id IN (" + id.Trim() + ") ";
                    string sSet = "UsedState = " + Ultity.Constant.Request_Delete;

                    if (!AuthorizeUser.IsHost())
                    {
                        new SysAdminAction<Ex_Question>().Updates(sSet, sWhere);
                        return Json(new { status = "success", Message = Ultity.Constant.Change_Delete_Success });
                    }
                    else
                    {
                        new SysAdminAction<Ex_Question>().Deletes(sWhere);
                        return Json(new { status = "success", Message = Ultity.Constant.Delete_Success });
                    }
                    //Trigger auto to delete table related
                }
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
            catch (Exception exception)
            {
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
        }

        [Authentication.ViewPermissionFunctionUser(View = Ultity.Constant.sView)]
        public ActionResult GetInfoData(int type, string grade, string examId, string subjectId)
        {
            try
            {
                switch (type)
                {
                    case 1: //lấy môn học theo khối
                        {
                            var objTemporary = new Ex_SubjectAction().GetSubjectByGrade(grade);
                            return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = objTemporary });
                        }
                    case 2: //Lấy đề thi theo môn và khối
                        {
                            var objTemporary = new SysAdminAction<Ex_Exam>().List("a.SubjectId=" + subjectId + " and a.Grade='" + grade.Trim() + "'", "a.Orders desc", 0, 100);
                            return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = objTemporary });
                        }
                    case 3://Lấy chương theo đề thi
                        {
                            var objTemporary = new SysAdminAction<Ex_ExamConfig>().List("a.ExamCode='" + examId + "'", "a.Orders desc", 0, 100);
                            return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Data = objTemporary });
                        }
                    default: //break;
                        {
                            return Json(new { status = "err", Message = Ultity.Constant.Ajax_Fail });
                        }
                }

            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
        }

        [Authentication.ViewPermissionFunctionUser(Edit = Ultity.Constant.sEdit, Add = Ultity.Constant.sAdd, Admin = Ultity.Constant.sView)]
        [HttpPost]
        public ActionResult EditAnswer(string sysModel)
        {
            try
            {

                int succcess = 0;
                var listObject = JsonConvert.DeserializeObject<List<AnswerObjectJson>>(sysModel);
                #region Update số lượng câu hỏi con vào bảng Question

                new SysAdminAction<Ex_Question>().Updates("SubQuestion=" + listObject.Count, "Id=" + listObject[0].QuestionId);
                #endregion

                if (listObject.Count > 0)
                {
                    #region Xoa nhung cau hoi con cu va dap an cu
                    try
                    {
                        _sysAction.DeleteSubQuestionAnswer(listObject[0].QuestionId);
                    }
                    catch (Exception e)
                    {
                        return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
                    }

                    #endregion

                    #region Them moi cau hoi con va dap an moi

                    for (int i = 0; i < listObject.Count; i++)
                    {
                        var subQModel = new Ex_SubQuestion();
                        subQModel.QuestionId = listObject[i].QuestionId;
                        subQModel.SubQuestionName = listObject[i].SubQuestionName;
                        subQModel.Orders = (i + 1);
                        subQModel.UsedState = Ultity.Constant.Active;
                        subQModel.CreatedBy = WebSecurity.CurrentUserId;
                        subQModel.CreatedDate = DateTime.Now;

                        var sub = new Ex_SubQuestionAction().Insert(subQModel);
                        if (sub > 0)
                        {
                            for (int j = 0; j < listObject[i].ListOfAnswer.Count; j++)
                            {
                                var answer = new Ex_Answer();
                                answer.SubQuestionId = sub;
                                answer.Answer = listObject[i].ListOfAnswer[j].Answer;
                                answer.CorrectAnswer = listObject[i].ListOfAnswer[j].CorrectAnswer;
                                answer.Orders = (j + 1);
                                answer.UsedState = Ultity.Constant.Active;
                                answer.CreatedBy = WebSecurity.CurrentUserId;
                                answer.CreatedDate = DateTime.Now;
                                var ans = new Ex_AnswerAction().Insert(answer);
                            }
                        }
                    }
                    return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success });
                    #endregion Redirect Request
                }
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });

            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
            }

            return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
        }
        [Authentication.ViewPermissionFunctionUser(Edit = Ultity.Constant.sEdit, Add = Ultity.Constant.sAdd, Admin = Ultity.Constant.sView)]
        public ActionResult GetQuestion(int cauHoi)
        {
            try
            {
                if (cauHoi > 0)
                {
                    var question = new SysAdminAction<Ex_Question>().GetById(cauHoi);
                    var subQuestion = new List<Ex_SubQuestion>();
                    var answerObjectJson = new List<AnswerObjectJson>();

                    if (question.Id > 0)
                    {
                        subQuestion = new SysAdminAction<Ex_SubQuestion>().List("a.QuestionId=" + question.Id, "a.Orders asc", 0, 100);
                        if (subQuestion.Count > 0)
                        {
                            for (int i = 0; i < subQuestion.Count; i++)
                            {
                                var model = new AnswerObjectJson();
                                model.Id = subQuestion[i].Id;
                                model.QuestionId = subQuestion[i].QuestionId;
                                model.SubQuestionName = subQuestion[i].SubQuestionName;

                                var listAnswer = new List<Ex_Answer>();
                                var answer = new SysAdminAction<Ex_Answer>().List("a.SubQuestionId=" + subQuestion[i].Id, "a.Orders asc", 0, 100);
                                if (answer.Count > 0)
                                {
                                    for (int j = 0; j < answer.Count; j++)
                                    {
                                        var sAnswer = new Ex_Answer();
                                        sAnswer.Answer = answer[j].Answer;
                                        sAnswer.CorrectAnswer = answer[j].CorrectAnswer;
                                        sAnswer.Id = answer[j].Id;
                                        listAnswer.Add(sAnswer);
                                    }
                                }
                                model.ListOfAnswer = listAnswer;
                                answerObjectJson.Add(model);
                            }
                        }
                        return Json(new { status = "success", Message = Ultity.Constant.Ajax_Success, Question = question, SubQuestion = answerObjectJson });
                    }
                    return Json(new { status = "waring", Message = Ultity.Constant.Ajax_Success });

                }
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
            catch (Exception exception)
            {
                Ultity.TFunction.WriteToLog(exception);
                return Json(new { status = "fail", Message = Ultity.Constant.Ajax_Fail });
            }
        }
        #endregion Properties Class
    }
}