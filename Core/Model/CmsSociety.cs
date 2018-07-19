using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.AccessControl;
using System.Text;
using System.Threading.Tasks;
using Core.Ultity;

namespace Core.Model
{
    public class CmsSociety:Entity
    {
        public int Type { get;set; }
        public string Name { get; set; }
        public string Link { get; set; }
    }
}
