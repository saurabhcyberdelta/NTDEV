<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="TptBlock.aspx.cs" Inherits="TptBlock" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <table align="center" border="0" cellpadding="2" width="100%" cellspacing="0">
                <tr>
                    <td colspan="4" class="heading">
                        <div class="gradient2">
                            <h1>
                                <span></span>Block / Un-Block Transport
                            </h1>
                            <h2>
                                Allows User to Block/Un-block transport of Associates on their No Shows.
                            </h2>
                        </div>
                    </td>
                </tr>
                <tr align="center">
                    <td align="left">
                        &nbsp;
                    </td>
                    <td align="center" colspan="2">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                            DisplayAfter="0" DynamicLayout="False">
                            <ProgressTemplate>
                                <table align="center" style="width: 400px">
                                    <tr>
                                        <td colspan="4" style="width: 200px">
                                            <img alt="Loding..." src="images/ajax-loader.gif" style="width: 16px; height: 16px" />
                                        </td>
                                        <td align="left" class="main_bg" style="width: 200px">
                                            Loading.....Please Wait!!!
                                        </td>
                                    </tr>
                                </table>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                    <td align="left">
                        &nbsp;
                    </td>
                </tr>
                <tr align="center">
                    <td align="left">
                        &nbsp;
                    </td>
                    <td align="center" width="40%">
                        <asp:Button ID="btnShowBlock" runat="server" CssClass="Button" OnClick="btnShowBlock_Click"
                            Text="Show Detail for Block " Width="200px" />
                    </td>
                    <td width="40%">
                        <asp:Button ID="btnShowUnblock" runat="server" CssClass="Button" Text="Show Detail for Un-Block"
                            Width="200px" OnClick="btnShowUnblock_Click" />
                    </td>
                    <td align="left">
                        &nbsp;
                    </td>
                </tr>
                <tr align="center">
                    <td align="left">
                        &nbsp;
                    </td>
                    <td align="center" width="40%">
                        &nbsp;
                    </td>
                    <td width="40%">
                        &nbsp;
                    </td>
                    <td align="left">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center">
                        <asp:Panel ID="pnlForBlock" runat="server" Width="90%" BorderColor="Gray" BorderStyle="Solid"
                            BorderWidth="1px" Visible="False">
                            <table align="center" border="0" cellpadding="2" cellspacing="1" width="100%">
                                <tr align="center">
                                    <td align="center" width="20%" colspan="5">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td align="center" colspan="5" width="20%">
                                        Detail of Associates liable for blocking their transport facility!
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td align="left" width="20%">
                                        &nbsp;
                                    </td>
                                    <td align="left" width="20%">
                                        <b>Month:</b>
                                    </td>
                                    <td align="left" width="20%">
                                        <b>Facility Name: </b>
                                    </td>
                                    <td align="left" width="20%">
                                        &nbsp;
                                    </td>
                                    <td align="center" width="20%">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td align="center" valign="middle">
                                        &nbsp;
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:DropDownList ID="ddlMonth" runat="server" AppendDataBoundItems="True">
                                        </asp:DropDownList>
                                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlMonth"
                                            Display="Dynamic" ErrorMessage="Select Month" Operator="NotEqual" ValidationGroup="Submit"
                                            ValueToCompare="0">*</asp:CompareValidator>
                                    </td>
                                    <td align="left" valign="middle">
                                        <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                        </asp:DropDownList>
                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                                            Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                                            ValueToCompare="0">*</asp:CompareValidator>
                                    </td>
                                    <td align="right">
                                        <asp:Button ID="btnSubmit" runat="server" CssClass="Button" OnClick="btnSubmit_Click"
                                            Text="Submit" ValidationGroup="Submit" />
                                    </td>
                                    <td align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td align="right">
                                        &nbsp;
                                    </td>
                                    <td align="center" colspan="3">
                                        &nbsp;
                                        <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" Height="16px" ShowMessageBox="True"
                                            ShowSummary="False" ValidationGroup="Submit" />
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td align="center" colspan="5">
                                        &nbsp;<asp:GridView ID="gvEmpDetail" runat="server" AllowPaging="True" AllowSorting="True"
                                            AutoGenerateColumns="False" CellPadding="0" DataKeyNames="ID" EmptyDataText="No Record Found!"
                                            Width="80%" OnPageIndexChanging="gvEmpDetail_PageIndexChanging">
                                            <EmptyDataRowStyle BorderStyle="None" ForeColor="Red" />
                                            <Columns>
                                                <asp:BoundField DataField="empCode" HeaderText="Associate ID">
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="empName" HeaderText="Associate Name">
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ProcessName" HeaderText="Department">
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Manager" HeaderText="Manager" />
                                                <asp:BoundField DataField="NoShowCount" HeaderText="No Show Count" />
                                                <asp:TemplateField HeaderText="Select">
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkBxHeader" AutoPostBack="true" OnCheckedChanged="CheckAll" runat="server" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelect" runat="server" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
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
                                        <br />
                                        <asp:Button ID="btnSave" runat="server" CssClass="Button" OnClick="btnSave_Click"
                                            Text="Block Transport" Visible="False" ValidationGroup="block" />
                                        &nbsp;
                                        <asp:Button ID="btnclose" runat="server" CssClass="Button" OnClick="btnclose_Click"
                                            Text="Close" />
                                        <asp:CustomValidator ID="CustomValidatorCheckBox" runat="server" ErrorMessage="Please select atleast one record !"
                                            OnServerValidate="CustomValidatorCheckBox_ServerValidate" ValidationGroup="block"
                                            Display="Dynamic">*</asp:CustomValidator>
                                        <br />
                                        <br />
                                        <asp:ValidationSummary ID="ValidationSummary3" runat="server" Height="16px" ValidationGroup="block" />
                                        <br />
                                        <br />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="pnlForUnBlock" runat="server" Width="90%" BorderColor="Gray" BorderWidth="1px"
                            Visible="False">
                            <table align="center" border="0" cellpadding="2" cellspacing="1" width="100%">
                                <tr align="center">
                                    <td align="center" width="20%" colspan="3">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td align="center" colspan="3" width="20%">
                                        Detail of Associates liable for Unblock their transport facility!
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td align="right">
                                        &nbsp;
                                    </td>
                                    <td align="center">
                                        &nbsp;
                                        <asp:Label ID="lblMsgU" runat="server" ForeColor="Red"></asp:Label>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td align="center" colspan="3">
                                        &nbsp;<asp:GridView ID="gvEmpDetailUnblock" runat="server" AllowPaging="True" AllowSorting="True"
                                            AutoGenerateColumns="False" CellPadding="0" DataKeyNames="ID" EmptyDataText="No Record Found!"
                                            OnPageIndexChanging="gvEmpDetailUnblock_PageIndexChanging" Width="80%">
                                            <EmptyDataRowStyle BorderStyle="None" ForeColor="Red" />
                                            <Columns>
                                                <asp:BoundField DataField="empCode" HeaderText="Associate ID">
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="empName" HeaderText="Associate Name">
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ProcessName" HeaderText="Department">
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Manager" HeaderText="Manager" />
                                                <asp:BoundField DataField="BlockedOn" HeaderText="Blocked On" />
                                                <asp:TemplateField HeaderText="Select">
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkBxHeader" AutoPostBack="true" OnCheckedChanged="CheckAll2" runat="server" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelect" runat="server" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
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
                                        <br />
                                        <asp:Button ID="btnUnblock" runat="server" CssClass="Button" OnClick="btnUnblock_Click"
                                            Text="Un-Block Transport" Visible="False" ValidationGroup="unblock" />
                                        &nbsp;
                                        <asp:Button ID="btnclose0" runat="server" CssClass="Button" OnClick="btnclose_Click"
                                            Text="Close" />
                                        <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Please select atleast one record !"
                                            OnServerValidate="CustomValidatorCheckBox_ServerValidate2" ValidationGroup="unblock"
                                            Display="Dynamic">*</asp:CustomValidator>
                                        <br />
                                        <br />
                                        <asp:ValidationSummary ID="ValidationSummary4" runat="server" Height="16px" ValidationGroup="unblock" />
                                        <br />
                                        <br />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
