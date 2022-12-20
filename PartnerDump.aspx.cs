using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PartnerDump : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BndDdl();
        }
    }
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        grdSitefile.DataSource = tms.GetEmployeeDump(Convert.ToInt32(rdbemp.SelectedValue),Convert.ToInt32(ddlfacility.SelectedValue));
        grdSitefile.DataBind();
        GridViewExportUtil.Export("PartnerDump.xls", grdSitefile);

    }
    public void BndDdl()
    {
        //**********************************//
        //Binds Facility Dropdown          //
        //*********************************//
        try
        {
            ddlfacility.Items.Clear();
            ListItem lifac = new ListItem("All Facilities", "0");
            ddlfacility.Items.Add(lifac);
            ddlfacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlfacility.DataTextField = "facilityName";
            ddlfacility.DataValueField = "Id";
            ddlfacility.DataBind();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }
}
