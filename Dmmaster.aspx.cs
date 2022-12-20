using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dmmaster : basepage
{

    DataClasses1DataContext ds = new DataClasses1DataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
        lbl_error.Text = "";
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            BindGrid();
        }
    }
    protected void BindGrid()
    {
        grdManager.DataSource = ds.GetdvManagerList(MyApplicationSession._LocationId);
        grdManager.DataBind();

    }


    protected void grdManager_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdManager.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void grdManager_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string id = grdManager.DataKeys[e.RowIndex].Value.ToString();
        ds.DeletekmTemplate(Convert.ToInt32(id));
        BindGrid();
    }

    protected void lbtn_AddTemplate_Click(object sender, EventArgs e)
    {
       // txtEmpIdName.Text = string.Empty;
        GvEmployee.DataSource = null;
        GvEmployee.DataBind();
        MultiView1.ActiveViewIndex = 1;
        bnddropdowns();


    }
    protected void bnddropdowns()
    {
        ddlDM.Items.Clear();
        ddlDM.DataSource = ds.getAllEmployee();
        ddlDM.DataValueField = "id";
        ddlDM.DataTextField = "empdetails";
        ddlDM.DataBind();

        ddlreportee.Items.Clear();
        ddlreportee.DataSource = ds.getAllEmployee();
        ddlreportee.DataValueField = "id";
        ddlreportee.DataTextField = "empdetails";
        ddlreportee.DataBind();

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //********************************************************************//
        //Call to function to bind Employee grid with the search Criteria    //
        //********************************************************************//
        ds.adddmmanager(Convert.ToInt32(ddlreportee.SelectedValue), Convert.ToInt32(ddlDM.SelectedValue));
        ShowMessage("Division Manager Added successfully");
        MultiView1.ActiveViewIndex = 0;
        BindGrid();


    }
   
    protected void GvEmployee_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        int empId = Convert.ToInt32(GvEmployee.DataKeys[e.NewSelectedIndex].Value.ToString());
        string res = ds.addManager(empId).ElementAtOrDefault(0).Result.ToString();
        if (res == "1")
        {
            ShowMessage("Manager Updated Successfully");
        }
        else
        {
            ShowMessage("Manager Name Already exists");
        }
        MultiView1.ActiveViewIndex = 0;
        BindGrid();

    }
    protected void GvEmployee_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //********************************************************************//
        // Employee grid with the Next Page Index Selected                   //
        //********************************************************************//
        try
        {
            GvEmployee.PageIndex = e.NewPageIndex;
           // BndEmpGrid();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }

    }

    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
    protected void LinkButton3_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow gvr = (GridViewRow)btn.NamingContainer;
        int rowindex = gvr.RowIndex;
        string id = grdManager.DataKeys[rowindex].Value.ToString();
        ds.deletedm(Convert.ToInt32(id));
        BindGrid();
        ShowMessage("Division Manager deleted Successfully");
    }
}
