using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VehicleInOut : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
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
    }

    public void BndMainGrid()
    {
        try
        {
            string Shifttimes = string.Empty;
            Shifttimes = lstShift.SelectedValue.Trim();

            grdViewRouteParent.DataSource = tmscontext.GetRoutes(txtStartDate.Text, txtStartDate.Text, ddlFacility.SelectedValue, rdoTripType.SelectedValue, Shifttimes, "");
            grdViewRouteParent.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    public string GetURL(object RouteID)
    {
        string ID = Convert.ToString(RouteID);
        String lbtnnavigateurl = new EncryptQueryString().Encrypt("Startdate=" + "&EndDate=" + "&FacilityID=" + "&TripType=" + "&Shifttimes=" + "&RouteID=" + ID);

        return "~/PrintTripsheet.aspx?" + lbtnnavigateurl;

    }
    protected void imbSaveInOut_Click(object sender, ImageClickEventArgs e)
    {
        for (int i = 0; i < grdViewRouteParent.Rows.Count; i++)
        {
            TextBox txtSDate = (TextBox)grdViewRouteParent.Rows[i].FindControl("txtSDate");
            TextBox txtTIMEIN = (TextBox)grdViewRouteParent.Rows[i].FindControl("txtTIMEIN");
            TextBox txtEDate = (TextBox)grdViewRouteParent.Rows[i].FindControl("txtEDate");
            TextBox txtTIMEOut = (TextBox)grdViewRouteParent.Rows[i].FindControl("txtTIMEOut");

            string routeID = grdViewRouteParent.DataKeys[i]["RouteID"].ToString();

            //if ((routeID != "") && (txtSDate.Text != "") && (txtTIMEIN.Text != "") && (txtEDate.Text != "") && (txtTIMEOut.Text != ""))
            //{
            if (rdoTripType.SelectedValue == "P")
            {
                if (txtTIMEIN.Text != "")
                {
                    tmscontext.UpdateVehicleInOut(routeID, Convert.ToDateTime(txtEDate.Text), txtTIMEOut.Text, Convert.ToDateTime(txtSDate.Text), txtTIMEIN.Text, MyApplicationSession._UserID);
                }
               }
            else
            {
                if (txtTIMEOut.Text != "")
                {
                    if (txtTIMEIN.Text == "")
                        txtTIMEIN.Text =null;
                    tmscontext.UpdateVehicleInOut(routeID, Convert.ToDateTime(txtEDate.Text), txtTIMEOut.Text, Convert.ToDateTime(txtSDate.Text), txtTIMEIN.Text, MyApplicationSession._UserID);
                }
            }
            //}
        }
        BndMainGrid();
        ShowMessage("Timing Updated Successfully!!");
    }
    protected Boolean getenabledrop()
    {
    if(rdoTripType.SelectedValue=="D")
    {
    return true;
    }
    return false;
    }
    protected Boolean getenablepick()
    {
        if (rdoTripType.SelectedValue == "P")
        {
            return true;
        }
        return false;
    }
    protected string getintime(Object start, Object end)
    {
        if (start == null)
            start = "";
        if (end == null)
            end = "";
        
        if (rdoTripType.SelectedValue == "P")
        {
            return end.ToString();
        }
        return end.ToString();

    }
    protected string getouttime(Object start, Object end)
    {
        if (start == null)
            start = "";
        if (end == null)
            end = "";
        if (rdoTripType.SelectedValue == "P")
        {
            return start.ToString();
        }
        return start.ToString();
    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);
        
    }

    public Boolean Geticon(object flag)
    {
        int ID = Convert.ToInt32(flag);
        if (ID == 0)
            return false;

        return true;

    }
}
