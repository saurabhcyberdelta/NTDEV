using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

public partial class PrintIOSTripSheet : basepage2
{
    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Boolean IsValid = true;
            string strReq = "";
            string[] arrIndMsg = null;
            strReq = Request.RawUrl;
            strReq = strReq.Substring(strReq.IndexOf('?') + 1);
            string sdate = null, facid = null, edate = null, rType = null, Shifts = null;
            if (strReq.Length < 0)
            {

            }
            else
            {
                strReq = new EncryptQueryString().Decrypt(strReq);
                string[] arrMsgs = strReq.Split('&');

                if (arrMsgs.Length > 1)
                {
                    arrIndMsg = arrMsgs[0].Split('=');
                    if (arrIndMsg.Length > 1)
                    {
                        sdate = arrIndMsg[1].ToString().Trim();
                    }
                    else
                    {
                        sdate = "";
                    }
                    if (!Regex.IsMatch(sdate, @"^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"))
                    {
                        IsValid = false;
                    }
                }
                else
                {
                    IsValid = false;
                }


               
                if (arrMsgs.Length > 2)
                {
                    arrIndMsg = arrMsgs[1].Split('=');

                    if (arrIndMsg.Length > 1)
                    {
                        facid = arrIndMsg[1].ToString().Trim();
                    }
                    else
                    {
                        facid = "";
                    }
                    if (IsValid == true)
                    {
                        if (Regex.IsMatch(facid, @"[^0-9]"))
                        {
                            IsValid = false;
                        }
                    }
                }

               
                if (arrMsgs.Length >= 3)
                {
                    arrIndMsg = arrMsgs[2].Split('=');
                    if (arrIndMsg.Length > 1)
                    {
                        Shifts = arrIndMsg[1].ToString().Trim();
                    }
                    else
                    {
                        Shifts = "";
                    }
                }

               
                }
                if (IsValid == true)
                {
                    // to generate Vehicle type
                  //  tmscontext.GenerateVehicleType(sdate, edate, facid, rType, Shifts);


                    lblFacility.Text = tmscontext.GetIOSRequestPrint(Convert.ToDateTime(sdate), Convert.ToInt32(facid), Shifts).ElementAtOrDefault(0).facilityName.ToString();
                    lblDate.Text = tmscontext.GetIOSRequestPrint(Convert.ToDateTime(sdate), Convert.ToInt32(facid), Shifts).ElementAtOrDefault(0).ShiftDate.ToString();
                    lblShift.Text = tmscontext.GetIOSRequestPrint(Convert.ToDateTime(sdate), Convert.ToInt32(facid), Shifts).ElementAtOrDefault(0).Shift.ToString();
                       grdViewRouteDetails.DataSource = tmscontext.GetIOSRequestPrint(Convert.ToDateTime(sdate), Convert.ToInt32(facid), Shifts);
                        grdViewRouteDetails.DataBind();
                    
                    
                }
                else
                {
                    lblErrorMsg.Visible = true;
                    lblErrorMsg.Text = "No Data Found";
                }
            }
        
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    protected void dlShowRoutes_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item)
        {
            Label lblMsg;
            lblMsg = (Label)e.Item.FindControl("lblMsg");
            if (Request.QueryString["TripType"] == "D")
            {
                lblMsg.Text = "This is to validate that I have taken the drop at my destination/address as mentioned by me in company records.";
                lblMsg.Visible = true;
            }
            else
            {
                lblMsg.Visible = false;
            }
        }

        if (e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lblMsg;
            lblMsg = (Label)e.Item.FindControl("lblMsg");

            lblMsg.Text = "This is to validate that I have taken the drop at my destination/address as mentioned by me in company records.";
        }

    }
}

