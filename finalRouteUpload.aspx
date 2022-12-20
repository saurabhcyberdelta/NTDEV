<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="finalRouteUpload.aspx.cs" Inherits="finalRouteUpload" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <link href="StyleSheets/SoftGreyGridView.css" rel="stylesheet" type="text/css" />
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" width="100%">
        <tr>
            <td align="center">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="Upload" />
            </td>
        </tr>
        <tr>
            <td class="heading">
                Final Upload Routes
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Label ID="Label2" runat="server" Font-Bold="False" Font-Overline="False" Text="Allows to upload routes (.XLS) file only."
                    CssClass="subHeading"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="Left">
                <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center">
            </td>
        </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table align="center" width="50%" style="border: 1px ridge #AAC5E8;" bgcolor="#AAC5E8">
                <tr>
                    <td bgcolor="#CBDBEF" align="center" class="style1">
                        Upload Routes (.XLS) File
                    </td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#EEF2FC">
                        Select Facility:
                        <asp:DropDownList ID="DlFac" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#EEF2FC" valign="middle">
                        <div style="padding: 2px; vertical-align: middle; text-align: center;" class="style3">
                            Upload a File:
                            <asp:FileUpload ID="FileUpload1" runat="server" BorderColor="Silver" BorderStyle="Ridge"
                                CssClass="Button" />
                            <br />
                            <br />
                            <asp:Button ID="btnUpload" runat="server" OnClick="btnUpload_Click" Text="Upload File"
                                CssClass="Button" ValidationGroup="Upload" />
                            <br />
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage=".XLS file is required!"
                                ControlToValidate="FileUpload1" Display="Dynamic" ValidationGroup="Upload"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Only XLS files are allowed!"
                                ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.xls|.XLS)$"
                                ControlToValidate="FileUpload1" Display="Dynamic" ValidationGroup="Upload"></asp:RegularExpressionValidator>
                        </div>
                    </td>
                </tr>
            </table>
            <table align="center" width="70%">
                <tr>
                    <td align="center">
                        <div id="modal" align="center">
                            <asp:Panel ID="Panel1" runat="server" Visible="true">
                                <table align="center" width="100%" style="border: 1px ridge #AAC5E8;" bgcolor="#CBDBEF">
                                    <tr>
                                        <td>
                                            &nbsp;&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="lblSearch" runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Red"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Panel ID="Panel2" runat="server" ScrollBars="Vertical">
                                                <asp:GridView ID="grdShowDetails" runat="server" CellPadding="4" ForeColor="#333333"
                                                    GridLines="None" CssClass="GridView" BorderColor="Black" BorderStyle="Ridge"
                                                    BorderWidth="1px">
                                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                    <EditRowStyle BackColor="#999999" />
                                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                </asp:GridView>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                                                DisplayAfter="0" DynamicLayout="False">
                                                <ProgressTemplate>
                                                    <table align="center">
                                                        <tr>
                                                            <td>
                                                                <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loading..." />
                                                            </td>
                                                            <td class="main_bg" bgcolor="White">
                                                                Loading.....Please Wait!!!
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnUpload" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
