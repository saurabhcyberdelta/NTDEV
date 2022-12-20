<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="NewBillingReports.aspx.cs" Inherits="NewBillingReports" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>--%>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="StyleSheets/GridView.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/TMS.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <table align="center" border="0">
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
            <td class="heading">Detailed Transport Cost
                        <br />
            </td>
        </tr>
        <tr>
            <td align="center" class="subHeading">Allows to Generate Detailed Transport Cost.
            </td>
        </tr>
        <tr>
            <td align="center">
                <br />
            </td>
        </tr>
        <tr>
            <td align="center">
                <table border="0" cellpadding="4" cellspacing="0" align="center" width="900" class="GridView">
                    <tr>
                        <td align="center" class="TDbg" colspan="7">Fill The Selection Criteria
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
                            <b>To Date:</b>&nbsp;
                        </td>
                        <td align="left" valign="top">
                            <b>Facility Name: </b>
                        </td>
                        <td align="left" valign="top">
                            <b>Vendor: </b>
                        </td>
                        <td align="left" rowspan="2" valign="middle">
                            <asp:RadioButtonList ID="rdbWeekType" runat="server">
                                <asp:ListItem Text="Week Day" Value="1" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Week End" Value="2"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                        <td align="left" valign="top">
                            <b>Report Type</b>
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
                            <asp:TextBox ID="txtEndDate" runat="server" CssClass="TextBox"></asp:TextBox>
                            &nbsp;<asp:ImageButton ID="ibcal2" runat="server" ImageUrl="~/images/calendar_icon.gif"
                                Height="17px" />
                            <br />
                            <cc1:CalendarExtender ID="txtEndDate_CalendarExtender" runat="server" Enabled="True"
                                TargetControlID="txtEndDate" PopupButtonID="ibcal2">
                            </cc1:CalendarExtender>
                            <i>(mm/dd/yyyy)</i>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEndDate"
                                Display="Dynamic" ErrorMessage="Enter Valid End Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                ValidationGroup="Submit">*</asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter End Date"
                                ControlToValidate="txtEndDate" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator15" runat="server" ControlToCompare="txtStartDate"
                                ControlToValidate="txtEndDate" ErrorMessage="End Date cannot be less than Start Date."
                                Operator="GreaterThanEqual" SetFocusOnError="True" Type="Date" ValidationGroup="Submit">*</asp:CompareValidator>
                        </td>
                        <td align="left" valign="top">
                            <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3"
                                AutoPostBack="True" OnSelectedIndexChanged="ddlFacility_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                                Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                        </td>
                        <td align="left" valign="top">
                            <asp:DropDownList ID="ddlVendor" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlVendor"
                                Display="Dynamic" ErrorMessage="Select Vendor " Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="-1" SetFocusOnError="True">*</asp:CompareValidator>
                        </td>
                        <td align="left" valign="top">
                            <%--<asp:RadioButtonList ID="rdbreptype" runat="server">
                                <asp:ListItem Text="Slab Detail" Value="1" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Slab Cost Calculation" Value="4"></asp:ListItem>
                                <asp:ListItem Text="Medical Billing" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Additional Billing" Value="3"></asp:ListItem>
                                <asp:ListItem Text="FTE-LTE-20 Billing" Value="5"></asp:ListItem>
                            </asp:RadioButtonList>--%>
                            <asp:DropDownList runat="server" ID="rdbreptype" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                <asp:ListItem Text="-Select-" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Slab Detail" Value="1" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Slab Cost Calculation" Value="4"></asp:ListItem>
                                <asp:ListItem Text="Medical Billing" Value="2"></asp:ListItem>
                                <%--<asp:ListItem Text="Additional Billing" Value="3"></asp:ListItem>--%>
                                <asp:ListItem Text="FTE-LTE-20 Billing" Value="5"></asp:ListItem>
                                <asp:ListItem Text="GV Trip Billing" Value="6"></asp:ListItem>
                                <asp:ListItem Text="Pune Trip Billing" Value="7"></asp:ListItem>
                                <asp:ListItem Text="(KSS)Medical Billing" Value="8"></asp:ListItem>
                                <asp:ListItem Text="Per Employee Cost" Value="9"></asp:ListItem>
                                <asp:ListItem Text="Process Wise Billing" Value="10"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:CompareValidator ID="cpvalidator" runat="server" ValueToCompare="0" ControlToValidate="rdbreptype" ValidationGroup="Submit" 
                                Display="Dynamic" ErrorMessage="Please select report type" SetFocusOnError="True" Operator="NotEqual">*</asp:CompareValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center">
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Visible="False" Width="800px"
                    Font-Names="Verdana" Font-Size="8pt" Style="margin-bottom: 30px"
                    ShowFindControls="False" ShowPrintButton="False" AsyncRendering="False"
                    ShowZoomControl="False" SizeToReportContent="True" ZoomMode="FullPage" 
                    WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Height="500px">
                    <LocalReport ReportPath="FTE-LTEBilling.rdlc">
                        <DataSources>
                            <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" 
                                Name="RPtBillingDataSet_FTELTEBilling" />
                        </DataSources>
                    </LocalReport>
                </rsweb:ReportViewer>
                <%--<asp:ObjectDataSource ID="ObjectDataSource2" runat="server" 
                    SelectMethod="GetData" 
                    TypeName="RPtBillingDataSetTableAdapters.MedicalDetailBillingTableAdapter">
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
                    SelectMethod="GetData" TypeName="RPtBillingDataSetTableAdapters.SlabDetailBillingTableAdapter">
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" 
                    SelectMethod="GetData" TypeName="RPtBillingDataSetTableAdapters.AdditionalDetailBillingTableAdapter">
                </asp:ObjectDataSource>--%>

                <br />
                
            </td>
        </tr>
    </table>
</asp:Content>

