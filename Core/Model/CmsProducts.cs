using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using Core.Ultity;

namespace Core.Model
{
    public class CmsProducts:Entity
    {
        public int TypeId { get; set; }
        public string Image { get; set; }
        public string Name { get; set; }
        public string TypeName { get; set; }
        public string Link { get; set; }
        public string Title { get; set; }
        public int NumberView { get; set; }
        public string ShortUrl { get; set; }
        [AllowHtml]
        public string Summary { get; set; }
    }
}
