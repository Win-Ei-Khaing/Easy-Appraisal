using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EasyAppraisal_Api.Models
{
    public class UserModel
    {
        public int UserID { get; set; }
        public string UserCode { get; set; }
        public string UserName { get; set; }
        public string Position { get; set; }
        public string Password { get; set; }
    }
}
