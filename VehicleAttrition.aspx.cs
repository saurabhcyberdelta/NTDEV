using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VehicleAttrition : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    VehicleAuditLog veh = new VehicleAuditLog();
    public int _Att
    {
        get
        {
            return (int)ViewState["_Att"];
        }
        set
        {
            ViewState["_Att"] = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bndfacilitydrop();
            bndvendordropdown();
            BndVehicleGrid();
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
    protected void bndvendordropdown()
    {
        ddlSelectVendor.Items.Clear();
        ddlSelectVendor.DataSource = tms.GetVendorByFac(Convert.ToInt32(ddlSelectFacility.SelectedValue));
        ddlSelectVendor.DataTextField = "vendorname";
        ddlSelectVendor.DataValueField = "Id";
        ddlSelectVendor.DataBind();
    }

    public void BndVehicleGrid()
    {
        //*************************************************************//
        //Binds the vehicle grid with vehicle list in DB     //
        //*************************************************************//
        try
        {
            int chkId;
            if (chkAtt.Checked == true)
            {
                chkId = 1;
                btnSave.Text = "UnAttrite";
            }
            else
            {
                chkId = 0;
                btnSave.Text = "Attrite";
            }

            GVVehicleMaster.DataSource = tms.SelectNonAttritedVehicle(Convert.ToInt32(ddlSelectVendor.SelectedValue), chkId);
            GVVehicleMaster.DataBind();
            if (GVVehicleMaster.Rows.Count < 1)
            {
                lblErrorMsg.Text = "No Record Found!";
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void ddlSelectFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndvendordropdown();
        BndVehicleGrid();
    }
    protected void ddlSelectVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        BndVehicleGrid();
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
    protected void btnSave_Click(object sender, EventArgs e)
    {
        //ModalPopupExtender1.Show();
    }
    protected void chkAll_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            CheckBox cb = (CheckBox)sender;

            if (cb.Checked == true)
            {
                ToggleCheckState(true);
            }
            else
            {
                ToggleCheckState(false);
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    private void ToggleCheckState(bool checkState)
    {
        try
        {
            foreach (GridViewRow i in GVVehicleMaster.Rows)
            {
                // Access the CheckBox
                CheckBox cb = (CheckBox)i.FindControl("chkId");
                if (cb != null)
                    cb.Checked = checkState;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    
    public void CustomValidatorCheckBox_ServerValidate(Object source, ServerValidateEventArgs args)
    {
        try
        {
            bool checkstate = false;

            foreach (GridViewRow i in GVVehicleMaster.Rows)
            {
                // Access the CheckBox
                CheckBox cb = (CheckBox)i.FindControl("chkId");
                if (cb.Checked)
                {
                    checkstate = true;
                    ModalPopupExtender1.Show();
                    break;                    
                }
            }
            args.IsValid = checkstate;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void ButtonSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid == true)
            {
                string vehId = string.Empty;
                string descp = string.Empty;
                if (chkAtt.Checked == true)
                {
                    _Att = 0;
                }
                else
                {
                    _Att = 1;
                }

                ContentPlaceHolder mainContaint = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");
                foreach (GridViewRow i in GVVehicleMaster.Rows)
                {
                    CheckBox cb = ((CheckBox)i.FindControl("chkId"));
                    if (cb != null && cb.Checked)
                    {
                        Label lbl = (Label)i.FindControl("lblVehicleNo");
                        vehId = vehId + lbl.Text.Trim() + ",";
                    }
                }
                vehId = vehId.Remove(vehId.Length - 1, 1);
                descp = txtDescp.Text;
                string result = tms.AttritedVehicle(vehId, _Att, descp, MyApplicationSession._UserID).ElementAtOrDefault(0).RESULT.Value.ToString();
                if (result.Equals("1"))
                {
                    if (_Att == 1)
                    {
                        ShowMessage("Vehicle Attrited successfully");
                    }
                    else
                    {
                        ShowMessage("Vehicle Unattrited successfully");
                    }
                    lblErrorMsg.ForeColor = System.Drawing.Color.Green;
                    lblErrorMsg.Visible = true;
                    BndVehicleGrid();
                    txtDescp.Text = string.Empty;
                }
                else
                {
                    lblErrorMsg.Text = "Error!";
                    lblErrorMsg.Visible = true;
                }
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
    protected void GVVehicleMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GVVehicleMaster.PageIndex = e.NewPageIndex;
        BndVehicleGrid();
    }
    protected void chkAtt_CheckedChanged(object sender, EventArgs e)
    {
      
        BndVehicleGrid();
    }
}
