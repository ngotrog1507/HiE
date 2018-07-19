using Core.Model;
using Framework;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Service
{
    public class CmsSupportAction
    {
        public readonly string SqlConnection =
           ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
               .ConnectionString;

        public CmsSupport GetById(int id)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Id", id));

            return SqlHelper.ExecuteTObject<CmsSupport>(SqlConnection, CommandType.Text,
                "SELECT * FROM CmsSupport WHERE Id = @Id", parameters.ToArray());
        }

        public List<Model.CmsSupport> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<CmsSupport>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsSupport_List_Paging"), ref objRef);
        }

        public int ListCount(string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsSupport_ListCount"), sWhere);
        }

        public int Insert(CmsSupport model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsSupport_Insert")
                , CommonHelper.Null.GetNull(model.Name), CommonHelper.Null.GetNull(model.Email), CommonHelper.Null.GetNull(model.Phone), model.IsRead, CommonHelper.Null.GetNull(model.ContentSent),
                model.IsConfirm, CommonHelper.Null.GetNull(model.ContentConfirm)
                , CommonHelper.Null.GetNull(model.ConfirmBy), CommonHelper.Null.GetNull(model.CreatedDate));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }


        public int Update(CmsSupport model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsSupport_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.Name), CommonHelper.Null.GetNull(model.Email), CommonHelper.Null.GetNull(model.Phone), model.IsRead, CommonHelper.Null.GetNull(model.ContentSent),
                model.IsConfirm, CommonHelper.Null.GetNull(model.ContentConfirm)
                , CommonHelper.Null.GetNull(model.ConfirmBy), CommonHelper.Null.GetNull(model.CreatedDate));
        }
    }
}
