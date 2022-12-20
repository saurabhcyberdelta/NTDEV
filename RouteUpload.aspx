<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="RouteUpload.aspx.cs" Inherits="RouteUpload" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
</asp:Content><asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" width="100%">
        <tr>
            <td align="center" colspan="2">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="Upload" />
            </td>
        </tr>
        <tr>
            <td class="heading" colspan="2">
                <div class="gradient2">
                    <h1>
                        <span></span>Upload Routes
                    </h1>
                    <h2>
                        Allows to upload routes (.mdb) file only.
                    </h2>
                </div>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td align="right">
                <b>Facility Name: </b>
            </td>
            <td align="left">
                <asp:DropDownList ID="ddlFacility" runat="server" CssClass="DropDownListBox3" ToolTip="Select Facility">
                </asp:DropDownList>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                    Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Upload"
                    ValueToCompare="0">*</asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                &nbsp;
            </td>
            <td align="left">
                &nbsp;
            </td>
        </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table align="center" width="50%" cellpadding="2" cellspacing="0" class="tableBorber">
                <tr>
                    <td bgcolor="#CBDBEF" align="center" class="TDbg">
                        Upload Routes (.MDB) File
                    </td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#EEF2FC" valign="middle">
                        <div>
                            Upload a File:
                            <asp:FileUpload ID="FileUpload1" runat="server" BorderColor="Silver" BorderStyle="Ridge" />
                            <br />
                            <br />
                            <asp:Button ID="btnUpload" runat="server" OnClick="btnUpload_Click" Text="Upload File"
                                CssClass="Button" ValidationGroup="Upload" />
                            <br />
                            <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Green"></asp:Label>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage=".MDB file is required!"
                                ControlToValidate="FileUpload1" Display="Dynamic" ValidationGroup="Upload"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Only MDB files are allowed!"
                                ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.mdb|.MDB)$"
                                ControlToValidate="FileUpload1" Display="Dynamic" ValidationGroup="Upload"></asp:RegularExpressionValidator>
                        </div>
                    </td>
                </tr>
            </table>
            <table align="center" width="70%">
                <tr>
                    <td align="center">
                        <div id="modal" align="center">
                            <asp:Panel ID="Panel1" runat="server" Visible="False">
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
                                            <asp:Panel ID="Panel2" runat="server" Height="200px" ScrollBars="Vertical">
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
