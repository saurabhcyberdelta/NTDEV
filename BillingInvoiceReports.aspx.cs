using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using RPtBillingDataSetTableAdapters;
using System.Data;
using System.IO;
using System.Drawing;

public partial class BillingInvoiceReports : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    VendorInvoiceSummaryTableAdapter ds = new VendorInvoiceSummaryTableAdapter();
    GvInvoiceSummaryTableAdapter ds1 = new GvInvoiceSummaryTableAdapter();
    static int x=0;
    static int y=0;
    static string fac = "";
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
                BndNOSNOLDetailedRPT();
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
            if(ddlFacility.SelectedValue == "6") 
            {
                fac = "5";
            }
            else
            {
                fac = ddlFacility.SelectedValue;
            }
            ddlVendor.Items.Clear();
            ListItem liv = new ListItem("Select Vendor", "0");
            //ListItem liv1 = new ListItem("All Vendor", "0");
            ddlVendor.Items.Add(liv);
            //ddlVendor.Items.Add(liv1);
            ddlVendor.DataSource = tmscontext.GetVendorByFacility(Convert.ToInt32(fac));
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
            ReportViewer1.LocalReport.ReportPath = "InvoiceSummary.rdlc";
            ReportDataSource report1DataSource = new ReportDataSource("RPtBillingDataSet_VendorInvoiceSummary", ds.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4,1));
            //ReportDataSource report4DataSource = new ReportDataSource("RPtBillingDataSet_SlabCostCalculation", ds3.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4));
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
            //ReportViewer1.LocalReport.DataSources.Add(report4DataSource);
            ReportViewer1.Visible = true;
            ReportViewer1.LocalReport.Refresh();

            MultiView1.ActiveViewIndex = -1;
            MultiView2.ActiveViewIndex = -1;
        }
        else if (rdbreptype.SelectedValue == "2")
        {
            //if (FacilityID == "5")
            //{
            //    x = 2;
            //    y = 1;
            //    BndNOSRptGrid(x,y);
            //}
            //else if(FacilityID == "6")
            //{
            //    x = 2;
            //    y = 2;
            //    BndNOSRptGrid(x, y);
            //}
            //else
            //{
                ReportViewer1.Reset();
                ReportViewer1.LocalReport.ReportPath = "GVTInvoiceSummary.rdlc";
                ReportDataSource report1DataSource = new ReportDataSource("RPtBillingDataSet_GvInvoiceSummary", ds1.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 2, 1));
                //ReportDataSource report4DataSource = new ReportDataSource("RPtBillingDataSet_SlabCostCalculation", ds3.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4));
                ReportViewer1.LocalReport.DataSources.Clear();
                ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
                //ReportViewer1.LocalReport.DataSources.Add(report4DataSource);
                ReportViewer1.Visible = true;
                ReportViewer1.LocalReport.Refresh();


                MultiView1.ActiveViewIndex = -1;
                MultiView2.ActiveViewIndex = -1;

            //}

        }
        else if (rdbreptype.SelectedValue == "3")
        {
            if (FacilityID == "5")
            {
                x = 3;
                y = 0;
                BndNOSRptGrid(x, y);
            }
            else if (FacilityID == "6")
            {
                x = 3;
                y = 0;
                BndNOSRptGrid(x, y);
            }
            else
            {
                ReportViewer1.Reset();
                ReportViewer1.LocalReport.ReportPath = "GVTInvoiceSummary.rdlc";
                ReportDataSource report1DataSource = new ReportDataSource("RPtBillingDataSet_GvInvoiceSummary", ds1.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 3, 1));
                //ReportDataSource report4DataSource = new ReportDataSource("RPtBillingDataSet_SlabCostCalculation", ds3.GetData(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Convert.ToInt32(vendorid), 4));
                ReportViewer1.LocalReport.DataSources.Clear();
                ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
                //ReportViewer1.LocalReport.DataSources.Add(report4DataSource);
                ReportViewer1.Visible = true;
                ReportViewer1.LocalReport.Refresh();


                MultiView1.ActiveViewIndex = -1;
                MultiView2.ActiveViewIndex = -1;
            }
        }
        else if (rdbreptype.SelectedValue == "4" || rdbreptype.SelectedValue == "5")
        {
            if (FacilityID == "5" || FacilityID == "6")
            {
                if(rdbreptype.SelectedValue == "4")
                {
                    x = 2;
                }
                else
                {
                    x = 3;
                }
                y = 1;
                BndNOSNOLRptGrid(x, y);
            }
        }

    }
    public void BndNOSRptGrid(int billCat,int beClear)
    {
        try
        {
            ReportViewer1.Visible = false;

            MultiView2.ActiveViewIndex = -1;
            GVNOSReport.DataSource = tmscontext.PuneGvInvoiceSummary(Convert.ToDateTime(txtStartDate.Text), Convert.ToDateTime(txtEndDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), Convert.ToInt32(ddlVendor.SelectedValue), billCat, 1,y);
            //GVNOSReport.DataSource = tmscontext.PuneGvInvoiceSummary(Convert.ToDateTime(txtStartDate.Text), Convert.ToDateTime(txtEndDate.Text), 6, 25, billCat, 1,y);
            GVNOSReport.DataBind();

            MultiView1.ActiveViewIndex = 0;

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    public void BndNOSNOLRptGrid(int billCat, int beClear)
    {
        try
        {
            ReportViewer1.Visible = false;
            MultiView1.ActiveViewIndex = -1;
            NOSNOLRptGrid.DataSource = tmscontext.PuneGvInvoiceSummary(Convert.ToDateTime(txtStartDate.Text), Convert.ToDateTime(txtEndDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), Convert.ToInt32(ddlVendor.SelectedValue), billCat, 1, y);
            //GVNOSReport.DataSource = tmscontext.PuneGvInvoiceSummary(Convert.ToDateTime(txtStartDate.Text), Convert.ToDateTime(txtEndDate.Text), 6, 25, billCat, 1,y);
            NOSNOLRptGrid.DataBind();

            MultiView2.ActiveViewIndex = 0;


        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        BndVendorDropdown();
        BndNOSNOLDetailedRPT();


    }

    public void BndNOSNOLDetailedRPT()
    {
        if (Convert.ToInt32(ddlFacility.SelectedValue) == 5 || Convert.ToInt32(ddlFacility.SelectedValue) == 6)
        {
            rdbreptype.Items.Clear();
            ListItem l1 = new ListItem("-Select-", "0");
            ListItem l2 = new ListItem("Vendor Invoice Summary", "1");
            ListItem l3 = new ListItem("GVT Invoice Summary", "2");
            ListItem l4 = new ListItem("Pune Invoice Summary", "3");
            // ListItem l5 = new ListItem("GVT Invoice Summary (Detailed)", "4");
            ListItem l6 = new ListItem("Pune Invoice Summary (Detailed)", "5");
            rdbreptype.Items.Add(l1);
            rdbreptype.Items.Add(l2);
            rdbreptype.Items.Add(l3);
            rdbreptype.Items.Add(l4);
            //  rdbreptype.Items.Add(l5);
            rdbreptype.Items.Add(l6);
        }
        else
        {
            rdbreptype.Items.Clear();
            ListItem l1 = new ListItem("-Select-", "0");
            ListItem l2 = new ListItem("Vendor Invoice Summary", "1");
            ListItem l3 = new ListItem("GVT Invoice Summary", "2");
            ListItem l4 = new ListItem("Pune Invoice Summary", "3");
            rdbreptype.Items.Add(l1);
            rdbreptype.Items.Add(l2);
            rdbreptype.Items.Add(l3);
            rdbreptype.Items.Add(l4);
        }
    }
    protected void GVNOSReport_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

    }

    protected void GVNOSReport_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }

    protected void GVNOSReport_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {

    }

    protected void GVNOSReport_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }

    protected void GVNOSReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        //required to avoid the runtime error "  
        //Control 'GridView1' of type 'GridView' must be placed inside a form tag with runat=server."  
    }
    protected void lbtnPritGuardSheet_Click(object sender, EventArgs e)
    {
        string rpt = "";
        rpt= (x == 3) ? "Pune" : "GVT";


        //Niave method to export
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = "NT" + rpt + "InvoiceSummary" + DateTime.Now + ".xls";
        StringWriter strwritter = new StringWriter();
        HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
        GVNOSReport.GridLines = GridLines.Both;
        GVNOSReport.HeaderStyle.Font.Bold = true;
        GVNOSReport.HeaderRow.BackColor = Color.White;

        GVNOSReport.RenderControl(htmltextwrtter);
        Response.Write(strwritter.ToString());
        Response.End();






        //GridView gvRpt = new GridView();
        //tmscontext.CommandTimeout = 0;
        //// gvRpt.DataSource = tmscontext.testPuneGvInvoiceSummary(Convert.ToDateTime(txtStartDate.Text), Convert.ToDateTime(txtEndDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), Convert.ToInt32(ddlVendor.SelectedValue), x, 1,y);
        //gvRpt.DataSource = tmscontext.testPuneGvInvoiceSummary(Convert.ToDateTime(txtStartDate.Text), Convert.ToDateTime(txtEndDate.Text), 6, 25, 3, 1, y);
        //gvRpt.DataBind();
        //GridViewExportUtil.Export("NOS"+rpt+"InvoiceSummary"+DateTime.Now+".xls", gvRpt);
        x = 0;

    }

    protected void lnkPrintNOSNOL_Click(object sender, EventArgs e)
    {
        string rpt = "";
        rpt = (x == 3) ? "Pune" : "GVT";


        //Niave method to export
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = "TAB"+ rpt + "InvoiceSummary" + DateTime.Now + ".xls";
        StringWriter strwritter = new StringWriter();
        HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
        NOSNOLRptGrid.GridLines = GridLines.Both;
        NOSNOLRptGrid.HeaderStyle.Font.Bold = true;
        NOSNOLRptGrid.HeaderRow.BackColor = Color.White;

        NOSNOLRptGrid.RenderControl(htmltextwrtter);
        Response.Write(strwritter.ToString());
        Response.End();
         x = 0;
    }
}