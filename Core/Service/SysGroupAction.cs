using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using Core.Model;
using Framework;

namespace Core.Service
{
    public class SysGroupAction
    {
        public readonly string SqlConnection =
         ConfigurationManager.ConnectionStrings[ConstantGlobalization.Constant.HarCode.ConnectionString]
             .ConnectionString;

        public SysGroup GetById(int groupId)
        {
            return SqlHelper.ExecuteTObject<SysGroup>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysGroup_GetById"), groupId);
        }

        public List<SysGroup> GetGroupByUserId(int userId)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@UserId", userId));
            string sql = "SELECT b.* FROM SysGroupUser a";
            sql += "LEFT JOIN SysGroup b ON b.Id=a.GroupId   WHERE a.UserId=@UserId AND b.UsedState=1 ";
            return SqlHelper.ExecuteList<SysGroup>(SqlConnection, CommandType.Text, sql, parameters.ToArray());
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
        /// <param name="objRef">Value PageSize is 0 query select all record</param>
        /// <returns></returns>
        public List<SysGroup> List(ref object[] objRef)
        {
            return SqlHelper.ExecuteList<SysGroup>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysGroup_List_Reference"), ref objRef);
        }

        public List<SysGroup> List(string sWhere, string sOrder, int fromRow, int toRow)
        {
            return SqlHelper.ExecuteList<SysGroup>(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysGroup_List"), sWhere, sOrder, fromRow, toRow);
        }

        public int ListCount(string sWhere)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysGroup_ListCount"), sWhere);
        }

        public int Insert(string name, string summary, int usedState, DateTime createdDate, int createdBy, DateTime? modifiedDate, int? modifiedBy)
        {
            var deciResult = (decimal)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysGroup_Insert"), name, CommonHelper.Null.GetNull(summary), usedState, createdDate, createdBy, CommonHelper.Null.GetNull(modifiedDate), CommonHelper.Null.GetNull(modifiedBy));
            return CommonHelper.Convert.ConvertToInt32(deciResult);
        }


        public int Update(int groupId, string name, string summary, int usedState,  DateTime createdDate, int createdBy, DateTime? modifiedDate, int? modifiedBy)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysGroup_Update"), groupId, name, CommonHelper.Null.GetNull(summary), usedState, createdDate, createdBy, CommonHelper.Null.GetNull(modifiedDate), CommonHelper.Null.GetNull(modifiedBy));
        }

        public int Delete(int groupId)
        {
            return (int)SqlHelper.ExecuteScalar(SqlConnection, CommonHelper.Config.GetFullyQualifiedName("SysGroup_Delete"), groupId);
        }

        public List<SysUser> GetUserInGroup(int groupId, string name)
        {
            var obj = new object[2];
            obj[0] = groupId;
            obj[1] = name;

            return SqlHelper.ExecuteList<SysUser>(SqlConnection,
               CommonHelper.Config.GetFullyQualifiedName("SysGroupUser_GetUserInGroup"), ref obj);
        }
        public List<SysUser> GetUserNotInGroup(int groupId, string name)
        {
            var obj = new object[2];
            obj[0] = groupId;
            obj[1] = name;

            return SqlHelper.ExecuteList<SysUser>(SqlConnection,
               CommonHelper.Config.GetFullyQualifiedName("SysGroupUser_GetUserNotInGroup"), ref obj);
        }
        public List<SelectListItem > GetGroupValueSelected(int valueSelected)
        {
            var list = new List<SelectListItem>();
            //try
            //{
            #region GetUnit

            var objRef = new object[5];
            objRef[0] = string.Concat(" a.UsedState = ", CommonHelper.Convert.ConvertToInt32((int)ConstantGlobalization.Enum.UsedState.Enable));
            objRef[1] = "a.Orders ASC";
            objRef[2] = 0;
            objRef[3] = 500;
            objRef[4] = 0;
            var models = new SysGroupAction().List(ref objRef);
            var Item = new SelectListItem
            {
                Text = "------- Selected Item -------",
                Value = "0",
                Selected = false
            };
            list.Add(Item);
            for (int i = 0; i < models.Count; i++)
            {
                bool isSelected = (CommonHelper.Convert.ConvertToInt32(models[i].Id).Equals(valueSelected));
                var selectListItem = new SelectListItem
                {
                    Text = models[i].Name,
                    Value = CommonHelper.Convert.ConvertToString(models[i].Id),
                    Selected = isSelected
                };
                list.Add(selectListItem);
            }

            #endregion GetUnit
            //}
            //catch (Exception exception)
            //{
            //    TFunction.WriteToLog(exception);
            //}
            return list;
        }
    }

}
