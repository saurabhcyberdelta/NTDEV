using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;

public partial class Login : System.Web.UI.Page
{
    DataClasses1DataContext TmsDataContext = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Login1.Focus();
        //string password = "Nos@9999";
        //string CryptedText = HashingEncryption.ComputeHash(password, "SHA384", null);

    }
    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        //RC4Engine myRC4Engine = new RC4Engine() { EncryptionKey = "ab48495fdjk4950dj39405fk", InClearText = Login1.Password };
        //myRC4Engine.Encrypt();

        string retValue = "";
        //using (MD5 md5Hash = MD5.Create())
        //{
        //string CryptedText = MD5Sample.GetMd5Hash(md5Hash, Login1.Password);
        //string CryptedText = HashingEncryption.ComputeHash(Login1.Password, "SHA384", null);
        //TmsDataContext.CheckUserLogin(Login1.UserName, CryptedText, ref retValue);
        string hashValue = TmsDataContext.GetPassword(Login1.UserName).ElementAtOrDefault(0).Password.ToString();

        bool IsValid = HashingEncryption.VerifyHash(Login1.Password, "SHA384", hashValue);
        //}

        if (IsValid == false)
        {
            Login1.FailureText = "Your login attempt was not successful. Please try again.";

        }
        else
        {
            //MyApplicationSession._UserName = "K Ganeshan";
            //MyApplicationSession._UserID = 96017;

           // MyApplicationSession._UserName = "2359";//Login1.UserName;
            MyApplicationSession._UserName = Login1.UserName;
            MyApplicationSession._LoggedInTime = DateTime.Now.ToLongTimeString();
            MyApplicationSession._CurrSessionID = HttpContext.Current.Session.SessionID;
            var result = TmsDataContext.Spr_GetuserId(MyApplicationSession._UserName);

            foreach (var result1 in result)
            {
                MyApplicationSession._UserID = Convert.ToInt32(result1.ID);
                MyApplicationSession._empName = result1.empName;
                MyApplicationSession._FacilityID = Convert.ToInt32(result1.FacilityID);
                MyApplicationSession._LocationId = Convert.ToInt32(result1.locationId);
                MyApplicationSession._IsExceptional = (result1.IsExceptional.ToString());
            }
            MyApplicationSession._ISAdmin = Convert.ToBoolean(TmsDataContext.GetISAdmin(MyApplicationSession._UserID).ElementAtOrDefault(0).result);

            TmsDataContext.UpdateLoggedInUsers(MyApplicationSession._UserID, MyApplicationSession._CurrSessionID, true);
            Response.Redirect("Default.aspx");
        }

    }

    protected void Login1_LoggedIn(object sender, EventArgs e)
    {

    }
}
