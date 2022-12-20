﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using RPtBillingDataSetTableAdapters;
using ReportTableAdapters;

public partial class RepArrivalShiftWise : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    SPR_PuneBillingDetailsTableAdapter ds = new SPR_PuneBillingDetailsTableAdapter();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                txtEndDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                BndFacilityDropdown();

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }

    }

    public void BndFacilityDropdown()
    {
        try
        {
            ddlFacility.Items.Clear();
            ListItem liv = new ListItem("Select Facility", "0");
            ddlFacility.Items.Add(liv);
            ddlFacility.DataSource = tmscontext.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlFacility.DataTextField = "facilityName";
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime Startdate = Convert.ToDateTime(txtStartDate.Text);
            DateTime EndDate = Convert.ToDateTime(txtEndDate.Text);
            int FacilityID = Convert.ToInt32(ddlFacility.SelectedValue);

            ReportDataSource report1DataSource = new ReportDataSource("RPtBillingDataSet_SPR_PuneBillingDetails", ds.GetData(Startdate, EndDate, FacilityID));

            ReportViewer1.LocalReport.DataSources.Clear();

            ReportViewer1.LocalReport.DataSources.Add(report1DataSource);

            ReportViewer1.Visible = true;
            ReportViewer1.LocalReport.Refresh();
        }
        catch (Exception ex) 
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
}
