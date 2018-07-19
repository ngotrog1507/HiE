using Core.Ultity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Core.Model
{
    public class Cms_Question : Entity
    {
        public string IdGuid { get; set; }
        public string Grade { get; set; }
        public int SubjectId { get; set; }
        public int TotalView { get; set; }
        [AllowHtml]
        public string Summary { get; set; }
        public string GradeName { get; set; }
        public string SubjectName { get; set; }
    }
    public class Cms_QuestionComments : Entity
    {
        public string IdGuid { get; set; }
        public string QuestionId { get; set; }
        public int UserId { get; set; }
        public string Comments { get; set; }
        public bool IsActive { get; set; }
        public bool IsShow { get; set; }
        public string CreatedDateStr { get; set; }
        public string ImageUrl { get; set; }
    }
}
