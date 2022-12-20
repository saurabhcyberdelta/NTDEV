using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReportTableAdapters;

public partial class RepZoneEmployee : basepage
{

    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    RepZoneWiseEmployeeTableAdapter ds = new RepZoneWiseEmployeeTableAdapter();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
               

                BndFacilityDropdown();

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
       
        string FacilityID = ddlFacility.SelectedValue;
        string triptype = rdbtnTripType.SelectedValue;
        GridView1.DataSource = ds.GetData(Convert.ToInt32(FacilityID), Convert.ToInt32(triptype));
        GridView1.DataBind();

      
     

        GridViewExportUtil.Export("EmployeeZone.XLS", GridView1);

    }
}
