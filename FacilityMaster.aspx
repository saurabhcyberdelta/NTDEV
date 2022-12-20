<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="FacilityMaster.aspx.cs" Inherits="FacilityMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table align="center" width="100%">
                <tr>
                    <td align="center">
                        <asp:ValidationSummary ID="ValidationSummaryEdit" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="edit" />
                        <asp:ValidationSummary ID="ValidationSummaryadd" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="add" />
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
                                <span></span>Facility Master
                            </h1>
                            <h2>
                                Allows User to View/Edit and Add New Facility.
                            </h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        &nbsp;
                        <asp:Label ID="lblMsg" runat="server" CssClass="message" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table align="center">
                            <tr>
                                <td align="center">
                                    <asp:MultiView ID="mvFacility" runat="server" ActiveViewIndex="0">
                                        <table align="center">
                                            <tr>
                                                <td>
                                                    <asp:View ID="View1" runat="server">
                                                        <table align="center">
                                                            <tr>
                                                                <td align="center">
                                                                    &nbsp;<asp:GridView ID="gvFacility" runat="server" AllowPaging="True" AllowSorting="True"
                                                                        AutoGenerateColumns="False" CssClass="GridView" OnPageIndexChanging="gvFacility_PageIndexChanging"
                                                                        DataKeyNames="Id" OnRowCancelingEdit="gvFacility_RowCancelingEdit" OnRowEditing="gvFacility_RowEditing"
                                                                        OnRowUpdating="gvFacility_RowUpdating" BorderWidth="0" ShowFooter="True">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Facility Name">
                                                                                <AlternatingItemTemplate>
                                                                                    <asp:Label ID="lblFacilityName" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                                                </AlternatingItemTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFacilityName" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Facility">
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtFacility" runat="server" Text='<%# Eval("facility") %>' MaxLength="20"
                                                                                        CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFacility"
                                                                                        Display="Dynamic" ErrorMessage="Enter Facility" ValidationGroup="edit">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegExpAlphanum0" runat="server" ControlToValidate="txtFacility"
                                                                                        Display="Dynamic" ErrorMessage="Facility Should be Alphanumeric." Text="*" ValidationExpression="^([\w\-.,]|\s)*$"
                                                                                        ValidationGroup="edit"></asp:RegularExpressionValidator>
                                                                                </EditItemTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFacility" runat="server" Text='<%# Eval("facility") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Geo-X">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblGeoX" runat="server" Text='<%# Eval("geoX") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtGeoX" runat="server" Text='<%# Eval("geoX") %>' MaxLength="10"
                                                                                        CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoX" runat="server" ControlToValidate="txtGeoX"
                                                                                        Display="Dynamic" ErrorMessage="Enter Geo X Value" ValidationGroup="edit">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtGeoX"
                                                                                        ValidationGroup="edit" ErrorMessage="Enter a valid Geo X Value" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}">*</asp:RegularExpressionValidator>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Geo-Y">
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtGeoY" runat="server" Text='<%# Eval("geoY") %>' MaxLength="10"
                                                                                        CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoY" runat="server" ControlToValidate="txtGeoY"
                                                                                        Display="Dynamic" ErrorMessage="Enter Geo Y value" ValidationGroup="edit">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtGeoY"
                                                                                        ValidationGroup="edit" ErrorMessage="Enter a valid Geo Y Value" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}">*</asp:RegularExpressionValidator>
                                                                                </EditItemTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblGeoY" runat="server" Text='<%# Eval("geoY") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Helpdesk Contact No">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblContactNo" runat="server" Text='<%# Eval("tptContactNo") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtContactNo" runat="server" Text='<%# Eval("tptContactNo") %>'
                                                                                        MaxLength="25" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RegularExpressionValidator ID="RegExpAlphanum1" runat="server" ControlToValidate="txtContactNo"
                                                                                        Display="Dynamic" ErrorMessage="Contact Number Should be Numeric." Text="*" ValidationExpression="^[0-9\s\-]+$"
                                                                                        ValidationGroup="edit"></asp:RegularExpressionValidator>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Helpdesk Email">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("tptEmail") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtEmail" runat="server" Text='<%# Eval("tptEmail") %>' MaxLength="30"
                                                                                        CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RegularExpressionValidator ID="reghExEmail" runat="server" ControlToValidate="txtEmail"
                                                                                        Display="Dynamic" ErrorMessage="Enter Valid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                                                        ValidationGroup="edit">*</asp:RegularExpressionValidator>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Location">
                                                                                <EditItemTemplate>
                                                                                    <asp:DropDownList ID="ddlLocation" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                                    </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Select Location"
                                                                                        ControlToValidate="ddlLocation" Display="Dynamic" SetFocusOnError="True" Text="*"
                                                                                        ValueToCompare="0" Operator="NotEqual" ValidationGroup="edit"></asp:CompareValidator>
                                                                                </EditItemTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("locationName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Active">
                                                                                <EditItemTemplate>
                                                                                    <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Convert.ToBoolean(Eval("Active")) %>' />
                                                                                </EditItemTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Convert.ToBoolean(Eval("Active")) %>'
                                                                                        Enabled="false" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:CommandField ShowEditButton="True" ValidationGroup="edit" />
                                                                        </Columns>
                                                                        <RowStyle CssClass="RowStyle" />
                                                                        <FooterStyle CssClass="FooterStyle" />
                                                                        <PagerStyle CssClass="PagerStyle" />
                                                                        <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                                        <HeaderStyle CssClass="HeaderStyle" />
                                                                        <EditRowStyle BackColor="#999999" />
                                                                        <AlternatingRowStyle CssClass="AltRowStyle" />
                                                                    </asp:GridView>
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center">
                                                                    <asp:LinkButton ID="lbtnAddNew" runat="server" CausesValidation="False" OnClick="lbtnAddNew_Click">Add New</asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:View>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:View ID="View2" runat="server">
                                                        <table width="100%" border="0">
                                                            <tr>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center">
                                                                    <asp:DetailsView ID="dvFacility" runat="server" AutoGenerateRows="False" DataKeyNames="Id"
                                                                        DefaultMode="Insert" HeaderText="Add New Facility" OnItemInserting="dvFacility_ItemInserting"
                                                                        OnModeChanging="dvFacility_ModeChanging" Width="100%">
                                                                        <Fields>
                                                                            <asp:TemplateField HeaderText="Facility Name:">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtdvFacilityName" runat="server" MaxLength="50" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldFacName" runat="server" ControlToValidate="txtdvFacilityName"
                                                                                        Display="Dynamic" ErrorMessage="Enter Facility Name" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegExpAlphanum2" runat="server" ControlToValidate="txtdvFacilityName"
                                                                                        Display="Dynamic" ErrorMessage="Facility Should be Alphanumeric." Text="*" ValidationExpression="^([\w\-.,]|\s)*$"
                                                                                        ValidationGroup="add"></asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Geo-X:">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtdvGeoX" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoX" runat="server" ControlToValidate="txtdvGeoX"
                                                                                        Display="Dynamic" ErrorMessage="Enter Geo X Value" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtdvGeoX"
                                                                                        ValidationGroup="add" ErrorMessage="Enter a valid Geo X Value" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Geo-Y:">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtdvGeoY" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoY" runat="server" ControlToValidate="txtdvGeoY"
                                                                                        Display="Dynamic" ErrorMessage="Enter Geo Y value" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtdvGeoY"
                                                                                        ValidationGroup="add" ErrorMessage="Enter a valid Geo Y Value" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Contact No:">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtdvContactNo" runat="server" MaxLength="25" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RegularExpressionValidator ID="RegExpAlphanum3" runat="server" ControlToValidate="txtdvContactNo"
                                                                                        Display="Dynamic" ErrorMessage="Contact Number Should be Numeric." Text="*" ValidationExpression="^[0-9\s\-]+$"
                                                                                        ValidationGroup="add"></asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Email:">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtdvEmail" runat="server" MaxLength="30" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RegularExpressionValidator ID="reghExEmail" runat="server" ControlToValidate="txtdvEmail"
                                                                                        Display="Dynamic" ErrorMessage="Enter Valid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                                                        ValidationGroup="add" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Location:">
                                                                                <InsertItemTemplate>
                                                                                    <asp:DropDownList ID="ddldvLocation" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                                    </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddldvLocation"
                                                                                        Display="Dynamic" ErrorMessage="Please Select Location" Operator="NotEqual" ValidationGroup="add"
                                                                                        ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                                                </InsertItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:CommandField ShowEditButton="True" ValidationGroup="add" />
                                                                            <asp:CommandField ShowInsertButton="True" ValidationGroup="add" />
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
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:MultiView>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                                        DisplayAfter="0">
                                        <ProgressTemplate>
                                            <table class="style6">
                                                <tr>
                                                    <td class="style7">
                                                        <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" />
                                                    </td>
                                                    <td>
                                                        Please Wait!!!
                                                    </td>
                                                </tr>
                                            </table>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
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
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
