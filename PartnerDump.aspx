<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="PartnerDump.aspx.cs" Inherits="PartnerDump" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center">
        <tr>
            <td>
                <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>&nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td class="heading">
                <div class="gradient2">
                    <h1>
                        <span></span>Export Partner Dump
                    </h1>
                    <h2></h2>
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
                                    <td colspan="2" align="center">
                                        <asp:DropDownList ID="ddlfacility" runat="server" AppendDataBoundItems="True" AutoPostBack="False"
                                            CssClass="DropDownListBox3">
                                           
                                        </asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td align="center">&nbsp;</td>

                                    <asp:RadioButtonList ID="rdbemp" runat="server" AutoPostBack="False" RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True" Value="0">All</asp:ListItem>
                                        <asp:ListItem Value="1">Active</asp:ListItem>
                                        <asp:ListItem Value="2">Attrited</asp:ListItem>
                                    </asp:RadioButtonList>
                        </td>
                        <td></td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        
                        <td align="center" colspan="2">
                            <asp:Button ID="BtnSubmit" runat="server" OnClick="BtnSubmit_Click" Text="Export Partner Dump"
                                CssClass="Button" />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td align="center"></td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center">&nbsp;
                            <asp:GridView ID="grdSitefile" runat="server">
                            </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        </table>
            </td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
    </table>
</asp:Content>

