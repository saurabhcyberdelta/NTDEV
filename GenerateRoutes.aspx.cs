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
using System.Text.RegularExpressions;

public partial class GenerateRoutes : basepage2
{
    public Boolean _IsRoutesStarted
    {
        get
        {
            return (Boolean)ViewState["_IsRoutesStarted"];
        }
        set
        {
            ViewState["_IsRoutesStarted"] = value;
        }
    }
    public Boolean _IsRoutesCompleted
    {
        get
        {
            return (Boolean)ViewState["_IsRoutesCompleted"];
        }
        set
        {
            ViewState["_IsRoutesCompleted"] = value;
        }
    }

    public ArrayList _shiftArrayList
    {
        get
        {
            return (ArrayList)ViewState["_shiftArrayList"];
        }
        set
        {
            ViewState["_shiftArrayList"] = value;
        }
    }

    public string _Startdate
    {
        get
        {
            return (string)ViewState["_Startdate"];
        }

        set
        {
            ViewState["_Startdate"] = value;
        }
    }

    public string _EndDate
    {
        get
        {
            return (string)ViewState["_EndDate"];
        }

        set
        {
            ViewState["_EndDate"] = value;
        }
    }

    public Int32 _FacilityID
    {
        get
        {
            return (Int32)ViewState["_FacilityID"];
        }

        set
        {
            ViewState["_FacilityID"] = value;
        }
    }

    public string _TripType
    {
        get
        {
            return (string)ViewState["_TripType"];
        }

        set
        {
            ViewState["_TripType"] = value;
        }
    }

    public string _Shifttimes
    {
        get
        {
            return (string)ViewState["_Shifttimes"];
        }

        set
        {
            ViewState["_Shifttimes"] = value;
        }
    }

    public int _parentRowIndex
    {
        get
        {
            return (int)ViewState["_parentRowIndex"];
        }

        set
        {
            ViewState["_parentRowIndex"] = value;
        }
    }

    public string _routeID
    {
        get
        {
            return (string)ViewState["_routeID"];
        }

        set
        {
            ViewState["_routeID"] = value;
        }
    }

    public string _shift
    {
        get
        {
            return (string)ViewState["_shift"];
        }

        set
        {
            ViewState["_shift"] = value;
        }
    }

    public ArrayList _arrlistRouteID
    {
        get
        {
            return (ArrayList)ViewState["_arrlistRouteID"];
        }
        set
        {
            ViewState["_arrlistRouteID"] = value;
        }
    }

    public ArrayList _arrlistEmployeeid
    {
        get
        {
            return (ArrayList)ViewState["_arrlistEmployeeid"];
        }
        set
        {
            ViewState["_arrlistEmployeeid"] = value;
        }
    }

    public ArrayList _arrlistParentGrdRowIndex
    {
        get
        {
            return (ArrayList)ViewState["_arrlistParentGrdRowIndex"];
        }
        set
        {
            ViewState["_arrlistParentGrdRowIndex"] = value;
        }
    }

    DataClasses1DataContext tms = new DataClasses1DataContext();

