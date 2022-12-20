using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class AddressChange : basepage2
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           // PanelShowHide();
            FillDatetext();
            FillLabels();
            lblDatecheck.Text =Convert.ToDateTime(txtCalendar.Text).ToString("MM/dd/yyyy");
            bndrequestGrid();
          
        }
    }
    protected void bndrequestGrid()
    {
        gvChangeRequests.DataSource = tms.getAddressChangeDetails(MyApplicationSession._UserID);
        gvChangeRequests.DataBind();
        if (gvChangeRequests.Rows.Count > 0)
        {
           
        }
    }
    protected void FillLabels()
    {
        var result = tms.GetEmployee(MyApplicationSession._UserID);
        foreach (var r in result)
        {
            lblEmployeeID.Text = r.empCode;
            lblEmployeeName.Text = r.empName;
            lblPrimaryAddress.Text = r.address;
            lblPrimaryLdmrk.Text = r.Landmark;
           
        }
    }
    
    protected void btnSave_Click(object sender, EventArgs e)
    {
        String result;
        string NewAddress = txtNewaddress.Text;
        string Oldaddress = null;
        Oldaddress = lblPrimaryAddress.Text;
    
        if (NewAddress.TrimEnd().TrimStart() == Oldaddress.TrimEnd().TrimStart())
        {
           // hidecontrols();
            lblMsg.Text= "No change reflected in address.Please change the address";
            lblMsg.Visible = true;
        }
        else
        {

            result = tms.ValidateEffectiveDate(Convert.ToDateTime(txtCalendar.Text),MyApplicationSession._FacilityID).ElementAtOrDefault(0).Result.ToString();
            if (result == "0")
            {

                lblMsg.Text = "Address change effective date should be greater than 2 days from Today";
                lblMsg.Visible = true;
                
            }
            else
            {
                multiview2.ActiveViewIndex = 0;
                ModalPopupExtender1.Show();
                lblMsg.Visible = false;
            
            }

        }
        
    }
    private void ShowMessage(string message)
    {
        try
        {
            string jScript = "alert('" + message + "');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);


        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void FillDatetext()
    {
        String Days = tms.GetAddressDateLock(MyApplicationSession._FacilityID).ElementAtOrDefault(0).configValue.ToString();
        DateTime Date = DateTime.Today.AddDays(Convert.ToDouble(Convert.ToInt32(Days) + 1));
        txtCalendar.Text = Date.ToString("MM/dd/yyyy");
        
    }
    protected void btnClose_Click(object sender, ImageClickEventArgs e)
    {
        hidecontrols();
        ModalPopupExtender1.Hide();
    }
    protected void btnAgree_Click(object sender, EventArgs e)
    {
     String res  = tms.AddAddressChange(MyApplicationSession._UserID, txtNewaddress.Text, Convert.ToDateTime(txtCalendar.Text),DateTime.Today).ElementAtOrDefault(0).result.ToString();
   
        ModalPopupExtender1.Hide();
        FillDatetext();
        //PanelShowHide();
        FillLabels();
        FillDatetext();
        bndrequestGrid();
        txtNewaddress.Text="";
       


        lblMsg.Visible = true;
        lblMsg.Text = res;
        
    }
      protected void hidecontrols()
    {
        Panel4.Enabled = false;
        btnClose.Enabled = false;
        btnDisagree.Enabled = false;
        btnAgree.Enabled = false;
        Button2.Enabled = false;
        
        
       
        Panel4.Visible = false;
        btnClose.Visible = false;
        btnDisagree.Visible = false;
        btnAgree.Visible = false;
      
    }
    protected void showcontrols()
    {
        
        Panel4.Visible = true;
        btnClose.Visible = true;
        btnDisagree.Visible = true;
        btnAgree.Visible = true;
        Panel4.Enabled = true;
        btnClose.Enabled = true;
        btnDisagree.Enabled = true;
        btnAgree.Enabled = true;
      
    }
}

