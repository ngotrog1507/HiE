using Framework;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Mvc;
using Core.Model;
using Core.Service;
using Core.Ultity;
using WebMatrix.WebData;

namespace HiSchool.Models
{
    public class Menu
    {
        public static bool CheckExitsInList(List<int> lst, int id)
        {
            foreach (var item in lst)
            {
                if (item == id)
                {
                    return false;
                }
            }
            return true;
        }
        public static string GetChildrenMenu(List<SysMenu> lst, int id)
        {
            var result = string.Empty;
            var lstM = lst.Where(o => o.ParentId == id).ToList();
            foreach (var item in lstM)
            {
                result = result + " <li id='menu_"+ item.Link.Split(new[] { "System/" }, StringSplitOptions.None)[1] + "'>";
                var checkChildren = lst.Where(x => x.ParentId == item.Id).ToList();
                if (checkChildren.Count > 0 && checkChildren != null)
                {
                    result = result + "     <a href = '" + item.Link + "' class='dropdown-toggle' >";
                    result = result + "     <i class='fa fa-circle-o'></i>";
                    result = result + item.Name;
                    result = result + "     <span class='pull-right-container'>";
                    result = result + "        <i class='fa fa-angle-left pull-right'></i>";
                    result = result + "       </span>";
                    result = result + "     </a>";
                    result = result + "<ul class='treeview-menu'>";
                    result = result + GetChildrenMenu(lst, item.Id);
                    result = result + "</ul>";
                }
                else
                {
                    result = result + "     <a href = '" + item.Link + "' >";
                    result = result + "     <i class='fa fa-circle-o'></i>";
                    result = result + item.Name;
                    result = result + "     </a>";
                }
                result = result + "</li>";
                //if (lst.Where(o => o.ParentId == item.Id).ToList().Count > 0)
                //{
                //    result = result + GetChildrenMenu(lst, item.Id);
                //}
            }
            return result;
        }
        public class _OBJ
        {
            public int ID { get; set; }
            public int ParentID { get; set; }
        }
        public static string GetMenu()
        {
            string result = string.Empty;
            var functionModel = new List<SysMenu>();
            int userId = WebSecurity.CurrentUserId;
            if (userId > 0)
            {
                if (AuthorizeUser.IsHost())
                {
                    var objRef = new object[5];
                    objRef[0] = " a.UsedState="+Ultity.Constant.Active;
                    objRef[1] = string.Empty;
                    objRef[2] = 0;
                    objRef[3] = 100;
                    objRef[4] = 0;
                    functionModel = new SysMenuAction().List(ref objRef);
                }
                else
                {
                    //Kiem tra xem User thuoc nhung Group nao
                    #region Not Host =find Function Id by UserId
                    functionModel = new SysMenuAction().GetMenuByUserId(userId);
                    #endregion
                }
            }
            if (functionModel != null && functionModel.Count > 0)
            {
                var functionlParentNull = functionModel.Where(o => o.ParentId == null).OrderBy(o => o.Orders).ToList();
                foreach (var item in functionlParentNull)
                {
                    var checkChildren = functionModel.Where(x => x.ParentId == item.Id).ToList();
                    if (checkChildren.Count > 0 && checkChildren != null)
                    {
                        result = result + " <li class='treeview'> <a href = '"+ item .Link+ "' >";

                        result = result + "<i class='" + item.Icon + "'></i>";
                        result = result + "<span> " + item.Name + "</span>";

                        result = result + "<span class='pull-right-container'>";
                        result = result + "      <i class='fa fa-angle-left pull-right'></i>";
                        result = result + "</span>";
                        result = result + "</a>";
                        result = result + "<ul class='treeview-menu'>";
                        result = result + GetChildrenMenu(functionModel, item.Id);
                        result = result + "</ul>";
                        result = result + "</li>";
                    }
                    else
                    {
                        result = result + " <li> <a href = '" + item.Link + "' >";

                        result = result + "<i class='" + item.Icon + "'></i>";
                        result = result + "<span> " + item.Name + "</span>";
                        result = result + "</a>";

                        result = result + "<b class='arrow'></b>";
                        result = result + "</li>";
                    }
                }
            }

            return result;
        }
    }
}