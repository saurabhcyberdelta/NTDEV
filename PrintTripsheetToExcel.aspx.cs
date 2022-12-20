using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Text.RegularExpressions;

public partial class PrintTripsheetToExcel : basepage2
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
        Boolean IsValid = true;
        string strReq = "";
        string[] arrIndMsg = null;
        strReq = Request.RawUrl;
        strReq = strReq.Substring(strReq.IndexOf('?') + 1);
        string sdate = null, facid = null, edate = null, rType = null, Shifts = null;

        strReq = new EncryptQueryString().Decrypt(strReq);
        string[] arrMsgs = strReq.Split('&');

        if (arrMsgs.Length > 1)
        {
            arrIndMsg = arrMsgs[0].Split('=');
            if (arrIndMsg.Length > 1)
            {
                sdate = arrIndMsg[1].ToString().Trim();
            }
            else
            {
                sdate = "";
            }
            if (!Regex.IsMatch(sdate, @"^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"))
            {
                IsValid = false;
            }
        }
        else
        {
            IsValid = false;
        }


        if (arrMsgs.Length > 2)
        {

            arrIndMsg = arrMsgs[1].Split('=');
            if (arrIndMsg.Length > 1)
            {
                edate = arrIndMsg[1].ToString().Trim();
            }
            else
            {
                edate = "";
            }


            if (IsValid == true)
            {
                if (!Regex.IsMatch(edate, @"^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"))
                {
                    IsValid = false;
                }
            }
        }

        if (arrMsgs.Length > 3)
        {
            arrIndMsg = arrMsgs[2].Split('=');

            if (arrIndMsg.Length > 1)
            {
                facid = arrIndMsg[1].ToString().Trim();
            }
            else
            {
                facid = "";
            }
            if (IsValid == true)
            {
                if (Regex.IsMatch(facid, @"[^0-9]"))
                {
                    IsValid = false;
                }
            }
        }

        if (arrMsgs.Length > 4)
        {

            arrIndMsg = arrMsgs[3].Split('=');
            if (arrIndMsg.Length > 1)
            {
                rType = arrIndMsg[1].ToString().Trim();
            }
            else
            {
                rType = "";
            }
        }

        if (arrMsgs.Length > 5)
        {
            arrIndMsg = arrMsgs[4].Split('=');
            if (arrIndMsg.Length > 1)
            {
                Shifts = arrIndMsg[1].ToString().Trim();
            }
            else
            {
                Shifts = "";
            }
        }

        string RouteID = null;
        if (arrMsgs.Length > 4)
        {
            arrIndMsg = arrMsgs[5].Split('=');
            if (arrIndMsg.Length > 1)
            {
                RouteID = arrIndMsg[1].ToString().Trim();
            }
            else
            {
                RouteID = "";
            }
        }



        DataTable dt = new DataTable();
        DataColumn dc = new DataColumn("SNo", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("Route#", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("Vendor", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("RouteID", typeof(System.String));
        dt.Columns.Add(dc);
       
        dc = new DataColumn("shiftDate", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("CabID", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("EmployeeID", typeof(System.String));
        dt.Columns.Add(dc);
       
        
        dc = new DataColumn("BU", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("Process", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("Shift", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("Gender", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("EmployeeName", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("colony", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("Address", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("Mobile", typeof(System.String));
        dt.Columns.Add(dc);
         dc = new DataColumn("ETA", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("remark", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("CabType", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("RegistrationNo", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("DriverContact1", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("DriverContact2", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("DriverName", typeof(System.String));
        dt.Columns.Add(dc);
        dc = new DataColumn("TripType", typeof(System.String));
        dt.Columns.Add(dc);
        
       
      
        dc = new DataColumn("stopNo", typeof(System.String));
        dt.Columns.Add(dc);
       
        dc = new DataColumn("city", typeof(System.String));
        dt.Columns.Add(dc);
       
        dc = new DataColumn("landmark", typeof(System.String));
        dt.Columns.Add(dc);
       
      
       
       
        

        Boolean flgRowBreak = false;
        //int noOfPax = Convert.ToInt32(tmscontext.GetNoOfPax().ElementAt(0).noOfPax);
        int sno = 0;
        int rowNum = 0;
        string routeID = "0";
        string shiftTime = string.Empty;
        fileName = "Pickup Roster File.xls";
        var result = tmscontext.GetRoutesExportExcel(sdate, edate, facid, rType, Shifts);
        foreach (var result1 in result)
        {

            if (routeID != "0" && routeID != result1.RouteID)
            {
                flgRowBreak = true;
                rowNum = 0;
            }

            shiftTime = result1.shiftTime;
            routeID = result1.RouteID;
            if (flgRowBreak == true)
            {
                flgRowBreak = false;
                DataRow drBlankRow = dt.NewRow();
                foreach (DataColumn dc1 in dt.Columns)
                {
                    drBlankRow[dc1.ColumnName] = DBNull.Value;
                }
                dt.Rows.Add(drBlankRow);
                DataRow drBlankRow1 = dt.NewRow();
                foreach (DataColumn dc1 in dt.Columns)
                {
                    drBlankRow1[dc1.ColumnName] = DBNull.Value;
                }
                dt.Rows.Add(drBlankRow1);
            }

            DataRow dr = dt.NewRow();
            sno = sno + 1;
            rowNum = rowNum + 1;
            dr["SNo"] = result1.SNo;
            dr["RouteID"] = result1.RouteID;
            dr["Shift"] = result1.shiftTime;
            dr["shiftDate"] = result1.shiftDate;
            dr["Vendor"] = result1.vendorName;
            dr["CabID"] = result1.vehicleId;
            dr["TripType"] = result1.TripType;
            dr["EmployeeID"] = result1.empCode;
            dr["EmployeeName"] = result1.empName;
            dr["Gender"] = result1.Gender;
            dr["BU"] = result1.processName;
            dr["TripType"] = result1.TripType;
            dr["stopNo"] = result1.stopNo;
            dr["Address"] = result1.address;
            dr["city"] = result1.city;
            dr["colony"] = result1.colony;
            dr["landmark"] = result1.landmark;
            dr["Mobile"] = result1.mobile;
            dr["ETA"] = result1.ETA;
            dr["remark"] = result1.remark;
            dr["DriverName"] = result1.DriverName;
            dr["DriverContact1"] = result1.DriverContact1;
            dr["DriverContact2"] = result1.DriverContact2;
            dr["Route#"] = result1.sticker;
            dr["Process"] = result1.Subprocess;
            dr["CabType"] = result1.type;
            dr["RegistrationNo"] = result1.vehicleNo;

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
