using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RPtBillingDataSetTableAdapters;
using Microsoft.Reporting.WebForms;


public partial class CostLock : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    ReptotalCostTableAdapter ds = new ReptotalCostTableAdapter();
    RptVendorPenaltyFinalTableAdapter ds1 = new RptVendorPenaltyFinalTableAdapter();
    getservicetaxTableAdapter ds2 = new getservicetaxTableAdapter();


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



        ReportViewer1.LocalReport.ReportPath = "RptTotalCost.rdlc";
        ReportDataSource report1DataSource = new ReportDataSource("RPtBillingDataSet_ReptotalCost", ds.GetData(Convert.ToInt32(ddlMonth.SelectedValue), Convert.ToInt32(ddlYear.SelectedValue), Convert.ToInt32(FacilityID)));
        ReportViewer1.LocalReport.DataSources.Clear();

        ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
        ReportDataSource report2DataSource = new ReportDataSource("RPtBillingDataSet_RptVendorPenaltyFinal", ds1.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID)));

        ReportViewer1.LocalReport.DataSources.Add(report2DataSource);
        ReportDataSource report3DataSource = new ReportDataSource("RPtBillingDataSet_getservicetax", ds2.GetData());

        ReportViewer1.LocalReport.DataSources.Add(report3DataSource);
        ReportViewer1.Visible = true;
        lockunlockbutton();
        ReportViewer1.LocalReport.Refresh();
    }

    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {


    }
    protected void ddlVendor_SelectedIndexChanged(object sender, EventArgs e)
    {


    }
    protected void btnLockCost_Click(object sender, EventArgs e)
    {
        tmscontext.CostLock(Convert.ToInt32(ddlMonth.SelectedValue), Convert.ToInt32(ddlYear.SelectedValue), Convert.ToInt32(ddlFacility.SelectedValue), DateTime.Now.Date, MyApplicationSession._UserID);
        lockunlockbutton();
    }
    protected void lockunlockbutton()
    {
        string res = tmscontext.ISCostLock(Convert.ToInt32(ddlMonth.SelectedValue), Convert.ToInt32(ddlYear.SelectedValue), Convert.ToInt32(ddlFacility.SelectedValue), DateTime.Now.Date, MyApplicationSession._UserID).ElementAtOrDefault(0).result.ToString();
        if (res == "1")
        {
            btnunlock.Visible = true;
            btnLockCost.Visible = false;
        }
        else
        {
            btnLockCost.Visible = true;
            btnunlock.Visible = false;
         }
    }
    protected void btnunlock_Click(object sender, EventArgs e)
    {
        tmscontext.CostUnLock(Convert.ToInt32(ddlMonth.SelectedValue), Convert.ToInt32(ddlYear.SelectedValue), Convert.ToInt32(ddlFacility.SelectedValue),  MyApplicationSession._UserID);
        lockunlockbutton();
    }
}
