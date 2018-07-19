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
    public class Cms_QuestionAction
    {
        public readonly string SqlConnection =
       ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
           .ConnectionString;
        public List<Cms_Question> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<Cms_Question>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_Question_List_Paging"), ref objRef);
        }

        public int Insert(Cms_Question model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_Question_Insert")
                , CommonHelper.Null.GetNull(model.IdGuid), CommonHelper.Null.GetNull(model.Grade), CommonHelper.Null.GetNull(model.SubjectId), CommonHelper.Null.GetNull(model.TotalView)
                , CommonHelper.Null.GetNull(model.Summary),
                model.Orders, model.UsedState,
                model.CreatedBy, model.CreatedDate, CommonHelper.Null.GetNull(model.ModifiedBy)
                , CommonHelper.Null.GetNull(model.ModifiedDate));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

        public int Update(Cms_Question model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_Question_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.IdGuid), CommonHelper.Null.GetNull(model.Grade), CommonHelper.Null.GetNull(model.SubjectId), CommonHelper.Null.GetNull(model.TotalView)
                , CommonHelper.Null.GetNull(model.Summary),
                model.Orders,
                model.UsedState,
               model.CreatedBy, model.CreatedDate, CommonHelper.Null.GetNull(model.ModifiedBy),
                CommonHelper.Null.GetNull(model.ModifiedDate));
        }
        public int Insert(Cms_QuestionComments model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_QuestionComments_Insert")
                , CommonHelper.Null.GetNull(model.IdGuid), CommonHelper.Null.GetNull(model.QuestionId), CommonHelper.Null.GetNull(model.UserId), CommonHelper.Null.GetNull(model.FullName)
                , CommonHelper.Null.GetNull(model.Comments),
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.IsActive), CommonHelper.Null.GetNull(model.IsShow));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

    }
}
