using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using RepProcessWiseCostTableAdapters;

public partial class RptProcessWiseCostNew : System.Web.UI.Page
{

    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    ReptotalProcessCostTableAdapter ds = new ReptotalProcessCostTableAdapter();
    TotalProcessPartnerTableAdapter ds1 = new TotalProcessPartnerTableAdapter();
    repProcesswiseCostcenterCostTableAdapter ds2 = new repProcesswiseCostcenterCostTableAdapter();


    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

                BndDropdown();

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    public void BndDropdown()
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


            ddlMonth.Items.Clear();
            for (int i = 1; i <= 12; i++)
            {
                ListItem lim = new ListItem(i.ToString(), i.ToString());
                ddlMonth.Items.Add(lim);
            }
            ddlYear.Items.Clear();
            int years = DateTime.Now.Year;


            ListItem li1 = new ListItem((years - 1).ToString(), (years - 1).ToString());
            ddlYear.Items.Add(li1);
            ListItem li2 = new ListItem((years).ToString(), (years).ToString());
            ddlYear.Items.Add(li2);
            ListItem li3 = new ListItem((years + 1).ToString(), (years + 1).ToString());
            ddlYear.Items.Add(li3);


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
        int noofdays = DateTime.DaysInMonth(Convert.ToInt32(ddlYear.SelectedValue), Convert.ToInt32(ddlMonth.SelectedValue));
        string Startdate = ddlMonth.SelectedValue.ToString() + "/" + "1" + "/" + ddlYear.SelectedValue.ToString();
        string EndDate = ddlMonth.SelectedValue.ToString() + "/" + noofdays.ToString() + "/" + ddlYear.SelectedValue.ToString();
        string FacilityID = ddlFacility.SelectedValue;



        ReportViewer1.LocalReport.ReportPath = "RptTotalProcess.rdlc";
        ReportDataSource report1DataSource = new ReportDataSource("RepProcessWiseCost_ReptotalProcessCost", ds.GetData(Convert.ToInt32(ddlMonth.SelectedValue), Convert.ToInt32(ddlYear.SelectedValue), Convert.ToInt32(FacilityID)));
        ReportViewer1.LocalReport.DataSources.Clear();

        ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
        ReportDataSource report2DataSource = new ReportDataSource("RepProcessWiseCost_TotalProcessPartner", ds1.GetData(Convert.ToInt32(ddlMonth.SelectedValue), Convert.ToInt32(ddlYear.SelectedValue), Convert.ToInt32(FacilityID)));

        ReportViewer1.LocalReport.DataSources.Add(report2DataSource);
        ReportDataSource report3DataSource = new ReportDataSource("RepProcessWiseCost_repProcesswiseCostcenterCost", ds2.GetData(Convert.ToInt32(ddlMonth.SelectedValue), Convert.ToInt32(ddlYear.SelectedValue), Convert.ToInt32(FacilityID)));

        ReportViewer1.LocalReport.DataSources.Add(report3DataSource);
        ReportViewer1.Visible = true;
        
        ReportViewer1.LocalReport.Refresh();
    }

    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {


    }
    protected void ddlVendor_SelectedIndexChanged(object sender, EventArgs e)
    {


    }
  
   
   }
