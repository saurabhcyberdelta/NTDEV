using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReportTableAdapters;
public partial class SmsSend : basepage
{
    ExportEmployeeForSmsTableAdapter ds = new ExportEmployeeForSmsTableAdapter();
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        lblmsg.Text = "";
        txtempid.Focus();
        //Lblsize.Text = "160";
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = -1;
            bindddlocation();
          
            txtStartDate.Text = DateTime.Now.Date.Date.ToString("MM/dd/yyyy");
            bndradiobtn();

        }
    }
    protected void ddsms()
    {

        try
        {
           
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }


    }
    protected void bindddlocation()
    {
        try
        {
            ddlFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID,MyApplicationSession._ISAdmin);
            ddlFacility.DataTextField = "FacilityName";
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
    protected void binddlFacilityshift()
    {
        try
        {
            ddlFacilityshift.Items.Clear();
            ListItem item = new ListItem("--Select--", "0");
            ddlFacilityshift.Items.Add(item);
            ddlFacilityshift.DataSource = tms.SelectFacility(MyApplicationSession._UserID,MyApplicationSession._ISAdmin);
            ddlFacilityshift.DataTextField = "FacilityName";
            ddlFacilityshift.DataValueField = "Id";
            ddlFacilityshift.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void rdbSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (rdbSearch.SelectedItem.ToString() == "Employee")
            {
                lblmsg.Text = "";
                txtempid.Text = "";
                MultiView1.ActiveViewIndex = 0;
                MultiView2.ActiveViewIndex = -1;
            }
            if (rdbSearch.SelectedItem.ToString() == "Process")
            {
                ddlFacility.SelectedValue = "0";
                ddlProcess.SelectedValue = "0";
                lblmsg.Text = "";
                ddlSubProcess.SelectedValue = "0";
                MultiView2.ActiveViewIndex = -1;
                MultiView1.ActiveViewIndex = 1;

            }
            if (rdbSearch.SelectedItem.ToString() == "Route")
            {
                lblmsg.Text = "";
                TxtrouteId.Text = "";
                TxtrouteId.Focus();
                MultiView2.ActiveViewIndex = -1;
                MultiView1.ActiveViewIndex = 2;

            }
            if (rdbSearch.SelectedItem.ToString() == "ShiftDate")
            {
                lblmsg.Text = "";
                TxtrouteId.Text = "";
              
                rdoTripType.SelectedIndex = 0;
                txtStartDate.Text = DateTime.Now.Date.Date.ToString("MM/dd/yyyy");
                binddlFacilityshift();
                BndShiftTimeListBx();
                MultiView2.ActiveViewIndex = -1;
                MultiView1.ActiveViewIndex = 3;

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    void bndradiobtn()
    {
        try
        {
            if (rdbSearch.SelectedItem.ToString() == "Employee")
            {
                lblmsg.Text = "";
                txtempid.Text = "";
                MultiView1.ActiveViewIndex = 0;
                MultiView2.ActiveViewIndex = -1;
            }
            if (rdbSearch.SelectedItem.ToString() == "Process")
            {
                ddlFacility.SelectedValue = "0";
                ddlProcess.SelectedValue = "0";
                lblmsg.Text = "";
                ddlSubProcess.SelectedValue = "0";
                MultiView2.ActiveViewIndex = -1;
                MultiView1.ActiveViewIndex = 1;

            }
            if (rdbSearch.SelectedItem.ToString() == "Route")
            {
                lblmsg.Text = "";
                TxtrouteId.Text = "";
                TxtrouteId.Focus();
                MultiView2.ActiveViewIndex = -1;
                MultiView1.ActiveViewIndex = 2;

            }
            if (rdbSearch.SelectedItem.ToString() == "ShiftDate")
            {
                lblmsg.Text = "";
                TxtrouteId.Text = "";

                rdoTripType.SelectedIndex = 0;
                txtStartDate.Text = DateTime.Now.Date.Date.ToString("MM/dd/yyyy");
                binddlFacilityshift();
                BndShiftTimeListBx();
                MultiView2.ActiveViewIndex = -1;
                MultiView1.ActiveViewIndex = 3;

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void btnsubmemp_Click(object sender, EventArgs e)
    {
        try
        {
            lblmsg.Text = "";
            newmessage();
            MultiView2.ActiveViewIndex = 0;
            ddsms();
            if (txtempid.Text.Length >= 5000)
            {
                MultiView2.ActiveViewIndex = -1;
                string script = "alert(\"Text size could nt b greater than 5000\");";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(),
                                                Guid.NewGuid().ToString(), script, true);
            }
            else
            {

                string empIDs = Strip(txtempid.Text).Trim();
                txtempid.Text = empIDs.Substring(0,empIDs.Length-1);
                string routeid = null;
                int facid = -1;
                int pid = -1;
                int spid = -1;
                DateTime shiftdate = DateTime.Now;
                string shifttime = null;
                string type = null;
                string gender = null;
                GVemployee.DataSource = tms.GetEmployeeForSms(empIDs, routeid, facid, pid, spid, shiftdate, shifttime, type, gender);
                GVemployee.DataBind();
                GridViewExportUtil.Export("Message", GVemployee);
                if (GVemployee.Rows.Count <= 0)
                {
                    lblmsg.Text = "Record not found";
                    MultiView2.ActiveViewIndex = -1;
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


    protected void checkAll_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            int rows = GVemployee.Rows.Count;
            CheckBox ckHead = ((CheckBox)GVemployee.HeaderRow.FindControl("checkAll"));
            if (ckHead.Checked == true)
            {
                for (int i = 0; i < rows; i++)
                {
                    CheckBox ck = ((CheckBox)GVemployee.Rows[i].FindControl("ckgvemployee"));
                    ck.Checked = true;
                }
            }
            else
            {
                for (int i = 0; i < rows; i++)
                {
                    CheckBox ck = ((CheckBox)GVemployee.Rows[i].FindControl("ckgvemployee"));
                    ck.Checked = false;
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

    protected void ddlFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            int facid = Convert.ToInt32(ddlFacility.SelectedValue);
            ddlProcess.Items.Clear();
            ListItem items = new ListItem("--Select--", "0");
            ddlProcess.Items.Add(items);
            ddlProcess.DataSource = tms.GetProcess(MyApplicationSession._LocationId);
            ddlProcess.DataTextField = "ProcessName";
            ddlProcess.DataValueField = "Id";
            ddlProcess.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    public string Strip(string text)
    {
        text = text.Replace("\r\n", ",");
        text = text.Replace("\n", ",");
        text = text.Replace(" ", ",");
        text = text.Replace(",,", ",");
        text = text.Replace(";", ",");
        text = text.Replace("'", ",");
        return text;
    }
    protected void btnRouteSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            newmessage();
            lblmsg.Text = "";
            MultiView2.ActiveViewIndex = 0;
            ddsms();
            string routeid = Strip(TxtrouteId.Text).Trim();
            string empIDs = null;
            int facid = -1;
            int pid = -1;
            int spid = -1;
            DateTime shiftdate = DateTime.Now;
            string shifttime = null;
            string type = null;
            string gender = null;
            GVemployee.DataSource = tms.GetEmployeeForSms(empIDs, routeid, facid, pid, spid, shiftdate, shifttime, type, gender);

            GVemployee.DataBind();
            if (GVemployee.Rows.Count <= 0)
            {
                lblmsg.Text = "Record not found";
                MultiView2.ActiveViewIndex = -1;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void ddlProcess_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            MultiView2.ActiveViewIndex = -1;
            int pid = Convert.ToInt32(ddlProcess.SelectedValue);
            ddlSubProcess.Items.Clear();
            ListItem item = new ListItem("--Select--", "0");
            ddlSubProcess.Items.Add(item);
            ddlSubProcess.DataSource = tms.GetSubProcess(pid);
            ddlSubProcess.DataTextField = "SubProcessName";
            ddlSubProcess.DataValueField = "Id";
            ddlSubProcess.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }

    }
    protected void btnprocess_Click(object sender, EventArgs e)
    {
        try
        {
            newmessage();
            lblmsg.Text = "";
            int facid = Convert.ToInt32(ddlFacility.SelectedValue);
            int pid = Convert.ToInt32(ddlProcess.SelectedValue);
            int spid = Convert.ToInt32(ddlSubProcess.SelectedValue);
            MultiView2.ActiveViewIndex = 0;
            ddsms();
            string routeid = null;
            string empIDs = null;
            DateTime shiftdate = DateTime.Now;
            string shifttime = null;
            string type = null;
            string gender = null;
            GVemployee.DataSource = tms.GetEmployeeForSms(empIDs, routeid, facid, pid, spid, shiftdate, shifttime, type, gender);
            GVemployee.DataBind();
            if (GVemployee.Rows.Count <= 0)
            {
                lblmsg.Text = "Record not found";
                MultiView2.ActiveViewIndex = -1;
            }
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
            int facid = Convert.ToInt32(ddlFacilityshift.SelectedValue.ToString());
            string type = rdoTripType.SelectedValue.ToString();
            lstShift.Items.Clear();
            ListItem list = new ListItem("-Select-", "0");
            lstShift.Items.Add(list);
            lstShift.DataSource = tms.GetShiftByFacilityType(facid, type);
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            newmessage();
            lblmsg.Text = "";
            string strShifttimes = null;
            if (lstShift.SelectedIndex >= 0)
            {
                for (int i = 0; i < lstShift.Items.Count; i++)
                {
                    if (lstShift.Items[i].Selected)
                    {
                        strShifttimes += lstShift.Items[i].Text.Trim() + ",";
                    }

                }
            }
            strShifttimes = strShifttimes.Remove(strShifttimes.Length - 1, 1);

            MultiView2.ActiveViewIndex = 0;
            ddsms();
            string routeid = null;
            string empIDs = null;
            int facid = Convert.ToInt32(ddlFacilityshift.SelectedValue);
            int pid = -1;
            int spid = -1;
            DateTime shiftdate = Convert.ToDateTime(txtStartDate.Text);

            string type = rdoTripType.SelectedValue;
            string gender = rdosextype.SelectedValue;
            GridView gv=new GridView();
          gv.DataSource   = ds.GetData( facid,  shiftdate, strShifttimes, type);

          gv.DataBind();
          gv.RowStyle.Wrap = false;
          gv.Rows[1].Cells[8].Wrap = false;
          GridViewExportUtil.Export("Messages.xls", gv);
            if (gv.Rows.Count <= 0)
            {
                lblmsg.Text = "Record not found";
                MultiView2.ActiveViewIndex = -1;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }


    protected void ddlFacilityshift_SelectedIndexChanged(object sender, EventArgs e)
    {

        try
        {
            BndShiftTimeListBx();

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void ddlMessage_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    protected void newmessage()
    {
       
        
    }

    protected void btnFinal_Click(object sender, EventArgs e)
    {
        try
        {
            int count = 0;
            int rows = GVemployee.Rows.Count;
            int f = 1;
            String empcodes;
            String empmobiles;

            for (int i = 0; i < rows; i++)
            {
                CheckBox ck = ((CheckBox)GVemployee.Rows[i].FindControl("ckgvemployee"));
                if (ck.Checked == true)
                {
                    count++;
                }
            }
            if (count == 0)
            {

                string script = "alert(\"Select at least one employee\");";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(),
                                                Guid.NewGuid().ToString(), script, true);
            }
            else
            {
                for (int i = 0; i < rows; i++)
                {
                    CheckBox ck = ((CheckBox)GVemployee.Rows[i].FindControl("ckgvemployee"));
                    if (ck.Checked == true)
                    {
                        Label lbpempcodes = ((Label)GVemployee.Rows[i].FindControl("lblempcode"));
                        Label lbpempmobiles = ((Label)GVemployee.Rows[i].FindControl("lblempmobile"));
                        empcodes = lbpempcodes.Text;
                        empmobiles = lbpempmobiles.Text;
                        tms.Addout_log(empmobiles, empcodes, "");
                        f = 1;
                    }
                }
                if (f == 1)
                {
                    lblmsg.Text = "Message sent successfully";
                    txtempid.Text = string.Empty;
                    TxtrouteId.Text = string.Empty;
                    MultiView2.ActiveViewIndex = -1;
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

}

