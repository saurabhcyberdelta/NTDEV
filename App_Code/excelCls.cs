using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.OleDb;
using System.Data;

/// <summary>
/// Summary description for excelCls
/// </summary>
public class excelCls
{
	public excelCls()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public string[] GetExcelSheetNames(string excelFile)
    {
        string sheetName = null;
        OleDbConnection objConn = null;
        System.Data.DataTable dt = null;
        try
        {
            string connString = "Provider=Microsoft.Jet.OLEDB.4.0;" + "Data Source=" + excelFile + ";Extended Properties=Excel 8.0;";
            objConn = new OleDbConnection(connString);
            objConn.Open();
            dt = objConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            if (dt == null)
            {
                return null;
            }
            string[] excelSheets = new string[dt.Rows.Count + 1];
            int i = 0;
            foreach (DataRow row in dt.Rows)
            {
                excelSheets[i] = row["TABLE_NAME"].ToString();
                sheetName = excelSheets[0];
                System.Math.Min(System.Threading.Interlocked.Increment(ref i), i - 1);
            }
            int j = 0;
            while (j < excelSheets.Length)
            {
                System.Math.Min(System.Threading.Interlocked.Increment(ref j), j - 1);
            }
            return excelSheets;
            //'Return sheetName
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
           
            return null;
        }
        finally
        {
            if ((objConn != null))
            {
                objConn.Close();
                objConn.Dispose();
            }
            if ((dt != null))
            {
                dt.Dispose();
            }
        }

    }

}
