using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ReplicateSchedule : basepage
{
    DataClasses1DataContext TmsDataContext = new DataClasses1DataContext();
    DateTime lockSDate, lockEDate, lockPickTime, lockDropTime;
    public int _NextWeekCount
    {
        get { return (int)ViewState["_NextWeekCount"]; }
        set { ViewState["_NextWeekCount"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            _NextWeekCount = 0;
            DateTime Today = DateTime.Now.Date;
            lblFromWSDate.Text = (Today.AddDays(1 - (int)Today.DayOfWeek)).ToShortDateString();
            lblFromWEDate.Text = (Today.AddDays(7 - (int)Today.DayOfWeek)).ToShortDateString();
            lblToWSDate.Text = (Today.AddDays(8 - (int)Today.DayOfWeek)).ToShortDateString();
            lblToWEDate.Text = (Today.AddDays(14 - (int)Today.DayOfWeek)).ToShortDateString();
            bindgrdEmployeeSchedule();
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

    protected void bindgrdEmployeeSchedule()
    {
        try
        {
            DateTime sDate = new DateTime();
            sDate = Convert.ToDateTime(lblToWSDate.Text);
            grdEmployeeSchedule.DataSource = TmsDataContext.GetEmployeeSchedule(MyApplicationSession._UserID, sDate);
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

    protected DateTime GetShiftdate(int addDays)
    {
        return Convert.ToDateTime(lblToWSDate.Text).AddDays(addDays);
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

    protected void btnReplicate_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid == true)
            {
                string empIds = string.Empty;
                var result = 0;
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

                var Lockresult = TmsDataContext.GetLockDetails(MyApplicationSession._FacilityID);
                foreach (var result1 in Lockresult)
                {
                    lockSDate = Convert.ToDateTime(result1.lockSDate);
                    lockEDate = Convert.ToDateTime(result1.lockEDate);
                    lockPickTime = Convert.ToDateTime(result1.pickLockDateTime);
                    lockDropTime = Convert.ToDateTime(result1.dropLockDateTime);
                }

                DateTime ToWSDate = Convert.ToDateTime(lblToWSDate.Text);
                //lockPickTime = lockPickTime.AddDays(5);
                if (lockPickTime < ToWSDate)
                {
                    TmsDataContext.ReplicateSchedule(empIds, Convert.ToDateTime(lblFromWSDate.Text), Convert.ToDateTime(lblFromWEDate.Text), Convert.ToDateTime(lblToWSDate.Text), Convert.ToDateTime(lblToWEDate.Text), MyApplicationSession._UserID);
                    result = 1;
                }
                else
                {
                    result = 2;
                }
                
                bindgrdEmployeeSchedule();
                if (result <= 0)
                {
                    lblSaveMsg.Text = "Schedule not replcated successfully.";
                }
                else if (result == 1)
                {
                    lblSaveMsg.Text = "Schedule Replcated successfully.";
                }
                else if (result == 2)
                {
                    lblSaveMsg.Text = "Sorry...Schedule Replication cannot be done because roster for the week starting " + lblToWSDate.Text + " to " + lblToWEDate.Text + " has been locked.";
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
    protected void lbtNextWeek_Click(object sender, EventArgs e)
    {
        lbtPrevWeek.Visible = true;
        DateTime NextWeek = Convert.ToDateTime(lblToWSDate.Text);
        lblToWSDate.Text = (NextWeek.AddDays(8 - (int)NextWeek.DayOfWeek)).ToShortDateString();
        lblToWEDate.Text = (NextWeek.AddDays(14 - (int)NextWeek.DayOfWeek)).ToShortDateString();
        _NextWeekCount += 1;
    }
    protected void lbtPrevWeek_Click(object sender, EventArgs e)
    {
        _NextWeekCount += -1;
        if (_NextWeekCount <= 0)
        {
            lbtPrevWeek.Visible = false;
        }
        DateTime PrevWeekStart = Convert.ToDateTime(lblToWSDate.Text);
        lblToWSDate.Text = (PrevWeekStart.AddDays((int)PrevWeekStart.DayOfWeek - 8)).ToShortDateString();
        DateTime PrevWeekEnd = Convert.ToDateTime(lblToWEDate.Text);
        lblToWEDate.Text = (PrevWeekEnd.AddDays((int)PrevWeekEnd.DayOfWeek - 7)).ToShortDateString();
    }
}
