using Core.Ultity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Core.Model
{
    public class Ex_Question : Entity
    {
        public int SubjectId { get; set; }
        public string SubjectName { get; set; }
        public string Grade { get; set; }
        public string GradeName { get; set; }
        public string ExamId { get; set; }
        public string ExamName { get; set; }
        public int SectionId { get; set; }
        public string Section { get; set; }
        [AllowHtml]
        public string QuestionContent { get; set; }
        public string LevelDifficult { get; set; }
        public string DiffName { get; set; }
        public int SubQuestion { get; set; }
    }
}
