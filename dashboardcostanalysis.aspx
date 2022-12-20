<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="dashboardcostanalysis.aspx.cs" Inherits="dashboardcostanalysis" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" border="0" width="100%">
        <tr>
            <td align="center">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="Submit" Height="16px" />
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Label ID="lblErrorMsg" runat="server" CssClass="error"></asp:Label>
                &nbsp;
            </td>
        </tr>
        <tr align="center">
            <td class="heading">
            
             
            </td>
        </tr>
       
        <tr>
            <td>
                <br />
               
            </td>
        </tr>
        <tr>
            <td>
                <table align="left" width="80%">
                    <tr>
                        <td align="left">
                            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Visible="False" Font-Names="Verdana"
                                Font-Size="8pt" ShowFindControls="False" ShowPrintButton="False" 
                                Width="95%" 
                                AsyncRendering="False" ShowBackButton="True" SizeToReportContent="True" 
                                ShowZoomControl="False" ZoomMode="FullPage">
                                <LocalReport ReportPath="dashCostAnalysis.rdlc">
                                </LocalReport>
                            </rsweb:ReportViewer>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

