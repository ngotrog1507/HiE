using Core.Ultity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Model
{
    public class Ex_ExamConfig : Entity
    {
        public string ExamCode { get; set; }
        public string ExamName { get; set; }
        public string LevelDifficult { get; set; }
        public string DiffName { get; set; }
        public string Section { get; set; }
        public int TotalNumber { get; set; }
    }
}
