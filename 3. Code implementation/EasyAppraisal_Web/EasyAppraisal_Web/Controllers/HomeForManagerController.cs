using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace EasyAppraisal_Web.Controllers
{
    public class HomeForManagerController : Controller
    {
        public IActionResult Index(string userCode)
        {
            if (userCode != null)
            {
                HttpContext.Session.SetString("UserCode", userCode);
                HttpContext.Session.SetString("Position", "Manager");
            }
            return View();
        }

        public IActionResult LatestSummary()
        {
            return View();
        }
    }
}
