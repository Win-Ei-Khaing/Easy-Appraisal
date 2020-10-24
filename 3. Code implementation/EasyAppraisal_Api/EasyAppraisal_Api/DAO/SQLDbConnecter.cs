using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace EasyAppraisal_Api.DAO
{
    public class SQLDbConnecter
    {
        private static SqlConnection cnn = null;
        public static SqlConnection Connect()
        {
            string connectionString = null;
            connectionString = @"Data Source=ETAG\MSSQLSERVER01;Initial Catalog=EasyAppraisalDb;Integrated Security=True";
            try
            {
                if (cnn == null)
                {
                    cnn = new SqlConnection(connectionString);
                }
                if (cnn.State != ConnectionState.Open)
                {
                    cnn.Open();
                }
                return cnn;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
