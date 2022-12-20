using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.SessionState;

public partial class PrintDummyTripsheet : basepage2
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        DateTime sDate = Convert.ToDateTime(MyPageSession._sDate);
        Int32 FacilityID = MyPageSession._Facility;
        string TripType = MyPageSession._TripType;
        string Shift = MyPageSession._Shift;
        string Action = MyPageSession._Action;
        Int32 NoOfSheets = MyPageSession._NoOfSheets;
        DataTable EmpDataTable = MyPageSession._EmpDataTable;
        string CabType = MyPageSession._CabType;
        string EmpIDs = "";
        String remarks = MyPageSession._Remarks;
        string transid = MyPageSession._transaction;
        if (Action == "Blank")
        {
            DataTable MyDataTable = (DataTable)MakeDataTable();

            dlShowRoutes.DataSource = tms.GenerateDummySheets(sDate, FacilityID, TripType, Shift, Action, NoOfSheets, CabType, EmpIDs,MyApplicationSession._UserID,remarks,transid);
            dlShowRoutes.DataBind();

            for (int i = 0; i < dlShowRoutes.Items.Count; i++)
            {
                GridView grdViewRouteDetails = (GridView)dlShowRoutes.Items[i].FindControl("grdViewRouteDetails");
                grdViewRouteDetails.DataSource = MyDataTable;
                grdViewRouteDetails.DataBind();
            }
        }
        else if (Action == "NonBlank")
        {
            if (EmpDataTable.Rows.Count > 0)
            {
                foreach (DataRow dr in EmpDataTable.Rows)
                {
                    EmpIDs += dr["ID"].ToString() + ",";
                }
            }
            EmpIDs = EmpIDs.Remove(EmpIDs.Length - 1, 1);

            dlShowRoutes.DataSource = tms.GenerateDummySheets(sDate, FacilityID, TripType, Shift, Action, NoOfSheets, CabType, EmpIDs, MyApplicationSession._UserID, remarks, transid);
            dlShowRoutes.DataBind();

            for (int i = 0; i < dlShowRoutes.Items.Count; i++)
            {
                string RouteID = ((Label)dlShowRoutes.Items[i].FindControl("lblRouteID")).Text.ToString();
                GridView grdViewRouteDetails = (GridView)dlShowRoutes.Items[i].FindControl("grdViewRouteDetails");

                grdViewRouteDetails.DataSource = tms.GetDummyRoutesDetails(RouteID);
                grdViewRouteDetails.DataBind();
            }
        
        }

    }
    private DataTable MakeDataTable()
    {
        // Create a new DataTable.
        DataTable MyDataTable = new DataTable("MyDataTable");
        DataColumn column;
        DataRow row;

        // Create first column and add to the DataTable.
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "stopNo";
        MyDataTable.Columns.Add(column);
        // Create second column and add to the DataTable.
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "empCode";
        MyDataTable.Columns.Add(column);

        // Create second column and add to the DataTable.
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "EmpName";
        MyDataTable.Columns.Add(column);

        // Create second column and add to the DataTable.
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "Gender";
        MyDataTable.Columns.Add(column);

        // Create second column and add to the DataTable.
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "Address";
        MyDataTable.Columns.Add(column);

        // Create second column and add to the DataTable.
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "TripType";
        MyDataTable.Columns.Add(column);

        // Create second column and add to the DataTable.
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "Shift";
        MyDataTable.Columns.Add(column);

        // Create second column and add to the DataTable.
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "MeterReading";
        MyDataTable.Columns.Add(column);

        // Create second column and add to the DataTable.
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "Sign";
        MyDataTable.Columns.Add(column);

        for (int i = 0; i < 8; i++)
        {
            row = MyDataTable.NewRow();
            row["stopNo"] = "";
            row["empCode"] = "";
            row["EmpName"] = "";
            row["Gender"] = "";
            row["Address"] = "";
            row["TripType"] = "";
            row["Shift"] = "";
            row["MeterReading"] = "";
            row["Sign"] = "";
            MyDataTable.Rows.Add(row);
        }
        return MyDataTable;
    }
}
