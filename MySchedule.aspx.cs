using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

public partial class MySchedule : basepage
{
    DataClasses1DataContext context = new DataClasses1DataContext();
    DateTime lockSDate, lockEDate, lockPickTime, lockDropTime;

    public int _SpocID
    {
        get
        {
            return (int)ViewState["_SpocID"];
        }

        set
        {
            ViewState["_SpocID"] = value;
        }
    }
    public int _DropRequest
    {
        get
        {
            return (int)ViewState["_DropRequest"];
        }

        set
        {
            ViewState["_DropRequest"] = value;
        }
    }

    public int _empId
    {
        get
        {
            return (int)ViewState["_empId"];
        }

        set
        {
            ViewState["_empId"] = value;
        }
    }

    public DateTime _seldate
    {
        get
        {
            return (DateTime)ViewState["_seldate"];
        }

        set
        {
            ViewState["_seldate"] = value;
        }
    }

    

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //Label1.Text = "View/Edit Transport Schedule";
            //Label2.Visible = true;

            if (!IsPostBack)
            {
                _SpocID = MyApplicationSession._UserID;
                _DropRequest = 0;
                txtCalendar.Text = System.DateTime.Now.Date.ToString("MM/dd/yyyy");
                MultiView1.ActiveViewIndex = 0;
                bindgrdEmployeeSchedule();
                ISTptBlocked();
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }

    }

    protected void txtCalendar_TextChanged(object sender, EventArgs e)
    {

        bindgrdEmployeeSchedule();
    }
    protected void bindgrdEmployeeSchedule()
    {
        //**********************************************************************************
        // Get the List of employees of Selected facility and selected Process of Login SPOC
        // Set the value of Gridview Headers to DaysOfWeeks like Mon, Tues..etc
        //**********************************************************************************
        try
        {
            lblErrorMsg.Text = string.Empty;
            lblErrorMsg.Visible = false;
            txt_PageSize.Text = grdEmployeeSchedule.PageSize.ToString();
            DateTime sDate = new DateTime();
            if (Regex.IsMatch(txtCalendar.Text, @"^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"))
            {
                sDate = Convert.ToDateTime(txtCalendar.Text);
                grdEmployeeSchedule.DataSource = context.GetMgrSchedule(MyApplicationSession._UserID, sDate);
                grdEmployeeSchedule.Columns[3].HeaderText = sDate.AddDays(0).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(0).Day.ToString() + "-" + sDate.AddDays(0).ToString("MMM");
                grdEmployeeSchedule.Columns[4].HeaderText = sDate.AddDays(1).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(1).Day.ToString() + "-" + sDate.AddDays(1).ToString("MMM");
                grdEmployeeSchedule.Columns[5].HeaderText = sDate.AddDays(2).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(2).Day.ToString() + "-" + sDate.AddDays(2).ToString("MMM");
                grdEmployeeSchedule.Columns[6].HeaderText = sDate.AddDays(3).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(3).Day.ToString() + "-" + sDate.AddDays(3).ToString("MMM");
                grdEmployeeSchedule.Columns[7].HeaderText = sDate.AddDays(4).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(4).Day.ToString() + "-" + sDate.AddDays(4).ToString("MMM");
                grdEmployeeSchedule.Columns[8].HeaderText = sDate.AddDays(5).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(5).Day.ToString() + "-" + sDate.AddDays(5).ToString("MMM");
                grdEmployeeSchedule.Columns[9].HeaderText = sDate.AddDays(6).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(6).Day.ToString() + "-" + sDate.AddDays(6).ToString("MMM");

                grdEmployeeSchedule.DataBind();
                int totalRows = context.GetMgrSchedule(MyApplicationSession._UserID, sDate).Count();
                DisplayRecords(totalRows);
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }
    }

    private void DisplayRecords(int totalRows)
    {
        int PageFirstCount = (grdEmployeeSchedule.PageIndex * grdEmployeeSchedule.PageSize) + 1;
        int PageLastCount = (grdEmployeeSchedule.PageIndex * grdEmployeeSchedule.PageSize) + grdEmployeeSchedule.Rows.Count;
        Label lblRecordsPerPage = (Label)grdEmployeeSchedule.FooterRow.FindControl("lblRecordsPerPage");
        lblRecordsPerPage.Text = string.Empty;
        lblRecordsPerPage.Text = "Records: " + PageFirstCount + " - " + PageLastCount + " of " + totalRows;
    }
    protected void ISTptBlocked()
    {
        var result = context.GetIsTptBlocked(MyApplicationSession._UserID);

        foreach (var result1 in result)
        {
            if ((result1.IsBlock == 1) && (result1.IsProcessed == 1))
            {
                lblIsBlocked.Visible = true;
                lblIsBlocked.Text = "Your Transport has been blocked On " + result1.EffectiveOn.Value.ToShortDateString() + " due to No Show.";
                lblIsBlocked.ForeColor = System.Drawing.Color.Red;
            }
            else if ((result1.IsBlock == 1) && (result1.IsProcessed == 0))
            {
                lblIsBlocked.Visible = true;
                lblIsBlocked.Text = "Your Transport will be blocked effective on " + result1.EffectiveOn.Value.ToShortDateString() + " due to No Show.";
                lblIsBlocked.ForeColor = System.Drawing.Color.Orange;

            }
            else
            {
                lblIsBlocked.Visible = false;

            }

        }

    }
    protected void grdEmployeeSchedule_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //********************************************************
        // view the current page of grid to selected page index
        //********************************************************
        try
        {
            // bindgrdEmployeeSchedule();
            grdEmployeeSchedule.PageIndex = e.NewPageIndex;
            bindgrdEmployeeSchedule();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }
    }
    protected void lnkBtnEmpName_Click(object sender, EventArgs e)
    {
        //********************************************************************
        // Selected the current view to selected Employee Details view
        //********************************************************************
        try
        {

            //Label1.Text = "Edit Mobile Number.";
            //Label2.Visible = false;
            MultiView1.ActiveViewIndex = 1;
            LinkButton EmpNameButton = sender as LinkButton;
            _empId = Convert.ToInt32(EmpNameButton.CommandArgument);
            var r = context.GetEmpGeoCodeDetails(_empId);
            foreach (var r1 in r)
            {
                
                DvGeo.HeaderText = "Allows to Edit Mobile Mumber.";
                ((Label)DvGeo.FindControl("lbldvEmpLoyeeID")).Text = r1.empCode;
                ((Label)DvGeo.FindControl("lbldvEmpName")).Text = r1.empName;
                ((CheckBox)DvGeo.FindControl("chkBxTptReq")).Checked = Convert.ToBoolean(r1.tptReq);
                ((Label)DvGeo.FindControl("lbldvAddress1")).Text = r1.address;
                ((Label)DvGeo.FindControl("lblMobile")).Text = r1.mobile.Trim();
                ((Label)DvGeo.FindControl("lbldvfacility")).Text = r1.Facility.Trim();


                string city = r1.city;
                string col = r1.colony;
                DropDownList ddlCity = (DropDownList)DvGeo.FindControl("ddldvCity");
                ddlCity.Items.Clear();
                ListItem licity = new ListItem("Select City", "0");
                ddlCity.Items.Add(licity);
                ddlCity.DataSource = context.GetGeoCity();
                ddlCity.DataTextField = "city";
                ddlCity.DataValueField = "city";
                ddlCity.DataBind();
                ddlCity.SelectedIndex = ddlCity.Items.IndexOf(ddlCity.Items.FindByText(city.ToString()));
                DropDownList ddlcol = (DropDownList)DvGeo.FindControl("ddldvColony");
                ddlcol.Items.Clear();
                ListItem licol = new ListItem("Select Colony", "0");
                ddlcol.Items.Add(licol);
                ddlcol.DataSource = context.GetGeoCityColony(city);
                ddlcol.DataTextField = "colony";
                ddlcol.DataValueField = "colony";
                ddlcol.DataBind();
                ddlcol.SelectedIndex = ddlcol.Items.IndexOf(ddlcol.Items.FindByText(col.ToString()));
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }
    }

    protected void btnGeoClose_Click(object sender, EventArgs e)
    {
        //*****************************************************************
        // Set the current view to Default View
        //*****************************************************************
        try
        {
            MultiView1.ActiveViewIndex = 0;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }
    }

    protected string CheckImage(object strArg)
    {
        //*********************************************************************
        // To Check and assign image based on wether employee is geocoed or not.
        //**********************************************************************

        string val = Convert.ToString(strArg);
        if (val == "Y" || val == "y")
        {
            return "Images/GeoCode.gif";
        }
        else
        {
            return "Images/NonGeoCode.gif";
        }

    }

    protected string CheckTptReq(object strArg)
    {
        //*********************************************************************************
        // To Check and assign image based on wether employee is required Transport or not.
        //*********************************************************************************

        string val = Convert.ToString(strArg);

        if (val == "Y" || val == "y")
        {
            return "Images/TptReq.gif";
        }
        else
        {
            return "Images/TptNotReq.gif";
        }

    }

    protected string CheckAltTptReq(object strArg)
    {
        //*********************************************************************************
        // To Check and assign image based on wether employee is required Transport or not.
        //*********************************************************************************

        string val = Convert.ToString(strArg);

        if (val == "Y" || val == "y")
        {
            return "Availing Transport.";
        }
        else
        {
            return "Not Availing Transport.";
        }

    }

    protected string CheckAltGeocode(object strArg)
    {
        //*********************************************************************************
        // To Check and assign image based on wether employee is required Transport or not.
        //*********************************************************************************

        string val = Convert.ToString(strArg);

        if (val == "Y" || val == "y")
        {
            return "Geocoded";
        }
        else
        {
            return "Not Geocoded";
        }

    }





    protected DateTime GetShiftdate(int addDays)
    {
        return Convert.ToDateTime(txtCalendar.Text).AddDays(addDays);
    }

    protected Boolean GetEnableOrNot(int addDays)
    {
        Boolean flag;
        if (Convert.ToDateTime(txtCalendar.Text).AddDays(addDays) < DateTime.Now.Date.AddDays(-1))
        {
            flag = false;
        }
        else
        {
            flag = true;
        }
        return flag;
    }
    

    protected void txt_PageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        //******************************************************************************
        // Set the pageSize of Selected grid if the records are greater then 10
        //******************************************************************************
        try
        {
            if ((txt_PageSize.Text != string.Empty) && (Regex.IsMatch(txt_PageSize.Text, @"^([\d])*$")))
            {
                if (Convert.ToInt32(txt_PageSize.Text) >= 10)
                {
                    grdEmployeeSchedule.PageSize = Convert.ToInt32(txt_PageSize.Text);
                    bindgrdEmployeeSchedule();
                }
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }

    }
    protected void DvGeo_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        //*****************************************************************
        // Set the current view to Default View
        //*****************************************************************
        try
        {
            Label lblMobile = ((Label)DvGeo.FindControl("lblMobile"));
            LinkButton lbEditMobile = ((LinkButton)DvGeo.FindControl("lbEditMobile"));
            LinkButton lbSaveMobile = ((LinkButton)DvGeo.FindControl("lbSaveMobile"));
            LinkButton lbCancelMobile = ((LinkButton)DvGeo.FindControl("lbCancelMobile"));
            TextBox txtMobile = ((TextBox)DvGeo.FindControl("txtMobile"));
            Image imgStatus = ((Image)DvGeo.FindControl("imgStatus"));
            lblMobile.Visible = true;
            txtMobile.Visible = false;
            lbEditMobile.Visible = true;
            lbSaveMobile.Visible = false;
            lbCancelMobile.Visible = false;
            imgStatus.Visible = false;
            MultiView1.ActiveViewIndex = 0;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }
    }

    protected void imgBtnRoute_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton imgBtnRoute = sender as ImageButton;
        GridViewRow row = imgBtnRoute.NamingContainer as GridViewRow;
        int rowIndex = Convert.ToInt32(row.RowIndex);
        _seldate = Convert.ToDateTime(imgBtnRoute.CommandArgument);
        Int32 selEmployeeID = Convert.ToInt32(grdEmployeeSchedule.DataKeys[rowIndex].Value);

        Panel1.Visible = false;
        Panel2.Visible = false;

        grdShowPickUpRoute.DataSource = context.GetMyRoutesDetails(selEmployeeID, _seldate, "P");
        grdShowPickUpRoute.DataBind();

        if (grdShowPickUpRoute.Rows.Count > 0)
        {
            Panel1.Visible = true;
            string routeID = grdShowPickUpRoute.DataKeys[0]["routeid"].ToString();
            var pickUpResult = context.GetRouteInfo(routeID);

            foreach (var pickUpResult1 in pickUpResult)
            {
                lblPickRouteID.Text = pickUpResult1.Id;
                lblPickShiftDate.Text = pickUpResult1.shiftDate.ToShortDateString();
                lblPickShiftTime.Text = pickUpResult1.shiftTime;
                if (pickUpResult1.tripType.ToString() == "P")
                {
                    lblPickTripType.Text = "PickUp";
                }
                lblPickVendorName.Text = pickUpResult1.vendorName;
                lblPickStickerNo.Text = pickUpResult1.vehicleNo;
                lblPickFacility.Text = pickUpResult1.facility;
            }
        }

        grdShowDropRoute.DataSource = context.GetMyRoutesDetails(selEmployeeID, _seldate, "D");
        grdShowDropRoute.DataBind();

        if (grdShowDropRoute.Rows.Count > 0)
        {
            Panel2.Visible = true;
            string routeID = grdShowDropRoute.DataKeys[0]["routeid"].ToString();
            var DropUpResult = context.GetRouteInfo(routeID);

            foreach (var DropUpResult1 in DropUpResult)
            {
                lblDropRouteID.Text = DropUpResult1.Id;
                lblDropShiftDate.Text = DropUpResult1.shiftDate.ToShortDateString();
                lblDropShiftTime.Text = DropUpResult1.shiftTime;
                if (DropUpResult1.tripType.ToString() == "D")
                {
                    lblDropTripType.Text = "Drop";
                }
                lblDropVendorName.Text = DropUpResult1.vendorName;
                lblDropStickerNo.Text = DropUpResult1.vehicleNo;
                lblDropFacility.Text = DropUpResult1.facility;
            }
        }

        ModalPopupExtender.Show();
        MultiView3.ActiveViewIndex = 0;
        
    }
    
    protected void lbEditMobile_Click(object sender, EventArgs e)
    {
        Label lblMobile = ((Label)DvGeo.FindControl("lblMobile"));
        LinkButton lbEditMobile = ((LinkButton)DvGeo.FindControl("lbEditMobile"));
        LinkButton lbSaveMobile = ((LinkButton)DvGeo.FindControl("lbSaveMobile"));
        LinkButton lbCancelMobile = ((LinkButton)DvGeo.FindControl("lbCancelMobile"));
        TextBox txtMobile = ((TextBox)DvGeo.FindControl("txtMobile"));
        Image imgStatus = ((Image)DvGeo.FindControl("imgStatus"));
        txtMobile.Text = lblMobile.Text;
        txtMobile.Focus();

        lblMobile.Visible = false;
        txtMobile.Visible = true;
        lbEditMobile.Visible = false;
        lbSaveMobile.Visible = true;
        lbCancelMobile.Visible = true;
        imgStatus.Visible = false;

    }
    protected void lbSaveMobile_Click(object sender, EventArgs e)
    {
        TextBox txtMobile = ((TextBox)DvGeo.FindControl("txtMobile"));
        string NewMobileNo = txtMobile.Text;
        Label lblMobile = ((Label)DvGeo.FindControl("lblMobile"));
        string OldMobileNo = lblMobile.Text;
        var result = context.UpdateEmpMobile(_empId, OldMobileNo, NewMobileNo, MyApplicationSession._UserID).ElementAtOrDefault(0).result;
        Image imgStatus = ((Image)DvGeo.FindControl("imgStatus"));
        imgStatus.Visible = true;
        if (result >= 1)
        {
            imgStatus.ImageUrl = "Images/checkmark.gif";
            imgStatus.AlternateText = "Saved Successfully.";
        }
        else
        {
            imgStatus.ImageUrl = "Images/delete1.jpg";
            imgStatus.AlternateText = "Save Failed.";
        }
        LinkButton lbEditMobile = ((LinkButton)DvGeo.FindControl("lbEditMobile"));
        LinkButton lbSaveMobile = ((LinkButton)DvGeo.FindControl("lbSaveMobile"));
        LinkButton lbCancelMobile = ((LinkButton)DvGeo.FindControl("lbCancelMobile"));

        lblMobile.Visible = true;
        txtMobile.Visible = false;
        lbEditMobile.Visible = true;
        lbSaveMobile.Visible = false;
        lbCancelMobile.Visible = false;

        lblMobile.Text = context.GetEmpGeoCodeDetails(_empId).ElementAtOrDefault(0).mobile;
    }
    protected void lbCancelMobile_Click(object sender, EventArgs e)
    {
        Label lblMobile = ((Label)DvGeo.FindControl("lblMobile"));
        LinkButton lbEditMobile = ((LinkButton)DvGeo.FindControl("lbEditMobile"));
        LinkButton lbSaveMobile = ((LinkButton)DvGeo.FindControl("lbSaveMobile"));
        LinkButton lbCancelMobile = ((LinkButton)DvGeo.FindControl("lbCancelMobile"));
        TextBox txtMobile = ((TextBox)DvGeo.FindControl("txtMobile"));
        Image imgStatus = ((Image)DvGeo.FindControl("imgStatus"));

        lblMobile.Visible = true;
        txtMobile.Visible = false;
        lbEditMobile.Visible = true;
        lbSaveMobile.Visible = false;
        lbCancelMobile.Visible = false;
        imgStatus.Visible = false;
    }

    protected void lnkBtnShift_Click(object sender, EventArgs e)
    {
        MultiView2.ActiveViewIndex=0;
        Panel pnlCaption = (Panel)dvEditEmployeeSchedule.FindControl("pnlCaption");
        pnlCaption.Visible = false;
        Panel pnlUpdateMsg = (Panel)dvEditEmployeeSchedule.FindControl("pnlUpdateMsg");
        pnlUpdateMsg.Visible = false;
        LinkButton lnkbtnSETime = (LinkButton)sender;
        _seldate = Convert.ToDateTime(lnkbtnSETime.CommandArgument);
        var result = context.GetLockDetails(MyApplicationSession._FacilityID);
        foreach (var result1 in result)
        {
            lockSDate = Convert.ToDateTime(result1.lockSDate);
            lockEDate = Convert.ToDateTime(result1.lockEDate);
            lockPickTime = Convert.ToDateTime(result1.pickLockDateTime);
            lockDropTime = Convert.ToDateTime(result1.dropLockDateTime);
        }

        _DropRequest = 0;
        //if ((seldate >= lockSDate) && (seldate <= lockEDate))
        //{
        GridViewRow row = lnkbtnSETime.NamingContainer as GridViewRow;
        int rowIndex = Convert.ToInt32(row.RowIndex);
        Int32 selEmployeeID = Convert.ToInt32(grdEmployeeSchedule.DataKeys[rowIndex].Value);
        var r = context.GetOneEmployeeSchedule(selEmployeeID, _seldate);

        foreach (var r1 in r)
        {
            ((Label)dvEditEmployeeSchedule.FindControl("lblShiftEmployeeID")).Text = r1.empCode;
            ((Label)dvEditEmployeeSchedule.FindControl("lblShiftEmpName")).Text = r1.empName;
            ((Label)dvEditEmployeeSchedule.FindControl("lblShiftdate")).Text = _seldate.ToLongDateString();


            string LogInFacility = Convert.ToString(r1.pickFacilityID);
            string LogOutFacility = Convert.ToString(r1.dropFacilityID);
            string LogInTime = r1.startTime;
            string LogOutTime = r1.endTime;

            DropDownList ddlInFacility = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlInFacility");
            ddlInFacility.Items.Clear();
            ListItem liInFacility = new ListItem("-Facility-", "0");
            ddlInFacility.Items.Add(liInFacility);
            ddlInFacility.DataSource = context.SelectFacility(_SpocID,false);
            ddlInFacility.DataTextField = "facilityName";
            ddlInFacility.DataValueField = "Id";
            ddlInFacility.DataBind();

            ddlInFacility.SelectedIndex = ddlInFacility.Items.IndexOf(ddlInFacility.Items.FindByValue(LogInFacility.ToString()));


            DropDownList ddlInTime = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlInTime");
            ddlInTime.Items.Clear();
            ListItem liIn0 = new ListItem("-Select-", "0");
            ddlInTime.Items.Insert(0, liIn0);
            ListItem liIn1 = new ListItem("N/A", "N/A");
            ddlInTime.Items.Insert(1, liIn1);
            ddlInTime.DataSource = context.GetPickShiftTime(Int32.Parse(LogInFacility), _seldate);
            ddlInTime.DataTextField = "shiftTime";
            ddlInTime.DataValueField = "shiftTime";
            ddlInTime.DataBind();
            ddlInTime.SelectedIndex = ddlInTime.Items.IndexOf(ddlInTime.Items.FindByValue(LogInTime.ToString()));

            Label lblInTime = (Label)dvEditEmployeeSchedule.FindControl("lblInTime");
            DateTime LoginDatetime = GetDateTimeComb(Convert.ToDateTime(r1.startDate), LogInTime);
            if (LoginDatetime <= lockPickTime)
            {
                ddlInFacility.Enabled = false;
                ddlInTime.Visible = false;
                lblInTime.Visible = true;
                lblInTime.Text = LogInTime;
            }
            else
            {
                ddlInFacility.Enabled = true;
                ddlInTime.Visible = true;
                lblInTime.Visible = false;
            }

            DropDownList ddlOutFacility = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlOutFacility");
            ddlOutFacility.Items.Clear();
            ListItem liOutFacility = new ListItem("-Facility-", "0");
            ddlOutFacility.Items.Add(liOutFacility);
            ddlOutFacility.DataSource = context.SelectFacility(_SpocID,false);
            ddlOutFacility.DataTextField = "facilityName";
            ddlOutFacility.DataValueField = "Id";
            ddlOutFacility.DataBind();

            ddlOutFacility.SelectedIndex = ddlOutFacility.Items.IndexOf(ddlOutFacility.Items.FindByValue(LogOutFacility.ToString()));
            DropDownList ddlOutTime = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlOutTime");
            ddlOutTime.Items.Clear();
            ListItem liOut0 = new ListItem("-Select-", "0");
            ddlOutTime.Items.Insert(0, liOut0);
            ListItem liOut1 = new ListItem("N/A", "N/A");
            ddlOutTime.Items.Insert(1, liOut1);
            ddlOutTime.DataSource = context.GetDropShiftTime(Int32.Parse(LogOutFacility), _seldate,"A");
            ddlOutTime.DataTextField = "shiftTime";
            ddlOutTime.DataValueField = "shiftTime";
            ddlOutTime.DataBind();
            ddlOutTime.SelectedIndex = ddlOutTime.Items.IndexOf(ddlOutTime.Items.FindByValue(LogOutTime.ToString()));

            Label lblOutTime = (Label)dvEditEmployeeSchedule.FindControl("lblOutTime");

            Button btnSaveShift = (Button)dvEditEmployeeSchedule.FindControl("btnSaveShift");
            DateTime LogoutDatetime = GetDateTimeCombDrop(Convert.ToDateTime(r1.startDate), LogOutTime);

            if (LogoutDatetime <= lockDropTime)
            {
                ddlOutFacility.Enabled = false;
                ddlOutTime.Visible = false;
                btnSaveShift.Visible = false;
                lblOutTime.Visible = true;
                lblOutTime.Text = LogOutTime;
                Panel pnl = (Panel)dvEditEmployeeSchedule.FindControl("pnlConfirmDrop");
                pnl.Visible = true;

            }
            else
            {
                ddlOutFacility.Enabled = true;
                ddlOutTime.Visible = true;
                btnSaveShift.Visible = true;
                lblOutTime.Visible = false;
                Panel pnl = (Panel)dvEditEmployeeSchedule.FindControl("pnlConfirmDrop");
                pnl.Visible = false;
            }
        }
        ModalPopupExtender1.Show();
        //}
        //else
        //{
        //    lblSaveMsg.Text = "Roster is Lock";
        //    lblSaveMsg.Visible = true;

        //}
    }
    protected DateTime GetDateTimeComb(DateTime sDate, string Time)
    {
        string result;
        if ((Time != "") && (Time != "N/A"))
        {
            result = Convert.ToDateTime(sDate).ToString("MM/dd/yyyy") + " " + Time.Trim().Substring(0, 2) + ":" + Time.Trim().Substring(Time.Trim().Length - 2, Time.Trim().Length - 2);
        }
        else
        {
            result = Convert.ToDateTime(sDate).AddDays(1).ToString("MM/dd/yyyy");
            
        }
        return Convert.ToDateTime(result);
    }

    protected DateTime GetDateTimeCombDrop(DateTime sDate, string Time)
    {
        string result;
        if ((Time != "") && (Time != "N/A"))
        {
            result = Convert.ToDateTime(sDate).ToString("MM/dd/yyyy") + " " + Time.Trim().Substring(0, 2) + ":" + Time.Trim().Substring(Time.Trim().Length - 2, Time.Trim().Length - 2);
        }
        else
        {
            result = Convert.ToDateTime(sDate).AddDays(1).ToString("MM/dd/yyyy") + " " + "23:59";

        }
        return Convert.ToDateTime(result);
    }

    protected void ddlInFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        //DropDownList ddlInFacility = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlInFacility");
        DropDownList ddlInFacility = (DropDownList)sender;
        DropDownList lBxIn0 = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlInTime");
        DateTime sDate = DateTime.Parse(((Label)dvEditEmployeeSchedule.FindControl("lblShiftdate")).Text);
        string selFacilityIDIn = ddlInFacility.SelectedValue.ToString();
        lBxIn0.Items.Clear();
        lBxIn0.DataSource = context.GetPickShiftTime(Int32.Parse(selFacilityIDIn), sDate);
        lBxIn0.DataTextField = "shiftTime";
        lBxIn0.DataValueField = "shiftTime";
        lBxIn0.DataBind();
        ListItem liIn0 = new ListItem("Select", "0");
        lBxIn0.Items.Insert(0, liIn0);
        ListItem liIn1 = new ListItem("N/A", "N/A");
        lBxIn0.Items.Insert(1, liIn1);
        ModalPopupExtender1.Show();
    }
    protected void ddlOutFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlOutFacility = (DropDownList)sender;
        DropDownList lBxOut0 = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlOutTime");
        DateTime sDate = DateTime.Parse(((Label)dvEditEmployeeSchedule.FindControl("lblShiftdate")).Text);
        string selFacilityIDOut = ddlOutFacility.SelectedValue.ToString();
        lBxOut0.Items.Clear();
        if (_DropRequest == 0)
        {
            lBxOut0.DataSource = context.GetDropShiftTime(Int32.Parse(selFacilityIDOut), sDate, "Admin");
        }
        else
        {
            lBxOut0.DataSource = context.GetDropShiftTimeUnSchedule(Int32.Parse(selFacilityIDOut), sDate);
        }
        lBxOut0.DataTextField = "shiftTime";
        lBxOut0.DataValueField = "shiftTime";
        lBxOut0.DataBind();
        ListItem liOut0 = new ListItem("Select", "0");
        lBxOut0.Items.Insert(0, liOut0);
        ListItem liOut1 = new ListItem("N/A", "N/A");
        lBxOut0.Items.Insert(1, liOut1);
        ModalPopupExtender1.Show();
    }
    protected void btnSaveShift_Click(object sender, EventArgs e)
    {
        string empID = ((Label)dvEditEmployeeSchedule.FindControl("lblShiftEmployeeID")).Text;
        DateTime sDate = DateTime.Parse(((Label)dvEditEmployeeSchedule.FindControl("lblShiftdate")).Text);
        string sTime = ((DropDownList)dvEditEmployeeSchedule.FindControl("ddlInTime")).SelectedValue;
        if (sTime == "0")
        {
            sTime = ((Label)dvEditEmployeeSchedule.FindControl("lblInTime")).Text;
        }
        
        string eTime = ((DropDownList)dvEditEmployeeSchedule.FindControl("ddlOutTime")).SelectedValue;
        if (eTime == "0")
        {
            eTime = ((Label)dvEditEmployeeSchedule.FindControl("lblOutTime")).Text;
        }

        string selFacilityIDIn = ((DropDownList)dvEditEmployeeSchedule.FindControl("ddlInFacility")).SelectedValue;
        string selFacilityIDOut = ((DropDownList)dvEditEmployeeSchedule.FindControl("ddlOutFacility")).SelectedValue;
        if (sDate <= lockPickTime)
        {
            sTime = "0";
            selFacilityIDIn = "0";
        }
        if (sDate <= lockDropTime)
        {
            eTime = "0";
            selFacilityIDOut = "0";
        }
        
        var result = context.UpdateEmpSchedule(empID, sDate, sTime.Trim(), eTime.Trim(), Int32.Parse(selFacilityIDIn), Int32.Parse(selFacilityIDOut), _SpocID);
        int IsLoginUpdated = 1, IsLogOutUpdated = 1;
        foreach (var result1 in result)
        {
            IsLoginUpdated = result1.IsLogInProcessed;
            IsLogOutUpdated = result1.IsLogOutProcessed;
        }
        Panel pnlUpdateMsg = (Panel)dvEditEmployeeSchedule.FindControl("pnlUpdateMsg");
        
        Label Label3 = (Label)dvEditEmployeeSchedule.FindControl("Label3");
        if (IsLoginUpdated <= 0 && IsLogOutUpdated <= 0)
        {
            pnlUpdateMsg.Visible = true;
            Label3.Text = "Login-Logout cannot updated because of they are falling under non hiring zone.";
            ModalPopupExtender1.Show();
        }
        else if (IsLoginUpdated <= 1 && IsLogOutUpdated <= 0)
        {
            pnlUpdateMsg.Visible = true;
            Label3.Text = "Logout cannot updated because of falling under non hiring zone.";
            ModalPopupExtender1.Show();
        }
        else if (IsLoginUpdated <= 0 && IsLogOutUpdated <= 1)
        {
            pnlUpdateMsg.Visible = true;
            Label3.Text = "Login cannot updated because of falling under non hiring zone.";
            ModalPopupExtender1.Show();
        }
        else
        {
            pnlUpdateMsg.Visible = false;
            ModalPopupExtender1.Hide();
            MultiView1.ActiveViewIndex = 0;
        }


        if (_DropRequest == 1)
        {
            context.UpdateDropRequestFlag(_SpocID.ToString(), sDate); 
        }
        bindgrdEmployeeSchedule();
    }
    protected void btnConfirmDropYes_Click(object sender, EventArgs e)
    {
        DropDownList ddlOutFacility = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlOutFacility");
        ddlOutFacility.Enabled = true;
        DropDownList ddlOutTime = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlOutTime");
        ddlOutTime.Visible = true;
        string LogOutFacility = ddlOutFacility.SelectedValue.ToString();

        ddlOutFacility.SelectedIndex = ddlOutFacility.Items.IndexOf(ddlOutFacility.Items.FindByValue(LogOutFacility.ToString()));
        ddlOutTime.Items.Clear();
        ListItem liOut0 = new ListItem("-Select-", "0");
        ddlOutTime.Items.Insert(0, liOut0);
        ListItem liOut1 = new ListItem("N/A", "N/A");
        ddlOutTime.Items.Insert(1, liOut1);
        ddlOutTime.DataSource = context.GetDropShiftTimeUnSchedule(Int32.Parse(LogOutFacility), _seldate);
        ddlOutTime.DataTextField = "shiftTime";
        ddlOutTime.DataValueField = "shiftTime";
        ddlOutTime.DataBind();

        Button btnSaveShift = (Button)dvEditEmployeeSchedule.FindControl("btnSaveShift");
        btnSaveShift.Visible = true;
        Label lblOutTime = (Label)dvEditEmployeeSchedule.FindControl("lblOutTime");
        lblOutTime.Visible = false;
        Panel pnl = (Panel)dvEditEmployeeSchedule.FindControl("pnlConfirmDrop");
        pnl.Visible = false;
        _DropRequest = 1;
        Panel pnlCaption = (Panel)dvEditEmployeeSchedule.FindControl("pnlCaption");
        pnlCaption.Visible = true;
        ModalPopupExtender1.Show();
    }
    protected void btnConfirmDropNo_Click(object sender, EventArgs e)
    {
        ModalPopupExtender1.Hide();
    }
    protected void grdEmployeeSchedule_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void btnNewSchedule_Click(object sender, EventArgs e)
    {

    }
}
