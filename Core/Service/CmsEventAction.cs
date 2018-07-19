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
   public class CmsEventAction
    {
         public readonly string SqlConnection =
            ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
                .ConnectionString;

        public CmsEvent GetById(int id)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Id", id));

            return SqlHelper.ExecuteTObject<CmsEvent>(SqlConnection, CommandType.Text,
                "SELECT * FROM CmsEvent WHERE Id = @Id", parameters.ToArray());
        }

        public List<CmsEvent> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<CmsEvent>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsEvent_List_Paging"), ref objRef);
        }

        public int ListCount(string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsEvent_ListCount"), sWhere);
        }

        public int Insert(CmsEvent model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsEvent_Insert")
                , CommonHelper.Null.GetNull(model.Image), model.TypeId,CommonHelper.Null.GetNull(model.Title), CommonHelper.Null.GetNull(model.Name)
                , CommonHelper.Null.GetNull(model.Summary), model.NumberView, model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }


        public int Update(CmsEvent model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsEvent_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.Image), model.TypeId, CommonHelper.Null.GetNull(model.Title), CommonHelper.Null.GetNull(model.Name)
                , CommonHelper.Null.GetNull(model.Summary),model.NumberView, model.Orders, model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }

    }
}
