<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="ScheduleUpload.aspx.cs" Inherits="ScheduleUpload" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="StyleSheets/GridView.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/TMS.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
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
                <div class="gradient2">
                    <h1>
                        <span></span>Schedule Upload
                    </h1>
                    <h2>
                        Allows to upload schedule Excel File only.
                    </h2>
                </div>
            </td>
        </tr>
        <tr>
            <td align="left">
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Red"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table align="center" width="50%" style="border: 1px ridge #AAC5E8;" bgcolor="#AAC5E8">
                <tr>
                    <td bgcolor="#CBDBEF" align="center" class="style1">
                        Upload Schedule (.CSV) File
                    </td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#EEF2FC" valign="middle">
                        <div style="padding: 2px; vertical-align: middle; text-align: center;">
                            Upload a File:
                            <asp:FileUpload ID="FileUpload1" runat="server" CssClass="Button" />&nbsp;
                            <asp:Button ID="btnVerify" runat="server" OnClick="btnVerify_Click" Text="Verify File"
                                CssClass="Button" ValidationGroup="Upload" />
                            <br />
                            <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Green"></asp:Label>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage=".CSV file is required!"
                                ControlToValidate="FileUpload1" Display="Dynamic" ValidationGroup="Upload"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Only CSV Files are allowed!"
                                ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(.csv|.CSV)$"
                                ControlToValidate="FileUpload1" Display="Dynamic" ValidationGroup="Upload"></asp:RegularExpressionValidator>
                        </div>
                    </td>
                </tr>
            </table>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                DisplayAfter="0">
                <ProgressTemplate>
                    <table align="center">
                        <tr>
                            <td align="center">
                                <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" />
                            </td>
                            <td>
                                Please Wait!!!
                            </td>
                        </tr>
                    </table>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:MultiView ID="MultiView1" runat="server">
                <asp:View ID="View1" runat="server">
                    <table style="border: 1px solid #000000; width: 100%" align="center">
                        <tr>
                            <td align="center">
                                <asp:Button ID="btnExportToExcel" runat="server" OnClick="btnExportToExcel_Click"
                                    Text="Export To Excel" CssClass="Button" />
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <div style="border: 1px solid #000000; overflow: auto; width: 900px; height: 300px"
                                    align="center">
                                    <asp:GridView ID="grdxlsdata" runat="server" OnRowDataBound="grdxlsdata_RowDataBound"
                                        CellPadding="4" ForeColor="#333333" GridLines="None" Font-Size="8pt" BorderWidth="0px"
                                        BorderColor="Black" BorderStyle="Solid">
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <EditRowStyle BackColor="#999999" />
                                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="View2" runat="server">
                    <table style="border: 1px solid #000000; width: 100%" align="center">
                        <tr>
                            <td align="center">
                                <asp:Button ID="btnExportToExcelFinal" runat="server" OnClick="btnExportToExcelFinal_Click"
                                    Text="Export To Excel" CssClass="Button" />
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <div style="border: 1px solid #000000; overflow: auto; width: 900px; height: 300px"
                                    align="center">
                                    <asp:GridView ID="grdFinalOutPut" runat="server" CellPadding="4" ForeColor="#333333"
                                        GridLines="None" Font-Size="8pt">
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <EditRowStyle BackColor="#999999" />
                                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>
                    </table>
                </asp:View>
            </asp:MultiView>
            <table style="width: 100%">
                <tr>
                    <td align="center">
                        <asp:Button ID="btnUploadSchedule" runat="server" Text="Update Roster Data" OnClick="btnUploadSchedule_Click"
                            CssClass="Button" Enabled="False" />
                    </td>
                </tr>
                <tr>
                    <td>
                        1. <a href="CSVFile/SampleFile.csv">Download</a> sample csv file for uploading 
                        Roster data to TMS Data server, Data should be in same format.<br />
                        &nbsp;
                    </td>
                </tr>
            </table>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnVerify" />
            <asp:PostBackTrigger ControlID="btnExportToExcel" />
            <asp:PostBackTrigger ControlID="btnExportToExcelFinal" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
