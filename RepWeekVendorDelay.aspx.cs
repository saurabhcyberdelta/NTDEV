using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReportTableAdapters;
using Microsoft.Reporting.WebForms;
public partial class RepWeekVendorDelay : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    RptWeekVendorDelayTableAdapter ds = new RptWeekVendorDelayTableAdapter();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");

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

        string FacilityID = ddlFacility.SelectedValue;

        ReportDataSource report1DataSource = new ReportDataSource("Report_RptWeekVendorDelay", ds.GetData(Convert.ToInt32(FacilityID), Convert.ToDateTime(Startdate)));

        ReportViewer1.LocalReport.DataSources.Clear();

        ReportViewer1.LocalReport.DataSources.Add(report1DataSource);


        ReportViewer1.Visible = true;
        ReportViewer1.LocalReport.Refresh();
    }
}
