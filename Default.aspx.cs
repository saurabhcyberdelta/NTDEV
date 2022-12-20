using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : basepage
{
    DataClasses1DataContext TmsDataContext = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //string loginuser = MyApplicationSession.LoginUser;
            //int index = loginuser.IndexOf(@"\");
            ////Login change----------------

            //MyApplicationSession._UserName = loginuser.Substring(index + 1, loginuser.Length - index - 1);

            ////Login change----------------
            //MyApplicationSession._LoggedInTime = DateTime.Now.ToLongTimeString();
            ////MyApplicationSession._UserName = "a77651";

            //var result = TmsDataContext.Spr_GetuserId(MyApplicationSession._UserName);

            //foreach (var result1 in result)
            //{
            //    MyApplicationSession._UserID = Convert.ToInt32(result1.ID);
            //    MyApplicationSession._empName = result1.empName;
            //    MyApplicationSession._FacilityID = Convert.ToInt32(result1.FacilityID);
            //    MyApplicationSession._LocationId = Convert.ToInt32(result1.locationId);
            //}

            if (MyApplicationSession._UserName == "No-User")
            {
                Response.Redirect("Login.aspx");
            }

            if (MyApplicationSession._UserID <= 0)
            {
                Response.Redirect("Login.aspx");
            }

            //for (int i = 0; i < Session.Contents.Count; i++)
            //{
            //    Response.Write(Session.Keys[i] + " - " + Session[i] + "<br />");
            //}
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            throw (ex);
        }

    }
}
