using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class IncidentMaster : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    IncidentMasters im = new IncidentMasters();
    public int _FacId
    {
        get
        {
            return (int)ViewState["_FacId"];
        }
        set
        {
            ViewState["_FacId"] = value;
        }
    }

    public int _IndId
    {
        get
        {
            return (int)ViewState["_IndId"];
        }
        set
        {
            ViewState["_IndId"] = value;
        }
    }

    public string _Status
    {
        get
        {
            return (string)ViewState["_Status"];
        }
        set
        {
            ViewState["_Status"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
            txtEndDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
            BndFacilityDropdown();
            mvFacility.ActiveViewIndex = -1;
            lkbExport.Visible = false;
        }
    }

    public void BndFacilityDropdown()
    {
        try
        {
            ddlSelectFacility.Items.Clear();
            ListItem liv = new ListItem("Select Facility", "0");
            ddlSelectFacility.Items.Add(liv);
            ddlSelectFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlSelectFacility.DataTextField = "facilityName";
            ddlSelectFacility.DataValueField = "Id";
            ddlSelectFacility.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void BndGridView()
    {
        try
        {
            _FacId = Convert.ToInt32(ddlSelectFacility.SelectedValue);
            gvIncedentMaster.DataSource = tms.SelectIncidentMasterByFac(_FacId);
            gvIncedentMaster.DataBind();
            lkbExport.Visible = true;
            if (gvIncedentMaster.Rows.Count < 1)
            {
                lblMsg.Text = "No Record Found!";
                lblMsg.Visible = true;
                mvFacility.ActiveViewIndex = 1;
                EmptyField();
                lkbExport.Visible = false;
                _Status = "Insert";
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void ddlSelectFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        mvFacility.ActiveViewIndex = 0;
        BndGridView();
    }

    protected void EmptyField()
    {
        BndDropDown();
        ((DropDownList)dvIncedentMaster.FindControl("ddlFacility")).SelectedIndex = 0;
        ((DropDownList)dvIncedentMaster.FindControl("ddlVendor")).SelectedIndex = 0;
        ((DropDownList)dvIncedentMaster.FindControl("ddlCab")).SelectedIndex = 0;
        //((DropDownList)dvIncedent.FindControl("ddlDriver")).SelectedIndex = 0;
        ((TextBox)dvIncedentMaster.FindControl("txtDriver")).Text = string.Empty;
        ((TextBox)dvIncedentMaster.FindControl("txtBadgeNo")).Text = string.Empty;
        ((TextBox)dvIncedentMaster.FindControl("txtDate")).Text = string.Empty;
        ((TextBox)dvIncedentMaster.FindControl("txtShift")).Text = string.Empty;
        ((TextBox)dvIncedentMaster.FindControl("txtRouteNo")).Text = string.Empty;
        ((DropDownList)dvIncedentMaster.FindControl("ddlSeverity")).SelectedIndex = 0;
        ((DropDownList)dvIncedentMaster.FindControl("ddlMistake")).SelectedIndex = 0;
        ((DropDownList)dvIncedentMaster.FindControl("ddlFacility")).Focus();
    }

    protected void BndDropDown()
    {
        try
        {
            DropDownList ddlFac = ((DropDownList)dvIncedentMaster.FindControl("ddlFacility"));
            DropDownList ddlVendor = ((DropDownList)dvIncedentMaster.FindControl("ddlVendor"));
            DropDownList ddlCab = ((DropDownList)dvIncedentMaster.FindControl("ddlCab"));
            //DropDownList ddlDriver = ((DropDownList)dvIncedent.FindControl("ddlDriver"));

            ListItem lstfac = new ListItem("-Select-", "0");
            ListItem lstven = new ListItem("-Select-", "0");
            ListItem lstcab = new ListItem("-Select-", "0");
            //ListItem lstdri = new ListItem("-Select-", "0");

            ddlFac.Items.Clear();
            ddlFac.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlFac.Items.Add(lstfac);
            ddlFac.DataTextField = "facilityName";
            ddlFac.DataValueField = "Id";
            ddlFac.DataBind();

            ddlVendor.Items.Clear();
            ddlVendor.DataSource = null;
            ddlVendor.Items.Add(lstven);
            //ddlFac.DataTextField = "";
            //ddlFac.DataValueField = "";
            ddlVendor.DataBind();

            ddlCab.Items.Clear();
            ddlCab.DataSource = null;
            ddlCab.Items.Add(lstcab);
            //ddlFac.DataTextField = "";
            //ddlFac.DataValueField = "";
            ddlCab.DataBind();
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
            DropDownList ddlVendor = ((DropDownList)dvIncedentMaster.FindControl("ddlVendor"));
            int facId = Convert.ToInt32(((DropDownList)dvIncedentMaster.FindControl("ddlFacility")).SelectedValue);
            ListItem lstven = new ListItem("-Select-", "0");
            ddlVendor.Items.Clear();
            ddlVendor.DataSource = tms.GetVendorByFacility(facId);
            ddlVendor.Items.Add(lstven);
            ddlVendor.DataTextField = "vendorName";
            ddlVendor.DataValueField = "Id";
            ddlVendor.DataBind();
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
        try
        {
            int facId = Convert.ToInt32(((DropDownList)dvIncedentMaster.FindControl("ddlFacility")).SelectedValue);
            int venId = Convert.ToInt32(((DropDownList)dvIncedentMaster.FindControl("ddlVendor")).SelectedValue);
            DropDownList ddlCab = ((DropDownList)dvIncedentMaster.FindControl("ddlCab"));
            ListItem lstcab = new ListItem("-Select-", "0");

            ddlCab.Items.Clear();
            ddlCab.DataSource = tms.GetCabIdByFacId_VenId(facId,venId);
            ddlCab.Items.Add(lstcab);
            ddlCab.DataTextField = "vehicleNo";
            ddlCab.DataValueField = "Id";
            ddlCab.DataBind(); 
            
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void ddlCab_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {            
            int cabId = Convert.ToInt32(((DropDownList)dvIncedentMaster.FindControl("ddlCab")).SelectedValue);
            var result = tms.GetDriverNameByCabId(cabId);
            foreach (var re in result)
            {
                ((TextBox)dvIncedentMaster.FindControl("txtDriver")).Text = re.DriverName.ToString();
                ((TextBox)dvIncedentMaster.FindControl("txtBadgeNo")).Text = re.BadgeNo.ToString();
            }           
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    protected void dvIncedent_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        try
        {
            FileUpload fuAttachment = ((FileUpload)dvIncedentMaster.FindControl("FUAttachment"));
            
            //im.Id = _IndId;
            im.FacId = Convert.ToInt32(((DropDownList)dvIncedentMaster.FindControl("ddlFacility")).SelectedValue);
            im.VendorId = Convert.ToInt32(((DropDownList)dvIncedentMaster.FindControl("ddlVendor")).SelectedValue);
            im.CabId = Convert.ToInt32(((DropDownList)dvIncedentMaster.FindControl("ddlCab")).SelectedValue);
            im.DriverName = ((TextBox)dvIncedentMaster.FindControl("txtDriver")).Text;
            im.BadgeNo = ((TextBox)dvIncedentMaster.FindControl("txtBadgeNo")).Text;
            im.IncDate = Convert.ToDateTime(((TextBox)dvIncedentMaster.FindControl("txtDate")).Text);
            im.Shift = ((TextBox)dvIncedentMaster.FindControl("txtShift")).Text;
            im.RouteId = ((TextBox)dvIncedentMaster.FindControl("txtRouteNo")).Text;
            im.Severity = Convert.ToChar(((DropDownList)dvIncedentMaster.FindControl("ddlSeverity")).SelectedValue);
            im.MistakeBy = Convert.ToChar(((DropDownList)dvIncedentMaster.FindControl("ddlMistake")).SelectedValue);
            Label lblAttachment = ((Label)dvIncedentMaster.FindControl("lblAttachment"));
            if (fuAttachment.HasFile)
            {
                string fileName = fuAttachment.FileName;
                string ext = System.IO.Path.GetExtension(fileName.ToString());
                if (ext == ".xls" || ext == ".xlsx")
                {
                    fileName = (DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Day.ToString() + DateTime.Now.Hour.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Second.ToString()).ToString() + ext;
                    // Upload the file on the server
                    fuAttachment.SaveAs(MapPath("~/IncidentFile/" + fileName));
                    im.Attachment = "~/IncidentFile/" + fileName;
                    lblAttachment.Text = string.Empty;
                }                
            }
            else
            {
                im.Attachment = lblAttachment.Text;
            }
            im.UpdatedBy = MyApplicationSession._UserID;

            if (_Status == "Insert")
            {
                string result = tms.InsertIncidentMaster(im.FacId, im.VendorId, im.CabId, im.DriverName, im.BadgeNo, im.IncDate, im.Shift, im.RouteId, im.Severity, im.MistakeBy, im.Attachment, im.UpdatedBy).ElementAtOrDefault(0).RESULT.Value.ToString();
                if (result.Equals("1"))
                {
                    lblMsg.Text = "Record Added Successfully!";
                    lblMsg.Visible = true;
                    EmptyField();
                }
                else
                {
                    lblMsg.Text = "Record Alredy Exists!";
                    lblMsg.Visible = true;
                }
            }
            else if (_Status == "Update")
            {
                im.Id = _IndId;
                string result = tms.UpdateIncidentMaster(im.Id,im.FacId, im.VendorId, im.CabId, im.DriverName, im.BadgeNo, im.IncDate, im.Shift, im.RouteId, im.Severity, im.MistakeBy, im.Attachment, im.UpdatedBy).ElementAtOrDefault(0).RESULT.Value.ToString();
                if (result.Equals("1"))
                {
                    lblMsg.Text = "Record Update Successfully!";
                    lblMsg.Visible = true;
                    EmptyField();
                    BndGridView();
                    mvFacility.ActiveViewIndex = 0;
                }
                else
                {
                    lblMsg.Text = "Record Alredy Exists!";
                    lblMsg.Visible = true;
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
    protected void lbtnAddNew_Click(object sender, EventArgs e)
    {
        EmptyField();
        mvFacility.ActiveViewIndex = 1;
        _Status = "Insert";
    }
    protected void dvIncedent_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.Cancel == true || e.CancelingEdit == true)
        {
            EmptyField();
            BndFacilityDropdown();
            BndGridView();
            mvFacility.ActiveViewIndex = -1;
        }
    }

    protected void gvIncedent_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvIncedentMaster.PageIndex = e.NewPageIndex;
        BndGridView();
    }
    protected void gvIncedentMaster_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        try
        {
            _IndId = Convert.ToInt32(gvIncedentMaster.DataKeys[e.NewSelectedIndex].Value.ToString());
            var result = tms.SelectIncidentMasterById(_IndId);
            foreach (var re in result)
            {
                DropDownList ddlFacility=((DropDownList)dvIncedentMaster.FindControl("ddlFacility"));
                DropDownList ddlVendor=((DropDownList)dvIncedentMaster.FindControl("ddlVendor"));
                DropDownList ddlCabId = ((DropDownList)dvIncedentMaster.FindControl("ddlCab"));
                DropDownList ddlSeverity = ((DropDownList)dvIncedentMaster.FindControl("ddlSeverity"));
                DropDownList ddlMistake = ((DropDownList)dvIncedentMaster.FindControl("ddlMistake"));
                //((DropDownList)dvIncedent.FindControl("ddlDriver")).SelectedIndex = 0;
                ((TextBox)dvIncedentMaster.FindControl("txtDriver")).Text = re.DriverName.ToString();
                ((TextBox)dvIncedentMaster.FindControl("txtBadgeNo")).Text = re.BadgeNo.ToString();
                ((TextBox)dvIncedentMaster.FindControl("txtDate")).Text = re.IncDate.ToString();
                ((TextBox)dvIncedentMaster.FindControl("txtShift")).Text = re.Shift.ToString();
                ((TextBox)dvIncedentMaster.FindControl("txtRouteNo")).Text = re.RouteId.ToString();
                ((Label)dvIncedentMaster.FindControl("lblAttachment")).Text = re.Attachment.ToString();

                ListItem lstfac = new ListItem("-Select-", "0");
                ListItem lstven = new ListItem("-Select-", "0");
                ListItem lstcab = new ListItem("-Select-", "0");
                //ListItem lstdri = new ListItem("-Select-", "0");

                ddlFacility.Items.Clear();
                ddlFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
                ddlFacility.Items.Add(lstfac);
                ddlFacility.DataTextField = "facilityName";
                ddlFacility.DataValueField = "Id";
                ddlFacility.DataBind();

                ddlFacility.SelectedIndex = ddlFacility.Items.IndexOf(ddlFacility.Items.FindByValue(re.FacId.ToString()));

                ddlVendor.Items.Clear();
                ddlVendor.DataSource = tms.GetVendorByFacility(Convert.ToInt32(re.FacId));
                ddlVendor.Items.Add(lstven);
                ddlVendor.DataTextField = "vendorName";
                ddlVendor.DataValueField = "Id";
                ddlVendor.DataBind();

                ddlVendor.SelectedIndex = ddlVendor.Items.IndexOf(ddlVendor.Items.FindByValue(re.VendorId.ToString()));

                ddlCabId.Items.Clear();
                ddlCabId.DataSource = tms.GetCabIdByFacId_VenId(Convert.ToInt32(re.FacId), Convert.ToInt32(re.VendorId));
                ddlCabId.Items.Add(lstcab);
                ddlCabId.DataTextField = "vehicleNo";
                ddlCabId.DataValueField = "Id";
                ddlCabId.DataBind();

                ddlCabId.SelectedIndex = ddlCabId.Items.IndexOf(ddlCabId.Items.FindByValue(re.CabId.ToString()));

                if (re.Severity == 'L')
                {
                    ddlSeverity.SelectedIndex = 1;
                }
                else if (re.Severity == 'M')
                {
                    ddlSeverity.SelectedIndex = 2;
                }
                else if (re.Severity == 'H')
                {
                    ddlSeverity.SelectedIndex = 3;
                }
                else
                {
                    ddlSeverity.SelectedIndex = 0;
                }

                if (re.MistakeBy == 'T')
                {
                    ddlMistake.SelectedIndex = 1;
                }
                else if (re.MistakeBy == 'S')
                {
                    ddlMistake.SelectedIndex = 2;
                }
                else if (re.MistakeBy == 'B')
                {
                    ddlMistake.SelectedIndex = 3;
                }
                else
                {
                    ddlMistake.SelectedIndex = 0;
                }
            }
            _Status = "Update";
            mvFacility.ActiveViewIndex = 1;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    protected void lkbExport_Click(object sender, EventArgs e)
    {
        _FacId = Convert.ToInt32(ddlSelectFacility.SelectedValue);
        gvIncedentMaster.AllowPaging = false;
        gvIncedentMaster.DataSource = tms.SelectIncidentMasterByFac(_FacId);
        gvIncedentMaster.DataBind();
        GridViewExportUtil.Export("IncidentMaster.xls", gvIncedentMaster);  
    }
}
