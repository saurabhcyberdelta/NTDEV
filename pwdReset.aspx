<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="pwdReset.aspx.cs" Inherits="pwdReset" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
         <table width="100%" align="center">
                <tr>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="addemp" />
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="editemp" />
                    <asp:ValidationSummary ID="ValidationSummary3" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="addgeo" />
                    <asp:ValidationSummary ID="ValidationSummary4" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="editgeo" />
                    <asp:ValidationSummary ID="ValidationSummary5" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="search" />
                    <td align="center">
                        <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="heading">
                        <div class="gradient2">
                            <h1>
                                <span></span>Password Reset
                            </h1>
                            <h2>
                                Allows to reset the password.
                            </h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch">
                            <table align="center" width="60%">
                                <tr>
                                    <td width="30%">
                                        Enter Partner ID or Name:
                                    </td>
                                    <td width="20%" align="left">
                                        <asp:TextBox ID="txtEmpIdName" runat="server" CssClass="TextBox1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmpIdName"
                                            Display="Dynamic" ErrorMessage="Please Enter Name or Id" ValidationGroup="search"
                                            SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td width="10%">
                                        <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search"
                                            ValidationGroup="search" CssClass="Button" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="20%" align="center" colspan="3">
                                       
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="center">
                                        <asp:Label ID="lblMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:MultiView ID="MultiView1" runat="server">
                            <table align="center" width="90%">
                                <tr>
                                    <td align="center">
                                        <asp:View ID="View1" runat="server">
                                            <table width="80%" align="center">
                                                <tr>
                                                    <td align="center" width="100%">
                                                        <asp:GridView ID="GvEmployee" OnPageIndexChanging="GvEmployee_PageIndexChanging" runat="server" AutoGenerateColumns="False" CssClass="GridView"
                                                            DataKeyNames="Id" 
                                                            AllowPaging="True" BorderWidth="0" ShowFooter="True" Width="100%">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Reset">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lbtnResetPwd" runat="server" onclick="lbtnResetPwd_Click">Reset</asp:LinkButton>
                                                                         <cc1:ConfirmButtonExtender ID="ConfirmButton_btnSave" TargetControlID="lbtnResetPwd"
                                                              runat="server" ConfirmOnFormSubmit="False" ConfirmText="Do You Really Want to Reset the Password?">
                                                                  </cc1:ConfirmButtonExtender>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                
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
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                    </td>
                                </tr>
                            </table>
                        </asp:MultiView>
                    </td>
                </tr>
                </table>
</asp:Content>

