using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AssignException : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bindCityddl();
            BndFacilityDropdown();
        }

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
    public void bindCityddl()
    {
        try
        {
            ddlCity.Items.Clear();
            ListItem licity = new ListItem("Select City", "0");
            ddlCity.Items.Add(licity);
            ddlCity.DataSource = tms.GetGeoCity();
            ddlCity.DataTextField = "city";
            ddlCity.DataValueField = "city";
            ddlCity.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    private void BindColonyAssigned()
    {
        try
        {
            int facility = Convert.ToInt32(ddlFacility.SelectedValue);
            string city = ddlCity.SelectedItem.Text;
            lstColony.Items.Clear();
            ListItem licol = new ListItem("Select Colony", "0");
            lstColony.Items.Add(licol);
            lstColony.DataSource = tms.GetColonyForNonHiring(city, facility, 0);
            lstColony.DataTextField = "colony";
            lstColony.DataValueField = "colony";
            lstColony.DataBind();
            lstColony.SelectedIndex = 0;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    public void bndLstShift()
    {
        try
        {
            int facid = Convert.ToInt32(ddlFacility.SelectedValue.ToString());
            string type = rdoTripType.SelectedValue.ToString();
            string city = ddlCity.SelectedValue.ToString();
            string colony = lstColony.SelectedValue.ToString();
            lstShift.Items.Clear();
            ListItem list = new ListItem("-Select-", "0");
            lstShift.Items.Add(list);
            lstShift.DataSource = tms.GetExceptionShifts(facid, city, colony, type, 1);
            lstShift.DataTextField = "shiftTime";
            lstShift.DataValueField = "shiftTime";
            lstShift.DataBind();
            lstShift.SelectedIndex = 0;
            //-------------assigned shift listbox------------
            lstShiftAssigned.Items.Clear();
            ListItem list2 = new ListItem("-Select-", "0");
            lstShiftAssigned.Items.Add(list2);
            lstShiftAssigned.DataSource = tms.GetExceptionShifts(facid, city, colony, type, 0);
            lstShiftAssigned.DataTextField = "shiftTime";
            lstShiftAssigned.DataValueField = "shiftTime";
            lstShiftAssigned.DataBind();
            lstShiftAssigned.SelectedIndex = 0;
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
        try
        {
            int facid = Convert.ToInt32(ddlFacility.SelectedValue.ToString());
            string type = rdoTripType.SelectedValue.ToString();
            string city = ddlCity.SelectedValue.ToString();
            string colony = lstColony.SelectedValue.ToString();
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
            Shifttimes = Shifttimes.Remove(Shifttimes.Length - 1, 1);
            tms.SprInsertExceptionShifts(facid, city, colony, Shifttimes, type, 1);
            bndLstShift();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void btnSubmitAssigned_Click(object sender, EventArgs e)
    {
        try
        {
            int facid = Convert.ToInt32(ddlFacility.SelectedValue.ToString());
            string type = rdoTripType.SelectedValue.ToString();
            string city = ddlCity.SelectedValue.ToString();
            string colony = lstColony.SelectedValue.ToString();
            string Shifttimes = string.Empty;
            if (lstShiftAssigned.SelectedIndex >= 0)
            {
                for (int i = 0; i < lstShiftAssigned.Items.Count; i++)
                {
                    if (lstShiftAssigned.Items[i].Selected)
                    {
                        Shifttimes += lstShiftAssigned.Items[i].Text.Trim() + ",";
                    }

                }
            }
            Shifttimes = Shifttimes.Remove(Shifttimes.Length - 1, 1);
            tms.SprInsertExceptionShifts(facid, city, colony, Shifttimes, type, 0);
            bndLstShift();
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
        BindColonyAssigned();
        bndLstShift();
    }
    protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindColonyAssigned();
        bndLstShift();
    }
    protected void rdoTripType_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndLstShift();
    }
    protected void lstColony_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndLstShift();
    }
}
