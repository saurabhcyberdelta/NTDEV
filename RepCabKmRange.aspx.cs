using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using RPtBillingDataSetTableAdapters;

public partial class RepCabKmRange : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    RepCabKmRangeTableAdapter ds = new RepCabKmRangeTableAdapter();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                txtEndDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                txtvalue.Text = string.Empty;
                
                BndDropdown();

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    public void BndDropdown()
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
            ddlbillingtripType.DataSource = tmscontext.GetBillingtripType();
            ddlbillingtripType.DataTextField = "BillingTripType";
            ddlbillingtripType.DataValueField = "ID";
            ddlbillingtripType.DataBind();
            ListItem livendor = new ListItem("Select Vendor", "0");
            ddlVendor.Items.Add(livendor);
            ddlVendor.DataBind();
            
           
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

        string Cabids = string.Empty;
        Cabids = ddlVendor.SelectedValue;
        ReportViewer1.LocalReport.ReportPath = "RepCabkmRnge.rdlc";
        ReportDataSource report1DataSource = new ReportDataSource("RPtBillingDataSet_RepCabKmRange", ds.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Cabids, Convert.ToInt32(rdbtnWeektype.SelectedValue), Convert.ToInt32(rdbtnOperator.SelectedValue), Convert.ToInt32(txtvalue.Text),Convert.ToInt32(ddlbillingtripType.SelectedValue)));
        ReportViewer1.LocalReport.DataSources.Clear();

        ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
        ReportViewer1.Visible = true;
        ReportViewer1.LocalReport.Refresh();
    }


    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlVendor.Items.Clear();
        ListItem livendor = new ListItem("Select Vendor", "0");
        ddlVendor.Items.Add(livendor);
        ddlVendor.DataSource = tmscontext.GetVendorByFac(Convert.ToInt32(ddlFacility.SelectedValue));
        ddlVendor.DataTextField = "vendorName";
        ddlVendor.DataValueField = "Id";
        ddlVendor.DataBind();
    }
}