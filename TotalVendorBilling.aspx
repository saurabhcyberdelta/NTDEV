<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="TotalVendorBilling.aspx.cs" Inherits="TotalVendorBilling" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table align="center" border="0" width="100%">
        <tr>
            <td align="center">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="Submit" Height="16px" />
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Label ID="lblErrorMsg" runat="server" CssClass="error"></asp:Label>
                &nbsp;
            </td>
        </tr>
        <tr align="center">
            <td align="center">
              <div class="gradient2">
                                        <h1>
                                            Total Vendor Billing Report.
                                        </h1>
                                        <h2>
                                               Allows to Generate Total Vendor Billing Report.
                                        </h2>
                                    </div>
            
     
            </td>
   
        </tr>
        <tr>
            <td>
                <br />
                <table border="0" cellpadding="4" cellspacing="0" align="center" width="50%" class="tableBorber">
                    <tr>
                        <td align="center" class="TDbg" colspan="4">
                            Fill The Selection Criteria
                            <asp:Label ID="lblFacError" runat="server" CssClass="error" Text="Select Facility"
                                Visible="False"></asp:Label>
                            &nbsp; &nbsp; &nbsp;
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="left" valign="top">
                            <b>Month</b>
                        </td>
                        <td align="left" valign="top">
                            <b>Year</b>&nbsp;
                        </td>
                        <%--<td align="left" valign="top">
                            <b>Facility Name: </b>
                        </td>--%>
                        <td align="left" rowspan="2" valign="middle">
                            <asp:Button ID="btnSubmit" runat="server" Text="Run Report" ValidationGroup="Submit"
                                OnClick="btnSubmit_Click" CssClass="Button" />
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="left" valign="top">
                            <asp:DropDownList ID="ddlMonth" runat="server">
                           </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="ddlMonth"
                                Display="Dynamic" ErrorMessage="Select Month" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                </td>
                        <td align="left" valign="top">
                            <asp:DropDownList ID="ddlYear" runat="server">
                           </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="ddlYear"
                                Display="Dynamic" ErrorMessage="Select Month" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                              </td>
                        <%--<td align="left" valign="top">
                            <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                                Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                        </td>--%>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table align="center" width="100%">
                    <tr>
                        <td align="center">
                            <asp:LinkButton ID="LkbExportExl" runat="server" OnClick="LkbExportExl_Click">Export to Excel</asp:LinkButton>
                        <asp:GridView ID="grdFinalBilling" runat="server" Width="90%" CssClass="grid" AutoGenerateColumns="false">
                            <Columns>
                            <asp:BoundField DataField="VendorName" HeaderText="Vendor Name" ItemStyle-Width="20" />
                                <asp:BoundField DataField="Ecospace_Cost" HeaderText="Ecospace Cost" ItemStyle-Width="30" />
                                <asp:BoundField DataField="Manyata_Cost" HeaderText="Manyata Cost" ItemStyle-Width="30" />
                                <asp:BoundField DataField="GVT_Cost" HeaderText="GVT Cost" ItemStyle-Width="30"/>
                                <asp:BoundField DataField="TotalCost" HeaderText="Total Cost" ItemStyle-Width="30" ItemStyle-Font-Bold="true" ItemStyle-ForeColor="Green" ItemStyle-BackColor="Gray"/>
                            </Columns>
                            <RowStyle CssClass="RowStyle" />
                            <FooterStyle CssClass="FooterStyle" />
                            <PagerStyle CssClass="PagerStyle" />
                            <SelectedRowStyle CssClass="SelectedRowStyle" />
                            <HeaderStyle CssClass="HeaderStyle" />
                            <EditRowStyle BackColor="#999999" />
                            <AlternatingRowStyle CssClass="AltRowStyle" />
                        </asp:GridView>
                            
                        <asp:Button ID="BtnLock" runat="server" Visible="false" Text="Lock Cost" ValidationGroup="Lock" CssClass="Button" OnClick="BtnLock_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

