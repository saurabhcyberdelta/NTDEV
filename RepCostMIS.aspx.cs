using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using RepCostMISSummaryDataSetTableAdapters;
using Microsoft.Reporting.WebForms;

public partial class RepCostMIS : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    RptCostMISSummaryTableAdapter ds = new RptCostMISSummaryTableAdapter();
    RptCostMISDetailedTableAdapter ds1 = new RptCostMISDetailedTableAdapter();
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
        ReportViewer1.Reset();
        ReportViewer1.LocalReport.Refresh();
        ReportViewer1.LocalReport.ReportPath = "RepCostMISReport.rdlc";
    
        ReportDataSource report1DataSource = new ReportDataSource("RepCostMISSummaryDataSet_RptCostMISSummary", ds.GetData(Startdate, EndDate, Convert.ToInt32(FacilityID)));
        ReportViewer1.LocalReport.DataSources.Clear();

        ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
        ReportViewer1.Visible = true;
        //ReportViewer1.LocalReport.Refresh();
    }

    protected void ReportViewer1_Drillthrough(object sender, DrillthroughEventArgs e)
    {
        string Parameters = string.Empty, tripType = string.Empty, sDate = string.Empty, eDate = string.Empty;
        int facilityid,vendorID;

        ReportParameterInfoCollection DrillThroughValues = e.Report.GetParameters();
        foreach (ReportParameterInfo d in DrillThroughValues)
        {
            Parameters += d.Values[0].ToString().Trim() + "|";
        }
        string[] Parameter = Parameters.Split('|');
        LocalReport localreport = (LocalReport)e.Report;
        sDate = Parameter[0];
        eDate = Parameter[1];
        facilityid = Convert.ToInt32(Parameter[2]);
        vendorID = Convert.ToInt32(Parameter[3]);

        ReportViewer1.Visible = true;
        ReportDataSource report2DataSource = new ReportDataSource("RepCostMISSummaryDataSet_RptCostMISDetailed", ds1.GetData(sDate,eDate, Convert.ToInt32(facilityid), vendorID));
        localreport.DataSources.Clear();
        localreport.DataSources.Add(report2DataSource);
        localreport.Refresh();
        
        
    }
   
}
