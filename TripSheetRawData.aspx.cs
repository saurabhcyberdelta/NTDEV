using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TripSheetRawData : System.Web.UI.Page
{

    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    // RptCabComplianceTableAdapter ds = new RptCabComplianceTableAdapter();
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
       
        string VendorIDs = "0";

        GvComplianceReport.DataSource = tmscontext.RepTripSheetRawData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(VendorIDs), Convert.ToInt32(FacilityID));
            GvComplianceReport.DataBind();
            GvComplianceReport.Caption = "Tripsheet Raw Data From:" + " " + txtStartDate.Text + " To:" + txtEndDate.Text ;
            GvComplianceReport.CaptionAlign = System.Web.UI.WebControls.TableCaptionAlign.Left;
       
        GridViewExportUtil.Export("TripSheetRawData.XLS", GvComplianceReport);

    }
    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        BndVendorDropdown();
    }

    public void BndVendorDropdown()
    {
        try
        {
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
