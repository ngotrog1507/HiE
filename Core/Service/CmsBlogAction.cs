using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Model;
using Framework;

namespace Core.Service
{
    public class CmsBlogAction
    {
        public readonly string SqlConnection =
           ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
               .ConnectionString;

        public CmsBlog GetById(int id)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Id", id));

            return SqlHelper.ExecuteTObject<CmsBlog>(SqlConnection, CommandType.Text,
                "SELECT * FROM CmsBlog WHERE Id = @Id", parameters.ToArray());
        }

        public List<CmsBlog> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<CmsBlog>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsBlog_List_Paging"), ref objRef);
        }

        public int ListCount(string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsBlog_ListCount"), sWhere);
        }

        public int Insert(CmsBlog model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsBlog_Insert")
                ,model.TypeId, CommonHelper.Null.GetNull(model.Image), CommonHelper.Null.GetNull(model.Title), CommonHelper.Null.GetNull(model.Name)
                , CommonHelper.Null.GetNull(model.Summary), model.NumberView, model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }


        public int Update(CmsBlog model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsBlog_Update")
                 , model.Id, model.TypeId, CommonHelper.Null.GetNull(model.Image), CommonHelper.Null.GetNull(model.Title), CommonHelper.Null.GetNull(model.Name)
                , CommonHelper.Null.GetNull(model.Summary), model.NumberView, model.Orders, model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }
    }
}
