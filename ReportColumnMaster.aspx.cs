using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ReportColumnMaster : basepage
{
    DataClasses1DataContext tmsdataclass = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Visible = false;
        if (!IsPostBack)
        {
            BndRdbList();
            btnSave.Visible = false;
        }
    }
    public int _reportId
    {
        get
        {
            return (int)ViewState["_reportId"];
        }
        set
        {
            ViewState["_reportId"] = value;
        }
    }
    public void BndColumnGrid()
    {
        try
        {
            gvColumns.DataSource = tmsdataclass.GetReportColumnAll(_reportId);
            gvColumns.DataBind();
            if (gvColumns.Rows.Count > 0)
                btnSave.Visible =true ;
            else
                btnSave.Visible = false;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    public void BndRdbList()
    {
        try
        {
            rdbListReport.DataSource = tmsdataclass.GetReportNames();
            rdbListReport.DataBind();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void gvColumns_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvColumns.PageIndex = e.NewPageIndex;
        BndColumnGrid();
    }
    protected void gvColumns_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvColumns.EditIndex = -1;
        BndColumnGrid();
    }
    protected void rdbListReport_SelectedIndexChanged(object sender, EventArgs e)
    {
        _reportId =Convert.ToInt32(rdbListReport.SelectedValue); 
        BndColumnGrid();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            for (int i = 0; i < gvColumns.Rows.Count; i++)
            {
                int userRightValue = 0;
                CheckBox chkN = (CheckBox)gvColumns.Rows[i].FindControl("rdbNormal");
                CheckBox chkM = (CheckBox)gvColumns.Rows[i].FindControl("rdbMandatory");
                CheckBox chkR = (CheckBox)gvColumns.Rows[i].FindControl("rdbRestricted");
                if (chkN.Checked == true) userRightValue = 0;
                if (chkM.Checked == true) userRightValue = 1;
                if (chkR.Checked == true) userRightValue = 2;
                int id = Convert.ToInt32(gvColumns.DataKeys[i]["Id"].ToString());
                tmsdataclass.UpdateReportColumnRights(id, userRightValue);
            }
            BndColumnGrid();
            lblMsg.Visible = true;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }

    }
    protected void gvColumns_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        gvColumns.PageIndex = e.NewPageIndex;
        BndColumnGrid();
    }
}
