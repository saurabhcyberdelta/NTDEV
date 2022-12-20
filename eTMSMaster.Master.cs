using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Web.Security;

public partial class eTMSMaster : System.Web.UI.MasterPage
{
    DataClasses1DataContext TmsDataContest = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        //**********************************************************************
        // Create and Display Menu based on User Rights
        //**********************************************************************

        try
        {
            lblCuurDate.Text = DateTime.Now.Date.ToLongDateString();

            if (Request.UserAgent.IndexOf("AppleWebKit") > 0)
            {

                Request.Browser.Adapters.Clear();

            }

            //lblCuurDate.Text = DateTime.Now.ToLongDateString();
            

            var result = TmsDataContest.Spr_GetMenuItem(Convert.ToString(MyApplicationSession._UserID));
            //
            // check id redirect to error page is result count is 0
            //
            lblUserName.Text = MyApplicationSession._empName + " at " + MyApplicationSession._LoggedInTime;
            DataTable dt = new DataTable();
            DataColumn dc = new DataColumn("MenuID", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("ParentID", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Text", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Description", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("NavigateUrl", typeof(System.String));
            dt.Columns.Add(dc);

            foreach (var result1 in result)
            {
                DataRow dr = dt.NewRow();
                dr["MenuID"] = result1.MenuID;
                dr["ParentID"] = result1.ParentID;
                dr["Text"] = result1.Text;
                dr["Description"] = result1.Description;
                dr["NavigateUrl"] = result1.NavigateUrl;
                dt.Rows.Add(dr);
            }


            DataSet dsMenu = new DataSet();
            dsMenu.Tables.Add(dt);
            if (dsMenu.Tables[0].Rows.Count > 0)
            {
                dsMenu.DataSetName = "Menus";
                dsMenu.Tables[0].TableName = "Menu";
                DataRelation relation = new DataRelation("ParentChild",
                        dsMenu.Tables["Menu"].Columns["MenuID"],
                        dsMenu.Tables["Menu"].Columns["ParentID"],
                        true);

                relation.Nested = true;
                dsMenu.Relations.Add(relation);

                xmlDataSource.Data = dsMenu.GetXml();

                if (Request.Params["Sel"] != null)
                {
                    if (File.Exists(Server.MapPath(Request.Params["Sel"])) == true)
                    {
                        Response.Redirect(Request.Params["Sel"]);
                    }
                    else
                    {
                        Server.Transfer("Http404ErrorPage.aspx");
                    }
                }
            }
        }
        catch (HttpException)
        {
            Server.Transfer("Http404ErrorPage.aspx");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public string ReturnDateFormat()
    {
        DateTime CurrentDate = DateTime.Now.Date;
        string year = CurrentDate.Year.ToString();
        string Month = CurrentDate.ToString("MMMM");
        string Day = CurrentDate.Day.ToString();
        string rs = Month + " " + Day + ", " + year;
        return rs;
    }
    protected void lbLogOut_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        TmsDataContest.UpdateLoggedInUsers(MyApplicationSession._UserID, MyApplicationSession._CurrSessionID, false);
       // Response.Write("<script language='javascript'>");
       // Response.Write("{");
        //Response.Write(" var Backlen=history.length;");
        //Response.Write(" history.go(-Backlen);");
        //Response.Write(String.Format(" window.location.href='{0}'; ", "Login.aspx"));
        //Response.Write("}");
        //Response.Write("</script>");
        Response.Redirect("Login.aspx");
        FormsAuthentication.SignOut();
    }
}
