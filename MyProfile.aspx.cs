using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MyProfile : basepage
{DataClasses1DataContext TmsDataContext=new DataClasses1DataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bndempDetail();
        }
    }
    protected void bndempDetail()
    {
        var r = TmsDataContext.GetEmployeeDetails(Convert.ToInt32(MyApplicationSession._UserID));

        foreach (var r1 in r)
        {
            ((Label)DvGeo.FindControl("lbldvEmpLoyeeID")).Text = r1.empCode;
            ((Label)DvGeo.FindControl("lbldvEmpName")).Text = r1.empName;
            if (r1.tptReq == 'Y')
            {
               ((CheckBox)DvGeo.FindControl("chkBxTptReq")).Checked = Convert.ToBoolean(1);
            }
            else
            {
                ((CheckBox)DvGeo.FindControl("chkBxTptReq")).Checked = Convert.ToBoolean(0);
            }
            ((Label)DvGeo.FindControl("lbldvAddress1")).Text = r1.address;
            
            ((Label)DvGeo.FindControl("lblMobile")).Text = r1.mobile;
            ((Label)DvGeo.FindControl("lblMobile2")).Text = r1.phone;
            ((Label)DvGeo.FindControl("lbldvfacility")).Text = r1.facilityName;
            ((Label)DvGeo.FindControl("lblProcess")).Text = r1.processName;
            ((Label)DvGeo.FindControl("lblLocation")).Text = r1.Location;
            ((Label)DvGeo.FindControl("lblReportmgr")).Text = r1.ManagerDetail;
            ((Label)DvGeo.FindControl("lbldvmgr")).Text = r1.DivisionManager;
            ((Label)DvGeo.FindControl("lblCostcenter")).Text = r1.Costcenter;
            ((Label)DvGeo.FindControl("lblsubProcess")).Text = r1.subprocessname;
            
            //((HyperLink)DvGeo.FindControl("lbChangeAddress")).Visible = true;
            ((Label)DvGeo.FindControl("lblGender")).Text = r1.Gender.ToString();
            ((Label)DvGeo.FindControl("lblEmail")).Text = r1.email.ToString();
            

           
        }
    }
    protected void lblEditDetails_Click(object sender, EventArgs e)
    {
        var r = TmsDataContext.GetEmployeeDetails(Convert.ToInt32(MyApplicationSession._UserID));
        foreach (var r1 in r)
        {
            showeditcontrols();
            hidelabels();
            ((TextBox)DvGeo.FindControl("txtEmpName")).Text = r1.empName;
             ((TextBox)DvGeo.FindControl("txtMobile")).Text = r1.mobile.Trim();
             ((TextBox)DvGeo.FindControl("txtMobile2")).Text = r1.phone.Trim();
             DropDownList ddlFacilty = (DropDownList)DvGeo.FindControl("ddlFacility");
            DropDownList ddlProcess = (DropDownList)DvGeo.FindControl("ddlProcess");
            DropDownList ddlReportingmanager = (DropDownList)DvGeo.FindControl("ddlReportingManager");
            DropDownList ddldvmanager = (DropDownList)DvGeo.FindControl("ddlDvManager");
            DropDownList ddlsubprocess = (DropDownList)DvGeo.FindControl("ddlsubProcess");
            DropDownList ddlCostcenter = (DropDownList)DvGeo.FindControl("ddlCostcenter");
            bnddropdown();
            ddlProcess.SelectedIndex = ddlProcess.Items.IndexOf(ddlProcess.Items.FindByText(r1.processName.ToString()));
            ddlFacilty.SelectedIndex = ddlFacilty.Items.IndexOf(ddlFacilty.Items.FindByText(r1.facilityName.ToString()));
            ddldvmanager.SelectedIndex = ddldvmanager.Items.IndexOf(ddldvmanager.Items.FindByValue(r1.dvmanagerid.ToString()));
            ddlReportingmanager.SelectedIndex = ddlReportingmanager.Items.IndexOf(ddlReportingmanager.Items.FindByValue(r1.managerId.ToString()));
            ddlCostcenter.SelectedIndex = ddlCostcenter.Items.IndexOf(ddlCostcenter.Items.FindByValue(r1.Costcenter.ToString()));
           
            ListItem li = new ListItem("-Select-", "0");
            ddlsubprocess.Items.Clear();
            ddlsubprocess.Items.Add(li);
            ddlsubprocess.DataSource = TmsDataContext.GetSubProcess(Convert.ToInt32(ddlProcess.SelectedValue));
            ddlsubprocess.DataTextField = "Subprocessname";
            ddlsubprocess.DataValueField = "id";
            ddlsubprocess.DataBind();
            ddlsubprocess.SelectedIndex = ddlsubprocess.Items.IndexOf(ddlsubprocess.Items.FindByValue(r1.subprocessId.ToString()));

            if (r1.Gender == "Male")
            {
                ((CheckBox)DvGeo.FindControl("rdbtndvM")).Checked = true;
            }
            else
            {
                if (r1.Gender == "Other")
                {
                    ((CheckBox)DvGeo.FindControl("rdbtndvO")).Checked = true;
                }
                else if (r1.Gender == "TG")
                {
                    ((CheckBox)DvGeo.FindControl("rdbtndvT")).Checked = true;
                }
                else
                {
                    ((CheckBox)DvGeo.FindControl("rdbtndvF")).Checked = true;
                }
            }
            ((TextBox)DvGeo.FindControl("txtEmail")).Text = r1.email.ToString();
            
           
        }
    }

    protected void bnddropdown()
    {
        DropDownList ddlFacilty = (DropDownList)DvGeo.FindControl("ddlFacility");
        DropDownList ddlProcess = (DropDownList)DvGeo.FindControl("ddlProcess");
        DropDownList ddlReportingmanager = (DropDownList)DvGeo.FindControl("ddlReportingManager");
        DropDownList ddldvmanager = (DropDownList)DvGeo.FindControl("ddlDvManager");
        DropDownList ddlCostcenter = (DropDownList)DvGeo.FindControl("ddlCostcenter");
        
        ListItem lifac = new ListItem("--Select--", "0");
        ListItem liprocess = new ListItem("--Select--", "0");
        ListItem lireportingmanger = new ListItem("--Select--", "0");
        ListItem lidvManager = new ListItem("--Select--", "0");
        ListItem licost = new ListItem("--Select--", "NotDefined");
        ddlFacilty.Items.Clear();
        ddlFacilty.Items.Add(lifac);
        ddlFacilty.DataSource = TmsDataContext.SelectFacility(MyApplicationSession._UserID,MyApplicationSession._ISAdmin);
        ddlFacilty.DataTextField = "facilityname";
        ddlFacilty.DataValueField = "id";
        ddlFacilty.DataBind();
        ddlProcess.Items.Clear();
        ddlProcess.Items.Add(liprocess);
        ddlProcess.DataSource = TmsDataContext.SelectAllProcess();
        ddlProcess.DataTextField = "processname";
        ddlProcess.DataValueField = "id";
        ddlProcess.DataBind();
        ddlReportingmanager.Items.Clear();
        ddlReportingmanager.Items.Add(lireportingmanger);
        ddlReportingmanager.DataSource = TmsDataContext.GetManagerList(MyApplicationSession._LocationId);
        ddlReportingmanager.DataTextField = "empName";
        ddlReportingmanager.DataValueField = "Id";
        ddlReportingmanager.DataBind();
        ddldvmanager.Items.Clear();
        ddldvmanager.Items.Add(lidvManager);
        ddldvmanager.DataSource = TmsDataContext.GetdvManagerList(MyApplicationSession._LocationId);
        ddldvmanager.DataTextField = "empname";
        ddldvmanager.DataValueField = "Id";
        ddldvmanager.DataBind();
        ddlCostcenter.Items.Clear();
        ddlCostcenter.Items.Add(licost);
        ddlCostcenter.DataSource = TmsDataContext.getCostcenter();
        ddlCostcenter.DataTextField = "costcenter";
        ddlCostcenter.DataValueField = "costcenter";
        ddlCostcenter.DataBind();



    }
    protected void ddlProcess_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlProcess = (DropDownList)DvGeo.FindControl("ddlProcess");
        DropDownList ddlsubprocess = (DropDownList)DvGeo.FindControl("ddlsubProcess");
              
        ListItem li = new ListItem("-Select-", "0");
        ddlsubprocess.Items.Clear();
        ddlsubprocess.Items.Add(li);
        ddlsubprocess.DataSource = TmsDataContext.GetSubProcess(Convert.ToInt32(ddlProcess.SelectedValue));
        ddlsubprocess.DataTextField = "Subprocessname";
        ddlsubprocess.DataValueField = "id";
        ddlsubprocess.DataBind();
           
    }
    protected void hidelabels()
    {

        ((Label)DvGeo.FindControl("lbldvEmpName")).Visible = false;
        ((Label)DvGeo.FindControl("lblMobile")).Visible = false;
        ((Label)DvGeo.FindControl("lblMobile2")).Visible = false;
        ((Label)DvGeo.FindControl("lblReportmgr")).Visible = false;
        ((Label)DvGeo.FindControl("lbldvmgr")).Visible = false;
        ((Label)DvGeo.FindControl("lbldvfacility")).Visible = false;
        ((Label)DvGeo.FindControl("lblProcess")).Visible = false;
        ((LinkButton)DvGeo.FindControl("lblEditDetails")).Visible = false;
        ((Label)DvGeo.FindControl("lblCostcenter")).Visible = false;
        ((Label)DvGeo.FindControl("lblsubProcess")).Visible = false;
        ((Label)DvGeo.FindControl("lblGender")).Visible = false;
        ((Label)DvGeo.FindControl("lblEmail")).Visible = false;
    }
    protected void showlabels()
    {
        ((Label)DvGeo.FindControl("lbldvEmpName")).Visible = true;
        ((Label)DvGeo.FindControl("lblMobile")).Visible = true;
        ((Label)DvGeo.FindControl("lblMobile2")).Visible = true;
        ((Label)DvGeo.FindControl("lblReportmgr")).Visible = true;
        ((Label)DvGeo.FindControl("lbldvmgr")).Visible = true;
        ((Label)DvGeo.FindControl("lbldvfacility")).Visible = true;
        ((Label)DvGeo.FindControl("lblProcess")).Visible = true;
        ((LinkButton)DvGeo.FindControl("lblEditDetails")).Visible = true;
        ((Label)DvGeo.FindControl("lblCostcenter")).Visible = true;
        ((Label)DvGeo.FindControl("lblsubProcess")).Visible = true;

        ((Label)DvGeo.FindControl("lblGender")).Visible = true;
        ((Label)DvGeo.FindControl("lblEmail")).Visible = true;
    
    }
    protected void hideeditcontrols()
    {
       // ((CheckBox)DvGeo.FindControl("chkBxTptReq")).Enabled = false;
        ((TextBox)DvGeo.FindControl("txtMobile")).Visible = false;
        ((TextBox)DvGeo.FindControl("txtMobile2")).Visible = false;
        ((TextBox)DvGeo.FindControl("txtEmpName")).Visible = false;
        ((LinkButton)DvGeo.FindControl("lbtnSave")).Visible = false;
        ((LinkButton)DvGeo.FindControl("lbtnCancel")).Visible = false;
        DropDownList ddlFacilty = (DropDownList)DvGeo.FindControl("ddlFacility");
        DropDownList ddlProcess = (DropDownList)DvGeo.FindControl("ddlProcess");
        DropDownList ddlReportingmanager = (DropDownList)DvGeo.FindControl("ddlReportingManager");
        DropDownList ddldvmanager = (DropDownList)DvGeo.FindControl("ddlDvManager");
        DropDownList ddlsubprocess = (DropDownList)DvGeo.FindControl("ddlsubProcess");
        DropDownList ddlCostcenter = (DropDownList)DvGeo.FindControl("ddlCostcenter");
        ddldvmanager.Visible = false;
        ddlProcess.Visible = false;
        ddlFacilty.Visible = false;
        ddlReportingmanager.Visible = false;
        ddlsubprocess.Visible = false;
        ddlCostcenter.Visible = false;
        ((CheckBox)DvGeo.FindControl("rdbtndvM")).Visible = false;
        ((CheckBox)DvGeo.FindControl("rdbtndvF")).Visible = false;
        ((CheckBox)DvGeo.FindControl("rdbtndvO")).Visible = false;
        ((CheckBox)DvGeo.FindControl("rdbtndvT")).Visible = false;
        ((TextBox)DvGeo.FindControl("txtEmail")).Visible = false;
    
    }
    protected void showeditcontrols()
    {
        //((CheckBox)DvGeo.FindControl("chkBxTptReq")).Enabled = true;
        ((TextBox)DvGeo.FindControl("txtMobile")).Visible = true;
        ((TextBox)DvGeo.FindControl("txtMobile2")).Visible = true;
        ((TextBox)DvGeo.FindControl("txtEmpName")).Visible = true;
        ((LinkButton)DvGeo.FindControl("lbtnSave")).Visible = true;
        ((LinkButton)DvGeo.FindControl("lbtnCancel")).Visible = true;
        DropDownList ddlFacilty = (DropDownList)DvGeo.FindControl("ddlFacility");
        DropDownList ddlProcess = (DropDownList)DvGeo.FindControl("ddlProcess");
        DropDownList ddlReportingmanager = (DropDownList)DvGeo.FindControl("ddlReportingManager");
        DropDownList ddldvmanager = (DropDownList)DvGeo.FindControl("ddlDvManager");
        DropDownList ddlsubprocess = (DropDownList)DvGeo.FindControl("ddlsubProcess");
        DropDownList ddlCostcenter = (DropDownList)DvGeo.FindControl("ddlCostcenter");
        ddldvmanager.Visible = true;
        ddlProcess.Visible = true;
        ddlFacilty.Visible = true;
        ddlReportingmanager.Visible = true;
        ddlsubprocess.Visible = true;
        ddlCostcenter.Visible = true;
        ((CheckBox)DvGeo.FindControl("rdbtndvM")).Visible = true;
        ((CheckBox)DvGeo.FindControl("rdbtndvF")).Visible = true;
        ((CheckBox)DvGeo.FindControl("rdbtndvO")).Visible = true;
        ((CheckBox)DvGeo.FindControl("rdbtndvT")).Visible = true;
        ((TextBox)DvGeo.FindControl("txtEmail")).Visible = true;
    
    }
    protected void lbtnCancel_Click(object sender, EventArgs e)
    {
        bndempDetail();
        showlabels();
        hideeditcontrols();
    }
    protected void lbtnSave_Click(object sender, EventArgs e)
    {
        String tptreq = null, empname = null, mobile = null, costcenter = null, empcode = null, phone = null, gender = null, emailId = null;

        int facility = 0, process = 0, subprocess = 0, manager = 0, dvmanager = 0;
    if (((CheckBox)DvGeo.FindControl("chkBxTptReq")).Checked == true)
    {
        tptreq = "Y";
    }
    else
    {
        tptreq = "N";
    }
    mobile = ((TextBox)DvGeo.FindControl("txtMobile")).Text;
    phone = ((TextBox)DvGeo.FindControl("txtMobile2")).Text;
    empname = ((TextBox)DvGeo.FindControl("txtEmpName")).Text;
    empcode = ((Label)DvGeo.FindControl("lbldvEmpLoyeeID")).Text;
    DropDownList ddlFacilty = (DropDownList)DvGeo.FindControl("ddlFacility");
    DropDownList ddlProcess = (DropDownList)DvGeo.FindControl("ddlProcess");
    DropDownList ddlReportingmanager = (DropDownList)DvGeo.FindControl("ddlReportingManager");
    DropDownList ddldvmanager = (DropDownList)DvGeo.FindControl("ddlDvManager");
    DropDownList ddlsubprocess = (DropDownList)DvGeo.FindControl("ddlsubProcess");
    DropDownList ddlCostcenter = (DropDownList)DvGeo.FindControl("ddlCostcenter");
    dvmanager = Convert.ToInt32(ddldvmanager.SelectedValue);
    process = Convert.ToInt32(ddlProcess.SelectedValue);
    facility = Convert.ToInt32(ddlFacilty.SelectedValue);
    manager = Convert.ToInt32(ddlReportingmanager.SelectedValue);
    subprocess = Convert.ToInt32(ddlsubprocess.SelectedValue);
    costcenter = ddlCostcenter.SelectedValue.ToString();
    if (((CheckBox)DvGeo.FindControl("rdbtndvM")).Checked == true)
    {
        gender = "Male";
    }
    else
    {
        if (((CheckBox)DvGeo.FindControl("rdbtndvO")).Checked == true)
        {
            gender = "Other";
        }
        else if (((CheckBox)DvGeo.FindControl("rdbtndvT")).Checked == true)
        {
            gender = "TG";
        }
        else
        {
            gender = "Female";
        }
    }
    emailId = ((TextBox)DvGeo.FindControl("txtEmail")).Text;
       string columnName = null, oldvalue = null, newvalue = null;
     var res=TmsDataContext.GetEmployeeDetails(MyApplicationSession._UserID);
     foreach (var r1 in res)
     {
         if (r1.empName.ToString() != empname)
         {
             columnName += ", empName";
             oldvalue += "," + r1.empName;
             newvalue += "," + empname;

         }

         if (r1.mobile.ToString() != mobile)
         {
             columnName += ", mobile";
             oldvalue += "," + r1.mobile;
             newvalue += "," + mobile;

         }


         if (r1.tptReq.ToString() != tptreq.ToString())
         {
             columnName += ", tptReq";
             oldvalue += "," + r1.tptReq;
             newvalue += "," + tptreq;

         }
         if (r1.managerId.ToString() != manager.ToString())
         {
             columnName += ", managerId";
             oldvalue += "," + r1.managerId;
             newvalue += "," + manager;

         }
         if (r1.dvmanagerid.ToString() != dvmanager.ToString())
         {
             columnName += ", divisionmanagerId";
             oldvalue += "," + r1.dvmanagerid;
             newvalue += "," + dvmanager;

         }
         if (r1.Procesid.ToString() != process.ToString())
         {
             columnName += ", processId";
             oldvalue += "," + r1.Procesid;
             newvalue += "," + process;

         }
         if (r1.subprocessId.ToString() != subprocess.ToString())
         {
             columnName += ", subProcessId";
             oldvalue += "," + r1.subprocessId;
             newvalue += "," + subprocess;

         }
         if (r1.facilityid.ToString() != facility.ToString())
         {
             columnName += ", facilityId";
             oldvalue += "," + r1.facilityid;
             newvalue += "," + facility;

         }
         if (r1.Costcenter.ToString() != costcenter.ToString())
         {
             columnName += ", CostCenter";
             oldvalue += "," + r1.Costcenter;
             newvalue += "," +costcenter ;

         }

         if (r1.Gender.ToString() != gender.ToString())
         {
             columnName += ", Gender";
             oldvalue += "," + r1.Gender;
             newvalue += "," + gender;
         }
         if (r1.email.ToString() != emailId.ToString())
         {
             columnName += ", Email";
             oldvalue += "," + r1.email;
             newvalue += "," + emailId;
         }
     }
                  
                    TmsDataContext.AddEmpProfileAuditLog(MyApplicationSession._UserID,columnName, MyApplicationSession._UserID,oldvalue,newvalue);



       TmsDataContext.UpdateEmployeeProfile(MyApplicationSession._UserID, empcode,empname, mobile, Convert.ToChar(tptreq), manager.ToString(), facility, process, subprocess, MyApplicationSession._UserID, costcenter, dvmanager,phone,gender,emailId);
       bndempDetail();
        hideeditcontrols();
       showlabels();
    }
}
