using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EasyAppraisal_Api.Models
{
    public class RequestModel
    {
        public DateTime GivenOn { get; set; }
        public string GivenBy { get; set; }
        public List<List<string>> UserMarkData { get; set; }
    }
}
