using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RepArrivalShiftWiseDataSetTableAdapters;
using ReportTableAdapters;
using Microsoft.Reporting.WebForms;


public partial class repMIS : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    rptHeadcountTableAdapter ds = new rptHeadcountTableAdapter();
    RptArrivalShiftWisepartnerTableAdapter ds1 = new RptArrivalShiftWisepartnerTableAdapter();
    RptArrivalShiftWiseLateTableAdapter ds2 = new RptArrivalShiftWiseLateTableAdapter();
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

        ReportDataSource report1DataSource = new ReportDataSource("Report_rptHeadcount", ds.GetData(Convert.ToDateTime(Startdate),Convert.ToDateTime( EndDate), Convert.ToInt32(FacilityID)));
        //ReportDataSource report2DataSource = new ReportDataSource("Report_RptArrivalShiftWisepartner", ds1.GetData(Startdate, EndDate, Convert.ToInt32(FacilityID)));
        //ReportDataSource report3DataSource = new ReportDataSource("Report_RptArrivalShiftWiseLate", ds2.GetData(Startdate, EndDate, Convert.ToInt32(FacilityID)));

        ReportViewer1.LocalReport.DataSources.Clear();

        ReportViewer1.LocalReport.DataSources.Add(report1DataSource);

       // ReportViewer1.LocalReport.DataSources.Add(report2DataSource);
        //ReportViewer1.LocalReport.DataSources.Add(report3DataSource);
        ReportViewer1.Visible = true;
        ReportViewer1.LocalReport.Refresh();
    }
}
