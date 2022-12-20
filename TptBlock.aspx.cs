using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TptBlock : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();

    public string _strStartdate
    {
        get
        {
            return (string)ViewState["_strStartdate"];
        }

        set
        {
            ViewState["_strStartdate"] = value;
        }
    }

    public string _strEndDate
    {
        get
        {
            return (string)ViewState["_strEndDate"];
        }

        set
        {
            ViewState["_strEndDate"] = value;
        }
    }

    public string _strFacilityID
    {
        get
        {
            return (string)ViewState["_strFacilityID"];
        }

        set
        {
            ViewState["_strFacilityID"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            lblMsg.Text = "";
            lblMsgU.Text = "";
            gvEmpDetail.Visible = false;
            if (!IsPostBack)
            {
                //txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                //txtEndDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                BndFacilityDropdown();
                BndMonthDropdown();
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    public void BndFacilityDropdown()
    {
        try
        {
            ddlFacility.Items.Clear();
            ListItem liv = new ListItem("-Select Facility-", "0");
            ddlFacility.Items.Add(liv);
            ddlFacility.DataSource = tmscontext.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlFacility.DataTextField = "facilityName";
            ddlFacility.DataValueField = "Id";
            ddlFacility.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    public void BndMonthDropdown()
    {
        try
        {
            ddlMonth.Items.Clear();
            ListItem liv = new ListItem("-Select Month-", "0");
            ddlMonth.Items.Add(liv);
            ListItem liv1 = new ListItem(DateTime.Today.ToString("MMMM") + ", " + DateTime.Today.Year.ToString(), DateTime.Today.Date.ToString());
            ddlMonth.Items.Add(liv1);
            ListItem liv2 = new ListItem(DateTime.Today.AddMonths(-1).ToString("MMMM") + ", " + DateTime.Today.AddMonths(-1).Year.ToString(), DateTime.Today.AddMonths(-1).Date.ToString());
            ddlMonth.Items.Add(liv2);
            ddlMonth.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        BndGvEmpDetail();
        gvEmpDetail.Visible = true;
    }

    private void BndGvEmpDetail()
    {
        try
        {
            _strFacilityID = ddlFacility.SelectedValue;
            CalculateDate();
            gvEmpDetail.DataSource = tmscontext.GetNoShowCountData(Convert.ToDateTime(_strStartdate), Convert.ToDateTime(_strEndDate), Convert.ToInt32(_strFacilityID), "P");
            gvEmpDetail.DataBind();
            if (gvEmpDetail.Rows.Count > 0)
                btnSave.Visible = true;
            else
                btnSave.Visible = false;

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    private void BndGvEmpDetailUnblock()
    {
        try
        {

            gvEmpDetailUnblock.DataSource = tmscontext.GetBlockedTptData();
            gvEmpDetailUnblock.DataBind();
            if (gvEmpDetailUnblock.Rows.Count > 0)
                btnUnblock.Visible = true;
            else
                btnUnblock.Visible = false;

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }


    private void CalculateDate()
    {
        _strStartdate = Convert.ToDateTime(Convert.ToDateTime(ddlMonth.SelectedValue).Month.ToString() + "/01/" + Convert.ToDateTime(ddlMonth.SelectedValue).Year.ToString()).ToString();
        _strEndDate = Convert.ToDateTime(_strStartdate).AddMonths(1).AddDays(-1).ToString();
    }
    protected void gvEmpDetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvEmpDetail.PageIndex = e.NewPageIndex;
        BndGvEmpDetail();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid == true)
            {

                string empIds = string.Empty;
                int empcount = 0;
                gvEmpDetail.Visible = true;
                foreach (GridViewRow i in gvEmpDetail.Rows)
                {
                    CheckBox cb = (CheckBox)i.FindControl("chkSelect");
                    if (cb != null && cb.Checked)
                    {
                        empIds = empIds + gvEmpDetail.DataKeys[i.RowIndex]["ID"].ToString() + ",";
                        empcount = empcount + 1;
                    }
                }
                empIds = empIds.Remove(empIds.Length - 1, 1);
                tmscontext.UpdateBlockUnBlock(empIds, MyApplicationSession._UserID.ToString(), "Block");
                lblMsg.Text = empcount + " Employee's Transport Blocked !";

                string[] strSplitArr = empIds.Split(',');

                foreach (string arrStr in strSplitArr)
                {
                    string empMail = "";
                    string empName = "";
                    string mgrEmail = "";
                    var result = tmscontext.GetEmployeeEmail(arrStr);
                    foreach (var result1 in result)
                    {
                        empMail = result1.empEmail;
                        mgrEmail = result1.mgremail;
                        empName = result1.empName;
                    }

                    string message = "<p class='MsoNormal'>";
                    message += "<span style='font-size: 10.0pt; font-family: &quot; arial&quot; ,&quot; sans-serif&quot;'>";
                    message += "Dear "+ empName +",<br />";
                    message += "Your TMS roaster has been blocked.";
                    message += "</p>";
                    message += "<p>";
                    message += "<span style='font-size: 10.0pt; font-family: &quot; arial&quot; ,&quot; sans-serif&quot;'>";
                    message += "Thank you for your help in keeping our transport services accurate.</span>";
                    message += "</p>";
                    message += "<div align='center' class='MsoNormal'>";
                    message += "<hr align='center' size='2' width='100%' />";
                    message += "</div>";
                    message += "<p>";
                    message += "<span style='font-size: 10.0pt; font-family: &quot; arial&quot; ,&quot; sans-serif&quot;'>";
                    message += "This is a system generated e-mail. Please do not respond. Please contact Transport";
                    message += " Department for any questions.</span>";
                    message += "<o:p>";
                    message += "</o:p>";
                    message += "</p>";
                    message += "<div align='center' class='MsoNormal'>";
                    message += "<hr align='center' size='2' width='100%' />";
                    message += "</div>";
                    message += "<p class='MsoNormal'>";
                    message += "<span style='font-size: 7.5pt; font-family: &quot; arial&quot; ,&quot; sans-serif&quot;'>";
                    message += "<br />";
                    message += "The information contained in this e-mail and any accompanying documents may contain information that is confidential or otherwise protected from disclosure. If you are not the intended recipient of this message, or if this message has been addressed";
                    message += " to you in error, please immediately alert the sender by reply e-mail and then delete this message, including any attachments. Any dissemination, distribution or other use of the contents of this message by anyone other than the intended recipient";
                    message += " is strictly prohibited. All messages sent to and from this e-mail address may be monitored as permitted by applicable law and regulations to ensure compliance with our internal policies and to protect our business. E-mails are not secure and cannot";
                    message += " be guaranteed to be error free as they can be intercepted, amended, lost or destroyed, or contain viruses. You are deemed to have accepted these risks if you communicate with us by e-mail. </span>";
                    message += "</p>";

                    SendMailHelper.SendMailMessage("Asia-Pacific SRM Mailbox@hewitt.com", empMail, "", mgrEmail, "Test: Transport Blocked", message);
                }

                BndGvEmpDetail();
            }
            else
            {
                gvEmpDetail.Visible = true;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void btnShowBlock_Click(object sender, EventArgs e)
    {
        pnlForBlock.Visible = true;
        pnlForUnBlock.Visible = false;
        BndFacilityDropdown();
        BndMonthDropdown();
        //if (ddlFacility.SelectedValue != "0" && ddlMonth.SelectedValue != "0")
        //    BndGvEmpDetail();

        btnShowBlock.Visible = false;
        btnShowUnblock.Visible = false;


    }
    protected void btnShowUnblock_Click(object sender, EventArgs e)
    {
        pnlForBlock.Visible = false;
        pnlForUnBlock.Visible = true;
        BndGvEmpDetailUnblock();
        btnShowBlock.Visible = false;
        btnShowUnblock.Visible = false;
    }
    protected void btnUnblock_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {

            string empIds = string.Empty;
            int empcount = 0;
            foreach (GridViewRow i in gvEmpDetailUnblock.Rows)
            {
                CheckBox cb = (CheckBox)i.FindControl("chkSelect");
                if (cb != null && cb.Checked)
                {
                    empIds = empIds + gvEmpDetailUnblock.DataKeys[i.RowIndex]["ID"].ToString() + ",";
                    empcount = empcount + 1;
                }
            }
            empIds = empIds.Remove(empIds.Length - 1, 1);
            tmscontext.UpdateBlockUnBlock(empIds, MyApplicationSession._UserID.ToString(), "Unblock");
            lblMsgU.Text = empcount + " Employee's Transport Un-Blocked !";
            BndGvEmpDetailUnblock();
        }

    }
    protected void gvEmpDetailUnblock_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvEmpDetailUnblock.PageIndex = e.NewPageIndex;
        BndGvEmpDetailUnblock();

    }
    protected void btnclose_Click(object sender, EventArgs e)
    {
        btnShowBlock.Visible = true;
        btnShowUnblock.Visible = true;
        pnlForBlock.Visible = false;
        pnlForUnBlock.Visible = false;
    }

    public void CheckAll(object sender, EventArgs e)
    {
        try
        {
            CheckBox cb = (CheckBox)sender;
            if (cb.Checked == true)
                ToggleCheckState(true);
            else
                ToggleCheckState(false);
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
            gvEmpDetail.Visible = true;
            foreach (GridViewRow i in gvEmpDetail.Rows)
            {
                // Access the CheckBox
                CheckBox cb = (CheckBox)i.FindControl("chkSelect");
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
    public void CheckAll2(object sender, EventArgs e)
    {
        try
        {
            CheckBox cb = (CheckBox)sender;
            if (cb.Checked == true)
                ToggleCheckState2(true);
            else
                ToggleCheckState2(false);
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    private void ToggleCheckState2(bool checkState)
    {
        try
        {
            foreach (GridViewRow i in gvEmpDetailUnblock.Rows)
            {
                // Access the CheckBox
                CheckBox cb = (CheckBox)i.FindControl("chkSelect");
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
            foreach (GridViewRow i in gvEmpDetail.Rows)
            {
                // Access the CheckBox
                CheckBox cb = (CheckBox)i.FindControl("chkSelect");
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

    public void CustomValidatorCheckBox_ServerValidate2(Object source, ServerValidateEventArgs args)
    {
        try
        {
            bool checkstate = false;
            foreach (GridViewRow i in gvEmpDetailUnblock.Rows)
            {
                // Access the CheckBox
                CheckBox cb = (CheckBox)i.FindControl("chkSelect");
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

}
