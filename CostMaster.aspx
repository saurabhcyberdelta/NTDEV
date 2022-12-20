<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="CostMaster.aspx.cs" Inherits="CostMaster" %>
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
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="Update" />
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
                                <span></span>Cost Master
                            </h1>
                            <h2>
                                Allows User to View/Edit and Add New Km Cost.
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
                        <table align="center" width="100%">
                            <tr>
                                <td align="center">
                                    <asp:MultiView ID="mvCost" runat="server" ActiveViewIndex="0">
                                        <table align="center" width="100%">
                                            <tr>
                                                <td>
                                                    <asp:View ID="View1" runat="server">
                                                        <table align="center" width="65%">
                                                            <tr>
                                                                <td align="center">
                                                                    &nbsp;<asp:GridView ID="gvCost" runat="server" AllowSorting="True"
                                                                        AutoGenerateColumns="False" CssClass="GridView" ShowFooter="True" 
                                                                        Width="100%" onrowcancelingedit="gvCost_RowCancelingEdit" 
                                                                        onrowediting="gvCost_RowEditing" onrowupdating="gvCost_RowUpdating" DataKeyNames="id" AllowPaging="True" OnPageIndexChanging="gvCost_PageIndexChanging" PageSize="20">
                                                                        <Columns>
                                                                             <asp:TemplateField HeaderText="Vendor">
                                                                              <ItemTemplate>
                                                                                    <asp:Label ID="lblVendor" runat="server" Text='<%# Eval("vendorName") %>'></asp:Label>
                                                                             </ItemTemplate>
                                                                                 <EditItemTemplate>
                                                                                     <asp:DropDownList ID="ddlgvVendor" runat="server" AppendDataBoundItems="true" Enabled="false">
                                                                                     </asp:DropDownList>
                                                                                 </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Vehicle Type">
                                                                              <ItemTemplate>
                                                                                    <asp:Label ID="lblVehicle" runat="server" Text='<%# Eval("vehicle") %>'></asp:Label>
                                                                             </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:DropDownList ID="ddlgvVehicle" runat="server" AppendDataBoundItems="true" Enabled="false">
                                                                                    </asp:DropDownList>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Current Fuel Rate">
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
                                                                          </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Rate/Km">                                                                               
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblKmRate" runat="server" Text='<%# Eval("KmRate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtgvKmRate" runat="server" Text='<%# Eval("KmRate") %>' MaxLength="7" CssClass="TextBox"></asp:TextBox>
                                                                                
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
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="To Date">                                                                                
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lbllastDate" runat="server" Text='<%# Eval("enddate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>                                                                            
                                                                             <asp:CommandField ShowEditButton="True" ValidationGroup="Update" CausesValidation="true" />                                                                            
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
                                                                        DefaultMode="Insert" HeaderText="Change Rate"  Width="35%" 
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
                                                                            <asp:TemplateField HeaderText="New Fuel Rate">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtnewRate" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoY" runat="server" ControlToValidate="txtnewRate"
                                                                                        Display="Dynamic" ErrorMessage="Enter New Fuel Rate" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtnewRate"
                                                                                        ValidationGroup="add" ErrorMessage="Enter a valid New Fuel Rate" Display="Dynamic"
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
                                                                        DefaultMode="Insert" HeaderText="Add New Cost"  Width="35%" 
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
                                                                                    <asp:TextBox ID="txtnewfuelRate01" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoY02" runat="server" ControlToValidate="txtnewfuelRate01"
                                                                                        Display="Dynamic" ErrorMessage="Enter Rate" ValidationGroup="New" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4011" runat="server" ControlToValidate="txtnewfuelRate01"
                                                                                        ValidationGroup="New" ErrorMessage="Enter a valid  Rate" Display="Dynamic"
                                                                                        ValidationExpression="[-]?[0-9]*[.]{0,1}[0-9]{0,4}" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                           
                                                                            <asp:TemplateField HeaderText="Rate">
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


