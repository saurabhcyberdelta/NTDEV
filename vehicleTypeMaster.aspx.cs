using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class vehicleTypeMaster : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    static int vendorId;
    vehicleType vt = new vehicleType();
    static int editindex;
    static int userId;
    static int locationId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            userId = MyApplicationSession._UserID;
            locationId = Convert.ToInt32(Session["LocationId"].ToString());
            if (!IsPostBack)
            {
                BndVendorDropdown();
                BndVehicleGrid();

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
        //*************************************************************//
        //Binds vendor DropDown with vendor list from DB //
        //*************************************************************//
        try
        {
            ddlVendor.Items.Clear();
            ListItem liVendor = new ListItem("All Vendors", "0");
            ddlVendor.Items.Add(liVendor);
            ddlVendor.DataSource = tmscontext.SelectVendor(locationId);
            ddlVendor.DataTextField = "vendorName";
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

    protected void ddlVendor_SelectedIndexChanged(object sender, EventArgs e)
    {

        BndVehicleGrid();

    }
    public void BndVehicleGrid()
    {
        //*************************************************************//
        //Binds Vehicle gridview for the selected vendor    //
        //*************************************************************//
        try
        {
            vendorId = Convert.ToInt32(ddlVendor.SelectedValue);
            GVVehicleType.DataSource = tmscontext.SelectVehicleType(vendorId);
            GVVehicleType.DataBind();
            if (GVVehicleType.Rows.Count < 1)
            {
                MultiView1.ActiveViewIndex = 1;
                BndDvDropdown();

            }
            else { MultiView1.ActiveViewIndex = 0; }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }
    public void BndDvDropdown()
    {
        //*************************************************************//
        //Binds vendor dropdown in the vehcile detailsview    //
        //*************************************************************//
        try
        {
            DropDownList ddlVend = (DropDownList)DVVehicle.FindControl("ddldvVendor");
            ddlVend.Items.Clear();
            ListItem liv = new ListItem("Select Vendor", "0");
            ddlVend.Items.Add(liv);
            ddlVend.DataSource = tmscontext.SelectVendor(locationId);
            ddlVend.DataTextField = "vendorName";
            ddlVend.DataValueField = "Id";
            ddlVend.DataBind();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }


    }
    protected void GVVehicleType_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //*************************************************************//
        //Updates vehicle type information into the DB    //
        //*************************************************************//
        try
        {
            vt.Id = Convert.ToInt32(GVVehicleType.DataKeys[e.RowIndex].Value.ToString());
            vt.vehicle = ((TextBox)GVVehicleType.Rows[e.RowIndex].FindControl("txtVehicle")).Text;
            vt.cost_ac = ((TextBox)GVVehicleType.Rows[e.RowIndex].FindControl("txtMileage")).Text;
            vt.cost_nonac = "";
            vt.occupancy = ((TextBox)GVVehicleType.Rows[e.RowIndex].FindControl("txtOccupancy")).Text;
            vt.vendorId = 0;
            vt.scheme = "Route";
            vt.updatedBy = userId;
            vt.updatedAt = System.DateTime.Now;
            string result = tmscontext.UpdateVehicleType(Server.HtmlEncode(vt.vehicle), vt.cost_ac, vt.cost_nonac, vt.occupancy, vt.vendorId, vt.updatedBy, vt.updatedAt, vt.scheme, vt.Id).ElementAtOrDefault(0).result.Value.ToString();
            if (result.Equals("0"))
            {
                lblMsg.Text = "Vehcile Type already Exists!!!";
                lblMsg.Visible = true;


            }
            else
            {
                MultiView1.ActiveViewIndex = 0;
                GVVehicleType.EditIndex = -1;
                lblMsg.Visible = false;
                BndVehicleGrid();
            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);
        }
    }

    protected void GVVehicleType_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //*************************************************************//
        //OPens the vehicle type gridview in edit mode                //
        //*************************************************************//
        try
        {
          //  string vendor = ((Label)GVVehicleType.Rows[e.NewEditIndex].FindControl("lblVendor")).Text;
            GVVehicleType.EditIndex = e.NewEditIndex;
            BndVehicleGrid();
         
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }

    protected void GVVehicleType_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        vt.Id = Convert.ToInt32(GVVehicleType.DataKeys[e.RowIndex].Value.ToString());
        tmscontext.DeleteVehicleType(vt.Id);
        BndVehicleGrid();
    }

    protected void GVVehicleType_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GVVehicleType.EditIndex = -1;
        lblMsg.Visible = false;
        BndVehicleGrid();
    }

    protected void DVVehicle_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.CancelingEdit == true)
        {
            GVVehicleType.EditIndex = -1;
            BndVehicleGrid();
            lblMsg.Visible = false;
            MultiView1.ActiveViewIndex = 0;
        }
    }

    protected void DVVehicle_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        //*************************************************************//
        //Saves vehicle type info into the DB  //
        //*************************************************************//
        try
        {
            vt.vehicle = ((TextBox)DVVehicle.FindControl("txtdvVehicle")).Text;
            vt.cost_ac = ((TextBox)DVVehicle.FindControl("txtdvCostAC")).Text;
            vt.cost_nonac = "0";
            vt.occupancy = ((TextBox)DVVehicle.FindControl("txtdvOccupancy")).Text;
            vt.vendorId = 0;
            vt.scheme = "Route";
            string result = tmscontext.InsertVehicleType(Server.HtmlEncode(vt.vehicle), vt.cost_ac, vt.cost_nonac, vt.occupancy, vt.vendorId, vt.updatedBy, vt.scheme).ElementAtOrDefault(0).result.Value.ToString();
            if (result.Equals("0"))
            {
                lblMsg.Text = "Vehcile Type already Exists!!!";
                lblMsg.Visible = true;

            }
            else
            {
                MultiView1.ActiveViewIndex = 0;
                BndVehicleGrid();
                lblMsg.Visible = false;
            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }

    protected void lbtnAddNew_Click(object sender, EventArgs e)
    {
        //*************************************************************//
        //Opens the detailview to add new vehcile type   //
        //*************************************************************//
        try
        {
            MultiView1.ActiveViewIndex = 1;
            ((TextBox)DVVehicle.FindControl("txtdvVehicle")).Text = string.Empty;
            ((TextBox)DVVehicle.FindControl("txtdvCostAC")).Text = string.Empty;
            
            ((TextBox)DVVehicle.FindControl("txtdvOccupancy")).Text = string.Empty;

            //ndDvDropdown();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);


        }
    }

    protected void ddldvVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        //*************************************************************//
        //Gets the vendor info for selected vendor in detailsview         //
        //*************************************************************//
        try
        {
            Label lblSc = (Label)DVVehicle.FindControl("lblScheme");
            vt.vendorId = Convert.ToInt32(((DropDownList)DVVehicle.FindControl("ddldvVendor")).SelectedValue);
            lblSc.Text = tmscontext.GetSelectedVendor(vt.vendorId).ElementAtOrDefault(0).vendorType.ToString();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }

    protected void ddlVendor_SelectedIndexChanged1(object sender, EventArgs e)
    { //***************************************************//
        //Gets the vendor info for selected vendor        //
        //************************************************//
        try
        {

            Label lblSc = (Label)GVVehicleType.Rows[editindex].FindControl("lblSchemeEdit");
            vt.vendorId = Convert.ToInt32(((DropDownList)GVVehicleType.Rows[editindex].FindControl("ddlgvVendor")).SelectedValue);
            lblSc.Text = tmscontext.GetSelectedVendor(vt.vendorId).ElementAtOrDefault(0).vendorType.ToString();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }
   
}
