using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Core.Model;
using Framework;

namespace Core.Service
{
    public class Ex_CategoryAction
    {
        public readonly string SqlConnection =
        ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
            .ConnectionString;

        public List<Ex_Category> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<Ex_Category>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Category_List_Paging"), ref objRef);
        }


        public int Insert(Ex_Category model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Category_Insert")
                , CommonHelper.Null.GetNull(model.Code), CommonHelper.Null.GetNull(model.Name), CommonHelper.Null.GetNull(model.Total)
                , model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

        public int Update(Ex_Category model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Category_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.Code), CommonHelper.Null.GetNull(model.Name), CommonHelper.Null.GetNull(model.Total)
                , model.Orders, model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }

        public int Delete(string id)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Category_Delete"), id);
        }
    }
}
