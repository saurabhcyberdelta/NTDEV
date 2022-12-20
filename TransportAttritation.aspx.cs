using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TransportAttritation : basepage
{
    DataClasses1DataContext tms = new DataClasses1DataContext();
    EmpToopAuditLog emp = new EmpToopAuditLog();
    public string _empIdName
    {
        get
        {
            return (string)ViewState["_empIdName"];
        }
        set
        {
            ViewState["_empIdName"] = value;
        }
    }
    public int _empId
    {
        get
        {
            return (int)ViewState["_empId"];
        }

        set
        {
            ViewState["_empId"] = value;
        }
    }

    public int _ChkId
    {
        get
        {
            return (int)ViewState["_ChkId"];
        }

        set
        {
            ViewState["_ChkId"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtEmpIdName.Text = string.Empty;
            txtEmpIdName.Focus();
        }
    }
    
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (txtEmpIdName.Text.ToString().Trim().Length > 0)
        {
            _empIdName = txtEmpIdName.Text;
            BndEmpGrid();
        }
        else
        {
            MultiView1.ActiveViewIndex = -1;
        }
    }
    public void BndEmpGrid()
    {
        try
        {
            if (txtEmpIdName.Text.ToString().Trim().Length > 0)
            {
                grdSearchEmployee.DataSource = tms.EmpSearch(_empIdName, MyApplicationSession._LocationId, MyApplicationSession._ISAdmin);
                grdSearchEmployee.DataBind();

                if (grdSearchEmployee.Rows.Count < 1)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "No Record were Found!!!";                    
                }
                else
                {
                    lblMsg.Visible = false;                   

                    grdSearchEmployee.PageIndex = 0;
                    if (grdSearchEmployee.Rows.Count == 1)
                    {
                        _empId = Convert.ToInt32(grdSearchEmployee.DataKeys[0].Value);
                        GetEmployeeDetails(_empId);
                        MultiView1.ActiveViewIndex = 1;
                    }
                    else
                    {
                        MultiView1.ActiveViewIndex = 0;
                    }
                }
            }
            else
            {
                MultiView1.ActiveViewIndex = -1;
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    private void GetEmployeeDetails(Int32 EmpID)
    {
        var result = tms.GetEmployeeDetails(EmpID);
        foreach (var result1 in result)
        {
            lblEmpID.Text = result1.empCode;
            lblEmployeeName.Text = result1.empName;
            lblDepartment.Text = result1.processName;
            lblFacility.Text = result1.facilityName;
            lblMobile.Text = result1.mobile;
            lblPhone.Text = result1.phone;
            lblAddress.Text = result1.address;
            lblLocation.Text = result1.Location;
            lblRepManager.Text = result1.ManagerDetail;
            lblManagerNo.Text = result1.mgrMobile;
            lblCostcenter.Text = result1.Costcenter;
            lblDivisionManager.Text = result1.DivisionManager;
            lblEffectiveDate.Text=result1.TptEffectedDate.ToString("dd-MMM-yyyy");

            if (result1.geoCode.ToString() == "Y")
            {
                imgIsGeoCoded.ImageUrl = "~/images/yes_icon.jpg";
                imgIsGeoCoded.AlternateText = "Yes";
            }
            else
            {
                imgIsGeoCoded.ImageUrl = "~/images/no_icon.jpg";
                imgIsGeoCoded.AlternateText = "No";
            }

            if (result1.tptReq.Value.ToString() == "Y")
            {
                imgIsTptReq.ImageUrl = "~/images/yes_icon.jpg";
                imgIsTptReq.AlternateText = "Yes";
            }
            else
            {
                imgIsTptReq.ImageUrl = "~/images/no_icon.jpg";
                imgIsTptReq.AlternateText = "No";
            }
            lblempName.Text = "Transportation Details of:- " + result1.empName;
        }
    }

    protected void grdSearchEmployee_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdSearchEmployee.PageIndex = e.NewPageIndex;
        BndEmpGrid();
    }

    protected void grdSearchEmployee_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        try
        {
            _empId = Convert.ToInt32(grdSearchEmployee.DataKeys[e.NewSelectedIndex].Value.ToString());
            GetEmployeeDetails(_empId);
            MultiView1.ActiveViewIndex = 1;
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
        string results=null;
        results = tms.getpendingRequest(_empId).ElementAtOrDefault(0).Result.ToString();
        if (results == "1")
        {
            ModalPopupExtender1.Show();
            txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
            var result = tms.GetEmployeeDetails(_empId);
            foreach (var re1 in result)
            {
                char tptReq = Convert.ToChar(re1.tptReq);
                if (tptReq == 'Y')
                {
                    chkTpt.Checked = true;
                }
                else
                {
                    chkTpt.Checked = false;
                }
                txtStartDate.Text = re1.TptEffectedDate.ToString("MM/dd/yyyy");
            }
            txtStartDate.Focus();
        }
        else
        {
            ShowMessage("One Pending Request Already exists");
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            emp.EmployeeId = _empId;
            if (chkTpt.Checked == true)
            {
                _ChkId = 1;
            }
            else
            {
                _ChkId = 0;
            }
            emp.Toop = _ChkId;
            emp.EffectedDate = Convert.ToDateTime(txtStartDate.Text);
            emp.Descp = txtDescp.Text;
            emp.UpdatedBy = MyApplicationSession._UserID;
            string result = tms.InsertEmpToopAuditLog(emp.EmployeeId, emp.Toop, emp.EffectedDate, emp.Descp, emp.UpdatedBy).ElementAtOrDefault(0).RESULT.Value.ToString();
            if (result.Equals("1"))
            {
                ModalPopupExtender1.Hide();
                ShowMessage("Record Updated Successfully!");
               
                chkTpt.Checked = false;
                txtStartDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");
                txtDescp.Text = string.Empty;
                GetEmployeeDetails(_empId);
            }
            else
            {
                ShowMessage("Effective Date Could Not Be Less than Last Effective Date");
                ModalPopupExtender1.Show();
            }
        }
        catch (Exception ex)
        {
            // Log the exception and notify system operators
            ExceptionUtility.LogException(ex, "Catch Error");

            throw (ex);
        }
    }

    private void ShowMessage(string message)
    {
        string jScript = "alert('" + message + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "updated", jScript, true);

    }
}
