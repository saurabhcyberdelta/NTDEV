using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.SessionState;
using System.Data;

public partial class DummyTripsheetGen : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    public DataTable _MyDataTable
    {
        get
        {
            return (DataTable)ViewState["_MyDataTable"];
        }

        set
        {
            ViewState["_MyDataTable"] = value;
        }
    }

    public int _sno
    {
        get
        {
            return (int)ViewState["_sno"];
        }

        set
        {
            ViewState["_sno"] = value;
        }
    }
    DataColumn column;
    DataRow row;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BndDdl();
            _sno = 0;
            txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
            _MyDataTable = new DataTable();
            _MyDataTable = (DataTable)MakeDataTableColumn();
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
            ListItem lifac = new ListItem("-Select-", "0");
            ddlfacility.Items.Add(lifac);
            ddlfacility.DataSource = tms.SelectFacility(MyApplicationSession._UserID, MyApplicationSession._ISAdmin);
            ddlfacility.DataTextField = "facilityName";
            ddlfacility.DataValueField = "Id";
            ddlfacility.DataBind();
            ddlCabType.Items.Clear();
            ddlCabType.Items.Add(lifac);
            ddlCabType.DataSource = tms.getdummyCabType();
            ddlCabType.DataTextField = "Type";
            ddlCabType.DataValueField = "ID";
            ddlCabType.DataBind();
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
        BndLstShift();
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
            switch (rbtnSearchType.SelectedItem.Value)
            {
                case "Blank":
                    //EncryptQueryString ObjEQT = new EncryptQueryString();
                    MyPageSession._sDate = txtStartDate.Text;
                    MyPageSession._Facility = Convert.ToInt32(ddlfacility.SelectedValue);
                    MyPageSession._TripType = rdbtnlstType.SelectedValue;
                    MyPageSession._Shift = lstShift.SelectedValue;
                    MyPageSession._NoOfSheets = Convert.ToInt32(txtNoOfSheets.Text);
                    MyPageSession._Action = rbtnSearchType.SelectedValue;
                    MyPageSession._CabType = ddlCabType.SelectedValue;
                    MyPageSession._Remarks = txtRemarks.Text;
                    string transid = tms.getTransactionId().ElementAtOrDefault(0).transid.ToString();
                    MyPageSession._transaction = transid;
                    Type cstype = this.GetType();
                    ClientScriptManager cs = Page.ClientScript;
                    //var url = "PrintDummyTripsheet.aspx?sDate=" + txtStartDate.Text + "&Facility=" + ddlfacility.SelectedValue + "&TripType=" + rdbtnlstType.SelectedValue + "&Shift=" + lstShift.SelectedValue + "&Action=" + rbtnSearchType.SelectedValue;
                    HttpSessionState ss = HttpContext.Current.Session;
                    //cs.RegisterStartupScript(cstype, "dateSrpt", "<script>window.open('PrintDummyTripsheet.aspx?sDate=" + Server.HtmlEncode(txtStartDate.Text) + "&Facility=" + Server.HtmlEncode(ddlfacility.SelectedValue) + "&TripType=" + Server.HtmlEncode(rdbtnlstType.SelectedValue.Trim()) + "&Shift=" + Server.HtmlEncode(lstShift.SelectedValue.Trim()) + "&Action=" + Server.HtmlEncode(rbtnSearchType.SelectedValue.Trim()) + "&NoOfSheets=" + Server.HtmlEncode(txtNoOfSheets.Text.Trim()) + "&SessionState=" + Server.HtmlEncode(ss.SessionID) + "')</script>");
                    cs.RegisterStartupScript(cstype, "dateSrpt", "<script>window.open('PrintDummyTripsheet.aspx')</script>");
                    BndDdl();
                    BndLstShift();
                    txtNoOfSheets.Text = "";
                    break;
                case "NonBlank":
                    BndEmpGrid();
                    break;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }

    }
    protected void rbtnSearchType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            switch (rbtnSearchType.SelectedItem.Value)
            {
                case "Blank":
                    Panel1.Visible = true;
                    Panel2.Visible = false;
                    txtEmpIdName.Text = "";
                    btnSubmit.Text = "Generate";
                    BndEmpGrid();
                    BndDdl();
                    BndLstShift();
                    lblMsg.Text = "";
                    _MyDataTable = new DataTable();
                    _MyDataTable = (DataTable)MakeDataTableColumn();
                    grdShowAddedEmp.DataSource = null;
                    grdShowAddedEmp.DataBind();
                    Panel3.Visible = false;
                    break;
                case "NonBlank":
                    Panel1.Visible = false;
                    Panel2.Visible = true;
                    BndDdl();
                    BndLstShift();
                    txtNoOfSheets.Text = "";
                    btnSubmit.Text = "Search";
                    txtEmpIdName.Focus();
                    break;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    public void BndEmpGrid()
    {
        //********************************************************************//
        //Bind the Employee grid with the with the search Criteria            //
        //********************************************************************//
        try
        {
            GvEmployee.DataSource = tms.EmpSearch(txtEmpIdName.Text, MyApplicationSession._LocationId,MyApplicationSession._ISAdmin);
            GvEmployee.DataBind();
            if (GvEmployee.Rows.Count < 1)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "No Record Found!!!";
                txtEmpIdName.Focus();
            }
            else
            {
                GvEmployee.SelectedIndex = -1;
                lblMsg.Visible = false;


            }

        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }
    protected void GvEmployee_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        int empID;
        empID = Convert.ToInt32(GvEmployee.DataKeys[e.NewSelectedIndex].Value.ToString());
        Boolean IsExists = false;
        if (_MyDataTable.Rows.Count > 0)
        {
            foreach (DataRow dr in _MyDataTable.Rows)
            {
                if (empID == Convert.ToInt32(dr["ID"].ToString()))
                {
                    IsExists = true;
                    break;

                }
            }
        }
        if (!IsExists)
        {
            var result = tms.GetEmployee(empID);
            _sno = _sno + 1;
            foreach (var result1 in result)
            {
                row = _MyDataTable.NewRow();
                row["stopNo"] = _sno;
                row["ID"] = empID;
                row["empCode"] = result1.empCode;
                row["empName"] = result1.empName;
                row["Gender"] = result1.Gender;
                row["Address"] = result1.address;
                _MyDataTable.Rows.Add(row);
            }
            Panel3.Visible = true;
            grdShowAddedEmp.DataSource = _MyDataTable;
            grdShowAddedEmp.DataBind();
            txtEmpIdName.Text = "";
            BndEmpGrid();
            lblMsg.Text = "";
        }
        else
        {
            lblMsg.Visible = true;
            lblMsg.Text = "Partner already exists.";
        }
    }
    protected void GvEmployee_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GvEmployee.PageIndex = e.NewPageIndex;
        BndEmpGrid();
    }

    private DataTable MakeDataTableColumn()
    {
        // Create first column and add to the DataTable.
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "stopNo";
        _MyDataTable.Columns.Add(column);

        // Create second column and add to the DataTable.
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "ID";
        _MyDataTable.Columns.Add(column);

        // Create second column and add to the DataTable.
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "empCode";
        _MyDataTable.Columns.Add(column);

        // Create second column and add to the DataTable.
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "empName";
        _MyDataTable.Columns.Add(column);

        // Create second column and add to the DataTable.
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "Gender";
        _MyDataTable.Columns.Add(column);

        // Create second column and add to the DataTable.
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "Address";
        _MyDataTable.Columns.Add(column);


        return _MyDataTable;
    }

    protected void btnGenerateEmpDummy_Click(object sender, EventArgs e)
    {
        MyPageSession._sDate = txtStartDate.Text;
        MyPageSession._Facility = Convert.ToInt32(ddlfacility.SelectedValue);
        MyPageSession._TripType = rdbtnlstType.SelectedValue;
        MyPageSession._Shift = lstShift.SelectedValue;
        MyPageSession._Action = rbtnSearchType.SelectedValue;
        MyPageSession._EmpDataTable = _MyDataTable;
        MyPageSession._CabType = ddlCabType.SelectedValue;
        MyPageSession._Remarks = txtRemarks.Text;
        string transid = tms.getTransactionId().ElementAtOrDefault(0).transid.ToString();
        MyPageSession._transaction = transid;
        Type cstype = this.GetType();
        ClientScriptManager cs = Page.ClientScript;
        HttpSessionState ss = HttpContext.Current.Session;
        cs.RegisterStartupScript(cstype, "dateSrpt", "<script>window.open('PrintDummyTripsheet.aspx')</script>");
        BndDdl();
        BndLstShift();
        _MyDataTable = new DataTable();
        _MyDataTable = (DataTable)MakeDataTableColumn();
        grdShowAddedEmp.DataSource = null;
        grdShowAddedEmp.DataBind();
        Panel3.Visible = false;
    }
    protected void grdShowAddedEmp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdShowAddedEmp.PageIndex = e.NewPageIndex;
        grdShowAddedEmp.DataSource = _MyDataTable;
        grdShowAddedEmp.DataBind();
    }
}
