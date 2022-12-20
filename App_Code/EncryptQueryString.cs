using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Security.Cryptography;
using System.IO;
using System.Text;

/// <summary>
/// Summary description for EncryptQueryString
/// </summary>
public class EncryptQueryString
{
    private byte[] IV = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16 };

    //private byte[] enckey = Encoding.UTF8.GetBytes("asjgdjg6545f"); // your solution key
    private byte[] enckey = Encoding.UTF8.GetBytes("r0b1nr0y"); // your solution key

    public EncryptQueryString()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public string Encrypt(string prmInput)
    {
        byte[] InputByteArray = Encoding.UTF8.GetBytes(prmInput);

        DESCryptoServiceProvider des = new DESCryptoServiceProvider();
        MemoryStream ms = new MemoryStream(); 
        CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(enckey, IV), CryptoStreamMode.Write);

        cs.Write(InputByteArray, 0, InputByteArray.Length);

        cs.FlushFinalBlock();

        cs.Clear();
        cs = null;
        return Convert.ToBase64String(ms.ToArray());
    }

    public string Decrypt(string prmInput)
    {
        byte[] inputByteArray;

        DESCryptoServiceProvider des = new DESCryptoServiceProvider();
        try
        {
            inputByteArray = Convert.FromBase64String(prmInput);
        }
        catch (Exception E)
        {
            inputByteArray = null;
        }
        if (inputByteArray != null)
        {

            try
            {
                MemoryStream ms = new MemoryStream();
                CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(enckey, IV), CryptoStreamMode.Write);

                cs.Write(inputByteArray, 0, inputByteArray.Length);

                cs.FlushFinalBlock();

                cs.Clear();
                cs = null;

                return Encoding.UTF8.GetString(ms.ToArray());
            }
            catch (Exception Ex)
            {
                return "";
            }
        }
        else
        {
        return "";
        }
    }

}
