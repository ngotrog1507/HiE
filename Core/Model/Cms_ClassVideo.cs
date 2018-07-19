using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Core.Model
{
    public class Cms_ClassVideo:Core.Ultity.Entity
    {
        public string Name { get; set; }
        public string ClassName { get; set; }
        public int ClassId { get; set; }
        public bool IsFree { get; set; }
        public string Link { get; set; }
        [AllowHtml]
        public string Summary { get; set; }
    }
}
