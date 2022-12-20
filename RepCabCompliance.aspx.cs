using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using RptCabComplianceTableAdapters;


public partial class RepCabCompliance : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
   RptCabComplianceTableAdapter ds = new RptCabComplianceTableAdapter();
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
            ddlFacility.DataSource = tmscontext.SelectFacility(MyApplicationSession._UserID,MyApplicationSession._ISAdmin);
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
        string EndDate = txtEndDate.Text;
        string FacilityID = ddlFacility.SelectedValue;
        string TripType = rdoTripType.SelectedValue;
        string VendorIDs = ddlVendor.SelectedValue;
        if (ddlPenaltyType.SelectedValue.ToString() == "2")
        {

            GvComplianceReport.DataSource = ds.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), TripType, VendorIDs);
            GvComplianceReport.DataBind();
            GvComplianceReport.Caption = "Compliance Penalty From:" + " " + txtStartDate.Text + " To:" + txtEndDate.Text + " For Vendor: " + ddlVendor.SelectedItem.ToString();
            GvComplianceReport.CaptionAlign = System.Web.UI.WebControls.TableCaptionAlign.Left;
        }
        else
        {
            GvComplianceReport.DataSource = tmscontext.RptOperationsPenalty(Startdate, EndDate, Convert.ToInt32(FacilityID), TripType, VendorIDs);
            GvComplianceReport.DataBind();
            GvComplianceReport.Caption = "Operations Penalty From:"+" "+txtStartDate.Text+" To:"+txtEndDate.Text+" For Vendor: "+ddlVendor.SelectedItem.ToString() ;
            GvComplianceReport.CaptionAlign = System.Web.UI.WebControls.TableCaptionAlign.Left;
        }
          GridViewExportUtil.Export("Cab Compliance.XLS", GvComplianceReport);  
    }
    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        BndVendorDropdown();
    }

    public void BndVendorDropdown()
    {
        try
        {
            ddlVendor.Items.Clear();
            ListItem liv = new ListItem("-Select-", "-1");
            ListItem liav = new ListItem("-All Vendor-", "0");
            ddlVendor.Items.Add(liv);
            ddlVendor.Items.Add(liav);
            ddlVendor.DataSource = tmscontext.GetVendorByFacility(Convert.ToInt32(ddlFacility.SelectedValue));
            ddlVendor.DataTextField = "VendorName";
            ddlVendor.DataValueField = "Id";
            ddlVendor.DataBind();
            ddlVendor.SelectedIndex = 0;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void GvComplianceReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        System.Web.UI.WebControls.Style s = new Style();
        s.CssClass = "verticaltext";
        GridViewRow r = GvComplianceReport.HeaderRow;
        if (r != null)
        {
            for (int i = 0; i < r.Cells.Count; i++)
            {
                r.ApplyStyle(s);
            }
        }
       }
}
