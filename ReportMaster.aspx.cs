using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReportTableAdapters;

public partial class ReportMaster : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    getAllReportsinoneTableAdapter ds = new getAllReportsinoneTableAdapter();
        protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                txtEndDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                BndFacilityDropdown();

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }

    }

    public void BndFacilityDropdown()
    {
        try
        {
            ddlFacility.Items.Clear();
            ListItem liv = new ListItem("Select Facility", "0");
            ddlFacility.Items.Add(liv);
            ddlFacility.DataSource = tmscontext.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlFacility.DataTextField = "facilityName";
            ddlFacility.DataValueField = "Id";
            ddlFacility.DataBind();

            ddlReport.Items.Clear();
            ddlReport.DataSource = tmscontext.getReportAll();
            ddlReport.DataTextField = "Reportname";
            ddlReport.DataValueField = "id";
            ddlReport.DataBind();
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
    DateTime Startdate = Convert.ToDateTime(txtStartDate.Text);
        DateTime EndDate = Convert.ToDateTime(txtEndDate.Text);
        string FacilityID = ddlFacility.SelectedValue;
        GridView1.DataSource = ds.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(ddlReport.SelectedValue));
        GridView1.DataBind();
        GridViewExportUtil.Export("Report.Xls", GridView1);
       
    }
}
