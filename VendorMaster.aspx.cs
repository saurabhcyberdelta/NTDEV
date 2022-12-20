using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VendorMaster : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    vendor vd = new vendor();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            BndVendorGrid();
        }

    }

    public void BndVendorGrid()
    {
        //*************************************************************//
        //Binds the vendor grid with the vendor list in the DB       //
        //*************************************************************//
        try
        {
            grdVendor.DataSource = tms.SelectVendor(Convert.ToInt32(Session["LocationId"].ToString()));
            grdVendor.DataBind();
            lblMsg.Visible = false;
            if (grdVendor.Rows.Count < 1)
            {
                MultiView1.ActiveViewIndex = 1;
                BndDvDropDown();
            }
            else { MultiView1.ActiveViewIndex = 0; }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void dvVendor_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        //*************************************************************//
        //Saves Vendor information into the DB            //
        //*************************************************************//
        try
        {
            vd.vendorName = ((TextBox)dvVendor.FindControl("txtdvVendorName")).Text;
            vd.vendorStrength = ((TextBox)dvVendor.FindControl("txtdvVendorStrength")).Text;
            vd.vendorContact = ((TextBox)dvVendor.FindControl("txtdvVendorContact")).Text;
            vd.vendorInfo = ((TextBox)dvVendor.FindControl("txtdvVendorInfo")).Text;
            if (((RadioButton)dvVendor.FindControl("rdbtndvRoute")).Checked == true)
            {
                vd.vendorType = "Route";
            }
            else
            {
                vd.vendorType = "Route";
            }
            vd.facilityId = Convert.ToInt32(((DropDownList)dvVendor.FindControl("ddldvFacility")).SelectedValue);

            vd.attrited = "0";


            int result = Convert.ToInt32(tms.InsertVendor(Server.HtmlEncode(vd.vendorName), vd.vendorStrength, vd.vendorContact, Server.HtmlEncode(vd.vendorInfo), vd.facilityId, vd.vendorType, vd.attrited).ElementAtOrDefault(0).result.Value.ToString());
            if (result.ToString().Equals("0"))
            {
                lblMsg.Text = "Vendor Already Exists!!!";
                lblMsg.Visible = true;
            }
            else
            {
                BndVendorGrid();
            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void dvVendor_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.Cancel == true || e.CancelingEdit == true)
        {
            MultiView1.ActiveViewIndex = 0;
            grdVendor.EditIndex = -1;
            BndVendorGrid();

        }
    }
    public void BndDvDropDown()
    {
        //*************************************************************//
        //Binds facility dropdown in the vendor  detailsview       //
        //*************************************************************//
        try
        {
            DropDownList ddlFac = (DropDownList)dvVendor.FindControl("ddldvFacility");
            ddlFac.Items.Clear();
            ListItem liFac = new ListItem("Select Facility", "0");
            ddlFac.Items.Add(liFac);
            ddlFac.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlFac.DataTextField = "facilityName";
            ddlFac.DataValueField = "Id";
            ddlFac.DataBind();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }

    }

    protected void grdVendor_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdVendor.PageIndex = e.NewPageIndex;
        BndVendorGrid();
    }

    protected void lbtnAddVendor_Click(object sender, EventArgs e)
    {
        //*************************************************************//
        //Opens detailsview to add new vendor       //
        //*************************************************************//
        try
        {
            MultiView1.ActiveViewIndex = 1;
            ((TextBox)dvVendor.FindControl("txtdvVendorName")).Text = string.Empty;
            ((TextBox)dvVendor.FindControl("txtdvVendorStrength")).Text = string.Empty;
            ((TextBox)dvVendor.FindControl("txtdvVendorContact")).Text = string.Empty;
            ((TextBox)dvVendor.FindControl("txtdvVendorInfo")).Text = string.Empty;
            BndDvDropDown();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void grdVendor_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //*************************************************************//
        //OPens the vendor gridview in edit mode      //
        //*************************************************************//
        try
        {
            string Fac = ((Label)grdVendor.Rows[e.NewEditIndex].FindControl("lblFacility")).Text;
            grdVendor.EditIndex = e.NewEditIndex;

            BndVendorGrid();
            DropDownList ddlfaci = (DropDownList)grdVendor.Rows[e.NewEditIndex].FindControl("ddlFacility");


            ddlfaci.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlfaci.DataTextField = "facilityName";
            ddlfaci.DataValueField = "Id";
            ddlfaci.DataBind();
            ddlfaci.SelectedIndex = ddlfaci.Items.IndexOf(ddlfaci.Items.FindByText(Fac.ToString()));

        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }

    }

    protected void grdVendor_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        grdVendor.EditIndex = -1;
        BndVendorGrid();
    }

    protected void grdVendor_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(grdVendor.DataKeys[e.RowIndex].Value.ToString());
        tms.DeleteVendor(id);
        BndVendorGrid();
    }

    protected void grdVendor_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //*************************************************************//
        //Updates the vendor information into the DB           //
        //*************************************************************//
        try
        {
            DropDownList ddlfac = (DropDownList)grdVendor.Rows[e.RowIndex].FindControl("ddlFacility");
            vd.facilityId = Convert.ToInt32(ddlfac.SelectedValue);
            vd.vendorName = ((TextBox)grdVendor.Rows[e.RowIndex].FindControl("txtVendorName")).Text;
            vd.vendorStrength = ((TextBox)grdVendor.Rows[e.RowIndex].FindControl("txtVendorStrength")).Text;
            vd.vendorContact = ((TextBox)grdVendor.Rows[e.RowIndex].FindControl("txtVendorContact")).Text;
            vd.vendorInfo = ((TextBox)grdVendor.Rows[e.RowIndex].FindControl("txtVendorInfo")).Text;
            if (((RadioButton)grdVendor.Rows[e.RowIndex].FindControl("rdbtnRoute")).Checked == true)
            {
                vd.vendorType = "Route";
            }
            else
            {
                vd.vendorType = "KM";
            }
            if (((CheckBox)grdVendor.Rows[e.RowIndex].FindControl("chkAttritedEdit")).Checked == true)
            {
                vd.attrited = "1";
            }
            else
            {
                vd.attrited = "0";
            }

            vd.Id = Convert.ToInt32(grdVendor.DataKeys[e.RowIndex].Value.ToString());
            string result = tms.UpdateVendor(Server.HtmlEncode(vd.vendorName), vd.vendorStrength, vd.vendorContact, Server.HtmlEncode(vd.vendorInfo), vd.facilityId, vd.vendorType, vd.attrited, vd.Id).ElementAtOrDefault(0).result.Value.ToString();
            if (result.ToString().Equals("0"))
            {
                lblMsg.Text = "Vendor Already Exists!!!";
                lblMsg.Visible = true;
            }
            else
            {
                grdVendor.EditIndex = -1;
                BndVendorGrid();
            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
}

