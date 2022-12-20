using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class SiteFile : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtCalendar.Text = System.DateTime.Now.Date.ToString("MM/dd/yyyy");
        }
      }


    protected void BtnSubmit_Click(object sender, EventArgs e)
    {

        //****************************************
        //On Submit Button Click ceates object of 
        //data layer and business layer each
        //generates dataset for required faclityid
        //call the function for export to an excel file
        //****************************************
        try
        {
            int facId = MyApplicationSession._FacilityID;
            var result = tms.GetSiteFile(facId,Convert.ToDateTime(txtCalendar.Text));
            // GridView1.DataBind();

            DataTable dt = new DataTable();
            DataColumn dc = new DataColumn("ID", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Name", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Type", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Depot", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("X", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Y", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Address1", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Address2", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Address3", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Pin", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Phone", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Process", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("SubProcess", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("City", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Colony", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("Landmark", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("geoCodeId", typeof(System.String));
            dt.Columns.Add(dc);
            dc = new DataColumn("EmployeeID", typeof(System.String));
            dt.Columns.Add(dc);

            foreach (var result1 in result)
            {
                DataRow dr = dt.NewRow();
                dr["ID"] = result1.ID.ToString();
                dr["Name"] = result1.Name;
                dr["Type"] = result1.Type;
                dr["Depot"] = result1.Depot;
                dr["X"] = result1.X;
                dr["Y"] = result1.Y;
                dr["Address1"] = result1.Address1;
                dr["Address2"] = result1.Address2;
                dr["Address3"] = result1.Address3;
                dr["Pin"] = result1.Pin;
                dr["Phone"] = result1.Phone;
                dr["Process"] = result1.Process;
                dr["SubProcess"] = result1.subProcess;
                dr["City"] = result1.City;
                dr["Colony"] = result1.Colony;
                dr["Landmark"] = result1.Landmark;
                dr["geoCodeId"] = result1.geoCodeId;
                dr["EmployeeID"] = result1.EmployeeID;
                dt.Rows.Add(dr);
            }


            DataSet dsMenu = new DataSet();
            dsMenu.Tables.Add(dt);

            ExportDataSetToExcel.ExportToExcel(dsMenu, "SiteFile.xls");
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");
            throw (ex);

        }
    }

}

