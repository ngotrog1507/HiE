using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Ultity;

namespace Core.Model
{
    public class SysGroupMenu : Entity
    {
        public int GroupId { get; set; }
        public string GroupName { get; set; }
        public int MenuId { get; set; }
        public string MenuName { get; set; }
        public int RoleId { get; set; }
        public string RoleName { get; set; }
    }
}
