using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReportTableAdapters;

public partial class Routestat : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    getRoutesStatsTableAdapter ds = new getRoutesStatsTableAdapter();
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

       

       


        BndDvViewStatistics();
        BndDatalistVendorCount();
        MultiView1.ActiveViewIndex = 0;
        EnableContol();
        //lbtnPrintHtml.NavigateUrl = "~/PrintTripsheet.aspx?Startdate=" + Server.HtmlEncode(txtStartDate.Text) + "&EndDate=" + Server.HtmlEncode(txtStartDate.Text) + "&FacilityID=" + Server.HtmlEncode(ddlFacility.SelectedValue) + "&TripType=" + Server.HtmlEncode(rdoTripType.SelectedValue) + "&Shifttimes=" + Server.HtmlEncode(Shifttimes);
        //lbtnPrintExcel.NavigateUrl = "~/PrintTripsheetToExcel.aspx?Startdate=" + Server.HtmlEncode(txtStartDate.Text) + "&EndDate=" + Server.HtmlEncode(txtStartDate.Text) + "&FacilityID=" + Server.HtmlEncode(ddlFacility.SelectedValue) + "&TripType=" + Server.HtmlEncode(rdoTripType.SelectedValue) + "&Shifttimes=" + Server.HtmlEncode(Shifttimes);

        String lbtnnavigateurl = (new EncryptQueryString()).Encrypt("Startdate=" + Server.HtmlEncode(txtStartDate.Text) + "&EndDate=" + Server.HtmlEncode(txtStartDate.Text) + "&FacilityID=" + Server.HtmlEncode(ddlFacility.SelectedValue) + "&TripType=" + Server.HtmlEncode(rdoTripType.SelectedValue) + "&Shifttimes=" + Server.HtmlEncode(_shifttimes) + "&RouteID=");
        lbtnPrintHtml.NavigateUrl = "~/PrintTripsheet.aspx?" + lbtnnavigateurl;
        lbtnnavigateurl = (new EncryptQueryString()).Encrypt("Startdate=" + Server.HtmlEncode(txtStartDate.Text) + "&EndDate=" + Server.HtmlEncode(txtStartDate.Text) + "&FacilityID=" + Server.HtmlEncode(ddlFacility.SelectedValue) + "&TripType=" + Server.HtmlEncode(rdoTripType.SelectedValue) + "&Shifttimes=" + Server.HtmlEncode(_shifttimes) + "&RouteID=");
        lbtnPrintExcel.NavigateUrl = "~/PrintTripsheetToExcel.aspx?" + lbtnnavigateurl;
     
    }

   
    public void BndDvViewStatistics()
    {
        try
        {
            //string Shifttimes = string.Empty;
            //if (lstShift.SelectedIndex >= 0)
            //{
            //    for (int i = 0; i < lstShift.Items.Count; i++)
            //    {
            //        if (lstShift.Items[i].Selected)
            //        {
            //            Shifttimes += lstShift.Items[i].Text.Trim() + ",";
            //        }
            //    }
            //}
            //Shifttimes = Shifttimes.Remove(Shifttimes.Length - 1, 1);

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
            //string Shifttimes = string.Empty;
            //if (lstShift.SelectedIndex >= 0)
            //{
            //    for (int i = 0; i < lstShift.Items.Count; i++)
            //    {
            //        if (lstShift.Items[i].Selected)
            //        {
            //            Shifttimes += lstShift.Items[i].Text.Trim() + ",";
            //        }
            //    }
            //}
            //Shifttimes = Shifttimes.Remove(Shifttimes.Length - 1, 1);

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

  


    //protected void ibAssignSticker_Click(object sender, ImageClickEventArgs e)
    //{
    //    for (int i = 0; i < grdViewRouteParent.Rows.Count; i++)
    //    {
    //        DropDownList ddlVendor = (DropDownList)grdViewRouteParent.Rows[i].FindControl("ddlVendor");
    //        TextBox txtCabID = (TextBox)grdViewRouteParent.Rows[i].FindControl("txtCabID");
    //        string routeID = grdViewRouteParent.DataKeys[i]["RouteID"].ToString();

    //        if ((Convert.ToInt32(ddlVendor.SelectedValue) != 0))
    //        {
    //            tmscontext.AssignStickerToRoutes(routeID, Convert.ToInt32(ddlVendor.SelectedValue), Server.HtmlEncode(txtCabID.Text));

    //        }
    //    }
    //    BndMainGrid();
    //    BndDatalistVendorCount();
    //}

    private void EnableContol()
    {
        lbtnPrintHtml.Visible = true;
        lbtnPrintExcel.Visible = true;
       // grdViewRouteParent.Visible = true;
        DvViewStatistics.Visible = true;
        DataListVendorCount.Visible = true;
        lbtnExportVendorSheet.Visible = true;
        lbtnDetail.Visible = true;
    }

    private void DisableContol()
    {
        lbtnPrintHtml.Visible = false;
        lbtnExportVendorSheet.Visible = false;
        lbtnPrintExcel.Visible = false;
        //grdViewRouteParent.Visible = false;
        DvViewStatistics.Visible = false;
        DataListVendorCount.Visible = false;
        lbtnDetail.Visible = false;
    }
   
   

    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
    protected void lbtnExportVendorSheet_Click(object sender, EventArgs e)
    {
        string Shifttimes = string.Empty;
        //if (lstShift.SelectedIndex >= 0)
        //{
        //    for (int i = 0; i < lstShift.Items.Count; i++)
        //    {
        //        if (lstShift.Items[i].Selected)
        //        {
        //            Shifttimes += lstShift.Items[i].Text.Trim() + ",";
        //        }
        //    }
        //}
        //Shifttimes = Shifttimes.Remove(Shifttimes.Length - 1, 1);

        GridView1.DataSource = tmscontext.GetRoutes(txtStartDate.Text, txtStartDate.Text, ddlFacility.SelectedValue, rdoTripType.SelectedValue, _shifttimes, "");
        GridView1.DataBind();
        GridViewExportUtil.Export("VendorSheet.xls", GridView1);

    }
    
    public Boolean Geticon(object flag)
    {
        int ID = Convert.ToInt32(flag);
        if (ID == 0)
            return false;

        return true;

    }
    protected void lbtnDetail_Click(object sender, EventArgs e)
    {
        GridView gv = new GridView();
        gv.DataSource = ds.GetData(Convert.ToDateTime(txtStartDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), rdoTripType.SelectedValue.ToString());
        gv.DataBind();
        for (int i = 1; i < gv.Rows[0].Cells.Count; i++)
        {
            int sum = 0;
            for (int j = 0; j < gv.Rows.Count; j++)
            {
                if (gv.Rows[j].Cells[i].Text != "")
                {
                    if (gv.Rows[j].Cells[i].Text == "&nbsp;")
                        gv.Rows[j].Cells[i].Text = "0";

                    sum = sum + Convert.ToInt32(gv.Rows[j].Cells[i].Text);
                }
            }
            gv.Rows[gv.Rows.Count - 1].Cells[i].Text = sum.ToString();
        }
        gv.Rows[gv.Rows.Count - 1].Cells[0].Text = "Total";

        //  gv.FooterRow.Cells[0].Text = "Sajal";
        gv.HeaderRow.BackColor = System.Drawing.Color.Green;
        gv.HeaderRow.ForeColor = System.Drawing.Color.White;
        gv.HeaderRow.Font.Bold = true;
        gv.Rows[gv.Rows.Count - 1].BackColor = System.Drawing.Color.Green;
        gv.Rows[gv.Rows.Count - 1].ForeColor = System.Drawing.Color.White;
        gv.Rows[gv.Rows.Count - 1].Font.Bold = true;

        GridViewExportUtil.Export("RouteSummary.XLS", gv);

    }
    protected void lbtnBoardCopy_Click(object sender, EventArgs e)
    {
        GridView gvBrd = new GridView();
        gvBrd.DataSource = tmscontext.GetRoutesBoardCopy(txtStartDate.Text, txtStartDate.Text, ddlFacility.SelectedValue.ToString(), rdoTripType.SelectedValue.ToString(), _shifttimes);
        gvBrd.DataBind();
        GridViewExportUtil.Export("BoardCopy.xls", gvBrd);
    }
}

