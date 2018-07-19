using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Core.Model;
using Framework;

namespace Core.Service
{
    public class Ex_AnswerAction
    {
        public readonly string SqlConnection =
        ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
            .ConnectionString;

        public List<Ex_Answer> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<Ex_Answer>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Answer_List_Paging"), ref objRef);
        }


        public int Insert(Ex_Answer model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Answer_Insert")
                , CommonHelper.Null.GetNull(model.SubQuestionId), CommonHelper.Null.GetNull(model.Answer), CommonHelper.Null.GetNull(model.CorrectAnswer)
                , model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

        public int Update(Ex_Answer model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Answer_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.SubQuestionId), CommonHelper.Null.GetNull(model.Answer), CommonHelper.Null.GetNull(model.CorrectAnswer)
                , model.Orders, model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedBy), CommonHelper.Null.GetNull(model.ModifiedDate));
        }

        public int Delete(string id)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Answer_Delete"), id);
        }
    }
}
