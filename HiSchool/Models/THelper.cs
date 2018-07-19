using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace HiSchool.Models
{
    public class THelper
    {
        public static class Ajax_Return
        {
            public static string Ok = "ok";
            public static string ErrSystem = "err";
            public static string ErrLogin = "login";
        }
        public static void SendMail(string email ,string fullname,string money,string summary)
        {
            try
            {
                //Email nhận
                var toAddress = new MailAddress(email);
                //Setup nội dung và tiêu đề
                string subject = "Thông báo giao dịch HiSchool";
                string body = "Chào anh/chị <b>" + fullname + "</b><br> Bạn vừa được thực hiện <b> "+summary+"</b> thành công với số tiền :<b>" + money+ "</b>";
                //Mail gửi
                var fromAddress = new MailAddress("trongnv.1995.2@gmail.com", subject);
                string fromPassword = "ngotrog1507";
                //Cấu hình Stmp
                var smtp = new SmtpClient
                {
                    Host = "smtp.gmail.com",
                    Port = 587,
                    EnableSsl = true,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    UseDefaultCredentials = false,
                    Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
                };
                //Cấu hình gửi mail
                using (var message = new MailMessage(fromAddress, toAddress)
                {
                    Subject = subject,
                    Body = body,
                    IsBodyHtml = true
                })
                { //Attach file đính kèm
                    smtp.Send(message);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Lỗi gửi email!");
                return;
            }
        }
    }
}