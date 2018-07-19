using Core.Model;
using Framework;
using System;
using System.Collections.Generic;
using System.Configuration;
namespace Core.Service
{
    public class Cms_ClassStudentAction
    {
        public readonly string SqlConnection =
       ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
           .ConnectionString;

        public List<Cms_ClassStudent> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<Cms_ClassStudent>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_ClassStudent_List_Paging"), ref objRef);
        }
        public int Insert(Cms_ClassStudent model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_ClassStudent_Insert")
                , CommonHelper.Null.GetNull(model.ClassId), CommonHelper.Null.GetNull(model.ClassGuid), CommonHelper.Null.GetNull(model.StudentId), model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }
    }
}
