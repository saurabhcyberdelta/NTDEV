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

public partial class VendorAllocation : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    public string _shifttimes
    {
        get
        {
            return (string)ViewState["_shifttimes"];
        }

        set
        {
            ViewState["_shifttimes"] = value;
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
        string Shifttimes = string.Empty;
        if (lstShift.SelectedIndex >= 0)
        {
            for (int i = 0; i < lstShift.Items.Count; i++)
            {
                if (lstShift.Items[i].Selected)
                {
                    Shifttimes += lstShift.Items[i].Text.Trim() + ",";
                }
            }
        }
        _shifttimes = Shifttimes.Remove(Shifttimes.Length - 1, 1);
        BndMainGrid();
        BndDvViewStatistics();
        BndDatalistVendorCount();

       
        //lbtnPrintHtml.NavigateUrl = "~/PrintTripsheet.aspx?Startdate=" + Server.HtmlEncode(txtStartDate.Text) + "&EndDate=" + Server.HtmlEncode(txtStartDate.Text) + "&FacilityID=" + Server.HtmlEncode(ddlFacility.SelectedValue) + "&TripType=" + Server.HtmlEncode(rdoTripType.SelectedValue) + "&Shifttimes=" + Server.HtmlEncode(Shifttimes);
        //lbtnPrintExcel.NavigateUrl = "~/PrintTripsheetToExcel.aspx?Startdate=" + Server.HtmlEncode(txtStartDate.Text) + "&EndDate=" + Server.HtmlEncode(txtStartDate.Text) + "&FacilityID=" + Server.HtmlEncode(ddlFacility.SelectedValue) + "&TripType=" + Server.HtmlEncode(rdoTripType.SelectedValue) + "&Shifttimes=" + Server.HtmlEncode(Shifttimes);

        String lbtnnavigateurl = (new EncryptQueryString()).Encrypt("Startdate=" + Server.HtmlEncode(txtStartDate.Text) + "&EndDate=" + Server.HtmlEncode(txtStartDate.Text) + "&FacilityID=" + Server.HtmlEncode(ddlFacility.SelectedValue) + "&TripType=" + Server.HtmlEncode(rdoTripType.SelectedValue) + "&Shifttimes=" + Server.HtmlEncode(_shifttimes) + "&RouteID=");
        lbtnPrintHtml.NavigateUrl = "~/PrintTripsheet.aspx?" + lbtnnavigateurl;
        lbtnnavigateurl = (new EncryptQueryString()).Encrypt("Startdate=" + Server.HtmlEncode(txtStartDate.Text) + "&EndDate=" + Server.HtmlEncode(txtStartDate.Text) + "&FacilityID=" + Server.HtmlEncode(ddlFacility.SelectedValue) + "&TripType=" + Server.HtmlEncode(rdoTripType.SelectedValue) + "&Shifttimes=" + Server.HtmlEncode(_shifttimes) + "&RouteID=");
        lbtnPrintExcel.NavigateUrl = "~/PrintTripsheetToExcel.aspx?" + lbtnnavigateurl;
    }

    public void BndMainGrid()
    {
        try
        {
           

            grdViewRouteParent.DataSource = tmscontext.GetRoutes(txtStartDate.Text, txtStartDate.Text, ddlFacility.SelectedValue, rdoTripType.SelectedValue, _shifttimes, "");
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
                lbtnExportVendorSheet.Visible = false;
                ShowMessage("No Records Found");
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
           

            DvViewStatistics.DataSource = tmscontext.GetRoutesStatistics(txtStartDate.Text, txtStartDate.Text, ddlFacility.SelectedValue, rdoTripType.SelectedValue, _shifttimes);
            DvViewStatistics.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    public void BndDatalistVendorCount()
    {
        try
        {
           

            DataListVendorCount.DataSource = tmscontext.GetAssignedVendorCount(txtStartDate.Text, txtStartDate.Text, ddlFacility.SelectedValue, rdoTripType.SelectedValue, _shifttimes);
            DataListVendorCount.DataBind();
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

            }
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
        DataListVendorCount.Visible = true;
        lbtnExportVendorSheet.Visible = true;
    }

    private void DisableContol()
    {
        lbtnPrintHtml.Visible = false;
        lbtnExportVendorSheet.Visible = false;
        lbtnPrintExcel.Visible = false;
        grdViewRouteParent.Visible = false;
        DvViewStatistics.Visible = false;
        DataListVendorCount.Visible = false;
    }
    protected void grdViewRouteParent_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdViewRouteParent.PageIndex = e.NewPageIndex;
            BndMainGrid();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    protected void txtCabID_TextChanged(object sender, EventArgs e)
    {
        TextBox txtCabID = sender as TextBox;
        string CabID = txtCabID.Text;
        string RouteID = string.Empty;

        GridViewRow row = txtCabID.NamingContainer as GridViewRow;
        int rowIndex = Convert.ToInt32(row.RowIndex);
        RouteID = grdViewRouteParent.DataKeys[rowIndex]["RouteID"].ToString();
        string result = string.Empty;
        //tmscontext.AssignStickerToRoutes(RouteID, 0, Server.HtmlEncode(txtCabID.Text),Convert.ToInt32(ddlFacility.SelectedValue),ref result);
        if (result == "0")
        {
            ShowMessage("CabID does not exists.");
            txtCabID.Focus();
            txtCabID.Text = "";
        }
        else
        {
            BndMainGrid();
            BndDatalistVendorCount();
            if (rowIndex == grdViewRouteParent.Rows.Count - 1)
            {
                ((TextBox)grdViewRouteParent.Rows[rowIndex].FindControl("txtCabID")).Focus();
            }
            else
            {
                ((TextBox)grdViewRouteParent.Rows[rowIndex+1].FindControl("txtCabID")).Focus();
            }
        }

    }

    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
    protected void lbtnExportVendorSheet_Click(object sender, EventArgs e)
    {
        string Shifttimes = string.Empty;
       
        GridView1.DataSource = tmscontext.GetRoutes(txtStartDate.Text, txtStartDate.Text, ddlFacility.SelectedValue, rdoTripType.SelectedValue, _shifttimes, "");
        GridView1.DataBind();
        GridViewExportUtil.Export("VendorSheet.xls", GridView1);

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < grdViewRouteParent.Rows.Count; i++)
        {
            string RouteID = grdViewRouteParent.DataKeys[i]["RouteID"].ToString();
            TextBox txtCabID = (TextBox)grdViewRouteParent.Rows[i].FindControl("txtCabID");
            TextBox txtRno = (TextBox)grdViewRouteParent.Rows[i].FindControl("txtRno");

            
            string result = string.Empty;

            tmscontext.AssignStickerToRoutes(RouteID, 0, Server.HtmlEncode(txtCabID.Text), Convert.ToInt32(ddlFacility.SelectedValue), Convert.ToInt32(txtRno.Text), ref result);
        }
        BndMainGrid();
        BndDatalistVendorCount();
    }
    public Boolean Geticon(object flag)
    {
        int ID = Convert.ToInt32(flag);
        if (ID == 0)
            return false;

        return true;

    }
    public Boolean Getmedicalicon(object flag)
    {
        string ID = Convert.ToString(flag);
   string res= tmscontext.getSpecialcasesbyroute(ID).ElementAtOrDefault(0).Result.ToString();
   if (res == "1")
   {
       return true;
   }
   else
   {
       return false;
   }
    }

   
}

