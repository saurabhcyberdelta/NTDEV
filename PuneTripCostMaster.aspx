<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="PuneTripCostMaster.aspx.cs" Inherits="PuneTripCostMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
                                Pune Trip Cost Master
                            </h1>
                            <h2>
                                Allows User to View/Edit and Add New Trip Cost for Pune.
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
                       <asp:DropDownList ID="ddlSelectFacility" runat="server" AutoPostBack="True" 
                                                onselectedindexchanged="ddlSelectFacility_SelectedIndexChanged">
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
                                                                    &nbsp;<asp:GridView ID="gvCost" runat="server" AllowSorting="True" DataKeyNames="id"
                                                                        AutoGenerateColumns="False" CssClass="GridView" ShowFooter="True" OnRowDeleting="gvCost_RowDeleting" EnableModelValidation="True">
                                                                       <Columns>
                                                                             <asp:TemplateField HeaderText="Vendor">
                                                                              <ItemTemplate>
                                                                                    <asp:Label ID="lblVendor" runat="server" Text='<%# Eval("vendorName") %>'></asp:Label>
                                                                             </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vehicle Type">
                                                                              <ItemTemplate>
                                                                                    <asp:Label ID="lblVehicle" runat="server" Text='<%# Eval("vehicle") %>'></asp:Label>
                                                                             </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                           <asp:TemplateField HeaderText="Fuel Rate">
                                                                               
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFuelRate" runat="server" Text='<%# Eval("FuelRate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Non-AC Rate">
                                                                               
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblKmRate" runat="server" Text='<%# Eval("TripRate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="AC Rate">
                                                                               
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblAcRate" runat="server" Text='<%# Eval("ACTripRate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                          
                                                                          <asp:TemplateField HeaderText="From Date">
                                                                                
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDate" runat="server" Text='<%# Eval("Date") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="To Date">
                                                                                
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbllastDate" runat="server" Text='<%# Eval("enddate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            
                                                                             <asp:CommandField ShowDeleteButton="True" />
                                                                            
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
                                                                    <asp:LinkButton ID="lbtnAddNew" runat="server" CausesValidation="False" OnClick="lbtnAddNew_Click">Change Rate</asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center">
                                                                      <asp:LinkButton ID="lbtnAdd" runat="server" CausesValidation="False" 
                                                                          onclick="lbtnAdd_Click">Add New Vendor Cost</asp:LinkButton>
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
                                                                        DefaultMode="Insert" HeaderText="Change Rate"  Width="100%" 
                                                                        oniteminserting="dvCost_ItemInserting" 
                                                                        onmodechanging="dvCost_ModeChanging">
                                                                        <Fields>
                                                                            <asp:TemplateField HeaderText="Effective Date">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtEffectiveDate" runat="server" Text='<%# Eval("registrationDate","{0:d}") %>'
                                                                            Width="60px" MaxLength="10" CssClass="TextBox"></asp:TextBox>
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
                                                                            CssClass="DropDownListBox3">
                                                                                         </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidatesd" runat="server" ControlToValidate="ddlVendor"
                                                                                   Display="Dynamic" ErrorMessage="Select Vendor" Operator="NotEqual" ValidationGroup="add"
                                                                                   ValueToCompare="0">*</asp:CompareValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vehicle Type">
                                                                                <InsertItemTemplate>
                                                                                     <asp:DropDownList ID="ddlVehicleType" runat="server" AppendDataBoundItems="True"
                                                                            CssClass="DropDownListBox3">
                                                                                         </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidat" runat="server" ControlToValidate="ddlVehicleType"
                                                                                   Display="Dynamic" ErrorMessage="Select Vehicle" Operator="NotEqual" ValidationGroup="add"
                                                                                   ValueToCompare="0">*</asp:CompareValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Fuel Cost">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtFuelRate" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoY2" runat="server" ControlToValidate="txtFuelRate"
                                                                                        Display="Dynamic" ErrorMessage="Enter Fuel Rate" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator42" runat="server" ControlToValidate="txtFuelRate"
                                                                                        ValidationGroup="add" ErrorMessage="Enter a valid Fuel Rate" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="New Non-AC Cost">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtnewRate" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoY" runat="server" ControlToValidate="txtnewRate"
                                                                                        Display="Dynamic" ErrorMessage="Enter New Non-AC Fuel Rate" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtnewRate"
                                                                                        ValidationGroup="add" ErrorMessage="Enter a valid New Non-AC Fuel Rate" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                           
                                                                            <asp:TemplateField HeaderText="New AC Cost">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtnewacRate" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeo1Y" runat="server" ControlToValidate="txtnewacRate"
                                                                                        Display="Dynamic" ErrorMessage="Enter New AC Fuel Rate" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator14" runat="server" ControlToValidate="txtnewacRate"
                                                                                        ValidationGroup="add" ErrorMessage="Enter a valid New AC Fuel Rate" Display="Dynamic"
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
                                                                        DefaultMode="Insert" HeaderText="Add New Cost"  Width="100%" 
                                                                        oniteminserting="dvAddnewvendor_ItemInserting" 
                                                                        onmodechanging="dvAddnewvendor_ModeChanging" >
                                                                     
                                                                        <Fields>
                                                                            <asp:TemplateField HeaderText="Effective Date">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtDVEffectiveDate" runat="server" Text='<%# Eval("registrationDate","{0:d}") %>'
                                                                            Width="60px" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtRegstrationDate_CalendarExtender10" runat="server" Enabled="True" CssClass="cal_Theme1"
                                                                            TargetControlID="txtDVEffectiveDate">
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RegularExpressionValidator ID="RegulapresionValdator601" runat="server" ControlToValidate="txtDVEffectiveDate"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid Effective Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="New">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vendor">
                                                                                <InsertItemTemplate>
                                                                                     <asp:DropDownList ID="ddlVendor01" runat="server" AppendDataBoundItems="True"
                                                                            CssClass="DropDownListBox3">
                                                                                         </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidatesd01" runat="server" ControlToValidate="ddlVendor01"
                                                                                   Display="Dynamic" ErrorMessage="Select Vendor" Operator="NotEqual" ValidationGroup="New"
                                                                                   ValueToCompare="0">*</asp:CompareValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vehicle Type">
                                                                                <InsertItemTemplate>
                                                                                     <asp:DropDownList ID="ddlVehicleType01" runat="server" AppendDataBoundItems="True"
                                                                            CssClass="DropDownListBox3">
                                                                                         </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidat01" runat="server" ControlToValidate="ddlVehicleType01"
                                                                                   Display="Dynamic" ErrorMessage="Select Vehicle" Operator="NotEqual" ValidationGroup="New"
                                                                                   ValueToCompare="0">*</asp:CompareValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                              
                                                                            <asp:TemplateField HeaderText="Fuel Rate">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtFuelRate01" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoY0111" runat="server" ControlToValidate="txtFuelRate01"
                                                                                        Display="Dynamic" ErrorMessage="Enter Fuel Rate" ValidationGroup="New" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator40102" runat="server" ControlToValidate="txtFuelRate01"
                                                                                        ValidationGroup="New" ErrorMessage="Enter a valid Fuel Rate" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                           
                                                                            <asp:TemplateField HeaderText="Non-AC Trip Rate">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtnewRate01" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoY01" runat="server" ControlToValidate="txtnewRate01"
                                                                                        Display="Dynamic" ErrorMessage="Enter Rate" ValidationGroup="New" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4010" runat="server" ControlToValidate="txtnewRate01"
                                                                                        ValidationGroup="New" ErrorMessage="Enter a valid  Rate" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                           
                                                                            <asp:TemplateField HeaderText="AC Trip Rate">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtnewacRate01" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoY101" runat="server" ControlToValidate="txtnewacRate01"
                                                                                        Display="Dynamic" ErrorMessage="Enter AC Rate" ValidationGroup="New" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator40110" runat="server" ControlToValidate="txtnewacRate01"
                                                                                        ValidationGroup="New" ErrorMessage="Enter a valid  Rate" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                           

                                                                            <asp:CommandField ShowEditButton="True" ValidationGroup="New" />
                                                                            <asp:CommandField ShowInsertButton="True" ValidationGroup="New" />
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



