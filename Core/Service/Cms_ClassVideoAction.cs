using Core.Model;
using Framework;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Core.Service
{
    public class Cms_ClassVideoAction
    {
        public readonly string SqlConnection =
           ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
               .ConnectionString;

        public Cms_ClassVideo GetById(int id)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Id", id));

            return SqlHelper.ExecuteTObject<Cms_ClassVideo>(SqlConnection, CommandType.Text,
                "SELECT * FROM Cms_ClassVideo WHERE Id = @Id", parameters.ToArray());
        }

        public List<Cms_ClassVideo> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<Cms_ClassVideo>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_ClassVideo_List_Paging"), ref objRef);
        }

        public int ListCount(string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_ClassVideo_ListCount"), sWhere);
        }

        public int Insert(Cms_ClassVideo model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_ClassVideo_Insert")
                , CommonHelper.Null.GetNull(model.Name)
                , CommonHelper.Null.GetNull(model.Summary), model.ClassId, CommonHelper.Null.GetNull(model.Link) ,model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

        public int Update(Cms_ClassVideo model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_ClassVideo_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.Name)
                , CommonHelper.Null.GetNull(model.Summary), model.ClassId, CommonHelper.Null.GetNull(model.Link), model.Orders,  model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }
    }
}
