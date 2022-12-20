using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using ReportTableAdapters;

public partial class RepDummyTypes : basepage
{

    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    rptDummyTypeTableAdapter ds = new rptDummyTypeTableAdapter();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

                txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                txtEndDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                BndCabTypeDropdown();
              

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    public void BndCabTypeDropdown()
    {
        try
        {
            ddlCabType.Items.Clear();
            ListItem liv = new ListItem("Select CabType", "0");
            ddlCabType.Items.Add(liv);
            ListItem liv1 = new ListItem("All CabTypes", "-1");
            ddlCabType.Items.Add(liv1);
            ddlCabType.DataSource = tmscontext.getdummyCabType();
            ddlCabType.DataTextField = "Type";
            ddlCabType.DataValueField = "ID";
            ddlCabType.DataBind();
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
        string cabtype = ddlCabType.SelectedValue;
        

        ReportViewer1.Visible = true;
        ReportDataSource reportDataSource = new ReportDataSource("Report_rptDummyType", ds.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(cabtype)));
        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(reportDataSource);
        ReportViewer1.Visible = true;
        ReportViewer1.LocalReport.Refresh();


    }
}
