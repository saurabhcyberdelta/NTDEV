using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.SessionState;

public partial class PrintUnscheduleTripsheet : basepage2
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        string strReq = "";
        string[] arrIndMsg = null;
        strReq = Request.RawUrl;
        strReq = strReq.Substring(strReq.IndexOf('?') + 1);
        strReq = new EncryptQueryString().Decrypt(strReq);
        string[] arrMsgs = strReq.Split('&');
        string ID = null;

        if (arrMsgs.Length == 1)
        {
            arrIndMsg = arrMsgs[0].Split('=');
            if (arrIndMsg.Length > 1)
            {
                ID = arrIndMsg[1].ToString().Trim();
            }
            else
            {
                ID = "";
            }

        }

        if (ID != "")
        {
            dlShowRoutes.DataSource = tms.GetUnscheduleDetails(ID);
            dlShowRoutes.DataBind();

            for (int i = 0; i < dlShowRoutes.Items.Count; i++)
            {
                GridView grdViewRouteDetails = (GridView)dlShowRoutes.Items[i].FindControl("grdViewRouteDetails");
                grdViewRouteDetails.DataSource = tms.GetUnscheduleDetails(ID); ;
                grdViewRouteDetails.DataBind();
            }

        }

    }
   
}
