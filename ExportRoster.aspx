<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="ExportRoster.aspx.cs" Inherits="ExportRoster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="left">
        <tr>
            <td align="center">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="order" />
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="heading">
                <div class="gradient2">
                    <h1>
                        <span></span>Export Roster Information
                    </h1>
                    <h2>
                        Transport Schedule details are exported to an Excel file.
                    </h2>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="False">
                    <ContentTemplate>
                        <table border="0" cellpadding="0" cellspacing="3" align="left">
                            <tr>
                                <td>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Date:
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="TextBox"></asp:TextBox>
                                    <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" Enabled="True"
                                        TargetControlID="txtStartDate" PopupButtonID="ibcal1">
                                    </cc1:CalendarExtender>
                                    <asp:ImageButton ID="ibcal1" runat="server" ImageUrl="~/images/calendar_icon.gif"
                                        Height="17px" />
                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtStartDate"
                                        Display="Dynamic" ErrorMessage="Start Date Required" ValidationGroup="order"
                                        SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtStartDate"
                                        Display="Dynamic" ErrorMessage="Date Format:mm/dd/yyyy" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                        ValidationGroup="order" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                    &nbsp;&nbsp;<br />
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
                                <td align="right">
                                    Facility Name:
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlfacility" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                        <asp:ListItem Selected="True" Value="0">Select Facility</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlfacility"
                                        ErrorMessage="Select Facility" Operator="NotEqual" ValueToCompare="0" ValidationGroup="order"
                                        SetFocusOnError="True">*</asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td align="left">
                                    <asp:RadioButtonList ID="rdbtnlstType" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True" Value="P">Pick</asp:ListItem>
                                        <asp:ListItem Value="D">Drop</asp:ListItem>
                                    </asp:RadioButtonList>
                                    &nbsp; &nbsp; &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td align="left">
                                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit"
                                        ValidationGroup="order" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="btnSubmit" />
                        <asp:AsyncPostBackTrigger ControlID="ddlfacility" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="rdbtnlstType" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                    DisplayAfter="0">
                    <ProgressTemplate>
                        <table align="left">
                            <tr>
                                <td>
                                    <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" />
                                </td>
                                <td class="main_bg" align="left">
                                    Loading.....Please Wait!!!
                                </td>
                            </tr>
                        </table>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>
    </table>
</asp:Content>
