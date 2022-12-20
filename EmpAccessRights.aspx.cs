using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

public partial class EmpAccessRights : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    StringBuilder sbAccess = new StringBuilder();
    

    // Add property values to view state with set;
    // retrieve them from view state with get.
    public int _MenuId
    {
        get
        {
            return (int)ViewState["_MenuId"];
        }

        set
        {
            ViewState["_MenuId"] = value;
        }
    }
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

    public int _empgvindex
    {
        get
        {
            return (int)ViewState["_empgvindex"];
        }

        set
        {
            ViewState["_empgvindex"] = value;
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        tms.CommandTimeout = 0;
        if (!IsPostBack)
        {
            txtEmpIdName.Focus();
            bndDataListMenuAccessCount();
            
        }

    }

    public void BndMenuGrid()
    {
        //********************************************************************//
        //Bind the Menu grid with the Main Menu and the corresponding Sub Menu//
        //********************************************************************//
        try
        {
            MultiView1.ActiveViewIndex = 1;
            gvMenu.DataSource = tms.SelectMainMenu(MyApplicationSession._ISAdmin.ToString());
            gvMenu.DataBind();
            AddHeader();
            tms.CommandTimeout = 0;
            foreach (GridViewRow gvr in gvMenu.Rows)
            {
                int parentId = Convert.ToInt32(gvMenu.DataKeys[gvr.RowIndex].Value.ToString());

                GridView gvsub = (GridView)gvr.FindControl("gvSubMenu");
                gvsub.DataSource = tms.GetUserRights(_empId, parentId);//SelectSubMenu(parentId);
                gvsub.DataBind();
                foreach (GridViewRow row in gvsub.Rows)
                {
                    if (((CheckBox)row.FindControl("chkSubMenu")).Checked == true)
                        ((CheckBox)gvr.FindControl("chkMenu")).Checked = true;
                }
                gvsub.Visible = false;
                //int count = tms.GetUserRights(_empId).Count();
                //foreach (GridViewRow row in gvsub.Rows)
                //{
                //    for (int i = 0; i < count; i++)
                //    {
                //        if (gvsub.DataKeys[row.RowIndex].Value.ToString().Equals(tms.GetUserRights(_empId).ElementAtOrDefault(i).subMenuId.ToString()))
                //        {
                //            ((CheckBox)row.FindControl("chkSubMenu")).Checked = true;
                //            ((CheckBox)gvr.FindControl("chkMenu")).Checked = true;
                //            break;
                //        }
                //        else
                //        {
                //            ((CheckBox)row.FindControl("chkSubMenu")).Checked = false;
                //        }
                //    }
                //}
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }
    public void AddHeader()
    {
        //***********************************************************************************//
        //Bind the Menu grid with the Name of the Employee for whose the rights are Displayed//
        //**********************************************************************************//
        try
        {
            Label lbl = new Label();
            lbl.Text = "Edit Access Rights for " + ((Label)GvEmployee.Rows[_empgvindex].FindControl("lblEmpName")).Text;
            gvMenu.HeaderRow.Cells[0].Controls.Add(lbl);
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //********************************************//
        //Call The function to bind the Employee Grid//
        //******************************************//

        BndEmpGrid();
    }
    public void BndEmpGrid()
    {
        //*********************************************//
        //Bind the Employee grid with the Employee Data//
        //********************************************//
        try
        {
            MultiView1.ActiveViewIndex = 0;
            if (txtEmpIdName.Text.ToString().Trim().Length > 0)
            {
                string empIdName = txtEmpIdName.Text;
                GvEmployee.DataSource = tms.EmpSearch(empIdName, Convert.ToInt32(Session["LocationId"].ToString()),MyApplicationSession._ISAdmin);
                GvEmployee.DataBind();
                if (GvEmployee.Rows.Count < 1)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "No Record Found!!!";
                }
                else
                {
                    lblMsg.Visible = false;
                }

            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }

    }

    protected void gvMenu_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //********************************************************************//
        //Makes Sub Menu Visible/Invisible on click of plus/minus             //
        //********************************************************************//
        try
        {
            GridViewRow gvr = (GridViewRow)((ImageButton)e.CommandSource).NamingContainer;
            int rowindex = gvr.RowIndex;
            AddHeader();
            GridView gvsub = (GridView)gvr.FindControl("gvSubMenu");
            ImageButton imgEx = (ImageButton)gvr.FindControl("imgbtnExpand");
            ImageButton imgCl = (ImageButton)gvr.FindControl("imgbtnClose");
            if (e.CommandName.Equals("expand"))
            {
                imgCl.Visible = true;
                imgEx.Visible = false;

                gvsub.Visible = true;
            }
            else if (e.CommandName.Equals("close"))
            {
                gvsub.Visible = false;
                imgCl.Visible = false;
                imgEx.Visible = true;

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }

    protected void GvEmployee_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //********************************************************************//
        //Bind the Employee grid with the Next Page//
        //********************************************************************//
        try
        {
            GvEmployee.PageIndex = e.NewPageIndex;
            BndEmpGrid();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);
        }
    }

    protected void GvEmployee_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        //********************************************************************//
        //Bind the Menu grid for the selected employee in employee Grid//
        //********************************************************************//
        try
        {
            _empId = Convert.ToInt32(GvEmployee.DataKeys[e.NewSelectedIndex].Value.ToString());
            _empgvindex = e.NewSelectedIndex;
            BndMenuGrid();

            lblMsg.Text = string.Empty;

            lblSaveMsg.Visible = false;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }

    protected void chkMenu_CheckedChanged(object sender, EventArgs e)
    {
        //*******************************************************************************//
        //Checks/Unchecks the checkboxes of the submenu grid if user checke/Unchecks them//
        //*******************************************************************************//
        try
        {
            AddHeader();
            GridViewRow gvr = (GridViewRow)((CheckBox)sender).NamingContainer;
            int rowindex = gvr.RowIndex;
            GridView gvsub = (GridView)gvMenu.Rows[rowindex].FindControl("gvSubMenu");
            if (((CheckBox)gvr.FindControl("chkMenu")).Checked == true)
            {
                foreach (GridViewRow grow in gvsub.Rows)
                {

                    ((CheckBox)grow.FindControl("chkSubMenu")).Checked = true;


                }
            }
            else
            {

                foreach (GridViewRow row in gvsub.Rows)
                {

                    ((CheckBox)row.FindControl("chkSubMenu")).Checked = false;


                }
            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }



    protected void lbtnCancel_Click(object sender, EventArgs e)
    {

        lblSaveMsg.Visible = false;
        MultiView1.ActiveViewIndex = 0;
    }

    protected void lbtnUpdate_Click(object sender, EventArgs e)
    {
        //********************************************************************//
        //On Save Button Click Saves the Access Rights of an Employee        //
        //********************************************************************//
        try
        {
            sbAccess.Append("<root>");

            foreach (GridViewRow gvr in gvMenu.Rows)
            {
                GridView gvsub = (GridView)gvr.FindControl("gvSubMenu");
                foreach (GridViewRow row in gvsub.Rows)
                {
                    if (((CheckBox)row.FindControl("chkSubMenu")).Checked == true)
                    {
                        sbAccess.AppendFormat("<subMenu><subMenuId>{0}</subMenuId></subMenu>", gvsub.DataKeys[row.RowIndex].Value.ToString());
                    }
                }
            }

            sbAccess.Append("</root>");
            tms.SetUserRights(_empId, sbAccess.ToString(), MyApplicationSession._UserID);
            lblSaveMsg.Text = "Access Rights Saved";
            lblSaveMsg.Visible = true;

            MultiView1.ActiveViewIndex = 0;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }


    protected void lbTotalEmployee_Click(object sender, EventArgs e)
    {
        LinkButton lbTotalEmployee = sender as LinkButton;
        string info = lbTotalEmployee.CommandArgument;
        string[] arg = new string[2];
        char[] splitter = { ';' };
        arg = info.Split(splitter);
        _MenuId = Convert.ToInt32(arg[0]);
        MultiView1.ActiveViewIndex = 2;
        ModalPopupExtender108.Show();
        lblShowMenuItem.Text = arg[1];
        BndgrdMenuUsersDetails(_MenuId);
       

        
    }

    protected void BndgrdMenuUsersDetails(int MenuId)
    {
        grdMenuUsersDetails.DataSource = tms.GetMenuUsersDetails(MyApplicationSession._LocationId, MenuId);
        grdMenuUsersDetails.DataBind();
    }


    protected void grdMenuUsersDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        MultiView1.ActiveViewIndex = 2;
        grdMenuUsersDetails.PageIndex = e.NewPageIndex;
        BndgrdMenuUsersDetails(_MenuId);
        ModalPopupExtender108.Show();
       
    }
    protected void bndDataListMenuAccessCount()
    {
        try
        {
            DataListMenuAccessCount.DataSource = tms.GetMenuAccessDetails(MyApplicationSession._LocationId);
            DataListMenuAccessCount.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }


    protected void grdMenuUsersDetails_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
