using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Ultity;

namespace Core.Model
{
    public class SysGroupMenuSort : Entity
    {
        public string Name { get; set; }
        public int ParentId { get; set; }
        public int Levels { get; set; }
        public int MenuId { get; set; }
        public bool Choosed { get; set; }
    }
}
