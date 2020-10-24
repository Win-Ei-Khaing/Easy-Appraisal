using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EasyAppraisal_Api.Models
{
    public class LatestSummaryModel
    {
        public List<string> CategoryNames { get; set; }
        public List<List<string>> UserMarks { get; set; }
    }
}
