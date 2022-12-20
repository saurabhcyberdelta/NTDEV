using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LocationMaster : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    Location loc = new Location();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BndLocationGrid();
        }

    }
    public void BndLocationGrid()
    {
        //********************************************************//
        //Binds Location gridview with the locations from DB     //
        //******************************************************//
        try
        {
            GVLocation.DataSource = tms.SelectLocation();
            GVLocation.DataBind();
            if (GVLocation.Rows.Count < 1)
            {
                MultiView1.ActiveViewIndex = 1;

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

    protected void DvLocation_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.Cancel == true || e.CancelingEdit == true)
        {

            MultiView1.ActiveViewIndex = 0;
            BndLocationGrid();

        }
    }

    protected void DvLocation_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        //*******************************//
        //Saves the location to the DB  //
        //******************************//
        try
        {
            loc.locationName = ((TextBox)DvLocation.FindControl("txtdvLocationName")).Text;
            string result = tms.InsertLocation(loc.locationName).ElementAtOrDefault(0).result.Value.ToString();
            if (result.Equals("0"))
            {
                lblMsg.Text = "Location Name Already Exists";
                lblMsg.Visible = true;

            }
            else
            {
                BndLocationGrid();
                lblMsg.Visible = false;

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
        try
        {
            ((TextBox)DvLocation.FindControl("txtdvLocationName")).Text = string.Empty;
            MultiView1.ActiveViewIndex = 1;
            lblMsg.Text = string.Empty;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);
        }
    }

    protected void GVLocation_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //*******************************//
        //Updates location into the DB  //
        //******************************//
        try
        {
            loc.locationName = ((TextBox)GVLocation.Rows[e.RowIndex].FindControl("txtLocationName")).Text;
            loc.Id = Convert.ToInt32(GVLocation.DataKeys[e.RowIndex].Value.ToString());
            string result = tms.UpdateLocation(loc.locationName, loc.Id).ElementAtOrDefault(0).result.Value.ToString();
            if (result.Equals("0"))
            {
                lblMsg.Text = "Location Name Already Exists";
                lblMsg.Visible = true;

            }
            else
            {
                GVLocation.EditIndex = -1;
                BndLocationGrid();
                lblMsg.Visible = false;

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }

    protected void GVLocation_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GVLocation.EditIndex = e.NewEditIndex;
        BndLocationGrid();
    }

    protected void GVLocation_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }

    protected void GVLocation_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GVLocation.EditIndex = -1;
        BndLocationGrid();
    }

    protected void GVLocation_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GVLocation.PageIndex = e.NewPageIndex;
        BndLocationGrid();
    }
}
