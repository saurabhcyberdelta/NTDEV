using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

public partial class HelpDesk : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
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
        try
        {
            //txtEmpIdName.Focus();
            lblMsg.Visible = false;
            lblMsg.Text = "";
            if (!IsPostBack)
            {
                _empId = 0;
                txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                txtStartDate0.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                txtEmpIdName.Focus();
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

    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            BndShiftTimeListBx();
            MultiView2.ActiveViewIndex = -1;
            MultiView3.ActiveViewIndex = -1;
            MultiView4.ActiveViewIndex = -1;
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
        try
        {
            BndShiftTimeListBx();
            MultiView2.ActiveViewIndex = -1;
            MultiView3.ActiveViewIndex = -1;
            MultiView4.ActiveViewIndex = -1;
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
        try
        {
            BndEmpGrid();
            txtRouteID.Text = "";
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void btnSearchRoute_Click(object sender, EventArgs e)
    {
        try
        {
            BndRouteGrid();
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
        try
        {
            if (txtEmpIdName.Text.ToString().Trim().Length > 0)
            {
                grdSearchEmployee.DataSource = tms.EmpSearch(txtEmpIdName.Text, MyApplicationSession._LocationId,MyApplicationSession._ISAdmin);
                grdSearchEmployee.DataBind();

                if (grdSearchEmployee.Rows.Count < 1)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "No Record were Found!!!";
                    MultiView2.ActiveViewIndex = -1;
                    MultiView3.ActiveViewIndex = -1;
                    MultiView4.ActiveViewIndex = -1;
                }
                else
                {
                    lblMsg.Visible = false;
                    MultiView2.ActiveViewIndex = 0;
                    MultiView3.ActiveViewIndex = -1;
                    MultiView4.ActiveViewIndex = -1;

                    grdSearchEmployee.PageIndex = 0;
                    if (grdSearchEmployee.Rows.Count == 1)
                    {
                        _empId = Convert.ToInt32(grdSearchEmployee.DataKeys[0].Value);
                        ShowEmpDetails(_empId, Convert.ToDateTime(txtStartDate0.Text));
                    }
                }
            }
            else
            {

                MultiView1.ActiveViewIndex = -1;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    public void ShowEmpDetails(Int32 EmpID, DateTime sDate)
    {
        try
        {
            grdShowEmployeeDetail.DataSource = tms.GetHelpDeskEmployeeDetail(sDate, EmpID);
            grdShowEmployeeDetail.DataBind();
            if (grdShowEmployeeDetail.Rows.Count < 1)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "No Record were Found!!!";
                GetEmployeeDetails(EmpID);
            }
            else
            {
                GetEmployeeDetails(EmpID);
                lblMsg.Visible = false;
                MultiView2.ActiveViewIndex = -1;
                MultiView3.ActiveViewIndex = 0;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    private void GetEmployeeDetails(Int32 EmpID)
    {
        //lblempName.Text = "Transportation Details of:- " + grdShowEmployeeDetail.DataKeys[0].Values[2].ToString();
        var result = tms.GetEmployeeDetails(EmpID);
        foreach (var result1 in result)
        {
            lblEmpID.Text = result1.empCode;
            lblEmployeeName.Text = result1.empName;
            lblDepartment.Text = result1.processName;
            lblFacility.Text = result1.facilityName;
            lblMobile.Text = result1.mobile;
            lblPhone.Text = result1.phone;
            lblAddress.Text = result1.address;
            lblLocation.Text = result1.Location;
            lblRepManager.Text = result1.ManagerDetail;
            lblManagerNo.Text = result1.mgrMobile;
            lblCostcenter.Text = result1.Costcenter;
            lblDivisionManager.Text = result1.DivisionManager;

            if (result1.geoCode.ToString() == "Y")
            {
                imgIsGeoCoded.ImageUrl = "~/images/yes_icon.jpg";
                imgIsGeoCoded.AlternateText = "Yes";
            }
            else
            {
                imgIsGeoCoded.ImageUrl = "~/images/no_icon.jpg";
                imgIsGeoCoded.AlternateText = "No";
            }

            if (result1.tptReq.Value.ToString() == "Y")
            {
                imgIsTptReq.ImageUrl = "~/images/yes_icon.jpg";
                imgIsTptReq.AlternateText = "Yes";
            }
            else
            {
                imgIsTptReq.ImageUrl = "~/images/no_icon.jpg";
                imgIsTptReq.AlternateText = "No";
            }

            lblempName.Text = "Transportation Details of:- " + result1.empName;

          

        }
    }

    public void BndRouteGrid()
    {
        try
        {
            string strStartdate = txtStartDate.Text;
            string strFacilityID = ddlFacility.SelectedValue;
            string strTripType = rdoTripType.SelectedValue;
            string strShifttimes = string.Empty;
            if (lstShift.SelectedIndex >= 0)
            {
                for (int i = 0; i < lstShift.Items.Count; i++)
                {
                    if (lstShift.Items[i].Selected)
                    {
                        strShifttimes = strShifttimes + lstShift.Items[i].Text + ",";
                    }
                }
            }
            grdViewShowRoute.DataSource = tms.GetRoutes(strStartdate, strStartdate, strFacilityID, strTripType, strShifttimes,"");
            grdViewShowRoute.DataBind();
            if (grdViewShowRoute.Rows.Count > 0)
            {
                for (int i = 0; i < grdViewShowRoute.Rows.Count; i++)
                {
                    string lblRouteID = ((Label)grdViewShowRoute.Rows[i].FindControl("lblRouteID")).Text.ToString();

                    GridView grdViewRouteChild = (GridView)grdViewShowRoute.Rows[i].FindControl("grdViewRouteChild");
                    //string SelectedRouteID = grdViewRouteParent.DataKeys[i].Value.ToString();
                    grdViewRouteChild.DataSource = tms.GetRoutesDetails(lblRouteID);
                    grdViewRouteChild.DataBind();
                }
                MultiView2.ActiveViewIndex = -1;
                MultiView3.ActiveViewIndex = -1;
                MultiView4.ActiveViewIndex = 0;
            }
            else
            {
                lblMsg.Visible = true;
                lblMsg.Text = "No Record were Found!!!";
                MultiView2.ActiveViewIndex = -1;
                MultiView3.ActiveViewIndex = -1;
                MultiView4.ActiveViewIndex = -1;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void grdSearchEmployee_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        try
        {
            _empId = Convert.ToInt32(grdSearchEmployee.DataKeys[e.NewSelectedIndex].Value.ToString());
            //DateTime sDate = DateTime.Now.Date.AddDays(-3);
            ShowEmpDetails(_empId, Convert.ToDateTime(txtStartDate0.Text));
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void grdSearchEmployee_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdSearchEmployee.PageIndex = e.NewPageIndex;
            BndEmpGrid();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void grdShowEmployeeDetail_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            DateTime sDate;
            if (e.CommandName == "ShowPickRoute")
            {
                _empId = Convert.ToInt32(grdShowEmployeeDetail.DataKeys[Convert.ToInt32(e.CommandArgument)]["id"].ToString());
                sDate = Convert.ToDateTime(grdShowEmployeeDetail.DataKeys[Convert.ToInt32(e.CommandArgument)]["ShiftDate"].ToString());
                string pickRouteID = ((LinkButton)grdShowEmployeeDetail.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lbpickRouteID")).Text.ToString();
                GetRouteDetail(pickRouteID);
            }

            if (e.CommandName == "ShowDropRoute")
            {
                _empId = Convert.ToInt32(grdShowEmployeeDetail.DataKeys[Convert.ToInt32(e.CommandArgument)]["id"].ToString());
                sDate = Convert.ToDateTime(grdShowEmployeeDetail.DataKeys[Convert.ToInt32(e.CommandArgument)]["ShiftDate"].ToString());

                string dropRouteID = ((LinkButton)grdShowEmployeeDetail.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lbdropRouteID")).Text.ToString();

                GetRouteDetail(dropRouteID);

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    public void GetRouteDetail(string routeID)
    {
        //grdShowRouteDetail.DataSource = tms.GetHelpDeskRouteDetail(routeID);
        try
        {
            grdShowRouteDetail.DataSource = tms.GetRoutesDetails(routeID);
            grdShowRouteDetail.DataBind();
            DvShowRouteDetails.DataSource = tms.GetRouteSummary(routeID);
            DvShowRouteDetails.DataBind();
            if (grdShowRouteDetail.Rows.Count < 1)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "No Record were Found!!!";
            }
            else
            {
                string triptype = grdShowRouteDetail.DataKeys[0].Values[3].ToString();
                if (triptype.ToLower().Trim() == "p")
                {
                    triptype = "PickUP";
                }
                else
                {
                    triptype = "DROP";
                }
                lblempName1.Text = lblempName.Text + " for " + Convert.ToDateTime(grdShowRouteDetail.DataKeys[0].Values[2].ToString()).ToLongDateString() + " " + triptype;
                lblMsg.Visible = false;
            }
            MultiView2.ActiveViewIndex = -1;
            MultiView3.ActiveViewIndex = 1;
            MultiView4.ActiveViewIndex = -1;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void rbtnSearchType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            switch (rbtnSearchType.SelectedItem.Text)
            {
                case "Employee":
                    MultiView1.ActiveViewIndex = 0;
                    MultiView2.ActiveViewIndex = -1;
                    MultiView3.ActiveViewIndex = -1;
                    MultiView4.ActiveViewIndex = -1;
                    break;
                case "Route":
                    MultiView1.ActiveViewIndex = 1;
                    MultiView2.ActiveViewIndex = -1;
                    MultiView3.ActiveViewIndex = -1;
                    MultiView4.ActiveViewIndex = -1;
                    BndFacilityDropdown();
                    BndShiftTimeListBx();
                    ddlFacility.Focus();
                    //BndShiftTimeListBx();
                    break;
            }
            //MultiView1.ActiveViewIndex = -1;
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

    public void BndShiftTimeListBx()
    {
        try
        {
            int facid = Convert.ToInt32(ddlFacility.SelectedValue.ToString());
            string type = rdoTripType.SelectedValue.ToString();
            lstShift.Items.Clear();
            ListItem list = new ListItem("Select Shift", "0");
            lstShift.Items.Add(list);
            lstShift.DataSource = tms.GetShiftByFacilityType(facid, type);
            lstShift.DataTextField = "shiftTime";
            lstShift.DataValueField = "shiftTime";
            lstShift.DataBind();
            lstShift.SelectedIndex = 0;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void grdViewShowRoute_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "ShowDetailRoute")
            {
                GridViewRow gvr = (GridViewRow)((ImageButton)e.CommandSource).NamingContainer;
                int rowindex = gvr.RowIndex;
                GridView grdViewRouteChild = (GridView)grdViewShowRoute.Rows[rowindex].FindControl("grdViewRouteChild");
                if (grdViewRouteChild.Visible == true)
                {
                    grdViewRouteChild.Visible = false;
                }
                else
                {
                    grdViewRouteChild.Visible = true;
                }
                ImageButton ibViewRouteID = (ImageButton)grdViewShowRoute.Rows[rowindex].FindControl("ibViewRouteID");

                if (ibViewRouteID.ImageUrl == "~/images/plus.gif")
                {
                    ibViewRouteID.ImageUrl = "~/images/minus.gif";
                    ibViewRouteID.ToolTip = "To Collapse the Route Detail";
                }
                else
                {
                    ibViewRouteID.ImageUrl = "~/images/plus.gif";
                    ibViewRouteID.ToolTip = "To Expand the Route Detail";

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

    protected void grdViewShowRoute_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "actVehicleStartTime")) == string.Empty && (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "actVehicleEndTime")) == string.Empty || Convert.ToString(DataBinder.Eval(e.Row.DataItem, "trackend")) == "0"))
                {
                    e.Row.BackColor = System.Drawing.Color.Tomato;
                }
                else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "actVehicleStartTime")) != string.Empty && Convert.ToString(DataBinder.Eval(e.Row.DataItem, "trackend")) == "0")
                {
                    e.Row.BackColor = System.Drawing.Color.Yellow;
                }
                else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "actVehicleStartTime")) != string.Empty && (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "actVehicleEndTime")) != string.Empty || Convert.ToString(DataBinder.Eval(e.Row.DataItem, "trackend")) != "0"))
                {
                    e.Row.BackColor = System.Drawing.Color.Lime;
                }

                if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "isCancel")) == "True")
                {
                    e.Row.BackColor = System.Drawing.Color.Tomato;
                }
                //e.Row.Attributes.Add("onMouseOver", "this.style.backgroundColor='Red'");
                //e.Row.Attributes.Add("onMouseOut", "this.style.backgroundColor='Transparent'");

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void grdViewRouteChild_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            string actVehicleStartTime = string.Empty;
            GridView grdViewRouteChild = (GridView)sender;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlAction = (DropDownList)e.Row.FindControl("ddlAction");
                if (ddlAction != null)
                {
                    ddlAction.Items.Add(new ListItem("Select Status", ""));
                    ddlAction.Items.Add(new ListItem("Boarded", "B"));
                    ddlAction.Items.Add(new ListItem("No-Show", "N"));
                    ddlAction.Items.Add(new ListItem("Moved", "M"));
                    ddlAction.Items.Add(new ListItem("Cancelled", "C"));
                }

                string strAction = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "trackingStatus"));
                ddlAction.SelectedIndex = ddlAction.Items.IndexOf(ddlAction.Items.FindByValue(strAction.ToString()));

                actVehicleStartTime = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "actVehicleStartTime"));

                if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "trackingStatus")) == "N")
                {
                    e.Row.BackColor = System.Drawing.Color.Plum;
                }
                if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "trackingStatus")) == "M")
                {
                    e.Row.BackColor = System.Drawing.Color.Plum;
                }
                else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "trackingStatus")) == "B")
                {
                    e.Row.BackColor = System.Drawing.Color.PaleTurquoise;
                }
                else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "trackingStatus")) == "C")
                {
                    e.Row.BackColor = System.Drawing.Color.Crimson;
                }
                if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "IsRouteFinalized")) == "True" && Convert.ToString(DataBinder.Eval(e.Row.DataItem, "IsAddedAfterFinal")) == "True")
                {
                    e.Row.BackColor = System.Drawing.Color.Gold;
                }

            }
            //if (e.Row.RowType == DataControlRowType.Footer)
            //{
            //    if (actVehicleStartTime == string.Empty)
            //    {
            //        ((LinkButton)e.Row.FindControl("lbSaveAction")).Visible = false;
            //    }
            //}
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void grdViewRouteChild_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            GridView grdViewRouteChild = (GridView)sender;
            string strRouteID = grdViewRouteChild.DataKeys[0].Values[0].ToString();
            switch (e.CommandName.ToString())
            {
                case "SaveAction":
                    Boolean IsPageValid = true;
                    foreach (GridViewRow i in grdViewRouteChild.Rows)
                    {
                        string strEmployeeID = grdViewRouteChild.DataKeys[i.RowIndex].Values[1].ToString();

                        string strAction = ((DropDownList)grdViewRouteChild.Rows[i.RowIndex].FindControl("ddlAction")).SelectedValue;
                        string strActETAhh = ((TextBox)grdViewRouteChild.Rows[i.RowIndex].FindControl("txtActETAhh")).Text;
                        string strActETAmm = ((TextBox)grdViewRouteChild.Rows[i.RowIndex].FindControl("txtActETAmm")).Text;
                        string TripStartDate = ((TextBox)grdViewRouteChild.Rows[i.RowIndex].FindControl("txtStartDate")).Text;
                        string strRemark = ((TextBox)grdViewRouteChild.Rows[i.RowIndex].FindControl("txtRemark")).Text;
                        Label lblErrorMsg = (Label)grdViewRouteChild.Rows[i.RowIndex].FindControl("lblErrorMsg");
                        lblErrorMsg.Visible = false;
                        lblErrorMsg.Text = "";

                        DateTime ActTripStartDate = new DateTime();
                        Boolean IsValid = true;
                        if (strAction != string.Empty)
                        {
                            if (strActETAhh != "")
                            {
                                if (!Regex.IsMatch(strActETAhh, @"^([0-1][0-9]|[2][0-3])$"))
                                {
                                    IsValid = false;
                                    lblErrorMsg.Text = "Enter Valid ETA Hours";
                                    lblErrorMsg.Visible = true;
                                }
                            }
                            if (IsValid == true)
                            {
                                if (strActETAmm != "")
                                {
                                    if (!Regex.IsMatch(strActETAmm, @"^([0-5][0-9])$"))
                                    {
                                        IsValid = false;
                                        lblErrorMsg.Text = "Enter Valid ETA Minuts";
                                        lblErrorMsg.Visible = true;
                                    }
                                }
                            }
                            if (IsValid == true)
                            {
                                if ((!Regex.IsMatch(TripStartDate, @"^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$")) || (TripStartDate == ""))
                                {
                                    IsValid = false;
                                    lblErrorMsg.Text = "Enter Valid Date";
                                    lblErrorMsg.Visible = true;
                                }
                                else
                                {
                                    ActTripStartDate = Convert.ToDateTime(TripStartDate);
                                }
                            }
                            if (IsValid == true)
                            {
                                if (!Regex.IsMatch(strRemark, @"^([\w\-]|\s)*$"))
                                {
                                    IsValid = false;
                                    lblErrorMsg.Text = "Remark Should be Alphanumeric.";
                                    lblErrorMsg.Visible = true;
                                }
                            }

                            if (IsValid == true)
                            {
                                tms.UpdateTrackingStatus(strRouteID, strEmployeeID, ActTripStartDate, strAction, strActETAhh, strActETAmm, strRemark, MyApplicationSession._UserID);
                            }
                            else
                            {
                                IsPageValid = false;
                            }
                        }                        
                    }
                    if (IsPageValid == true)
                    {
                        grdViewRouteChild.DataSource = tms.GetRoutesDetails(strRouteID);
                        grdViewRouteChild.DataBind();
                    }
                    break;
                case "CancelAction":
                    grdViewRouteChild.DataSource = tms.GetRoutesDetails(strRouteID);
                    grdViewRouteChild.DataBind();
                    grdViewRouteChild.Visible = false;
                    int parentRowIndex = ((GridViewRow)(grdViewRouteChild.NamingContainer)).RowIndex;
                    ImageButton ibViewRouteID = (ImageButton)grdViewShowRoute.Rows[parentRowIndex].FindControl("ibViewRouteID");

                    if (ibViewRouteID.ImageUrl == "~/images/plus.gif")
                    {
                        ibViewRouteID.ImageUrl = "~/images/minus.gif";
                        ibViewRouteID.ToolTip = "To Collapse the Route Detail";
                    }
                    else
                    {
                        ibViewRouteID.ImageUrl = "~/images/plus.gif";
                        ibViewRouteID.ToolTip = "To Expand the Route Detail";
                    }
                    break;
            }

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void grdViewShowRoute_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdViewShowRoute.PageIndex = e.NewPageIndex;
            BndRouteGrid();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void grdViewShowRoute_Sorting(object sender, GridViewSortEventArgs e)
    {
        //var result = tms.GetRoutes();
        ////PropertyInfo[] propertys = typeof(GetRoutesResult).GetProperties();
        ////DataSet ds = new DataSet();
        ////ds.Tables.Add(result);
        ////DataTable dt = ds.Tables[0];
        //DataTable dt = new DataTable();
        //DataColumn dc = new DataColumn("RouteID", typeof(System.String));
        //dt.Columns.Add(dc);
        //dc = new DataColumn("shiftTime", typeof(System.String));
        //dt.Columns.Add(dc);
        //dc = new DataColumn("Address", typeof(System.String));
        //dt.Columns.Add(dc);
        //dc = new DataColumn("vendorName", typeof(System.String));
        //dt.Columns.Add(dc);
        //dc = new DataColumn("stickerNo", typeof(System.String));
        //dt.Columns.Add(dc);
        //dc = new DataColumn("totalStop", typeof(System.String));
        //dt.Columns.Add(dc);

        //foreach (var result1 in result)
        //{
        //    DataRow dr = dt.NewRow();
        //    dr["RouteID"] = result1.RouteID;
        //    dr["shiftTime"] = result1.shiftTime;
        //    dr["Address"] = result1.Address;
        //    dr["vendorName"] = result1.vendorName;
        //    dr["stickerNo"] = result1.stickerNo;
        //    dr["totalStop"] = result1.totalStop;
        //    dt.Rows.Add(dr);
        //}


        //if (dt != null)
        //{
        //    DataView dataView = new DataView(dt);
        //    dataView.Sort = e.SortExpression + " " + getSortDirectionString(e.SortDirection);
        //    grdViewShowRoute.DataSource = dataView;
        //    grdViewShowRoute.DataBind();
        //}

    }
    private string getSortDirectionString(SortDirection sortDireciton)
    {
        string newSortDirection = String.Empty;
        if (sortDireciton == SortDirection.Ascending)
        {
            newSortDirection = "ASC";
        }
        else
        {
            newSortDirection = "DESC";
        }

        return newSortDirection;
    }
    private string GetSortDirection(string column)
    {

        // By default, set the sort direction to ascending.
        string sortDirection = "ASC";

        // Retrieve the last column that was sorted.
        string sortExpression = Session["SortExpression"] as string;

        if (sortExpression != null)
        {
            // Check if the same column is being sorted.
            // Otherwise, the default value can be returned.
            if (sortExpression == column)
            {
                string lastDirection = Session["SortDirection"] as string;
                if ((lastDirection != null) && (lastDirection == "ASC"))
                {
                    sortDirection = "DESC";
                }
            }
        }

        // Save new values in ViewState.
        Session["SortDirection"] = sortDirection;
        Session["SortExpression"] = column;

        return sortDirection;
    }

    protected void grdShowRouteDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlAction = (DropDownList)e.Row.FindControl("ddlAction");
                if (ddlAction != null)
                {
                    ddlAction.Items.Add(new ListItem("Select Status", ""));
                    ddlAction.Items.Add(new ListItem("Boarded", "B"));
                    ddlAction.Items.Add(new ListItem("No-Show", "N"));
                    ddlAction.Items.Add(new ListItem("Moved", "M"));
                    ddlAction.Items.Add(new ListItem("Cancelled", "C"));
                }
                string sdate = grdShowRouteDetail.DataKeys[e.Row.RowIndex]["shiftdate"].ToString();
                string strAction = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "trackingStatus"));
                ddlAction.SelectedIndex = ddlAction.Items.IndexOf(ddlAction.Items.FindByValue(strAction.ToString()));

                RangeValidator RangeValidator3 = (RangeValidator)e.Row.FindControl("RangeValidator3");
                RangeValidator3.MinimumValue = Convert.ToDateTime(sdate).AddDays(-1).ToShortDateString();
                RangeValidator3.MaximumValue = Convert.ToDateTime(sdate).ToShortDateString();

                RangeValidator3.ErrorMessage = "Start date should be between " + Convert.ToDateTime(sdate).AddDays(-1).ToShortDateString() + " and " + Convert.ToDateTime(sdate).ToShortDateString();

                if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "trackingStatus")) == "B")
                {
                    e.Row.BackColor = System.Drawing.Color.PaleTurquoise;
                }
                else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "trackingStatus")) == "N")
                {
                    e.Row.BackColor = System.Drawing.Color.Plum;
                }
                else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "trackingStatus")) == "M")
                {
                    e.Row.BackColor = System.Drawing.Color.Plum;
                }
                else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "trackingStatus")) == "C")
                {
                    e.Row.BackColor = System.Drawing.Color.Crimson;
                }
                if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "IsRouteFinalized")) == "True" && Convert.ToString(DataBinder.Eval(e.Row.DataItem, "IsAddedAfterFinal")) == "True")
                {
                    e.Row.BackColor = System.Drawing.Color.Gold;
                }

                if (Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "id")) == _empId)
                {
                    e.Row.Font.Bold = true;
                    ddlAction.Focus();
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

    protected void grdShowRouteDetail_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            GridView grdShowRouteDetail = (GridView)sender;
            string strRouteID = grdShowRouteDetail.DataKeys[0].Values[0].ToString();
            switch (e.CommandName.ToString())
            {
                case "SaveAction":
                    foreach (GridViewRow i in grdShowRouteDetail.Rows)
                    {
                        string strEmployeeID = grdShowRouteDetail.DataKeys[i.RowIndex].Values[1].ToString();
                        string strAction = ((DropDownList)grdShowRouteDetail.Rows[i.RowIndex].FindControl("ddlAction")).SelectedValue;
                        string strActETAhh = ((TextBox)grdShowRouteDetail.Rows[i.RowIndex].FindControl("txtActETAhh")).Text;
                        string strActETAmm = ((TextBox)grdShowRouteDetail.Rows[i.RowIndex].FindControl("txtActETAmm")).Text;
                        string strRemark = ((TextBox)grdShowRouteDetail.Rows[i.RowIndex].FindControl("txtRemark")).Text;
                        if (strAction != string.Empty)
                        {
                            DateTime ActTripStartDate = Convert.ToDateTime(((TextBox)grdShowRouteDetail.Rows[i.RowIndex].FindControl("txtStartDate")).Text);
                            tms.UpdateTrackingStatus(strRouteID, strEmployeeID, ActTripStartDate, strAction, strActETAhh, strActETAmm, Server.HtmlEncode(strRemark), MyApplicationSession._UserID);
                        }
                    }
                    grdShowRouteDetail.DataSource = tms.GetRoutesDetails(strRouteID);
                    grdShowRouteDetail.DataBind();


                    //MultiView1.ActiveViewIndex = 1;
                    break;
                case "CancelAction":
                    MultiView2.ActiveViewIndex = -1;
                    MultiView3.ActiveViewIndex = 0;
                    MultiView4.ActiveViewIndex = -1;
                    break;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }


    protected void lbShifts_Click(object sender, EventArgs e)
    {
        LinkButton lbShifts = sender as LinkButton;
        GridViewRow gvr = (GridViewRow)lbShifts.Parent.Parent;
        int rowIndex = gvr.RowIndex;

        DateTime shiftDate = Convert.ToDateTime(grdShowEmployeeDetail.DataKeys[rowIndex]["ShiftDate"].ToString());
        int empID = Convert.ToInt32(grdShowEmployeeDetail.DataKeys[rowIndex]["id"].ToString());

        dvScheduleAuditTrail.DataSource = tms.GetEmpScheduleLog(empID, shiftDate);
        dvScheduleAuditTrail.DataBind();

        ModalPopupExtender1.Show();
    }

    private bool ValidateNumber(string input)
    {
        foreach (char c in input)
        {
            if (!Char.IsNumber(c))
            {
                return false;
            }
        }

        return true;
    }
    protected void btnClose0_Click(object sender, ImageClickEventArgs e)
    {
        MultiView2.ActiveViewIndex = -1;
        MultiView3.ActiveViewIndex = 0;
        MultiView4.ActiveViewIndex = -1;
    }
    protected void btnRouteSearch_Click(object sender, EventArgs e)
    {
        _empId = 0;
        txtEmpIdName.Text = "";
        GetRouteDetail(txtRouteID.Text.Trim());
    }
    protected void rbtDelay_CheckedChanged(object sender, EventArgs e)
    {
        RadioButton rbtDelay = sender as RadioButton;
        GridViewRow gvr = (GridViewRow)rbtDelay.Parent.Parent;
        int rowIndex = gvr.RowIndex;
        GridView grdViewRouteChild = (GridView)rbtDelay.NamingContainer.NamingContainer;
        string routeID = grdViewRouteChild.DataKeys[rowIndex]["routeid"].ToString();
        string empCode = grdViewRouteChild.DataKeys[rowIndex]["empCode"].ToString();
        lblDelayRouteID.Text = routeID;
        lblDelayEmpID.Text = empCode;
        ddlDelays.Items.Clear();
        ListItem li = new ListItem("Select Delay Reason", "0");
        ddlDelays.Items.Add(li);
        ddlDelays.DataSource = tms.getDelays();
        ddlDelays.DataTextField = "delay";
        ddlDelays.DataValueField="id";
        ddlDelays.DataBind();
        _empId = Convert.ToInt32(grdViewRouteChild.DataKeys[rowIndex]["id"].ToString());
        ModalPopupExtender2.Show();
        MultiView5.ActiveViewIndex = 0;
        
    }
    protected void btnSaveDelayReason_Click(object sender, EventArgs e)
    {
        if ((lblDelayRouteID.Text != "") && (lblDelayEmpID.Text != ""))
        {
            tms.MarkDelayByTracker(lblDelayRouteID.Text, _empId,txtDelayReason.Text, MyApplicationSession._UserID,Convert.ToInt32(ddlDelays.SelectedValue));
            lblDelayRouteID.Text = "";
            lblDelayEmpID.Text = "";
            txtDelayReason.Text = "";
            _empId = 0;
        }
    }
}

