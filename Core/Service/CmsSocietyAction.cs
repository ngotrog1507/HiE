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
    public class CmsSocietyAction
    {
        public readonly string SqlConnection =
        ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
            .ConnectionString;

        public CmsSociety GetById(int id)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Id", id));

            return SqlHelper.ExecuteTObject<CmsSociety>(SqlConnection, CommandType.Text,
                "SELECT * FROM CmsSociety WHERE Id = @Id", parameters.ToArray());
        }

        public List<CmsSociety> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<CmsSociety>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsSociety_List_Paging"), ref objRef);
        }

        public List<CmsSociety> List(string sWhere, string sOrder, int fromRow, int toRow)
        {
            return SqlHelper.ExecuteList<CmsSociety>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsSociety_List"), sWhere, sOrder, fromRow, toRow);
        }
        public int ListCount(string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsSociety_ListCount"), sWhere);
        }

        public int Insert(CmsSociety model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsSociety_Insert")
                , CommonHelper.Null.GetNull(model.Type), CommonHelper.Null.GetNull(model.Name), CommonHelper.Null.GetNull(model.Link)
                , model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }


        public int Update(CmsSociety model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsSociety_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.Type), CommonHelper.Null.GetNull(model.Name), CommonHelper.Null.GetNull(model.Link)
                , model.Orders, model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }

        public int Delete(string id)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsSociety_Delete"), id);
        }


    }
}
