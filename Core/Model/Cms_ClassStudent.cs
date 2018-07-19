using Core.Ultity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Model
{
    public class Cms_ClassStudent : Entity
    {
        public int ClassId { get; set; }
        public string ClassGuid { get; set; }
        public int StudentId { get; set; }
    }
}
