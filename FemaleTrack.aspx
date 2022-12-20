<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="FemaleTrack.aspx.cs" Inherits="FemaleTrack" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    <style type="text/css">
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" width="100%">
        <tr>
            <td align="center">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="save" />
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="heading">
                Track Female Associates
            </td>
        </tr>
        <tr>
            <td align="center">
                Allow to Track Female Associates
            </td>
        </tr>
        <tr>
            <td align="left">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <table border="0" cellpadding="3" cellspacing="3" align="left" width="100%">
                            <tr>
                                <td align="left" valign="middle" colspan="2">
                                    <table border="0" cellpadding="4" cellspacing="0" align="left" width="90%" class="tableBorber">
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
                                                <b>Shift Date:</b>
                                            </td>
                                            <td align="left" valign="top">
                                                <b>Facility Name: </b>
                                            </td>
                                            <td align="left" rowspan="2" valign="middle">
                                                <asp:RadioButtonList ID="rdoTripType" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                                                    AutoPostBack="True" OnSelectedIndexChanged="rdoTripType_SelectedIndexChanged">
                                                    <asp:ListItem Selected="True" Value="P">Pick</asp:ListItem>
                                                    <asp:ListItem Value="D">Drop</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                            <td align="left" valign="top">
                                                <b>Shift:</b><br />
                                                <em>ctrl-click for multi - select</em>
                                            </td>
                                            <td align="left" rowspan="2" valign="middle">
                                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" ValidationGroup="Submit"
                                                    OnClick="btnSubmit_Click" CssClass="Button" />
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
                                                <asp:DropDownList ID="ddlfacility" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                    OnSelectedIndexChanged="ddlfacility_SelectedIndexChanged" CssClass="DropDownListBox3">
                                                </asp:DropDownList>
                                                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                                                    Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                                                    ValueToCompare="0">*</asp:CompareValidator>
                                            </td>
                                            <td align="left" valign="top">
                                                <asp:ListBox ID="lstShift" runat="server" SelectionMode="Multiple" AppendDataBoundItems="True">
                                                    <asp:ListItem Selected="True" Value="0"></asp:ListItem>
                                                </asp:ListBox>
                                                <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="lstShift"
                                                    ErrorMessage="Select Shift Time" Operator="NotEqual" ValidationGroup="Submit"
                                                    ValueToCompare="0">*</asp:CompareValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:LinkButton ID="lbtnPrintExcel" runat="server" OnClick="lbtnPrintExcel_Click"
                                        Visible="False">Export to Excel</asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:GridView ID="gvFemaleData" runat="server" AllowPaging="True" AllowSorting="True"
                                        AutoGenerateColumns="False" Width="100%" CellPadding="0" EmptyDataText="No Record Found!"
                                        DataKeyNames="Routeid,id" OnRowUpdating="gvFemaleData_RowUpdating" OnPageIndexChanging="gvFemaleData_PageIndexChanging">
                                        <Columns>
                                            <asp:BoundField DataField="employeeID" HeaderText="Associate ID">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="EmpName" HeaderText="Associate Name">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ProcessName" HeaderText="Department">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="mobile" HeaderText="Phone Number">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Shifttime" HeaderText="Shift Time">
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="RouteID" HeaderText="Route No">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="vehicleID" HeaderText="Cab ID">
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="stopno" HeaderText="Stop No">
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ETA" HeaderText="ETA">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Location" HeaderText="Location">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Track">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkTrack" runat="server" Checked='<%#  Convert.ToInt32(Eval("Tracked"))==1?true:false %>' />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Remark">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtRemark" runat="server" MaxLength="500" Text='<%# Eval("Remark") %>'
                                                        Width="100px"></asp:TextBox>
                                                    <asp:RegularExpressionValidator ID="RegExpAlphanum" runat="server" ControlToValidate="txtRemark"
                                                        Display="Dynamic" ErrorMessage="Remark Should be Alphanumeric." Text="*" ValidationExpression="^([\w\-,.:]|\s)*$"
                                                        ValidationGroup="save"></asp:RegularExpressionValidator>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Save">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnSave" runat="server" CommandName="Update" Height="20px" Text="Save"
                                                         Width="50px" ValidationGroup="save" />
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
                                        <EmptyDataRowStyle ForeColor="Red" Font-Bold="true" />
                                    </asp:GridView>
                            </tr>
                        </table>
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="lbtnPrintExcel" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                    DisplayAfter="0">
                    <ProgressTemplate>
                        <table align="center">
                            <tr>
                                <td>
                                    <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loading" />
                                </td>
                                <td class="main_bg" align="left">
                                    Loading.....Please Wait!!!&nbsp;
                                </td>
                            </tr>
                        </table>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>
    </table>
</asp:Content>


