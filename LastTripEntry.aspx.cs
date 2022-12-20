using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LastTripEntry : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
  
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
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
       

        bindGrid();
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
    protected void findlasttrip()
    {
        int i = 0;
        int rowcount = gvRoutesFinal.Rows.Count;
        int j=0;
        for (i = 0; i < rowcount-1; i++)
        {
        j=i+1;
        if (gvRoutesFinal.Rows[i].Cells[0].Text != gvRoutesFinal.Rows[j].Cells[0].Text)
        {
            // gvRoutesFinal.Rows[i].Style.Remove("RowStyle");

            gvRoutesFinal.Rows[i].BackColor = System.Drawing.Color.Green;
            ((CheckBox)gvRoutesFinal.Rows[i].FindControl("chkLasttrip")).Checked = true;

        }
        else
        {
            gvRoutesFinal.Rows[i].Attributes.Add("CssClass", "RowStyle");
            ((CheckBox)gvRoutesFinal.Rows[i].FindControl("chkLasttrip")).Checked = false ;
        }
        }
        if (rowcount > 0)
        {
            gvRoutesFinal.Rows[rowcount - 1].BackColor = System.Drawing.Color.Green;
            ((CheckBox)gvRoutesFinal.Rows[rowcount - 1].FindControl("chkLasttrip")).Checked = true;
        }
    }
    public Boolean getTrip(Object LastTrip)
    {
    if(Convert.ToString(LastTrip)=="1")
    {
        return true;
    }
        return false;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        int i = 0;
        for (i = 0; i < gvRoutesFinal.Rows.Count; i++)
        {
            string routeid = gvRoutesFinal.Rows[i].Cells[1].Text.ToString();
            CheckBox chkLasttrip = (CheckBox)gvRoutesFinal.Rows[i].FindControl("chkLasttrip");
            int flag=0;
            if(chkLasttrip.Checked==true)
            {
            flag=1;
            }
            tmscontext.updateLastTrip(routeid, flag, MyApplicationSession._UserID);
        }
        ShowMessage("Last Trip Updated successfully");
        bindGrid();
    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
    public void bindGrid()
    {
        string Startdate = txtStartDate.Text;

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
        gvRoutesFinal.DataSource = tmscontext.getLastTripEntry(Convert.ToDateTime(Startdate), Convert.ToDateTime(Startdate), Convert.ToInt32(FacilityID), Cabids);
        gvRoutesFinal.DataBind();
        findlasttrip();
    }
    protected void lbtnExport_Click(object sender, EventArgs e)
    {
        string Startdate = txtStartDate.Text;

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
        GridView gvlasttrip = new GridView();
        gvlasttrip.DataSource = tmscontext.getLastTripEntry(Convert.ToDateTime(Startdate), Convert.ToDateTime(Startdate), Convert.ToInt32(FacilityID), Cabids);
        gvlasttrip.DataBind();
        GridViewExportUtil.Export("LastripFile.xls", gvlasttrip);
    }
}
