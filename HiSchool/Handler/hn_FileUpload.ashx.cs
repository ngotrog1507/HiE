using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using WebMatrix.WebData;

namespace HiSchool.Handler
{
    /// <summary>
    /// Summary description for hn_FileUpload
    /// </summary>
    public class hn_FileUpload : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string dirFullPath = HttpContext.Current.Server.MapPath("~/Uploads/");
            string[] files;
            int numFiles;
            files = System.IO.Directory.GetFiles(dirFullPath);

            string str_image = string.Empty;
            string fileName = string.Empty;
            string pathToSave_100 = string.Empty;
            //get string url
            string year = DateTime.Now.Year.ToString();
            string month = DateTime.Now.Month.ToString();
            string date = DateTime.Now.Day.ToString();
            string urlPath = "/Uploads/" + WebSecurity.CurrentUserId + "/" + year + "/" + month + "/" + date;
            string path = HttpContext.Current.Server.MapPath(urlPath);
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            try
            {
                foreach (string s in context.Request.Files)
                {
                    HttpPostedFile file = context.Request.Files[s];
                    //  int fileSizeInBytes = file.ContentLength;
                    //
                    string fileExtension = file.ContentType;
                    fileName = Path.GetFileNameWithoutExtension(file.FileName);
                    fileExtension = Path.GetExtension(file.FileName);
                    str_image = file.FileName;
                    pathToSave_100 = path + "/" + str_image;
                    file.SaveAs(pathToSave_100);
                }
                var t = new { url = urlPath + "/" + str_image, id = str_image, fileName = fileName };
                context.Response.Write(JsonConvert.SerializeObject(t));
            }
            catch (Exception e)
            {
                context.Response.Write(JsonConvert.SerializeObject(string.Empty));
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}