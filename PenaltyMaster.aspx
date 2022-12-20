<%@ Page Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="PenaltyMaster.aspx.cs" Inherits="PenaltyMaster" Title="Penalty Master" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

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
                    <td align="center" >
                        <div >
                            <strong>Penalty Master </strong>
                           <br />
                                Allows User to View/Edit and Add New Penalty.
                          
                        </div>
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
                <tr>
                    <td align="center">
                        &nbsp;
                        <asp:Label ID="lblMsg" runat="server" CssClass="message" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr style="display:none">
                    <td align="center"><b>Facility : </b>
                        <asp:DropDownList ID="ddlfacility0" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="DropDownListBox3" OnSelectedIndexChanged="ddlfacility0_SelectedIndexChanged1" >
                            <asp:ListItem Selected="True" Value="0">Select Facility</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Vendor : </b>
                        <asp:DropDownList ID="ddlvendor0" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="DropDownListBox3" OnSelectedIndexChanged="ddlvendor0_SelectedIndexChanged1" >
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table align="center" width="80%">
                            <tr>
                                <td align="center">
                                    <asp:MultiView ID="mvFacility" runat="server" ActiveViewIndex="0">
                                        <table align="center" width="100%">
                                            <tr>
                                                <td>
                                                    <asp:View ID="View1" runat="server">
                                                        <table align="center" width="100%">
                                                            <tr>
                                                                <td align="center">
                                                                    &nbsp;<asp:GridView ID="gvFacility" runat="server" AllowPaging="True" AllowSorting="True"
                                                                        AutoGenerateColumns="False" CssClass="GridView" OnPageIndexChanging="gvFacility_PageIndexChanging"
                                                                        DataKeyNames="Id" OnRowCancelingEdit="gvFacility_RowCancelingEdit" OnRowEditing="gvFacility_RowEditing"
                                                                        OnRowUpdating="gvFacility_RowUpdating" BorderWidth="0px" ShowFooter="True" Width="75%" EmptyDataText="No Record Found" EnableModelValidation="True">
                                                                        <Columns>
                                                                            <%--<asp:TemplateField HeaderText="Facility Name">
                                                                                <EditItemTemplate>
                                                                                    <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="true" 
                                                                                        onselectedindexchanged="ddlFacility_SelectedIndexChanged" AutoPostBack="true" Enabled="False">
                                                                                    </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidator_Fac" runat="server" ErrorMessage="Select Facility Name"
                                                                                        ControlToValidate="ddlFacility" Display="Dynamic" SetFocusOnError="True" Text="*"
                                                                                        ValueToCompare="0" Operator="NotEqual" ValidationGroup="edit"></asp:CompareValidator>
                                                                                </EditItemTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbFacility" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>--%>
                                                                            <%--<asp:TemplateField HeaderText="Vendor Name">
                                                                                <EditItemTemplate>
                                                                                <asp:DropDownList ID="ddlVendor" runat="server" AppendDataBoundItems="true" Enabled="False">
                                                                                </asp:DropDownList>
                                                                                <asp:CompareValidator ID="CompareValidator" runat="server" ErrorMessage="Select Vendor Name"
                                                                                    ControlToValidate="ddlVendor" Display="Dynamic" SetFocusOnError="True" Text="*"
                                                                                    ValueToCompare="0" Operator="NotEqual" ValidationGroup="edit">
                                                                                </asp:CompareValidator>
                                                                                </EditItemTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVendor" runat="server" Text='<%# Eval("vendorName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>--%>                                                                            
                                                                            <asp:TemplateField HeaderText="Penalty Name">
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtFacility" runat="server" Text='<%# Eval("HeadName") %>' MaxLength="20"
                                                                                        CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFacility"
                                                                                        Display="Dynamic" ErrorMessage="Enter Penalty Head" ValidationGroup="edit">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegExpAlphanum0" runat="server" ControlToValidate="txtFacility"
                                                                                        Display="Dynamic" ErrorMessage="Penalty Should be Alphanumeric." Text="*" ValidationExpression="^[a-zA-Z0-9_\s]*"
                                                                                        ValidationGroup="edit"></asp:RegularExpressionValidator>
                                                                                </EditItemTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblHead" runat="server" Text='<%# Eval("HeadName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Penalty Amount">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblGeoX" runat="server" Text='<%# Eval("Penalty") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtGeoX" runat="server" Text='<%# Eval("Penalty") %>' MaxLength="10"
                                                                                        CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoX" runat="server" ControlToValidate="txtGeoX"
                                                                                        Display="Dynamic" ErrorMessage="Enter Penalty Amount" ValidationGroup="edit">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtGeoX"
                                                                                        ValidationGroup="edit" ErrorMessage="Enter a Penalty Amount" Display="Dynamic"
                                                                                        ValidationExpression="^[1-9]\d*(\.\d+)?$">*</asp:RegularExpressionValidator>
                                                                                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtGeoX"
                                                                                        ErrorMessage="Please Enter the Numeric Value" MaximumValue="99999" MinimumValue="0"
                                                                                        SetFocusOnError="true" Type="Double" ValidationGroup="add">*</asp:RangeValidator>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Penalty For">
                                                                                <EditItemTemplate>
                                                                                    <asp:DropDownList ID="ddlPenaltyFor" runat="server" AppendDataBoundItems="true">
                                                                                        <asp:ListItem Text="Compliance" Value="CAB" Selected="True" />
                                                                                        <asp:ListItem Text="Vendor" Value="ROUTE" />
                                                                                    </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="Select Penalty For"
                                                                                        ControlToValidate="ddlPenaltyFor" Display="Dynamic" SetFocusOnError="True" Text="*"
                                                                                        ValueToCompare="0" Operator="NotEqual" ValidationGroup="edit"></asp:CompareValidator>
                                                                                </EditItemTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblGeoY" runat="server" Text='<%# Eval("PenaltyFor") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                             <%--<asp:TemplateField HeaderText="From_Date">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDate" runat="server" Text='<%# Eval("Date") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>--%>
                                                                            <%--<asp:TemplateField HeaderText="To_Date">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbllastDate" runat="server" Text='<%# Eval("enddate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>--%>
                                                                            <asp:CommandField ShowEditButton="True" ValidationGroup="edit" />
                                                                        </Columns>
                                                                        <RowStyle CssClass="RowStyle" />
                                                                        <EmptyDataRowStyle ForeColor="Red" />
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
                                                                    &nbsp;
                                                                    <asp:LinkButton ID="lbtnExport" runat="server" CausesValidation="False" OnClick="lbtnExport_Click">Export To Excel</asp:LinkButton>
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
                                                                        DefaultMode="Insert" HeaderText="Add New Penalty" OnItemInserting="dvFacility_ItemInserting"
                                                                        OnModeChanging="dvFacility_ModeChanging" Width="50%" CssClass="DetailsView" CellPadding="6">
                                                                        <FieldHeaderStyle Width="40%" />
                                                                        <Fields>
                                                                            <%--<asp:TemplateField HeaderText="Facility Name">
                                                                                <InsertItemTemplate>
                                                                                    <asp:DropDownList ID="ddldvFacility" runat="server" AppendDataBoundItems="true" 
                                                                                        onselectedindexchanged="ddldvFacility_SelectedIndexChanged" AutoPostBack="true">
                                                                                    </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidator_dvFacility" runat="server" ErrorMessage="Select Facility Name"
                                                                                        ControlToValidate="ddldvFacility" Display="Dynamic" SetFocusOnError="True" Text="*"
                                                                                        ValueToCompare="0" Operator="NotEqual" ValidationGroup="edit"></asp:CompareValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>--%>
                                                                            <%--<asp:TemplateField HeaderText="Vendor Name">
                                                                                <InsertItemTemplate>
                                                                                    <asp:DropDownList ID="ddldvVendor" runat="server" AppendDataBoundItems="true">
                                                                                    </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidator_dvVendor" runat="server" ErrorMessage="Select Vendor Name"
                                                                                        ControlToValidate="ddldvVendor" Display="Dynamic" SetFocusOnError="True" Text="*"
                                                                                        ValueToCompare="-1" Operator="NotEqual" ValidationGroup="edit"></asp:CompareValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>--%>
                                                                            <asp:TemplateField HeaderText="Penalty Name">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtdvFacilityName" runat="server" MaxLength="50" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldFacName" runat="server" ControlToValidate="txtdvFacilityName"
                                                                                        Display="Dynamic" ErrorMessage="Enter Penalty Name" ValidationGroup="add"
                                                                                        SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegExpAlphanum2" runat="server" ControlToValidate="txtdvFacilityName"
                                                                                        Display="Dynamic" ErrorMessage="Penalty Name Should be Alphanumeric." Text="*"
                                                                                        ValidationExpression="^[a-zA-Z0-9_\s]*" ValidationGroup="add"></asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Penalty Amount">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtdvGeoX" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoX" runat="server" ControlToValidate="txtdvGeoX"
                                                                                        Display="Dynamic" ErrorMessage="Enter Penalty Amount" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtdvGeoX"
                                                                                        ValidationGroup="add" ErrorMessage="Enter a valid Penalty Amount" Display="Dynamic"
                                                                                        ValidationExpression="^[1-9]\d*(\.\d+)?$" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtdvGeoX"
                                                                                        ErrorMessage="Please Enter the Numeric Value" MaximumValue="99999" MinimumValue="0"
                                                                                        SetFocusOnError="true" Type="Double" ValidationGroup="add">*</asp:RangeValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Penalty For">
                                                                                <InsertItemTemplate>
                                                                                    <asp:DropDownList ID="ddldvPenaltyfor" runat="server" AppendDataBoundItems="true">
                                                                                        <asp:ListItem Text="Compliance" Value="CAB" Selected="True" />
                                                                                        <asp:ListItem Text="Operational" Value="ROUTE" />
                                                                                    </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Select Penalty For"
                                                                                        ControlToValidate="ddldvPenaltyfor" Display="Dynamic" SetFocusOnError="True"
                                                                                        Text="*" ValueToCompare="0" Operator="NotEqual" ValidationGroup="edit"></asp:CompareValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                              <%--<asp:TemplateField HeaderText="Effective Date">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtEffectiveDate" ReadOnly="false" runat="server" CssClass="TextBox" MaxLength="10"
                                                                                        Text='<%# Eval("registrationDate","{0:d}") %>' Width="100px"></asp:TextBox>
                                                                                    <cc1:CalendarExtender ID="txtRegstrationDate_CalendarExtender" runat="server" Enabled="True"
                                                                                        TargetControlID="txtEffectiveDate"></cc1:CalendarExtender>
                                                                                    <asp:RegularExpressionValidator ID="RegulapresionValdator6" runat="server" ControlToValidate="txtEffectiveDate"
                                                                                        Display="Dynamic" ErrorMessage="Enter Valid Effective Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                                        ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>

                                                                            </asp:TemplateField>--%>
                                                                            <asp:CommandField ValidationGroup="add" ShowInsertButton="True" />
                                                                        </Fields>
                                                                        <RowStyle CssClass="DetailsViewRowStyle" />
                                                                        <FooterStyle CssClass="DetailsViewFooterStyle" />
                                                                        <PagerStyle CssClass="DetailsViewPagerStyle" />
                                                                        <HeaderStyle CssClass="DetailsViewHeaderStyle" Font-Bold="True" />
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
                            
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="gvCostExcel" runat="server"  AutoGenerateColumns="False"  >
                            <Columns>
                                <asp:BoundField DataField="HeadName" HeaderText="Penalty Name" />
                                <asp:BoundField DataField="Penalty" HeaderText="Penalty" />
                                <asp:BoundField DataField="PenaltyFor" HeaderText="PenaltyFor" />
                                <%--<asp:BoundField DataField="facilityName" HeaderText="Facility" />--%>
                                <%--<asp:BoundField DataField="vendorName" HeaderText="Vendor" />--%>
                                <%--<asp:BoundField DataField="DATE" HeaderText="From_Date" />--%>
                                <%--<asp:BoundField DataField="Enddate" HeaderText="TO_Date" />--%>
                            </Columns>
                          
                        </asp:GridView>
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
            <asp:PostBackTrigger ControlID="lbtnExport" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

