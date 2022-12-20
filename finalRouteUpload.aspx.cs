using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Data;
using System.Text.RegularExpressions;
public partial class finalRouteUpload : basepage
{
    public string _StrFileName
    {
        get
        {
            return (string)ViewState["_StrFileName"];
        }

        set
        {
            ViewState["_StrFileName"] = value;
        }
    }
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DlFac.Items.Clear();
            ListItem li = new ListItem("Select", "0");
            DlFac.Items.Add(li);
            DlFac.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            DlFac.DataTextField = "FacilityName";
            DlFac.DataValueField = "id";
            DlFac.DataBind();
        }

    }
    protected void btnUpload_Click(object sender, EventArgs e)
    {
        OleDbConnection objConn = null;
        System.Data.DataTable dt = null;
        string _StrFileName = FileUpload1.PostedFile.FileName.Substring(FileUpload1.PostedFile.FileName.LastIndexOf("\\") + 1);
        FileUpload1.PostedFile.SaveAs(Server.MapPath("RouteFile/" + _StrFileName));

        string excelFile = Server.MapPath("RouteFile/" + _StrFileName);

        String connString = "Provider=Microsoft.Jet.OLEDB.4.0;" +
      "Data Source=" + excelFile + ";Extended Properties=Excel 8.0;";
        objConn = new OleDbConnection(connString);
        objConn.Open();
        dt = objConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

        if (dt == null)
        {

        }

        String[] excelSheets = new String[dt.Rows.Count];
        int i = 0;

        // Add the sheet name to the string array.

        foreach (DataRow row in dt.Rows)
        {
            excelSheets[i] = row["TABLE_NAME"].ToString();
            i++;
        }
        string SheetName;
        string strComand;
        if (excelSheets[0].IndexOf("|") > 0)
        {

            SheetName = excelSheets[0].Substring(0, excelSheets[0].IndexOf("|"));
            //   Range = excelSheets[0].Substring(excelSheets[0].IndexOf("|") + 1);
            strComand = "select * from [" + SheetName + "]";
        }
        else
        {
            strComand = "select * from [" + excelSheets[0] + "]";
        }

        OleDbDataAdapter daAdapter = new OleDbDataAdapter(strComand, objConn);
        DataTable dts = new DataTable(excelSheets[0]);
        daAdapter.FillSchema(dts, SchemaType.Source);
        daAdapter.Fill(dts);
        objConn.Close();
        grdShowDetails.Visible = true;
        grdShowDetails.DataSource = dts;
        grdShowDetails.DataBind();
        DataSet ds = new DataSet();
        ds.Tables.Add(dts);
        int Vres = regularexpressionValidation(grdShowDetails);
        if (Vres == 0)
        {
            lblErrorMsg.Text = "Some Data is not in valid Format Please Check ";
            lblErrorMsg.ForeColor = System.Drawing.Color.Red;
        }
        else
        {
            int Rres = ShiftShiftdateRequired(grdShowDetails);

            if (Rres == 0)
            {
                lblErrorMsg.Text = "Some required  Data is not available Please Check ";
                lblErrorMsg.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                int eres = ValidateEmployee(grdShowDetails);
                if (eres == 0)
                {
                    lblErrorMsg.Text = "Some Employees  are attrited or Tranport not Required Please Check ";
                    lblErrorMsg.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    int dres = DifferenShiftGroupValidate(grdShowDetails);
                    if (dres == 1)
                    {
                        lblErrorMsg.Text = "Different Shifts are occuring in one Route  Please Check ";
                        lblErrorMsg.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        if (checkRouteDuplicacy(grdShowDetails) == 0)
                        {

                            lblErrorMsg.Text = "Duplicate Employees in the same shift  Please Check ";
                            lblErrorMsg.ForeColor = System.Drawing.Color.Red;
                        }
                        else
                        {

                            string xm = ds.GetXml();
                            string res = tms.UploadRouteFinal(xm, Convert.ToInt32(DlFac.SelectedValue)).ElementAtOrDefault(0).result.ToString();


                            ShowMessage(res);
                        }

                    }
                }
            }
        }
        
    }
    protected int DifferenShiftGroupValidate(GridView GvRoute)
    {
        int f = 0;
        int rowcount = GvRoute.Rows.Count;
        int cellcount = GvRoute.HeaderRow.Cells.Count;
        for (int i = 0; i < cellcount; i++)
        {
            if (GvRoute.HeaderRow.Cells[i].Text.ToUpper() == "SHIFT")
            {
                for (int j = 0; j < rowcount; j++)
                {
                    if (GvRoute.Rows[j].Cells[i].Text != "&nbsp;")
                    {
                        int k = j;
                        string FShift = GvRoute.Rows[k].Cells[i].Text;
                        while (GvRoute.Rows[k].Cells[i].Text != "&nbsp;")
                        {
                            if (GvRoute.Rows[k].Cells[i].Text != FShift)
                            {
                                GvRoute.Rows[k].Cells[i].BackColor = System.Drawing.Color.Red;
                                f = 1;
                                goto Breaks;
                            }
                            else
                            {

                                k++;
                                if (k >= rowcount)
                                {
                                    break;
                                }
                            }
                        }
                        j = k - 1;

                    }

                }
            }
        }
    Breaks: return f;
    }
    protected int ValidateEmployee(GridView GvRoute)
    {
        int f = 1;
        int rowcount = GvRoute.Rows.Count;
        int cellcount = GvRoute.HeaderRow.Cells.Count;
        for (int i = 0; i < cellcount; i++)
        {
            if (GvRoute.HeaderRow.Cells[i].Text.ToUpper() == "EMPLOYEEID")
            {
                for (int j = 0; j < rowcount; j++)
                {
                    if (GvRoute.Rows[j].Cells[i].Text != "&nbsp;")
                    {
                        int id = Convert.ToInt32(GvRoute.Rows[j].Cells[i].Text);
                        string res = tms.ValidateEmployee(id).ElementAtOrDefault(0).Result.Value.ToString();
                        int r = Convert.ToInt32(res);
                        if (r == 0)
                        {
                            GvRoute.Rows[j].Cells[i].BackColor = System.Drawing.Color.Red;
                            f = 0;
                        }

                    }

                }
            }
        }
        return f;
    }

    protected int regularexpressionValidation(GridView GvRoute)
    {
        int f = 1;
        Regex regdatetime = new Regex("^((0[1-9]|1[0-2])/(0[1-9]|[1-2][0-9]|3[0-1])/([1-2][0-9][0-9][0-9]))(([0-9]|[0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9][A,P][M])$");
        Regex regShift = new Regex("^^(20|21|22|23|[01]\\d|\\d)(([0-5]\\d){1,2})$$");
        int rowcount = GvRoute.Rows.Count;
        int cellcount = GvRoute.HeaderRow.Cells.Count;
        for (int i = 0; i < cellcount; i++)
        {
            if (GvRoute.HeaderRow.Cells[i].Text.ToUpper() == "SHIFTDATE")
            {
                for (int j = 0; j < rowcount; j++)
                {
                    if (GvRoute.Rows[j].Cells[i].Text != "&nbsp;")
                    {
                        string dates = GvRoute.Rows[j].Cells[i].Text.ToString().Replace(" ", "");
                        if (!regdatetime.IsMatch(dates))
                        {
                            GvRoute.Rows[j].Cells[i].BackColor = System.Drawing.Color.Red;

                            f = 0;
                        }
                    }
                }
            }
            if (GvRoute.HeaderRow.Cells[i].Text.ToUpper() == "ETA")
            {
                for (int j = 0; j < rowcount; j++)
                {
                    if (GvRoute.Rows[j].Cells[i].Text != "&nbsp;")
                    {
                        string dates = GvRoute.Rows[j].Cells[i].Text.ToString().Replace(" ", "");
                        if (!regdatetime.IsMatch(dates))
                        {
                            GvRoute.Rows[j].Cells[i].BackColor = System.Drawing.Color.Red;

                            f = 0;
                        }
                    }
                }
            }
            if (GvRoute.HeaderRow.Cells[i].Text.ToUpper() == "SHIFT")
            {
                for (int j = 0; j < rowcount; j++)
                {
                    if (GvRoute.Rows[j].Cells[i].Text != "&nbsp;")
                    {
                        //   string dates = GvRoute.Rows[j].Cells[i].Text.ToString().Replace(" ", "");
                        if (!regShift.IsMatch(GvRoute.Rows[j].Cells[i].Text))
                        {
                            GvRoute.Rows[j].Cells[i].BackColor = System.Drawing.Color.Red;

                            f = 0;
                        }
                    }
                }
            }
        }
        return f;
    }

    protected int ShiftShiftdateRequired(GridView GvRoute)
    {
        int f = 1;
        Regex regdatetime = new Regex("^((0[1-9]|1[0-2])/(0[1-9]|[1-2][0-9]|3[0-1])/([1-2][0-9][0-9][0-9]))(([0-9]|[0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9][A,P][M])$");
        Regex regShift = new Regex("^^(20|21|22|23|[01]\\d|\\d)(([0-5]\\d){1,2})$$");
        int rowcount = GvRoute.Rows.Count;
        int shiftCol = 0;
        int EmployeeCol = 0;
        int cellcount = GvRoute.HeaderRow.Cells.Count;
        int c = 0;

        for (c = 0; c < cellcount; c++)
        {
            if (GvRoute.HeaderRow.Cells[c].Text.ToUpper() == "SHIFTDATE")
            {
                shiftCol = c;

            }
            if (GvRoute.HeaderRow.Cells[c].Text.ToUpper() == "EMPLOYEEID")
            {
                EmployeeCol = c;

            }
        }
        for (int i = 0; i < cellcount; i++)
        {
            if (GvRoute.HeaderRow.Cells[i].Text.ToUpper() == "SHIFT")
            {
                for (int j = 0; j < rowcount; j++)
                {
                    if (GvRoute.Rows[j].Cells[i].Text != "&nbsp;" && GvRoute.Rows[j].Cells[shiftCol].Text != "&nbsp;" && GvRoute.Rows[j].Cells[EmployeeCol].Text != "&nbsp;")
                    {

                    }
                    else
                    {
                        if (GvRoute.Rows[j].Cells[i].Text == "&nbsp;" && GvRoute.Rows[j].Cells[shiftCol].Text == "&nbsp;" && GvRoute.Rows[j].Cells[EmployeeCol].Text == "&nbsp;")
                        {
                        }
                        else
                        {

                            f = 0;
                            GvRoute.Rows[j].Cells[i].BackColor = System.Drawing.Color.Red;
                            GvRoute.Rows[j].Cells[shiftCol].BackColor=System.Drawing.Color.Red;
                            GvRoute.Rows[j].Cells[EmployeeCol].BackColor = System.Drawing.Color.Red;
                        }
                    }

                }

            }
        }
        return f;
    }

    private void ShowMessage(string message)
    {
        try
        {
            string jScript = "alert('" + message + "');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);


        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected int checkRouteDuplicacy(GridView GvRoute)
    {
     int f = 1;
         int rowcount = GvRoute.Rows.Count;
        int shiftCol = 0;
        int EmployeeCol = 0;
        int cellcount = GvRoute.HeaderRow.Cells.Count;
        int c = 0;
        string shift = null;
        int i=0;
        int k=0;
        for (c = 0; c < cellcount; c++)
        {
            if (GvRoute.HeaderRow.Cells[c].Text.ToUpper() == "SHIFT")
            {
                shiftCol = c;

            }
            if (GvRoute.HeaderRow.Cells[c].Text.ToUpper() == "EMPLOYEEID")
            {
                EmployeeCol = c;

            }
        }
       int rcount=0;
       while (rcount<rowcount)
       {
           for (k = i; k < rowcount; k++)
           {
               shift = GvRoute.Rows[i].Cells[shiftCol].Text;
               rcount++;
               if (GvRoute.Rows[k].Cells[shiftCol].Text != shift && GvRoute.Rows[k].Cells[shiftCol].Text != "&nbsp;")
               {
                   
                   break;
               }

           }
           for (int s = i; s < k - 1; s++)
           {
               string id = GvRoute.Rows[s].Cells[EmployeeCol].Text;
               for (int t = s + 1; t < k; t++)
               {
                   if (GvRoute.Rows[t].Cells[EmployeeCol].Text == id && GvRoute.Rows[t].Cells[EmployeeCol].Text != "&nbsp;")
                   {
                       GvRoute.Rows[t].Cells[EmployeeCol].BackColor = System.Drawing.Color.Red;
                       GvRoute.Rows[s].Cells[EmployeeCol].BackColor = System.Drawing.Color.Red;
                       f = 0;
                       goto breaks;
                   }

               }
           }

           i = k;
       }
    breaks: return f;
    }
    
}
