using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using RPtBillingDataSetTableAdapters;

public partial class TripFinalCost : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    TripFinalBillingTableAdapter ds = new TripFinalBillingTableAdapter();
    RptVendorPenaltyBillTableAdapter ds1 = new RptVendorPenaltyBillTableAdapter();
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
            ddlVendor.Items.Clear();
            ListItem livendor = new ListItem("Select Vendor", "0");
            ddlVendor.Items.Add(livendor);
            ddlVendor.DataBind();
            

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

        string Cabids = "%";

        ReportViewer1.LocalReport.ReportPath = "TripFinalBillTransport.rdlc";
        ReportDataSource report1DataSource = new ReportDataSource("RPtBillingDataSet_TripFinalBilling", ds.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Cabids, Convert.ToInt32(ddlVendor.SelectedValue), Convert.ToInt32(0)));
        ReportViewer1.LocalReport.DataSources.Clear();

        ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
        ReportDataSource report2DataSource = new ReportDataSource("RPtBillingDataSet_RptVendorPenaltyBill", ds1.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), ddlVendor.SelectedValue));
        
        ReportViewer1.LocalReport.DataSources.Add(report2DataSource);
        ReportDataSource report3DataSource = new ReportDataSource("RPtBillingDataSet_getservicetax", ds2.GetData());

        ReportViewer1.LocalReport.DataSources.Add(report3DataSource);
        ReportViewer1.Visible = true;
        ReportViewer1.LocalReport.Refresh();
    }

    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlVendor.Items.Clear();
        ListItem livendor = new ListItem("Select Vendor", "0");
        ddlVendor.Items.Add(livendor);
        ddlVendor.DataSource = tmscontext.GetVendorByFac(Convert.ToInt32(ddlFacility.SelectedValue));
        ddlVendor.DataTextField = "vendorName";
        ddlVendor.DataValueField = "Id";
        ddlVendor.DataBind();
      
    }
    protected void ddlVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
       

    }
}
