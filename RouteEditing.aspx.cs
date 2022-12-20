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

public partial class RouteEditing : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();

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

    public int _childRowIndex
    {
        get
        {
            return (int)ViewState["_childRowIndex"];
        }

        set
        {
            ViewState["_childRowIndex"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
            BndFacilityDropdown();
            BndShiftTimeListBx();

        }
    }

    public void BndFacilityDropdown()
    {
        try
        {
            ddlFacility.Items.Clear();
            ListItem liv = new ListItem("Select Facility", "0");
            ddlFacility.Items.Add(liv);
            ddlFacility.DataSource = tmscontext.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
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
            ListItem list = new ListItem("-Select-", "0");
            lstShift.Items.Add(list);
            lstShift.DataSource = tmscontext.GetShiftByFacilityType(facid, type);
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

    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            BndShiftTimeListBx();
            DisableContol();
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
            DisableContol();
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
        BndMainGrid();
        BndDvViewStatistics();
        IsRouteFinalized();

        String lbtnnavigateurl = (new EncryptQueryString()).Encrypt("Startdate=" + Server.HtmlEncode(txtStartDate.Text) + "&EndDate=" + Server.HtmlEncode(txtStartDate.Text) + "&FacilityID=" + Server.HtmlEncode(ddlFacility.SelectedValue) + "&TripType=" + Server.HtmlEncode(rdoTripType.SelectedValue) + "&Shifttimes=" + Server.HtmlEncode(lstShift.SelectedValue) + "&RouteID=");
        lbtnPrintHtml.NavigateUrl = "~/PrintTripsheet.aspx?" + lbtnnavigateurl;
        lbtnnavigateurl = (new EncryptQueryString()).Encrypt("Startdate=" + Server.HtmlEncode(txtStartDate.Text) + "&EndDate=" + Server.HtmlEncode(txtStartDate.Text) + "&FacilityID=" + Server.HtmlEncode(ddlFacility.SelectedValue) + "&TripType=" + Server.HtmlEncode(rdoTripType.SelectedValue) + "&Shifttimes=" + Server.HtmlEncode(lstShift.SelectedValue) + "&RouteID=");
        lbtnPrintExcel.NavigateUrl = "~/PrintTripsheetToExcel.aspx?" + lbtnnavigateurl;
        ConfirmButton_btnSave.ConfirmText = "Are you sure You want to Finalize the Routes for " + txtStartDate.Text + " | " + ddlFacility.SelectedItem + " | " + rdoTripType.SelectedValue + " | " + lstShift.SelectedValue;
    }

    public void BndMainGrid()
    {
        try
        {
            string Shifttimes = string.Empty;
            Shifttimes = lstShift.SelectedValue.Trim();

            grdViewRouteParent.DataSource = tmscontext.GetRoutes(txtStartDate.Text, txtStartDate.Text, ddlFacility.SelectedValue, rdoTripType.SelectedValue, Shifttimes, "");
            grdViewRouteParent.DataBind();

            if (grdViewRouteParent.Rows.Count > 0)
            {
                EnableContol();
            }
            else
            {
                lbtnPrintHtml.Visible = false;
                lbtnPrintExcel.Visible = false;
                DvViewStatistics.Visible = false;
                grdViewRouteParent.Visible = true;
               // btnFinalize.Visible = false;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    public void BndDvViewStatistics()
    {
        try
        {
            DvViewStatistics.DataSource = tmscontext.GetRoutesStatistics(txtStartDate.Text, txtStartDate.Text, ddlFacility.SelectedValue, rdoTripType.SelectedValue, lstShift.SelectedValue);
            DvViewStatistics.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    public void IsRouteFinalized()
    {
        try
        {
            string Shifttimes = string.Empty;
            Shifttimes = lstShift.SelectedValue.Trim();
            var result = tmscontext.GetIsRouteFinalized(Convert.ToDateTime(txtStartDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), rdoTripType.SelectedValue, Shifttimes).ElementAtOrDefault(0).result.Value.ToString();

            if (result == "True")
            {
                //btnFinalize.Enabled = false;
               // btnFinalize.Text = "Route Finalized";
            }
            else
            {
              //  btnFinalize.Enabled = true;
              //  btnFinalize.Text = "Finalize Route";
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
                grdViewRouteChild.DataSource = tmscontext.GetRoutesDetails(RouteID);
                grdViewRouteChild.DataBind();
                grdViewRouteChild.Visible = true;
                if (Convert.ToDateTime(txtStartDate.Text) < Convert.ToDateTime(DateTime.Now.Date.ToString("MM/dd/yyyy")))
                {
                    grdViewRouteChild.Enabled = false;
                }
                else
                {
                    grdViewRouteChild.Enabled = true;
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
                ShowMessage("Select Atleast one employee !");
            }

            if (moveFromRouteIDs != string.Empty && empIDs != string.Empty && parentGrdIndexs != string.Empty)
            {
                tmscontext.UpdateCutPaste(moveFromRouteIDs, empIDs, moveToRouteID, (rowIndex + 1));
                grdViewRouteChild.DataSource = tmscontext.GetRoutesDetails(moveToRouteID);
                grdViewRouteChild.DataBind();

                string[] moveFromRouteID = moveFromRouteIDs.Split(',');
                string[] parentGrdRowIndex = parentGrdIndexs.Split(',');
                for (int i = 0; i <= parentGrdRowIndex.Length - 1; i++)
                {
                    GridView OldChildGridView = (GridView)grdViewRouteParent.Rows[Convert.ToInt32(parentGrdRowIndex[i])].FindControl("grdViewRouteChild");
                    OldChildGridView.DataSource = tmscontext.GetRoutesDetails(moveFromRouteID[Convert.ToInt32(i)].ToString());
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
                    tmscontext.UpdateRoute(routeID, strEmployeeID, strShiftdate, Convert.ToInt32(StopNo), ETA);

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
            grdViewRouteChild.DataSource = tmscontext.GetRoutesDetails(routeID);
            grdViewRouteChild.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
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
                    HyperLink lblRouteID = (HyperLink)i.FindControl("lblRouteID");
                    //string routeid = grdViewRouteChild.DataKeys[i].Value.ToString();
                    RouteIDs = RouteIDs + lblRouteID.Text.Trim() + ",";
                }
            }

            Label lblParentErrorMsg = (Label)grdViewRouteParent.FooterRow.FindControl("lblParentErrorMsg");
            lblParentErrorMsg.Text = string.Empty;
            if (RouteIDs != string.Empty)
            {
                RouteIDs = RouteIDs.Remove(RouteIDs.Length - 1, 1);
                tmscontext.MergeRoute(RouteIDs);
                BndMainGrid();
                BndDvViewStatistics();
            }
            else
            {
                lblParentErrorMsg.Text = "** Select Atleast one RouteID ! **";
                ShowMessage("Select Atleast one RouteID !");
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
                var result = tmscontext.SplitRoute(routeID, EmpIDs).ElementAtOrDefault(0).result.ToString();
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
                    BndDvViewStatistics();
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
        try
        {
            MultiView1.ActiveViewIndex = 0;
            ImageButton ImbtInsert = sender as ImageButton;
            GridView grdViewRouteChild = (GridView)ImbtInsert.NamingContainer.NamingContainer;

            _routeID = grdViewRouteChild.DataKeys[0]["routeid"].ToString();
            _childRowIndex = ((GridViewRow)(grdViewRouteChild.NamingContainer)).RowIndex;

            GvEmployee.Visible = false;
            lblSearch.Visible = false;
            ddlStopNO.Items.Clear();
            //BndMainGrid();
            ListItem li = new ListItem("Select Stop No", "0");
            string val = string.Empty;
            ddlStopNO.Items.Add(li);
            for (int i = 0; i <= grdViewRouteChild.Rows.Count; i++)
            {
                val = (i + 1).ToString();
                ddlStopNO.Items.Add(val.ToString());
            }

            ModalPopupExtender.Show();
            txtEmpIdName.Focus();

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void ibDeleteRoute_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
            int index = gvRow.RowIndex;

            //string routeID = ((Label)grdViewRouteParent.Rows[index].FindControl("lblRouteID")).Text.ToString();
            string routeID = grdViewRouteParent.DataKeys[index]["RouteID"].ToString();
            var result = tmscontext.DeleteRoutes("", 0, "", "", routeID, 0, MyApplicationSession._UserID).ElementAtOrDefault(0).result.Value.ToString();
            Label lblParentErrorMsg = (Label)grdViewRouteParent.FooterRow.FindControl("lblParentErrorMsg");
            if (result.Equals("1"))
            {
                BndMainGrid();
                BndDvViewStatistics();
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

            var result = tmscontext.DeleteRoutes("", 0, "", "", routeID, empID, MyApplicationSession._UserID).ElementAtOrDefault(0).result.Value.ToString();
            Label lblParentErrorMsg = (Label)grdViewRouteParent.FooterRow.FindControl("lblParentErrorMsg");
            if (result.Equals("1"))
            {
                grdViewRouteChild.DataSource = tmscontext.GetRoutesDetails(routeID);
                grdViewRouteChild.DataBind();
                lblParentErrorMsg.Text = "Employee deleted Successfully.";
                ShowMessage("Employee deleted Successfully.");
            }
            else
            {
                lblParentErrorMsg.Text = "An error occurred while deleting the employee.";
                ShowMessage("An error occurred while deleting the employee.");
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
        ModalPopupExtender.Hide();
    }

    protected void btnEmpSearch_Click(object sender, EventArgs e)
    {
        try
        {
            BndSearchEmpGrid();
            ModalPopupExtender.Show();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    public void BndSearchEmpGrid()
    {
        try
        {
            GvEmployee.DataSource = tmscontext.EmpSearch(txtEmpIdName.Text, MyApplicationSession._LocationId, MyApplicationSession._ISAdmin);
            GvEmployee.DataBind();
            if (GvEmployee.Rows.Count < 1)
            {

                lblSearch.Visible = true;
                lblSearch.Text = "No Record Found!!!";
                txtEmpIdName.Focus();
                GvEmployee.Visible = false;
            }
            else
            {
                lblSearch.Visible = false;
                //txtEmpIdName.Text = string.Empty;
                GvEmployee.Visible = true;
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

    protected void GvEmployee_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        try
        {
            int empId = Convert.ToInt32(GvEmployee.DataKeys[e.NewSelectedIndex].Value.ToString());
            int stopNo = Convert.ToInt32(ddlStopNO.SelectedValue);
            string result = tmscontext.AddEmpToRoute(empId, stopNo, _routeID).ElementAtOrDefault(0).result.Value.ToString();
            if (result.Equals("1"))
            {
                GridView grdViewRouteChild = (GridView)grdViewRouteParent.Rows[_childRowIndex].FindControl("grdViewRouteChild");
                grdViewRouteChild.DataSource = tmscontext.GetRoutesDetails(_routeID);
                grdViewRouteChild.DataBind();
            }
            else
            {
                lblSearch.Text = "Employee Already Exists in Route or in the same shift";
                lblSearch.Visible = true;
                ModalPopupExtender.Show();
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
        try
        {
            GvEmployee.PageIndex = e.NewPageIndex;
            BndSearchEmpGrid();
            ModalPopupExtender.Show();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }


    private void EnableContol()
    {
        lbtnPrintHtml.Visible = true;
        lbtnPrintExcel.Visible = true;
        grdViewRouteParent.Visible = true;
        DvViewStatistics.Visible = true;
       // btnFinalize.Visible = true;
    }

    private void DisableContol()
    {
        lbtnPrintHtml.Visible = false;
        lbtnPrintExcel.Visible = false;
        grdViewRouteParent.Visible = false;
        DvViewStatistics.Visible = false;
      //  btnFinalize.Visible = false;
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
    protected void btnFinalize_Click(object sender, EventArgs e)
    {
        string Shifttimes = string.Empty;
        Shifttimes = lstShift.SelectedValue.Trim();
        tmscontext.RouteFinalized(Convert.ToDateTime(txtStartDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), rdoTripType.SelectedValue, Shifttimes, MyApplicationSession._UserID);
        IsRouteFinalized();
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

                var result = tmscontext.MakeNewRoute(routeID, EmpIDs, MyApplicationSession._UserID).ElementAtOrDefault(0).NewRouteID.ToString();

                BndMainGrid();
                BndDvViewStatistics();
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
            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "IsDisabled")) == "Y")
            {
                e.Row.BackColor = System.Drawing.Color.SkyBlue;
            }
        }
    }

    public string GetURL(object RouteID)
    {
        string ID = Convert.ToString(RouteID);
        String lbtnnavigateurl = new EncryptQueryString().Encrypt("Startdate=" + "&EndDate=" + "&FacilityID=" + "&TripType=" + "&Shifttimes=" + "&RouteID=" + ID);

        return "~/PrintTripsheet.aspx?" + lbtnnavigateurl;

    }

    public Boolean Geticon(object flag)
    {
        int ID = Convert.ToInt32(flag);
       if(ID==0)
           return false;

       return true;

    }
    public System.Drawing.Color GetColor(object flag)
    {
        int ID = Convert.ToInt32(flag);
        if (ID == 0)
            return System.Drawing.Color.Aqua;

        return System.Drawing.Color.Green;

    }
    public Boolean GetAdmin()
    {
        return (MyApplicationSession._ISAdmin);
    }
}
