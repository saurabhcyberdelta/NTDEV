using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
public partial class SpocAdhoc : basepage
{
    DataClasses1DataContext context = new DataClasses1DataContext();
    public int _SpocID
    {
        get
        {
            return (int)ViewState["_SpocID"];
        }

        set
        {
            ViewState["_SpocID"] = value;
        }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                _SpocID = MyApplicationSession._UserID;                
                txtCalendar.Text = System.DateTime.Now.Date.ToString("MM/dd/yyyy");
                MultiView1.ActiveViewIndex = 0;
                bindgrdEmployeeSchedule();                
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }

    }
    protected void txtCalendar_TextChanged(object sender, EventArgs e)
    {

        bindgrdEmployeeSchedule();
    }

    protected void bindgrdEmployeeSchedule()
    {
        //**********************************************************************************
        // Get the List of employees of Selected facility and selected Process of Login SPOC
        // Set the value of Gridview Headers to DaysOfWeeks like Mon, Tues..etc
        //**********************************************************************************
        try
        {
            lblErrorMsg.Text = string.Empty;
            lblErrorMsg.Visible = false;
            txt_PageSize.Text = grdEmployeeSchedule.PageSize.ToString();
            DateTime sDate = new DateTime();
            if (Regex.IsMatch(txtCalendar.Text, @"^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"))
            {
                sDate = Convert.ToDateTime(txtCalendar.Text);
                grdEmployeeSchedule.DataSource = context.GetSpocAdhoc(MyApplicationSession._UserID, sDate);
                grdEmployeeSchedule.Columns[3].HeaderText = sDate.AddDays(0).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(0).Day.ToString() + "-" + sDate.AddDays(0).ToString("MMM");
                grdEmployeeSchedule.Columns[4].HeaderText = sDate.AddDays(1).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(1).Day.ToString() + "-" + sDate.AddDays(1).ToString("MMM");
                grdEmployeeSchedule.Columns[5].HeaderText = sDate.AddDays(2).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(2).Day.ToString() + "-" + sDate.AddDays(2).ToString("MMM");
                grdEmployeeSchedule.Columns[6].HeaderText = sDate.AddDays(3).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(3).Day.ToString() + "-" + sDate.AddDays(3).ToString("MMM");
                grdEmployeeSchedule.Columns[7].HeaderText = sDate.AddDays(4).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(4).Day.ToString() + "-" + sDate.AddDays(4).ToString("MMM");
                grdEmployeeSchedule.Columns[8].HeaderText = sDate.AddDays(5).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(5).Day.ToString() + "-" + sDate.AddDays(5).ToString("MMM");
                grdEmployeeSchedule.Columns[9].HeaderText = sDate.AddDays(6).DayOfWeek.ToString().Substring(0, 3) + "<br/>" + sDate.AddDays(6).Day.ToString() + "-" + sDate.AddDays(6).ToString("MMM");
                grdEmployeeSchedule.DataBind();
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }
    }
    protected void txt_PageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        //******************************************************************************
        // Set the pageSize of Selected grid if the records are greater then 10
        //******************************************************************************
        try
        {
            if ((txt_PageSize.Text != string.Empty) && (Regex.IsMatch(txt_PageSize.Text, @"^([\d])*$")))
            {
                if (Convert.ToInt32(txt_PageSize.Text) >= 10)
                {
                    grdEmployeeSchedule.PageSize = Convert.ToInt32(txt_PageSize.Text);
                    bindgrdEmployeeSchedule();
                }
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }

    }
    protected void lnkBtnShift_Click(object sender, EventArgs e)
    {    
        try
        {
            LinkButton btn = (LinkButton)sender;


            GridViewRow gvr = (GridViewRow)btn.NamingContainer;


            int rowindex = gvr.RowIndex;
            int spoc = Convert.ToInt32(grdEmployeeSchedule.DataKeys[rowindex].Value.ToString());
            GrdEmployeePending.DataSource = context.SelectEmpAdhocRequest(spoc, Convert.ToDateTime(((LinkButton)sender).CommandArgument), Convert.ToDateTime(((LinkButton)sender).CommandArgument), "Pending");
            GrdEmployeePending.DataBind();
            GrdEmployeeAccepted.DataSource = context.SelectEmpAdhocRequest(spoc, Convert.ToDateTime(((LinkButton)sender).CommandArgument), Convert.ToDateTime(((LinkButton)sender).CommandArgument), "Approved");
            GrdEmployeeAccepted.DataBind();
            GrdEmployeeRejected.DataSource = context.SelectEmpAdhocRequest(spoc, Convert.ToDateTime(((LinkButton)sender).CommandArgument), Convert.ToDateTime(((LinkButton)sender).CommandArgument), "Rejected");
            GrdEmployeeRejected.DataBind();
         
            ModalPopupExtender.Show();
            AJX.Visible = true;
           
        }
        catch (Exception ex)
        {
            lblErrorMsg.Text = ex.Message;
        }


    }

    protected DateTime GetShiftdate(int addDays)
    {
        return Convert.ToDateTime(txtCalendar.Text).AddDays(addDays);
    }
    protected Boolean GetEnableOrNot(int addDays)
    {
        Boolean flag;
        if (Convert.ToDateTime(txtCalendar.Text).AddDays(addDays) < DateTime.Now.Date.AddDays(-1))
        {
            flag = false;
        }
        else
        {
            flag = true;
        }
        return flag;
    }
    protected void grdEmployeeSchedule_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //********************************************************
        // view the current page of grid to selected page index
        //********************************************************
        try
        {
            // bindgrdEmployeeSchedule();
            grdEmployeeSchedule.PageIndex = e.NewPageIndex;
            bindgrdEmployeeSchedule();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        ModalPopupExtender.Hide();
    }
   
}
