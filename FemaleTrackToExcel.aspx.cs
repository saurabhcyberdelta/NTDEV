using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;


public partial class FemaleTrackToExcel : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    static string fileName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            ExportDataSetToExcel(ConvertToDataTable(), fileName);
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    public DataTable ConvertToDataTable()
    {
        string sdate = PreviousPage._ShiftDate;
        string facid = PreviousPage._facilityid;
        string rType = PreviousPage._strTripType;
        string Shifts = PreviousPage._StrShift;

        //string sdate = "08/02/2010";
        //string facid = "1";
        //string rType = "P";
        //string Shifts = "1730";



        DataTable dt = new DataTable();
        DataColumn dc = new DataColumn("Sno", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("AssociateID", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("AssociateName", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("Department", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("PhoneNumber", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("ShiftTime", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("RouteNo", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("CabID", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("StopNo", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("ETA", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("Location", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("Tracked", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("Remark", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("UpdatedBy", typeof(System.String));
        dt.Columns.Add(dc);

        int sno = 0;
        fileName = "FemaleTrackedData.xls";
        var result = tmscontext.GetFemaleRouteData(sdate, Convert.ToInt32(facid), Shifts, rType);
        foreach (var result1 in result)
        {

            DataRow dr = dt.NewRow();
            sno = sno + 1;
            dr["Sno"] = sno;
            dr["AssociateID"] = result1.employeeid;
            dr["AssociateName"] = result1.empName;
            dr["Department"] = result1.processName;
            dr["PhoneNumber"] = result1.mobile;
            dr["ShiftTime"] = result1.shiftTime;
            dr["RouteNo"] = result1.Routeid;
            dr["CabID"] = result1.vehicleId;
            dr["StopNo"] = result1.stopNo;
            dr["ETA"] = result1.eta;
            dr["Location"] = result1.Location;
            dr["Tracked"] = result1.Tracked == 1 ? "Yes" : "NO";
            dr["Remark"] = result1.Remark;
            dr["UpdatedBy"] = result1.UpdatedBy;
            dt.Rows.Add(dr);

        }
        return dt;
    }
    public static void ExportDataSetToExcel(DataTable dt, string filename)
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
                    dg.DataSource = dt;
                    dg.DataBind();

                    dg.RenderControl(htw);
                    response.Write(sw.ToString());
                    response.End();
                }
            }
        }
        catch (Exception ex)
        {
            Label lblerror = new Label();
            lblerror.Text = ex.ToString();
        }

    }
}
