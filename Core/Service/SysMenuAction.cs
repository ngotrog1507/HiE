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
    public class SysMenuAction
    {
        public readonly string SqlConnection =
       ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
           .ConnectionString;
        public SysMenu GetById(int id)
        {
            return SqlHelper.ExecuteTObject<SysMenu>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysMenu_GetById"), id);
        }

        public List<SysMenu> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<SysMenu>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysMenu_List_Paging"), ref objRef);
        }

        public List<SysMenu> List(string sWhere, string sOrder, int fromRow, int toRow)
        {
            return SqlHelper.ExecuteList<SysMenu>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysMenu_List"), sWhere, sOrder, fromRow, toRow);
        }
        public List<SysMenu> ListRecursive(int iParentId, int iMenuId, int usedState)
        {
            return SqlHelper.ExecuteList<SysMenu>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysMenu_List_Recursive"), iParentId, iMenuId, usedState);
        }
        public int ListCount(string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysMenu_ListCount"), sWhere);
        }

        public int Insert(string link, int? parentId, string name, string icon, int orders, int usedState, int? createdBy, DateTime createdDate, DateTime? modifiedDate, int? modifiedBy)
        {
            var deciResult = SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysMenu_Insert")
                , CommonHelper.Null.GetNull(link), CommonHelper.Null.GetNull(parentId)
                , CommonHelper.Null.GetNull(name), CommonHelper.Null.GetNull(icon), orders, usedState,

               createdBy, createdDate,
                CommonHelper.Null.GetNull(modifiedDate), CommonHelper.Null.GetNull(modifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }

        public int Update(int id, string link, int? parentId, string name, string icon, int orders, int usedState, int? createdBy, DateTime createdDate, DateTime? modifiedDate, int? modifiedBy)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysMenu_Update")
                 , id, CommonHelper.Null.GetNull(link), CommonHelper.Null.GetNull(parentId)
                , CommonHelper.Null.GetNull(name), CommonHelper.Null.GetNull(icon), orders, usedState,
              createdBy, createdDate,
                CommonHelper.Null.GetNull(modifiedDate), CommonHelper.Null.GetNull(modifiedBy));
        }

        public List<SysMenu> GetMenuByUserId(int userId)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@UserId", userId));
            string sql = @"SELECT *
                            FROM SysMenu
                            WHERE Id IN
                                (SELECT DISTINCT MenuId
                                 FROM SysGroupMenu
                                 WHERE GroupId IN
                                     (SELECT DISTINCT GroupId
                                      FROM SysGroupUser
                                      WHERE UserId=@UserId)
                                   AND RoleId=" + Ultity.Ultity.Constant.View + ") AND UsedState=1";

            return SqlHelper.ExecuteList<SysMenu>(SqlConnection, CommandType.Text, sql, parameters.ToArray());
        }
        public int Delete(string id)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysMenu_Delete"), id);
        }

    }
}
