<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="AdminAdhoc.aspx.cs" Inherits="AdminAdhoc" %>

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
                        Admin Adhoc
                        <br />
                    </td>
                </tr>
                <tr>
                    <td align="center" class="subHeading">
                        Allows to Update An Adhoc request
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                        <table border="0" cellpadding="4" cellspacing="0" align="left" width="100%" class="tableBorber">
                            <tr>
                                <td align="center" class="TDbg" colspan="5">
                                    Fill The Selection Criteria
                                    <asp:Label ID="lblFacError" runat="server" CssClass="error" Text="Select Facility"
                                        Visible="False"></asp:Label>
                                    &nbsp; &nbsp; &nbsp;
                                </td>
                            </tr>
                            <tr align="center">
                                <td align="left" valign="top">
                                    <b>Date:</b>
                                </td>
                                <td align="left" valign="top">
                                    <b>Facility Name: </b>
                                </td>
                                <td align="left" valign="top">
                                    <b>Trip Type</b>
                                </td>
                                <td align="left" valign="top">
                                    <b>Shift</b>
                                </td>
                                <td align="left" rowspan="2" valign="middle">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="Button" OnClick="btnSubmit_Click"
                                        ValidationGroup="Submit" />
                                </td>
                            </tr>
                            <tr align="center">
                                <td align="left" valign="top">
                                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="TextBox"></asp:TextBox>
                                    <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" Enabled="true"
                                        TargetControlID="txtStartDate" PopupButtonID="ibcal1">
                                    </cc1:CalendarExtender>
                                    &nbsp;<asp:ImageButton ID="ibcal1" runat="server" ImageUrl="~/images/calendar_icon.gif"
                                        Height="17px" /><br />
                                    <i>(mm/dd/yyyy)</i>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtStartDate"
                                        Display="Dynamic" ErrorMessage="Enter Valid Start Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                        ValidationGroup="Submit">*</asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Start Date"
                                        ControlToValidate="txtStartDate" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                                </td>
                                <td align="left" valign="top">
                                    <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3"
                                        AutoPostBack="True" OnSelectedIndexChanged="ddlFacility_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlFacility"
                                        Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                                        ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                </td>
                                <td align="left" valign="top">
                                    <asp:DropDownList ID="ddlTripType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlTripType_SelectedIndexChanged">
                                        <asp:ListItem Value="P">Pick</asp:ListItem>
                                        <asp:ListItem Value="D">Drop</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td align="left" valign="top">
                                    <asp:DropDownList ID="ddlShift" runat="server" AppendDataBoundItems="True">
                                        <asp:ListItem Selected="True" Value="0">Select</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlShift"
                                        Display="Dynamic" ErrorMessage="Select Shift Time" Operator="NotEqual" ValidationGroup="Submit"
                                        ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <cc1:TabContainer ID="AJX" runat="server" Visible="false">
                            <cc1:TabPanel ID="TabPanel1" runat="server" HeaderText="Pending">
                                <HeaderTemplate>
                                    Pending</HeaderTemplate>
                                <ContentTemplate>
                                    <asp:GridView ID="GrdEmployeePending" runat="server" AutoGenerateColumns="False"
                                        Width="100%" DataKeyNames="id" EmptyDataText="No Records Found">
                                        <AlternatingRowStyle CssClass="AltRowStyle" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="PartnerName">
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "empName")%></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ShiftTime">
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "ShiftTime")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Facility">
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "FacilityID")%></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "Status")%></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Raised By">
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "ManagerName") %></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbtnUpdate" Text="Update" runat="server" OnClick="lbtnUpdate_Click1"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <EditRowStyle BackColor="#999999" />
                                        <FooterStyle CssClass="FooterStyle" />
                                        <HeaderStyle CssClass="HeaderStyle" />
                                        <PagerStyle CssClass="PagerStyle" />
                                        <RowStyle CssClass="RowStyle" />
                                        <SelectedRowStyle CssClass="SelectedRowStyle" />
                                    </asp:GridView>
                                </ContentTemplate>
                            </cc1:TabPanel>
                            <cc1:TabPanel ID="TabPanel2" runat="server" HeaderText="Approved">
                                <ContentTemplate>
                                    <asp:GridView ID="GrdEmployeeAccepted" runat="server" AutoGenerateColumns="false"
                                        Width="100%" EmptyDataText="No Records Found">
                                        <Columns>
                                            <asp:TemplateField HeaderText="PartnerName">
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "empName")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ShiftTime">
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "ShiftTime")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Facility">
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "FacilityID")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "Status")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Raised By">
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "ManagerName") %>
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
                                </ContentTemplate>
                            </cc1:TabPanel>
                            <cc1:TabPanel ID="TabPanel3" runat="server" HeaderText="Rejected">
                                <ContentTemplate>
                                    <asp:GridView ID="GrdEmployeeRejected" runat="server" AutoGenerateColumns="false"
                                        Width="100%" EmptyDataText="No Records Found">
                                        <Columns>
                                            <asp:TemplateField HeaderText="PartnerName">
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "empName")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ShiftTime">
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "ShiftTime")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Facility">
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "FacilityID")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "Status")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Raised By">
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "ManagerName") %>
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
                                </ContentTemplate>
                            </cc1:TabPanel>
                        </cc1:TabContainer>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="Panel1" runat="server">
                            <table>
                                <tr>
                                    <td align="right">
                                        <asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/images/no_icon.jpg" OnClick="btnClose_Click" />
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td align="center">
                                        <asp:DetailsView ID="dvShowDetail" runat="server" DataKeyNames="id" HeaderText="Update Status"
                                            AutoGenerateRows="false">
                                            <Fields>
                                                <asp:TemplateField HeaderText="PartnerName">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEmpName" runat="server" Text='<%#Eval("empName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Adhoc Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAdhocDate" runat="server" Text='<%#Eval("AdhocDate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ShiftTime">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblShiftTime" runat="server" Text='<%#Eval("ShiftTime") %>'></asp:Label>
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
                                                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="Button" OnClick="btnUpdate_Click1" />
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
