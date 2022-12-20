using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Header : System.Web.UI.MasterPage
{
    DataClasses1DataContext TmsDataContest = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        lblCuurDate.Text = DateTime.Now.ToLongDateString();
        lblUserName.Text = MyApplicationSession._empName + " at " + MyApplicationSession._LoggedInTime;
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
        Response.Write("<script language='javascript'>");
        Response.Write("{");
        Response.Write(" var Backlen=history.length;");
        Response.Write(" history.go(-Backlen);");
        Response.Write(String.Format(" window.location.href='{0}'; ", "Login.aspx"));
        Response.Write("}");
        Response.Write("</script>");
        FormsAuthentication.SignOut();
    }
}
