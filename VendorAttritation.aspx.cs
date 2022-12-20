using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VendorAttritation : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    //vendor vd = new vendor();

    public int _Att
    {
        get
        {
            return (int)ViewState["_Att"];
        }
        set
        {
            ViewState["_Att"] = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bndfacilitydrop();
            BndVendorGrid();
        }
    }

    protected void bndfacilitydrop()
    {
        ddlSelectFacility.Items.Clear();
        ddlSelectFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
        ddlSelectFacility.DataTextField = "facilityName";
        ddlSelectFacility.DataValueField = "Id";
        ddlSelectFacility.DataBind();
        ListItem liFacIn = new ListItem("-Select Facility-", "0");
        ddlSelectFacility.Items.Insert(0, liFacIn);
        ddlSelectFacility.SelectedIndex = ddlSelectFacility.Items.IndexOf(ddlSelectFacility.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));
    }

    public void BndVendorGrid()
    {
        //*************************************************************//
        //Binds the vendor grid with the vendor list in the DB       //
        //*************************************************************//
        try
        {
            int chkId;
            if (chkAtt.Checked == true)
            {
                chkId = 1;
                btnOk.Text = "UnAttrite";
            }
            else
            {
                chkId = 0;
                btnOk.Text = "Attrite";
            }
            int facId = Convert.ToInt32(ddlSelectFacility.SelectedValue);
            grdVendor.DataSource = tms.SelectVendorById(Convert.ToInt32(Session["LocationId"].ToString()), facId, chkId);
            grdVendor.DataBind();
            lblMsg.Visible = false;
            if (grdVendor.Rows.Count < 1)
            {
                lblMsg.Text = "No Record Found!";
                lblMsg.Visible = true;
            }
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void grdVendor_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdVendor.PageIndex = e.NewPageIndex;
        BndVendorGrid();
    }
    protected void chkAtt_CheckedChanged(object sender, EventArgs e)
    {
        BndVendorGrid();
    }

    protected void ButtonSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid == true)
            {
                int f = 0;
                string vederId = string.Empty;
                string descp = string.Empty;
                if (chkAtt.Checked == true)
                {
                    _Att = 0;
                }
                else
                {
                    _Att = 1;
                }

                ContentPlaceHolder mainContaint = (ContentPlaceHolder)this.Master.FindControl("ContentPlaceHolder1");
                foreach (GridViewRow i in grdVendor.Rows)
                {
                    CheckBox cb = ((CheckBox)i.FindControl("chkAttrited"));
                    if (cb != null && cb.Checked)
                    {
                        Label lbl = (Label)i.FindControl("lblId");
                        vederId = vederId + lbl.Text.Trim() + ",";
                        f = 1;
                    }                    
                }
                if (f == 1)
                {
                    vederId = vederId.Remove(vederId.Length - 1, 1);
                    descp = txtDescp.Text;
                    string result = tms.AttritedVendor(vederId, _Att, descp, MyApplicationSession._UserID).ElementAtOrDefault(0).RESULT.Value.ToString();
                    if (result.Equals("1"))
                    {
                        lblErrorMsg.Text = "<b>Record Updated Successfully!</b>";
                        lblErrorMsg.ForeColor = System.Drawing.Color.Green;
                        lblErrorMsg.Visible = true;
                        BndVendorGrid();
                        txtDescp.Text = string.Empty;
                    }
                    else
                    {
                        lblErrorMsg.Text = "Error!";
                        lblErrorMsg.Visible = true;
                    }
                }
                else
                {
                    ShowMessage("Please select at least one vendor");
                }
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    //public void CustomValidatorCheckBox_ServerValidate(Object source, ServerValidateEventArgs args)
    //{
    //    try
    //    {
    //        bool checkstate = false;
    //        foreach (GridViewRow i in grdVendor.Rows)
    //        {
    //            // Access the CheckBox
    //            CheckBox cb = (CheckBox)i.FindControl("chkAttrited");
    //            if (cb.Checked)
    //            {
    //                checkstate = true;
    //                ModalPopupExtender1.Show();
    //                break;
    //            }
    //        }
    //        args.IsValid = checkstate;
    //    }
    //    catch (Exception ex)
    //    {
    //        // Log the exception and notify system operators
    //        ExceptionUtility.LogException(ex, "Catch Error");
    //        throw (ex);
    //    }
    //}
    protected void btnOk_Click(object sender, EventArgs e)
    {
        ModalPopupExtender1.Show();
    }
    protected void ddlSelectFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        BndVendorGrid();
    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
}
