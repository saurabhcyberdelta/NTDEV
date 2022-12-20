using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;
using System.Data;

public partial class ComplianceCheck : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();

    public string _CabId
    {
        get
        {
            return (string)ViewState["_CabId"];
        }
        set
        {
            ViewState["_CabId"] = value;
        }
    }
    public string _SelDate
    {
        get
        {
            return (string)ViewState["_SelDate"];
        }
        set
        {
            ViewState["_SelDate"] = value;
        }
    }

    public int _facilityID
    {
        get
        {
            return (int)ViewState["_facilityID"];
        }
        set
        {
            ViewState["_facilityID"] = value;
        }
    }

    public int _vendorID
    {
        get
        {
            return (int)ViewState["_vendorID"];
        }
        set
        {
            ViewState["_vendorID"] = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";

        if (!IsPostBack)
        {
            txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
            pnlDetail.Visible = false;
            BndDdlFac();
        }
    }
    public void BndDdlFac()
    {
        try
        {
            ddlfacility.Items.Clear();
            ListItem lifac = new ListItem("Select Facility", "0");
            ddlfacility.Items.Add(lifac);
            ddlfacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
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
    public void BndDvDropdown()
    {
        try
        {
            ddlVendor.Items.Clear();
            ListItem liv = new ListItem("Select Vendor", "0");
            ddlVendor.Items.Add(liv);
            ddlVendor.DataSource = tms.GetVendorByFac(Convert.ToInt32(ddlfacility.SelectedValue));
            ddlVendor.DataTextField = "vendorName";
            ddlVendor.DataValueField = "Id";
            ddlVendor.DataBind();
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
        _SelDate = txtStartDate.Text;
        _CabId = txtCabID.Text;
        _facilityID = Convert.ToInt32(ddlfacility.SelectedValue);
        _vendorID = Convert.ToInt32(ddlVendor.SelectedValue);
        lblMsg.Text = "";
        pnlDetail.Visible = true;
        btnSave.Visible = true;
        BndGvDetail();

        GridView gv = new GridView();
        gv.DataSource = tms.GetCompCheckOther(_CabId, Convert.ToDateTime(_SelDate),_facilityID,_vendorID);
        gv.DataBind();
        if (gv.Rows.Count > 0)
        {
            int IsOther = Convert.ToInt32(gv.Rows[0].Cells[2].Text);
            if (IsOther == 1)
            {
                pnlOther.Visible = true;
                chkOther.Checked = true;
                txtOremark.Text = gv.Rows[0].Cells[1].Text;
                txtOpenalty.Text = gv.Rows[0].Cells[0].Text;
            }
            else
            {
                pnlOther.Visible = false;
                chkOther.Checked = false;
                txtOremark.Text = "";
                txtOpenalty.Text = "";
            }
        }
        else
        {
            pnlOther.Visible = false;
            chkOther.Checked = false;
            txtOremark.Text = "";
            txtOpenalty.Text = "";

        }
    }
    private void BndGvDetail()
    {
        try
        {
            gvDetail.DataSource = tms.GetCompCheckData(_CabId, Convert.ToDateTime(_SelDate),_facilityID,_vendorID);
            gvDetail.DataBind();
            txtRegistrationNo.Visible = true;
            txtRegistrationNo.Text = tms.GetCompCheckData(_CabId, Convert.ToDateTime(_SelDate), _facilityID, _vendorID).ElementAtOrDefault(0).vehicleRegistrationNo.ToString();
            for (int i = 0; i < gvDetail.Rows.Count; i++)
            {
                DropDownList drdList;
                drdList = (DropDownList)(gvDetail.Rows[i].FindControl("ddlStatus"));
                drdList.SelectedValue = gvDetail.DataKeys[i]["Status"].ToString();
                if (drdList.SelectedValue.ToString() == "N/A")
                    ((TextBox)gvDetail.Rows[i].FindControl("txtRemark")).Enabled = false;
                else
                    ((TextBox)gvDetail.Rows[i].FindControl("txtRemark")).Enabled = true;
                if (drdList.SelectedValue.ToString() == "NOT OK")
                    ((Label)gvDetail.Rows[i].FindControl("lblPenalty")).Visible = true;
                else
                    ((Label)gvDetail.Rows[i].FindControl("lblPenalty")).Visible = false;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            DropDownList drdList;
            int EditRows=0;
            string OtherRemark = "";
            Double OtherPenalty = 0;
            int IsOther = 0;
            int refID;
            if (chkOther.Checked == true)
            {
                IsOther = 1;
                OtherRemark = txtOremark.Text;
                OtherPenalty = Convert.ToDouble(txtOpenalty.Text);
            }
            foreach (GridViewRow row in gvDetail.Rows)
            {
                drdList = (DropDownList)(gvDetail.Rows[row.RowIndex].Cells[1].FindControl("ddlStatus"));
                if (drdList.SelectedValue == "N/A")
                    EditRows = EditRows + 1;
            }
            //User Neither select any dropdown nor entered any value in 'other reason' text box.

            if (EditRows == gvDetail.Rows.Count && IsOther == 0)
            {
                string regno = txtRegistrationNo.Text;
                refID = Convert.ToInt32(tms.UpdateCompCheckMain(Convert.ToDateTime(_SelDate), _CabId, "Delete", IsOther, OtherRemark, OtherPenalty,_facilityID,_vendorID,regno).ElementAtOrDefault(0).ID.ToString());
                if (refID==-1)
                    lblMsg.Text = "Record Removed !";
                else if(refID==0)
                    lblMsg.Text = "Record not saved, You didn't select any option.";
            }
            else
            {
                string regno = txtRegistrationNo.Text;
                refID = Convert.ToInt32(tms.UpdateCompCheckMain(Convert.ToDateTime(_SelDate), _CabId, MyApplicationSession._UserID.ToString(), IsOther, OtherRemark, OtherPenalty, _facilityID, _vendorID,regno).ElementAtOrDefault(0).ID.ToString());
                foreach (GridViewRow row in gvDetail.Rows)
                {
                    drdList = (DropDownList)(gvDetail.Rows[row.RowIndex].Cells[1].FindControl("ddlStatus"));
                    string remark = ((TextBox)(gvDetail.Rows[row.RowIndex].Cells[2].FindControl("txtRemark"))).Text;
                    int headID = Convert.ToInt32(gvDetail.DataKeys[row.RowIndex].Values[0]);
                    tms.UpdateCompCheckDetail(refID, headID, drdList.SelectedValue,Server.HtmlEncode(remark));
                }
                lblMsg.Text = "Details saved !";
            }
            pnlDetail.Visible = false;
            txtCabID.Text = "";
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
        BndDvDropdown();
        pnlDetail.Visible = false;
        txtCabID.Text = "";
        ddlVendor.Focus();
    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;
        GridViewRow gvr = (GridViewRow)ddl.Parent.Parent;
        int rindex = gvr.RowIndex;
        if (ddl.SelectedValue.ToString() == "N/A")
        {
            ((TextBox)gvDetail.Rows[rindex].FindControl("txtRemark")).Text = string.Empty;
            ((TextBox)gvDetail.Rows[rindex].FindControl("txtRemark")).Enabled = false;
        }
        else
            ((TextBox)gvDetail.Rows[rindex].FindControl("txtRemark")).Enabled = true;
        if (ddl.SelectedValue.ToString() == "NOT OK")
            ((Label)gvDetail.Rows[rindex].FindControl("lblPenalty")).Visible = true;
        else
            ((Label)gvDetail.Rows[rindex].FindControl("lblPenalty")).Visible = false;


    }
    protected void chkOther_CheckedChanged(object sender, EventArgs e)
    {
        if (chkOther.Checked == true)
            pnlOther.Visible = true;
        else
            pnlOther.Visible = false;
    }
    protected void ddlVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        pnlDetail.Visible = false;
        txtCabID.Text = "";
        txtCabID.Focus();
    }
}
