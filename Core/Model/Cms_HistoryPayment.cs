using Core.Ultity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Model
{
    public class Cms_HistoryPayment : Entity
    {
        public string IdGuid { get; set; }
        public string Code { get; set; }
        public bool IsShow { get; set; }
        public bool IsActive { get; set; }
        public int FromUser { get; set; }
        public int ToUser { get; set; }
        public string FromUserStr { get; set; }
        public string ToUserStr { get; set; }
        public double BCoin { get; set; }
        public string Summary { get; set; }
        public string CreatedDateStr { get; set; }
    }
}
