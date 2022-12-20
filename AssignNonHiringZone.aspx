<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="AssignNonHiringZone.aspx.cs" Inherits="AssignNonHiringZone" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    <style type="text/css">
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table align="center" width="90%">
                <tr>
                    <td align="center" class="heading" colspan="4">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="center" class="heading" colspan="4">
                        Assign Non Hiring Zone to Facilities
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4">
                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" Height="16px" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="Submit" />
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" Height="16px" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="Submit2" />
                    </td>
                </tr>
                <tr>
                    <td width="30%">
                        &nbsp;
                    </td>
                    <td align="right" width="20%">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0" DynamicLayout="False">
                            <ProgressTemplate>
                                <img src="images/ajax-loader.gif" />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                    <td width="15%">
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
                        <b>Select City: </b>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlCity" runat="server" AppendDataBoundItems="True" 
                            AutoPostBack="True" CssClass="DropDownListBox3" 
                            OnSelectedIndexChanged="ddlCity_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
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
                        <asp:ListBox ID="lstColony" runat="server" SelectionMode="Multiple" AppendDataBoundItems="True"
                            Rows="5">
                            <asp:ListItem Selected="True" Value="0">-Select-</asp:ListItem>
                        </asp:ListBox>
                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="lstColony"
                            ErrorMessage="Select Colony" Operator="NotEqual" ValidationGroup="Submit" ValueToCompare="0">*</asp:CompareValidator>
                    </td>
                    <td align="right" valign="middle">
                        Select Colony<br />
                        For UnAssign</td>
                    <td align="left">
                        <asp:ListBox ID="lstColonyAssigned" runat="server" AppendDataBoundItems="True" 
                            Rows="5" SelectionMode="Multiple">
                            <asp:ListItem Selected="True" Value="0">-Select-</asp:ListItem>
                        </asp:ListBox>
                        <asp:CompareValidator ID="CompareValidator3" runat="server" 
                            ControlToValidate="lstColonyAssigned" ErrorMessage="Select Colony" 
                            Operator="NotEqual" ValidationGroup="Submit2" ValueToCompare="0">*</asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td align="left">
                        &nbsp;<asp:Button ID="btnSubmit" runat="server" CssClass="Button" OnClick="btnSubmit_Click"
                            Text=" Assign " ValidationGroup="Submit" 
                            ToolTip="Assign Non Hiring Zone to Facilities " />
                    </td>
                    <td align="left">
                        &nbsp;</td>
                    <td align="left">
                        <asp:Button ID="btnSubmitAssigned" runat="server" CssClass="Button" 
                            OnClick="btnSubmitAssigned_Click" Text="UnAssign" 
                            ValidationGroup="Submit2" ToolTip="UnAssign Non Hiring Zone to Facilities " />
                    </td>
                </tr>
                <tr>
                    <td>
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
