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
    public class SysGroupMenuAction
    {
        public readonly string SqlConnection =
          ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
              .ConnectionString;
        public List<SysGroupMenu> GetByGroupId(int groupId)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@GroupId", groupId));

            return SqlHelper.ExecuteList<SysGroupMenu>(SqlConnection, CommandType.Text,
                "SELECT * FROM SysGroupMenu WHERE GroupId = @GroupId", parameters.ToArray());
        }
        public SysGroupMenu GetById(int groupId)
        {
            return SqlHelper.ExecuteTObject<SysGroupMenu>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysGroupMenu_GetById"), groupId);
        }

        public List<SysGroupMenu> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<SysGroupMenu>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysGroupMenu_List_Reference"), ref objRef);
        }

        public List<SysGroupMenu> List(string sWhere, string sOrder, int fromRow, int toRow)
        {
            return SqlHelper.ExecuteList<SysGroupMenu>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysGroupMenu_List"), sWhere, sOrder, fromRow, toRow);
        }

        public List<SysMenu> ListRecursive(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<SysMenu>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysMenu_List_Recursive"), ref objRef);
        }

        public List<SysGroupMenuSort> GetMenuByGroupId(int groupId)
        {
            var objRef = new object[2];
            objRef[0] = groupId;
            objRef[1] = 1;
            return SqlHelper.ExecuteList<SysGroupMenuSort>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysGroupMenu_GetBy_GroupId"), objRef);
        }
        public SysGroupMenu FindByRole(int groupId, int menuId, int roleId)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@groupId", groupId));
            parameters.Add(new SqlParameter("@menuId", menuId));
            parameters.Add(new SqlParameter("@roleId", roleId));

            return SqlHelper.ExecuteTObject<SysGroupMenu>(SqlConnection, CommandType.Text,
                "SELECT * FROM SysGroupMenu WHERE GroupId = @GroupId AND MenuId=@MenuId AND RoleId=@RoleId", parameters.ToArray());
        }

        public List<SysGroupMenu> GetRoleByUrl(string link, int role,int userId)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Link", link));
            parameters.Add(new SqlParameter("@RoleId", role));
            parameters.Add(new SqlParameter("@UserId", userId));

            string sql = "SELECT  * FROM SysGroupMenu WHERE MenuId in ";
            sql += "(SELECT Id FROM SysMenu WHERE Link = @Link) ";
            sql += "and RoleId = @RoleId ";
            sql += " AND GroupId in (SELECT GroupId FROM SysGroupUser WHERE UserId = @UserId)";

            return SqlHelper.ExecuteList<SysGroupMenu>(SqlConnection, CommandType.Text,
                sql, parameters.ToArray());
        }
        public GroupMenuObj GetRole(int groupId, int menuId)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@groupId", groupId));
            parameters.Add(new SqlParameter("@menuId", menuId));

            string query = "SELECT A.GroupId,A.MenuId," +
                           " SUM(CASE WHEN A.RoleId = 4 THEN 1 ELSE 0 END) AS RoleView," +
                           " SUM(CASE WHEN A.RoleId = 1 THEN 1 ELSE 0 END) AS RoleAdd," +
                           " SUM(CASE WHEN A.RoleId = 2 THEN 1 ELSE 0 END) AS RoleEdit," +
                           " SUM(CASE WHEN A.RoleId = 3 THEN 1 ELSE 0 END) AS RoleDelete," +
                           " SUM(CASE WHEN A.RoleId = 5 THEN 1 ELSE 0 END) AS RoleAccept," +
                           " SUM(CASE WHEN A.RoleId = 6 THEN 1 ELSE 0 END) AS RoleExport," +
                           " SUM(CASE WHEN A.RoleId = 0 THEN 1 ELSE 0 END) AS RoleAdmin" +
                           " FROM SysGroupMenu  A" +
                           " WHERE GroupID = @groupId AND MenuId = @menuId" +
                           " group by GroupId,MenuId";
            return SqlHelper.ExecuteTObject<GroupMenuObj>(SqlConnection, CommandType.Text,
                query, parameters.ToArray());
        }
        public int Insert(SysGroupMenu sysGroupMenu)
        {
            var deciResult =
                (decimal)
                    SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysGroupMenu_Insert"),
                        sysGroupMenu.GroupId, sysGroupMenu.MenuId, sysGroupMenu.RoleId, sysGroupMenu.RoleName,
                        sysGroupMenu.UsedState, sysGroupMenu.Orders,
                          sysGroupMenu.CreatedDate,
                        sysGroupMenu.CreatedBy,
                        CommonHelper.Null.GetNull(sysGroupMenu.ModifiedDate),
                        CommonHelper.Null.GetNull(sysGroupMenu.ModifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }
        public List<SysUser> FindByMenu(int groupId, int menuId)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@groupId", groupId));
            parameters.Add(new SqlParameter("@menuId", menuId));

            return SqlHelper.ExecuteList<SysUser>(SqlConnection, CommandType.Text,
                "SELECT * FROM SysGroupMenu WHERE GroupId = @GroupId AND MenuId=@MenuId", parameters.ToArray());
        }

        public int Update(int Id, int groupId, int functionId, int usedState, int orders, int createdBy, DateTime createdDate, int? modifiedBy, DateTime? modifiedDate)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysGroupMenu_Update"), Id, groupId, functionId, usedState, orders, createdBy, createdDate, CommonHelper.Null.GetNull(modifiedBy), CommonHelper.Null.GetNull(modifiedDate));
        }
        public int Delete(int id)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@Id", id));

            return
                (int)
                    SqlHelper.ExecuteScalar(SqlConnection, CommandType.Text, "DELETE  FROM SysGroupMenu WHERE Id = @Id SELECT @@RowCount",
                        parameters.ToArray());
        }
        public List<SysGroupMenu> GetViewFunctionByUserId(int userId, int Id, int? usedState, ref int totalRows)
        {
            var objRef = new object[4];
            objRef[0] = userId;
            objRef[1] = Id;
            objRef[2] = usedState;
            objRef[3] = totalRows;
            List<SysGroupMenu> ls = SqlHelper.ExecuteList<SysGroupMenu>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("sp_GetViewFunctionByUserId"), ref objRef);
            totalRows = Convert.ToInt32(objRef[3]);
            return ls;
        }
    }
}
