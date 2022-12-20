using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

public partial class RouteUpload : System.Web.UI.Page
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    RouteUploadLog RouteUploadLog = new RouteUploadLog();

    public string _mdbFileName
    {
        get
        {
            return (string)ViewState["_mdbFileName"];
        }

        set
        {
            ViewState["_mdbFileName"] = value;
        }
    }

    private OleDbConnection sourceconnection;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (MyApplicationSession._UserID <= 0)
        {
            Response.Redirect("~/Default.aspx");
        }
        lblErrorMsg.Text = string.Empty;
        Panel1.Visible = false;
        if (!IsPostBack)
        {
            // Make File Upload control as Read Only
            _mdbFileName = "";
            if (ddlFacility != null)
            {
                ddlFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
                ddlFacility.DataTextField = "facilityName";
                ddlFacility.DataValueField = "Id";
                ddlFacility.DataBind();
                ListItem liFacIn = new ListItem("-Select Facility-", "0");
                ddlFacility.Items.Insert(0, liFacIn);

                ddlFacility.SelectedIndex = ddlFacility.Items.IndexOf(ddlFacility.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));
            }
            FileUpload1.Attributes.Add("onkeypress", "return false;");
            FileUpload1.Attributes.Add("onkeydown", "return false;");


            System.Text.StringBuilder sbValid = new System.Text.StringBuilder();

            sbValid.Append("if (typeof(Page_ClientValidate) == 'function') { ");

            sbValid.Append("if (Page_ClientValidate() == false) { return false; }} ");

            sbValid.Append("this.value = 'Please wait...';");

            sbValid.Append("this.disabled = true;");

            sbValid.Append("document.all." + btnUpload.UniqueID + ".disabled = true;");

            sbValid.Append(this.Page.GetPostBackEventReference(this.btnUpload));

            sbValid.Append(";");

            this.btnUpload.Attributes.Add("onclick", sbValid.ToString());
        }
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        DateTime UploadStartTime = DateTime.Now;
        string MachineIP = Request.ServerVariables["REMOTE_ADDR"];
        string result = "";
        try
        {
            System.Threading.Thread.Sleep(5000);

            if (FileUpload1.HasFile)
            {
                string fileExt = System.IO.Path.GetExtension(FileUpload1.FileName);
                if (fileExt.ToUpper() == ".MDB")
                {
                    //string FileName = FileUpload1.PostedFile.FileName.Substring(FileUpload1.PostedFile.FileName.LastIndexOf("\\") + 1);
                    string UpdateTime = ExtractCurrTime();

                    string FileName = "REPORTS" + UpdateTime + ".MDB";

                    FileUpload1.PostedFile.SaveAs(Server.MapPath("RouteFile/" + FileName));

                    _mdbFileName = Server.MapPath("RouteFile/" + FileName);

                    if (File.Exists(_mdbFileName))
                    {
                        string TransactionId = GetRandomString(0);

                        //Connect to Source DataBase for TEMPRTE
                        sourceconnection = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + _mdbFileName + ";Persist Security Info=False");
                        string dstConnection = ConfigurationManager.ConnectionStrings["DeltaTmsConnectionString"].ToString();
                        sourceconnection.Open();
                        OleDbCommand oledbCmd = new OleDbCommand("SELECT LTRIM(RTRIM(ID)) AS ID, TotalDist, TotalHours, TotalCost, LTRIM(RTRIM(VehicleID)) AS VehicleID, RTType,'" + TransactionId + "' as TransactionId FROM TEMPVEH");
                        oledbCmd.Connection = sourceconnection;
                        OleDbDataReader oledbReader = oledbCmd.ExecuteReader();

                        //Connect to Destination DataBase for TEMPRTE
                        SqlConnection destinationConnection = new SqlConnection(dstConnection);
                        destinationConnection.Open();
                        SqlBulkCopy bulkCopy = new SqlBulkCopy(destinationConnection);
                        bulkCopy.DestinationTableName = "TEMPVEH";
                        bulkCopy.ColumnMappings.Add("ID", "ID");
                        bulkCopy.ColumnMappings.Add("TotalDist", "TotalDist");
                        bulkCopy.ColumnMappings.Add("TotalHours", "TotalHours");
                        bulkCopy.ColumnMappings.Add("TotalCost", "TotalCost");
                        bulkCopy.ColumnMappings.Add("VehicleID", "VehicleID");
                        bulkCopy.ColumnMappings.Add("RTType", "RTType");
                        bulkCopy.ColumnMappings.Add("TransactionId", "TransactionId");
                        bulkCopy.WriteToServer(oledbReader);
                        oledbReader.Close();
                        destinationConnection.Close();

                        //Connect to Source DataBase for TEMPVEH
                        OleDbCommand oledbCmd1 = new OleDbCommand("SELECT  LTRIM(RTRIM(PointID)) AS PointID, StopNumber, LTRIM(RTRIM(KeyStr10)) AS KeyStr10, LTRIM(RTRIM(ShiftDt)) AS ShiftDt, LTRIM(RTRIM(SHIFT)) AS SHIFT, LTRIM(RTRIM(ZoneName)) AS ZoneName, LTRIM(RTRIM(Remark)) AS Remark, NextStopDist, Action, ETA, LTRIM(RTRIM(Type)) AS Type,'" + TransactionId + "' as TransactionId  FROM TEMPRTE");
                        oledbCmd1.Connection = sourceconnection;
                        OleDbDataReader oledbReader1 = oledbCmd1.ExecuteReader();
                        //Connect to Destination DataBase for TEMPVEH
                        SqlConnection destinationConnection1 = new SqlConnection(dstConnection);
                        destinationConnection1.Open();

                        SqlBulkCopy bulkCopy1 = new SqlBulkCopy(destinationConnection1);
                        bulkCopy1.DestinationTableName = "TEMPRTE";
                        bulkCopy1.ColumnMappings.Add("PointID", "PointID");
                        bulkCopy1.ColumnMappings.Add("StopNumber", "StopNumber");
                        bulkCopy1.ColumnMappings.Add("KeyStr10", "KeyStr10");
                        bulkCopy1.ColumnMappings.Add("ShiftDt", "ShiftDt");
                        bulkCopy1.ColumnMappings.Add("SHIFT", "SHIFT");
                        bulkCopy1.ColumnMappings.Add("ZoneName", "ZoneName");
                        bulkCopy1.ColumnMappings.Add("Remark", "Remark");
                        bulkCopy1.ColumnMappings.Add("NextStopDist", "NextStopDist");
                        bulkCopy1.ColumnMappings.Add("Action", "Action");
                        bulkCopy1.ColumnMappings.Add("ETA", "ETA");
                        bulkCopy1.ColumnMappings.Add("Type", "Type");
                        bulkCopy1.ColumnMappings.Add("TransactionId", "TransactionId");
                        bulkCopy1.WriteToServer(oledbReader1);
                        oledbReader1.Close();
                        sourceconnection.Close();
                        destinationConnection.Close();
                        File.Delete(_mdbFileName);

                        tms.CommandTimeout = 0;
                        tms.UploadRoster(MyApplicationSession._UserID, Convert.ToInt32(ddlFacility.SelectedValue), TransactionId, ref result);
                        //lblErrorMsg.Text = "Your file " + FileName + " of type " + FileUpload1.PostedFile.ContentType + " and size " + FileUpload1.PostedFile.ContentLength + " kb has been uploaded successfully.<br>To view the uploaded routes go to Transport >>View Routes Tab.";
                        lblErrorMsg.Text = result;
                        tms.SaveRouteUploadLog(UploadStartTime, result, MyApplicationSession._UserID, MachineIP, MyApplicationSession._UserName);
                    }
                    else
                    {
                        lblErrorMsg.Text = "<font color='Red'>Your file " + FileName + " of type " + FileUpload1.PostedFile.ContentType + " and size " + FileUpload1.PostedFile.ContentLength + " kb not uploaded successfully.</font>";

                        tms.UpdateTmsUtilityStatus("N", MyApplicationSession._UserID);
                        tms.SaveRouteUploadLog(UploadStartTime, "Routes upload failed.File was not exists.", MyApplicationSession._UserID, MachineIP, MyApplicationSession._UserName);

                    }

                }
                else
                {
                    lblErrorMsg.Text = "<font color='Red'>Only .MDB file(s) is allowed!</font>";
                    tms.UpdateTmsUtilityStatus("N", MyApplicationSession._UserID);
                    tms.SaveRouteUploadLog(UploadStartTime, "Routes upload failed. Only .MDB file(s) was allowed.", MyApplicationSession._UserID, MachineIP, MyApplicationSession._UserName);

                }

            }
            else
            {
                lblErrorMsg.Text = "You have not specified a file.";
                tms.UpdateTmsUtilityStatus("N", MyApplicationSession._UserID);
                tms.SaveRouteUploadLog(UploadStartTime, "Routes upload failed. No file selected.", MyApplicationSession._UserID, MachineIP, MyApplicationSession._UserName);

            }

        }
        catch (Exception ex)
        {
            lblErrorMsg.Text = "<font color='Red'>ERROR: " + ex.Message.ToString() + "</font>";
            tms.UpdateTmsUtilityStatus("N", MyApplicationSession._UserID);
            tms.SaveRouteUploadLog(UploadStartTime, "Routes upload failed. An error occurred. ERROR: " + ex.Message.ToString(), MyApplicationSession._UserID, MachineIP, MyApplicationSession._UserName);

            ExceptionUtility.LogException(ex, "Catch Error");

        }
        finally
        {
            if (sourceconnection != null)
            {
                if (sourceconnection.State.Equals(System.Data.ConnectionState.Open))
                {
                    sourceconnection.Close();
                }
            }
            if (File.Exists(_mdbFileName))
            {
                File.Delete(_mdbFileName);
            }
        }
    }

    private static string ExtractCurrTime()
    {
        string UpdateTime = DateTime.Now.ToString();
        UpdateTime = UpdateTime.Replace("/", "");
        UpdateTime = UpdateTime.Replace(" ", "_");
        UpdateTime = UpdateTime.Replace(":", "");
        return UpdateTime;
    }

    private string GetRandomString(int seed)
    {
        //use the following string to control your set of alphabetic characters to choose from
        //for example, you could include uppercase too
        const string alphabet = "abcdefghijklmnopqrstuvwxyz";
        Random rnd;
        // Random is not truly random, 
        // so we try to encourage better randomness by always changing the seed value
        if (seed == 0)
        {
            rnd = new Random(DateTime.Now.Millisecond);
        }
        else
        {
            rnd = new Random((seed + DateTime.Now.Millisecond));
        }

        // basic 5 digit random number
        string result = rnd.Next(100000000, 999999999).ToString();

        // single random character in ascii range a-z
        string alphaChar = alphabet.Substring(rnd.Next(0, alphabet.Length - 1), 1);

        // random position to put the alpha character
        int replacementIndex = rnd.Next(0, (result.Length - 1));
        result = result.Remove(replacementIndex, 1).Insert(replacementIndex, alphaChar);

        return result;
    }
}

