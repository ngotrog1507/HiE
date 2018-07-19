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
    public class CmsEmailAction
    {
        public readonly string SqlConnection =
        ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
            .ConnectionString;

        public CmsEmail GetById(int id)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Id", id));

            return SqlHelper.ExecuteTObject<CmsEmail>(SqlConnection, CommandType.Text,
                "SELECT * FROM CmsEmail WHERE Id = @Id", parameters.ToArray());
        }

        public List<CmsEmail> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<CmsEmail>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsEmail_List_Paging"), ref objRef);
        }

        public List<CmsEmail> List(string sWhere, string sOrder, int fromRow, int toRow)
        {
            return SqlHelper.ExecuteList<CmsEmail>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsEmail_List"), sWhere, sOrder, fromRow, toRow);
        }
        public int ListCount(string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsEmail_ListCount"), sWhere);
        }

        public int Insert(CmsEmail model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsEmail_Insert")
                , CommonHelper.Null.GetNull(model.Email.Trim()), CommonHelper.Null.GetNull(model.Address.Trim()), CommonHelper.Null.GetNull(model.Phone.Trim())
                , model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }


        public int Update(CmsEmail model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsEmail_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.Email.Trim()), CommonHelper.Null.GetNull(model.Address.Trim()), CommonHelper.Null.GetNull(model.Phone.Trim())
                , model.Orders, model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }

        public int Delete(string id)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsEmail_Delete"), id);
        }


    }
}
