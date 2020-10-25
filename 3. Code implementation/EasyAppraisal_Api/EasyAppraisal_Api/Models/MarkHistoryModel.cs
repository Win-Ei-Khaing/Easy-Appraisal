using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Threading.Tasks;

namespace EasyAppraisal_Api.Models
{
    public class MarkHistoryModel
    {
        public int MarkHistoryID { get; set; }
        public int UserID { get; set; }
        public int Mark { get; set; }
        public int GivenBy { get; set; }
        public DateTime GivenOn { get; set; }
        public string UserCode { get; set; }
    }
}
