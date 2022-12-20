using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ShuttleEntry : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BndDdl();
            txtShiftDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
            MultiView1.ActiveViewIndex = -1;
        }

    }

    public void BndDdl()
    {
        //**********************************//
        //Binds Facility Dropdown          //
        //*********************************//
        try
        {
            ddlFacility.Items.Clear();
            ListItem lifac = new ListItem("Select Facility", "0");
            ddlFacility.Items.Add(lifac);
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (rbShuttleType.SelectedValue == "IOS")
        {
            BindgvIOS();
            MultiView1.ActiveViewIndex = 1;
        }
        else if (rbShuttleType.SelectedValue == "BFC")
        {
            BindgvBFC();
            MultiView1.ActiveViewIndex = 2;
        }
        else if (rbShuttleType.SelectedValue == "Toll")
        {
            BindgvToll();
            MultiView1.ActiveViewIndex = 3;
        }
        else
        {
            BindgvFCS();
            MultiView1.ActiveViewIndex = 0;
        }

    }

    private void BindgvIOS()
    {
        gvIOS.DataSource = tms.GetShuttleEntryDetails(Convert.ToDateTime(txtShiftDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), rbShuttleType.SelectedValue);
        gvIOS.DataBind();

        DataTable dt = new DataTable();
        MultiView1.ActiveViewIndex = 1;
        if (gvIOS.Rows.Count <= 0)
        {
            ShowNoResultFound(adddataTableColumn(dt), gvIOS);
        }
    }
    private void BindgvToll()
    {
        gvToll.DataSource = tms.GetTollEntryDetails(Convert.ToDateTime(txtShiftDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), rbShuttleType.SelectedValue);
        gvToll.DataBind();

        DataTable dt = new DataTable();
        MultiView1.ActiveViewIndex = 3;
        if (gvToll.Rows.Count <= 0)
        {
            ShowNoResultFound(adddataTableColumn(dt), gvToll);
        }
    }

    private void BindgvFCS()
    {
        gvFCS.DataSource = tms.GetShuttleEntryDetails(Convert.ToDateTime(txtShiftDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), rbShuttleType.SelectedValue);
        gvFCS.DataBind();

        DataTable dt = new DataTable();

        if (gvFCS.Rows.Count <= 0)
        {
            ShowNoResultFound(adddataTableColumn(dt), gvFCS);
        }
    }
    private void BindgvBFC()
    {
        gvBFC.DataSource = tms.GetShuttleEntryDetails(Convert.ToDateTime(txtShiftDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), rbShuttleType.SelectedValue);
        gvBFC.DataBind();

        DataTable dt = new DataTable();

        if (gvBFC.Rows.Count <= 0)
        {
            ShowNoResultFound(adddataTableColumn(dt), gvBFC);
        }
    }

    private static DataTable adddataTableColumn(DataTable dt)
    {
        dt.Columns.Add("ID", typeof(int));
        dt.Columns.Add("ShiftDate", typeof(DateTime));
        dt.Columns.Add("FacilityID", typeof(int));
        dt.Columns.Add("ShuttleType", typeof(string));
        dt.Columns.Add("CabID", typeof(int));
        dt.Columns.Add("CabRegNo", typeof(string));
        dt.Columns.Add("TimeIN", typeof(DateTime));
        dt.Columns.Add("Time", typeof(DateTime));
        dt.Columns.Add("TimeOut", typeof(DateTime));
        dt.Columns.Add("Duration", typeof(string));
        dt.Columns.Add("DriverName", typeof(string));
        dt.Columns.Add("Plaza", typeof(string));
        dt.Columns.Add("Amount", typeof(Double));
        dt.Columns.Add("StartLocation", typeof(string));
        dt.Columns.Add("EmpCount", typeof(int));
        dt.Columns.Add("IsDocument", typeof(Boolean));
        dt.Columns.Add("UpdatedBy", typeof(int));
        dt.Columns.Add("UpdatedTime", typeof(DateTime));
        return dt;
    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        TextBox txtCabID = (TextBox)gvFCS.FooterRow.FindControl("txtCabID");
        TextBox txtCABNUMERIC = (TextBox)gvFCS.FooterRow.FindControl("txtCABNUMERIC");
        TextBox txtTIMEIN = (TextBox)gvFCS.FooterRow.FindControl("txtTIMEIN");
        TextBox txtTIMEOUT = (TextBox)gvFCS.FooterRow.FindControl("txtTIMEOUT");
        TextBox txtDRIVERNAME = (TextBox)gvFCS.FooterRow.FindControl("txtDRIVERNAME");

     string result=tms.InsertShuttleEntry(Convert.ToDateTime(txtShiftDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), rbShuttleType.SelectedValue, txtCabID.Text, txtCABNUMERIC.Text, txtTIMEIN.Text, txtTIMEOUT.Text, txtDRIVERNAME.Text, 0, 0, false, MyApplicationSession._UserID).ElementAtOrDefault(0).result.ToString();
     if (result == "0")
     {
         ShowMessage("CabId Already Entered for the same day");
     }
     
       BindgvFCS();
        txtCabID = (TextBox)gvFCS.FooterRow.FindControl("txtCabID");
        txtCabID.Focus();
    
     }
    protected void btnSaveToll_Click(object sender, EventArgs e)
    {
        TextBox txtCabID = (TextBox)gvToll.FooterRow.FindControl("txtCabID");
        TextBox txtCABNUMERIC = (TextBox)gvToll.FooterRow.FindControl("txtCABNUMERIC");
        TextBox txtTIME = (TextBox)gvToll.FooterRow.FindControl("txtTIMEIN");
        TextBox txtPlaza = (TextBox)gvToll.FooterRow.FindControl("txtToll");
        TextBox txtTollAmount = (TextBox)gvToll.FooterRow.FindControl("txtAmount");

        string result = tms.InsertTollEntry(Convert.ToDateTime(txtShiftDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), txtCabID.Text, txtCABNUMERIC.Text, txtTIME.Text, txtPlaza.Text, Convert.ToDouble(txtTollAmount.Text), MyApplicationSession._UserID).ElementAtOrDefault(0).result.ToString();
        if (result == "0")
        {
            ShowMessage("CabId Already Entered for the same day");
        }

        BindgvToll();
        txtCabID = (TextBox)gvToll.FooterRow.FindControl("txtCabID");
        txtCabID.Focus();

    }
    protected void btnSaveBFC_Click(object sender, EventArgs e)
    {
        //ShowMessage("success1");
        //return;
        TextBox txtCabID = (TextBox)gvBFC.FooterRow.FindControl("txtCabID");
        //ShowMessage("success2");
        TextBox txtCABNUMERIC = (TextBox)gvBFC.FooterRow.FindControl("txtCABNUMERIC");
        //ShowMessage("success3");
        TextBox txtTIMEIN = (TextBox)gvBFC.FooterRow.FindControl("txtTIMEIN");
        TextBox txtTIMEOUT = (TextBox)gvBFC.FooterRow.FindControl("txtTIMEOUT");
        //TextBox txtDRIVERNAME = (TextBox)gvBFC.FooterRow.FindControl("txtDRIVERNAME");
        
        string result = tms.InsertShuttleEntry(Convert.ToDateTime(txtShiftDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), rbShuttleType.SelectedValue, txtCabID.Text, txtCABNUMERIC.Text, txtTIMEIN.Text, txtTIMEOUT.Text, null, 0, 0, false, MyApplicationSession._UserID).ElementAtOrDefault(0).result.ToString();
        if (result == "0")
        {
            ShowMessage("CabId Already Entered for the same day");
        }

        BindgvBFC();
        txtCabID = (TextBox)gvBFC.FooterRow.FindControl("txtCabID");
        txtCabID.Focus();

    }
    protected void btnSaveIOS_Click(object sender, EventArgs e)
    {
        TextBox txtCabID = (TextBox)gvIOS.FooterRow.FindControl("txtCabID");
        TextBox txtCABNUMERIC = (TextBox)gvIOS.FooterRow.FindControl("txtCABNUMERIC");
        //TextBox txtTIMEIN = (TextBox)gvIOS.FooterRow.FindControl("txtTIMEIN");
        DropDownList ddlFromLoc = (DropDownList)gvIOS.FooterRow.FindControl("ddlFromLoc");
        TextBox txtTIMEOUT = (TextBox)gvIOS.FooterRow.FindControl("txtTIMEOUT");
        TextBox txtEmpCount = (TextBox)gvIOS.FooterRow.FindControl("txtEmpCount");
        RadioButtonList rblDocument = (RadioButtonList)gvIOS.FooterRow.FindControl("rblDocument");
        Boolean isDocument = new Boolean();
        if (rblDocument.SelectedValue == "1")
        {
            isDocument = true;
        }
        else
        {
            isDocument = false;
        }

        tms.InsertShuttleEntry(Convert.ToDateTime(txtShiftDate.Text), Convert.ToInt32(ddlFacility.SelectedValue), rbShuttleType.SelectedValue, txtCabID.Text, txtCABNUMERIC.Text, "", txtTIMEOUT.Text, "", Convert.ToInt32(ddlFromLoc.SelectedValue), Convert.ToInt32(txtEmpCount.Text), isDocument, MyApplicationSession._UserID);
        BindgvIOS();
        txtCabID = (TextBox)gvIOS.FooterRow.FindControl("txtCabID");
        txtCabID.Focus();
    }

    private void ShowNoResultFound(DataTable source, GridView gv)
    {
        source.Rows.Add(source.NewRow()); // create a new blank row to the DataTable
        // Bind the DataTable which contain a blank row to the GridView
        gv.DataSource = source;
        gv.DataBind();
        // Get the total number of columns in the GridView to know what the Column Span should be
        int columnsCount = gv.Columns.Count;
        gv.Rows[0].Cells.Clear();// clear all the cells in the row
        gv.Rows[0].Cells.Add(new TableCell()); //add a new blank cell
        gv.Rows[0].Cells[0].ColumnSpan = columnsCount; //set the column span to the new added cell

        //You can set the styles here
        gv.Rows[0].Cells[0].HorizontalAlign = HorizontalAlign.Center;
        gv.Rows[0].Cells[0].ForeColor = System.Drawing.Color.Red;
        gv.Rows[0].Cells[0].Font.Bold = true;
        //set No Results found to the new added cell
        gv.Rows[0].Cells[0].Text = "NO RESULT FOUND!";
    }
    protected void txtCabID_TextChanged(object sender, EventArgs e)
    {
        TextBox txtCabID = sender as TextBox;
        string CabID = txtCabID.Text;
        string cabRegNo = "";
        TextBox txtCABNUMERIC = new TextBox();
        TextBox txtDrivername = new TextBox();
        if (rbShuttleType.SelectedValue == "IOS")
        {
            txtCABNUMERIC = (TextBox)gvIOS.FooterRow.FindControl("txtCABNUMERIC");
       // txtDrivername = (TextBox)gvIOS.FooterRow.FindControl("txtCABNUMERIC");
        }
        else if (rbShuttleType.SelectedValue == "BFC")
        {
            txtCABNUMERIC = (TextBox)gvBFC.FooterRow.FindControl("txtCABNUMERIC");
            //txtDrivername = (TextBox)gvBFC.FooterRow.FindControl("txtDRIVERNAME");
        }
        else if (rbShuttleType.SelectedValue == "Toll")
        {
            txtCABNUMERIC = (TextBox)gvToll.FooterRow.FindControl("txtCABNUMERIC");
            //txtDrivername = (TextBox)gvBFC.FooterRow.FindControl("txtDRIVERNAME");
        }
        else
        {
            txtCABNUMERIC = (TextBox)gvFCS.FooterRow.FindControl("txtCABNUMERIC");
            txtDrivername = (TextBox)gvFCS.FooterRow.FindControl("txtDRIVERNAME");
        }
        string driver = null;
        var result = tms.SelectVehicleByID(CabID, Convert.ToInt32(ddlFacility.SelectedValue));
        
        foreach (var result1 in result)
        {
            cabRegNo = result1.vehicleRegistrationNo;
            CabID = result1.vehicleNo;
            driver = result1.DriverName;
        }
        txtCABNUMERIC.Text = cabRegNo;
        txtCabID.Text = CabID;
        txtDrivername.Text = driver;
        txtCABNUMERIC.Focus();
    }
    protected void rbShuttleType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rbShuttleType.SelectedValue == "IOS")
        {
            ddlFacility.SelectedIndex = ddlFacility.Items.IndexOf(ddlFacility.Items.FindByValue("1"));
        }
        else
        {
            ddlFacility.SelectedIndex = ddlFacility.Items.IndexOf(ddlFacility.Items.FindByValue("2"));
        }
        MultiView1.ActiveViewIndex = -1;
    }
    protected void gvIOS_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            DropDownList ddlFromLoc = (DropDownList)e.Row.FindControl("ddlFromLoc");
            if (ddlFromLoc != null)
            {
                ddlFromLoc.Items.Clear();
                ListItem lifac1 = new ListItem("-Select-", "0");
                ddlFromLoc.Items.Add(lifac1);
                ddlFromLoc.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
                ddlFromLoc.DataTextField = "facilityName";
                ddlFromLoc.DataValueField = "Id";
                ddlFromLoc.DataBind();
            }

        }
    }
    protected void gvFCS_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvFCS.EditIndex = e.NewEditIndex;
        BindgvFCS();
    }
    protected void gvToll_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvToll.EditIndex = e.NewEditIndex;
        BindgvToll();
    }
    protected void gvBFC_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvBFC.EditIndex = e.NewEditIndex;
        BindgvBFC();
    }
    protected void gvIOS_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvIOS.EditIndex = e.NewEditIndex;
        BindgvIOS();
    }
    protected void gvFCS_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        TextBox txtShiftdate = (TextBox)gvFCS.Rows[e.RowIndex].FindControl("txtShiftdateedit");
        TextBox txtCabid = (TextBox)gvFCS.Rows[e.RowIndex].FindControl("txtCabidFCS");
        TextBox txtTimein = (TextBox)gvFCS.Rows[e.RowIndex].FindControl("txtTimeinEdit");
        TextBox txtVehicleNo = (TextBox)gvFCS.Rows[e.RowIndex].FindControl("txtVehicleNoFCS");
        TextBox txtDriver = (TextBox)gvFCS.Rows[e.RowIndex].FindControl("txtDriverFCS");
        TextBox txtTimeout = (TextBox)gvFCS.Rows[e.RowIndex].FindControl("txtTIMEOUTFCS");
        int id=Convert.ToInt32(gvFCS.DataKeys[e.RowIndex].Value.ToString());
        String result = tms.UpdateFcsShuttle(Convert.ToInt32(ddlFacility.SelectedValue),Convert.ToDateTime(txtShiftDate.Text), Convert.ToInt32(txtCabid.Text), txtTimein.Text, txtTimeout.Text, txtDriver.Text, txtVehicleNo.Text, id, MyApplicationSession._UserID).ElementAtOrDefault(0).result.ToString();
        ShowMessage(result);
        gvFCS.EditIndex = -1;
        BindgvFCS();
    }
    protected void gvToll_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        TextBox txtShiftdate = (TextBox)gvToll.Rows[e.RowIndex].FindControl("txtShiftdateedit");
        TextBox txtCabid = (TextBox)gvToll.Rows[e.RowIndex].FindControl("txtCabidToll");
        TextBox txtTime = (TextBox)gvToll.Rows[e.RowIndex].FindControl("txtTimeinEdit");
        TextBox txtVehicleNo = (TextBox)gvToll.Rows[e.RowIndex].FindControl("txtVehicleNoToll");
        TextBox txtTollPlaza = (TextBox)gvToll.Rows[e.RowIndex].FindControl("txtTollPlaza");
        TextBox txtTollAmount = (TextBox)gvToll.Rows[e.RowIndex].FindControl("txtTollAmount");
        int id = Convert.ToInt32(gvToll.DataKeys[e.RowIndex].Value.ToString());
        String result = tms.UpdateTollEntry(Convert.ToInt32(ddlFacility.SelectedValue), Convert.ToDateTime(txtShiftDate.Text), Convert.ToInt32(txtCabid.Text), txtTime.Text, txtTollPlaza.Text, txtVehicleNo.Text,Convert.ToDouble(txtTollAmount.Text), id, MyApplicationSession._UserID).ElementAtOrDefault(0).result.ToString();
        ShowMessage(result);
        gvToll.EditIndex = -1;
        BindgvToll();
    }
    protected void gvBFC_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        TextBox txtShiftdate = (TextBox)gvBFC.Rows[e.RowIndex].FindControl("txtShiftdateedit");
        TextBox txtCabid = (TextBox)gvBFC.Rows[e.RowIndex].FindControl("txtCabidBFC");
        TextBox txtTimein = (TextBox)gvBFC.Rows[e.RowIndex].FindControl("txtTimeinEdit");
        TextBox txtVehicleNo = (TextBox)gvBFC.Rows[e.RowIndex].FindControl("txtVehicleNoBFC");
        //TextBox txtDriver = (TextBox)gvBFC.Rows[e.RowIndex].FindControl("txtDriverBFC");
        TextBox txtTimeout = (TextBox)gvBFC.Rows[e.RowIndex].FindControl("txtTIMEOUTBFC");
        int id = Convert.ToInt32(gvBFC.DataKeys[e.RowIndex].Value.ToString());
        String result = tms.UpdateFcsShuttle(Convert.ToInt32(ddlFacility.SelectedValue),Convert.ToDateTime(txtShiftDate.Text), Convert.ToInt32(txtCabid.Text), txtTimein.Text, txtTimeout.Text, "", txtVehicleNo.Text, id, MyApplicationSession._UserID).ElementAtOrDefault(0).result.ToString();
        ShowMessage(result);
        gvBFC.EditIndex = -1;
        BindgvBFC();
    }
    protected void gvIOS_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        TextBox txtShiftdate = (TextBox)gvIOS.Rows[e.RowIndex].FindControl("txtShiftDateIOS");
        TextBox txtCabid = (TextBox)gvIOS.Rows[e.RowIndex].FindControl("txtCabIDIOS");
        TextBox txtvehicleNo = (TextBox)gvIOS.Rows[e.RowIndex].FindControl("txtVehicleNoIOS");
        TextBox txtStartfrom = (TextBox)gvIOS.Rows[e.RowIndex].FindControl("txtStartLocIOS");
        TextBox txttimeout = (TextBox)gvIOS.Rows[e.RowIndex].FindControl("txtTimeoutIOS");
        TextBox txtPartner = (TextBox)gvIOS.Rows[e.RowIndex].FindControl("txtEmpCountIOS");
        TextBox txtDocument = (TextBox)gvIOS.Rows[e.RowIndex].FindControl("txtDocumentIOS");
        int isdocument = 0;
        if (txtDocument.Text == "Yes")
            isdocument = 1;

        int id = Convert.ToInt32(gvIOS.DataKeys[e.RowIndex].Value.ToString());
        String Result = tms.UpdateIOSShuttle(Convert.ToDateTime(txtShiftdate.Text), Convert.ToInt32(txtCabid.Text), txtvehicleNo.Text, txtStartfrom.Text, txttimeout.Text, Convert.ToInt32(txtPartner.Text), isdocument, id, MyApplicationSession._UserID).ElementAtOrDefault(0).Result.ToString();
        ShowMessage(Result);
        gvIOS.EditIndex = -1;
        BindgvIOS();
    }

    protected void gvIOS_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvIOS.EditIndex = -1;
        BindgvIOS();
    }
    protected void gvFCS_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvFCS.EditIndex = -1;
        BindgvFCS();
    }
    protected void gvToll_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvToll.EditIndex = -1;
        BindgvToll();
    }
    protected void gvFCS_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(gvFCS.DataKeys[e.RowIndex].Value.ToString());
        tms.DeleteShuttleEntry(id, MyApplicationSession._UserID);
        ShowMessage("Entry Deleted Successfully");
        BindgvFCS();
    }
    protected void gvToll_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(gvToll.DataKeys[e.RowIndex].Value.ToString());
        tms.DeleteTollEntry(id, MyApplicationSession._UserID);
        ShowMessage("Entry Deleted Successfully");
        BindgvToll();
    }
    protected void gvBFC_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvBFC.EditIndex = -1;
        BindgvBFC();
    }
    protected void gvBFC_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(gvBFC.DataKeys[e.RowIndex].Value.ToString());
        tms.DeleteShuttleEntry(id, MyApplicationSession._UserID);
        ShowMessage("Entry Deleted Successfully");
        BindgvBFC();
    }
protected void  gvIOS_SelectedIndexChanged(object sender, EventArgs e)
{

}
protected void  gvIOS_RowDeleting(object sender, GridViewDeleteEventArgs e)
{
    int id = Convert.ToInt32(gvIOS.DataKeys[e.RowIndex].Value.ToString());
    tms.DeleteShuttleEntry(id, MyApplicationSession._UserID);
    ShowMessage("Entry Deleted Successfully");
    BindgvIOS();
}
}
