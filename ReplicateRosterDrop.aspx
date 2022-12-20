<%@ Page Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="ReplicateRosterDrop.aspx.cs" Inherits="ReplicateRosterDrop" Title="Drop Route Replication" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="StyleSheets/GridView.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/TMS.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table align="left" width="50%">
                <tr>
                    <td align="center">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="order" />
                    </td>
                </tr>
                <tr>
                <td class="heading">
                                    <div class="gradient2">
                                        <h1>
                                            <span></span>Replicate Drop
                                        </h1>
                                        <h2>
                                               Day Wise Only Drop Route Replication
             
                                        </h2>
                                    </div>
                                </td>
                   
                </tr>
                <tr>
                    <td>
                        <fieldset>
                            <legend style="font-weight: 700">Replicate From PickUp:</legend>
                            <table align="left" width="100%">
                                <tr>
                                    <td align="right">
                                        Date:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="TextBox"></asp:TextBox>
                                        <cc1:CalendarExtender ID="txtFromDate_CalendarExtender" runat="server" Enabled="True"
                                            TargetControlID="txtFromDate" PopupButtonID="ImgBtnCalendar">
                                        </cc1:CalendarExtender>
                                        <asp:ImageButton ID="ImgBtnCalendar" runat="server" ImageUrl="Images/calendar_icon.gif"
                                            Height="17px" Width="17px" />
                                        <i>&nbsp;(mm/dd/yyyy)</i> &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                            runat="server" ControlToValidate="txtFromDate" Display="Dynamic" ErrorMessage="Start Date Required"
                                            ValidationGroup="order" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtFromDate"
                                                Display="Dynamic" ErrorMessage="Date Format:mm/dd/yyyy" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                ValidationGroup="order" SetFocusOnError="True">*</asp:RegularExpressionValidator>&nbsp;&nbsp;<br />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblFacError" runat="server" CssClass="error" Text="Select Facility"
                                            Visible="False"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" width="30%">
                                        Facility Name:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlfacility" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                            OnSelectedIndexChanged="ddlfacility_SelectedIndexChanged" CssClass="DropDownListBox3">
                                            <asp:ListItem Selected="True" Value="0">Select Facility</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlfacility"
                                            ErrorMessage="Select Facility" Operator="NotEqual" ValueToCompare="0" ValidationGroup="order"
                                            SetFocusOnError="True">*</asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        PickUp Shift:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlPickShift" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                            <asp:ListItem Selected="True" Value="0">-Select-</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlPickShift"
                                            Display="Dynamic" ErrorMessage="Select PickUp ShiftTime" Operator="NotEqual"
                                            ValidationGroup="order" ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset>
                            <legend style="font-weight: 700">Replicate To Drop:</legend>
                            <table width="100%">
                                <tr>
                                    <td align="right" width="30%">
                                        Date:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtToDate" runat="server" CssClass="TextBox"></asp:TextBox>
                                        <cc1:CalendarExtender ID="txtToDate_CalendarExtender" runat="server" Enabled="True"
                                            TargetControlID="txtToDate" PopupButtonID="ImgBtnCalendar1">
                                        </cc1:CalendarExtender>
                                        <asp:ImageButton ID="ImgBtnCalendar1" runat="server" ImageUrl="Images/calendar_icon.gif"
                                            Height="17px" Width="17px" />
                                        <i>&nbsp;(mm/dd/yyyy)</i> &nbsp;
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtToDate"
                                            Display="Dynamic" ErrorMessage="Replicate To Date is Required" ValidationGroup="order"
                                            SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtToDate"
                                            Display="Dynamic" ErrorMessage="Date Format:mm/dd/yyyy" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                            ValidationGroup="order" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                        <asp:CompareValidator ID="CompareValidator15" runat="server" ControlToCompare="txtFromDate"
                                            ControlToValidate="txtToDate" ErrorMessage="Replicate To Date cannot be less than equal to Replicate From Date."
                                            Operator="GreaterThanEqual" SetFocusOnError="True" Type="Date" 
                                            ValidationGroup="order">*</asp:CompareValidator>
                                        <asp:CompareValidator ID="CompareValidator3" ControlToValidate="txtToDate" Operator="GreaterThanEqual"
                                            Type="Date" runat="server" ErrorMessage="Replicate To Date must be greater than equal to current date"
                                            ValidationGroup="order" Display="Dynamic">*</asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Drop Shift:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlDropShift" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                            <asp:ListItem Selected="True" Value="0">-Select-</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="ddlDropShift"
                                            Display="Dynamic" ErrorMessage="Select Drop ShiftTime" Operator="NotEqual" ValidationGroup="order"
                                            ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Replicate"
                            ValidationGroup="order" CssClass="Button" />
                        <cc1:ConfirmButtonExtender ID="ConfirmButton_btnSave" TargetControlID="btnSubmit"
                            runat="server" ConfirmOnFormSubmit="False" ConfirmText="Are you sure you want to replicate the Routes.">
                        </cc1:ConfirmButtonExtender>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="lblErrorFlag" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                            DisplayAfter="0">
                            <ProgressTemplate>
                                <table align="center">
                                    <tr>
                                        <td>
                                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loading" />
                                        </td>
                                        <td class="main_bg" align="center">
                                            Please Wait!!!
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
