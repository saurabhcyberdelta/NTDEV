using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CostMaster2 : basepage
{

    
    public int _level { get { return (int)ViewState["_level"]; } set { ViewState["_level"]=value;} }
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            _level = 0;
            //mvCost.ActiveViewIndex = 0;

            
        }
    }
    void bndGridCost()
    {
        gvSlabCost.DataSource = tms.GetSlabCost(Convert.ToInt32(ddlSelectSlabFacility.SelectedValue));
        gvSlabCost.DataBind();
       
        if (MyApplicationSession._ISAdmin == true)
        {
            gvSlabCost.Columns[10].Visible = true;
        }
        else
        {
            gvSlabCost.Columns[10].Visible = false;
        }
        BndDvDropDown();
    }
    void bndMedicalGridCost()
    {
        gvMedicalCost.DataSource = tms.GetMedicalCost(Convert.ToInt32(ddlSelectMedicalFacility.SelectedValue));
        gvMedicalCost.DataBind();

        if (MyApplicationSession._ISAdmin == true)
        {
            gvMedicalCost.Columns[12].Visible = true;
        }
        else
        {
            gvMedicalCost.Columns[12].Visible = false;
        }

        BndMedicalDvDropDown();

    }
    void bndAdditionalGridCost()
    {
        gvAdditionalCost.DataSource = tms.GetAdditionCost(Convert.ToInt32(ddlSelectAdditionalFacility.SelectedValue));
        gvAdditionalCost.DataBind();

        if (MyApplicationSession._ISAdmin == true)
        {
            gvAdditionalCost.Columns[10].Visible = true;
        }
        else
        {
            gvAdditionalCost.Columns[10].Visible = false;
        }

        BndAdditionalDvDropDown();

    }
    protected void bndfacilitydrop()
    {
        ddlSelectSlabFacility.Items.Clear();
        ddlSelectSlabFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
        ddlSelectSlabFacility.DataTextField = "facilityName";
        ddlSelectSlabFacility.DataValueField = "Id";
        ddlSelectSlabFacility.DataBind();
        ListItem liFacIn = new ListItem("-Select Facility-", "-1");
        ListItem liFacInAll = new ListItem("All Facility", "0");
        ddlSelectSlabFacility.Items.Insert(0,liFacIn);
        ddlSelectSlabFacility.Items.Insert(1,liFacInAll);

        ddlSelectSlabFacility.SelectedIndex = ddlSelectSlabFacility.Items.IndexOf(ddlSelectSlabFacility.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));


    }
    protected void bndMedicalfacilitydrop()
    {
        ddlSelectMedicalFacility.Items.Clear();
        ddlSelectMedicalFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
        ddlSelectMedicalFacility.DataTextField = "facilityName";
        ddlSelectMedicalFacility.DataValueField = "Id";
        ddlSelectMedicalFacility.DataBind();
        ListItem liFacIn = new ListItem("-Select Facility-", "-1");
        ListItem liFacInAll = new ListItem("All Facility", "0");
        ddlSelectMedicalFacility.Items.Insert(0, liFacIn);
        ddlSelectMedicalFacility.Items.Insert(1, liFacInAll);

        ddlSelectMedicalFacility.SelectedIndex = ddlSelectMedicalFacility.Items.IndexOf(ddlSelectMedicalFacility.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));


    }
    protected void bndAdditionalfacilitydrop()
    {
        ddlSelectAdditionalFacility.Items.Clear();
        ddlSelectAdditionalFacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
        ddlSelectAdditionalFacility.DataTextField = "facilityName";
        ddlSelectAdditionalFacility.DataValueField = "Id";
        ddlSelectAdditionalFacility.DataBind();
        ListItem liFacIn = new ListItem("-Select Facility-", "-1");
        ListItem liFacInAll = new ListItem("All Facility", "0");
        ddlSelectAdditionalFacility.Items.Insert(0, liFacIn);
        ddlSelectAdditionalFacility.Items.Insert(1, liFacInAll);

        ddlSelectAdditionalFacility.SelectedIndex = ddlSelectAdditionalFacility.Items.IndexOf(ddlSelectAdditionalFacility.Items.FindByValue(MyApplicationSession._FacilityID.ToString()));


    }
    protected void BndDvDropDown()
    {
        DropDownList ddlveh = (DropDownList)dvSlabCost.FindControl("ddlVehicleType");
        ddlveh.Items.Clear();
        ListItem liveh = new ListItem("Select Vehicle", "0");
        ddlveh.Items.Add(liveh);
        ddlveh.DataSource = tms.GetVehicleType();
        ddlveh.DataTextField = "vehicle";
        ddlveh.DataValueField = "Id";
        ddlveh.DataBind();
        DropDownList ddlVendor = (DropDownList)dvSlabCost.FindControl("ddlVendor");
        ListItem livev = new ListItem("Select Vendor", "-1");
        ListItem livevall = new ListItem("All Vendor", "0");
        ddlVendor.Items.Clear();
        ddlVendor.Items.Add(livev);
        ddlVendor.Items.Add(livevall);
        ddlVendor.DataSource = tms.GetVendorByFac(Convert.ToInt32(ddlSelectSlabFacility.SelectedValue));
        ddlVendor.DataTextField = "vendorName";
        ddlVendor.DataValueField = "Id";
        ddlVendor.DataBind();

    }
    protected void BndMedicalDvDropDown()
    {
        DropDownList ddlveh = (DropDownList)dvMedicalCost.FindControl("ddlVehicleTypem");
        ddlveh.Items.Clear();
        ListItem liveh = new ListItem("Select Vehicle", "0");
        ddlveh.Items.Add(liveh);
        ddlveh.DataSource = tms.GetVehicleType();
        ddlveh.DataTextField = "vehicle";
        ddlveh.DataValueField = "Id";
        ddlveh.DataBind();
        DropDownList ddlVendor = (DropDownList)dvMedicalCost.FindControl("ddlVendorm");
        ListItem livev = new ListItem("Select Vendor", "-1");
        ListItem livevAll = new ListItem("All Vendor", "0");
        ddlVendor.Items.Clear();
        ddlVendor.Items.Add(livev);
        ddlVendor.Items.Add(livevAll);
        ddlVendor.DataSource = tms.GetVendorByFac(Convert.ToInt32(ddlSelectMedicalFacility.SelectedValue));
        ddlVendor.DataTextField = "vendorName";
        ddlVendor.DataValueField = "Id";
        ddlVendor.DataBind();

    }
    protected void BndAdditionalDvDropDown()
    {
        DropDownList ddlveh = (DropDownList)dvAdditionalCost.FindControl("ddlVehicleTypea");
        ddlveh.Items.Clear();
        ListItem liveh = new ListItem("Select Vehicle", "0");
        ddlveh.Items.Add(liveh);
        ddlveh.DataSource = tms.GetVehicleType();
        ddlveh.DataTextField = "vehicle";
        ddlveh.DataValueField = "Id";
        ddlveh.DataBind();
        DropDownList ddlVendor = (DropDownList)dvAdditionalCost.FindControl("ddlVendora");
        ListItem livev = new ListItem("Select Vendor", "-1");
        ListItem livevall = new ListItem("All Vendor", "0");
        ddlVendor.Items.Clear();
        ddlVendor.Items.Add(livev);
        ddlVendor.Items.Add(livevall);
        ddlVendor.DataSource = tms.GetVendorByFac(Convert.ToInt32(ddlSelectAdditionalFacility.SelectedValue));
        ddlVendor.DataTextField = "vendorName";
        ddlVendor.DataValueField = "Id";
        ddlVendor.DataBind();

    }
    protected void ddlSelectSlabFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndGridCost();
        mvSlab.ActiveViewIndex = 0;
    }
    protected void ddlVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtnewFuelRate_TextChanged(sender, e);
    }
    protected void ddlVehicleType_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtnewFuelRate_TextChanged(sender, e);
    }
    protected void txtEffectiveDate_TextChanged(object sender, EventArgs e)
    {
        txtnewFuelRate_TextChanged(sender, e);
    }
    protected void txtStartKm_TextChanged(object sender, EventArgs e)
    {
        txtnewFuelRate_TextChanged(sender, e);
    }
    protected void txtnewFuelRatem_TextChanged(object sender, EventArgs e)
    {
        DropDownList ddlveh = (DropDownList)dvMedicalCost.FindControl("ddlVehicleTypem");
        TextBox effectiveDate = (TextBox)dvMedicalCost.FindControl("txtEffectiveDatem");
        TextBox NewRate = (TextBox)dvMedicalCost.FindControl("txtnewRatem");
        TextBox FuelRate = (TextBox)dvMedicalCost.FindControl("txtnewFuelRatem");
        TextBox StartKm = (TextBox)dvMedicalCost.FindControl("txtStartKmm");
        DropDownList ddlVendor = (DropDownList)dvMedicalCost.FindControl("ddlVendorm");

        //if (StartKm.Text == "")
        //{
        //    //ShowMessage("Please enter start km slab.");
        //}
        //else
        //{
        //    string kmrate = tms.GetDieselBasisKmRate(Convert.ToInt32(ddlSelectSlabFacility.SelectedValue), Convert.ToDateTime(effectiveDate.Text), Convert.ToInt32(ddlVendor.SelectedValue), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToInt32(StartKm.Text), Convert.ToDouble(FuelRate.Text)).ElementAtOrDefault(0).Kmrate.ToString();
        //    NewRate.Text = kmrate;
        //}
    }
    protected void txtnewFuelRate_TextChanged(object sender, EventArgs e)
    {
        DropDownList ddlveh = (DropDownList)dvSlabCost.FindControl("ddlVehicleType");
        TextBox effectiveDate = (TextBox)dvSlabCost.FindControl("txtEffectiveDate");
        TextBox NewRate = (TextBox)dvSlabCost.FindControl("txtnewRate");
        TextBox FuelRate = (TextBox)dvSlabCost.FindControl("txtnewFuelRate");
        TextBox StartKm = (TextBox)dvSlabCost.FindControl("txtStartKm");
        DropDownList ddlVendor = (DropDownList)dvSlabCost.FindControl("ddlVendor");
        if (StartKm.Text == "" || FuelRate.Text == "")
        {
            //ShowMessage("Please enter start km slab.");
        }
        else
        {
            string kmrate = tms.GetDieselBasisKmRate(Convert.ToInt32(ddlSelectSlabFacility.SelectedValue), Convert.ToDateTime(effectiveDate.Text), Convert.ToInt32(ddlVendor.SelectedValue), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToInt32(StartKm.Text), Convert.ToDouble(FuelRate.Text)).ElementAtOrDefault(0).Kmrate.ToString();
            NewRate.Text = kmrate;
        }
       
    }
    
    protected void ddlSelectMedicalFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndMedicalGridCost();
        mvMedical.ActiveViewIndex = 0;
    }
    protected void ddlSelectAdditionalFacility_SelectedIndexChanged(object sender, EventArgs e)
    {
        bndAdditionalGridCost();
        mvAdditional.ActiveViewIndex = 0;
    }
    protected void dvSlabCost_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        DropDownList ddlveh = (DropDownList)dvSlabCost.FindControl("ddlVehicleType");
        TextBox effectiveDate = (TextBox)dvSlabCost.FindControl("txtEffectiveDate");
        TextBox NewRate = (TextBox)dvSlabCost.FindControl("txtnewRate");
        TextBox FuelRate = (TextBox)dvSlabCost.FindControl("txtnewFuelRate");
        TextBox StartKm = (TextBox)dvSlabCost.FindControl("txtStartKm");
        TextBox EndKm = (TextBox)dvSlabCost.FindControl("txtEndKm");
        DropDownList ddlVendor = (DropDownList)dvSlabCost.FindControl("ddlVendor");
        CheckBox chkAllFacility = (CheckBox)dvSlabCost.FindControl("chkAllfacility");
        if (chkAllFacility.Checked==false)
        {
            if (_level == 1)
            {
                String Result = tms.AddSlabCost(Convert.ToInt32(ddlSelectSlabFacility.SelectedValue), Convert.ToDateTime(effectiveDate.Text), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToDouble(NewRate.Text), Convert.ToInt32(ddlVendor.SelectedValue), Convert.ToDouble(StartKm.Text), Convert.ToDouble(EndKm.Text), MyApplicationSession._UserID, Convert.ToDouble(FuelRate.Text)).ElementAtOrDefault(0).Result.ToString();
                if (Result == "1")
                {
                    //lblErrorMsg.Visible = false;
                    mvSlab.ActiveViewIndex = 0;
                    bndGridCost();
                    ShowMessage("Record added successfully!");
                }
                else
                {
                    ShowMessage("Record already exists!");
                    //lblErrorMsg.Text = "Date Could Not be less than the Past Dates";
                    //lblErrorMsg.Visible = true;
                }
            }
            else
            {
                String Result = tms.ChangeSlabCost(Convert.ToInt32(ddlSelectSlabFacility.SelectedValue), Convert.ToDateTime(effectiveDate.Text), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToDouble(NewRate.Text), Convert.ToInt32(ddlVendor.SelectedValue), Convert.ToDouble(StartKm.Text), Convert.ToDouble(EndKm.Text), MyApplicationSession._UserID, Convert.ToDouble(FuelRate.Text)).ElementAtOrDefault(0).Result.ToString();
                if (Result == "1")
                {
                    //lblErrorMsg.Visible = false;
                    mvSlab.ActiveViewIndex = 0;
                    bndGridCost();
                    ShowMessage("Record added successfully!");
                }
                else if (Result == "2")
                {
                    ShowMessage("Record not exists!");
                }
                else if (Result == "3")
                {
                    ShowMessage("Cost already exists!");
                }
                else
                {
                    ShowMessage("Date Could Not be less than the Past Dates!");
                    //lblErrorMsg.Text = "Date Could Not be less than the Past Dates";
                    //lblErrorMsg.Visible = true;
                }
            }  
        }
        else
        {
            if (_level == 1)
            {
                String Result = tms.AddSlabCost(Convert.ToInt32(0), Convert.ToDateTime(effectiveDate.Text), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToDouble(NewRate.Text), Convert.ToInt32(0), Convert.ToDouble(StartKm.Text), Convert.ToDouble(EndKm.Text), MyApplicationSession._UserID, Convert.ToDouble(FuelRate.Text)).ElementAtOrDefault(0).Result.ToString();
                if (Result == "1")
                {
                    //lblErrorMsg.Visible = false;
                    mvSlab.ActiveViewIndex = 0;
                    bndGridCost();
                    ShowMessage("Record added successfully!");
                }
                else
                {
                    ShowMessage("Record already exists!");
                    //lblErrorMsg.Text = "Date Could Not be less than the Past Dates";
                    //lblErrorMsg.Visible = true;
                }
            }
            else
            {
                String Result = tms.ChangeSlabCost(Convert.ToInt32(0), Convert.ToDateTime(effectiveDate.Text), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToDouble(NewRate.Text), Convert.ToInt32(0), Convert.ToDouble(StartKm.Text), Convert.ToDouble(EndKm.Text), MyApplicationSession._UserID, Convert.ToDouble(FuelRate.Text)).ElementAtOrDefault(0).Result.ToString();
                if (Result == "1")
                {
                    //lblErrorMsg.Visible = false;
                    mvSlab.ActiveViewIndex = 0;
                    bndGridCost();
                    ShowMessage("Record added successfully!");
                }
                else if (Result == "2")
                {
                    ShowMessage("Record not exists!");
                }
                else if (Result == "3")
                {
                    ShowMessage("Cost already exists!");
                }
                else if (Result == "4")
                {
                    ShowMessage("Please Enter Valid Cost/ Effective Date!");
                }
                else
                {
                    ShowMessage("Date Could Not be less than the Past Dates!");
                    //lblErrorMsg.Text = "Date Could Not be less than the Past Dates";
                    //lblErrorMsg.Visible = true;
                }
            }
        }
        //chkAllFacility.Checked = false;
    }
    protected void dvMedicalCost_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        DropDownList ddlveh = (DropDownList)dvMedicalCost.FindControl("ddlVehicleTypem");
        TextBox effectiveDate = (TextBox)dvMedicalCost.FindControl("txtEffectiveDatem");
        TextBox NewRate = (TextBox)dvMedicalCost.FindControl("txtnewRatem");
        TextBox FuelRate = (TextBox)dvMedicalCost.FindControl("txtnewFuelRatem");
        TextBox StartKm = (TextBox)dvMedicalCost.FindControl("txtStartKmm");
        TextBox EndKm = (TextBox)dvMedicalCost.FindControl("txtEndKmm");
        TextBox StartShift = (TextBox)dvMedicalCost.FindControl("txtStartShift");
        TextBox EndShift = (TextBox)dvMedicalCost.FindControl("txtEndShift");
        DropDownList ddlVendor = (DropDownList)dvMedicalCost.FindControl("ddlVendorm");
        CheckBox chkAllFacility = (CheckBox)dvMedicalCost.FindControl("chkAllfacility");
        if (chkAllFacility.Checked == false)
        {
            if (_level == 1)
            {
                String Result = tms.InsertMedicalCost(Convert.ToInt32(ddlSelectMedicalFacility.SelectedValue), Convert.ToInt32(ddlVendor.SelectedValue), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToDouble(StartKm.Text), Convert.ToDouble(EndKm.Text), (StartShift.Text), (EndShift.Text), Convert.ToDouble(NewRate.Text), Convert.ToDateTime(effectiveDate.Text), MyApplicationSession._UserID, Convert.ToDouble(FuelRate.Text)).ElementAtOrDefault(0).result.ToString();
                if (Result == "1")
                {
                    //lblErrorMsg.Visible = false;
                    mvMedical.ActiveViewIndex = 0;
                    bndMedicalGridCost();
                    ShowMessage("Record added successfully!");
                }
                else
                {
                    ShowMessage("Record already exists!");
                    //lblErrorMsg.Text = "Date Could Not be less than the Past Dates";
                    //lblErrorMsg.Visible = true;
                }
            }
            else
            {
                String Result = tms.ChangeMedicalCost(Convert.ToInt32(ddlSelectMedicalFacility.SelectedValue), Convert.ToInt32(ddlVendor.SelectedValue), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToDouble(StartKm.Text), Convert.ToDouble(EndKm.Text), (StartShift.Text), (EndShift.Text), Convert.ToDouble(NewRate.Text), Convert.ToDateTime(effectiveDate.Text), MyApplicationSession._UserID, Convert.ToDouble(FuelRate.Text)).ElementAtOrDefault(0).result.ToString();
                if (Result == "1")
                {
                    //lblErrorMsg.Visible = false;
                    mvMedical.ActiveViewIndex = 0;
                    bndMedicalGridCost();
                    ShowMessage("Record added successfully!");
                }
                else if (Result == "2")
                {
                    ShowMessage("Record not exists!");
                }
                else if (Result == "3")
                {
                    ShowMessage("Cost already exists!");
                }
                else
                {
                    ShowMessage("Date Could Not be less than the Past Dates!");
                    //lblErrorMsg.Text = "Date Could Not be less than the Past Dates";
                    //lblErrorMsg.Visible = true;
                }
            }
        }
        else
        {
            if (_level == 1)
            {
                String Result = tms.InsertMedicalCost(Convert.ToInt32(0), Convert.ToInt32(0), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToDouble(StartKm.Text), Convert.ToDouble(EndKm.Text), (StartShift.Text), (EndShift.Text), Convert.ToDouble(NewRate.Text), Convert.ToDateTime(effectiveDate.Text), MyApplicationSession._UserID, Convert.ToDouble(FuelRate.Text)).ElementAtOrDefault(0).result.ToString();
                if (Result == "1")
                {
                    //lblErrorMsg.Visible = false;
                    mvMedical.ActiveViewIndex = 0;
                    bndMedicalGridCost();
                    ShowMessage("Record added successfully!");
                }
                else
                {
                    ShowMessage("Record already exists!");
                    //lblErrorMsg.Text = "Date Could Not be less than the Past Dates";
                    //lblErrorMsg.Visible = true;
                }
            }
            else
            {
                String Result = tms.ChangeMedicalCost(Convert.ToInt32(0), Convert.ToInt32(0), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToDouble(StartKm.Text), Convert.ToDouble(EndKm.Text), (StartShift.Text), (EndShift.Text), Convert.ToDouble(NewRate.Text), Convert.ToDateTime(effectiveDate.Text), MyApplicationSession._UserID, Convert.ToDouble(FuelRate.Text)).ElementAtOrDefault(0).result.ToString();
                if (Result == "1")
                {
                    //lblErrorMsg.Visible = false;
                    mvMedical.ActiveViewIndex = 0;
                    bndMedicalGridCost();
                    ShowMessage("Record added successfully!");
                }
                else if (Result == "2")
                {
                    ShowMessage("Record not exists!");
                }
                else if (Result == "3")
                {
                    ShowMessage("Cost already exists!");
                }
                else if (Result == "4")
                {
                    ShowMessage("Please Enter Valid Cost/ Effective Date!");
                }
                else
                {
                    ShowMessage("Date Could Not be less than the Past Dates!");
                    //lblErrorMsg.Text = "Date Could Not be less than the Past Dates";
                    //lblErrorMsg.Visible = true;
                }
            }
        }
        
    }
    protected void dvAdditionalCost_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        DropDownList ddlveh = (DropDownList)dvAdditionalCost.FindControl("ddlVehicleTypea");
        TextBox effectiveDate = (TextBox)dvAdditionalCost.FindControl("txtEffectiveDatea");
        TextBox NewRate = (TextBox)dvAdditionalCost.FindControl("txtnewRatea");
        TextBox FuelRate = (TextBox)dvAdditionalCost.FindControl("txtnewFuelRatea");
        TextBox StartKm = (TextBox)dvAdditionalCost.FindControl("txtStartKma");
        TextBox Workinghr = (TextBox)dvAdditionalCost.FindControl("txtWorkinghr");
        DropDownList ddlVendor = (DropDownList)dvAdditionalCost.FindControl("ddlVendora");
        CheckBox chkAllFacility = (CheckBox)dvAdditionalCost.FindControl("chkAllfacility");
        if (chkAllFacility.Checked == false)
        {
            if (_level == 1)
            {
                String Result = tms.InsertAdditionalCabCost(Convert.ToInt32(ddlSelectAdditionalFacility.SelectedValue), Convert.ToInt32(ddlVendor.SelectedValue), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToInt32(Workinghr.Text), Convert.ToDouble(StartKm.Text), Convert.ToDouble(NewRate.Text), Convert.ToDateTime(effectiveDate.Text), MyApplicationSession._UserID, Convert.ToDouble(FuelRate.Text)).ElementAtOrDefault(0).result.ToString();
                if (Result == "1")
                {
                    //lblErrorMsg.Visible = false;
                    mvAdditional.ActiveViewIndex = 0;
                    bndAdditionalGridCost();
                    ShowMessage("Record added successfully!");
                }
                else
                {
                    ShowMessage("Record already exists!");
                    //lblErrorMsg.Text = "Date Could Not be less than the Past Dates";
                    //lblErrorMsg.Visible = true;
                }
            }
            else
            {
                String Result = tms.ChangeAddtitionalCabCost(Convert.ToInt32(ddlSelectAdditionalFacility.SelectedValue), Convert.ToInt32(ddlVendor.SelectedValue), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToInt32(Workinghr.Text), Convert.ToDouble(StartKm.Text), Convert.ToDouble(NewRate.Text), Convert.ToDateTime(effectiveDate.Text), MyApplicationSession._UserID, Convert.ToDouble(FuelRate.Text)).ElementAtOrDefault(0).result.ToString();
                if (Result == "1")
                {
                    //lblErrorMsg.Visible = false;
                    mvAdditional.ActiveViewIndex = 0;
                    bndAdditionalGridCost();
                    ShowMessage("Record added successfully!");
                }
                else if (Result == "2")
                {
                    ShowMessage("Record not exists!");
                }
                else if (Result == "3")
                {
                    ShowMessage("Cost already exists!");
                }
                else
                {
                    ShowMessage("Date Could Not be less than the Past Dates!");
                    //lblErrorMsg.Text = "Date Could Not be less than the Past Dates";
                    //lblErrorMsg.Visible = true;
                }
            }
        }
        else
        {
            if (_level == 1)
            {
                String Result = tms.InsertAdditionalCabCost(Convert.ToInt32(0), Convert.ToInt32(0), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToInt32(Workinghr.Text), Convert.ToDouble(StartKm.Text), Convert.ToDouble(NewRate.Text), Convert.ToDateTime(effectiveDate.Text), MyApplicationSession._UserID, Convert.ToDouble(FuelRate.Text)).ElementAtOrDefault(0).result.ToString();
                if (Result == "1")
                {
                    //lblErrorMsg.Visible = false;
                    mvAdditional.ActiveViewIndex = 0;
                    bndAdditionalGridCost();
                    ShowMessage("Record added successfully!");
                }
                else
                {
                    ShowMessage("Record already exists!");
                    //lblErrorMsg.Text = "Date Could Not be less than the Past Dates";
                    //lblErrorMsg.Visible = true;
                }
            }
            else
            {
                String Result = tms.ChangeAddtitionalCabCost(Convert.ToInt32(0), Convert.ToInt32(0), Convert.ToInt32(ddlveh.SelectedValue), Convert.ToInt32(Workinghr.Text), Convert.ToDouble(StartKm.Text), Convert.ToDouble(NewRate.Text), Convert.ToDateTime(effectiveDate.Text), MyApplicationSession._UserID, Convert.ToDouble(FuelRate.Text)).ElementAtOrDefault(0).result.ToString();
                if (Result == "1")
                {
                    //lblErrorMsg.Visible = false;
                    mvAdditional.ActiveViewIndex = 0;
                    bndAdditionalGridCost();
                    ShowMessage("Record added successfully!");
                }
                else if (Result == "2")
                {
                    ShowMessage("Record not exists!");
                }
                else if (Result == "3")
                {
                    ShowMessage("Cost already exists!");
                }
                else if (Result == "4")
                {
                    ShowMessage("Please Enter Valid Cost/ Effective Date!");
                }
                else
                {
                    ShowMessage("Date Could Not be less than the Past Dates!");
                    //lblErrorMsg.Text = "Date Could Not be less than the Past Dates";
                    //lblErrorMsg.Visible = true;
                }
            }
        }
        
    }
    protected void gvSlabCost_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            //string vendor = ((Label)gvSlabCost.Rows[e.NewEditIndex].FindControl("lblVendor")).Text;
            //string vehicle = ((Label)gvSlabCost.Rows[e.NewEditIndex].FindControl("lblVehicle")).Text;
            //string KmRate = ((Label)gvSlabCost.Rows[e.NewEditIndex].FindControl("txtgvKmRate")).Text;

            gvSlabCost.EditIndex = e.NewEditIndex;
            bndGridCost();

            //DropDownList ddlVendor = ((DropDownList)gvSlabCost.Rows[e.NewEditIndex].FindControl("ddlgvVendor"));
            //DropDownList ddlVehicle = ((DropDownList)gvSlabCost.Rows[e.NewEditIndex].FindControl("ddlgvVehicle"));
            //ListItem lstVen = new ListItem("-Select-", "0");
            //ListItem lstVeh = new ListItem("-Select-", "0");
            //ddlVendor.Items.Clear();
            //ddlVehicle.Items.Clear();
            //ddlVendor.DataSource = tms.GetVendorByFac(Convert.ToInt32(ddlSelectSlabFacility.SelectedValue));
            //ddlVendor.Items.Add(lstVen);
            //ddlVendor.DataTextField = "vendorName";
            //ddlVendor.DataValueField = "Id";
            //ddlVendor.DataBind();
            //ddlVendor.SelectedIndex = ddlVendor.Items.IndexOf(ddlVendor.Items.FindByText(vendor));

            //ddlVehicle.DataSource = tms.GetVehicleType();
            //ddlVehicle.Items.Add(lstVen);
            //ddlVehicle.DataTextField = "vehicle";
            //ddlVehicle.DataValueField = "Id";
            //ddlVehicle.DataBind();
            //ddlVehicle.SelectedIndex = ddlVehicle.Items.IndexOf(ddlVehicle.Items.FindByText(vehicle));
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void gvMedicalCost_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            //string vendor = ((Label)gvSlabCost.Rows[e.NewEditIndex].FindControl("lblVendor")).Text;
            //string vehicle = ((Label)gvSlabCost.Rows[e.NewEditIndex].FindControl("lblVehicle")).Text;
            //string KmRate = ((Label)gvSlabCost.Rows[e.NewEditIndex].FindControl("txtgvKmRate")).Text;

            gvMedicalCost.EditIndex = e.NewEditIndex;
            bndMedicalGridCost();

            //DropDownList ddlVendor = ((DropDownList)gvSlabCost.Rows[e.NewEditIndex].FindControl("ddlgvVendor"));
            //DropDownList ddlVehicle = ((DropDownList)gvSlabCost.Rows[e.NewEditIndex].FindControl("ddlgvVehicle"));
            //ListItem lstVen = new ListItem("-Select-", "0");
            //ListItem lstVeh = new ListItem("-Select-", "0");
            //ddlVendor.Items.Clear();
            //ddlVehicle.Items.Clear();
            //ddlVendor.DataSource = tms.GetVendorByFac(Convert.ToInt32(ddlSelectSlabFacility.SelectedValue));
            //ddlVendor.Items.Add(lstVen);
            //ddlVendor.DataTextField = "vendorName";
            //ddlVendor.DataValueField = "Id";
            //ddlVendor.DataBind();
            //ddlVendor.SelectedIndex = ddlVendor.Items.IndexOf(ddlVendor.Items.FindByText(vendor));

            //ddlVehicle.DataSource = tms.GetVehicleType();
            //ddlVehicle.Items.Add(lstVen);
            //ddlVehicle.DataTextField = "vehicle";
            //ddlVehicle.DataValueField = "Id";
            //ddlVehicle.DataBind();
            //ddlVehicle.SelectedIndex = ddlVehicle.Items.IndexOf(ddlVehicle.Items.FindByText(vehicle));
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void gvAdditionalCost_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            //string vendor = ((Label)gvSlabCost.Rows[e.NewEditIndex].FindControl("lblVendor")).Text;
            //string vehicle = ((Label)gvSlabCost.Rows[e.NewEditIndex].FindControl("lblVehicle")).Text;
            //string KmRate = ((Label)gvSlabCost.Rows[e.NewEditIndex].FindControl("txtgvKmRate")).Text;

            gvAdditionalCost.EditIndex = e.NewEditIndex;
            bndAdditionalGridCost();

            //DropDownList ddlVendor = ((DropDownList)gvSlabCost.Rows[e.NewEditIndex].FindControl("ddlgvVendor"));
            //DropDownList ddlVehicle = ((DropDownList)gvSlabCost.Rows[e.NewEditIndex].FindControl("ddlgvVehicle"));
            //ListItem lstVen = new ListItem("-Select-", "0");
            //ListItem lstVeh = new ListItem("-Select-", "0");
            //ddlVendor.Items.Clear();
            //ddlVehicle.Items.Clear();
            //ddlVendor.DataSource = tms.GetVendorByFac(Convert.ToInt32(ddlSelectSlabFacility.SelectedValue));
            //ddlVendor.Items.Add(lstVen);
            //ddlVendor.DataTextField = "vendorName";
            //ddlVendor.DataValueField = "Id";
            //ddlVendor.DataBind();
            //ddlVendor.SelectedIndex = ddlVendor.Items.IndexOf(ddlVendor.Items.FindByText(vendor));

            //ddlVehicle.DataSource = tms.GetVehicleType();
            //ddlVehicle.Items.Add(lstVen);
            //ddlVehicle.DataTextField = "vehicle";
            //ddlVehicle.DataValueField = "Id";
            //ddlVehicle.DataBind();
            //ddlVehicle.SelectedIndex = ddlVehicle.Items.IndexOf(ddlVehicle.Items.FindByText(vehicle));
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void gvSlabCost_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            int rowId = Convert.ToInt32(gvSlabCost.DataKeys[e.RowIndex].Value.ToString());
            //string fromdate = ((TextBox)gvSlabCost.Rows[e.RowIndex].FindControl("txtDate")).Text;
            //string todate = ((TextBox)gvSlabCost.Rows[e.RowIndex].FindControl("txtlastDate")).Text;
            decimal StartkmSlab = Convert.ToDecimal(((TextBox)gvSlabCost.Rows[e.RowIndex].FindControl("txtgvStartkmSlab")).Text);
            decimal EndkmSlab = Convert.ToDecimal(((TextBox)gvSlabCost.Rows[e.RowIndex].FindControl("txtgvEndkmSlab")).Text);
            decimal kmRate = Convert.ToDecimal(((TextBox)gvSlabCost.Rows[e.RowIndex].FindControl("txtgvKmRate")).Text);
            decimal FuelRate = Convert.ToDecimal(((TextBox)gvSlabCost.Rows[e.RowIndex].FindControl("txtgvFuelRate")).Text);
            string result = tms.UpdateSlabCost(rowId, Convert.ToDouble(StartkmSlab), Convert.ToDouble(EndkmSlab), Convert.ToDouble(FuelRate), Convert.ToDouble(kmRate),"","", MyApplicationSession._UserID).ElementAtOrDefault(0).result.ToString();
            //ShowMessage(fromdate+"-"+todate);
            if (result.Equals("1"))
            {
                ShowMessage("Record Updated Successfully!");
                gvSlabCost.EditIndex = -1;
                bndGridCost();
            }
            else
            {
                ShowMessage("Record Already Exists!");
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    
    protected void gvMedicalCost_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            int rowId = Convert.ToInt32(gvMedicalCost.DataKeys[e.RowIndex].Value.ToString());
            decimal Startkm = Convert.ToDecimal(((TextBox)gvMedicalCost.Rows[e.RowIndex].FindControl("txtgvStartkmm")).Text);
            decimal Endkm = Convert.ToDecimal(((TextBox)gvMedicalCost.Rows[e.RowIndex].FindControl("txtgvEndkm0")).Text);
            string StartShift = ((TextBox)gvMedicalCost.Rows[e.RowIndex].FindControl("txtgvStartShift")).Text;
            string EndShift = ((TextBox)gvMedicalCost.Rows[e.RowIndex].FindControl("txtgvEndShift")).Text;

            decimal kmRate = Convert.ToDecimal(((TextBox)gvMedicalCost.Rows[e.RowIndex].FindControl("txtgvKmRatem")).Text);
            decimal FuelRate = Convert.ToDecimal(((TextBox)gvMedicalCost.Rows[e.RowIndex].FindControl("txtgvFuelRatem")).Text);
            string result = tms.UpdateMedicalCost(rowId, Convert.ToDouble(kmRate), MyApplicationSession._UserID, Convert.ToDouble(FuelRate), Convert.ToDouble(Startkm), Convert.ToDouble(Endkm), StartShift.ToString(), EndShift.ToString()).ElementAtOrDefault(0).result.ToString();
            if (result.Equals("1"))
            {
                ShowMessage("Record Updated Successfully!");
                gvMedicalCost.EditIndex = -1;
                bndMedicalGridCost();
            }
            else
            {
                ShowMessage("Record Already Exists!");
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void gvAdditionalCost_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            int rowId = Convert.ToInt32(gvAdditionalCost.DataKeys[e.RowIndex].Value.ToString());
            decimal kmRate = Convert.ToDecimal(((TextBox)gvAdditionalCost.Rows[e.RowIndex].FindControl("txtgvKmRatea")).Text);
            decimal FuelRate = Convert.ToDecimal(((TextBox)gvAdditionalCost.Rows[e.RowIndex].FindControl("txtgvFuelRatea")).Text);
            decimal WorkingHr = Convert.ToDecimal(((TextBox)gvAdditionalCost.Rows[e.RowIndex].FindControl("txtgvWorkingHr")).Text);
            decimal km = Convert.ToDecimal(((TextBox)gvAdditionalCost.Rows[e.RowIndex].FindControl("txtgvkm")).Text);
            string result = tms.UpdateAdditionalCabCost(rowId, Convert.ToDouble(kmRate), MyApplicationSession._UserID, Convert.ToDouble(FuelRate),Convert.ToInt32(WorkingHr),Convert.ToDouble(km)).ElementAtOrDefault(0).result.ToString();
            if (result.Equals("1"))
            {
                ShowMessage("Record Updated Successfully!");
                gvAdditionalCost.EditIndex = -1;
                bndAdditionalGridCost();
            }
            else
            {
                ShowMessage("Record Already Exists!");
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void gvSlabCost_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        try
        {
            gvSlabCost.EditIndex = -1;
            bndGridCost();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void gvMedicalCost_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        try
        {
            gvMedicalCost.EditIndex = -1;
            bndMedicalGridCost();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void gvAdditionalCost_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        try
        {
            gvAdditionalCost.EditIndex = -1;
            bndAdditionalGridCost();
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void gvSlabCost_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvSlabCost.PageIndex = e.NewPageIndex;

        bndGridCost();
    }
    protected void gvMedicalCost_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvMedicalCost.PageIndex = e.NewPageIndex;

        bndMedicalGridCost();
    }
    protected void gvAdditionalCost_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvAdditionalCost.PageIndex = e.NewPageIndex;

        bndAdditionalGridCost();
    }
    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
    protected void lkbSlab_Click(object sender, EventArgs e)
    {
        mvSlab.ActiveViewIndex = 0;
        mvMedical.ActiveViewIndex = -1;
        mvAdditional.ActiveViewIndex = -1;
        bndfacilitydrop();
        bndGridCost();
    }
    protected void lkbMedical_Click(object sender, EventArgs e)
    {
        mvAdditional.ActiveViewIndex = -1;
        mvSlab.ActiveViewIndex = -1;
        mvMedical.ActiveViewIndex = 0;
        bndMedicalfacilitydrop();
        bndMedicalGridCost();
    }
    protected void lkbAddition_Click(object sender, EventArgs e)
    {
        mvAdditional.ActiveViewIndex = 0;
        mvSlab.ActiveViewIndex = -1;
        mvMedical.ActiveViewIndex = -1;
        bndAdditionalfacilitydrop();
        bndAdditionalGridCost();
    }
    protected void lbtnAddNew_Click(object sender, EventArgs e)
    {
        mvSlab.ActiveViewIndex = 1;
        BndDvDropDown();
        TextBox effectiveDate = (TextBox)dvSlabCost.FindControl("txtEffectiveDate");
        TextBox txtStartKm = (TextBox)dvSlabCost.FindControl("txtStartKm");
        TextBox txtEndKm = (TextBox)dvSlabCost.FindControl("txtEndKm");
        TextBox txtnewRate = (TextBox)dvSlabCost.FindControl("txtnewRate");
        CheckBox chkAllFacility = (CheckBox)dvSlabCost.FindControl("chkAllfacility");
        chkAllFacility.Checked = false;
        effectiveDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
        txtStartKm.Text = string.Empty;
        txtEndKm.Text = string.Empty;
        txtnewRate.Text = string.Empty;
        _level = 2;
    }
    protected void lbtnAddNewm_Click(object sender, EventArgs e)
    {
        mvMedical.ActiveViewIndex = 1;
        BndMedicalDvDropDown();
        TextBox effectiveDate = (TextBox)dvMedicalCost.FindControl("txtEffectiveDatem");
        TextBox NewRate = (TextBox)dvMedicalCost.FindControl("txtnewRatem");
        TextBox StartKm = (TextBox)dvMedicalCost.FindControl("txtStartKmm");
        TextBox EndKm = (TextBox)dvMedicalCost.FindControl("txtEndKmm");
        TextBox StartShift = (TextBox)dvMedicalCost.FindControl("txtStartShift");
        TextBox EndShift = (TextBox)dvMedicalCost.FindControl("txtEndShift");
        CheckBox chkAllFacility = (CheckBox)dvMedicalCost.FindControl("chkAllfacility");
        chkAllFacility.Checked = false;
        NewRate.Text = string.Empty;
        StartKm.Text = string.Empty;
        EndKm.Text = string.Empty;
        StartShift.Text = string.Empty;
        EndShift.Text = string.Empty;
        effectiveDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
        _level = 2;
    }
    protected void lbtnAddNewa_Click(object sender, EventArgs e)
    {
        mvAdditional.ActiveViewIndex = 1;
        BndAdditionalDvDropDown();
        TextBox effectiveDate = (TextBox)dvAdditionalCost.FindControl("txtEffectiveDatea");
        TextBox NewRate = (TextBox)dvAdditionalCost.FindControl("txtnewRatea");
        TextBox StartKm = (TextBox)dvAdditionalCost.FindControl("txtStartKma");
        TextBox Workinghr = (TextBox)dvAdditionalCost.FindControl("txtWorkinghr");
        CheckBox chkAllFacility = (CheckBox)dvAdditionalCost.FindControl("chkAllfacility");
        chkAllFacility.Checked = false;
        NewRate.Text = string.Empty;
        StartKm.Text = string.Empty;
        Workinghr.Text = string.Empty;
        effectiveDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
        _level = 2;
    }
    protected void lbtnAdd_Click(object sender, EventArgs e)
    {
        mvSlab.ActiveViewIndex = 1;
        BndDvDropDown();
        TextBox effectiveDate = (TextBox)dvSlabCost.FindControl("txtEffectiveDate");
        TextBox txtStartKm = (TextBox)dvSlabCost.FindControl("txtStartKm");
        TextBox txtEndKm = (TextBox)dvSlabCost.FindControl("txtEndKm");
        TextBox txtnewRate = (TextBox)dvSlabCost.FindControl("txtnewRate");
        effectiveDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
        CheckBox chkAllFacility = (CheckBox)dvSlabCost.FindControl("chkAllfacility");
        chkAllFacility.Checked = false;
        txtStartKm.Text = string.Empty;
        txtEndKm.Text = string.Empty;
        txtnewRate.Text = string.Empty;
        _level = 1;
    }
    protected void lbtnAddm_Click(object sender, EventArgs e)
    {
        mvMedical.ActiveViewIndex = 1;
        BndMedicalDvDropDown();
        TextBox effectiveDate = (TextBox)dvMedicalCost.FindControl("txtEffectiveDatem");
        TextBox NewRate = (TextBox)dvMedicalCost.FindControl("txtnewRatem");
        TextBox StartKm = (TextBox)dvMedicalCost.FindControl("txtStartKmm");
        TextBox EndKm = (TextBox)dvMedicalCost.FindControl("txtEndKmm");
        TextBox StartShift = (TextBox)dvMedicalCost.FindControl("txtStartShift");
        TextBox EndShift = (TextBox)dvMedicalCost.FindControl("txtEndShift");
        CheckBox chkAllFacility = (CheckBox)dvMedicalCost.FindControl("chkAllfacility");
        chkAllFacility.Checked = false;
        NewRate.Text = string.Empty;
        StartKm.Text = string.Empty;
        EndKm.Text = string.Empty;
        StartShift.Text = string.Empty;
        EndShift.Text = string.Empty;
        effectiveDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
        ////TextBox NewRate = (TextBox)dvCost.FindControl("txtnewRate");
        ////effectiveDate.Text = string.Empty;
        ////NewRate.Text = string.Empty;
        _level = 1;
    }
    protected void lbtnAdda_Click(object sender, EventArgs e)
    {
        mvAdditional.ActiveViewIndex = 1;
        BndAdditionalDvDropDown();
        TextBox effectiveDate = (TextBox)dvAdditionalCost.FindControl("txtEffectiveDatea");
        TextBox NewRate = (TextBox)dvAdditionalCost.FindControl("txtnewRatea");
        TextBox StartKm = (TextBox)dvAdditionalCost.FindControl("txtStartKma");
        TextBox Workinghr = (TextBox)dvAdditionalCost.FindControl("txtWorkinghr");
        CheckBox chkAllFacility = (CheckBox)dvAdditionalCost.FindControl("chkAllfacility");
        chkAllFacility.Checked = false;
        NewRate.Text = string.Empty;
        StartKm.Text = string.Empty;
        Workinghr.Text = string.Empty;
        effectiveDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
        ////TextBox NewRate = (TextBox)dvCost.FindControl("txtnewRate");
        ////effectiveDate.Text = string.Empty;
        ////NewRate.Text = string.Empty;
        _level = 1;
    }
    protected void dvSlabCost_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.CancelingEdit == true || e.Cancel == true)
        {
            mvSlab.ActiveViewIndex = 0;
            gvSlabCost.EditIndex = -1;
            bndGridCost();
        }
    }
    protected void dvMedicalCost_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.CancelingEdit == true || e.Cancel == true)
        {
            mvMedical.ActiveViewIndex = 0;
            gvMedicalCost.EditIndex = -1;
            bndMedicalGridCost();
        }
    }
    protected void dvAdditionalCost_ModeChanging(object sender, DetailsViewModeEventArgs e)
    {
        if (e.CancelingEdit == true || e.Cancel == true)
        {
            mvAdditional.ActiveViewIndex = 0;
            gvAdditionalCost.EditIndex = -1;
            bndAdditionalGridCost();
        }
    }
    protected void LkbExportExl_Click(object sender, EventArgs e)
    {
        gvSlabCost.AllowPaging = false;
        gvSlabCost.DataSource = tms.GetSlabCost(Convert.ToInt32(ddlSelectSlabFacility.SelectedValue));
        gvSlabCost.DataBind();
        GridViewExportUtil.Export("SlabCostMaster.xls", gvSlabCost);
    }
    protected void LkbExportExl1_Click(object sender, EventArgs e)
    {
        gvMedicalCost.AllowPaging = false;
        gvMedicalCost.DataSource = tms.GetMedicalCost(Convert.ToInt32(ddlSelectMedicalFacility.SelectedValue));
        gvMedicalCost.DataBind();
        GridViewExportUtil.Export("MedicalCostMaster.xls", gvMedicalCost);
    }
    protected void LkbExportExl2_Click(object sender, EventArgs e)
    {
        gvAdditionalCost.AllowPaging = false;
        gvAdditionalCost.DataSource = tms.GetAdditionCost(Convert.ToInt32(ddlSelectAdditionalFacility.SelectedValue));
        gvAdditionalCost.DataBind();
        GridViewExportUtil.Export("MedicalCostMaster.xls", gvAdditionalCost);
    }
    protected void gvSlabCost_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int rowId = Convert.ToInt32(gvSlabCost.DataKeys[e.RowIndex].Value.ToString());
            string result = tms.DeleteSlabCost(rowId, MyApplicationSession._UserID).ElementAtOrDefault(0).result.ToString();
            if (result.Equals("1"))
            {
                ShowMessage("Record Deleted Successfully!");
                gvSlabCost.EditIndex = -1;
                bndGridCost();
            }
            else
            {
                ShowMessage("Record Not Deleted!");
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void gvMedicalCost_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int rowId = Convert.ToInt32(gvMedicalCost.DataKeys[e.RowIndex].Value.ToString());
            string result = tms.DeleteMedicalCost(rowId, MyApplicationSession._UserID).ElementAtOrDefault(0).result.ToString();
            if (result.Equals("1"))
            {
                ShowMessage("Record Deleted Successfully!");
                gvMedicalCost.EditIndex = -1;
                bndMedicalGridCost();
            }
            else
            {
                ShowMessage("Record Not Deleted!");
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
    protected void gvAdditionalCost_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int rowId = Convert.ToInt32(gvAdditionalCost.DataKeys[e.RowIndex].Value.ToString());
            string result = tms.DeleteAdditionalCabCost(rowId, MyApplicationSession._UserID).ElementAtOrDefault(0).result.ToString();
            if (result.Equals("1"))
            {
                ShowMessage("Record Deleted Successfully!");
                gvAdditionalCost.EditIndex = -1;
                bndAdditionalGridCost();
            }
            else
            {
                ShowMessage("Record Not Deleted!");
            }
        }
        catch (Exception ex)
        {
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);
        }
    }
}