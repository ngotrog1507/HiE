using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Core.Model;
using Framework;

namespace Core.Service
{
    public class Ex_SubQuestionAction
    {
        public readonly string SqlConnection =
        ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
            .ConnectionString;

        public List<Ex_SubQuestion> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<Ex_SubQuestion>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_SubQuestion_List_Paging"), ref objRef);
        }


        public int Insert(Ex_SubQuestion model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_SubQuestion_Insert")
                , CommonHelper.Null.GetNull(model.QuestionId), CommonHelper.Null.GetNull(model.SubQuestionName)
              , model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

        public int Update(Ex_SubQuestion model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_SubQuestion_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.QuestionId), CommonHelper.Null.GetNull(model.SubQuestionName)
               , model.Orders, model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }

        public int Delete(string id)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_SubQuestion_Delete"), id);
        }
    }
}
