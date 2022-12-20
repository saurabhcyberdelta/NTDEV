using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class NoAccess : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (MyApplicationSession._UserName == "No User")
        {
            lblErrorMsg.Visible = true;
            lblErrorMsg.Text = "Windows does not return any username.";
        }

        if (MyApplicationSession._UserID <= 0)
        {
            lblErrorMsg.Visible = true;
            lblErrorMsg.Text = MyApplicationSession._UserName + " does not exist in the eTMS database.";
        }
    }
}
