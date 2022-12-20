using System;
using System.Net;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MapGeocodingMMI : basepage2
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
    public Int32 _changeid
    {
        get
        {
            return (Int32)ViewState["_changeid"];
        }
        set
        {
            ViewState["_changeid"] = value;
        }
    }
    public Int32 _addtype
    {
        get
        {
            return (Int32)ViewState["_addtype"];
        }
        set
        {
            ViewState["_addtype"] = value;
        }
    }

    public Int32 _isModel
    {
        get
        {
            return (Int32)ViewState["_isModel"];
        }
        set
        {
            ViewState["_isModel"] = value;
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
            //Added on 19APR22 for MapMyIndia
            _facId = 1;
            hfToken.Value = GetAuthToken();
            _IsPasePostBack = "false";
        }
    }
    [System.Web.Services.WebMethod]
    public static string GetCurrentToken()
    {
        var result = GetAuthToken();

        return result;
    }

    public static String GetAuthToken()
    {
       
        String Auth_EndPoint = "https://outpost.mapmyindia.com/api/security/oauth/token";
        String Auth_Scope = "";
        String Auth_Flow = "client_credentials";
        String Client_ID = "R51peBj3SKVQ5Keo8RNddkrYlJnRqK3TiYB7e1gCgzEwJGnH9CjpFpUJWLooIZrBsmeOw7OBbd4=";
        //String Client_Secret = "j83gvyzt6x76h8nbkgtk8d7vi";
        String Client_Secret = "9K_q_9Q2GHNRne9yRirSpsSVXu7j0bOfhbYZrz-9TlFROYr4Oc-66bfw1aA4YVeMS4o_s0xKrErVFB-7VKgPuA==";
        String RequestBody = "grant_type=" + Auth_Flow + "&scope=" + Auth_Scope;
        String BasicToken = Convert.ToBase64String(System.Text.ASCIIEncoding.ASCII.GetBytes(Client_ID + ":" + Client_Secret));
        Byte[] data = Encoding.ASCII.GetBytes(RequestBody);

        ////handle getAuth error
       // ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;
        //  System.Net.ServicePointManager.SecurityProtocol |= (SecurityProtocolType)(0xc0 | 0x300 | 0xc00); //SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
       ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

        //ServicePointManager.Expect100Continue = true;
        //ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Ssl3 |
        //                                       SecurityProtocolType.Tls | SecurityProtocolType.Tls11;


        //ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3;
        //System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
        //ServicePointManager.ServerCertificateValidationCallback = (snder, cert, chain, error) => true;


        HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create(Auth_EndPoint);
        req.Method = "POST";
        req.ContentType = "application/x-www-form-urlencoded";
        req.Headers.Add(HttpRequestHeader.Authorization, "Basic " + BasicToken);

        System.IO.Stream requestStream = req.GetRequestStream();
        requestStream.Write(data, 0, data.Length);
        requestStream.Close();

     
        HttpWebResponse HttpResponse = (HttpWebResponse)req.GetResponse();
        System.IO.Stream responseStream = HttpResponse.GetResponseStream();
        System.IO.StreamReader streamReader = new System.IO.StreamReader(responseStream, Encoding.Default);
        String response = streamReader.ReadToEnd();

        streamReader.Close();
        responseStream.Close();
        HttpResponse.Close();
        //dynamic joResponse = JObject.Parse(response);
        //string jwt = joResponse.access_token;
        // string myjsonstring = responseString;
        responseData jsonDe = JsonConvert.DeserializeObject<responseData>(response);
        string jwt = jsonDe.access_token; // Outputs 100
        // Outputs success

        return jwt;
    }
    public class responseData
    {
        public string access_token { get; set; }
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
        //Commented on 21Apr22 Clicked employee was not showing
       // if (_Adrtyp == 2)
       // {
       //     DvEmpGeoDetails.DataSource = tms.GetAddressChangeEmployeebyid(_selectedEmpID);
       //     DvEmpGeoDetails.DataBind();
       ////   ((Label)DvEmpGeoDetails.FindControl("lbldvSubColony")).Text = tms.GetAddressChangeEmployeebyid(_selectedEmpID).ElementAtOrDefault(0).Colony.ToString();

       // }
        //else
        //{
          DvEmpGeoDetails.DataSource = tms.GetEmployee(_selectedEmpID);
          DvEmpGeoDetails.DataBind();
       ((Label)DvEmpGeoDetails.FindControl("lbldvSubColony")).Text = tms.GetEmpGeoDetails(_selectedEmpID).ElementAtOrDefault(0).SubColony.ToString();

        //}

        hfLatitude.Value = ((Label)DvEmpGeoDetails.FindControl("lblGeoY")).Text.ToString();
        hfLongitude.Value = ((Label)DvEmpGeoDetails.FindControl("lblGeoX")).Text.ToString();
        hfAddress.Value = ((Label)DvEmpGeoDetails.FindControl("lbldvAddress")).Text.ToString();
        //pnlShowSearchGrd.Visible = false;
        _IsPasePostBack = "true";
        txtSubcolony.Text = tms.GetEmpGeoDetails(_selectedEmpID).ElementAtOrDefault(0).SubColony.ToString();
        txtLandmark.Text = tms.GetEmpGeoDetails(_selectedEmpID).ElementAtOrDefault(0).landmark.ToString();
        lblgeoY.Text = "(" + ((Label)DvEmpGeoDetails.FindControl("lblGeoY")).Text.ToString() + ")";
        lblgeoX.Text = "(" + ((Label)DvEmpGeoDetails.FindControl("lblGeoX")).Text.ToString() + ")";

        ModalPopupExtender1.Show();
        bndcitydropdown();

    }

    protected void bndcitydropdown()
    {
        ddlCity.Items.Clear();
        ddlCity.Items.Add(new ListItem("--Select--", "0"));
        ddlCity.DataSource = tms.GetGeoCity();
        ddlCity.DataTextField = "city";
        ddlCity.DataValueField = "city";
        ddlCity.DataBind();
        ddlColony.Items.Clear();
        ddlColony.Items.Add(new ListItem("--Select--", "0"));

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
        txtSubcolony.Text = "";
        txtLandmark.Text = "";
        _IsPasePostBack = "false";
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        //string geox = hfgeoX.Value;
        //string geoY = hfLatitude.Value;   //Commented on 21APR22 ->>GMap with MapMyIndia 
        string geox = hfLongitude.Value;
        string geoY = hfLatitude.Value;
        string City = ddlCity.SelectedItem.ToString();
        string Colony = ddlColony.SelectedItem.ToString();
        string subcolony = txtSubcolony.Text;
        string Landmark = txtLandmark.Text;
        if (_Adrtyp == 2)
        {
            tms.SaveAddressChangeMapGeocode(_selectedEmpID, City.Trim(), Colony.Trim(), Landmark.Trim(), geox.Trim(), geoY.Trim(), subcolony.Trim(), MyApplicationSession._UserID);
        }
        else
        {
            tms.SaveMapGeocode(_selectedEmpID, City.Trim(), Colony.Trim(), Landmark.Trim(), geox.Trim(), geoY.Trim(), subcolony.Trim(), MyApplicationSession._UserID);
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