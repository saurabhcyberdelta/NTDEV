using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ReportTableAdapters;
using Microsoft.Reporting.WebForms;
public partial class dashboardcostanalysis : basepage2
{

    DataClasses1DataContext tmscontext = new DataClasses1DataContext();
    dashcostanalysisTableAdapter ds = new dashcostanalysisTableAdapter();
    dashboardcostanalysTableAdapter ds1 = new dashboardcostanalysTableAdapter();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

                string strReq = "";
                string[] arrIndMsg = null;
                strReq = Request.RawUrl;
                strReq = strReq.Substring(strReq.IndexOf('?') + 1);
                string id = null, facid = null, years = null;
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

                    if (arrMsgs.Length >= 3)
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
                ReportViewer1.LocalReport.ReportPath = "dashcostanalysis.rdlc";

                ReportDataSource report1DataSource = new ReportDataSource("Report_dashcostanalysis", ds.GetData(Convert.ToInt32(id), Convert.ToInt32(years), Convert.ToInt32(facid)));
                ReportViewer1.LocalReport.DataSources.Clear();

                ReportViewer1.LocalReport.DataSources.Add(report1DataSource);
                ReportDataSource report2DataSource = new ReportDataSource("Report_dashboardcostanalys", ds1.GetData(Convert.ToInt32(years), Convert.ToInt32(facid), Convert.ToInt32(id)));
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
    
