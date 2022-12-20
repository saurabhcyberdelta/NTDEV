using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using System.Xml.Schema;
using System.Text.RegularExpressions;
using System.IO;
using System.Text;
using System.Web.UI.HtmlControls;

public partial class ScheduleUpload : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    StringBuilder sbAccess = new StringBuilder();
    public int errorcount
    {
        get
        {
            return (int)ViewState["_errorcount"];
        }

        set
        {
            ViewState["_errorcount"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblMsg.Visible = false;
            BoundField boundField = new BoundField();
            boundField.DataField = "";
            boundField.HeaderText = "Remark";
            boundField.HtmlEncode = false;
            boundField.DataFormatString = "{0:d}";
            grdxlsdata.Columns.Add(boundField);
            errorcount = 0;
        }
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
    protected void btnVerify_Click(object sender, EventArgs e)
    {
        if ((FileUpload1.FileName) != "")
        {
            if (this.FileUpload1.FileName.EndsWith(".csv"))
            {
                string _strFileName = FileUpload1.PostedFile.FileName.Substring(FileUpload1.PostedFile.FileName.LastIndexOf("\\") + 1);
                FileUpload1.PostedFile.SaveAs(Server.MapPath("CSVFile/" + _strFileName));

                string filename = Server.MapPath("CSVFile/" + _strFileName);
                if (File.Exists(filename))
                {
                    FileInfo file = new FileInfo(filename);
                    string ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + file.Directory + ";Extended Properties='text;HDR=Yes;FMT=Delimited(,)';";
                    OleDbConnection con = new OleDbConnection(ConnectionString);
                    OleDbCommand cmd = new OleDbCommand(string.Format("SELECT * FROM [" + file.Name + "]", file.Name), con);
                    try
                    {
                        con.Open();
                        OleDbDataAdapter oda = new OleDbDataAdapter(cmd);
                        DataTable dt = new DataTable("CSVTable");
                        oda.Fill(dt);
                        grdxlsdata.DataSource = dt;
                        grdxlsdata.DataBind();
                        con.Close();
                        DataSet ds = new DataSet();
                        if (errorcount > 0)
                        {
                            ShowMessage("Error in Verifying the File.\n Please be insure Data should not contain Special Charecter Like(.$&^@!~`#)");
                            lblMsg.Visible = true;
                            lblMsg.Text = "Error in Verifying the File. Please be insure Data should not contain Special Charecter Like(.$&^@!~`#)";
                            btnUploadSchedule.Enabled = false;

                        }
                        else
                        {
                            btnUploadSchedule.Enabled = true;
                            //ds.Tables.Add(dt);                            
                            //string xml = ds.GetXml();
                            //tms.ScheduleUploadExcel(xml, MyApplicationSession._UserID);

                        }
                        lblMsg.Text = "";
                        //CheckDataGridValue();
                    }
                    catch (Exception ex)
                    {
                        lblMsg.Text = ex.Message;
                    }
                }
            }
            else
            {
                lblMsg.Text = "Please Select CSV File";
            }

        }
        else
        {
            this.lblMsg.Text = "Please Select CSV File";
        }
        MultiView1.ActiveViewIndex = 0;
    }
    protected void btnUploadSchedule_Click(object sender, EventArgs e)
    {
        sbAccess.Append("<root>");

        foreach (GridViewRow gvr in grdxlsdata.Rows)
        {
            sbAccess.AppendFormat("<Employee><employeeID>{0}</employeeID><LoginDate>{1}</LoginDate><LoginTime>{2}</LoginTime><LoginFacility>{3}</LoginFacility><LogoutTime>{4}</LogoutTime><LogoutFacility>{5}</LogoutFacility></Employee>", gvr.Cells[1].Text, gvr.Cells[2].Text, gvr.Cells[3].Text, gvr.Cells[4].Text, gvr.Cells[5].Text, gvr.Cells[6].Text);
        }

        sbAccess.Append("</root>");

        var result = tms.ScheduleUploadExcel(sbAccess.ToString(), MyApplicationSession._UserID, MyApplicationSession._FacilityID);
        grdFinalOutPut.DataSource = result;
        grdFinalOutPut.DataBind();
        MultiView1.ActiveViewIndex = 1;
    }
    protected void grdxlsdata_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        int f = 1;
        string errorMsg = "Verifying the File successfully";

        Regex regVarChar = new Regex("^[0-9a-zA-Z-]+$");
        Regex regCharNull = new Regex("^[0-9a-zA-Z''&nbsp;]+$");
        Regex RegDate = new Regex("^([1-9]|1[012])[//.](0[1-9]|[1][0-9]|3[01])[//.]([1|2][0-9][0-9][0-9])$");
        Regex RegTime = new Regex("^(([0-1]?[0-9])|([2][0-3])):([0-5]?[0-9])$");
        Regex regShift = new Regex(@"^(20|21|22|23|[01]\d)(([0-5]\d){1,2})$");
        Regex RegNumeric = new Regex("^[0-9]+$");
        //Regex regdatetime = new Regex("^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\\d{3})? ?((([0-1]?\\d)|(2[0-3])):[0-5]\\d)?(:[0-5]\\d)? ?([AM|am|PM|pm])?$");
        Regex regDateTime = new Regex("^(((((0[13578])|([13578])|(1[02]))[\\-\\/\\s]?((0[1-9])|([1-9])|([1-2][0-9])|(3[01])))|((([469])|(11))[\\-\\/\\s]?((0[1-9])|([1-9])|([1-2][0-9])|(30)))|((02|2)[\\-\\/\\s]?((0[1-9])|([1-9])|([1-2][0-9]))))[\\-\\/\\s]?\\d{4})(\\s(((0[1-9])|([1-9])|(1[0-2]))\\:([0-5][0-9])((\\s)|(\\:([0-5][0-9])\\s))([AM|PM|am|pm]{2,2})))?$");
        if (e.Row.RowType == DataControlRowType.Header)
        {
            if (e.Row.Cells[1].Text.ToUpper() != "EMPLOYEEID")
            {
                e.Row.Cells[1].BackColor = System.Drawing.Color.Red;
                f = 0;
                errorcount++;
            }
            if (e.Row.Cells[2].Text.ToUpper() != "LOGINDATE")
            {
                e.Row.Cells[2].BackColor = System.Drawing.Color.Red;
                f = 0;
                errorcount++;
            }
            if (e.Row.Cells[3].Text.ToUpper() != "LOGINTIME")
            {
                e.Row.Cells[3].BackColor = System.Drawing.Color.Red;
                f = 0;
                errorcount++;
            }
            if (e.Row.Cells[4].Text.ToUpper() != "LOGINFACILITY")
            {
                e.Row.Cells[4].BackColor = System.Drawing.Color.Red;
                f = 0;
                errorcount++;
            }
            if (e.Row.Cells[5].Text.ToUpper() != "LOGOUTTIME")
            {
                e.Row.Cells[5].BackColor = System.Drawing.Color.Red;
                f = 0;
                errorcount++;
            }
            if (e.Row.Cells[6].Text.ToUpper() != "LOGOUTFACILITY")
            {
                e.Row.Cells[6].BackColor = System.Drawing.Color.Red;
                f = 0;
                errorcount++;
            }
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (!regVarChar.IsMatch(e.Row.Cells[1].Text))
            {
                e.Row.Cells[1].BackColor = System.Drawing.Color.Red;
                f = 0;
                errorcount++;
                errorMsg = "EmployeeID should not contain Special Charecter Like(.$&^@!~`#)";
                e.Row.Cells[0].Text = e.Row.Cells[0].Text = errorMsg;

            }
            if (!regDateTime.IsMatch(e.Row.Cells[2].Text))
            {
                e.Row.Cells[2].BackColor = System.Drawing.Color.Red;
                f = 0;
                errorcount++;
                errorMsg = "Login Date should be in date n time.";
                e.Row.Cells[0].Text = errorMsg;
            }
            char pad = '0';
            if (!regShift.IsMatch(e.Row.Cells[3].Text.PadLeft(4, pad).ToString()))
            {
                f = 0;
                errorcount++;
                e.Row.Cells[3].BackColor = System.Drawing.Color.Red;
                errorMsg = "The Login Time time must be with in 0000 hrs to 2359 hrs.";
                e.Row.Cells[0].Text = errorMsg;
            }
            else
            {
                e.Row.Cells[3].Text = e.Row.Cells[3].Text.PadLeft(4, pad).ToString();
            }
            if (!regVarChar.IsMatch(e.Row.Cells[4].Text))
            {
                f = 0;
                errorcount++;
                e.Row.Cells[4].BackColor = System.Drawing.Color.Red;
                errorMsg = "Login Facility should not contain Special Charecter Like(.$&^@!~`#)";
                e.Row.Cells[0].Text = errorMsg;
            }
            if (!regShift.IsMatch(e.Row.Cells[5].Text.PadLeft(4, pad).ToString()))
            {
                f = 0;
                errorcount++;
                e.Row.Cells[5].BackColor = System.Drawing.Color.Red;
                errorMsg = "The LogOut Time time must be with in 0000 hrs to 2359 hrs.";
                e.Row.Cells[0].Text = errorMsg;
            }
            else
            {
                e.Row.Cells[5].Text = e.Row.Cells[5].Text.PadLeft(4, pad).ToString();
            }
            if (!regVarChar.IsMatch(e.Row.Cells[6].Text))
            {
                f = 0;
                errorcount++;
                e.Row.Cells[6].BackColor = System.Drawing.Color.Red;
                errorMsg = "LogOut Facility should not contain Special Charecter Like(.$&^@!~`#)";
                e.Row.Cells[0].Text = errorMsg;
            }

        }


    }
    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        string attachment = "attachment; filename=ScheduleVerifyResult.xls";
        HttpResponse response = HttpContext.Current.Response;
        response.Clear();
        response.Charset = string.Empty;
        response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("content-disposition", attachment);
        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter htw = new HtmlTextWriter(sw))
            {
                grdxlsdata.RenderControl(htw);
                response.Write(sw.ToString());
                response.End();
            }
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btnExportToExcelFinal_Click(object sender, EventArgs e)
    {
        string attachment = "attachment; filename=ScheduleUploadResult.xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        grdFinalOutPut.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End(); 
    }

}
