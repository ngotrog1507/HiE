using Core.Ultity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Model
{
    public class Ex_Exam : Entity
    {
        public int SubjectId { get; set; }
        public string IdGuid { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public float Price { get; set; }
        public string SubjectName { get; set; }
        public int Time { get; set; }
        public int TotalNumber { get; set; }
        public int TotalStudent { get; set; }
        public string Grade { get; set; }
        public string GradeName { get; set; }
    }
}
