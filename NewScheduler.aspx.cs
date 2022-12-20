using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class NewScheduler : basepage2
{
    DateTime lockPickTime, lockDropTime;
    int lockDiffDays;
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
            var result = TmsDataContext.GetLockDetails(MyApplicationSession._FacilityID);
            foreach (var result1 in result)
            {
                lockPickTime = Convert.ToDateTime(result1.pickLockDateTime).AddDays(1);
                lockDropTime = Convert.ToDateTime(result1.dropLockDateTime);
                lockDiffDays = Convert.ToInt32(result1.lockDiffDays);
            }
            check();
            if (!IsPostBack)
            {
                check();
                txtFromDate.Attributes.Add("readOnly", "true");
                txtFromDate.Text = lockPickTime.ToShortDateString();
                txtToDate.Attributes.Add("readOnly", "true");
                txtToDate.Text = lockPickTime.AddDays(lockDiffDays).ToShortDateString();

                RangeValidator1.MinimumValue = lockPickTime.ToShortDateString();
                RangeValidator1.MaximumValue = lockPickTime.AddDays(lockDiffDays).ToShortDateString();
                RangeValidator1.ErrorMessage = "From date should be between " + lockPickTime.ToShortDateString() + " and " + lockPickTime.AddDays(lockDiffDays).ToShortDateString();

                RangeValidator2.MinimumValue = lockPickTime.ToShortDateString();
                RangeValidator2.MaximumValue = lockPickTime.AddDays(lockDiffDays).ToShortDateString();
                RangeValidator2.ErrorMessage = "To date should be between " + lockPickTime.ToShortDateString() + " and " + lockPickTime.AddDays(lockDiffDays).ToShortDateString();


                _SpocID = MyApplicationSession._UserID;

                bindgrdEmployeeSchedule();
                bindShiftHeader();
            }
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
                ddlLogIn.DataSource = TmsDataContext.GetShiftsbyDays(Convert.ToInt32(ddlFacilityIn.SelectedValue),"P","0");
                ddlLogIn.DataTextField = "shiftTime";
                ddlLogIn.DataValueField = "shiftTime";
                ddlLogIn.DataBind();
                ListItem liIn = new ListItem("Select", "0");
                ddlLogIn.Items.Insert(0, liIn);
                ListItem liIn1 = new ListItem("N/A", "N/A");
                ddlLogIn.Items.Insert(1, liIn1);
            }
            if (ddlEndLogin != null)
            {
                ddlEndLogin.DataSource = TmsDataContext.GetShiftsbyDays(Convert.ToInt32(ddlFacilityIn.SelectedValue), "P", "1");
                ddlEndLogin.DataTextField = "shiftTime";
                ddlEndLogin.DataValueField = "shiftTime";
                ddlEndLogin.DataBind();
                ListItem liIn = new ListItem("Select", "0");
                ddlEndLogin.Items.Insert(0, liIn);
                ListItem liIn1 = new ListItem("N/A", "N/A");
                ddlEndLogin.Items.Insert(1, liIn1);
            }

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
                ddlLogOut.DataSource = TmsDataContext.GetShiftsbyDays(Convert.ToInt32(ddlFacilityOut.SelectedValue), "D", "0");
                ddlLogOut.DataTextField = "shiftTime";
                ddlLogOut.DataValueField = "shiftTime";
                ddlLogOut.DataBind();
                ListItem liOut = new ListItem("Select", "0");
                ddlLogOut.Items.Insert(0, liOut);
                ListItem liOut1 = new ListItem("N/A", "N/A");
                ddlLogOut.Items.Insert(1, liOut1);
            }
            if (ddlEndLogout != null)
            {
                ddlEndLogout.DataSource = TmsDataContext.GetShiftsbyDays(Convert.ToInt32(ddlFacilityOut.SelectedValue), "D", "1");
                ddlEndLogout.DataTextField = "shiftTime";
                ddlEndLogout.DataValueField = "shiftTime";
                ddlEndLogout.DataBind();
                ListItem liOut = new ListItem("Select", "0");
                ddlEndLogout.Items.Insert(0, liOut);
                ListItem liOut1 = new ListItem("N/A", "N/A");
                ddlEndLogout.Items.Insert(1, liOut1);
            }
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
            grdEmployeeSchedule.DataSource = TmsDataContext.GetMgrAssociate(_SpocID);
            grdEmployeeSchedule.DataBind();

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
            ddlLogIn.DataSource = TmsDataContext.GetShiftsbyDays(Convert.ToInt32(ddlFacilityIn.SelectedValue), "P", "0");
            ddlLogIn.DataTextField = "shiftTime";
            ddlLogIn.DataValueField = "shiftTime";
            ddlLogIn.DataBind();
            ListItem liIn = new ListItem("Select", "0");
            ddlLogIn.Items.Insert(0, liIn);
            ddlEndLogin.DataSource = TmsDataContext.GetShiftsbyDays(Convert.ToInt32(ddlFacilityIn.SelectedValue), "P", "1");
            ddlEndLogin.DataTextField = "shiftTime";
            ddlEndLogin.DataValueField = "shiftTime";
            ddlEndLogin.DataBind();
            ListItem liIn0 = new ListItem("Select", "0");
            ddlEndLogin.Items.Insert(0, liIn0);
            ListItem liIn1 = new ListItem("N/A", "N/A");
            ddlEndLogin.Items.Insert(1, liIn1);
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
            string selFacilityIDOut = ddlFacilityOut.SelectedValue.ToString();
            ddlLogOut.DataSource = TmsDataContext.GetShiftsbyDays(Convert.ToInt32(ddlFacilityOut.SelectedValue), "D", "0");
            ddlLogOut.DataTextField = "shiftTime";
            ddlLogOut.DataValueField = "shiftTime";
            ddlLogOut.DataBind();
            ListItem liOut = new ListItem("Select", "0");
            ddlLogOut.Items.Insert(0, liOut);
            ddlEndLogout.DataSource = TmsDataContext.GetShiftsbyDays(Convert.ToInt32(ddlFacilityOut.SelectedValue), "D", "1");
            ddlEndLogout.DataTextField = "shiftTime";
            ddlEndLogout.DataValueField = "shiftTime";
            ddlEndLogout.DataBind();
            ListItem liOut0 = new ListItem("Select", "0");
            ddlEndLogout.Items.Insert(0, liOut0);
            ListItem liOut1 = new ListItem("N/A", "N/A");
            ddlEndLogout.Items.Insert(1, liOut1);
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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid == true)
            {
                string empIds = string.Empty;
                string fromDate, toDate, facilityIn, facilityOut, logIn, logOut, WeeklyOff = "";
                //var result = 0;
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
                fromDate = txtFromDate.Text;
                toDate = txtToDate.Text;
                facilityIn = ddlFacilityIn.SelectedValue;
                facilityOut = ddlFacilityOut.SelectedValue;
                logIn = ddlLogIn.SelectedValue;
                logOut = ddlLogOut.SelectedValue;
                String weekendlogin = ddlEndLogin.SelectedValue;
                String weekendlogout = ddlEndLogout.SelectedValue;
                foreach (ListItem listitem in chkWeeklyOff.Items)
                {
                    if (listitem.Selected)
                        WeeklyOff += listitem.Value + ",";
                }

//                var result = TmsDataContext.InsertNewSchedule(empIds, fromDate, toDate, Convert.ToInt32(facilityIn), Convert.ToInt32(facilityOut), logIn, logOut, WeeklyOff, _SpocID);
                grdScheduleNotUpdated.DataSource = TmsDataContext.InsertNewSchedule(empIds, fromDate, toDate, Convert.ToInt32(facilityIn), Convert.ToInt32(facilityOut), logIn, logOut, WeeklyOff, _SpocID,weekendlogin,weekendlogout);
                grdScheduleNotUpdated.DataBind();
                if (grdScheduleNotUpdated.Rows.Count > 0)
                {
                    Panel3.Style.Add(HtmlTextWriterStyle.Visibility, "visible");
                    ModalPopupExtender1.Show();
                }
                else
                {
                    Response.Redirect("MySchedule.aspx");
                }
                //foreach (var result1 in result)
                //{ 
                    
                //}

                //Response.Redirect("MySchedule.aspx");
                //WeeklyOff = chkWeeklyOff.SelectedValue;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void chkWeeklyOff_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (ListItem listitem in chkWeeklyOff.Items)
        {
            if (listitem.Selected)
            {
                if (Convert.ToInt32(listitem.Value) == 1 | Convert.ToInt32(listitem.Value) == 7)
                {
                    ddlEndLogout.Enabled = true;
                    ddlEndLogin.Enabled = true;
                }
                else
                {
                    ddlEndLogout.Enabled = false;
                    ddlEndLogin.Enabled = false;
                }
            }
        }

      
    }
    public void check()
    {
        foreach (ListItem listitem in chkWeeklyOff.Items)
        {
            if (listitem.Selected)
            {
                if (listitem.Value == "7")
                {
                    foreach (ListItem listitems in chkWeeklyOff.Items)
                    {
                        if (listitems.Selected)
                        {
                            if (listitems.Value == "1")
                            {
                                ddlEndLogout.Enabled = false;
                                ddlEndLogin.Enabled = false;
                                CompareValidator4.Enabled = false;
                                CompareValidator6.Enabled = false;
                            }
                            else
                            {
                                ddlEndLogout.Enabled = true;
                                ddlEndLogin.Enabled = true;
                                CompareValidator4.Enabled = true;
                                CompareValidator6.Enabled = true;
                            }

                        }

                    }
                }
                else
                {
                    ddlEndLogout.Enabled = true;
                    ddlEndLogin.Enabled = true;
                    CompareValidator4.Enabled = true;
                    CompareValidator6.Enabled = true;
                }
                if (listitem.Value == "1")
                {
                    foreach (ListItem listitems in chkWeeklyOff.Items)
                    {
                        if (listitems.Selected)
                        {
                            if (listitems.Value == "7")
                            {
                                ddlEndLogout.Enabled = false;
                                ddlEndLogin.Enabled = false;
                                CompareValidator4.Enabled = false;
                                CompareValidator6.Enabled = false;
                                break;

                            }

                            else
                            {
                                ddlEndLogout.Enabled = true;
                                ddlEndLogin.Enabled = true;
                                CompareValidator4.Enabled = true;
                                CompareValidator6.Enabled = true;

                            }

                        }

                    }
                }
                else
                {
                    ddlEndLogout.Enabled = true;
                    ddlEndLogin.Enabled = true;
                    CompareValidator4.Enabled = true;
                    CompareValidator6.Enabled = true;
                }
            }
        }
        int i=0;
        foreach (ListItem listitem in chkWeeklyOff.Items)
        {
            if (listitem.Selected)
            {
                i = i + 1;
            }
        }
        if (i == 0)
        {
            ddlEndLogout.Enabled = true;
            ddlEndLogin.Enabled = true;
            CompareValidator4.Enabled = true;
            CompareValidator6.Enabled = true;
        }
        else
        {
            ddlEndLogout.Enabled = false;
            ddlEndLogin.Enabled = false;
            CompareValidator4.Enabled = false;
            CompareValidator6.Enabled = false;
        }
    
    }

}
