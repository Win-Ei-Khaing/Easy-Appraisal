using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EasyAppraisal_Api.DAO.DAO_Interface;
using Microsoft.AspNetCore.Mvc;
using EasyAppraisal_Api.Models;

namespace EasyAppraisal_Api.Controllers
{
    [Route("api/[controller]/[Action]")]
    [ApiController]
    public class LoginController : Controller
    {
        private readonly IUserDAO userDAO;
        public LoginController(IUserDAO userDAO)
        {
            this.userDAO = userDAO;
        }

        [HttpPost]
        public ResponseModel Login([FromForm] UserModel user)
        {
            return userDAO.Login(user.UserCode, user.Password);
        }
    }
}
