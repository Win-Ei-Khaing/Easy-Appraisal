using EasyAppraisal_Api.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EasyAppraisal_Api.DAO.DAO_Interface
{
    public interface IUserDAO
    {
        ResponseModel Login(string userCode, string password);
    }
}
