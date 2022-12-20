using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DriverAttritation : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    DriverAuditLog da = new DriverAuditLog();
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

            BndFacilityDropdown();
            bndvendordropdown();
            BndDriverGrid();
        }
    }
    protected void bndvendordropdown()
    {
        ddlSelectVendor.Items.Clear();
        ListItem liv = new ListItem("-Select-", "0");
        ddlSelectVendor.Items.Add(liv);
        ddlSelectVendor.DataSource = tms.GetVendorByFac(Convert.ToInt32(ddlSelectFacility.SelectedValue));
        ddlSelectVendor.DataTextField = "vendorname";
        ddlSelectVendor.DataValueField = "Id";
        ddlSelectVendor.DataBind();
    }
    public void BndFacilityDropdown()
    {
        try
        {
            //DropDownList ddlSelectFacility = (DropDownList)DvDriver.FindControl("ddlSelectFacility");
            ddlSelectFacility.Items.Clear();
            ListItem liv = new ListItem("Select Facility", "0");
            ddlSelectFacility.Items.Add(liv);
            ddlSelectFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlSelectFacility.DataTextField = "facilityName";
            ddlSelectFacility.DataValueField = "Id";
            ddlSelectFacility.DataBind();

            ddlSelectFacility.SelectedIndex = ddlSelectFacility.Items.IndexOf(ddlSelectFacility.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    public void BndDriverGrid()
    {
        //*************************************************************//
        //Binds the vehicle grid with vehicle list in DB     //
        //*************************************************************//
        try
        {
            if (ChkAtt.Checked == true)
            {
                _Att = 1;
            }
            else
            {
                _Att = 0;
            }

            GVDriverMaster.DataSource = tms.GetDriverDetailsByAtt(Convert.ToInt32(ddlSelectFacility.SelectedValue), Convert.ToInt32(ddlSelectVendor.SelectedValue),_Att);
            GVDriverMaster.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }
    protected void GVDriverMaster_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string BadgeExpiryDateColor = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BadgeExpiryDateColor"));
                string LicenseExpiryDateColor = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "LicenseExpiryDateColor"));

                getGrdColor(e, BadgeExpiryDateColor, LicenseExpiryDateColor);
           
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    private static void getGrdColor(GridViewRowEventArgs e, string BadgeExpiryDateColor, string LicenseExpiryDateColor)
    {
        if (BadgeExpiryDateColor == "Red")
        {
            e.Row.Cells[5].ForeColor = System.Drawing.Color.Red;
        }
        else if (BadgeExpiryDateColor == "Green")
        {
            e.Row.Cells[5].ForeColor = System.Drawing.Color.Green;
        }
        else if (BadgeExpiryDateColor == "Blue")
        {
            e.Row.Cells[5].ForeColor = System.Drawing.Color.SteelBlue;
        }
        else
        {
            e.Row.Cells[5].ForeColor = System.Drawing.Color.Black;
        }

        if (LicenseExpiryDateColor == "Red")
        {
            e.Row.Cells[8].ForeColor = System.Drawing.Color.Red;
        }
        else if (LicenseExpiryDateColor == "Green")
        {
            e.Row.Cells[8].ForeColor = System.Drawing.Color.Green;
        }
        else if (LicenseExpiryDateColor == "Blue")
        {
            e.Row.Cells[8].ForeColor = System.Drawing.Color.SteelBlue;
        }
        else
        {
            e.Row.Cells[8].ForeColor = System.Drawing.Color.Black;
        }
    }
    protected void GVDriverMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }

    protected void ChkAll_CheckedChanged(object sender, EventArgs e)
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
            foreach (GridViewRow i in GVDriverMaster.Rows)
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

            foreach (GridViewRow i in GVDriverMaster.Rows)
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
    protected void btnSave_Click(object sender, EventArgs e)
    {

    }
    protected void ButtonSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid == true)
            {
                string DrivId = string.Empty;
                string descp = string.Empty;
                string Ids = string.Empty;
                if (ChkAtt.Checked == true)
                {
                    _Att = 0;
                }
                else
                {
                    _Att = 1;
                }

                ContentPlaceHolder mainContaint = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");
                foreach (GridViewRow i in GVDriverMaster.Rows)
                {
                    CheckBox cb = ((CheckBox)i.FindControl("chkId"));
                    if (cb != null && cb.Checked)
                    {
                        Label lbl = (Label)i.FindControl("lblCabId");
                        DrivId = DrivId + lbl.Text.Trim() + ",";
                    }
                }
                DrivId = DrivId.Remove(DrivId.Length - 1, 1);
                descp = txtDescp.Text;
                string result = tms.AttritedDriver(DrivId, _Att, descp, MyApplicationSession._UserID).ElementAtOrDefault(0).RESULT.Value.ToString();
                if (result.Equals("1"))
                {
                    lblErrorMsg.Text = "<b>Record Updated Successfully!</b>";
                    lblErrorMsg.ForeColor = System.Drawing.Color.Green;
                    lblErrorMsg.Visible = true;
                    BndDriverGrid();
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
    protected void ChkAtt_CheckedChanged(object sender, EventArgs e)
    {
        BndDriverGrid();
    }
    protected void ddlSelectVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        BndDriverGrid();
    }
    protected void ddlSelectFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndvendordropdown();
        BndDriverGrid();
    }
}
