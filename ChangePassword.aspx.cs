using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;

public partial class ChangePassword : basepage
{
    private string CryptedText = String.Empty;
    bool checkstate;
    DataClasses1DataContext TmsDataContext = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        lblErrorMsg.Text = string.Empty;
        lblErrorMsg.Visible = false;
         
        if (TmsDataContext.GetLastPassChanged(MyApplicationSession._UserID).ElementAtOrDefault(0).LastPassChanged.ToString() == "true")
        {
            pnlChange.Enabled = false;
            lblErrorMsg.Visible = true;
            DateTime changeAt = TmsDataContext.GetLastPassChanged(MyApplicationSession._UserID).ElementAtOrDefault(0).ChangedAt;
            lblErrorMsg.Text = "You can change password only once in 24 hrs (Minimum Password age).<br>Last password change:" + changeAt.ToLongDateString() + " " + changeAt.ToLongTimeString() + ".";
        }
        else
        {
            pnlChange.Enabled = true;
            lblErrorMsg.Visible = false;
        }
    }
    protected void ChangePassword1_ChangingPassword(object sender, LoginCancelEventArgs e)
    {
        if (Page.IsValid == true)
        {
            //using (MD5 md5Hash = MD5.Create())
            //{
            //CryptedText = MD5Sample.GetMd5Hash(md5Hash, ChangePassword1.NewPassword);
            CryptedText = HashingEncryption.ComputeHash(NewPassword.Text, "SHA384", null);

            //}

            string result = TmsDataContext.ChangePassword(MyApplicationSession._UserID, CryptedText).ElementAtOrDefault(0).result.ToString();

            if (result == "1")
            {
                lblErrorMsg.Visible = true;
                ShowMessage("Your password has been changed successfully!");
                pnlChange.Enabled = false;
                lblErrorMsg.Visible = true;
                DateTime changeAt = TmsDataContext.GetLastPassChanged(MyApplicationSession._UserID).ElementAtOrDefault(0).ChangedAt;
                lblErrorMsg.Text = "You can change password only once in 24 hrs (Minimum Password age).<br>Last password change:" + changeAt.ToLongDateString() + " " + changeAt.ToLongTimeString() + ".";
            }
            else
            {
                ShowMessage("Your password has not been changed.");
            }

        }

    }



    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        //using (MD5 md5Hash = MD5.Create())
        //{
        //    CryptedText = MD5Sample.GetMd5Hash(md5Hash, ChangePassword1.CurrentPassword);
        //    CryptedText = HashingEncryption.ComputeHash(ChangePassword1.CurrentPassword, "SHA384", null);

        //}
        //if (TmsDataContext.GetEmployee(MyApplicationSession._UserID).ElementAtOrDefault(0).Password != CryptedText)
        string hashValue = TmsDataContext.GetEmployee(MyApplicationSession._UserID).ElementAtOrDefault(0).Password;
        checkstate = HashingEncryption.VerifyHash(CurrentPassword.Text, "SHA384", hashValue);
        //else
        //checkstate = true;
        args.IsValid = checkstate;

        //if (args.IsValid == true)
        //{
        //    if (ChangePassword1.NewPassword.IndexOf(TmsDataContext.GetEmployee(MyApplicationSession._UserID).ElementAtOrDefault(0).empCode) >-1)
        //    {
        //        checkstate = false;

        //    }
        //    else
        //    {
        //        checkstate = true;
        //    }
        //}
        //args.IsValid = checkstate;
    }
    protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (args.IsValid == true)
        {
            if (NewPassword.Text.IndexOf(TmsDataContext.GetEmployee(MyApplicationSession._UserID).ElementAtOrDefault(0).empCode) > -1)
            {
                checkstate = false;

            }
            else
            {
                checkstate = true;
            }
            args.IsValid = checkstate;
        }
    }

    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
    protected void CustomValidator3_ServerValidate(object source, ServerValidateEventArgs args)
    {
        //using (MD5 md5Hash = MD5.Create())
        //{
        //    CryptedText = MD5Sample.GetMd5Hash(md5Hash, ChangePassword1.NewPassword);
            CryptedText = HashingEncryption.ComputeHash(NewPassword.Text, "SHA384", null);

        //}
        if (args.IsValid == true)
        {
            if (TmsDataContext.IsExistsInOldPassword(CryptedText).ElementAtOrDefault(0).result > 0)
            {
                checkstate = false;
            }
            else
            {
                checkstate = true;
            }
            args.IsValid = checkstate;
        }
    }
    protected void ChangePasswordPushButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            //using (MD5 md5Hash = MD5.Create())
            //{
            //CryptedText = MD5Sample.GetMd5Hash(md5Hash, ChangePassword1.NewPassword);
            CryptedText = HashingEncryption.ComputeHash(NewPassword.Text, "SHA384", null);

            //}

            string result = TmsDataContext.ChangePassword(MyApplicationSession._UserID, CryptedText).ElementAtOrDefault(0).result.ToString();

            if (result == "1")
            {

                ShowMessage("Your password has been changed successfully!");
                pnlChange.Enabled = false;
                //ChangePassword1.Enabled = false;
            }
            else
            {
                ShowMessage("Your password has not been changed.");
            }

        }
    }
}
