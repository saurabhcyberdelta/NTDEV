using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using RepAttritationDataSetTableAdapters;

public partial class TotalVendorBilling : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    RepDriverAttritedTableAdapter ds = new RepDriverAttritedTableAdapter();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                BndDropdown();
                //BndFacilityDropdown();
                LkbExportExl.Visible = false;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    public void BndDropdown()
    {
        try
        {
            ddlMonth.Items.Clear();
            for (int i = 1; i <= 12; i++)
            {
                ListItem lim = new ListItem(i.ToString(), i.ToString());
                ddlMonth.Items.Add(lim);
            }
            ddlYear.Items.Clear();
            int years = DateTime.Now.Year;


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
        try
        {
            int month = Convert.ToInt32(ddlMonth.SelectedValue);
            int year = Convert.ToInt32(ddlYear.SelectedValue);

            grdFinalBilling.DataSource = tms.SPR_TotalVendorCost(month, year);
            grdFinalBilling.DataBind();

            int res = Convert.ToInt32(tms.ISCostLock(month, year, 0,Convert.ToDateTime(DateTime.Now), 1).ElementAtOrDefault(0).result);

            if (grdFinalBilling.Rows.Count>0)
            {
                LkbExportExl.Visible = true;
                if (MyApplicationSession._ISAdmin==true)
                {
                    BtnLock.Visible = true;
                    if (res == 1)
                    {
                        BtnLock.Text = "Unlock Cost";
                    }
                    else
                    {
                        BtnLock.Text = "Lock Cost";
                    }
                }
            }
            
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "catch error");
            throw ex;
        }
        
    }
    protected void LkbExportExl_Click(object sender, EventArgs e)
    {
        try
        {

            int month = Convert.ToInt32(ddlMonth.SelectedValue);
            int year = Convert.ToInt32(ddlYear.SelectedValue);

            grdFinalBilling.AllowPaging = false; 
            grdFinalBilling.DataSource = tms.SPR_TotalVendorCost(month, year);
            grdFinalBilling.DataBind();
            GridViewExportUtil.Export("FinalVendorBilling"+DateTime.UtcNow.Millisecond+".xls", grdFinalBilling);
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "catch error");
            throw ex;
        }
    }
    protected void BtnLock_Click(object sender, EventArgs e)
    {
        try
        {
            //Changes for 
            int month = Convert.ToInt32(ddlMonth.SelectedValue);
            int year = Convert.ToInt32(ddlYear.SelectedValue);
            
            tms.CostLock(month, year, 0, Convert.ToDateTime(DateTime.Now), MyApplicationSession._UserID);
            if (BtnLock.Text=="Lock Cost")
            {
                lblErrorMsg.Text = "Cost is locked for this month.";
                BtnLock.Text = "Unlock Cost";
            }
            else
            {
                lblErrorMsg.Text = "Cost is Unlocked for this month.";
                BtnLock.Text = "Lock Cost";
            }
            
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "catch error");
            throw ex;
        }
    }
}