    string arrcordinates = "MyEmpArray=new Array();\n";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            _IsRoutesStarted = false;
            _IsRoutesCompleted = false;
            _shiftArrayList = new ArrayList();
            _arrlistRouteID = new ArrayList();
            _arrlistEmployeeid = new ArrayList();
            _arrlistParentGrdRowIndex = new ArrayList();
            BndDdl();
            txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
            litCordinates.Text = arrcordinates;

        }
        else
        {
            if (_IsRoutesStarted == true)
            {
                saveData();
                getData();
            }
            else if (_IsRoutesCompleted == true)
            {
                litCordinates.Text = "MyEmpArray = '';";
                saveData();
                pnlProcessBar.Visible = false;
                BndMainGrid();
                _shiftArrayList.Clear();
                _IsRoutesStarted = false;
                _IsRoutesCompleted = false;
            }
        }
    }

    protected void saveData()
    {
        try
        {
            string gMapResult = this.hfResults.Value;
            gMapResult = gMapResult.Substring(1, gMapResult.Length - 1);
            tms.UpdateGMapRoute(_Startdate, _FacilityID, _TripType, _shift, gMapResult);
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }
    }

    public void BndDdl()
    {
        //**********************************//
        //Binds Facility Dropdown          //
        //*********************************//
        try
        {
            ddlfacility.Items.Clear();
            ListItem lifac = new ListItem("Select Facility", "0");
            ddlfacility.Items.Add(lifac);
            ddlfacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID,MyApplicationSession._ISAdmin);
            ddlfacility.DataTextField = "facilityName";
            ddlfacility.DataValueField = "Id";
            ddlfacility.DataBind();
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

    protected void ddlfacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblFacError.Visible = false;
        if (ddlfacility.SelectedIndex != 0)
        {
            BndLstShift();

        }
    }

    public void BndLstShift()
    {

        //**********************************//
        //Bind Shift Listbox              //
        //*********************************//
        try
        {
            _FacilityID = Convert.ToInt32(ddlfacility.SelectedValue.ToString());
            _TripType = rdbtnlstType.SelectedValue.ToString();
            lstShift.Items.Clear();
            ListItem list = new ListItem("-Select-", "0");
            lstShift.Items.Add(list);
            lstShift.DataSource = tms.GetShiftByFacilityType(_FacilityID, _TripType);
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

    protected void rdbtnlstType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlfacility.SelectedIndex != 0)
            {

                BndLstShift();
                lblFacError.Visible = false;
            }
            else
            {

                lblFacError.Visible = true;

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            btnSubmit.Enabled = false;
            _Startdate = txtStartDate.Text;
            _EndDate = txtStartDate.Text;
            _TripType = rdbtnlstType.SelectedValue;
            _FacilityID = Convert.ToInt32(ddlfacility.SelectedValue.ToString());
            _Shifttimes = string.Empty;

            if (lstShift.SelectedIndex >= 0)
            {
                for (int i = 0; i < lstShift.Items.Count; i++)
                {
                    if (lstShift.Items[i].Selected)
                    {
                        _Shifttimes = _Shifttimes + lstShift.Items[i].Text.Trim() + ",";
                    }
                }
                _Shifttimes = _Shifttimes.Remove(_Shifttimes.Length - 1, 1);
            }

            _shiftArrayList.AddRange(_Shifttimes.Split(','));
            grdViewRouteParent.DataSource = null;
            grdViewRouteParent.DataBind();

            Int32 IsRouteExists;
            IsRouteExists = tms.GetRoutes(_Startdate, _EndDate, Convert.ToString(_FacilityID), _TripType, _Shifttimes,"").Count();
            if (IsRouteExists <= 0)
            {
                getData();
            }
            else
            {
                litCordinates.Text = "MyEmpArray = '';";
                lblMessage.Text = "Data already exists!";
                pnlProcessBar.Visible = false;
                BndMainGrid();
                _shiftArrayList.Clear();
                _IsRoutesStarted = false;
                _IsRoutesCompleted = false;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }
        finally
        {
            btnSubmit.Enabled = true;
        }
    }

    protected void getData()
    {
        try
        {
            for (int i = 0; i < _shiftArrayList.Count; i++)
            {
                _shift = _shiftArrayList[i].ToString();

                var result = tms.GetEmpForRouting(_Startdate, _FacilityID, _TripType, _shift);
                //GridView tempGrid = new GridView();
                //tempGrid.DataSource = tms.GetEmpForRouting(_Startdate, _FacilityID, _TripType, shift);
                //tempGrid.DataBind();
                int j = 0;
                //int resultCount = 1;
                int resultCount = tms.GetEmpForRouting(_Startdate, _FacilityID, _TripType, _shift).Count();
                if (resultCount != 0)
                {
                    pnlProcessBar.Visible = true;
                    foreach (var result1 in result)
                    {
                        arrcordinates += "MyEmpArray[" + j + "]=new Array(2);\n";
                        arrcordinates += "MyEmpArray[" + j + "][0]=" + result1.id + ";\n";
                        arrcordinates += "MyEmpArray[" + j + "][1]=" + result1.BaseDistance + ";\n";
                        arrcordinates += "MyEmpArray[" + j + "][2]=" + result1.geoY + ";\n";
                        arrcordinates += "MyEmpArray[" + j + "][3]=" + result1.geoX + ";\n";
                        arrcordinates += "MyEmpArray[" + j + "][4]=" + result1.BaseDuration + ";\n";
                        j++;
                    }
                    litCordinates.Text = arrcordinates;
                    lblMessage.Text = "";
                    _shiftArrayList.RemoveAt(i);
                    _IsRoutesStarted = true;
                    _IsRoutesCompleted = false;
                    if (_shiftArrayList.Count == 0)
                    {
                        _IsRoutesStarted = false;
                        _IsRoutesCompleted = true;
                    }
                    break;
                }
                else
                {
                    lblMessage.Text = "Data does not exists for routing .";
                    litCordinates.Text = "MyEmpArray = '';";
                    pnlProcessBar.Visible = false;
                    _IsRoutesStarted = false;
                    _IsRoutesCompleted = false;
                }
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }
    }

    protected void grdViewRouteParent_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            string RouteIDs = string.Empty;

            if (e.CommandName == "ShowDetailPanel")
            {
                GridViewRow gvr = (GridViewRow)((ImageButton)e.CommandSource).NamingContainer;
                int rowindex = gvr.RowIndex;
                GridView grdViewRouteChild = (GridView)grdViewRouteParent.Rows[rowindex].FindControl("grdViewRouteChild");
                if (grdViewRouteChild.Visible == true)
                {
                    grdViewRouteChild.Visible = false;
                }
                else
                {
                    grdViewRouteChild.Visible = true;
                }
                ImageButton ibViewRouteID = (ImageButton)grdViewRouteParent.Rows[rowindex].FindControl("ibViewRouteID");

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

            if (e.CommandName == "Merge")
            {

                GridView grdViewRouteChild = (GridView)sender;
                foreach (GridViewRow i in grdViewRouteChild.Rows)
                {
                    CheckBox cb = (CheckBox)i.FindControl("chkBxRouteID");
                    if (cb != null && cb.Checked)
                    {
                        Label lblRouteID = (Label)i.FindControl("lblRouteID");
                        RouteIDs = RouteIDs + lblRouteID.Text.Trim() + ",";
                    }
                }
                Label lblParentErrorMsg = (Label)grdViewRouteParent.FooterRow.FindControl("lblParentErrorMsg");
                lblParentErrorMsg.Text = string.Empty;
                if (RouteIDs != string.Empty)
                {
                    RouteIDs = RouteIDs.Remove(RouteIDs.Length - 1, 1);
                    tms.MergeRoute(RouteIDs);
                    BndMainGrid();
                }
                else
                {
                    lblParentErrorMsg.Text = "** Select Atleast one RouteID ! **";
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

    public void BndMainGrid()
    {
        try
        {
            grdViewRouteParent.DataSource = tms.GetRoutes(_Startdate, _EndDate, Convert.ToString(_FacilityID), _TripType, _Shifttimes,"");
            grdViewRouteParent.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void grdViewRouteParent_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                GridViewRow row = e.Row;
                string routeid;
                GridView grdViewRouteChild = (GridView)row.FindControl("grdViewRouteChild");
                routeid = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "RouteID"));
                grdViewRouteChild.DataSource = tms.GetRoutesDetails(routeid);
                grdViewRouteChild.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

    protected void grdViewRouteChild_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        try
        {
            GridView grdChildTemp = (GridView)sender;
            _parentRowIndex = ((GridViewRow)(grdChildTemp.NamingContainer)).RowIndex;
            _routeID = grdChildTemp.DataKeys[0].Values[0].ToString();
            string EmployeeID = grdChildTemp.DataKeys[Convert.ToInt32(e.NewSelectedIndex)].Values[1].ToString();

            _arrlistRouteID.Add(_routeID);
            _arrlistEmployeeid.Add(EmployeeID);
            _arrlistParentGrdRowIndex.Add(_parentRowIndex);
            grdChildTemp.Rows[Convert.ToInt32(e.NewSelectedIndex)].BackColor = System.Drawing.Color.Salmon;

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
            GridView grdChildTemp = (GridView)sender;
            _parentRowIndex = ((GridViewRow)(grdChildTemp.NamingContainer)).RowIndex;
            _routeID = grdChildTemp.DataKeys[0].Values[0].ToString();
            string EmpIDs = string.Empty;
            if (e.CommandName == "UpdateStopNo")
            {

                foreach (GridViewRow i in grdChildTemp.Rows)
                {
                    string strEmployeeID = grdChildTemp.DataKeys[i.RowIndex].Values[1].ToString();
                    DateTime strShiftdate = Convert.ToDateTime(grdChildTemp.DataKeys[i.RowIndex].Values[2]);
                    Int32 intStopNo = Convert.ToInt32(((TextBox)grdChildTemp.Rows[i.RowIndex].FindControl("txtstopNo")).Text);
                    string strETAhh = ((TextBox)grdChildTemp.Rows[i.RowIndex].FindControl("txtETAhh")).Text;
                    string strETAmm = ((TextBox)grdChildTemp.Rows[i.RowIndex].FindControl("txtETAmm")).Text;
//                    tms.UpdateRoute(_routeID, strEmployeeID, strShiftdate, intStopNo, strETAhh, strETAmm);

                }
                grdChildTemp.DataSource = tms.GetRoutesDetails(_routeID);
                grdChildTemp.DataBind();
                foreach (GridViewRow i in grdChildTemp.Rows)
                {
                    grdChildTemp.Rows[Convert.ToInt32(i.RowIndex)].BackColor = System.Drawing.Color.SkyBlue;
                    ((TextBox)grdChildTemp.Rows[Convert.ToInt32(i.RowIndex)].FindControl("txtETAhh")).Enabled = false;
                    ((TextBox)grdChildTemp.Rows[Convert.ToInt32(i.RowIndex)].FindControl("txtETAmm")).Enabled = false;
                    ((TextBox)grdChildTemp.Rows[Convert.ToInt32(i.RowIndex)].FindControl("txtstopNo")).Enabled = false;
                    ((CheckBox)grdChildTemp.Rows[Convert.ToInt32(i.RowIndex)].FindControl("chkBxEmployeeID")).Enabled = false;
                    ((ImageButton)grdChildTemp.Rows[Convert.ToInt32(i.RowIndex)].FindControl("ibCutEmployee")).Enabled = false;
                    ((ImageButton)grdChildTemp.Rows[Convert.ToInt32(i.RowIndex)].FindControl("ibPasteEmployee")).Enabled = false;
                    ((ImageButton)grdChildTemp.Rows[Convert.ToInt32(i.RowIndex)].FindControl("ibDeleteEmployee")).Enabled = false;
                    ((ImageButton)grdChildTemp.FooterRow.FindControl("ibUpdateStopNo")).Enabled = false;
                    ((ImageButton)grdChildTemp.FooterRow.FindControl("ImbtSplit")).Enabled = false;

                }
            }

            if (e.CommandName == "Paste")
            {
                try
                {
                    string oldRouteID = string.Empty;
                    string oldEmployeeID = string.Empty;
                    string OldparentGrdRowIndex = string.Empty;
                    string NewRouteID = _routeID;
                    Int32 NewStopNo = Convert.ToInt32(((TextBox)grdChildTemp.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtstopNo")).Text);

                    for (int i = 0; i < _arrlistRouteID.Count; i++)
                    {
                        oldRouteID = _arrlistRouteID[i].ToString() + "," + oldRouteID;
                    }

                    for (int i = 0; i < _arrlistEmployeeid.Count; i++)
                    {
                        oldEmployeeID = _arrlistEmployeeid[i].ToString() + "," + oldEmployeeID;
                    }

                    if (oldRouteID != string.Empty && oldEmployeeID != string.Empty)
                    {
                        tms.UpdateCutPaste(oldRouteID, oldEmployeeID, NewRouteID, NewStopNo);
                        grdChildTemp.DataSource = tms.GetRoutesDetails(NewRouteID);
                        grdChildTemp.DataBind();
                    }

                    for (int i = 0; i < _arrlistParentGrdRowIndex.Count; i++)
                    {
                        OldparentGrdRowIndex = _arrlistParentGrdRowIndex[i].ToString();
                        GridView OldChildGridView = (GridView)grdViewRouteParent.Rows[Convert.ToInt32(OldparentGrdRowIndex)].FindControl("grdViewRouteChild");
                        OldChildGridView.DataSource = tms.GetRoutesDetails(_arrlistRouteID[i].ToString());
                        OldChildGridView.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    _arrlistRouteID.Clear();
                    _arrlistEmployeeid.Clear();
                    _arrlistParentGrdRowIndex.Clear();

                }
            }

            if (e.CommandName == "Split")
            {
                foreach (GridViewRow i in grdChildTemp.Rows)
                {
                    CheckBox cb = (CheckBox)i.FindControl("chkBxEmployeeID");
                    if (cb != null && cb.Checked)
                    {
                        string lblEmpID = grdChildTemp.DataKeys[i.RowIndex].Values[1].ToString();
                        EmpIDs = EmpIDs + lblEmpID.Trim() + ",";
                    }
                }

                Label lblChildErrorMsg = (Label)grdChildTemp.FooterRow.FindControl("lblChildErrorMsg");
                lblChildErrorMsg.Text = string.Empty;
                if (EmpIDs != string.Empty)
                {
                    EmpIDs = EmpIDs.Remove(EmpIDs.Length - 1, 1);
                    tms.SplitRoute(_routeID, EmpIDs);
                    BndMainGrid();
                }
                else
                {
                    lblChildErrorMsg.Text = "** Select Atleast one employee ! **";
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

    protected void grdViewRouteParent_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdViewRouteParent.PageIndex = e.NewPageIndex;
        BndMainGrid();
    }

    protected void linkbtMerge_Click(object sender, EventArgs e)
    {
        try
        {
            string RouteIDs = string.Empty;
            LinkButton linkbtMerge = sender as LinkButton;
            foreach (GridViewRow i in grdViewRouteParent.Rows)
            {
                CheckBox cb = (CheckBox)i.FindControl("chkBxRouteID");
                if (cb != null && cb.Checked)
                {
                    Label lblRouteID = (Label)i.FindControl("lblRouteID");
                    //string routeid = grdViewRouteChild.DataKeys[i].Value.ToString();
                    RouteIDs = RouteIDs + lblRouteID.Text.Trim() + ",";
                }
            }

            Label lblParentErrorMsg = (Label)grdViewRouteParent.FooterRow.FindControl("lblParentErrorMsg");
            lblParentErrorMsg.Text = string.Empty;
            if (RouteIDs != string.Empty)
            {
                RouteIDs = RouteIDs.Remove(RouteIDs.Length - 1, 1);
                tms.MergeRoute(RouteIDs);
                BndMainGrid();
            }
            else
            {
                lblParentErrorMsg.Text = "** Select Atleast one RouteID ! **";
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void ibViewRouteID_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            string RouteID = string.Empty;

            ImageButton ibViewRouteID = sender as ImageButton;
            GridViewRow row = ibViewRouteID.NamingContainer as GridViewRow;
            int rowIndex = Convert.ToInt32(row.RowIndex);
            GridView grdViewRouteChild = (GridView)grdViewRouteParent.Rows[rowIndex].FindControl("grdViewRouteChild");

            if (grdViewRouteChild.Visible == true)
            {
                ibViewRouteID.ImageUrl = "~/images/plus.gif";
                ibViewRouteID.ToolTip = "To Expand the Route Detail";
                grdViewRouteChild.Visible = false;
            }
            else
            {
                ibViewRouteID.ImageUrl = "~/images/minus.gif";
                ibViewRouteID.ToolTip = "To Collapse the Route Detail";

                RouteID = grdViewRouteParent.DataKeys[rowIndex]["RouteID"].ToString();
                grdViewRouteChild.DataSource = tms.GetRoutesDetails(RouteID);
                grdViewRouteChild.DataBind();
                grdViewRouteChild.Visible = true;

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void ImbtSplit_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            string EmpIDs = string.Empty;

            ImageButton ImbtSplit = sender as ImageButton;
            GridView grdViewRouteChild = (GridView)ImbtSplit.NamingContainer.NamingContainer;
            string routeID = grdViewRouteChild.DataKeys[0]["routeid"].ToString();
            foreach (GridViewRow i in grdViewRouteChild.Rows)
            {
                CheckBox cb = (CheckBox)i.FindControl("chkBxEmployeeID");
                if (cb != null && cb.Checked)
                {
                    string lblEmpID = grdViewRouteChild.DataKeys[i.RowIndex]["id"].ToString();
                    EmpIDs = EmpIDs + lblEmpID.Trim() + ",";
                }
            }

            Label lblChildErrorMsg = (Label)grdViewRouteChild.FooterRow.FindControl("lblChildErrorMsg");
            lblChildErrorMsg.Text = string.Empty;
            if (EmpIDs != string.Empty)
            {
                EmpIDs = EmpIDs.Remove(EmpIDs.Length - 1, 1);
                var result = tms.SplitRoute(routeID, EmpIDs).ElementAtOrDefault(0).result.ToString();
                if (result == "-1")
                {
                    lblChildErrorMsg.Text = "Route is already splited,so cannot split again";
                }
                else if (result == "0")
                {
                    lblChildErrorMsg.Text = "Route is already splited,so cannot split again";
                }
                else
                {
                    BndMainGrid();
                }


            }
            else
            {
                lblChildErrorMsg.Text = "** Select Atleast one employee ! **";
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }

    }

    protected void ImbtInsert_Click(object sender, ImageClickEventArgs e)
    {
        
    }

    protected void ibUpdateStopNo_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ImageButton ibUpdateStopNo = sender as ImageButton;
            GridView grdViewRouteChild = (GridView)ibUpdateStopNo.NamingContainer.NamingContainer;

            string routeID = grdViewRouteChild.DataKeys[0]["routeid"].ToString();
            DateTime strShiftdate = Convert.ToDateTime(grdViewRouteChild.DataKeys[0]["shiftdate"].ToString());

            foreach (GridViewRow i in grdViewRouteChild.Rows)
            {
                string strEmployeeID = grdViewRouteChild.DataKeys[i.RowIndex]["id"].ToString();
                string StopNo;
                Boolean isValidStopNo, isValidETAhh, isValidETAmm, isValidETA;
                StopNo = ((TextBox)grdViewRouteChild.Rows[i.RowIndex].FindControl("txtstopNo")).Text;
                if (ValidateNumber(StopNo))
                {
                    if (Convert.ToInt32(StopNo) > 0)
                    {
                        isValidStopNo = true;
                    }
                    else
                    {
                        isValidStopNo = false;
                    }
                }
                else
                {
                    isValidStopNo = false;
                }
                string ETA = ((TextBox)grdViewRouteChild.Rows[i.RowIndex].FindControl("txtETA")).Text;
                if (!Regex.IsMatch(ETA, @"^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))$|^([01]\d|2[0-3])(:[0-5]\d){0,2}$"))
                {
                    isValidETA = false;
                }
                else
                {
                    isValidETA = true;
                }
                //string strETAhh = ((TextBox)grdViewRouteChild.Rows[i.RowIndex].FindControl("txtETAhh")).Text;
                //if (ValidateNumber(strETAhh))
                //{
                //    if (Convert.ToInt32(strETAhh) >= 0 && Convert.ToInt32(strETAhh) < 24)
                //    {
                //        isValidETAhh = true;
                //    }
                //    else
                //    {
                //        isValidETAhh = false;
                //    }
                //}
                //else
                //{
                //    isValidETAhh = false;
                //}
                //string strETAmm = ((TextBox)grdViewRouteChild.Rows[i.RowIndex].FindControl("txtETAmm")).Text;

                //if (ValidateNumber(strETAmm))
                //{
                //    if (Convert.ToInt32(strETAmm) >= 0 && Convert.ToInt32(strETAmm) < 59)
                //    {
                //        isValidETAmm = true;
                //    }
                //    else
                //    {
                //        isValidETAmm = false;
                //    }
                //}
                //else
                //{
                //    isValidETAmm = false;
                //}
                //if (isValidStopNo == true && isValidETAhh == true && isValidETAmm == true)
                if (isValidStopNo == true && isValidETA == true)
                {
                    //tmscontext.UpdateRoute(routeID, strEmployeeID, strShiftdate, Convert.ToInt32(StopNo), strETAhh, strETAmm);
                    tms.UpdateRoute(routeID, strEmployeeID, strShiftdate, Convert.ToInt32(StopNo), ETA);

                }
                else
                {
                    Label lblChildErrorMsg = (Label)grdViewRouteChild.FooterRow.FindControl("lblChildErrorMsg");
                    lblChildErrorMsg.Text = string.Empty;
                    lblChildErrorMsg.Text = "Either you enter the wrong StopNo or ETA.";
                    ShowMessage("Either you enter the wrong StopNo or ETA !");
                    break;
                }
            }
            grdViewRouteChild.DataSource = tms.GetRoutesDetails(routeID);
            grdViewRouteChild.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
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

    protected void ibPasteEmployee_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ImageButton ibPasteEmployee = sender as ImageButton;
            GridViewRow row = ibPasteEmployee.NamingContainer as GridViewRow;
            // Child row index
            int rowIndex = Convert.ToInt32(row.RowIndex);

            GridView grdViewRouteChild = (GridView)ibPasteEmployee.NamingContainer.NamingContainer;

            // to get the parent row index
            int parentRowIndex = ((GridViewRow)(grdViewRouteChild.NamingContainer)).RowIndex;

            // to get the parent routeid
            string moveToRouteID = grdViewRouteParent.DataKeys[parentRowIndex]["RouteID"].ToString();
            string moveFromRouteIDs = string.Empty;
            string empIDs = string.Empty;
            string parentGrdIndexs = string.Empty;
            foreach (GridViewRow gvr in grdViewRouteParent.Rows)
            {

                GridView grdViewRouteChildTemp = ((GridView)gvr.FindControl("grdViewRouteChild"));
                int inxParent = Convert.ToInt32(gvr.RowIndex);
                if (grdViewRouteChildTemp.Visible == true)
                {
                    foreach (GridViewRow gvrchild in grdViewRouteChildTemp.Rows)
                    {
                        CheckBox cb = (CheckBox)gvrchild.FindControl("chkBxEmployeeID");
                        if (cb.Checked == true)
                        {
                            parentGrdIndexs += inxParent + ",";
                            moveFromRouteIDs += grdViewRouteChildTemp.DataKeys[Convert.ToInt32(gvrchild.RowIndex)]["routeid"].ToString() + ",";
                            empIDs += grdViewRouteChildTemp.DataKeys[Convert.ToInt32(gvrchild.RowIndex)]["id"].ToString() + ",";

                        }
                    }
                }
            }

            if (moveFromRouteIDs != string.Empty && empIDs != string.Empty && parentGrdIndexs != string.Empty)
            {
                parentGrdIndexs = parentGrdIndexs.Remove(parentGrdIndexs.Length - 1, 1);
                moveFromRouteIDs = moveFromRouteIDs.Remove(moveFromRouteIDs.Length - 1, 1);
                empIDs = empIDs.Remove(empIDs.Length - 1, 1);
            }
            else
            {
                Label lblChildErrorMsg = (Label)grdViewRouteChild.FooterRow.FindControl("lblChildErrorMsg");
                lblChildErrorMsg.Text = string.Empty;
                lblChildErrorMsg.Text = "** Select Atleast one employee ! **";
            }

            if (moveFromRouteIDs != string.Empty && empIDs != string.Empty && parentGrdIndexs != string.Empty)
            {
                tms.UpdateCutPaste(moveFromRouteIDs, empIDs, moveToRouteID, (rowIndex + 1));
                grdViewRouteChild.DataSource = tms.GetRoutesDetails(moveToRouteID);
                grdViewRouteChild.DataBind();

                string[] moveFromRouteID = moveFromRouteIDs.Split(',');
                string[] parentGrdRowIndex = parentGrdIndexs.Split(',');
                for (int i = 0; i <= parentGrdRowIndex.Length - 1; i++)
                {
                    GridView OldChildGridView = (GridView)grdViewRouteParent.Rows[Convert.ToInt32(parentGrdRowIndex[i])].FindControl("grdViewRouteChild");
                    OldChildGridView.DataSource = tms.GetRoutesDetails(moveFromRouteID[Convert.ToInt32(i)].ToString());
                    OldChildGridView.DataBind();
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

    protected void ibDeleteEmployee_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ImageButton ibDeleteEmployee = sender as ImageButton;
            GridViewRow gvRow = (GridViewRow)ibDeleteEmployee.NamingContainer;
            int index = gvRow.RowIndex;
            GridView grdViewRouteChild = (GridView)ibDeleteEmployee.NamingContainer.NamingContainer;
            int parentRowIndex = ((GridViewRow)(grdViewRouteChild.NamingContainer)).RowIndex;
            string routeID = grdViewRouteParent.DataKeys[parentRowIndex]["RouteID"].ToString();
            int empID = Convert.ToInt32(grdViewRouteChild.DataKeys[index]["id"].ToString());

            var result = tms.DeleteRoutes("", 0, "", "", routeID, empID, MyApplicationSession._UserID).ElementAtOrDefault(0).result.Value.ToString();
            Label lblParentErrorMsg = (Label)grdViewRouteParent.FooterRow.FindControl("lblParentErrorMsg");
            if (result.Equals("1"))
            {
                grdViewRouteChild.DataSource = tms.GetRoutesDetails(routeID);
                grdViewRouteChild.DataBind();
                lblParentErrorMsg.Text = "Employee deleted Successfully.";
            }
            else
            {
                lblParentErrorMsg.Text = "An error occurred while deleting the employee.";
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    public Boolean GetAdmin()
    {
        return (MyApplicationSession._ISAdmin);
    }
    protected void ImbtAddNewRoute_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            string EmpIDs = string.Empty;

            ImageButton ImbtAddNewRoute = sender as ImageButton;
            GridView grdViewRouteChild = (GridView)ImbtAddNewRoute.NamingContainer.NamingContainer;
            string routeID = grdViewRouteChild.DataKeys[0]["routeid"].ToString();
            foreach (GridViewRow i in grdViewRouteChild.Rows)
            {
                CheckBox cb = (CheckBox)i.FindControl("chkBxEmployeeID");
                if (cb != null && cb.Checked)
                {
                    string lblEmpID = grdViewRouteChild.DataKeys[i.RowIndex]["id"].ToString();
                    EmpIDs = EmpIDs + lblEmpID.Trim() + ",";
                }
            }

            Label lblChildErrorMsg = (Label)grdViewRouteChild.FooterRow.FindControl("lblChildErrorMsg");
            lblChildErrorMsg.Text = string.Empty;
            if (EmpIDs != string.Empty)
            {
                EmpIDs = EmpIDs.Remove(EmpIDs.Length - 1, 1);

                var result = tms.MakeNewRoute(routeID, EmpIDs, MyApplicationSession._UserID).ElementAtOrDefault(0).NewRouteID.ToString();

                BndMainGrid();
                
                ShowMessage("Your new routeid generated is " + result);
            }
            else
            {
                lblChildErrorMsg.Text = "** Select Atleast one employee ! **";
                ShowMessage("Select atleast one employee !");
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }


    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);
    }
    protected void ibDeleteRoute_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int index = gvRow.RowIndex;

            //string routeID = ((Label)grdViewRouteParent.Rows[index].FindControl("lblRouteID")).Text.ToString();
            string routeID = grdViewRouteParent.DataKeys[index]["RouteID"].ToString();
            var result = tms.DeleteRoutes("", 0, "", "", routeID, 0, MyApplicationSession._UserID).ElementAtOrDefault(0).result.Value.ToString();
            Label lblParentErrorMsg = (Label)grdViewRouteParent.FooterRow.FindControl("lblParentErrorMsg");
            if (result.Equals("1"))
            {
                BndMainGrid();
             
                lblParentErrorMsg.Text = "Route deleted Successfully.";
                ShowMessage("Route deleted Successfully.");
            }
            else
            {
                lblParentErrorMsg.Text = "An error occurred while deleting the route.";
                ShowMessage("An error occurred while deleting the route.");
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
        // Display gold color if routes been finalized and some employee added after it.
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "isNewAdded")) == "True")
            {
                e.Row.BackColor = System.Drawing.Color.GreenYellow;
            }

            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "SpecialCase")) == "1")
            {
                e.Row.BackColor = System.Drawing.Color.RosyBrown;
            }

        }
    }
}
