using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManageMenu : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    Menu m = new Menu();

    // Add property values to view state with set;
    // retrieve them from view state with get.
    public int _parentid
    {
        get
        {
            return (int)ViewState["_parentid"];
        }

        set
        {
            ViewState["_parentid"] = value;
        }
    }

    public string _parentmenu
    {
        get
        {
            return (string)ViewState["_parentmenu"];
        }

        set
        {
            ViewState["_parentmenu"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Visible = false;
        if (!IsPostBack)
        {
            BndMainMenuGrid();
        }
    }
    public void BndMainMenuGrid()
    {
        //**************************************************//
        //Binds the main menu grid with the mainmenu from DB//
        //**************************************************//
        try
        {
            GVMenu.DataSource = tms.SelectMainMenu(MyApplicationSession._ISAdmin.ToString());
            GVMenu.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }

    }

    protected void GVMenu_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GVMenu.EditIndex = e.NewEditIndex;
        BndMainMenuGrid();
    }

    protected void GVMenu_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //***********************************//
        //Updates the Main menu into the DB  //
        //***********************************//
        try
        {
            m.Text = ((TextBox)GVMenu.Rows[e.RowIndex].FindControl("txtMenuText")).Text;
            m.Description = ((TextBox)GVMenu.Rows[e.RowIndex].FindControl("txtMenuDescription")).Text;
            m.MenuID = Convert.ToInt32(GVMenu.DataKeys[e.RowIndex].Value.ToString());
            string result = tms.UpdateMenu(m.Text, Server.HtmlEncode(m.Description), m.ParentID, m.NavigateUrl, m.MenuID).ElementAtOrDefault(0).result.Value.ToString();
            if (result.Equals("0"))
            {
                lblMsg.Text = "Menu Name Already Exists!!!";
                lblMsg.Visible = true;
            }
            else
            {
                lblMsg.Visible = true;
                GVMenu.EditIndex = -1;
                BndMainMenuGrid();
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }


    protected void GVMenu_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GVMenu.EditIndex = -1;
        BndMainMenuGrid();
    }

    protected void GVMenu_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GVMenu.PageIndex = e.NewPageIndex;
        BndMainMenuGrid();
    }
    public void BndSubMenuGrid(int _parentid)
    {
        //**************************************************//
        //Binds the Submenu grid for selected parnet menu   //
        //**************************************************//
        try
        {
            GVSubMenu.DataSource = tms.SelectSubMenu(_parentid);
            GVSubMenu.DataBind();

            if (GVSubMenu.Rows.Count < 1)
            {
                MultiView1.ActiveViewIndex = 1;
                lblMainMenu.Text = "No Sub Menu Under " + _parentmenu.ToString();
                lblMainMenu.Visible = true;
                BndDvDropDown();

                ((TextBox)DVSubMenu.FindControl("txtdvSubMenuText")).Text = string.Empty;
                ((TextBox)DVSubMenu.FindControl("txtdvSubMenuDescription")).Text = string.Empty;

                ((TextBox)DVSubMenu.FindControl("txtdvNavigateUrl")).Text = string.Empty;

            }
            else
            {
                lblMainMenu.Text = "Sub Menu Under " + _parentmenu.ToString();
                lblMainMenu.Visible = true;
                MultiView1.ActiveViewIndex = 0;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }
    public void BndDvDropDown()
    {
        //******************************************//
        //Binds dropdowns of submenu detailsview  //
        //*****************************************//
        try
        {
            DropDownList ddl = (DropDownList)DVSubMenu.FindControl("ddldvParentMenu");
            ddl.DataSource = tms.SelectMainMenu(MyApplicationSession._ISAdmin.ToString());
            ddl.DataTextField = "Text";
            ddl.DataValueField = "MenuId";
            ddl.DataBind();
            ddl.SelectedIndex = ddl.Items.IndexOf(ddl.Items.FindByValue(_parentid.ToString()));
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }

    }

    protected void GVMenu_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        //************************************************************************************//
        //For the Selected menu in menu grid, binds Submenu grid//
        //**********************************************************************************//
        try
        {
            MultiView1.ActiveViewIndex = 0;
            _parentid = Convert.ToInt32(GVMenu.DataKeys[e.NewSelectedIndex].Value.ToString());


            _parentmenu = ((Label)GVMenu.Rows[e.NewSelectedIndex].FindControl("lblMenuText")).Text;
            lblMainMenu.Text = "Sub Menu Under " + _parentmenu.ToString();
            GVMenu.EditIndex = -1;
            BndMainMenuGrid();
            lblMainMenu.Visible = true;
            GVSubMenu.EditIndex = -1;
            BndSubMenuGrid(_parentid);
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void DVSubMenu_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        //**********************************************//
        //Saves Submenu under a parent menu in the DB  //
        //*********************************************//
        try
        {
            m.Text = ((TextBox)DVSubMenu.FindControl("txtdvSubMenuText")).Text;
            m.Description = ((TextBox)DVSubMenu.FindControl("txtdvSubMenuDescription")).Text;
            m.ParentID = Convert.ToInt32(((DropDownList)DVSubMenu.FindControl("ddldvParentMenu")).SelectedValue);
            m.NavigateUrl = ((TextBox)DVSubMenu.FindControl("txtdvNavigateUrl")).Text;
            string result = tms.InsertMenu(m.Text, Server.HtmlEncode(m.Description), m.ParentID, m.NavigateUrl).ElementAtOrDefault(0).result.Value.ToString();
            if (result.Equals("0"))
            {
                lblMsg.Text = "Sub Menu Item Already Exists";
                lblMsg.Visible = true;
            }
            else
            {
                lblMsg.Text = "Sub Menu Item Added Successfully.";
                lblMsg.Visible = true;
                BndSubMenuGrid(_parentid);
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void DVSubMenu_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        //************************************************************//
        //Changes view index On Click of cancel in Dv Sub menu city //
        //***********************************************************//
        try
        {
            if (e.Cancel == true || e.CancelingEdit == true)
            {
                lblMsg.Visible = false;
                BndSubMenuGrid(_parentid);
                if (GVSubMenu.Rows.Count < 1)
                {
                    MultiView1.ActiveViewIndex = -1;
                    lblMainMenu.Visible = false;
                }
                else
                {
                    MultiView1.ActiveViewIndex = 0;

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

    protected void DVMenu_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        //**************************** //
        //Saves Menu Item in the DB   //
        //***************************//
        try
        {
            m.Text = ((TextBox)DVMenu.FindControl("txtdvMenuText")).Text;
            m.Description = ((TextBox)DVMenu.FindControl("txtdvMenuDescription")).Text;

            m.NavigateUrl = string.Empty;
            string result = tms.InsertMenu(m.Text, Server.HtmlEncode(m.Description), m.ParentID, m.NavigateUrl).ElementAtOrDefault(0).result.Value.ToString();
            if (result.Equals("0"))
            {
                lblMsg.Text = "Menu Item Already Exists";
                lblMsg.Visible = true;
            }
            else
            {
                lblMsg.Text = "Menu Name Added Successfully!!!";
                lblMsg.Visible = true;
                
                ((TextBox)DVMenu.FindControl("txtdvMenuText")).Text = string.Empty;
                ((TextBox)DVMenu.FindControl("txtdvMenuDescription")).Text = string.Empty;
                MultiView1.ActiveViewIndex = -1;
                BndMainMenuGrid();

            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void DVMenu_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.Cancel == true || e.CancelingEdit == true)
        {
            MultiView1.ActiveViewIndex = -1;
            lblMainMenu.Visible = false;
        }
    }

    protected void lbtnNewParentMenu_Click(object sender, EventArgs e)
    {
        //************************************************************************************//
        //Opens the Detailsview to add new menu Item to the DB//
        //**********************************************************************************//
        try
        {
            MultiView1.ActiveViewIndex = 2;
            GVMenu.EditIndex = -1;
            BndMainMenuGrid();
            lblMainMenu.Visible = false;
            ((TextBox)DVMenu.FindControl("txtdvMenuText")).Text = string.Empty;
            ((TextBox)DVMenu.FindControl("txtdvMenuDescription")).Text = string.Empty;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void lbtnNewSubMenu_Click(object sender, EventArgs e)
    {
        //************************************************************************************//
        //Opens the Detailsview to add new Sub-menu Item to the DB//
        //**********************************************************************************//
        try
        {
            MultiView1.ActiveViewIndex = 1;
            DVSubMenu.Visible = true;
            ((TextBox)DVSubMenu.FindControl("txtdvSubMenuText")).Text = string.Empty;
            ((TextBox)DVSubMenu.FindControl("txtdvSubMenuDescription")).Text = string.Empty;

            ((TextBox)DVSubMenu.FindControl("txtdvNavigateUrl")).Text = string.Empty;
            BndDvDropDown();
            lblMainMenu.Visible = false;
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void GVSubMenu_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //*********************************//
        //Updates SubMenu Item into the DB//
        //********************************//

        try
        {
            m.Text = ((TextBox)GVSubMenu.Rows[e.RowIndex].FindControl("txtSubMenuText")).Text;
            m.Description = ((TextBox)GVSubMenu.Rows[e.RowIndex].FindControl("txtSubMenuDescription")).Text;
            m.NavigateUrl = ((TextBox)GVSubMenu.Rows[e.RowIndex].FindControl("txtNavigateUrl")).Text;
            m.ParentID = Convert.ToInt32(((DropDownList)GVSubMenu.Rows[e.RowIndex].FindControl("ddlParentMenu")).SelectedValue);

            m.MenuID = Convert.ToInt32(GVSubMenu.DataKeys[e.RowIndex].Value.ToString());
            string result = tms.UpdateMenu(m.Text, Server.HtmlEncode(m.Description), m.ParentID, m.NavigateUrl, m.MenuID).ElementAtOrDefault(0).result.Value.ToString();
            if (result.Equals("0"))
            {
                lblMsg.Text = "Menu Name Already Exists!!!";
                lblMsg.Visible = true;
            }
            else
            {
                lblMsg.Visible = true;
                GVSubMenu.EditIndex = -1;
                BndSubMenuGrid(_parentid);
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void GVSubMenu_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //*********************************************//
        //Opens the Gridview for editing the Submenu  //
        //********************************************//
        try
        {
            GVSubMenu.EditIndex = e.NewEditIndex;
            string parent = ((Label)GVSubMenu.Rows[e.NewEditIndex].FindControl("lblParentMenu")).Text;
            BndSubMenuGrid(_parentid);
            DropDownList ddl = (DropDownList)GVSubMenu.Rows[e.NewEditIndex].FindControl("ddlParentMenu");
            ddl.Items.Clear();
            ddl.DataSource = tms.SelectMainMenu(MyApplicationSession._ISAdmin.ToString());
            ddl.DataTextField = "Text";
            ddl.DataValueField = "MenuID";
            ddl.DataBind();


            ddl.SelectedIndex = ddl.Items.IndexOf(ddl.Items.FindByText(parent.ToString()));
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void GVSubMenu_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //*************************************//
        //Deltes a sub-menu item from the DB // 
        //************************************//
        try
        {
            m.MenuID = Convert.ToInt32(GVSubMenu.DataKeys[e.RowIndex].Value.ToString());
            tms.DeleteMenu(m.MenuID);
            BndSubMenuGrid(_parentid);
            GVSubMenu.DataBind();

            lblMsg.Text = "Sub Menu Deleted successfully!!!";
            lblMsg.Visible = true;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void GVSubMenu_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        try
        {
            GVSubMenu.EditIndex = -1;

            BndSubMenuGrid(_parentid);
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void GVSubMenu_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            GVSubMenu.PageIndex = e.NewPageIndex;
            BndSubMenuGrid(_parentid);
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void GVMenu_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }

}
