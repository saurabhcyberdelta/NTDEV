<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="VendorPenalty.aspx.cs" Inherits="VendorPenalty" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
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
                            <asp:ValidationSummary ID="ValidationSummarygrid" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="gridedit" />
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
                                <span></span>Vendor Penalty Master
                            </h1>
                            <h2>
                                Allows User to View/Edit and Add New Vendor Penalty.
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
                    <td align="center">
                        Select Facility:
                        <asp:DropDownList ID="ddlSelectFacility" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSelectFacility_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table align="center">
                            <tr>
                                <td align="center">
                                    <asp:MultiView ID="mvCost" runat="server" ActiveViewIndex="0">
                                        <table align="center" style="height: 473px">
                                            <tr>
                                                <td>
                                                    <asp:View ID="View1" runat="server">
                                                        <table align="center">
                                                            <tr>
                                                                <td align="center">
                                                                    &nbsp;<asp:GridView ID="gvCost" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                        CssClass="GridView" ShowFooter="True" DataKeyNames="id" OnRowDeleting="gvCost_RowDeleting" EnableModelValidation="True">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Vendor">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVendor" runat="server" Text='<%# Eval("vendorName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Month">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVehicle" runat="server" Text='<%# Eval("Month") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Penalty Amount">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFuelRate" runat="server" Text='<%# Eval("PenaltyAmt") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <%--<EditItemTemplate>
                                                                                    <asp:TextBox ID="txtPenaltyAmt"  runat="server" Text='<%# Eval("PenaltyAmt") %>' Width="50" MaxLength="8"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldlblFuelRate" runat="server" ControlToValidate="txtPenaltyAmt"
                                                                                        Display="Dynamic" ErrorMessage="Enter Penalty Amt." ValidationGroup="gridedit" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="regexFuelRate" runat="server" ControlToValidate="txtPenaltyAmt"
                                                                                        ValidationGroup="gridedit" ErrorMessage="Enter a valid Penalty Amt" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,2}" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                </EditItemTemplate>--%>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="UpdatedBy">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblUpdatedBy" runat="server" Text='<%# Eval("UpdatedBy") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            
                                                                            <asp:CommandField ButtonType="Link" ShowDeleteButton="True"   />
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
                                                                    <asp:LinkButton ID="lbtnAddNew" runat="server" Visible="false" CausesValidation="False" OnClick="lbtnAddNew_Click">Change Rate</asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center">
                                                                    <asp:LinkButton ID="lbtnAdd" runat="server" CausesValidation="False" OnClick="lbtnAdd_Click">Add New Vendor Penalty</asp:LinkButton>
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
                                                                    <asp:DetailsView ID="dvCost" runat="server" AutoGenerateRows="False" DataKeyNames="Id"
                                                                        DefaultMode="Insert" HeaderText="Change Rate" Width="100%" OnItemInserting="dvCost_ItemInserting"
                                                                        OnModeChanging="dvCost_ModeChanging">
                                                                        <Fields>
                                                                            <asp:TemplateField HeaderText="Month">
                                                                                <InsertItemTemplate>
                                                                                    <asp:DropDownList ID="ddlMonth" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                                        <asp:ListItem Value="1">January</asp:ListItem>
                                                                                        <asp:ListItem Value="2">February</asp:ListItem>
                                                                                        <asp:ListItem Value="3">March</asp:ListItem>
                                                                                        <asp:ListItem Value="4">April</asp:ListItem>
                                                                                        <asp:ListItem Value="5">May</asp:ListItem>
                                                                                        <asp:ListItem Value="6">June</asp:ListItem>
                                                                                        <asp:ListItem Value="7">July</asp:ListItem>
                                                                                        <asp:ListItem Value="8">August</asp:ListItem>
                                                                                        <asp:ListItem Value="9">September</asp:ListItem>
                                                                                        <asp:ListItem Value="10">October</asp:ListItem>
                                                                                        <asp:ListItem Value="11">November</asp:ListItem>
                                                                                        <asp:ListItem Value="12">December</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vendor">
                                                                                <InsertItemTemplate>
                                                                                    <asp:DropDownList ID="ddlVendor1" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                                    </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidatesd" runat="server" ControlToValidate="ddlVendor1"
                                                                                        Display="Dynamic" ErrorMessage="Select Vendor" Operator="NotEqual" ValidationGroup="add"
                                                                                        ValueToCompare="0">*</asp:CompareValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                   
                                                                            <asp:TemplateField HeaderText="Penalty Amount">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtPenalty" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoY" runat="server" ControlToValidate="txtPenalty"
                                                                                        Display="Dynamic" ErrorMessage="Enter New Penalty" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtPenalty"
                                                                                        ValidationGroup="add" ErrorMessage="Enter a valid New Penalty" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
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
                                                    <asp:View ID="View3" runat="server">
                                                        <table width="100%" border="0">
                                                            <tr>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center">
                                                                    <asp:DetailsView ID="dvAddnewvendor" runat="server" AutoGenerateRows="False" DataKeyNames="Id"
                                                                        DefaultMode="Insert" HeaderText="Add New Penalty" Width="100%" OnItemInserting="dvAddnewvendor_ItemInserting"
                                                                        OnModeChanging="dvAddnewvendor_ModeChanging" EnableModelValidation="True">
                                                                        <Fields>
                                                                            <asp:TemplateField HeaderText="Month">
                                                                                <InsertItemTemplate>
                                                                                    <asp:DropDownList ID="ddlMonth" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                                        <asp:ListItem Value="01">January</asp:ListItem>
                                                                                        <asp:ListItem Value="02">February</asp:ListItem>
                                                                                        <asp:ListItem Value="03">March</asp:ListItem>
                                                                                        <asp:ListItem Value="04">April</asp:ListItem>
                                                                                        <asp:ListItem Value="05">May</asp:ListItem>
                                                                                        <asp:ListItem Value="06">June</asp:ListItem>
                                                                                        <asp:ListItem Value="07">July</asp:ListItem>
                                                                                        <asp:ListItem Value="08">August</asp:ListItem>
                                                                                        <asp:ListItem Value="09">September</asp:ListItem>
                                                                                        <asp:ListItem Value="10">October</asp:ListItem>
                                                                                        <asp:ListItem Value="11">November</asp:ListItem>
                                                                                        <asp:ListItem Value="12">December</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vendor">
                                                                                <InsertItemTemplate>
                                                                                    <asp:DropDownList ID="ddlVendorp" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                                        <asp:ListItem Value="0">Select Vendor</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidatesd" runat="server" ControlToValidate="ddlVendorp"
                                                                                        Display="Dynamic" ErrorMessage="Select Vendor" Operator="NotEqual" ValidationGroup="add"
                                                                                        ValueToCompare="0">*</asp:CompareValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                   
                                                                            <asp:TemplateField HeaderText="Penalty Amount">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtPenalty" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoY" runat="server" ControlToValidate="txtPenalty"
                                                                                        Display="Dynamic" ErrorMessage="Enter New Penalty" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtPenalty"
                                                                                        ValidationGroup="add" ErrorMessage="Enter a valid New Penalty" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:CommandField ShowEditButton="True" />
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
