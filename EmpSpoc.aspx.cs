using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EmpSpoc : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();

    public string _spocCode
    {
        get
        {
            return (string)ViewState["_spocCode"];
        }

        set
        {
            ViewState["_spocCode"] = value;
        }
    }

    public string _spocName
    {
        get
        {
            return (string)ViewState["_spocName"];
        }

        set
        {
            ViewState["_spocName"] = value;
        }
    }

    public string _spocIdName
    {
        get
        {
            return (string)ViewState["_spocIdName"];
        }

        set
        {
            ViewState["_spocIdName"] = value;
        }
    }

    public string _empIdName
    {
        get
        {
            return (string)ViewState["_empIdName"];
        }

        set
        {
            ViewState["_empIdName"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        txtEmpIdName.Focus();
        btnAllAssign.Visible = false;
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (txtEmpIdName.Text.ToString().Trim().Length > 0)
        {
            _empIdName = txtEmpIdName.Text;
            BndSPOCGrid();
        }
        else
        {

            MultiView1.ActiveViewIndex = -1;
        }
    }
    public void BndSPOCGrid()
    {
        //*****************************************************//
        //Binds The Spoc Gridview with the search criteria      //
        //*****************************************************//
        try
        {
            gvSPOC.DataSource = tms.EmpSearch(_empIdName, MyApplicationSession._LocationId, MyApplicationSession._ISAdmin);
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
                int totalRows = tms.EmpSearch(_empIdName, MyApplicationSession._LocationId, MyApplicationSession._ISAdmin).Count();
                DisplayRecords(totalRows);
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

    protected void gvSPOC_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        //******************************************************************************//
        //On seletion of employee Displayes the details of SPOC team of that employee //
        //***************************************************************************//
        try
        {
            _spocCode = gvSPOC.DataKeys[e.NewSelectedIndex].Value.ToString();
            txtEmpIdName.Text = ((Label)gvSPOC.Rows[e.NewSelectedIndex].FindControl("lblEmpID")).Text;
            _spocName = ((Label)gvSPOC.Rows[e.NewSelectedIndex].FindControl("lblEmpName")).Text;
            BndSPOCDetailGrid();
            BndBackupSpocGrid();
            BndProcessDdl();
            GvEmployee.Visible = false;
            if (gvSPOCDetails.Rows.Count > 0)
            {

                lblSpocName.Text = "SPOC team assigned to " + _spocName.ToString();
            }
            else
            {
                lblSpocName.Text = " ";

            }
            if (gvSPOCBackup.Rows.Count > 0)
            {
                lblBackupSpoc.Text = "Backup SPOC for " + _spocName.ToString();
            }
            else
            {
                lblBackupSpoc.Text = " ";
            }
            lblAddMsg.Visible = false;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    public void BndProcessDdl()
    {
        //***********************//
        //Binds Process DropDown//
        //**********************//
        try
        {

            ListItem lipr = new ListItem("Select Process", "0");
            ddlProcessSort.Items.Clear();
            ddlProcessSort.Items.Add(lipr);
            ddlProcessSort.DataSource = tms.GetProcess(Convert.ToInt32(Session["LocationId"].ToString()));
            ddlProcessSort.DataTextField = "ProcessName";
            ddlProcessSort.DataValueField = "Id";
            ddlProcessSort.DataBind();
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
        //********************************************************************//
        //For the Next Page Index  bind Spoc grid      //
        //********************************************************************//
        try
        {
            gvSPOC.PageIndex = e.NewPageIndex;
            BndSPOCGrid();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }

    private void DisplayRecords(int totalRows)
    {
        int PageFirstCount = (gvSPOC.PageIndex * gvSPOC.PageSize) + 1;
        int PageLastCount = (gvSPOC.PageIndex * gvSPOC.PageSize) + gvSPOC.Rows.Count;
        Label lblRecordsPerPage = (Label)gvSPOC.FooterRow.FindControl("lblRecordsPerPage");
        lblRecordsPerPage.Text = string.Empty;
        lblRecordsPerPage.Text = "Records: " + PageFirstCount + " - " + PageLastCount + " of " + totalRows;
    }
    public void BndBackupSpocGrid()
    {
        //********************************************************************//
        //Binds Backup SPOC Grid Assignes to the SPOC    //
        //********************************************************************//
        try
        {
            gvSPOCBackup.DataSource = tms.GetBackupSpoc(Convert.ToInt32(_spocCode));
            gvSPOCBackup.DataBind();
            if (gvSPOCBackup.Rows.Count < 1)
            {

                lblBackupSpoc.Visible = true;
                lblBackupSpoc.Text = "No Backup Spoc Assigned!!";
            }
            else { lblBackupSpoc.Text = "Backup SPOC for " + _spocName.ToString(); }

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
        //********************************************************************//
        //Binds the SOPC Detail Grid of an employee     //
        //********************************************************************//
        gvSPOCDetails.DataSource = tms.GetEmpAssignedSPOC(_spocCode);
        gvSPOCDetails.DataBind();
        MultiView1.ActiveViewIndex = 1;
        lblSpocMsg.Visible = false;
        if (gvSPOCDetails.Rows.Count < 1)
        {
            lblSpocMsg.Visible = true;
            lblSpocMsg.Text = "No Employee Under This SPOC";

        }
    }

    protected void btnEmpSearch_Click(object sender, EventArgs e)
    {
        //********************************************************************//
        //Call to bind employee grid and backup spoc  //
        //********************************************************************//
        if (txtSPOCIdName.Text.ToString().Trim().Length > 0)
        {
            _spocIdName = txtSPOCIdName.Text;

            lblAddMsg.Visible = false;
            BndEmpGrid();
            BndBackupSpocGrid();
        }
    }
    public void BndEmpGrid()
    {
        //********************************************************************//
        //Bind Employee Grid with the searched employee  //
        //********************************************************************//
        try
        {

            GvEmployee.DataSource = tms.EmpSearch(_spocIdName, MyApplicationSession._LocationId, MyApplicationSession._ISAdmin);
            GvEmployee.DataBind();
            if (GvEmployee.Rows.Count < 1)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "No Record Found!!!";


            }
            else
            {
                lblMsg.Visible = false;
                lblSpocMsg.Visible = false;
                GvEmployee.Visible = true;
                //txtSPOCIdName.Text = string.Empty;
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
        gvSPOCDetails.PageIndex = e.NewPageIndex;
        BndSPOCDetailGrid();
    }

    protected void GvEmployee_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        GvEmployee.PageIndex = e.NewPageIndex;
        BndEmpGrid();
    }

    protected void GvEmployee_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        //********************************************************************//
        //On Click of Assign button,Assigns the employee to the SPOC team//
        //********************************************************************//
        try
        {
            int emp = Convert.ToInt32(GvEmployee.DataKeys[e.NewSelectedIndex].Value.ToString());
            string result = tms.AssignSpoc(_spocCode, emp).ElementAtOrDefault(0).result.Value.ToString();
            if (result.Equals("1"))
            {

                lblAddMsg.Text = "Employee Assigned to SPOC";
                lblAddMsg.Visible = true;

                GvEmployee.Visible = false;
                BndSPOCDetailGrid();

            }
            else
            {
                lblAddMsg.Text = "Employee Already exists in SPOC!!";
                lblAddMsg.Visible = true;
            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);


        }
    }

    protected void gvSPOCDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //********************************************************************//
        //Removes an employee from SPOC team      //
        //********************************************************************//
        try
        {
            int empid = Convert.ToInt32(gvSPOCDetails.DataKeys[e.RowIndex]["Id"].ToString());
            int spocID = Convert.ToInt32(gvSPOCDetails.DataKeys[e.RowIndex]["spocId"].ToString());
            tms.RemoveSPOC(spocID, empid);
            lblAddMsg.Visible = false;
            BndSPOCDetailGrid();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }

    }

    protected void gvSPOCDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //********************************************************************//
        //Changes the view index on close button click of SPOC grid      //
        //********************************************************************//
        if (e.CommandName.Equals("close"))
        {
            MultiView1.ActiveViewIndex = 0;

            txtEmpIdName.Text = string.Empty;
        }
    }

    protected void GvEmployee_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //********************************************************************//
        //On Click of Assign Backup button,Assigns the employee as the Backup SPOC//
        //On Click of Close button,Closes the employee Grid//
        //********************************************************************//
        try
        {
            if (e.CommandName.Equals("close"))
            {

                GvEmployee.Visible = false;
                lblAddMsg.Visible = false;
            }
            if (e.CommandName.Equals("backup"))
            {
                GridViewRow gvr = (GridViewRow)((LinkButton)e.CommandSource).NamingContainer;
                int rowindex = gvr.RowIndex;
                int backupSpocId = Convert.ToInt32(GvEmployee.DataKeys[rowindex].Value.ToString());
                string result = tms.AssignBackupSpoc(_spocCode, backupSpocId, MyApplicationSession._UserID).ElementAtOrDefault(0).result.Value.ToString();
                if (result.Equals("1"))
                {

                    lblAddMsg.Text = "Backup Assigned to SPOC";
                    lblAddMsg.Visible = true;


                    BndBackupSpocGrid();

                }
                else
                {
                    lblAddMsg.Text = "Backup Already exists in SPOC!!";
                    lblAddMsg.Visible = true;
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



    protected void gvSPOCBackup_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvSPOCBackup.PageIndex = e.NewPageIndex;
        BndBackupSpocGrid();
    }



    protected void gvSPOCBackup_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //********************************************************************//
        //Removes Backup SPOC from the backup SPOC team//           
        //********************************************************************//
        try
        {
            int backupSpocId = Convert.ToInt32(gvSPOCBackup.DataKeys[e.RowIndex]["id"].ToString());
            int SpocId = Convert.ToInt32(gvSPOCBackup.DataKeys[e.RowIndex]["spocId"].ToString());
            tms.RemoveBackupSpoc(SpocId, backupSpocId);
            BndBackupSpocGrid();
            lblAddMsg.Visible = false;
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }

    protected void ddlProcessSort_SelectedIndexChanged(object sender, EventArgs e)
    {
        //********************************************************************//
        //Sorts the Employee by process//
        //********************************************************************//
        try
        {
            if (ddlProcessSort.SelectedIndex != 0)
            {
                int processId = Convert.ToInt32(ddlProcessSort.SelectedValue.ToString());

                GvEmployee.DataSource = tms.GetEmployeeByProcess(processId);
                GvEmployee.DataBind();
                if (GvEmployee.Rows.Count < 1)
                {

                    lblSpocMsg.Text = "No Employees in This Process";
                    lblSpocMsg.Visible = true;
                    btnAllAssign.Visible = false;

                }
                else
                {
                    lblSpocMsg.Visible = false;
                    GvEmployee.Visible = true;
                    btnAllAssign.Visible = true;
                }

            }
            else
            {
                GvEmployee.Visible = false;
                btnAllAssign.Visible = false;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);


        }
    }
    protected void btnAllAssign_Click(object sender, EventArgs e)
    {
        try
        {
            spoc sp = new spoc();
            _spocName = "";
            if (ddlProcessSort.SelectedIndex != 0)
            {
                int processId = Convert.ToInt32(ddlProcessSort.SelectedValue);
                string result = tms.AssignAllSpoc(processId, Convert.ToInt32(_spocCode), MyApplicationSession._LocationId).ToString();
                lblAddMsg.Text = "All Employees Assigned to selected SPOC";
                BndSPOCDetailGrid();
                GvEmployee.Visible = false;
            }
        }
        catch (Exception ex)
        {
            //Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
}
