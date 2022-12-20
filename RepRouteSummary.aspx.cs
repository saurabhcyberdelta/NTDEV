using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReportTableAdapters;

public partial class RepRouteSummary : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    RptRouteSummaryTableAdapter ds = new RptRouteSummaryTableAdapter();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                
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
        string Startdate = txtStartDate.Text;
       
        string FacilityID = ddlFacility.SelectedValue;
        string triptype = rdbtnTripType.SelectedValue;
        GridView1.DataSource = ds.GetData(Convert.ToDateTime(Startdate), Convert.ToInt32(FacilityID), triptype);
        GridView1.DataBind();
       
        for (int i = 1; i < GridView1.Rows[0].Cells.Count; i++)
        {
            int sum = 0;
            for (int j = 0; j < GridView1.Rows.Count; j++)
            {
                if (GridView1.Rows[j].Cells[i].Text != "")
                {
                    sum = sum + Convert.ToInt32(GridView1.Rows[j].Cells[i].Text);
                }
            }
            GridView1.Rows[GridView1.Rows.Count - 1].Cells[i].Text = sum.ToString();
        }
        GridView1.Rows[GridView1.Rows.Count - 1].Cells[0].Text = "Total";

        //  GridView1.FooterRow.Cells[0].Text = "Sajal";
        GridView1.HeaderRow.BackColor = System.Drawing.Color.Green;
        GridView1.HeaderRow.ForeColor = System.Drawing.Color.White;
        GridView1.HeaderRow.Font.Bold = true;
        GridView1.Rows[GridView1.Rows.Count - 1].BackColor = System.Drawing.Color.Green;
        GridView1.Rows[GridView1.Rows.Count - 1].ForeColor = System.Drawing.Color.White;
        GridView1.Rows[GridView1.Rows.Count - 1].Font.Bold = true;
       
        GridView1.Caption = "Route Summary For" + Startdate;

        GridViewExportUtil.Export("RouteSummary.XLS", GridView1);

    }
}
