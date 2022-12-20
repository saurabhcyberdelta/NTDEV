<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="SiteFile.aspx.cs" Inherits="SiteFile" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

    
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="left">
        <tr>
            <td>
                <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td class="heading">
                <div class="gradient2">
                    <h1>
                        <span></span>Export Information to Site File
                    </h1>
                    <h2>
                        Export Information to Route Pro Site File in Route Planning Format.
                    </h2>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <table class="style1" align="center">
                    <tr>
                        <td>
                            <table border="0" cellpadding="0" cellspacing="4" align="center">
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    Date:
                                     <asp:TextBox ID="txtCalendar" runat="server" 
                                                CssClass="TextBox" CausesValidation="True" ValidationGroup="Submit"></asp:TextBox>
                                            <asp:ImageButton ID="ImgBtnCalendar" runat="server" ImageUrl="Images/calendar_icon.gif"
                                                Height="17px" Width="17px" />
                                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Animated="False" TargetControlID="txtCalendar"
                                                PopupButtonID="ImgBtnCalendar" />
                                            &nbsp;<i>(mm/dd/yyyy)</i>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtCalendar"
                                                Display="Dynamic" ErrorMessage="Enter Date Format:mm/dd/yyyy" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                ValidationGroup="Submit" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter From Date"
                                                ControlToValidate="txtCalendar" ValidationGroup="Submit" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                      
                                    </td>
                                    <td>
                                        <asp:Button ID="BtnSubmit" runat="server" OnClick="BtnSubmit_Click" Text="Generate Site File"
                                            CssClass="Button" ValidationGroup="Submit" />
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            &nbsp;
                            <asp:GridView ID="grdSitefile" runat="server">
                            </asp:GridView>
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
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
