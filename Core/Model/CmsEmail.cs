using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Ultity;

namespace Core.Model
{
    public class CmsEmail : Entity
    {
        public string Email { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
    }
}
