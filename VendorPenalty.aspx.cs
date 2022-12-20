using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VendorPenalty : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bndfacilitydrop();
            bndGridCost();
            BndDvDropDown();
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

        BndDvDropDown();
    }
    protected void ddlSelectFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndGridCost();
        BndDvDropDown();
        mvCost.ActiveViewIndex = 0;
    }
    void bndGridCost()
    {
        gvCost.DataSource = tms.GetVendorPenalty(Convert.ToInt32(ddlSelectFacility.SelectedValue));
        gvCost.DataBind();
        if (gvCost.Rows.Count < 1)
        {
            mvCost.ActiveViewIndex = 2;
            BndDvDropDown();
        }
        else
        {
            mvCost.ActiveViewIndex = 0;
        }
    }
    protected void lbtnAddNew_Click(object sender, EventArgs e)
    {
        mvCost.ActiveViewIndex = 2;
        
        DropDownList ddlmonth = (DropDownList)dvAddnewvendor.FindControl("ddlMonth");
        DropDownList ddlvendor = (DropDownList)dvAddnewvendor.FindControl("ddlVendor");
        TextBox txtPenalty = (TextBox)dvAddnewvendor.FindControl("txtPenalty");
        BndDvDropDown();
        txtPenalty.Text = string.Empty;
    }
    protected void BndDvDropDown()
    {
        //DropDownList ddlveh = (DropDownList)dvCost.FindControl("ddlVehicleType");
        //ddlveh.Items.Clear();
        //ListItem liveh = new ListItem("Select Vehicle", "0");
        //ddlveh.Items.Add(liveh);
        //ddlveh.DataSource = tms.GetVehicleType();
        //ddlveh.DataTextField = "vehicle";
        //ddlveh.DataValueField = "Id";
        //ddlveh.DataBind();
        DropDownList ddlVendor = (DropDownList)dvAddnewvendor.FindControl("ddlVendorp");
        ListItem livev = new ListItem("Select Vendor", "0");
        ddlVendor.Items.Clear();
        ddlVendor.Items.Add(livev);
        ddlVendor.DataSource = tms.GetVendorByFacility(Convert.ToInt32(ddlSelectFacility.SelectedValue));
        ddlVendor.DataTextField = "VendorName";
        ddlVendor.DataValueField = "Id";
        ddlVendor.DataBind();

        //ShowMessage(ddlVendor.SelectedValue);

    }

    protected void dvCost_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        DropDownList ddlmonth = (DropDownList)dvCost.FindControl("ddlMonth");
        DropDownList ddlveh = (DropDownList)dvCost.FindControl("ddlVendor");
        TextBox txtPenalty = (TextBox)dvCost.FindControl("txtPenalty");
        String Result = tms.AddNewVendorPenalty(Convert.ToInt32(ddlSelectFacility.SelectedValue), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToInt32(ddlmonth.SelectedValue), Convert.ToDouble(txtPenalty.Text),Convert.ToInt32(MyApplicationSession._UserID)).ElementAtOrDefault(0).result.ToString();
        if (Result == "1")
        {
            ShowMessage("Record Added Successfully.");
            mvCost.ActiveViewIndex = 0;
            bndGridCost();
        }
        else
        {
            ShowMessage("Penalty already exists for the selected vendor.");
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
        
        ////DropDownList ddlmonth = (DropDownList)dvAddnewvendor.FindControl("ddlMonth");
        //DropDownList ddlvendor = (DropDownList)dvAddnewvendor.FindControl("ddlVendor");
        TextBox txtPenalty = (TextBox)dvAddnewvendor.FindControl("txtPenalty");

        BndDvDropDown();

    }
    protected void NewBndDvDropDown()
    {
        //DropDownList ddlveh = (DropDownList)dvAddnewvendor.FindControl("ddlVehicleType01");
        //ddlveh.Items.Clear();
        //ListItem liveh = new ListItem("Select Vehicle", "0");
        //ddlveh.Items.Add(liveh);
        //ddlveh.DataSource = tms.GetVehicleType();
        //ddlveh.DataTextField = "vehicle";
        //ddlveh.DataValueField = "Id";
        //ddlveh.DataBind();
        //DropDownList ddlVendor = (DropDownList)dvAddnewvendor.FindControl("ddlVendor01");
        //ListItem livev = new ListItem("Select Vendor", "0");
        //ddlVendor.Items.Clear();
        //ddlVendor.DataSource = tms.GetVendorByFac(Convert.ToInt32(ddlSelectFacility.SelectedValue));
        //ddlVendor.DataTextField = "vendorName";
        //ddlVendor.DataValueField = "Id";
        //ddlVendor.DataBind();

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
        DropDownList ddlmonth = (DropDownList)dvAddnewvendor.FindControl("ddlMonth");
        DropDownList ddlveh = (DropDownList)dvAddnewvendor.FindControl("ddlVendorp");
        TextBox txtPenalty = (TextBox)dvAddnewvendor.FindControl("txtPenalty");
        String Result = tms.AddNewVendorPenalty(Convert.ToInt32(ddlSelectFacility.SelectedValue), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToInt32(ddlmonth.SelectedValue), Convert.ToDouble(txtPenalty.Text),MyApplicationSession._UserID).ElementAtOrDefault(0).result.ToString();
        if (Result == "1")
        {
            ShowMessage("Record Added Successfully.");
            mvCost.ActiveViewIndex = 0;
            bndGridCost();
        }
        else
        {
            ShowMessage("Penalty already exists for the selected vendor.");
        }
    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
    protected void gvCost_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            double FuelRate = Convert.ToDouble(((TextBox)gvCost.Rows[e.RowIndex].FindControl("txtFuelRate")).Text);
            double Rate = Convert.ToDouble(((TextBox)gvCost.Rows[e.RowIndex].FindControl("txtKmRate")).Text);
            int id = Convert.ToInt32(gvCost.DataKeys[e.RowIndex].Value.ToString());
            tms.UpdateShuttleCost(id, Rate, FuelRate, MyApplicationSession._UserID);
            lblMsg.Text = "Data updated successfully";
            gvCost.EditIndex = -1;
            bndGridCost();
           
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void gvCost_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvCost.EditIndex = e.NewEditIndex;
        bndGridCost();
    }
    protected void gvCost_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvCost.EditIndex = -1;
        bndGridCost();
    }
    protected void gvCost_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(gvCost.DataKeys[e.RowIndex].Value.ToString());
        tms.DeleteVendorPenalty(id);
        lblMsg.Text = "Data Deleted successfully";
        gvCost.EditIndex = -1;
        bndGridCost();
    }
}
