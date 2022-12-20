using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminAdhoc : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                bndfacility();
                txtStartDate.Text = System.DateTime.Now.Date.ToString("MM/dd/yyyy");
            }
            catch (Exception ex)
            {
                ExceptionUtility.LogException(ex, "Catch Error");
                throw (ex);
            } 
        }


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
                ddlShift.DataSource = tms.GetShiftByFacilityType(Convert.ToInt32(ddlFacility.SelectedValue), "P");
                ddlShift.DataTextField = "shiftTime";
                ddlShift.DataValueField = "shiftTime";
                ddlShift.DataBind();
            }
            else
            {
                ddlShift.Items.Clear();
                ListItem li = new ListItem("--Select--", "0");
                ddlShift.Items.Add(li);
                ddlShift.DataSource = tms.GetShiftByFacilityType(Convert.ToInt32(ddlFacility.SelectedValue), "D");
                ddlShift.DataTextField = "shiftTime";
                ddlShift.DataValueField = "shiftTime";
                ddlShift.DataBind();
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void bndfacility()
    {
        try
        {
            ddlFacility.Items.Clear();
            ListItem liv = new ListItem("Select Facility", "0");
            ddlFacility.Items.Add(liv);
            ddlFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
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
    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndShiftddl();
    }
    protected void ddlTripType_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndShiftddl();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        AJX.Visible = true;

        bndgrids();
    }
    protected void bndgrids()
    {
        try
        {
            GrdEmployeePending.DataSource = tms.GetAdhocForAdmin(Convert.ToDateTime(txtStartDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), ddlTripType.SelectedValue, ddlShift.SelectedValue, "Pending");
            GrdEmployeePending.DataBind();
            GrdEmployeeAccepted.DataSource = tms.GetAdhocForAdmin(Convert.ToDateTime(txtStartDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), ddlTripType.SelectedValue, ddlShift.SelectedValue, "Approved");
            GrdEmployeeAccepted.DataBind();
            GrdEmployeeRejected.DataSource = tms.GetAdhocForAdmin(Convert.ToDateTime(txtStartDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), ddlTripType.SelectedValue, ddlShift.SelectedValue, "Rejected");
            GrdEmployeeRejected.DataBind();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
  
    protected void lbtnUpdate_Click1(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            int rowindex = gvr.RowIndex;
            string id = GrdEmployeePending.DataKeys[rowindex].Value.ToString(); ;
            dvShowDetail.DataSource = tms.getAdhocDetails(Convert.ToInt32(id));
            dvShowDetail.DataBind();
            dvShowDetail.Visible = true;
            ModalPopupExtender1.Show();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        ModalPopupExtender1.Hide();
    }
   
    protected void dvShowDetail_PageIndexChanging(object sender, DetailsViewPageEventArgs e)
    {

    }
    protected void btnUpdate_Click1(object sender, EventArgs e)
    {
        try
        {
            string id = dvShowDetail.DataKey["id"].ToString();
            DropDownList status = ((DropDownList)dvShowDetail.FindControl("ddlStatus"));
            tms.UpdateAdhocStatus(Convert.ToInt32(id), status.SelectedValue, MyApplicationSession._UserID, "Admin");
            ShowMessage("Status Updated Successfully");
            bndgrids();
            dvShowDetail.Visible = false;
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }

    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
}
