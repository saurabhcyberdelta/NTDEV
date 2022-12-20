using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class MapGeocoding : basepage2
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    public string _IsPasePostBack
    {
        get
        {
            return (string)ViewState["_IsPasePostBack"];
        }

        set
        {
            ViewState["_IsPasePostBack"] = value;
        }
    }

    public string _Latitude
    {
        get
        {
            return (string)ViewState["_Latitude"];
        }

        set
        {
            ViewState["_Latitude"] = value;
        }
    }

    public string _Longitude
    {
        get
        {
            return (string)ViewState["_Longitude"];
        }

        set
        {
            ViewState["_Longitude"] = value;
        }
    }

    public string _Address
    {
        get
        {
            return (string)ViewState["_Address"];
        }

        set
        {
            ViewState["_Address"] = value;
        }
    }

    public Int32 _selectedEmpID
    {
        get
        {
            return (Int32)ViewState["_selectedEmpID"];
        }

        set
        {
            ViewState["_selectedEmpID"] = value;
        }
    }

    public Int32 _facId
    {
        get
        {
            return (Int32)ViewState["_facId"];
        }

        set
        {
            ViewState["_facId"] = value;
        }
    }
    public Int32 _Adrtyp
    {
        get
        {
            return (Int32)ViewState["_Adrtyp"];
        }

        set
        {
            ViewState["_Adrtyp"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BndGVEmpCount();
            BndGVNonEmpCount();
            txtEmpIdName.Focus();
            _IsPasePostBack = "false";
        }
    }

    public void BndGVEmpCount()
    {
        //******************************************************************************//
        //Binds the empcount gridview with the count of employees which are not geocoded//
        //*****************************************************************************//
        try
        {
            _Adrtyp = 1;
            GvEmpCount.Columns[0].HeaderText = "Total No of Employees";
            GvEmpCount.Columns[1].HeaderText = tms.GetEmpCount(Convert.ToInt32(Session["LocationId"].ToString())).ElementAtOrDefault(0).count.Value.ToString();
            GvEmpCount.DataSource = tms.GetNotGeoCodedCount(Convert.ToInt32(Session["LocationId"].ToString())) ;
            GvEmpCount.DataBind();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }
    public void BndGVNonEmpCount()
    {
        //******************************************************************************//
        //Binds the empcount gridview with the count of employees which are not geocoded//
        //*****************************************************************************//
        try
        {
            _Adrtyp = 2;
            gvNotGeocoded.DataSource = tms.getChangeAddressnongeocodedCount();
            gvNotGeocoded.DataBind();
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
        _Adrtyp = 1;
        _facId = 0;
        BndEmpGrid();
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
                if (_Adrtyp == 1)
                {
                    GvEmployee.DataSource = tms.GetEmployeeByFacility(_facId);
                }
                else
                {
                    GvEmployee.DataSource = tms.GetAdressChangeEmployeeByFacility(_facId);
                }
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
                lblMsg.Visible = false;
                pnlShowSearchGrd.Visible = true;

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators               
            throw (ex);

        }

    }

    protected void lbSelectEmp_Click(object sender, EventArgs e)
    {
        pnlShowMap.Visible = true;

        LinkButton lbSelectedEmp = (LinkButton)sender;
        _selectedEmpID = Convert.ToInt32(lbSelectedEmp.CommandArgument);
        if (_Adrtyp == 2)
        {
            DvEmpGeoDetails.DataSource = tms.GetAddressChangeEmployeebyid(_selectedEmpID);
            DvEmpGeoDetails.DataBind();
            ((Label)DvEmpGeoDetails.FindControl("lbldvSubColony")).Text = tms.GetAddressChangeEmployeebyid(_selectedEmpID).ElementAtOrDefault(0).Colony.ToString();
        
        }
        else
        {
            DvEmpGeoDetails.DataSource = tms.GetEmployee(_selectedEmpID);
            DvEmpGeoDetails.DataBind();
            ((Label)DvEmpGeoDetails.FindControl("lbldvSubColony")).Text = tms.GetEmpGeoDetails(_selectedEmpID).ElementAtOrDefault(0).SubColony.ToString();
        
        }
            
        hfLatitude.Value = ((Label)DvEmpGeoDetails.FindControl("lblGeoY")).Text.ToString();
        hfLongitude.Value = ((Label)DvEmpGeoDetails.FindControl("lblGeoX")).Text.ToString();
        hfAddress.Value = ((Label)DvEmpGeoDetails.FindControl("lbldvAddress")).Text.ToString();
        //pnlShowSearchGrd.Visible = false;
        _IsPasePostBack = "true";
        ModalPopupExtender1.Show();
        bndcitydropdown();

    }

    protected void bndcitydropdown()
    {
        ddlCity.Items.Clear();
        ddlCity.Items.Add(new ListItem("--Select--","0"));
         ddlCity.DataSource = tms.GetGeoCity();
            ddlCity.DataTextField = "city";
            ddlCity.DataValueField = "city";
            ddlCity.DataBind();
        ddlColony.Items.Clear();
        ddlColony.Items.Add(new ListItem("--Select--","0"));
 
    }
    protected void ddldvCity_SelectedIndexChanged(object sender, EventArgs e)
    {
        //************************************************************************************//
        //On Selection of City in city dropdown binds the colony and clears landmark dropdown//
        //**********************************************************************************//
        try
        {
            



            string city = ddlCity.SelectedItem.Text;
            
            ddlColony.Items.Clear();
            ListItem licol = new ListItem("Select Colony", "0");

            ddlColony.Items.Add(licol);

            ddlColony.DataSource = tms.GetGeoCityColony(city);
            ddlColony.DataTextField = "colony";
            ddlColony.DataValueField = "colony";
            ddlColony.DataBind();
            ddlColony.Focus();
          


           
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
                ModalPopupExtender1.Hide();
                _IsPasePostBack = "false";
             }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string geox = hfgeoX.Value;
        string geoY = hfgeoY.Value;
        string City = ddlCity.SelectedItem.ToString();
        string Colony =ddlColony.SelectedItem.ToString();
        string subcolony = txtSubcolony.Text;
        string Landmark = txtLandmark.Text;
        if (_Adrtyp == 2)
        {
            tms.SaveAddressChangeMapGeocode(_selectedEmpID, City.Trim(), Colony.Trim(), Landmark.Trim(), geox.Trim(), geoY.Trim(), subcolony.Trim(),MyApplicationSession._UserID);
        }
        else
        {
            tms.SaveMapGeocode(_selectedEmpID, City.Trim(), Colony.Trim(), Landmark.Trim(), geox.Trim(), geoY.Trim(), subcolony.Trim(),MyApplicationSession._UserID);
        }
            BndGVEmpCount();
            BndGVNonEmpCount();
        BndEmpGrid();
    }

    protected void lbtnFac_Click(object sender, EventArgs e)
    {
        _Adrtyp = 1;
        LinkButton lbtnFac = (LinkButton)sender;
        _facId = Convert.ToInt32(lbtnFac.CommandArgument);
        BndEmpGrid();
    }
    protected void lbtnNonGeocodeFac_Click(object sender, EventArgs e)
    {
        _Adrtyp = 2;
        LinkButton lbtnNonGeocodeFac = (LinkButton)sender;
        _facId = Convert.ToInt32(lbtnNonGeocodeFac.CommandArgument);
        BndEmpGrid();
    }
    protected void GvEmployee_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GvEmployee.PageIndex = e.NewPageIndex;
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

}


