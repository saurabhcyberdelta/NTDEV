<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="AdhocChange.aspx.cs" Inherits="AdhocChange" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
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
                    <td class="heading">
                        Manager Change Adhoc
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="center" class="subHeading">
                        Allows to Change An Adhoc Request
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:GridView ID="GVAdhocChange" runat="server" AutoGenerateColumns="False" Width="700px"
                            DataKeyNames="id" AllowPaging="True" OnPageIndexChanging="GVAdhocChange_PageIndexChanging"
                            OnSelectedIndexChanging="GVAdhocChange_SelectedIndexChanging">
                            <Columns>
                                <asp:TemplateField HeaderText="Partner Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmpName" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Shift Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblShiftDate" runat="server" Text='<%# Eval("AdhocDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Shif Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblShift" runat="server" Text='<%# Eval("ShiftTime") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Trip Type">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTripType" runat="server" Text='<%# Eval("TripType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Facility">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFacility" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Raised By">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRaised" runat="server" Text='<%# Eval("RaisedBy") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:TemplateField HeaderText="Action">
                          <ItemTemplate>
                              <asp:LinkButton ID="lkbUpdate" runat="server" onclick="lkbUpdate_Click">Update</asp:LinkButton>
                          </ItemTemplate>
                      </asp:TemplateField>--%>
                                <asp:CommandField HeaderText="Action" SelectText="Update" ShowSelectButton="True" />
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
                <tr>
                    <td align="center">
                        <asp:Panel ID="Panel1" runat="server" BackColor="Wheat">
                            <table>
                                <tr>
                                    <td align="right" bgcolor="blue" valign="bottom">
                                        <asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/images/no_icon.jpg" OnClick="btnClose_Click" />
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td align="center" valign="top">
                                        <asp:DetailsView ID="dvShowDetail" runat="server" DataKeyNames="id" HeaderText="Update Status"
                                            AutoGenerateRows="False">
                                            <Fields>
                                                <asp:TemplateField HeaderText="PartnerName">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEmpName" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Adhoc Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAdhocDate" runat="server" Text='<%# Eval("AdhocDate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ShiftTime">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblShiftTime" runat="server" Text='<%# Eval("ShiftTime") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlStatus" runat="server">
                                                            <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>
                                                            <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="Button" OnClick="btnUpdate_Click" />
                                                    </ItemTemplate>
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
                        </asp:Panel>
                        <asp:Button ID="Button2" runat="server" Style="visibility: hidden" />
                        <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                            TargetControlID="Button2" PopupControlID="Panel1" DropShadow="false">
                        </cc1:ModalPopupExtender>
                        <asp:Button ID="Button3" runat="server" Style="visibility: hidden" />
                        <cc1:ModalPopupExtender ID="Button3_ModalPopupExtender" runat="server" BackgroundCssClass="modalBackground"
                            DropShadow="false" Enabled="True" PopupControlID="Panel1" TargetControlID="Button3">
                        </cc1:ModalPopupExtender>
                    </td>
                </tr>
                <tr align="center">
                    <td align="right" colspan="3">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                            DisplayAfter="0">
                            <ProgressTemplate>
                                <table align="center" style="width: 400px">
                                    <tr>
                                        <td colspan="4" style="width: 200px">
                                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loding..." />
                                        </td>
                                        <td class="main_bg" style="width: 200px" align="left">
                                            Loading.....Please Wait!!!
                                        </td>
                                    </tr>
                                </table>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
