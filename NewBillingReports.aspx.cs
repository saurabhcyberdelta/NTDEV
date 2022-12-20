using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using RPtBillingDataSetTableAdapters;

public partial class NewBillingReports : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    SlabDetailBillingTableAdapter ds = new SlabDetailBillingTableAdapter();
    MedicalDetailBillingTableAdapter ds1 = new MedicalDetailBillingTableAdapter();
    AdditionalDetailBillingTableAdapter ds2 = new AdditionalDetailBillingTableAdapter();
    SlabCostCalculationTableAdapter ds3 = new SlabCostCalculationTableAdapter();
    FTELTEBillingTableAdapter ds4 = new FTELTEBillingTableAdapter();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                txtEndDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                BndFacilityDropdown();
                BndVendorDropdown();

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    public void BndVendorDropdown()
    {
        try
        {
            ddlVendor.Items.Clear();
            ListItem liv = new ListItem("Select Vendor", "-1");
            ListItem liv1 = new ListItem("All Vendor", "0");
            ddlVendor.Items.Add(liv);
            ddlVendor.Items.Add(liv1);
            ddlVendor.DataSource = tmscontext.GetVendorByFac(Convert.ToInt32(ddlFacility.SelectedValue));
            ddlVendor.DataTextField = "VendorName";
            ddlVendor.DataValueField = "Id";
            ddlVendor.DataBind();
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
            ddlFacility.SelectedIndex = ddlFacility.Items.IndexOf(ddlFacility.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));
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
        string vendorid = ddlVendor.SelectedValue;
        if (rdbreptype.SelectedValue == "1")
        {
            ReportViewer1.Reset();
            ReportViewer1.LocalReport.ReportPath = "RptSlabBilling.rdlc";
            ReportDataSource report1DataSource = new ReportDataSource("RPtBillingDataSet_SlabDetailBilling", ds.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4,Convert.ToInt32(rdbWeekType.SelectedValue)));
            //ReportDataSource report4DataSource = new ReportDataSource("RPtBillingDataSet_SlabCostCalculation", ds3.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4));
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
            //ReportViewer1.LocalReport.DataSources.Add(report4DataSource);
            ReportViewer1.Visible = true;
            ReportViewer1.LocalReport.Refresh();
        }
        else if (rdbreptype.SelectedValue == "2")
        {
            //ReportViewer1.Reset();
            //ReportViewer1.LocalReport.ReportPath = "MedicalDetailBilling.rdlc";
            //ReportDataSource report2DataSource = new ReportDataSource("RPtBillingDataSet_MedicalDetailBilling", ds1.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4, Convert.ToInt32(rdbWeekType.SelectedValue)));
            //ReportViewer1.LocalReport.DataSources.Clear();
            //ReportViewer1.LocalReport.DataSources.Add(report2DataSource);
            //ReportViewer1.Visible = true;
            //ReportViewer1.LocalReport.Refresh();
            GridView gv = new GridView();
            

            gv.DataSource = tmscontext.MedicalBillingReport(Convert.ToInt32(FacilityID), Convert.ToInt32(ddlVendor.SelectedValue), Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate));
            gv.DataBind();
            gv.Caption = "Medical Cab Billing.";

            gv.HeaderRow.BackColor = System.Drawing.Color.Green;
            gv.HeaderRow.Font.Bold = true;
            gv.HeaderRow.ForeColor = System.Drawing.Color.White;

            GridViewExportUtil.Export("MedicalBillingReport" + DateTime.Now + ".xls", gv);

        }
        else if (rdbreptype.SelectedValue == "3")
        {
            ReportViewer1.Reset();
            ReportViewer1.LocalReport.ReportPath = "AdditionalDetailBilling.rdlc";
            ReportDataSource report3DataSource = new ReportDataSource("RPtBillingDataSet_AdditionalDetailBilling", ds2.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4, Convert.ToInt32(rdbWeekType.SelectedValue)));
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(report3DataSource);
            ReportViewer1.Visible = true;
            ReportViewer1.LocalReport.Refresh();
        }
        else if (rdbreptype.SelectedValue == "4")
        {
            ReportViewer1.Reset();
            ReportViewer1.LocalReport.ReportPath = "SlabCostCalculation.rdlc";
            ReportDataSource report4DataSource = new ReportDataSource("RPtBillingDataSet_SlabCostCalculation", ds3.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4, Convert.ToInt32(rdbWeekType.SelectedValue)));
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(report4DataSource);
            ReportViewer1.Visible = true;
            ReportViewer1.LocalReport.Refresh();
        }
        else if (rdbreptype.SelectedValue == "5")
        {
            ReportViewer1.Reset();
            ReportViewer1.LocalReport.ReportPath = "FTE-LTEBilling.rdlc";
            ReportDataSource report5DataSource = new ReportDataSource("RPtBillingDataSet_FTELTEBilling", ds4.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4, Convert.ToInt32(rdbWeekType.SelectedValue)));
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(report5DataSource);
            ReportViewer1.Visible = true;
            ReportViewer1.LocalReport.Refresh();
        }
        else if (rdbreptype.SelectedValue == "6")
        {
            GridView gv1 = new GridView();
            gv1.DataSource = tmscontext.GvTripBasisBilling(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 6, Convert.ToInt32(rdbWeekType.SelectedValue));
            gv1.DataBind();
            gv1.Caption = "GV trip billing:" + " " + txtStartDate.Text + " To:" + txtEndDate.Text;
            gv1.CaptionAlign = System.Web.UI.WebControls.TableCaptionAlign.Left;   
            GridViewExportUtil.Export("GvTripBilling.XLS", gv1);
        }
        else if (rdbreptype.SelectedValue == "7")
        {
            GridView gv1 = new GridView();
                gv1.DataSource = tmscontext.GvTripBasisBilling(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 7, Convert.ToInt32(rdbWeekType.SelectedValue));
            gv1.DataBind();
            gv1.Caption = "Pune trip billing:" + " " + txtStartDate.Text + " To:" + txtEndDate.Text;
            gv1.CaptionAlign = System.Web.UI.WebControls.TableCaptionAlign.Left;
            GridViewExportUtil.Export("PuneTripBilling.XLS", gv1);
        }
        else if (rdbreptype.SelectedValue == "8")
        {
            GridView gv1 = new GridView();
            gv1.DataSource = tmscontext.MedicalCabBillingReport(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 6, Convert.ToInt32(rdbWeekType.SelectedValue));
            gv1.DataBind();
            gv1.Caption = "Kss medical billing:" + " " + txtStartDate.Text + " To:" + txtEndDate.Text;
            gv1.CaptionAlign = System.Web.UI.WebControls.TableCaptionAlign.Left;
            GridViewExportUtil.Export("KssMedicalbilling"+DateTime.Now+".XLS", gv1);
        }
        else if (rdbreptype.SelectedValue == "9")
        {
            GridView gv1 = new GridView();
            gv1.DataSource = tmscontext.PerEmpBilling(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 6, Convert.ToInt32(rdbWeekType.SelectedValue));
            gv1.DataBind();
            gv1.Caption = "Per Employee Cost:" + " " + txtStartDate.Text + " To:" + txtEndDate.Text;
            gv1.CaptionAlign = System.Web.UI.WebControls.TableCaptionAlign.Left;
            GridViewExportUtil.Export("PerEmployeeCost" + DateTime.Now + ".XLS", gv1);
        }
        else if (rdbreptype.SelectedValue == "10")
        {
            GridView gv1 = new GridView();
            gv1.DataSource = tmscontext.ProcessWiseBilling(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 6, Convert.ToInt32(rdbWeekType.SelectedValue));
            gv1.DataBind();
            gv1.Caption = "Process Wise Billing:" + " " + txtStartDate.Text + " To:" + txtEndDate.Text;
            gv1.CaptionAlign = System.Web.UI.WebControls.TableCaptionAlign.Left;
            GridViewExportUtil.Export("ProcessWiseBilling" + DateTime.Now + ".XLS", gv1);
        }
        //string Startdate = txtStartDate.Text;
        //string EndDate = txtEndDate.Text;
        //string FacilityID = ddlFacility.SelectedValue;
        //string vendorid = ddlVendor.SelectedValue;

        //ReportDataSource report1DataSource = new ReportDataSource("RPtBillingDataSet_SlabDetailBilling", ds.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4));

        //ReportDataSource report2DataSource = new ReportDataSource("RPtBillingDataSet_MedicalDetailBilling", ds1.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4));

        //ReportDataSource report3DataSource = new ReportDataSource("RPtBillingDataSet_AdditionalDetailBilling", ds2.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4));
        //ReportViewer1.LocalReport.DataSources.Clear();

        //ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
        //ReportViewer1.LocalReport.DataSources.Add(report2DataSource);
        //ReportViewer1.LocalReport.DataSources.Add(report3DataSource);
        //ReportViewer1.Visible = true;
        //ReportViewer1.LocalReport.Refresh();

    }
    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        BndVendorDropdown();
    }
}