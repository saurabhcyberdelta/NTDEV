using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdhocRequest : basepage2
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
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
        if (!IsPostBack)
        {
            try
            {
                string strReq = "";
                string[] arrIndMsg = null;
                strReq = Request.RawUrl;
                strReq = strReq.Substring(strReq.IndexOf('?') + 1);
                strReq = new EncryptQueryString().Decrypt(strReq);
                string[] arrMsgs = strReq.Split('&');
                string triptype = null;
                string seldate=null;

                if (arrMsgs.Length == 2)
                {
                    arrIndMsg = arrMsgs[0].Split('=');
                    if (arrIndMsg.Length > 1)
                    {
                        triptype = arrIndMsg[1].ToString().Trim();
                    }
                    else
                    {
                        triptype = "";
                    }
                    arrIndMsg = arrMsgs[1].Split('=');
                    if (arrIndMsg.Length > 1)
                    {
                        seldate = arrIndMsg[1].ToString().Trim();
                    }
                    else
                    {
                        seldate = "";
                    }
                }
                _SpocID = MyApplicationSession._UserID;
                txtStartDate.Text = Convert.ToDateTime(seldate).ToString("MM/dd/yyyy");
                txtStartDate.Enabled = false;
                ibcal1.Visible = false;
                

                bindgrdEmployeeSchedule();
                BndEmpAdhoc(MyApplicationSession._UserID, Convert.ToDateTime("1/12/2012"), Convert.ToDateTime("1/12/2012"));
                ddlTripType.SelectedIndex = ddlTripType.Items.IndexOf(ddlTripType.Items.FindByValue(triptype.ToString()));
                ddlTripType.Enabled = false;
                bndfacility();
                bndShiftddl();
            }
            catch (Exception ex)
            {
                // Log the exception and notify system operators
                ExceptionUtility.LogException(ex, "Catch Error");
                throw (ex);
            }
        }
    }
    protected void ddlFacility1_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndShiftddl();

    }
    protected void bndShiftddl()
    {
        try
        {
            if (ddlTripType.SelectedValue == "P")
            {
                ddlShift.Items.Clear();
                ListItem li = new ListItem("--Select--", "0");
                ddlShift.Items.Add(li);
                ddlShift.DataSource = tms.getpickshiftAdhoc(Convert.ToInt32(ddlFacility1.SelectedValue), Convert.ToDateTime(txtStartDate.Text));
                ddlShift.DataTextField = "shiftTime";
                ddlShift.DataValueField = "shiftTime";
                ddlShift.DataBind();
            }
            else
            {
                ddlShift.Items.Clear();
                ListItem li = new ListItem("--Select--", "0");
                ddlShift.Items.Add(li);
                ddlShift.DataSource = tms.getdropshiftadhoc(Convert.ToInt32(ddlFacility1.SelectedValue), Convert.ToDateTime(txtStartDate.Text));
                ddlShift.DataTextField = "shiftTime";
                ddlShift.DataValueField = "ShiftValue";
                ddlShift.DataBind();
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void ddlTripType_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndShiftddl();

    }

    protected void bndfacility()
    {
        try
        {
            ddlFacility1.Items.Clear();
            ListItem liv = new ListItem("Select Facility", "0");
            ddlFacility1.Items.Add(liv);
            ddlFacility1.DataSource = tms.getfacilityforunsched();
            ddlFacility1.DataTextField = "facilityName";
            ddlFacility1.DataValueField = "Id";
            ddlFacility1.DataBind();
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
            grdEmployeeSchedule.DataSource = tms.getemployeeforadhoc(_SpocID);

            //grdEmployeeSchedule.DataSource = tms.getMgrAssociateAdhoc(_SpocID,Convert.ToDateTime(txtStartDate.Text),ddlTripType.SelectedValue.ToString());
            grdEmployeeSchedule.DataBind();

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string empIds = string.Empty;
            int count = 0;
            // string fromDate, toDate, facilityIn, facilityOut, logIn, logOut, WeeklyOff = "";
            //var result = 0;
            foreach (GridViewRow i in grdEmployeeSchedule.Rows)
            {
                CheckBox cb = (CheckBox)i.FindControl("chkBxEmpId");
                if (cb != null && cb.Checked)
                {
                    count = count + 1;
                    Label lbl = (Label)i.FindControl("EmpID");
                    empIds = empIds + lbl.Text.Trim() + ",";
                }
            }

            if (count == 0)
            {
                ShowMessage("Please Select Partner");
            }
            else
            {
                //  1.Emplyee request already made<br/>2.Shift is locked<br/>3.Employee Address Not geocoded
                empIds = empIds.Remove(empIds.Length - 1, 1);
                GridView GridView1 = new GridView();
                GridView1.DataSource = tms.AddAdhocRequest(empIds, Convert.ToInt32(ddlFacility1.SelectedValue), ddlShift.SelectedItem.ToString(), ddlTripType.SelectedValue, _SpocID, Convert.ToDateTime(txtStartDate.Text));
                GridView1.DataBind();
                if (GridView1.Rows.Count > 0)
                {
                    ShowMessage(" Request not updated as:" + "\\n" + " 1.Partner request already made. " + "\\n" + "Please Cancel Your last request" + " \\n" + " 3.Only one request at a time");
                    lblMessage.ForeColor = System.Drawing.Color.Red;

                }
                else
                {
                    lblMessage.Text = "Your Aligned unscheduled request would be arranged. Thank you";
                    lblMessage.ForeColor = System.Drawing.Color.Red;

                    BndEmpAdhoc(MyApplicationSession._UserID, Convert.ToDateTime("1/12/2012"), Convert.ToDateTime("1/12/2012"));


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
    protected void txtStartDate_TextChanged(object sender, EventArgs e)
    {
       
        bndShiftddl();
        // bindgrdEmployeeSchedule();
    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
    protected void btncancel_Click(object sender, EventArgs e)
    {

    }
    protected void btnClose_Click(object sender, ImageClickEventArgs e)
    {


        bindgrdEmployeeSchedule();
    }
    protected void BndEmpAdhoc(int empId, DateTime sDate, DateTime eDate)
    {
        try
        {

            GVAdhoc.DataSource = tms.SelectEmpAdhocRequest(empId, sDate, eDate, "All");
            GVAdhoc.DataBind();

        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected Boolean enableds(object strArg,object strag1)
    {
        try
        {
            string val = Convert.ToString(strArg);
            string action = Convert.ToString(strag1);

            if (val == "0" || action=="1")
            {
                return false;
            }
            else
            {
                return true;
            }

        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void lbtnUpdate_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;


        GridViewRow gvr = (GridViewRow)btn.NamingContainer;


        int rowindex = gvr.RowIndex;
        String id = GVAdhoc.DataKeys[rowindex][0].ToString();
        tms.DeleteAdhoc(id);
        BndEmpAdhoc(MyApplicationSession._UserID, Convert.ToDateTime("1/12/2012"), Convert.ToDateTime("1/12/2012"));

    }
    protected void GVAdhoc_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GVAdhoc.PageIndex = e.NewPageIndex;
        BndEmpAdhoc(MyApplicationSession._UserID, Convert.ToDateTime("1/12/2012"), Convert.ToDateTime("1/12/2012"));

    }
}
