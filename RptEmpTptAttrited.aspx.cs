using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using RepAttritationDataSetTableAdapters;

public partial class RptEmpTptAttrited : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    RptEmpToopAuditLogTableAdapter ds = new RptEmpToopAuditLogTableAdapter();
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
            ddlFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
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
        DateTime startDate = Convert.ToDateTime(txtStartDate.Text);
        DateTime endDate = Convert.ToDateTime(txtEndDate.Text);

        int facId = Convert.ToInt32(ddlFacility.SelectedValue);
        ReportDataSource report1DataSource = new ReportDataSource("RepAttritationDataSet_RptEmpToopAuditLog", ds.GetData(startDate, endDate, facId));
        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
        ReportViewer1.Visible = true;
        ReportViewer1.LocalReport.Refresh();
    }
}
