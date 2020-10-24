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
                SqlCommand scom = new SqlCommand(" SELECT *, dbo.GetUserNameById(UserID) AS UserName, dbo.GetCategoryNameById(CategoryID) AS CategoryName  FROM tblUserMark WHERE UserID = [dbo].[GetUserIDByCode]('" + userCode + "'); ", SQLDbConnecter.Connect());
                scom.CommandType = CommandType.Text;
                DataSet ds = new DataSet();
                SqlDataAdapter adapter = new SqlDataAdapter(scom);
                adapter.Fill(ds);
                if (ds.Tables[0].Rows.Count >= 1)
                {
                    result.ResponseCode = 0;
                    List<UserMarkModel> lstUserMark = new List<UserMarkModel>();
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
                    List<int> lstCategories = new List<int>();
                    List<string> lstCategoryNames = new List<string>();
                    for (int i = 0; i < dsCategories.Tables[0].Rows.Count; i++)
                    {
                        var categoryID = Convert.ToInt32(dsCategories.Tables[0].Rows[i]["CategoryID"]);
                        lstCategories.Add(categoryID);
                        var categoryName = Convert.ToString(dsCategories.Tables[0].Rows[i]["CategoryName"]);
                        lstCategoryNames.Add(categoryName);
                    }
                    latestSummary.CategoryNames = lstCategoryNames;

                    //collect all users'marks related to each category
                    List<List<string>> lstSummaryUserMarks = new List<List<string>>();

                    SqlCommand scomUserMarks = new SqlCommand("SELECT dbo.GetUserNameById(UserID) AS UserName, dbo.GetCategoryNameById(CategoryID) AS CategoryName,  Mark FROM tblUserMark WITH (NOLOCK) ORDER BY UserID, CategoryID;", SQLDbConnecter.Connect());
                    scomUserMarks.CommandType = CommandType.Text;
                    DataSet dsUserMarks = new DataSet();
                    SqlDataAdapter adapterUserMarks = new SqlDataAdapter(scomUserMarks);
                    adapterUserMarks.Fill(dsUserMarks);
                    int sn = 1;
                    if (dsUserMarks.Tables[0].Rows.Count >= 1)
                    {
                        for (int i = 0; i < dsUserMarks.Tables[0].Rows.Count; i++)
                        {
                            List<string> userMarkData = new List<string>();

                            userMarkData.Add(Convert.ToString(sn));
                            sn++;
                            var userName = Convert.ToString(dsUserMarks.Tables[0].Rows[i]["UserName"]);
                            userMarkData.Add(userName);
                            for (int j = 0; j < lstCategories.Count; j++)
                            {
                                var mark = Convert.ToString(dsUserMarks.Tables[0].Rows[i]["Mark"]);
                                userMarkData.Add(mark);
                            }

                            i += lstCategories.Count - 1;
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
    }
}
