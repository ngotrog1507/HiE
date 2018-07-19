using Core.Ultity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Core.Model
{
    public class Cms_Class : Entity
    {
        public string IdGuid { get; set; }
        public string Grade { get; set; }
        public int SubjectId { get; set; }
        public string LinkFile { get; set; }
        public string Name { get; set; }
        public string Image { get; set; }
        public int Star { get; set; }
        public float Price { get; set; }
        public int TeacherId { get; set; }
        public float Sale { get; set; }
        public string Summary { get; set; }
        [AllowHtml]
        public string Content { get; set; }
        public string VideoDemo { get; set; }
        public string GradeName { get; set; }
        public string SubjectName { get; set; }
        public int TongHS { get; set; }
    }
}
