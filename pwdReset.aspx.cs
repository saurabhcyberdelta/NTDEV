using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class pwdReset : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    employee emp = new employee();

    // Add property values to view state with set;
    // retrieve them from view state with get.
    public int _empId
    {
        get
        {
            return (int)ViewState["_empId"];
        }

        set
        {
            ViewState["_empId"] = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtEmpIdName.Focus();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //********************************************************************//
        //Call to function to bind Employee grid with the search Criteria    //
        //********************************************************************//
        if (txtEmpIdName.Text.ToString().Trim().Length > 0)
        {
            BndEmpGrid();

        }
        else
        {

            MultiView1.ActiveViewIndex = -1;
        }
    }
    public void BndEmpGrid()
    {
        //********************************************************************//
        //Bind the Employee grid with the with the search Criteria            //
        //********************************************************************//
        try
        {
            GvEmployee.DataSource = tms.EmpSearch(txtEmpIdName.Text, MyApplicationSession._LocationId, MyApplicationSession._ISAdmin);
            GvEmployee.DataBind();
            if (GvEmployee.Rows.Count < 1)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "No Record Found!!!";
                txtEmpIdName.Focus();
            }
            else
            {
                lblMsg.Visible = false;


            }
            MultiView1.ActiveViewIndex = 0;

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    protected void lbtnResetPwd_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow gvr = (GridViewRow)btn.NamingContainer;
        int rowindex = gvr.RowIndex;
        string empid = GvEmployee.DataKeys[rowindex].Value.ToString();
        tms.ResetPassword(Convert.ToInt32(empid), MyApplicationSession._UserID);
        ShowMessage("Password Reset Successfully");
        MultiView1.ActiveViewIndex = -1;
        txtEmpIdName.Text = "";
        txtEmpIdName.Focus();

    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }

    protected void GvEmployee_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GvEmployee.PageIndex = e.NewPageIndex;
        this.BndEmpGrid();
    }
}
