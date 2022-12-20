using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;

public partial class ExportRoster : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BndDdl();
            txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
        }
    }

    public void BndDdl()
    {
        //**********************************//
        //Binds Facility Dropdown          //
        //*********************************//
        try
        {
            ddlfacility.Items.Clear();
            ListItem lifac = new ListItem("Select Facility", "0");
            ddlfacility.Items.Add(lifac);
            ddlfacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlfacility.DataTextField = "facilityName";
            ddlfacility.DataValueField = "Id";
            ddlfacility.DataBind();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string sDate = txtStartDate.Text;
            string rtype = rdbtnlstType.SelectedValue;
            int facId = Convert.ToInt32(ddlfacility.SelectedValue.ToString());
      
            var result = tms.ExportRoster(sDate, facId, rtype);
            // GridView1.DataBind();

            DataTable dt = new DataTable();
            DataColumn dc = new DataColumn("EmpID", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("ShiftDate", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Shift", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Gender", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Employee Name", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Address", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("City", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Location", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("SubLoacation", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Mobile", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Facility", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Department", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Manager", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Division Manager", typeof(System.String));
            dt.Columns.Add(dc);
            foreach (var result1 in result)
            {
                DataRow dr = dt.NewRow();
                dr["EmpID"] = result1.empCode;
                dr["ShiftDate"] = result1.startdate;
                dr["Shift"] = result1.startTime;
                dr["Gender"] = result1.Gender;
                dr["Employee Name"] = result1.empName;
                dr["Address"] = result1.address;
                dr["City"] = result1.city;
                dr["Location"] = result1.colony;
                dr["SubLoacation"] = result1.SubColony;
                dr["Mobile"] = result1.mobile;
                dr["Facility"] = result1.facility;
                dr["Department"] = result1.processName;
                dr["Manager"] = result1.Manager;
                dr["Division Manager"] = result1.DivisionManager;
                dt.Rows.Add(dr);
            }
            DataSet dsMenu = new DataSet();
            dsMenu.Tables.Add(dt);

            ExportDataSetToExcel(dsMenu, "ExportRoster.xls");

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }

    public static void ExportDataSetToExcel(DataSet ds, string filename)
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
