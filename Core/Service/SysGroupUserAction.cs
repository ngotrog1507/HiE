using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Model;
using Core.Ultity;
using Framework;

namespace Core.Service
{
    public  class SysGroupUserAction
    {
        public readonly string SqlConnection =
         ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
             .ConnectionString;
        public List<SysGroupUser> GetByGroupId(int groupId)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@GroupId", groupId));

            return SqlHelper.ExecuteList<SysGroupUser>(SqlConnection, CommandType.Text,
                "SELECT * FROM SysGroupUser WHERE GroupId = @GroupId", parameters.ToArray());
        }
        public SysGroupUser Get(int id)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Id", id));

            return SqlHelper.ExecuteTObject<SysGroupUser>(SqlConnection, CommandType.Text,
                "SELECT * FROM SysGroupUser WHERE Id = @Id", parameters.ToArray());
        }
        public List<SysGroupUser> GetByUserId(int groupId, int userId)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@groupId", groupId));
            parameters.Add(new SqlParameter("@userId", userId));

            return SqlHelper.ExecuteList<SysGroupUser>(SqlConnection, CommandType.Text,
                "SELECT * FROM SysGroupUser WHERE GroupId = @groupId AND UserId=@userId", parameters.ToArray());
        }
        public List<SysGroupUser> GetGroupByUserId(int userId)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@userId", userId));

            return SqlHelper.ExecuteList<SysGroupUser>(SqlConnection, CommandType.Text,
                "SELECT * FROM SysGroupUser WHERE UserId=@userId", parameters.ToArray());
        }

        public int Add(SysGroupUser sysGroupUser)
        {
            var deciResult =
                (decimal)
                    SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysGroupUser_Insert"),
                        sysGroupUser.GroupId, sysGroupUser.UserId, sysGroupUser.Orders,
                        sysGroupUser.UsedState,
                          sysGroupUser.CreatedDate,
                        sysGroupUser.CreatedBy,
                        CommonHelper.Null.GetNull(sysGroupUser.ModifiedDate),
                        CommonHelper.Null.GetNull(sysGroupUser.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

        public int Update(SysGroupUser sysGroupUser)
        {
            return
                (int)
                    SqlHelper.ExecuteScalar(
                        SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysGroupUser_Update"),

                        sysGroupUser.Id, sysGroupUser.GroupId, sysGroupUser.UserId, sysGroupUser.Orders,
                        sysGroupUser.UsedState,
                         CommonHelper.Null.GetNull(sysGroupUser.CreatedDate),
                        CommonHelper.Null.GetNull(sysGroupUser.CreatedBy),
                        sysGroupUser.ModifiedDate,
                        sysGroupUser.ModifiedBy);
        }

        public int Delete(int id)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Id", id));

            return
                (int)
                    SqlHelper.ExecuteScalar(SqlConnection, CommandType.Text, "DELETE  FROM SysGroupUser WHERE Id = @Id SELECT @@RowCount",
                        parameters.ToArray());
        }
        public int DeleteGroupUser(int groupId, int userId)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@groupId", groupId));
            parameters.Add(new SqlParameter("@userId", userId));

            return
                (int)
                    SqlHelper.ExecuteScalar(SqlConnection, CommandType.Text, "DELETE  FROM SysGroupUser WHERE GroupId = @groupId and UserId = @userId SELECT @@RowCount",
                        parameters.ToArray());
        }
    }
}
