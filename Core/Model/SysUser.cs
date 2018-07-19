using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using Core.Ultity;

namespace Core.Model
{
    public class SysUser : Entity
    {
        public int UserId { get; set; }
        public string Token { get; set; }
        public string FullName { get; set; }
        public string BankAccount { get; set; }
        [AllowHtml]
        public string Summary { get; set; }
        public string UserName { get; set; }
        public Boolean Host { get; set; }
        public string Gender { get; set; }
        public string ImageUrl { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Password { get; set; }
        public string ConfirmPassword { get; set; }
        public int BCoin { get; set; }
        public int TongBG { get; set; }
        public int TongHS { get; set; }
        public int TongDT { get; set; }
    }
}
