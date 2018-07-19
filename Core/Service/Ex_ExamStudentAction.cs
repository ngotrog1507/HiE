using Core.Model;
using Framework;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Service
{
    public class Ex_ExamStudentAction
    {
        public readonly string SqlConnection =
       ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
           .ConnectionString;

        public int Insert(Ex_ExamStudent model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Ex_ExamStudent_Insert")
                , CommonHelper.Null.GetNull(model.ExamId),CommonHelper.Null.GetNull(model.StudentId), model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }
    }
}
