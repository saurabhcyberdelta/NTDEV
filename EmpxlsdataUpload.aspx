<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="EmpxlsdataUpload.aspx.cs" Inherits="EmpxlsdataUpload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div align="center">
        <table>
            <tr>
                <td colspan="2">
                    <div class="gradient2">
                        <h1>
                            <span></span>Import Employee Data from Excel
                        </h1>
                        <h2>
                            Allows User to Import employee data from excel.
                        </h2>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    Select file
                </td>
                <td>
                    <asp:FileUpload ID="FilexlsUpload" runat="server" />
                    <asp:Button ID="cmdUploadxlsdata" runat="server" Text="Import Data" OnClick="cmdUploadxlsdata_Click"
                        CssClass="Button" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblerrmsg" CssClass="11t" runat="server" Text="" ForeColor="Red"></asp:Label>
                </td>
            </tr>
        </table>
        <table style="width: 100%">
            <tr>
                <td>
                    <div style="overflow: auto; width: 750px; height: 370px">
                        <asp:GridView ID="grdxlsdata" runat="server" CssClass="grid">
                            <RowStyle CssClass="RowStyle" />
                            <FooterStyle CssClass="FooterStyle" />
                            <PagerStyle CssClass="PagerStyle" />
                            <SelectedRowStyle CssClass="SelectedRowStyle" />
                            <HeaderStyle CssClass="HeaderStyle" />
                            <EditRowStyle BackColor="#999999" />
                            <AlternatingRowStyle CssClass="AltRowStyle" />
                        </asp:GridView>
                    </div>
                </td>
            </tr>
        </table>
        <table style="width: 100%">
            <tr>
                <td>
                    <asp:Button ID="cmdUpdateEmployee" runat="server" Text="Update Employee Data" 
                        OnClick="cmdUpdateEmployee_Click" CssClass="Button" Width="170px" />
                </td>
            </tr>
            <tr>
                <td class="11t">
                    1. <a class="11t" href="samplexls/TMSDataFeedsample.xls" target="_new">Download</a>
                    sample xls file for uploading employee data to TMS Data server, Data should be in
                    same format.<br />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
