using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EasyAppraisal_Api.Models
{
    public class UserMarkModel
    {
        public int UserMarkID { get; set; }
        public int UserID { get; set; }
        public int CategoryID { get; set; }
        public decimal Mark { get; set; }
        public string UserName { get; set; }
        public string CategoryName { get; set; }
    }
}
