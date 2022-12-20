<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="RptProcessWiseCostNew.aspx.cs" Inherits="RptProcessWiseCostNew" %>



<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
                                    <div class="gradient2">
                                        <h1>
                                            <span></span>Process Wise Cost
                                        </h1>
                                        <h2>
                                              Allows to Give Process Wise Cost
                                        </h2>
                                    </div>
                                </td>
           </tr>
        <tr>
            <td>
                <br />
                <table border="0" cellpadding="4" cellspacing="0" align="left" width="90%" class="tableBorber">
                    <tr>
                        <td align="center" class="TDbg" colspan="7">
                            Fill The Selection Criteria
                            <asp:Label ID="lblFacError" runat="server" CssClass="error" Text="Select Facility"
                                Visible="False"></asp:Label>
                            &nbsp; &nbsp; &nbsp;
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="left" valign="top">
                            <b>Month:</b>
                        </td>
                        <td align="left" valign="top">
                            <b>Year:</b>&nbsp;
                        </td>
                        <td align="left" valign="top">
                            <b>Facility Name: </b>
                        </td>
                        
                        <td align="left" rowspan="2" valign="middle">
                            <asp:Button ID="btnSubmit" runat="server" Text="Run Report" ValidationGroup="Submit"
                                OnClick="btnSubmit_Click" CssClass="Button" />
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="left" valign="top">
                            <asp:DropDownList ID="ddlMonth" runat="server">
                           </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="ddlMonth"
                                Display="Dynamic" ErrorMessage="Select Month" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                </td>
                        <td align="left" valign="top">
                            <asp:DropDownList ID="ddlYear" runat="server">
                           </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="ddlYear"
                                Display="Dynamic" ErrorMessage="Select Month" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                              </td>
                        <td align="left" valign="top">
                            <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" 
                                CssClass="DropDownListBox3" AutoPostBack="False" 
                                onselectedindexchanged="ddlFacility_SelectedIndexChanged" Visible="false">
                            </asp:DropDownList>
                           
                        </td>
                       
                       
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table align="left" width="90%">
                        <td align="left">
                            <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto" Width="100%">
                                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Visible="False" Width="100%"
                                    Font-Names="Verdana" Font-Size="8pt" Style="margin-bottom: 30px" 
                                    ShowBackButton="True" ShowFindControls="False" ShowPrintButton="False" 
                                    Height="400px" ShowZoomControl="False">
                                    <LocalReport ReportPath="RptTotalProcess.rdlc">
                                        <DataSources>
                                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" 
                                                Name="RepProcessWiseCost_ReptotalProcessCost" />
                                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource3" 
                                                Name="RepProcessWiseCost_TotalProcessPartner" />
                                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource4" 
                                                Name="RepProcessWiseCost_repProcesswiseCostcenterCost" />
                                        </DataSources>
                                    </LocalReport>
                                </rsweb:ReportViewer>
                                <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" 
                                    SelectMethod="GetData" 
                                    TypeName="RepProcessWiseCostTableAdapters.repProcesswiseCostcenterCostTableAdapter">
                                </asp:ObjectDataSource>
                                <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" 
                                    SelectMethod="GetData" 
                                    TypeName="RepProcessWiseCostTableAdapters.TotalProcessPartnerTableAdapter">
                                </asp:ObjectDataSource>
                                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" 
                                    SelectMethod="GetData" TypeName="RepProcessWiseCostTableAdapters.">
                                </asp:ObjectDataSource>
                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                                    SelectMethod="GetData" 
                                    TypeName="RepProcessWiseCostTableAdapters.ReptotalProcessCostTableAdapter">
                                </asp:ObjectDataSource>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

