using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DriverDetails : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    DriverMaster dm = new DriverMaster();
    public int _DriverId
    {
        get
        {
            return (int)ViewState["_DriverId"];
        }
        set
        {
            ViewState["_DriverId"] = value;
        }
    }

    public int _CabId
    {
        get
        {
            return (int)ViewState["_CabId"];
        }
        set
        {
            ViewState["_CabId"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BndFacilityDropdown();
            bndvendordropdown();
            lkbExport.Visible = false;
            BndDriverGrid();
            MultiView1.ActiveViewIndex = 0;
        }
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

    public void BndDvFacilityDropdown()
    {
        try
        {
            DropDownList ddldvFacility = ((DropDownList)FVDriver.FindControl("ddldvFacility"));
            ddldvFacility.Items.Clear();
            ListItem liv = new ListItem("Select Facility", "0");
            ddldvFacility.Items.Add(liv);
            ddldvFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddldvFacility.DataTextField = "facilityName";
            ddldvFacility.DataValueField = "Id";
            ddldvFacility.DataBind();
            ddldvFacility.Focus();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void bndvendordropdown()
    {
        ddlSelectVendor.Items.Clear();
        ListItem liv = new ListItem("-All Vendor-", "0");
        ddlSelectVendor.Items.Add(liv);
        ddlSelectVendor.DataSource = tms.GetVendorByFac(Convert.ToInt32(ddlSelectFacility.SelectedValue));
        ddlSelectVendor.DataTextField = "vendorname";
        ddlSelectVendor.DataValueField = "Id";
        ddlSelectVendor.DataBind();
    }

    public void BndDriverGrid()
    {
        //*************************************************************//
        //Binds the vehicle grid with vehicle list in DB     //
        //*************************************************************//
        try
        {

            GVDriverMaster.DataSource = tms.GetDriverDetails(Convert.ToInt32(ddlSelectFacility.SelectedValue), Convert.ToInt32(ddlSelectVendor.SelectedValue));
            GVDriverMaster.DataBind();

            MultiView1.ActiveViewIndex = 0;
            if (GVDriverMaster.Rows.Count > 0)
            {
                lkbExport.Visible = true;
            }
            else
            {
                lkbExport.Visible = false;
            }
            //if (GVDriverMaster.Rows.Count < 1)
            //{
            //    MultiView1.ActiveViewIndex = 1;
            //    BndDvFacilityDropdown();
            //}
            //else
            //{
            //    MultiView1.ActiveViewIndex = 0;
            //}
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }

    protected void GVDriverMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GVDriverMaster.PageIndex = e.NewPageIndex;
        BndDriverGrid();
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

    protected void ddlSelectFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndvendordropdown();
        BndDriverGrid();
    }

    protected void EmptyField()
    {
        ((DropDownList)FVDriver.FindControl("ddldvFacility")).SelectedIndex = 0;
        ((DropDownList)FVDriver.FindControl("ddlDvCabID")).SelectedIndex = 0;
        ((DropDownList)FVDriver.FindControl("ddlBloodGroup")).SelectedIndex = 0;
        ((TextBox)FVDriver.FindControl("txtDvDriverName")).Text = string.Empty;
        ((TextBox)FVDriver.FindControl("txtDateOfJoining")).Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
        ((TextBox)FVDriver.FindControl("txtdvBadgeNo")).Text = string.Empty;
        ((TextBox)FVDriver.FindControl("txtdvBadgeIssueDate")).Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
        ((TextBox)FVDriver.FindControl("txtdvBadgeExpiryDate")).Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
        ((TextBox)FVDriver.FindControl("txtdvLicenseNumber")).Text = string.Empty;
        ((TextBox)FVDriver.FindControl("txtdvLicenseIssuedDate")).Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
        ((TextBox)FVDriver.FindControl("txtdvLicenseExpiryDate")).Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
        ((TextBox)FVDriver.FindControl("txtdvTotalExperience")).Text = string.Empty;
        ((TextBox)FVDriver.FindControl("txtdvAreaOfResidence")).Text = string.Empty;
        ((TextBox)FVDriver.FindControl("txtdvContact1")).Text = string.Empty;
        ((TextBox)FVDriver.FindControl("txtdvContact2")).Text = string.Empty;
        //((TextBox)FVDriver.FindControl("")).Text = string.Empty;
        ((Image)FVDriver.FindControl("imgfvdPhoto")).ImageUrl = string.Empty;
        ((Image)FVDriver.FindControl("imgfvdFinger")).ImageUrl = string.Empty;

        ((Label)FVDriver.FindControl("lblfvdPhoto")).Text = string.Empty;
        ((Label)FVDriver.FindControl("lblfvdFinger")).Text = string.Empty;
        BndFVDropDown();
    }

    protected void BndFVDropDown()
    {
        try
        {
            DropDownList ddlFacility = ((DropDownList)FVDriver.FindControl("ddldvFacility"));
            DropDownList ddlDvCabID = ((DropDownList)FVDriver.FindControl("ddlDvCabID"));
            DropDownList ddlBlood = ((DropDownList)FVDriver.FindControl("ddlBloodGroup"));

            ddlFacility.Items.Clear();
            ListItem lstFac = new ListItem("-Select Facility-", "0");
            ddlFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlFacility.Items.Add(lstFac);
            ddlFacility.DataTextField = "facilityName";
            ddlFacility.DataValueField = "Id";
            ddlFacility.DataBind();

            ddlDvCabID.Items.Clear();
            ListItem lstCab = new ListItem("-Select CabId-", "0");
            ddlDvCabID.DataSource = null;
            ddlDvCabID.Items.Add(lstCab);
            //ddlFacility.DataTextField = "facilityName";
            //ddlFacility.DataValueField = "Id";
            ddlDvCabID.DataBind();

            ddlBlood.Items.Clear();
            List<ListItem> lstBood = new List<ListItem>();
            lstBood.Add(new ListItem("-Select Blood-", "0"));
            lstBood.Add(new ListItem("AB+", "AB+"));
            lstBood.Add(new ListItem("AB-", "AB-"));
            lstBood.Add(new ListItem("A+", "A+"));
            lstBood.Add(new ListItem("A-", "A-"));
            lstBood.Add(new ListItem("B+", "B+"));
            lstBood.Add(new ListItem("B-", "B-"));
            lstBood.Add(new ListItem("O+", "O+"));
            lstBood.Add(new ListItem("O-", "O-"));
            ddlBlood.DataSource = lstBood;
            ddlBlood.DataBind();

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    
    protected void ddlSelectVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        BndDriverGrid();
    }

    protected void lbtnAddNew_Click(object sender, EventArgs e)
    {
        BndDvFacilityDropdown();
        //BndCabIDDropdown();
        EmptyField();
        MultiView1.ActiveViewIndex = 1;
        _DriverId = 0;
    }

    protected void ddldvFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            int selFacility = Convert.ToInt32(((DropDownList)FVDriver.FindControl("ddldvFacility")).SelectedValue);
            DropDownList ddlDvCabID = (DropDownList)FVDriver.FindControl("ddlDvCabID");
            ddlDvCabID.Items.Clear();
            ListItem liv = new ListItem("Select CabID", "0");
            ddlDvCabID.Items.Add(liv);
            ddlDvCabID.DataSource = tms.SelectVehicle(selFacility);
            ddlDvCabID.DataTextField = "vehicleNo";
            ddlDvCabID.DataValueField = "Id";
            ddlDvCabID.DataBind();  
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void ddlDvCabID_SelectedIndexChanged(object sender, EventArgs e)
    {
        _CabId = Convert.ToInt32(((DropDownList)FVDriver.FindControl("ddlDvCabID")).SelectedValue);
        var result = tms.SelectDriverInfo(_CabId);
        _DriverId = 0;
        foreach (var re in result)
        {
            string blood = re.BloodGroup.ToString();
            DropDownList ddlBlood = ((DropDownList)FVDriver.FindControl("ddlBloodGroup"));
            ddlBlood.SelectedIndex = ddlBlood.Items.IndexOf(ddlBlood.Items.FindByText(blood));
            _DriverId = re.ID;
            ((TextBox)FVDriver.FindControl("txtDvDriverName")).Text = re.DriverName == null ? "" : re.DriverName.ToString();
            ((TextBox)FVDriver.FindControl("txtDateOfJoining")).Text = re.DateOfJoining == null ? "" : re.DateOfJoining.ToString();
            ((TextBox)FVDriver.FindControl("txtdvBadgeNo")).Text = re.BadgeNo == null ? "" : re.BadgeNo.ToString();
            ((TextBox)FVDriver.FindControl("txtdvBadgeIssueDate")).Text = re.BadgeIssueDate == null ? "" : re.BadgeIssueDate.ToString();
            ((TextBox)FVDriver.FindControl("txtdvBadgeExpiryDate")).Text = re.BadgeExpiryDate == null ? "" : re.BadgeExpiryDate.ToString();
            ((TextBox)FVDriver.FindControl("txtdvLicenseNumber")).Text = re.LicenseNumber == null ? "" : re.LicenseNumber.ToString();
            ((TextBox)FVDriver.FindControl("txtdvLicenseIssuedDate")).Text = re.LicenseIssuedDate == null ? "" : re.LicenseIssuedDate.ToString();
            ((TextBox)FVDriver.FindControl("txtdvLicenseExpiryDate")).Text = re.LicenseExpiryDate == null ? "" : re.LicenseExpiryDate.ToString();
            ((TextBox)FVDriver.FindControl("txtdvTotalExperience")).Text = re.TotalExperience == null ? "" : re.TotalExperience.ToString();
            ((TextBox)FVDriver.FindControl("txtdvAreaOfResidence")).Text = re.AreaofResidence == null ? "" : re.AreaofResidence.ToString();
            ((TextBox)FVDriver.FindControl("txtdvContact1")).Text = re.Contact1 == null ? "" : re.Contact1.ToString();
            ((TextBox)FVDriver.FindControl("txtdvContact2")).Text = re.Contact2==null ?"":re.Contact2.ToString();
            int chk = Convert.ToInt32(re.Attrited.ToString());
            CheckBox chkAttrited = ((CheckBox)FVDriver.FindControl("chkAttrited"));
            if (chk == 1)
            {
                chkAttrited.Checked = true;
            }
            else
            {
                chkAttrited.Checked = false;
            }
            ((Image)FVDriver.FindControl("imgfvdPhoto")).ImageUrl = re.Photo.ToString();
            ((Image)FVDriver.FindControl("imgfvdFinger")).ImageUrl = re.FingerPrint.ToString();

            ((Label)FVDriver.FindControl("lblfvdPhoto")).Text = re.Photo.ToString();
            ((Label)FVDriver.FindControl("lblfvdFinger")).Text = re.FingerPrint.ToString();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            dm.ID = _DriverId;
            dm.CabID = _CabId;//Convert.ToInt32(((DropDownList)FVDriver.FindControl("ddlDvCabID")).SelectedValue);
            dm.DriverName = ((TextBox)FVDriver.FindControl("txtDvDriverName")).Text;
            dm.DateOfJoining = ((TextBox)FVDriver.FindControl("txtDateOfJoining")).Text == "" ? DateTime.MinValue : Convert.ToDateTime(((TextBox)FVDriver.FindControl("txtDateOfJoining")).Text);
            dm.BadgeNo = ((TextBox)FVDriver.FindControl("txtdvBadgeNo")).Text;
            dm.BadgeIssueDate = ((TextBox)FVDriver.FindControl("txtdvBadgeIssueDate")).Text == "" ? DateTime.MinValue : Convert.ToDateTime(((TextBox)FVDriver.FindControl("txtdvBadgeIssueDate")).Text);
            dm.BadgeExpiryDate = ((TextBox)FVDriver.FindControl("txtdvBadgeExpiryDate")).Text == "" ? DateTime.MinValue : Convert.ToDateTime(((TextBox)FVDriver.FindControl("txtdvBadgeExpiryDate")).Text);
            dm.LicenseNumber = ((TextBox)FVDriver.FindControl("txtdvLicenseNumber")).Text;
            dm.LicenseIssuedDate = ((TextBox)FVDriver.FindControl("txtdvLicenseIssuedDate")).Text == "" ? DateTime.MinValue : Convert.ToDateTime(((TextBox)FVDriver.FindControl("txtdvLicenseIssuedDate")).Text);
            dm.LicenseExpiryDate = ((TextBox)FVDriver.FindControl("txtdvLicenseExpiryDate")).Text == "" ? DateTime.MinValue : Convert.ToDateTime(((TextBox)FVDriver.FindControl("txtdvLicenseExpiryDate")).Text);
            dm.TotalExperience = ((TextBox)FVDriver.FindControl("txtdvTotalExperience")).Text;
            dm.AreaofResidence = ((TextBox)FVDriver.FindControl("txtdvAreaOfResidence")).Text;
            dm.Contact1 = ((TextBox)FVDriver.FindControl("txtdvContact1")).Text;
            dm.Contact2 = ((TextBox)FVDriver.FindControl("txtdvContact2")).Text;
            dm.UpdatedBy = MyApplicationSession._UserID;
            CheckBox chkAttrited = ((CheckBox)FVDriver.FindControl("chkAttrited"));
            if (chkAttrited.Checked == true)
            {
                dm.Attrited = 1;
            }
            else
            {
                dm.Attrited = 0;
            }
            dm.BloodGroup = ((DropDownList)FVDriver.FindControl("ddlBloodGroup")).SelectedValue;

            FileUpload fuPhoto = ((FileUpload)FVDriver.FindControl("FileUploadPhoto"));
            FileUpload fuFingerPrint = ((FileUpload)FVDriver.FindControl("FileUploadFinger"));
            Label lblfuPhoto = ((Label)FVDriver.FindControl("lblfvdPhoto"));
            Label lblFuFingerPrint = ((Label)FVDriver.FindControl("lblfvdFinger"));
            //if (_DriverId != 0)
            //{

            //}
            if (fuPhoto.HasFile)
            {
                string filePhotoName = fuPhoto.FileName;
                string extPhoto = System.IO.Path.GetExtension(filePhotoName.ToString());

                if (extPhoto == ".bmp" || extPhoto == ".gif" || extPhoto == ".jpg" || extPhoto == ".jpge" || extPhoto == ".png" || extPhoto == ".tif")
                {
                    filePhotoName = "P" + (DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Day.ToString() + DateTime.Now.Hour.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Second.ToString()).ToString() + extPhoto;
                    // Upload the file on the server
                    fuPhoto.SaveAs(MapPath("~/DriverPhoto/" + filePhotoName));
                    dm.Photo = "~/DriverPhoto/" + filePhotoName;
                    lblfuPhoto.Text = string.Empty;
                }
            }
            else
            {
                dm.Photo = lblfuPhoto.Text;
            }
            if (fuFingerPrint.HasFile)
            {
                string fileFingerName = fuFingerPrint.FileName;
                string extFinger = System.IO.Path.GetExtension(fileFingerName.ToString());
                if (extFinger == ".bmp" || extFinger == ".gif" || extFinger == ".jpg" || extFinger == ".jpge" || extFinger == ".png" || extFinger == ".tif")
                {
                    fileFingerName = "F" + (DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Day.ToString() + DateTime.Now.Hour.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Second.ToString()).ToString() + extFinger;
                    // Upload the file on the server
                    fuFingerPrint.SaveAs(MapPath("~/DriverPhoto/" + fileFingerName));
                    dm.FingerPrint = "~/DriverPhoto/" + fileFingerName;
                    lblFuFingerPrint.Text = string.Empty;
                }
            }
            else
            {
                dm.FingerPrint = lblFuFingerPrint.Text;
            }
            string result = tms.InsertDriverDetails(dm.ID, dm.CabID, dm.DriverName, dm.DateOfJoining, dm.BadgeNo, dm.BadgeIssueDate, dm.BadgeExpiryDate, dm.LicenseNumber, dm.LicenseIssuedDate, dm.LicenseExpiryDate, dm.TotalExperience, dm.AreaofResidence, dm.Contact1, dm.Contact2, dm.UpdatedBy, dm.Attrited, dm.BloodGroup, dm.Photo, dm.FingerPrint).ElementAtOrDefault(0).RESULT.Value.ToString();
            if (result.Equals("1"))
            {
                ShowMessage("Record Added Successfully!");
                //EmptyField();
            }
            else if (result.Equals("2"))
            {
                ShowMessage("Record Updated Successfully!");
                EmptyField();
                BndDriverGrid();
                MultiView1.ActiveViewIndex = 0;
            }
            else
            {
                ShowMessage("Record Already Exists!");
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    private void ShowMessage(string msg)
    {
        string jScript = "alert('" + msg + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);
    }

    protected void lkbCabId_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lbCabId= sender as LinkButton;
            GridViewRow grv = (GridViewRow)lbCabId.Parent.Parent;
            int rowIndex = grv.RowIndex;
            int CabID = Convert.ToInt32(GVDriverMaster.DataKeys[rowIndex]["ID"].ToString());

            FVDriverDetails.DataSource = tms.SelectDriverMasterById(CabID);
            FVDriverDetails.DataBind();
            ModalPopupExtender1.Show();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        EmptyField();
    }
    protected void lkbExport_Click(object sender, EventArgs e)
    {
        GVDriverMaster.AllowPaging = false;
        GVDriverMaster.DataSource = tms.GetDriverDetails(Convert.ToInt32(ddlSelectFacility.SelectedValue), Convert.ToInt32(ddlSelectVendor.SelectedValue));
        GVDriverMaster.DataBind();
        GridViewExportUtil.Export("DriverMaster.xls", GVDriverMaster);  
    }
}
