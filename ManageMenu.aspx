<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="ManageMenu.aspx.cs" Inherits="ManageMenu" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table width="100%" align="center">
                <tr>
                    <td align="center">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="submenuedit" />
                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="menuedit" />
                        <asp:ValidationSummary ID="ValidationSummary3" runat="server" ValidationGroup="submenuadd" />
                        <asp:ValidationSummary ID="ValidationSummary4" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="menuadd" />
                        <asp:ValidationSummary ID="ValidationSummary5" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="submenuadd" />
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
                                <span></span>Manage Menu
                            </h1>
                            <h2>
                                Allows User to View/Edit and Add New Menu items and sub menu items.
                            </h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <table align="center" width="90%" border="0px">
                            <tr>
                                <td align="center">
                                    <asp:GridView ID="GVMenu" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CssClass="GridView" DataKeyNames="MenuId" OnPageIndexChanging="GVMenu_PageIndexChanging"
                                        OnRowCancelingEdit="GVMenu_RowCancelingEdit" OnRowEditing="GVMenu_RowEditing"
                                        OnRowUpdating="GVMenu_RowUpdating" OnSelectedIndexChanging="GVMenu_SelectedIndexChanging"
                                        OnRowDeleting="GVMenu_RowDeleting" PageSize="8" Width="450px" BorderWidth="0"
                                        ShowFooter="True">
                                        <Columns>
                                            <asp:CommandField ShowSelectButton="True" SelectText="View Sub-Menu"></asp:CommandField>
                                            <asp:TemplateField HeaderText="Menu Text">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtMenuText" runat="server" Text='<%# Eval("Text") %>' MaxLength="20"
                                                        CssClass="TextBox"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMenuText"
                                                        Display="Dynamic" ErrorMessage="Enter  Menu Text" ValidationGroup="menuedit">*</asp:RequiredFieldValidator>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMenuText" runat="server" Text='<%# Eval("Text") %>' Width="100px"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Menu Description">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtMenuDescription" runat="server" Text='<%# Eval("Description") %>'
                                                        MaxLength="50" CssClass="TextBox"></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMenuDescription" runat="server" Text='<%# Eval("Description") %>'
                                                        Width="100px"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:CommandField HeaderText="Actions" ShowDeleteButton="False" ShowEditButton="True"
                                                ValidationGroup="menuedit" SelectText="View Sub-Menu" />
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
                                <td align="center">
                                    <asp:LinkButton ID="lbtnNewParentMenu" runat="server" OnClick="lbtnNewParentMenu_Click">Add New  Menu Item</asp:LinkButton>
                                </td>
                            </tr>
                            <tr style="background-image: url('images/Grid/row_selected.gif')">
                                <td align="center" class="SelectedRowStyle">
                                    <asp:Label ID="lblMainMenu" runat="server" Visible="False" Style="font-weight: 700;
                                        font-size: 13px"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Label ID="lblMsg" runat="server" CssClass="error"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:MultiView ID="MultiView1" runat="server">
                                        <asp:View ID="View1" runat="server">
                                            <table align="center">
                                                <tr>
                                                    <td align="left">
                                                        <asp:GridView ID="GVSubMenu" runat="server" AllowPaging="True" AllowSorting="True"
                                                            AutoGenerateColumns="False" CssClass="GridView" DataKeyNames="MenuId" OnPageIndexChanging="GVSubMenu_PageIndexChanging"
                                                            OnRowCancelingEdit="GVSubMenu_RowCancelingEdit" OnRowDeleting="GVSubMenu_RowDeleting"
                                                            OnRowEditing="GVSubMenu_RowEditing" OnRowUpdating="GVSubMenu_RowUpdating" PageSize="8"
                                                            BorderWidth="0" ShowFooter="True">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="SubMenu Text">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtSubMenuText" runat="server" Text='<%# Eval("Text") %>' MaxLength="20"
                                                                            CssClass="TextBox"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidat"
                                                                                runat="server" ControlToValidate="txtSubMenuText" Display="Dynamic" ErrorMessage="Enter Sub Menu Text"
                                                                                ValidationGroup="submenuedit">*</asp:RequiredFieldValidator></EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblSubMenuText" runat="server" Text='<%# Eval("Text") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Description">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtSubMenuDescription" runat="server" Text='<%# Eval("Description") %>'
                                                                            MaxLength="50" CssClass="TextBox"></asp:TextBox></EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblSubMneuDescription" runat="server" Text='<%# Eval("Description") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Parent Menu">
                                                                    <EditItemTemplate>
                                                                        <asp:DropDownList ID="ddlParentMenu" runat="server" CssClass="DropDownListBox3">
                                                                        </asp:DropDownList>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblParentMenu" runat="server" Text='<%# Eval("mtext") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Navigate URL">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtNavigateUrl" runat="server" Text='<%# Eval("NavigateUrl") %>'
                                                                            MaxLength="50" CssClass="TextBox"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldVa"
                                                                                runat="server" ControlToValidate="txtNavigateUrl" Display="Dynamic" ErrorMessage="Enter Navigate URL"
                                                                                ValidationGroup="submenuedit">*</asp:RequiredFieldValidator></EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblNavigateUrl" runat="server" Text='<%# Eval("NavigateUrl") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Actions" ShowHeader="False">
                                                                    <EditItemTemplate>
                                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                                                                            Text="Update"></asp:LinkButton>
                                                                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                            Text="Cancel"></asp:LinkButton>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                                                                            Text="Edit"></asp:LinkButton>
                                                                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete"
                                                                            Text="Delete"></asp:LinkButton><cc1:ConfirmButtonExtender ID="ConfirmButton_LinkButton2"
                                                                                TargetControlID="LinkButton2" runat="server" ConfirmOnFormSubmit="False" ConfirmText="Are you sure you want to delete this Sub Menu?">
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
                                                <tr>
                                                    <td>
                                                        <asp:LinkButton ID="lbtnNewSubMenu0" runat="server" OnClick="lbtnNewSubMenu_Click">Add New SubMenu Item</asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                        <asp:View ID="View2" runat="server">
                                            <table align="center">
                                                <tr>
                                                    <td align="center">
                                                        <asp:DetailsView ID="DVSubMenu" runat="server" AutoGenerateRows="False" DefaultMode="Insert"
                                                            HeaderText="Add New SubMenu" OnItemInserting="DVSubMenu_ItemInserting" OnModeChanging="DVSubMenu_ModeChanging"
                                                            Width="200px">
                                                            <Fields>
                                                                <asp:TemplateField HeaderText="SubMenu Text:">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvSubMenuText" runat="server" MaxLength="30" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtdvSubMenuText"
                                                                            Display="Dynamic" ErrorMessage="Enter Sub Menu Text" ValidationGroup="submenuadd"
                                                                            SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Description:">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvSubMenuDescription" runat="server" MaxLength="50" CssClass="TextBox"></asp:TextBox></InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Parent Menu:">
                                                                    <InsertItemTemplate>
                                                                        <asp:DropDownList ID="ddldvParentMenu" runat="server" CssClass="DropDownListBox3">
                                                                        </asp:DropDownList>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Navigate Url:">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvNavigateUrl" runat="server" MaxLength="30" CssClass="TextBox"></asp:TextBox><asp:RequiredFieldValidator
                                                                            ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtdvNavigateUrl"
                                                                            Display="Dynamic" ErrorMessage="Enter Navigate URL" ValidationGroup="submenuadd"
                                                                            SetFocusOnError="True">*</asp:RequiredFieldValidator></InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:CommandField InsertText="Add" ShowInsertButton="True" ValidationGroup="submenuadd" />
                                                            </Fields>
                                                            <RowStyle CssClass="DetailsViewRowStyle" />
                                                            <FooterStyle CssClass="DetailsViewFooterStyle" />
                                                            <PagerStyle CssClass="DetailsViewPagerStyle" />
                                                            <HeaderStyle CssClass="DetailsViewHeaderStyle" />
                                                            <AlternatingRowStyle CssClass="DetailsViewAltRowStyle" />
                                                        </asp:DetailsView>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                        <asp:View ID="View3" runat="server">
                                            <table align="center">
                                                <tr>
                                                    <td align="center">
                                                        <asp:DetailsView ID="DVMenu" runat="server" AutoGenerateRows="False" DefaultMode="Insert"
                                                            HeaderText="Add New Menu" OnItemInserting="DVMenu_ItemInserting" OnModeChanging="DVMenu_ModeChanging">
                                                            <Fields>
                                                                <asp:TemplateField HeaderText="Menu Text:">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvMenuText" runat="server" MaxLength="20" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtdvMenuText"
                                                                            Display="Dynamic" ErrorMessage="Please Enter  Menu Text" ValidationGroup="menuadd"
                                                                            SetFocusOnError="True">*</asp:RequiredFieldValidator></InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Description:">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvMenuDescription" runat="server" MaxLength="50" CssClass="TextBox"></asp:TextBox></InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:CommandField CausesValidation="true" ValidationGroup="menuadd" InsertText="Add"
                                                                    ShowInsertButton="True" />
                                                            </Fields>
                                                            <RowStyle CssClass="DetailsViewRowStyle" />
                                                            <FooterStyle CssClass="DetailsViewFooterStyle" />
                                                            <PagerStyle CssClass="DetailsViewPagerStyle" />
                                                            <HeaderStyle CssClass="DetailsViewHeaderStyle" />
                                                            <AlternatingRowStyle CssClass="DetailsViewAltRowStyle" />
                                                        </asp:DetailsView>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                    </asp:MultiView>
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
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
