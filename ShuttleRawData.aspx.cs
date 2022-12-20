using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReportTableAdapters;
public partial class ShuttleRawData : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    RptgetFCSShuttleTableAdapter ds = new RptgetFCSShuttleTableAdapter();
    getIOSshuttleDetailsTableAdapter ds1 = new getIOSshuttleDetailsTableAdapter();
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
            ddlVendor.Items.Clear();
            ListItem livendor = new ListItem("Select Vendor", "0");
            ddlVendor.Items.Add(livendor);

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
        GridView gv = new GridView();
        if (ddlShuttleType.SelectedValue == "FCS")
        {
            gv.DataSource = ds.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(ddlVendor.SelectedValue));
            gv.DataBind();
            gv.Caption = "Food Court shuttle details";
        }
        else if (ddlShuttleType.SelectedValue == "IOSB")
        {
            gv.DataSource = tmscontext.IOSBillingReport(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate),Convert.ToInt32(ddlFacility.SelectedValue), Convert.ToInt32(ddlVendor.SelectedValue),1,1);
            gv.DataBind();
            gv.Caption = "Inter office  shuttle Billing";
        }
        else if (ddlShuttleType.SelectedValue == "BFC")
        {
            gv.DataSource = tmscontext.BufferCabBillingReport(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(ddlFacility.SelectedValue), Convert.ToInt32(ddlVendor.SelectedValue), 1, 1);
            gv.DataBind();
            gv.Caption = "Buffer cabs Billing";
        }
        else if (ddlShuttleType.SelectedValue == "Toll")
        {
            gv.DataSource = tmscontext.GetTollEntryData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(ddlVendor.SelectedValue));
            gv.DataBind();
            gv.Caption = "Toll Entry Data";
        }
        else if (ddlShuttleType.SelectedValue == "Ele")
        {
            gv.DataSource = tmscontext.ElectricCabBilling(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(ddlFacility.SelectedValue), Convert.ToInt32(ddlVendor.SelectedValue));
            gv.DataBind();
            gv.Caption = "Electric Billing";
        }
        else
        {
            gv.DataSource = ds1.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(ddlVendor.SelectedValue));
            gv.DataBind();
            gv.Caption = "Inter office  shuttle details";
        }
        
        if (gv.Rows.Count > 0)
        {
            gv.HeaderRow.BackColor = System.Drawing.Color.Green;
            gv.HeaderRow.Font.Bold = true;
            gv.HeaderRow.ForeColor = System.Drawing.Color.White;
            GridViewExportUtil.Export("Shuttle"+DateTime.Now+".xls", gv);
        }
        else
        {
            ShowMessage("No Data exists for selected vendor");
        }
      
    }

    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndvendorDrop();
    }
    protected void ddlShuttleType_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndvendorDrop();
    }
    void bndvendorDrop()
    {
        //string type = ddlShuttleType.SelectedValue.ToString();
        int fid = Convert.ToInt32(ddlFacility.SelectedValue);
        //if (type == "FCS")
        //{
        //    fid = 2;
        //}
        //else
        //{
        //    fid = 1;
        //}
        ddlVendor.Items.Clear();
        ListItem livendor = new ListItem("Select Vendor", "0");
        ddlVendor.Items.Add(livendor);
        ddlVendor.DataSource = tmscontext.GetVendorByFac(fid);
        ddlVendor.DataTextField = "vendorName";
        ddlVendor.DataValueField = "Id";
        ddlVendor.DataBind();
        
    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
}