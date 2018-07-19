using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Core.Model;
using Framework;

namespace Core.Service
{
    public class Ex_QuestionAction
    {
        public readonly string SqlConnection =
        ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
            .ConnectionString;

        public List<Ex_Question> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<Ex_Question>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Question_List_Paging"), ref objRef);
        }


        public int Insert(Ex_Question model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Question_Insert")
                , CommonHelper.Null.GetNull(model.SubjectId), CommonHelper.Null.GetNull(model.Grade), CommonHelper.Null.GetNull(model.ExamId), CommonHelper.Null.GetNull(model.SectionId)
                , CommonHelper.Null.GetNull(model.QuestionContent), CommonHelper.Null.GetNull(model.LevelDifficult), CommonHelper.Null.GetNull(model.SubQuestion)
           , model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

        public int Update(Ex_Question model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Question_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.SubjectId), CommonHelper.Null.GetNull(model.Grade), CommonHelper.Null.GetNull(model.ExamId), CommonHelper.Null.GetNull(model.SectionId)
                , CommonHelper.Null.GetNull(model.QuestionContent), CommonHelper.Null.GetNull(model.LevelDifficult), CommonHelper.Null.GetNull(model.SubQuestion)
                , model.Orders, model.UsedState,
              model.CreatedBy, CommonHelper.Null.GetNull(model.CreatedDate),
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }

        public int Delete(string id)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Question_Delete"), id);
        }
        public int DeleteSubQuestionAnswer(int idQuestion)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@QuestionId", idQuestion));

            string sql = " DELETE FROM Ex_Answer WHERE SubQuestionId IN(SELECT Id FROM Ex_SubQuestion WHERE QuestionId=@QuestionId) ";
            sql += " DELETE FROM Ex_SubQuestion WHERE QuestionId=@QuestionId ";
            return SqlHelper.ExecuteNonQuery(SqlConnection, CommandType.Text,
               sql, parameters.ToArray());
        }
    }
}
