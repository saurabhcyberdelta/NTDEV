using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UnschedRequests : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
            BndFacilityDropdown();
            BndShiftTimeListBx();

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

    public void BndShiftTimeListBx()
    {
        try
        {
            int facid = Convert.ToInt32(ddlFacility.SelectedValue.ToString());
            string type = rdoTripType.SelectedValue.ToString();
            lstShift.Items.Clear();
            ListItem list = new ListItem("-Select-", "0");
            lstShift.Items.Add(list);
            lstShift.DataSource = tmscontext.GetShiftByFacilityType(facid, type);
            lstShift.DataTextField = "shiftTime";
            lstShift.DataValueField = "shiftTime";
            lstShift.DataBind();
            lstShift.SelectedIndex = 0;
            
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
            BndShiftTimeListBx();
            bndgrid();
          }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    protected void rdoTripType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            BndShiftTimeListBx();
            bndgrid();
           
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
        bndgrid(); 
    }
    protected void bndgrid()
    {
        string date = txtStartDate.Text;
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
        string fac = ddlFacility.SelectedValue;
        gvUnsched.DataSource = tmscontext.getAllunschedRequests(Convert.ToDateTime(date), Shifttimes, Convert.ToInt32(fac));
        gvUnsched.DataBind();
        if (gvUnsched.Rows.Count > 0)
        {
            lblexport.Visible = true;
        }
        else
        {
            lblexport.Visible = false;
        }
    }
    protected void lbTakePrint_Click(object sender, EventArgs e)
    {
       
        LinkButton btn = (LinkButton)sender;
        GridViewRow gvr = (GridViewRow)btn.NamingContainer;
        int rowindex = gvr.RowIndex;
        string Id = gvUnsched.DataKeys[rowindex].Value.ToString();
        String lbtnnavigateurl = (new EncryptQueryString()).Encrypt("ID=" + Id);
        string jScript = "window.open('PrintUnscheduleTripsheet.aspx?" + lbtnnavigateurl + "','','');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Print", jScript, true);
    }
    protected void lblexport_Click(object sender, EventArgs e)
    {
        GridViewExportUtil.Export("UnscheduleRequest.xls", gvUnsched);
    }
}
