using Core.Ultity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Core.Model
{
    public class CmsSupport : Entity
    {
        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public bool IsRead { get; set; }        
        public string ContentSent { get; set; }
        public bool IsConfirm { get; set; }
        public string ContentConfirm { get; set; }
        [AllowHtml]
        public int ConfirmBy { get; set; }
    }
}
