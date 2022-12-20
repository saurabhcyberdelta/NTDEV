using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class ChangePasswordFirstTime : basepage2
{
    private string CryptedText = String.Empty;
    bool checkstate;
    DataClasses1DataContext TmsDataContext = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                MultiView1.ActiveViewIndex = 0;

                if (TmsDataContext.GetLastPassChanged(MyApplicationSession._UserID).ElementAtOrDefault(0).LastPassChanged.ToString() == "true")
                {
                    pnlChange.Enabled = false;
                  
                    lblErrorMsg.Visible = true;
                    DateTime changeAt = TmsDataContext.GetLastPassChanged(MyApplicationSession._UserID).ElementAtOrDefault(0).ChangedAt;
                    lblErrorMsg.Text = "You can change password only once in 24 hrs (Minimum Password age).<br>Last password change:" + changeAt.ToLongDateString() + " " + changeAt.ToLongTimeString() + ".";
                    MultiView1.ActiveViewIndex = -1;
                }
                else
                {
                    pnlChange.Enabled = true;
                    lblErrorMsg.Visible = false;
                    MultiView1.ActiveViewIndex = 0;
                }
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }
    protected void ChangePassword1_ChangingPassword(object sender, LoginCancelEventArgs e)
    {
        try
        {
            if (Page.IsValid == true)
            {
                //using (MD5 md5Hash = MD5.Create())
                //{
                //    CryptedText = MD5Sample.GetMd5Hash(md5Hash, ChangePassword1.NewPassword);
                CryptedText = HashingEncryption.ComputeHash(NewPassword.Text, "SHA384", null);

                //}

                string result = TmsDataContext.ChangePassword(MyApplicationSession._UserID, CryptedText).ElementAtOrDefault(0).result.ToString();

                if (result == "1")
                {

                    //ShowMessage("Your password has been changed successfully!");
                  
                    ModalPopupExtender1.Show();
                    MultiView2.ActiveViewIndex = 0;
                    //Response.Redirect("Login.aspx");
                }
                else
                {
                    //ShowMessage("Your password has not been changed.");
                }

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }

    }



    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        //using (MD5 md5Hash = MD5.Create())
        //{
        //    CryptedText = MD5Sample.GetMd5Hash(md5Hash, ChangePassword1.CurrentPassword);

        //}
        //if (TmsDataContext.GetEmployee(MyApplicationSession._UserID).ElementAtOrDefault(0).Password != CryptedText)
        //    checkstate = false;
        //else
        //    checkstate = true;
        try
        {
            string hashValue = TmsDataContext.GetEmployee(MyApplicationSession._UserID).ElementAtOrDefault(0).Password;
            checkstate = HashingEncryption.VerifyHash(CurrentPassword.Text, "SHA384", hashValue);

            args.IsValid = checkstate;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
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
        try
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
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

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

        //}

        try
        {

            CryptedText = HashingEncryption.ComputeHash(NewPassword.Text, "SHA384", null);

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
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }
    protected void ChangePasswordPushButton_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid == true)
            {
                //using (MD5 md5Hash = MD5.Create())
                //{
                //    CryptedText = MD5Sample.GetMd5Hash(md5Hash, ChangePassword1.NewPassword);
                CryptedText = HashingEncryption.ComputeHash(NewPassword.Text, "SHA384", null);

                //}

                string result = TmsDataContext.ChangePassword(MyApplicationSession._UserID, CryptedText).ElementAtOrDefault(0).result.ToString();

                if (result == "1")
                {

                    //ShowMessage("Your password has been changed successfully!");
                    ModalPopupExtender1.Show();
                    MultiView2.ActiveViewIndex = 0;
                    //Response.Redirect("Login.aspx");
                }
                else
                {
                    //ShowMessage("Your password has not been changed.");
                }

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }
    protected void btnOk_Click(object sender, EventArgs e)
    {
       
    }
    protected void ibtnSMclose_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Login.aspx");
    }
    protected void CurrentPassword_TextChanged(object sender, EventArgs e)
    {
        try
        {
            string hashValue = TmsDataContext.GetEmployee(MyApplicationSession._UserID).ElementAtOrDefault(0).Password;
            checkstate = HashingEncryption.VerifyHash(CurrentPassword.Text, "SHA384", hashValue);

            if (checkstate == false)
            {
                ShowMessage("Old Password Mismatch");
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);

        }
    }
}
