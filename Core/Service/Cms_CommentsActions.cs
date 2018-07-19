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
    public class Cms_CommentsActions
    {
        public readonly string SqlConnection =
          ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
              .ConnectionString;
        public int Insert(Cms_Comments model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Cms_Comments_Insert")
                , model.IdGuid, CommonHelper.Null.GetNull(model.ClassId), CommonHelper.Null.GetNull(model.ClassStudentId), CommonHelper.Null.GetNull(model.UserId), CommonHelper.Null.GetNull(model.UserName)
                , CommonHelper.Null.GetNull(model.Comments),
               model.CreatedBy,model.CreatedDate,
                CommonHelper.Null.GetNull(model.IsActive), CommonHelper.Null.GetNull(model.IsShow));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }
    }
}
