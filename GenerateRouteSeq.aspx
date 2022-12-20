<%@ Page Title="Generate Routes" Language="C#" MasterPageFile="~/eTMSMaster.master"
    AutoEventWireup="true" CodeFile="GenerateRouteSeq.aspx.cs" Inherits="GenerateRouteSeq" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <link href="StyleSheets/SoftGreyGridView.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style2
        {
            font-size: small;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <table align="center" border="0" style="height: 161px; width: 822px" cellpadding="2"
                cellspacing="1" >
                <tr>
                    <td colspan="4" align="center">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="Submit" Height="16px" />
                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="Update" Height="16px" />
                        <asp:ValidationSummary ID="ValidationSummary3" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="add" Height="16px" />
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4">
                        <asp:Label ID="lblErrorMsg" runat="server" CssClass="error"></asp:Label>
                        &nbsp;
                    </td>
                </tr>
                <tr align="center">
                    <td colspan="4" align="left" class="style2">
                        Genareate Routes
                    </td>
                </tr>
                <tr align="center">
                    <td align="center" valign="middle">
                        <b>Start Date:</b>&nbsp;
                        <asp:TextBox ID="txtStartDate" runat="server" CssClass="TextBox"></asp:TextBox>
                        <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" Enabled="true"
                            TargetControlID="txtStartDate" PopupButtonID="ibcal1">
                        </cc1:CalendarExtender>
                        &nbsp;<asp:ImageButton ID="ibcal1" runat="server" ImageUrl="~/images/calendar_icon.gif"
                            Height="17px" />
                        <i>(mm/dd/yyyy)</i>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtStartDate"
                            Display="Dynamic" ErrorMessage="Enter Valid Start Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                            ValidationGroup="Submit">*</asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Start Date"
                            ControlToValidate="txtStartDate" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                    </td>
                    <td align="center">
                        <b>Facility Name:</b>&nbsp;
                        <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                            OnSelectedIndexChanged="ddlFacility_SelectedIndexChanged" CssClass="DropDownListBox3">
                        </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                            Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                            ValueToCompare="0">*</asp:CompareValidator>
                    </td>
                    <td rowspan="2">
                        <asp:RadioButtonList ID="rdoTripType" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                            AutoPostBack="True" OnSelectedIndexChanged="rdoTripType_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Value="P">Pick</asp:ListItem>
                            <asp:ListItem Value="D">Drop</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr align="center">
                    <td>
                    </td>
                    <td align="center">
                    </td>
                </tr>
                <tr align="center">
                    <td align="right">
                        <b>Shift:</b><br />
                        <em>ctrl-click for multi - select</em>&nbsp;
                    </td>
                    <td align="left">
                        &nbsp;<asp:ListBox ID="lstShift" runat="server" SelectionMode="Multiple" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="0"></asp:ListItem>
                        </asp:ListBox>
                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="lstShift"
                            ErrorMessage="Select Shift Time" Operator="NotEqual" ValidationGroup="Submit"
                            ValueToCompare="0">*</asp:CompareValidator>
                    </td>
                    <td>
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" ValidationGroup="Submit"
                            OnClick="btnSubmit_Click" CssClass="Button" />
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4">
                        <asp:Label ID="lblMsg" runat="server" Visible = "false" Font-Bold ="true"  ></asp:Label>
                    </td>
                </tr>
                <tr align="center">
                    <td align="right" colspan="3">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                            DisplayAfter="0">
                            <ProgressTemplate>
                                <table align="center" style="width: 400px">
                                    <tr>
                                        <td style="width: 200px">
                                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loding..." />
                                        </td>
                                        <td class="main_bg" style="width: 200px" align="left">
                                            Loading.....Please Wait!!!
                                        </td>
                                    </tr>
                                </table>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
