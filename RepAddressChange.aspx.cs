using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RepAddressChange : basepage
{

    public int _Adressid
    {
        get
        {
            return (int)ViewState["_Adressid"];
        }

        set
        {
            ViewState["_Adressid"] = value;
        }
    }
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
            txtEndDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
            BndDropdown();

        }

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        lblErrorMsg.Visible = false;
        bindgrid();
        GridViewExportUtil.Export("AddressChangeStatus.xls", gvStatus);
    }
    protected void bindgrid()
    {

        gvStatus.DataSource = tms.getAddressChangestatus(Convert.ToDateTime(txtStartDate.Text), Convert.ToDateTime(txtEndDate.Text), ddlStatus.SelectedValue, Convert.ToInt32(ddlFacility.SelectedValue));
        gvStatus.DataBind();
       
       
    }
    public void BndDropdown()
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
    
   
   
   
}
