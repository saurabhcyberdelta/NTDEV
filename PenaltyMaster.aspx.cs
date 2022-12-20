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

public partial class PenaltyMaster : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    ComplianceCheckMaster cm = new ComplianceCheckMaster();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblMsg.Text = string.Empty;
            mvFacility.ActiveViewIndex = 0;
            BndFacility();
            bindvendor();
            BndGridView();            
        }
    }

    protected void EmptyField()
    {
        ((TextBox)dvFacility.FindControl("txtdvFacilityName")).Text = string.Empty;
        ((TextBox)dvFacility.FindControl("txtdvGeoX")).Text = string.Empty;
        ((DropDownList)dvFacility.FindControl("ddldvPenaltyfor")).SelectedIndex = 0;
        ((TextBox)dvFacility.FindControl("txtdvFacilityName")).Focus();

        //DropDownList ddlFacility = ((DropDownList)dvFacility.FindControl("ddldvFacility"));
        //DropDownList ddlVendor = ((DropDownList)dvFacility.FindControl("ddldvVendor"));

        //ListItem lstFac = new ListItem("-Select-", "0");
        //ListItem lstVen = new ListItem("-Select-", "-1");

        //ddlFacility.Items.Clear();
        //ddlVendor.Items.Clear();
        //ddlVendor.Items.Add(lstVen);
        //ddlFacility.Items.Add(lstVen);

        //ddlFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
        //ddlFacility.DataTextField = "facilityName";
        //ddlFacility.DataValueField = "Id";
        //ddlFacility.DataBind();

        //ddlFacility.DataSource = null;// tms.SelectFacility(MyApplicationSession._UserID);
        ////ddlFacility.DataTextField = "";
        ////ddlFacility.DataValueField = "";
        //ddlFacility.DataBind();
    }
    private void bindvendor()
    {
        ListItem livend = new ListItem("Select Vendor", "-1");
        ListItem livend2 = new ListItem("-All Vendor-", "0");
        ddlvendor0.Items.Clear();
        ddlvendor0.Items.Add(livend);
        ddlvendor0.Items.Add(livend2);
        ddlvendor0.DataSource = tms.GetVendorByFacility(Convert.ToInt32(ddlfacility0.SelectedValue));
        ddlvendor0.DataTextField = "vendorName";
        ddlvendor0.DataValueField = "Id";
        ddlvendor0.DataBind();
        ddlvendor0.SelectedIndex = 1;
    }
    public void BndFacility()
    {
        try
        {
            ddlfacility0.Items.Clear();
            ddlfacility0.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlfacility0.DataTextField = "facilityName";
            ddlfacility0.DataValueField = "Id";
            ddlfacility0.DataBind();
            ddlfacility0.SelectedIndex = ddlfacility0.Items.IndexOf(ddlfacility0.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void BndGridView()
    {
        try
        {
            gvFacility.DataSource = tms.SelectPenaltyType(Convert.ToInt32(ddlvendor0.SelectedValue));
            gvFacility.DataBind();
            //if (gvFacility.Rows.Count < 1)
            //{
            //    lblMsg.Text = "No Record Found!";
            //    lblMsg.Visible = true;
            //    mvFacility.ActiveViewIndex = 1;
            //    EmptyField();
            //}
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void lbtnAddNew_Click(object sender, EventArgs e)
    {
        mvFacility.ActiveViewIndex = 1;
        EmptyField();
        lblMsg.Text = string.Empty;
    }
    protected void dvFacility_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        try
        {
            cm.HeadName = ((TextBox)dvFacility.FindControl("txtdvFacilityName")).Text;
            cm.Penalty = Convert.ToDouble(((TextBox)dvFacility.FindControl("txtdvGeoX")).Text);
            //int facId = Convert.ToInt32(((DropDownList)dvFacility.FindControl("ddldvFacility")).SelectedValue);
            //int venId = Convert.ToInt32(((DropDownList)dvFacility.FindControl("ddldvVendor")).SelectedValue);
            cm.PenaltyFor = ((DropDownList)dvFacility.FindControl("ddldvPenaltyfor")).SelectedValue;
            //int fac = Convert.ToInt32(((DropDownList)dvFacility.FindControl("ddldvFacility")).SelectedValue);
            //string effdate= ((TextBox)dvFacility.FindControl("txtEffectiveDate")).Text;
            var Result = tms.InsertPenalty(cm.HeadName, Convert.ToDecimal(cm.Penalty), cm.PenaltyFor,0,Convert.ToDateTime(DateTime.Now),MyApplicationSession._UserID,0);
            //if (result.Equals("1"))
            //{
            //    lblMsg.Text = "Record Added Successfully!";
            //    lblMsg.Visible = true;
            //    EmptyField();
            //}
            //else
            //{
            //    lblMsg.Text = "Record Already Exists!";
            //    lblMsg.Visible = true;
            //}


            foreach (var r in Result)
            {
                if (r.flag.ToString() == "0")
                {
                    lblErrorMsg.Visible = false;
                    ShowMessage(r.RESULT.ToString());
                    lblMsg.Visible = true;
                    //EmptyField();
                }
                else
                {
                    ShowMessage(r.RESULT.ToString());
                    if (r.RESULT.ToUpper().Contains("OTHERS ARE INSERTED") == true)
                    {
                        lblMsg.Visible = true;
                        //EmptyField();
                    }


                }
            }
            ((TextBox)dvFacility.FindControl("txtdvFacilityName")).Text = string.Empty;
            ((TextBox)dvFacility.FindControl("txtdvGeoX")).Text = string.Empty;
            ((DropDownList)dvFacility.FindControl("ddldvPenaltyfor")).SelectedIndex = 0;
            ((TextBox)dvFacility.FindControl("txtdvFacilityName")).Focus();

           



        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
    protected void dvFacility_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.Cancel == true || e.CancelingEdit == true)
        {
            mvFacility.ActiveViewIndex = 0;
            gvFacility.EditIndex = -1;
            EmptyField();
            BndGridView();
            lblMsg.Text = string.Empty;
        }
    }

    protected void ddlfacility0_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindvendor();
        BndGridView();

    }
    protected void ddlvendor0_SelectedIndexChanged(object sender, EventArgs e)
    {
        BndGridView();
    }
    protected void gvFacility_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvFacility.PageIndex = e.NewPageIndex;
        BndGridView();
    }
    protected void gvFacility_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        lblMsg.Text = string.Empty;
        gvFacility.EditIndex = -1;
        BndGridView();
    }
    protected void gvFacility_RowEditing(object sender, GridViewEditEventArgs e)
    {
        string penaltyfor = ((Label)gvFacility.Rows[e.NewEditIndex].FindControl("lblGeoY")).Text;
        //string facility = ((Label)gvFacility.Rows[e.NewEditIndex].FindControl("lbFacility")).Text;
        //string vendor = ((Label)gvFacility.Rows[e.NewEditIndex].FindControl("lblVendor")).Text;

        gvFacility.EditIndex = e.NewEditIndex;
        BndGridView();
        DropDownList ddlPenaltyFor = ((DropDownList)gvFacility.Rows[e.NewEditIndex].FindControl("ddlPenaltyFor"));
        //DropDownList ddlFacility = ((DropDownList)gvFacility.Rows[e.NewEditIndex].FindControl("ddlFacility"));
        //DropDownList ddlVendor = ((DropDownList)gvFacility.Rows[e.NewEditIndex].FindControl("ddlVendor"));

        //ddlFacility.Items.Clear();
        //ListItem lstFac = new ListItem("-Select-", "0");
        //ddlFacility.Items.Add(lstFac);
        //ddlFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
        //ddlFacility.DataTextField = "facilityName";
        //ddlFacility.DataValueField = "Id";
        //ddlFacility.DataBind();

        //ddlFacility.SelectedIndex = ddlFacility.Items.IndexOf(ddlFacility.Items.FindByText(facility));

        //ddlVendor.Items.Clear();
        //ListItem lstVen = new ListItem("-Select-", "0");
        //ddlVendor.Items.Add(lstVen);
        //ddlVendor.DataSource = tms.GetVendorByFacility(Convert.ToInt32(ddlFacility.SelectedValue));
        //ddlVendor.DataTextField = "VendorName";
        //ddlVendor.DataValueField = "Id";
        //ddlVendor.DataBind();

        //ddlVendor.SelectedIndex = ddlVendor.Items.IndexOf(ddlVendor.Items.FindByText(vendor));

        ddlPenaltyFor.SelectedIndex = ddlPenaltyFor.Items.IndexOf(ddlPenaltyFor.Items.FindByText(penaltyfor.ToString()));
    }
    protected void gvFacility_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            cm.ID = Convert.ToInt32(gvFacility.DataKeys[e.RowIndex].Value.ToString());
            cm.HeadName = ((TextBox)gvFacility.Rows[e.RowIndex].FindControl("txtFacility")).Text;
            cm.Penalty = Convert.ToDouble(((TextBox)gvFacility.Rows[e.RowIndex].FindControl("txtGeoX")).Text);
            cm.PenaltyFor = ((DropDownList)gvFacility.Rows[e.RowIndex].FindControl("ddlPenaltyFor")).SelectedValue;
            //int facId = Convert.ToInt32(((DropDownList)gvFacility.Rows[e.RowIndex].FindControl("ddlFacility")).SelectedValue);
            //int VenId = Convert.ToInt32(((DropDownList)gvFacility.Rows[e.RowIndex].FindControl("ddlVendor")).SelectedValue);
            string result = tms.UpdatePenalty(cm.ID,cm.HeadName, Convert.ToDecimal(cm.Penalty), cm.PenaltyFor,0,MyApplicationSession._UserID).ElementAtOrDefault(0).RESULT.ToString();
            if (result.Equals("1"))
            {
                lblMsg.Text = "Record Updated Successfully!";
                lblMsg.Visible = true;
                gvFacility.EditIndex = -1;
                BndGridView();
            }
            else
            {
                lblMsg.Text = "Record Already Exists!";
                lblMsg.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void ddldvFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            int ddlFac = Convert.ToInt32(((DropDownList)dvFacility.FindControl("ddldvFacility")).SelectedValue);
            DropDownList ddlven = ((DropDownList)dvFacility.FindControl("ddldvVendor"));
            ListItem lstVen = new ListItem("-Select-", "-1");
            ListItem lstVen2 = new ListItem("-All Vendor-", "0");
            ddlven.Items.Clear();
            ddlven.Items.Add(lstVen);
            ddlven.Items.Add(lstVen2);
            ddlven.DataSource = tms.GetVendorByFacility(ddlFac);
            ddlven.DataTextField = "vendorName";
            ddlven.DataValueField = "Id";
            ddlven.DataBind();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        try 
        {
            DropDownList ddlvendor = (DropDownList)sender;

            GridViewRow row = (GridViewRow)ddlvendor.NamingContainer;
            if (row != null)
            {
                DropDownList ddlFacility = ((DropDownList)row.FindControl("ddlFacility"));
                DropDownList ddlVendor = ((DropDownList)row.FindControl("ddlVendor"));

                ddlVendor.Items.Clear();
                ListItem lstven = new ListItem("-Select-", "0");
                ddlVendor.Items.Clear();
                ddlVendor.Items.Add(lstven);
                ddlVendor.DataSource = tms.GetVendorByFacility(Convert.ToInt32(ddlFacility.SelectedValue));
                ddlVendor.DataTextField = "vendorName";
                ddlVendor.DataValueField = "Id";
                ddlVendor.DataBind();
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void ddlfacility0_SelectedIndexChanged1(object sender, EventArgs e)
    {
        bindvendor();
        BndGridView();
    }
    protected void ddlvendor0_SelectedIndexChanged1(object sender, EventArgs e)
    {
        BndGridView();
    }
    protected void lbtnExport_Click(object sender, EventArgs e)
    {
        try
        {
            gvCostExcel.DataSource = tms.SelectPenaltyType(Convert.ToInt32(ddlvendor0.SelectedValue));
            gvCostExcel.DataBind();
            GridViewExportUtil.Export("CostMaster"+DateTime.Now.ToString()+".xls", gvCostExcel);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
}
