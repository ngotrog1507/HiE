using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Core.Model;
using Framework;

namespace Core.Service
{
    public class Ex_SubjectAction
    {
        public readonly string SqlConnection =
        ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
            .ConnectionString;

        public List<Ex_Subject> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<Ex_Subject>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Subject_List_Paging"), ref objRef);
        }


        public int Insert(Ex_Subject model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Subject_Insert")
                ,CommonHelper.Null.GetNull(model.Name)
                ,  model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

        public int Update(Ex_Subject model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Subject_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.Name)
                , model.Orders, model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }

        public int Delete(string id)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Subject_Delete"), id);
        }
        public List<Ex_Subject> GetSubjectByGrade(string grade)
        {

            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@grade", grade.Trim()));

            string sql = "SELECT c.* FROM Cms_GradeSubject a";
            sql += " INNER  JOIN Ex_Subject c ON a.SubjectId=c.Id";
            sql += " where a.Grade=@grade";

            return SqlHelper.ExecuteList<Ex_Subject>(SqlConnection, CommandType.Text,
                sql, parameters.ToArray());
        }
    }
}
