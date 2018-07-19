using Framework;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Model;

namespace Core.Service
{
    public class CmsProductsAction
    {
        public readonly string SqlConnection =
           ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
               .ConnectionString;

        public CmsProducts GetById(int id)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Id", id));

            return SqlHelper.ExecuteTObject<CmsProducts>(SqlConnection, CommandType.Text,
                "SELECT * FROM CmsProducts WHERE Id = @Id", parameters.ToArray());
        }

        public List<CmsProducts> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<CmsProducts>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsProducts_List_Paging"), ref objRef);
        }

        public List<CmsProducts> List(string sWhere, string sOrder, int fromRow, int toRow)
        {
            return SqlHelper.ExecuteList<CmsProducts>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsProducts_List"), sWhere, sOrder, fromRow, toRow);
        }

        public int Insert(CmsProducts model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsProducts_Insert")
               ,model.TypeId , CommonHelper.Null.GetNull(model.Image), CommonHelper.Null.GetNull(model.Name), CommonHelper.Null.GetNull(model.Link), model.NumberView
                , CommonHelper.Null.GetNull(model.Title), CommonHelper.Null.GetNull(model.Summary), model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }


        public int Update(CmsProducts model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsProducts_Update")
                 , model.Id, model.TypeId, CommonHelper.Null.GetNull(model.Image), CommonHelper.Null.GetNull(model.Name), CommonHelper.Null.GetNull(model.Link), model.NumberView
              , CommonHelper.Null.GetNull(model.Title), CommonHelper.Null.GetNull(model.Summary), model.Orders, model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }

        public int Delete(string id)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsProducts_Delete"), id);
        }
    }
}
