<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="AssignException.aspx.cs" Inherits="AssignException" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table align="left" width="100%">
                <tr>
                    <td align="center" class="heading" colspan="3">
                        Assign Exceptional Shifts for Non Hiring Zones
                    </td>
                    <td align="center" class="heading">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="center" colspan="3">
                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" Height="16px" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="Submit" />
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" Height="16px" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="Submit2" />
                    </td>
                    <td align="center">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td width="30%">
                        &nbsp;
                    </td>
                    <td align="right" width="25%">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0" DynamicLayout="False">
                            <ProgressTemplate>
                                <img src="images/ajax-loader.gif" />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                    <td width="20%">
                        &nbsp;
                    </td>
                    <td width="30%">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <b>Select Facility:</b>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3"
                            AutoPostBack="True" OnSelectedIndexChanged="ddlFacility_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                            Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                            ValueToCompare="0">*</asp:CompareValidator>
                        <asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="ddlFacility"
                            Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit2"
                            ValueToCompare="0">*</asp:CompareValidator>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td align="left">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td align="left">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <b>Select City: </b>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlCity" runat="server" AppendDataBoundItems="True" 
                            AutoPostBack="True" CssClass="DropDownListBox3" 
                            OnSelectedIndexChanged="ddlCity_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td align="left">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <b>Select Colony: </b>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="lstColony" runat="server" AppendDataBoundItems="True" 
                            AutoPostBack="True" CssClass="DropDownListBox3" 
                            OnSelectedIndexChanged="lstColony_SelectedIndexChanged">
                            <asp:ListItem Value="0">Select Colony</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CompareValidator ID="CompareValidator7" runat="server" ControlToValidate="lstColony"
                            ErrorMessage="Select Colony" Operator="NotEqual" ValidationGroup="Submit" 
                            ValueToCompare="0">*</asp:CompareValidator>
                        <asp:CompareValidator ID="CompareValidator8" runat="server" 
                            ControlToValidate="lstColony" ErrorMessage="Select Colony" Operator="NotEqual" 
                            ValidationGroup="Submit2" ValueToCompare="0">*</asp:CompareValidator>
                    </td>
                    <td align="left">
                        &nbsp;</td>
                    <td align="left">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td align="left">
                        <asp:RadioButtonList ID="rdoTripType" runat="server" AutoPostBack="True" 
                            onselectedindexchanged="rdoTripType_SelectedIndexChanged" RepeatColumns="3" 
                            RepeatDirection="Horizontal">
                            <asp:ListItem Selected="True" Value="P">Pick</asp:ListItem>
                            <asp:ListItem Value="D">Drop</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td align="left">
                        &nbsp;</td>
                    <td align="left">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        Select Exceptional
                        <br />
                        Shifts:</td>
                    <td align="left">
                        <asp:ListBox ID="lstShift" runat="server" AppendDataBoundItems="True" Rows="5" 
                            SelectionMode="Multiple">
                            <asp:ListItem Selected="True" Value="0">-Select-</asp:ListItem>
                        </asp:ListBox>
                        <asp:CompareValidator ID="CompareValidator5" runat="server" 
                            ControlToValidate="lstShift" ErrorMessage="Select Shift" Operator="NotEqual" 
                            ValidationGroup="Submit" ValueToCompare="0">*</asp:CompareValidator>
                    </td>
                    <td align="left" valign="middle">
                        <asp:ListBox ID="lstShiftAssigned" runat="server" AppendDataBoundItems="True" 
                            Rows="5" SelectionMode="Multiple">
                            <asp:ListItem Selected="True" Value="0">-Select-</asp:ListItem>
                        </asp:ListBox>
                        <asp:CompareValidator ID="CompareValidator6" runat="server" 
                            ControlToValidate="lstShiftAssigned" ErrorMessage="Select Shift" 
                            Operator="NotEqual" ValidationGroup="Submit2" ValueToCompare="0">*</asp:CompareValidator>
                    </td>
                    <td align="left" valign="middle">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td align="left">
                        &nbsp;<asp:Button ID="btnSubmit" runat="server" CssClass="Button" OnClick="btnSubmit_Click"
                            Text=" Assign " ValidationGroup="Submit" />
                    </td>
                    <td align="left">
                        <asp:Button ID="btnSubmitAssigned" runat="server" CssClass="Button" OnClick="btnSubmitAssigned_Click"
                            Text="UnAssign" ValidationGroup="Submit2" />
                    </td>
                    <td align="left">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;
                    </td>
                    <td align="left">
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

