using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EasyAppraisal_Api.Models
{
    public class ResponseModel
    {
        public int ResponseCode { get; set; }
        public string ResponseMessage { get; set; }
        public List<UserMarkModel> ResponseUserMarkModel { get; set; }
        public LatestSummaryModel ResponseLatestSummaryModel { get; set; }
    }
}
