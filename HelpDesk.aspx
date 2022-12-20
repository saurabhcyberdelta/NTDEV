<%@ Page Language="C#" MasterPageFile="~/Header.Master" AutoEventWireup="true" CodeFile="HelpDesk.aspx.cs"
    Inherits="HelpDesk" Title="Help Desk" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style7
        {
            border-left: thin solid #99C65B;
            border-right: thin solid #99C65B;
            border-top: thin none #99C65B;
            border-bottom: thin none #99C65B;
            width: 38%;
            height: 100%;
            padding: 20px;
            vertical-align: top;
            text-align: right;
        }
        .style8
        {
            border-left: thin solid #99C65B;
            border-right: thin solid #99C65B;
            border-top: thin none #99C65B;
            border-bottom: thin none #99C65B;
            width: 13%;
            height: 100%;
            padding: 20px;
            vertical-align: top;
            text-align: left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table align="center" border="0" width="100%">
                <tr align="center">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="SearchEmployee" />
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="SearchRoute" />
                    <asp:ValidationSummary ID="ValidationSummary3" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="SearchRouteID" />
                         <asp:ValidationSummary ID="ValidationSummary4" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="enterdelay" />
                    <td class="heading" colspan="2">
                        <div class="gradient2">
                            <h1>
                                <span></span>Transport HelpDesk / Tracking Module
                            </h1>
                            <h2>
                                Allows Helpdesk/Tracker to update employees PickUp/Drop Information.
                            </h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="3">
                        <table align="left" width="100%" class="tableBorber" border="0">
                            <tr>
                                <td align="left" class="TDbg" width="15%">
                                    Search BY
                                </td>
                                <td align="left" class="TDbg" width="15%">
                                    &nbsp;
                                </td>
                                <td align="left" class="TDbg">
                                    <asp:RadioButtonList ID="rbtnSearchType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rbtnSearchType_SelectedIndexChanged"
                                        RepeatDirection="Horizontal" Style="margin-left: 0px" Height="16px" Width="218px">
                                        <asp:ListItem Selected="True">Employee</asp:ListItem>
                                        <asp:ListItem>Route</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <asp:MultiView ID="MultiView1" runat="server">
                                        <asp:View ID="View1" runat="server">
                                            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch">
                                                <br />
                                                <table>
                                                    <tr>
                                                        <td align="left" valign="middle">
                                                            <b>Date:</b><asp:TextBox ID="txtStartDate0" runat="server" Style="margin-left: 4px"
                                                                CssClass="TextBox" MaxLength="12"></asp:TextBox><cc1:CalendarExtender ID="txtStartDate0_CalendarExtender"
                                                                    runat="server" Enabled="true" PopupButtonID="ibcal1" TargetControlID="txtStartDate0"
                                                                    Animated="True">
                                                                </cc1:CalendarExtender>
                                                            &nbsp;<asp:ImageButton ID="ibcal1" runat="server" Height="17px" ImageUrl="~/images/calendar_icon.gif" />
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtStartDate0"
                                                                Display="Dynamic" ErrorMessage="Please Enter Valid Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                ValidationGroup="SearchEmployee" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                        </td>
                                                        <td>
                                                            &nbsp; Enter Employee ID or Name:&nbsp;
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtEmpIdName" runat="server" CssClass="TextBox1" MaxLength="100"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmpIdName"
                                                                Display="Dynamic" ErrorMessage="Please Enter Name or Id" ValidationGroup="SearchEmployee"
                                                                SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" ValidationGroup="SearchEmployee"
                                                                Text="Search" CssClass="Button" />
                                                        </td>
                                                        <td>
                                                            <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0" DynamicLayout="False">
                                                                <ProgressTemplate>
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <img src="images/ajax-loader.gif" alt="Loding..." />
                                                                </ProgressTemplate>
                                                            </asp:UpdateProgress>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" colspan="5" valign="middle" class="heading">
                                                            <b>OR</b>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            Enter RouteID:
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtRouteID" runat="server" CssClass="TextBox1" MaxLength="100"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtRouteID"
                                                                Display="Dynamic" ErrorMessage="Please Enter RouteID" ValidationGroup="SearchRouteID"
                                                                SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnRouteSearch" runat="server" OnClick="btnRouteSearch_Click" ValidationGroup="SearchRouteID"
                                                                Text="Search Route" CssClass="Button" />
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                            </asp:Panel>
                                        </asp:View>
                                        <asp:View ID="View2" runat="server">
                                            <asp:Panel ID="Panel2" runat="server" Visible="true" DefaultButton="btnSearchRoute">
                                                <table width="80%">
                                                    <tr align="center">
                                                        <td align="left" valign="top" width="15%">
                                                            <b>Shift Date:</b>
                                                        </td>
                                                        <td align="left" valign="top" width="15%">
                                                            <b>Facility Name: </b>
                                                        </td>
                                                        <td align="left" rowspan="2" valign="middle" width="10%">
                                                            <asp:RadioButtonList ID="rdoTripType" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                                                                AutoPostBack="True" OnSelectedIndexChanged="rdoTripType_SelectedIndexChanged">
                                                                <asp:ListItem Selected="True" Value="P">Pick</asp:ListItem>
                                                                <asp:ListItem Value="D">Drop</asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                        <td align="left" valign="top" width="20%">
                                                            <b>Shift:</b><br />
                                                        </td>
                                                        <td align="left" rowspan="2" valign="middle" width="5%">
                                                            <asp:Button ID="btnSearchRoute" runat="server" Text="Submit" ValidationGroup="SearchRoute"
                                                                OnClick="btnSearchRoute_Click" CssClass="Button" />
                                                        </td>
                                                        <td align="left" rowspan="2" valign="middle" width="5%">
                                                            <asp:UpdateProgress ID="UpdateProgress2" runat="server" DisplayAfter="0" DynamicLayout="False">
                                                                <ProgressTemplate>
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <img src="images/ajax-loader.gif" alt="Loding..." />
                                                                </ProgressTemplate>
                                                            </asp:UpdateProgress>
                                                        </td>
                                                    </tr>
                                                    <tr align="center">
                                                        <td align="left" valign="top">
                                                            <asp:TextBox ID="txtStartDate" runat="server" CssClass="TextBox"></asp:TextBox>
                                                            <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" Enabled="true"
                                                                TargetControlID="txtStartDate" PopupButtonID="ibcal2">
                                                            </cc1:CalendarExtender>
                                                            &nbsp;<asp:ImageButton ID="ibcal2" runat="server" ImageUrl="~/images/calendar_icon.gif"
                                                                Height="17px" /><br />
                                                            <i>(mm/dd/yyyy)</i>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtStartDate"
                                                                Display="Dynamic" ErrorMessage="Enter Valid Shift Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                ValidationGroup="SearchRoute" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Shift Date"
                                                                ControlToValidate="txtStartDate" ValidationGroup="SearchRoute" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                        </td>
                                                        <td align="left" valign="top">
                                                            <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                OnSelectedIndexChanged="ddlFacility_SelectedIndexChanged" CssClass="DropDownListBox3">
                                                            </asp:DropDownList>
                                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                                                                Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="SearchRoute"
                                                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                        </td>
                                                        <td align="left" valign="top">
                                                            <asp:ListBox ID="lstShift" runat="server" AppendDataBoundItems="True">
                                                                <asp:ListItem Selected="True" Value="0"></asp:ListItem>
                                                            </asp:ListBox>
                                                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="lstShift"
                                                                ErrorMessage="Select Shift Time" Operator="NotEqual" ValidationGroup="SearchRoute"
                                                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </asp:View>
                                    </asp:MultiView>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="center">
                                    <asp:Label ID="lblMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:MultiView ID="MultiView2" runat="server">
                            <asp:View ID="View3" runat="server">
                                <table width="100%" align="center">
                                    <tr>
                                        <td align="center">
                                            <asp:GridView ID="grdSearchEmployee" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
                                                OnPageIndexChanging="grdSearchEmployee_PageIndexChanging" OnSelectedIndexChanging="grdSearchEmployee_SelectedIndexChanging"
                                                AllowPaging="True" CssClass="GridView" BorderWidth="0px" ShowFooter="True" Width="60%">
                                                <Columns>
                                                    <asp:CommandField ShowSelectButton="True" />
                                                    <asp:TemplateField HeaderText="Employee Id">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblEmpId" runat="server" Text='<%# Eval("empCode") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Employee Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblEmpName" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Process">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblEmpProcess" runat="server" Text='<%# Eval("processName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Facility">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblEmpFacility" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="E-mail">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblEmpEmail" runat="server" Text='<%# Eval("email") %>'></asp:Label>
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
                                </table>
                            </asp:View>
                        </asp:MultiView>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:MultiView ID="MultiView3" runat="server">
                            <asp:View ID="View4" runat="server">
                                <table width="90%" border="0" cellpadding="2" cellspacing="0" align="center">
                                    <tr>
                                        <td align="center">
                                            <table align="center" width="90%" cellpadding="4" cellspacing="0" class="myTable">
                                                <tr>
                                                    <td colspan="4" class="TDbg">
                                                        <asp:Label ID="lblempName" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="20%" class="myTableRowStyle">
                                                        EmployeeID :
                                                    </td>
                                                    <td width="40%" class="myTableRowStyle">
                                                        <asp:Label ID="lblEmpID" runat="server"></asp:Label>
                                                        &nbsp;
                                                    </td>
                                                    <td width="25%" class="myTableRowStyle">
                                                        Employee Name :
                                                    </td>
                                                    <td width="20%" class="myTableRowStyle">
                                                        <asp:Label ID="lblEmployeeName" runat="server"></asp:Label>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="myTableAltRowStyle" width="20%">
                                                        Department :
                                                    </td>
                                                    <td class="myTableAltRowStyle" width="40%">
                                                        <asp:Label ID="lblDepartment" runat="server"></asp:Label>
                                                    </td>
                                                    <td class="myTableAltRowStyle" width="25%">
                                                        Facility :
                                                    </td>
                                                    <td class="myTableAltRowStyle" width="20%">
                                                        <asp:Label ID="lblFacility" runat="server"></asp:Label>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="myTableRowStyle" width="20%">
                                                        Mobile Number :
                                                    </td>
                                                    <td class="myTableRowStyle" width="40%">
                                                        <asp:Label ID="lblMobile" runat="server"></asp:Label>
                                                    </td>
                                                    <td class="myTableRowStyle" width="25%">
                                                        Other Number :
                                                    </td>
                                                    <td class="myTableRowStyle" width="20%">
                                                        <asp:Label ID="lblPhone" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr class="myTableAltRowStyle">
                                                    <td class="myTableAltRowStyle" width="20%">
                                                        Address :
                                                    </td>
                                                    <td class="myTableAltRowStyle" width="40%">
                                                        <asp:Label ID="lblAddress" runat="server"></asp:Label>
                                                    </td>
                                                    <td class="myTableAltRowStyle" width="25%">
                                                        Location :
                                                    </td>
                                                    <td class="myTableAltRowStyle" width="20%">
                                                        <asp:Label ID="lblLocation" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="myTableRowStyle" width="20%">
                                                        Reporting Manager :
                                                    </td>
                                                    <td class="myTableRowStyle" width="40%">
                                                        <asp:Label ID="lblRepManager" runat="server"></asp:Label>
                                                    </td>
                                                    <td class="myTableRowStyle" width="25%">
                                                        Manager Mobile No. :
                                                    </td>
                                                    <td class="myTableRowStyle" width="20%">
                                                        <asp:Label ID="lblManagerNo" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="myTableAltRowStyle" width="20%">
                                                        Cost Center :
                                                    </td>
                                                    <td class="myTableAltRowStyle" width="40%">
                                                        <asp:Label ID="lblCostcenter" runat="server"></asp:Label>
                                                    </td>
                                                    <td class="myTableAltRowStyle" width="25%">
                                                        Division Manager :
                                                    </td>
                                                    <td class="myTableAltRowStyle" width="20%">
                                                        <asp:Label ID="lblDivisionManager" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="myTableRowStyle" width="20%">
                                                        IsGeoCoded :
                                                    </td>
                                                    <td class="myTableRowStyle" width="40%">
                                                        <asp:Image ID="imgIsGeoCoded" runat="server" />
                                                    </td>
                                                    <td class="myTableRowStyle" width="25%">
                                                        Transport Required :
                                                    </td>
                                                    <td class="myTableRowStyle" width="20%">
                                                        <asp:Image ID="imgIsTptReq" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <br />
                                            <asp:GridView ID="grdShowEmployeeDetail" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                Width="90%" OnRowCommand="grdShowEmployeeDetail_RowCommand" DataKeyNames="id,ShiftDate,empName"
                                                CssClass="GridView" BorderWidth="0px" ShowFooter="True">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="ShiftDate">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblShiftDate" runat="server" Text='<%# Eval("ShiftDate") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Shift Time">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbShifts" runat="server" Text='<%# Eval("Shifts") %>' CssClass="linkButton"
                                                                OnClick="lbShifts_Click"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="PickUp RouteID">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbpickRouteID" runat="server" Text='<%# Eval("pickRouteID") %>'
                                                                CssClass="linkButton" CommandName="ShowPickRoute" CommandArgument='<%# Container.DataItemIndex %>'><%# Eval("pickRouteID") %></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Peta" HeaderText="ETA"></asp:BoundField>
                                                    <asp:BoundField DataField="PickTrackingStatus" HeaderText="PickUp Tracking Status">
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Drop RouteID">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbdropRouteID" runat="server" Text='<%# Eval("dropRouteID") %>'
                                                                CssClass="linkButton" CommandName="ShowDropRoute" CommandArgument='<%# Container.DataItemIndex %>'><%# Eval("dropRouteID") %></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Deta" HeaderText="ETD"></asp:BoundField>
                                                    <asp:BoundField DataField="DropTrackingStatus" HeaderText="Drop Tracking Status">
                                                    </asp:BoundField>
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
                                    <tr align="center">
                                        <td>
                                            <asp:Button ID="Button1" runat="server" Style="display: none" />
                                            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                                TargetControlID="Button1" PopupControlID="Panel3" CancelControlID="btnClose">
                                            </cc1:ModalPopupExtender>
                                            <asp:Panel ID="Panel3" runat="server">
                                                <table width="300px" style="border: 1px ridge #000000" bgcolor="#FFFFCC">
                                                    <tr>
                                                        <td bgcolor="#0000CC" align="right">
                                                            <asp:ImageButton ID="btnClose" runat="server" ImageUrl="images/Exit.jpg" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:DetailsView ID="dvScheduleAuditTrail" runat="server" AutoGenerateRows="False"
                                                                HeaderText="Employee Schedule Audit Trail" Width="100%">
                                                                <RowStyle CssClass="DetailsViewRowStyle" />
                                                                <FooterStyle CssClass="DetailsViewFooterStyle" />
                                                                <PagerStyle CssClass="DetailsViewPagerStyle" />
                                                                <HeaderStyle CssClass="DetailsViewHeaderStyle" />
                                                                <AlternatingRowStyle CssClass="DetailsViewAltRowStyle" />
                                                                <Fields>
                                                                    <asp:BoundField DataField="empCode" HeaderText="Associate ID:" HeaderStyle-HorizontalAlign="Right">
                                                                        <HeaderStyle HorizontalAlign="Right" />
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="empName" HeaderText="Associate Name:" HeaderStyle-HorizontalAlign="Right">
                                                                        <HeaderStyle HorizontalAlign="Right" />
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="processName" HeaderText="Department:" HeaderStyle-HorizontalAlign="Right">
                                                                        <HeaderStyle HorizontalAlign="Right" />
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="startDate" HeaderText="Schedule Date:" HeaderStyle-HorizontalAlign="Right">
                                                                        <HeaderStyle HorizontalAlign="Right" />
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="updatedByName" HeaderText="Updated BY:" HeaderStyle-HorizontalAlign="Right">
                                                                        <HeaderStyle HorizontalAlign="Right" />
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="updationStime" HeaderText="Updated On:" HeaderStyle-HorizontalAlign="Right">
                                                                        <HeaderStyle HorizontalAlign="Right" />
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:BoundField>
                                                                </Fields>
                                                            </asp:DetailsView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="View5" runat="server">
                                <table width="100%" cellpadding="0" cellspacing="0">
                                    <tr style="background-image: url('images/Grid/row_selected.gif'); background-repeat: repeat-x">
                                        <td bgcolor="#CCCCFF" style="font-size: 15px" align="center" class="heading">
                                            <asp:Label ID="lblempName1" runat="server" Font-Bold="True" Font-Names="Verdana"
                                                Font-Size="Small" CssClass="ListBox"></asp:Label>
                                        </td>
                                        <td bgcolor="#CCCCFF" width="5%" align="right">
                                            <asp:ImageButton ID="btnClose0" runat="server" ImageUrl="images/Exit.jpg" OnClick="btnClose0_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            &nbsp;
                                        </td>
                                        <td align="right" width="5%">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="2">
                                            <asp:GridView ID="grdShowRouteDetail" AutoGenerateColumns="False" runat="server"
                                                DataKeyNames="routeid,id,shiftdate,tripType" ShowFooter="True" Width="100%" OnRowDataBound="grdShowRouteDetail_RowDataBound"
                                                OnRowCommand="grdShowRouteDetail_RowCommand" BorderWidth="0px" CssClass="table">
                                                <RowStyle BackColor="#E7E7FF" HorizontalAlign="Left" />
                                                <AlternatingRowStyle BackColor="#F7F7F7" BorderColor="Black" HorizontalAlign="Left" />
                                                <FooterStyle CssClass="FooterStyle" />
                                                <PagerStyle CssClass="PagerStyle" />
                                                <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                <HeaderStyle CssClass="HeaderStyle" />
                                                <EditRowStyle BackColor="#999999" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="SNo" SortExpression="stopNo">
                                                        <ItemTemplate>
                                                            <%# Eval("SNo")%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Employee Detail" SortExpression="empCode">
                                                        <ItemTemplate>
                                                            <div style="width: 150px;">
                                                                <%# Eval("empCode") %>
                                                                -
                                                                <%# Eval("EmpName") %>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="G" SortExpression="Gender">
                                                        <ItemTemplate>
                                                            <%# Eval("Gender") %>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Address" SortExpression="Address" ItemStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <%# Eval("Address") %>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblChildErrorMsg" runat="server" Font-Bold="True" Font-Size="Small"
                                                                ForeColor="Red"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Location">
                                                        <ItemTemplate>
                                                            <%# Eval("Location") %>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Mobile">
                                                        <ItemTemplate>
                                                            <%# Eval("EmpMobile") %>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Shift">
                                                        <ItemTemplate>
                                                            <%# Eval("Shift") %>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="">
                                                        <ItemTemplate>
                                                            <%# Eval("tripType") %>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="ETA/ETD" HeaderStyle-Width="40px">
                                                        <ItemTemplate>
                                                            <div style="width: 40px;">
                                                                <%# Eval("ETA")%>
                                                            </div>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="40px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Action">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlAction" runat="server" Width="75px" AppendDataBoundItems="True"
                                                                CssClass="DropDownListBox3">
                                                            </asp:DropDownList>
                                                            <asp:Label ID="ldlAction" runat="server" Visible="false"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Time">
                                                        <ItemTemplate>
                                                            <div style="width: 140px;">
                                                                <asp:TextBox ID="txtStartDate" runat="server" Text='<%# Eval("actEta")%>' MaxLength="10"
                                                                    CssClass="TextBox"></asp:TextBox>
                                                                <cc1:CalendarExtender ID="gridtxtStartDate_CalendarExtender" runat="server" Enabled="true"
                                                                    Format="MM/dd/yyyy" TargetControlID="txtStartDate">
                                                                </cc1:CalendarExtender>
                                                                <asp:TextBox ID="txtActETAhh" Text='<%# Eval("ActETAhh")%>' runat="server" Width="15px"
                                                                    MaxLength="2" TabIndex="2"></asp:TextBox>
                                                                <asp:TextBox ID="txtActETAmm" Text='<%# Eval("ActETAmm")%>' runat="server" Width="15px"
                                                                    MaxLength="2" TabIndex="2"></asp:TextBox>
                                                                <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="txtStartDate"
                                                                    Type="Date" ValidationGroup="Save" Display="Dynamic" SetFocusOnError="True">*
                                                                </asp:RangeValidator>
                                                                <asp:RangeValidator ID="RangeValidator1" runat="server" ValidationGroup="Save" ErrorMessage="Enter Valid Act ETA Hours"
                                                                    MaximumValue="23" MinimumValue="0" SetFocusOnError="True" ControlToValidate="txtActETAhh"
                                                                    Display="Dynamic">*</asp:RangeValidator>
                                                                <asp:RangeValidator ID="RangeValidator2" runat="server" ValidationGroup="Save" ErrorMessage="Enter Valid Act ETA Minuts"
                                                                    MaximumValue="59" Display="Dynamic" MinimumValue="0" SetFocusOnError="True" ControlToValidate="txtActETAmm">*</asp:RangeValidator>
                                                                <asp:Label ID="ldlActETA" runat="server" Visible="false"></asp:Label>
                                                            </div>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:LinkButton ID="lbCancelAction" runat="server" ToolTip="Cancel Action" Height="15px"
                                                                Width="20px" CommandName="CancelAction" ValidationGroup="Cancel" Text="Cancel"
                                                                Font-Bold="True" />
                                                        </FooterTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Remark">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtRemark" runat="server" Width="75px" MaxLength="100" Text='<%# Eval("trackingRemark")%>'
                                                                CssClass="TextBox1" TabIndex="0"></asp:TextBox>
                                                            <asp:Label ID="ldlRemark" runat="server" Visible="false" Text='<%# Eval("trackingRemark")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:LinkButton ID="lbSaveAction" runat="server" ToolTip="Save Action" Height="15px"
                                                                Width="20px" CommandName="SaveAction" ValidationGroup="Save" Text="Save" Font-Bold="True" />
                                                        </FooterTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="2">
                                            <br />
                                            <asp:DetailsView ID="DvShowRouteDetails" runat="server" AutoGenerateRows="False"
                                                Height="50px" Width="222px">
                                                <RowStyle CssClass="DetailsViewRowStyle" />
                                                <FooterStyle CssClass="DetailsViewFooterStyle" />
                                                <PagerStyle CssClass="DetailsViewPagerStyle" />
                                                <HeaderStyle CssClass="DetailsViewHeaderStyle" />
                                                <AlternatingRowStyle CssClass="DetailsViewAltRowStyle" />
                                                <Fields>
                                                    <asp:TemplateField HeaderText="Route ID :">
                                                        <ItemTemplate>
                                                            <%# Eval("RouteID")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" Font-Bold="True" Font-Size="Small" />
                                                        <ItemStyle HorizontalAlign="Left" Font-Size="Small" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Route # :">
                                                        <ItemTemplate>
                                                            <%# Eval("routeno")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" Font-Bold="True" Font-Size="Small" />
                                                        <ItemStyle HorizontalAlign="Left" Font-Size="Small" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Vendor :">
                                                        <ItemTemplate>
                                                            <%# Eval("VendorName")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" Font-Bold="True" Font-Size="Small" />
                                                        <ItemStyle HorizontalAlign="Left" Font-Size="Small" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="CabID :">
                                                        <ItemTemplate>
                                                            <%# Eval("vehicleId")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" Font-Bold="True" Font-Size="Small" />
                                                        <ItemStyle HorizontalAlign="Left" Font-Size="Small" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Right" HeaderText="Facility :">
                                                        <ItemTemplate>
                                                            <%# Eval("facility")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" Font-Bold="True" Font-Size="Small" />
                                                        <ItemStyle HorizontalAlign="Left" Font-Size="Small" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Right" HeaderText="Guard :">
                                                        <ItemTemplate>
                                                            <%# Eval("remark")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" Font-Bold="True" Font-Size="Small" />
                                                        <ItemStyle HorizontalAlign="Left" Font-Size="Small" />
                                                    </asp:TemplateField>
                                                </Fields>
                                            </asp:DetailsView>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                        </asp:MultiView>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:MultiView ID="MultiView4" runat="server">
                            <asp:View ID="View6" runat="server">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
                                    <tr>
                                        <td align="center">
                                            <asp:GridView ID="grdViewShowRoute" runat="server" AutoGenerateColumns="False" OnRowCommand="grdViewShowRoute_RowCommand"
                                                DataKeyNames="RouteID" Width="100%" AllowPaging="True" OnRowDataBound="grdViewShowRoute_RowDataBound"
                                                OnPageIndexChanging="grdViewShowRoute_PageIndexChanging" CssClass="Childgrid"
                                                ShowFooter="True" CellPadding="4">
                                                <RowStyle CssClass="TD_Tracking" />
                                                <AlternatingRowStyle CssClass="TD_Tracking" />
                                                <PagerStyle CssClass="PagerStyle" />
                                                <HeaderStyle CssClass="ChildgridHeaderStyle" />
                                                <FooterStyle CssClass="FooterStyle" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Route ID" SortExpression="RouteID">
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="ibViewRouteID" runat="server" ImageUrl="~/images/plus.gif" ToolTip="To Expand the Route Detail"
                                                                CommandName="ShowDetailRoute" CommandArgument='<%# Container.DataItemIndex %>' />
                                                            <asp:Label ID="lblRouteID" Text='<%# Eval("RouteID") %>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="shiftTime" HeaderText="Shift" ReadOnly="True" ItemStyle-Width="5%">
                                                        <ItemStyle Width="5%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                                        <ItemTemplate>
                                                            <%# Eval("Location")%></ItemTemplate>
                                                        <ItemStyle Width="40%" HorizontalAlign="left" />
                                                        <FooterTemplate>
                                                            <table bgcolor="Silver" bordercolor="Black" cellpadding="2" cellspacing="0" style="border: 1px solid #000000"
                                                                width="100%">
                                                                <tr>
                                                                    <td width="25%">
                                                                        Trip Not Started
                                                                    </td>
                                                                    <td bordercolor="Black">
                                                                        <asp:Label ID="Label1" runat="server" BackColor="Tomato" BorderColor="Black" BorderStyle="Solid"
                                                                            BorderWidth="1px" Height="10px" Width="10px"></asp:Label>
                                                                    </td>
                                                                    <td bordercolor="Black" width="5%">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td width="25%">
                                                                        Trip Started
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label3" runat="server" BackColor="Yellow" BorderColor="Black" BorderStyle="Solid"
                                                                            BorderWidth="1px" Height="10px" Width="10px"></asp:Label>
                                                                    </td>
                                                                    <td width="5%">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td width="25%">
                                                                        Trip Completed
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label4" runat="server" BackColor="Lime" BorderColor="Black" BorderStyle="Solid"
                                                                            BorderWidth="1px" Height="10px" Width="10px"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </FooterTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Vendor-CabID">
                                                        <ItemTemplate>
                                                            <%# Eval("vendorName") %>-<%# Eval("vehicleId") %>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Driver Info">
                                                        <ItemTemplate>
                                                            <%# Eval("DriverName") %>-<%# Eval("DriverContact") %>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="totalStop" HeaderText="Pax" ReadOnly="True" ItemStyle-Width="5%">
                                                        <ItemStyle Width="5%"></ItemStyle>
                                                    </asp:BoundField>
                                                   
                                                    <asp:BoundField DataField="sticker" HeaderText="Route#" ReadOnly="True" ItemStyle-Width="5%">
                                                        <ItemStyle Width="5%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td colspan="8" align="center">
                                                                    <asp:UpdatePanel ID="childPnl" runat="server" UpdateMode="Always">
                                                                        <ContentTemplate>
                                                                            <asp:GridView ID="grdViewRouteChild" BackColor="White" AutoGenerateColumns="False"
                                                                                runat="server" DataKeyNames="routeid,id,shiftdate,empCode" ShowFooter="True" CssClass="Childgrid"
                                                                                Visible="false" Width="95%" OnRowDataBound="grdViewRouteChild_RowDataBound" OnRowCommand="grdViewRouteChild_RowCommand">
                                                                                <RowStyle BackColor="#E7E7FF" HorizontalAlign="Left" />
                                                                                <AlternatingRowStyle BackColor="#F7F7F7" BorderColor="Black" HorizontalAlign="Left" />
                                                                                <PagerStyle BackColor="#E7E7FF" HorizontalAlign="Right" />
                                                                                <HeaderStyle CssClass="ChildgridHeaderStyle" />
                                                                                <FooterStyle CssClass="ChildgridFooterStyle" />
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="SNo" SortExpression="stopNo">
                                                                                        <ItemTemplate>
                                                                                            <%# Eval("SNo")%>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Employee Detail" SortExpression="empCode">
                                                                                        <ItemTemplate>
                                                                                            <div style="width: 150px;">
                                                                                                <%# Eval("empCode") %>
                                                                                                -
                                                                                                <%# Eval("EmpName") %>
                                                                                            </div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="G" SortExpression="Gender">
                                                                                        <ItemTemplate>
                                                                                            <%# Eval("Gender") %>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Address" SortExpression="Address" FooterStyle-ForeColor="White"
                                                                                        FooterStyle-Font-Bold="true">
                                                                                        <ItemTemplate>
                                                                                            <%# Eval("Address") %>
                                                                                        </ItemTemplate>
                                                                                        <FooterTemplate>
                                                                                            <table bgcolor="Silver" bordercolor="Black" cellpadding="2" cellspacing="0" style="border: 1px solid #000000"
                                                                                                width="100%">
                                                                                                <tr>
                                                                                                    <td width="25%">
                                                                                                        Boarded
                                                                                                    </td>
                                                                                                    <td bordercolor="Black">
                                                                                                        <asp:Label ID="Label1" runat="server" BackColor="PaleTurquoise" BorderColor="Black"
                                                                                                            BorderStyle="Solid" BorderWidth="1px" Height="10px" Width="10px"></asp:Label>
                                                                                                    </td>
                                                                                                    <td bordercolor="Black" width="5%">
                                                                                                        &nbsp;
                                                                                                    </td>
                                                                                                    <td width="25%">
                                                                                                        No-Show
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <asp:Label ID="Label3" runat="server" BackColor="Plum" BorderColor="Black" BorderStyle="Solid"
                                                                                                            BorderWidth="1px" Height="10px" Width="10px"></asp:Label>
                                                                                                    </td>
                                                                                                    <td width="5%">
                                                                                                        &nbsp;
                                                                                                    </td>
                                                                                                    <td width="25%">
                                                                                                        Cancelled
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <asp:Label ID="Label4" runat="server" BackColor="Crimson" BorderColor="Black" BorderStyle="Solid"
                                                                                                            BorderWidth="1px" Height="10px" Width="10px"></asp:Label>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </FooterTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Location">
                                                                                        <ItemTemplate>
                                                                                            <%# Eval("Location") %>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Mobile">
                                                                                        <ItemTemplate>
                                                                                            <%# Eval("EmpMobile") %>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Shift">
                                                                                        <ItemTemplate>
                                                                                            <%# Eval("Shift") %>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="">
                                                                                        <ItemTemplate>
                                                                                            <%# Eval("tripType") %>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="PickUp Time" SortExpression="ETA">
                                                                                        <ItemTemplate>
                                                                                            <div style="width: 40px;">
                                                                                                <%# Eval("ETA")%>
                                                                                            </div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Action">
                                                                                        <ItemTemplate>
                                                                                            <asp:DropDownList ID="ddlAction" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox2">
                                                                                            </asp:DropDownList>
                                                                                            <asp:Label ID="ldlAction" runat="server" Visible="false"></asp:Label>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Time">
                                                                                        <ItemTemplate>
                                                                                            <div style="width: 140px;">
                                                                                                <asp:TextBox ID="txtStartDate" runat="server" Style="margin-left: 4px" Text='<%# Eval("actEta")%>'
                                                                                                    MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                                <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" Enabled="True"
                                                                                                    TargetControlID="txtStartDate">
                                                                                                </cc1:CalendarExtender>
                                                                                                <asp:TextBox ID="txtActETAhh" Text='<%# Eval("ActETAhh")%>' runat="server" Width="15px"
                                                                                                    MaxLength="2" CssClass="TextBox1" TabIndex="2"></asp:TextBox>
                                                                                                <asp:TextBox ID="txtActETAmm" Text='<%# Eval("ActETAmm")%>' runat="server" Width="15px"
                                                                                                    MaxLength="2" CssClass="TextBox1" TabIndex="2"></asp:TextBox>
                                                                                                <asp:Label ID="ldlActETA" runat="server" Visible="false"></asp:Label>
                                                                                            </div>
                                                                                        </ItemTemplate>
                                                                                        <FooterTemplate>
                                                                                            <asp:LinkButton ID="lbCancelAction" runat="server" ToolTip="Cancel Action" Height="15px"
                                                                                                Width="20px" CommandName="CancelAction" ValidationGroup="Cancel" Text="Cancel"
                                                                                                Font-Bold="True" ForeColor="White" />
                                                                                        </FooterTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Remark">
                                                                                        <ItemTemplate>
                                                                                            <asp:TextBox ID="txtRemark" runat="server" Width="75px" MaxLength="100" Text='<%# Eval("trackingRemark")%>'></asp:TextBox>
                                                                                            <br />
                                                                                            <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Font-Size="Small" Visible="False"></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <FooterTemplate>
                                                                                            <asp:LinkButton ID="lbSaveAction" runat="server" ToolTip="Save Action" Height="15px"
                                                                                                Width="20px" CommandName="SaveAction" ValidationGroup="SaveAction" Text="Save"
                                                                                                Font-Bold="True" ForeColor="White" />
                                                                                        </FooterTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Delay">
                                                                                        <ItemTemplate>
                                                                                            <asp:RadioButton ID="rbtDelay" AutoPostBack="true" Checked='<%# Convert.ToString(Eval("trackingDelay"))=="Y"?true:false %>'
                                                                                                OnCheckedChanged="rbtDelay_CheckedChanged" runat="server" />
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle Width="5%"></ItemStyle>
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                        </ContentTemplate>
                                                                    </asp:UpdatePanel>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="1%"></ItemStyle>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                        </asp:MultiView>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:MultiView ID="MultiView5" runat="server">
                            <asp:View ID="View7" runat="server">
                                <asp:Button ID="Button2" runat="server" Text="Show Modal" Style="visibility: hidden" />
                                <cc1:ModalPopupExtender ID="ModalPopupExtender2" runat="server" BackgroundCssClass="modal-bg"
                                    TargetControlID="Button2" PopupControlID="pnlModal" CancelControlID="ibtnSMclose">
                                </cc1:ModalPopupExtender>
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td>
                                            <asp:Panel ID="pnlModal" runat="server" CssClass="modal" DefaultButton="btnSaveDelayReason">
                                                <table cellpadding="0" cellspacing="0" width="100%" align="center">
                                                    <tr>
                                                        <td class="blueHeaderMiddleLeft" width="1%">
                                                            &nbsp;
                                                        </td>
                                                        <td class="blueHeaderMiddleCenter" width="100%">
                                                            RouteID:-
                                                            <asp:Label ID="lblDelayRouteID" runat="server"></asp:Label>
                                                            PartnerID:-
                                                            <asp:Label ID="lblDelayEmpID" runat="server"></asp:Label>
                                                        </td>
                                                        <td class="blueHeaderMiddleCenter1">
                                                            <asp:ImageButton ID="ibtnSMclose" runat="server" ImageUrl="~/images/Window/CloseOut.gif"
                                                                CssClass="ButtonCloseOver" />
                                                        </td>
                                                        <td class="blueHeaderMiddleRight" width="1%">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6">
                                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                                <tr>
                                                                    <td class="style7">
                                                                        Enter the Delay Reason:
                                                                    </td>
                                                                    <td class="style8">
                                                                        <asp:DropDownList ID="ddlDelays" runat="server" AppendDataBoundItems="true">
                                                                        </asp:DropDownList>
                                                                          <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="ddlDelays"
                                                                Display="Dynamic" ErrorMessage="Select Delay" Operator="NotEqual" ValidationGroup="enterdelay"
                                                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                                    </td>
                                                                    <td class="style8">
                                                                        <asp:TextBox ID="txtDelayReason" runat="server" MaxLength="40" CssClass="TextBox1"></asp:TextBox>
                                                                   <br />
                                                                   <asp:Button ID="btnSaveDelayReason" runat="server" Text="Save" OnClick="btnSaveDelayReason_Click"
                                                                            CssClass="Button" ValidationGroup="enterdelay" />
                                                                    </td>
                                                                   
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4">
                                                            <table width="100%" cellpadding="0" cellspacing="0" class="footerInnserTable">
                                                                <tr>
                                                                    <td class="blueFooterMiddleCenter">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                        </asp:MultiView>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
