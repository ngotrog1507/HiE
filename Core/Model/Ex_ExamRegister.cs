using Core.Ultity;
using System;
using System.Collections.Generic;
namespace Core.Model
{
    public class Ex_ExamRegister : Entity
    {
        public string IdGuid { get; set; }
        public string IdExam { get; set; }
        public int StudentId { get; set; }
        public bool IsSuccess { get; set; }
        public DateTime ExamTime { get; set; }
        public int TotalRight { get; set; }
        public int TotalWrong { get; set; }

    }
    public class Ex_ExamQuestionRegister
    {
        public string IdExamRegister { get; set; }
        public string IdSubQuestion { get; set; }
    }
    public class Ex_QuestionAnswerRegister
    {
        public string IdGuid { get; set; }
        public string SubQuestionId { get; set; }
        public string Answer { get; set; }
        public bool CorrectAnswer { get; set; }
        public string Choosed { get; set; }
    }
}
