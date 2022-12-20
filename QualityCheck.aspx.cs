using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class QualityCheck : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
 
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
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
        string EndDate = txtStartDate.Text;
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
       grdQualityCheck.DataSource=tmscontext.PlannedVsActualTrip(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Cabids, Convert.ToInt32(rdbtnWeektype.SelectedValue), Convert.ToInt32(ddlbillingtripType.SelectedValue));
       grdQualityCheck.DataBind();
       if (grdQualityCheck.Rows.Count > 0)
       {
           btnQC.Visible = true;
           btnExport.Visible = true;
       }
       else
       {
           btnQC.Visible = false;
           btnExport.Visible = false;
       }
        
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
        lstCabID.SelectedIndex = 0;
    }
    protected void ddlVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        lstCabID.Items.Clear();
        ListItem licab = new ListItem("Select cabid", "0");
        lstCabID.Items.Add(licab);

        lstCabID.DataSource = tmscontext.SelectVehiclebyVendor(Convert.ToInt32(ddlVendor.SelectedValue));
        lstCabID.DataTextField = "vehicleNo";
        lstCabID.DataValueField = "vehicleNo";
        lstCabID.DataBind();
        lstCabID.SelectedIndex = 0;

    }
    protected void btnQC_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < grdQualityCheck.Rows.Count; i++)
        {

            DateTime dt = Convert.ToDateTime(grdQualityCheck.Rows[i].Cells[0].Text.ToString());
            int cabid = Convert.ToInt32(grdQualityCheck.Rows[i].Cells[1].Text.ToString());

            int actualtrips = Convert.ToInt32(grdQualityCheck.Rows[i].Cells[3].Text.ToString());
            int vendortrips = Convert.ToInt32(((TextBox)grdQualityCheck.Rows[i].FindControl("txtVendortrips")).Text);
            int actualempcount = Convert.ToInt32(grdQualityCheck.Rows[i].Cells[6].Text.ToString());
            int vendorempcount = Convert.ToInt32(((TextBox)grdQualityCheck.Rows[i].FindControl("txtparttrips")).Text == "" ? "0" : ((TextBox)grdQualityCheck.Rows[i].FindControl("txtparttrips")).Text);
            tmscontext.InsertFQC(dt, Convert.ToInt32(ddlFacility.SelectedValue), cabid, actualtrips, vendortrips, MyApplicationSession._UserID,actualempcount,vendorempcount);
        }
        ShowMessage("Quality Check Done");
        string Startdate = txtStartDate.Text;
        string EndDate = txtStartDate.Text;
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
        grdQualityCheck.DataSource = tmscontext.PlannedVsActualTrip(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Cabids, Convert.ToInt32(rdbtnWeektype.SelectedValue), Convert.ToInt32(ddlbillingtripType.SelectedValue));
        grdQualityCheck.DataBind();
        if (grdQualityCheck.Rows.Count > 0)
        {
            btnQC.Visible = true;
            btnExport.Visible = true;
        }
        else
        {
            btnQC.Visible = false;
            btnExport.Visible = false;
        }
        
    }

    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
    protected void btnExport_Click(object sender, EventArgs e)
    {
        string Startdate = txtStartDate.Text;
        string EndDate = txtStartDate.Text;
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
        }
            Cabids = Cabids.Remove(Cabids.Length - 1, 1);
            GridView gvcheck = new GridView();
            gvcheck.DataSource = tmscontext.PlannedVsActualTrip(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Cabids, Convert.ToInt32(rdbtnWeektype.SelectedValue), Convert.ToInt32(ddlbillingtripType.SelectedValue));
            gvcheck.DataBind();
            GridViewExportUtil.Export("QualityCheck.xls", gvcheck);
        
    }
    public System.Drawing.Color GetColor(object R1,Object R2)
    {

        int ID = Convert.ToInt32(R1) - Convert.ToInt32(R2);
        if (ID == 0)
            return System.Drawing.Color.White;

        return System.Drawing.Color.Yellow;

    }
    protected void btnCompleteQualitycheckk_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < grdQualityCheck.Rows.Count; i++)
        {

            DateTime dt = Convert.ToDateTime(grdQualityCheck.Rows[i].Cells[0].Text.ToString());
            int cabid = Convert.ToInt32(grdQualityCheck.Rows[i].Cells[1].Text.ToString());

            int actualtrips = Convert.ToInt32(grdQualityCheck.Rows[i].Cells[3].Text.ToString());
            int vendortrips = Convert.ToInt32(((TextBox)grdQualityCheck.Rows[i].FindControl("txtVendortrips")).Text);
            int actualempcount = Convert.ToInt32(grdQualityCheck.Rows[i].Cells[6].Text.ToString());
            int vendorempcount = Convert.ToInt32(((TextBox)grdQualityCheck.Rows[i].FindControl("txtparttrips")).Text == "" ? "0" : ((TextBox)grdQualityCheck.Rows[i].FindControl("txtparttrips")).Text);
            tmscontext.InsertFQCFreeze(dt, Convert.ToInt32(ddlFacility.SelectedValue), cabid, actualtrips, vendortrips, MyApplicationSession._UserID, actualempcount, vendorempcount);
        }
        ShowMessage("Quality Check Freezed");
        string Startdate = txtStartDate.Text;
        string EndDate = txtStartDate.Text;
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
        grdQualityCheck.DataSource = tmscontext.PlannedVsActualTrip(Convert.ToDateTime(Startdate), Convert.ToDateTime(EndDate), Convert.ToInt32(FacilityID), Cabids, Convert.ToInt32(rdbtnWeektype.SelectedValue), Convert.ToInt32(ddlbillingtripType.SelectedValue));
        grdQualityCheck.DataBind();
        if (grdQualityCheck.Rows.Count > 0)
        {
            btnQC.Visible = true;
            btnExport.Visible = true;
        }
        else
        {
            btnQC.Visible = false;
            btnExport.Visible = false;
        }
        

    }
}
