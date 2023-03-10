<%@ Page Title="" Language="C#" MasterPageFile="~/Header.Master" AutoEventWireup="true" CodeFile="dashBudget.aspx.cs" Inherits="dashBudget" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
    <style type="text/css">
        .style1
        {
            color: White;
            font-weight: bold;
            width: 104px;
            background-color: #1d1d1d;
            background-image: url('images/gridHeader.jpg');
            background-repeat: repeat-x;
        }
        .style2
        {
            width: 104px;
        }
    </style>
    
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
                Display Vehicle Utilization Dashboard
                <br />
            </td>
        </tr>
        <tr>
            <td align="center" class="subHeading">
                Allows to Generate Vehicle Utilization Dashboard.
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <table border="0" cellpadding="4" cellspacing="0" align="left" width="90%" class="tableBorber">
                    <tr>
                        <td align="center" class="style1">
                            &nbsp;</td>
                        <td align="center" class="TDbg">
                            &nbsp;</td>
                        <td align="center" class="TDbg" colspan="2">
                            Fill The Selection Criteria
                            <asp:Label ID="lblFacError" runat="server" CssClass="error" Text="Select Facility"
                                Visible="False"></asp:Label>
                            &nbsp; &nbsp; &nbsp;
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="left" valign="top" class="style2">
                            &nbsp;</td>
                        
                        <td align="left" valign="top" width="103px">
                            &nbsp;</td>
                        
                        <td align="left" valign="top" width="103px">
                            &nbsp;</td>
                        
                        <td align="left" valign="top">
                            <b>&nbsp;</b></td>
                    </tr>
                    <tr align="center">
                        <td align="left" valign="top" class="style2">
                            <b>Facility Name:</b></td>
                       
                        <td align="left" valign="top">
                            <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" 
                                CssClass="DropDownListBox3" AutoPostBack="True" 
                                onselectedindexchanged="ddlFacility_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                                Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="left" valign="top" class="style2">
                            <b>Years:</b></td>
                       
                        <td align="left" valign="top"width="103px">
                            <asp:DropDownList ID="ddlyear" runat="server" AutoPostBack="True" 
                                onselectedindexchanged="ddlyear_SelectedIndexChanged">
                            </asp:DropDownList> </td>
                       
                        <td align="right" valign="middle"width="103px">
                            <b>Months:</b></td>
                       
                        <td align="left" valign="top">
                            <asp:RadioButtonList ID="rblistMonth" runat="server" 
                                RepeatDirection="Horizontal" AutoPostBack="True" 
                                onselectedindexchanged="rblistMonth_SelectedIndexChanged">
                            <asp:ListItem Text="Jan" Value="1" />
                            <asp:ListItem Text="Feb" Value="2" />
                           <asp:ListItem Text="Mar" Value="3" />
                            <asp:ListItem Text="Apr" Value="4" />
                            <asp:ListItem Text="May" Value="5" />
                            <asp:ListItem Text="Jun" Value="6" />
                            <asp:ListItem Text="Jul" Value="7" />
                            
                            <asp:ListItem Text="Aug" Value="8" />
                            <asp:ListItem Text="Sep" Value="9" />
                            <asp:ListItem Text="Oct" Value="10" />
                            <asp:ListItem Text="Nov" Value="11" />
                            <asp:ListItem Text="Dec" Value="12" />
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
                            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Visible="False" Font-Names="Verdana"
                                Font-Size="8pt" ShowFindControls="False" ShowPrintButton="False" 
                                Width="95%" 
                                AsyncRendering="False" ShowBackButton="True" SizeToReportContent="True" 
                                ShowZoomControl="False" ZoomMode="FullPage">
                                
                              
                            </rsweb:ReportViewer>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
