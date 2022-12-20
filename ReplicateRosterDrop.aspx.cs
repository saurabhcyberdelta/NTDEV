using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class ReplicateRosterDrop : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        lblErrorFlag.Visible = false;
        CompareValidator3.ValueToCompare = DateTime.Now.ToString("MM/dd/yyyy");
        if (!IsPostBack)
        {
            BndDdl();
            txtFromDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");

            System.Text.StringBuilder sbValid = new System.Text.StringBuilder();

            sbValid.Append("if (typeof(Page_ClientValidate) == 'function') { ");

            sbValid.Append("if (Page_ClientValidate() == false) { return false; }} ");

            sbValid.Append("this.value = 'Please wait...';");

            sbValid.Append("this.disabled = true;");

            sbValid.Append("document.all." + btnSubmit.UniqueID + ".disabled = true;");

            sbValid.Append(this.Page.GetPostBackEventReference(this.btnSubmit));

            sbValid.Append(";");

            this.btnSubmit.Attributes.Add("onclick", sbValid.ToString());
        }
    }
    public void BndDdl()
    {
        //**********************************//
        //Binds Facility Dropdown          //
        //*********************************//
        try
        {
            ddlfacility.Items.Clear();
            ListItem lifac = new ListItem("Select Facility", "0");
            ddlfacility.Items.Add(lifac);
            ddlfacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID,MyApplicationSession._ISAdmin);
            ddlfacility.DataTextField = "facilityName";
            ddlfacility.DataValueField = "Id";
            ddlfacility.DataBind();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }
    protected void ddlfacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblFacError.Visible = false;
        if (ddlfacility.SelectedIndex != 0)
        {
            BndLstShift();

        }
    }

    public void BndLstShift()
    {

        //**********************************//
        //Bind Shift Listbox              //
        //*********************************//
        try
        {
            int facid = Convert.ToInt32(ddlfacility.SelectedValue.ToString());
            ddlPickShift.Items.Clear();
            ListItem list = new ListItem("-Select-", "0");
            ddlPickShift.Items.Add(list);
            ddlPickShift.DataSource = tms.GetShiftByFacilityType(facid, "P");
            ddlPickShift.DataTextField = "shiftTime";
            ddlPickShift.DataValueField = "shiftTime";
            ddlPickShift.DataBind();
            ddlPickShift.SelectedIndex = 0;

            ddlDropShift.Items.Clear();
            ListItem list1 = new ListItem("-Select-", "0");
            ddlDropShift.Items.Add(list1);
            ddlDropShift.DataSource = tms.GetShiftByFacilityType(facid, "D");
            ddlDropShift.DataTextField = "shiftTime";
            ddlDropShift.DataValueField = "shiftTime";
            ddlDropShift.DataBind();
            ddlDropShift.SelectedIndex = 0;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }
    protected void rdbtnlstType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlfacility.SelectedIndex != 0)
            {

                BndLstShift();
                lblFacError.Visible = false;
            }
            else
            {

                lblFacError.Visible = true;

            }
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
        DateTime fromDate = Convert.ToDateTime(txtFromDate.Text);
        DateTime toDate = Convert.ToDateTime(txtToDate.Text);
        int facId = Convert.ToInt32(ddlfacility.SelectedValue.ToString());

        var result = tms.ReplicateRosterForDrop(fromDate, toDate, facId, ddlPickShift.SelectedValue, ddlDropShift.SelectedValue, MyApplicationSession._UserID).ElementAtOrDefault(0).result.ToString();
        lblErrorFlag.Text = result;
        lblErrorFlag.Visible = true;
    }
}
