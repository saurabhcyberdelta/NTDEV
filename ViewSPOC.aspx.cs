using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewSPOC : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    static string spocCode = string.Empty;
    static string empIdName = string.Empty;
    static string empId = string.Empty;
    static int userId = 0;
    static string spocName = string.Empty;
    static int locationId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        userId = MyApplicationSession._UserID;
        locationId = Convert.ToInt32(Session["LocationId"].ToString());
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtEmpIdName.Text.ToString().Trim().Length > 0)
            {
                empIdName = txtEmpIdName.Text;
                BndSPOCGrid();
            }
            else
            {

                MultiView1.ActiveViewIndex = -1;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);
        }
    }

    public void BndSPOCGrid()
    {
        //*************************************************************//
        //Binds SPOC grid with the searc criteria    //
        //*************************************************************//
        try
        {

            gvSPOC.DataSource = tms.EmpSearch(txtEmpIdName.Text, MyApplicationSession._LocationId,MyApplicationSession._ISAdmin);
            gvSPOC.DataBind();
            if (gvSPOC.Rows.Count < 1)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "No Record Found!!!";
            }
            else
            {
                lblMsg.Visible = false;
                txtEmpIdName.Text = string.Empty;


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

    protected void gvSPOC_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvSPOC.PageIndex = e.NewPageIndex;
        BndSPOCGrid();
    }

    protected void gvSPOC_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        try
        {
            empId = gvSPOC.DataKeys[e.NewSelectedIndex].Value.ToString();

            spocName = ((Label)gvSPOC.Rows[e.NewSelectedIndex].FindControl("lblEmpName")).Text;
            BndSPOCDetailGrid();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);
        }
    }
    public void BndSPOCDetailGrid()
    {
        //*************************************************************//
        //Binds the vendor grid with the vendor list in the DB       //
        //*************************************************************//
        try
        {
            gvSPOCDetails.DataSource = tms.GetEmpSpoc(empId);
            gvSPOCDetails.DataBind();

            if (gvSPOCDetails.Rows.Count < 1)
            {
                lblMsg.Visible = true;
                MultiView1.ActiveViewIndex = 0;
                lblMsg.Text = "No SPOC Assigned for " + spocName;

            }
            else
            {
                lblMsg.Visible = false;
                MultiView1.ActiveViewIndex = 1;
                lblSpocName.Text = "SPOC assigned for " + spocName.ToString();
            }


        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }

    }

    protected void gvSPOCDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvSPOC.PageIndex = e.NewPageIndex;
        BndSPOCDetailGrid();
    }

    protected void gvSPOCDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.Equals("close"))
        {
            MultiView1.ActiveViewIndex = 0;

        }
    }
}

