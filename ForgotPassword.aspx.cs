using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ForgotPassword : System.Web.UI.Page
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnResetPassword_Click(object sender, EventArgs e)
    {

        String res = tms.ForgetPassword(txtEmployeeID.Text, txtEmailID.Text).ElementAtOrDefault(0).Result.ToString();
        if (res == "0")
        {
            ShowMessage("Authentication Failed. Please Try Again Later!");
        
        }
        else
        {
            ShowMessage("Password Reset Successfully! Please Check Your Email for Default Password.");
        }
     //   Response.Redirect("~/default.aspx");

    }

    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "forget", jScript, true);

    }
}
