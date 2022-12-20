using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AssignExceptionToEmp : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
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
        txtEmpIdName.Focus();
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
            GvEmployee.DataSource = tms.EmpSearch(txtEmpIdName.Text, MyApplicationSession._LocationId,MyApplicationSession._ISAdmin);
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
    protected void GvEmployee_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //********************************************************************//
        // Employee grid with the Next Page Index Selected                   //
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

    public void BndFacilityDropdown()
    {
        try
        {
            ddlFacility.Items.Clear();
            ListItem liv = new ListItem("Select Facility", "0");
            ddlFacility.Items.Add(liv);
            ddlFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlFacility.DataTextField = "facilityName";
            ddlFacility.DataValueField = "Id";
            ddlFacility.DataBind();
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
        try
        {
            _empId = Convert.ToInt32(GvEmployee.DataKeys[e.NewSelectedIndex].Value.ToString());
            BndFacilityDropdown();
            BingShiftDdl();

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    private void BingShiftDdl()
    {
        try
        {
            string type = rdoTripType.SelectedValue.ToString();
            string colony = tms.GetEmpGeoDetails(_empId).ElementAtOrDefault(0).colony.ToString();
            string empname = tms.GetEmpGeoDetails(_empId).ElementAtOrDefault(0).empName.ToString();
            string city = tms.GetEmpGeoDetails(_empId).ElementAtOrDefault(0).city.ToString();
            int facid = Convert.ToInt32(ddlFacility.SelectedValue.ToString());
            MultiView1.ActiveViewIndex = 1;
            lblempcolony.Text = colony;
            lblempname.Text = empname;
            lstShift.Items.Clear();
            ListItem list2 = new ListItem("-Select-", "0");
            lstShift.Items.Add(list2);
            lstShift.DataSource = tms.GetExceptionShiftsToEmp(facid, city, colony, type, 1, _empId);
            lstShift.DataTextField = "shiftTime";
            lstShift.DataValueField = "SID";
            lstShift.DataBind();
            lstShift.SelectedIndex = 0;
            //////////////////////////////////////
            lstShiftAssigned.Items.Clear();
            ListItem list3 = new ListItem("-Select-", "0");
            lstShiftAssigned.Items.Add(list3);
            lstShiftAssigned.DataSource = tms.GetExceptionShiftsToEmp(facid, city, colony, type, 0, _empId);
            lstShiftAssigned.DataTextField = "shiftTime";
            lstShiftAssigned.DataValueField = "SID";
            lstShiftAssigned.DataBind();
            lstShiftAssigned.SelectedIndex = 0;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string SID = string.Empty;
            int facilityId = Convert.ToInt32(ddlFacility.SelectedValue.ToString());
            if (lstShift.SelectedIndex >= 0)
            {
                for (int i = 0; i < lstShift.Items.Count; i++)
                {
                    if (lstShift.Items[i].Selected)
                    {
                        SID += lstShift.Items[i].Value.Trim() + ",";
                    }
                }
            }
            SID = SID.Remove(SID.Length - 1, 1);
            tms.SprInsertExpShiftToEmp(_empId, facilityId, SID, 1);
            BingShiftDdl();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void rdoTripType_SelectedIndexChanged(object sender, EventArgs e)
    {
        BingShiftDdl();
    }
    protected void btnUnAssign_Click(object sender, EventArgs e)
    {
        try
        {
            string SID = string.Empty;
            int facilityId = Convert.ToInt32(ddlFacility.SelectedValue.ToString());
            if (lstShiftAssigned.SelectedIndex >= 0)
            {
                for (int i = 0; i < lstShiftAssigned.Items.Count; i++)
                {
                    if (lstShiftAssigned.Items[i].Selected)
                    {
                        SID += lstShiftAssigned.Items[i].Value.Trim() + ",";
                    }
                }
            }
            SID = SID.Remove(SID.Length - 1, 1);
            tms.SprInsertExpShiftToEmp(_empId, facilityId, SID, 0);
            BingShiftDdl();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        BingShiftDdl();
    }
}
