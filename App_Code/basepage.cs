using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

/// <summary>
/// Summary description for basepage
/// </summary>
public class basepage : System.Web.UI.Page
{
    public basepage()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    protected override void OnPreInit(EventArgs e)
    {
        DataClasses1DataContext TmsDataContext = new DataClasses1DataContext();
        FileInfo pageUrl = new FileInfo(Request.Url.AbsolutePath);
        Boolean IsAccess = false;
        if (MyApplicationSession._UserID > 0)
        {
            if (TmsDataContext.Spr_GetuserId(MyApplicationSession._UserName).ElementAtOrDefault(0).FirstTimeLogin == true)
            {
                Response.Redirect("ChangePasswordFirstTime.aspx");
            }
            var resultMenuItem = TmsDataContext.Spr_GetMenuItem(Convert.ToString(MyApplicationSession._UserID));

            var result = TmsDataContext.GetMenuItem(MyApplicationSession._UserID);
            foreach (var r1 in result)
            {
                if (r1.NavigateUrl == pageUrl.Name)
                {
                    IsAccess = true;
                    break;
                }
                else
                {
                    if ((pageUrl.Name == "ReplicateSchedule.aspx") && (r1.NavigateUrl == "Scheduler.aspx"))
                    {
                        IsAccess = true;
                        break;
                    }

                    //Login change----------------

                    if (pageUrl.Name == "Default.aspx")
                    {
                        IsAccess = true;
                        break;
                    }

                    //Login change----------------
                }
            }
        }
        else
        {
            //Login change----------------

            //Response.Redirect("Default.aspx");

            //Login change----------------
            Response.Redirect("Login.aspx");
        }

        if (IsAccess == false)
        {
            Response.Redirect("NoAccess.htm");
        }

        base.OnPreInit(e);
    }
}
