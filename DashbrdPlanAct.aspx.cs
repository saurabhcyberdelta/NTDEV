using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

using RepCostMISSampleDataSetTableAdapters;
using Microsoft.Reporting.WebForms;


public partial class DashbrdPlanAct : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    
    DashPlanactTableAdapter dash = new DashPlanactTableAdapter();
    dashbudgetTableAdapter dash1 = new dashbudgetTableAdapter();
    protected void Page_Load(object sender, EventArgs e)
    {


        try
        {
            if (!IsPostBack)
            {
             
               rblistMonth.SelectedValue = DateTime.Now.Month.ToString();
                BndFacilityDropdown();
                BndYearDropDown();
             getreport(DateTime.Now.Month, DateTime.Now.Year, 1);

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }


    public void BndYearDropDown()
    {
        ddlyear.Items.Clear();
        ListItem liv = new ListItem("Select Year", "0");
        ddlyear.Items.Add(liv);
        int currYear = DateTime.Now.Year;
        String curr = currYear.ToString();
        String back = (currYear - 1).ToString();
        ListItem livcurr = new ListItem(curr, curr);
        ListItem livback = new ListItem(back, back);
        ddlyear.Items.Add(livcurr);
        ddlyear.Items.Add(livback);
        ddlyear.DataBind();
        ddlyear.SelectedValue = curr;

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
            ddlFacility.SelectedValue = MyApplicationSession._FacilityID.ToString();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    protected void getreport(int month, int year, int facid)
    {
        ReportViewer1.Reset();
        ReportViewer1.LocalReport.Refresh();
        ReportViewer1.LocalReport.ReportPath = "DashPlanActReport.rdlc";

        ReportDataSource report1DataSource = new ReportDataSource("RepCostMISSampleDataSet_DashPlanact", dash.GetData(month, year,facid));
        //ReportDataSource report2DataSource = new ReportDataSource("RepCostMISSampleDataSet_RptCostMISfacility", ds.GetData(month, year, facid));

        ReportViewer1.LocalReport.DataSources.Clear();

        ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
      //  ReportViewer1.LocalReport.DataSources.Add(report2DataSource);
        ReportViewer1.Visible = true;
        ReportViewer1.LocalReport.Refresh();
    }
    protected void rblistMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        getreport(Convert.ToInt32(rblistMonth.SelectedValue), Convert.ToInt32(ddlyear.SelectedValue), Convert.ToInt32(ddlFacility.SelectedValue));
    }
    protected void ddlyear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getreport(Convert.ToInt32(rblistMonth.SelectedValue), Convert.ToInt32(ddlyear.SelectedValue), Convert.ToInt32(ddlFacility.SelectedValue));

    }

    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        getreport(Convert.ToInt32(rblistMonth.SelectedValue), Convert.ToInt32(ddlyear.SelectedValue), Convert.ToInt32(ddlFacility.SelectedValue));

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //Button1.ForeColor = System.Drawing.Color.Gray;
        //btnBudget.ForeColor = System.Drawing.Color.Black;
        btnBudget.BackColor = System.Drawing.Color.Black;
        Button1.BackColor = System.Drawing.Color.Gray;
        Button1.ForeColor = System.Drawing.Color.Aquamarine;
        btnBudget.ForeColor = System.Drawing.Color.White;
        int month = Convert.ToInt32(rblistMonth.SelectedValue);

        int year = Convert.ToInt32(ddlyear.SelectedValue);
        int facid = Convert.ToInt32(ddlFacility.SelectedValue);
        ReportViewer1.Reset();
        ReportViewer1.LocalReport.Refresh();
        ReportViewer1.LocalReport.ReportPath = "DashPlanActReport.rdlc";

        ReportDataSource report1DataSource = new ReportDataSource("RepCostMISSampleDataSet_DashPlanact", dash.GetData(month, year, facid));
        //ReportDataSource report2DataSource = new ReportDataSource("RepCostMISSampleDataSet_RptCostMISfacility", ds.GetData(month, year, facid));

        ReportViewer1.LocalReport.DataSources.Clear();

        ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
        //  ReportViewer1.LocalReport.DataSources.Add(report2DataSource);
        ReportViewer1.Visible = true;
        ReportViewer1.LocalReport.Refresh();
    }

    protected void btnBudget_Click(object sender, EventArgs e)
    {
        btnBudget.BackColor = System.Drawing.Color.Gray;
        Button1.BackColor = System.Drawing.Color.Black;
        btnBudget.ForeColor = System.Drawing.Color.Aquamarine;
        Button1.ForeColor = System.Drawing.Color.White;
        //btnBudget.ForeColor = System.Drawing.Color.Gray;
        //Button1.ForeColor = System.Drawing.Color.Black;
        int month=Convert.ToInt32(rblistMonth.SelectedValue);
        
        int year=Convert.ToInt32(ddlyear.SelectedValue);
        int facid = Convert.ToInt32(ddlFacility.SelectedValue);
        ReportViewer1.Reset();
        ReportViewer1.LocalReport.Refresh();
        ReportViewer1.LocalReport.ReportPath = "DashBudgetReport.rdlc";

        ReportDataSource report1DataSource = new ReportDataSource("RepCostMISSampleDataSet_dashbudget", dash1.GetData(month, year, facid));
        //ReportDataSource report2DataSource = new ReportDataSource("RepCostMISSampleDataSet_RptCostMISfacility", ds.GetData(month, year, facid));

        ReportViewer1.LocalReport.DataSources.Clear();

        ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
        //  ReportViewer1.LocalReport.DataSources.Add(report2DataSource);
        ReportViewer1.Visible = true;
        ReportViewer1.LocalReport.Refresh();
    }
}
