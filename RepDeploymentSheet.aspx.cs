using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReportTableAdapters;

public partial class RepDeploymentSheet : basepage
{

    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    RepDeployementSheetTableAdapter ds=new RepDeployementSheetTableAdapter();
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
       
        GridView1.DataSource = ds.GetData(Convert.ToDateTime(Startdate), Convert.ToInt32(FacilityID));
        GridView1.DataBind();
        if (GridView1.Rows.Count > 2)
        {
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                for (int j = 1; j < GridView1.Rows[i].Cells.Count - 1; j++)
                {
                    if (GridView1.Rows[i].Cells[j].Text == "0")
                    {
                        GridView1.Rows[i].Cells[j].Text = "";
                    }
                    else
                    {
                        if (GridView1.Rows[i].Cells[j].Text.ToString().IndexOf("P")>= 0)
                        {
                            GridView1.Rows[i].Cells[j].BackColor = System.Drawing.Color.Aqua;
                        }
                        else
                        {
                            if (GridView1.Rows[i].Cells[j].Text.ToString().IndexOf("D") >=0)
                            {
                                GridView1.Rows[i].Cells[j].BackColor = System.Drawing.Color.BurlyWood;
                            }
                        }
                    }
                   
                    }
                }

         
                for (int j = 1; j < GridView1.HeaderRow.Cells.Count - 1; j++)
                {
                    if (GridView1.HeaderRow.Cells[j].Text == "0")
                    {
                        GridView1.HeaderRow.Cells[j].Text = "";
                    }
                    else
                    {
                        if (GridView1.HeaderRow.Cells[j].Text.ToString().IndexOf("P") >= 0)
                        {
                            GridView1.HeaderRow.Cells[j].BackColor = System.Drawing.Color.Aqua;
                        }
                        else
                        {
                            if (GridView1.HeaderRow.Cells[j].Text.ToString().IndexOf("D") >= 0)
                            {
                                GridView1.HeaderRow.Cells[j].BackColor = System.Drawing.Color.BurlyWood;
                            }
                        }
                    }

                }
            
        

        
          
            GridView1.Caption = "Deployment Sheet For: " + Startdate;
            GridViewExportUtil.Export("Deployment Sheet.XLS", GridView1);
        }
        else
        {

        }
    }
}
