using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using Core.Ultity;

namespace Core.Model
{
   public class CmsIntroduce:Entity
    {
        [AllowHtml]
        public string HomeContent { get; set; }
        [AllowHtml]
        public string PageIntroduce { get; set; }
    }
}
