using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class FemaleTrack : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    string strShifttimes = string.Empty;
    public string _facilityid
    {
        get
        {
            return (string)ViewState["_facilityid"];
        }

        set
        {
            ViewState["_facilityid"] = value;
        }
    }
    public string _ShiftDate
    {
        get
        {
            return (string)ViewState["_ShiftDate"];
        }

        set
        {
            ViewState["_ShiftDate"] = value;
        }
    }
    public string _StrShift
    {
        get
        {
            return (string)ViewState["_StrShift"];
        }

        set
        {
            ViewState["_StrShift"] = value;
        }
    }
    public string _strTripType
    {
        get
        {
            return (string)ViewState["_strTripType"];
        }

        set
        {
            ViewState["_strTripType"] = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Visible = false;
        if (!IsPostBack)
        {
            BndDdl();
            txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string sDate = txtStartDate.Text;
            int facId = Convert.ToInt32(ddlfacility.SelectedValue.ToString());

            if (lstShift.SelectedIndex >= 0)
            {
                for (int i = 0; i < lstShift.Items.Count; i++)
                {
                    if (lstShift.Items[i].Selected)
                    {
                        strShifttimes = strShifttimes + lstShift.Items[i].Text.Trim() + ",";
                    }
                }
                strShifttimes = strShifttimes.Remove(strShifttimes.Length - 1, 1);
            }
            _ShiftDate = txtStartDate.Text;
            _facilityid = ddlfacility.SelectedValue.ToString();
            _StrShift = strShifttimes;
            _strTripType = rdoTripType.SelectedValue;

            BndGridFemaleData();

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
        finally
        {

            btnSubmit.Enabled = true;
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
    protected void ddlfacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblFacError.Visible = false;
        BndLstShift();

    }
    public void BndLstShift()
    {
        //**********************************//
        //Bind Shift Listbox              //
        //*********************************//
        try
        {
            int facid = Convert.ToInt32(ddlfacility.SelectedValue.ToString());
            string type = rdoTripType.SelectedValue.ToString();
            lstShift.Items.Clear();
            ListItem list = new ListItem("-Select-", "0");
            lstShift.Items.Add(list);
            lstShift.DataSource = tms.GetShiftFemaleTrack(facid, type);
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

    public void BndGridFemaleData()
    {
        try
        {
            gvFemaleData.DataSource = tms.GetFemaleRouteData(_ShiftDate, Convert.ToInt32(_facilityid), _StrShift, _strTripType);
            gvFemaleData.DataBind();
            if (gvFemaleData.Rows.Count > 0)
                lbtnPrintExcel.Visible = true;
            else
                lbtnPrintExcel.Visible = false;

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }




    protected void gvFemaleData_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            int ResChkTrack = Convert.ToByte(((CheckBox)gvFemaleData.Rows[e.RowIndex].FindControl("ChkTrack")).Checked);
            string ResTxtRemark = ((TextBox)gvFemaleData.Rows[e.RowIndex].FindControl("TxtRemark")).Text;
            string ResRouteid = gvFemaleData.DataKeys[e.RowIndex].Values[0].ToString();
            string ResEmpid = gvFemaleData.DataKeys[e.RowIndex].Values[1].ToString();
            tms.UpdateFemaleTrackDetail(ResRouteid, ResEmpid, ResChkTrack, Server.HtmlEncode(ResTxtRemark), MyApplicationSession._UserID);
            lblMsg.Visible = true;
            lblMsg.Text = "Record updated successfully.";
            BndGridFemaleData();
            //ImageButton ibAssignSticker = (ImageButton)grdViewRouteParent.Rows[e.RowIndex].FindControl("ibAssignSticker");
            //ibAssignSticker.ImageUrl = "~/images/save5.jpg";
            //ibAssignSticker.ToolTip = "Vendor/StickerNo has been Assinged";
            //lblErroSticker.Text = string.Empty;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }

    }

    protected void gvFemaleData_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvFemaleData.PageIndex = e.NewPageIndex;
        BndGridFemaleData();
    }
    protected void rdoTripType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            BndLstShift();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void lbtnPrintExcel_Click(object sender, EventArgs e)
    {
        try
        {
            Server.Transfer("TrackFemaleToExcel.aspx");

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
}
