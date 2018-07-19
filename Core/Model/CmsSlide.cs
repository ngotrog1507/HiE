using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Ultity;

namespace Core.Model
{
    public class CmsSlide:Entity
    {
        public string Image { get; set; }
        public string Title { get; set; }
        public string Alt { get; set; }
        public string Summary { get; set; }
    }
}

