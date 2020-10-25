using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EasyAppraisal_Api.DAO.DAO_Interface;
using EasyAppraisal_Api.Models;
using Microsoft.AspNetCore.Mvc;

namespace EasyAppraisal_Api.Controllers
{
    [Route("api/[controller]/[Action]")]
    [ApiController]
    public class UserMarkController : Controller
    {
        private readonly IUserMarkDAO userMarkDAO;
        public UserMarkController(IUserMarkDAO userMarkDAO)
        {
            this.userMarkDAO = userMarkDAO;
        }
        [HttpPost]
        public ResponseModel GetOwnedMark([FromForm] UserModel user)
        {
            return userMarkDAO.GetOwnedMark(user.UserCode);
        }

        [HttpGet]
        public ResponseModel GetLatestSummary()
        {
            return userMarkDAO.GetLatestSummary();
        }

        [HttpPost]
        public ResponseModel StartForAppraisal([FromForm] MarkHistoryModel markHistory)
        {
            return userMarkDAO.StartForAppraisal(markHistory.GivenOn, markHistory.UserCode);
        }

        [HttpPost]
        public ResponseModel SaveAppraisal([FromForm] RequestModel request)
        {
            return userMarkDAO.SaveAppraisal(request);
        }
    }
}
