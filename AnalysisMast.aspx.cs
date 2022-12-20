using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AnalysisMast : basepage
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
        grdManager.DataSource = ds.getAnalysis();
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
        ds.deleteAnalysis(Convert.ToInt32(id));
        BindGrid();
    }

    protected void lbtn_AddTemplate_Click(object sender, EventArgs e)
    {
        txtEmpIdName.Text = string.Empty;
       
        MultiView1.ActiveViewIndex = 1;

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //********************************************************************//
        //Call to function to bind Employee grid with the search Criteria    //
        //********************************************************************//

        ds.AddAnalysis(txtEmpIdName.Text);
        ShowMessage("Analysis Added successfully");
        MultiView1.ActiveViewIndex = 0;
        BindGrid();
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
        ds.deleteAnalysis(Convert.ToInt32(id));
        BindGrid();
    }
}
