using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class tripBasisCostMaster : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bndfacilitydrop();
            bndGridCost();
            mvCost.ActiveViewIndex = 0;
        }
    }

    protected void bndfacilitydrop()
    {
        ddlSelectFacility.Items.Clear();
        ddlSelectFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
        ddlSelectFacility.DataTextField = "facilityName";
        ddlSelectFacility.DataValueField = "Id";
        ddlSelectFacility.DataBind();
        ListItem liFacIn = new ListItem("-Select Facility-", "0");
        ddlSelectFacility.Items.Insert(0, liFacIn);

        ddlSelectFacility.SelectedIndex = ddlSelectFacility.Items.IndexOf(ddlSelectFacility.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));


    }
    protected void ddlSelectFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndGridCost();
        mvCost.ActiveViewIndex = 0;
    }
    void bndGridCost()
    {
        gvCost.DataSource = tms.GettripBasisCost(Convert.ToInt32(ddlSelectFacility.SelectedValue));
        gvCost.DataBind();
        if (gvCost.Rows.Count < 1)
        {
            mvCost.ActiveViewIndex = 1;
            BndDvDropDown();

        }
        else
        {

            mvCost.ActiveViewIndex = 0;
        }
    }
    protected void lbtnAddNew_Click(object sender, EventArgs e)
    {
        mvCost.ActiveViewIndex = 1;
        BndDvDropDown();
        TextBox effectiveDate = (TextBox)dvCost.FindControl("txtEffectiveDate");
        TextBox NewRate = (TextBox)dvCost.FindControl("txtnewRate");
        TextBox NewacRate = (TextBox)dvCost.FindControl("txtnewacRate");
        effectiveDate.Text = string.Empty;
        NewRate.Text = string.Empty;
        NewacRate.Text = string.Empty;
    }
    protected void BndDvDropDown()
    {
        DropDownList ddlveh = (DropDownList)dvCost.FindControl("ddlVehicleType");
        ddlveh.Items.Clear();
        ListItem liveh = new ListItem("Select Vehicle", "0");
        ddlveh.Items.Add(liveh);
        ddlveh.DataSource = tms.GetVehicleType();
        ddlveh.DataTextField = "vehicle";
        ddlveh.DataValueField = "Id";
        ddlveh.DataBind();
        DropDownList ddlVendor = (DropDownList)dvCost.FindControl("ddlVendor");
		ListItem livev = new ListItem("All Vendor", "0");
        ListItem livev1 = new ListItem("Select Vendor", "-1");
        ddlVendor.Items.Clear();
        ddlVendor.Items.Add(livev1);
        ddlVendor.Items.Add(livev);
        ddlVendor.DataSource = tms.GetVendorByFac(Convert.ToInt32(ddlSelectFacility.SelectedValue));
        ddlVendor.DataTextField = "vendorName";
        ddlVendor.DataValueField = "Id";
        ddlVendor.DataBind();

    }

    protected void dvCost_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        DropDownList ddlveh = (DropDownList)dvCost.FindControl("ddlVehicleType");
        TextBox effectiveDate = (TextBox)dvCost.FindControl("txtEffectiveDate");
        TextBox NewRate = (TextBox)dvCost.FindControl("txtnewRate");
        TextBox NewacRate = (TextBox)dvCost.FindControl("txtnewacRate");
        TextBox FuelRate = (TextBox)dvCost.FindControl("txtFuelRate");
        DropDownList ddlVendor = (DropDownList)dvCost.FindControl("ddlVendor");
        String Result = tms.AddNewTripBasisCost(Convert.ToDateTime(effectiveDate.Text), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToDouble(NewRate.Text), Convert.ToInt32(ddlVendor.SelectedValue), MyApplicationSession._UserID, Convert.ToDouble(NewacRate.Text), Convert.ToDouble(FuelRate.Text)).ElementAtOrDefault(0).Result.ToString();
        if (Result == "1")
        {
            lblErrorMsg.Visible = false;
            mvCost.ActiveViewIndex = 0;
            bndGridCost();
        }
        else
        {
            ShowMessage("Date Could Not be less than the Past Dates");
            lblErrorMsg.Text = "Date Could Not be less than the Past Dates";
            lblErrorMsg.Visible = true;
        }
    }
    protected void dvCost_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.CancelingEdit == true || e.Cancel == true)
        {
            mvCost.ActiveViewIndex = 0;
            gvCost.EditIndex = -1;
            bndGridCost();
        }
    }
    protected void lbtnAdd_Click(object sender, EventArgs e)
    {
        mvCost.ActiveViewIndex = 2;
        NewBndDvDropDown();
        DropDownList ddlveh = (DropDownList)dvAddnewvendor.FindControl("ddlVehicleType01");
        TextBox effectiveDate = (TextBox)dvAddnewvendor.FindControl("txtDVEffectiveDate");
        TextBox NewRate = (TextBox)dvAddnewvendor.FindControl("txtnewRate01");
        TextBox NewACRate = (TextBox)dvAddnewvendor.FindControl("txtnewacRate01");
        TextBox FuelRate = (TextBox)dvAddnewvendor.FindControl("txtFuelRate01");
        DropDownList ddlVendor = (DropDownList)dvAddnewvendor.FindControl("ddlVendor01");
       
        effectiveDate.Text = string.Empty;
        NewRate.Text = string.Empty;
        NewACRate.Text = string.Empty;
        FuelRate.Text = string.Empty;
      
    }
    protected void NewBndDvDropDown()
    {
        DropDownList ddlveh = (DropDownList)dvAddnewvendor.FindControl("ddlVehicleType01");
        ddlveh.Items.Clear();
        ListItem liveh = new ListItem("Select Vehicle", "0");
        ddlveh.Items.Add(liveh);
        ddlveh.DataSource = tms.GetVehicleType();
        ddlveh.DataTextField = "vehicle";
        ddlveh.DataValueField = "Id";
        ddlveh.DataBind();
        DropDownList ddlVendor = (DropDownList)dvAddnewvendor.FindControl("ddlVendor01");
		ListItem livev = new ListItem("All Vendor", "0");
        ListItem livev1 = new ListItem("Select Vendor", "-1");
        ddlVendor.Items.Clear();
        ddlVendor.Items.Add(livev1);
        ddlVendor.Items.Add(livev);
        ddlVendor.DataSource = tms.GetVendorByFac(Convert.ToInt32(ddlSelectFacility.SelectedValue));
        ddlVendor.DataTextField = "vendorName";
        ddlVendor.DataValueField = "Id";
        ddlVendor.DataBind();

    }
    protected void dvAddnewvendor_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.CancelingEdit == true || e.Cancel == true)
        {
            mvCost.ActiveViewIndex = 0;
            gvCost.EditIndex = -1;
            bndGridCost();
        }
    }
    protected void dvAddnewvendor_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        DropDownList ddlveh = (DropDownList)dvAddnewvendor.FindControl("ddlVehicleType01");
        TextBox effectiveDate = (TextBox)dvAddnewvendor.FindControl("txtDVEffectiveDate");
        TextBox NewRate = (TextBox)dvAddnewvendor.FindControl("txtnewRate01");
        TextBox NewACRate = (TextBox)dvAddnewvendor.FindControl("txtnewacRate01");
        TextBox FuelRate = (TextBox)dvAddnewvendor.FindControl("txtFuelRate01");
        DropDownList ddlVendor = (DropDownList)dvAddnewvendor.FindControl("ddlVendor01");


        String Result = tms.AddNewVendortripBasisCost(Convert.ToDateTime(effectiveDate.Text), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToDouble(NewRate.Text), Convert.ToInt32(ddlVendor.SelectedValue), MyApplicationSession._UserID, Convert.ToDouble(NewACRate.Text), Convert.ToDouble(FuelRate.Text)).ElementAtOrDefault(0).Result.ToString();
        if (Result == "1")
        {
            lblErrorMsg.Visible = false;
            mvCost.ActiveViewIndex = 0;
            bndGridCost();
        }
        else
        {
            ShowMessage("Data already exists for selected vendor");
            lblErrorMsg.Text = "Data already exists for selected vendor";
            lblErrorMsg.Visible = true;
        }
    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
}