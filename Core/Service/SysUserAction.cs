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
using WebMatrix.WebData;

namespace Core.Service
{
    public class SysUserAction
    {
        public readonly string SqlConnection =
         ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
             .ConnectionString;

        public SysUser GetById(int sysUserId)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Id", sysUserId));
            return SqlHelper.ExecuteTObject<SysUser>(SqlConnection, CommandType.Text,
                "SELECT * FROM SysUser WHERE UserId = @Id ", parameters.ToArray());
        }
        public List<SysUser> GetMember(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<SysUser>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysUser_GetMember_Paging"), ref objRef);
        }
        public SysUser GetByUserName(string userName)
        {
            return SqlHelper.ExecuteTObject<SysUser>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysUser_GetByUserName"), userName);
        }

        public SysUser GetByEmail(string email)
        {
            return SqlHelper.ExecuteTObject<SysUser>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysUser_GetByEmail"), email);
        }

        /// <summary>
        /// objRef have parameter :
        /// sWhere NVARCHAR,
        /// iUserId INT,
        /// sOrder NVARCHAR,
        /// PageIndex INT,
        /// PageSize INT,
        /// TotalRow INT,
        /// </summary>
        /// <param name="objRef">Value PageSize is 0  query select all record</param>
        /// <returns></returns>
        public List<SysUser> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<SysUser>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysUser_List_Paging"), ref objRef);
        }

        public List<SysUser> List(string sWhere, string sOrder, int fromRow, int toRow)
        {
            return SqlHelper.ExecuteList<SysUser>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysUser_List"), sWhere, sOrder, fromRow, toRow);
        }

        public List<SysUser> ListUserNotExistsGroup(int groupId, int userId, int? notRole, int usedState, string sOrder)
        {
            return SqlHelper.ExecuteList<SysUser>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysUser_List_Not_Exists_Group"), groupId, userId, notRole, usedState, sOrder);
        }

        public int ListCount(string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysUser_ListCount"), sWhere);
        }
        public int Insert(SysUser model)
        {
            var deciResult =
                (decimal)
                    SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysUser_Insert")
                       , model.UserId, CommonHelper.Null.GetNull(model.Token), CommonHelper.Null.GetNull(model.FullName), model.UserName
                , model.Email, CommonHelper.Null.GetNull(model.ImageUrl), CommonHelper.Null.GetNull(model.Phone), CommonHelper.Null.GetNull(model.Host), CommonHelper.Null.GetNull(model.Gender), CommonHelper.Null.GetNull(model.BCoin)
                , model.UsedState,
               CommonHelper.Null.GetNull(model.CreatedBy), model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedBy), CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.BankAccount), CommonHelper.Null.GetNull(model.Summary));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

        public int Update(SysUser model)
        {

            var deciResult =
                (int)
                    SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysUser_Update")
                    , model.UserId, CommonHelper.Null.GetNull(model.Token), CommonHelper.Null.GetNull(model.UserName), CommonHelper.Null.GetNull(model.FullName)
                , model.Host, CommonHelper.Null.GetNull(model.Gender), CommonHelper.Null.GetNull(model.BCoin), model.Orders
                , CommonHelper.Null.GetNull(model.ImageUrl), CommonHelper.Null.GetNull(model.Phone)
                , CommonHelper.Null.GetNull(model.Email), model.UsedState,
              CommonHelper.Null.GetNull(model.CreatedBy), model.CreatedDate,
                CommonHelper.Null.GetNull(model.ModifiedDate), CommonHelper.Null.GetNull(model.ModifiedBy), CommonHelper.Null.GetNull(model.BankAccount), CommonHelper.Null.GetNull(model.Summary));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

        public int Updates(string sSet, string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysUser_Updates"), sSet, sWhere);
        }

        public int Delete(string sysUserId)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysUser_Delete"), sysUserId);
        }

        public int Deletes(string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysUser_Deletes"), sWhere);
        }

        /// <summary>
        /// Check UsedState Area, UsedState Group,UsedState User , ExpiredDate is active
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="usedState"></param>
        /// <returns></returns>
        public bool IsActive(int userId, int? usedState)
        {
            var dt = SqlHelper.ExecuteDataTable(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("sp_IsUserActive"), userId, usedState);
            if (dt != null && dt.Rows.Count > 0 && dt.Columns.Contains("isActive"))
            {
                return CommonHelper.Convert.ConvertToInt32(dt.Rows[0]["isActive"]) > 0;
            }
            return false;
        }

        /// <summary>
        /// (Optional) The time in minutes until the password reset token expires. The default is 1440 (24 hours).
        /// Membership provider is not registered in the configuration of your site. For more information, contact your site's system administrator
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="newPassword"></param>
        /// <returns></returns>
        public bool ChangePassword(string userName, string newPassword)
        {
            return WebSecurity.ResetPassword(WebSecurity.GeneratePasswordResetToken(userName), newPassword);
        }

        /// <summary>
        /// (Optional) The time in minutes until the password reset token expires. The default is 1440 (24 hours).
        /// Membership provider is not registered in the configuration of your site. For more information, contact your site's system administrator
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="newPassword"></param>
        /// <returns></returns>

        public bool ChangePassword(string userName, string currentPassword, string newPassword)
        {
            return WebSecurity.ChangePassword(userName, currentPassword, newPassword);
        }
    }
}
