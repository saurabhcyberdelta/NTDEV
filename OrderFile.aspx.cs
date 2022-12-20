using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;

public partial class OrderFile : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
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
            ddlfacility.DataSource = tms.SelectFacilityMerge(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
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

            var result = tms.GetOrderFile(sDate, facId, rtype, strShifttimes);
            // GridView1.DataBind();

            DataTable dt = new DataTable();
            DataColumn dc = new DataColumn("ID", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("FromID", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("ToID", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Type", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("PickAptAvlDT", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("PickAptByDT", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("DropAptAvlDT", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("DropAptByDT", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("PickAvlDT", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("PickByDT", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("DropAvlDT", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("DropByDT", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("EnfPickApt", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("EnfDropApt", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Quantity1", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Shift", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("ShiftDt", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("PkNPk", typeof(System.String));
            dt.Columns.Add(dc);

            foreach (var result1 in result)
            {
                DataRow dr = dt.NewRow();
                dr["ID"] = result1.ID;
                dr["FromID"] = result1.FromID;
                dr["ToID"] = result1.ToID;
                dr["Type"] = result1.Type;
                dr["PickAptAvlDT"] = result1.PickAptAvlDT;
                dr["PickAptByDT"] = result1.PickAptByDT;
                dr["DropAptAvlDT"] = result1.DropAptAvlDT;
                dr["DropAptByDT"] = result1.DropAptByDT;
                dr["PickAvlDT"] = result1.PickAvlDT;
                dr["PickByDT"] = result1.PickByDT;
                dr["DropAvlDT"] = result1.DropAvlDT;
                dr["DropByDT"] = result1.DropByDT;
                dr["EnfPickApt"] = result1.EnfPickApt;
                dr["EnfDropApt"] = result1.EnfDropApt;
                dr["Quantity1"] = result1.Quantity1;
                dr["Shift"] = result1.Shift;
                dr["ShiftDt"] = result1.ShiftDt;
                dr["PkNPk"] = result1.PkNPk;
                dt.Rows.Add(dr);
            }
            DataSet dsMenu = new DataSet();
            dsMenu.Tables.Add(dt);

            ExportDataSetToExcel(dsMenu, "OrderFile.xls");

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            
            throw (ex);

        }
    }
    public static void ExportDataSetToExcel(DataSet ds, string filename)
    {
        //*************************************
        //creates object of stringwriter and htmltextwriter
        //reads the dataset and exports the data items to an excel file
        //*************************************
        try
        {
            HttpResponse response = HttpContext.Current.Response;
            response.Clear();
            response.Charset = string.Empty;
            response.ContentType = "application/vnd.ms-excel";
            response.AddHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {
                    DataGrid dg = new DataGrid();
                    dg.DataSource = ds.Tables[0];
                    dg.DataBind();
                    dg.RenderControl(htw);
                    response.Write(sw.ToString());
                    response.End();
                }
            }
        }
        catch (Exception ex)
        {
            Label lblerror = new Label();
            lblerror.Text = ex.ToString();

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
}

