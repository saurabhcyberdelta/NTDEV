<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="VendorAttritation.aspx.cs" Inherits="VendorAttritation" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <table width="100%" align="center">
                <tr>
                    <td>
                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="save" />
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="add" />
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="style7">
                        <asp:UpdateProgress ID="UpdateProgress2" runat="server" 
                            AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0">
                            <ProgressTemplate>
                                <table align="center">
                                    <tr>
                                        <td align="center" class="style7">
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
                    <td align="center">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        </asp:UpdateProgress>
                    </td>
                </tr>
                <tr>
                    <td class="heading">
                        <div class="gradient2">
                            <h1>
                                <span></span>Manage Vendor Details
                            </h1>
                            <h2>
                                Allows to View/Edit and Add New Vendor.
                            </h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="lblMsg" runat="server" CssClass="error"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <table class="table" width="60%">
                            <tr>
                                <td align="center" class="row1">
                                    <b>Facility</b>
                                </td>
                                <td align="center" class="row1">
                                    Attrited</td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:DropDownList ID="ddlSelectFacility" runat="server" AutoPostBack="True" 
                                        onselectedindexchanged="ddlSelectFacility_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td align="center">
                                    <asp:CheckBox ID="chkAtt" runat="server" AutoPostBack="true"
                                        oncheckedchanged="chkAtt_CheckedChanged" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <table>
                            <tr>
                                <td align="left">
                                    <table>
                                        <tr>
                                            <td align="center">
                                                <asp:GridView ID="grdVendor" runat="server" AllowPaging="True" 
                                                    AutoGenerateColumns="False" BorderWidth="0px" CssClass="GridView" 
                                                    DataKeyNames="Id" OnPageIndexChanging="grdVendor_PageIndexChanging" 
                                                    ShowFooter="True" Width="794px">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Attrited">                                                           
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkAttrited" runat="server" Text=" " />
                                                                <asp:Label ID="lblId" runat="server" Text='<%# Eval("Id") %>' Visible="false"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Vendor Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblVendorName" runat="server" Text='<%# Eval("vendorName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Vendor Strength">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblVendorStrength" runat="server" 
                                                                    Text='<%# Eval("vendorStrength") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Vendor Contact">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblVendorContact" runat="server" 
                                                                    Text='<%# Eval("vendorContact") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Vendor Info">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblVendorInfo" runat="server" Text='<%# Eval("vendorInfo") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Facility">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblFacility" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Vendor Type">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblVendorType" runat="server" Text='<%# Eval("vendorType") %>'></asp:Label>
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
                                           <td align="center">
                                                                                         
                                                <asp:Button ID="btnOk" runat="server" Text="OK" CssClass="Button" 
                                                    ValidationGroup="save" onclick="btnOk_Click"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" style="width: 99%; height: 13px;">
                                                <asp:Button ID="Button1" runat="server" Style="visibility: hidden" />
                                                <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" 
                                                    BackgroundCssClass="modalBackground" CancelControlID="btnCancelDetails" 
                                                    Enabled="True" PopupControlID="Panel1" TargetControlID="Button1">
                                                </cc1:ModalPopupExtender>
                                                <asp:Panel ID="Panel1" runat="server">
                                                    <table bgcolor="#FFFFCC" style="border: 1px ridge #000000" width="500px">
                                                        <tr>
                                                            <td align="right" style="width:30%">
                                                                Description :</td>
                                                            <td align="left" style="width:30%">
                                                                <asp:TextBox ID="txtDescp" runat="server" CssClass="TextBox" Height="25px" 
                                                                    TextMode="MultiLine" Width="300px" ValidationGroup="add"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDescp"
                                                                    ErrorMessage="Please Enter Description" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center" colspan="2">
                                                                <asp:Button ID="ButtonSave" runat="server" CssClass="Button" 
                                                                    onclick="ButtonSave_Click" Text="Save" Width="60px" ValidationGroup="add"/>
                                                                <asp:Button ID="btnCancelDetails" runat="server" CssClass="Button" 
                                                                    Text="Cancel" Width="60px" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" style="width:30%">
                                                                &nbsp;</td>
                                                            <td align="left" style="width:70%">
                                                                &nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                                &nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <tr>
                <td>
                    <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server" 
                        AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0">
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
                    </asp:UpdateProgress>--%>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

