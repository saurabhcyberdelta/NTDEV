<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="TollMaster.aspx.cs" Inherits="TollMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="StyleSheets/TMS.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/GridView.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <table width="100%" align="center">
                <tr>
                    <td align="center">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="save" />
                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="edit" />
                        <asp:ValidationSummary ID="ValidationSummary3" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="change" />
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                <td align="center">
                        <div>
                           
                                <strong>Toll Master </strong>
                         <br />
                                Allows User to View/Edit and Add New Toll.
                           
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
                                                                    <asp:GridView ID="grdToll" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                        CssClass="GridView" DataKeyNames="id" ShowFooter="True" Width="800px">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Toll Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblTollName" runat="server" Text='<%# Eval("tollname") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Toll Cost">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblTollCost" runat="server" Text='<%# Eval("tollcost") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>                                                                            
                                                                            <asp:TemplateField HeaderText="Facility Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFacility" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="From Date">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblFrom" runat="server" Text='<%# Eval("From_Date") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="To Date">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblTo" runat="server" Text='<%# Eval("ToDate") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="UpdatedBy">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblUpdatedBy" runat="server" Text='<%# Eval("UpdatedBy") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Action" Visible="false">
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="lbActivate" runat="server" 
                                                                                        Visible='<%# getVisibleactivated(DataBinder.Eval(Container.DataItem, "activated")) %>' 
                                                                                        onclick="lbActivate_Click">Activate</asp:LinkButton>
                                                                                     <asp:LinkButton ID="lbDeactivate" runat="server" Visible='<%# getVisibledeactivated(DataBinder.Eval(Container.DataItem, "activated")) %>'
                                                                                         OnClick="lbDeactivate_Click">Deactivate</asp:LinkButton>
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
                                                                    <asp:LinkButton ID="btnTollChange" runat="server" onclick="btnTollChange_Click" Visible="false">Change Toll Rate</asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center">
                                                                    <asp:LinkButton ID="lbtnAddToll" runat="server" onclick="lbtnAddToll_Click">Add New & Change Toll Rate</asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:View>
                                                    <asp:View ID="View2" runat="server">
                                                        <asp:DetailsView ID="dvToll" runat="server" AutoGenerateRows="False" DefaultMode="Insert"
                                                             HeaderText="Add New/Change Toll Rate" Width="328px" CellPadding="4" 
                                                            CssClass="DetailsView" oniteminserting="dvToll_ItemInserting" 
                                                            onmodechanging="dvToll_ModeChanging">
                                                            <Fields>
                                                                <asp:TemplateField HeaderText="Facility Name :">
                                                                    <InsertItemTemplate>
                                                                        <asp:DropDownList ID="ddldvFacilityAdd" runat="server" AppendDataBoundItems="true">
                                                                        </asp:DropDownList>
                                                                        <asp:CompareValidator ID="CompareValidator3" runat="server" ErrorMessage="Select Facility"
                                                                            ControlToValidate="ddldvFacilityAdd" Operator="NotEqual" ValueToCompare="0" ValidationGroup="add">*</asp:CompareValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Efective Date :">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvEffectiveDate" runat="server" Text='<%# Eval("registrationDate","{0:d}") %>'
                                                                            Width="60px" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtRegstrationDate_CalendarExtender1" runat="server" Enabled="True"
                                                                            TargetControlID="txtdvEffectiveDate" >
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RequiredFieldValidator ID="rvEffectiveDate1" runat="server" ControlToValidate="txtdvEffectiveDate"
                                                                            Display="Dynamic" ErrorMessage="Enter date" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegulapresionValdator6" runat="server" ControlToValidate="txtdvEffectiveDate"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid Effective Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Toll Name :">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvTollName" runat="server" MaxLength="20" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="rfvTollName" runat="server" ControlToValidate="txtdvTollName"
                                                                            ErrorMessage="Please Enter the Toll Name" SetFocusOnError="true" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                
                                                                <asp:TemplateField HeaderText="Toll Cost:">
                                                                   
                                                                    <InsertItemTemplate>
                                                                       <asp:TextBox ID="txtdvTollCost" runat="server" MaxLength="20" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="rfvTollCost" runat="server" ControlToValidate="txtdvTollCost"
                                                                            ErrorMessage="Please Enter the Toll cost" SetFocusOnError="true" ValidationGroup="save">*</asp:RequiredFieldValidator>
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
                                                    
                                                    <asp:View ID="View3" runat="server">
                                                        <asp:DetailsView ID="dvTollChange" runat="server" AutoGenerateRows="False" DefaultMode="Insert"
                                                            HeaderText="Change Toll Rate" Width="328px" CellPadding="4" CssClass="DetailsView">
                                                            <Fields>
                                                                <asp:TemplateField HeaderText="Facility Name :">
                                                                    <InsertItemTemplate>
                                                                        <asp:DropDownList ID="ddldvFacilityChange" runat="server" AppendDataBoundItems="true">
                                                                        </asp:DropDownList>
                                                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Select Facility"
                                                                            ControlToValidate="ddldvFacilityChange" Operator="NotEqual" ValueToCompare="0" ValidationGroup="change">*</asp:CompareValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Efective Date :">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtEffectiveDate" runat="server" Text='<%# Eval("registrationDate","{0:d}") %>'
                                                                            Width="60px" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                        <cc1:calendarextender id="txtRegstrationDate_CalendarExtender" runat="server" enabled="True"
                                                                            targetcontrolid="txtEffectiveDate" >
                                                                        </cc1:calendarextender>
                                                                        <asp:RequiredFieldValidator ID="rvEffectiveDate" runat="server" ControlToValidate="txtEffectiveDate"
                                                                            Display="Dynamic" ErrorMessage="Enter date" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegulapresionValdator6" runat="server" ControlToValidate="txtEffectiveDate"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid Effective Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Toll Name :">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtchTollName" runat="server" MaxLength="20" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="rfvTollName1" runat="server" ControlToValidate="txtchTollName"
                                                                            ErrorMessage="Please Enter the Toll Name" SetFocusOnError="true" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Toll Cost:">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtTochllCost" runat="server" MaxLength="20" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="rfvTollCost1" runat="server" ControlToValidate="txtTochllCost"
                                                                            ErrorMessage="Please Enter the Toll cost" SetFocusOnError="true" ValidationGroup="save">*</asp:RequiredFieldValidator>
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

