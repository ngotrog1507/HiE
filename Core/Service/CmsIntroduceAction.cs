using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Model;
using Framework;

namespace Core.Service
{
    public class CmsIntroduceAction
    {
        public readonly string SqlConnection =
            ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
                .ConnectionString;

        public CmsIntroduce GetById(int id)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Id", id));

            return SqlHelper.ExecuteTObject<CmsIntroduce>(SqlConnection, CommandType.Text,
                "SELECT * FROM CmsIntroduce WHERE Id = @Id", parameters.ToArray());
        }

        public List<CmsIntroduce> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<CmsIntroduce>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("Table_List_Paging"), ref objRef);
        }

        public int ListCount(string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsIntroduce_ListCount"), sWhere);
        }

        public int Insert(CmsIntroduce model)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsIntroduce_Insert")
                , CommonHelper.Null.GetNull(model.HomeContent), CommonHelper.Null.GetNull(model.PageIntroduce), model.UsedState,
               model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }


        public int Update(CmsIntroduce model)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("CmsIntroduce_Update")
                 , model.Id, CommonHelper.Null.GetNull(model.HomeContent), CommonHelper.Null.GetNull(model.PageIntroduce), model.UsedState,
              model.CreatedBy, model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy));
        }

    }
}
