<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="AdhocCabDetails.aspx.cs" Inherits="AdhocCabDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
                                <span></span>Adhoc Cab Allocation
                            </h1>
                            <h2>
                                Allows User to View/Edit and Add New Adhoc Cab.
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
                                                                    &nbsp;<asp:GridView ID="gvAdhoc" runat="server" AllowPaging="True" AllowSorting="True"
                                                                        AutoGenerateColumns="False" CssClass="GridView" OnPageIndexChanging="gvAdhoc_PageIndexChanging"
                                                                        DataKeyNames="Id" OnRowCancelingEdit="gvAdhoc_RowCancelingEdit" OnRowEditing="gvAdhoc_RowEditing"
                                                                        OnRowUpdating="gvAdhoc_RowUpdating" BorderWidth="0px" ShowFooter="True" 
                                                                        onselectedindexchanging="gvAdhoc_SelectedIndexChanging">
                                                                        <Columns>
                                                                            <asp:CommandField ShowSelectButton="True" />
                                                                            <asp:TemplateField HeaderText="Adhoc CabId">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblAdhocCabId1" runat="server" Text='<%# Eval("AdhocCabId") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Facility Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFacilityName" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vendor Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVendor" runat="server" Text='<%# Eval("vendorName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="CabId">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblCabId" runat="server" Text='<%# Eval("CabId") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vehicle No.">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVehicle" runat="server" Text='<%# Eval("VehicleNo") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="No. Of Person">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblPerson" runat="server" Text='<%# Eval("NoPerson") %>'></asp:Label>
                                                                                </ItemTemplate>                                                                                
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Billing Type">                                                                                
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblBilling" runat="server" Text='<%# Eval("BillingType") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Cost">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblCost" runat="server" Text='<%# Eval("Cost") %>'></asp:Label>
                                                                                </ItemTemplate>                                                                                
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Total KM">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblTotalKM" runat="server" Text='<%# Eval("TotalKM") %>'></asp:Label>
                                                                                </ItemTemplate>                                                                                
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Week Type">                                                                                
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblWeekType" runat="server" Text='<%# Eval("WeekType") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Attachment">                                                                                
                                                                                <ItemTemplate>
                                                                                    <asp:HyperLink ID="hpAttachment" runat="server" Text='<%# Eval("AttachmentName") %>'
                                                                                        NavigateUrl='<%# bind("Attachment") %>'></asp:HyperLink>                                                                                    
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:CommandField ShowEditButton="True" ValidationGroup="edit" 
                                                                                Visible="False" />
                                                                        </Columns>
                                                                        <RowStyle CssClass="RowStyle" />
                                                                        <FooterStyle CssClass="FooterStyle" />
                                                                        <PagerStyle CssClass="PagerStyle" />
                                                                        <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                                        <HeaderStyle CssClass="HeaderStyle1" />
                                                                        <EditRowStyle BackColor="#999999" />
                                                                        <AlternatingRowStyle CssClass="AltRowStyle" />
                                                                    </asp:GridView>
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center">
                                                                    <asp:LinkButton ID="lbtnAddNew" runat="server" CausesValidation="False" OnClick="lbtnAddNew_Click" CssClass="linkButton">Add New</asp:LinkButton>
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
                                                                    <asp:DetailsView ID="dvAdhoc" runat="server" AutoGenerateRows="False" DataKeyNames="Id"
                                                                        DefaultMode="Insert" HeaderText="Add New Adhoc Cab" OnItemInserting="dvAdhoc_ItemInserting"
                                                                        OnModeChanging="dvAdhoc_ModeChanging" Width="100%">
                                                                        <Fields>
                                                                            <asp:TemplateField HeaderText="Facility Name :">
                                                                                <InsertItemTemplate>
                                                                                    <asp:DropDownList ID="ddldvFacility" runat="server" AppendDataBoundItems="True" 
                                                                                        CssClass="DropDownListBox3" AutoPostBack="True" 
                                                                                        onselectedindexchanged="ddldvFacility_SelectedIndexChanged">
                                                                                    </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddldvFacility"
                                                                                        Display="Dynamic" ErrorMessage="Please Select Facility" Operator="NotEqual" ValidationGroup="add"
                                                                                        ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vendor Name :">
                                                                                <InsertItemTemplate>
                                                                                    <asp:DropDownList ID="ddldvVendor" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                                    </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddldvVendor"
                                                                                        Display="Dynamic" ErrorMessage="Please Select Facility" Operator="NotEqual" ValidationGroup="add"
                                                                                        ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="CabId :">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtdvCabId" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoY" runat="server" ControlToValidate="txtdvCabId"
                                                                                        Display="Dynamic" ErrorMessage="Enter Cab Id" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegExpAlphanum3" runat="server" ControlToValidate="txtdvCabId"
                                                                                        Display="Dynamic" ErrorMessage="Cab Id Should be Numeric." Text="*" ValidationExpression="^[0-9\s\-]+$"
                                                                                        ValidationGroup="add"></asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vehicle No. :">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtdvVehicleNo" runat="server" MaxLength="25" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldVehicleNo" runat="server" ControlToValidate="txtdvVehicleNo"
                                                                                        Display="Dynamic" ErrorMessage="Enter Vehicle No." ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="No. Of Person :">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtdvPerson" runat="server" MaxLength="30" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldPerson" runat="server" ControlToValidate="txtdvPerson"
                                                                                        Display="Dynamic" ErrorMessage="Enter Person No." ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegExpPerson" runat="server" ControlToValidate="txtdvPerson"
                                                                                        Display="Dynamic" ErrorMessage="Person No. Should be Numeric." Text="*" ValidationExpression="^[0-9\s\-]+$"
                                                                                        ValidationGroup="add"></asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Billling Type :">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtdvBilling" runat="server" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldBilling" runat="server" ControlToValidate="txtdvBilling"
                                                                                        Display="Dynamic" ErrorMessage="Enter Billling Type" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                </InsertItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Cost :">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtdvCost" runat="server" MaxLength="30" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldCost" runat="server" ControlToValidate="txtdvCost"
                                                                                        Display="Dynamic" ErrorMessage="Enter Cost" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegExpCost" runat="server" ControlToValidate="txtdvCost"
                                                                                        Display="Dynamic" ErrorMessage="Cost Should be Numeric." Text="*" ValidationExpression="^[0-9\s\-]+$"
                                                                                        ValidationGroup="add"></asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Total KM :">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtdvTotalKM" runat="server" MaxLength="30" CssClass="TextBox"></asp:TextBox>                                                                                   
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="WeekType :">
                                                                                <InsertItemTemplate>
                                                                                    <asp:RadioButtonList ID="rbWeekType" runat="server" 
                                                                                        RepeatDirection="Horizontal">
                                                                                        <asp:ListItem Text="Week Day" Value="WD" Selected="True" />
                                                                                        <asp:ListItem Text="Week End" Value="WE" />
                                                                                    </asp:RadioButtonList>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Attachmen :">
                                                                                <InsertItemTemplate>
                                                                                    <asp:FileUpload ID="fuAttachment" runat="server" /><br />
                                                                                    <asp:Label ID="lblAttachment" runat="server"></asp:Label>
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
                                                            <tr>
                                                                <td align="center">
                                                                    &nbsp;</td>
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
        <Triggers>
            <asp:PostBackTrigger ControlID="dvAdhoc" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

