using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Summary description for Bisiness
/// </summary>
public class Bisiness
{
	public Bisiness()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static bool Checklogin(string EmployeeID)
    {
        //string connString = ConfigurationManager.ConnectionStrings["DeltaTmsConnectionString"];
        string connString = ConfigurationManager.ConnectionStrings["DeltaTmsConnectionString"].ToString();
        SqlConnection con = new SqlConnection(connString);
        SqlDataAdapter da = new SqlDataAdapter("select empcode from employee  where userName ='" + EmployeeID + "'", con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            return true;

        }
        else
        {
            return false;
        }
    }
}
