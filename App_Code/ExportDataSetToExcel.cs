using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

/// <summary>
/// Summary description for ExportDataSetToExcel
/// </summary>
public static class ExportDataSetToExcel
{

    public static void ExportToExcel(DataSet ds, string filename)
    {
        //*************************************
        //creates object of stringwriter and htmltextwriter
        //reads the dataset and exports the data items to an excel file
        //*************************************
        try
        {
            HttpResponse response = HttpContext.Current.Response;
            response.Clear();
            response.Charset = string.Empty;
            response.ContentType = "application/vnd.ms-excel";
            response.AddHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {
                    DataGrid dg = new DataGrid();
                    dg.DataSource = ds.Tables[0];
                    dg.DataBind();
                    dg.RenderControl(htw);
                    response.Write(sw.ToString());
                    //HttpContext.Current.ApplicationInstance.CompleteRequest();
                    response.End();
                }
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            //throw ex;
        }

    }
}
