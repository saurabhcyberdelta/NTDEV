using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OperationsCompliance : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();

    public string _routeid
    {
        get
        {
            return (string)ViewState["_routeid"];
        }

        set
        {
            ViewState["_routeid"] = value;
        }
    }

    public string _save
    {
        get
        {
            return (string)ViewState["_save"];
        }

        set
        {
            ViewState["_save"] = value;
        }
    }
    routeDet rd = new routeDet();
    route r = new route();
    static int size = 0;
    static string[,] arr = new string[size, 3];
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                bndfacilitydrop();
                txtShiftDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                lblRouteId.Text = GetRoutePreFix();
                txtRouteId.Focus();
                _save = "False";
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    protected void bndfacilitydrop()
    {
        ddlSelectFacility.Items.Clear();
        ddlSelectFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
        ddlSelectFacility.DataTextField = "facilityName";
        ddlSelectFacility.DataValueField = "Id";
        ddlSelectFacility.DataBind();
        ListItem liFacIn = new ListItem("-Select-", "0");
        ddlSelectFacility.Items.Insert(0, liFacIn);

        ddlSelectFacility.SelectedIndex = ddlSelectFacility.Items.IndexOf(ddlSelectFacility.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));


    }
    public void BndFvtrip()
    {
        //**************************************************//
        //Binds Trip Formview with the searched routeId //
        //**************************************************//
        try
        {
            fvTrip.DataSource = tms.GetRouteInfo(_routeid);
            fvTrip.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }
  

    public void DateChanged()
    {
        //*********************************************************//
        //Displayes route id prefix according to the date selected //
        //********************************************************//
        try
        {
            lblRouteId.Text = GetRoutePreFix();
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
        //**************************************************//
        //Displayes the searched route information        //
        //**************************************************//
        try
        {
            _routeid = GetRouteID(); ;
            //_routeid = "0518R0000005";
            //txtRouteId.Text = string.Empty;
            //txtRouteId.Text = _routeid.ToString();
            int count;
            count = tms.GetRouteInfo(_routeid).Count();
            if (count > 0)
            {
                MultiView1.ActiveViewIndex = 0;
                lblErrorMsg.Visible = false;

                BndFvtrip();


              //  fvTrip.ChangeMode(FormViewMode.ReadOnly);

              
                panelLink.Visible = true;

                 txtRouteId.Focus();
                 DropDownList ddlPenalty = (DropDownList)fvTrip.FindControl("ddlPenalty");
                 ddlPenalty.DataSource = tms.GetPenaltyType();
                 ddlPenalty.DataTextField = "HeadName";
                 ddlPenalty.DataValueField = "ID";
                 ddlPenalty.DataBind();
                 string id = tms.GetRouteInfo(_routeid).ElementAtOrDefault(0).PenaltyID.ToString();
                 ddlPenalty.SelectedIndex = ddlPenalty.Items.IndexOf(ddlPenalty.Items.FindByValue(id));
    

            }
            else
            {
                ShowMessage("No Record Found!!!");
                lblErrorMsg.Text = "No Record Found!!!";
                txtRouteId.Focus();
                txtRouteId.Text = string.Empty;
                lblErrorMsg.Visible = true;
                panelLink.Visible = false;


            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    private string GetRouteID()
    {
        string routeno;
        int count;
        DateTime dt1 = Convert.ToDateTime("01/01/2010");
        DateTime dt2 = Convert.ToDateTime(txtShiftDate.Text);

        TimeSpan ts = dt2 - dt1;
        string days = Convert.ToString(ts.Days);
        if (days.Length < 4)
        {
            days = '0' + days;
        }

        string Facility = Convert.ToString(ddlSelectFacility.SelectedValue);
        if (Facility.Length < 2)
        {
            Facility = '0' + Facility;
        }

        routeno = string.Empty;
        routeno = Facility + days + "R";
        //routeno = days + "R";
        count = txtRouteId.Text.ToString().Trim().Length;
        string txtInput = txtRouteId.Text.ToString().Trim();

        // code for the split routeID
        if (txtInput.Substring((txtInput.Length - 1), 1).ToUpper() == "S")
        {
            count = count - 1;
        }
        for (int i = 1; i <= 4 - count; i++)
        {
            routeno += "0";
        }
        routeno += txtRouteId.Text.ToString();
        return routeno;
    }

    private string GetRoutePreFix()
    {
        string routeno;
        DateTime dt1 = Convert.ToDateTime("01/01/2010");
        DateTime dt2 = Convert.ToDateTime(txtShiftDate.Text);

        TimeSpan ts = dt2 - dt1;
        string days = Convert.ToString(ts.Days);
        if (days.Length < 4)
        {
            days = '0' + days;
        }

        string Facility = Convert.ToString(ddlSelectFacility.SelectedValue);
        if (Facility.Length < 2)
        {
            Facility = '0' + Facility;
        }

        routeno = string.Empty;
        routeno = Facility + days + "R";
        return routeno;
    }


  
  

   
  
  
   
    protected void btnSave_Click(object sender, EventArgs e)
    {
        //*************************************************************//
        //Saves the route information into the DB   //
        //*************************************************************//

        DropDownList ddlPenalty = (DropDownList)fvTrip.FindControl("ddlPenalty");
        TextBox txtvehicle = (TextBox)fvTrip.FindControl("txtVehicle");
        int penaltyid = Convert.ToInt32(ddlPenalty.SelectedValue);
        Label penaltyamount = (Label)fvTrip.FindControl("lblPenalty");
        string amount = penaltyamount.Text;
        TextBox textremarks = (TextBox)fvTrip.FindControl("txtRemarks");
        tms.UpdateOperationPenalty(penaltyid, Convert.ToInt32(amount), _routeid,textremarks.Text,txtvehicle.Text,MyApplicationSession._UserID);
        ShowMessage("Penalty Saved Successfully");
        txtRouteId.Text="";
        txtRouteId.Focus();
        MultiView1.ActiveViewIndex = -1;
     
    }

   

    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
   
 
    protected void ddlSelectFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblRouteId.Text = GetRoutePreFix();
        txtRouteId.Text = String.Empty;
        txtRouteId.Focus();
        MultiView1.ActiveViewIndex = -1;


    }

    protected void ddlPenalty_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlPenalty = (DropDownList)fvTrip.FindControl("ddlPenalty");
        int penaltyid = Convert.ToInt32(ddlPenalty.SelectedValue);
        Label penaltyamount = (Label)fvTrip.FindControl("lblPenalty");
        if (penaltyid != 0)
        {
            string penalty = tms.gerPenaltyAmount(penaltyid).ElementAtOrDefault(0).Penalty.ToString();
            penaltyamount.Text = penalty;
        }
        else
        {
            penaltyamount.Text = "0";
        
        }
        }
}

