using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Core.Model;
using Framework;

namespace Core.Service
{
    public class Ex_CategoryValueAction
    {
        public readonly string SqlConnection =
        ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
            .ConnectionString;

        public List<Ex_CategoryValue> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<Ex_CategoryValue>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_CategoryValue_List_Paging"), ref objRef);
        }


        public int Insert(Ex_CategoryValue model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_CategoryValue_Insert")
                , CommonHelper.Null.GetNull(model.CatCode), CommonHelper.Null.GetNull(model.TypeCode), CommonHelper.Null.GetNull(model.Name)
                , model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

        public int Update(Ex_CategoryValue model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_CategoryValue_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.CatCode), CommonHelper.Null.GetNull(model.TypeCode), CommonHelper.Null.GetNull(model.Name)
                , model.Orders, model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }

        public int Delete(string id)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_CategoryValue_Delete"), id);
        }
    }
}
