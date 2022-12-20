using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AssignShift : basepage
{
    DataClasses1DataContext TmsDataContext = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindShiftTimes();
        }
    }

    string PickUpList = "False";
    string DropUpList = "False";
    public void BindShiftTimes()
    {
        //**********************************************************************
        // Create a list of ShiftTimes for PickUp and Drop starting from 0000 hrs to 2130hrs
        //**********************************************************************
        try
        {
            int ishift;
            ChkBxLstShiftTimePick.Items.Clear();
            ChkBxLstShiftTimeDrop.Items.Clear();
            // For PickUp        
            for (ishift = 0; ishift < 24; ishift++)
            {
                if (ishift.ToString().Length < 2)
                {
                    ListItem lst = new ListItem();
                    lst.Value = "0" + ishift.ToString() + "00";
                    ChkBxLstShiftTimePick.Items.Add(lst);
                    ListItem lst1 = new ListItem();
                    lst1.Value = "0" + ishift.ToString() + "30";
                    ChkBxLstShiftTimePick.Items.Add(lst1);
                    //ListItem lst2 = new ListItem();
                    //lst2.Value = "0" + ishift.ToString() + "30";
                    //ChkBxLstShiftTimePick.Items.Add(lst2);
                    //ListItem lst3 = new ListItem();
                    //lst3.Value = "0" + ishift.ToString() + "15";
                    //ChkBxLstShiftTimePick.Items.Add(lst3);
                }
                else
                {
                    ListItem lst = new ListItem();
                    lst.Value = ishift.ToString() + "00";
                    ChkBxLstShiftTimePick.Items.Add(lst);
                    ListItem lst1 = new ListItem();
                    lst1.Value = ishift.ToString() + "30";
                    ChkBxLstShiftTimePick.Items.Add(lst1);
                    //ListItem lst2 = new ListItem();
                    //lst2.Value = ishift.ToString() + "30";
                    //ChkBxLstShiftTimePick.Items.Add(lst2);
                    //ListItem lst3 = new ListItem();
                    //lst3.Value = ishift.ToString() + "15";
                    //ChkBxLstShiftTimePick.Items.Add(lst3);
                }
                ChkBxLstShiftTimePick.Items[ishift].Selected = false;
            }
            // For Drop        
            for (ishift = 0; ishift < 24; ishift++)
            {
                if (ishift.ToString().Length < 2)
                {
                    ListItem lst = new ListItem();
                    lst.Value = "0" + ishift.ToString() + "00";
                    ChkBxLstShiftTimeDrop.Items.Add(lst);
                    ListItem lst1 = new ListItem();
                    lst1.Value = "0" + ishift.ToString() + "30";
                    ChkBxLstShiftTimeDrop.Items.Add(lst1);
                    //ListItem lst2 = new ListItem();
                    //lst2.Value = "0" + ishift.ToString() + "30";
                    //ChkBxLstShiftTimeDrop.Items.Add(lst2);
                    //ListItem lst3 = new ListItem();
                    //lst3.Value = "0" + ishift.ToString() + "15";
                    //ChkBxLstShiftTimeDrop.Items.Add(lst3);
                }
                else
                {
                    ListItem lst = new ListItem();
                    lst.Value = ishift.ToString() + "00";
                    ChkBxLstShiftTimeDrop.Items.Add(lst);
                    ListItem lst1 = new ListItem();
                    lst1.Value = ishift.ToString() + "30";
                    ChkBxLstShiftTimeDrop.Items.Add(lst1);
                    //ListItem lst2 = new ListItem();
                    //lst2.Value = ishift.ToString() + "30";
                    //ChkBxLstShiftTimeDrop.Items.Add(lst2);
                    //ListItem lst3 = new ListItem();
                    //lst3.Value =ishift.ToString() + "15";
                    //ChkBxLstShiftTimeDrop.Items.Add(lst3);
                }
                ChkBxLstShiftTimeDrop.Items[ishift].Selected = false;
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
    protected void chkPick_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkPick.Checked == true)
            {
                foreach (ListItem lst in ChkBxLstShiftTimePick.Items)
                {
                    lst.Selected = true;
                }
            }
            else
            {
                foreach (ListItem lst in ChkBxLstShiftTimePick.Items)
                {
                    lst.Selected = false;
                }
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void chkDrop_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkDrop.Checked == true)
            {
                foreach (ListItem lst in ChkBxLstShiftTimeDrop.Items)
                {
                    lst.Selected = true;
                }
            }
            else
            {
                foreach (ListItem lst in ChkBxLstShiftTimeDrop.Items)
                {
                    lst.Selected = false;
                }
            }
        }
        catch (Exception ex)
        {
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
    public string Strip(string text)
    {
        text = text.Replace("\r\n", ",");
        text = text.Replace("\n", ",");
        text = text.Replace(" ", ",");
        text = text.Replace(",,", ",");
        text = text.Replace(";", ",");
        text = text.Replace("'", ",");
        return text;
    }
    protected void bindgrdEmployeeSchedule()
    {
        try
        {
            DateTime sDate = new DateTime();
            sDate = Convert.ToDateTime(DateTime.Now);
            string empIDs = Strip(txtEmpIDs.Text).Trim();

            grdEmployeeSchedule.DataSource = TmsDataContext.GetAdminSchedule(empIDs, sDate);
            grdEmployeeSchedule.DataBind();
            txtEmpIDs.Text = empIDs;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bindgrdEmployeeSchedule();
    }
    protected void lbtnSave_Click(object sender, EventArgs e)
    {
        //**************************************************//
        //Saves the shifttime into the DB //
        //**************************************************//
        try
        {
            {

                string sbpicktime = string.Empty;
                string sbdroptime = string.Empty;

                for (int j = 0; j < ChkBxLstShiftTimePick.Items.Count; j++)
                {
                    if (ChkBxLstShiftTimePick.Items[j].Selected == true)
                    {
                        sbpicktime = sbpicktime + ChkBxLstShiftTimePick.Items[j].Value.Trim() + ",";
                    }
                }
                if (sbpicktime == "")
                {
                    sbpicktime = "0";
                }
                sbpicktime = sbpicktime.Remove(sbpicktime.Length - 1, 1);

                for (int k = 0; k < ChkBxLstShiftTimePick.Items.Count; k++)
                {
                    if (ChkBxLstShiftTimeDrop.Items[k].Selected == true)
                    {
                        sbdroptime = sbdroptime + ChkBxLstShiftTimeDrop.Items[k].Value.Trim() + ",";
                    }
                }
                if (sbdroptime == "")
                {
                    sbdroptime = "0";
                }
                sbdroptime = sbdroptime.Remove(sbdroptime.Length - 1, 1);
                string processIds = string.Empty;
                string zoneNames = string.Empty;
                
                sbdroptime.Remove(0, sbdroptime.Length);
                sbpicktime.Remove(0, sbpicktime.Length);
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    public void alertPick()
    {
        foreach (ListItem listItem in ChkBxLstShiftTimePick.Items)
        {
            if (listItem.Selected)
            {
                PickUpList = "True";
            }
        }
    }
    public void alertDrop()
    {
        foreach (ListItem listItem in ChkBxLstShiftTimeDrop.Items)
        {
            if (listItem.Selected)
            {
                DropUpList = "True";
            }
        }
    }
    private void ShowMessage(string message)
    {
        try
        {
            string jScript = "alert('" + message + "');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void btnAssignShift_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid == true)
            {
        string empIds = string.Empty;
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
        if (empIds =="")
        {
            ShowMessage("Please select employee.");
        }
            alertPick();
            alertDrop();
            if (PickUpList == "False" || DropUpList == "False")
            {
                ShowMessage("Please select atleast one Pickup and Drop shift !!");
            }
            else
            {

                string sbpicktime = string.Empty;
                string sbdroptime = string.Empty;


                for (int j = 0; j < ChkBxLstShiftTimePick.Items.Count; j++)
                {
                    if (ChkBxLstShiftTimePick.Items[j].Selected == true)
                    {
                        sbpicktime = sbpicktime + ChkBxLstShiftTimePick.Items[j].Value.Trim() + ",";
                    }
                }
                if (sbpicktime == "")
                {
                    sbpicktime = "0";
                }
                sbpicktime = sbpicktime.Remove(sbpicktime.Length - 1, 1);

                for (int k = 0; k < ChkBxLstShiftTimePick.Items.Count; k++)
                {
                    if (ChkBxLstShiftTimeDrop.Items[k].Selected == true)
                    {
                        sbdroptime = sbdroptime + ChkBxLstShiftTimeDrop.Items[k].Value.Trim() + ",";
                    }
                }
                if (sbdroptime == "")
                {
                    sbdroptime = "0";
                }
                sbdroptime = sbdroptime.Remove(sbdroptime.Length - 1, 1);
                string Isweekend = chkIsWeekend.Checked == true ? "Weekend" : "Weekday";
                TmsDataContext.SprAssignShift(empIds, sbdroptime, sbpicktime, Isweekend, MyApplicationSession._UserID);
                ShowMessage("Shift assigned successfully to the selected employees.");
                BindShiftTimes();
                //bindgrdEmployeeSchedule();
                
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

}