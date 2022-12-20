using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdhocCabDetails : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    AdhocCab ac = new AdhocCab();
    public int _CabId
    {
        get
        {
            return (int)ViewState["_CabId"];
        }
        set
        {
            ViewState["_CabId"] = value;
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
            mvFacility.ActiveViewIndex = 0;
            BndGridView();
        }
    }

    protected void BndGridView()
    {
        try
        {
            gvAdhoc.DataSource = tms.SelectAdhocCab();
            gvAdhoc.DataBind();
            if (gvAdhoc.Rows.Count < 1)
            {
                lblMsg.Text = "No Record Found!";
                lblMsg.Visible = true;
                mvFacility.ActiveViewIndex = 1;
                EmptyField();
                _Status = "Insert";
                _CabId = 0;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void BndDropDwon()
    {
        try
        {
            DropDownList ddlFacility = ((DropDownList)dvAdhoc.FindControl("ddldvFacility"));
            DropDownList ddlVendor = ((DropDownList)dvAdhoc.FindControl("ddldvVendor"));

            ListItem lstFac = new ListItem("-Select-", "0");
            ListItem lstVen = new ListItem("-Select-", "0");

            ddlFacility.Items.Clear();
            ddlFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlFacility.Items.Add(lstFac);
            ddlFacility.DataTextField = "facilityName";
            ddlFacility.DataValueField = "Id";
            ddlFacility.DataBind();

            ddlVendor.DataSource = null;
            ddlVendor.Items.Add(lstVen);
            //ddlVendor.DataTextField = "facilityName";
            //ddlVendor.DataValueField = "Id";
            ddlVendor.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    protected void EmptyField()
    {
        BndDropDwon();
        ((DropDownList)dvAdhoc.FindControl("ddldvFacility")).SelectedIndex = 0;
        ((DropDownList)dvAdhoc.FindControl("ddldvVendor")).SelectedIndex = 0;
        ((TextBox)dvAdhoc.FindControl("txtdvCabId")).Text = "";
        ((TextBox)dvAdhoc.FindControl("txtdvVehicleNo")).Text = "";
        ((TextBox)dvAdhoc.FindControl("txtdvPerson")).Text = String.Empty;
        ((TextBox)dvAdhoc.FindControl("txtdvBilling")).Text = String.Empty;
        ((TextBox)dvAdhoc.FindControl("txtdvCost")).Text = String.Empty;
        ((TextBox)dvAdhoc.FindControl("txtdvTotalKM")).Text = String.Empty;
        ((RadioButtonList)dvAdhoc.FindControl("rbWeekType")).SelectedIndex = 0;
        ((Label)dvAdhoc.FindControl("lblAttachment")).Text = string.Empty;
        ((DropDownList)dvAdhoc.FindControl("ddldvFacility")).Focus();
    }

    protected void lbtnAddNew_Click(object sender, EventArgs e)
    {
        mvFacility.ActiveViewIndex = 1;
        EmptyField();
        _CabId = 0;
        _Status = "Insert";
    }

    protected void dvAdhoc_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        try
        {
            ac.Id = _CabId;
            //ac.AdhocCabId = "";
            ac.FacilityId = Convert.ToInt32(((DropDownList)dvAdhoc.FindControl("ddldvFacility")).SelectedValue);
            ac.VendorId = Convert.ToInt32(((DropDownList)dvAdhoc.FindControl("ddldvVendor")).SelectedValue);
            ac.CabId = Convert.ToInt32(((TextBox)dvAdhoc.FindControl("txtdvCabId")).Text);
            ac.VehicleNo = ((TextBox)dvAdhoc.FindControl("txtdvVehicleNo")).Text;
            ac.NoPerson = Convert.ToInt32(((TextBox)dvAdhoc.FindControl("txtdvPerson")).Text);
            ac.BillingType = ((TextBox)dvAdhoc.FindControl("txtdvBilling")).Text;
            ac.Cost = Convert.ToDecimal(((TextBox)dvAdhoc.FindControl("txtdvCost")).Text);
            ac.TotalKM = Convert.ToDecimal(((TextBox)dvAdhoc.FindControl("txtdvTotalKM")).Text);
            RadioButtonList rbWeek = ((RadioButtonList)dvAdhoc.FindControl("rbWeekType"));
            ac.UpdatedBy = MyApplicationSession._UserID;
            if (rbWeek.SelectedIndex == 0)
            {
                ac.WeekType = "WD";
            }
            else
            {
                ac.WeekType = "WE";
            }
            FileUpload fuAttachment = ((FileUpload)dvAdhoc.FindControl("fuAttachment"));
            Label lblAttachment = ((Label)dvAdhoc.FindControl("lblAttachment"));
            if (fuAttachment.HasFile)
            {
                string filePhotoName = fuAttachment.FileName;
                string extPhoto = System.IO.Path.GetExtension(filePhotoName.ToString());

                if (extPhoto == ".xls" || extPhoto == ".xlsx")
                {
                    filePhotoName = (DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Day.ToString() + DateTime.Now.Hour.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Second.ToString()).ToString() + extPhoto;
                    // Upload the file on the server
                    fuAttachment.SaveAs(MapPath("~/AdhocCab/" + filePhotoName));
                    ac.Attachment = "~/AdhocCab/" + filePhotoName;
                    lblAttachment.Text = string.Empty;
                }                
            }
            else
            {
                ac.Attachment = lblAttachment.Text;
            }
            if (_Status == "Insert")
            {
                string result = tms.InsertAdhocCab(ac.FacilityId, ac.VendorId, ac.CabId, ac.VehicleNo, ac.NoPerson, ac.BillingType, ac.Cost, ac.TotalKM, ac.WeekType, ac.Attachment, ac.UpdatedBy).ElementAtOrDefault(0).RESULT.Value.ToString();
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
                string result = tms.UpdateAdhocCab(ac.Id,ac.FacilityId, ac.VendorId, ac.CabId, ac.VehicleNo, ac.NoPerson, ac.BillingType, ac.Cost, ac.TotalKM, ac.WeekType, ac.Attachment, ac.UpdatedBy).ElementAtOrDefault(0).RESULT.Value.ToString();
                if (result.Equals("1"))
                {
                    lblMsg.Text = "Record Updated Successfully!";
                    lblMsg.Visible = true;
                    EmptyField();
                    BndGridView();
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

    protected void dvAdhoc_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.Cancel == true || e.CancelingEdit == true)
        {
            mvFacility.ActiveViewIndex = 0;
            EmptyField();
            BndGridView();
        }
    }

    protected void ddldvFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            DropDownList ddlFacility = ((DropDownList)dvAdhoc.FindControl("ddldvFacility"));
            DropDownList ddlVendor = ((DropDownList)dvAdhoc.FindControl("ddldvVendor"));
            ddlVendor.Items.Clear();
            ListItem liv = new ListItem("-Select-", "0");
            ddlVendor.Items.Add(liv);
            ddlVendor.DataSource = tms.GetVendorByFac(Convert.ToInt32(ddlFacility.SelectedValue));
            ddlVendor.DataTextField = "vendorname";
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

    protected void gvAdhoc_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvAdhoc.PageIndex = e.NewPageIndex;
        BndGridView();
    }
    protected void gvAdhoc_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
       
    }
    protected void gvAdhoc_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        try
        {
            _CabId = Convert.ToInt32(gvAdhoc.DataKeys[e.NewSelectedIndex].Value.ToString());
            var result = tms.SelectAdhocCabByID(_CabId);
            foreach (var re in result)
            {
                DropDownList ddlFacility = ((DropDownList)dvAdhoc.FindControl("ddldvFacility"));
                DropDownList ddlVendor = ((DropDownList)dvAdhoc.FindControl("ddldvVendor"));
                ((TextBox)dvAdhoc.FindControl("txtdvCabId")).Text =re.CabId.ToString();
                ((TextBox)dvAdhoc.FindControl("txtdvVehicleNo")).Text = re.VehicleNo.ToString();
                ((TextBox)dvAdhoc.FindControl("txtdvPerson")).Text = re.NoPerson.ToString();
                ((TextBox)dvAdhoc.FindControl("txtdvBilling")).Text = re.BillingType.ToString();
                ((TextBox)dvAdhoc.FindControl("txtdvCost")).Text = re.Cost.ToString();
                ((TextBox)dvAdhoc.FindControl("txtdvTotalKM")).Text = re.TotalKM.ToString();
                ((Label)dvAdhoc.FindControl("lblAttachment")).Text = re.Attachment.ToString();
                RadioButtonList rbWeek = ((RadioButtonList)dvAdhoc.FindControl("rbWeekType"));
                if (re.WeekType == "WD")
                {
                    rbWeek.SelectedIndex = 0;
                }
                else
                {
                    rbWeek.SelectedIndex = 1;
                }                

                ListItem lstFac = new ListItem("-Select-", "0");
                ListItem lstVen = new ListItem("-Select-", "0");

                ddlFacility.Items.Clear();
                ddlFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
                ddlFacility.Items.Add(lstFac);
                ddlFacility.DataTextField = "facilityName";
                ddlFacility.DataValueField = "Id";
                ddlFacility.DataBind();

                ddlFacility.SelectedIndex = ddlFacility.Items.IndexOf(ddlFacility.Items.FindByValue(re.FacilityId.ToString()));

                ddlVendor.Items.Add(lstVen);
                ddlVendor.DataSource = tms.GetVendorByFac(Convert.ToInt32(re.FacilityId));
                ddlVendor.DataTextField = "vendorname";
                ddlVendor.DataValueField = "Id";
                ddlVendor.DataBind();

                ddlVendor.SelectedIndex = ddlVendor.Items.IndexOf(ddlVendor.Items.FindByValue(re.VendorId.ToString()));                
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
    protected void gvAdhoc_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message;
            lblMsg.Visible = true;
        }
    }
    protected void gvAdhoc_RowEditing(object sender, GridViewEditEventArgs e)
    {
        
    }

}
