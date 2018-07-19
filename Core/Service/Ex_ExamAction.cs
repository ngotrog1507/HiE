using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Core.Model;
using Framework;

namespace Core.Service
{
    public class Ex_ExamAction
    {
        public readonly string SqlConnection =
        ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
            .ConnectionString;

        public List<Ex_Exam> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<Ex_Exam>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Exam_List_Paging"), ref objRef);
        }


        public int Insert(Ex_Exam model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Exam_Insert")
                ,CommonHelper.Null.GetNull(model.IdGuid), CommonHelper.Null.GetNull(model.Grade), CommonHelper.Null.GetNull(model.SubjectId), CommonHelper.Null.GetNull(model.Code), CommonHelper.Null.GetNull(model.Name)
                , CommonHelper.Null.GetNull(model.Time), CommonHelper.Null.GetNull(model.Price), CommonHelper.Null.GetNull(model.TotalNumber), model.Orders, model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

        public int Update(Ex_Exam model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Exam_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.IdGuid), CommonHelper.Null.GetNull(model.Grade), CommonHelper.Null.GetNull(model.SubjectId), CommonHelper.Null.GetNull(model.Name)
                , CommonHelper.Null.GetNull(model.Time), CommonHelper.Null.GetNull(model.Price), CommonHelper.Null.GetNull(model.TotalNumber), model.Orders, model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }

        public int Delete(string id)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_Exam_Delete"), id);
        }
    }
}
