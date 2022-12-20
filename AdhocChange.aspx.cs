using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdhocChange : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BndChangeAdhoc(MyApplicationSession._UserID);
        }
    }

    protected void BndChangeAdhoc(int mgrId)
    {
        try
        {
            GVAdhocChange.DataSource = tms.SelectChangeAdhoc(mgrId);
            GVAdhocChange.DataBind();
            if (GVAdhocChange.Rows.Count < 1)
            {
                lblErrorMsg.Text = "No Record Found!";
                lblErrorMsg.Visible = true;
            }

        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }


    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string id = dvShowDetail.DataKey["id"].ToString();
        DropDownList status = ((DropDownList)dvShowDetail.FindControl("ddlStatus"));
        tms.UpdateAdhocStatus(Convert.ToInt32(id), status.SelectedValue, MyApplicationSession._UserID, "Manager");
        BndChangeAdhoc(MyApplicationSession._UserID);
    }
    protected void GVAdhocChange_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GVAdhocChange.PageIndex = e.NewPageIndex;
        BndChangeAdhoc(MyApplicationSession._UserID);
    }
    
    protected void GVAdhocChange_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        try
        {
            int AdId = Convert.ToInt32(GVAdhocChange.DataKeys[e.NewSelectedIndex].Value.ToString());
            dvShowDetail.DataSource = tms.SelectAdhocById(AdId);
            dvShowDetail.DataBind();
            ModalPopupExtender1.Show();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void btnClose_Click(object sender, ImageClickEventArgs e)
    {
        ModalPopupExtender1.Hide();
    }
}
