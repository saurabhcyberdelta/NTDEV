<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="VendorMaster.aspx.cs" Inherits="VendorMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <table width="100%" align="center">
                <tr>
                    <td>
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="save" />
                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="edit" />
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
                        <table>
                            <tr>
                                <td align="left">
                                    <table>
                                        <tr>
                                            <td align="center">
                                                <asp:MultiView ID="MultiView1" runat="server">
                                                    <asp:View ID="View1" runat="server">
                                                        <table width="100%">
                                                            <tr>
                                                                <td>
                                                                    <asp:GridView ID="grdVendor" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                        CssClass="GridView" DataKeyNames="Id" OnPageIndexChanging="grdVendor_PageIndexChanging"
                                                                        OnRowCancelingEdit="grdVendor_RowCancelingEdit" OnRowDeleting="grdVendor_RowDeleting"
                                                                        OnRowEditing="grdVendor_RowEditing" OnRowUpdating="grdVendor_RowUpdating" BorderWidth="0"
                                                                        ShowFooter="True">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Vendor Name">
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtVendorName" runat="server" Text='<%# Eval("vendorName") %>' MaxLength="30"
                                                                                        CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="rqfvVname" runat="server" ControlToValidate="txtVendorName"
                                                                                        ErrorMessage="Please Enter the Vendor Name" SetFocusOnError="true" ValidationGroup="edit">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegExpAlphanum3" runat="server" ControlToValidate="txtVendorName"
                                                                                        Display="Dynamic" ErrorMessage="Vendor Name Should be Alphanumeric." Text="*"
                                                                                        ValidationExpression="^([\w\-]|\s)*$" ValidationGroup="edit"></asp:RegularExpressionValidator>
                                                                                </EditItemTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVendorName" runat="server" Text='<%# Eval("vendorName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vendor Strength">
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtVendorStrength" runat="server" Text='<%# Eval("vendorStrength") %>'
                                                                                        Width="80px" MaxLength="3" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="rqfvStregth" runat="server" ControlToValidate="txtVendorStrength"
                                                                                        ErrorMessage="Please Enter Vendor Strength" SetFocusOnError="true" ValidationGroup="edit">*</asp:RequiredFieldValidator>
                                                                                    <asp:RangeValidator ID="RangValiStregth" runat="server" ControlToValidate="txtVendorStrength"
                                                                                        ErrorMessage="Please provide vendor strength as a numeric value." MaximumValue="1000"
                                                                                        MinimumValue="0" SetFocusOnError="true" Type="Integer" ValidationGroup="edit">*</asp:RangeValidator>
                                                                                </EditItemTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVendorStrength" runat="server" Text='<%# Eval("vendorStrength") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vendor Contact">
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtVendorContact" runat="server" Text='<%# Eval("vendorContact") %>'
                                                                                        Width="100px" MaxLength="210" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RegularExpressionValidator ID="reqfVContNo" runat="server" ControlToValidate="txtVendorContact"
                                                                                        ErrorMessage="Please Enter valid Phone No." SetFocusOnError="true" ValidationExpression="\d{10}"
                                                                                        ValidationGroup="edit">*</asp:RegularExpressionValidator>
                                                                                </EditItemTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVendorContact" runat="server" Text='<%# Eval("vendorContact") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vendor Info">
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtVendorInfo" runat="server" Text='<%# Eval("vendorInfo") %>' MaxLength="50"
                                                                                        CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RegularExpressionValidator ID="RegExpAlphanum4" runat="server" ControlToValidate="txtVendorInfo"
                                                                                        Display="Dynamic" ErrorMessage="Vendor Info Should be Alphanumeric." Text="*"
                                                                                        ValidationExpression="^([\w\-]|\s)*$" ValidationGroup="edit"></asp:RegularExpressionValidator>
                                                                                </EditItemTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVendorInfo" runat="server" Text='<%# Eval("vendorInfo") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Facility">
                                                                                <EditItemTemplate>
                                                                                    <asp:DropDownList ID="ddlFacility" runat="server" CssClass="DropDownListBox3">
                                                                                    </asp:DropDownList>
                                                                                </EditItemTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFacility" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vendor Type">
                                                                                <EditItemTemplate>
                                                                                    <asp:RadioButton ID="rdbtnRoute" runat="server" Checked='<%# Convert.ToString(Eval("vendorType"))=="Route"?true:false %>'
                                                                                        GroupName="type" Text="Route Basis" />
                                                                                    <asp:RadioButton ID="rdbtnKM" runat="server" Checked='<%# Convert.ToString(Eval("vendorType"))=="KM"?true:false %>'
                                                                                        GroupName="type" Text="KM Basis" />
                                                                                </EditItemTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVendorType" runat="server" Text='<%# Eval("vendorType") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Attrited">
                                                                                <EditItemTemplate>
                                                                                    <asp:CheckBox ID="chkAttritedEdit" runat="server" Checked='<%# Convert.ToInt32(Eval("Attrited"))==1?true:false %>'
                                                                                        Text=" " />
                                                                                </EditItemTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox ID="chkAttrited" runat="server" Checked='<%# Convert.ToInt32(Eval("Attrited"))==1?true:false %>'
                                                                                        Enabled="False" Text=" " />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:CommandField HeaderText="Actions" ShowEditButton="True" ValidationGroup="edit" />
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
                                                                    <asp:LinkButton ID="lbtnAddVendor" runat="server" OnClick="lbtnAddVendor_Click">Add New Vendor</asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:View>
                                                    <asp:View ID="View2" runat="server">
                                                        <asp:DetailsView ID="dvVendor" runat="server" AutoGenerateRows="False" DefaultMode="Insert"
                                                            HeaderText="Add New Vendor" OnItemInserting="dvVendor_ItemInserting" Width="328px"
                                                            OnModeChanging="dvVendor_ModeChanging">
                                                            <Fields>
                                                                <asp:TemplateField HeaderText="Vendor Name :">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvVendorname" runat="server" MaxLength="20" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="rfvVname" runat="server" ControlToValidate="txtdvVendorname"
                                                                            ErrorMessage="Please Enter the Vendor Name" SetFocusOnError="true" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegExpAlphanum" runat="server" ControlToValidate="txtdvVendorname"
                                                                            Display="Dynamic" ErrorMessage="Vendor Name Should be Alphanumeric." Text="*"
                                                                            ValidationExpression="^([\w\-]|\s)*$" ValidationGroup="save"></asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Vendor Strength :">
                                                                    <FooterTemplate>
                                                                        <asp:TextBox ID="txtStregthfooter" runat="server" CssClass="TextBox"></asp:TextBox>
                                                                    </FooterTemplate>
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvVendorStrength" runat="server" MaxLength="3" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="rfvStregth" runat="server" ControlToValidate="txtdvVendorStrength"
                                                                            ErrorMessage="Please Enter Vendor Strength" SetFocusOnError="true" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                                        <asp:RangeValidator ID="RangeValiStregth" runat="server" ControlToValidate="txtdvVendorStrength"
                                                                            ErrorMessage="Please provide vendor strength as a numeric value." MaximumValue="1000"
                                                                            MinimumValue="0" SetFocusOnError="true" Type="Integer" ValidationGroup="save">*</asp:RangeValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Vendor Contact No.:">
                                                                    <FooterTemplate>
                                                                        <asp:TextBox ID="txtVContNoFooter" runat="server" CssClass="TextBox"></asp:TextBox>
                                                                    </FooterTemplate>
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvVendorContact" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RegularExpressionValidator ID="revVContNo" runat="server" ControlToValidate="txtdvVendorContact"
                                                                            ErrorMessage="Please Enter valid Phone No." SetFocusOnError="true" ValidationExpression="\d{10}"
                                                                            ValidationGroup="save">*                          
                                                                        </asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Vendor Information :">
                                                                    <FooterTemplate>
                                                                        <asp:TextBox ID="txtVInfoFooter" runat="server" CssClass="TextBox"></asp:TextBox>
                                                                    </FooterTemplate>
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvVendorInfo" runat="server" MaxLength="50" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RegularExpressionValidator ID="RegExpAlphanum2" runat="server" ControlToValidate="txtdvVendorInfo"
                                                                            Display="Dynamic" ErrorMessage="Vendor Info Should be Alphanumeric." Text="*"
                                                                            ValidationExpression="^([\w\-]|\s)*$" ValidationGroup="save"></asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Facility :">
                                                                    <FooterTemplate>
                                                                        <asp:DropDownList ID="ddFacilityFooter" runat="server" CssClass="DropDownListBox3">
                                                                        </asp:DropDownList>
                                                                    </FooterTemplate>
                                                                    <InsertItemTemplate>
                                                                        <asp:DropDownList ID="ddldvFacility" runat="server" AppendDataBoundItems="true" CssClass="DropDownListBox3">
                                                                            <asp:ListItem Value="0">Select Facility</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddldvFacility"
                                                                            ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="save" ValueToCompare="0">*</asp:CompareValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Vendor Type :">
                                                                    <FooterTemplate>
                                                                        <asp:RadioButton ID="rbVTypeFooter" runat="server" />
                                                                    </FooterTemplate>
                                                                    <InsertItemTemplate>
                                                                        <asp:RadioButton ID="rdbtndvRoute" runat="server" Checked="True" Text="Route Basis"
                                                                            GroupName="type" />
                                                                        <asp:RadioButton ID="rdbtndvKm" runat="server" Text="KM Basis" GroupName="type" />
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:CommandField ShowInsertButton="True" ValidationGroup="save" InsertText="Save"
                                                                    CancelText="Close">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:CommandField>
                                                            </Fields>
                                                            <RowStyle CssClass="DetailsViewRowStyle" />
                                                            <FooterStyle CssClass="DetailsViewFooterStyle" />
                                                            <PagerStyle CssClass="DetailsViewPagerStyle" />
                                                            <HeaderStyle CssClass="DetailsViewHeaderStyle" />
                                                            <AlternatingRowStyle CssClass="DetailsViewAltRowStyle" />
                                                        </asp:DetailsView>
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
                    &nbsp;</tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
