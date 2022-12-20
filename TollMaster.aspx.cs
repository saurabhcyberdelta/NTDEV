using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TollMaster : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            bndMainGrid();
        }
    }
    void bndMainGrid()
    {
        grdToll.DataSource = tms.SelectTollMaster(MyApplicationSession._UserID,"Y","");
        grdToll.DataBind();
        if (grdToll.Rows.Count > 0)
        {
            MultiView1.ActiveViewIndex = 0;
        }
        else
        {
            MultiView1.ActiveViewIndex = 1;
            bndDvtoll();
            
            
        }


    }
    public Boolean getVisibleactivated(object act)
    {
        int ac = Convert.ToInt32(act);
        if (ac == 0)
        {
            return true;
        }
        return false;
    }
    public Boolean getVisibledeactivated(object act)
    {
        int ac = Convert.ToInt32(act);
        if (ac == 0)
        {
            return false;
        }
        return true;
    }

    public string getTextName(object act)
    {
        int ac = Convert.ToInt32(act);
        if (ac == 0)
        {
            return "Active";
        }
        else
        {
            return "Deactive";
        }
    }
    protected void lbtnAddToll_Click(object sender, EventArgs e)
    {
        try
        {
            bndDvtoll();

            //((TextBox)dvToll.FindControl("txtdvTollName")).Text = "";
            //((TextBox)dvToll.FindControl("txtdvTollCost")).Text = "";
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    private void bndDvtoll()
    {
        DropDownList ddlFacility = ((DropDownList)dvToll.FindControl("ddldvFacilityAdd"));
        TextBox txtEfectiveDate = ((TextBox)dvToll.FindControl("txtdvEffectiveDate"));
        TextBox txtTollName = ((TextBox)dvToll.FindControl("txtdvTollName"));
        TextBox txtRate = ((TextBox)dvToll.FindControl("txtdvTollCost"));
        ddlFacility.Items.Clear();
        ListItem lstFac = new ListItem("-Select-", "0");
        ddlFacility.Items.Add(lstFac);
        ddlFacility.DataSource = tms.GetFacility(MyApplicationSession._LocationId);
        ddlFacility.DataTextField = "facilityName";
        ddlFacility.DataValueField = "Id";
        ddlFacility.DataBind();

        txtEfectiveDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
        txtRate.Text = string.Empty;
        txtTollName.Text = string.Empty;
        MultiView1.ActiveViewIndex = 1;
    }
    
    protected void dvToll_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        try
        {
            String TollName = ((TextBox)dvToll.FindControl("txtdvTollName")).Text;
            int TollCost = Convert.ToInt32(((TextBox)dvToll.FindControl("txtdvTollCost")).Text);
            DateTime sDate = Convert.ToDateTime(((TextBox)dvToll.FindControl("txtdvEffectiveDate")).Text);
            int facId = Convert.ToInt32(((DropDownList)dvToll.FindControl("ddldvFacilityAdd")).SelectedValue);
            string result = tms.InsertNewToll(TollName, TollCost, MyApplicationSession._UserID, facId, sDate).ElementAtOrDefault(0).RESULT.ToString();
            if (result.Equals("1"))
            {
                ShowMessage("Record Updated Successfully!");
                //lblMsg.Visible = true;
            }
            else if (result.Equals("2"))
            {
                ShowMessage("Record already exists./ effective date can not be less than previous date.!");
            }
            else
            {
                ShowMessage("Record Added Successfully!");
                //lblMsg.Visible = true;
            }
            MultiView1.ActiveViewIndex = 0;
            bndMainGrid();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }

    protected void dvToll_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        bndMainGrid();
    }
    protected void lbActivate_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow gvr = (GridViewRow)btn.NamingContainer;
        int rowindex = gvr.RowIndex;
        string id = grdToll.DataKeys[rowindex]["id"].ToString();
        string res=tms.ActivateDeactivateToll(Convert.ToInt32(id),1, MyApplicationSession._UserID).ElementAtOrDefault(0).RESULT.ToString();
        if (res.Equals("1"))
        {
            ShowMessage("Record Deactivated Successfully!");
        }
        else
        {
            ShowMessage("Record Alredy Exists!");
        }
        bndMainGrid();
    }
    protected void lbDeactivate_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow gvr = (GridViewRow)btn.NamingContainer;
        int rowindex = gvr.RowIndex;
        string id = grdToll.DataKeys[rowindex]["id"].ToString();
        string res = tms.ActivateDeactivateToll(Convert.ToInt32(id), 0, MyApplicationSession._UserID).ElementAtOrDefault(0).RESULT.ToString();
        if (res.Equals("1"))
        {
            ShowMessage("Record Activated Successfully!");
        }
        else
        {
            ShowMessage("Record Alredy Exists!");
        }
        bndMainGrid();
    }

    private void ShowMessage(string mesg)
    {
        string jScript = "alert('" + mesg + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Updated", jScript, true);

    }
    protected void btnTollChange_Click(object sender, EventArgs e)
    {
        try
        {
            MultiView1.ActiveViewIndex = 2;
            DropDownList ddlFacility = ((DropDownList)dvTollChange.FindControl("ddldvFacilityChange"));
            TextBox txtEfectiveDate = ((TextBox)dvTollChange.FindControl("txtEffectiveDate"));
            TextBox txtTollName = ((TextBox)dvTollChange.FindControl("txtdvTollName"));
            TextBox txtRate = ((TextBox)dvTollChange.FindControl("txtdvTollCost"));
            ddlFacility.Items.Clear();
            ListItem lstFac = new ListItem("-Select-", "0");
            ddlFacility.Items.Add(lstFac);
            ddlFacility.DataSource = tms.GetFacility(MyApplicationSession._LocationId);
            ddlFacility.DataTextField = "facilityName";
            ddlFacility.DataValueField = "Id";
            ddlFacility.DataBind();


        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
}
