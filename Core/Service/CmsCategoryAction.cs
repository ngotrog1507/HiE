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
    public class CmsCategoryAction
    {
        public readonly string SqlConnection =
        ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
            .ConnectionString;

        public CmsCategory GetById(int id)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Id", id));

            return SqlHelper.ExecuteTObject<CmsCategory>(SqlConnection, CommandType.Text,
                "SELECT * FROM CmsCategory WHERE Id = @Id", parameters.ToArray());
        }

        public List<CmsCategory> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<CmsCategory>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsCategory_List_Paging"), ref objRef);
        }

        public List<CmsCategory> List(string sWhere, string sOrder, int fromRow, int toRow)
        {
            return SqlHelper.ExecuteList<CmsCategory>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsCategory_List"), sWhere, sOrder, fromRow, toRow);
        }
        public List<CmsCategory> ListRecursive(int iParentId, int iMenuId, int usedState)
        {
            return SqlHelper.ExecuteList<CmsCategory>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsCategory_List_Recursive"), iParentId, iMenuId, usedState);
        }
        public int ListCount(string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsCategory_ListCount"), sWhere);
        }

        public int Insert(CmsCategory model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsCategory_Insert")
                , CommonHelper.Null.GetNull(model.Link)
                , CommonHelper.Null.GetNull(model.Name), model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

        public int Update(CmsCategory model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsCategory_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.Link)
                , CommonHelper.Null.GetNull(model.Name), model.Orders, model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }

        public int Delete(string id)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsCategory_Delete"), id);
        }
    }
}
