using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

public partial class ShiftTimeMaster : basepage
{
    DataClasses1DataContext TmsDataContext = new DataClasses1DataContext();

    shiftTime s = new shiftTime();

    public string _addval
    {
        get { return (string)ViewState["_addval"]; }
        set { ViewState["_addval"] = value; }
    }

    public string _editval
    {
        get { return (string)ViewState["_editval"]; }
        set { ViewState["_editval"] = value; }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                BndGridShift();
                if (gvShiftTime.Rows.Count < 1)
                {
                    mvShiftTime.ActiveViewIndex = 1;
                    lblMsg.Visible = false;
                    BndDvDropDown();
                }
                BndDropDown();
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }

    }
    public void BndDvDropDown()
    {

        //**************************************************//
        //Binds Facility Dropdown in shift time Detailsview //
        //**************************************************//
        try
        {

            DropDownList dlfac = (DropDownList)dvShiftTimeAdd.FindControl("ddlFacilityAdd");
            ListItem lifac = new ListItem("Select Facility", "0");
            dlfac.Items.Clear();
            dlfac.Items.Add(lifac);
            dlfac.DataSource = TmsDataContext.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            dlfac.DataTextField = "facilityName";
            dlfac.DataValueField = "Id";
            dlfac.DataBind();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }

    }
    public void BndDropDown()
    {

        //**************************************************//
        //Binds Facility and process Dropdown //
        //**************************************************//
        try
        {
            ListItem facli = new ListItem("All", "0");
            ddlFacilitySort.Items.Clear();
            ddlFacilitySort.Items.Add(facli);
            ddlFacilitySort.DataSource = TmsDataContext.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlFacilitySort.DataTextField = "facilityName";
            ddlFacilitySort.DataValueField = "Id";
            ddlFacilitySort.DataBind();            
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }
    protected void lbtnAddNew_Click(object sender, EventArgs e)
    {
        //**************************************************//
        //Opens detailview to add new shift time      //
        //**************************************************//
        try
        {
            mvShiftTime.ActiveViewIndex = 1;
            lblMsg.Visible = false;
            ((TextBox)dvShiftTimeAdd.FindControl("txtShiftTimeAdd")).Text = string.Empty;
            ((TextBox)dvShiftTimeAdd.FindControl("txtBuffer")).Text = string.Empty;


            DropDownList dlfac = (DropDownList)dvShiftTimeAdd.FindControl("ddlFacilityAdd");
            ListItem lifac = new ListItem("Select Facility", "0");
            dlfac.Items.Clear();
            dlfac.Items.Add(lifac);
            DataClasses1DataContext TmsDataContext = new DataClasses1DataContext();
            dlfac.DataSource = TmsDataContext.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            dlfac.DataTextField = "facilityName";
            dlfac.DataValueField = "Id";
            dlfac.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    public void BndGridShift()
    {

        //**************************************************//
        //Binds Shift Grid    //
        //**************************************************//
        try
        {
            int facid = Convert.ToInt32(ddlFacilitySort.SelectedValue);
            gvShiftTime.DataSource = TmsDataContext.GetSelectedShiftTime(facid);
            gvShiftTime.DataBind();            
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }

    }

    protected void gvShiftTime_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvShiftTime.PageIndex = e.NewPageIndex;
        BndGridShift();
    }





    protected void dvShiftTimeAdd_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.CancelingEdit == true)
        {

            mvShiftTime.ActiveViewIndex = 0;
            lblMsg.Visible = false;
            gvShiftTime.EditIndex = -1;
            BndGridShift();
        }
    }

    protected void dvShiftTimeAdd_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        //**************************************************//
        //Saves Shift Time details into the DB           //
        //**************************************************//
        try
        {
            s.shiftTime1 = ((TextBox)dvShiftTimeAdd.FindControl("txtShiftTimeAdd")).Text;
            s.facilityId = Convert.ToInt32(((DropDownList)dvShiftTimeAdd.FindControl("ddlFacilityAdd")).SelectedValue);
            if (((RadioButton)dvShiftTimeAdd.FindControl("rdbtndvWeekday")).Checked == true)
            {
                s.weekDay = '0';
            }
            else if (((RadioButton)dvShiftTimeAdd.FindControl("rdbtndvWeekEnd")).Checked == true)
            {

                s.weekDay = '1';

            }
            else { s.weekDay = '2'; }

            if (((RadioButton)dvShiftTimeAdd.FindControl("rdbtndvPick")).Checked == true)
            {
                s.shiftType = 'P';
            }
            else if (((RadioButton)dvShiftTimeAdd.FindControl("rdbtndvDrop")).Checked == true)
            {

                s.shiftType = 'D';

            }
            else { s.shiftType = 'B'; }


            string buffer = ((TextBox)dvShiftTimeAdd.FindControl("txtBuffer")).Text;
            _addval = TmsDataContext.AddShiftTime(Server.HtmlEncode(s.shiftTime1), s.facilityId, s.shiftType, s.weekDay,Convert.ToInt32(buffer)).ElementAtOrDefault(0).result.Value.ToString();
            if (_addval.Equals("0"))
            {
                lblMsg.Text = "ShiftTime Already Exists!!!";
                lblMsg.Visible = true;

            }
            else
            {
                mvShiftTime.ActiveViewIndex = 0;
                gvShiftTime.EditIndex = -1;
                BndGridShift();
                
                lblMsg.Visible = false;
            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }


    }

    protected void gvShiftTime_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //**************************************************//
        //Updates Shift Time Details into the DB        //
        //**************************************************//
        try
        {

            s.shiftTime1 = ((TextBox)gvShiftTime.Rows[e.RowIndex].FindControl("txtShiftTime")).Text;
            s.facilityId = Convert.ToInt32(((DropDownList)gvShiftTime.Rows[e.RowIndex].FindControl("ddlFacility")).SelectedValue);
            s.Id = Convert.ToInt32(gvShiftTime.DataKeys[e.RowIndex].Value.ToString());
            if (((RadioButton)gvShiftTime.Rows[e.RowIndex].FindControl("rdbtnWeekday")).Checked == true)
            {
                s.weekDay = '0';
            }
            else if (((RadioButton)gvShiftTime.Rows[e.RowIndex].FindControl("rdbtnWeekEnd")).Checked == true)
            {

                s.weekDay = '1';

            }
            else { s.weekDay = '2'; }
            if (((RadioButton)gvShiftTime.Rows[e.RowIndex].FindControl("rdbtnPick")).Checked == true)
            {
                s.shiftType = 'P';
            }
            else if (((RadioButton)gvShiftTime.Rows[e.RowIndex].FindControl("rdbtnDrop")).Checked == true)
            {

                s.shiftType = 'D';

            }
            string buffer = ((TextBox)gvShiftTime.Rows[e.RowIndex].FindControl("txtBuffer")).Text;
           
            _editval = TmsDataContext.UpdateShiftTime(Server.HtmlEncode(s.shiftTime1), s.facilityId, s.weekDay, s.shiftType, s.Id,Convert.ToInt32(buffer)).ElementAtOrDefault(0).result.Value.ToString();
            if (_editval.Equals("0"))
            {
                lblMsg.Text = "ShiftTime Already Exists!!!";
                lblMsg.Visible = true;

            }
            else
            {
                gvShiftTime.EditIndex = -1;
                BndGridShift();
            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }
    public void BindShiftTimes()
    {
        //**********************************************************************
        // Create a list of ShiftTimes for PickUp and Drop starting from 0000 hrs to 2130hrs
        //**********************************************************************
        try
        {
            mvShiftTime.ActiveViewIndex = 2;
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
                }
                else
                {
                    ListItem lst = new ListItem();
                    lst.Value = ishift.ToString() + "00";
                    ChkBxLstShiftTimePick.Items.Add(lst);
                    ListItem lst1 = new ListItem();
                    lst1.Value = ishift.ToString() + "30";
                    ChkBxLstShiftTimePick.Items.Add(lst1);
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
                }
                else
                {
                    ListItem lst = new ListItem();
                    lst.Value = ishift.ToString() + "00";
                    ChkBxLstShiftTimeDrop.Items.Add(lst);
                    ListItem lst1 = new ListItem();
                    lst1.Value = ishift.ToString() + "30";
                    ChkBxLstShiftTimeDrop.Items.Add(lst1);
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
    protected void gvShiftTime_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //**************************************************//
        //Opens Shift TIme Grid in edit mode   //
        //**************************************************//
        try
        {
            string FacilityVal = ((Label)gvShiftTime.Rows[e.NewEditIndex].FindControl("lblFacilityName")).Text;
            gvShiftTime.EditIndex = e.NewEditIndex;

            BndGridShift();
            DataClasses1DataContext TmsDataContextext = new DataClasses1DataContext();
            DropDownList ddlFacility = (DropDownList)gvShiftTime.Rows[e.NewEditIndex].FindControl("ddlFacility");

            ddlFacility.DataSource = TmsDataContextext.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlFacility.DataTextField = "facilityName";
            ddlFacility.DataValueField = "Id";
            ddlFacility.DataBind();
            ddlFacility.SelectedIndex = ddlFacility.Items.IndexOf(ddlFacility.Items.FindByText(FacilityVal.ToString()));
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }


    }


    protected void gvShiftTime_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvShiftTime.EditIndex = -1;
        BndGridShift();
        lblMsg.Visible = false;
    }

    protected void ddlFacilitySort_SelectedIndexChanged(object sender, EventArgs e)
    {
        //**************************************************//
        //For Selected Facility,binds process Dropdown//
        //**************************************************//
        try
        {
            BndGridShift();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void ddlProcessSort_SelectedIndexChanged(object sender, EventArgs e)
    {
        BndGridShift();
    }

    protected void gvShiftTime_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //**************************************************//
        //deletes Shift time from DB    //
        //**************************************************//
        try
        {
            int id = Convert.ToInt32(gvShiftTime.DataKeys[e.RowIndex].Value.ToString());
            TmsDataContext.DeleteShiftTime(id);
            BndGridShift();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }

    }


    protected void lbtnAddNewGrid_Click(object sender, EventArgs e)
    {
        //**************************************************//
        //On click of add new grid //
        //**************************************************//
        try
        {
            BindShiftTimes();
            BndLstFacility();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void ChkBxLstShiftTimeDrop_Validate(object source, ServerValidateEventArgs args)
    {
        //**************************************************//
        //Validates selection in the checkbox list of drop time //
        //**************************************************//
        try
        {
            int counter = 0;
            for (int i = 0; i < ChkBxLstShiftTimeDrop.Items.Count; i++)
            {
                if (ChkBxLstShiftTimeDrop.Items[i].Selected)
                {
                    counter++;
                }
                args.IsValid = (counter == 0) ? false : true;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void ChkBxLstShiftTimePick_Validate(object source, ServerValidateEventArgs args)
    {
        //**************************************************//
        //Validates selection in the checkbox list of Pick time //
        //**************************************************//
        try
        {
            int counter = 0;
            for (int i = 0; i < ChkBxLstShiftTimePick.Items.Count; i++)
            {
                if (ChkBxLstShiftTimePick.Items[i].Selected)
                {
                    counter++;
                }

                args.IsValid = (counter == 0) ? false : true;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }
    public void BndLstFacility()
    {
        //**************************************************//
        //Binds Facility Listbox //
        //**************************************************//
        try
        {
            ListItem li = new ListItem("Select Facility", "0");

            ddlFacilityGrid.Items.Clear();
            ddlFacilityGrid.Items.Add(li);
            ddlFacilityGrid.DataSource = TmsDataContext.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlFacilityGrid.DataTextField = "facilityName";
            ddlFacilityGrid.DataValueField = "Id";
            ddlFacilityGrid.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }


    }

    protected void lbtnSave_Click(object sender, EventArgs e)
    {
        //**************************************************//
        //Saves the shifttime into the DB //
        //**************************************************//
        try
        {
            StringBuilder sbpicktime = new StringBuilder();
            StringBuilder sbdroptime = new StringBuilder();
            if (Page.IsValid == true)
            {
                s.facilityId = Convert.ToInt32(ddlFacilityGrid.SelectedValue.ToString());

                sbpicktime.Append("<root>");
                for (int j = 0; j < ChkBxLstShiftTimePick.Items.Count; j++)
                {

                    if (ChkBxLstShiftTimePick.Items[j].Selected == true)
                    {

                        sbpicktime.AppendFormat("<shift><picktime>{0}</picktime></shift>", ChkBxLstShiftTimePick.Items[j].Value.ToString());

                    }


                }
                sbpicktime.Append("</root>");

                sbdroptime.Append("<root>");
                for (int k = 0; k < ChkBxLstShiftTimePick.Items.Count; k++)
                {

                    if (ChkBxLstShiftTimeDrop.Items[k].Selected == true)
                    {

                        sbdroptime.AppendFormat("<shift><droptime>{0}</droptime></shift>", ChkBxLstShiftTimeDrop.Items[k].Value.ToString());

                    }


                }
                sbdroptime.Append("</root>");
                if (rdbtnWeek.Checked == true)
                {

                    s.weekDay = '0';
                }
                else
                {
                    s.weekDay = '1';

                }
                TmsDataContext.UpdateShiftTimeGrid(s.facilityId, sbdroptime.ToString(), sbpicktime.ToString(), s.weekDay);
                sbdroptime.Remove(0, sbdroptime.Length);
                sbpicktime.Remove(0, sbpicktime.Length);

                mvShiftTime.ActiveViewIndex = 0;
                BndDropDown();
                BndGridShift();
                
            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void lbtnClose_Click(object sender, EventArgs e)
    {
        mvShiftTime.ActiveViewIndex = 0;
    }
}

