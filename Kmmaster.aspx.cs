using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Kmmaster : basepage
{
    DataClasses1DataContext ds = new DataClasses1DataContext();
    
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
                MultiView1.ActiveViewIndex = 0;
            }
            BindGrid();
        }
    }
    protected void BindGrid()
    {
        grdkmTemplate.DataSource = ds.GetKmTemplate(Convert.ToInt32(ddlFacility.SelectedValue));
        grdkmTemplate.DataBind();

    }
    protected void grdkmTemplate_RowEditing(object sender, GridViewEditEventArgs e)
    {
        grdkmTemplate.EditIndex = e.NewEditIndex;
        BindGrid();
    }
    protected void grdkmTemplate_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
      
        TextBox Txt_Location = (TextBox)grdkmTemplate.Rows[e.RowIndex].FindControl("Txt_Location");

       
        TextBox Txt_Kmdistance = (TextBox)grdkmTemplate.Rows[e.RowIndex].FindControl("Txt_Kmdistance");
        Label lbl_Facility = (Label)grdkmTemplate.Rows[e.RowIndex].FindControl("lbl_Facility");
        string id = grdkmTemplate.DataKeys[e.RowIndex].Value.ToString();
        lbl_error.Text = "";
            ds.UpdatekmTemplate(Txt_Location.Text,"",Convert.ToInt32(Txt_Kmdistance.Text),Convert.ToInt32(id));
            grdkmTemplate.EditIndex = -1;
            BindGrid();
        

    }
    protected void grdkmTemplate_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        lbl_error.Text = "";
        grdkmTemplate.EditIndex = -1;
        BindGrid();
    }
    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }
    protected void Grid1_UpdateCommand(object sender, Obout.Grid.GridRecordEventArgs e)
    {

    }
    protected void grdkmTemplate_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdkmTemplate.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void grdkmTemplate_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string id = grdkmTemplate.DataKeys[e.RowIndex].Value.ToString();
        ds.DeletekmTemplate(Convert.ToInt32(id));
        BindGrid();
    }
    protected void dvInsertKM_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        TextBox txtLocation = (TextBox)dvInsertKM.FindControl("txtLocation");
        
        TextBox txtDistance = (TextBox)dvInsertKM.FindControl("txtDistance");
        DropDownList ddlfac = (DropDownList)dvInsertKM.FindControl("ddlFacility");
       string flag= ds.AddkmTemplate(txtLocation.Text,"", Convert.ToInt32(txtDistance.Text), Convert.ToInt32(ddlFacility.SelectedValue)).ElementAtOrDefault(0).Result.ToString(); ;
       lbl_error.Text = flag;
       lbl_error.Visible = true;
       MultiView1.ActiveViewIndex = 0;
        BindGrid();
    }
    protected void lbtn_AddTemplate_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
        DropDownList ddlfac = (DropDownList)dvInsertKM.FindControl("ddlFacility");

        ddlfac.DataSource = ds.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
        ddlfac.DataTextField = "facilityName";
        ddlfac.DataValueField = "Id";
        ddlfac.DataBind();
        ListItem liFacIn = new ListItem("-Select Facility-", "0");
        ddlfac.Items.Insert(0, liFacIn);
        TextBox txtLocation = (TextBox)dvInsertKM.FindControl("txtLocation");
       
        TextBox txtDistance = (TextBox)dvInsertKM.FindControl("txtDistance");
        txtLocation.Text = String.Empty;
      
        txtDistance.Text = string.Empty;
       

    }
    protected void dvInsertKM_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.CancelingEdit == true || e.Cancel == true)
        {
            MultiView1.ActiveViewIndex = 0;
            
            BindGrid();
        }
    }
    protected void LinkButton4_Click(object sender, EventArgs e)
    {
        GridView Gridview1 = new GridView();
        Gridview1.DataSource = ds.GetKmTemplate(Convert.ToInt32(ddlFacility.SelectedValue));
        Gridview1.DataBind();
        GridViewExportUtil.Export("Kmmaster.xls", Gridview1);
        

    }
}
