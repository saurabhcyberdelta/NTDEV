using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class costanalysisdetails : System.Web.UI.Page
{

    DataClasses1DataContext tmscontext = new DataClasses1DataContext();

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
            ddlYear.Items.Clear();
            int years = DateTime.Now.Year;
            ListItem liy = new ListItem("Select Year", "0");
            ddlYear.Items.Add(liy);
            ListItem li1 = new ListItem((years - 1).ToString(), (years - 1).ToString());
            ddlYear.Items.Add(li1);
            ListItem li2 = new ListItem((years).ToString(), (years).ToString());
            ddlYear.Items.Add(li2);
            ListItem li3 = new ListItem((years + 1).ToString(), (years + 1).ToString());
            ddlYear.Items.Add(li3);
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
        Grdanalysis.DataSource = tmscontext.getcostAnalysisDetails(Convert.ToInt32(ddlYear.SelectedValue), Convert.ToInt32(ddlFacility.SelectedValue));
        Grdanalysis.DataBind();
    }
    protected void lbtnAnalysisName_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;


        GridViewRow gvr = (GridViewRow)btn.NamingContainer;
        int rowindex = gvr.RowIndex;
        string id = Grdanalysis.DataKeys[rowindex].Value.ToString();
        int txtjan = Convert.ToInt32(((TextBox)(Grdanalysis.Rows[rowindex].FindControl("txtjan"))).Text);
        int txtfeb = Convert.ToInt32(((TextBox)(Grdanalysis.Rows[rowindex].FindControl("txtfeb"))).Text);
        int txtmar = Convert.ToInt32(((TextBox)(Grdanalysis.Rows[rowindex].FindControl("txtmar"))).Text);
        int txtapr = Convert.ToInt32(((TextBox)(Grdanalysis.Rows[rowindex].FindControl("txtapr"))).Text);
        int txtmay = Convert.ToInt32(((TextBox)(Grdanalysis.Rows[rowindex].FindControl("txtmay"))).Text);
        int txtjun = Convert.ToInt32(((TextBox)(Grdanalysis.Rows[rowindex].FindControl("txtjun"))).Text);
        int txtjul = Convert.ToInt32(((TextBox)(Grdanalysis.Rows[rowindex].FindControl("txtjul"))).Text);
        int txtaug = Convert.ToInt32(((TextBox)(Grdanalysis.Rows[rowindex].FindControl("txtaug"))).Text);
        int txtsep = Convert.ToInt32(((TextBox)(Grdanalysis.Rows[rowindex].FindControl("txtsep"))).Text);
        int txtoct = Convert.ToInt32(((TextBox)(Grdanalysis.Rows[rowindex].FindControl("txtoct"))).Text);
        int txtnov = Convert.ToInt32(((TextBox)(Grdanalysis.Rows[rowindex].FindControl("txtnov"))).Text);
        int txtdec = Convert.ToInt32(((TextBox)(Grdanalysis.Rows[rowindex].FindControl("txtdec"))).Text);
        int facid = Convert.ToInt32(ddlFacility.SelectedValue);
        int years = Convert.ToInt32(ddlYear.SelectedValue);
        tmscontext.addcostanalysisdetail(years, facid, Convert.ToInt32(id), txtjan, txtfeb, txtmar, txtapr, txtmay, txtjun, txtjul, txtaug, txtsep, txtoct, txtnov, txtdec);
        String lbtnnavigateurl = new EncryptQueryString().Encrypt("id=" + id + "&facid=" + facid.ToString() + "&years=" + years.ToString());
        string jScript = "window.open('dashboardcostanalysis.aspx?" + lbtnnavigateurl + "','','');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Print", jScript, true);
    }
}
