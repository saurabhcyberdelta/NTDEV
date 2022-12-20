<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="EmpAccessRights.aspx.cs" Inherits="EmpAccessRights" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="StyleSheets/TMS.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/GridView.css" rel="stylesheet" type="text/css" />
   <%-- <link href="StyleSheets/DataList.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/DetailsView.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/Window.css" rel="stylesheet" type="text/css" />--%>
    <link href="StyleSheets/TMSSEC.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/SoftGreyGridView.css" rel="stylesheet" type="text/css" />
   <%-- <link href="StyleSheets/Text-gradient.css" rel="stylesheet" type="text/css" />--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" width="100%">
        <tr>
            <td align="left">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <table align="center" border="0" width="80%">
                            <tr>
                                <td align="center">
                                    <asp:Label ID="lblErrorMsg" runat="server" CssClass="error"></asp:Label>
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                        ShowSummary="False" ValidationGroup="search" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="heading">
                                    Manage User Access Rights
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                           <tr>
                                <td align="center">
                                    <asp:DataList ID="DataListMenuAccessCount" runat="server" RepeatDirection="Horizontal"
                                        Width="90%" CellPadding="4">
                                     <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                                    <AlternatingItemStyle BackColor="#DCDCDC" />
                                    <ItemStyle BackColor="#EEEEEE" ForeColor="Black" />
                                    <SelectedItemStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="White" />
                                   
                                        <HeaderTemplate>
                                            Total Assigned Module to Users
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblMenu" runat="server" Text='<%# Eval("Menu") %>' />
                                            <br />
                                            <hr />
                                            <asp:LinkButton ID="lbTotalEmployee" runat="server" Text='<%# Eval("TotalEmployee") %>'
                                                CommandArgument='<%# Eval("ParentID") + ";" + Eval("Menu") %>' CssClass="linkButton"
                                                OnClick="lbTotalEmployee_Click"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Label ID="lblMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch">
                                        <table align="left" width="80%" border="0">
                                            <tr>
                                                <td width="50%" align="center">
                                                    Enter Employee ID or Name:
                                                </td>
                                                <td width="30%" align="left">
                                                    <asp:TextBox ID="txtEmpIdName" runat="server" CssClass="TextBox1"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmpIdName"
                                                        Display="Dynamic" ErrorMessage="Please Enter Name or Id" ValidationGroup="search">*</asp:RequiredFieldValidator>
                                                </td>
                                                <td width="20%">
                                                    <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search"
                                                        ValidationGroup="search" CssClass="Button" />
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
                                            <table width="100%" align="center" border="0">
                                                <tr>
                                                    <td align="left">
                                                        <asp:GridView ID="GvEmployee" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                            DataKeyNames="Id" OnPageIndexChanging="GvEmployee_PageIndexChanging" OnSelectedIndexChanging="GvEmployee_SelectedIndexChanging"
                                                            CssClass="GridView" Width="100%">
                                                            <Columns>
                                                                <asp:CommandField SelectText="Edit" ShowSelectButton="True" />
                                                                <asp:TemplateField HeaderText="Employee Id">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblEmpId" runat="server" Text='<%# Eval("empCode") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Employee Name">
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
                                                <tr>
                                                    <td align="center">
                                                        &nbsp;
                                                        <asp:Label ID="lblSaveMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                        <asp:View ID="View2" runat="server">
                                            <table width="70%" align="center">
                                                <tr>
                                                    <td align="center">
                                                        <asp:GridView ID="gvMenu" runat="server" AutoGenerateColumns="False" DataKeyNames="MenuId"
                                                            GridLines="None" OnRowCommand="gvMenu_RowCommand" Width="60%" CssClass="GridView">
                                                            <Columns>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <table width="100%" cellspacing="0" cellpadding="0">
                                                                            <tr valign="middle">
                                                                                <td style="text-align: left" valign="middle" width="10%">
                                                                                    <asp:ImageButton ID="imgbtnExpand" runat="server" CausesValidation="False" CommandName="expand"
                                                                                        ImageUrl="~/images/plus.gif" />
                                                                                    <asp:ImageButton ID="imgbtnClose" runat="server" CausesValidation="False" CommandName="close"
                                                                                        ImageUrl="~/images/minus.gif" Visible="False" />
                                                                                </td>
                                                                                <td style="text-align: left" valign="middle" width="20%">
                                                                                    <asp:CheckBox ID="chkMenu" runat="server" AutoPostBack="True"  OnCheckedChanged="chkMenu_CheckedChanged" />
                                                                                </td>
                                                                                <td style="text-align: center; vertical-align: middle" width="70%" valign="middle">
                                                                                    <asp:Label ID="lblMenu" runat="server" Style="font-weight: 700" Text='<%# Eval("Text") %>'></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="text-align: left" valign="top" width="10%">
                                                                                    &nbsp;
                                                                                </td>
                                                                                <td style="text-align: left" valign="top" width="20%">
                                                                                    &nbsp;
                                                                                </td>
                                                                                <td style="text-align: left; vertical-align: middle" width="70%">
                                                                                    <asp:GridView ID="gvSubMenu" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                                                        DataKeyNames="MenuId" ForeColor="#333333" GridLines="None" ShowHeader="False"
                                                                                        Width="100%" CssClass="GridView">
                                                                                        <Columns>
                                                                                            <asp:TemplateField>
                                                                                                <ItemTemplate>
                                                                                                    <asp:CheckBox ID="chkSubMenu" Checked='<%# (Eval("checked").ToString()== "1" ?true:false) %>' runat="server" />
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField>
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="lblSubMenu" runat="server" Text='<%# Eval("Text") %>'></asp:Label>
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
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                            <HeaderStyle CssClass="HeaderStyle" />
                                                            <EditRowStyle BackColor="#999999" />
                                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <asp:LinkButton ID="lbtnUpdate" runat="server" OnClick="lbtnUpdate_Click" ValidationGroup="update">Save</asp:LinkButton>
                                                        &nbsp;&nbsp;
                                                        <asp:LinkButton ID="lbtnCancel" runat="server" CausesValidation="False" OnClick="lbtnCancel_Click">Close</asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                        <asp:View ID="view3" runat="server">
                                           <tr>
            <td>
                <asp:Button ID="Button1" runat="server"  Style="visibility: hidden" />
                 <cc1:ModalPopupExtender ID="ModalPopupExtender108" runat="server"   BackgroundCssClass="modalBackground"
                    TargetControlID="Button1" PopupControlID="pnlModal" CancelControlID="ibtnSMclose" DropShadow="True">
                </cc1:ModalPopupExtender>
                <asp:Panel ID="pnlModal" runat="server">
                    <table cellpadding="0" cellspacing="0" width="70%" align="center">
                        <tr bgcolor="#336699">
                            <td  width="100%" style="color: #FFFFFF">
                                <b>List of Users who have
                                    <asp:Label ID="lblShowMenuItem" runat="server" ForeColor="White"></asp:Label>
                                    Menu Access. </b>
                            </td>
                            <td >
                                <asp:ImageButton ID="ibtnSMclose" runat="server" ImageUrl="~/images/Exit.jpg" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:GridView ID="grdMenuUsersDetails" runat="server" AutoGenerateColumns="False"
                                    DataKeyNames="Id" AllowPaging="True" PageSize="15"  Width="100%"
                                    OnPageIndexChanging="grdMenuUsersDetails_PageIndexChanging" BorderWidth="0px"
                                    ShowFooter="True">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Employee Id">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEmpId" runat="server" Text='<%# Eval("empCode") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Employee Name">
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
                                    </Columns>
                               <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                            <HeaderStyle CssClass="HeaderStyle" />
                                                            <EditRowStyle BackColor="#999999" />
                                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                 
            </td>
        </tr>
                                        </asp:View>
                                    </asp:MultiView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                            </tr>
                        </table>
                 
            </td>
        </tr>
       
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
      
     
           </ContentTemplate>
                </asp:UpdatePanel>
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
</asp:Content>
