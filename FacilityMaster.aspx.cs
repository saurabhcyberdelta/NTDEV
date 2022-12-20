using System; 
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FacilityMaster : basepage
{
    DataClasses1DataContext tmsdataclass = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        lblMsg.Visible = false;
        if (!IsPostBack)
        {
            BndFacGrid();
        }
        
    }
    public void BndFacGrid()
    {
        //********************************************************************//
        //Binds the Facility Gridview with the retrieved facilities from DB//
        //********************************************************************//
        try
        {
            var r = tmsdataclass.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            gvFacility.DataSource = r;
            gvFacility.DataBind();
            
            if (gvFacility.Rows.Count < 1)
            {
                mvFacility.ActiveViewIndex = 1;
                BndDvDropDown();

            }
            else
            {

                mvFacility.ActiveViewIndex = 0;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);


        }

    }
    public void BndDvDropDown()
    {
        //********************************************************************//
        //Binds Location Dropdown of Detailview                               //
        //********************************************************************//
        try
        {
            DropDownList ddlloc = (DropDownList)dvFacility.FindControl("ddldvLocation");
            ddlloc.Items.Clear();
            ListItem liloc = new ListItem("Select Location", "0");
            ddlloc.Items.Add(liloc);
            ddlloc.DataSource = tmsdataclass.SelectLocation();
            ddlloc.DataTextField = "locationName";
            ddlloc.DataValueField = "Id";
            ddlloc.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }
    protected void gvFacility_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvFacility.PageIndex = e.NewPageIndex;
        BndFacGrid();
    }



    protected void lbtnAddNew_Click(object sender, EventArgs e)
    {
        //********************************************************************//
        //OPens Dtailview to add new Facility                                 //
        //********************************************************************//
        try
        {
            lblMsg.Visible = false;
            mvFacility.ActiveViewIndex = 1;

            dvFacility.HeaderText = "Add New Facility";
            dvFacility.ChangeMode(DetailsViewMode.Insert);
            ClearDvFields();
            BndDvDropDown();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void dvFacility_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.CancelingEdit == true || e.Cancel == true)
        {
            mvFacility.ActiveViewIndex = 0;
            gvFacility.EditIndex = -1;
            BndFacGrid();
        }
    }

    protected void dvFacility_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        //********************************************************************//
        //Saves New Facility to the DB                                         //
        //********************************************************************//
        try
        {
            lblMsg.Visible = false;

            DataClasses1DataContext context = new DataClasses1DataContext();
            facility f = new facility();
            f.facilityName = ((TextBox)dvFacility.FindControl("txtdvFacilityName")).Text;
            f.geoX = Convert.ToDouble(((TextBox)dvFacility.FindControl("txtdvGeoX")).Text);
            f.geoY = Convert.ToDouble(((TextBox)dvFacility.FindControl("txtdvGeoY")).Text);
            f.tptContactNo = ((TextBox)dvFacility.FindControl("txtdvContactNo")).Text;
            f.tptEmail = ((TextBox)dvFacility.FindControl("txtdvEmail")).Text;
            f.locationId = Convert.ToInt32(((DropDownList)dvFacility.FindControl("ddldvLocation")).SelectedValue);
            string locationName = ((DropDownList)dvFacility.FindControl("ddldvLocation")).SelectedItem.Text;
            string val = context.InsertFacility(Server.HtmlEncode(f.facilityName), f.geoX, f.geoY, f.tptEmail,Server.HtmlEncode(f.tptContactNo), f.locationId, locationName).ElementAtOrDefault(0).result.Value.ToString();
            gvFacility.EditIndex = -1;
            if (val.Equals("0"))
            {
                lblMsg.Text = "Facility Name Already Exists!!!!";
                lblMsg.Visible = true;

            }
            else
            {
                lblMsg.Text = "Record Added Successfully!!";
                lblMsg.Visible = true;

                mvFacility.ActiveViewIndex = 0;
                BndFacGrid();

            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }
    public void ClearDvFields()
    {
        //********************************************************************//
        //Clears Detailsview fields when it closes//
        //********************************************************************//
        try
        {
            ((TextBox)dvFacility.FindControl("txtdvFacilityName")).Text = string.Empty;
            ((TextBox)dvFacility.FindControl("txtdvGeoX")).Text = string.Empty;
            ((TextBox)dvFacility.FindControl("txtdvGeoY")).Text = string.Empty;
            ((TextBox)dvFacility.FindControl("txtdvContactNo")).Text = string.Empty;
            ((TextBox)dvFacility.FindControl("txtdvEmail")).Text = string.Empty;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }

    }



    protected void gvFacility_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //**********************************//
        //Updates Facility Details         //
        //*********************************//
        try
        {
            DataClasses1DataContext context = new DataClasses1DataContext();
            facility f = new facility();
            f.facility1 = ((TextBox)gvFacility.Rows[e.RowIndex].FindControl("txtFacility")).Text;
            f.geoX = Convert.ToDouble(((TextBox)gvFacility.Rows[e.RowIndex].FindControl("txtGeoX")).Text);
            f.geoY = Convert.ToDouble(((TextBox)gvFacility.Rows[e.RowIndex].FindControl("txtGeoY")).Text);
            f.tptContactNo = ((TextBox)gvFacility.Rows[e.RowIndex].FindControl("txtContactNo")).Text;
            f.tptEmail = ((TextBox)gvFacility.Rows[e.RowIndex].FindControl("txtEmail")).Text;
            f.Id = Convert.ToInt32(gvFacility.DataKeys[e.RowIndex].Value.ToString());
            f.locationId = Convert.ToInt32(((DropDownList)gvFacility.Rows[e.RowIndex].FindControl("ddlLocation")).SelectedValue);
            f.active = Convert.ToBoolean(((CheckBox)gvFacility.Rows[e.RowIndex].FindControl("chkActive")).Checked);
            string locName = ((DropDownList)gvFacility.Rows[e.RowIndex].FindControl("ddlLocation")).SelectedItem.Text;
            string val = context.UpdateFacility(Server.HtmlEncode(f.facility1), f.geoX, f.geoY, f.tptEmail,Server.HtmlEncode(f.tptContactNo), f.Id, f.locationId, locName,f.active,MyApplicationSession._UserID).ElementAtOrDefault(0).result.Value.ToString();
            if (val.Equals("0"))
            {
                lblMsg.Text = "Facility Name Already Exists!!!!";
                lblMsg.Visible = true;

            }
            else
            {
                lblMsg.Text = "Record Updated Successfully!!";
                lblMsg.Visible = true;

                gvFacility.EditIndex = -1;
                BndFacGrid();

            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

    protected void gvFacility_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //********************************************************************//
        //Opens the facilty gridview in edit mode to edit the facilty details//
        //********************************************************************//
        try
        {
            string loc = ((Label)gvFacility.Rows[e.NewEditIndex].FindControl("lblLocation")).Text;
            gvFacility.EditIndex = e.NewEditIndex;
            BndFacGrid();
            DropDownList ddlloc = (DropDownList)gvFacility.Rows[e.NewEditIndex].FindControl("ddlLocation");
            ddlloc.Items.Clear();
            ListItem liloc = new ListItem("-Select-", "0");
            ddlloc.Items.Add(liloc);
            ddlloc.DataSource = tmsdataclass.SelectLocation();
            ddlloc.DataTextField = "locationName";
            ddlloc.DataValueField = "Id";
            ddlloc.DataBind();
            ddlloc.SelectedIndex = ddlloc.Items.IndexOf(ddlloc.Items.FindByText(loc.ToString()));
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }

    }

    protected void gvFacility_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvFacility.EditIndex = -1;
        BndFacGrid();
    }

}
