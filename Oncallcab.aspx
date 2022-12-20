<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="Oncallcab.aspx.cs" Inherits="Oncallcab" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                ShowSummary="False" ValidationGroup="add" />
            <table width="60%">
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td class="heading" style="width: 99%">
                                    <div class="gradient2">
                                        <h1>
                                            <span></span>On Call Cab Tracker
                                        </h1>
                                        <h2>
                                            Allows to View/Edit and Add On Call Cab Request.</h2>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%">
                            <tr>
                                <td>
                                    <table width="50%">
                                        <tr>
                                            <td valign="middle" align="left">
                                                <table width="100%" class="table">
                                                    <tr>
                                                        <td align="center" class="row1">
                                                            <b>Facility</b>
                                                        </td>
                                                        <td align="center" class="row1">
                                                            <b>Vendor</b>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:DropDownList ID="ddlSelectFacility" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSelectFacility_SelectedIndexChanged"
                                                                AppendDataBoundItems="True">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td align="center">
                                                            <asp:DropDownList ID="ddlSelectVendor" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSelectVendor_SelectedIndexChanged"
                                                                AppendDataBoundItems="True">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                       
                                        <tr>
                                            <td align="center">
                                                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                                                    DisplayAfter="0">
                                                    <ProgressTemplate>
                                                        <table align="center" align="center">
                                                            <tr>
                                                                <td align="center">
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
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:MultiView ID="MultiView1" runat="server">
                                        <asp:View ID="View1" runat="server">
                                            <table align="center" width="100%">
                                                <tr>
                                                    <td align="center">
                                                        <asp:GridView ID="GVDriverMaster" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                            DataKeyNames="ID" OnPageIndexChanging="GVDriverMaster_PageIndexChanging" PageSize="20"
                                                            CssClass="GridView" BorderWidth="0px" EmptyDataText="No record found" ShowFooter="True" Width="1200px" OnRowDataBound="GVDriverMaster_RowDataBound">
                                                            <RowStyle CssClass="RowStyle" />
                                                            <FooterStyle CssClass="FooterStyle" />
                                                            <PagerStyle CssClass="PagerStyle" />
                                                            <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                            <HeaderStyle BackColor="#004f75" ForeColor="White" Font-Bold="true" />
                                                            <EditRowStyle BackColor="#999999" />
                                                            <AlternatingRowStyle CssClass="AltRowStyle" />
                                                            <EmptyDataRowStyle ForeColor="Red" Font-Bold="true" HorizontalAlign="Left" />
                                                            <Columns>
                                                                <asp:BoundField DataField="vehicleNo" HeaderText="CabID" />
                                                                <asp:BoundField DataField="DriverName" HeaderText="Driver Name" />
                                                                <asp:BoundField DataField="DateOfJoining" HeaderText="Date Of Joining" />
                                                                <asp:BoundField DataField="BadgeNo" HeaderText="BadgeNo" />
                                                                <asp:BoundField DataField="BadgeIssueDate" HeaderText="Badge Issue Date" />
                                                                <asp:BoundField DataField="BadgeExpiryDate" HeaderText="Badge Expiry Date" />
                                                                <asp:BoundField DataField="LicenseNumber" HeaderText="License Number" />
                                                                <asp:BoundField DataField="LicenseIssuedDate" HeaderText="License Issued Date" />
                                                                <asp:BoundField DataField="LicenseExpiryDate" HeaderText="License Expiry Date" />
                                                                <asp:BoundField DataField="TotalExperience" HeaderText="Total Experience" />
                                                                <asp:BoundField DataField="AreaofResidence" HeaderText="Area Of Residence" />
                                                                <asp:BoundField DataField="Contact1" HeaderText="Contact1" />
                                                                <asp:BoundField DataField="Contact2" HeaderText="Contact2" />
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <asp:LinkButton ID="lbtnAddNew" runat="server" OnClick="lbtnAddNew_Click">Add New On Call Cab Request</asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                        <asp:View ID="View2" runat="server">
                                            <table align="center">
                                                <tr>
                                                    <td align="center">
                                                        <asp:DetailsView ID="DvDriver" runat="server" AutoGenerateRows="False" DefaultMode="Insert"
                                                            HeaderText="Add New On Call Cab Request" Height="50px" OnItemInserting="DvVehicle_ItemInserting"
                                                            OnModeChanging="DvVehicle_ModeChanging" Width="100%">
                                                            <Fields>
                                                                <asp:TemplateField HeaderText="Facility">
                                                                    <InsertItemTemplate>
                                                                        <asp:DropDownList ID="ddldvFacility" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3"
                                                                            AutoPostBack="false">
                                                                        </asp:DropDownList>
                                                                        <asp:CompareValidator ID="CompareVa" runat="server" ControlToValidate="ddldvFacility"
                                                                            Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="add"
                                                                            ValueToCompare="0" SetFocusOnError="true">*</asp:CompareValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Reason">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtReason" MaxLength=300 TextMode="MultiLine" runat="server"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldReson" runat="server" ControlToValidate="txtReason"
                                                                            Display="Dynamic" ErrorMessage="Enter Reason" ValidationGroup="add" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                                                    
                                                                         <asp:RegularExpressionValidator ID="regtxtReason" runat="server" ControlToValidate="txtReason"
                                                                            Display="Dynamic" ErrorMessage="Reason Should be Alphanumeric." ValidationExpression="^([\w\-]|\s)*$"
                                                                            ValidationGroup="add" Text="*" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Cab Count">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtCabCount" runat="server" MaxLength="50" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldCabCount2" runat="server" ControlToValidate="txtCabCount"
                                                                            Display="Dynamic" ErrorMessage="Enter Cab Count" ValidationGroup="add" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegCabCount" runat="server" ControlToValidate="txtCabCount"
                                                                            Display="Dynamic" ErrorMessage="Cab Count Should be Numberic." ValidationExpression="^([\w\-]|\s)*$"
                                                                            ValidationGroup="add" Text="*" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Date Of Request">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtDateOfReq" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtDateOfJoining_CalendarExtender" runat="server" Enabled="True"
                                                                            TargetControlID="txtDateOfReq" CssClass="cal_Theme1">
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDateOfReq"
                                                                            Display="Dynamic" ErrorMessage="Enter Date Of Request" ValidationGroup="add"
                                                                            SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegularExpressionVidator6" runat="server" ControlToValidate="txtDateOfReq"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid Date Of Request" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="add" SetFocusOnError="true">*</asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Cost Center">
                                                                    <InsertItemTemplate>
                                                                      <asp:DropDownList ID="ddlCostCenter" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3"
                                                                            AutoPostBack="false">
                                                                        </asp:DropDownList>
                                                                        <asp:CompareValidator ID="CompareVaCostCenter" runat="server" ControlToValidate="ddlCostCenter"
                                                                            Display="Dynamic" ErrorMessage="Select Cost Center" Operator="NotEqual" ValidationGroup="add"
                                                                            ValueToCompare="0" SetFocusOnError="true">*</asp:CompareValidator> 
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Status">
                                                                    <InsertItemTemplate>
                                                                         <asp:DropDownList ID="ddlStatus" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3"
                                                                            AutoPostBack="false">
                                                                            <asp:ListItem Text="Pending" Value="P"></asp:ListItem>
                                                                            <asp:ListItem Text="Approved" Value="A"></asp:ListItem>
                                                                            <asp:ListItem Text="Rejected" Value="R"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Remarks">
                                                                    <InsertItemTemplate>
                                                                      <asp:TextBox ID="txtRemarks" MaxLength=300 TextMode="MultiLine" runat="server"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldRemarks" runat="server" ControlToValidate="txtRemarks"
                                                                            Display="Dynamic" ErrorMessage="Enter Remarks" ValidationGroup="add" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                                                    
                                                                         <asp:RegularExpressionValidator ID="regtxtRemarks" runat="server" ControlToValidate="txtRemarks"
                                                                            Display="Dynamic" ErrorMessage="Remarks Should be Alphanumeric." ValidationExpression="^([\w\-]|\s)*$"
                                                                            ValidationGroup="add" Text="*" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                                                   
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Request By:">
                                                                    <InsertItemTemplate>
                                                                         <asp:DropDownList ID="ddlReqby" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3"
                                                                            AutoPostBack="false">
                                                                        </asp:DropDownList>
                                                                        <asp:CompareValidator ID="CompareVaReqby" runat="server" ControlToValidate="ddlReqby"
                                                                            Display="Dynamic" ErrorMessage="Select Request By" Operator="NotEqual" ValidationGroup="add"
                                                                            ValueToCompare="0" SetFocusOnError="true">*</asp:CompareValidator> 
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                              
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
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


