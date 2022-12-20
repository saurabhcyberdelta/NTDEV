using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class rptDummy : System.Web.UI.Page
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
   
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

                txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                txtEndDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                BndCabTypeDropdown();


            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    public void BndCabTypeDropdown()
    {
        try
        {
            ddlCabType.Items.Clear();
            ListItem liv = new ListItem("-Select-", "0");
            ddlCabType.Items.Add(liv);
            ddlCabType.DataSource = tmscontext.SelectAllFacility();
            ddlCabType.DataTextField = "facilityname";
            ddlCabType.DataValueField = "ID";
            ddlCabType.DataBind();
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
        string facility = ddlCabType.SelectedValue;
        GridView1.DataSource = tmscontext.rptDummyTypeAll(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(facility));
        GridView1.DataBind();
        GridViewExportUtil.Export("Dummyreport.xls", GridView1);





    }
}