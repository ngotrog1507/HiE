using Core.Ultity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Model
{
    public class Ex_Answer : Entity
    {
        public int SubQuestionId { get; set; }
        public string Answer { get; set; }
        public bool CorrectAnswer { get; set; }
        public bool Choosed { get; set; }
    }
}
