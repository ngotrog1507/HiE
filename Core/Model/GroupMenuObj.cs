using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Ultity;

namespace Core.Model
{
    public class GroupMenuObj : Entity
    {
        public int GroupId { get; set; }
        public int MenuId { get; set; }
        public int RoleView { get; set; }
        public int RoleEdit { get; set; }
        public int RoleAdd { get; set; }
        public int RoleDelete { get; set; }
        public int RoleAccept { get; set; }
        public int RoleExport { get; set; }
        public int RoleAdmin { get; set; }
        public string Link { get; set; }
        public string MenuName { get; set; }
        public string GroupName { get; set; }
    }
}
