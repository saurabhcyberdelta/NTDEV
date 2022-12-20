using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using RepPlanActDataSetTableAdapters;

public partial class RepPlanAct : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    RptPlanActTableAdapter ds = new RptPlanActTableAdapter();
    RptPlanActDetailedTableAdapter ds1 = new RptPlanActDetailedTableAdapter();
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
        string TripType = rdoTripType.SelectedValue;
        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.Refresh();
        ReportViewer1.Reset();

        ReportViewer1.LocalReport.ReportPath = "RepPlanActReport.rdlc";

        ReportDataSource report1DataSource = new ReportDataSource("RepPlanActDataSet_RptPlanAct", ds.GetData(Startdate, EndDate, Convert.ToInt32(FacilityID), TripType));
        ReportViewer1.LocalReport.DataSources.Clear();

        ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
        ReportViewer1.Visible = true;
        //ReportViewer1.Attributes.Add("style", "overflow:auto");
        ReportViewer1.LocalReport.Refresh();
    }
    protected void ReportViewer1_Drillthrough(object sender, DrillthroughEventArgs e)
    {
        string Parameters = string.Empty,tripType = string.Empty;
        DateTime sDate;
        int facilityid;

        ReportParameterInfoCollection DrillThroughValues = e.Report.GetParameters();
        foreach (ReportParameterInfo d in DrillThroughValues)
        {
            Parameters += d.Values[0].ToString().Trim() + "|";
        }
        string[] Parameter = Parameters.Split('|');
        LocalReport localreport = (LocalReport)e.Report;
        sDate = Convert.ToDateTime(Parameter[0]);
        facilityid = Convert.ToInt32(Parameter[1]);
        tripType = Parameter[2];

        ReportViewer1.Visible = true;
        ReportDataSource report2DataSource = new ReportDataSource("RepPlanActDataSet_RptPlanActDetailed", ds1.GetData(sDate, Convert.ToInt32(facilityid),tripType));
        localreport.DataSources.Clear();
        localreport.DataSources.Add(report2DataSource);
      
        localreport.Refresh();

    }
}
