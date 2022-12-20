<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="LocationMaster.aspx.cs" Inherits="LocationMaster" %>

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
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="loc" />
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="heading">
                        <div class="gradient2">
                            <h1>
                                <span></span>Manage Location
                            </h1>
                            <h2>
                                Allows to View/Edit and Add New Location.
                            </h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <table align="center" width="50%">
                            <tr>
                                <td align="center">
                                    <asp:Label ID="lblMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:MultiView ID="MultiView1" runat="server">
                                        <asp:View ID="View1" runat="server">
                                            <table width="100%" align="center">
                                                <tr>
                                                    <td align="center" width="100%">
                                                        <asp:GridView ID="GVLocation" runat="server" AutoGenerateColumns="False" CssClass="GridView"
                                                            DataKeyNames="Id" OnPageIndexChanging="GVLocation_PageIndexChanging" OnRowCancelingEdit="GVLocation_RowCancelingEdit"
                                                            OnRowDeleting="GVLocation_RowDeleting" OnRowEditing="GVLocation_RowEditing" OnRowUpdating="GVLocation_RowUpdating"
                                                            BorderWidth="0px" ShowFooter="True" Width="100%">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Location Name">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtLocationName" runat="server" Text='<%# Eval("locationName") %>'
                                                                            CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldVal" runat="server" ControlToValidate="txtLocationName"
                                                                            Display="Dynamic" ErrorMessage="Enter Location Name" ValidationGroup="loc">*</asp:RequiredFieldValidator>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblLocationName" runat="server" Text='<%# Eval("locationName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:CommandField ShowDeleteButton="False" ShowEditButton="True" ValidationGroup="loc" />
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
                                                        <asp:LinkButton ID="lbtnAddNew" runat="server" OnClick="lbtnAddNew_Click">Add New</asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                        <asp:View ID="View2" runat="server">
                                            <table align="center">
                                                <tr>
                                                    <td align="center">
                                                        <asp:DetailsView ID="DvLocation" runat="server" AutoGenerateRows="False" DefaultMode="Insert"
                                                            HeaderText="Add New Location" Height="50px" OnItemInserting="DvLocation_ItemInserting"
                                                            OnModeChanging="DvLocation_ModeChanging">
                                                            <Fields>
                                                                <asp:TemplateField HeaderText="Location Name:">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvLocationName" runat="server" MaxLength="30" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtdvLocationName"
                                                                            Display="Dynamic" ErrorMessage="Enter Location Name" ValidationGroup="loc">*</asp:RequiredFieldValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:CommandField ShowInsertButton="True" InsertText="Save" CancelText="Close" ValidationGroup="loc" />
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
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
