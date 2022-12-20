using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using ReportTableAdapters;

public partial class RepUnscheduleRequest : basepage
{

    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    RptUnscheduleRequestTableAdapter ds = new RptUnscheduleRequestTableAdapter();
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
            ddlType.Items.Clear();
            ListItem liv = new ListItem("Select Facility", "0");
            ddlType.Items.Add(liv);
            ddlType.DataSource = tmscontext.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlType.DataTextField = "facilityName";
            ddlType.DataValueField = "Id";
            ddlType.DataBind();
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
        string Startdate = txtStartDate.Text;
        string EndDate = txtEndDate.Text;
        string cabtype = ddlType.SelectedValue;


        ReportViewer1.Visible = true;
        ReportDataSource reportDataSource = new ReportDataSource("Report_RptUnscheduleRequest", ds.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(cabtype)));
        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(reportDataSource);
        ReportViewer1.Visible = true;
        ReportViewer1.LocalReport.Refresh();


    }
}