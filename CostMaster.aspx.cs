using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CostMaster : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bndfacilitydrop();
            bndGridCost();
            mvCost.ActiveViewIndex = 0;
            //string s = MyApplicationSession._ISAdmin.ToString();
            if (MyApplicationSession._ISAdmin == true)
            {
                gvCost.Columns[6].Visible = true;
            }
            else
            {
                gvCost.Columns[6].Visible = false;
            }
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
        gvCost.DataSource = tms.GetCost(Convert.ToInt32(ddlSelectFacility.SelectedValue));
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
        effectiveDate.Text = string.Empty;
        NewRate.Text = string.Empty;
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
        ListItem livev = new ListItem("Select Vendor", "0");
        ddlVendor.Items.Clear();
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
        DropDownList ddlVendor = (DropDownList)dvCost.FindControl("ddlVendor");
        String Result = tms.AddNewCost(Convert.ToDateTime(effectiveDate.Text), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToDouble(NewRate.Text),Convert.ToInt32(ddlVendor.SelectedValue)).ElementAtOrDefault(0).Result.ToString();
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
        DropDownList ddlVendor = (DropDownList)dvAddnewvendor.FindControl("ddlVendor01");
        TextBox NewFuelRate = (TextBox)dvAddnewvendor.FindControl("txtnewfuelRate01");
        effectiveDate.Text = string.Empty;
        NewRate.Text = string.Empty;
        NewFuelRate.Text = string.Empty;

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
        ListItem livev = new ListItem("Select Vendor", "0");
        ddlVendor.Items.Clear();
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
        DropDownList ddlVendor = (DropDownList)dvAddnewvendor.FindControl("ddlVendor01");
        TextBox NewFuelRate = (TextBox)dvAddnewvendor.FindControl("txtnewfuelRate01");

        String Result = tms.AddNewVendorCost(Convert.ToDateTime(effectiveDate.Text), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToDouble(NewRate.Text), Convert.ToInt32(ddlVendor.SelectedValue), Convert.ToDouble(NewFuelRate.Text)).ElementAtOrDefault(0).Result.ToString();
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
    protected void gvCost_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            string vendor = ((Label)gvCost.Rows[e.NewEditIndex].FindControl("lblVendor")).Text;
            string vehicle = ((Label)gvCost.Rows[e.NewEditIndex].FindControl("lblVehicle")).Text;

            gvCost.EditIndex = e.NewEditIndex;
            bndGridCost();

            DropDownList ddlVendor = ((DropDownList)gvCost.Rows[e.NewEditIndex].FindControl("ddlgvVendor"));
            DropDownList ddlVehicle = ((DropDownList)gvCost.Rows[e.NewEditIndex].FindControl("ddlgvVehicle"));
            ListItem lstVen = new ListItem("-Select-", "0");
            ListItem lstVeh = new ListItem("-Select-", "0");
            ddlVendor.Items.Clear();
            ddlVehicle.Items.Clear();
            ddlVendor.DataSource = tms.GetVendorByFac(Convert.ToInt32(ddlSelectFacility.SelectedValue));
            ddlVendor.Items.Add(lstVen);
            ddlVendor.DataTextField = "vendorName";
            ddlVendor.DataValueField = "Id";
            ddlVendor.DataBind();
            ddlVendor.SelectedIndex = ddlVendor.Items.IndexOf(ddlVendor.Items.FindByText(vendor));

            ddlVehicle.DataSource = tms.GetVehicleType();
            ddlVehicle.Items.Add(lstVen);
            ddlVehicle.DataTextField = "vehicle";
            ddlVehicle.DataValueField = "Id";
            ddlVehicle.DataBind();
            ddlVehicle.SelectedIndex = ddlVehicle.Items.IndexOf(ddlVehicle.Items.FindByText(vehicle));
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void gvCost_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            int rowId = Convert.ToInt32(gvCost.DataKeys[e.RowIndex].Value.ToString());
            int venId = Convert.ToInt32(((DropDownList)gvCost.Rows[e.RowIndex].FindControl("ddlgvVendor")).SelectedValue);
            int vehId = Convert.ToInt32(((DropDownList)gvCost.Rows[e.RowIndex].FindControl("ddlgvVehicle")).SelectedValue);
            decimal curFul = Convert.ToDecimal(((TextBox)gvCost.Rows[e.RowIndex].FindControl("txtgvFuleRate")).Text);
            decimal kmRate = Convert.ToDecimal(((TextBox)gvCost.Rows[e.RowIndex].FindControl("txtgvKmRate")).Text);
            string result = tms.UpdateCostMaster(rowId, vehId, venId, curFul, kmRate,MyApplicationSession._UserID).ElementAtOrDefault(0).RESULT.ToString();
            if (result.Equals("1"))
            {
                ShowMessage("Record Updated Successfully!");
                gvCost.EditIndex = -1;
                bndGridCost();
            }
            else
            {
                ShowMessage("Record Alredy Exists!");
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void gvCost_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        try
        {
            gvCost.EditIndex = -1;
            bndGridCost();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void gvCost_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvCost.PageIndex = e.NewPageIndex;

        bndGridCost();
    }
}
