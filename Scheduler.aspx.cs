using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Scheduler : basepage
{
    DateTime lockSDate, lockEDate, lockPickTime, lockDropTime;
    DateTime sDate = new DateTime();
    DataClasses1DataContext TmsDataContext = new DataClasses1DataContext();

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
                txtCalendar.Text = DateTime.Today.ToShortDateString();
                bindgrdEmployeeSchedule();
                bindShiftHeader();
                bindShiftHeaders();
                binBSpocDDL();
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }

    }

    protected void txtCalendar_TextChanged(object sender, EventArgs e)
    {
        try
        {
            bindgrdEmployeeSchedule();
            bindShiftHeader();
            bindShiftHeaders();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void binBSpocDDL()
    {
        try
        {
            ddlSpocList.DataSource = TmsDataContext.GetBackupSpocList(_SpocID);
            ddlSpocList.DataTextField = "SpocName";
            ddlSpocList.DataValueField = "SpocId";
            ddlSpocList.DataBind();

            ddlSpocList.SelectedIndex = ddlSpocList.Items.IndexOf(ddlSpocList.Items.FindByValue(_SpocID.ToString()));
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
            grdEmployeeSchedule.DataSource = TmsDataContext.GetEmployeeSchedule(_SpocID, sDate);
            grdEmployeeSchedule.Columns[4].HeaderText = sDate.AddDays(0).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(0).Day.ToString() + "-" + sDate.AddDays(0).ToString("MMMM");
            grdEmployeeSchedule.Columns[5].HeaderText = sDate.AddDays(1).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(1).Day.ToString() + "-" + sDate.AddDays(1).ToString("MMMM");
            grdEmployeeSchedule.Columns[6].HeaderText = sDate.AddDays(2).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(2).Day.ToString() + "-" + sDate.AddDays(2).ToString("MMMM");
            grdEmployeeSchedule.Columns[7].HeaderText = sDate.AddDays(3).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(3).Day.ToString() + "-" + sDate.AddDays(3).ToString("MMMM");
            grdEmployeeSchedule.Columns[8].HeaderText = sDate.AddDays(4).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(4).Day.ToString() + "-" + sDate.AddDays(4).ToString("MMMM");
            grdEmployeeSchedule.Columns[9].HeaderText = sDate.AddDays(5).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(5).Day.ToString() + "-" + sDate.AddDays(5).ToString("MMMM");
            grdEmployeeSchedule.Columns[10].HeaderText = sDate.AddDays(6).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(6).Day.ToString() + "-" + sDate.AddDays(6).ToString("MMMM");
            grdEmployeeSchedule.DataBind();

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    public void bindShiftHeader()
    {

        try
        {
            ContentPlaceHolder mainContentPlaceHolder = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");
            sDate = DateTime.Parse(txtCalendar.Text);
            DropDownList ddlFacilityIn = mainContentPlaceHolder.FindControl("ddlFacilityIn") as DropDownList;
            DropDownList ddlLogIn = mainContentPlaceHolder.FindControl("lstBxIn") as DropDownList;

            if (ddlFacilityIn != null)
            {
                ddlFacilityIn.DataSource = TmsDataContext.SelectFacility(_SpocID,false);
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
                ddlFacilityOut.DataSource = TmsDataContext.SelectFacility(_SpocID,false);
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
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
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
                    ddlFacilityIn.DataSource = TmsDataContext.SelectFacility(_SpocID,false);
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
                    ddlFacilityOut.DataSource = TmsDataContext.SelectFacility(_SpocID,false);
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
            ModalPopupExtender.Show();
            foreach (var r1 in r)
            {
                ((Label)DvGeo.FindControl("lbldvEmpLoyeeID")).Text = r1.empCode;
                ((Label)DvGeo.FindControl("lbldvEmpName")).Text = r1.empName;
                ((CheckBox)DvGeo.FindControl("chkBxTptReq")).Checked = Convert.ToBoolean(r1.tptReq);
                ((Label)DvGeo.FindControl("lbldvAddress1")).Text = r1.address;


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
            bindShiftHeaders();
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
                if (txtDate > lockPickTime && txtDate > lockDropTime)
                {
                    ddlFacIn.SelectedValue = ddlFacilityIn.SelectedValue;
                    ddlIn.DataSource = TmsDataContext.GetPickShiftTime(Convert.ToInt32(ddlFacilityIn.SelectedValue), txtDate);
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
                    ddlOut.DataSource = TmsDataContext.GetDropShiftTime(Convert.ToInt32(ddlFacOut.SelectedValue), txtDate, "A");
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
            lstBxIn.DataSource = TmsDataContext.GetShiftByFacilityType(Convert.ToInt32(ddlFacilityIn.SelectedValue), "P");
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
            lstBxOut.DataSource = TmsDataContext.GetShiftByFacilityType(Convert.ToInt32(ddlFacilityOut.SelectedValue), "D");
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

        lstBxIn0.DataSource = TmsDataContext.GetPickShiftTime(selFacilityIDIn0, sDate);
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
        lstBxOut0.DataSource = TmsDataContext.GetDropShiftTime(selFacilityIDOut0, sDate, "A");
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
        lstBxIn1.DataSource = TmsDataContext.GetPickShiftTime(selFacilityIDIn1, sDate);
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
        lstBxOut1.DataSource = TmsDataContext.GetDropShiftTime(selFacilityIDOut1, sDate, "A");
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
        lstBxIn2.DataSource = TmsDataContext.GetPickShiftTime(selFacilityIDIn2, sDate);
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
        lstBxOut2.DataSource = TmsDataContext.GetDropShiftTime(selFacilityIDOut2, sDate, "A");
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
        lstBxIn3.DataSource = TmsDataContext.GetPickShiftTime(selFacilityIDIn3, sDate);
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
        lstBxOut3.DataSource = TmsDataContext.GetDropShiftTime(selFacilityIDOut3, sDate, "A");
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
        lstBxIn4.DataSource = TmsDataContext.GetPickShiftTime(selFacilityIDIn4, sDate);
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
        lstBxOut4.DataSource = TmsDataContext.GetDropShiftTime(selFacilityIDOut4, sDate, "A");
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
        lstBxIn5.DataSource = TmsDataContext.GetPickShiftTime(selFacilityIDIn5, sDate);
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
        lstBxOut5.DataSource = TmsDataContext.GetDropShiftTime(selFacilityIDOut5, sDate, "A");
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
        lstBxIn6.DataSource = TmsDataContext.GetPickShiftTime(selFacilityIDIn6, sDate);
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
        lstBxOut6.DataSource = TmsDataContext.GetDropShiftTime(selFacilityIDOut6, sDate, "A");
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

                ddlFacIn.DataSource = TmsDataContext.SelectFacility(_SpocID,false);
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

                ddlFacInOut.DataSource = TmsDataContext.SelectFacility(_SpocID,false);
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
        //if ((seldate >= lockSDate) && (seldate <= lockEDate))
        //{
        GridViewRow row = lnkbtnSETime.NamingContainer as GridViewRow;
        int rowIndex = Convert.ToInt32(row.RowIndex);
        Int32 selEmployeeID = Convert.ToInt32(grdEmployeeSchedule.DataKeys[rowIndex].Value);
        var r = TmsDataContext.GetOneEmployeeSchedule(selEmployeeID, seldate);

        foreach (var r1 in r)
        {
            ((Label)dvEditEmployeeSchedule.FindControl("lblShiftEmployeeID")).Text = r1.empCode;
            ((Label)dvEditEmployeeSchedule.FindControl("lblShiftEmpName")).Text = r1.empName;
            ((Label)dvEditEmployeeSchedule.FindControl("lblShiftdate")).Text = seldate.ToLongDateString();


            string LogInFacility = Convert.ToString(r1.pickFacilityID);
            string LogOutFacility = Convert.ToString(r1.dropFacilityID);
            string LogInTime = r1.startTime;
            string LogOutTime = r1.endTime;

            DropDownList ddlInFacility = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlInFacility");
            ddlInFacility.Items.Clear();
            ListItem liInFacility = new ListItem("-Facility-", "0");
            ddlInFacility.Items.Add(liInFacility);
            ddlInFacility.DataSource = TmsDataContext.SelectFacility(_SpocID,false);
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

            DateTime LoginDatetime = GetDateTimeComb(Convert.ToDateTime(r1.startDate), LogInTime);
            if (LoginDatetime <= lockPickTime)
            {
                ddlInFacility.Enabled = false;
                ddlInTime.Enabled = false;
            }
            else
            {
                ddlInFacility.Enabled = true;
                ddlInTime.Enabled = true;
            }

            DropDownList ddlOutFacility = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlOutFacility");
            ddlOutFacility.Items.Clear();
            ListItem liOutFacility = new ListItem("-Facility-", "0");
            ddlOutFacility.Items.Add(liOutFacility);
            ddlOutFacility.DataSource = TmsDataContext.SelectFacility(_SpocID,false);
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

            Button btnSaveShift = (Button)dvEditEmployeeSchedule.FindControl("btnSaveShift");
            DateTime LogoutDatetime = GetDateTimeComb(Convert.ToDateTime(r1.endDate), LogOutTime);

            if (LogoutDatetime <= lockDropTime)
            {
                ddlOutFacility.Enabled = false;
                ddlOutTime.Enabled = false;
                btnSaveShift.Visible = false;
            }
            else
            {
                ddlOutFacility.Enabled = true;
                ddlOutTime.Enabled = true;
                btnSaveShift.Visible = true;
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
        //DropDownList ddlInFacility = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlInFacility");
        DropDownList ddlInFacility = (DropDownList)sender;
        DropDownList lBxIn0 = (DropDownList)dvEditEmployeeSchedule.FindControl("ddlInTime");
        DateTime sDate = DateTime.Parse(((Label)dvEditEmployeeSchedule.FindControl("lblShiftdate")).Text);
        string selFacilityIDIn = ddlInFacility.SelectedValue.ToString();
        lBxIn0.Items.Clear();
        lBxIn0.DataSource = TmsDataContext.GetPickShiftTime(Int32.Parse(selFacilityIDIn), sDate);
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
        lBxOut0.DataSource = TmsDataContext.GetDropShiftTime(Int32.Parse(selFacilityIDOut), sDate, "A");
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

    protected void ddlSpocList_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["Spoc"] = ddlSpocList.SelectedValue;
        _SpocID = Convert.ToInt32(ddlSpocList.SelectedValue);
        String id = Session["Spoc"].ToString();
        bindgrdEmployeeSchedule();
        bindShiftHeader();
        bindShiftHeaders();
    }
    
}
