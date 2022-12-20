﻿<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="RepFleetvsRoutes.aspx.cs" Inherits="RepFleetvsRoutes" %>


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
                
               <div class="gradient2">
                                        <h1>
                                            <span></span>Fleet Vs Routes Report
                                        </h1>
                                        <h2>
                                             Allows to Generate Fleet Vs Routes Report 
                                        </h2>
                                    </div>
                                    
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <table border="0" cellpadding="4" cellspacing="0" align="left" width="90%" class="tableBorber">
                    <tr>
                        <td align="center" class="TDbg" colspan="4">
                            Fill The Selection Criteria
                            <asp:Label ID="lblFacError" runat="server" CssClass="error" Text="Select Facility"
                                Visible="False"></asp:Label>
                            &nbsp; &nbsp; &nbsp;
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="left" valign="top">
                            <b>From Date:</b>
                        </td>
                        <td align="left" valign="top">
                            <b>Facility Name:</b>&nbsp;
                        </td>
                        <td align="left" valign="top">
                            <b>Trip Type </b>
                        </td>
                        <td align="left" rowspan="2" valign="middle">
                            <asp:Button ID="btnSubmit" runat="server" Text="Run Report" ValidationGroup="Submit"
                                OnClick="btnSubmit_Click" CssClass="Button" />
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="left" valign="top">
                            <asp:TextBox ID="txtStartDate" runat="server" CssClass="TextBox"></asp:TextBox>
                            <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" Enabled="true"
                                TargetControlID="txtStartDate" PopupButtonID="ibcal1">
                            </cc1:CalendarExtender>
                            &nbsp;<asp:ImageButton ID="ibcal1" runat="server" ImageUrl="~/images/calendar_icon.gif"
                                Height="17px" /><br />
                            <i>(mm/dd/yyyy)</i>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtStartDate"
                                Display="Dynamic" ErrorMessage="Enter Valid Start Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                ValidationGroup="Submit">*</asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Start Date"
                                ControlToValidate="txtStartDate" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                        </td>
                        <td align="left" valign="top">
                             <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                                Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                        
                                 </td>
                        <td align="left" valign="top">
                            <asp:RadioButtonList ID="rdbtnTripType" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Pick" Value="P" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Drop" Value="D"></asp:ListItem>
                            </asp:RadioButtonList>
                           </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table align="left" width="80%">
                    <tr>
                        <td align="left">
                            <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto" Width="100%">
                                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Visible="False" Width="100%"
                                    Font-Names="Verdana" Font-Size="8pt" Style="margin-bottom: 30px" 
                                    ShowBackButton="True" ShowFindControls="False" ShowPrintButton="False" 
                                    Height="400px" AsyncRendering="False" ShowZoomControl="False" 
                                    SizeToReportContent="True" ZoomMode="FullPage">
                                    <LocalReport ReportPath="RepFeet.rdlc">
                                        <DataSources>
                                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" 
                                                Name="Report_RptFleetvsRoutes" />
                                        </DataSources>
                                    </LocalReport>
                                </rsweb:ReportViewer>
                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                                    SelectMethod="GetData" 
                                    TypeName="ReportTableAdapters.RptFleetvsRoutesTableAdapter">
                                </asp:ObjectDataSource>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

