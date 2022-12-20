using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

/// <summary>
/// Summary description for basepage2
/// </summary>
public class basepage2 : System.Web.UI.Page
{
	public basepage2()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    protected override void OnPreInit(EventArgs e)
    {
        if (MyApplicationSession._UserID <= 0)        
        {
            //Response.Redirect("Default.aspx");

            Response.Redirect("Login.aspx");
        }
        base.OnPreInit(e);
    }
}
