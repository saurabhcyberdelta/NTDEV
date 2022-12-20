using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VehicleMaster : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    vehicle vh = new vehicle();
    static int vendorId;
    static int editindex;
    static int userId = 0;
    static int locationId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            userId = MyApplicationSession._UserID;
            locationId = Convert.ToInt32(Session["LocationId"].ToString());
            if (!IsPostBack)
            {
                MultiView1.ActiveViewIndex = 0;
                bndfacilitydrop();
                bndvendordropdown();
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
    protected void bndfacilitydrop()
    {
        ddlSelectFacility.Items.Clear();
        ddlSelectFacility.DataSource = tmscontext.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
        ddlSelectFacility.DataTextField = "facilityName";
        ddlSelectFacility.DataValueField = "Id";
        ddlSelectFacility.DataBind();
        ListItem liFacIn = new ListItem("-Select Facility-", "0");
        ddlSelectFacility.Items.Insert(0, liFacIn);

        ddlSelectFacility.SelectedIndex = ddlSelectFacility.Items.IndexOf(ddlSelectFacility.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));


    }
    protected void bndvendordropdown()
    {
        ddlSelectVendor.Items.Clear();
      
        ddlSelectVendor.DataSource = tmscontext.GetVendorByFac(Convert.ToInt32(ddlSelectFacility.SelectedValue));
        ddlSelectVendor.DataTextField = "vendorname";
        ddlSelectVendor.DataValueField = "Id";
        ddlSelectVendor.DataBind();
        ListItem lifac = new ListItem("All Vendors", "0");
        ddlSelectVendor.Items.Add(lifac);
        ddlSelectVendor.SelectedIndex = ddlSelectVendor.Items.IndexOf(ddlSelectVendor.Items.FindByValue("0"));

    }
    public void BndVehicleGrid()
    {
        //*************************************************************//
        //Binds the vehicle grid with vehicle list in DB     //
        //*************************************************************//
        try
        {

            GVVehicleMaster.DataSource = tmscontext.getvehiclebyVendor(Convert.ToInt32(ddlSelectFacility.SelectedValue), Convert.ToInt32(ddlSelectVendor.SelectedValue));
            GVVehicleMaster.DataBind();
            //GVVehicleMaster.EditIndex = -1;
            //GVVehicleMaster.PageIndex = 0;

            if (GVVehicleMaster.Rows.Count < 1)
            {
                
                MultiView1.ActiveViewIndex = 1;
                BndDvDropdown();
            }
            else
            {
                MultiView1.ActiveViewIndex = 0;
                GVVehicleMaster.Visible = true;
                gvsummary.Visible = false;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }

    protected void GVVehicleMaster_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //*************************************************************//
        //Opens the vehicle Master gridview for editing      //
        //*************************************************************//
        try
        {
            String tesdate = Convert.ToDateTime("30 Mar 2008").ToString("MM/dd/yyyy");
            string regdate = ((Label)GVVehicleMaster.Rows[e.NewEditIndex].FindControl("lblRegistrationDate")).Text;
            string fcValiddate = ((Label)GVVehicleMaster.Rows[e.NewEditIndex].FindControl("lblfcValidDate")).Text;
            string insaurance = ((Label)GVVehicleMaster.Rows[e.NewEditIndex].FindControl("lblInsuranceDate")).Text;
            string PermitExpiry = ((Label)GVVehicleMaster.Rows[e.NewEditIndex].FindControl("lblPermitExpiryDate")).Text;
            string taxvalidity = ((Label)GVVehicleMaster.Rows[e.NewEditIndex].FindControl("lblTaxValidity")).Text;
            string EmmisionExpiry = ((Label)GVVehicleMaster.Rows[e.NewEditIndex].FindControl("lblEmissionExpiry")).Text;


            string vehicle = ((Label)GVVehicleMaster.Rows[e.NewEditIndex].FindControl("lblVehicleType")).Text;
            GVVehicleMaster.EditIndex = e.NewEditIndex;
            editindex = e.NewEditIndex;
            BndVehicleGrid();
            BndGVDropdown();
            DropDownList ddlveh = (DropDownList)GVVehicleMaster.Rows[editindex].FindControl("ddlVehicleType");
            ddlveh.SelectedIndex = ddlveh.Items.IndexOf(ddlveh.Items.FindByText(vehicle.ToString()));
            if (regdate != "")
            {
                ((TextBox)GVVehicleMaster.Rows[e.NewEditIndex].FindControl("txtRegDate")).Text = Convert.ToDateTime(regdate).ToString("MM/dd/yyyy");
            }
            if (fcValiddate != "")
            {
                ((TextBox)GVVehicleMaster.Rows[e.NewEditIndex].FindControl("txtfcValidDate")).Text = Convert.ToDateTime(fcValiddate).ToString("MM/dd/yyyy");
            }
            if (insaurance != "")
            {
                ((TextBox)GVVehicleMaster.Rows[e.NewEditIndex].FindControl("txtInsuranceDate")).Text = Convert.ToDateTime(insaurance).ToString("MM/dd/yyyy");
            }
            if (PermitExpiry != "")
            {
                ((TextBox)GVVehicleMaster.Rows[e.NewEditIndex].FindControl("txtPermitDate")).Text = Convert.ToDateTime(PermitExpiry).ToString("MM/dd/yyyy");
            }
            if (taxvalidity != "")
            {
                ((TextBox)GVVehicleMaster.Rows[e.NewEditIndex].FindControl("txtTaxValidity")).Text = Convert.ToDateTime(taxvalidity).ToString("MM/dd/yyyy");
            }
            if (EmmisionExpiry != "")
            {
                ((TextBox)GVVehicleMaster.Rows[e.NewEditIndex].FindControl("txtEmissionDate")).Text = Convert.ToDateTime(EmmisionExpiry).ToString("MM/dd/yyyy");
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }
    public void BndGVDropdown()
    {
        //*************************************************************//
        //Binds the dropdowns in vehcile master gridview //
        //*************************************************************//
        try
        {
            DropDownList ddlveh = (DropDownList)GVVehicleMaster.Rows[editindex].FindControl("ddlVehicleType");
           
            ListItem liveh = new ListItem("Select Vehicle", "0");
           
            ddlveh.Items.Clear();
           
            ddlveh.Items.Add(liveh);
            
            ddlveh.DataSource = tmscontext.SelectVehicleType(vendorId);
            ddlveh.DataTextField = "vehicle";
            ddlveh.DataValueField = "Id";
            ddlveh.DataBind();
           
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }

    }

    protected void GVVehicleMaster_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //*************************************************************//
        //Updates vehicle Master details into the DB               //
        //*************************************************************//
        try
        {
            vh.Id = Convert.ToInt32(GVVehicleMaster.DataKeys[e.RowIndex].Value.ToString());
            vh.vehicleNo = ((Label)GVVehicleMaster.Rows[e.RowIndex].FindControl("lblVehicleNoEdit")).Text;
            vh.vehicleTypeId = Convert.ToInt32(((DropDownList)GVVehicleMaster.Rows[e.RowIndex].FindControl("ddlVehicleType")).SelectedValue);
            vh.vehicleRegistrationNo = ((TextBox)GVVehicleMaster.Rows[e.RowIndex].FindControl("txtVehicleRegNo")).Text;
            String regDate = ((TextBox)GVVehicleMaster.Rows[e.RowIndex].FindControl("txtRegDate")).Text;
            if (regDate != "")
            {
                vh.registrationDate = Convert.ToDateTime(regDate);
            }
            else
            {
                vh.registrationDate = null;
            }


            vh.Model = ((TextBox)GVVehicleMaster.Rows[e.RowIndex].FindControl("txtModel")).Text;

            String fcValidDate = ((TextBox)GVVehicleMaster.Rows[e.RowIndex].FindControl("txtfcValidDate")).Text;
            if (fcValidDate != "")
            {
                vh.FCValidDate = Convert.ToDateTime(fcValidDate);
            }
            else
            {
                vh.FCValidDate = null;
            }

            vh.InsauranceNo = ((TextBox)GVVehicleMaster.Rows[e.RowIndex].FindControl("txtInsauranceNo")).Text;
            vh.InsauranceCompany = ((TextBox)GVVehicleMaster.Rows[e.RowIndex].FindControl("txtInsauranceCo")).Text;
            String insauranceexpiry = ((TextBox)GVVehicleMaster.Rows[e.RowIndex].FindControl("txtInsuranceDate")).Text;
            if (insauranceexpiry != "")
            {
                vh.InsuranceExpiryDate = Convert.ToDateTime(insauranceexpiry);
            }
            else
            {
                vh.InsuranceExpiryDate = null;
            }
            vh.PermitNo = ((TextBox)GVVehicleMaster.Rows[e.RowIndex].FindControl("txtPermitNo")).Text;

            String permitExpiry = ((TextBox)GVVehicleMaster.Rows[e.RowIndex].FindControl("txtPermitDate")).Text;
            if (permitExpiry != "")
            {
                vh.permitExpiryDate = Convert.ToDateTime(permitExpiry);
            }
            else
            {
                vh.permitExpiryDate = null;
            }

            String taxValidity = ((TextBox)GVVehicleMaster.Rows[e.RowIndex].FindControl("txtTaxValidity")).Text;
            if (taxValidity != "")
            {
                vh.taxExpiryDate = Convert.ToDateTime(taxValidity);
            }
            else
            {
                vh.taxExpiryDate = null;
            }

            String taxEmission = ((TextBox)GVVehicleMaster.Rows[e.RowIndex].FindControl("txtEmissionDate")).Text;
            if (taxEmission != "")
            {
                vh.emmissionexpiry = Convert.ToDateTime(taxEmission);
            }
            else
            {
                vh.emmissionexpiry = null;
            }
             tmscontext.UpdateVehicle(vh.vehicleNo, vh.vehicleRegistrationNo, vh.registrationDate, vh.permitExpiryDate, vh.InsuranceExpiryDate, vh.FCValidDate, vh.taxExpiryDate, vh.vehicleTypeId, vh.Model, vh.InsauranceNo, vh.InsauranceCompany, vh.PermitNo, vh.emmissionexpiry, vh.Id, MyApplicationSession._UserID);
             GVVehicleMaster.EditIndex = -1;
             BndVehicleGrid();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }

    protected void GVVehicleMaster_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //*************************************************************//
        //Deletes vehicle from the DB          //
        //*************************************************************//
        try
        {
            vh.Id = Convert.ToInt32(GVVehicleMaster.DataKeys[e.RowIndex].Value.ToString());
            tmscontext.DeleteVehicle(vh.Id);
            BndVehicleGrid();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }


    protected void GVVehicleMaster_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GVVehicleMaster.EditIndex = -1;
        BndVehicleGrid();
    }

    protected void lbtnAddNew_Click(object sender, EventArgs e)
    {
        //*************************************************************//
        //Opens Detailsview for adding new vehicle into the DB //
        //*************************************************************//
        try
        {
            MultiView1.ActiveViewIndex = 1;
            ((TextBox)DvVehicle.FindControl("txtdvVehicleNo")).Text = string.Empty;
            ((TextBox)DvVehicle.FindControl("txtdvVehicleRegNo")).Text = string.Empty;
            ((TextBox)DvVehicle.FindControl("txtdvRegDate")).Text = string.Empty;
            ((TextBox)DvVehicle.FindControl("txtdvTaxDate")).Text = string.Empty;
            ((TextBox)DvVehicle.FindControl("txtdvPermitDate")).Text = string.Empty;
            ((TextBox)DvVehicle.FindControl("txtdvInsuranceDate")).Text = string.Empty;
            ((TextBox)DvVehicle.FindControl("txtdvChasis")).Text = string.Empty;
            ((TextBox)DvVehicle.FindControl("txtdvModel")).Text = string.Empty;
            ((TextBox)DvVehicle.FindControl("txtdvInsauranceNo")).Text = string.Empty;
            ((TextBox)DvVehicle.FindControl("txtdvInsauranceCo")).Text = string.Empty;
            ((TextBox)DvVehicle.FindControl("txtdvPermitNo")).Text = string.Empty;
            ((TextBox)DvVehicle.FindControl("txtdvEmission")).Text = string.Empty;
            ((TextBox)DvVehicle.FindControl("txtdvFcValidDate")).Text = string.Empty;
           
            BndDvDropdown();
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
        //Binds the dropdown//
        //*************************************************************//
        try
        {

            DropDownList ddlvend = (DropDownList)DvVehicle.FindControl("ddldvVendor");
            DropDownList ddlveh = (DropDownList)DvVehicle.FindControl("ddldvVehicleType");
            DropDownList ddlfac = (DropDownList)DvVehicle.FindControl("ddldvFacility");
            ListItem livend = new ListItem("Select Vendor", "0");
            ListItem liveh = new ListItem("Select Vehicle", "0");
            ListItem lifac = new ListItem("Select Facility", "0");
            ddlvend.Items.Clear();
            ddlveh.Items.Clear();
            ddlfac.Items.Clear();
            ddlvend.Items.Add(livend);
            ddlveh.Items.Add(liveh);
            ddlfac.Items.Add(lifac);
            ddlvend.DataSource = tmscontext.GetVendorByFac(Convert.ToInt32(ddlfac.SelectedValue));
            ddlvend.DataTextField = "vendorName";
            ddlvend.DataValueField = "Id";
            ddlvend.DataBind();
            vendorId = Convert.ToInt32(ddlvend.SelectedValue);
            ddlveh.DataSource = tmscontext.GetVehicleType();
            ddlveh.DataTextField = "vehicle";
            ddlveh.DataValueField = "Id";
            ddlveh.DataBind();
            ddlfac.DataSource = tmscontext.SelectFacility(MyApplicationSession._UserID,MyApplicationSession._ISAdmin);
            ddlfac.DataTextField = "facilityName";
            ddlfac.DataValueField = "Id";
            ddlfac.DataBind();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);
        }


    }
    protected void DvVehicle_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.CancelingEdit == true)
        {
            GVVehicleMaster.EditIndex = -1;
            BndVehicleGrid();
            MultiView1.ActiveViewIndex = 0;
        }
    }

    protected void DvVehicle_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        //*************************************************************//
        //Saves vehicle information into the DB     //
        //*************************************************************//
        try
        {
            vh.vehicleNo = ((TextBox)DvVehicle.FindControl("txtdvVehicleNo")).Text;
            vh.vehicleRegistrationNo = ((TextBox)DvVehicle.FindControl("txtdvVehicleRegNo")).Text;
            vh.ChasisNo= ((TextBox)DvVehicle.FindControl("txtdvChasis")).Text;
            vh.Model= ((TextBox)DvVehicle.FindControl("txtdvModel")).Text;
            vh.InsauranceNo=  ((TextBox)DvVehicle.FindControl("txtdvInsauranceNo")).Text;
            vh.InsauranceCompany=((TextBox)DvVehicle.FindControl("txtdvInsauranceCo")).Text;
            vh.PermitNo = ((TextBox)DvVehicle.FindControl("txtdvPermitNo")).Text;
            String regDate = ((TextBox)DvVehicle.FindControl("txtdvRegDate")).Text;
            if (regDate != "")
            {
                vh.registrationDate = Convert.ToDateTime(regDate);
            }
            else
            {
                vh.registrationDate = null;
            }
            String taxvalidity =((TextBox)DvVehicle.FindControl("txtdvTaxDate")).Text;
            if (taxvalidity != "")
            {
                vh.taxExpiryDate = Convert.ToDateTime(taxvalidity);
            }
            else
            {
                vh.taxExpiryDate = null;
            }
            String txtpermit = ((TextBox)DvVehicle.FindControl("txtdvPermitDate")).Text;
            if (txtpermit != "")
            {
                vh.permitExpiryDate = Convert.ToDateTime(txtpermit);
            }
            else
            {
                vh.permitExpiryDate = null;
            }
            String txtinsaurancedate = ((TextBox)DvVehicle.FindControl("txtdvInsuranceDate")).Text;
            if (txtinsaurancedate != "")
            {
                vh.InsuranceExpiryDate = Convert.ToDateTime(txtinsaurancedate);
            }
            else
            {
                vh.InsuranceExpiryDate = null;
            }

            String txtemmisionDate = ((TextBox)DvVehicle.FindControl("txtdvEmission")).Text;
            if (txtemmisionDate != "")
            {
                vh.emmissionexpiry = Convert.ToDateTime(txtemmisionDate);
            }
            else
            {
                vh.emmissionexpiry = null;
            }
            String txtfcvalid = ((TextBox)DvVehicle.FindControl("txtdvFcValidDate")).Text;
            if (txtfcvalid != "")
            {
                vh.FCValidDate = Convert.ToDateTime(txtfcvalid);
            }
            else
            {
                vh.FCValidDate = null;
            }
            vh.facilityId = Convert.ToInt32(((DropDownList)DvVehicle.FindControl("ddldvFacility")).SelectedValue);
            vh.vehicleTypeId = Convert.ToInt32(((DropDownList)DvVehicle.FindControl("ddldvVehicleType")).SelectedValue);
            vh.vendorId = Convert.ToInt32(((DropDownList)DvVehicle.FindControl("ddldvVendor")).SelectedValue);
            string result = tmscontext.InsertVehicle(vh.vehicleNo, vh.vehicleRegistrationNo, vh.registrationDate, vh.permitExpiryDate, vh.InsuranceExpiryDate, vh.FCValidDate, vh.taxExpiryDate, vh.Model, vh.InsauranceCompany, vh.InsauranceNo, vh.PermitNo, vh.emmissionexpiry, MyApplicationSession._UserID, vh.vehicleTypeId, vh.vendorId, vh.facilityId).ElementAtOrDefault(0).result.ToString();
            if (result.Equals("1"))
            {
                ShowMessage("Vehicle already exists");
                lblErrorMsg.Text = "Vehicle Already Exists";
                lblErrorMsg.Visible = true;

            }
            else
            {
                ShowMessage("Vehicle added successfully");
                BndVehicleGrid();
                MultiView1.ActiveViewIndex = 0;
                lblErrorMsg.Visible = false;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }

    protected void ddldvVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        //*************************************************************//
        //Binds the vehicle dropdown for selected vendor in detailsview//
        //*************************************************************//
        try
        {
            vendorId = Convert.ToInt32(((DropDownList)DvVehicle.FindControl("ddldvVendor")).SelectedValue);
            DropDownList ddlveh = (DropDownList)DvVehicle.FindControl("ddldvVehicleType");
            ListItem liveh = new ListItem("Select Vehicle", "0");
            ddlveh.Items.Clear();
            ddlveh.Items.Add(liveh);
            ddlveh.DataSource = tmscontext.SelectVehicleType(vendorId);
            ddlveh.DataTextField = "vehicle";
            ddlveh.DataValueField = "Id";
            ddlveh.DataBind();
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
        //*************************************************************//
        //calls the function to bind employee grid with serach criteria //
        //*************************************************************//
        try
        {
            DropDownList ddlveh = (DropDownList)GVVehicleMaster.Rows[editindex].FindControl("ddlVehicleType");
            DropDownList ddlvend = (DropDownList)GVVehicleMaster.Rows[editindex].FindControl("ddlVendor");
            ListItem liveh = new ListItem("Select Vehicle", "0");
            ddlveh.Items.Clear();
            ddlveh.Items.Add(liveh);
            vendorId = Convert.ToInt32(ddlvend.SelectedValue);
            ddlveh.DataSource = tmscontext.SelectVehicleType(vendorId);
            ddlveh.DataTextField = "vehicle";
            ddlveh.DataValueField = "Id";
            ddlveh.DataBind();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }

    }

    protected void GVVehicleMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GVVehicleMaster.PageIndex = e.NewPageIndex;
       
        BndVehicleGrid();
    }
    protected void ddlSelectFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndvendordropdown();
        BndVehicleGrid();
        MultiView1.ActiveViewIndex = 0;
    }
    protected void ddlSelectVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        GVVehicleMaster.EditIndex = -1;
        BndVehicleGrid();
        rdbvehicle.SelectedIndex = 0;
    }
    protected System.Drawing.Color Colors(object strArg)
    {
        try
        {
            string val = Convert.ToString(strArg);

            if (val == "B")
            {
                return System.Drawing.Color.Green;
            }
            else 
            {
                int value = Convert.ToInt32(val);
                if (value <= 0)
                    return System.Drawing.Color.Red;
                else if (value > 0 && value <= 5)
                    return System.Drawing.Color.Green;
                else if (value > 5 && value <= 7)
                    return System.Drawing.Color.SteelBlue;
                else
                    return System.Drawing.Color.Black;
            }

        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected Boolean Bolds(object strArg)
    {
        try
        {
            string val = Convert.ToString(strArg);

            if (val == "B")
            {
                return true;
            }
            else
            {
                int value = Convert.ToInt32(val);
                if (value <= 0)
                    return true;
                else if (value > 0 && value <= 5)
                    return true;
                else if (value > 5 && value <= 7)
                    return true;
                else
                    return false;
            }

        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void ddldvFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlvend = (DropDownList)DvVehicle.FindControl("ddldvVendor");
        DropDownList ddlfac = (DropDownList)DvVehicle.FindControl("ddldvFacility");
        
        ListItem lifac = new ListItem("Select Vendor", "0");
        ddlvend.Items.Clear();
         ddlvend.Items.Add(lifac);
        ddlvend.DataSource = tmscontext.GetVendorByFac(Convert.ToInt32(ddlfac.SelectedValue));
        ddlvend.DataTextField = "vendorName";
        ddlvend.DataValueField = "Id";
        ddlvend.DataBind();
       
       
    }

    protected void lbtnExportExcel_Click(object sender, EventArgs e)
    {
        if (rdbvehicle.SelectedValue == "0")
        
            GridViewExportUtil.Export("VehicleMaster.xls", GVVehicleMaster);
      
        else
            GridViewExportUtil.Export("VehicleMaster.xls", gvsummary );
           
    }
    protected void rdbvehicle_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rdbvehicle.SelectedValue == "0")
        {
            BndVehicleGrid();
            gvsummary.Visible = false;
           
        }
        else
        {
            gvsummary.DataSource = tmscontext.getvehicleSummary( Convert.ToInt32(ddlSelectFacility.SelectedValue),Convert.ToInt32(ddlSelectVendor.SelectedValue));
            gvsummary.DataBind();
            gvsummary.Visible = true;
            GVVehicleMaster.Visible = false;
            
        }

    }
}
