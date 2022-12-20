using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Data;
using Microsoft.VisualBasic;

public partial class SystemSetting : basepage
{
    DataClasses1DataContext ds = new DataClasses1DataContext();
    String configname;
    protected void Page_Load(object sender, EventArgs e)
    {
        lbl_error.Text = "";
        if (!IsPostBack)
        {
            if (ddlFacility != null)
            {
                ddlFacility.DataSource = ds.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
                ddlFacility.DataTextField = "facilityName";
                ddlFacility.DataValueField = "Id";
                ddlFacility.DataBind();
                ListItem liFacIn = new ListItem("-Select Facility-", "0");
                ddlFacility.Items.Insert(0, liFacIn);

                ddlFacility.SelectedIndex = ddlFacility.Items.IndexOf(ddlFacility.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));
            }
            BindGrid();
        }
    }
    protected void BindGrid()
    {
        grdSysSettings.DataSource = ds.GetConfiguration(Convert.ToInt32(ddlFacility.SelectedValue));
        grdSysSettings.DataBind();
        
    }
    protected void grdSysSettings_RowEditing(object sender, GridViewEditEventArgs e)
    {
        grdSysSettings.EditIndex = e.NewEditIndex;
        BindGrid();
    }
    protected void grdSysSettings_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        String Errmsg;
        int f = 1;
        Label lblConfigName = (Label)grdSysSettings.Rows[e.RowIndex].FindControl("lbl_ConfigName");
        configname = lblConfigName.Text;
        TextBox textvalue = (TextBox)grdSysSettings.Rows[e.RowIndex].FindControl("Txt_configValue");
        TextBox textDescription = (TextBox)grdSysSettings.Rows[e.RowIndex].FindControl("Txt_description");
        String value = textvalue.Text;
        String Description = textDescription.Text;


        String getdt = ds.GetRegex(configname, Convert.ToInt32(ddlFacility.SelectedValue)).ElementAtOrDefault(0).Regex.ToString();
        Regex rg = new Regex(getdt);

        Match s = rg.Match(value);
        if (!s.Success)
        {
            f = 0;
            Errmsg = ds.GetRegex(configname, Convert.ToInt32(ddlFacility.SelectedValue)).ElementAtOrDefault(0).ErrMessages.ToString();
            textvalue.BackColor = System.Drawing.Color.Yellow;
            textvalue.Focus();
            String Script = "<script>alert(" + "'" + Errmsg + "'" + ");</script>";
            Page.RegisterStartupScript("errmsg", Script);
            lbl_error.Text = Errmsg;
        }

        if (f == 1)
        {
            lbl_error.Text = "";
            ds.AddSetting(configname, value, Description, Convert.ToInt32(ddlFacility.SelectedValue));
            grdSysSettings.EditIndex = -1;
            BindGrid();
        }


    }
    protected void grdSysSettings_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        lbl_error.Text = "";
        grdSysSettings.EditIndex = -1;
        BindGrid();
    }
    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }
    protected void Grid1_UpdateCommand(object sender, Obout.Grid.GridRecordEventArgs e)
    {

    }
    protected void grdSysSettings_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdSysSettings.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}
