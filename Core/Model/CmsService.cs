using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using Core.Ultity;

namespace Core.Model
{
   public class CmsService:Entity
    {
       public string Name { get; set; }
       public string Title { get; set; }
       public string Image { get; set; }
        [AllowHtml]
       public string Summary { get; set; }

    }
}
