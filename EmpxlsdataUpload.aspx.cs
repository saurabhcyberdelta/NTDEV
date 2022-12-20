using System;
using System.IO;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EmpxlsdataUpload : basepage
{
    string dirpath = "";
    string strfile = "";

    //string connstr = System.Configuration.ConfigurationSettings.AppSettings.Get("TmsConnectionString");
    string connstr = System.Configuration.ConfigurationManager.ConnectionStrings["DeltaTmsConnectionString"].ToString();
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {


            if (string.IsNullOrEmpty((MyApplicationSession._UserID).ToString().Trim()))
            {
                Response.Redirect("default.aspx");
            }
            if (Directory.Exists(Server.MapPath("Uploads/")) == false)
            {
                Directory.CreateDirectory(Server.MapPath("Uploads/"));
            }
            dirpath = Server.MapPath("Uploads/");
            this.cmdUpdateEmployee.Enabled = false;
            this.lblerrmsg.Text = "";
        }
        catch (Exception ex)
        {
            this.lblerrmsg.Text = ex.Message.ToString();
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }

    }
    protected void cmdUploadxlsdata_Click(object sender, System.EventArgs e)
    {


        if (Directory.Exists(dirpath) == false)
        {
            Directory.CreateDirectory(Server.MapPath("Uploads/"));
        }
        strfile = dirpath + FilexlsUpload.FileName;
        try
        {
            if (!string.IsNullOrEmpty((FilexlsUpload.FileName).ToString().Trim()))
            {
                if (this.FilexlsUpload.FileName.EndsWith(".xls"))
                {
                    this.FilexlsUpload.SaveAs(strfile);
                }
                this.lblerrmsg.Text = "";
                SetImportData(strfile);
            }
            else
            {
                this.lblerrmsg.Text = "Please Select Excel File";
            }

        }
        catch (Exception ex)
        {
            this.lblerrmsg.Text = ex.Message.ToString();
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }

    }
    private void SetImportData(string strfilepath)
    {
        //**********************************************************************
        //Function: Show all data of uploded xls file   
        //Created on 26 NOV 2010
        //created by 
        //**********************************************************************
        try
        {
            DataSet myDataset = new DataSet();
            string fname = null;
            string strConn = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" + strfilepath + "; Extended Properties=Excel 8.0;";
            //'You must use the $ after the object you reference in the spreadsheet

            excelCls objClass1 = new excelCls();
            string[] SheetName = objClass1.GetExcelSheetNames(strfilepath);
            if (SheetName.Length > 2)
            {
                this.cmdUpdateEmployee.Enabled = true;
                this.lblerrmsg.Text = "There should be only one sheet with no page range in excel file";
                objClass1 = null;
                this.cmdUpdateEmployee.Enabled = false;
                System.IO.File.Delete(strfilepath);
                Session.Clear();
                return;
            }
            fname = SheetName[0];
            OleDbDataAdapter myData = new OleDbDataAdapter("SELECT * FROM [" + fname + "]", strConn);
            myData.TableMappings.Add("Table", "ExcelTest");
            myData.Fill(myDataset);
            grdxlsdata.DataSource = myDataset.Tables[0].DefaultView;
            grdxlsdata.DataBind();
            grdxlsdata.Visible = true;
            this.cmdUpdateEmployee.Enabled = true;
            this.lblerrmsg.Text = "";
            System.IO.File.Delete(strfilepath);
        }
        catch (Exception ex)
        {
            this.lblerrmsg.Text = ex.Message.ToString();
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }
    private string Filterdata(string strdata)
    {
        //**********************************************************************
        //Function: replace ' to `
        //**********************************************************************

        strdata = strdata.Replace("'", "`");
        strdata = strdata.Replace("" + (char)34, "`");
        return strdata;
    }
    protected void cmdUpdateEmployee_Click(object sender, System.EventArgs e)
    {
        //**********************************************************************
        //Function: uploding employee data 
        //Created on 03/06/12
        //created by Sajal Agarwal
        //**********************************************************************
        SqlConnection connection = new SqlConnection(connstr);
        if (validempfile() == true)
        {
            int irow = 0;
            string strEmpCode = "";
            string strEmpName = "";
            string strgender = "";
            string straddress = "";
            string strmobile = "";
            string strphone = "";
            string stremail = "";
            string strattrited = "";
            string strtptreq = "";
            string strManagerID = "";
            string strfacility = "";
            string strProcess = "";
            string strSubProcess = "";
            string strcostcenter = "";  
            string dvmanagerid = "";
            string strspecialcase = "";
            string strfromspecialcase = "";
            string tospecialcase = "";

            int intPassRowcount = 0;
            int intFailRowcount = 0;
            System.Text.StringBuilder stremployeemsg = new System.Text.StringBuilder();
            DateTime strupdate_time = System.DateTime.Now;
            System.DateTime prSttime = System.DateTime.Now;
            int strupdate_user = MyApplicationSession._UserID;
            int rowno = 2;
            string remark = "Invalid EmployeeID";
            string sql = "";
            SqlCommand cmd = new SqlCommand();

            sql = "Delete from GridEmp where Username='" + strupdate_user + "'";
            cmd.CommandText = sql;
            cmd.Connection = connection;
            connection.Open();
            cmd.ExecuteScalar();
            connection.Close();
            GridView grdtempview = new GridView();
            grdtempview = grdxlsdata;

            if (grdxlsdata.Rows.Count >= 1)
            {

                for (irow = 0; irow <= this.grdxlsdata.Rows.Count - 1; irow++)
                {
                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[0].Text.Trim()))
                    {
                        strEmpCode = checkval(this.grdxlsdata.Rows[irow].Cells[0].Text.Trim(), "str").Replace("&amp;", "");
                    }
                    else
                    {
                        strEmpCode = "";
                    }

                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[1].Text.Trim()))
                    {
                        strEmpName = checkval(this.grdxlsdata.Rows[irow].Cells[1].Text.Trim(), "str").Replace("&amp;", "");
                    }
                    else
                    {
                        strEmpName = "";
                    }

                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[2].Text.Trim()))
                    {
                        if (this.grdxlsdata.Rows[irow].Cells[2].Text.Trim().ToUpper() == "F" | this.grdxlsdata.Rows[irow].Cells[2].Text.Trim().ToUpper() == ("Female").ToUpper())
                        {
                            strgender = "Female";
                        }
                        else if (this.grdxlsdata.Rows[irow].Cells[2].Text.Trim().ToUpper() == "M" | this.grdxlsdata.Rows[irow].Cells[2].Text.Trim().ToUpper() == ("Male").ToUpper())
                        {
                            strgender = "Male";
                        }
                    }
                    else
                    {
                        strgender = "";
                    }

                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[3].Text.Trim()))
                    {
                        straddress = checkval(Filterdata(this.grdxlsdata.Rows[irow].Cells[3].Text.Trim()), "str").Replace("&amp;", "");
                    }
                    else
                    {
                        straddress = "";
                    }
                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[4].Text.Trim()))
                    {
                        strmobile = checkval(this.grdxlsdata.Rows[irow].Cells[4].Text.Trim(), "str").Replace("&amp;", "");
                    }
                    else
                    {
                        strmobile = "";
                    }


                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[5].Text.Trim()))
                    {
                        strphone = checkval(this.grdxlsdata.Rows[irow].Cells[5].Text.Trim(), "str");
                    }
                    else
                    {
                        strphone = "";
                    }
                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[6].Text.Trim()))
                    {
                        stremail = checkval(this.grdxlsdata.Rows[irow].Cells[6].Text.Trim(), "str");
                    }
                    else
                    {
                        stremail = "";
                    }
                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[7].Text.Trim()))
                    {
                        strattrited = checkval(this.grdxlsdata.Rows[irow].Cells[7].Text.Trim(), "str");
                    }
                    else
                    {
                        strattrited = "";
                    }
                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[8].Text.Trim()))
                    {
                        strtptreq = checkval(this.grdxlsdata.Rows[irow].Cells[8].Text.Trim(), "str");
                    }
                    else
                    {
                        strtptreq = "";
                    }
                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[9].Text.Trim()))
                    {
                        strManagerID = checkval(this.grdxlsdata.Rows[irow].Cells[9].Text.Trim(), "str").Replace("&amp;", "");
                    }
                    else
                    {
                        strManagerID = "";
                    }
                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[10].Text.Trim()))
                    {
                        strfacility = checkval(this.grdxlsdata.Rows[irow].Cells[10].Text.Trim(), "str").Replace("&amp;", ""); 
                    }
                    else
                    {
                        strfacility = "";
                    }

                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[11].Text.Trim()))
                    {
                        strProcess = checkval(this.grdxlsdata.Rows[irow].Cells[11].Text.Trim(), "str").Replace("&amp;", ""); 
                    }
                    else
                    {
                        strProcess = "";
                    }

                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[12].Text.Trim()))
                    {
                        strSubProcess = checkval(this.grdxlsdata.Rows[irow].Cells[12].Text.Trim(), "str").Replace("&amp;","");
                    }
                    else
                    {
                        strSubProcess = "";
                    }

                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[13].Text.Trim()))
                    {
                        strcostcenter = checkval(this.grdxlsdata.Rows[irow].Cells[13].Text.Trim(), "str").Replace("&amp;", ""); ;
                    }
                    else
                    {
                        strcostcenter = "";
                    }
                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[14].Text.Trim()))
                    {
                        dvmanagerid = checkval(this.grdxlsdata.Rows[irow].Cells[14].Text.Trim(), "str");
                    }
                    else
                    {
                        dvmanagerid = "";
                    }

                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[15].Text.Trim()))
                    {
                        if (this.grdxlsdata.Rows[irow].Cells[15].Text.Trim().ToUpper() == "Y" | this.grdxlsdata.Rows[irow].Cells[15].Text.Trim().ToUpper() == ("YES").ToUpper())
                        {
                            strspecialcase = "1";
                        }
                        else if (this.grdxlsdata.Rows[irow].Cells[15].Text.Trim().ToUpper() == "N" | this.grdxlsdata.Rows[irow].Cells[15].Text.Trim().ToUpper() == ("NO").ToUpper())
                        {
                            strspecialcase = "0";
                        }
                    }
                    else
                    {
                        strgender = "";
                    }
                    strupdate_time = System.DateTime.Now;
                    DateTime specialto,specialfrom;
                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[16].Text.Trim()))
                    {
                        strfromspecialcase = this.grdxlsdata.Rows[irow].Cells[16].Text.Trim();
                        if (strfromspecialcase == "&nbsp;")
                        {
                            specialfrom = DateTime.MaxValue;
                        }
                        else
                        {
                            specialfrom = Convert.ToDateTime(strfromspecialcase);
                        }
                    }
                    else
                    {
                        strfromspecialcase = "";
                        specialfrom = Convert.ToDateTime(null);
                    }
                    if (!string.IsNullOrEmpty(this.grdxlsdata.Rows[irow].Cells[17].Text.Trim()))
                    {
                        tospecialcase = this.grdxlsdata.Rows[irow].Cells[17].Text.Trim();
                        if (tospecialcase == "&nbsp;")
                        {
                            specialto = DateTime.MaxValue;
                        }
                        else
                        {
                            specialto = Convert.ToDateTime(tospecialcase);
                        }
                    }
                    else
                    {
                        tospecialcase = "";
                        specialto = Convert.ToDateTime(null);
                    }
                    

                    if ((strEmpCode == "NA") || (strEmpCode == "TMP"))
                    {
                        /* SqlCommand CmdGetTempID = new SqlCommand("Spr_GetTempID", connection);
                           CmdGetTempID.CommandType = CommandType.StoredProcedure;
                           connection.Open();
                           strEmpCode = CmdGetTempID.ExecuteScalar().ToString();
                           connection.Close();
                           if (string.IsNullOrEmpty(strEmpCode) == true)
                           {
                               strEmpCode = "TMP000001";
                           }
                         */
                    }

                    if (!string.IsNullOrEmpty(strEmpCode))
                    {
                        try
                        {

                     string res=tms.Spr_InsUpdBulkEmpData(strEmpCode,
                            strEmpName,
                            strgender,
                            straddress,
                             strmobile,
                             strphone,
                             stremail,
                             strattrited,
                             strtptreq,
                             strManagerID,
                             strfacility,
                             strProcess,
                             strSubProcess,
                             strcostcenter,
                             dvmanagerid,
                             strspecialcase,
                             specialfrom,
                             specialto,
                             strupdate_user.ToString(),
                             strupdate_time).ElementAtOrDefault(0).Column1.ToString();


                            //SqlCommand CmdUpadateEmployee = new SqlCommand("Spr_InsUpdBulkEmpData", connection);
                            //CmdUpadateEmployee.CommandType = CommandType.StoredProcedure;
                            //var _with1 = CmdUpadateEmployee.Parameters;
                            //_with1.AddWithValue("@strEmpCode", strEmpCode);
                            //_with1.AddWithValue("@strEmpName", strEmpName);
                            //_with1.AddWithValue("@strgender", strgender);
                            //_with1.AddWithValue("@straddress", straddress);
                            //_with1.AddWithValue("@strmobile", strmobile);
                            //_with1.AddWithValue("@strphone", strphone);
                            //_with1.AddWithValue("@stremail", stremail);
                            //_with1.AddWithValue("@strattrited", strattrited);
                            //_with1.AddWithValue("@strtptreq", strtptreq);
                            //_with1.AddWithValue("@strManagerID", strManagerID);
                            //_with1.AddWithValue("@strfacility", strfacility);
                            //_with1.AddWithValue("@strProcess", strProcess);
                            //_with1.AddWithValue("@strSubProcess", strSubProcess);
                            //_with1.AddWithValue("@strCostcenter", strcostcenter);
                            //_with1.AddWithValue("@strdvmanager", dvmanagerid);
                            //_with1.AddWithValue("@strSpecialCase", strspecialcase);
                            //_with1.AddWithValue("@strfromspecial", specialfrom);
                            //_with1.AddWithValue("@strtospecial", specialto);
                            //_with1.AddWithValue("@strupdate_user", strupdate_user);
                            //_with1.AddWithValue("@strupdate_time", strupdate_time);
                          
                            //connection.Open();
                            //CmdUpadateEmployee.ExecuteNonQuery();
                            //CmdUpadateEmployee.
                            //connection.Close();

                    

                        }
                        catch (Exception ex)
                        {
                            this.lblerrmsg.Text = ex.Message.ToString();
                            ExceptionUtility.LogException(ex, "Catch Error");
                            throw (ex);

                        }
                        intPassRowcount = intPassRowcount + 1;
                        rowno = rowno + 1;
                    }
                    else
                    {
                        try
                        {
                            SqlCommand CmdUpadateEmployee = new SqlCommand("Spr_InsErrBulkEmpData", connection);
                            CmdUpadateEmployee.CommandType = CommandType.StoredProcedure;
                            var _with2 = CmdUpadateEmployee.Parameters;
                            _with2.AddWithValue("@strrowno", rowno);
                            _with2.AddWithValue("@strEmpName", strEmpName);
                            _with2.AddWithValue("@strProcess", strProcess);
                            _with2.AddWithValue("@strremark", remark);
                            _with2.AddWithValue("@strupdate_user", strupdate_user);
                            connection.Open();
                            CmdUpadateEmployee.ExecuteNonQuery();
                            connection.Close();
                        }
                        catch (Exception ex)
                        {
                            this.lblerrmsg.Text = ex.Message.ToString();
                            ExceptionUtility.LogException(ex, "Catch Error");
                            throw (ex);

                        }
                        intFailRowcount = intFailRowcount + 1;
                        rowno = rowno + 1;
                    }
                }
            }
            grdxlsdata.Visible = true ;
            this.cmdUpdateEmployee.Enabled = false;
            this.lblerrmsg.Text = "Total no of records processed: " + irow + " Total no of records passed: " + intPassRowcount + " Total no of records failed: " + intFailRowcount;
            DataSet GridDataset = new DataSet();
            SqlDataAdapter GridData = new SqlDataAdapter("SELECT * FROM GridEmp where username='" + strupdate_user + "'", connection);
            GridData.TableMappings.Add("Table", "ExcelTest");
            GridData.Fill(GridDataset);
            grdxlsdata.DataSource = GridDataset.Tables[0].DefaultView;
            grdxlsdata.DataBind();
            grdxlsdata.Visible = true;

        }
        else
        {
            this.lblerrmsg.Text = "You have select wrong file format to upload employee data in TMS Database ";
        }

    }
    private bool validempfile()
    {
        bool functionReturnValue = false;
        //**********************************************************************
        //Function: validate employee data file 
        //Created on 08/06/08
        //created by Hemant Tiwari
        //**********************************************************************
        try
        {
            bool validstatus = true;
            if (this.grdxlsdata.HeaderRow.Cells[0].Text.ToUpper() != ("Partnerid").ToUpper())
                if ((this.grdxlsdata.HeaderRow.Cells[1].Text).ToUpper() != ("partnername").ToUpper())
                    if ((this.grdxlsdata.HeaderRow.Cells[2].Text.ToUpper()) != ("gender").ToUpper())
                        if ((this.grdxlsdata.HeaderRow.Cells[3].Text.ToUpper()) != ("address").ToUpper())
                            if ((this.grdxlsdata.HeaderRow.Cells[4].Text.ToUpper()) != ("mobile").ToUpper())
                                if ((this.grdxlsdata.HeaderRow.Cells[5].Text.ToUpper()) != ("phone").ToUpper())
                                    if ((this.grdxlsdata.HeaderRow.Cells[6].Text.ToUpper()) != ("email").ToUpper())
                                        if ((this.grdxlsdata.HeaderRow.Cells[7].Text).ToUpper() != ("attrited").ToUpper())
                                            if ((this.grdxlsdata.HeaderRow.Cells[8].Text.ToUpper()) != ("TransportRequired").ToUpper())
                                                if ((this.grdxlsdata.HeaderRow.Cells[9].Text.ToUpper()) != ("managerid").ToUpper())
                                                    if ((this.grdxlsdata.HeaderRow.Cells[10].Text.ToUpper()) != ("site").ToUpper())
                                                        if ((this.grdxlsdata.HeaderRow.Cells[11].Text.ToUpper()) != ("bu").ToUpper())
                                                            if ((this.grdxlsdata.HeaderRow.Cells[12].Text.ToUpper()) != ("process").ToUpper())
                                                                    if ((this.grdxlsdata.HeaderRow.Cells[13].Text.ToUpper()) != ("costcenter").ToUpper())
                                                                        if ((this.grdxlsdata.HeaderRow.Cells[14].Text.ToUpper()) != ("DivisionManager").ToUpper())
                                                                            if ((this.grdxlsdata.HeaderRow.Cells[15].Text.ToUpper()) != ("specialcase").ToUpper())
                                                                                if ((this.grdxlsdata.HeaderRow.Cells[16].Text.ToUpper()) != ("fromspecialcase").ToUpper())
                                                                                    if ((this.grdxlsdata.HeaderRow.Cells[17].Text.ToUpper()) != ("tospecialcase").ToUpper())
                                                                                    {
                                                                                        validstatus = false;
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        validstatus = true;
                                                                                    }

            functionReturnValue = validstatus;
        }
        catch (Exception ex)
        {
            this.lblerrmsg.Text = ex.Message.ToString();
            functionReturnValue = false;
        }
        return functionReturnValue;

    }

    public string checkval(object str, string tocheck)
    {
        //**********************************************************************
        //Function: Function for check Special Charater
        //Created on 08/06/08
        //created by Hemant Tiwari
        //**********************************************************************

        string tmpStr = null;
        switch (tocheck)
        {
            case "str":
                if (string.IsNullOrEmpty(str.ToString()))
                {
                    return "";
                }
                tmpStr = str.ToString().Replace("'", "`");
                tmpStr = tmpStr.Trim();
                tmpStr = tmpStr.Replace("\"", "");
                tmpStr = tmpStr.Replace("/", "");
                tmpStr = tmpStr.Replace("\\", "");
                tmpStr = tmpStr.Replace("?", "");
                tmpStr = tmpStr.Replace("|", "");
                tmpStr = tmpStr.Replace("~", "");
                tmpStr = tmpStr.Replace("(", "");
                tmpStr = tmpStr.Replace(")", "");
                tmpStr = tmpStr.Replace("+", "");
                tmpStr = tmpStr.Replace("=", "");
                tmpStr = tmpStr.Replace("<", "");
                tmpStr = tmpStr.Replace(">", "");
                tmpStr = tmpStr.Replace("&nbsp;", "");
                return tmpStr;
            case "date":
                if (!IsDate(str.ToString()))
                {
                    return System.DateTime.Today.Date.ToShortDateString();
                }
                return str.ToString();
            case "num":
                if (!IsNumeric(str))
                {
                    return "0";
                }
                return str.ToString();
        }
        return str.ToString();
    }
    public static bool IsNumeric(object numberString)
    {
        char[] ca = numberString.ToString().ToCharArray();
        for (int i = 0; i < ca.Length; i++)
        {
            if (!char.IsNumber(ca[i]))
                if (ca[i] != '.')
                    return false;
        }
        if (numberString.ToString().Trim() == "")
            return false;
        return true;
    }
    public static bool IsDate(string strDate)
    {
        DateTime outDate;
        return DateTime.TryParse(strDate, out outDate);
    }
}
