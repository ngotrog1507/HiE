using System;
using System.Configuration;
using System.Data;
using System.Web.Mvc;
using Core.Model;
using Core.Service;
using Framework;

namespace HiSchool.Controllers
{
    public class HomeController : Controller
    {
        #region Properties Class

        private readonly int rowInPage = CommonHelper.Convert.ConvertToInt32(ConfigurationManager.AppSettings["RowInPageClient"]);
        private readonly int rowInPageLQ = CommonHelper.Convert.ConvertToInt32(ConfigurationManager.AppSettings["RowInPageClientLienQuan"]);
        public readonly string SqlConnection =
       ConfigurationManager.ConnectionStrings["ConnectionString"]
           .ConnectionString;

        #endregion Properties Class

        #region Public Method
        public ActionResult Index()
        {
            try
            {
                var objRef = new object[5];

                #region + Danh sách lớp học mới nhất

                string sWhere = "a.UsedState = 1";
                string sSort = "a.CreatedDate desc";

                objRef[0] = sWhere;
                objRef[1] = sSort;
                objRef[2] = 0;
                objRef[3] = 15;
                objRef[4] = 0;
                var modelList = new Cms_ClassAction().List(ref objRef);
                int totalRow = CommonHelper.Convert.ConvertToInt32(objRef[4]);
                ViewBag.ListClass = modelList;
                #endregion

                #region +Bài viết
                var objRef2 = new object[5];

                sWhere = "a.UsedState = 1";
                sSort = "a.CreatedDate desc";

                objRef2[0] = sWhere;
                objRef2[1] = sSort;
                objRef2[2] = 0;
                objRef2[3] = 15;
                objRef2[4] = 0;
                var modelBlog = new CmsBlogAction().List(ref objRef2);
                ViewBag.Blog = modelBlog;
                #endregion

                #region +Danh sách đề thi
                sWhere = "a.UsedState = 1";
                sSort = "a.CreatedDate desc";

                objRef[0] = sWhere;
                objRef[1] = sSort;
                objRef[2] = 0;
                objRef[3] = 4;
                objRef[4] = 0;
                var modelExam = new Ex_ExamAction().List(ref objRef2);
                ViewBag.Exam = modelExam;
                #endregion

                #region +Thầy cô nổi bật

                #region +Theo số học sinh
                string sql = "SELECT b.FullName,a.CreatedBy AS UserId,COUNT(*) TongBG,b.ImageUrl";
                sql += " FROM Cms_Class a";
                sql += " LEFT JOIN SysUser b";
                sql += " ON a.CreatedBy = b.Id";
                sql += " GROUP BY a.CreatedBy,b.FullName,b.ImageUrl";
                sql += " ORDER BY TongBG DESC";

                var listHS = SqlHelper.ExecuteList<SysUser>(SqlConnection, CommandType.Text, sql);
                #endregion
                #region +Theo số bài giảng
                sql = "SELECT b.FullName,a.CreatedBy AS UserId,COUNT(*) TongBG,b.ImageUrl";
                sql += " FROM Cms_Class a";
                sql += " LEFT JOIN SysUser b";
                sql += " ON a.CreatedBy = b.Id";
                sql += " GROUP BY a.CreatedBy,b.FullName,b.ImageUrl";
                sql += " ORDER BY TongBG DESC";

                var listBG = SqlHelper.ExecuteList<SysUser>(SqlConnection, CommandType.Text, sql);
                #endregion
                #region +Theo số đề thi
                sql = "SELECT b.FullName,a.CreatedBy AS UserId,COUNT(*) TongDT,b.ImageUrl";
                sql += " FROM Ex_Exam a";
                sql += " LEFT JOIN SysUser b";
                sql += " ON a.CreatedBy = b.Id";
                sql += " GROUP BY a.CreatedBy,b.FullName,b.ImageUrl";
                sql += " ORDER BY TongDT DESC";

                var listDT = SqlHelper.ExecuteList<SysUser>(SqlConnection, CommandType.Text, sql);
                #endregion
                ViewBag.TopBaiGiang = listBG;
                ViewBag.TopDeThi = listDT;
                #endregion

                #region Học sinh chuyên cần
                #endregion

            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
            return View();
        }


        //public ActionResult Video(int? id, int? page, string title, string type)
        //{
        //    try
        //    {
        //        int size = rowInPage;
        //        int currentPageIndex = page.HasValue ? page.Value - 1 : 0;
        //        if (currentPageIndex < 0) currentPageIndex = 0;
        //        int editId = id.HasValue ? id.Value : 0;

        //        var objRef = new object[5];
        //        string sWhere = "a.UsedState=1";
        //        string sOrder = "a.CreatedDate desc";
        //        var products = new List<CmsProducts>();
        //        if (!string.IsNullOrEmpty(type))
        //        {
        //            var cmsType = new SysAdminAction<CmsClassVideo>().List("a.ShortUrl =N'" + type + "'", "a.Orders asc", 0, 1);
        //            if (cmsType.Count > 0)
        //            {
        //                sWhere += " and a.TypeId = " + cmsType[0].Id;
        //            }
        //            sOrder = "a.Orders asc";
        //            ViewBag.Type = type;
        //        }

        //        if (editId > 0)
        //        {
        //            ViewBag.Product = new SysAdminAction<CmsProducts>().GetById(editId);
        //            products = null;
        //            var update = new SysAdminAction<CmsProducts>().Updates("NumberView=" + (Convert.ToInt32(ViewBag.Product.NumberView) + 1).ToString(), "Id=" + editId);
        //            var objRefLQ = new object[5];
        //            objRefLQ[0] = "a.UsedState=1 and a.TypeId=" + ViewBag.Product.TypeId + " and a.Id != " + editId;
        //            objRefLQ[1] = "a.Orders asc";
        //            objRefLQ[2] = currentPageIndex;
        //            objRefLQ[3] = 70;
        //            objRefLQ[4] = 0;
        //            ViewBag.LienQuan = new CmsProductsAction().List(ref objRefLQ);
        //            return View(products);
        //        }
        //        objRef[0] = sWhere;
        //        objRef[1] = sOrder;
        //        objRef[2] = currentPageIndex;
        //        objRef[3] = size;
        //        objRef[4] = 0;
        //        products = new CmsProductsAction().List(ref objRef);
        //        int total = CommonHelper.Convert.ConvertToInt32(objRef[4]);
        //        ViewBag.Total = total;
        //        ViewBag.PageCurrent = currentPageIndex + 1;
        //        ViewBag.PageCount = (total % size > 0) ? ((total / size) + 1) : (total / size);
        //        ViewBag.ListType = new SysAdminAction<CmsClassVideo>().List("a.UsedState=1 and a.Type=" + Ultity.Constant.Video, "a.Orders asc", 0, 100);
        //        return View(products);
        //    }
        //    catch (Exception e)
        //    {
        //        return View(new List<CmsProducts>());
        //    }
        //}

        //public ActionResult Blogs(int? id, int? page, string title, string type)
        //{
        //    try
        //    {
        //        int currentPageIndex = page.HasValue ? page.Value - 1 : 0;
        //        if (currentPageIndex < 0) currentPageIndex = 0;
        //        int editId = id.HasValue ? id.Value : 0;

        //        var objRef = new object[5];
        //        string sWhere = "a.UsedState=1";
        //        string sOrder = "a.CreatedDate desc";
        //        var blogs = new List<CmsBlog>();
        //        int size = rowInPage;

        //        if (!string.IsNullOrEmpty(type))
        //        {
        //            var cmsType = new SysAdminAction<CmsClassVideo>().List("a.ShortUrl =N'" + type + "'", "a.Orders asc", 0, 1);
        //            if (cmsType.Count > 0)
        //            {
        //                sWhere += " and a.TypeId = " + cmsType[0].Id;
        //            }
        //            sOrder = "a.Orders asc";
        //            ViewBag.Type = type;
        //        }

        //        if (editId > 0)
        //        {
        //            ViewBag.Blog = new SysAdminAction<CmsBlog>().GetById(editId);
        //            blogs = null;
        //            var update = new SysAdminAction<CmsBlog>().Updates(
        //                "NumberView=" + (Convert.ToInt32(ViewBag.Blog.NumberView) + 1).ToString(), "Id=" + editId);
        //            var objRefLQ = new object[5];
        //            objRefLQ[0] = "a.UsedState=1 and a.TypeId=" + ViewBag.Blog.TypeId + " and a.Id!=" + editId;
        //            objRefLQ[1] = "a.Orders asc";
        //            objRefLQ[2] = currentPageIndex;
        //            objRefLQ[3] = rowInPageLQ;
        //            objRefLQ[4] = 0;
        //            ViewBag.LienQuan = new CmsBlogAction().List(ref objRefLQ);
        //            return View(blogs);
        //        }

        //        objRef[0] = sWhere;
        //        objRef[1] = sOrder;
        //        objRef[2] = currentPageIndex;
        //        objRef[3] = size;
        //        objRef[4] = 0;
        //        blogs = new CmsBlogAction().List(ref objRef);
        //        int total = CommonHelper.Convert.ConvertToInt32(objRef[4]);
        //        ViewBag.ListType =
        //            new SysAdminAction<CmsClassVideo>().List("a.UsedState=1 and a.Type=" + Ultity.Constant.TinTuc, "a.Orders asc", 0, 100);
        //        ViewBag.Total = total;
        //        ViewBag.PageCurrent = currentPageIndex + 1;
        //        ViewBag.PageCount = (total % size > 0) ? ((total / size) + 1) : (total / size);
        //        return View(blogs);
        //    }
        //    catch (Exception e)
        //    {
        //        return View(new List<CmsBlog>());
        //    }
        //}
        //[HttpGet]
        //public ActionResult Contact()
        //{
        //    var model = new CmsEmail();
        //    try
        //    {

        //        var list = new SysAdminAction<CmsEmail>().List("a.UsedState=1", "", 0, 1);
        //        model = (list.Count > 0) ? list[0] : null;
        //    }
        //    catch (Exception e)
        //    {
        //        Console.WriteLine(e);
        //    }
        //    ViewBag.CmsEmail = model;
        //    return View();
        //}
        //[HttpPost]
        //public ActionResult Contact(CmsSupport cmsSupport)
        //{
        //    var cmsEmail = new CmsEmail();
        //    try
        //    {

        //        var list = new SysAdminAction<CmsEmail>().List("a.UsedState=1", "", 0, 1);
        //        cmsEmail = (list.Count > 0) ? list[0] : null;
        //    }
        //    catch (Exception e)
        //    {
        //        Console.WriteLine(e);
        //    }
        //    ViewBag.CmsEmail = cmsEmail;
        //    #region Check Captcha
        //    var response = Request["g-recaptcha-response"];
        //    string secretKey = ConfigurationManager.AppSettings["captcha"];
        //    var client = new WebClient();
        //    var result = client.DownloadString(string.Format("https://www.google.com/recaptcha/api/siteverify?secret={0}&response={1}", secretKey, response));
        //    var obj = JObject.Parse(result);
        //    var status = (bool)obj.SelectToken("success");
        //    #endregion
        //    bool check = true;
        //    #region Validate form
        //    if (!status)
        //    {
        //        ModelState.AddModelError("Captcha", "Mã captcha không đúng.");
        //        check = false;
        //    }
        //    if (string.IsNullOrEmpty(cmsSupport.Name))
        //    {
        //        ModelState.AddModelError("Username", "Không được để trống Tên.");
        //        check = false;
        //    }
        //    if (string.IsNullOrEmpty(cmsSupport.Email))
        //    {
        //        ModelState.AddModelError("Email", "Không được để trống Email.");
        //        check = false;
        //    }
        //    if (!string.IsNullOrEmpty(cmsSupport.Email) && (!IsValidEmail(cmsSupport.Email)))
        //    {
        //        ModelState.AddModelError("EmailValidate", "Email không đúng định dạng.");
        //        check = false;
        //    }
        //    if (string.IsNullOrEmpty(cmsSupport.ContentSent))
        //    {
        //        ModelState.AddModelError("ContentSent", "Nội dung không được để trống.");
        //        check = false;
        //    }
        //    if (!string.IsNullOrEmpty(cmsSupport.ContentSent) && cmsSupport.ContentSent.Length < 20)
        //    {
        //        ModelState.AddModelError("ContentSent", "Nội dung phải lớn hơn 20 ký tự.");
        //        check = false;
        //    }
        //    #endregion
        //    if (check)
        //    {
        //        if (ModelState.IsValid)
        //        {
        //            var model = new CmsSupport();
        //            model.IsRead = false;
        //            model.Name = cmsSupport.Name;
        //            model.Email = cmsSupport.Email;
        //            model.ContentSent = cmsSupport.ContentSent;
        //            model.CreatedDate = DateTime.Now;
        //            model.Phone = cmsSupport.Phone;
        //            var update = new CmsSupportAction().Insert(model);
        //            ModelState.AddModelError("Success", "Gửi phản hồi thành công.");
        //        }                
        //    }
        //    return View();
        //}
        bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }
        #endregion 
    }
}