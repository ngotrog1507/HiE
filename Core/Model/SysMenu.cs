using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Ultity;

namespace Core.Model
{
    public class SysMenu : Entity
    {
        public string Link { get; set; }

        public int? ParentId { get; set; }

        public string Name { get; set; }

        public string Icon { get; set; }
        public string MenuName { get; set; }
        public string GroupName { get; set; }
        public int GroupId { get; set; }
        public int MenuId { get; set; }
        public int Choosed { get; set; }

    }
}
