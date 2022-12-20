﻿<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="RepZoneEmployee.aspx.cs" Inherits="RepZoneEmployee" %>


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
                                            <span></span>Display AreaWise/Distance wise Employee count
                                        </h1>
                                        <h2>
                                             Allows to AreaWise/Distance wise Employee count
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
                            <b>Facility Name:</b>&nbsp;
                        </td>
                        <td align="left" valign="top">
                            <b>Type</b>
                        </td>
                        <td align="left" rowspan="2" valign="middle">
                            <asp:Button ID="btnSubmit" runat="server" Text="Run Report" ValidationGroup="Submit"
                                OnClick="btnSubmit_Click" CssClass="Button" />
                        </td>
                    </tr>
                    <tr align="center">
                        
                        <td align="left" valign="top">
                             <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                                Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                        
                                 </td>
                        <td align="left" valign="top">
                            <asp:RadioButtonList ID="rdbtnTripType" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Area Wise" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Distance Wise" Value="2"></asp:ListItem>
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
                            <asp:GridView ID="GridView1" runat="server" Visible="False">
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

