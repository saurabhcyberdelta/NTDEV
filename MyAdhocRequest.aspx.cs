using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MyAdhocRequest : basepage
{
    DataClasses1DataContext Adhoc = new DataClasses1DataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int empid = MyApplicationSession._UserID;
            txtDateFrom.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
            txtDateTo.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
            DateTime sDate = DateTime.Now.Date;
            DateTime eDate = DateTime.Now.Date;
            BndEmpAdhoc(empid, sDate, eDate);
        }
    }

    protected void BndEmpAdhoc(int empId, DateTime sDate, DateTime eDate)
    {
        try
        {

            GVAdhoc.DataSource = Adhoc.SelectEmpAdhocRequest(empId, sDate, eDate,"All");
            GVAdhoc.DataBind();
            
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int empid = MyApplicationSession._UserID;
            DateTime sDate = Convert.ToDateTime(txtDateFrom.Text).Date;
            DateTime eDate = Convert.ToDateTime(txtDateTo.Text).Date;
            BndEmpAdhoc(empid, sDate, eDate);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
}
