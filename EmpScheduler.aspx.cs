using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EmpScheduler : basepage
{
    DateTime lockSDate, lockEDate, lockPickTime, lockDropTime;
    DateTime sDate = new DateTime();
    DataClasses1DataContext TmsDataContext = new DataClasses1DataContext();

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
    public int _Facility
    {
        get
        {
            return (int)ViewState["_Facility"];
        }

        set
        {
            ViewState["_Facility"] = value;
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
            lblSaveMsg.Text = "";
            if (!IsPostBack)
            {
                _SpocID = MyApplicationSession._UserID;
                Session["Spoc"] = _SpocID;
                txtCalendar.Attributes.Add("readOnly", "true");
                string flag=null;
            flag=TmsDataContext.getDefaulttime().ElementAtOrDefault(0).result.ToString();
                if (flag == "1")
                {
                    txtCalendar.Text = DateTime.Today.AddDays(-1).ToShortDateString();
                }
                else
                {
                    txtCalendar.Text = DateTime.Today.AddDays(0).ToShortDateString();
                
                }
                    lblDate.Text = Convert.ToDateTime(txtCalendar.Text).ToString("dd-MMM-yyyy");
                bindgrdEmployeeSchedule();
                bindShiftHeader();
                bindShiftHeaders();
                bndshiftboxheader();
               // binBSpocDDL();
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
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

    protected void txtCalendar_TextChanged(object sender, EventArgs e)
    {
        try
        {
            lblDate.Text = Convert.ToDateTime(txtCalendar.Text).ToString("dd-MMM-yyyy");
            bindgrdEmployeeSchedule();
            bindShiftHeader();
            bindShiftHeaders();
            bndshiftboxheader();
           
            
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

  
    protected void bindgrdEmployeeSchedule()
    {
        try
        {
            DateTime sDate = new DateTime();
            sDate = Convert.ToDateTime(txtCalendar.Text);
            grdEmployeeSchedule.DataSource = TmsDataContext.GetMgrSchedule(MyApplicationSession._UserID, sDate);
            grdEmployeeSchedule.Columns[4].HeaderText = sDate.AddDays(0).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(0).Day.ToString() + "-" + sDate.AddDays(0).ToString("MMMM");
            grdEmployeeSchedule.Columns[5].HeaderText = sDate.AddDays(1).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(1).Day.ToString() + "-" + sDate.AddDays(1).ToString("MMMM");
            grdEmployeeSchedule.Columns[6].HeaderText = sDate.AddDays(2).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(2).Day.ToString() + "-" + sDate.AddDays(2).ToString("MMMM");
            grdEmployeeSchedule.Columns[7].HeaderText = sDate.AddDays(3).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(3).Day.ToString() + "-" + sDate.AddDays(3).ToString("MMMM");
            grdEmployeeSchedule.Columns[8].HeaderText = sDate.AddDays(4).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(4).Day.ToString() + "-" + sDate.AddDays(4).ToString("MMMM");
            grdEmployeeSchedule.Columns[9].HeaderText = sDate.AddDays(5).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(5).Day.ToString() + "-" + sDate.AddDays(5).ToString("MMMM");
            grdEmployeeSchedule.Columns[10].HeaderText = sDate.AddDays(6).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(6).Day.ToString() + "-" + sDate.AddDays(6).ToString("MMMM");
            grdEmployeeSchedule.DataBind();
            for (int i = 0; i < grdEmployeeSchedule.Rows.Count; i++)
            {
                if (grdEmployeeSchedule.DataKeys[i].Value.ToString() == MyApplicationSession._UserID.ToString())
                {
                    ((CheckBox)grdEmployeeSchedule.Rows[i].FindControl("chkBxEmpId")).Checked = true;
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
    protected void bndshiftboxheader()
    {
        DateTime sDate = new DateTime();
        sDate = Convert.ToDateTime(txtCalendar.Text);
        
        lblday1.Text = sDate.AddDays(0).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(0).Day.ToString() + "-" + sDate.AddDays(0).ToString("MMMM");
        string day = sDate.AddDays(0).DayOfWeek.ToString();
        if (sDate.AddDays(0).DayOfWeek.ToString() == "Saturday" || sDate.AddDays(0).DayOfWeek.ToString() == "Sunday")
        {
            chkoff0.Checked = true;
        }
        else
        {
            chkoff0.Checked = false;
        }
        if (sDate.AddDays(1).DayOfWeek.ToString() == "Saturday" || sDate.AddDays(1).DayOfWeek.ToString() == "Sunday")
        {
            chkoff1.Checked = true;
        }
        else
        {
            chkoff1.Checked = false;
        }

        if (sDate.AddDays(2).DayOfWeek.ToString() == "Saturday" || sDate.AddDays(2).DayOfWeek.ToString() == "Sunday")
        {
            chkoff2.Checked = true;
        }
        else
        {
            chkoff2.Checked = false;
        }

        if (sDate.AddDays(3).DayOfWeek.ToString() == "Saturday" || sDate.AddDays(3).DayOfWeek.ToString() == "Sunday")
        {
            chkoff3.Checked = true;
        }
        else
        {
            chkoff3.Checked = false;
        }

        if (sDate.AddDays(4).DayOfWeek.ToString() == "Saturday" || sDate.AddDays(4).DayOfWeek.ToString() == "Sunday")
        {
            chkoff4.Checked = true;
        }
        else
        {
            chkoff4.Checked = false;
        }
        if (sDate.AddDays(5).DayOfWeek.ToString() == "Saturday" || sDate.AddDays(5).DayOfWeek.ToString() == "Sunday")
        {
            chkoff5.Checked = true;
        }
        else
        {
            chkoff5.Checked = false;
        }
        if (sDate.AddDays(6).DayOfWeek.ToString() == "Saturday" || sDate.AddDays(6).DayOfWeek.ToString() == "Sunday")
        {
            chkoff6.Checked = true;
        }
        else
        {
            chkoff6.Checked = false;
        }
        WklyOfChkChangedmanual(chkoff0);
        WklyOfChkChangedmanual(chkoff2);
        WklyOfChkChangedmanual(chkoff3);
        WklyOfChkChangedmanual(chkoff4);

        WklyOfChkChangedmanual(chkoff5);
        WklyOfChkChangedmanual(chkoff6);
        
        lblday2.Text = sDate.AddDays(1).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(1).Day.ToString() + "-" + sDate.AddDays(1).ToString("MMMM");
        lblday3.Text = sDate.AddDays(2).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(2).Day.ToString() + "-" + sDate.AddDays(2).ToString("MMMM");
        lblday4.Text= sDate.AddDays(3).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(3).Day.ToString() + "-" + sDate.AddDays(3).ToString("MMMM");
        lblday5.Text = sDate.AddDays(4).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(4).Day.ToString() + "-" + sDate.AddDays(4).ToString("MMMM");
        lblday6.Text= sDate.AddDays(5).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(5).Day.ToString() + "-" + sDate.AddDays(5).ToString("MMMM");
        lblday7.Text = sDate.AddDays(6).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(6).Day.ToString() + "-" + sDate.AddDays(6).ToString("MMMM");
           
    }
    public void bindShiftHeader()
    {

        try
        {
            ContentPlaceHolder mainContentPlaceHolder = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");
            sDate = DateTime.Parse(txtCalendar.Text);
            DropDownList ddlFacilityIn = mainContentPlaceHolder.FindControl("ddlFacilityIn") as DropDownList;
            DropDownList ddlLogIn = mainContentPlaceHolder.FindControl("lstBxIn") as DropDownList;

            if (MyApplicationSession._IsExceptional=="0")
            {
                if (ddlFacilityIn != null)
                {
                    ddlFacilityIn.DataSource = TmsDataContext.SelectFacilityEmployeeModule(_SpocID);
                    ddlFacilityIn.DataTextField = "facilityName";
                    ddlFacilityIn.DataValueField = "Id";
                    ddlFacilityIn.DataBind();
                    ListItem liFacIn = new ListItem("Select", "0");
                    ddlFacilityIn.Items.Insert(0, liFacIn);

                    ddlFacilityIn.SelectedIndex = ddlFacilityIn.Items.IndexOf(ddlFacilityIn.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));
                }

                if (ddlLogIn != null)
                {
                    ddlLogIn.DataSource = TmsDataContext.GetShiftByFacilityType(Convert.ToInt32(ddlFacilityIn.SelectedValue), "P");
                    ddlLogIn.DataTextField = "shiftTime";
                    ddlLogIn.DataValueField = "shiftTime";
                    ddlLogIn.DataBind();
                    ListItem liIn = new ListItem("Select", "0");
                    ddlLogIn.Items.Insert(0, liIn);
                    ListItem liIn1 = new ListItem("N/A", "N/A");
                    ddlLogIn.Items.Insert(1, liIn1);
                }

                DropDownList ddlFacilityOut = mainContentPlaceHolder.FindControl("ddlFacilityOut") as DropDownList;
                DropDownList ddlLogOut = mainContentPlaceHolder.FindControl("lstBxOut") as DropDownList;

                if (ddlFacilityOut != null)
                {
                    ddlFacilityOut.DataSource = TmsDataContext.SelectFacilityEmployeeModule(_SpocID);
                    ddlFacilityOut.DataTextField = "facilityName";
                    ddlFacilityOut.DataValueField = "Id";
                    ddlFacilityOut.DataBind();

                    ListItem liFacOut = new ListItem("Select", "0");
                    ddlFacilityOut.Items.Insert(0, liFacOut);

                    ddlFacilityOut.SelectedIndex = ddlFacilityOut.Items.IndexOf(ddlFacilityOut.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));
                }

                if (ddlLogOut != null)
                {
                    ddlLogOut.DataSource = TmsDataContext.GetShiftByFacilityType(Convert.ToInt32(ddlFacilityOut.SelectedValue), "D");
                    ddlLogOut.DataTextField = "shiftTime";
                    ddlLogOut.DataValueField = "shiftTime";
                    ddlLogOut.DataBind();
                    ListItem liOut = new ListItem("Select", "0");
                    ddlLogOut.Items.Insert(0, liOut);
                    ListItem liOut1 = new ListItem("N/A", "N/A");
                    ddlLogOut.Items.Insert(1, liOut1);
                }
            }
            else
            {
                if (ddlFacilityIn != null)
                {
                    ddlFacilityIn.DataSource = TmsDataContext.SelectFacilityEmployeeModule(_SpocID);
                    ddlFacilityIn.DataTextField = "facilityName";
                    ddlFacilityIn.DataValueField = "Id";
                    ddlFacilityIn.DataBind();
                    ListItem liFacIn = new ListItem("Select", "0");
                    ddlFacilityIn.Items.Insert(0, liFacIn);

                    ddlFacilityIn.SelectedIndex = ddlFacilityIn.Items.IndexOf(ddlFacilityIn.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));
                }

                if (ddlLogIn != null)
                {
                    ddlLogIn.DataSource = TmsDataContext.GetEmployeesAssignedShifts(Convert.ToInt32(ddlFacilityIn.SelectedValue),MyApplicationSession._UserID, "HP",DateTime.Now);
                    ddlLogIn.DataTextField = "shiftTime";
                    ddlLogIn.DataValueField = "shiftTime";
                    ddlLogIn.DataBind();
                    ListItem liIn = new ListItem("Select", "0");
                    ddlLogIn.Items.Insert(0, liIn);
                    ListItem liIn1 = new ListItem("N/A", "N/A");
                    ddlLogIn.Items.Insert(1, liIn1);
                }

                DropDownList ddlFacilityOut = mainContentPlaceHolder.FindControl("ddlFacilityOut") as DropDownList;
                DropDownList ddlLogOut = mainContentPlaceHolder.FindControl("lstBxOut") as DropDownList;

                if (ddlFacilityOut != null)
                {
                    ddlFacilityOut.DataSource = TmsDataContext.SelectFacilityEmployeeModule(_SpocID);
                    ddlFacilityOut.DataTextField = "facilityName";
                    ddlFacilityOut.DataValueField = "Id";
                    ddlFacilityOut.DataBind();

                    ListItem liFacOut = new ListItem("Select", "0");
                    ddlFacilityOut.Items.Insert(0, liFacOut);

                    ddlFacilityOut.SelectedIndex = ddlFacilityOut.Items.IndexOf(ddlFacilityOut.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));
                }

                if (ddlLogOut != null)
                {
                    ddlLogOut.DataSource = TmsDataContext.GetEmployeesAssignedShifts(Convert.ToInt32(ddlFacilityIn.SelectedValue), MyApplicationSession._UserID, "HD", DateTime.Now);
                    ddlLogOut.DataTextField = "shiftTime";
                    ddlLogOut.DataValueField = "shiftTime";
                    ddlLogOut.DataBind();
                    ListItem liOut = new ListItem("Select", "0");
                    ddlLogOut.Items.Insert(0, liOut);
                    ListItem liOut1 = new ListItem("N/A", "N/A");
                    ddlLogOut.Items.Insert(1, liOut1);
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
            //MultiView1.ActiveViewIndex = 0;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }
    }
    public void bindShiftHeaders()
    {

        try
        {
            var result = TmsDataContext.GetLockDetails(MyApplicationSession._FacilityID);
            foreach (var result1 in result)
            {
                lockSDate = Convert.ToDateTime(result1.lockSDate);
                lockEDate = Convert.ToDateTime(result1.lockEDate);
                lockPickTime = Convert.ToDateTime(result1.pickLockDateTime);
                lockDropTime = Convert.ToDateTime(result1.dropLockDateTime);
            }

            ContentPlaceHolder mainContentPlaceHolder = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");
            sDate = DateTime.Parse(txtCalendar.Text);
            for (int i = 0; i <= 6; i++)
            {
                DropDownList ddlFacilityIn = mainContentPlaceHolder.FindControl("ddlFacilityIn" + i) as DropDownList;
                DropDownList ddlIn = mainContentPlaceHolder.FindControl("lstBxIn" + i) as DropDownList;
                //ddlFacilityIn.Items.Clear();
                //ddlIn.Items.Clear();                   

                if (ddlFacilityIn != null)
                {
                    ddlFacilityIn.DataSource = TmsDataContext.SelectFacilityEmployeeModule(_SpocID);
                    ddlFacilityIn.DataTextField = "facilityName";
                    ddlFacilityIn.DataValueField = "Id";
                    ddlFacilityIn.DataBind();

                    ListItem liFacIn = new ListItem("Select", "0");
                    ddlFacilityIn.Items.Insert(0, liFacIn);
                    //ddlFacilityIn.SelectedValue = "7";
                    //ddlFacilityIn.SelectedIndex = ddlFacilityIn.Items.IndexOf(ddlFacilityIn.Items.FindByValue("7"));
                }

                if (ddlIn != null)
                {

                    ddlIn.DataSource = TmsDataContext.GetPickShiftTime(Convert.ToInt32(ddlFacilityIn.SelectedValue), sDate.AddDays(i));
                    ddlIn.DataTextField = "shiftTime";
                    ddlIn.DataValueField = "shiftTime";
                    ddlIn.DataBind();

                    ListItem liIn = new ListItem("Select", "0");
                    ddlIn.Items.Insert(0, liIn);
                    ListItem liIn1 = new ListItem("N/A", "N/A");
                    ddlIn.Items.Insert(1, liIn1);
                }

                DropDownList ddlFacilityOut = mainContentPlaceHolder.FindControl("ddlFacilityOut" + i) as DropDownList;
                DropDownList ddlOut = mainContentPlaceHolder.FindControl("lstBxOut" + i) as DropDownList;
                //ddlFacilityOut.Items.Clear();
                //ddlOut.Items.Clear();


                if (ddlFacilityOut != null)
                {
                    ddlFacilityOut.DataSource = TmsDataContext.SelectFacilityEmployeeModule(_SpocID);
                    ddlFacilityOut.DataTextField = "facilityName";
                    ddlFacilityOut.DataValueField = "Id";
                    ddlFacilityOut.DataBind();

                    ListItem liFacOut = new ListItem("Select", "0");
                    ddlFacilityOut.Items.Insert(0, liFacOut);

                    //ddlFacilityOut.SelectedIndex = ddlFacilityOut.Items.IndexOf(ddlFacilityOut.Items.FindByValue("7"));
                }

                if (ddlOut != null)
                {
                    ddlOut.DataSource = TmsDataContext.GetDropShiftTime(Convert.ToInt32(ddlFacilityOut.SelectedValue), sDate.AddDays(i),"A");
                    ddlOut.DataTextField = "shiftTime";
                    ddlOut.DataValueField = "shiftTime";
                    ddlOut.DataBind();
                    ListItem liOut = new ListItem("Select", "0");
                    ddlOut.Items.Insert(0, liOut);
                    ListItem liOut1 = new ListItem("N/A", "N/A");
                    ddlOut.Items.Insert(1, liOut1);
                }

                CheckBox chkoff = mainContentPlaceHolder.FindControl("chkoff" + i) as CheckBox;
                chkoff.Checked = false;

                if ((DateTime.Parse(txtCalendar.Text).AddDays(i) >= lockPickTime) && (DateTime.Parse(txtCalendar.Text).AddDays(i) >= lockDropTime))
                {
                    ddlIn.Enabled = true;
                    ddlIn.DataSource = null;
                    ddlOut.Enabled = true;
                    ddlFacilityIn.Enabled = true;
                    ddlFacilityOut.Enabled = true;
                    chkoff.Enabled = true;
                }
                else
                {
                    ddlIn.Enabled = false;
                    ddlOut.Enabled = false;
                    ddlFacilityIn.Enabled = false;
                    ddlFacilityOut.Enabled = false;
                    chkoff.Enabled = false;
                }
                //Added By Saurabh on 02Aug22
              //if ((DateTime.Parse(txtCalendar.Text).AddDays(i).DayOfWeek.ToString() == "Friday") && !(DateTime.Parse(txtCalendar.Text) >= lockSDate))
              // {
                  
              //      ddlIn.Enabled = false;
              //      ddlOut.Enabled = false;
              //      ddlFacilityIn.Enabled = false;
              //      ddlFacilityOut.Enabled = false;
              //      chkoff.Enabled = false;
              //  }
               
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void CustomValidatorStartDate_ServerValidate(object source, ServerValidateEventArgs args)
    {
        bool checkstate = false;
        args.IsValid = checkstate;

    }
    protected void txt_PageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        //            grdEmployeeSchedule.PageSize = Convert.ToInt32(txt_PageSize.Text);
        //          bindgrdEmployeeSchedule();
    }
    public void CheckAll(object sender, EventArgs e)
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
            foreach (GridViewRow i in grdEmployeeSchedule.Rows)
            {
                // Access the CheckBox
                CheckBox cb = (CheckBox)i.FindControl("chkBxEmpId");
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

            foreach (GridViewRow i in grdEmployeeSchedule.Rows)
            {
                // Access the CheckBox
                CheckBox cb = (CheckBox)i.FindControl("chkBxEmpId");
                if (cb.Checked)
                {
                    checkstate = true;
                    break;
                }
            }
            args.IsValid = checkstate;

            if (args.IsValid == true)
            {
                for (int i = 0; i <= 6; i++)
                {
                    string ddlname = "ctl00$ContentPlaceHolder1$lstBxIn" + i;
                    DropDownList ddlshift = (DropDownList)FindControl(ddlname);
                    if (ddlshift.SelectedValue != "0")
                    {
                        checkstate = true;
                        break;
                    }
                    else
                    {
                        checkstate = false;
                    }

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



    protected string CheckImage(object strArg)
    {

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

    protected void lnkBtnEmpName_Click(object sender, EventArgs e)
    {
        //********************************************************************
        // Selected the current view to selected Employee Details view
        //********************************************************************
        try
        {
            //MultiView1.ActiveViewIndex = 1;
            LinkButton EmpNameButton = sender as LinkButton;
            var r = TmsDataContext.GetEmpGeoCodeDetails(Convert.ToInt32(EmpNameButton.CommandArgument));
            _empId = Convert.ToInt32(EmpNameButton.CommandArgument);
            ModalPopupExtender.Show();
            foreach (var r1 in r)
            {
                ((Label)DvGeo.FindControl("lbldvEmpLoyeeID")).Text = r1.empCode;
                ((Label)DvGeo.FindControl("lbldvEmpName")).Text = r1.empName;
                ((CheckBox)DvGeo.FindControl("chkBxTptReq")).Checked = Convert.ToBoolean(r1.tptReq);
                ((Label)DvGeo.FindControl("lbldvAddress1")).Text = r1.address;
                ((Label)DvGeo.FindControl("lbldvPincode")).Text = r1.landmark;
                ((Label)DvGeo.FindControl("lblMobile")).Text = r1.mobile;
                ((Label)DvGeo.FindControl("lbldvfacility")).Text = r1.Facility;
                if (MyApplicationSession._UserID == _empId)
                {
                    ((HyperLink)DvGeo.FindControl("lbChangeAddress")).Visible = true;
                }
                else
                {
                    ((HyperLink)DvGeo.FindControl("lbChangeAddress")).Visible = false;
                }



                

                string city = r1.city;
                string col = r1.colony;
                DropDownList ddlCity = (DropDownList)DvGeo.FindControl("ddldvCity");
                ddlCity.Items.Clear();
                ListItem licity = new ListItem("Select City", "0");
                ddlCity.Items.Add(licity);
                ddlCity.DataSource = TmsDataContext.GetGeoCity();
                ddlCity.DataTextField = "city";
                ddlCity.DataValueField = "city";
                ddlCity.DataBind();
                ddlCity.SelectedIndex = ddlCity.Items.IndexOf(ddlCity.Items.FindByText(city.ToString()));
                DropDownList ddlcol = (DropDownList)DvGeo.FindControl("ddldvColony");
                ddlcol.Items.Clear();
                ListItem licol = new ListItem("Select Colony", "0");
                ddlcol.Items.Add(licol);
                ddlcol.DataSource = TmsDataContext.GetGeoCityColony(city);
                ddlcol.DataTextField = "colony";
                ddlcol.DataValueField = "colony";
                ddlcol.DataBind();
                ddlcol.SelectedIndex = ddlcol.Items.IndexOf(ddlcol.Items.FindByText(col.ToString()));
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }


    protected void lnkBtnSetAll_Click(object sender, EventArgs e)
    {
        try
        {
            ContentPlaceHolder mainContent = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");
          
          //  bindShiftHeaders();
          //  bndshiftboxheader();
            var result = TmsDataContext.GetLockDetails(MyApplicationSession._FacilityID);
            foreach (var result1 in result)
            {
                lockSDate = Convert.ToDateTime(result1.lockSDate);
                lockEDate = Convert.ToDateTime(result1.lockEDate);
                lockPickTime = Convert.ToDateTime(result1.pickLockDateTime);
                lockDropTime = Convert.ToDateTime(result1.dropLockDateTime);
            }
            sDate = DateTime.Parse(txtCalendar.Text);
            for (int i = 0; i <= 6; i++)
            {
                DropDownList ddlFacIn = mainContent.FindControl("ddlFacilityIn" + i) as DropDownList;
                DropDownList ddlFacOut = mainContent.FindControl("ddlFacilityOut" + i) as DropDownList;
                DropDownList ddlIn = mainContent.FindControl("lstBxIn" + i) as DropDownList;
                DropDownList ddlOut = mainContent.FindControl("lstBxOut" + i) as DropDownList;
                DateTime txtDate = DateTime.Parse(txtCalendar.Text).AddDays(i);
                CheckBox chkoff = mainContent.FindControl("chkoff" + i) as CheckBox;
                if (txtDate > lockPickTime && txtDate > lockDropTime)
                {
                    if (chkoff.Checked == false)
                    {
                        ddlFacIn.SelectedValue = ddlFacilityIn.SelectedValue;
                        ddlIn.DataSource = TmsDataContext.GetEmployeesAssignedShifts(Convert.ToInt32(ddlFacilityIn.SelectedValue),MyApplicationSession._UserID,"P", txtDate);
                        ddlIn.DataTextField = "shiftTime";
                        ddlIn.DataValueField = "shiftTime";
                        ddlIn.DataBind();
                        string val = lstBxIn.SelectedItem.ToString().Trim();
                        ddlIn.SelectedIndex = ddlIn.Items.IndexOf(ddlIn.Items.FindByText(val.ToString()));
                        ListItem liIn = new ListItem("Select", "0");
                        ddlIn.Items.Insert(0, liIn);
                        ListItem liIn1 = new ListItem("N/A", "N/A");
                        ddlIn.Items.Insert(1, liIn1);

                        ddlFacOut.SelectedValue = ddlFacilityOut.SelectedValue;
                        ddlOut.DataSource = TmsDataContext.GetEmployeesAssignedShifts(Convert.ToInt32(ddlFacOut.SelectedValue), MyApplicationSession._UserID, "D", txtDate);
                        ddlOut.DataTextField = "shiftTime";
                        ddlOut.DataValueField = "shiftTime";
                        ddlOut.DataBind();
                        string val1 = lstBxOut.SelectedItem.ToString().Trim();
                        ddlOut.SelectedIndex = ddlOut.Items.IndexOf(ddlOut.Items.FindByText(val1.ToString()));
                        ListItem liOut = new ListItem("Select", "0");
                        ddlOut.Items.Insert(0, liOut);
                        ListItem liOut1 = new ListItem("N/A", "N/A");
                        ddlOut.Items.Insert(1, liOut1);
                    }
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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid == true)
            {
                string empIds = string.Empty;
                var result = 0;
                ContentPlaceHolder mainContent = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");
                foreach (GridViewRow i in grdEmployeeSchedule.Rows)
                {
                    CheckBox cb = (CheckBox)i.FindControl("chkBxEmpId");
                    if (cb != null && cb.Checked)
                    {
                        Label lbl = (Label)i.FindControl("EmpID");
                        empIds = empIds + lbl.Text.Trim() + ",";
                    }
                }
                empIds = empIds.Remove(empIds.Length - 1, 1);
                for (int i = 0; i <= 6; i++)
                {
                    DropDownList ddlFacilityIn = mainContent.FindControl("ddlFacilityIn" + i) as DropDownList;
                    DropDownList ddlIn = mainContent.FindControl("lstBxIn" + i) as DropDownList;
                    DropDownList ddlOut = mainContent.FindControl("lstBxOut" + i) as DropDownList;
                    DropDownList ddlFacilityOut = mainContent.FindControl("ddlFacilityOut" + i) as DropDownList;

                    var resultLock = TmsDataContext.GetLockDetails(MyApplicationSession._FacilityID);
                    foreach (var result1 in resultLock)
                    {
                        lockSDate = Convert.ToDateTime(result1.lockSDate);
                        lockEDate = Convert.ToDateTime(result1.lockEDate);
                        lockPickTime = Convert.ToDateTime(result1.pickLockDateTime);
                        lockDropTime = Convert.ToDateTime(result1.dropLockDateTime);
                    }
                    if ((ddlFacilityIn.SelectedValue != "0" && ddlIn.SelectedValue != "0") || (ddlOut.SelectedValue != "0" && ddlFacilityOut.SelectedValue != "0"))
                    {
                        DateTime sDate = DateTime.Parse(txtCalendar.Text).AddDays(i);
                        if (sDate > lockPickTime && sDate > lockDropTime)
                        {
                            //TmsDataContext.InsertSchedule(empIds, sDate, ddlIn.SelectedValue, sDate, ddlOut.SelectedValue, "Rachit", "M", DateTime.Now.Date, "", "", DateTime.Now.Date, "0900", "2000");
                            result = TmsDataContext.InsertSchedule(empIds, sDate, ddlIn.SelectedValue, sDate, ddlOut.SelectedValue, MyApplicationSession._UserID.ToString(), DateTime.Now, "", DateTime.Now, ddlFacilityIn.SelectedValue, ddlFacilityOut.SelectedValue);
                            //TmsDataContext.InsertSchedule(empIds, sDate, "", sDate, ddlOut.SelectedValue, "Rachit", "M", DateTime.Now.Date, "", "", DateTime.Now.Date, "0900", "2000");
                            
                            if (result <= 0)
                            {
                                break;
                            }
                        }
                    }
                }
                bindShiftHeader();
                bindShiftHeaders();
                bindgrdEmployeeSchedule();
                bndshiftboxheader();
                if (result <= 0)
                {
                    lblSaveMsg.Text = "Schedule not updated successfully.";
                }
                else
                {
                    lblSaveMsg.Text = "Schedule updated successfully.";
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

    protected void ddlFacilityIn_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            sDate = DateTime.Parse(txtCalendar.Text);
            lstBxIn.DataSource = TmsDataContext.GetEmployeesAssignedShifts(Convert.ToInt32(ddlFacilityIn.SelectedValue),MyApplicationSession._UserID, "HP",DateTime.Now);
            lstBxIn.DataTextField = "shiftTime";
            lstBxIn.DataValueField = "shiftTime";
            lstBxIn.DataBind();
            ListItem liIn = new ListItem("Select", "0");
            lstBxIn.Items.Insert(0, liIn);
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }

    }

    protected void ddlFacilityOut_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            sDate = DateTime.Parse(txtCalendar.Text);
            string selFacilityIDOut = ddlFacilityOut.SelectedValue.ToString();
            lstBxOut.DataSource = TmsDataContext.GetEmployeesAssignedShifts(Convert.ToInt32(ddlFacilityIn.SelectedValue), MyApplicationSession._UserID, "HD", DateTime.Now);
            lstBxOut.DataTextField = "shiftTime";
            lstBxOut.DataValueField = "shiftTime";
            lstBxOut.DataBind();
            ListItem liOut = new ListItem("Select", "0");
            lstBxOut.Items.Insert(0, liOut);
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void ddlFacilityIn0_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selFacilityIDIn0 = Convert.ToInt32(ddlFacilityIn0.SelectedValue);
        DateTime sDate = DateTime.Parse(txtCalendar.Text);

        lstBxIn0.DataSource = TmsDataContext.GetEmployeesAssignedShifts(selFacilityIDIn0, MyApplicationSession._UserID, "HP", DateTime.Now);
        lstBxIn0.DataTextField = "shiftTime";
        lstBxIn0.DataValueField = "shiftTime";
        lstBxIn0.DataBind();
        ListItem liIn0 = new ListItem("Select", "0");
        lstBxIn0.Items.Insert(0, liIn0);
        ListItem liIn1 = new ListItem("N/A", "N/A");
        lstBxIn0.Items.Insert(1, liIn1);

    }

    protected void ddlFacilityOut0_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selFacilityIDOut0 = Convert.ToInt32(ddlFacilityOut0.SelectedValue);
        DateTime sDate = DateTime.Parse(txtCalendar.Text);
        lstBxOut0.DataSource = TmsDataContext.GetEmployeesAssignedShifts(selFacilityIDOut0, MyApplicationSession._UserID, "HD", DateTime.Now);
        lstBxOut0.DataTextField = "shiftTime";
        lstBxOut0.DataValueField = "shiftTime";
        lstBxOut0.DataBind();
        ListItem liOut0 = new ListItem("Select", "0");
        lstBxOut0.Items.Insert(0, liOut0);
        ListItem liOut1 = new ListItem("N/A", "N/A");
        lstBxOut0.Items.Insert(1, liOut1);
    }

    protected void ddlFacilityIn1_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selFacilityIDIn1 = Convert.ToInt32(ddlFacilityIn1.SelectedValue);
        DateTime sDate = DateTime.Parse(txtCalendar.Text).AddDays(1);
        lstBxIn1.DataSource = TmsDataContext.GetEmployeesAssignedShifts(selFacilityIDIn1, MyApplicationSession._UserID, "P", sDate);
        lstBxIn1.DataTextField = "shiftTime";
        lstBxIn1.DataValueField = "shiftTime";
        lstBxIn1.DataBind();
        ListItem liIn1 = new ListItem("Select", "0");
        lstBxIn1.Items.Insert(0, liIn1);
        ListItem liIn2 = new ListItem("N/A", "N/A");
        lstBxIn1.Items.Insert(1, liIn2);
    }

    protected void ddlFacilityOut1_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selFacilityIDOut1 = Convert.ToInt32(ddlFacilityOut1.SelectedValue);
        DateTime sDate = DateTime.Parse(txtCalendar.Text).AddDays(1);
        lstBxOut1.DataSource = TmsDataContext.GetEmployeesAssignedShifts(selFacilityIDOut1, MyApplicationSession._UserID, "D", sDate);
        lstBxOut1.DataTextField = "shiftTime";
        lstBxOut1.DataValueField = "shiftTime";
        lstBxOut1.DataBind();
        ListItem liOut1 = new ListItem("Select", "0");
        lstBxOut1.Items.Insert(0, liOut1);
        ListItem liOut2 = new ListItem("N/A", "N/A");
        lstBxOut1.Items.Insert(1, liOut2);
    }

    protected void ddlFacilityIn2_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selFacilityIDIn2 = Convert.ToInt32(ddlFacilityIn2.SelectedValue);
        DateTime sDate = DateTime.Parse(txtCalendar.Text).AddDays(2);
        lstBxIn2.DataSource = TmsDataContext.GetEmployeesAssignedShifts(selFacilityIDIn2, MyApplicationSession._UserID, "P", sDate);
        lstBxIn2.DataTextField = "shiftTime";
        lstBxIn2.DataValueField = "shiftTime";
        lstBxIn2.DataBind();
        ListItem liIn2 = new ListItem("Select", "0");
        lstBxIn2.Items.Insert(0, liIn2);
        ListItem liIn3 = new ListItem("N/A", "N/A");
        lstBxIn2.Items.Insert(1, liIn3);
    }

    protected void ddlFacilityOut2_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selFacilityIDOut2 = Convert.ToInt32(ddlFacilityOut2.SelectedValue);
        DateTime sDate = DateTime.Parse(txtCalendar.Text).AddDays(2);
        lstBxOut2.DataSource = TmsDataContext.GetEmployeesAssignedShifts(selFacilityIDOut2, MyApplicationSession._UserID, "D", sDate);
        lstBxOut2.DataTextField = "shiftTime";
        lstBxOut2.DataValueField = "shiftTime";
        lstBxOut2.DataBind();
        ListItem liOut2 = new ListItem("Select", "0");
        lstBxOut2.Items.Insert(0, liOut2);
        ListItem liOut3 = new ListItem("N/A", "N/A");
        lstBxOut2.Items.Insert(1, liOut3);
    }

    protected void ddlFacilityIn3_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selFacilityIDIn3 = Convert.ToInt32(ddlFacilityIn3.SelectedValue);
        DateTime sDate = DateTime.Parse(txtCalendar.Text).AddDays(3);
        lstBxIn3.DataSource = TmsDataContext.GetEmployeesAssignedShifts(selFacilityIDIn3, MyApplicationSession._UserID, "P", sDate);
        lstBxIn3.DataTextField = "shiftTime";
        lstBxIn3.DataValueField = "shiftTime";
        lstBxIn3.DataBind();
        ListItem liIn3 = new ListItem("Select", "0");
        lstBxIn3.Items.Insert(0, liIn3);
        ListItem liIn4 = new ListItem("N/A", "N/A");
        lstBxIn3.Items.Insert(1, liIn4);
    }

    protected void ddlFacilityOut3_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selFacilityIDOut3 = Convert.ToInt32(ddlFacilityOut3.SelectedValue);
        DateTime sDate = DateTime.Parse(txtCalendar.Text).AddDays(3);
        lstBxOut3.DataSource = TmsDataContext.GetEmployeesAssignedShifts(selFacilityIDOut3, MyApplicationSession._UserID, "D", sDate);
        lstBxOut3.DataTextField = "shiftTime";
        lstBxOut3.DataValueField = "shiftTime";
        lstBxOut3.DataBind();
        ListItem liOut3 = new ListItem("Select", "0");
        lstBxOut3.Items.Insert(0, liOut3);
        ListItem liOut4 = new ListItem("N/A", "N/A");
        lstBxOut3.Items.Insert(1, liOut4);
    }

    protected void ddlFacilityIn4_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selFacilityIDIn4 = Convert.ToInt32(ddlFacilityIn4.SelectedValue);
        DateTime sDate = DateTime.Parse(txtCalendar.Text).AddDays(4);
        lstBxIn4.DataSource = TmsDataContext.GetEmployeesAssignedShifts(selFacilityIDIn4, MyApplicationSession._UserID, "P", sDate);
        lstBxIn4.DataTextField = "shiftTime";
        lstBxIn4.DataValueField = "shiftTime";
        lstBxIn4.DataBind();
        ListItem liIn4 = new ListItem("Select", "0");
        lstBxIn4.Items.Insert(0, liIn4);
        ListItem liIn5 = new ListItem("N/A", "N/A");
        lstBxIn4.Items.Insert(1, liIn5);
    }

    protected void ddlFacilityOut4_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selFacilityIDOut4 = Convert.ToInt32(ddlFacilityOut4.SelectedValue);
        DateTime sDate = DateTime.Parse(txtCalendar.Text).AddDays(4);
        lstBxOut4.DataSource = TmsDataContext.GetEmployeesAssignedShifts(selFacilityIDOut4, MyApplicationSession._UserID, "D", sDate);
        lstBxOut4.DataTextField = "shiftTime";
        lstBxOut4.DataValueField = "shiftTime";
        lstBxOut4.DataBind();
        ListItem liOut4 = new ListItem("Select", "0");
        lstBxOut4.Items.Insert(0, liOut4);
        ListItem liOut5 = new ListItem("N/A", "N/A");
        lstBxOut4.Items.Insert(1, liOut5);
    }

    protected void ddlFacilityIn5_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selFacilityIDIn5 = Convert.ToInt32(ddlFacilityIn5.SelectedValue);
        DateTime sDate = DateTime.Parse(txtCalendar.Text).AddDays(5);
        lstBxIn5.DataSource = TmsDataContext.GetEmployeesAssignedShifts(selFacilityIDIn5, MyApplicationSession._UserID, "P", sDate);
        lstBxIn5.DataTextField = "shiftTime";
        lstBxIn5.DataValueField = "shiftTime";
        lstBxIn5.DataBind();
        ListItem liIn5 = new ListItem("Select", "0");
        lstBxIn5.Items.Insert(0, liIn5);
        ListItem liIn6 = new ListItem("N/A", "N/A");
        lstBxIn5.Items.Insert(1, liIn6);
    }

    protected void ddlFacilityOut5_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selFacilityIDOut5 = Convert.ToInt32(ddlFacilityOut5.SelectedValue);
        DateTime sDate = DateTime.Parse(txtCalendar.Text).AddDays(5);
        lstBxOut5.DataSource = TmsDataContext.GetEmployeesAssignedShifts(selFacilityIDOut5, MyApplicationSession._UserID, "D", sDate);
        lstBxOut5.DataTextField = "shiftTime";
        lstBxOut5.DataValueField = "shiftTime";
        lstBxOut5.DataBind();
        ListItem liOut5 = new ListItem("Select", "0");
        lstBxOut5.Items.Insert(0, liOut5);
        ListItem liOut6 = new ListItem("N/A", "N/A");
        lstBxOut5.Items.Insert(1, liOut6);
    }

    protected void ddlFacilityIn6_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selFacilityIDIn6 = Convert.ToInt32(ddlFacilityIn6.SelectedValue);
        DateTime sDate = DateTime.Parse(txtCalendar.Text).AddDays(6);
        lstBxIn6.DataSource = TmsDataContext.GetEmployeesAssignedShifts(selFacilityIDIn6, MyApplicationSession._UserID, "P", sDate);
        lstBxIn6.DataTextField = "shiftTime";
        lstBxIn6.DataValueField = "shiftTime";
        lstBxIn6.DataBind();
        ListItem liIn6 = new ListItem("Select", "0");
        lstBxIn6.Items.Insert(0, liIn6);
        ListItem liIn7 = new ListItem("N/A", "N/A");
        lstBxIn6.Items.Insert(1, liIn7);
    }

    protected void ddlFacilityOut6_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selFacilityIDOut6 = Convert.ToInt32(ddlFacilityOut6.SelectedValue);
        DateTime sDate = DateTime.Parse(txtCalendar.Text).AddDays(6);
        lstBxOut6.DataSource = TmsDataContext.GetEmployeesAssignedShifts(selFacilityIDOut6, MyApplicationSession._UserID, "D", sDate);
        lstBxOut6.DataTextField = "shiftTime";
        lstBxOut6.DataValueField = "shiftTime";
        lstBxOut6.DataBind();
        ListItem liOut6 = new ListItem("Select", "0");
        lstBxOut6.Items.Insert(0, liOut6);
        ListItem liOut7 = new ListItem("N/A", "N/A");
        lstBxOut6.Items.Insert(1, liOut7);
    }

    public void WklyOfChkChanged(object sender, EventArgs e)
    {
        try
        {
            DateTime sDate = new DateTime();
            sDate = DateTime.Parse(txtCalendar.Text);
            CheckBox cb = (CheckBox)sender;
            ContentPlaceHolder mainContent = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");
            string i = cb.ID.Substring(cb.ID.Length - 1, 1);
            if (cb.Checked == true)
            {
                DropDownList ddlFacIn = mainContent.FindControl("ddlFacilityIn" + i) as DropDownList;
                DropDownList ddlFacInOut = mainContent.FindControl("ddlFacilityOut" + i) as DropDownList;
                DropDownList ddlIn = mainContent.FindControl("lstBxIn" + i) as DropDownList;
                DropDownList ddlOut = mainContent.FindControl("lstBxOut" + i) as DropDownList;
                ddlFacIn.Items.Clear();
                ddlFacInOut.Items.Clear();
                ddlIn.Items.Clear();
                ddlOut.Items.Clear();
                ddlFacIn.Items.Add(new ListItem("N/A", "N/A"));
                ddlFacInOut.Items.Add(new ListItem("N/A", "N/A"));
                ddlIn.Items.Add(new ListItem("Off", "N/A"));
                ddlOut.Items.Add(new ListItem("Off", "N/A"));
            }
            else
            {
                DropDownList ddlFacIn = mainContent.FindControl("ddlFacilityIn" + i) as DropDownList;
                DropDownList ddlFacInOut = mainContent.FindControl("ddlFacilityOut" + i) as DropDownList;
                DropDownList ddlIn = mainContent.FindControl("lstBxIn" + i) as DropDownList;
                DropDownList ddlOut = mainContent.FindControl("lstBxOut" + i) as DropDownList;

                ddlFacIn.DataSource = TmsDataContext.SelectFacilityEmployeeModule(_SpocID);
                ddlFacIn.DataTextField = "facilityName";
                ddlFacIn.DataValueField = "Id";
                ddlFacIn.DataBind();

                ListItem liFacIn = new ListItem("Select", "0");
                ddlFacIn.Items.Insert(0, liFacIn);

                ddlIn.DataSource = TmsDataContext.GetEmployeesAssignedShifts(Convert.ToInt32(ddlFacilityIn.SelectedValue),MyApplicationSession._UserID,"P", sDate);
                ddlIn.DataTextField = "shifttime";
                ddlIn.DataValueField = "shifttime";
                ddlIn.DataBind();
                ListItem lstddlIn = new ListItem("Select", "0");
                ddlIn.Items.Insert(0, lstddlIn);

                ddlFacInOut.DataSource = TmsDataContext.SelectFacilityEmployeeModule(_SpocID);
                ddlFacInOut.DataTextField = "facilityName";
                ddlFacInOut.DataValueField = "Id";
                ddlFacInOut.DataBind();

                ListItem liFacOut = new ListItem("Select", "0");
                ddlFacInOut.Items.Insert(0, liFacOut);

                ddlOut.DataSource = TmsDataContext.GetEmployeesAssignedShifts(Convert.ToInt32(ddlFacilityOut.SelectedValue), MyApplicationSession._UserID, "D", sDate);
                ddlOut.DataTextField = "shifttime";
                ddlOut.DataValueField = "shifttime";
                ddlOut.DataBind();
                ListItem lstddlOut = new ListItem("Select", "0");
                ddlOut.Items.Insert(0, lstddlOut);
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    public void WklyOfChkChangedmanual(CheckBox cb)
    {
        try
        {
            DateTime sDate = new DateTime();
            sDate = DateTime.Parse(txtCalendar.Text);
            ContentPlaceHolder mainContent = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");
            string i = cb.ID.Substring(cb.ID.Length - 1, 1);
            if (cb.Checked == true)
            {
                DropDownList ddlFacIn = mainContent.FindControl("ddlFacilityIn" + i) as DropDownList;
                DropDownList ddlFacInOut = mainContent.FindControl("ddlFacilityOut" + i) as DropDownList;
                DropDownList ddlIn = mainContent.FindControl("lstBxIn" + i) as DropDownList;
                DropDownList ddlOut = mainContent.FindControl("lstBxOut" + i) as DropDownList;
                ddlFacIn.Items.Clear();
                ddlFacInOut.Items.Clear();
                ddlIn.Items.Clear();
                ddlOut.Items.Clear();
                ddlFacIn.Items.Add(new ListItem("N/A", "N/A"));
                ddlFacInOut.Items.Add(new ListItem("N/A", "N/A"));
                ddlIn.Items.Add(new ListItem("Off", "N/A"));
                ddlOut.Items.Add(new ListItem("Off", "N/A"));
            }
            else
            {
                DropDownList ddlFacIn = mainContent.FindControl("ddlFacilityIn" + i) as DropDownList;
                DropDownList ddlFacInOut = mainContent.FindControl("ddlFacilityOut" + i) as DropDownList;
                DropDownList ddlIn = mainContent.FindControl("lstBxIn" + i) as DropDownList;
                DropDownList ddlOut = mainContent.FindControl("lstBxOut" + i) as DropDownList;

                ddlFacIn.DataSource = TmsDataContext.SelectFacilityEmployeeModule(_SpocID);
                ddlFacIn.DataTextField = "facilityName";
                ddlFacIn.DataValueField = "Id";
                ddlFacIn.DataBind();

                ListItem liFacIn = new ListItem("Select", "0");
                ddlFacIn.Items.Insert(0, liFacIn);

                ddlIn.DataSource = TmsDataContext.GetPickShiftTime(Convert.ToInt32(ddlFacilityIn.SelectedValue), sDate);
                ddlIn.DataTextField = "shifttime";
                ddlIn.DataValueField = "shifttime";
                ddlIn.DataBind();
                ListItem lstddlIn = new ListItem("Select", "0");
                ddlIn.Items.Insert(0, lstddlIn);

                ddlFacInOut.DataSource = TmsDataContext.SelectFacilityEmployeeModule(_SpocID);
                ddlFacInOut.DataTextField = "facilityName";
                ddlFacInOut.DataValueField = "Id";
                ddlFacInOut.DataBind();

                ListItem liFacOut = new ListItem("Select", "0");
                ddlFacInOut.Items.Insert(0, liFacOut);

                ddlOut.DataSource = TmsDataContext.GetPickShiftTime(Convert.ToInt32(ddlFacilityOut.SelectedValue), sDate);
                ddlOut.DataTextField = "shifttime";
                ddlOut.DataValueField = "shifttime";
                ddlOut.DataBind();
                ListItem lstddlOut = new ListItem("Select", "0");
                ddlOut.Items.Insert(0, lstddlOut);
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void ShiftHeader_Click(object sender, EventArgs e)
    {
        if (pnlShiftHeader.Visible == true)
        {
            pnlShiftHeader.Visible = false;
            lblShiftHeader.Text = "Click here to Show Shift Header for Updation...";
            Image1.ImageUrl = "images/expand_blue.jpg";
        }
        else
        {
            pnlShiftHeader.Visible = true;
            bindShiftHeader();
            lblShiftHeader.Text = "Click here to Hide Shift Header...";
            Image1.ImageUrl = "images/collapse_blue.jpg";
        }
    }
    protected DateTime GetShiftdate(int addDays)
    {
        return Convert.ToDateTime(txtCalendar.Text).AddDays(addDays);
    }
    protected void lnkBtnShift_Click(object sender, EventArgs e)
    {

        LinkButton lnkbtnSETime = (LinkButton)sender;
        DateTime seldate = Convert.ToDateTime(lnkbtnSETime.CommandArgument);
        var result = TmsDataContext.GetLockDetails(MyApplicationSession._FacilityID);
        foreach (var result1 in result)
        {
            lockSDate = Convert.ToDateTime(result1.lockSDate);
            lockEDate = Convert.ToDateTime(result1.lockEDate);
            lockPickTime = Convert.ToDateTime(result1.pickLockDateTime);
            lockDropTime = Convert.ToDateTime(result1.dropLockDateTime);
        }
        //by saurabh -on 01Aug22
        //if ((seldate >= lockSDate) && (seldate <= lockEDate))
        //{
        GridViewRow row = lnkbtnSETime.NamingContainer as GridViewRow;
        int rowIndex = Convert.ToInt32(row.RowIndex);
        Int32 selEmployeeID = Convert.ToInt32(grdEmployeeSchedule.DataKeys[rowIndex].Value);
        Int32 IsExceptional = Convert.ToInt32(grdEmployeeSchedule.DataKeys[rowIndex].Values[1]);
        _empId = selEmployeeID;
        var r = TmsDataContext.GetOneEmployeeSchedule(selEmployeeID, seldate);
        if (IsExceptional==0)
	    {
            foreach (var r1 in r)
            {
                ((Label)dvEditEmployeeSchedule.FindControl("lblShiftEmployeeID")).Text = r1.empCode;
                ((Label)dvEditEmployeeSchedule.FindControl("lblShiftEmpName")).Text = r1.empName;
                ((Label)dvEditEmployeeSchedule.FindControl("lblShiftdate")).Text = seldate.ToLongDateString();


                string LogInFacility = Convert.ToString(r1.pickFacilityID);
                string LogOutFacility = Convert.ToString(r1.dropFacilityID);
                string LogInTime = r1.startTime;
                string LogOutTime = r1.endTime;
                if (LogInTime == "")
                {
                    LogInTime = "N/A";
                }
                if (LogOutTime == "")
                {
                    LogOutTime = "N/A";
                }
                DropDownList ddlInFacility = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlInFacility");
                ddlInFacility.Items.Clear();
                ListItem liInFacility = new ListItem("-Facility-", "-1");
                ddlInFacility.Items.Add(liInFacility);
                ddlInFacility.DataSource = TmsDataContext.SelectFacilityEmployeeModule(_SpocID);
                ddlInFacility.DataTextField = "facilityName";
                ddlInFacility.DataValueField = "Id";
                ddlInFacility.DataBind();

                ddlInFacility.SelectedIndex = ddlInFacility.Items.IndexOf(ddlInFacility.Items.FindByValue(LogInFacility.ToString()));


                DropDownList ddlInTime = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlInTime");
                ddlInTime.Items.Clear();
                ListItem liIn0 = new ListItem("Select", "0");
                ddlInTime.Items.Insert(0, liIn0);
                ListItem liIn1 = new ListItem("N/A", "N/A");
                ddlInTime.Items.Insert(1, liIn1);
                ddlInTime.DataSource = TmsDataContext.GetPickShiftTime(Int32.Parse(LogInFacility), seldate);
                ddlInTime.DataTextField = "shiftTime";
                ddlInTime.DataValueField = "shiftTime";
                ddlInTime.DataBind();

                ddlInTime.SelectedIndex = ddlInTime.Items.IndexOf(ddlInTime.Items.FindByText(LogInTime.ToString()));
                Label lblInTime = (Label)dvEditEmployeeSchedule.FindControl("lblInTime");

                DateTime LoginDatetime = GetDateTimeComb(Convert.ToDateTime(r1.startDate), LogInTime);
                if (LoginDatetime <= lockPickTime)
                {
                    ddlInFacility.Enabled = false;
                    ddlInTime.Visible = false;
                    lblInTime.Visible = true;
                    lblInTime.Text = LogInTime;
                    String lbtnnavigateurl = (new EncryptQueryString()).Encrypt("TripType=P");
                    ((HyperLink)dvEditEmployeeSchedule.FindControl("lbPickAdhoc")).Visible = false;
                }
                else
                {
                    ddlInFacility.Enabled = true;
                    ddlInTime.Visible = true;
                    lblInTime.Visible = false;
                    ((HyperLink)dvEditEmployeeSchedule.FindControl("lbPickAdhoc")).Visible = false;
                }

                DropDownList ddlOutFacility = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlOutFacility");
                ddlOutFacility.Items.Clear();
                ListItem liOutFacility = new ListItem("-Facility-", "0");
                ddlOutFacility.Items.Add(liOutFacility);
                ddlOutFacility.DataSource = TmsDataContext.SelectFacilityEmployeeModule(_SpocID);
                ddlOutFacility.DataTextField = "facilityName";
                ddlOutFacility.DataValueField = "Id";
                ddlOutFacility.DataBind();

                ddlOutFacility.SelectedIndex = ddlOutFacility.Items.IndexOf(ddlOutFacility.Items.FindByValue(LogOutFacility.ToString()));
                DropDownList ddlOutTime = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlOutTime");
                ddlOutTime.Items.Clear();
                ListItem liOut0 = new ListItem("Select", "0");
                ddlOutTime.Items.Insert(0, liOut0);
                ListItem liOut1 = new ListItem("N/A", "N/A");
                ddlOutTime.Items.Insert(1, liOut1);
                ddlOutTime.DataSource = TmsDataContext.GetDropShiftTime(Int32.Parse(LogOutFacility), seldate, "A");
                ddlOutTime.DataTextField = "shiftTime";
                ddlOutTime.DataValueField = "shiftTime";
                ddlOutTime.DataBind();
                ddlOutTime.SelectedIndex = ddlOutTime.Items.IndexOf(ddlOutTime.Items.FindByText(LogOutTime.ToString()));
                Label lblOutTime = (Label)dvEditEmployeeSchedule.FindControl("lblOutTime");


                Button btnSaveShift = (Button)dvEditEmployeeSchedule.FindControl("btnSaveShift");
                DateTime LogoutDatetime = GetDateTimeComb(Convert.ToDateTime(r1.endDate), LogOutTime);



                if (LogoutDatetime <= lockDropTime)
                {
                    ddlOutFacility.Enabled = false;
                    ddlOutTime.Visible = false;
                    btnSaveShift.Visible = false;
                    lblOutTime.Visible = true;
                    lblOutTime.Text = LogOutTime;

                    if (_empId == MyApplicationSession._UserID && TmsDataContext.GetEmployeeDetails(_empId).ElementAtOrDefault(0).tptReq == 'Y')
                    {
                        String lbtdropnnavigateurl = (new EncryptQueryString()).Encrypt("TripType=D&shiftDate=" + seldate);
                        ((HyperLink)dvEditEmployeeSchedule.FindControl("lbDropAdhoc")).NavigateUrl = "~/AdhocRequest.aspx?" + lbtdropnnavigateurl;
                        ((HyperLink)dvEditEmployeeSchedule.FindControl("lbDropAdhoc")).Visible = true;
                        ((Panel)dvEditEmployeeSchedule.FindControl("pnlUnschedule")).Visible = true;

                        DropDownList ddlfacUnschedule = ((DropDownList)dvEditEmployeeSchedule.FindControl("ddlunscheduleFacility"));
                        ddlfacUnschedule.Items.Clear();
                        ddlfacUnschedule.DataSource = TmsDataContext.getfacilityforunsched();
                        ddlfacUnschedule.DataTextField = "facilityName";
                        ddlfacUnschedule.DataValueField = "Id";
                        ddlfacUnschedule.DataBind();
                    }
                    else
                    {
                        ((HyperLink)dvEditEmployeeSchedule.FindControl("lbDropAdhoc")).Visible = false;
                        ((Panel)dvEditEmployeeSchedule.FindControl("pnlUnschedule")).Visible = false;
                    }
                }
                else
                {
                    if (seldate == DateTime.Now.Date && LogOutTime == "N/A" && _empId == MyApplicationSession._UserID && TmsDataContext.GetEmployeeDetails(_empId).ElementAtOrDefault(0).tptReq == 'Y')
                    {
                        ddlOutFacility.Enabled = true;
                        ddlOutTime.Visible = true;
                        btnSaveShift.Visible = true;
                        lblOutTime.Visible = false;
                        ((HyperLink)dvEditEmployeeSchedule.FindControl("lbDropAdhoc")).Visible = true;
                        ((Panel)dvEditEmployeeSchedule.FindControl("pnlUnschedule")).Visible = true;

                        String lbtdropnnavigateurl = (new EncryptQueryString()).Encrypt("TripType=D&shiftDate=" + seldate);

                        ((HyperLink)dvEditEmployeeSchedule.FindControl("lbDropAdhoc")).NavigateUrl = "~/AdhocRequest.aspx?" + lbtdropnnavigateurl;
                        DropDownList ddlfacUnschedule = ((DropDownList)dvEditEmployeeSchedule.FindControl("ddlunscheduleFacility"));
                        ddlfacUnschedule.Items.Clear();
                        ddlfacUnschedule.DataSource = TmsDataContext.getfacilityforunsched();
                        ddlfacUnschedule.DataTextField = "facilityName";
                        ddlfacUnschedule.DataValueField = "Id";
                        ddlfacUnschedule.DataBind();
                    }
                    else if (_empId == MyApplicationSession._UserID && TmsDataContext.GetEmployeeDetails(_empId).ElementAtOrDefault(0).tptReq == 'Y' && (seldate == DateTime.Now.Date || seldate == DateTime.Now.Date.AddDays(-1)))
                    {
                        ddlOutFacility.Enabled = true;
                        ddlOutTime.Visible = true;
                        btnSaveShift.Visible = true;
                        lblOutTime.Visible = false;
                        ((HyperLink)dvEditEmployeeSchedule.FindControl("lbDropAdhoc")).Visible = true;
                        ((Panel)dvEditEmployeeSchedule.FindControl("pnlUnschedule")).Visible = true;

                        String lbtdropnnavigateurl = (new EncryptQueryString()).Encrypt("TripType=D&shiftDate=" + seldate);

                        ((HyperLink)dvEditEmployeeSchedule.FindControl("lbDropAdhoc")).NavigateUrl = "~/AdhocRequest.aspx?" + lbtdropnnavigateurl;
                        DropDownList ddlfacUnschedule = ((DropDownList)dvEditEmployeeSchedule.FindControl("ddlunscheduleFacility"));
                        ddlfacUnschedule.Items.Clear();
                        ddlfacUnschedule.DataSource = TmsDataContext.getfacilityforunsched();
                        ddlfacUnschedule.DataTextField = "facilityName";
                        ddlfacUnschedule.DataValueField = "Id";
                        ddlfacUnschedule.DataBind();






                    }
                    else
                    {
                        ddlOutFacility.Enabled = true;
                        ddlOutTime.Visible = true;
                        btnSaveShift.Visible = true;
                        lblOutTime.Visible = false;
                        ((HyperLink)dvEditEmployeeSchedule.FindControl("lbDropAdhoc")).Visible = false;
                        ((Panel)dvEditEmployeeSchedule.FindControl("pnlUnschedule")).Visible = false;

                    }
                }
            }
	    }
        else
        {
            foreach (var r1 in r)
            {
                ((Label)dvEditEmployeeSchedule.FindControl("lblShiftEmployeeID")).Text = r1.empCode;
                ((Label)dvEditEmployeeSchedule.FindControl("lblShiftEmpName")).Text = r1.empName;
                ((Label)dvEditEmployeeSchedule.FindControl("lblShiftdate")).Text = seldate.ToLongDateString();


                string LogInFacility = Convert.ToString(r1.pickFacilityID);
                string LogOutFacility = Convert.ToString(r1.dropFacilityID);
                string LogInTime = r1.startTime;
                string LogOutTime = r1.endTime;
                if (LogInTime == "")
                {
                    LogInTime = "N/A";
                }
                if (LogOutTime == "")
                {
                    LogOutTime = "N/A";
                }
                DropDownList ddlInFacility = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlInFacility");
                ddlInFacility.Items.Clear();
                ListItem liInFacility = new ListItem("-Facility-", "0");
                ddlInFacility.Items.Add(liInFacility);
                ddlInFacility.DataSource = TmsDataContext.SelectFacilityEmployeeModule(_SpocID);
                ddlInFacility.DataTextField = "facilityName";
                ddlInFacility.DataValueField = "Id";
                ddlInFacility.DataBind();

                ddlInFacility.SelectedIndex = ddlInFacility.Items.IndexOf(ddlInFacility.Items.FindByValue(LogInFacility.ToString()));


                DropDownList ddlInTime = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlInTime");
                ddlInTime.Items.Clear();
                ListItem liIn0 = new ListItem("Select", "0");
                ddlInTime.Items.Insert(0, liIn0);
                ListItem liIn1 = new ListItem("N/A", "N/A");
                ddlInTime.Items.Insert(1, liIn1);
                ddlInTime.DataSource = TmsDataContext.GetEmployeesAssignedShifts(Int32.Parse(LogInFacility),_empId,"P", seldate);
                ddlInTime.DataTextField = "shiftTime";
                ddlInTime.DataValueField = "shiftTime";
                ddlInTime.DataBind();

                ddlInTime.SelectedIndex = ddlInTime.Items.IndexOf(ddlInTime.Items.FindByText(LogInTime.ToString()));
                Label lblInTime = (Label)dvEditEmployeeSchedule.FindControl("lblInTime");

                DateTime LoginDatetime = GetDateTimeComb(Convert.ToDateTime(r1.startDate), LogInTime);
                if (LoginDatetime <= lockPickTime)
                {
                    ddlInFacility.Enabled = false;
                    ddlInTime.Visible = false;
                    lblInTime.Visible = true;
                    lblInTime.Text = LogInTime;
                    String lbtnnavigateurl = (new EncryptQueryString()).Encrypt("TripType=P");
                    ((HyperLink)dvEditEmployeeSchedule.FindControl("lbPickAdhoc")).Visible = false;
                }
                else
                {
                    ddlInFacility.Enabled = true;
                    ddlInTime.Visible = true;
                    lblInTime.Visible = false;
                    ((HyperLink)dvEditEmployeeSchedule.FindControl("lbPickAdhoc")).Visible = false;
                }

                DropDownList ddlOutFacility = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlOutFacility");
                ddlOutFacility.Items.Clear();
                ListItem liOutFacility = new ListItem("-Facility-", "0");
                ddlOutFacility.Items.Add(liOutFacility);
                ddlOutFacility.DataSource = TmsDataContext.SelectFacilityEmployeeModule(_SpocID);
                ddlOutFacility.DataTextField = "facilityName";
                ddlOutFacility.DataValueField = "Id";
                ddlOutFacility.DataBind();

                ddlOutFacility.SelectedIndex = ddlOutFacility.Items.IndexOf(ddlOutFacility.Items.FindByValue(LogOutFacility.ToString()));
                DropDownList ddlOutTime = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlOutTime");
                ddlOutTime.Items.Clear();
                ListItem liOut0 = new ListItem("Select", "0");
                ddlOutTime.Items.Insert(0, liOut0);
                ListItem liOut1 = new ListItem("N/A", "N/A");
                ddlOutTime.Items.Insert(1, liOut1);
                ddlOutTime.DataSource = TmsDataContext.GetEmployeesAssignedShifts(Int32.Parse(LogOutFacility),_empId,"D", seldate);
                ddlOutTime.DataTextField = "shiftTime";
                ddlOutTime.DataValueField = "shiftTime";
                ddlOutTime.DataBind();
                ddlOutTime.SelectedIndex = ddlOutTime.Items.IndexOf(ddlOutTime.Items.FindByText(LogOutTime.ToString()));
                Label lblOutTime = (Label)dvEditEmployeeSchedule.FindControl("lblOutTime");


                Button btnSaveShift = (Button)dvEditEmployeeSchedule.FindControl("btnSaveShift");
                DateTime LogoutDatetime = GetDateTimeComb(Convert.ToDateTime(r1.endDate), LogOutTime);



                if (LogoutDatetime <= lockDropTime)
                {
                    ddlOutFacility.Enabled = false;
                    ddlOutTime.Visible = false;
                    btnSaveShift.Visible = false;
                    lblOutTime.Visible = true;
                    lblOutTime.Text = LogOutTime;

                    if (_empId == MyApplicationSession._UserID && TmsDataContext.GetEmployeeDetails(_empId).ElementAtOrDefault(0).tptReq == 'Y')
                    {
                        String lbtdropnnavigateurl = (new EncryptQueryString()).Encrypt("TripType=D&shiftDate=" + seldate);
                        ((HyperLink)dvEditEmployeeSchedule.FindControl("lbDropAdhoc")).NavigateUrl = "~/AdhocRequest.aspx?" + lbtdropnnavigateurl;
                        ((HyperLink)dvEditEmployeeSchedule.FindControl("lbDropAdhoc")).Visible = true;
                        ((Panel)dvEditEmployeeSchedule.FindControl("pnlUnschedule")).Visible = true;

                        DropDownList ddlfacUnschedule = ((DropDownList)dvEditEmployeeSchedule.FindControl("ddlunscheduleFacility"));
                        ddlfacUnschedule.Items.Clear();
                        ddlfacUnschedule.DataSource = TmsDataContext.getfacilityforunsched();
                        ddlfacUnschedule.DataTextField = "facilityName";
                        ddlfacUnschedule.DataValueField = "Id";
                        ddlfacUnschedule.DataBind();
                    }
                    else
                    {
                        ((HyperLink)dvEditEmployeeSchedule.FindControl("lbDropAdhoc")).Visible = false;
                        ((Panel)dvEditEmployeeSchedule.FindControl("pnlUnschedule")).Visible = false;
                    }
                }
                else
                {
                    if (seldate == DateTime.Now.Date && LogOutTime == "N/A" && _empId == MyApplicationSession._UserID && TmsDataContext.GetEmployeeDetails(_empId).ElementAtOrDefault(0).tptReq == 'Y')
                    {
                        ddlOutFacility.Enabled = true;
                        ddlOutTime.Visible = true;
                        btnSaveShift.Visible = true;
                        lblOutTime.Visible = false;
                        ((HyperLink)dvEditEmployeeSchedule.FindControl("lbDropAdhoc")).Visible = true;
                        ((Panel)dvEditEmployeeSchedule.FindControl("pnlUnschedule")).Visible = true;

                        String lbtdropnnavigateurl = (new EncryptQueryString()).Encrypt("TripType=D&shiftDate=" + seldate);

                        ((HyperLink)dvEditEmployeeSchedule.FindControl("lbDropAdhoc")).NavigateUrl = "~/AdhocRequest.aspx?" + lbtdropnnavigateurl;
                        DropDownList ddlfacUnschedule = ((DropDownList)dvEditEmployeeSchedule.FindControl("ddlunscheduleFacility"));
                        ddlfacUnschedule.Items.Clear();
                        ddlfacUnschedule.DataSource = TmsDataContext.getfacilityforunsched();
                        ddlfacUnschedule.DataTextField = "facilityName";
                        ddlfacUnschedule.DataValueField = "Id";
                        ddlfacUnschedule.DataBind();
                    }
                    else if (_empId == MyApplicationSession._UserID && TmsDataContext.GetEmployeeDetails(_empId).ElementAtOrDefault(0).tptReq == 'Y' && (seldate == DateTime.Now.Date || seldate == DateTime.Now.Date.AddDays(-1)))
                    {
                        ddlOutFacility.Enabled = true;
                        ddlOutTime.Visible = true;
                        btnSaveShift.Visible = true;
                        lblOutTime.Visible = false;
                        ((HyperLink)dvEditEmployeeSchedule.FindControl("lbDropAdhoc")).Visible = true;
                        ((Panel)dvEditEmployeeSchedule.FindControl("pnlUnschedule")).Visible = true;

                        String lbtdropnnavigateurl = (new EncryptQueryString()).Encrypt("TripType=D&shiftDate=" + seldate);

                        ((HyperLink)dvEditEmployeeSchedule.FindControl("lbDropAdhoc")).NavigateUrl = "~/AdhocRequest.aspx?" + lbtdropnnavigateurl;
                        DropDownList ddlfacUnschedule = ((DropDownList)dvEditEmployeeSchedule.FindControl("ddlunscheduleFacility"));
                        ddlfacUnschedule.Items.Clear();
                        ddlfacUnschedule.DataSource = TmsDataContext.getfacilityforunsched();
                        ddlfacUnschedule.DataTextField = "facilityName";
                        ddlfacUnschedule.DataValueField = "Id";
                        ddlfacUnschedule.DataBind();
                        
                    }
                    else
                    {
                        ddlOutFacility.Enabled = true;
                        ddlOutTime.Visible = true;
                        btnSaveShift.Visible = true;
                        lblOutTime.Visible = false;
                        ((HyperLink)dvEditEmployeeSchedule.FindControl("lbDropAdhoc")).Visible = false;
                        ((Panel)dvEditEmployeeSchedule.FindControl("pnlUnschedule")).Visible = false;

                    }
                }
            }
        }

       
        MultiView2.ActiveViewIndex = 0;
        ModalPopupExtender3.Show();
        //}
        //else
        //{
        //    lblSaveMsg.Text = "Roster is Lock";
        //    lblSaveMsg.Visible = true;

        //}
    }
    protected void lbReplicateSchedule_Click(object sender, EventArgs e)
    {
        try
        {
            Server.Execute("ReplicateSchedule.aspx");
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void ddlInFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        Button btnSaveShift = (Button)dvEditEmployeeSchedule.FindControl("btnSaveShift");
        btnSaveShift.Enabled = false;
        //DropDownList ddlInFacility = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlInFacility");
        DropDownList ddlInFacility = (DropDownList)sender;
        DropDownList lBxIn0 = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlInTime");
        DateTime sDate = DateTime.Parse(((Label)dvEditEmployeeSchedule.FindControl("lblShiftdate")).Text);
        string selFacilityIDIn = ddlInFacility.SelectedValue.ToString();

        if (MyApplicationSession._IsExceptional == "0" || MyApplicationSession._UserID != _empId)
        {
            lBxIn0.Items.Clear();
            lBxIn0.DataSource = TmsDataContext.GetPickShiftTime(Int32.Parse(selFacilityIDIn), sDate);
            lBxIn0.DataTextField = "shiftTime";
            lBxIn0.DataValueField = "shiftTime";
            lBxIn0.DataBind();
            ListItem liIn0 = new ListItem("Select", "0");
            lBxIn0.Items.Insert(0, liIn0);
            ListItem liIn1 = new ListItem("N/A", "N/A");
            lBxIn0.Items.Insert(1, liIn1);
            MultiView2.ActiveViewIndex = 0;
            ModalPopupExtender3.Show();
            btnSaveShift.Enabled = true;
        }
        else
        {
            lBxIn0.Items.Clear();
            lBxIn0.DataSource = TmsDataContext.GetEmployeesAssignedShifts(Int32.Parse(selFacilityIDIn),_empId,"P", sDate);
            lBxIn0.DataTextField = "shiftTime";
            lBxIn0.DataValueField = "shiftTime";
            lBxIn0.DataBind();
            ListItem liIn0 = new ListItem("Select", "0");
            lBxIn0.Items.Insert(0, liIn0);
            ListItem liIn1 = new ListItem("N/A", "N/A");
            lBxIn0.Items.Insert(1, liIn1);
            MultiView2.ActiveViewIndex = 0;
            ModalPopupExtender3.Show();
            btnSaveShift.Enabled = true;
        }
        
    }

    protected void ddlOutFacility_SelectedIndexChanged(object sender, EventArgs e)
    {

        Button btnSaveShift = (Button)dvEditEmployeeSchedule.FindControl("btnSaveShift");
        btnSaveShift.Enabled = false;
        DropDownList ddlOutFacility = (DropDownList)sender;
        DropDownList lBxOut0 = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlOutTime");
        DateTime sDate = DateTime.Parse(((Label)dvEditEmployeeSchedule.FindControl("lblShiftdate")).Text);
        string selFacilityIDOut = ddlOutFacility.SelectedValue.ToString();

        if (MyApplicationSession._IsExceptional == "0" || MyApplicationSession._UserID != _empId)
        {
            lBxOut0.Items.Clear();
            lBxOut0.DataSource = TmsDataContext.GetDropShiftTime(Int32.Parse(selFacilityIDOut), sDate, "A");
            lBxOut0.DataTextField = "shiftTime";
            lBxOut0.DataValueField = "shiftTime";
            lBxOut0.DataBind();
            ListItem liOut0 = new ListItem("Select", "0");
            lBxOut0.Items.Insert(0, liOut0);
            ListItem liOut1 = new ListItem("N/A", "N/A");
            lBxOut0.Items.Insert(1, liOut1);
            MultiView2.ActiveViewIndex = 0;
            ModalPopupExtender3.Show();
            btnSaveShift.Enabled = true;
        }
        else
        {
            lBxOut0.Items.Clear();
            lBxOut0.DataSource = TmsDataContext.GetEmployeesAssignedShifts(Int32.Parse(selFacilityIDOut),_empId,"D", sDate);
            lBxOut0.DataTextField = "shiftTime";
            lBxOut0.DataValueField = "shiftTime";
            lBxOut0.DataBind();
            ListItem liOut0 = new ListItem("Select", "0");
            lBxOut0.Items.Insert(0, liOut0);
            ListItem liOut1 = new ListItem("N/A", "N/A");
            lBxOut0.Items.Insert(1, liOut1);
            MultiView2.ActiveViewIndex = 0;
            ModalPopupExtender3.Show();
            btnSaveShift.Enabled = true;
        }
        
       
    }

    protected void btnSaveShift_Click(object sender, EventArgs e)
    {
        string empID = ((Label)dvEditEmployeeSchedule.FindControl("lblShiftEmployeeID")).Text;
        DateTime sDate = DateTime.Parse(((Label)dvEditEmployeeSchedule.FindControl("lblShiftdate")).Text);

        string sTime = ((DropDownList)dvEditEmployeeSchedule.FindControl("ddlInTime")).SelectedValue;
        string eTime = ((DropDownList)dvEditEmployeeSchedule.FindControl("ddlOutTime")).SelectedValue;


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

        var result = TmsDataContext.UpdateEmpSchedule(empID, sDate, sTime.Trim(), eTime.Trim(), Int32.Parse(selFacilityIDIn), Int32.Parse(selFacilityIDOut), _SpocID);
        bindgrdEmployeeSchedule();

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
    protected void lbSaveMobile_Click(object sender, EventArgs e)
    {
        TextBox txtMobile = ((TextBox)DvGeo.FindControl("txtMobile"));
        string NewMobileNo = txtMobile.Text;
        Label lblMobile = ((Label)DvGeo.FindControl("lblMobile"));
        string OldMobileNo = lblMobile.Text;
        var result = TmsDataContext.UpdateEmpMobile(_empId, OldMobileNo, NewMobileNo, MyApplicationSession._UserID).ElementAtOrDefault(0).result;
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
        ModalPopupExtender.Show();
        lblMobile.Text = TmsDataContext.GetEmpGeoCodeDetails(_empId).ElementAtOrDefault(0).mobile;
    }
    protected void lbEditMobile_Click(object sender, EventArgs e)
    {
        ModalPopupExtender.Show();
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
    protected void lbCancelMobile_Click(object sender, EventArgs e)
    {
        ModalPopupExtender.Show();
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

    protected void imgBtnRoute_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton imgBtnRoute = sender as ImageButton;
        GridViewRow row = imgBtnRoute.NamingContainer as GridViewRow;
        int rowIndex = Convert.ToInt32(row.RowIndex);
        _seldate = Convert.ToDateTime(imgBtnRoute.CommandArgument);
        Int32 selEmployeeID = Convert.ToInt32(grdEmployeeSchedule.DataKeys[rowIndex].Value);

        Panel4.Visible = false;
        Panel5.Visible = false;

        grdShowPickUpRoute.DataSource = TmsDataContext.GetMyRoutesDetails(selEmployeeID, _seldate, "P");
        grdShowPickUpRoute.DataBind();

        if (grdShowPickUpRoute.Rows.Count > 0)
        {
            Panel4.Visible = true;
            string routeID = grdShowPickUpRoute.DataKeys[0]["routeid"].ToString();
            var pickUpResult = TmsDataContext.GetRouteInfo(routeID);

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
                lblPickStickerNo.Text = pickUpResult1.vehicleId;
                lblPickFacility.Text = pickUpResult1.facility;
                lblRouteNo.Text = pickUpResult1.sticker.ToString();
            }
        }

        grdShowDropRoute.DataSource = TmsDataContext.GetMyRoutesDetails(selEmployeeID, _seldate, "D");
        grdShowDropRoute.DataBind();

        if (grdShowDropRoute.Rows.Count > 0)
        {
           Panel5.Visible = true;
            string routeID = grdShowDropRoute.DataKeys[0]["routeid"].ToString();
            var DropUpResult = TmsDataContext.GetRouteInfo(routeID);

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
                lblDropStickerNo.Text = DropUpResult1.vehicleId;
                lblDropFacility.Text = DropUpResult1.facility;
                Label1.Text = DropUpResult1.sticker.ToString();
            }
        }

        ModalPopupExtender2.Show();
        MultiView3.ActiveViewIndex = 0;
        
    }

    protected void btnRaiseUnschedule_Click(object sender, EventArgs e)
    {
        string shift = null;
        string Shiftdate=null;
          DropDownList ddlfacUnschedule = ((DropDownList)dvEditEmployeeSchedule.FindControl("ddlunscheduleFacility"));
          _Facility = Convert.ToInt32(ddlfacUnschedule.SelectedValue);

          ddlShiftAvailable.DataSource = TmsDataContext.GetUnscheduleShift(_empId, Convert.ToInt32(ddlfacUnschedule.SelectedValue));
          ddlShiftAvailable.DataTextField = "shiftTime";
          ddlShiftAvailable.DataValueField = "shiftTime";
        ddlShiftAvailable.DataBind();
        MultiView2.ActiveViewIndex = -1;
        ModalPopupExtender3.Hide();
        MultiView1.ActiveViewIndex = 0;
        ModalPopupExtender1.Show();
        if (ddlShiftAvailable.Items.Count==0)
        {
           
            lblUnscheduleMsg.Text = "No available shift in unschedule period";
            lblUnscheduleMsg.Visible = true;
            pnlRaise.Visible = false;
        }
        else
        {
            pnlRaise.Visible = true;
            lblStatus.Text = "Your unscheduled request would be allocated based on the route & seat availability. Please carry the unscheduled form. Thank you.<br/><br/><br/>Next Available Unschedule shift is:<br/>";
            lblUnscheduleMsg.Visible = false;
        }
 
    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);
    }

    protected void btnAccept_Click(object sender, EventArgs e)
    {
        var res = TmsDataContext.AddUnscheduleRequest(_empId, _Facility,MyApplicationSession._UserID,ddlShiftAvailable.SelectedValue);
        String msg = null, flag = null;
        foreach (var r in res)
        {
            msg = r.Result;
            flag = r.ID;
        }
        if (flag == "0")
        {
            MultiView2.ActiveViewIndex = -1;
            ModalPopupExtender3.Hide();
            MultiView1.ActiveViewIndex = 0;
            ModalPopupExtender1.Show();

            lblUnscheduleMsg.Text = msg;
            lblUnscheduleMsg.Visible = true;
            pnlRaise.Visible = false;
        }
        else
        {
            String lbtnnavigateurl = (new EncryptQueryString()).Encrypt("ID="+flag);
            string jScript = "window.open('PrintUnscheduleTripsheet.aspx?" + lbtnnavigateurl + "','','');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Request", jScript, true);
            
        }
    }
    protected void lbUnscheduleRequest_Click(object sender, EventArgs e)
    {
        MultiView4.ActiveViewIndex = 0;
        ModalPopupExtender4.Show();
        GvUnschedule.DataSource = TmsDataContext.GetUnscheduleDetailsbyEmp(MyApplicationSession._UserID);
        GvUnschedule.DataBind();
    }
    protected void lbTakePrint_Click(object sender, EventArgs e)
    {
        MultiView4.ActiveViewIndex = 0;
        ModalPopupExtender4.Show();
        LinkButton btn = (LinkButton)sender;
        GridViewRow gvr = (GridViewRow)btn.NamingContainer;
        int rowindex = gvr.RowIndex;
        Label Id = (Label)GvUnschedule.Rows[rowindex].FindControl("lblRequestID");
        String lbtnnavigateurl = (new EncryptQueryString()).Encrypt("ID=" + Id.Text);
        string jScript = "window.open('PrintUnscheduleTripsheet.aspx?" + lbtnnavigateurl + "','','');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Print", jScript, true);
    }
    protected void lbDelete_Click(object sender, EventArgs e)
    {
        MultiView4.ActiveViewIndex = 0;
        ModalPopupExtender4.Show();
        LinkButton btn = (LinkButton)sender;
        GridViewRow gvr = (GridViewRow)btn.NamingContainer;
        int rowindex = gvr.RowIndex;
        Label Id = (Label)GvUnschedule.Rows[rowindex].FindControl("lblRequestID");
        TmsDataContext.DeleteUnscheduleRequest(Id.Text);

        GvUnschedule.DataSource = TmsDataContext.GetUnscheduleDetailsbyEmp(MyApplicationSession._UserID);
        GvUnschedule.DataBind();
    }
    protected Boolean enableds(object strArg)
    {
        try
        {
            string val = Convert.ToString(strArg);

            if (val == "0")
            {
                return true;
            }
            else
            {
                return false;
            }

        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void lnbtnSpecialRequest_Click(object sender, EventArgs e)
    {
        MultiView6.ActiveViewIndex = 0;
        ModalPopupExtender5.Show();
        GVSeperate.DataSource = TmsDataContext.GetMgrSchedule(_SpocID, DateTime.Now.Date) ;
        GVSeperate.DataBind();
        for (int i = 0; i < GVSeperate.Rows.Count; i++)
        {
            if (((Label)(GVSeperate.Rows[i].FindControl("EmpID"))).Text == MyApplicationSession._UserID.ToString())
            {
                CheckBox cb=(CheckBox)(GVSeperate.Rows[i].FindControl("chkBxEmpId"));
                cb.Checked=true;
            }
        }
       //
       
        ddlSeperateCabFacility.Items.Clear();
        ddlSeperateCabFacility.DataSource = TmsDataContext.SelectFacilityEmployeeModule(MyApplicationSession._UserID);
        ddlSeperateCabFacility.DataTextField = "facilityname";
        ddlSeperateCabFacility.DataValueField = "Id";
        ddlSeperateCabFacility.DataBind();
    }
    protected void btnRaiseSeperateCab_Click(object sender, EventArgs e)
    {string ids=null;
        for (int i = 0; i < GVSeperate.Rows.Count; i++)
        {
            if (((CheckBox)(GVSeperate.Rows[i].FindControl("chkBxEmpId"))).Checked==true)
            {
            ids=ids+  ((Label)(GVSeperate.Rows[i].FindControl("EmpID"))).Text+",";
                
               
            }
        }
        if (ids != null)
        {
            ids = ids.Substring(0, ids.Length - 1);
            TmsDataContext.InsertSeperateCab(ids,Convert.ToInt32(ddlSeperateCabFacility.SelectedValue),MyApplicationSession._UserID,txtreason.Text);
            MultiView6.ActiveViewIndex = -1;
            ModalPopupExtender5.Hide();
            ShowMessage("Request Sent successfully to Division Manager for approval");
        }
        else
        {
            ShowMessage("Please Select Atleast one Partner");
            ModalPopupExtender5.Show();
        }
    }
    protected void lbtnShuttleRequest_Click(object sender, EventArgs e)
    {
        MultiView7.ActiveViewIndex = 0;
        ModalPopupExtender6.Show();
        GvShuttle.DataSource = TmsDataContext.GetMgrSchedule(_SpocID, DateTime.Now.Date);
        GvShuttle.DataBind();
        for (int i = 0; i < GvShuttle.Rows.Count; i++)
        {
            if (((Label)(GvShuttle.Rows[i].FindControl("EmpID"))).Text == MyApplicationSession._UserID.ToString())
            {
                CheckBox cb = (CheckBox)(GvShuttle.Rows[i].FindControl("chkBxEmpId"));
                cb.Checked = true;
            }
        }
        //

        ddlShuttleFacility.Items.Clear();
        ddlShuttleFacility.DataSource = TmsDataContext.SelectFacilityEmployeeModule(MyApplicationSession._UserID);
        ddlShuttleFacility.DataTextField = "facilityname";
        ddlShuttleFacility.DataValueField = "Id";
        ddlShuttleFacility.DataBind();
        bndshuttlefacility();

    }
    protected void ddlShuttleFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndshuttlefacility();
    }
    protected void btnShuttle_Click(object sender, EventArgs e)
    {
        string ids = null;
        int id = 0;
        int flag = 0;
        string res = null;
        for (int i = 0; i < GvShuttle.Rows.Count; i++)
        {
            if (((CheckBox)(GvShuttle.Rows[i].FindControl("chkBxEmpId"))).Checked == true)
            {
                ids = ids + ((Label)(GvShuttle.Rows[i].FindControl("EmpID"))).Text + ",";
                id = Convert.ToInt32(((Label)(GvShuttle.Rows[i].FindControl("EmpID"))).Text);

             res=   TmsDataContext.InsertShuttleRequest(id, Convert.ToInt32(ddlShuttleFacility.SelectedValue), ddlShiftsShuttle.SelectedValue, MyApplicationSession._UserID).ElementAtOrDefault(0).Result.ToString();
             if (res != "0")
             {
                  ModalPopupExtender6.Hide();
               MultiView7.ActiveViewIndex = -1;
               ShowMessage("Request for" + res + " has been already made");
               MultiView1.ActiveViewIndex = -1;
               flag = 1;
             }
             else
             {
                 flag = 0;
             
             }
            
            }
        }
        if (ids != null)
        {
            ids = ids.Substring(0, ids.Length - 1);
           
            MultiView7.ActiveViewIndex = -1;
            ModalPopupExtender6.Hide();
            if (flag == 0)
            {
                ShowMessage("Request Sent successfully for partners");
                MultiView1.ActiveViewIndex = -1;
            }
            }
        else
        {
            MultiView1.ActiveViewIndex = -1;
            ShowMessage("Please Select Atleast one Partner");
            ModalPopupExtender5.Show();
        }
    }
    protected void bndshuttlefacility()
    {
        int id = Convert.ToInt32(ddlShuttleFacility.SelectedValue);
        ddlShiftsShuttle.Items.Clear();
        ddlShiftsShuttle.DataSource = TmsDataContext.getShuttleShifts(id);
        ddlShiftsShuttle.DataTextField = "Shift";
        ddlShiftsShuttle.DataValueField = "shift";
        ddlShiftsShuttle.DataBind();
        if (ddlShiftsShuttle.Items.Count > 0)
        {
            ModalPopupExtender6.Show();
        }
        else
        {
            ModalPopupExtender6.Hide();
            MultiView7.ActiveViewIndex = -1;
            ShowMessage("No Shifts Available for the selected Facility");
            MultiView1.ActiveViewIndex =-1;
        }
    }
    protected void lbtnIOSRequest_Click(object sender, EventArgs e)
    {
        MultiView8.ActiveViewIndex = 0;
        ModalPopupExtender7.Show();
        GvShuttleDetails.DataSource = TmsDataContext.getShuttleDetailsbyEmp(MyApplicationSession._UserID);
        GvShuttleDetails.DataBind();
    }
    public Boolean Geticon(object flag)
    {
        int ID = Convert.ToInt32(flag);
        if (ID == 0)
            return true;

        return false;

    }
    protected void lblCancel_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;


        GridViewRow gvr = (GridViewRow)btn.NamingContainer;


        int rowindex = gvr.RowIndex;
        int id =Convert.ToInt32( GvShuttleDetails.DataKeys[rowindex].Value.ToString());
        TmsDataContext.deleteshuttlerequest(id);
        ShowMessage("Shuttle Request Cancelled Successfully");
        MultiView8.ActiveViewIndex = -1;
        ModalPopupExtender7.Hide();

    }
}
