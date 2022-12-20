using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using RPtBillingDataSetTableAdapters;

public partial class NewBillingSummaryReports : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    SlabBillingSummaryTableAdapter ds = new SlabBillingSummaryTableAdapter();
    MedicalBillingSummaryTableAdapter ds1 = new MedicalBillingSummaryTableAdapter();
    AdditionalBillingSummaryTableAdapter ds2 = new AdditionalBillingSummaryTableAdapter();
    FTELTEBillingSummaryTableAdapter ds3 = new FTELTEBillingSummaryTableAdapter();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                txtEndDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                BndFacilityDropdown();
                BndVendorDropdown();

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    public void BndVendorDropdown()
    {
        try
        {
            ddlVendor.Items.Clear();
            ListItem liv = new ListItem("Select Vendor", "-1");
            ListItem liv1 = new ListItem("All Vendor", "0");
            ddlVendor.Items.Add(liv);
            ddlVendor.Items.Add(liv1);
            ddlVendor.DataSource = tmscontext.GetVendorByFacility(Convert.ToInt32(ddlFacility.SelectedValue));
            ddlVendor.DataTextField = "VendorName";
            ddlVendor.DataValueField = "Id";
            ddlVendor.DataBind();
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
            ddlFacility.SelectedIndex = ddlFacility.Items.IndexOf(ddlFacility.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));
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
        string FacilityID = ddlFacility.SelectedValue;
        string vendorid = ddlVendor.SelectedValue;

        if (rdbreptype.SelectedValue=="1")
        {
            ReportViewer1.Reset();
            ReportViewer1.LocalReport.ReportPath = "SlabBillingSummary.rdlc";
            ReportDataSource report1DataSource = new ReportDataSource("RPtBillingDataSet_SlabBillingSummary", ds.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4, Convert.ToInt32(rdbWeekType.SelectedValue)));
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
            ReportViewer1.Visible = true;
            ReportViewer1.LocalReport.Refresh();
        }
        else if (rdbreptype.SelectedValue=="2")
        {
            ReportViewer1.Reset();
            ReportViewer1.LocalReport.ReportPath = "MedicalBillingSummary.rdlc";
            ReportDataSource report2DataSource = new ReportDataSource("RPtBillingDataSet_MedicalBillingSummary", ds1.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4, Convert.ToInt32(rdbWeekType.SelectedValue)).ToList());
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(report2DataSource);
            ReportViewer1.Visible = true;
            ReportViewer1.LocalReport.Refresh();
        }
        else if (rdbreptype.SelectedValue=="3")
        {
            ReportViewer1.Reset();
            ReportViewer1.LocalReport.ReportPath = "AdditionalBillingSummary.rdlc";
            ReportDataSource report3DataSource = new ReportDataSource("RPtBillingDataSet_AdditionalBillingSummary", ds2.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4, Convert.ToInt32(rdbWeekType.SelectedValue)).ToList());
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(report3DataSource);
            ReportViewer1.Visible = true;
            ReportViewer1.LocalReport.Refresh();
        }
        else if (rdbreptype.SelectedValue == "4")
        {
            ReportViewer1.Reset();
            ReportViewer1.LocalReport.ReportPath = "FTE-LTEBillingSummary.rdlc";
            ReportDataSource report4DataSource = new ReportDataSource("RPtBillingDataSet_FTELTEBillingSummary", ds3.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4, Convert.ToInt32(rdbWeekType.SelectedValue)).ToList());
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(report4DataSource);
            ReportViewer1.Visible = true;
            ReportViewer1.LocalReport.Refresh();
        }
        
    }
    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        BndVendorDropdown();
    }
}