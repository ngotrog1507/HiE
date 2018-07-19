using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Ultity
{
    public abstract class Entity
    {
        public virtual int Id { get; set; }

        //trongnv -- create abstract implement object other
        public virtual string CreatedByName { get; set; }
        public virtual int Orders { get; set; }

        public virtual int UsedState { get; set; }

        public virtual DateTime? CreatedDate { get; set; }

        public virtual int? CreatedBy { get; set; }
        public virtual string FullName { get; set; }

        public virtual DateTime? ModifiedDate { get; set; }

        public virtual int? ModifiedBy { get; set; }
    }
}
