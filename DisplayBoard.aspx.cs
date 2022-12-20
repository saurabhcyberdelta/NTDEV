using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class DisplayBoard : System.Web.UI.Page
{
    DataClasses1DataContext tms = new DataClasses1DataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void MoveNext_Tick(object sender, EventArgs e)
    {
        grdViewRouteParent.DataSource = tms.GetRoutes("02/18/2011", "02/18/2011", "2", "P", "1800","");
        grdViewRouteParent.DataBind();
        if (grdViewRouteParent.Rows.Count > 0)
        {
            for (int i = 0; i < grdViewRouteParent.Rows.Count; i++)
            {
                string lbRouteID = grdViewRouteParent.DataKeys[i]["RouteID"].ToString();

                GridView grdViewRouteChild = (GridView)grdViewRouteParent.Rows[i].FindControl("grdViewRouteChild");
                grdViewRouteChild.DataSource = tms.GetRoutesDetails(lbRouteID);
                grdViewRouteChild.DataBind();
            }
        }
        if (grdViewRouteParent.PageIndex == (grdViewRouteParent.PageCount - 1))
        {
            grdViewRouteParent.PageIndex = 0;
        }
        else
        {
            grdViewRouteParent.PageIndex = grdViewRouteParent.PageIndex + 1;
        }

    }
}
