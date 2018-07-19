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
    public class CmsSlideAction
    {
        public readonly string SqlConnection =
        ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
            .ConnectionString;

        public CmsSlide GetById(int id)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Id", id));

            return SqlHelper.ExecuteTObject<CmsSlide>(SqlConnection, CommandType.Text,
                "SELECT * FROM CmsSlide WHERE Id = @Id", parameters.ToArray());
        }

        public List<CmsSlide> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<CmsSlide>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsSlide_List_Paging"), ref objRef);
        }

        public List<CmsSlide> List(string sWhere, string sOrder, int fromRow, int toRow)
        {
            return SqlHelper.ExecuteList<CmsSlide>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsSlide_List"), sWhere, sOrder, fromRow, toRow);
        }
        public int ListCount(string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsSlide_ListCount"), sWhere);
        }

        public int Insert(CmsSlide model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsSlide_Insert")
                , CommonHelper.Null.GetNull(model.Image), CommonHelper.Null.GetNull(model.Title), CommonHelper.Null.GetNull(model.Alt)
                , model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }


        public int Update(CmsSlide model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsSlide_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.Image), CommonHelper.Null.GetNull(model.Title), CommonHelper.Null.GetNull(model.Alt)
                , model.Orders, model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }

        public int Delete(string id)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsSlide_Delete"), id);
        }
    }
}
