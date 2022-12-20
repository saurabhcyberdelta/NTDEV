using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Text;
using System.IO;

public partial class RepVendorPerformance : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
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
    public void BndVendorDropdown()
    {
        try
        {
            ddlVendor.Items.Clear();
            ListItem liv = new ListItem("Select Facility", "0");
            ddlVendor.Items.Add(liv);
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        BndDvResult();
        //ReportDataSource report1DataSource = new ReportDataSource("RepArrivalVendorWiseDataSet_RptArrivalVendorWise", ds.GetData(Startdate, EndDate, Convert.ToInt32(FacilityID)));
        //ReportViewer1.LocalReport.DataSources.Clear();
        //ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
        //ReportViewer1.Visible = true;
        //ReportViewer1.LocalReport.Refresh();
    }
    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        BndVendorDropdown();
    }
    public void BndDvResult()
    {
        try
        {
            dvResult.DataSource = tmscontext.RptVendorPerformance(txtStartDate.Text, txtEndDate.Text, Convert.ToInt32(ddlFacility.SelectedValue), Convert.ToInt32(ddlVendor.SelectedValue));
            dvResult.DataBind();
            if (dvResult.Rows.Count > 1)
            {
                lblHeading.Text = "Period : " + txtStartDate.Text + " To " + txtEndDate.Text + ", For Vendor : " + ddlVendor.SelectedItem;
                lbtnExportExcel.Visible = true;
            }
            else
            {
                lblHeading.Text = string.Empty;
                lbtnExportExcel.Visible = false;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void lbtnExportExcel_Click(object sender, EventArgs e)
    {
        try
        {
            string attachment = "attachment; filename=VendorPerformance.xls";
            //Response.Clear();
            //Response.Buffer=true;
            //Response.Charset="";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/vnd.ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            dvResult.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        //This empty code is required for render control's above code.
    }
}
