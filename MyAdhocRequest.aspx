<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="MyAdhocRequest.aspx.cs" Inherits="MyAdhocRequest" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td>
                        <table width="90%">
                            <tr>
                                <td align="left">
                                    &nbsp;&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Label ID="Label1" runat="server" CssClass="heading" Font-Bold="True" Font-Overline="False"
                                Text="Adhoc Request Status"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Label ID="Label2" runat="server" Font-Bold="False" Font-Overline="False" Text="Allows Employee/Manager to View/Edit Schedule Details "
                                CssClass="subHeading"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Label ID="lblErrorMsg" runat="server" CssClass="error"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0" 
                                AssociatedUpdatePanelID="UpdatePanel1">
                                        <ProgressTemplate>
                                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" 
                                        alt="Loding..." /> Loading.....Please Wait!!!
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%" align="center">
                            <tr>
                                <td align="right" valign="middle" width="40%">
                                    <strong>From Date:</strong> </td>
                                <td align="left" valign="middle" width="40%">
                                    <asp:TextBox ID="txtDateFrom" runat="server" 
                                        CausesValidation="True" CssClass="TextBox" ValidationGroup="Submit"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBtnCalendar" runat="server" Height="17px" 
                                        ImageUrl="Images/calendar_icon.gif" Width="17px" />
                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Animated="False" 
                                        PopupButtonID="ImgBtnCalendar" TargetControlID="txtDateFrom" />
                                    &nbsp;<i>(mm/dd/yyyy)</i>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                        ControlToValidate="txtDateFrom" Display="Dynamic" 
                                        ErrorMessage="Enter Date Format:mm/dd/yyyy" SetFocusOnError="True" 
                                        ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$" 
                                        ValidationGroup="Submit">*</asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                        ControlToValidate="txtDateFrom" ErrorMessage="Please Enter From Date" 
                                        SetFocusOnError="True" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                                </td>
                                <td align="right" valign="middle" width="20%">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td align="right" valign="middle" width="40%">
                                    <strong>To Date:</strong> </td>
                                <td align="left" valign="middle" width="40%">
                                    <asp:TextBox ID="txtDateTo" runat="server" 
                                        CausesValidation="True" CssClass="TextBox" ValidationGroup="Submit"></asp:TextBox>
                                    <cc1:CalendarExtender ID="txtCalendar0_CalendarExtender" runat="server" 
                                        Animated="False" PopupButtonID="ImgBtnDateTo" 
                                        TargetControlID="txtDateTo" />
                                    <asp:ImageButton ID="ImgBtnDateTo" runat="server" Height="17px" 
                                        ImageUrl="Images/calendar_icon.gif" Width="17px" />
                                    &nbsp;<i>(mm/dd/yyyy)</i>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                                        ControlToValidate="txtDateTo" Display="Dynamic" 
                                        ErrorMessage="Enter Date Format:mm/dd/yyyy" SetFocusOnError="True" 
                                        ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$" 
                                        ValidationGroup="Submit">*</asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                        ControlToValidate="txtDateTo" ErrorMessage="Please Enter From Date" 
                                        SetFocusOnError="True" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                                </td>
                                <td align="right" valign="middle" width="20%">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td align="right" valign="middle" width="40%">
                                    &nbsp;</td>
                                <td align="left" valign="middle" width="40%">
                                    <asp:Button ID="btnSubmit" runat="server" CssClass="Button" 
                                        onclick="btnSubmit_Click" Text="Submit" ValidationGroup="Submit"/>
                                </td>
                                <td align="right" valign="middle" width="20%">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <asp:Label ID="lblIsBlocked" runat="server" Font-Bold="True" ForeColor="Red" 
                                        Visible="False"></asp:Label>
                                </td>
                                <td style="text-align: right; font-weight: 700;" align="right">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="3">
                                    <asp:GridView ID="GVAdhoc" runat="server" AutoGenerateColumns="False" 
                                        CssClass="GridView" DataKeyNames="Id" Width="700px" EmptyDataText="No Request Found For Selected Date">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Shift Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDate" runat="server" 
                                                        Text='<%# Eval("AdhocDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Shift">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblShift" runat="server" 
                                                        Text='<%# Eval("ShiftTime") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Trip Type">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAction" runat="server" 
                                                        Text='<%# Eval("TripType") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="FacilityID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFacility" runat="server" 
                                                        Text='<%# Eval("facilityName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblStatus" runat="server" 
                                                        Text='<%# Eval("Status") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Approved By">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblApproved" runat="server" 
                                                        Text='<%# Eval("AprovedBy") %>'></asp:Label>
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
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    
</asp:Content>

