using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AssignNonHiringZone : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            bindCityddl();
            BndFacilityDropdown();
        }
    }
    public void bindCityddl()
    {
        ddlCity.Items.Clear();
        ListItem licity = new ListItem("Select City", "0");
        ddlCity.Items.Add(licity);
        ddlCity.DataSource = tms.GetGeoCity();
        ddlCity.DataTextField = "city";
        ddlCity.DataValueField = "city";
        ddlCity.DataBind();
    }
    public void BndFacilityDropdown()
    {
        try
        {
            ddlFacility.Items.Clear();
            ListItem liv = new ListItem("Select Facility", "0");
            ddlFacility.Items.Add(liv);
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
    protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
    {
        //************************************************************************************//
        //On Selection of City in city dropdown binds the colony and clears landmark dropdown//
        //**********************************************************************************//
        try
        {
            BindColony();
            BindColonyAssigned();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    private void BindColony()
    {
        int facility = Convert.ToInt32(ddlFacility.SelectedValue);
        string city = ddlCity.SelectedItem.Text;
        lstColony.Items.Clear();
        ListItem licol = new ListItem("-Select-", "0");
        lstColony.Items.Add(licol);
        lstColony.DataSource = tms.GetColonyForNonHiring(city,facility,1);
        lstColony.DataTextField = "colony";
        lstColony.DataValueField = "colony";
        lstColony.DataBind();
        lstColony.SelectedIndex = 0;
    }
    private void BindColonyAssigned()
    {
        int facility = Convert.ToInt32(ddlFacility.SelectedValue);
        string city = ddlCity.SelectedItem.Text;
        lstColonyAssigned.Items.Clear();
        ListItem licol = new ListItem("-Select-", "0");
        lstColonyAssigned.Items.Add(licol);
        lstColonyAssigned.DataSource = tms.GetColonyForNonHiring(city,facility,0);
        lstColonyAssigned.DataTextField = "colony";
        lstColonyAssigned.DataValueField = "colony";
        lstColonyAssigned.DataBind();
        lstColonyAssigned.SelectedIndex = 0;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int facility = Convert.ToInt32(ddlFacility.SelectedValue);
        string city = ddlCity.SelectedValue;
        string colony = string.Empty;
        if (lstColony.SelectedIndex >= 0)
        {
            for (int i = 0; i <lstColony.Items.Count; i++)
            {
                if (lstColony.Items[i].Selected)
                {
                    colony += lstColony.Items[i].Text.Trim() + ",";
                }
            }
        }
        colony = colony.Remove(colony.Length - 1, 1);
        tms.SprInsertNonHiringColony(facility, city, colony,1);
        BindColony();
        BindColonyAssigned();
    }
    protected void btnSubmitAssigned_Click(object sender, EventArgs e)
    {
        int facility = Convert.ToInt32(ddlFacility.SelectedValue);
        string city = ddlCity.SelectedValue;
        string colony = string.Empty;
        if (lstColonyAssigned.SelectedIndex >= 0)
        {
            for (int i = 0; i < lstColonyAssigned.Items.Count; i++)
            {
                if (lstColonyAssigned.Items[i].Selected)
                {
                    colony += lstColonyAssigned.Items[i].Text.Trim() + ",";
                }
            }
        }
        colony = colony.Remove(colony.Length - 1, 1);
        tms.SprInsertNonHiringColony(facility, city, colony,0);
        BindColony();
        BindColonyAssigned();
    }
    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            BindColony();
            BindColonyAssigned();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
}
