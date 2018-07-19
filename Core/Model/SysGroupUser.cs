using System;
using System.Collections.Generic;
using Core.Ultity;

namespace Core.Model
{
    public class SysGroupUser : Entity
    {
        public int GroupId { get; set; }

        public int UserId { get; set; }

        public string GroupName { get; set; }
        public List<SysUser> ListUser { get; set; }
        //public int? UsedState { get; set; }

        //public DateTime? CreatedDate { get; set; }

        //public int? CreatedBy { get; set; }

        //public DateTime? ModifiedDate { get; set; }

        //public int? ModifiedBy { get; set; }
    }
}