<%@ Page Title="" Language="C#" MasterPageFile="~/Header.Master" AutoEventWireup="true" CodeFile="CostMaster2.aspx.cs" Inherits="CostMaster2" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
                <div>
                    <table align="center" width="800px">
                                        <tr>
                                            <td align="center" style="border: solid">
                                                <asp:LinkButton ID="lkbSlab" runat="server" Font-Bold="true" OnClick="lkbSlab_Click">Slab Rate Cost Master</asp:LinkButton>
                                            </td>
                                            <td align="center" style="border: solid">
                                                <asp:LinkButton ID="lkbMedical" runat="server" Font-Bold="true" OnClick="lkbMedical_Click">Medical Cab Cost Master</asp:LinkButton>
                                            </td>
                                            <td align="center" style="border: solid; display:none">
                                                <asp:LinkButton ID="lkbAddition" runat="server" Font-Bold="true" OnClick="lkbAddition_Click">Additional Cab Cost Master</asp:LinkButton>
                                            </td>
                                        </tr>
                                        </table>
                </div>
            
            <table align="center" width="1000px">
                <tr>
                    <td align="center">
                        <asp:ValidationSummary ID="ValidationSummaryEdit" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="edit" />
                        <asp:ValidationSummary ID="ValidationSummaryadd" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="add" />
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="Update" />
                    </td>
                </tr>
                <%--<tr>
                    <td class="heading">
                        <div class="gradient2">
                            <h1>
                                <span></span>Cost Master New Model
                            </h1>
                            <h2>Allows User to View/Edit and Add New Cost.
                            </h2>
                        </div>
                    </td>
                </tr>--%>
                <tr>
                                <td align="center">
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                                        DisplayAfter="0" DynamicLayout="False">
                                        <ProgressTemplate>
                                            <table class="style6">
                                                <tr>
                                                    <td class="style7">
                                                        <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" />
                                                    </td>
                                                    <td>Please Wait!!!
                                                    </td>
                                                </tr>
                                            </table>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                <tr>
                    <%--<td align="center">
                       Select Facility:
                       <asp:DropDownList ID="ddlSelectFacility" runat="server" AutoPostBack="True" 
                                                onselectedindexchanged="ddlSelectFacility_SelectedIndexChanged">
                                            </asp:DropDownList>
                       </td>--%>
                </tr>
                <tr>
                    <td>
                        <table align="center" width="1000px">
                            <tr>
                                <td align="center" colspan="3">
                                    <asp:MultiView ID="mvSlab" runat="server">
                                        <table align="center" width="1000px">
                                            <tr>
                                                <td>
                                                    <asp:View ID="ViewSlab" runat="server">
                                                        <table align="center" width="100%">
                                                            <tr>
                                                                <td>
                                                                    <b><span>Slab rate cost master</span></b>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" valign="middle">
                                                                    Select Facility:
                                                                   <asp:DropDownList ID="ddlSelectSlabFacility" runat="server" AutoPostBack="True"
                                                                       OnSelectedIndexChanged="ddlSelectSlabFacility_SelectedIndexChanged">
                                                                   </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="LkbExportExl" runat="server" OnClick="LkbExportExl_Click">Export to Excel</asp:LinkButton>
                                                                    <asp:GridView ID="gvSlabCost" runat="server" AllowSorting="True" EmptyDataText="No record Found"
                                                                        AutoGenerateColumns="False" CssClass="GridView" ShowFooter="True"
                                                                        Width="100%" OnRowCancelingEdit="gvSlabCost_RowCancelingEdit"
                                                                        OnRowEditing="gvSlabCost_RowEditing" OnRowUpdating="gvSlabCost_RowUpdating" 
                                                                        OnRowDeleting="gvSlabCost_RowDeleting" DataKeyNames="id" AllowPaging="True" OnPageIndexChanging="gvSlabCost_PageIndexChanging"
                                                                        PageSize="20" EnableModelValidation="True">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Facility">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFacility" runat="server" Text='<%# Eval("Facility") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <%--<EditItemTemplate>
                                                                                    <asp:DropDownList ID="ddlgvVendor" runat="server" AppendDataBoundItems="true" Enabled="false">
                                                                                    </asp:DropDownList>
                                                                                </EditItemTemplate>--%>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vendor">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVendor" runat="server" Text='<%# Eval("vendorName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <%--<EditItemTemplate>
                                                                                    <asp:DropDownList ID="ddlgvVendor" runat="server" AppendDataBoundItems="true" Enabled="false">
                                                                                    </asp:DropDownList>
                                                                                </EditItemTemplate>--%>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vehicle Type">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVehicle" runat="server" Text='<%# Eval("vehicle") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <%--<EditItemTemplate>
                                                                                    <asp:DropDownList ID="ddlgvVehicle" runat="server" AppendDataBoundItems="true" Enabled="false">
                                                                                    </asp:DropDownList>
                                                                                </EditItemTemplate>--%>
                                                                            </asp:TemplateField>
                                                                            <%--<asp:TemplateField HeaderText="Current Fuel Rate">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFuelRate" runat="server" Text='<%# Eval("CurrentFuelRate") %>'></asp:Label>
                                                                                
                                                                                
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvFuleRate" runat="server" Text='<%# Eval("CurrentFuelRate") %>' MaxLength="7" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtgvFuleRate" runat="server" ControlToValidate="txtgvFuleRate"
                                                                                        Display="Dynamic" ErrorMessage="Please Enter Fuel Rate" ValidationGroup="Update" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegulartxtgvFuleRate" runat="server" ControlToValidate="txtgvFuleRate"
                                                                                        ValidationGroup="Update" ErrorMessage="Enter a valid Fuel Rate" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>

                                                                                
                                                                                
                                                                                </EditItemTemplate>
                                                                          </asp:TemplateField>--%>
                                                                            <asp:TemplateField HeaderText="Start KM Slab">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblStartkm" runat="server" Text='<%# Eval("StartKmSlab") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvStartkmSlab" runat="server" Text='<%# Eval("StartKmSlab") %>' MaxLength="7" CssClass="TextBox"></asp:TextBox>

                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtStartkmSlab" runat="server" ControlToValidate="txtgvStartkmSlab"
                                                                                        Display="Dynamic" ErrorMessage="Please Enter Start KM Slab" ValidationGroup="Update" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegulartxttxtgvStartkmSlab" runat="server" ControlToValidate="txtgvStartkmSlab"
                                                                                        ValidationGroup="Update" ErrorMessage="Enter a valid Start KM Slab" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>

                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="End KM Slab">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblEndkm" runat="server" Text='<%# Eval("EndKmSlab") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvEndkmSlab" runat="server" Text='<%# Eval("EndKmSlab") %>' MaxLength="7" CssClass="TextBox"></asp:TextBox>

                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtEndkmSlab" runat="server" ControlToValidate="txtgvEndkmSlab"
                                                                                        Display="Dynamic" ErrorMessage="Please Enter End KM Slab" ValidationGroup="Update" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegulartxttxtgvEndkmSlab" runat="server" ControlToValidate="txtgvEndkmSlab"
                                                                                        ValidationGroup="Update" ErrorMessage="Enter a valid End KM Slab" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>


                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Fuel Rate">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFuelRate" runat="server" Text='<%# Eval("FuelRate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvFuelRate" runat="server" Text='<%# Eval("FuelRate") %>' MaxLength="10" CssClass="TextBox"></asp:TextBox>

                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtgvFuelRate" runat="server" ControlToValidate="txtgvFuelRate"
                                                                                        Display="Dynamic" ErrorMessage="Please Enter Fuel Rate" ValidationGroup="Update" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegulartxttxtgvFuelRate" runat="server" ControlToValidate="txtgvFuelRate"
                                                                                        ValidationGroup="Update" ErrorMessage="Enter a valid Fuel Rate" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>


                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Rate/Km">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblKmRate" runat="server" Text='<%# Eval("KmRate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvKmRate" runat="server" Text='<%# Eval("KmRate") %>' MaxLength="10" CssClass="TextBox"></asp:TextBox>

                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtgvKmRate" runat="server" ControlToValidate="txtgvKmRate"
                                                                                        Display="Dynamic" ErrorMessage="Please Enter Rate" ValidationGroup="Update" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegulartxttxtgvKmRate" runat="server" ControlToValidate="txtgvKmRate"
                                                                                        ValidationGroup="Update" ErrorMessage="Enter a valid Rate" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>


                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="From Date">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDate" runat="server" Text='<%# Eval("Date") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                 <%--<EditItemTemplate>
                                                                                    <asp:TextBox ID="txtDate" runat="server" Text='<%# Eval("Date") %>' MaxLength="15" CssClass="TextBox"></asp:TextBox>
                                                                                </EditItemTemplate>--%>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="To Date">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbllastDate" runat="server" Text='<%# Eval("enddate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <%--<EditItemTemplate>
                                                                                    <asp:TextBox ID="txtlastDate" runat="server" Text='<%# Eval("enddate") %>' MaxLength="15" CssClass="TextBox"></asp:TextBox>
                                                                                </EditItemTemplate>--%>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="UpdatedBY" ItemStyle-Width="10%">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblUpdatedBY" runat="server" Text='<%# Eval("UpdatedBY") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <%--<EditItemTemplate>
                                                                                    <asp:TextBox ID="txtlastDate" runat="server" Text='<%# Eval("enddate") %>' MaxLength="15" CssClass="TextBox"></asp:TextBox>
                                                                                </EditItemTemplate>--%>
                                                                            </asp:TemplateField>
                                                                            <asp:CommandField ShowEditButton="True" ValidationGroup="Update" CausesValidation="true" />
                                                                            <asp:CommandField ShowDeleteButton="false" />
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
                                                                    <asp:LinkButton ID="lbtnAddNew" runat="server" CausesValidation="False" OnClick="lbtnAddNew_Click">Change Rate</asp:LinkButton>
                                                                       &nbsp;<asp:LinkButton ID="lbtnAdd" runat="server" CausesValidation="False" OnClick="lbtnAdd_Click">Add New Slab Cost</asp:LinkButton>
                                                                    </td>
                                                            </tr>
                                                        </table>
                                                    </asp:View>
                                                    <asp:View ID="ViewSlab1" runat="server">
                                                        <table align="center" width="1000px">
                                                            <tr>
                                                                <td align="center">
                                                                    <asp:DetailsView ID="dvSlabCost" runat="server" AutoGenerateRows="False" DataKeyNames="Id"
                                                                        DefaultMode="Insert" HeaderText="Slab Cost Master"  Width="35%" 
                                                                        oniteminserting="dvSlabCost_ItemInserting" 
                                                                        onmodechanging="dvSlabCost_ModeChanging">
                                                                        <Fields>
                                                                            <asp:TemplateField HeaderText="Effective Date">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtEffectiveDate" runat="server" Text='<%# Eval("registrationDate","{0:d}") %>'
                                                                            Width="60px" MaxLength="10" CssClass="TextBox" OnTextChanged="txtEffectiveDate_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtRegstrationDate_CalendarExtender" runat="server" Enabled="True"
                                                                            TargetControlID="txtEffectiveDate" CssClass="cal_Theme1">
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RegularExpressionValidator ID="RegulapresionValdator6" runat="server" ControlToValidate="txtEffectiveDate"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid Effective Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vendor">
                                                                                <InsertItemTemplate>
                                                                                     <asp:DropDownList ID="ddlVendor" runat="server" AppendDataBoundItems="True"
                                                                            CssClass="DropDownListBox3" OnSelectedIndexChanged="ddlVendor_SelectedIndexChanged" AutoPostBack="true">
                                                                                         </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidatesd" runat="server" ControlToValidate="ddlVendor"
                                                                                   Display="Dynamic" ErrorMessage="Select Vendor" Operator="NotEqual" ValidationGroup="add"
                                                                                   ValueToCompare="-1">*</asp:CompareValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vehicle Type">
                                                                                <InsertItemTemplate>
                                                                                     <asp:DropDownList ID="ddlVehicleType" runat="server" AppendDataBoundItems="True"
                                                                                        CssClass="DropDownListBox3" OnSelectedIndexChanged="ddlVehicleType_SelectedIndexChanged" AutoPostBack="true">
                                                                                         </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidat" runat="server" ControlToValidate="ddlVehicleType"
                                                                                   Display="Dynamic" ErrorMessage="Select Vehicle" Operator="NotEqual" ValidationGroup="add"
                                                                                   ValueToCompare="0">*</asp:CompareValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Start KM Slab">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtStartKm" OnTextChanged="txtStartKm_TextChanged" AutoPostBack="true" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtStartKm" runat="server" ControlToValidate="txtStartKm"
                                                                                        Display="Dynamic" ErrorMessage="Enter Start KM" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressiontxtStartKm" runat="server" ControlToValidate="txtStartKm"
                                                                                        ValidationGroup="add" ErrorMessage="Enter a valid Start Km" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="End KM Slab">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtEndKm" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtEndKm" runat="server" ControlToValidate="txtEndKm"
                                                                                        Display="Dynamic" ErrorMessage="Enter End KM" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressiontxtEndKm" runat="server" ControlToValidate="txtEndKm"
                                                                                        ValidationGroup="add" ErrorMessage="Enter a valid End Km" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                <%--<asp:CompareValidator ID="CompareValidattxtEndKm" runat="server" ControlToValidate="txtEndKm"
                                                                                   Display="Dynamic" ErrorMessage="End km should be greater than start km" Operator="GreaterThan" ValidationGroup="add"
                                                                                   ControlToCompare="txtStartKm">*</asp:CompareValidator>--%>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Fuel Rate">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtnewFuelRate" OnTextChanged="txtnewFuelRate_TextChanged" AutoPostBack="true" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFuelFieldGeoY" runat="server" ControlToValidate="txtnewFuelRate"
                                                                                        Display="Dynamic" ErrorMessage="Enter Fuel Rate" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidatorFuel" runat="server" ControlToValidate="txtnewFuelRate"
                                                                                        ValidationGroup="add" ErrorMessage="Enter a valid Fuel Rate" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="KM Rate">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtnewRate" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoY" runat="server" ControlToValidate="txtnewRate"
                                                                                        Display="Dynamic" ErrorMessage="Enter Km Rate" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtnewRate"
                                                                                        ValidationGroup="add" ErrorMessage="Enter a valid Km Rate" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="All Facility" HeaderStyle-ForeColor="Red">
                                                                                <InsertItemTemplate>
                                                                                  <asp:CheckBox ID="chkAllfacility" runat="server" Text="Check if yes" Checked="false"/>

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
                                                    </asp:MultiView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <asp:MultiView ID="mvMedical" runat="server">
                                                    <asp:View ID="ViewMedical" runat="server">
                                                        <table align="center" width="1000px">
                                                            <tr>
                                                                <td align="center"><b><span>Medical Cab cost master</span></b>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" valign="middle">Select Facility:
                                                                    <asp:DropDownList ID="ddlSelectMedicalFacility" runat="server" AutoPostBack="True" 
                                                                        OnSelectedIndexChanged="ddlSelectMedicalFacility_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="LkbExportExl1" runat="server" OnClick="LkbExportExl1_Click">Export to Excel</asp:LinkButton>
                                                                    <asp:GridView ID="gvMedicalCost" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="GridView" 
                                                                        DataKeyNames="id" EmptyDataText="No record Found" OnPageIndexChanging="gvMedicalCost_PageIndexChanging" 
                                                                        OnRowCancelingEdit="gvMedicalCost_RowCancelingEdit" OnRowEditing="gvMedicalCost_RowEditing" OnRowUpdating="gvMedicalCost_RowUpdating" PageSize="20" 
                                                                        ShowFooter="True" Width="100%" EnableModelValidation="True" OnRowDeleting="gvMedicalCost_RowDeleting">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Facility">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFacility" runat="server" Text='<%# Eval("Facility") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vendor">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVendorm" runat="server" Text='<%# Eval("vendorName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <%--<EditItemTemplate>
                                                                                    <asp:DropDownList ID="ddlgvVendor" runat="server" AppendDataBoundItems="true" Enabled="false">
                                                                                    </asp:DropDownList>
                                                                                </EditItemTemplate>--%></asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vehicle Type">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVehiclem" runat="server" Text='<%# Eval("vehicle") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <%--<EditItemTemplate>
                                                                                    <asp:DropDownList ID="ddlgvVehicle" runat="server" AppendDataBoundItems="true" Enabled="false">
                                                                                    </asp:DropDownList>
                                                                                </EditItemTemplate>--%></asp:TemplateField>
                                                                            <%--<asp:TemplateField HeaderText="Current Fuel Rate">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFuelRate" runat="server" Text='<%# Eval("CurrentFuelRate") %>'></asp:Label>
                                                                                
                                                                                
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvFuleRate" runat="server" Text='<%# Eval("CurrentFuelRate") %>' MaxLength="7" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtgvFuleRate" runat="server" ControlToValidate="txtgvFuleRate"
                                                                                        Display="Dynamic" ErrorMessage="Please Enter Fuel Rate" ValidationGroup="Update" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegulartxtgvFuleRate" runat="server" ControlToValidate="txtgvFuleRate"
                                                                                        ValidationGroup="Update" ErrorMessage="Enter a valid Fuel Rate" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>

                                                                                
                                                                                
                                                                                </EditItemTemplate>
                                                                          </asp:TemplateField>--%>
                                                                            <asp:TemplateField HeaderText="Start KM">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblStartkmm" runat="server" Text='<%# Eval("StartKm") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvStartkmm" runat="server" Text='<%# Eval("StartKm") %>' MaxLength="7" CssClass="TextBox"></asp:TextBox>

                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtStartkmm" runat="server" ControlToValidate="txtgvStartkmm"
                                                                                        Display="Dynamic" ErrorMessage="Please Enter Start KM" ValidationGroup="Update" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegulartxttxtgvStartkmm" runat="server" ControlToValidate="txtgvStartkmm"
                                                                                        ValidationGroup="Update" ErrorMessage="Enter a valid Start KM" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>


                                                                                </EditItemTemplate></asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="End KM">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblEndkm0" runat="server" Text='<%# Eval("EndKm") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvEndkm0" runat="server" Text='<%# Eval("EndKm") %>' MaxLength="7" CssClass="TextBox"></asp:TextBox>

                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtEndkm0" runat="server" ControlToValidate="txtgvEndkm0"
                                                                                        Display="Dynamic" ErrorMessage="Please Enter End KM" ValidationGroup="Update" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegulartxttxtgvEndkm0" runat="server" ControlToValidate="txtgvEndkm0"
                                                                                        ValidationGroup="Update" ErrorMessage="Enter a valid End KM" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>


                                                                                </EditItemTemplate></asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Start Shift">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblStartShift" runat="server" Text='<%# Eval("StartShift") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvStartShift" runat="server" Text='<%# Eval("StartShift") %>' MaxLength="7" CssClass="TextBox"></asp:TextBox>

                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtStartShift" runat="server" ControlToValidate="txtgvStartShift"
                                                                                        Display="Dynamic" ErrorMessage="Please Enter Start Shift" ValidationGroup="Update" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegulartxttxtgvStartShift" runat="server" ControlToValidate="txtgvStartShift"
                                                                                        ValidationGroup="Update" ErrorMessage="Enter a valid Start Shift" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>


                                                                                </EditItemTemplate></asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="End Shift">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblEndShift" runat="server" Text='<%# Eval("EndShift") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvEndShift" runat="server" Text='<%# Eval("EndShift") %>' MaxLength="7" CssClass="TextBox"></asp:TextBox>

                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtEndShift" runat="server" ControlToValidate="txtgvEndShift"
                                                                                        Display="Dynamic" ErrorMessage="Please Enter End Shift" ValidationGroup="Update" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegulartxttxtgvEndShift" runat="server" ControlToValidate="txtgvEndShift"
                                                                                        ValidationGroup="Update" ErrorMessage="Enter a valid End Shift" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>


                                                                                </EditItemTemplate></asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Fuel Rate">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFuelRatem" runat="server" Text='<%# Eval("FuelRate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvFuelRatem" runat="server" CssClass="TextBox" MaxLength="10" Text='<%# Eval("FuelRate") %>'></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtgvFuelRatem" runat="server" ControlToValidate="txtgvFuelRatem" Display="Dynamic" 
                                                                                        ErrorMessage="Please Enter Fuel Rate" SetFocusOnError="True" ValidationGroup="Update">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegulartxttxtgvFuelRatem" runat="server" ControlToValidate="txtgvFuelRatem" Display="Dynamic" 
                                                                                        ErrorMessage="Enter a valid Fuel Rate" SetFocusOnError="True" ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" ValidationGroup="Update">*</asp:RegularExpressionValidator>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Rate/Km">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblKmRatem" runat="server" Text='<%# Eval("KmRate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvKmRatem" runat="server" CssClass="TextBox" MaxLength="10" Text='<%# Eval("KmRate") %>'></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtgvKmRatem" runat="server" ControlToValidate="txtgvKmRatem" Display="Dynamic" 
                                                                                        ErrorMessage="Please Enter Rate" SetFocusOnError="True" ValidationGroup="Update">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegulartxttxtgvKmRatem" runat="server" ControlToValidate="txtgvKmRatem" Display="Dynamic" 
                                                                                        ErrorMessage="Enter a valid km Rate" SetFocusOnError="True" ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" ValidationGroup="Update">*</asp:RegularExpressionValidator>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="From Date">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDatem" runat="server" Text='<%# Eval("fromdate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="To Date">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbllastDatem" runat="server" Text='<%# Eval("Todate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="UpdatedBY" ItemStyle-Width="10%">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblUpdatedBY" runat="server" Text='<%# Eval("UpdatedBY") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <%--<EditItemTemplate>
                                                                                    <asp:TextBox ID="txtlastDate" runat="server" Text='<%# Eval("enddate") %>' MaxLength="15" CssClass="TextBox"></asp:TextBox>
                                                                                </EditItemTemplate>--%>
                                                                            </asp:TemplateField>
                                                                            <asp:CommandField CausesValidation="true" ShowEditButton="True" ValidationGroup="Update" />
                                                                            <asp:CommandField ShowDeleteButton="false" />
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
                                                                    <asp:LinkButton ID="lbtnAddNewm" runat="server" CausesValidation="False" OnClick="lbtnAddNewm_Click">Change Rate</asp:LinkButton>
                                                                    &nbsp;<asp:LinkButton ID="lbtnAddm" runat="server" CausesValidation="False" OnClick="lbtnAddm_Click">Add New Medical Cost</asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:View>
                                                        <asp:View ID="ViewMedical1" runat="server">

                                                            <table align="center" width="1000px">
                                                                <tr>
                                                                    <td align="center">
                                                                        <asp:DetailsView ID="dvMedicalCost" runat="server" AutoGenerateRows="False" DataKeyNames="Id" DefaultMode="Insert" 
                                                                            HeaderText="Medical Cost Master" oniteminserting="dvMedicalCost_ItemInserting" onmodechanging="dvMedicalCost_ModeChanging" Width="35%">
                                                                            <Fields>
                                                                                <asp:TemplateField HeaderText="Effective Date">
                                                                                    <InsertItemTemplate>
                                                                                        <asp:TextBox ID="txtEffectiveDatem" runat="server" CssClass="TextBox" MaxLength="10" Text='<%# Eval("registrationDate","{0:d}") %>' 
                                                                                            Width="60px"></asp:TextBox>
                                                                                        <cc1:CalendarExtender ID="txtRegstrationDate_CalendarExtender0" runat="server" CssClass="cal_Theme1" Enabled="True" 
                                                                                            TargetControlID="txtEffectiveDatem">
                                                                                        </cc1:CalendarExtender>
                                                                                        <asp:RegularExpressionValidator ID="RegulapresionValdator7" runat="server" ControlToValidate="txtEffectiveDatem" Display="Dynamic" 
                                                                                            ErrorMessage="Enter Valid Effective Date" 
                                                                                            ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$" 
                                                                                            ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                                    </InsertItemTemplate>
                                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Vendor">
                                                                                    <InsertItemTemplate>
                                                                                        <asp:DropDownList ID="ddlVendorm" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                                        </asp:DropDownList>
                                                                                        <asp:CompareValidator ID="CompareValidatesd0" runat="server" ControlToValidate="ddlVendorm" Display="Dynamic" ErrorMessage="Select Vendor" 
                                                                                            Operator="NotEqual" ValidationGroup="add" ValueToCompare="-1">*</asp:CompareValidator>
                                                                                    </InsertItemTemplate>
                                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Vehicle Type">
                                                                                    <InsertItemTemplate>
                                                                                        <asp:DropDownList ID="ddlVehicleTypem" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                                        </asp:DropDownList>
                                                                                        <asp:CompareValidator ID="CompareValidat0" runat="server" ControlToValidate="ddlVehicleTypem" Display="Dynamic" 
                                                                                            ErrorMessage="Select Vehicle" Operator="NotEqual" ValidationGroup="add" ValueToCompare="0">*</asp:CompareValidator>
                                                                                    </InsertItemTemplate>
                                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Start KM">
                                                                                    <InsertItemTemplate>
                                                                                        <asp:TextBox ID="txtStartKmm" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                                        <asp:RequiredFieldValidator ID="ReqFieldtxtStartKm0" runat="server" ControlToValidate="txtStartKmm" Display="Dynamic" 
                                                                                            ErrorMessage="Enter Start KM" SetFocusOnError="True" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                        <asp:RegularExpressionValidator ID="RegularExpressiontxtStartKm0" runat="server" ControlToValidate="txtStartKmm" Display="Dynamic" 
                                                                                            ErrorMessage="Enter a valid Start Km" SetFocusOnError="True" ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                                    </InsertItemTemplate>
                                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="End KM">
                                                                                    <InsertItemTemplate>
                                                                                        <asp:TextBox ID="txtEndKmm" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                                        <asp:RequiredFieldValidator ID="ReqFieldtxtEndKm0" runat="server" ControlToValidate="txtEndKmm" Display="Dynamic" 
                                                                                            ErrorMessage="Enter End KM" SetFocusOnError="True" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                        <asp:RegularExpressionValidator ID="RegularExpressiontxtEndKm0" runat="server" ControlToValidate="txtEndKmm" Display="Dynamic" 
                                                                                            ErrorMessage="Enter a valid End Km" SetFocusOnError="True" ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                                    </InsertItemTemplate>
                                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Start Shift">
                                                                                    <InsertItemTemplate>
                                                                                        <asp:TextBox ID="txtStartShift" runat="server" CssClass="TextBox" MaxLength="4"></asp:TextBox>
                                                                                        <asp:RequiredFieldValidator ID="ReqFieldStartShift" runat="server" ControlToValidate="txtStartShift" Display="Dynamic" 
                                                                                            ErrorMessage="Enter Start Shift" SetFocusOnError="True" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                        <asp:RegularExpressionValidator ID="RegularExpressionStartShift" runat="server" ControlToValidate="txtStartShift" Display="Dynamic" 
                                                                                            ErrorMessage="Enter a valid Start shift" SetFocusOnError="True" ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                                    </InsertItemTemplate>
                                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="End Shift">
                                                                                    <InsertItemTemplate>
                                                                                        <asp:TextBox ID="txtEndShift" runat="server" CssClass="TextBox" MaxLength="4"></asp:TextBox>
                                                                                        <asp:RequiredFieldValidator ID="ReqFieldEndShift" runat="server" ControlToValidate="txtEndShift" Display="Dynamic" 
                                                                                            ErrorMessage="Enter End Shift" SetFocusOnError="True" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                        <asp:RegularExpressionValidator ID="RegularExpressionEndShift" runat="server" ControlToValidate="txtEndShift" Display="Dynamic" 
                                                                                            ErrorMessage="Enter a valid End Shift" SetFocusOnError="True" ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                                    </InsertItemTemplate>
                                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Fuel Rate">
                                                                                    <InsertItemTemplate>
                                                                                        <asp:TextBox ID="txtnewFuelRatem" OnTextChanged="txtnewFuelRatem_TextChanged" AutoPostBack="false" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                                        <asp:RequiredFieldValidator ID="ReqFuelRatem" runat="server" ControlToValidate="txtnewFuelRatem" Display="Dynamic" ErrorMessage="Enter Fuel Rate" 
                                                                                            SetFocusOnError="True" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorFuel" runat="server" ControlToValidate="txtnewFuelRatem" Display="Dynamic" 
                                                                                            ErrorMessage="Enter a valid Fuel Rate" SetFocusOnError="True" ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                                    </InsertItemTemplate>
                                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="KM Rate">
                                                                                    <InsertItemTemplate>
                                                                                        <asp:TextBox ID="txtnewRatem" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                                        <asp:RequiredFieldValidator ID="ReqRatem" runat="server" ControlToValidate="txtnewRatem" Display="Dynamic" ErrorMessage="Enter Km Rate" 
                                                                                            SetFocusOnError="True" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtnewRatem" Display="Dynamic" 
                                                                                            ErrorMessage="Enter a valid Km Rate" SetFocusOnError="True" ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                                    </InsertItemTemplate>

                                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="All Facility" HeaderStyle-ForeColor="Red">
                                                                                <InsertItemTemplate>
                                                                                  <asp:CheckBox ID="chkAllfacility" runat="server" Text="Check if yes" Checked="false"/>

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
                                                        </asp:MultiView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                    <asp:MultiView ID="mvAdditional" runat="server">
                                                    <asp:View ID="ViewAdditional" runat="server">
                                                        
                                                        <table align="center" width="1000px">
                                                            <tr>
                                                                <td align="center"><b><span>Additional Cab cost master</span></b>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" valign="middle">Select Facility:
                                                                    <asp:DropDownList ID="ddlSelectAdditionalFacility" runat="server" AutoPostBack="True" 
                                                                        OnSelectedIndexChanged="ddlSelectAdditionalFacility_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="LkbExportExl2" runat="server" OnClick="LkbExportExl2_Click">Export to Excel</asp:LinkButton>
                                                                    <asp:GridView ID="gvAdditionalCost" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="GridView" 
                                                                        DataKeyNames="id" EmptyDataText="No record Found" OnPageIndexChanging="gvAdditionalCost_PageIndexChanging" 
                                                                        OnRowCancelingEdit="gvAdditionalCost_RowCancelingEdit" OnRowEditing="gvAdditionalCost_RowEditing" OnRowUpdating="gvAdditionalCost_RowUpdating" 
                                                                        PageSize="20" ShowFooter="True" Width="100%" EnableModelValidation="True" OnRowDeleting="gvAdditionalCost_RowDeleting">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Facility">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFacility" runat="server" Text='<%# Eval("Facility") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vendor">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVendorma" runat="server" Text='<%# Eval("vendorName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <%--<EditItemTemplate>
                                                                                    <asp:DropDownList ID="ddlgvVendor" runat="server" AppendDataBoundItems="true" Enabled="false">
                                                                                    </asp:DropDownList>
                                                                                </EditItemTemplate>--%></asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vehicle Type">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblVehiclea" runat="server" Text='<%# Eval("vehicle") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <%--<EditItemTemplate>
                                                                                    <asp:DropDownList ID="ddlgvVehicle" runat="server" AppendDataBoundItems="true" Enabled="false">
                                                                                    </asp:DropDownList>
                                                                                </EditItemTemplate>--%></asp:TemplateField>
                                                                            <%--<asp:TemplateField HeaderText="Current Fuel Rate">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFuelRate" runat="server" Text='<%# Eval("CurrentFuelRate") %>'></asp:Label>
                                                                                
                                                                                
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvFuleRate" runat="server" Text='<%# Eval("CurrentFuelRate") %>' MaxLength="7" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtgvFuleRate" runat="server" ControlToValidate="txtgvFuleRate"
                                                                                        Display="Dynamic" ErrorMessage="Please Enter Fuel Rate" ValidationGroup="Update" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegulartxtgvFuleRate" runat="server" ControlToValidate="txtgvFuleRate"
                                                                                        ValidationGroup="Update" ErrorMessage="Enter a valid Fuel Rate" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>

                                                                                
                                                                                
                                                                                </EditItemTemplate>
                                                                          </asp:TemplateField>--%>
                                                                            <asp:TemplateField HeaderText="KM">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblkm" runat="server" Text='<%# Eval("Km") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvkm" runat="server" Text='<%# Eval("Km") %>' MaxLength="7" CssClass="TextBox"></asp:TextBox>

                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtkm" runat="server" ControlToValidate="txtgvkm"
                                                                                        Display="Dynamic" ErrorMessage="Please Enter KM" ValidationGroup="Update" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="Regulartxttxtgvkm" runat="server" ControlToValidate="txtgvkm"
                                                                                        ValidationGroup="Update" ErrorMessage="Enter a valid KM" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>


                                                                                </EditItemTemplate></asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Working Hour">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblWorkingHr" runat="server" Text='<%# Eval("WorkingHr") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvWorkingHr" runat="server" Text='<%# Eval("WorkingHr") %>' MaxLength="7" CssClass="TextBox"></asp:TextBox>

                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtWorkingHr" runat="server" ControlToValidate="txtgvWorkingHr"
                                                                                        Display="Dynamic" ErrorMessage="Please Enter Working Hr" ValidationGroup="Update" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegulartxttxtgvWorkingHr" runat="server" ControlToValidate="txtgvWorkingHr"
                                                                                        ValidationGroup="Update" ErrorMessage="Enter a valid Working Hr" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>


                                                                                </EditItemTemplate></asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Fuel Rate">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFuelRatea" runat="server" Text='<%# Eval("FuelRate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvFuelRatea" runat="server" CssClass="TextBox" MaxLength="10" Text='<%# Eval("FuelRate") %>'></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtgvFuelRatem0" runat="server" ControlToValidate="txtgvFuelRatea" Display="Dynamic" 
                                                                                        ErrorMessage="Please Enter Fuel Rate" SetFocusOnError="True" ValidationGroup="Update">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegulartxttxtgvFuelRatea" runat="server" ControlToValidate="txtgvFuelRatea" Display="Dynamic" 
                                                                                        ErrorMessage="Enter a valid Fuel Rate" SetFocusOnError="True" ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" ValidationGroup="Update">*</asp:RegularExpressionValidator>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            
                                                                            <asp:TemplateField HeaderText="Rate/Km">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblKmRatea" runat="server" Text='<%# Eval("KmRate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvKmRatea" runat="server" CssClass="TextBox" MaxLength="10" Text='<%# Eval("KmRate") %>'></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldtxtgvKmRatem0" runat="server" ControlToValidate="txtgvKmRatea" Display="Dynamic" 
                                                                                        ErrorMessage="Please Enter Rate" SetFocusOnError="True" ValidationGroup="Update">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegulartxttxtgvKmRatea" runat="server" ControlToValidate="txtgvKmRatea" Display="Dynamic" 
                                                                                        ErrorMessage="Enter a valid km Rate" SetFocusOnError="True" ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" ValidationGroup="Update">*</asp:RegularExpressionValidator>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="From Date">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDatea" runat="server" Text='<%# Eval("fromdate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="To Date">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbllastDatea" runat="server" Text='<%# Eval("Todate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="UpdatedBY" ItemStyle-Width="10%">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblUpdatedBY" runat="server" Text='<%# Eval("UpdatedBY") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <%--<EditItemTemplate>
                                                                                    <asp:TextBox ID="txtlastDate" runat="server" Text='<%# Eval("enddate") %>' MaxLength="15" CssClass="TextBox"></asp:TextBox>
                                                                                </EditItemTemplate>--%>
                                                                            </asp:TemplateField>
                                                                            <asp:CommandField CausesValidation="true" ShowEditButton="True" ValidationGroup="Update" />
                                                                            <asp:CommandField ShowDeleteButton="false" />
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
                                                                    <asp:LinkButton ID="lbtnAddNewa" runat="server" CausesValidation="False" OnClick="lbtnAddNewa_Click">Change Rate</asp:LinkButton>
                                                                     &nbsp;<asp:LinkButton ID="lbtnAdda" runat="server" CausesValidation="False" OnClick="lbtnAdda_Click">Add New Additional Cab Cost</asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        
                                                    </asp:View>
                                        <asp:View ID="ViewAdditional1" runat="server">

                                            <table align="center" width="1000px">
                                                <tr>
                                                    <td align="center">
                                                        <asp:DetailsView ID="dvAdditionalCost" runat="server" AutoGenerateRows="False" DataKeyNames="Id" DefaultMode="Insert" 
                                                            HeaderText="Additional Cab Cost Master" oniteminserting="dvAdditionalCost_ItemInserting" onmodechanging="dvAdditionalCost_ModeChanging" Width="35%">
                                                            <Fields>
                                                                <asp:TemplateField HeaderText="Effective Date">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtEffectiveDatea" runat="server" CssClass="TextBox" MaxLength="10" Text='<%# Eval("registrationDate","{0:d}") %>' 
                                                                            Width="60px"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtRegstrationDate_CalendarExtender1" runat="server" CssClass="cal_Theme1" Enabled="True" 
                                                                            TargetControlID="txtEffectiveDatea">
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RegularExpressionValidator ID="RegulapresionValdator8" runat="server" ControlToValidate="txtEffectiveDatea" Display="Dynamic" 
                                                                            ErrorMessage="Enter Valid Effective Date" 
                                                                            ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$" 
                                                                            ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Vendor">
                                                                    <InsertItemTemplate>
                                                                        <asp:DropDownList ID="ddlVendora" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                        </asp:DropDownList>
                                                                        <asp:CompareValidator ID="CompareValidatesd1" runat="server" ControlToValidate="ddlVendora" Display="Dynamic" ErrorMessage="Select Vendor" 
                                                                            Operator="NotEqual" ValidationGroup="add" ValueToCompare="-1">*</asp:CompareValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Vehicle Type">
                                                                    <InsertItemTemplate>
                                                                        <asp:DropDownList ID="ddlVehicleTypea" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                        </asp:DropDownList>
                                                                        <asp:CompareValidator ID="CompareValidat1" runat="server" ControlToValidate="ddlVehicleTypea" Display="Dynamic" 
                                                                            ErrorMessage="Select Vehicle" Operator="NotEqual" ValidationGroup="add" ValueToCompare="0">*</asp:CompareValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="KM">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtStartKma" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="ReqFieldtxtStartKm1" runat="server" ControlToValidate="txtStartKma" Display="Dynamic" 
                                                                            ErrorMessage="Enter KM" SetFocusOnError="True" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegularExpressiontxtStartKm1" runat="server" ControlToValidate="txtStartKma" Display="Dynamic" 
                                                                            ErrorMessage="Enter a valid Km" SetFocusOnError="True" ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Working Hour">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtWorkinghr" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="ReqFieldtxtEndKm1" runat="server" ControlToValidate="txtWorkinghr" Display="Dynamic" 
                                                                            ErrorMessage="Enter Working hr" SetFocusOnError="True" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegularExpressiontxtEndKm1" runat="server" ControlToValidate="txtWorkinghr" Display="Dynamic" 
                                                                            ErrorMessage="Enter a valid Working hr" SetFocusOnError="True" ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Fuel Rate">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtnewFuelRatea" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="ReqRateaFuel" runat="server" ControlToValidate="txtnewFuelRatea" Display="Dynamic" ErrorMessage="Enter Fuel Rate" 
                                                                            SetFocusOnError="True" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorFuel" runat="server" ControlToValidate="txtnewFuelRatea" Display="Dynamic" 
                                                                            ErrorMessage="Enter a valid Fuel Rate" SetFocusOnError="True" ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="KM Rate">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtnewRatea" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="ReqRatea" runat="server" ControlToValidate="txtnewRatea" Display="Dynamic" ErrorMessage="Enter Km Rate" 
                                                                            SetFocusOnError="True" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtnewRatea" Display="Dynamic" 
                                                                            ErrorMessage="Enter a valid Km Rate" SetFocusOnError="True" ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="All Facility" HeaderStyle-ForeColor="Red">
                                                                                <InsertItemTemplate>
                                                                                  <asp:CheckBox ID="chkAllfacility" runat="server" Text="Check if yes" Checked="false"/>

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
                                        </asp:MultiView>
                                                </td>
                                            </tr>
                                        </table>
                                    
                                </td>
                            </tr>
                            
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="LkbExportExl" />
            <asp:PostBackTrigger ControlID="LkbExportExl1" />
            <asp:PostBackTrigger ControlID="LkbExportExl2" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>


