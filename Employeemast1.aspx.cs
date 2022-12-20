using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Employeemast1 : basepage
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

    protected void GvEmployee_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        //***************************************************************************//
        //Display Employee Details on selection of that employee in the Employee grid//
        //***************************************************************************//
        try
        {
            AJX.ActiveTabIndex=0;
            _empId = Convert.ToInt32(GvEmployee.DataKeys[e.NewSelectedIndex].Value.ToString());
            var result = tms.GetEmployee(_empId);
            fvEmployee.ChangeMode(FormViewMode.Edit);
            fvEmployee.DataBind();
            fvadress.ChangeMode(FormViewMode.Edit);
            fvadress.DataBind();
            fvEmployee.DataSource = tms.GetEmployee(_empId);
            
            foreach (var r in result)
            {
                string manid = r.managerId.ToString();
                string prId = r.processId.ToString();
                string facid = r.facilityId.ToString();
                string nodId = r.nodalId.ToString();
                string subId = r.subProcessId.ToString();
                fvadress.DataSource = tms.GetEmployee(_empId);
                fvEmployee.DataBind();

                fvadress.DataBind();


                //fvEmployee.HeaderText = "Edit Employee Details";
                BndDvDropDown();
                //  MultiView1.ActiveViewIndex = 1;


                ((TextBox)fvEmployee.FindControl("txtdvEmpId")).Text = r.empCode.ToString();

                //((TextBox)fvEmployee.FindControl("txtdvDesignation")).Text = r.designation.ToString();

                ((TextBox)fvEmployee.FindControl("txtdvEmail")).Text = r.email.ToString();
                ((TextBox)fvEmployee.FindControl("txtdvEmpName")).Text = r.empName.ToString();

                ((TextBox)fvEmployee.FindControl("txtdvMobile")).Text = r.mobile.ToString();
                ((TextBox)fvEmployee.FindControl("txtdvPhone")).Text = r.phone.ToString();

                ((TextBox)fvEmployee.FindControl("txtdvUserName")).Text = r.userName.ToString();

                if (r.attrited.ToString().Equals("Y"))
                {

                    ((CheckBox)fvEmployee.FindControl("chkdvAttrited")).Checked = true;
                }
                else { ((CheckBox)fvEmployee.FindControl("chkdvAttrited")).Checked = false; }

                if (r.Gender.ToString().Equals("Male"))
                {
                    ((RadioButton)fvEmployee.FindControl("rdbtndvM")).Checked = true;
                }
                else
                {
                    if (r.Gender.ToString().Equals("Other"))
                    {
                        ((RadioButton)fvEmployee.FindControl("rdbtndvO")).Checked = true;
                    }
                    else if (r.Gender.ToString().Equals("TG"))
                    {
                        ((RadioButton)fvEmployee.FindControl("rdbtndvT")).Checked = true;
                    }
                    else
                    {
                        ((RadioButton)fvEmployee.FindControl("rdbtndvF")).Checked = true;
                    }
                    
                }
                if (r.tptReq.ToString().Equals("Y"))
                {
                    ((CheckBox)fvEmployee.FindControl("chkdvTptReq")).Checked = true;
                }
                else { ((CheckBox)fvEmployee.FindControl("chkdvTptReq")).Checked = false; }
                if (r.IsDisabled.ToString().Equals("Y"))
                {
                    ((CheckBox)fvEmployee.FindControl("ChkDisability")).Checked = true;
                }
                else
                {
                    ((CheckBox)fvEmployee.FindControl("ChkDisability")).Checked = false;
                }

                DropDownList ddlman = (DropDownList)fvEmployee.FindControl("ddldvManager");
                DropDownList ddlprocess = (DropDownList)fvEmployee.FindControl("ddldvProcess");
                DropDownList ddlfac = (DropDownList)fvEmployee.FindControl("ddldvFacility");
                DropDownList ddlSubProcess = (DropDownList)fvEmployee.FindControl("ddldvSubProcess");
                ddlfac.SelectedIndex = ddlfac.Items.IndexOf(ddlfac.Items.FindByValue(facid.ToString()));
                ddlprocess.SelectedIndex = ddlprocess.Items.IndexOf(ddlprocess.Items.FindByValue(prId.ToString()));

                ddlman.SelectedIndex = ddlman.Items.IndexOf(ddlman.Items.FindByValue(manid.ToString()));


                ddlprocess.SelectedIndex = ddlprocess.Items.IndexOf(ddlprocess.Items.FindByValue(prId));

                if (ddlprocess.SelectedIndex != 0)
                {
                    int pid = Convert.ToInt32(ddlprocess.SelectedValue.ToString());
                    ddlSubProcess.DataSource = tms.GetSubProcess(pid);
                    ddlSubProcess.DataTextField = "subProcessName";
                    ddlSubProcess.DataValueField = "Id";
                    ddlSubProcess.DataBind();
                    ddlSubProcess.SelectedIndex = ddlSubProcess.Items.IndexOf(ddlSubProcess.Items.FindByValue(subId.ToString()));

                }
                int id = Convert.ToInt32(r.geoCodeId.ToString());
                ((Label)fvadress.FindControl("lblX")).Text = tms.GetLandMarkGeoCode(id).ElementAtOrDefault(0).geoX.ToString();
                ((Label)fvadress.FindControl("lblY")).Text = tms.GetLandMarkGeoCode(id).ElementAtOrDefault(0).geoY.ToString();
                ((TextBox)fvadress.FindControl("txtdvAddress")).Text = r.address.ToString();
                ((TextBox)fvadress.FindControl("txtdvPincode")).Text = r.pincode.ToString();
                string city = tms.GetEmpGeoDetails(_empId).ElementAtOrDefault(0).city.ToString();
                string col = tms.GetEmpGeoDetails(_empId).ElementAtOrDefault(0).colony.ToString();
                string subcol = tms.GetEmpGeoDetails(_empId).ElementAtOrDefault(0).SubColony.ToString();
                //   string subcol = tms.GetEmpGeoDetails(_empId).ElementAtOrDefault(0).SubColony.ToString();
                string land = tms.GetEmpGeoDetails(_empId).ElementAtOrDefault(0).landmark.ToString();
                DropDownList ddlCity = (DropDownList)fvadress.FindControl("ddldvCity");
                ddlCity.Items.Clear();
                ListItem licity = new ListItem("Select City", "0");
                ddlCity.Items.Add(licity);
                ddlCity.DataSource = tms.GetGeoCity();
                ddlCity.DataTextField = "city";
                ddlCity.DataValueField = "city";
                ddlCity.DataBind();
                ddlCity.SelectedIndex = ddlCity.Items.IndexOf(ddlCity.Items.FindByText(city.ToString()));

                DropDownList ddlcol = (DropDownList)fvadress.FindControl("ddldvColony");
                ddlcol.Items.Clear();
                ListItem licol = new ListItem("Select Colony", "0");
                ddlcol.Items.Add(licol);
                ddlcol.DataSource = tms.GetGeoCityColony(city);
                ddlcol.DataTextField = "colony";
                ddlcol.DataValueField = "colony";
                ddlcol.DataBind();
                ddlcol.SelectedIndex = ddlcol.Items.IndexOf(ddlcol.Items.FindByText(col.ToString()));

                DropDownList ddlSubcolony = (DropDownList)fvadress.FindControl("ddldvSubColony");
                ddlSubcolony.Items.Clear();
                ListItem liSubcol = new ListItem("-Select-", "0");
                ddlSubcolony.Items.Add(liSubcol);
                ddlSubcolony.DataSource = tms.GetGeoSubColony(col, city);
                ddlSubcolony.DataTextField = "Subcolony";

                ddlSubcolony.DataBind();
                ddlSubcolony.SelectedIndex = ddlSubcolony.Items.IndexOf(ddlSubcolony.Items.FindByText(subcol.ToString()));
                DropDownList ddlland = (DropDownList)fvadress.FindControl("ddldvLandmark");
                ddlland.Items.Clear();
                ListItem liland = new ListItem("Select LandMark", "0");
                ddlland.Items.Add(liland);
                ddlland.DataSource = tms.GetGeoColonyLandmark(col,subcol, city);
                ddlland.DataTextField = "landmark";
                ddlland.DataValueField = "Id";
                ddlland.DataBind();
                ddlland.SelectedIndex = ddlland.Items.IndexOf(ddlland.Items.FindByText(land.ToString()));
                DropDownList ddldvman = (DropDownList)fvEmployee.FindControl("ddldvisionManager");
                DropDownList ddlCostcenter = (DropDownList)fvEmployee.FindControl("ddlCostcenter");
                string costcenter = r.Costcenter.ToString();
                if (costcenter == "")
                {
                    costcenter = "0";
                }
                string dvmana = r.dvManager.ToString();
                ddlCostcenter.SelectedIndex = ddlCostcenter.Items.IndexOf(ddlCostcenter.Items.FindByText(costcenter.ToString()));
                if (dvmana != "0")
                {
                    ddldvman.SelectedIndex = ddldvman.Items.IndexOf(ddldvman.Items.FindByValue(dvmana.ToString()));
                }
                   CheckBox chkspecialCase = ((CheckBox)fvEmployee.FindControl("chkspecialCase"));
                TextBox txtfromdate = ((TextBox)fvEmployee.FindControl("txtFromDate"));
                TextBox txttodate = ((TextBox)fvEmployee.FindControl("txttoDate"));
                showhidespecialcase();
                if (chkspecialCase.Checked == true)
                {
                    txtfromdate.Text = r.fromspecialcase.ToString();
                    txttodate.Text = r.tospecialcase.ToString();
                }
                lblMsg.Visible = false;
                ModalPopupExtender1.Show();
                MultiView2.ActiveViewIndex = 0;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);


        }

    }
    protected void fvEmployee_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        //********************************************************************//
        //Change View index of multiview on click of cancel of detailsview    //
        //********************************************************************//
        try
        {
            if (e.Cancel == true || e.CancelingEdit == true)
            {
                MultiView1.ActiveViewIndex = 0;
                lblMsg.Visible = false;
                //BndEmpGrid();

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
        //*********************************//
        //Bind Detailsview's dropdown Lists//
        //*********************************//
        try
        {
            DropDownList ddlman = (DropDownList)fvEmployee.FindControl("ddldvManager");
            DropDownList ddlprocess = (DropDownList)fvEmployee.FindControl("ddldvProcess");
            DropDownList ddlsubprocess = (DropDownList)fvEmployee.FindControl("ddldvSubProcess");
            DropDownList ddlfac = (DropDownList)fvEmployee.FindControl("ddldvFacility");
            DropDownList ddlCity = (DropDownList)fvadress.FindControl("ddldvCity");
            DropDownList ddldvman = (DropDownList)fvEmployee.FindControl("ddldvisionManager");
            DropDownList ddlCostcenter = (DropDownList)fvEmployee.FindControl("ddlCostcenter");

            ListItem liman = new ListItem("-Select-", "0");
            ListItem lipr = new ListItem("-Select-", "0");
            ListItem lifac = new ListItem("-Select-", "0");
            ListItem liSub = new ListItem("-Select-", "0");
            ListItem licity = new ListItem("-Select-", "0");
            ddlfac.Items.Clear();
            ddlsubprocess.Items.Clear();
            ddlprocess.Items.Clear();
            ddlman.Items.Clear();
            ddldvman.Items.Clear();
            ddlCostcenter.Items.Clear();

            ddlfac.Items.Add(lifac);
            ddlman.Items.Add(liman);
            ddlprocess.Items.Add(lipr);
            ddlsubprocess.Items.Add(liSub);
            ddldvman.Items.Add(liman);
            ddlCostcenter.Items.Add(liman);

            ddlfac.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlfac.DataTextField = "facilityName";
            ddlfac.DataValueField = "Id";
            ddlfac.DataBind();

            ddlman.DataSource = tms.GetManagerList(MyApplicationSession._LocationId);
            ddlman.DataTextField = "empName";
            ddlman.DataValueField = "Id";
            ddlman.DataBind();

            ddldvman.DataSource = tms.GetdvManagerList(MyApplicationSession._LocationId);
            ddldvman.DataTextField = "empname";
            ddldvman.DataValueField = "Id";
            ddldvman.DataBind();

            ddlprocess.DataSource = tms.GetProcess(MyApplicationSession._LocationId);
            ddlprocess.DataTextField = "processName";
            ddlprocess.DataValueField = "Id";
            ddlprocess.DataBind();

            ddlCostcenter.DataSource = tms.getCostcenter();
            ddlCostcenter.DataTextField = "costcenter";
            ddlCostcenter.DataValueField = "costcenter";
            ddlCostcenter.DataBind();


            ddlCity.Items.Clear();
            ddlCity.Items.Add(licity);
            ddlCity.DataSource = tms.GetGeoCity();
            ddlCity.DataTextField = "city";
            ddlCity.DataValueField = "city";
            ddlCity.DataBind();

            DropDownList ddlcol = (DropDownList)fvadress.FindControl("ddldvColony");
            ddlcol.Items.Clear();
            ListItem licol = new ListItem("-Select-", "0");
            ddlcol.Items.Add(licol);

           
            DropDownList ddlland = (DropDownList)fvadress.FindControl("ddldvLandmark");
            ddlland.Items.Clear();
            ListItem liland = new ListItem("-Select-", "0");
            ddlland.Items.Add(liland);

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }


    }





    protected void ddldvCity_SelectedIndexChanged(object sender, EventArgs e)
    {
        //********************************************************************//
        //For the selected city of city dropdown bind colony dropdown      //
        //********************************************************************//
        try
        {
            DropDownList ddlcity = (DropDownList)fvadress.FindControl("ddldvCity");
            string city = ddlcity.SelectedItem.Text;
            DropDownList ddlcol = (DropDownList)fvadress.FindControl("ddldvColony");
            ddlcol.Items.Clear();
            ListItem licol = new ListItem("-Select-", "0");
            ddlcol.Items.Add(licol);
            ddlcol.DataSource = tms.GetGeoCityColony(city);
            ddlcol.DataTextField = "colony";
            ddlcol.DataValueField = "colony";
            ddlcol.DataBind();

  

            DropDownList ddlland = (DropDownList)fvadress.FindControl("ddldvLandmark");
            ddlland.Items.Clear();
            ListItem liland = new ListItem("-Select-", "0");
            ddlland.Items.Add(liland);
            ((Label)fvadress.FindControl("lblX")).Text = string.Empty;
            ((Label)fvadress.FindControl("lblY")).Text = string.Empty;
            ModalPopupExtender1.Show();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);


        }
    }




    protected void ddldvColony_SelectedIndexChanged(object sender, EventArgs e)
    {
        //***************************************************************************************************//
        //For the selected city of city dropdown and selected colony dropdown binds the landmark Dropdown //
        //***********************************************************************************************//
        try
        {
            DropDownList ddlcity = (DropDownList)fvadress.FindControl("ddldvCity");
            string city = ddlcity.SelectedItem.Text;
            DropDownList ddlcol = (DropDownList)fvadress.FindControl("ddldvColony");
            string col = ddlcol.SelectedItem.Text;

            DropDownList ddlSubcolony = (DropDownList)fvadress.FindControl("ddldvSubColony");
            ddlSubcolony.Items.Clear();
            ListItem liSubcol = new ListItem("-Select-", "0");
            ddlSubcolony.Items.Add(liSubcol);
            ddlSubcolony.DataSource = tms.GetGeoSubColony(col, city);
            ddlSubcolony.DataTextField = "Subcolony";

            ddlSubcolony.DataBind();
            ((Label)fvadress.FindControl("lblX")).Text = string.Empty;
            ((Label)fvadress.FindControl("lblY")).Text = string.Empty;
            ModalPopupExtender1.Show();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }


    protected void ddldvSubColony_SelectedIndexChanged(object sender, EventArgs e)
    {
        //***************************************************************************************************//
        //For the selected city of city dropdown and selected colony dropdown binds the landmark Dropdown //
        //***********************************************************************************************//
        try
        {
            DropDownList ddlcity = (DropDownList)fvadress.FindControl("ddldvCity");
            string city = ddlcity.SelectedItem.Text;
            DropDownList ddlcol = (DropDownList)fvadress.FindControl("ddldvColony");
            string col = ddlcol.SelectedItem.Text;
            DropDownList ddlSubColony = (DropDownList)fvadress.FindControl("ddldvSubColony");
            String subcolony = ddlSubColony.SelectedItem.Text;

            DropDownList ddlland = (DropDownList)fvadress.FindControl("ddldvLandmark");
            ddlland.Items.Clear();

            ListItem liland = new ListItem("-Select-", "0");
            ddlland.Items.Add(liland);
            ddlland.DataSource = tms.GetGeoColonyLandmark(col,subcolony,city);
            ddlland.DataTextField = "Landmark";
            ddlland.DataValueField = "Id";
            ddlland.DataBind();
            ModalPopupExtender1.Show();
         
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }



    protected void ddldvLandmark_SelectedIndexChanged(object sender, EventArgs e)
    {
        //********************************************************************//
        //For the selected Landmark displayes the geoX and geoY Co-ordinates   //
        //********************************************************************//
        try
        {
            DropDownList ddlland = (DropDownList)fvadress.FindControl("ddldvLandmark");
            int Id = Convert.ToInt32(ddlland.SelectedValue);
            if (ddlland.SelectedIndex != 0)
            {
                ((Label)fvadress.FindControl("lblX")).Text = tms.GetLandMarkGeoCode(Id).ElementAtOrDefault(0).geoX.ToString();
                ((Label)fvadress.FindControl("lblY")).Text = tms.GetLandMarkGeoCode(Id).ElementAtOrDefault(0).geoY.ToString();
            }
            ModalPopupExtender1.Show();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);


        }
    }

    protected void DvGeo_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        //*****************************************************************************//
        //Changes view index of multiview on click of close button  of Geo Details View//
        //****************************************************************************//
        try
        {

            ((TextBox)fvEmployee.FindControl("txtdvAddress")).Text = string.Empty;
            ((TextBox)fvEmployee.FindControl("txtdvPincode")).Text = string.Empty;

            ((Label)fvEmployee.FindControl("lblX")).Text = string.Empty;
            ((Label)fvEmployee.FindControl("lblY")).Text = string.Empty;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);


        }

    }

    protected void DvGeo_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        //**************************************//
        //Updates the Geo Details of An Employee//
        //**************************************//
        try
        {
            DropDownList ddlland = (DropDownList)fvEmployee.FindControl("ddldvLandmark");
            string columnName = string.Empty;
            int geocodeId = Convert.ToInt32(ddlland.SelectedValue);
            if (tms.GetEmployee(_empId).ElementAtOrDefault(0).geoCodeId.ToString() != geocodeId.ToString())
            {
                columnName += "GeoCodeId";

            }
            emp.address = ((TextBox)fvEmployee.FindControl("txtdvAddress")).Text;
            if (tms.GetEmployee(_empId).ElementAtOrDefault(0).address.ToString() != emp.address.ToString())
            {
                columnName += ", address";

            }
            emp.pincode = ((TextBox)fvEmployee.FindControl("txtdvPincode")).Text;
            if (tms.GetEmployee(_empId).ElementAtOrDefault(0).pincode.ToString() != emp.pincode.ToString())
            {
                columnName += ", pincode";

            }
            emp.updatedBy = MyApplicationSession._UserID;
            string res = tms.updateEmpGeoCode(emp.address, emp.pincode, geocodeId, _empId, emp.updatedBy).ElementAtOrDefault(0).result.Value.ToString();
            tms.AddEmpAuditLog(_empId, columnName, emp.updatedBy);
            if (res.Equals("1"))
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Geo Details Saved!!!";

            }
            else
            {

                lblMsg.Visible = true;
                lblMsg.Text = "Error In Saving Details!!!Please Try Again";
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }

    protected void lbtnAddnew_Click(object sender, EventArgs e)
    {
        //********************************************************************//
        //Changes view index and opens detailsview to add new Employee     //
        //********************************************************************//
        try
        {
            //MultiView1.ActiveViewIndex = 1;
            MultiView2.ActiveViewIndex = 0;
            lblMsg.Visible = false;
            _empId = 0;
            fvEmployee.ChangeMode(FormViewMode.Insert);
            fvEmployee.DataBind();
            fvadress.ChangeMode(FormViewMode.Insert);
            fvadress.DataBind();
            ClearDvGeoFields();
            BndDvDropDown();
            ClearDvEmpFields();
            txtEmpIdName.Text = string.Empty;
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }
    public void ClearDvEmpFields()
    {
        //********************************************************************//
        //Clears the DetailsView fields when detailview closes     //
        //********************************************************************//
        try
        {
            ((TextBox)fvEmployee.FindControl("txtdvEmpId")).Text = string.Empty;

            //((TextBox)fvEmployee.FindControl("txtdvDesignation")).Text = string.Empty;

            ((TextBox)fvEmployee.FindControl("txtdvEmail")).Text = string.Empty;
            ((TextBox)fvEmployee.FindControl("txtdvEmpName")).Text = string.Empty;

            ((TextBox)fvEmployee.FindControl("txtdvMobile")).Text = string.Empty;
            ((TextBox)fvEmployee.FindControl("txtdvPhone")).Text = string.Empty;

            ((TextBox)fvEmployee.FindControl("txtdvUserName")).Text = string.Empty;


            ((CheckBox)fvEmployee.FindControl("chkdvAttrited")).Checked = false;

            ((RadioButton)fvEmployee.FindControl("rdbtndvM")).Checked = true;



            ((CheckBox)fvEmployee.FindControl("chkdvTptReq")).Checked = false;

            ModalPopupExtender1.Show();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }

    protected void DvGeo_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        //********************************************************************//
        //Saves Geo details of Newly Added Employee   //
        //********************************************************************//
        try
        {
            DropDownList ddlland = (DropDownList)fvEmployee.FindControl("ddldvLandmark");
            string columnName = string.Empty;
            int geocodeId = Convert.ToInt32(ddlland.SelectedValue);
            if (tms.GetEmployee(_empId).ElementAtOrDefault(0).geoCodeId.ToString() != geocodeId.ToString())
            {
                columnName += "GeoCodeId";

            }
            emp.address = ((TextBox)fvEmployee.FindControl("txtdvAddress")).Text;
            if (tms.GetEmployee(_empId).ElementAtOrDefault(0).address.ToString() != emp.address.ToString())
            {
                columnName += ", address";

            }
            emp.pincode = ((TextBox)fvEmployee.FindControl("txtdvPincode")).Text;
            if (tms.GetEmployee(_empId).ElementAtOrDefault(0).pincode.ToString() != emp.pincode.ToString())
            {
                columnName += ", pincode";

            }
            emp.updatedBy = MyApplicationSession._UserID;
            string res = tms.updateEmpGeoCode(emp.address, emp.pincode, geocodeId, _empId, emp.updatedBy).ElementAtOrDefault(0).result.Value.ToString();
            if (res.Equals("1"))
            {
                tms.AddEmpAuditLog(_empId, columnName, emp.updatedBy);
                lblMsg.Visible = true;
                lblMsg.Text = "Geo Details Saved!!!";

            }
            else
            {

                lblMsg.Visible = true;
                lblMsg.Text = "Error In Saving Details!!!Please Try Again";
            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }

    public void ClearDvGeoFields()
    {
        //********************************************************************//
        //Clears Geo Detailview fields on its closing      //
        //********************************************************************//
        try
        {
            ((TextBox)fvadress.FindControl("txtdvAddress")).Text = string.Empty;
            ((TextBox)fvadress.FindControl("txtdvPincode")).Text = string.Empty;
            ((DropDownList)fvadress.FindControl("ddldvCity")).Text = "0";
            ((DropDownList)fvadress.FindControl("ddldvColony")).Text = "0";
         
            ((DropDownList)fvadress.FindControl("ddldvLandmark")).Text = "0";
            ((Label)fvadress.FindControl("lblX")).Text = string.Empty;
            ((Label)fvadress.FindControl("lblY")).Text = string.Empty;
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);


        }
    }

    public void BndGeoDv()
    {
        //********************************************************************//
        //Binds Dropdown of Geo detailsView  //
        //********************************************************************//

        try
        {
            DropDownList ddlCity = (DropDownList)fvadress.FindControl("ddldvCity");
            ddlCity.Items.Clear();
            ListItem licity = new ListItem("-Select-", "0");
            ddlCity.Items.Add(licity);
            ddlCity.DataSource = tms.GetGeoCity();
            ddlCity.DataTextField = "city";
            ddlCity.DataValueField = "city";
            ddlCity.DataBind();

            DropDownList ddlcol = (DropDownList)fvadress.FindControl("ddldvColony");
            ddlcol.Items.Clear();
            ListItem licol = new ListItem("-Select-", "0");
            ddlcol.Items.Add(licol);


            DropDownList ddlland = (DropDownList)fvadress.FindControl("ddldvLandmark");
            ddlland.Items.Clear();
            ListItem liland = new ListItem("-Select-", "0");
            ddlland.Items.Add(liland);


        }
        catch (Exception ex)
        {


            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }

    protected void ddldvProcess_SelectedIndexChanged(object sender, EventArgs e)
    {
        //********************************************************************//
        //For the selected Process of Proces dropdown bind Sub-Process dropdown //
        //********************************************************************//
        try
        {

            DropDownList ddlprocess = (DropDownList)fvEmployee.FindControl("ddldvProcess");
            DropDownList ddlSubProcess = (DropDownList)fvEmployee.FindControl("ddldvSubProcess");
            ListItem lispr = new ListItem("-Select-", "0");
            ddlSubProcess.Items.Clear();
            ddlSubProcess.Items.Add(lispr);
            if (ddlprocess.SelectedIndex != 0)
            {
                int pid = Convert.ToInt32(ddlprocess.SelectedValue.ToString());
                ddlSubProcess.DataSource = tms.GetSubProcess(pid);
                ddlSubProcess.DataTextField = "subProcessName";
                ddlSubProcess.DataValueField = "Id";
                ddlSubProcess.DataBind();


            }
            ModalPopupExtender1.Show();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }

    //protected void ddldvFacility_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    //********************************************************************//
    //    //For the selected Facility of Facility dropdown bind Process dropdown //
    //    //********************************************************************//
    //    try
    //    {
    //        DropDownList ddlprocess = (DropDownList)fvEmployee.FindControl("ddldvProcess");
    //        DropDownList ddlfac = (DropDownList)fvEmployee.FindControl("ddldvFacility");
    //        ListItem lipr = new ListItem("-Select-", "0");
    //        ddlprocess.Items.Clear();
    //        ddlprocess.Items.Add(lipr);
    //        if (ddlfac.SelectedIndex != 0)
    //        {
    //            int facid = Convert.ToInt32(ddlfac.SelectedValue.ToString());
    //            ddlprocess.DataSource = tms.GetProcessByFacility(facid);
    //            ddlprocess.DataTextField = "processName";
    //            ddlprocess.DataValueField = "Id";
    //            ddlprocess.DataBind();
    //        }

    //    }
    //    catch (Exception ex)
    //    {

    //        // Log the exception and notify system operators
    //        ExceptionUtility.LogException(ex, "Catch Error");

    //        throw (ex);

    //    }
    //}

    protected void btnSave_Click(object sender, EventArgs e)
    {
        //*********************************//
        //Update Employee details to DB   //
        //*********************************//
        try
        {

            if (Page.IsValid)
            {
                string columnName = string.Empty;
                string ChkDisability = string.Empty;
                emp.empCode = ((TextBox)fvEmployee.FindControl("txtdvEmpId")).Text;
                emp.id = _empId;
                emp.designation = string.Empty;
                if (_empId > 0)
                {
                    emp.email = ((TextBox)fvEmployee.FindControl("txtdvEmail")).Text;
                    if (tms.GetEmployee(_empId).ElementAtOrDefault(0).email.ToString() != emp.email)
                    {

                        columnName += ", email";
                    }
                    emp.empName = ((TextBox)fvEmployee.FindControl("txtdvEmpName")).Text;
                    if (tms.GetEmployee(_empId).ElementAtOrDefault(0).empName.ToString() != emp.empName)
                    {
                        columnName += ", empName";

                    }
                    emp.mobile = ((TextBox)fvEmployee.FindControl("txtdvMobile")).Text;
                    if (tms.GetEmployee(_empId).ElementAtOrDefault(0).mobile.ToString() != emp.mobile)
                    {
                        columnName += ", mobile";

                    }
                    emp.phone = ((TextBox)fvEmployee.FindControl("txtdvPhone")).Text;
                    if (tms.GetEmployee(_empId).ElementAtOrDefault(0).phone.ToString().ToString() != emp.phone)
                    {
                        columnName += ", phone";
                    }
                    emp.userName = ((TextBox)fvEmployee.FindControl("txtdvUserName")).Text;


                    if (((CheckBox)fvEmployee.FindControl("chkdvAttrited")).Checked == true)
                    {
                        emp.attrited = 'Y';
                    }
                    else
                    {
                        emp.attrited = 'N';
                    }
                    if (tms.GetEmployee(_empId).ElementAtOrDefault(0).attrited != emp.attrited)
                    {

                        columnName += ", attrited";
                    }
                    if (((RadioButton)fvEmployee.FindControl("rdbtndvM")).Checked == true)
                    {
                        emp.Gender = "Male";
                    }
                    else
                    {
                        if (((RadioButton)fvEmployee.FindControl("rdbtndvO")).Checked == true)
                        {
                            emp.Gender = "Other";
                        }
                        else if (((RadioButton)fvEmployee.FindControl("rdbtndvT")).Checked == true)
                        {
                            emp.Gender = "TG";
                        }
                        else
                        {
                            emp.Gender = "Female";

                        }

                    }
                    if (tms.GetEmployee(_empId).ElementAtOrDefault(0).Gender.ToString() != emp.Gender)
                    {

                        columnName += ", gender";
                    }

                    if (((CheckBox)fvEmployee.FindControl("chkdvTptReq")).Checked == true)
                    {

                        emp.tptReq = 'Y';


                    }
                    else
                    {
                        emp.tptReq = 'N';
                    }
                    if (tms.GetEmployee(_empId).ElementAtOrDefault(0).tptReq != emp.tptReq)
                    {
                        columnName += ", tptReq";

                    }
                    emp.managerId = ((DropDownList)fvEmployee.FindControl("ddldvManager")).SelectedValue;
                    if (tms.GetEmployee(_empId).ElementAtOrDefault(0).managerId.ToString() != emp.managerId)
                    {
                        columnName += ", managerId";

                    }
                    emp.processId = Convert.ToInt32(((DropDownList)fvEmployee.FindControl("ddldvProcess")).SelectedValue);
                    if (tms.GetEmployee(_empId).ElementAtOrDefault(0).processId.ToString() != emp.processId.Value.ToString())
                    {
                        columnName += ", processId";

                    }
                    emp.subProcessId = Convert.ToInt32(((DropDownList)fvEmployee.FindControl("ddldvSubProcess")).SelectedValue);
                    if (tms.GetEmployee(_empId).ElementAtOrDefault(0).subProcessId.ToString() != emp.subProcessId.Value.ToString())
                    {
                        columnName += ", subProcessId";

                    }
                    emp.facilityId = Convert.ToInt32(((DropDownList)fvEmployee.FindControl("ddldvFacility")).SelectedValue);
                    if (tms.GetEmployee(_empId).ElementAtOrDefault(0).facilityId.ToString() != emp.facilityId.Value.ToString())
                    {
                        columnName += ", facilityId";

                    }

                    DropDownList ddlland = (DropDownList)fvadress.FindControl("ddldvLandmark");
                    int geocodeId = Convert.ToInt32(ddlland.SelectedValue);
                    if (tms.GetEmployee(_empId).ElementAtOrDefault(0).geoCodeId.ToString() != geocodeId.ToString())
                    {
                        columnName += "GeoCodeId";

                    }
                    emp.address = ((TextBox)fvadress.FindControl("txtdvAddress")).Text;
                    if (tms.GetEmployee(_empId).ElementAtOrDefault(0).address.ToString() != emp.address.ToString())
                    {
                        columnName += ", address";

                    }
                    emp.pincode = ((TextBox)fvadress.FindControl("txtdvPincode")).Text;
                    if (tms.GetEmployee(_empId).ElementAtOrDefault(0).pincode.ToString() != emp.pincode.ToString())
                    {
                        columnName += ", pincode";

                    }
                    DropDownList ddldvman = (DropDownList)fvEmployee.FindControl("ddldvisionManager");
                    DropDownList ddlCostcenter = (DropDownList)fvEmployee.FindControl("ddlCostcenter");
                  
                   CheckBox chkspecialCase = ((CheckBox)fvEmployee.FindControl("chkspecialCase"));
                    TextBox txtfromdate = ((TextBox)fvEmployee.FindControl("txtFromDate"));
                    TextBox txttodate = ((TextBox)fvEmployee.FindControl("txttoDate"));
                    int dvmanager = Convert.ToInt32(ddldvman.SelectedValue);
                    String dlcostcenter = ddlCostcenter.SelectedValue.ToString();
                   emp.fromspecialcase = null;
                 emp.tospecialcase= null;
                    int specialcase = 0;
                    if (chkspecialCase.Checked == true)
                    {
                        specialcase = 1;
                        emp.fromspecialcase = Convert.ToDateTime(txtfromdate.Text);
                        emp.tospecialcase = Convert.ToDateTime(txttodate.Text);
                    }
                    
                    if (((CheckBox)fvEmployee.FindControl("ChkDisability")).Checked == true)
                    {
                        ChkDisability = "Y";
                    }
                    else
                    {
                        ChkDisability = "N";
                    }

                    string result = tms.UpdateEmployee(emp.id, emp.empCode, Server.HtmlEncode(emp.empName), Server.HtmlEncode(emp.userName), emp.designation, emp.Gender, emp.mobile, emp.phone, Server.HtmlEncode(emp.email), emp.attrited, emp.tptReq, emp.managerId, emp.facilityId, emp.processId, emp.subProcessId, emp.nodalId, Server.HtmlEncode(emp.address), Server.HtmlEncode(emp.pincode), geocodeId, MyApplicationSession._UserID, specialcase, ddlCostcenter.SelectedValue, Convert.ToInt32(ddldvman.SelectedValue), emp.fromspecialcase, emp.tospecialcase, ChkDisability).ElementAtOrDefault(0).result.Value.ToString();
                    tms.AddEmpAuditLog(emp.id, columnName, MyApplicationSession._UserID);
                    if (result.Equals("0"))
                    {
                        lblMsg.Visible = true;
                        lblMsg.Text = "Employee Already Exists!!!";

                    }
                    else
                    {
                        lblMsg.Text = "Details Saved Successfully!!!";
                        lblMsg.Visible = true;
                        MultiView1.ActiveViewIndex = 0;
                    }
                }
                else
                {
                    emp.email = ((TextBox)fvEmployee.FindControl("txtdvEmail")).Text;
                    emp.empName = ((TextBox)fvEmployee.FindControl("txtdvEmpName")).Text;
                    emp.mobile = ((TextBox)fvEmployee.FindControl("txtdvMobile")).Text;
                    emp.phone = ((TextBox)fvEmployee.FindControl("txtdvPhone")).Text;
                    emp.userName = ((TextBox)fvEmployee.FindControl("txtdvUserName")).Text;
                    if (((CheckBox)fvEmployee.FindControl("chkdvAttrited")).Checked == true)
                    {
                        emp.attrited = 'Y';
                    }
                    else
                    {
                        emp.attrited = 'N';
                    }
                    if (((CheckBox)fvEmployee.FindControl("ChkDisability")).Checked == true)
                    {
                        ChkDisability = "Y";
                    }
                    else
                    {
                        ChkDisability = "N";
                    }

                    if (((RadioButton)fvEmployee.FindControl("rdbtndvM")).Checked == true)
                    {
                        emp.Gender = "Male";
                    }
                    else
                    {
                        if (((RadioButton)fvEmployee.FindControl("rdbtndvO")).Checked == true)
                        {
                            emp.Gender = "Other";
                        }
                        else if (((RadioButton)fvEmployee.FindControl("rdbtndvT")).Checked == true)
                        {
                            emp.Gender = "TG";
                        }
                        else
                        {
                            emp.Gender = "Female";

                        }
                    }

                    if (((CheckBox)fvEmployee.FindControl("chkdvTptReq")).Checked == true)
                    {

                        emp.tptReq = 'Y';


                    }
                    else
                    {
                        emp.tptReq = 'N';
                    }

                    emp.managerId = ((DropDownList)fvEmployee.FindControl("ddldvManager")).SelectedValue;
                    emp.processId = Convert.ToInt32(((DropDownList)fvEmployee.FindControl("ddldvProcess")).SelectedValue);
                    emp.subProcessId = Convert.ToInt32(((DropDownList)fvEmployee.FindControl("ddldvSubProcess")).SelectedValue);
                    emp.facilityId = Convert.ToInt32(((DropDownList)fvEmployee.FindControl("ddldvFacility")).SelectedValue);
                    //emp.nodalId = Convert.ToInt32(((DropDownList)fvEmployee.FindControl("ddlNodal")).SelectedValue);
                    emp.nodalId = 0;
                    DropDownList ddlland = (DropDownList)fvadress.FindControl("ddldvLandmark");
                    int geocodeId = 0;
                    if (ddlland.SelectedValue != "")
                    {
                        geocodeId = Convert.ToInt32(ddlland.SelectedValue);
                    }
                    emp.address = ((TextBox)fvadress.FindControl("txtdvAddress")).Text;
                    emp.pincode = ((TextBox)fvadress.FindControl("txtdvPincode")).Text;
                    DropDownList ddldvman = (DropDownList)fvEmployee.FindControl("ddldvisionManager");
                    DropDownList ddlCostcenter = (DropDownList)fvEmployee.FindControl("ddlCostcenter");

                    CheckBox chkspecialCase = ((CheckBox)fvEmployee.FindControl("chkspecialCase"));
                    TextBox txtfromdate = ((TextBox)fvEmployee.FindControl("txtFromDate"));
                    TextBox txttodate = ((TextBox)fvEmployee.FindControl("txttoDate"));
                    int dvmanager = Convert.ToInt32(ddldvman.SelectedValue);
                    String dlcostcenter = ddlCostcenter.SelectedValue.ToString();
                    emp.fromspecialcase = null;
                    emp.tospecialcase = null;
                    int specialcase = 0;
                    if (chkspecialCase.Checked == true)
                    {
                        specialcase = 1;
                        emp.fromspecialcase = Convert.ToDateTime(txtfromdate.Text);
                        emp.tospecialcase = Convert.ToDateTime(txttodate.Text);
                    }
                    string result = tms.InsertEmployee(emp.id, emp.empCode, Server.HtmlEncode(emp.empName), Server.HtmlEncode(emp.userName), emp.designation, emp.Gender, emp.mobile, emp.phone, Server.HtmlEncode(emp.email), emp.attrited, emp.tptReq, emp.managerId, emp.facilityId, emp.processId, emp.subProcessId, emp.nodalId, Server.HtmlEncode(emp.address), Server.HtmlEncode(emp.pincode), geocodeId, MyApplicationSession._UserID, specialcase, ddlCostcenter.SelectedValue, Convert.ToInt32(ddldvman.SelectedValue), emp.fromspecialcase, emp.tospecialcase, ChkDisability).ElementAtOrDefault(0).result.Value.ToString();
                    if (result.Equals("0"))
                    {
                        lblMsg.Visible = true;
                        lblMsg.Text = "Partner Already Exists!!!";

                    }
                    else
                    {
                        lblMsg.Text = "Details Saved Successfully!!!";
                        lblMsg.Visible = true;
                        MultiView1.ActiveViewIndex = 0;
                    }
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

    protected void btnClose_Click(object sender, EventArgs e)
    {
        MultiView2.ActiveViewIndex = -1;
        lblMsg.Visible = false;
        ModalPopupExtender1.Hide();

    }

    void ValidateLandmark(object val, ServerValidateEventArgs args)
    {
        string textval = ((TextBox)fvadress.FindControl("txtdvAddress")).Text;
        if (((CheckBox)fvEmployee.FindControl("chkdvTptReq")).Checked == true)
            if ((((TextBox)fvadress.FindControl("txtdvAddress")).Text == "") || (((DropDownList)fvadress.FindControl("ddldvLandmark")).SelectedValue == "0"))
            {
                args.IsValid = false;
                ModalPopupExtender1.Show();
                TabPanel2.Focus();
                AJX.ActiveTab = TabPanel2;
            }
            else
                args.IsValid = true;
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        ValidateLandmark(source, args);

    }
    protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
    {
        ValidateLandmark(source, args);
    }
    protected void chkspecialCase_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkspecialCase = ((CheckBox)fvEmployee.FindControl("chkspecialCase"));
        TextBox txtfromdate = ((TextBox)fvEmployee.FindControl("txtFromDate"));
        TextBox txttodate = ((TextBox)fvEmployee.FindControl("txttoDate"));
        Label lblfrmdate = ((Label)fvEmployee.FindControl("lblFromDate"));
        Label lbltodate = ((Label)fvEmployee.FindControl("lbltoDate"));
        RequiredFieldValidator r1 = ((RequiredFieldValidator)fvEmployee.FindControl("RequiredFieldValidator4"));
        RequiredFieldValidator r2 = ((RequiredFieldValidator)fvEmployee.FindControl("RequiredFieldValidator5"));
        CompareValidator c2 = ((CompareValidator)fvEmployee.FindControl("CompareValidator2"));
        RegularExpressionValidator img1 = ((RegularExpressionValidator)fvEmployee.FindControl("RegularExpressionValidator3"));
        RegularExpressionValidator img2 = ((RegularExpressionValidator)fvEmployee.FindControl("RegularExpressionValidator4"));
        if (chkspecialCase.Checked == true)
        {
            txtfromdate.Visible = true;
            txttodate.Visible = true;
            lblfrmdate.Visible = true;
            lbltodate.Visible = true;
            img1.Enabled = true;
            img2.Enabled = true;
            r1.Enabled = true;
            r2.Enabled = true;
            c2.Enabled = true;
        }
        else
        {
            txtfromdate.Visible = false;
            txttodate.Visible = false;
            lblfrmdate.Visible = false;
            lbltodate.Visible = false;
            img1.Enabled = false;
            img2.Enabled = false;
            r1.Enabled = false;
            r2.Enabled = false;
            c2.Enabled = false;
        
        }
        ModalPopupExtender1.Show();


    }
    void showhidespecialcase()
    {
        CheckBox chkspecialCase = ((CheckBox)fvEmployee.FindControl("chkspecialCase"));
        TextBox txtfromdate = ((TextBox)fvEmployee.FindControl("txtFromDate"));
        TextBox txttodate = ((TextBox)fvEmployee.FindControl("txttoDate"));
        Label lblfrmdate = ((Label)fvEmployee.FindControl("lblFromDate"));
        Label lbltodate = ((Label)fvEmployee.FindControl("lbltoDate"));
        RequiredFieldValidator r1 = ((RequiredFieldValidator)fvEmployee.FindControl("RequiredFieldValidator4"));
        RequiredFieldValidator r2 = ((RequiredFieldValidator)fvEmployee.FindControl("RequiredFieldValidator5"));
        CompareValidator c2 = ((CompareValidator)fvEmployee.FindControl("CompareValidator2"));
        RegularExpressionValidator img1 = ((RegularExpressionValidator)fvEmployee.FindControl("RegularExpressionValidator3"));
        RegularExpressionValidator img2 = ((RegularExpressionValidator)fvEmployee.FindControl("RegularExpressionValidator4"));
        if (chkspecialCase.Checked == true)
        {
            txtfromdate.Visible = true;
            txttodate.Visible = true;
            lblfrmdate.Visible = true;
            lbltodate.Visible = true;
            img1.Enabled = true;
            img2.Enabled = true;
            r1.Enabled = true;
            r2.Enabled = true;
            c2.Enabled = true;
        }
        else
        {
            txtfromdate.Visible = false;
            txttodate.Visible = false;
            lblfrmdate.Visible = false;
            lbltodate.Visible = false;
            img1.Enabled = false;
            img2.Enabled = false;
            r1.Enabled = false;
            r2.Enabled = false;
            c2.Enabled = false;

        }
        ModalPopupExtender1.Show();
    }
    }
