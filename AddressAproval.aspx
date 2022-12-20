<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="AddressAproval.aspx.cs" Inherits="AddressAproval" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>

.WrapStyle TD

{

word-break :  break-all;

}

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
                
                &nbsp;
            </td>
        </tr>
        <tr align="center">
            <td class="heading">
                <div class="gradient2">
                    <h1>
                        <span></span>Change Address Approval
                    </h1>
                    <h2>Allows to change the status of change address request.
                    </h2>
                </div>
            </td>
           </tr>
        <caption>
            <tr>
                <td>
                    <br />
                    <table align="left" border="0" cellpadding="4" cellspacing="0"
                        class="tableBorber" width="90%">
                        <tr>
                            <td align="center" class="TDbg" colspan="5">Fill The Selection Criteria
                                <asp:Label ID="lblFacError" runat="server" CssClass="error"
                                    Text="Select Facility" Visible="False"></asp:Label>
                                &nbsp; &nbsp; &nbsp;
                            </td>
                        </tr>
                        <tr align="center">
                            <td align="left" valign="top">
                                <b>From Date:</b>
                            </td>
                            <td align="left" valign="top">
                                <b>To Date:</b>&nbsp;
                            </td>
                            <td align="left" valign="top">
                                <b>Facility Name: </b>
                            </td>
                            <td align="left" valign="top">
                                <b>Status: </b>
                            </td>
                            <td align="left" rowspan="2" valign="middle">
                                <asp:Button ID="btnSubmit" runat="server" CssClass="Button"
                                    OnClick="btnSubmit_Click" Text="Run Report" ValidationGroup="Submit" />
                            </td>
                        </tr>
                        <tr align="center">
                            <td align="left" valign="top">
                                <asp:TextBox ID="txtStartDate" runat="server" CssClass="TextBox"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server"
                                    Enabled="true" PopupButtonID="ibcal1" TargetControlID="txtStartDate">
                                </cc1:CalendarExtender>
                                &nbsp;<asp:ImageButton ID="ibcal1" runat="server" Height="17px"
                                    ImageUrl="~/images/calendar_icon.gif" />
                                <br />
                                <i>(mm/dd/yyyy)</i>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                    ControlToValidate="txtStartDate" Display="Dynamic"
                                    ErrorMessage="Enter Valid Start Date"
                                    ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                    ValidationGroup="Submit">*</asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    ControlToValidate="txtStartDate" ErrorMessage="Enter Start Date"
                                    ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                            </td>
                            <td align="left" valign="top">
                                <asp:TextBox ID="txtEndDate" runat="server" CssClass="TextBox"></asp:TextBox>
                                &nbsp;<asp:ImageButton ID="ibcal2" runat="server" Height="17px"
                                    ImageUrl="~/images/calendar_icon.gif" />
                                <br />
                                <cc1:CalendarExtender ID="txtEndDate_CalendarExtender" runat="server"
                                    Enabled="True" PopupButtonID="ibcal2" TargetControlID="txtEndDate">
                                </cc1:CalendarExtender>
                                <i>(mm/dd/yyyy)</i>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                    ControlToValidate="txtEndDate" Display="Dynamic"
                                    ErrorMessage="Enter Valid End Date"
                                    ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                    ValidationGroup="Submit">*</asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                    ControlToValidate="txtEndDate" ErrorMessage="Enter End Date"
                                    ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CompareValidator15" runat="server"
                                    ControlToCompare="txtStartDate" ControlToValidate="txtEndDate"
                                    ErrorMessage="End Date cannot be less than Start Date."
                                    Operator="GreaterThanEqual" SetFocusOnError="True" Type="Date"
                                    ValidationGroup="Submit">*</asp:CompareValidator>
                            </td>
                            <td align="left" valign="top">
                                <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True"
                                    CssClass="DropDownListBox3">
                                </asp:DropDownList>
                                <asp:CompareValidator ID="CompareValidator1" runat="server"
                                    ControlToValidate="ddlFacility" Display="Dynamic"
                                    ErrorMessage="Select Facility" Operator="NotEqual" SetFocusOnError="True"
                                    ValidationGroup="Submit" ValueToCompare="0">*</asp:CompareValidator>
                            </td>
                            <td align="left" valign="top">
                                <asp:DropDownList ID="ddlStatus" runat="server" AppendDataBoundItems="True"
                                    CssClass="DropDownListBox3">
                                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Pending" Value="P"></asp:ListItem>
                                    <asp:ListItem Text="Approved" Value="A"></asp:ListItem>
                                    <asp:ListItem Text="Rejected" Value="R"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="100" AssociatedUpdatePanelID="UpdatePanel1"
                        DynamicLayout="False">
                        <ProgressTemplate>
                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loding..." />
                            Loading.....Please Wait!!!
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lblErrorMsg" runat="server" CssClass="error"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:LinkButton ID="lbtnPrintExcel" runat="server" Visible="False"
                        CssClass="linkButton" OnClick="lbtnPrintExcel_Click">Export to Excel</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td>
                    <table align="left" width="90%">
                        <tr>
                            <td align="left">
                                <asp:GridView ID="gvStatus" EmptyDataText="No Record Found!!" runat="server" DataKeyNames="id" AutoGenerateColumns="false" Width="100%">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Partner">
                                            <ItemStyle Width="20%" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblEmployeeID" runat="server" Text='<%#Eval("empDet")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="OldAddress" HeaderText="Old Address"
                                            ItemStyle-Width="20%">
                                            <ItemStyle Width="20%" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="New Address">
                                            <ItemStyle Width="20%" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblNewAddress" runat="server" Text='<%#Eval("NewAddress") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Wrap="true" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStatus" runat="server" Text='<%#Eval("status") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Request Date">
                                            <ItemStyle Width="10%" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblRequestDate" runat="server" Text='<%#Eval("RequestDate") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Effective Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEffectiveDate" runat="server" Text='<%#Eval("EffectiveDate") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Remark">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnApprove" runat="server" OnClick="lbtnApprove_Click" Visible='<%# Eval("Addstatus").ToString() == "1" ? true : false %>'>Approve</asp:LinkButton>
                                                <asp:LinkButton ID="lbtnReject" runat="server" OnClick="lbtnReject_Click" Visible='<%# Eval("Addstatus").ToString() == "1" ? true : false %>'>Reject</asp:LinkButton>
                                                <asp:Label ID="lblRemark" runat="server" Text='<%#Eval("Reason") %>' Visible='<%# Eval("Addstatus").ToString() == "0" ? true : false %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle CssClass="RowStyle" />
                                    <FooterStyle CssClass="FooterStyle" />
                                    <PagerStyle CssClass="PagerStyle" />
                                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                                    <HeaderStyle CssClass="HeaderStyle1" />
                                    <EditRowStyle BackColor="#999999" />
                                    <AlternatingRowStyle CssClass="AltRowStyle" />
                                </asp:GridView>

                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </caption>
    </table>
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="View1" runat="server">
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="Button1" runat="server" Style="visibility: hidden" />
                            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                TargetControlID="Button1" PopupControlID="Panel2" CancelControlID="ImageButton2">
                            </cc1:ModalPopupExtender>
                            <table cellpadding="0" cellspacing="0" width="60%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="Panel2" runat="server" CssClass="modal">
                                            <table cellpadding="0" cellspacing="0" width="100%" align="center">
                                                <tr>
                                                    <td class="blueHeaderMiddleLeft" width="1%">&nbsp;
                                                    </td>
                                                    <td class="blueHeaderMiddleCenter" width="100%">Address Reject Reason
                                                    </td>
                                                    <td class="blueHeaderMiddleCenter1">
                                                        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Window/CloseOut.gif"
                                                            CssClass="ButtonCloseOver" />
                                                    </td>
                                                    <td class="blueHeaderMiddleRight" width="1%">&nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" class="contenttableBorber">
                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td class="contentInnerTable">
                                                                    <asp:Panel ID="pnlRaise" runat="server" Visible="false">
                                                                        <table>
                                                                            <tr>
                                                                                <td align="center">
                                                                                    <asp:Label ID="lblStatus" runat="server" Text="Enter the Reason:"></asp:Label>
                                                                                    <asp:TextBox ID="txtReason" runat="server"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter the reason"
                                                                                        ControlToValidate="txtReason" ValidationGroup="Submit" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td align="center">
                                                                                    <asp:Button ID="btnAccept" runat="server" Text="Save" CssClass="Button"
                                                                                        OnClick="btnAccept_Click" ValidationGroup="Submit" />
                                                                                    &nbsp;
                                                                                    <asp:Button ID="btnReject" runat="server" Text="Cancel" CssClass="Button" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4">
                                                        <table width="100%" cellpadding="0" cellspacing="0" class="footerInnserTable">
                                                            <tr>
                                                                <td class="blueFooterMiddleCenter"></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:View>
        </asp:MultiView>
    </ContentTemplate>
    <Triggers>
    <asp:PostBackTrigger ControlID="lbtnPrintExcel" />
    </Triggers>
    </asp:UpdatePanel>
</asp:Content>

