using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GeoCode : basepage
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

    public int _facId
    {
        get
        {
            return (int)ViewState["_facId"];
        }

        set
        {
            ViewState["_facId"] = value;
        }
    }

    public int _PageIndex
    {
        get
        {
            return (int)ViewState["_PageIndex"];
        }

        set
        {
            ViewState["_PageIndex"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                BndGVEmpCount();
                txtEmpIdName.Focus();

            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }
    public void BndGVEmpCount()
    {
        //******************************************************************************//
        //Binds the empcount gridview with the count of employees which are not geocoded//
        //*****************************************************************************//
        try
        {
            MultiView2.ActiveViewIndex = -1;
            GvEmpCount.Columns[0].HeaderText = "Total No of Partners";
            GvEmpCount.Columns[1].HeaderText = tms.GetEmpCount(Convert.ToInt32(Session["LocationId"].ToString())).ElementAtOrDefault(0).count.Value.ToString();
            GvEmpCount.DataSource = tms.GetNotGeoCodedCount(Convert.ToInt32(Session["LocationId"].ToString()));
            GvEmpCount.DataBind();
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
        //empIdName = txtEmpIdName.Text;           
        _facId = 0;
        BndEmpGrid();
        gdsearchgecode.DataSource = null;
        txtSearchaddr.Text = null;
    }
    public void BndEmpGrid()
    {
        //********************************************************************//
        //Binds the employee grid with the search results for an employee     //
        //********************************************************************//
        try
        {
            if (_facId <= 0)
            {
                GvEmployee.DataSource = tms.EmpSearch(txtEmpIdName.Text, MyApplicationSession._LocationId, MyApplicationSession._ISAdmin);
            }
            else
            {
                GvEmployee.DataSource = tms.GetEmployeeByFacility(_facId);
            }

            GvEmployee.DataBind();
            if (GvEmployee.Rows.Count < 1)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "No Record Found!!!";
            }
            else
            {
                GvEmployee.EditIndex = -1;
                _PageIndex = GvEmployee.PageIndex;
                lblMsg.Visible = false;
                lblSearchaddr.Visible = false;
                txtSearchaddr.Visible = false;
                btnSearchaddr.Visible = false;
                MultiView1.ActiveViewIndex = 0;

            }
            BndGVEmpCount();
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
        GvEmployee.PageIndex = e.NewPageIndex;
        BndEmpGrid();
    }

    protected void GvEmployee_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        //**********************************************************************************//
        //On selection of an employee opens the geo details view to add/edit the geo details//
        //*********************************************************************************//
        try
        {
            lblSearchaddr.Visible = true;
            txtSearchaddr.Visible = true;
            txtSearchaddr.Text = String.Empty;
            btnSearchaddr.Visible = true;
            gdsearchgecode.DataSource = null;
            gdsearchgecode.DataBind();
            gdsearchgecode.Visible = false;
            MultiView1.ActiveViewIndex = 1;

            lblMsg.Visible = false;

            _empId = Convert.ToInt32(GvEmployee.DataKeys[e.NewSelectedIndex].Values[0].ToString());
            string empName = GvEmployee.DataKeys[e.NewSelectedIndex].Values[1].ToString();
            //int count = Convert.ToInt32(tms.GetEmpGeoDetails(empId).Count());
            //if (count == 0)
            //{
            //    DvGeo.HeaderText = "Add Employee Geo Details";
            //    BndGeoDv();
            //}
            //else
            //{
            DvGeo.HeaderText = "Edit Geo Details :- " + empName;
            DvGeo.DataBind();
            //BndGeoDv();
            int id = Convert.ToInt32(tms.GetEmployee(_empId).ElementAtOrDefault(0).geoCodeId.ToString());
            string str = tms.GetLandMarkGeoCode(id).ElementAtOrDefault(0).geoX.ToString();

            ((Label)DvGeo.FindControl("lblX")).Text = str.ToString();
            ((Label)DvGeo.FindControl("lblY")).Text = tms.GetLandMarkGeoCode(id).ElementAtOrDefault(0).geoY.ToString();
            ((Label)DvGeo.FindControl("lbldvAddress")).Text = tms.GetEmployee(_empId).ElementAtOrDefault(0).address.ToString();

            string city = tms.GetEmpGeoDetails(_empId).ElementAtOrDefault(0).city.ToString();
            string col = tms.GetEmpGeoDetails(_empId).ElementAtOrDefault(0).colony.ToString();
            string subcol = tms.GetEmpGeoDetails(_empId).ElementAtOrDefault(0).SubColony.ToString();
            string land = tms.GetEmpGeoDetails(_empId).ElementAtOrDefault(0).landmark.ToString();

            DropDownList ddlCity = (DropDownList)DvGeo.FindControl("ddldvCity");
            ddlCity.Items.Clear();
            ListItem licity = new ListItem("Select City", "0");
            ddlCity.Items.Add(licity);

         

            ddlCity.DataSource = tms.GetGeoCity();
            ddlCity.DataTextField = "city";
            ddlCity.DataValueField = "city";
            ddlCity.DataBind();
            ddlCity.SelectedIndex = ddlCity.Items.IndexOf(ddlCity.Items.FindByText(city.ToString()));
            DropDownList ddlcol = (DropDownList)DvGeo.FindControl("ddldvColony");
            ddlcol.Items.Clear();
            ListItem licol = new ListItem("Select Colony", "0");
            ddlcol.Items.Add(licol);
           
            ddlcol.DataSource = tms.GetGeoCityColony(city);
            ddlcol.DataTextField = "colony";
            ddlcol.DataValueField = "colony";
            ddlcol.DataBind();
            ddlcol.SelectedIndex = ddlcol.Items.IndexOf(ddlcol.Items.FindByText(col.ToString()));
            DropDownList ddlSubcol = (DropDownList)DvGeo.FindControl("ddldvSubColony");
            ddlSubcol.Items.Clear();
            ListItem lisubcol = new ListItem("Select Block/Sectors", "0");
            ddlSubcol.Items.Add(lisubcol);
            
            ddlSubcol.DataSource = tms.GetGeoSubColony(col, city);
            ddlSubcol.DataTextField = "SubColony";
            ddlSubcol.DataValueField = "SubColony";
            ddlSubcol.DataBind();
            ddlSubcol.SelectedIndex = ddlSubcol.Items.IndexOf(ddlSubcol.Items.FindByText(subcol.ToString()));
            DropDownList ddlland = (DropDownList)DvGeo.FindControl("ddldvLandmark");
            ddlland.Items.Clear();
            ListItem liland = new ListItem("Select LandMark", "0");
            ddlland.Items.Add(liland);
          
            ddlland.DataSource = tms.GetGeoColonyLandmark(col, subcol, city);
            ddlland.DataTextField = "landmark";
            ddlland.DataValueField = "Id";
            ddlland.DataBind();
            ddlland.SelectedIndex = ddlland.Items.IndexOf(ddlland.Items.FindByText(land.ToString()));
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
        //Binds the geo detailsview with the geo details of the employee     //
        //********************************************************************//
        try
        {
            lblSearchaddr.Visible = true;
            txtSearchaddr.Visible = true;
            btnSearchaddr.Visible = true;
            MultiView1.ActiveViewIndex = 1;
            LinkButton lbtnColony = (LinkButton)DvGeo.FindControl("lbtncolony");
            LinkButton lbtnSubcolony = (LinkButton)DvGeo.FindControl("lbtnSubcolony");
            LinkButton lbtnLandmark = (LinkButton)DvGeo.FindControl("lbtnLandmark");
            lbtnColony.Visible = false;
            lbtnSubcolony.Visible = false;
            lbtnLandmark.Visible = false;
            Label txt = (Label)DvGeo.FindControl("lbldvAddress");
            DropDownList ddlCity = (DropDownList)DvGeo.FindControl("ddldvCity");
            ddlCity.Items.Clear();
            
            ListItem licity = new ListItem("Select City", "0");
            
            ddlCity.Items.Add(licity);
           
            ddlCity.DataSource = tms.GetGeoCity();
            ddlCity.DataTextField = "city";
            ddlCity.DataValueField = "city";
            ddlCity.DataBind();

            DropDownList ddlcol = (DropDownList)DvGeo.FindControl("ddldvColony");
            ddlcol.Items.Clear();
            ListItem licol = new ListItem("Select Colony", "0");
            ddlcol.Items.Add(licol);
           

            DropDownList ddlSubcol = (DropDownList)DvGeo.FindControl("ddldvSubColony");
            ddlSubcol.Items.Clear();
            ListItem liSubcol = new ListItem("Select Block/Sectors", "0");
            ddlSubcol.Items.Add(liSubcol);
            

            DropDownList ddlland = (DropDownList)DvGeo.FindControl("ddldvLandmark");
            ddlland.Items.Clear();
            ListItem liland = new ListItem("Select LandMark", "0");
            ddlland.Items.Add(liland);
          

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
        //********************************************************************//
        //Changes view index and clears the geo detailview field          s//
        //********************************************************************//
        try
        {
            ((Label)DvGeo.FindControl("lbldvAddress")).Text = string.Empty;

            ((Label)DvGeo.FindControl("lblX")).Text = string.Empty;
            ((Label)DvGeo.FindControl("lblY")).Text = string.Empty;
            BndEmpGrid();
            lblMsg.Visible = false;
            lblSearchaddr.Visible = false;
            txtSearchaddr.Visible = false;
            btnSearchaddr.Visible = false;
            MultiView1.ActiveViewIndex = 0;
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
        //************************************************************************************//
        //On Selection of City in city dropdown binds the colony and clears landmark dropdown//
        //**********************************************************************************//
        try
        {
            DropDownList ddlcity = (DropDownList)DvGeo.FindControl("ddldvCity");
            
           

                string city = ddlcity.SelectedItem.Text;
                DropDownList ddlcol = (DropDownList)DvGeo.FindControl("ddldvColony");
                ddlcol.Items.Clear();
                ListItem licol = new ListItem("Select Colony", "0");
                
                ddlcol.Items.Add(licol);
               
                ddlcol.DataSource = tms.GetGeoCityColony(city);
                ddlcol.DataTextField = "colony";
                ddlcol.DataValueField = "colony";
                ddlcol.DataBind();
                ddlcol.Focus();
                LinkButton lbtnColony = (LinkButton)DvGeo.FindControl("lbtncolony");
                if (ddlcol.Items.Count > 1)
                {
                    
                    lbtnColony.Visible = true;
                }
                else
                {
                    lbtnColony.Visible = false;
                }

                DropDownList ddlSubcol = (DropDownList)DvGeo.FindControl("ddldvSubColony");
                ddlSubcol.Items.Clear();
                ListItem liSubcol = new ListItem("Select Block/Sectors", "0");
                ddlSubcol.Items.Add(liSubcol);
                
                DropDownList ddlland = (DropDownList)DvGeo.FindControl("ddldvLandmark");
                ddlland.Items.Clear();
                ListItem liland = new ListItem("Select LandMark", "0");
                ddlland.Items.Add(liland);
              
                ((Label)DvGeo.FindControl("lblX")).Text = string.Empty;
                ((Label)DvGeo.FindControl("lblY")).Text = string.Empty;
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
        //************************************************************************************//
        //On Selection  colony dropdown binds the landmark dropdown//
        //**********************************************************************************//
        
        try
        {
            DropDownList ddlcity = (DropDownList)DvGeo.FindControl("ddldvCity");
            string city = ddlcity.SelectedItem.Text;
        
            DropDownList ddlcol = (DropDownList)DvGeo.FindControl("ddldvColony");
            string col = ddlcol.SelectedItem.Text;
           

                DropDownList ddlSubcol = (DropDownList)DvGeo.FindControl("ddldvSubColony");
                ddlSubcol.Items.Clear();
                ListItem liland = new ListItem("Select Block/Sectors", "0");
                
                ddlSubcol.Items.Add(liland);
                
                ddlSubcol.DataSource = tms.GetGeoSubColony(col, city);
                ddlSubcol.DataTextField = "SubColony";
                ddlSubcol.DataValueField = "SubColony";
                ddlSubcol.DataBind();
                ddlSubcol.Focus();
                LinkButton lbtnSubcolony = (LinkButton)DvGeo.FindControl("lbtnSubcolony");
                if (ddlSubcol.Items.Count > 1)
                {
                    lbtnSubcolony.Visible = true;
                }
                else
                {
                    lbtnSubcolony.Visible = false;
                }
                DropDownList ddlland = (DropDownList)DvGeo.FindControl("ddldvLandmark");
                ddlland.Items.Clear();
                ListItem liland1 = new ListItem("Select LandMark", "0");
                ddlland.Items.Add(liland1);
              

                //DropDownList ddlland = (DropDownList)DvGeo.FindControl("ddldvLandmark");
                //ddlland.Items.Clear();
                //ListItem liland = new ListItem("Select LandMark", "0");
                //ddlland.Items.Add(liland);
                //ddlland.DataSource = tms.GetGeoColonyLandmark(col, "", city);
                //ddlland.DataTextField = "landmark";
                //ddlland.DataValueField = "Id";
                //ddlland.DataBind();
                //ddlland.Focus();
                ((Label)DvGeo.FindControl("lblX")).Text = string.Empty;
                ((Label)DvGeo.FindControl("lblY")).Text = string.Empty;
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
        //************************************************************************************//
        //On Selection  Sub colony dropdown binds the landmark dropdown//
        //**********************************************************************************//
        try
        {
            DropDownList ddlcity = (DropDownList)DvGeo.FindControl("ddldvCity");
            string city = ddlcity.SelectedItem.Text;
            DropDownList ddlcol = (DropDownList)DvGeo.FindControl("ddldvColony");
            string col = ddlcol.SelectedItem.Text;
            DropDownList ddlsubcol = (DropDownList)DvGeo.FindControl("ddldvSubColony");
            string subcol = ddlsubcol.SelectedItem.Text;
            DropDownList ddlland = (DropDownList)DvGeo.FindControl("ddldvLandmark");
            ddlland.Items.Clear();
            ListItem liland = new ListItem("Select LandMark", "0");
            
            ddlland.Items.Add(liland);
          
            ddlland.DataSource = tms.GetGeoColonyLandmark(col, subcol, city);
            ddlland.DataTextField = "landmark";
            ddlland.DataValueField = "Id";
            ddlland.DataBind();
            ddlland.Focus();
            LinkButton lbtnLandmark = (LinkButton)DvGeo.FindControl("lbtnLandmark");
            if (ddlland.Items.Count > 1)
            {
                lbtnLandmark.Visible = true;
            }
            else
            {
                lbtnLandmark.Visible = false;
            }

            ((Label)DvGeo.FindControl("lblX")).Text = string.Empty;
            ((Label)DvGeo.FindControl("lblY")).Text = string.Empty;
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
        //************************************************************************************//
        //On Selection of landmark in dropdown displayes geo co-ordinates//
        //**********************************************************************************//
        try
        {
            DropDownList ddlland = (DropDownList)DvGeo.FindControl("ddldvLandmark");
            int Id = Convert.ToInt32(ddlland.SelectedValue);
            if (ddlland.SelectedIndex != 0)
            {
                ((Label)DvGeo.FindControl("lblX")).Text = tms.GetLandMarkGeoCode(Id).ElementAtOrDefault(0).geoX.ToString();
                ((Label)DvGeo.FindControl("lblY")).Text = tms.GetLandMarkGeoCode(Id).ElementAtOrDefault(0).geoY.ToString();
            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }




    protected void GvEmpCount_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //**************************************************************************************//
        //For Selected Facility in Empcount Gridview,binds the Employee Grid with the employees//
        //************************************************************************************//
        try
        {
            lblMsg.Visible = false;
            if (e.CommandName.Equals("Select"))
            {
                //facId = Convert.ToInt32(e.CommandArgument.ToString());
                _facId = Convert.ToInt32(e.CommandArgument.ToString());
                BndEmpGrid();
                lblSearchaddr.Visible = false;
                txtSearchaddr.Visible = false;
                btnSearchaddr.Visible = false;
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

    protected void DvGeo_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        //********************************************************************//
        //Updates the geo detials of the Employee                             //
        //********************************************************************//
        try
        {
            DropDownList ddlland = (DropDownList)DvGeo.FindControl("ddldvLandmark");
            string columnName = string.Empty;
            int geocodeId = Convert.ToInt32(ddlland.SelectedValue);
            if (tms.GetEmployee(_empId).ElementAtOrDefault(0).geoCodeId.ToString() != geocodeId.ToString())
            {
                columnName += "GeoCodeId";

            }
            emp.address = ((Label)DvGeo.FindControl("lbldvAddress")).Text;
            if (tms.GetEmployee(_empId).ElementAtOrDefault(0).address.ToString() != emp.address.ToString())
            {
                columnName += ", address";

            }

            emp.updatedBy = MyApplicationSession._UserID;
            string res = tms.updateEmpGeoCode(emp.address, emp.pincode, geocodeId, _empId, emp.updatedBy).ElementAtOrDefault(0).result.Value.ToString();
            tms.AddEmpAuditLog(_empId, columnName, emp.updatedBy);
            //BndGVEmpCount();
            if (res.Equals("1"))
            {
                GvEmployee.PageIndex = _PageIndex;
                BndEmpGrid();
                lblMsg.Visible = true;
                lblMsg.Text = "Geo-code details has been saved successfully.";
                lblSearchaddr.Visible = false;
                txtSearchaddr.Visible = false;
                btnSearchaddr.Visible = false;
                MultiView1.ActiveViewIndex = 0;
            }
            else
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Error In Saving Details!!!Please Try Again.";
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }

    protected void lbtnFac_Click(object sender, EventArgs e)
    {
        LinkButton lbtnFac = (LinkButton)sender;
        _facId = Convert.ToInt32(lbtnFac.CommandArgument);
        BndEmpGrid();
    }

    protected string CheckImage(object strArg)
    {
        string val = Convert.ToString(strArg);

        if (val == "Y" || val == "y")
        {
            return "Images/GeoCode.gif";
        }
        else
        {
            return "Images/NonGeoCode.gif";
        }
    }

    protected string CheckAlt(object strArg)
    {
        string val = Convert.ToString(strArg);

        if (val == "Y" || val == "y")
        {
            return "Geo-coded";
        }
        else
        {
            return "Not Geo-coded";
        }
    }


    protected void btnSearchaddr_Click(object sender, EventArgs e)
    {
        gdsearchgecode.Visible = true;
        Session["addr"] = txtSearchaddr.Text;
        gdsearchgecode.DataSource = tms.searchgeocode(txtSearchaddr.Text);
        gdsearchgecode.DataBind();
    }
    protected void lbassign_Click(object sender, EventArgs e)
    {
        String str = Session["addr"].ToString();
        gdsearchgecode.DataSource = tms.searchgeocode(str);
        string addr = txtSearchaddr.Text;
        gdsearchgecode.DataBind();
        LinkButton link = (LinkButton)sender;
        GridViewRow gv = (GridViewRow)(link.Parent.Parent);
        //LinkButton CustomerID = (LinkButton)gv.FindControl("lnk_CustomerID");
        Label colony = (Label)gv.FindControl("lblcolonySearch");
        Label Sector = (Label)gv.FindControl("lblblockSearch");
        Label Landmark = (Label)gv.FindControl("lbllandmarkSearch");
        Label city = (Label)gv.FindControl("lblcitySearch");

        DropDownList ddlcity = (DropDownList)DvGeo.FindControl("ddldvCity");
        ddlcity.Text = city.Text;
        bindcolony(ddlcity);
        DropDownList ddlcolony = (DropDownList)DvGeo.FindControl("ddldvColony");
        ddlcolony.Text = colony.Text;
        bindsubcolony(ddlcity, ddlcolony);

        DropDownList ddlSubcolony = (DropDownList)DvGeo.FindControl("ddldvSubColony");
        ddlSubcolony.Text = Sector.Text;
        bindsubcolony(ddlcity, ddlcolony);

        DropDownList ddlland = (DropDownList)DvGeo.FindControl("ddldvLandmark");
        ddlland.Items.Clear();
        ListItem liland = new ListItem("Select LandMark", "0");
        ddlland.Items.Add(liland);
        ddlland.DataSource = tms.GetGeoColonyLandmark(colony.Text, ddlSubcolony.Text, city.Text);
        ddlland.DataTextField = "landmark";
        ddlland.DataValueField = "Id";
        ddlland.DataBind();
        // ddlland.Text = Landmark.Text;
        ddlland.Focus();
        //ddlland.Text = Landmark.Text;
        //bindlandmark(ddlcity, ddlcolony, ddlSector);
        DropDownList ddllandmark = (DropDownList)DvGeo.FindControl("ddldvLandmark");
        //ddllandmark.Text = Landmark.Text;
        ddllandmark.Items.FindByText(Landmark.Text).Selected = true;
        //        ddllandmark.SelectedIndex =Convert.ToInt32(ddllandmark.Items.FindByText(Landmark.Text).Value);
        int Id = Convert.ToInt32(ddllandmark.SelectedValue);
        if (ddllandmark.SelectedIndex != 0)
        {
            ((Label)DvGeo.FindControl("lblX")).Text = tms.GetLandMarkGeoCode(Id).ElementAtOrDefault(0).geoX.ToString();
            ((Label)DvGeo.FindControl("lblY")).Text = tms.GetLandMarkGeoCode(Id).ElementAtOrDefault(0).geoY.ToString();
        }
        gdsearchgecode.DataBind();
        gdsearchgecode.DataSource = "";
        //gdsearchgecode.Dispose();
        txtSearchaddr.Text = null;


    }
    public void bindcolony(DropDownList ddlcity)
    {
        string city = ddlcity.SelectedItem.Text;
        DropDownList ddlcol = (DropDownList)DvGeo.FindControl("ddldvColony");
        ddlcol.Items.Clear();
        ListItem licol = new ListItem("Select Colony", "0");
        ddlcol.Items.Add(licol);
        ddlcol.DataSource = tms.GetGeoCityColony(city);
        ddlcol.DataTextField = "colony";
        ddlcol.DataValueField = "colony";
        ddlcol.DataBind();
        ddlcol.Focus();

        DropDownList ddlSubcol = (DropDownList)DvGeo.FindControl("ddldvSubColony");
        ddlSubcol.Items.Clear();
        ListItem liSubcol = new ListItem("Select Block/Sectors", "0");
        ddlSubcol.Items.Add(liSubcol);

        DropDownList ddlland = (DropDownList)DvGeo.FindControl("ddldvLandmark");
        ddlland.Items.Clear();
        ListItem liland = new ListItem("Select LandMark", "0");
        ddlland.Items.Add(liland);
        ((Label)DvGeo.FindControl("lblX")).Text = string.Empty;
        ((Label)DvGeo.FindControl("lblY")).Text = string.Empty;
    }
    public void bindsubcolony(DropDownList ddlcity, DropDownList ddlcol)
    {
        // DropDownList ddlcity = (DropDownList)DvGeo.FindControl("ddldvCity");
        string city = ddlcity.SelectedItem.Text;
        //DropDownList ddlcol = (DropDownList)DvGeo.FindControl("ddldvColony");
        string col = ddlcol.SelectedItem.Text;

        DropDownList ddlSubcol = (DropDownList)DvGeo.FindControl("ddldvSubColony");
        ddlSubcol.Items.Clear();
        ListItem liland = new ListItem("Select Block/Sectors", "0");
        ddlSubcol.Items.Add(liland);
        ddlSubcol.DataSource = tms.GetGeoSubColony(col, city);
        ddlSubcol.DataTextField = "SubColony";
        ddlSubcol.DataValueField = "SubColony";
        ddlSubcol.DataBind();
        ddlSubcol.Focus();

        DropDownList ddlland = (DropDownList)DvGeo.FindControl("ddldvLandmark");
        ddlland.Items.Clear();
        ListItem liland1 = new ListItem("Select LandMark", "0");
        ddlland.Items.Add(liland1);
    }
    public void bindlandmark(DropDownList ddlcity, DropDownList ddlcol, DropDownList ddlsubcol)
    {
        // DropDownList ddlcity = (DropDownList)DvGeo.FindControl("ddldvCity");
        string city = ddlcity.SelectedItem.Text;
        //DropDownList ddlcol = (DropDownList)DvGeo.FindControl("ddldvColony");
        string col = ddlcol.SelectedItem.Text;
        // DropDownList ddlsubcol = (DropDownList)DvGeo.FindControl("ddldvSubColony");
        string subcol = ddlsubcol.SelectedItem.Text;
        DropDownList ddlland = (DropDownList)DvGeo.FindControl("ddldvLandmark");
        ddlland.Items.Clear();
        ListItem liland = new ListItem("Select LandMark", "0");
        ddlland.Items.Add(liland);
        ddlland.DataSource = tms.GetGeoColonyLandmark(col, subcol, city);
        ddlland.DataTextField = "landmark";
        ddlland.DataValueField = "Id";
        ddlland.DataBind();
        ddlland.Focus();
        ((Label)DvGeo.FindControl("lblX")).Text = string.Empty;
        ((Label)DvGeo.FindControl("lblY")).Text = string.Empty;
    }
    protected void lbSelectEmp_Click(object sender, EventArgs e)
    {

    }
    protected void DvInsertColony_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        
        TextBox txtColony = (TextBox)DvInsertColony.FindControl("txtColony");

        TextBox txtsector = (TextBox)DvInsertColony.FindControl("txtSubColony");
        TextBox txtLandmark = (TextBox)DvInsertColony.FindControl("txtLandmark");
        TextBox txtGeoX = (TextBox)DvInsertColony.FindControl("txtGeoX");
        TextBox txtGeoY = (TextBox)DvInsertColony.FindControl("txtGeoY");
            DropDownList ddlcity = (DropDownList)DvGeo.FindControl("ddldvCity");
             tms.InsertGeoCode(ddlcity.SelectedItem.Text, txtColony.Text, txtsector.Text, txtLandmark.Text, Convert.ToDouble(txtGeoX.Text), Convert.ToDouble(txtGeoY.Text));
             ShowMessage("Geodcode Updated successfully");
             BndGeoDv();
        ModalPopupExtender1.Hide();
             MultiView2.ActiveViewIndex = -1;
        }
    protected void lbtncolony_Click(object sender, EventArgs e)
    {
       
        MultiView2.ActiveViewIndex = 0;
        ModalPopupExtender1.Show();
        //MultiView2.ActiveViewIndex = 0;
        TextBox txtColony = (TextBox)DvInsertColony.FindControl("txtColony");
       
        txtColony.Text = string.Empty;
        txtColony.Enabled = true;
        TextBox txtsector = (TextBox)DvInsertColony.FindControl("txtSubColony");
       
        txtsector.Text = string.Empty;
        txtsector.Enabled = true;
        TextBox txtLandmark = (TextBox)DvInsertColony.FindControl("txtLandmark");
        TextBox txtGeoX = (TextBox)DvInsertColony.FindControl("txtGeoX");
        TextBox txtGeoY = (TextBox)DvInsertColony.FindControl("txtGeoY");
        txtLandmark.Text = string.Empty;
        txtGeoX.Text = string.Empty;
        txtGeoY.Text = string.Empty;

    }
    protected void lbtnSubcolony_Click(object sender, EventArgs e)
    {
        MultiView2.ActiveViewIndex = 0;
        ModalPopupExtender1.Show(); 
        TextBox txtColony = (TextBox)DvInsertColony.FindControl("txtColony");
          DropDownList ddlcolony = (DropDownList)DvGeo.FindControl("ddldvColony");
          txtColony.Text = ddlcolony.SelectedItem.Text;
          txtColony.Enabled = false;
          TextBox txtsector = (TextBox)DvInsertColony.FindControl("txtSubColony");

          txtsector.Text = string.Empty;
          txtsector.Enabled = true;
          TextBox txtLandmark = (TextBox)DvInsertColony.FindControl("txtLandmark");
          TextBox txtGeoX = (TextBox)DvInsertColony.FindControl("txtGeoX");
          TextBox txtGeoY = (TextBox)DvInsertColony.FindControl("txtGeoY");
          txtLandmark.Text = string.Empty;
          txtGeoX.Text = string.Empty;
          txtGeoY.Text = string.Empty;
    }
    protected void lbtnLandmark_Click(object sender, EventArgs e)
    {
        MultiView2.ActiveViewIndex = 0;
        ModalPopupExtender1.Show(); 
        TextBox txtColony = (TextBox)DvInsertColony.FindControl("txtColony");
        DropDownList ddlcolony = (DropDownList)DvGeo.FindControl("ddldvColony");
        txtColony.Text = ddlcolony.SelectedItem.Text;
        txtColony.Enabled = false;
        TextBox txtsector = (TextBox)DvInsertColony.FindControl("txtSubColony");
        DropDownList ddlSubcolony = (DropDownList)DvGeo.FindControl("ddldvSubColony");
        txtsector.Text = ddlSubcolony.SelectedItem.Text;
        txtsector.Enabled = false;
        TextBox txtLandmark = (TextBox)DvInsertColony.FindControl("txtLandmark");
        TextBox txtGeoX = (TextBox)DvInsertColony.FindControl("txtGeoX");
        TextBox txtGeoY = (TextBox)DvInsertColony.FindControl("txtGeoY");
        txtLandmark.Text = string.Empty;
        txtGeoX.Text = string.Empty;
        txtGeoY.Text = string.Empty;
    }
    protected void DvInsertColony_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        ModalPopupExtender1.Hide();
        MultiView2.ActiveViewIndex = -1;
    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
}

