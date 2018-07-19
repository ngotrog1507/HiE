using Core.Ultity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Model
{
    public class Cms_GradeSubject : Entity
    {
        public int Grade { get; set; }
        public int SubjectId { get; set; }
        public string GradeName { get; set; }
        public string SubjectName { get; set; }
    }
}
