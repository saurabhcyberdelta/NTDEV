using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ReplicationException : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    public string _facilityid
    {
        get { return (string)ViewState["_facilityid"]; }
        set { ViewState["_facilityid"] = value; }
    }
    public string _ShiftDate
    {
        get { return (string)ViewState["_ShiftDate"]; }
        set { ViewState["_ShiftDate"] = value; }
    }
    public string _StrShift
    {
        get { return (string)ViewState["_StrShift"]; }
        set { ViewState["_StrShift"] = value; }
    }
    public string _strTripType
    {
        get { return (string)ViewState["_strTripType"]; }
        set { ViewState["_strTripType"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        lblmsg.Visible = false;
        MultiView1.ActiveViewIndex = -1;
        CompareValidator3.ValueToCompare = DateTime.Now.ToString("MM/dd/yyyy");
        if (!IsPostBack)
        {
            BndDdl();
            txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string strShifttimes = string.Empty;
            if (lstShift.SelectedIndex >= 0)
            {
                for (int i = 0; i < lstShift.Items.Count; i++)
                {
                    if (lstShift.Items[i].Selected)
                    {
                        strShifttimes = strShifttimes + lstShift.Items[i].Text.Trim() + ",";
                    }
                }
                strShifttimes = strShifttimes.Remove(strShifttimes.Length - 1, 1);
            }
            _ShiftDate = txtStartDate.Text;
            _facilityid = ddlfacility.SelectedValue.ToString();
            _StrShift = strShifttimes;
            _strTripType = rdbtnlstType.SelectedValue;

            //----------Bing Grid for Employee Deletion--------
            BndGridDeleteData();
            //----------Bing Grid for Employee Addition--------
            BndGridAddData();

            var result = tms.GetIsRouteFinalized(Convert.ToDateTime(txtStartDate.Text), Convert.ToInt32(_facilityid), _strTripType, _StrShift).ElementAtOrDefault(0).result.Value.ToString();

            if (result == "True")
            {
                lblmsg.Visible = true;
                lblmsg.Text = "Route has been finalized for " + _StrShift + " shift.";
            }

            lblDelData.Visible = true;
            lblAddData.Visible = true;
            MultiView1.ActiveViewIndex = 0;

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
        finally
        {
            btnSubmit.Enabled = true;
        }
    }
    public void BndGridDeleteData()
    {
        try
        {
            gvDeleteData.DataSource = tms.GetDeleteException(_ShiftDate, Convert.ToInt32(_facilityid), _StrShift, _strTripType);
            gvDeleteData.DataBind();
            MultiView1.ActiveViewIndex = 0;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    public void BndGridAddData()
    {
        try
        {
            gvAddData.DataSource = tms.GetAddException(_ShiftDate, Convert.ToInt32(_facilityid), _StrShift, _strTripType);
            gvAddData.DataBind();
            MultiView1.ActiveViewIndex = 0;
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
                
            }            
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    public void BndLstShift()
    {
        try
        {
            int facid = Convert.ToInt32(ddlfacility.SelectedValue.ToString());
            string type = rdbtnlstType.SelectedValue.ToString();
            lstShift.Items.Clear();
            ListItem list = new ListItem("-Select-", "0");
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
    protected void ddlfacility_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (ddlfacility.SelectedIndex != 0)
        {
            BndLstShift();
        }
    }
    protected void gvDeleteData_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvDeleteData.PageIndex = e.NewPageIndex;
        BndGridDeleteData();
    }
    public void BndDdl()
    {
        try
        {
            ddlfacility.Items.Clear();
            ListItem lifac = new ListItem("Select Facility", "0");
            ddlfacility.Items.Add(lifac);
            ddlfacility.DataSource = tms.SelectFacilityMerge(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            //tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlfacility.DataTextField = "facilityName";
            ddlfacility.DataValueField = "Id";
            ddlfacility.DataBind();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    public void CheckAll(object sender, EventArgs e)
    {
        try
        {
            CheckBox cb = (CheckBox)sender;
            if (cb.Checked == true)
            {
                foreach (GridViewRow i in gvDeleteData.Rows)
                {
                    CheckBox cbl = (CheckBox)i.FindControl("chkTrack");
                    if (cbl != null)
                        cbl.Checked = true;
                }
            }
            else
            {
                foreach (GridViewRow i in gvDeleteData.Rows)
                {
                    CheckBox cbl = (CheckBox)i.FindControl("chkTrack");
                    if (cbl != null)
                        cbl.Checked = false;
                }
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
    protected void ibDelete_Click(object sender, ImageClickEventArgs e)
    {
        string EmpIdList = string.Empty;
        foreach (GridViewRow i in gvDeleteData.Rows)
        {
            CheckBox cbl = (CheckBox)i.FindControl("chkTrack");
            if (cbl.Checked == true)
            {
                EmpIdList = EmpIdList + gvDeleteData.DataKeys[i.RowIndex].Values[0].ToString() + ",";
            }
        }
        if (EmpIdList != string.Empty)
        {
            EmpIdList = EmpIdList.Remove(EmpIdList.Length - 1, 1);
            tms.SprDeleteExceptionEmp(_ShiftDate, Convert.ToInt32(_facilityid), _StrShift, _strTripType, EmpIdList,MyApplicationSession._UserID);
            BndGridDeleteData();
            ShowMessage("Selected employee deleted successfully!");
        }
        else
        {
            ShowMessage("Select atleast one employee for deletion !");
            MultiView1.ActiveViewIndex = 0;
        }
    }

    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
    protected void gvAddData_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvAddData.PageIndex = e.NewPageIndex;
        BndGridAddData();
    }

    protected void ibAddData_Click(object sender, ImageClickEventArgs e)
    {
        string EmpIdList = string.Empty;
        foreach (GridViewRow i in gvAddData.Rows)
        {
            CheckBox cbl = (CheckBox)i.FindControl("chkTrack");
            if (cbl.Checked == true)
            {
                EmpIdList = EmpIdList + gvAddData.DataKeys[i.RowIndex].Values[0].ToString() + ",";
            }
        }

        if (EmpIdList != string.Empty)
        {
            EmpIdList = EmpIdList.Remove(EmpIdList.Length - 1, 1);

            var result = tms.MakeRouteReplicateException(Convert.ToDateTime(_ShiftDate), Convert.ToInt32(_facilityid), _StrShift, _strTripType, EmpIdList, MyApplicationSession._UserID).ElementAtOrDefault(0).NewRouteID.ToString();
            BndGridAddData();
            ShowMessage("Your new routeid generated is " + result);
        }
        else
        {
            ShowMessage("Select atleast one employee to make a new route!");
            MultiView1.ActiveViewIndex = 0;
        }
    }

    protected void CheckAllAdd(object sender, EventArgs e)
    {
        try
        {
            CheckBox cb = (CheckBox)sender;
            if (cb.Checked == true)
            {
                foreach (GridViewRow i in gvAddData.Rows)
                {
                    CheckBox cbl = (CheckBox)i.FindControl("chkTrack");
                    if (cbl != null)
                        cbl.Checked = true;
                }
            }
            else
            {
                foreach (GridViewRow i in gvAddData.Rows)
                {
                    CheckBox cbl = (CheckBox)i.FindControl("chkTrack");
                    if (cbl != null)
                        cbl.Checked = false;
                }
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

    protected void ibaligndata_Click(object sender, ImageClickEventArgs e)
    {
        string EmpIdList = string.Empty;
        foreach (GridViewRow i in gvAddData.Rows)
        {
            CheckBox cbl = (CheckBox)i.FindControl("chkTrack");
            if (cbl.Checked == true)
            {
                EmpIdList = EmpIdList + gvAddData.DataKeys[i.RowIndex].Values[0].ToString() + ",";
            }
        }

        if (EmpIdList != string.Empty)
        {
            EmpIdList = EmpIdList.Remove(EmpIdList.Length - 1, 1);

           lblAssignEmpID.Text=EmpIdList;
             grdRoutes.DataSource = tms.GetRoutes(txtStartDate.Text, txtStartDate.Text, ddlfacility.SelectedValue, rdbtnlstType.SelectedValue, lstShift.SelectedValue,"");
            grdRoutes.DataBind();
              if (grdRoutes.Rows.Count > 0)
            {
                  MultiView2.ActiveViewIndex=0;
                ModalPopupExtender1.Show();
            }
            else
            {
                ShowMessage("No Routes in the system for given Details");
                BndGridAddData();
                BndGridDeleteData();
            }
 
        }
        else
        {
            ShowMessage("Select atleast one employee to align into the route!");
            BndGridAddData();
            BndGridDeleteData();
            MultiView1.ActiveViewIndex = 0;
        }
    }
    protected void lbRouteAssign_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;


            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
          

            int rowindex = gvr.RowIndex;
            string empid = lblAssignEmpID.Text;
            Label routeID = (Label)grdRoutes.Rows[rowindex].FindControl("lblRouteID");
            string rid = routeID.Text;
            Label totstop = (Label)grdRoutes.Rows[rowindex].FindControl("lblTotalStop");
            int tstop = Convert.ToInt32(totstop.Text);
            string[] empids;
            empids=lblAssignEmpID.Text.Split(',');
           for(int len=0;len<empids.Length;len++)
           {
                   
                    tms.AddEmpToRoute(Convert.ToInt32(empids[len].ToString()), tstop + 1, rid);
                    tstop = tstop + 1;
                }

            
            MultiView2.ActiveViewIndex = -1;
            BndGridAddData();
            BndGridDeleteData();
            MultiView1.ActiveViewIndex = 0;
        


        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void btnClose_Click(object sender, ImageClickEventArgs e)
    {
        MultiView2.ActiveViewIndex = -1;
        BndGridAddData();
        BndGridDeleteData();
    }
}