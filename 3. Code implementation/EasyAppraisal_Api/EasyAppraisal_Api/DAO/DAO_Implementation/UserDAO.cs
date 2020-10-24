
using EasyAppraisal_Api.DAO.DAO_Interface;
using EasyAppraisal_Api.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace EasyAppraisal_Api.DAO.DAO_Implementation
{
    public class UserDAO : IUserDAO
    {
        public ResponseModel Login(string userCode, string password)
        {
            ResponseModel result = new ResponseModel();
            try
            {
                SqlCommand scom = new SqlCommand(" SELECT * FROM tblUser WITH (NOLOCK) WHERE UserCode='" + userCode + "' AND Password='" + password + "'; ", SQLDbConnecter.Connect());
                scom.CommandType = CommandType.Text;
                DataSet ds = new DataSet();
                SqlDataAdapter adapter = new SqlDataAdapter(scom);
                adapter.Fill(ds);
                if (ds.Tables[0].Rows.Count == 1)
                {
                    result.ResponseCode = 0;
                    result.ResponseMessage = Convert.ToString(ds.Tables[0].Rows[0]["Position"]);
                }
                else
                {
                    result.ResponseCode = 1;
                    result.ResponseMessage = "Invalid User Code or Password";
                }
            }
            catch(Exception e)
            {
                result.ResponseCode = 2;
                result.ResponseMessage = e.Message;
            }
            return result;
        }
    }
}
