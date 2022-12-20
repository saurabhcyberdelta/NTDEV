using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SeperateCab : basepage
{

    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
  
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                txtEndDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
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
        grdSeperateCab.DataSource = tmscontext.getAllSeperateCab(Convert.ToDateTime(txtStartDate.Text), Convert.ToDateTime(txtEndDate.Text), Convert.ToInt32(ddlFacility.SelectedValue));
        grdSeperateCab.DataBind();
    }
    protected Boolean enableds(object strArg)
    {
        try
        {
            string val = Convert.ToString(strArg);
          

            if (val == "0" )
            {
                return true;
            }
            else
            {
                return false;
            }

        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;


        GridViewRow gvr = (GridViewRow)btn.NamingContainer;


        int rowindex = gvr.RowIndex;
        string id = grdSeperateCab.DataKeys[rowindex].Value.ToString();
        tmscontext.AcceptSeperateCab(Convert.ToInt32(id));
        ShowMessage("Request Approved Successfully");
        grdSeperateCab.DataSource = tmscontext.getAllSeperateCab(Convert.ToDateTime(txtStartDate.Text), Convert.ToDateTime(txtEndDate.Text), Convert.ToInt32(ddlFacility.SelectedValue));
        grdSeperateCab.DataBind();
    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
}
