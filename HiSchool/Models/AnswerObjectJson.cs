using Core.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HiSchool.Models
{
    public class AnswerObjectJson
    {
        public int Id { get; set; }
        public int QuestionId { get; set; }
        public string SubQuestionName { get; set; }
        public List<Ex_Answer> ListOfAnswer { get; set; }
    }
}