using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReportTableAdapters;
using Microsoft.Reporting.WebForms;

public partial class dashboardanalysis : basepage2
{

    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    dashanalysisTableAdapter ds = new dashanalysisTableAdapter();
    dashboardanalysTableAdapter ds1 = new dashboardanalysTableAdapter();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                 Boolean IsValid = true;
            string strReq = "";
            string[] arrIndMsg = null;
            strReq = Request.RawUrl;
            strReq = strReq.Substring(strReq.IndexOf('?') + 1);
            string id = null, facid = null, years = null,from =null;
            if (strReq.Length < 0)
            {

            }
            else
            {
                strReq = new EncryptQueryString().Decrypt(strReq);
                string[] arrMsgs = strReq.Split('&');

                if (arrMsgs.Length > 1)
                {
                    arrIndMsg = arrMsgs[0].Split('=');
                    if (arrIndMsg.Length > 1)
                    {
                        id = arrIndMsg[1].ToString().Trim();
                    }
                    else
                    {
                        id = "";
                    }

                }


                if (arrMsgs.Length > 2)
                {

                    arrIndMsg = arrMsgs[1].Split('=');
                    if (arrIndMsg.Length > 1)
                    {
                        facid = arrIndMsg[1].ToString().Trim();
                    }
                    else
                    {
                        facid = "";
                    }


                }

                if (arrMsgs.Length >=3)
                {
                    arrIndMsg = arrMsgs[2].Split('=');

                    if (arrIndMsg.Length > 1)
                    {
                        years = arrIndMsg[1].ToString().Trim();
                    }
                    else
                    {
                        years = "";
                    }

                }
               
            }
              
               
             
                ReportViewer1.Reset();
                ReportViewer1.LocalReport.Refresh();
                ReportViewer1.LocalReport.ReportPath = "dashanalysis.rdlc";

                ReportDataSource report1DataSource = new ReportDataSource("Report_dashanalysis", ds.GetData(Convert.ToInt32(id),Convert.ToInt32(years),Convert.ToInt32(facid)));
                ReportViewer1.LocalReport.DataSources.Clear();

                ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
                ReportDataSource report2DataSource = new ReportDataSource("Report_dashboardanalys", ds1.GetData(Convert.ToInt32(years),Convert.ToInt32(facid),Convert.ToInt32(id)));
                //ReportViewer1.LocalReport.DataSources.Clear();

                ReportViewer1.LocalReport.DataSources.Add(report2DataSource);
                ReportViewer1.Visible = true;
                //ReportViewer1.LocalReport.Refresh();

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
      
    }

    

}
