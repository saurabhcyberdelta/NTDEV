using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RouteDeletion : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        lblErrorFlag.Visible = false;
        CompareValidator3.ValueToCompare = DateTime.Now.ToString("MM/dd/yyyy");
        if (!IsPostBack)
        {
            BndDdl();
            txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
        }
    }

    public void BndDdl()
    {
        //**********************************//
        //Binds Facility Dropdown          //
        //*********************************//
        try
        {
            ddlfacility.Items.Clear();
            ListItem lifac = new ListItem("Select Facility", "0");
            ddlfacility.Items.Add(lifac);
            ddlfacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlfacility.DataTextField = "facilityName";
            ddlfacility.DataValueField = "Id";
            ddlfacility.DataBind();
        }
        catch (Exception ex)
        {

            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }

    protected void ddlfacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblFacError.Visible = false;
        if (ddlfacility.SelectedIndex != 0)
        {
            BndLstShift();

        }
    }

    public void BndLstShift()
    {

        //**********************************//
        //Bind Shift Listbox              //
        //*********************************//
        try
        {
            int facid = Convert.ToInt32(ddlfacility.SelectedValue.ToString());
            string type = rdbtnlstType.SelectedValue.ToString();
            lstShift.Items.Clear();
            ListItem list = new ListItem("-Select-", "0");
            lstShift.Items.Add(list);
            lstShift.DataSource = tms.GetShiftByFacilityType(facid, type);
            lstShift.DataTextField = "shiftTime";
            lstShift.DataValueField = "shiftTime";
            lstShift.DataBind();
            lstShift.SelectedIndex = 0;
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }

    protected void rdbtnlstType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlfacility.SelectedIndex != 0)
            {

                BndLstShift();
                lblFacError.Visible = false;
            }
            else
            {

                lblFacError.Visible = true;

            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            btnSubmit.Enabled = false;
            string sDate = txtStartDate.Text;
            string rtype = rdbtnlstType.SelectedValue;
            int facId = Convert.ToInt32(ddlfacility.SelectedValue.ToString());
            string strShifttimes = string.Empty;
            if (lstShift.SelectedIndex >= 0)
            {
                for (int i = 0; i < lstShift.Items.Count; i++)
                {
                    if (lstShift.Items[i].Selected)
                    {
                        strShifttimes = strShifttimes + lstShift.Items[i].Text.Trim() + ",";
                    }
                }
                strShifttimes = strShifttimes.Remove(strShifttimes.Length - 1, 1);
            }
            var result = tms.DeleteRoutes(sDate, facId, rtype, strShifttimes,"",0, MyApplicationSession._UserID).ElementAtOrDefault(0).result.Value.ToString();
            if (result.Equals("1"))
            {
                lblErrorFlag.Text = "Routes deleted Successfully.";
                lblErrorFlag.Visible = true;
            }
            else
            {
                lblErrorFlag.Text = "An error has occurred.";
                lblErrorFlag.Visible = true;
            }
            BndDdl();
            BndLstShift();
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
        finally
        {
            btnSubmit.Enabled = true;
        }
    }
}

