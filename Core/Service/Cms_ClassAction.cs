using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Core.Model;
using Framework;

namespace Core.Service
{
    public class Cms_ClassAction
    {
        public readonly string SqlConnection =
        ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
            .ConnectionString;

        public List<Cms_Class> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<Cms_Class>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_Class_List_Paging"), ref objRef);
        }

        public int Insert(Cms_Class model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_Class_Insert")
                , CommonHelper.Null.GetNull(model.IdGuid), CommonHelper.Null.GetNull(model.Grade), CommonHelper.Null.GetNull(model.SubjectId), CommonHelper.Null.GetNull(model.Name)
                , CommonHelper.Null.GetNull(model.Image), CommonHelper.Null.GetNull(model.Star)
                , CommonHelper.Null.GetNull(model.Price), CommonHelper.Null.GetNull(model.TeacherId), CommonHelper.Null.GetNull(model.Sale)
                , CommonHelper.Null.GetNull(model.Summary), CommonHelper.Null.GetNull(model.Content), CommonHelper.Null.GetNull(model.VideoDemo),
                CommonHelper.Null.GetNull(model.LinkFile),
                model.Orders,
                model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

        public int Update(Cms_Class model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_Class_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.IdGuid), CommonHelper.Null.GetNull(model.Grade), CommonHelper.Null.GetNull(model.SubjectId), CommonHelper.Null.GetNull(model.Name)
                , CommonHelper.Null.GetNull(model.Image), CommonHelper.Null.GetNull(model.Star)
                , CommonHelper.Null.GetNull(model.Price), CommonHelper.Null.GetNull(model.TeacherId), CommonHelper.Null.GetNull(model.Sale)
                , CommonHelper.Null.GetNull(model.Summary), CommonHelper.Null.GetNull(model.Content), CommonHelper.Null.GetNull(model.VideoDemo),
                CommonHelper.Null.GetNull(model.LinkFile), model.Orders, model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedBy), CommonHelper.Null.GetNull(model.ModifiedDate));
        }

        public int Delete(string id)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_Class_Delete"), id);
        }
        public List<Cms_Class> GetTopClass(int max)
        {
            string sql = string.Empty;

            sql += " SELECT TOP " + max + " x.*, y.TongHS, s.Name AS SubjectName, ct.Name AS GradeName ,u.FullName as CreatedByName";
            sql += " FROM Cms_Class x";
            sql += " LEFT JOIN(SELECT";
            sql += "   a.Id,COUNT(b.StudentId) AS TongHS";
            sql += " FROM Cms_Class a";
            sql += " LEFT JOIN Cms_ClassStudent b";
            sql += "   ON b.ClassId = a.Id";
            sql += " GROUP BY a.Id) y";
            sql += "   ON x.Id = y.Id";
            sql += " LEFT JOIN Ex_Subject s";
            sql += "   ON s.Id = x.SubjectId";
            sql += " LEFT JOIN Ex_CategoryValue ct";
            sql += "   ON ct.TypeCode = x.Grade";
            sql += "   LEFT JOIN SysUser u";
            sql += "   ON u.Id = x.TeacherId";
            sql += " ORDER BY y.TongHS DESC";
            return SqlHelper.ExecuteList<Cms_Class>(SqlConnection, CommandType.Text, sql);
        }
    }
}
