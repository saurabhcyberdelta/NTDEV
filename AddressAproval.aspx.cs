using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddressAproval : System.Web.UI.Page
{
    public int _Adressid
    {
        get
        {
            return (int)ViewState["_Adressid"];
        }

        set
        {
            ViewState["_Adressid"] = value;
        }
    }
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
            txtEndDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
            BndDropdown();

        }

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        lblErrorMsg.Visible = false;
        bindgrid();
    }
    protected void bindgrid()
    {
       
        gvStatus.DataSource = tms.getAddressChangestatus(Convert.ToDateTime(txtStartDate.Text), Convert.ToDateTime(txtEndDate.Text), ddlStatus.SelectedValue, Convert.ToInt32(ddlFacility.SelectedValue));
        gvStatus.DataBind();
        if (gvStatus.Rows.Count > 0)
        {
            lbtnPrintExcel.Visible = true;
        }
        else
        {
            lbtnPrintExcel.Visible = false;
        }
        if (ddlStatus.SelectedValue == "")
        {

        }
        else if (ddlStatus.SelectedValue == "P")
        {
            for (int i = 0; i < gvStatus.Rows.Count; i++)
            {
                ((LinkButton)gvStatus.Rows[i].FindControl("lbtnApprove")).Visible = true;
                ((LinkButton)gvStatus.Rows[i].FindControl("lbtnReject")).Visible = true;
                ((Label)gvStatus.Rows[i].FindControl("lblRemark")).Visible = false;
            }
        }
        else
        {
            for (int i = 0; i < gvStatus.Rows.Count; i++)
            {
                ((LinkButton)gvStatus.Rows[i].FindControl("lbtnApprove")).Visible = false;
                ((LinkButton)gvStatus.Rows[i].FindControl("lbtnReject")).Visible = false;
                ((Label)gvStatus.Rows[i].FindControl("lblRemark")).Visible = true;
            }

        }
    }
    public void BndDropdown()
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
    protected void lbtnApprove_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;


            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
             int rowindex = gvr.RowIndex;
             string id = gvStatus.DataKeys[rowindex].Value.ToString();
             string res=tms.ApproveAddressRequest(Convert.ToInt32(id), MyApplicationSession._UserID).ElementAtOrDefault(0).Result.ToString();
             lblErrorMsg.Visible = true;
             lblErrorMsg.Text = res;
             ShowMessage(res);
             bindgrid();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void lbtnReject_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;


        GridViewRow gvr = (GridViewRow)btn.NamingContainer;
        int rowindex = gvr.RowIndex;
        string id = gvStatus.DataKeys[rowindex].Value.ToString();
        _Adressid = Convert.ToInt32(id);
        MultiView1.ActiveViewIndex = 0;
        ModalPopupExtender1.Show();
        pnlRaise.Visible = true;
        txtReason.Text = string.Empty;

    }
    protected void btnAccept_Click(object sender, EventArgs e)
    {
        string res = tms.CancelAddressRequest(_Adressid, MyApplicationSession._UserID, txtReason.Text).ElementAtOrDefault(0).Result.ToString();
        lblErrorMsg.Visible = true;
        lblErrorMsg.Text = res;
        ShowMessage(res);
        bindgrid();
    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
    protected void lbtnPrintExcel_Click(object sender, EventArgs e)
    {
        GridViewExportUtil.Export("AddressChange.xls", gvStatus);
    }
}
