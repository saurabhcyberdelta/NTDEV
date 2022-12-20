<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="ViewSPOC.aspx.cs" Inherits="ViewSPOC" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="heading">
                View SPOC </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <table width="100%">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td width="33%">
                                                Enter SPOC ID or Name:</td>
                                            <td width="33%">
                                                <asp:TextBox ID="txtEmpIdName" runat="server" ValidationGroup="spoc" 
                                                    MaxLength="20"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                    ControlToValidate="txtEmpIdName" Display="Dynamic" 
                                                    ErrorMessage="Please Enter Name or Id" ValidationGroup="spoc">*</asp:RequiredFieldValidator>
                                            </td>
                                            <td width="33%">
                                                <asp:Button ID="btnSearch" runat="server" onclick="btnSearch_Click" 
                                                    Text="Search" ValidationGroup="spoc" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" >
                                                <asp:Label ID="lblMsg" runat="server" CssClass="error"></asp:Label>
                                                &nbsp;&nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:MultiView ID="MultiView1" runat="server">
                                        <asp:View ID="View1" runat="server">
                                            <asp:GridView ID="gvSPOC" runat="server" AutoGenerateColumns="False" 
                                                CellPadding="4" DataKeyNames="Id" ForeColor="#333333" 
                                                GridLines="None" onpageindexchanging="gvSPOC_PageIndexChanging" 
                                                onselectedindexchanging="gvSPOC_SelectedIndexChanging" AllowPaging="True" 
                                                CssClass="GridView">
                                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                <Columns>
                                                    <asp:CommandField SelectText="View SPOC Details" ShowSelectButton="True" />
                                                    <asp:TemplateField HeaderText="Employee  Code">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblEmpId" runat="server" Text='<%# Eval("empCode") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Employee Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblEmpName" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="ManagerId">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblManagerId" runat="server" Text='<%# Eval("managerId") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Process">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblProcess" runat="server" Text='<%# Eval("processName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Facility">
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                <EditRowStyle BackColor="#999999" />
                                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                            </asp:GridView>
                                        </asp:View>
                                        <asp:View ID="View2" runat="server">
                                            <table class="style1">
                                                <tr>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <table class="style1">
                                                                        <tr>
                                                                            <td style="text-align:"center">
                                                                                <asp:Label ID="lblSpocName" runat="server" style="font-weight: 700"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td class="style2">
                                                                    &nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:GridView ID="gvSPOCDetails" runat="server" AllowPaging="True" 
                                                                        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" 
                                                                        ForeColor="#333333" GridLines="None" 
                                                                        onpageindexchanging="gvSPOCDetails_PageIndexChanging" 
                                                                        onrowcommand="gvSPOCDetails_RowCommand" PageSize="5">
                                                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Employee Code">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblSpocEmpCode" runat="server" Text='<%# Eval("empCode") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Employee Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblSpocEmpName" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Process">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblSpocProcess" runat="server" Text='<%# Eval("processName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Facility">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Actions" ShowHeader="False">
                                                                                <HeaderTemplate>
                                                                                    <table class="style1">
                                                                                        <tr>
                                                                                            <td style="text-align: right">
                                                                                                <asp:ImageButton ID="ImageButton2" runat="server" AlternateText="Close" 
                                                                                                    CausesValidation="False" CommandName="close" ImageUrl="~/images/Exit.jpg" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </HeaderTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                                        <EditRowStyle BackColor="#999999" />
                                                                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                                    </asp:GridView>
                                                                </td>
                                                                <td valign="top">
                                                                    &nbsp;</td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                    </asp:MultiView>
                                </td>
                            </tr>
                            
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" 
                    AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0">
                    <ProgressTemplate>
                        <table align="center">
                            <tr>
                                <td >
                                    <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" /></td>
                                <td class="main_bg">
                                    Loading.....Please Wait!!!</td>
                            </tr>
                        </table>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>
    </table>

</asp:Content>

