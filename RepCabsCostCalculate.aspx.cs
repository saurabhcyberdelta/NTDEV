using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using RPtBillingDataSetTableAdapters;
public partial class RepCabsCostCalculate : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    RepCabCostCalculationTableAdapter ds = new RepCabCostCalculationTableAdapter();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                txtEndDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
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
            lstCabID.Items.Clear();
            ListItem licab = new ListItem("Select Cabid", "0");
            lstCabID.Items.Add(licab);
            lstCabID.DataBind();
            lstCabID.SelectedIndex = 0;
            ddlbillingtripType.DataSource = tmscontext.GetBillingtripType();
            ddlbillingtripType.DataTextField = "BillingTripType";
            ddlbillingtripType.DataValueField = "ID";
            ddlbillingtripType.DataBind();
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

        string Cabids = string.Empty;
        if (lstCabID.SelectedIndex >= 0)
        {
            for (int i = 0; i < lstCabID.Items.Count; i++)
            {
                if (lstCabID.Items[i].Selected)
                {
                    Cabids = Cabids + lstCabID.Items[i].Text.Trim() + ",";
                }

            }
            Cabids = Cabids.Remove(Cabids.Length - 1, 1);
        }
        ReportViewer1.LocalReport.ReportPath = "RepCabcostCalculation.rdlc";
        ReportDataSource report1DataSource = new ReportDataSource("RPtBillingDataSet_RepCabCostCalculation", ds.GetData(Convert.ToDateTime(Startdate),Convert.ToDateTime( EndDate), Convert.ToInt32(FacilityID), Cabids,Convert.ToInt32(rdbtnWeektype.SelectedValue),Convert.ToInt32(ddlbillingtripType.SelectedValue)));
        ReportViewer1.LocalReport.DataSources.Clear();

        ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
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
        ddlVendor.DataValueField="Id";
        ddlVendor.DataBind();
        lstCabID.SelectedIndex = 0;
    }
    protected void ddlVendor_SelectedIndexChanged(object sender, EventArgs e)
        {  lstCabID.Items.Clear();
           ListItem licab = new ListItem("Select cabid", "0");
           lstCabID.Items.Add(licab);
       
           lstCabID.DataSource=tmscontext.SelectVehiclebyVendor(Convert.ToInt32(ddlVendor.SelectedValue));
           lstCabID.DataTextField = "vehicleNo";
           lstCabID.DataValueField = "vehicleNo";
           lstCabID.DataBind();
           lstCabID.SelectedIndex = 0;

    }
}
