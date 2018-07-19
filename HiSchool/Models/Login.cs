using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HiSchool.Models
{
    public class Login
    {
        public string UserName { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string Password { get; set; }
        public string Remember { get; set; }
        public string UrlRedirect { get; set; }
    }
}