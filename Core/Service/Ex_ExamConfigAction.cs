using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Core.Model;
using Framework;

namespace Core.Service
{
    public class Ex_ExamConfigAction
    {
        public readonly string SqlConnection =
        ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
            .ConnectionString;

        public List<Ex_ExamConfig> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<Ex_ExamConfig>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_ExamConfig_List_Paging"), ref objRef);
        }


        public int Insert(Ex_ExamConfig model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_ExamConfig_Insert")
                , CommonHelper.Null.GetNull(model.ExamCode), CommonHelper.Null.GetNull(model.Section), CommonHelper.Null.GetNull(model.LevelDifficult)
                , CommonHelper.Null.GetNull(model.TotalNumber), model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

        public int Update(Ex_ExamConfig model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_ExamConfig_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.ExamCode), CommonHelper.Null.GetNull(model.Section), CommonHelper.Null.GetNull(model.LevelDifficult)
                , CommonHelper.Null.GetNull(model.TotalNumber), model.Orders, model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }

        public int Delete(string id)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_ExamConfig_Delete"), id);
        }
        public List<Ex_ExamConfig> GetExamConfig(string sWhere, string sOrders)
        {

            List<SqlParameter> parameters = new List<SqlParameter>();

            string sql = "  SELECT a.*,b.Name AS DiffName FROM Ex_ExamConfig a ";
            sql += " LEFT JOIN Ex_CategoryValue b ON a.LevelDifficult = b.TypeCode  " + sWhere + " " + sOrders;

            return SqlHelper.ExecuteList<Ex_ExamConfig>(SqlConnection, CommandType.Text, sql, parameters.ToArray());

        }
        public List<Ex_ExamConfig> GetConfigByExam(string ids)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@ids", ids));
            string sql = string.Empty;
            sql += " SELECT b.*";
            sql += " FROM Ex_Exam a";
            sql += " LEFT JOIN Ex_ExamConfig b";
            sql += "   ON a.Code = b.ExamCode";
            sql += " WHERE a.IdGuid = @ids";
            sql += " AND a.UsedState = 1";

            return SqlHelper.ExecuteList<Ex_ExamConfig>(SqlConnection, CommandType.Text, sql, parameters.ToArray());
        }
    }
}
