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
    public class UserMarkDAO : IUserMarkDAO
    {
        public ResponseModel GetOwnedMark(string userCode)
        {
            ResponseModel result = new ResponseModel();
            try
            {
                SqlCommand scom = new SqlCommand(" SELECT *, " +
                    "(SELECT COUNT(DISTINCT GivenOn) FROM tblMarkHistory WHERE GivenBy=[dbo].[GetUserIDByCode]('" + userCode + "')) AS PreviousAppraisalCount, " +
                    "dbo.GetUserNameById(UserID) AS UserName, dbo.GetCategoryNameById(CategoryID) AS CategoryName  " +
                    "FROM tblUserMark WHERE UserID = [dbo].[GetUserIDByCode]('" + userCode + "'); ", SQLDbConnecter.Connect());
                scom.CommandType = CommandType.Text;
                DataSet ds = new DataSet();
                SqlDataAdapter adapter = new SqlDataAdapter(scom);
                adapter.Fill(ds);
                if (ds.Tables[0].Rows.Count >= 1)
                {
                    result.ResponseCode = 0;
                    result.ResponseAppraisalCount = Convert.ToInt32(ds.Tables[0].Rows[0]["PreviousAppraisalCount"]);
                    List <UserMarkModel> lstUserMark = new List<UserMarkModel>();
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        UserMarkModel usermark = new UserMarkModel();
                        usermark.UserMarkID = Convert.ToInt32(ds.Tables[0].Rows[i]["UserMarkID"]);
                        usermark.UserID = Convert.ToInt32(ds.Tables[0].Rows[i]["UserID"]);
                        usermark.CategoryID = Convert.ToInt32(ds.Tables[0].Rows[i]["CategoryID"]);
                        usermark.Mark = Convert.ToDecimal(ds.Tables[0].Rows[i]["Mark"]);
                        usermark.UserName = Convert.ToString(ds.Tables[0].Rows[i]["UserName"]);
                        usermark.CategoryName = Convert.ToString(ds.Tables[0].Rows[i]["CategoryName"]);

                        lstUserMark.Add(usermark);
                    }
                    result.ResponseUserMarkModel = lstUserMark;
                }
                else
                {
                    result.ResponseCode = 1;
                    result.ResponseMessage = "No data for this user";
                }
            }
            catch (Exception e)
            {
                result.ResponseCode = 2;
                result.ResponseMessage = e.Message;
            }
            return result;
        }
        public ResponseModel GetLatestSummary()
        {
            ResponseModel result = new ResponseModel();
            try
            {
                LatestSummaryModel latestSummary = new LatestSummaryModel();
                //collect all categories
                SqlCommand scomCategories = new SqlCommand("SELECT CategoryID, dbo.GetCategoryNameById(CategoryID) AS CategoryName FROM tblCategory WITH (NOLOCK) ORDER BY CategoryID; ", SQLDbConnecter.Connect());
                scomCategories.CommandType = CommandType.Text;
                DataSet dsCategories = new DataSet();
                SqlDataAdapter adapterCategories = new SqlDataAdapter(scomCategories);
                adapterCategories.Fill(dsCategories);
                if (dsCategories.Tables[0].Rows.Count >= 1)
                {
                    List<string> lstCategoryNames = new List<string>();
                    for (int i = 0; i < dsCategories.Tables[0].Rows.Count; i++)
                    {
                        var categoryName = Convert.ToString(dsCategories.Tables[0].Rows[i]["CategoryName"]);
                        lstCategoryNames.Add(categoryName);
                    }
                    latestSummary.CategoryNames = lstCategoryNames;

                    //collect all users'marks related to each category
                    List<List<string>> lstSummaryUserMarks = new List<List<string>>();

                    SqlCommand scomUserMarks = new SqlCommand("SELECT dbo.GetUserNameById(um.UserID) AS UserName, dbo.GetCategoryNameById(um.CategoryID) AS CategoryName,  um.Mark, " +
                        "dbo.GetPositionById(um.UserID) AS Position, " +
                        "(SELECT COUNT(DISTINCT GivenOn) FROM tblMarkHistory WHERE GivenBy = um.UserID) AS PreviousAppraisalCount " +
                        "FROM tblUserMark um WITH(NOLOCK) ORDER BY UserID, CategoryID; ", SQLDbConnecter.Connect());
                    scomUserMarks.CommandType = CommandType.Text;
                    DataSet dsUserMarks = new DataSet();
                    SqlDataAdapter adapterUserMarks = new SqlDataAdapter(scomUserMarks);
                    adapterUserMarks.Fill(dsUserMarks);
                    int sn = 1;
                    if (dsUserMarks.Tables[0].Rows.Count >= 1)
                    {
                        result.ResponseCode = 0;
                        for (int i = 0; i < dsUserMarks.Tables[0].Rows.Count; i++)
                        {
                            List<string> userMarkData = new List<string>();

                            userMarkData.Add(Convert.ToString(sn));
                            sn++;
                            var userName = Convert.ToString(dsUserMarks.Tables[0].Rows[i]["UserName"]);
                            userMarkData.Add(userName);
                            var position = Convert.ToString(dsUserMarks.Tables[0].Rows[i]["Position"]);
                            userMarkData.Add(position);
                            var previousAppraisalCount = Convert.ToString(dsUserMarks.Tables[0].Rows[i]["PreviousAppraisalCount"]);
                            userMarkData.Add(previousAppraisalCount);
                            for (int j = 0; j < lstCategoryNames.Count; j++)
                            {
                                var mark = Convert.ToString(dsUserMarks.Tables[0].Rows[i+j]["Mark"]);
                                userMarkData.Add(mark);
                            }

                            i += lstCategoryNames.Count - 1;
                            lstSummaryUserMarks.Add(userMarkData);
                        }
                    }
                    else
                        result.ResponseCode = 1;

                    latestSummary.UserMarks = lstSummaryUserMarks;

                    result.ResponseLatestSummaryModel = latestSummary;
                }
                else
                    result.ResponseCode = 1;

                if (result.ResponseCode != 0)
                    result.ResponseMessage = "Something wrong in retrieving data";
            }
            catch (Exception e)
            {
                result.ResponseCode = 2;
                result.ResponseMessage = e.Message;
            }
            return result;
        }
        public ResponseModel StartForAppraisal(DateTime givenOn, string userCode)
        {
            ResponseModel result = new ResponseModel();
            try
            {
                LatestSummaryModel latestSummary = new LatestSummaryModel();
                //collect all categories
                SqlCommand scomCategories = new SqlCommand("SELECT dbo.GetCategoryNameById(CategoryID) AS CategoryName FROM tblCategory WITH (NOLOCK) ORDER BY CategoryID; ", SQLDbConnecter.Connect());
                scomCategories.CommandType = CommandType.Text;
                DataSet dsCategories = new DataSet();
                SqlDataAdapter adapterCategories = new SqlDataAdapter(scomCategories);
                adapterCategories.Fill(dsCategories);
                if (dsCategories.Tables[0].Rows.Count >= 1)
                {
                    List<int> lstCategories = new List<int>();
                    List<string> lstCategoryNames = new List<string>();
                    for (int i = 0; i < dsCategories.Tables[0].Rows.Count; i++)
                    {
                        var categoryName = Convert.ToString(dsCategories.Tables[0].Rows[i]["CategoryName"]);
                        lstCategoryNames.Add(categoryName);
                    }
                    latestSummary.CategoryNames = lstCategoryNames;

                    //collect all users'marks related to each category
                    List<List<string>> lstUsers = new List<List<string>>();

                    SqlCommand scomUsers = new SqlCommand("SELECT UserID, dbo.GetUserNameById(UserID) AS UserName FROM tblUserMark WITH (NOLOCK) WHERE UserID<>ISNULL([dbo].[GetUserIDByCode]('" + userCode+"'), 0) GROUP BY UserID; ", SQLDbConnecter.Connect());
                    scomUsers.CommandType = CommandType.Text;
                    DataSet dsUsers = new DataSet();
                    SqlDataAdapter adapterUsers = new SqlDataAdapter(scomUsers);
                    adapterUsers.Fill(dsUsers);
                    if (dsUsers.Tables[0].Rows.Count >= 1)
                    {
                        result.ResponseCode = 0;
                        for (int i = 0; i < dsUsers.Tables[0].Rows.Count; i++)
                        {
                            List<string> userData = new List<string>();

                            var userId = Convert.ToString(dsUsers.Tables[0].Rows[i]["UserID"]);
                            userData.Add(userId);
                            var userName = Convert.ToString(dsUsers.Tables[0].Rows[i]["UserName"]);
                            userData.Add(userName);
                            for (int j = 0; j < lstCategoryNames.Count; j++)
                            {
                                userData.Add("0");
                            }
                            lstUsers.Add(userData);
                        }
                    }
                    else
                        result.ResponseCode = 1;

                    latestSummary.UserMarks = lstUsers;

                    result.ResponseLatestSummaryModel = latestSummary;
                }
                else
                    result.ResponseCode = 1;

                if (result.ResponseCode != 0)
                    result.ResponseMessage = "Something wrong in retrieving data";
            }
            catch (Exception e)
            {
                result.ResponseCode = 2;
                result.ResponseMessage = e.Message;
            }
            return result;
        }

        public ResponseModel SaveAppraisal(RequestModel request)
        {
            SqlConnection con = SQLDbConnecter.Connect();
            con.Close();
            ResponseModel result = new ResponseModel();
            try
            {
                con.Open();
                var oTransaction = con.BeginTransaction();
                //get all categories
                SqlCommand scomCategories = new SqlCommand("SELECT CategoryID FROM tblCategory WITH (NOLOCK) ORDER BY CategoryID; ", con);
                scomCategories.CommandType = CommandType.Text;
                scomCategories.Transaction=oTransaction;
                DataSet dsCategories = new DataSet();
                SqlDataAdapter adapterCategories = new SqlDataAdapter(scomCategories);
                adapterCategories.Fill(dsCategories);
                if (dsCategories.Tables[0].Rows.Count >= 1)
                {
                    List<int> lstCategories = new List<int>();
                    for (int i = 0; i < dsCategories.Tables[0].Rows.Count; i++)
                    {
                        var categoryId = Convert.ToInt32(dsCategories.Tables[0].Rows[i]["CategoryID"]);
                        lstCategories.Add(categoryId);
                    }

                    //insert mark histoy
                    DateTime giveOnDateTime = request.GivenOn;
                    string giveOnSqlDateTime = giveOnDateTime.ToString("yyyy-MM-dd HH:mm");
                    string sqlInsertString = "";
                    for (int i = 0; i < request.UserMarkData.Count; i++)
                    {
                        List<string> userMark = request.UserMarkData[i];
                        var userID = userMark[0];
                        for (int j = 0; j < lstCategories.Count; j++)
                        {
                            var categoryID = lstCategories[j];
                            var mark = userMark[j+1];
                            sqlInsertString += "INSERT INTO tblMarkHistory VALUES ("+ userID + "," +categoryID+ ","+mark+ ", [dbo].[GetUserIDByCode]('" + request.GivenBy + "'),'" + giveOnSqlDateTime + "');";
                       
                        }
                    }
                    var totalCount = request.UserMarkData.Count * lstCategories.Count;
                    SqlCommand scomMarkHistory = new SqlCommand(sqlInsertString, con);
                    scomMarkHistory.CommandType = CommandType.Text;
                    scomMarkHistory.Transaction = oTransaction;
                    var insertedHistoryCount = scomMarkHistory.ExecuteNonQuery();

                    if(insertedHistoryCount == totalCount)
                    {
                        //update user mark
                        string sqlUpdateString = "";
                        for (int i = 0; i < request.UserMarkData.Count; i++)
                        {
                            List<string> userMark = request.UserMarkData[i];
                            var userID = userMark[0];
                            for (int j = 0; j < lstCategories.Count; j++)
                            {
                                var categoryID = lstCategories[j];
                                var mark = userMark[j + 1];
                                sqlUpdateString += "UPDATE tblUserMark SET Mark+="+mark+" WHERE UserID="+userID+" AND CategoryID="+categoryID+";";

                            }
                        }
                        SqlCommand scomUserData = new SqlCommand(sqlUpdateString, con);
                        scomUserData.CommandType = CommandType.Text;
                        scomUserData.Transaction = oTransaction;
                        var updatedHistoryCount = scomUserData.ExecuteNonQuery();

                        if(updatedHistoryCount == totalCount)
                            result.ResponseCode = 0;
                        else
                            result.ResponseCode = 1;
                    }
                    else
                        result.ResponseCode = 1;
                }
                else
                    result.ResponseCode = 1;

                if (result.ResponseCode != 0)
                {
                    oTransaction.Rollback();
                    result.ResponseMessage = "Something wrong in retrieving data";
                }
                else
                {
                    oTransaction.Commit();
                    result.ResponseMessage = "Successfully saved";
                }
            }
            catch (Exception e)
            {
                result.ResponseCode = 2;
                result.ResponseMessage = e.Message;
            }
            return result;
        }
    }
}
