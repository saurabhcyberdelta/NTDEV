<%@ Page Title="Admin Schedule Page" Language="C#" MasterPageFile="~/Header.Master"
    AutoEventWireup="true" CodeFile="AdminSchedule.aspx.cs" Inherits="AdminSchedule" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                ShowSummary="False" ValidationGroup="PageSize" />
            <asp:ValidationSummary ID="ValidationSummary2" runat="server" DisplayMode="BulletList"
                EnableClientScript="true" ValidationGroup="SetAll" ShowMessageBox="True" ShowSummary="False" />
            <asp:ValidationSummary ID="ValidationSummary5" runat="server" ShowMessageBox="True"
                ShowSummary="False" ValidationGroup="search" />
            <asp:ValidationSummary ID="ValidationSummary4" runat="server" ShowMessageBox="True"
                ShowSummary="False" ValidationGroup="saveShift" />
            <table align="left" cellpadding="4" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <table align="left" cellpadding="4" cellspacing="0" width="100%">
                            <tr>
                                <td class="heading" colspan="2">
                                    <div class="gradient2">
                                        <h1>
                                            <span></span>View Partners Transport Schedule
                                        </h1>
                                        <h2>
                                            Allows Admin to View/Update Partner Transport Schedule Details.
                                        </h2>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2">
                                    <asp:ValidationSummary ID="ValidationSummary3" runat="server" DisplayMode="BulletList"
                                        EnableClientScript="true" HeaderText="Please correct the following information : "
                                        ValidationGroup="save" ShowMessageBox="True" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="middle" colspan="2">
                                    <br />
                                    <b>From Date: </b>
                                    <asp:TextBox ID="txtCalendar" runat="server" AutoPostBack="True" OnTextChanged="txtCalendar_TextChanged"
                                        CssClass="TextBox"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBtnCalendar" runat="server" ImageUrl="Images/calendar_icon.gif"
                                        Height="17px" Width="17px" />
                                    <i>&nbsp;(mm/dd/yyyy)</i>
                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Animated="False" TargetControlID="txtCalendar"
                                        PopupButtonID="ImgBtnCalendar" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="middle" width="40%">
                                    <b>Partner ID's:</b><br />
                                </td>
                                <td align="left" valign="middle">
                                    <asp:TextBox ID="txtEmpIDs" runat="server" TextMode="MultiLine" Columns="36" Rows="6"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmpIDs"
                                        Display="Dynamic" ErrorMessage="Please Enter PartnerId" ValidationGroup="search"
                                        SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="middle" colspan="2">
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="Button" OnClick="btnSearch_Click"
                                        ValidationGroup="search" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="middle" colspan="2">
                                    &nbsp;
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="100" AssociatedUpdatePanelID="UpdatePanel1"
                                        DynamicLayout="False">
                                        <ProgressTemplate>
                                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loding..." />
                                            Loading.....Please Wait!!!</ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:MultiView ID="MultiView1" runat="server">
                            <asp:View ID="View1" runat="server">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:Panel ID="pnlShiftHeadertitle" runat="server" Width="100%" BackImageUrl="~/Images/Row1.gif"
                                            Height="20px">
                                            <table>
                                                <tr>
                                                    <td width="100%">
                                                        <asp:LinkButton ID="lblShiftHeader" runat="server" Text="Click here to Show Shift Header for Updation..."
                                                            ForeColor="White" OnClick="ShiftHeader_Click" Font-Bold="True"></asp:LinkButton>
                                                    </td>
                                                    <td width="2%">
                                                        <asp:ImageButton ID="Image1" runat="server" OnClick="ShiftHeader_Click" ImageUrl="images/expand_blue.jpg" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                        <asp:Panel ID="pnlShiftHeader" runat="server" BackColor="Silver" BorderStyle="Solid"
                                            BorderColor="Silver" BorderWidth="1" Width="100%" Visible="False">
                                            <table align="left" width="100%" class="table">
                                                <tr style="background-image: url('images/Grid/row_selected.gif')">
                                                    <td align="right" colspan="3">
                                                        &nbsp; &nbsp; &nbsp; <b>Weekly Off</b>
                                                    </td>
                                                    <td align="center">
                                                        <asp:CheckBox ID="chkoff0" runat="server" AutoPostBack="True" OnCheckedChanged="WklyOfChkChanged" />
                                                    </td>
                                                    <td align="center">
                                                        <asp:CheckBox ID="chkoff1" runat="server" AutoPostBack="True" OnCheckedChanged="WklyOfChkChanged" />
                                                    </td>
                                                    <td align="center">
                                                        <asp:CheckBox ID="chkoff2" runat="server" AutoPostBack="True" OnCheckedChanged="WklyOfChkChanged" />
                                                    </td>
                                                    <td align="center">
                                                        <asp:CheckBox ID="chkoff3" runat="server" AutoPostBack="True" OnCheckedChanged="WklyOfChkChanged" />
                                                    </td>
                                                    <td align="center">
                                                        <asp:CheckBox ID="chkoff4" runat="server" AutoPostBack="True" OnCheckedChanged="WklyOfChkChanged" />
                                                    </td>
                                                    <td align="center">
                                                        <asp:CheckBox ID="chkoff5" runat="server" AutoPostBack="True" OnCheckedChanged="WklyOfChkChanged" />
                                                    </td>
                                                    <td align="center">
                                                        <asp:CheckBox ID="chkoff6" runat="server" AutoPostBack="True" OnCheckedChanged="WklyOfChkChanged" />
                                                    </td>
                                                </tr>
                                                <tr style="background-image: url('images/Grid/row_selected.gif')">
                                                    <td align="right">
                                                        <b>Log-IN</b>
                                                    </td>
                                                    <td align="center">
                                                        <asp:DropDownList ID="ddlFacilityIn" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFacilityIn_SelectedIndexChanged"
                                                            CssClass="ddlScheduleFacility" ToolTip="Select Login Facility">
                                                            <asp:ListItem Text="-Select-" Value="">-Select-</asp:ListItem>
                                                            <asp:ListItem Text="N/A" Value="N/A">N/A</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:DropDownList ID="lstBxIn" runat="server" CssClass="ddlScheduleShift">
                                                            <asp:ListItem Text="-Select-" Value="">-Select-</asp:ListItem>
                                                            <asp:ListItem Text="N/A" Value="N/A">N/A</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:CompareValidator ID="CompareValidatddlFacilityIn0" runat="server" ControlToValidate="ddlFacilityIn"
                                                            Display="Dynamic" ErrorMessage="Select Login Facility" Operator="NotEqual" ValidationGroup="SetAll"
                                                            ValueToCompare="0">*</asp:CompareValidator>
                                                        <asp:CompareValidator ID="CompareValidatlstBxIn0" runat="server" ControlToValidate="lstBxIn"
                                                            Display="Dynamic" ErrorMessage="Select Login Shift" Operator="NotEqual" ValidationGroup="SetAll"
                                                            ValueToCompare="0">*</asp:CompareValidator>
                                                    </td>
                                                    <td rowspan="2" align="right">
                                                        <asp:LinkButton ID="lnkBtnSetAll" runat="server" OnClick="lnkBtnSetAll_Click" Text="Set All"
                                                            ValidationGroup="SetAll"></asp:LinkButton>
                                                    </td>
                                                    <td width="11%">
                                                        <asp:DropDownList ID="ddlFacilityIn0" runat="server" AutoPostBack="True" Enabled="false"
                                                            OnSelectedIndexChanged="ddlFacilityIn0_SelectedIndexChanged" CssClass="ddlScheduleFacility">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:DropDownList ID="lstBxIn0" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td width="11%">
                                                        <asp:DropDownList ID="ddlFacilityIn1" runat="server" AutoPostBack="True" Enabled="false"
                                                            OnSelectedIndexChanged="ddlFacilityIn1_SelectedIndexChanged" CssClass="ddlScheduleFacility">
                                                            <asp:ListItem Text="-Select-" Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:DropDownList ID="lstBxIn1" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                            <asp:ListItem Text="-Select-" Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td width="11%">
                                                        <asp:DropDownList ID="ddlFacilityIn2" runat="server" AutoPostBack="True" Enabled="false"
                                                            OnSelectedIndexChanged="ddlFacilityIn2_SelectedIndexChanged" CssClass="ddlScheduleFacility">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:DropDownList ID="lstBxIn2" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td width="11%">
                                                        <asp:DropDownList ID="ddlFacilityIn3" runat="server" AutoPostBack="True" Enabled="false"
                                                            OnSelectedIndexChanged="ddlFacilityIn3_SelectedIndexChanged" CssClass="ddlScheduleFacility">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:DropDownList ID="lstBxIn3" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td width="11%">
                                                        <asp:DropDownList ID="ddlFacilityIn4" runat="server" Enabled="false" CssClass="ddlScheduleFacility"
                                                            OnSelectedIndexChanged="ddlFacilityIn4_SelectedIndexChanged" AutoPostBack="True">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:DropDownList ID="lstBxIn4" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td width="11%">
                                                        <asp:DropDownList ID="ddlFacilityIn5" runat="server" Enabled="false" CssClass="ddlScheduleFacility"
                                                            OnSelectedIndexChanged="ddlFacilityIn5_SelectedIndexChanged" AutoPostBack="True"
                                                            Width="38px">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:DropDownList ID="lstBxIn5" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td width="11%">
                                                        <asp:DropDownList ID="ddlFacilityIn6" runat="server" Enabled="false" CssClass="ddlScheduleFacility"
                                                            OnSelectedIndexChanged="ddlFacilityIn6_SelectedIndexChanged" AutoPostBack="True">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:DropDownList ID="lstBxIn6" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr style="background-image: url('images/Grid/row_selected.gif')">
                                                    <td align="right">
                                                        <strong>Log-OUT</strong>
                                                    </td>
                                                    <td align="center">
                                                        <asp:DropDownList ID="ddlFacilityOut" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlFacilityOut_SelectedIndexChanged"
                                                            CssClass="ddlScheduleFacility" ToolTip="Select LogOut Facility">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                            <asp:ListItem Text="N/A" Value="N/A">N/A</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:DropDownList ID="lstBxOut" runat="server" CssClass="ddlScheduleShift">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                            <asp:ListItem Text="N/A" Value="N/A">N/A</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:CompareValidator ID="CompareValidatorddlFacilityOut" runat="server" ControlToValidate="ddlFacilityOut"
                                                            Display="Dynamic" ErrorMessage="Select Logout Facility" Operator="NotEqual" ValidationGroup="SetAll"
                                                            ValueToCompare="0">*</asp:CompareValidator>
                                                        <asp:CompareValidator ID="CompareValidatorlstBxOut" runat="server" ControlToValidate="lstBxOut"
                                                            Display="Dynamic" ErrorMessage="Select Logout Shift" Operator="NotEqual" ValidationGroup="SetAll"
                                                            ValueToCompare="0">*</asp:CompareValidator>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlFacilityOut0" Enabled="false" runat="server" AutoPostBack="True"
                                                            OnSelectedIndexChanged="ddlFacilityOut0_SelectedIndexChanged" CssClass="ddlScheduleFacility">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:DropDownList ID="lstBxOut0" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlFacilityOut1" Enabled="false" runat="server" AutoPostBack="True"
                                                            OnSelectedIndexChanged="ddlFacilityOut1_SelectedIndexChanged" CssClass="ddlScheduleFacility">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:DropDownList ID="lstBxOut1" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlFacilityOut2" Enabled="false" runat="server" AutoPostBack="True"
                                                            OnSelectedIndexChanged="ddlFacilityOut2_SelectedIndexChanged" CssClass="ddlScheduleFacility">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:DropDownList ID="lstBxOut2" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlFacilityOut3" Enabled="false" runat="server" AutoPostBack="True"
                                                            OnSelectedIndexChanged="ddlFacilityOut3_SelectedIndexChanged" CssClass="ddlScheduleFacility">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:DropDownList ID="lstBxOut3" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlFacilityOut4" Enabled="false" runat="server" CssClass="ddlScheduleFacility"
                                                            OnSelectedIndexChanged="ddlFacilityOut4_SelectedIndexChanged" AutoPostBack="True">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:DropDownList ID="lstBxOut4" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlFacilityOut5" Enabled="false" runat="server" CssClass="ddlScheduleFacility"
                                                            OnSelectedIndexChanged="ddlFacilityOut5_SelectedIndexChanged" AutoPostBack="True">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:DropDownList ID="lstBxOut5" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlFacilityOut6" Enabled="false" runat="server" CssClass="ddlScheduleFacility"
                                                            OnSelectedIndexChanged="ddlFacilityOut6_SelectedIndexChanged" AutoPostBack="True">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<asp:DropDownList ID="lstBxOut6" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                            <asp:ListItem Value="">-Select-</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr style="background-image: url('images/Grid/row2.gif')">
                                                    <td colspan="10" align="right" valign="middle" bgcolor="White">
                                                        <asp:CustomValidator ID="CustomValidatorCheckBox" runat="server" ErrorMessage="Cannot proceed because either you did not choose any Partner or any shift pattern."
                                                            OnServerValidate="CustomValidatorCheckBox_ServerValidate" ValidationGroup="save"
                                                            Display="Dynamic">*</asp:CustomValidator>
                                                        <asp:Button ID="btnSave" runat="server" Text="Save Schedule" OnClick="btnSave_Click"
                                                            ValidationGroup="save" CssClass="Button" />
                                                        <cc1:ConfirmButtonExtender ID="ConfirmButton_btnSave" TargetControlID="btnSave" runat="server"
                                                            ConfirmOnFormSubmit="False" ConfirmText="Are you sure you want to save the selected shift pattern?">
                                                        </cc1:ConfirmButtonExtender>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <table align="left" cellpadding="3" cellspacing="0" width="100%" border="1px">
                                            <tr>
                                                <td align="left" valign="middle" colspan="10">
                                                    <asp:GridView ID="grdEmployeeSchedule" runat="server" AutoGenerateColumns="False"
                                                        AllowPaging="False" DataKeyNames="EmployeeId" CssClass="GridView" EmptyDataText="No Record were found."
                                                        Width="100%" BorderWidth="0px" ShowFooter="True">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="ID">
                                                                <ItemStyle Width="20px" />
                                                                <HeaderTemplate>
                                                                    <asp:CheckBox ID="chkBxHeader" AutoPostBack="true" OnCheckedChanged="CheckAll" runat="server" />
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkBxEmpId" runat="server" />
                                                                    <asp:Label runat="server" ID="EmpID" Text='<%# Eval( "EmployeeId" ) %>' Visible="false"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="G">
                                                                <ItemStyle Width="10px" />
                                                                <ItemTemplate>
                                                                    <img id="imgGeoCode" src='<%# CheckImage(DataBinder.Eval(Container.DataItem, "geoCode")) %>'
                                                                        alt="GeoCode" width="15" height="15" /><br />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="T">
                                                                <ItemStyle Width="10px" />
                                                                <ItemTemplate>
                                                                    <img id="imgTptReq" src='<%# CheckTptReq(DataBinder.Eval(Container.DataItem, "tptReq")) %>'
                                                                        alt="Transport Required" width="15" height="15" /><br />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="EmpName">
                                                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkBtnEmpName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EmpName") %>'
                                                                        OnClick="lnkBtnEmpName_Click" CommandArgument='<%# Eval( "EmployeeId" ) %>' CssClass="linkButton"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="In0">
                                                                <ItemStyle Width="11%" HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkbtnSETime0" runat="server" Text='<%# (Eval("SETime0").ToString()!=""? Eval("SETime0").ToString().Substring(0, Eval("SETime0").ToString().IndexOf("!")):Eval("SETime0"))%>'
                                                                        OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(0) %>' CssClass="linkButton"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="In1">
                                                                <ItemStyle Width="11%" HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkbtnSETime1" runat="server" Text='<%# (Eval("SETime1").ToString() != string.Empty ? Eval("SETime1").ToString().Substring(0, Eval("SETime1").ToString().IndexOf("!")) : Eval("SETime1"))%>'
                                                                        OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(1) %>' CssClass="linkButton"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="In2">
                                                                <ItemStyle Width="11%" HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkbtnSETime2" runat="server" OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(2) %>'
                                                                        Text='<%# (Eval("SETime2").ToString() != string.Empty ? Eval("SETime2").ToString().Substring(0, Eval("SETime2").ToString().IndexOf("!")) : Eval("SETime2"))%>'
                                                                        CssClass="linkButton"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="In3">
                                                                <ItemStyle Width="11%" HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkbtnSETime3" runat="server" OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(3) %>'
                                                                        Text='<%# (Eval("SETime3").ToString() != string.Empty ? Eval("SETime3").ToString().Substring(0, Eval("SETime3").ToString().IndexOf("!")) : Eval("SETime3"))%>'
                                                                        CssClass="linkButton"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="In4">
                                                                <ItemStyle Width="11%" HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkbtnSETime4" runat="server" OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(4) %>'
                                                                        Text='<%# (Eval("SETime4").ToString() != string.Empty ? Eval("SETime4").ToString().Substring(0, Eval("SETime4").ToString().IndexOf("!")) : Eval("SETime4"))%>'
                                                                        CssClass="linkButton"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="In5">
                                                                <ItemStyle Width="11%" HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkbtnSETime5" runat="server" OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(5) %>'
                                                                        Text='<%# (Eval("SETime5").ToString() != string.Empty ? Eval("SETime5").ToString().Substring(0, Eval("SETime5").ToString().IndexOf("!")) : Eval("SETime5"))%>'
                                                                        CssClass="linkButton"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="In6">
                                                                <ItemStyle Width="11%" HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkbtnSETime6" runat="server" OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(6) %>'
                                                                        Text='<%# (Eval("SETime6").ToString() != string.Empty ? Eval("SETime6").ToString().Substring(0, Eval("SETime6").ToString().IndexOf("!")) : Eval("SETime6"))%>'
                                                                        CssClass="linkButton"></asp:LinkButton>
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
                                                        <EmptyDataRowStyle Font-Bold="true" ForeColor="Red" />
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="10" align="center" valign="middle">
                                                    <asp:Label ID="lblSaveMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </asp:View>
                        </asp:MultiView>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btnHidden" runat="server" Style="display: none" />
                        <cc1:ModalPopupExtender ID="ModalPopupExtender" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                            Drag="True" TargetControlID="btnHidden" CancelControlID="lbtnClose" OkControlID="lbtnClose"
                            PopupControlID="modal">
                        </cc1:ModalPopupExtender>
                        <div id="modal">
                            <asp:Panel ID="Panel1" runat="server" Style="visibility: hidden">
                                <table width="500px" style="border: 1px ridge #000000" bgcolor="#FFFFCC">
                                    <tr>
                                        <td align="center">
                                            <asp:DetailsView ID="DvGeo" runat="server" AutoGenerateRows="False" HeaderText="Partner Details"
                                                Width="100%" DefaultMode="Insert">
                                                <RowStyle CssClass="DetailsViewRowStyle" />
                                                <FooterStyle CssClass="DetailsViewFooterStyle" />
                                                <PagerStyle CssClass="DetailsViewPagerStyle" />
                                                <HeaderStyle CssClass="DetailsViewHeaderStyle" />
                                                <AlternatingRowStyle CssClass="DetailsViewAltRowStyle" />
                                                <Fields>
                                                    <asp:TemplateField HeaderText="Partner ID:">
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldvEmployeeID" runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Name:">
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldvEmpName" runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Address:">
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldvAddress1" runat="server" Width="300px"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Pincode:">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldvPincode" runat="server" Width="80%"></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Transport Required:">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkBxTptReq" runat="server" Enabled="false" />
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="City:">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddldvCity" runat="server" AppendDataBoundItems="True" Enabled="false"
                                                                CssClass="DropDownListBox3">
                                                            </asp:DropDownList>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Colony:">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddldvColony" runat="server" AppendDataBoundItems="True" Enabled="false"
                                                                CssClass="DropDownListBox3">
                                                            </asp:DropDownList>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                </Fields>
                                            </asp:DetailsView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:LinkButton ID="lbtnClose" runat="server">Close</asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="Button1" runat="server" Style="display: none" />
                        <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                            TargetControlID="Button1" PopupControlID="Panel2" CancelControlID="btnClose">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="Panel2" runat="server" Style="visibility: hidden">
                            <table width="500px" style="border: 1px ridge #000000" bgcolor="#FFFFCC">
                                <tr bgcolor="#003366">
                                    <td align="left" style="color: #FFFFFF">
                                        <b>Partner Shift Detail </b>
                                    </td>
                                    <td align="right" width="10%">
                                        <asp:ImageButton ID="btnClose" runat="server" ImageUrl="images/Exit.jpg" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:DetailsView ID="dvEditEmployeeSchedule" runat="server" AutoGenerateRows="False"
                                            Width="100%" DefaultMode="Insert" Height="222px">
                                            <RowStyle CssClass="DetailsViewRowStyle" />
                                            <FooterStyle CssClass="DetailsViewFooterStyle" />
                                            <PagerStyle CssClass="DetailsViewPagerStyle" />
                                            <HeaderStyle CssClass="DetailsViewHeaderStyle" />
                                            <AlternatingRowStyle CssClass="DetailsViewAltRowStyle" />
                                            <Fields>
                                                <asp:TemplateField HeaderText="Employee ID:">
                                                    <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblShiftEmployeeID" runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Name:">
                                                    <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblShiftEmpName" runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Shift Date:">
                                                    <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblShiftdate" runat="server" Width="300px"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Select Log-In:">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlInFacility" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3"
                                                            AutoPostBack="true" OnSelectedIndexChanged="ddlInFacility_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                        <asp:CompareValidator ID="CompareValidatddlFacilityIn0" runat="server" ControlToValidate="ddlInFacility"
                                                            Display="Dynamic" ErrorMessage="Select LogIn Facility" Operator="NotEqual" ValidationGroup="saveShift"
                                                            ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                        <asp:DropDownList ID="ddlInTime" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                        </asp:DropDownList>
                                                        <asp:Label ID="lblInTime" runat="server" Visible="False"></asp:Label>
                                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlInTime"
                                                            Display="Dynamic" ErrorMessage="Select LogIn Shift" Operator="NotEqual" ValidationGroup="saveShift"
                                                            ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Select Log-Out:">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlOutFacility" runat="server" AppendDataBoundItems="True"
                                                            AutoPostBack="true" OnSelectedIndexChanged="ddlOutFacility_SelectedIndexChanged"
                                                            CssClass="DropDownListBox3">
                                                        </asp:DropDownList>
                                                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlOutFacility"
                                                            Display="Dynamic" ErrorMessage="Select LogOut Facility" Operator="NotEqual" ValidationGroup="saveShift"
                                                            ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                        <asp:DropDownList ID="ddlOutTime" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                        </asp:DropDownList>
                                                        <asp:Label ID="lblOutTime" runat="server" Visible="False"></asp:Label>
                                                        <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="ddlOutTime"
                                                            Display="Dynamic" ErrorMessage="Select LogOut Shift" Operator="NotEqual" ValidationGroup="saveShift"
                                                            ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnSaveShift" ValidationGroup="saveShift" runat="server" Text="Save"
                                                            CssClass="Button" OnClick="btnSaveShift_Click" />
                                                        <asp:Panel ID="pnlUpdateMsg" runat="server" Visible="False">
                                                            <asp:Label ID="Label3" runat="server" Text="Label" ForeColor="Red"></asp:Label>
                                                        </asp:Panel>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Fields>
                                        </asp:DetailsView>
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
