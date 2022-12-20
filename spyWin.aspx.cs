using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class spyWin : System.Web.UI.Page
{
      DataClasses1DataContext TmsDataContext = new DataClasses1DataContext();
   
    protected void Page_Load(object sender, EventArgs e)
    {
        string script = "<script type='text/javascript' " +
            "language='javascript'> " +
            " function check_opener() { " +
            " if (opener && opener.closed){ " +
            " parent.opener=''; " +
            " parent.close(); " +
            " } " +
            " else{ " +
            " parent.opener=''; " +
            " parent.close(); " +
            " } " +
            "} " +
            " onload = function() { " +
            " self.blur(); " +
            " setTimeout('check_opener()',0); " +
            " } " +
            " </script>";
        this.Controls.Add(new LiteralControl(script));
        
        TmsDataContext.UpdateLoggedInUsers(MyApplicationSession._UserID, MyApplicationSession._CurrSessionID, false);
        Session.Abandon();
    }
}
