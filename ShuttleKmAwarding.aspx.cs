using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReportTableAdapters;
using Microsoft.Reporting.WebForms;

public partial class ShuttleKmAwarding : System.Web.UI.Page
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    RptShuttleAwardingKmTableAdapter ds = new RptShuttleAwardingKmTableAdapter();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                txtEndDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                bndvendorDrop();
            }
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
         string type = ddlShuttleType.SelectedValue.ToString();
        int fid = 0;
        if (type == "FCS")
        {
            fid = 2;
        }
        else
        {
            fid = 1;
        }
        ReportViewer1.LocalReport.ReportPath = "RepShuttleKmAwarding.rdlc";
        ReportDataSource report1DataSource = new ReportDataSource("Report_RptShuttleAwardingKm", ds.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate),Convert.ToInt32(ddlVendor.SelectedValue),fid));
        ReportViewer1.LocalReport.DataSources.Clear();

        ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
        ReportViewer1.Visible = true;
        ReportViewer1.LocalReport.Refresh();

    }


    protected void ddlShuttleType_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndvendorDrop();
    }
    void bndvendorDrop()
    {
        string type = ddlShuttleType.SelectedValue.ToString();
        int fid = 0;
        if (type == "FCS")
        {
            fid = 2;
        }
        else
        {
            fid = 1;
        }
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