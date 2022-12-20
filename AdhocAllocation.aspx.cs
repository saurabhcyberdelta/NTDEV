using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdhocAllocation : basepage
{

    public int _Adhocid
    {
        get
        {
            return (int)ViewState["_Adhocid"];
        }

        set
        {
            ViewState["_Adhocid"] = value;
        }
    }
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                bndfacility();
                bndShiftddl();
                txtStartDate.Text = System.DateTime.Now.Date.ToString("MM/dd/yyyy");
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void bndShiftddl()
    {
        try
        {
                ddlShift.Items.Clear();
                ListItem li = new ListItem("--Select--", "0");
                ddlShift.Items.Add(li);
                ddlShift.DataSource = tms.GetShiftByFacilityType(Convert.ToInt32(ddlFacility.SelectedValue), ddlTripType.SelectedValue);
                ddlShift.DataTextField = "shiftTime";
                ddlShift.DataValueField = "shiftTime";
                ddlShift.DataBind();
         
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void bndfacility()
    {
        try
        {
            ddlFacility.Items.Clear();
            ListItem liv = new ListItem("Select Facility", "0");
            ddlFacility.Items.Add(liv);
            ddlFacility.DataSource = tms.GetFacility(MyApplicationSession._LocationId);
            ddlFacility.DataTextField = "facilityName";
            ddlFacility.DataValueField = "Id";
            ddlFacility.DataBind();
            ddlFacility.SelectedIndex = ddlFacility.Items.IndexOf(ddlFacility.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));
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
            bndShiftddl();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
        
    }
    protected void ddlTripType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            bndShiftddl();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            AJX.Visible = true;

            bndgrids();

        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void bndgrids()
    {
        try
        {
          
            GrdEmployeeAccepted.DataSource = tms.GetAdhocForAdmin(Convert.ToDateTime(txtStartDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), ddlTripType.SelectedValue, ddlShift.SelectedValue, "Approved");
            GrdEmployeeAccepted.DataBind();
            if (GrdEmployeeAccepted.Rows.Count > 0)
            {
                lblexport.Visible = true;
            }
            else
            {
                lblexport.Visible = false;
            }
            
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
       }

    protected void lbtnUpdate_Click1(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            int rowindex = gvr.RowIndex;
            string id = GrdEmployeeAccepted.DataKeys[rowindex]["Empid"].ToString();
            lblAssignEmpID.Text = id;
           _Adhocid=Convert.ToInt32( GrdEmployeeAccepted.DataKeys[rowindex]["id"].ToString());
            grdRoutes.DataSource = tms.GetRoutes(txtStartDate.Text, txtStartDate.Text, ddlFacility.SelectedValue, ddlTripType.SelectedValue, ddlShift.SelectedValue,"");
            grdRoutes.DataBind();
            if (grdRoutes.Rows.Count > 0)
            {
                ModalPopupExtender1.Show();
            }
            else
            {
                ShowMessage("No Routes in the system for given Details");
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        ModalPopupExtender1.Hide();
    }


    private void ShowMessage(string message)
    {
        try
        {
            string jScript = "alert('" + message + "');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);


        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void lbtnNewRoute_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;


            int rowindex = gvr.RowIndex;
            string empid = GrdEmployeeAccepted.DataKeys[rowindex]["Empid"].ToString();
            _Adhocid = Convert.ToInt32(GrdEmployeeAccepted.DataKeys[rowindex]["id"].ToString());
            string routeid = tms.MakeRouteReplicateException(Convert.ToDateTime(txtStartDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), ddlShift.SelectedValue, ddlTripType.SelectedValue, empid, MyApplicationSession._UserID).ElementAtOrDefault(0).NewRouteID.ToString();
            ShowMessage("Employee Added in the New Route with RouteID:" + routeid);
            bndgrids();

        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected Boolean enableds(object strArg)
    {
        try
        {
            string val = Convert.ToString(strArg);

            if (val == "true")
            {
                return true;
            }
            else
            {
                return false;
            }

        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
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
            tms.AddEmpToRoute(Convert.ToInt32(empid), tstop + 1, rid);
            bndgrids();
            

        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void lblexport_Click(object sender, EventArgs e)
    {
        GridViewExportUtil.Export("AlignedUnscheduleRequest.xls",GrdEmployeeAccepted);
    }
}
