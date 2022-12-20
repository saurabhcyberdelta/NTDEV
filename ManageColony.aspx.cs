using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManageColony : basepage
{
    
    DataClasses1DataContext context = new DataClasses1DataContext();

    private int _PreviousID
    {
        get { return (int)ViewState["_PreviousID"]; }
        set { ViewState["_PreviousID"] = value; }
    }
    private int _PrvPrntRowIndex
    {
        get { return (int)ViewState["_PrvPrntRowIndex"]; }
        set { ViewState["_PrvPrntRowIndex"] = value; }
    }

    private int _PrvRouteID
    {
        get { return (int)ViewState["_PrvRouteID"]; }
        set { ViewState["_PrvRouteID"] = value; }
    }

    private int _PrvRowIndex
    {
        get { return (int)ViewState["_PrvRowIndex"]; }
        set { ViewState["_PrvRowIndex"] = value; }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                _PreviousID = -1;
                _PrvRowIndex = -1;
                _PrvRouteID = -1;
                _PrvPrntRowIndex = -1;
                BindRouteSeq();
            }
            lblMessage.Text = "";
            lblMessage.Visible = false;
        }
        catch (Exception ex)
        {
            My_Error(ex);
        }
    }

    protected void BindRouteSeq()
    {
        try
        {
            if (context.GetRouteSeq(MyApplicationSession._LocationId).Count() == 0)
            {
                lblMessage.Text = "No Data Found......";
                lblMessage.Visible = true;
            }
            gvRouteSequence.DataSource = context.GetRouteSeq(MyApplicationSession._LocationId);
            gvRouteSequence.DataBind();
            foreach (GridViewRow gvMain in gvRouteSequence.Rows)
            {
                int RouteID = Convert.ToInt32(gvRouteSequence.DataKeys[gvMain.RowIndex].Value);
                GridView gvSub = (GridView)gvMain.FindControl("gvColony");
                gvSub.DataSource = context.GetRouteSeqDetail(RouteID, MyApplicationSession._LocationId);
                gvSub.DataBind();
            }
        }
        catch (Exception ex)
        {
            My_Error(ex);
        }
    }
    protected void gvRouteSequence_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            GridViewRow gvr = (GridViewRow)((ImageButton)e.CommandSource).NamingContainer;
            GridView gvSub = (GridView)gvr.FindControl("gvColony");
            ImageButton imgEx = (ImageButton)gvr.FindControl("imgbtnExpand");
            ImageButton imgCl = (ImageButton)gvr.FindControl("imgbtnClose");
            if (e.CommandName.Equals("expand"))
            {
                imgCl.Visible = true;
                imgEx.Visible = false;
                gvSub.Visible = true;
            }
            else if (e.CommandName.Equals("close"))
            {
                gvSub.Visible = false;
                imgCl.Visible = false;
                imgEx.Visible = true;
            }
        }
        catch (Exception ex)
        {
            My_Error(ex);
        }
    }
    protected void gvColony_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            GridView gvSub = (GridView)sender;
            int RouteID = Convert.ToInt32(gvSub.DataKeys[e.NewEditIndex].Values[1].ToString());
            string City = ((Label)gvSub.Rows[e.NewEditIndex].FindControl("lblCity")).Text;
            string Zone = ((Label)gvSub.Rows[e.NewEditIndex].FindControl("lblZoneName")).Text;
            string Bus = ((Label)gvSub.Rows[e.NewEditIndex].FindControl("lblBus")).Text;
            string Metro = ((Label)gvSub.Rows[e.NewEditIndex].FindControl("lblMetro")).Text;
            gvSub.DataSource = context.GetRouteSeqDetail(RouteID, MyApplicationSession._LocationId);
            gvSub.EditIndex = e.NewEditIndex;
            gvSub.DataBind();
            DropDownList ddlstbxCity = (DropDownList)gvSub.Rows[e.NewEditIndex].FindControl("ddlCity");
            ddlstbxCity.DataSource = context.GetRouteSeqCity(MyApplicationSession._LocationId);
            ddlstbxCity.DataTextField = "City";
            ddlstbxCity.DataValueField = "City";
            ddlstbxCity.DataBind();
            ddlstbxCity.SelectedIndex = ddlstbxCity.Items.IndexOf(ddlstbxCity.Items.FindByText(City));
            DropDownList ddlstbxZone = (DropDownList)gvSub.Rows[e.NewEditIndex].FindControl("ddlZoneName");
            ddlstbxZone.DataSource = context.GetRouteSeqZone(MyApplicationSession._LocationId);
            ddlstbxZone.DataTextField = "zoneName";
            ddlstbxZone.DataValueField = "zoneName";
            ddlstbxZone.DataBind();
            ddlstbxZone.SelectedIndex = ddlstbxZone.Items.IndexOf(ddlstbxZone.Items.FindByText(Zone));
            DropDownList ddlMetro = (DropDownList)gvSub.Rows[e.NewEditIndex].FindControl("ddlMetro");
            ddlMetro.SelectedIndex = ddlMetro.Items.IndexOf(ddlMetro.Items.FindByText(Metro));
            DropDownList ddlBus = (DropDownList)gvSub.Rows[e.NewEditIndex].FindControl("ddlBus");
            ddlBus.SelectedIndex = ddlBus.Items.IndexOf(ddlBus.Items.FindByText(Bus));
        }
        catch (Exception ex)
        {
            My_Error(ex);
        }
    }
    protected void gvColony_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            GridView gvSub = (GridView)sender;
            int ID = Convert.ToInt32(gvSub.DataKeys[e.RowIndex].Values[0].ToString());
            context.DeleteRouteSeqColony(ID, Session["UserID"].ToString());
            int RouteID = Convert.ToInt32(gvSub.DataKeys[e.RowIndex].Values[1].ToString());
            gvSub.DataSource = context.GetRouteSeqDetail(RouteID, MyApplicationSession._LocationId);
            gvSub.EditIndex = -1;
            gvSub.DataBind();
        }
        catch (Exception ex)
        {
            My_Error(ex);
        }
    }

    protected void gvColony_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        try
        {
            GridView gvSub = (GridView)sender;
            int RouteID = Convert.ToInt32(gvSub.DataKeys[e.RowIndex].Values[1].ToString());
            gvSub.DataSource = context.GetRouteSeqDetail(RouteID, MyApplicationSession._LocationId);
            gvSub.EditIndex = -1;
            gvSub.DataBind();
        }
        catch (Exception ex)
        {
            My_Error(ex);
        }
    }
    protected void gvColony_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            GridView gvSub = (GridView)sender;
            int rowindex = Convert.ToInt32(e.CommandArgument);
            int ID = Convert.ToInt32(gvSub.DataKeys[rowindex].Values[0].ToString());
            int RouteID = Convert.ToInt32(gvSub.DataKeys[rowindex].Values[1].ToString());
            switch (e.CommandName)
            {
                case "Insert":
                    gvSub.DataSource = context.GetRouteSeqDetail(RouteID, MyApplicationSession._LocationId);
                    gvSub.EditIndex = rowindex;
                    gvSub.DataBind();
                    TextBox txtBox = (TextBox)gvSub.Rows[rowindex].FindControl("txtColony");
                    txtBox.Text = "";
                    txtBox.Enabled = true;
                    DropDownList ddlstbxCity = (DropDownList)gvSub.Rows[rowindex].FindControl("ddlCity");
                    ddlstbxCity.DataSource = context.GetRouteSeqCity(MyApplicationSession._LocationId);
                    ddlstbxCity.DataTextField = "City";
                    ddlstbxCity.DataValueField = "City";
                    ddlstbxCity.DataBind();
                    ddlstbxCity.SelectedIndex = 0;
                    ddlstbxCity.Enabled = true;
                    DropDownList ddlstbxZone = (DropDownList)gvSub.Rows[rowindex].FindControl("ddlZoneName");
                    ddlstbxZone.DataSource = context.GetRouteSeqZone(MyApplicationSession._LocationId);
                    ddlstbxZone.DataTextField = "zoneName";
                    ddlstbxZone.DataValueField = "zoneName";
                    ddlstbxZone.DataBind();
                    ddlstbxZone.SelectedIndex = 0;
                    break;
                case "Cut":
                    _PreviousID = ID;
                    if (_PrvPrntRowIndex != -1)
                    {
                        GridView prvGvSub = (GridView)gvRouteSequence.Rows[Convert.ToInt32(_PrvPrntRowIndex)].FindControl("gvColony");
                        prvGvSub.Rows[_PrvRowIndex].BackColor = System.Drawing.Color.White;
                    }
                    gvSub.Rows[rowindex].BackColor = System.Drawing.Color.OrangeRed ;
                    _PrvRouteID =Convert.ToInt32(gvSub.DataKeys[rowindex]["RouteID"].ToString());
                    _PrvPrntRowIndex = ((GridViewRow)(gvSub.NamingContainer)).RowIndex;
                    _PrvRowIndex = rowindex;
                    break;
                case "Paste":
                    context.MoveColony(_PreviousID, ID, Session["UserID"].ToString());
                    if (_PrvRowIndex != -1)
                    {
                        GridView prvGvSub = (GridView)gvRouteSequence.Rows[Convert.ToInt32(_PrvPrntRowIndex)].FindControl("gvColony");
                        prvGvSub.DataSource = context.GetRouteSeqDetail(_PrvRouteID, MyApplicationSession._LocationId);
                        prvGvSub.DataBind();
                    }
                    gvSub.DataSource = context.GetRouteSeqDetail(RouteID, MyApplicationSession._LocationId);
                    gvSub.DataBind();
                    _PreviousID = -1;
                    break;
            }
        }
        catch (Exception ex)
        {
            My_Error(ex);
        }
    }
    protected void gvColony_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            GridView gvSub = (GridView)sender;
            int ID = Convert.ToInt32(gvSub.DataKeys[e.RowIndex].Values[0].ToString());
            string ZoneName = ((DropDownList)gvSub.Rows[e.RowIndex].FindControl("ddlZoneName")).SelectedValue;
            Boolean Bus = Boolean.Parse(((DropDownList)gvSub.Rows[e.RowIndex].FindControl("ddlBus")).SelectedValue);
            Boolean Metro = Boolean.Parse(((DropDownList)gvSub.Rows[e.RowIndex].FindControl("ddlMetro")).SelectedValue);
            int TravelTime = Convert.ToInt32(((TextBox)gvSub.Rows[e.RowIndex].FindControl("txtTravelTime")).Text);
            int TravelKm = Convert.ToInt32(((TextBox)gvSub.Rows[e.RowIndex].FindControl("txtTravelKm")).Text);

            DropDownList ddlCity = (DropDownList)gvSub.Rows[e.RowIndex].FindControl("ddlCity");
            TextBox txtColony = (TextBox)gvSub.Rows[e.RowIndex].FindControl("txtColony");

            if (ddlCity.Enabled == false && txtColony.Enabled == false)
            {
                // Update Record 
                context.UpdateRouteSeqColony(ID, ZoneName, Bus,Metro,TravelTime,TravelKm, Session["UserID"].ToString());
            }
            else
            {
                // New Record
                context.SaveRouteSeqColony(ID, ddlCity.SelectedValue, txtColony.Text, ZoneName, Bus, Metro, TravelTime, TravelKm , Session["UserID"].ToString());
            }

            int RouteID = Convert.ToInt32(gvSub.DataKeys[e.RowIndex].Values[1].ToString());
            gvSub.DataSource = context.GetRouteSeqDetail(RouteID, MyApplicationSession._LocationId);
            gvSub.EditIndex = -1;
            gvSub.DataBind();
        }

        catch (Exception ex)
        {
            My_Error(ex);
        }
    }
    private void My_Error(Exception ex)
    {
    }

}