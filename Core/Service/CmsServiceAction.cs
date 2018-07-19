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
    public class CmsServiceAction
    {

        public readonly string SqlConnection =
            ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
                .ConnectionString;

        public CmsService GetById(int id)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Id", id));

            return SqlHelper.ExecuteTObject<CmsService>(SqlConnection, CommandType.Text,
                "SELECT * FROM CmsService WHERE Id = @Id", parameters.ToArray());
        }

        public List<CmsService> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<CmsService>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Table_List_Paging"), ref objRef);
        }

        public List<CmsService> List(string sWhere, string sOrder, int fromRow, int toRow)
        {
            return SqlHelper.ExecuteList<CmsService>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsService_List"), sWhere, sOrder, fromRow, toRow);
        }
        public int ListCount(string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsService_ListCount"), sWhere);
        }

        public int Insert(CmsService model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsService_Insert")
                , CommonHelper.Null.GetNull(model.Image), CommonHelper.Null.GetNull(model.Title), CommonHelper.Null.GetNull(model.Name)
                , CommonHelper.Null.GetNull(model.Summary), model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }


        public int Update(CmsService model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsService_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.Image), CommonHelper.Null.GetNull(model.Title), CommonHelper.Null.GetNull(model.Name)
                , CommonHelper.Null.GetNull(model.Summary), model.Orders, model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }

        public int Delete(string id)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsService_Delete"), id);
        }
    }
}
