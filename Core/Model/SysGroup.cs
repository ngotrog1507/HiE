using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using Core.Ultity;

namespace Core.Model
{
    public class SysGroup : Entity
    {
        public string Name { get; set; }
        [AllowHtml]
        public string Summary { get; set; }
    }
}
