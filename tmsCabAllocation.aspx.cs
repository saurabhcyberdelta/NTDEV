using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReportTableAdapters;

public partial class tmsCabAllocation : basepage
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    ReportTMSCabPivotTableAdapter ds = new ReportTMSCabPivotTableAdapter();
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
      //  string triptype = rdbtnTripType.SelectedValue;
        GridView1.DataSource = ds.GetData(Convert.ToDateTime(Startdate), Convert.ToInt32(FacilityID));
        GridView1.DataBind();
        for (int i = 1; i < GridView1.Rows.Count; i++)
        {
            for (int j = 1; j < GridView1.Rows[i].Cells.Count - 1; j++)
            {
                if (GridView1.Rows[i].Cells[j].Text == "0")
                {
                    GridView1.Rows[i].Cells[j].Text = "";
                }
                else
                {
                    if (Convert.ToInt32(GridView1.Rows[i].Cells[j].Text) > 1)
                    {
                        GridView1.Rows[i].Cells[j].BackColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        int k = 0, l = 0, f = 0, s = 0;
                        if (j + 1 <= GridView1.Rows[i].Cells.Count - 2)
                        {
                            k = j + 1;
                            f = 1;
                        }
                        if (j + 2 <= GridView1.Rows[i].Cells.Count - 2)
                        {
                            l = j + 2;
                            s = 1;
                        }
                        if (f == 1)
                        {

                            if (Convert.ToInt32(GridView1.Rows[i].Cells[k].Text) >= 1)
                            {
                                GridView1.Rows[i].Cells[j].BackColor = System.Drawing.Color.Yellow;
                                GridView1.Rows[i].Cells[k].BackColor = System.Drawing.Color.Yellow;
                                // GridView1.Rows[i].Cells[l].BackColor = System.Drawing.Color.Yellow;
                            }
                        }
                        if (s == 1)
                        {

                            if (Convert.ToInt32(GridView1.Rows[i].Cells[l].Text) >= 1)
                            {
                                GridView1.Rows[i].Cells[j].BackColor = System.Drawing.Color.Yellow;
                                GridView1.Rows[i].Cells[k].BackColor = System.Drawing.Color.Yellow;
                                GridView1.Rows[i].Cells[l].BackColor = System.Drawing.Color.Yellow;
                            }
                        }
                    }
                }
            }
        }
        GridView1.Caption = "Cab Pivot Summary For: " + Startdate;
        GridViewExportUtil.Export("CabPivot.XLS", GridView1);

    }
}
