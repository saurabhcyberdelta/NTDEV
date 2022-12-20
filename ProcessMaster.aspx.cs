using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ProcessMaster : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    process p = new process();
    SubProcess sp = new SubProcess();
    // Add property values to view state with set;
    // retrieve them from view state with get.
    public int _processId
    {
        get
        {
            return (int)ViewState["_processId"];
        }

        set
        {
            ViewState["_processId"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = string.Empty;
        lblMsg.Visible = false;
        if (!IsPostBack)
        {
            BndGridProcess();
        }

    }
    public void BndGridProcess()
    {
        //*************************************************//
        //Binds Process Grids with the Process List in DB//
        //**********************************************//
        try
        {
            gvProcess.DataSource = tms.GetProcess(Convert.ToInt32(Session["LocationId"].ToString()));
            gvProcess.DataBind();
            if (gvProcess.Rows.Count < 1)
            {
                mvProcess.ActiveViewIndex = 1;
                //BndDvDropDown();
                ClearFields();
            }
            else { mvProcess.ActiveViewIndex = -1; }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void dvProcess_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {

        //**********************************//
        //Saves Process details into the DB  //
        //*********************************//
        try
        {
            p.processName = ((TextBox)dvProcess.FindControl("txtdvProcessName")).Text;
            //p.facilityId = Convert.ToInt32(((DropDownList)dvProcess.FindControl("ddldvFacility")).SelectedValue.ToString());
            string val = tms.AddProcess(p.processName).ElementAtOrDefault(0).result.Value.ToString();
            if (val.Equals("0"))
            {
                lblMsg.Text = "Process Already Exists!!!";
                lblMsg.Visible = true;
            }
            else
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Process Added Succesfuly!!";
                mvProcess.ActiveViewIndex = 0;
                BndGridProcess();
            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void dvProcess_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.CancelingEdit == true || e.Cancel == true)
        {
            mvProcess.ActiveViewIndex = -1;
            lblMsg.Text = string.Empty;
        }
    }

    protected void lbtnAddNew_Click(object sender, EventArgs e)
    { //**************************************//
        //Opens Detailview to add new process//
        //**********************************//
        try
        {
            mvProcess.ActiveViewIndex = 1;
            //BndDvDropDown();
            ClearFields();
            lblMsg.Text = string.Empty;
            lblMsg.Visible = false;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }

    }
    //public void BndDvDropDown()
    //{
    //    //**********************************************//
    //    //Binds Facility dropdown in process Detailview//
    //    //********************************************//
    //    try
    //    {
    //        DropDownList ddlfac = (DropDownList)dvProcess.FindControl("ddldvFacility");
    //        ddlfac.Items.Clear();
    //        ListItem li = new ListItem("Select Facillity", "0");
    //        ddlfac.Items.Add(li);
    //        ddlfac.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
    //        ddlfac.DataTextField = "facilityName";
    //        ddlfac.DataValueField = "Id";
    //        ddlfac.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        // Log the exception and notify system operators
    //        ExceptionUtility.LogException(ex, "Catch Error");
    //        throw (ex);
    //    }
    //}

    public void ClearFields()
    {
        ((TextBox)dvProcess.FindControl("txtdvProcessName")).Text = string.Empty;
    }

    protected void gvProcess_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        try
        {
            _processId = Convert.ToInt32(gvProcess.DataKeys[e.NewSelectedIndex].Value.ToString());
            BndGridSubProcess();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    public void BndGridSubProcess()
    {
        //**************************************************//
        //Binds the Sub Process grid related to the process //
        //**************************************************//
        try
        {
            gvSubProcess.DataSource = tms.GetSubProcess(_processId);
            gvSubProcess.DataBind();
            if (gvSubProcess.Rows.Count < 1)
            {
                mvProcess.ActiveViewIndex = 2;
                BndSubDvDropDown();
            }
            else
            {
                mvProcess.ActiveViewIndex = 0;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }

    }
    public void BndSubDvDropDown()
    {

        //*************************************************//
        //Binds process dropdown of subprocess Detailview  //
        //***********************************************//
        try
        {
            DropDownList ddlpr = (DropDownList)dvSubProcess.FindControl("ddldvProcess");
            ddlpr.Items.Clear();
            ListItem lipr = new ListItem("Select Process", "0");
            ddlpr.Items.Add(lipr);
            ddlpr.DataSource = tms.GetProcess(Convert.ToInt32(Session["LocationId"].ToString()));
            ddlpr.DataTextField = "ProcessName";
            ddlpr.DataValueField = "Id";
            ddlpr.DataBind();
            ddlpr.SelectedIndex = ddlpr.Items.IndexOf(ddlpr.Items.FindByValue(_processId.ToString()));
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }

    }

    protected void dvSubProcess_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        mvProcess.ActiveViewIndex = -1;

    }

    protected void gvProcess_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //**********************************//
        //Updates process details into the DB//
        //*********************************//
        try
        {
            //p.facilityId = Convert.ToInt32(((DropDownList)gvProcess.Rows[e.RowIndex].FindControl("ddlFacility")).SelectedValue);
            p.processName = ((TextBox)gvProcess.Rows[e.RowIndex].FindControl("txtProcessName")).Text;
            p.Id = Convert.ToInt32(gvProcess.DataKeys[e.RowIndex].Value.ToString());
            string result = tms.UpdateProcess(p.Id,Server.HtmlEncode(p.processName)).ElementAtOrDefault(0).result.Value.ToString();
            if (result.Equals("0"))
            {
                lblMsg.Text = "Process Already Exists!!!";
                lblMsg.Visible = true;
                mvProcess.ActiveViewIndex = -1;
            }
            else
            {
                lblMsg.Visible = true;
                gvProcess.EditIndex = -1;
                mvProcess.ActiveViewIndex = 0;
                BndGridProcess();
            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void gvProcess_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //***************************************//
        //Opens the Process Grid in Editing Mode //
        //**************************************//
        try
        {
            gvProcess.EditIndex = e.NewEditIndex;
            BndGridProcess();
            //string fac = ((Label)gvProcess.Rows[e.NewEditIndex].FindControl("lblFacility")).Text;
            //int index = e.NewEditIndex;
            //BndGvProcessDrop(index);
            //DropDownList ddlfac = (DropDownList)gvProcess.Rows[e.NewEditIndex].FindControl("ddlFacility");
            //ddlfac.SelectedIndex = ddlfac.Items.IndexOf(ddlfac.Items.FindByText(fac.ToString()));
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    public void BndGvProcessDrop(int index)
    {
        //*********************************************//
        //Binds facility dropdown of process gridview  //
        //********************************************//
        try
        {
            DropDownList ddlfac = (DropDownList)gvProcess.Rows[index].FindControl("ddlFacility");
            ddlfac.Items.Clear();
            ListItem li = new ListItem("Select Facillity", "0");
            ddlfac.Items.Add(li);
            ddlfac.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlfac.DataTextField = "facilityName";
            ddlfac.DataValueField = "Id";
            ddlfac.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }

    }

    protected void gvProcess_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvProcess.EditIndex = -1;
        BndGridProcess();
    }

    protected void gvProcess_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvProcess.PageIndex = e.NewPageIndex;
        BndGridProcess();
    }

    protected void dvSubProcess_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        //*************************************//
        //Saves Sub-process details into the DB//
        //************************************//
        try
        {
            sp.processId = Convert.ToInt32(((DropDownList)dvSubProcess.FindControl("ddldvProcess")).SelectedValue);
            sp.subProcessName = ((TextBox)dvSubProcess.FindControl("txtdvSubProcess")).Text;
            string result = tms.InsertSubProcess(sp.processId,Server.HtmlEncode(sp.subProcessName)).ElementAtOrDefault(0).result.Value.ToString();
            if (result.Equals("0"))
            {
                lblMsg.Text = "Sub-Process Already Exists!!!";
                lblMsg.Visible = true;

            }
            else
            {

                lblMsg.Visible = false;


                mvProcess.ActiveViewIndex = 0;
                BndGridSubProcess();
            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void lbtnNewSubProcess_Click(object sender, EventArgs e)
    {
        mvProcess.ActiveViewIndex = 2;
        BndSubDvDropDown();
        ((TextBox)dvSubProcess.FindControl("txtdvSubProcess")).Text = string.Empty;
    }

    protected void gvSubProcess_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //*****************************************//
        //Updates Sub-Process details into the DB//
        //**************************************//
        try
        {
            int id = Convert.ToInt32(gvSubProcess.DataKeys[e.RowIndex].Value.ToString());
            sp.processId = _processId;
            sp.subProcessName = ((TextBox)gvSubProcess.Rows[e.RowIndex].FindControl("txtSubProcessName")).Text;
            sp.Id = id;
            string result = tms.UpdateSubProcess(sp.processId,Server.HtmlEncode(sp.subProcessName), sp.Id).ElementAtOrDefault(0).result.Value.ToString();
            if (result.Equals("0"))
            {
                lblMsg.Text = "Sub-Process Already Exists!!!";
                lblMsg.Visible = true;
            }
            else
            {

                lblMsg.Visible = false;
                gvSubProcess.EditIndex = -1;
                mvProcess.ActiveViewIndex = 0;
                BndGridSubProcess();
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }
    //public void BndGvSubDrop(int index)
    //{
    //    //*****************************************//
    //    //Binds Process Dropdown of SubProcess Grid//
    //    //*****************************************//
    //    try
    //    {
    //        DropDownList ddlpr = (DropDownList)gvSubProcess.Rows[index].FindControl("ddlProcessName");
    //        ddlpr.Items.Clear();
    //        ListItem lipr = new ListItem("Select Process", "0");
    //        ddlpr.Items.Add(lipr);
    //        ddlpr.DataSource = tms.GetProcess(Convert.ToInt32(Session["LocationId"].ToString()));
    //        ddlpr.DataTextField = "ProcessName";
    //        ddlpr.DataValueField = "Id";
    //        ddlpr.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        // Log the exception and notify system operators
    //        ExceptionUtility.LogException(ex, "Catch Error");
    //        throw (ex);

    //    }

    //}

    protected void gvSubProcess_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //**********************************//
        //Opens Subprocess grid in edit mode//
        //*********************************//
        try
        {
            gvSubProcess.EditIndex = e.NewEditIndex;
            int index = Convert.ToInt32(e.NewEditIndex.ToString());
            BndGridSubProcess();
            //BndGvSubDrop(index);
            //DropDownList ddlpr = (DropDownList)gvSubProcess.Rows[e.NewEditIndex].FindControl("ddlProcessName");
            //ddlpr.SelectedIndex = ddlpr.Items.IndexOf(ddlpr.Items.FindByText(proc.ToString()));
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }

    }

    protected void gvSubProcess_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvSubProcess.EditIndex = -1;
        BndGridSubProcess();
    }

    protected void gvSubProcess_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvSubProcess.PageIndex = e.NewPageIndex;
        BndGridSubProcess();

    }
}

