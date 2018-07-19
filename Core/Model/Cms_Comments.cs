using Core.Ultity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Model
{
    public class Cms_Comments:Entity
    {
        public int mkh { get; set; }
        public string IdGuid { get; set; }
        public string ClassGuid { get; set; }
        public int ClassId { get; set; }
        public int ClassStudentId { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string Comments { get; set; }
        public bool IsActive { get; set; }
        public bool IsShow { get; set; }
        public string CreatedDateStr { get; set; }
        public string ImageUrl { get; set; }
    }
}
