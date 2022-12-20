<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="AssignExceptionToEmp.aspx.cs" Inherits="AssignExceptionToEmp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch">
                <table width="100%">
                    <tr>
                        <td align="center" class="heading" colspan="4">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="heading" colspan="4">
                            Assign Employee to Exception Shift
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="3">
                            <asp:ValidationSummary ID="ValidationSummary2" runat="server" Height="16px" ShowMessageBox="True"
                                ShowSummary="False" ValidationGroup="Submit" />
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" Height="16px" ShowMessageBox="True"
                                ShowSummary="False" ValidationGroup="Submit2" />
                        </td>
                        <td align="center">
                            &nbsp;
                        </td>
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
                            &nbsp;
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="center" width="25%" colspan="4">
                            Enter Employee ID or Name:&nbsp;<asp:TextBox ID="txtEmpIdName" runat="server"></asp:TextBox>&nbsp;<asp:Button
                                ID="btnSearch" runat="server" CssClass="Button" OnClick="btnSearch_Click" Text="Search"
                                ValidationGroup="search" />
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="right" width="30%">
                            &nbsp;
                        </td>
                        <td align="right" width="25%">
                            <asp:Label ID="lblMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                        </td>
                        <td align="left" width="20%">
                            &nbsp;
                        </td>
                        <td width="30%">
                            &nbsp;
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="center" colspan="4" width="30%">
                            <asp:MultiView ID="MultiView1" runat="server">
                                <table align="center">
                                    <tr>
                                        <td align="center">
                                            <asp:View ID="View1" runat="server">
                                                <table width="80%" align="center">
                                                    <tr>
                                                        <td align="center">
                                                            <asp:GridView ID="GvEmployee" runat="server" AutoGenerateColumns="False" CssClass="GridView"
                                                                DataKeyNames="Id" OnPageIndexChanging="GvEmployee_PageIndexChanging" OnSelectedIndexChanging="GvEmployee_SelectedIndexChanging"
                                                                AllowPaging="True">
                                                                <Columns>
                                                                    <asp:CommandField SelectText="Select" ShowSelectButton="True" />
                                                                    <asp:TemplateField HeaderText="Partner Id">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblEmpId" runat="server" Text='<%# Eval("empCode") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Partner Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblEmpName" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Process">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblEmpProcess" runat="server" Text='<%# Eval("processName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Facility">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblEmpFacility" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="E-mail">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblEmpEmail" runat="server" Text='<%# Eval("email") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <RowStyle CssClass="RowStyle" />
                                                                <FooterStyle CssClass="FooterStyle" />
                                                                <PagerStyle CssClass="PagerStyle" />
                                                                <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                                <HeaderStyle CssClass="HeaderStyle" />
                                                                <EditRowStyle BackColor="#999999" />
                                                                <AlternatingRowStyle CssClass="AltRowStyle" />
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:View>
                                        </td>
                                    </tr>
                                </table>
                                <asp:View ID="View2" runat="server">
                                    <table style="border-style: solid; border-width: thin; background-color: #E2E2E2"
                                        cellpadding="2" width="350">
                                        <tr>
                                            <td align="right">
                                                Selected Partner:&nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:Label ID="lblempname" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Assigned Colony:&nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:Label ID="lblempcolony" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Select Facility:
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
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Select Shift Type:
                                            </td>
                                            <td align="left">
                                                <asp:RadioButtonList ID="rdoTripType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rdoTripType_SelectedIndexChanged"
                                                    RepeatColumns="3" RepeatDirection="Horizontal">
                                                    <asp:ListItem Selected="True" Value="P">Pick</asp:ListItem>
                                                    <asp:ListItem Value="D">Drop</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" valign="top">
                                                Select Shift:<br />
                                                <asp:ListBox ID="lstShift" runat="server" AppendDataBoundItems="True" Rows="5" SelectionMode="Multiple">
                                                    <asp:ListItem Selected="True" Value="0">-Select-</asp:ListItem>
                                                </asp:ListBox>
                                                <asp:CompareValidator ID="CompareValidator5" runat="server" ControlToValidate="lstShift"
                                                    ErrorMessage="Select Shift" Operator="NotEqual" ValidationGroup="Submit" ValueToCompare="0">*</asp:CompareValidator>
                                                &nbsp;
                                            </td>
                                            <td align="center" valign="top">
                                                Unassign Shift:<br />
                                                <asp:ListBox ID="lstShiftAssigned" runat="server" AppendDataBoundItems="True" Rows="5"
                                                    SelectionMode="Multiple" ValidationGroup="UnAssign">
                                                    <asp:ListItem Selected="True" Value="0">-Select-</asp:ListItem>
                                                </asp:ListBox>
                                                <asp:CompareValidator ID="CompareValidator6" runat="server" ControlToValidate="lstShiftAssigned"
                                                    ErrorMessage="Select Shift" Operator="NotEqual" ValidationGroup="Submit2" ValueToCompare="0">*</asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                &nbsp;&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                &nbsp;
                                                <asp:Button ID="btnSubmit0" runat="server" CssClass="Button" OnClick="btnSubmit_Click"
                                                    Text=" Assign " ValidationGroup="Submit" Width="100px" />
                                            </td>
                                            <td align="center">
                                                <asp:Button ID="btnUnAssign" runat="server" CssClass="Button" OnClick="btnUnAssign_Click"
                                                    Text=" Un-Assign " ValidationGroup="Submit2" Width="100px" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:View>
                            </asp:MultiView>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
