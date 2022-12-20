using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DummyTripSheetEntry : basepage
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

    public string oldvalue
    {
        get
        {
            return (string)ViewState["oldvalue"];
        }

        set
        {
            ViewState["oldvalue"] = value;
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
        ListItem liFacIn = new ListItem("-Select Facility-", "0");
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
            fvTrip.DataSource = tms.GetDummyRouteInfo(_routeid);
            fvTrip.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }
    public void BndFvDropDown()
    {
        //**************************************************//
        //Binds dropdown in trip formview      //
        //**************************************************//
        try
        {

            ListBox lststhh = (ListBox)fvTrip.FindControl("lstStartHH");
            ListBox lststmm = (ListBox)fvTrip.FindControl("lstStartMM");
            ListBox lstendhh = (ListBox)fvTrip.FindControl("lstEndHH");
            ListBox lstendmm = (ListBox)fvTrip.FindControl("lstEndMM");
            DropDownList ddlPenaltyType = (DropDownList)fvTrip.FindControl("ddlPenaltyType");
            DropDownList ddlBillingTripType = (DropDownList)fvTrip.FindControl("ddlBillingTripType");
            DropDownList ddlCostLocation = (DropDownList)fvTrip.FindControl("ddlCostLocation");
            DropDownList ddlShift = (DropDownList)fvTrip.FindControl("ddlShift");
            
            ddlPenaltyType.Items.Clear();
            ListItem livno = new ListItem("-Select-", "0");
            ddlPenaltyType.Items.Add(livno);

            ddlBillingTripType.Items.Clear();
            ListItem livno1 = new ListItem("-Select-", "0");
            ddlBillingTripType.Items.Add(livno1);



            lststhh.Items.Clear();
            lststmm.Items.Clear();
            lstendhh.Items.Clear();
            lstendmm.Items.Clear();
            ddlShift.Items.Clear();
            ddlShift.Items.Add(livno1);
            ListItem lihh = new ListItem("HH", "0");
            ListItem limm = new ListItem("MM", "0");
            ListItem lihh1 = new ListItem("HH", "0");
            ListItem limm1 = new ListItem("MM", "0");
            ListItem liven = new ListItem("-Select-", "0");
            ListItem livt = new ListItem("-Select-", "0");
            lststhh.Items.Add(lihh);
            lstendhh.Items.Add(lihh1);
            lststmm.Items.Add(limm);

            lstendmm.Items.Add(limm1);

            for (int i = 0; i < 24; i++)
            {

                if (i < 10)
                {
                    lststhh.Items.Add("0" + i.ToString());
                    lstendhh.Items.Add("0" + i.ToString());
                }
                else
                {
                    lststhh.Items.Add(i.ToString());
                    lstendhh.Items.Add(i.ToString());
                }
            }
            for (int j = 0; j < 60; j++)
            {
                if (j < 10)
                {
                    lststmm.Items.Add("0" + j.ToString());
                    lstendmm.Items.Add("0" + j.ToString());
                }
                else
                {
                    lststmm.Items.Add(j.ToString());
                    lstendmm.Items.Add(j.ToString());
                }



            }
            lstendhh.SelectedIndex = 0;
            lstendmm.SelectedIndex = 0;
            lststhh.SelectedIndex = 0;
            lststmm.SelectedIndex = 0;



            ListBox lbtoll = (ListBox)fvTrip.FindControl("lbToll");
            lbtoll.Items.Clear();
            ListItem toll = new ListItem("-SELECT--", "0");
            lbtoll.Items.Add(toll);
            lbtoll.DataSource = tms.SelectTollMaster(MyApplicationSession._UserID, "Y", _routeid);
            lbtoll.DataTextField = "tollname";
            lbtoll.DataValueField = "id";
            lbtoll.DataBind();

            ddlPenaltyType.DataSource = tms.GetPenaltyType();
            ddlPenaltyType.DataTextField = "HeadName";
            ddlPenaltyType.DataValueField = "ID";
            ddlPenaltyType.DataBind();
            ddlCostLocation.DataSource = tms.SelectFacility(MyApplicationSession._UserID,MyApplicationSession._ISAdmin);
            ddlCostLocation.DataTextField = "facilityname";
            ddlCostLocation.DataValueField = "id";
            ddlCostLocation.DataBind();
        
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }

    }


    protected void ddlVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        //**************************************************//
        //For Selected Vendor binds the vehicle dropdown //
        //**************************************************//
        try
        {
            DropDownList ddlven = (DropDownList)fvTrip.FindControl("ddlVendor");
            int vendorId = Convert.ToInt32(ddlven.SelectedValue);
            DropDownList ddlvt = (DropDownList)fvTrip.FindControl("ddlVehicleType");
            //DropDownList ddlvno = (DropDownList)fvTrip.FindControl("ddlVehicleNo");
            ListItem livt = new ListItem("-Select-", "0");
            //ddlvno.Items.Clear();
            //ListItem livno = new ListItem("-Select-", "0");
            //ddlvno.Items.Add(livno);
            ddlvt.Items.Clear();
            ddlvt.Items.Add(livt);
            if (ddlven.SelectedIndex != 0)
            {
                ddlvt.DataSource = tms.SelectVehicleType(0);
                ddlvt.DataTextField = "vehicle";
                ddlvt.DataValueField = "Id";
                ddlvt.DataBind();
            }
            ddlvt.Focus();
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
    public void BndEmpGrid()
    {
        //**************************************************//
        //**************************************************//
        try
        {
            GvEmpInfo.DataSource = tms.GetDummyEmpByRoute(_routeid);
            GvEmpInfo.DataBind();

        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }

    }
    public void ddlBillingTripType_SelectedIndexChanged(object sender, EventArgs e)
    {
        //**************************************************//
        //Binds Employee grid for the particular routeid //
        //**************************************************//
        try
        {
            DropDownList ddlBillingTripType = (DropDownList)fvTrip.FindControl("ddlBillingTripType");
            RadioButtonList rdbBillType = (RadioButtonList)fvTrip.FindControl("rdbBillType");

            if (ddlBillingTripType.SelectedValue == "4")
            {
                rdbBillType.Visible = true;
                rdbBillType.SelectedValue = oldvalue;
            }
            else
            {
                rdbBillType.Visible = true;
                rdbBillType.SelectedIndex = -1;
                if (MyApplicationSession._LocationId > 1)
                {
                    rdbBillType.SelectedValue = "1";
                    rdbBillType.Enabled = false;
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
    public void BndEmpGridData()
    {
        //***************************************************************//
        //Binds the employee grid with data to display in read only mode //
        //**************************************************************//
        try
        {
            foreach (GridViewRow gvr in GvEmpInfo.Rows)
            {

                //((TextBox)gvr.FindControl("txtStopNo")).ReadOnly = true;
                ((TextBox)gvr.FindControl("txtgvRemarks")).ReadOnly = true;
                //if (((LinkButton)gvr.FindControl("lbtnRemove")).Visible == true)
                //{
                //    ((Label)gvr.FindControl("lblNew")).Visible = true;
                //    gvr.BackColor = System.Drawing.Color.LightSlateGray;
                //}
              //  ((LinkButton)gvr.FindControl("lbtnRemove")).Visible = false;
                DropDownList ddl = (DropDownList)gvr.FindControl("ddlStatus");

                ddl.SelectedIndex = ddl.Items.IndexOf(ddl.Items.FindByValue(tms.GetDummyEmpByRoute(_routeid).ElementAtOrDefault(gvr.RowIndex).trackingStatus.ToString()));
                if (fvTrip.CurrentMode.ToString() == "Edit")
                {
                    ddl.Enabled = true;

                }
                else
                {
                    ddl.Enabled = false;
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
            count = tms.GetDummyRouteInfo(_routeid).Count();
            if (count > 0)
            {
                MultiView1.ActiveViewIndex = 0;
                lblErrorMsg.Visible = false;

                //var ISAdmin = tms.GetISAdmin(MyApplicationSession._UserID).ElementAtOrDefault(0).result.Value.ToString();

                if ((tms.GetDummyRouteInfo(_routeid).ElementAtOrDefault(0).isFinal == true) && (MyApplicationSession._ISAdmin == false))
                {
                    fvTrip.ChangeMode(FormViewMode.ReadOnly);
                    BndFvtrip();
                    //BndFvDropDown();
                    panelLink.Visible = true;
                    BndEmpGrid();
                    BndEmpGridData();
                    ((CheckBox)fvTrip.FindControl("chkReadGuard")).Enabled = false;
                    btnSave.Enabled = false;
                    imbbtnAddEmp.Enabled = false;
                    btnCancelTrip0.Enabled = false;

                    DropDownList ddlBillingTripType = (DropDownList)fvTrip.FindControl("ddlBillingTripTyperead");
                    ddlBillingTripType.Enabled = false;
                    ddlBillingTripType.DataSource = tms.GetBillingtripType();
                    ddlBillingTripType.DataTextField = "BillingTripType";
                    ddlBillingTripType.DataValueField = "ID";
                    ddlBillingTripType.DataBind();
                    // string trp = tms.GetRouteInfo(_routeid).ElementAtOrDefault(0).BillingTriptype.ToString();

                    var resread = tms.GetRouteInfo(_routeid);
                    foreach (var resultread in resread)
                    {



                        if (resultread.BillingTriptype.ToString() != "")
                        {
                            ddlBillingTripType.SelectedIndex = ddlBillingTripType.Items.IndexOf(ddlBillingTripType.Items.FindByValue(resultread.BillingTriptype.ToString()));
                        }
                        else
                        {
                            ddlBillingTripType.SelectedIndex = ddlBillingTripType.Items.IndexOf(ddlBillingTripType.Items.FindByValue(1.ToString()));

                        }
                        DropDownList ddlCostLocation = (DropDownList)fvTrip.FindControl("ddlCostLocationread");

                        ddlCostLocation.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
                        ddlCostLocation.DataTextField = "facilityname";
                        ddlCostLocation.DataValueField = "id";
                        ddlCostLocation.DataBind();
                        ddlCostLocation.SelectedIndex = ddlCostLocation.Items.IndexOf(ddlCostLocation.Items.FindByValue(resultread.CostLocation.ToString()));
                        ddlCostLocation.Enabled = false;
                        txtRouteId.Focus();

                        ListBox lbtoll = (ListBox)fvTrip.FindControl("lbToll");
                        //DropDownList ddlToll = ((DropDownList)fvTrip.FindControl("ddlToll"));
                        //string tollId = tms.SelectTollByRouteId(_routeid).ElementAtOrDefault(0).Tollname.ToString();
                        var r1 = tms.SelectTollidbyroute(_routeid);
                        //ddlToll.SelectedIndex=ddlToll.Items.IndexOf(ddlToll.Items.FindByValue(r.ElementAtOrDefault(0).tollid.ToString()));
                        TextBox txtVehicleNo = ((TextBox)fvTrip.FindControl("txtVehicleNo"));
                        foreach (var rest in r1)
                        {
                            // ddlToll.SelectedIndex = ddlToll.Items.IndexOf(ddlToll.Items.FindByValue(rest.tollid.ToString()));
                            for (int tollid = 0; tollid < lbtoll.Items.Count; tollid++)
                            {
                                if (lbtoll.Items[tollid].Value.ToString() == rest.tollid.ToString())
                                {
                                    lbtoll.Items[tollid].Selected = true;
                                }
                            }
                        }

                        RadioButtonList rdbBillTypeid = ((RadioButtonList)fvTrip.FindControl("BillType"));
                        //int billcatid = Convert.ToInt32(rdbBillTypeid.SelectedValue);
                        //RadioButtonList rdbBillType = (RadioButtonList)fvTrip.FindControl("rdbBillType");

                        if (ddlBillingTripType.SelectedValue == "4")
                        {
                            rdbBillTypeid.Visible = true;
                        }
                        else
                        {
                            rdbBillTypeid.Visible = false;
                            rdbBillTypeid.SelectedIndex = -1;
                        }
                        if (resultread.billcategoryid > 0)
                        {
                            rdbBillTypeid.SelectedValue = resultread.billcategoryid.ToString();
                        }
                    }

                }
                else
                {
                    tms.DeleteTempEmpFromRoute(_routeid);
                    fvTrip.ChangeMode(FormViewMode.Edit);
                    BndFvtrip();
                    BndFvDropDown();
                    BndEmpGrid();
                    BndEmpGridData();
                    panelLink.Visible = true;



                    TextBox txtCabID = (TextBox)fvTrip.FindControl("txtCabID");
                    DropDownList ddlCostLocation = (DropDownList)fvTrip.FindControl("ddlCostLocation");
                    string vehicleid = tms.GetDummyRouteInfo(_routeid).ElementAtOrDefault(0).vehicleId.ToString();
                    txtCabID.Text = tms.GetDummyRouteInfo(_routeid).ElementAtOrDefault(0).vehicleId.ToString();
                    ddlCostLocation.SelectedIndex = ddlCostLocation.Items.IndexOf(ddlCostLocation.Items.FindByValue(tms.GetDummyRouteInfo(_routeid).ElementAtOrDefault(0).CostLocation.ToString()));

                    TextBox txtVehicleType = (TextBox)fvTrip.FindControl("txtVehicleType");
                    TextBox txtVendor = (TextBox)fvTrip.FindControl("txtVendor");
                    txtVendor.Text = tms.GetDummyRouteInfo(_routeid).ElementAtOrDefault(0).vendorName.ToString();
                    txtVehicleType.Text = tms.GetDummyRouteInfo(_routeid).ElementAtOrDefault(0).Vehicle.ToString();
                    RangeValidator RangeValidatorStartTime = (RangeValidator)fvTrip.FindControl("RangeValidatorStartTime");
                    RangeValidatorStartTime.MinimumValue = Convert.ToDateTime(txtShiftDate.Text).AddDays(-1).ToShortDateString();
                    RangeValidatorStartTime.MaximumValue = Convert.ToDateTime(txtShiftDate.Text).ToShortDateString();

                    RangeValidatorStartTime.ErrorMessage = "Start date should be between " + Convert.ToDateTime(txtShiftDate.Text).AddDays(-1).ToShortDateString() + " and " + Convert.ToDateTime(txtShiftDate.Text).ToShortDateString();

                    RangeValidator RangeValidatorEndTime = (RangeValidator)fvTrip.FindControl("RangeValidatorEndTime");
                    RangeValidatorEndTime.MinimumValue = Convert.ToDateTime(txtShiftDate.Text).AddDays(-1).ToShortDateString();
                    RangeValidatorEndTime.MaximumValue = Convert.ToDateTime(txtShiftDate.Text).ToShortDateString();

                    RangeValidatorEndTime.ErrorMessage = "End date should be between " + Convert.ToDateTime(txtShiftDate.Text).AddDays(-1).ToShortDateString() + " and " + Convert.ToDateTime(txtShiftDate.Text).ToShortDateString();

                    ((TextBox)fvTrip.FindControl("txtStartTime")).Text = Convert.ToDateTime(fvTrip.DataKey[0].ToString()).ToString("MM/dd/yyyy");
                    ((TextBox)fvTrip.FindControl("txtEndTime")).Text = Convert.ToDateTime(fvTrip.DataKey[0].ToString()).ToString("MM/dd/yyyy");


                    ((TextBox)fvTrip.FindControl("txtVehicleReg")).Text = tms.GetDummyRouteInfo(_routeid).ElementAtOrDefault(0).vehicleNo.ToString();


                    ListBox lstStartHH = (ListBox)fvTrip.FindControl("lstStartHH");
                    lstStartHH.SelectedIndex = lstStartHH.Items.IndexOf(lstStartHH.Items.FindByValue(tms.GetDummyRouteInfo(_routeid).ElementAtOrDefault(0).sHH.ToString()));

                    ListBox lstStartMM = (ListBox)fvTrip.FindControl("lstStartMM");
                    lstStartMM.SelectedIndex = lstStartMM.Items.IndexOf(lstStartMM.Items.FindByValue(tms.GetDummyRouteInfo(_routeid).ElementAtOrDefault(0).sMM.ToString()));

                    ListBox lstEndHH = (ListBox)fvTrip.FindControl("lstEndHH");
                    lstEndHH.SelectedIndex = lstEndHH.Items.IndexOf(lstEndHH.Items.FindByValue(tms.GetDummyRouteInfo(_routeid).ElementAtOrDefault(0).eHH.ToString()));

                    ListBox lstEndMM = (ListBox)fvTrip.FindControl("lstEndMM");
                    lstEndMM.SelectedIndex = lstEndMM.Items.IndexOf(lstEndMM.Items.FindByValue(tms.GetDummyRouteInfo(_routeid).ElementAtOrDefault(0).eMM.ToString()));

                    DropDownList ddlPenaltyType = (DropDownList)fvTrip.FindControl("ddlPenaltyType");
                    ddlPenaltyType.SelectedIndex = ddlPenaltyType.Items.IndexOf(ddlPenaltyType.Items.FindByValue(tms.GetDummyRouteInfo(_routeid).ElementAtOrDefault(0).PenaltyID.ToString()));

                    var res = tms.GetDummyRouteInfo(_routeid);
                    foreach (var result in res)
                    {

                        DropDownList ddlBillingTripType = (DropDownList)fvTrip.FindControl("ddlBillingTripType");
                        DropDownList ddlshift = (DropDownList)fvTrip.FindControl("ddlShift");
                        ddlshift.DataSource = tms.GetShiftByFacilityType(Convert.ToInt32(result.FacilityID), tms.GetDummyRouteInfo(_routeid).ElementAtOrDefault(0).tripType.ToString());
                        ddlshift.DataTextField = "Shifttime";
                        ddlshift.DataValueField = "Shifttime";
                        ddlshift.DataBind();

                        ddlBillingTripType.DataSource = tms.GetBillingtripType();
                        ddlBillingTripType.DataTextField = "BillingTripType";
                        ddlBillingTripType.DataValueField = "ID";
                        ddlBillingTripType.DataBind();
                        if (result.BillingTriptype.ToString() != "")
                        {
                            ddlBillingTripType.SelectedIndex = ddlBillingTripType.Items.IndexOf(ddlBillingTripType.Items.FindByValue(result.BillingTriptype.ToString()));
                        }
                        else
                        {
                            ddlBillingTripType.SelectedIndex = ddlBillingTripType.Items.IndexOf(ddlBillingTripType.Items.FindByValue(1.ToString()));

                        }
                        string sgi = result.shiftTime.ToString();
                        ddlshift.SelectedIndex = ddlshift.Items.IndexOf(ddlshift.Items.FindByText(sgi.ToString()));

                        RadioButtonList rdbBillType = (RadioButtonList)fvTrip.FindControl("rdbBillType");
                        //int billcatid = result.billcategoryid;
                        if (ddlBillingTripType.SelectedValue == "4")
                        {
                            rdbBillType.Visible = true;
                        }
                        else
                        {
                            rdbBillType.Visible = false;
                            rdbBillType.SelectedIndex = -1;
                        }
                        if (result.billcategoryid > 0)
                        {
                           
                            if (MyApplicationSession._LocationId > 1)
                            {
                                rdbBillType.SelectedValue = "1";
                                rdbBillType.Enabled = false;
                            }
                            else
                            {
                                rdbBillType.SelectedValue = result.billcategoryid.ToString();
                            }
                            oldvalue = result.billcategoryid.ToString();
                        }

                        TextBox txtPenaltyAmount = (TextBox)fvTrip.FindControl("txtPenaltyAmount");
                        // string cl=tms.GetDummyRouteInfo(_routeid).ElementAtOrDefault(0).CostLocation.ToString();
                        ddlCostLocation.SelectedIndex = ddlCostLocation.Items.IndexOf(ddlCostLocation.Items.FindByValue(result.CostLocation.ToString()));

                        ListBox lbtoll = (ListBox)fvTrip.FindControl("lbToll");
                        var r1 = tms.SelectTollidbyroute(_routeid);
                        //ddlToll.SelectedIndex=ddlToll.Items.IndexOf(ddlToll.Items.FindByValue(r.ElementAtOrDefault(0).tollid.ToString()));
                        TextBox txtVehicleNo = ((TextBox)fvTrip.FindControl("txtVehicleNo"));
                        foreach (var rest in r1)
                        {
                            // ddlToll.SelectedIndex = ddlToll.Items.IndexOf(ddlToll.Items.FindByValue(rest.tollid.ToString()));
                            for (int tollid = 0; tollid < lbtoll.Items.Count; tollid++)
                            {
                                if (lbtoll.Items[tollid].Value.ToString() == rest.tollid.ToString())
                                {
                                    lbtoll.Items[tollid].Selected = true;
                                }
                            }
                        }
                    
                    }
                    btnSave.Enabled = true;
                    imbbtnAddEmp.Enabled = true;
                    btnCancelTrip0.Enabled = true;
                    txtCabID.Focus();
                }
            }
            else
            {
                ShowMessage("No Record Found!!");
                lblErrorMsg.Text = "No Record Found!!!";
                txtRouteId.Text = String.Empty;
                txtRouteId.Focus();
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

        string Facility =Convert.ToString(ddlSelectFacility.SelectedValue);
        if (Facility.Length < 2)
        {
            Facility = '0' + Facility;
        }

        routeno = string.Empty;
        routeno = Facility + days + "R";
        //routeno = days + "R";
        count = txtRouteId.Text.ToString().Trim().Length;
        for (int i = 1; i <= 5 - count; i++)
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


    protected void btnAddEmp_Click(object sender, ImageClickEventArgs e)
    {
        //**************************************************//
        //Opens popup to search and add new employee to route //
        //**************************************************//
        try
        {
            Panel1.Style.Add(HtmlTextWriterStyle.Visibility, "visible");
            GvEmployee.Visible = false;
            lblSearch.Visible = false;
            ddlStopNO.Items.Clear();
            ListItem li = new ListItem("Select Stop No", "0");
            string val = string.Empty;
            ddlStopNO.Items.Add(li);
            for (int i = 0; i <= GvEmpInfo.Rows.Count; i++)
            {
                val = (i + 1).ToString();

                ddlStopNO.Items.Add(val.ToString());

            }
            GetGvData();
            ModalPopupExtender1.Show();
            txtEmpIdName.Focus();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }
    public void GetGvData()
    {

        //**************************************************//
        //Saves the entered data in empinfo gridview into an array //
        //**************************************************//
        try
        {
            size = GvEmpInfo.Rows.Count;
            arr = new string[size, 3];
            for (int i = 0; i < GvEmpInfo.Rows.Count; i++)
            {

                arr[i, 0] = GvEmpInfo.DataKeys[i].Value.ToString();
                arr[i, 1] = ((DropDownList)GvEmpInfo.Rows[i].FindControl("ddlStatus")).SelectedValue;
                arr[i, 2] = ((TextBox)GvEmpInfo.Rows[i].FindControl("txtgvRemarks")).Text;
            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }

    }

    protected void lbtnClose_Click(object sender, EventArgs e)
    {
        ModalPopupExtender1.Hide();
        imbbtnAddEmp.Focus();
    }

    protected void btnEmpSearch_Click(object sender, EventArgs e)
    {
        //*************************************************************//
        //calls the function to bind employee grid with serach criteria //
        //*************************************************************//
        try
        {
            BndManGrid();
            txtEmpIdName.Text = string.Empty;
            ModalPopupExtender1.Show();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }
    public void BndManGrid()
    {

        //*************************************************************//
        // Binds the employee grid with serach criteria //
        //*************************************************************//
        try
        {

            GvEmployee.DataSource = tms.EmpSearch(txtEmpIdName.Text, MyApplicationSession._LocationId,MyApplicationSession._ISAdmin);
            GvEmployee.DataBind();
            if (GvEmployee.Rows.Count < 1)
            {

                lblSearch.Visible = true;
                lblSearch.Text = "No Record Found!!!";
            }
            else
            {
                lblSearch.Visible = false;
                txtEmpIdName.Text = string.Empty;
                GvEmployee.Visible = true;
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
        GvEmployee.PageIndex = e.NewPageIndex;
        BndManGrid();
        ModalPopupExtender1.Show();
    }


    protected void GvEmployee_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        //*************************************************************//
        //Adds the selected employee to the route      //
        //*************************************************************//
        try
        {
            int empId = Convert.ToInt32(GvEmployee.DataKeys[e.NewSelectedIndex].Value.ToString());
            int stopNo = Convert.ToInt32(ddlStopNO.SelectedValue);
            string result = tms.AddEmpToDummyRoute(empId, stopNo, _routeid,MyApplicationSession._UserID).ElementAtOrDefault(0).result.Value.ToString();

            if (result.Equals("1"))
            {
                BndEmpGrid();
                SetGvData();
                imbbtnAddEmp.Focus();
            }
            else
            {
                lblSearch.Text = "Employee Already Exists In TripSheet";
                lblSearch.Visible = true;
                ModalPopupExtender1.Show();

            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }

    public void SetGvData()
    {
        //****************************************************************************//
        //Binds the empinfo grid with the temporarily saved information after postback //
        //***************************************************************************//
        try
        {
            for (int i = 0; i < size; i++)
            {
                for (int j = 0; j < GvEmpInfo.Rows.Count; j++)
                {
                    if (arr[i, 0].ToString().Equals(GvEmpInfo.DataKeys[j].Value.ToString()))
                    {
                        DropDownList ddl = (DropDownList)GvEmpInfo.Rows[j].FindControl("ddlStatus");
                        TextBox txt = (TextBox)GvEmpInfo.Rows[j].FindControl("txtgvRemarks");
                        ddl.SelectedIndex = ddl.Items.IndexOf(ddl.Items.FindByValue(arr[i, 1].ToString()));
                        txt.Text = arr[i, 2].ToString();
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
    protected void GvEmpInfo_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //*************************************************************//
        //Removes the recently added employee from the route   //
        //*************************************************************//
        try
        {
            int empId = Convert.ToInt32(GvEmpInfo.DataKeys[e.RowIndex].Value.ToString());
            tms.DeleteEmpFromRoute(empId, _routeid,MyApplicationSession._UserID,"DummyTripSheet");
            GetGvData();
            BndEmpGrid();
            SetGvData();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }

    protected void txtEndKM_TextChanged(object sender, EventArgs e)
    {
        //*********************************************************************//
        //Calculates the KM travelled by subtracting start km from the end Km  //
        //********************************************************************//
        try
        {
            TextBox txtstart = (TextBox)fvTrip.FindControl("txtStartKM");
            TextBox txtEnd = (TextBox)fvTrip.FindControl("txtEndKM");
            TextBox txtAct = (TextBox)fvTrip.FindControl("txtActKM");
            TextBox txtApp = (TextBox)fvTrip.FindControl("txtAppKM");

            if ((txtEnd.Text.ToString().Trim().Length > 0) && (txtstart.Text.ToString().Trim().Length > 0) && System.Text.RegularExpressions.Regex.IsMatch(txtEnd.Text, @"^\d+(?:\.\d{0,2})?$"))
            {
                txtAct.Text = ((Convert.ToDecimal(txtEnd.Text)) - Convert.ToDecimal(txtstart.Text)).ToString();
                txtApp.Focus();

            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }

    protected void lstEndMM_SelectedIndexChanged(object sender, EventArgs e)
    {
      //  CompDate();
        ListBox lstmm = (ListBox)fvTrip.FindControl("lstEndMM");
        lstmm.Focus();

    }
   

    protected void btnSave_Click(object sender, EventArgs e)
    {
        //*************************************************************//
        //Saves the route information into the DB   //
        //*************************************************************//

        try
        {
            _save = "True";
            checkduplicacy();
          //  CompDate();
            if (_save.Equals("True"))
            {
                if (((TextBox)fvTrip.FindControl("txtEndKm")).Text == "")
                {
                    r.actEndKm = 0;
                }
                else
                {
                    r.actEndKm = Convert.ToInt32(((TextBox)fvTrip.FindControl("txtEndKm")).Text);
                }

                if (((TextBox)fvTrip.FindControl("txtStartKm")).Text == "")
                {
                    r.actStartKm = 0;
                }
                else
                {
                    r.actStartKm = Convert.ToInt32(((TextBox)fvTrip.FindControl("txtStartKm")).Text);
                }

                r.actTotalStop = GvEmpInfo.Rows.Count;
                ListBox lstendmm = (ListBox)fvTrip.FindControl("lstEndMM");
                ListBox lstendhh = (ListBox)fvTrip.FindControl("lstEndHH");
                TextBox txtenddate = (TextBox)fvTrip.FindControl("txtEndTime");
                ListBox lststartmm = (ListBox)fvTrip.FindControl("lstStartMM");
                ListBox lststarthh = (ListBox)fvTrip.FindControl("lstStartHH");
                TextBox txtstartdate = (TextBox)fvTrip.FindControl("txtStartTime");
                r.actVehicleEndTime = Convert.ToDateTime(txtenddate.Text + " " + lstendhh.Text + ":" + lstendmm.Text + ":00");
                r.actVehicleStartTime = Convert.ToDateTime(txtstartdate.Text + " " + lststarthh.Text + ":" + lststartmm.Text + ":00");
                if (((CheckBox)fvTrip.FindControl("chkGuard")).Checked == true)
                {
                    r.guard = "T";

                }
                else
                {
                    r.guard = "F";

                }
                if (((CheckBox)fvTrip.FindControl("chkLastTrip")).Checked == true)
                {
                    r.lastTrip = 1;

                }
                else
                {
                    r.lastTrip = 0;

                }
                r.vehicleId = ((TextBox)fvTrip.FindControl("txtCabID")).Text;
                r.vendorName = ((TextBox)fvTrip.FindControl("txtVendor")).Text;
                string vehicletype = ((TextBox)fvTrip.FindControl("txtVehicleType")).Text;
                r.vehicleType = Convert.ToInt32(tms.getvehicletypebyname(vehicletype).ElementAtOrDefault(0).id);
                r.remark = ((TextBox)fvTrip.FindControl("txtRemarks")).Text;
                r.vehicleNo = ((TextBox)fvTrip.FindControl("txtVehiclereg")).Text;
                if (((TextBox)fvTrip.FindControl("txtAppKm")).Text == "")
                {
                    r.approvedKm = 0;
                }
                else
                {
                    r.approvedKm = Convert.ToInt32(((TextBox)fvTrip.FindControl("txtAppKm")).Text);
                }


              //  r.delay = ((TextBox)fvTrip.FindControl("txtDelay")).Text;
                r.Id = _routeid;
                r.updatedBy = MyApplicationSession._UserID;
                r.driver = ((TextBox)fvTrip.FindControl("txtDriver")).Text;
                r.PenaltyType = Convert.ToInt32(((DropDownList)fvTrip.FindControl("ddlPenaltyType")).SelectedValue);
                r.shiftTime=((DropDownList)fvTrip.FindControl("ddlshift")).SelectedValue;
            
                    r.PenaltyAmount = 0;
            

                r.BillingTriptype=Convert.ToInt32(((DropDownList)fvTrip.FindControl("ddlBillingTripType")).SelectedValue.ToString());
                r.CostLocation = Convert.ToInt32(((DropDownList)fvTrip.FindControl("ddlCostLocation")).SelectedValue.ToString());

                int billcatid = 0;
                if (((RadioButtonList)fvTrip.FindControl("rdbBillType")).Visible == true)
                {
                    billcatid = Convert.ToInt32(((RadioButtonList)fvTrip.FindControl("rdbBillType")).SelectedValue);
                }
                string flag = tms.iscabalreadyused(Convert.ToInt32(r.vehicleId), Convert.ToDateTime(txtShiftDate.Text), _routeid).ElementAtOrDefault(0).result.ToString();
                if (flag == "2")
                {
                    ShowMessage("Billing is locked for this month please contact billing admin to unlock.");
                }
                else
                {
                tms.SaveDummyRouteInfo(r.vehicleId, r.vendorName, r.vehicleType, r.actStartKm, r.actEndKm, r.approvedKm, r.actVehicleStartTime, r.actVehicleEndTime, r.guard, Server.HtmlEncode(r.vehicleNo), r.driver, Server.HtmlEncode(r.remark), r.delayReason, _routeid, r.updatedBy, r.PenaltyType, r.PenaltyAmount, r.BillingTriptype, r.lastTrip, r.CostLocation, r.shiftTime, billcatid);
                foreach (GridViewRow gvr in GvEmpInfo.Rows)
                {
                    rd.employeeId = Convert.ToInt32(GvEmpInfo.DataKeys[gvr.RowIndex].Value.ToString());
                    rd.routeid = _routeid;
                    rd.stopNo = Convert.ToInt32(((Label)gvr.FindControl("lblStopNo")).Text);
                    rd.trackingRemark = ((TextBox)gvr.FindControl("txtgvRemarks")).Text;
                    rd.trackingStatus = ((DropDownList)gvr.FindControl("ddlStatus")).SelectedValue;
                    tms.SaveDummyRouteDetInfo(rd.routeid, rd.employeeId, rd.stopNo, rd.trackingRemark, rd.trackingStatus,MyApplicationSession._UserID);
                }
                string toll = null;
                ListBox lbtoll = (ListBox)fvTrip.FindControl("lbToll");
                for (int tollid = 0; tollid < lbtoll.Items.Count; tollid++)
                {
                    if (lbtoll.Items[tollid].Selected == true)
                    {
                        toll = toll + lbtoll.Items[tollid].Value.ToString() + ",";
                    }
                }
                if (toll == null)
                {
                    toll = "0";
                }
                else
                {
                    toll = toll.Remove(toll.Length - 1, 1);
                }

                tms.AddtolltoRoute(_routeid, toll);


                tms.SaveDummyRouteInfo(r.vehicleId, r.vendorName, r.vehicleType, r.actStartKm, r.actEndKm, r.approvedKm, r.actVehicleStartTime, r.actVehicleEndTime, r.guard, Server.HtmlEncode(r.vehicleNo), r.driver, Server.HtmlEncode(r.remark), r.delayReason, _routeid, r.updatedBy, r.PenaltyType, r.PenaltyAmount, r.BillingTriptype, r.lastTrip, r.CostLocation, r.shiftTime, billcatid);
          
                lblErrorMsg.Visible = true;
                ShowMessage("TripSheet Saved Successfully");
                txtRouteId.Text = String.Empty;
                txtRouteId.Focus();
                lblErrorMsg.Text = "TripSheet Saved Successfully";
                MultiView1.ActiveViewIndex = -1;
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

    protected void btnCancelTrip_Click(object sender, EventArgs e)
    {
        //*************************************************************//
        //Saves the Tripsheet into the DB as Cancelled //
        //*************************************************************//
        try
        {
            string flag = tms.iscabalreadyused(0, Convert.ToDateTime(txtShiftDate.Text), _routeid).ElementAtOrDefault(0).result.ToString();
            if (flag == "2")
            {
                ShowMessage("Billing is locked for this month please contact billing admin to unlock.");
            }
            else
            {
                tms.CancelTripSheet(_routeid);
                MultiView1.ActiveViewIndex = -1;
                lblErrorMsg.Text = " Trip Canceled for: " + _routeid.ToString();
            }
            
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }
    

    protected void ddlVehicleType_SelectedIndexChanged(object sender, EventArgs e)
    {
        //**************************************************//
        //For Selected Vendor binds the vehicle dropdown //
        //**************************************************//
        try
        {

            DropDownList ddlvt = sender as DropDownList;
            int VehicleTypeID = Convert.ToInt32(ddlvt.SelectedValue);

            DropDownList ddlBillingTripType = (DropDownList)fvTrip.FindControl("ddlBillingTripType");
            ListItem livt = new ListItem("-Select-", "0");
            ddlBillingTripType.Items.Clear();
            ddlBillingTripType.Items.Add(livt);

            if (VehicleTypeID != 0)
            {
                ddlBillingTripType.DataSource = tms.GetZoneName(MyApplicationSession._FacilityID, VehicleTypeID);
                ddlBillingTripType.DataTextField = "workzonename";
                ddlBillingTripType.DataValueField = "ZoneID";
                ddlBillingTripType.DataBind();
            }
            ddlvt.Focus();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }
    protected void ddlCostLocation_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void ddlCabID_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlCabID = (DropDownList)fvTrip.FindControl("ddlCabID");
        int CabId = Convert.ToInt32(ddlCabID.SelectedValue);
        string vehiclereg = null;
        int vendorID = 0, vehicltypeid = 0;
        var result = tms.SelectVehicleByID(CabId.ToString(),Convert.ToInt32(ddlSelectFacility.SelectedValue));
        foreach (var r in result)
        {
            vendorID = Convert.ToInt32(r.vendorId);
            vehiclereg = r.vehicleRegistrationNo;
            vehicltypeid = Convert.ToInt32(r.vehicleTypeId);

        }
        
        DropDownList ddlVendor = (DropDownList)fvTrip.FindControl("ddlVendor");
        ddlVendor.SelectedIndex = ddlVendor.Items.IndexOf(ddlVendor.Items.FindByValue(vendorID.ToString()));
        DropDownList ddlVehicleType = (DropDownList)fvTrip.FindControl("ddlVehicleType");
        ddlVehicleType.SelectedIndex = ddlVehicleType.Items.IndexOf(ddlVehicleType.Items.FindByValue(vehicltypeid.ToString()));
        TextBox txtVehicleReg = (TextBox)fvTrip.FindControl("txtVehicleReg");
        txtVehicleReg.Text = vehiclereg;


    }
    protected void txtCabID_TextChanged(object sender, EventArgs e)
    {
        TextBox txtCabID = (TextBox)fvTrip.FindControl("txtCabID");
        int CabId = Convert.ToInt32(txtCabID.Text);
        string vehiclereg = null;
        string vendor = null, vehicltype = null;
        var result = tms.SelectVehicleByID(CabId.ToString(),Convert.ToInt32(ddlSelectFacility.SelectedValue));
        foreach (var r in result)
        {
            vendor = r.vendorName;
            vehiclereg = r.vehicleRegistrationNo;
            vehicltype = r.vehicle;

        }
        if (vendor == null)
        {
            ShowMessage("CabID Does not Exists");
            txtCabID.Focus();
        }
        else
        {

            TextBox txtVehicleType = (TextBox)fvTrip.FindControl("txtVehicleType");
            TextBox txtVendor = (TextBox)fvTrip.FindControl("txtVendor");
            txtVendor.Text = vendor;
            txtVehicleType.Text = vehicltype;
            ((TextBox)fvTrip.FindControl("txtVehicleReg")).Text = vehiclereg;
            ((TextBox)fvTrip.FindControl("txtVehicleReg")).Focus();
        }
    }

    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
    protected void rdbtnTripTag_SelectedIndexChanged(object sender, EventArgs e)
    {
        TextBox txtCabID = (TextBox)fvTrip.FindControl("txtCabID");
        RadioButtonList rdbtnTripTag = (RadioButtonList)fvTrip.FindControl("rdbtnTripTag");
        var result = tms.validateTripTag(Convert.ToInt32(txtCabID.Text), rdbtnTripTag.SelectedValue, _routeid);
        string msg = null, flag = null;
        foreach (var r in result)
        {
            msg = r.MSG;
            flag = r.FLAG.ToString();
        }
        if (flag == "0")
        {
            lblErrorMsg.Text = msg;
            lblErrorMsg.Visible = true;
            rdbtnTripTag.SelectedIndex = -1;
        }


    }
    protected void ddlSelectFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblRouteId.Text = GetRoutePreFix();
        txtRouteId.Text = String.Empty;
        txtRouteId.Focus();
        MultiView1.ActiveViewIndex = -1;


    }
    protected void imgbtnAddUnschedule_Click(object sender, ImageClickEventArgs e)
    {
        multiview2.ActiveViewIndex = 0;
        ModalPopupExtender2.Show();
        lblPrefix.Text = tms.getRequestIdPrefixDummy(_routeid).ElementAtOrDefault(0).Prefix;
        Panel3.Visible = true;
        ddlUnschDropStop.Items.Clear();
        ListItem li = new ListItem("Select Stop No", "0");
        string val = string.Empty;
        ddlUnschDropStop.Items.Add(li);
        for (int i = 0; i <= GvEmpInfo.Rows.Count; i++)
        {
            val = (i + 1).ToString();

            ddlUnschDropStop.Items.Add(val.ToString());

        }
        txt.Text = String.Empty;



    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        var res = tms.AlignSpecialRequestdummy(lblPrefix.Text, txt.Text, _routeid, Convert.ToInt32(ddlUnschDropStop.SelectedItem.ToString()),MyApplicationSession._UserID);
        String flag = null, msg = null;
        foreach (var r in res)
        {
            flag = r.Flag.ToString();
            msg = r.msg;
        }
        if (flag == "0")
        {
            multiview2.ActiveViewIndex = 0;
            ModalPopupExtender2.Show();
            lblunscheduleerror.Text = msg;
            lblunscheduleerror.Visible = true;


        }
        else
        {
            BndEmpGrid();
            BndEmpGridData();
        }
    }
    public void checkduplicacy()
    {
        String employeeid = null, status = null;
        string routeid = _routeid;
        foreach (GridViewRow gvr in GvEmpInfo.Rows)
        {
            employeeid = employeeid + "," + Convert.ToInt32(GvEmpInfo.DataKeys[gvr.RowIndex].Value.ToString());



            status = status + "," + ((DropDownList)gvr.FindControl("ddlStatus")).SelectedValue;

        }

        status = status.Substring(1, status.Length - 1);
        employeeid = employeeid.Substring(1, employeeid.Length - 1);

        gvDupEmpInfo.DataSource = tms.getduplicateemployee(employeeid, status, routeid);
        gvDupEmpInfo.DataBind();
        if (gvDupEmpInfo.Rows.Count > 0)
        {
            _save = "false";
            multiview4.ActiveViewIndex = 0;
            ModalPopupExtender3.Show();

        }
    }
    protected void btnDupSaveChanges_Click(object sender, EventArgs e)
    {
        multiview4.ActiveViewIndex = 0;
        ModalPopupExtender3.Show();
        foreach (GridViewRow gvr in gvDupEmpInfo.Rows)
        {
            rd.employeeId = Convert.ToInt32(gvDupEmpInfo.DataKeys[gvr.RowIndex].Value.ToString());
            rd.routeid = ((Label)gvr.FindControl("lblDupRouteID")).Text;
            rd.stopNo = Convert.ToInt32(((Label)gvr.FindControl("lblDupStopNo")).Text);
            rd.trackingRemark = "";
            rd.trackingStatus = ((DropDownList)gvr.FindControl("ddlStatus")).SelectedValue;
            tms.SaveRouteDetInfo(rd.routeid, rd.employeeId, rd.stopNo, rd.trackingRemark, rd.trackingStatus);
        }
        multiview4.ActiveViewIndex = -1;
        ModalPopupExtender3.Hide();

    }
    protected void lbtnClose_Click2(object sender, EventArgs e)
    {
        ModalPopupExtender3.Hide();
        imbbtnAddEmp.Focus();
        multiview4.ActiveViewIndex = -1;
    }

}