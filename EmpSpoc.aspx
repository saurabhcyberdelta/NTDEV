<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="EmpSpoc.aspx.cs" Inherits="EmpSpoc" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table width="100%" align="center">
                <tr>
                    <td align="center">
                        <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="search" />
                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="emp" />
                    </td>
                </tr>
                <tr>
                    <td class="heading">
                        <div class="gradient2">
                            <h1>
                                <span></span>Manage SPOC
                            </h1>
                            <h2>
                                Allows to View Employee assignments for a SPOC.
                            </h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <table width="100%" align="center">
                            <tr>
                                <td align="center">
                                    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch">
                                        <table align="center">
                                            <tr>
                                                <td width="33%" align="center">
                                                    Enter SPOC ID or Name:
                                                </td>
                                                <td width="33%">
                                                    <asp:TextBox ID="txtEmpIdName" runat="server" ValidationGroup="spoc" MaxLength="100"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmpIdName"
                                                        Display="Dynamic" ErrorMessage="Please Enter Name or Id" ValidationGroup="search"
                                                        SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                </td>
                                                <td width="33%">
                                                    <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search"
                                                        ValidationGroup="search" CssClass="Button" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="33%">
                                                    &nbsp;
                                                </td>
                                                <td width="33%">
                                                    <asp:Label ID="lblMsg" runat="server" CssClass="error"></asp:Label>
                                                </td>
                                                <td width="33%">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:MultiView ID="MultiView1" runat="server">
                                        <asp:View ID="View1" runat="server">
                                            <asp:GridView ID="gvSPOC" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
                                                OnPageIndexChanging="gvSPOC_PageIndexChanging" OnSelectedIndexChanging="gvSPOC_SelectedIndexChanging"
                                                AllowPaging="True" BorderWidth="0px" ShowFooter="True" Width="70%">
                                                <Columns>
                                                    <asp:CommandField SelectText="View SPOC" ShowSelectButton="True" />
                                                    <asp:TemplateField HeaderText="Employee ID">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblEmpId" runat="server" Text='<%# Eval("empCode") %>'></asp:Label></ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Employee Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblEmpName" runat="server" Text='<%# Eval("empName") %>'></asp:Label></ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Process">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblProcess" runat="server" Text='<%# Eval("processName") %>'></asp:Label></ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Facility">
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label></ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblRecordsPerPage" runat="server"></asp:Label>
                                                        </FooterTemplate>
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
                                        </asp:View>
                                        <asp:View ID="View2" runat="server">
                                            <table align="center" cellpadding="4" cellspacing="0">
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:Panel ID="panel2" runat="server" DefaultButton="btnEmpSearch">
                                                            <table>
                                                                <tr>
                                                                    <td width="40%" align="center">
                                                                        Enter Emp ID or Name:
                                                                    </td>
                                                                    <td width="25%">
                                                                        <asp:TextBox ID="txtSPOCIdName" runat="server" ValidationGroup="emp" MaxLength="100"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSPOCIdName"
                                                                            Display="Dynamic" ErrorMessage="Please Enter Name or Id" ValidationGroup="emp"
                                                                            SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                    </td>
                                                                    <td width="15%" align="left">
                                                                        <asp:Button ID="btnEmpSearch" runat="server" OnClick="btnEmpSearch_Click" Text="Search"
                                                                            ValidationGroup="emp" CssClass="Button" />
                                                                    </td>
                                                                    <td align="left" width="5%">
                                                                        <b>OR</b>
                                                                    </td>
                                                                    <td width="25%">
                                                                        <asp:DropDownList ID="ddlProcessSort" runat="server" AppendDataBoundItems="True"
                                                                            AutoPostBack="True" OnSelectedIndexChanged="ddlProcessSort_SelectedIndexChanged">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4">
                                                                        &nbsp;
                                                                        <asp:Label ID="lblSpocMsg" runat="server" CssClass="error"></asp:Label>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td width="25%">
                                                                        &nbsp;
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
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td width="25%">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table align="center">
                                                            <tr>
                                                                <td align="center">
                                                                    <asp:Label ID="lblSpocName" runat="server" Style="font-weight: 700"></asp:Label>
                                                                </td>
                                                                <td align="center">
                                                                    <asp:Label ID="lblBackupSpoc" runat="server" Style="font-weight: 700"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td valign="top" align="center">
                                                                    <asp:GridView ID="gvSPOCDetails" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                        DataKeyNames="Id,spocId" OnPageIndexChanging="gvSPOCDetails_PageIndexChanging"
                                                                        OnRowCommand="gvSPOCDetails_RowCommand" OnRowDeleting="gvSPOCDetails_RowDeleting"
                                                                        PageSize="5" Width="400px" BorderWidth="0" ShowFooter="True">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Employee ID">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblSpocEmpCode" runat="server" Text='<%# Eval("empCode") %>'></asp:Label></ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Employee Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblSpocEmpName" runat="server" Text='<%# Eval("empName") %>'></asp:Label></ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Facility">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label></ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Actions" ShowHeader="False">
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                                                                        Text="Remove"></asp:LinkButton><cc1:ConfirmButtonExtender ID="LinkButton1_ConfirmButtonExtender"
                                                                                            runat="server" ConfirmText="Are You Sure You Want To Remove?" Enabled="True"
                                                                                            TargetControlID="LinkButton1">
                                                                                        </cc1:ConfirmButtonExtender>
                                                                                </ItemTemplate>
                                                                                <HeaderTemplate>
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td style="text-align: right">
                                                                                                <asp:ImageButton ID="ImageButton2" runat="server" AlternateText="Close" CausesValidation="False"
                                                                                                    CommandName="close" ImageUrl="~/images/Exit.jpg" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </HeaderTemplate>
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
                                                                <td valign="top" align="center">
                                                                    <asp:GridView ID="gvSPOCBackup" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                        DataKeyNames="id,spocId" OnPageIndexChanging="gvSPOCBackup_PageIndexChanging"
                                                                        OnRowDeleting="gvSPOCBackup_RowDeleting" PageSize="5" Width="500px" BorderWidth="0"
                                                                        ShowFooter="True">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Employee ID">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblSpocEmpCode0" runat="server" Text='<%# Eval("empCode") %>'></asp:Label></ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Employee Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblSpocEmpName0" runat="server" Text='<%# Eval("empName") %>'></asp:Label></ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Facility">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label></ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Actions" ShowHeader="False">
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandName="Delete"
                                                                                        Text="Remove Backup"></asp:LinkButton><cc1:ConfirmButtonExtender ID="LinkButton3_ConfirmButtonExtender"
                                                                                            runat="server" ConfirmText="Are You Sure You Want To Remove This backup Spoc?"
                                                                                            Enabled="True" TargetControlID="LinkButton3">
                                                                                        </cc1:ConfirmButtonExtender>
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
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="2">
                                                        <asp:GridView ID="GvEmployee" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                            DataKeyNames="Id" OnPageIndexChanging="GvEmployee_PageIndexChanging" OnRowCommand="GvEmployee_RowCommand"
                                                            OnSelectedIndexChanging="GvEmployee_SelectedIndexChanging" BorderWidth="0" ShowFooter="True"
                                                            Width="70%">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Employee ID">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblEmpId0" runat="server" Text='<%# Eval("empCode") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Employee Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblEmpName0" runat="server" Text='<%# Eval("empName") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Process">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblEmpProcess" runat="server" Text='<%# Eval("processName") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Facility">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblFacility" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField ShowHeader="False">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                                                            Text="Assign"></asp:LinkButton>&nbsp;&nbsp;
                                                                        <asp:LinkButton ID="lbtnAssignBackup" runat="server" CausesValidation="False" CommandArgument='<%# Eval("Id") %>'
                                                                            CommandName="backup">Assign Backup</asp:LinkButton></ItemTemplate>
                                                                    <HeaderTemplate>
                                                                        <table cellpadding="0" cellspacing="0" class="style1">
                                                                            <tr>
                                                                                <td style="text-align: right">
                                                                                    <asp:ImageButton ID="ImageButton3" runat="server" AlternateText="Close" CommandName="close"
                                                                                        ImageUrl="~/images/Exit.jpg" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </HeaderTemplate>
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
                                                    <td colspan="2" align="center">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnAllAssign" runat="server" OnClick="btnAllAssign_Click" Text="All Assign"
                                                                        Visible="False" CssClass="Button" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblAddMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                    </asp:MultiView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
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
                                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" />
                                        </td>
                                        <td class="main_bg">
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
