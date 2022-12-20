<%@ Page Title="Schedule Page" Language="C#" MasterPageFile="~/eTMSMaster.Master"
    AutoEventWireup="true" CodeFile="EmpScheduler.aspx.cs" Inherits="EmpScheduler" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" language="javascript">
        function ClientValidate(source, arguments) {
            if (arguments.Value % 2 == 0) {
                arguments.IsValid = true;
            } else {
                arguments.IsValid = false;
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table align="left" cellpadding="4" cellspacing="0" width="100%">
                <tr>
                    <td colspan="10">
                        <table align="left" cellpadding="4" cellspacing="0" width="100%">
                            <tr>
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                    ShowSummary="False" ValidationGroup="PageSize" />
                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" DisplayMode="BulletList"
                                    EnableClientScript="true" ValidationGroup="SetAll" ShowMessageBox="True" ShowSummary="False" />
                                <td class="heading" colspan="2">
                                    <div class="gradient2">
                                        <h1>
                                            <span></span>View/Edit Transport Schedule
                                        </h1>
                                        <h2>
                                            Allows Partner/Manager to View/Edit Schedule Details.
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
                                <td align="left" valign="middle">
                                    <br />
                                    <b>From Date: </b>
                                    <asp:TextBox ID="txtCalendar" runat="server" AutoPostBack="True" OnTextChanged="txtCalendar_TextChanged"
                                        CssClass="TextBox"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBtnCalendar" runat="server" ImageUrl="Images/calendar_icon.gif"
                                        Height="17px" Width="17px" />
                                    <i>&nbsp;(mm/dd/yyyy)</i>
                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Animated="False" TargetControlID="txtCalendar"
                                        PopupButtonID="ImgBtnCalendar" />
                                    <br />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:Label ID="lblDate" runat="server"></asp:Label>
                                </td>
                                <td align="right" valign="middle">
                                    <asp:HyperLink ID="lbReplicateSchedule" runat="server" CssClass="linkButton" NavigateUrl="EmpReplicateSchedule.aspx">Replicate Schedule</asp:HyperLink>
                                    <br />
                                    <asp:LinkButton ID="lnbtnSpecialRequest"  CssClass="linkButton" runat="server" 
                                        onclick="lnbtnSpecialRequest_Click">Seperate Cab Request</asp:LinkButton>
                                       
                                    <cc1:ConfirmButtonExtender ID="ConfirmButtom1" runat="server" ConfirmText="Do you Really Want to make a Seperate Cab Request? The Request will be approved by your Division Manager" TargetControlID="lnbtnSpecialRequest"></cc1:ConfirmButtonExtender>
                <br />
                                    <asp:LinkButton ID="lbtnShuttleRequest"  CssClass="linkButton" runat="server" onclick="lbtnShuttleRequest_Click" 
                                        >IOS Shuttle Request</asp:LinkButton>
                                  <br />
                                  <br />
                                    <asp:LinkButton ID="lbUnscheduleRequest" runat="server" CssClass="linkButton" OnClick="lbUnscheduleRequest_Click">View Unschedule Requests</asp:LinkButton>
                                <br />
                                  <asp:LinkButton ID="lbtnIOSRequest" runat="server" CssClass="linkButton" 
                                        onclick="lbtnIOSRequest_Click">View IOS Shuttle Requests</asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="middle" colspan="2">
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
                    <td colspan="10">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="pnlShiftHeadertitle" runat="server" Width="100%" BackImageUrl="~/images/Row2.gif"
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
                                <asp:Panel ID="pnlShiftHeader" runat="server" BorderStyle="Solid" BorderColor="Silver"
                                    BorderWidth="1" Width="100%" Visible="False">
                                    <table class="table" width="100%">
                                        <tr class="HeaderStyle1">
                                            <td align="right" colspan="3">
                                                &nbsp; &nbsp; &nbsp; <b>Days</b>
                                            </td>
                                            <td align="center">
                                                <asp:Label ID="lblday1" runat="server" Font-Bold="True"></asp:Label>
                                            </td>
                                            <td align="center">
                                                <asp:Label ID="lblday2" runat="server" Font-Bold="True"></asp:Label>
                                            </td>
                                            <td align="center">
                                                <asp:Label ID="lblday3" runat="server" Font-Bold="True"></asp:Label>
                                            </td>
                                            <td align="center">
                                                <asp:Label ID="lblday4" runat="server" Font-Bold="True"></asp:Label>
                                            </td>
                                            <td align="center">
                                                <asp:Label ID="lblday5" runat="server" Font-Bold="True"></asp:Label>
                                            </td>
                                            <td align="center">
                                                <asp:Label ID="lblday6" runat="server" Font-Bold="True"></asp:Label>
                                            </td>
                                            <td align="center">
                                                <asp:Label ID="lblday7" runat="server" Font-Bold="True"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="RowStyle">
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
                                        <tr class="AltRowStyle">
                                            <td align="right">
                                                <b>Arr. Time</b>
                                            </td>
                                            <td align="center">
                                                <asp:DropDownList ID="ddlFacilityIn" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFacilityIn_SelectedIndexChanged"
                                                    CssClass="ddlScheduleFacility" ToolTip="Select Arrival Facility">
                                                    <asp:ListItem Text="-Select-" Value="">-Select-</asp:ListItem>
                                                    <asp:ListItem Text="N/A" Value="N/A">N/A</asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;<asp:DropDownList ID="lstBxIn" runat="server" CssClass="ddlScheduleShift">
                                                    <asp:ListItem Text="-Select-" Value="">-Select-</asp:ListItem>
                                                    <asp:ListItem Text="N/A" Value="N/A">N/A</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:CompareValidator ID="CompareValidatddlFacilityIn0" runat="server" ControlToValidate="ddlFacilityIn"
                                                    Display="Dynamic" ErrorMessage="Select Arrival Facility" Operator="NotEqual" ValidationGroup="SetAll"
                                                    ValueToCompare="0">*</asp:CompareValidator>
                                                <asp:CompareValidator ID="CompareValidatlstBxIn0" runat="server" ControlToValidate="lstBxIn"
                                                    Display="Dynamic" ErrorMessage="Select Arival Shift" Operator="NotEqual" ValidationGroup="SetAll"
                                                    ValueToCompare="0">*</asp:CompareValidator>
                                            </td>
                                            <td rowspan="2" align="right">
                                                <asp:LinkButton ID="lnkBtnSetAll" runat="server" OnClick="lnkBtnSetAll_Click" Text="Set All"
                                                    ValidationGroup="SetAll"></asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlFacilityIn0" runat="server" AutoPostBack="True" Enabled="false"
                                                    OnSelectedIndexChanged="ddlFacilityIn0_SelectedIndexChanged" CssClass="ddlScheduleFacility">
                                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;<asp:DropDownList ID="lstBxIn0" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlFacilityIn1" runat="server" AutoPostBack="True" Enabled="false"
                                                    OnSelectedIndexChanged="ddlFacilityIn1_SelectedIndexChanged" CssClass="ddlScheduleFacility">
                                                    <asp:ListItem Text="-Select-" Value="">-Select-</asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;<asp:DropDownList ID="lstBxIn1" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                    <asp:ListItem Text="-Select-" Value="">-Select-</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlFacilityIn2" runat="server" AutoPostBack="True" Enabled="false"
                                                    OnSelectedIndexChanged="ddlFacilityIn2_SelectedIndexChanged" CssClass="ddlScheduleFacility">
                                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;<asp:DropDownList ID="lstBxIn2" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlFacilityIn3" runat="server" AutoPostBack="True" Enabled="false"
                                                    OnSelectedIndexChanged="ddlFacilityIn3_SelectedIndexChanged" CssClass="ddlScheduleFacility">
                                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;<asp:DropDownList ID="lstBxIn3" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlFacilityIn4" runat="server" Enabled="false" CssClass="ddlScheduleFacility"
                                                    OnSelectedIndexChanged="ddlFacilityIn4_SelectedIndexChanged" AutoPostBack="True">
                                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;<asp:DropDownList ID="lstBxIn4" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlFacilityIn5" runat="server" Enabled="false" CssClass="ddlScheduleFacility"
                                                    OnSelectedIndexChanged="ddlFacilityIn5_SelectedIndexChanged" AutoPostBack="True"
                                                    Width="38px">
                                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;<asp:DropDownList ID="lstBxIn5" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlFacilityIn6" runat="server" Enabled="false" CssClass="ddlScheduleFacility"
                                                    OnSelectedIndexChanged="ddlFacilityIn6_SelectedIndexChanged" AutoPostBack="True">
                                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;<asp:DropDownList ID="lstBxIn6" runat="server" Enabled="false" CssClass="ddlScheduleShift">
                                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr class="AltRowStyle">
                                            <td align="right">
                                                <strong>Dep. Time</strong>
                                            </td>
                                            <td align="center">
                                                <asp:DropDownList ID="ddlFacilityOut" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlFacilityOut_SelectedIndexChanged"
                                                    CssClass="ddlScheduleFacility" ToolTip="Select Departure Facility">
                                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                                    <asp:ListItem Text="N/A" Value="N/A">N/A</asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp;<asp:DropDownList ID="lstBxOut" runat="server" CssClass="ddlScheduleShift">
                                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                                    <asp:ListItem Text="N/A" Value="N/A">N/A</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:CompareValidator ID="CompareValidatorddlFacilityOut" runat="server" ControlToValidate="ddlFacilityOut"
                                                    Display="Dynamic" ErrorMessage="Select Departure Facility" Operator="NotEqual" ValidationGroup="SetAll"
                                                    ValueToCompare="0">*</asp:CompareValidator>
                                                <asp:CompareValidator ID="CompareValidatorlstBxOut" runat="server" ControlToValidate="lstBxOut"
                                                    Display="Dynamic" ErrorMessage="Select Departure Shift" Operator="NotEqual" ValidationGroup="SetAll"
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
                                        <tr class="RowStyle">
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
                        </asp:UpdatePanel>
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <table align="left" cellpadding="3" cellspacing="0" width="100%" border="0px">
                                    <tr>
                                        <td align="left" valign="middle" colspan="10">
                                            <asp:GridView ID="grdEmployeeSchedule" runat="server" AutoGenerateColumns="False"
                                                AllowPaging="False" DataKeyNames="EmployeeId,IsExceptional" CssClass="GridView" BorderWidth="0px"
                                                ShowFooter="True" Width="100%">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="ID">
                                                        <ItemStyle Width="20px" />
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkBxHeader" AutoPostBack="true" OnCheckedChanged="CheckAll" ToolTip="Select All" runat="server" />
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
                                                                alt='<%# CheckAltGeocode(DataBinder.Eval(Container.DataItem, "geoCode")) %>' width="15" height="15" /><br />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="T">
                                                        <ItemStyle Width="10px" />
                                                        <ItemTemplate>
                                                            <img id="imgTptReq" src='<%# CheckTptReq(DataBinder.Eval(Container.DataItem, "tptReq")) %>'
                                                                alt='<%# CheckAltTptReq(DataBinder.Eval(Container.DataItem, "tptReq")) %>' width="15" height="15" /><br />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Partner Name">
                                                        <ItemStyle Width="160px" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lnkBtnEmpName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EmpName") %>'></asp:Label></ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In0">
                                                        <ItemStyle Width="110px" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkbtnSETime0" runat="server" Text='<%# (Eval("SETime0").ToString()!=""? Eval("SETime0").ToString().Substring(0, Eval("SETime0").ToString().IndexOf("!")):Eval("SETime0"))%>'
                                                                OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(0) %>' CssClass="linkButton"></asp:LinkButton><asp:ImageButton
                                                                    ID="imgBtnRouteIn0" ImageUrl="~/Images/TptReq.gif" Height="10px" Width="20px"
                                                                    Visible='<%# (Eval("SETime0").ToString()!=""?(Eval("SETime0").ToString().Substring(Eval("SETime0").ToString().IndexOf("!") + 1, Eval("SETime0").ToString().Length - (Eval("SETime0").ToString().IndexOf("!") + 1))).Trim()== "false" ?false:true:false) %>'
                                                                    OnClick="imgBtnRoute_Click" runat="server" CommandArgument='<%# GetShiftdate(0) %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In1">
                                                        <ItemStyle Width="110px" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkbtnSETime1" runat="server" Text='<%# (Eval("SETime1").ToString() != string.Empty ? Eval("SETime1").ToString().Substring(0, Eval("SETime1").ToString().IndexOf("!")) : Eval("SETime1"))%>'
                                                                OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(1) %>' CssClass="linkButton"></asp:LinkButton><asp:ImageButton
                                                                    ID="imgBtnRouteIn1" ImageUrl="~/Images/TptReq.gif" Height="10px" Width="20px"
                                                                    Visible='<%# (Eval("SETime1").ToString()!=""?(Eval("SETime1").ToString().Substring(Eval("SETime1").ToString().IndexOf("!") + 1, Eval("SETime1").ToString().Length - (Eval("SETime1").ToString().IndexOf("!") + 1))).Trim()== "false" ?false:true:false) %>'
                                                                    CommandArgument='<%# GetShiftdate(1) %>' runat="server" OnClick="imgBtnRoute_Click" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In2">
                                                        <ItemStyle Width="110px" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkbtnSETime2" runat="server" OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(2) %>'
                                                                Text='<%# (Eval("SETime2").ToString() != string.Empty ? Eval("SETime2").ToString().Substring(0, Eval("SETime2").ToString().IndexOf("!")) : Eval("SETime2"))%>'
                                                                CssClass="linkButton"></asp:LinkButton><asp:ImageButton ID="imgBtnRouteIn2" ImageUrl="~/Images/TptReq.gif"
                                                                    Height="10px" Width="20px" Visible='<%# (Eval("SETime2").ToString()!=""?(Eval("SETime2").ToString().Substring(Eval("SETime2").ToString().IndexOf("!") + 1, Eval("SETime2").ToString().Length - (Eval("SETime2").ToString().IndexOf("!") + 1))).Trim()== "false" ?false:true:false) %>'
                                                                    CommandArgument='<%# GetShiftdate(2) %>' runat="server" OnClick="imgBtnRoute_Click" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In3">
                                                        <ItemStyle Width="110px" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkbtnSETime3" runat="server" OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(3) %>'
                                                                Text='<%# (Eval("SETime3").ToString() != string.Empty ? Eval("SETime3").ToString().Substring(0, Eval("SETime3").ToString().IndexOf("!")) : Eval("SETime3"))%>'
                                                                CssClass="linkButton"></asp:LinkButton><asp:ImageButton ID="imgBtnRouteIn3" ImageUrl="~/Images/TptReq.gif"
                                                                    Height="10px" Width="20px" Visible='<%# (Eval("SETime3").ToString()!=""?(Eval("SETime3").ToString().Substring(Eval("SETime3").ToString().IndexOf("!") + 1, Eval("SETime3").ToString().Length - (Eval("SETime3").ToString().IndexOf("!") + 1))).Trim()== "false" ?false:true:false) %>'
                                                                    CommandArgument='<%# GetShiftdate(3) %>' runat="server" OnClick="imgBtnRoute_Click" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In4">
                                                        <ItemStyle Width="110px" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkbtnSETime4" runat="server" OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(4) %>'
                                                                Text='<%# (Eval("SETime4").ToString() != string.Empty ? Eval("SETime4").ToString().Substring(0, Eval("SETime4").ToString().IndexOf("!")) : Eval("SETime4"))%>'
                                                                CssClass="linkButton"></asp:LinkButton><asp:ImageButton ID="imgBtnRouteIn4" ImageUrl="~/Images/TptReq.gif"
                                                                    Height="10px" Width="20px" Visible='<%# (Eval("SETime4").ToString()!=""?(Eval("SETime4").ToString().Substring(Eval("SETime4").ToString().IndexOf("!") + 1, Eval("SETime4").ToString().Length - (Eval("SETime4").ToString().IndexOf("!") + 1))).Trim()== "false" ?false:true:false) %>'
                                                                    CommandArgument='<%# GetShiftdate(4) %>' runat="server" OnClick="imgBtnRoute_Click" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In5">
                                                        <ItemStyle Width="110px" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkbtnSETime5" runat="server" OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(5) %>'
                                                                Text='<%# (Eval("SETime5").ToString() != string.Empty ? Eval("SETime5").ToString().Substring(0, Eval("SETime5").ToString().IndexOf("!")) : Eval("SETime5"))%>'
                                                                CssClass="linkButton"></asp:LinkButton><asp:ImageButton ID="imgBtnRouteIn5" ImageUrl="~/Images/TptReq.gif"
                                                                    Height="10px" Width="20px" Visible='<%# (Eval("SETime5").ToString()!=""?(Eval("SETime5").ToString().Substring(Eval("SETime5").ToString().IndexOf("!") + 1, Eval("SETime5").ToString().Length - (Eval("SETime5").ToString().IndexOf("!") + 1))).Trim()== "false" ?false:true:false) %>'
                                                                    CommandArgument='<%# GetShiftdate(5) %>' runat="server" OnClick="imgBtnRoute_Click" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In6">
                                                        <ItemStyle Width="110px" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkbtnSETime6" runat="server" OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(6) %>'
                                                                Text='<%# (Eval("SETime6").ToString() != string.Empty ? Eval("SETime6").ToString().Substring(0, Eval("SETime6").ToString().IndexOf("!")) : Eval("SETime6"))%>'
                                                                CssClass="linkButton"></asp:LinkButton><asp:ImageButton ID="imgBtnRouteIn6" ImageUrl="~/Images/TptReq.gif"
                                                                    Height="10px" Width="20px" Visible='<%# (Eval("SETime6").ToString()!=""?(Eval("SETime6").ToString().Substring(Eval("SETime6").ToString().IndexOf("!") + 1, Eval("SETime6").ToString().Length - (Eval("SETime6").ToString().IndexOf("!") + 1))).Trim()== "false" ?false:true:false) %>'
                                                                    CommandArgument='<%# GetShiftdate(6) %>' runat="server" OnClick="imgBtnRoute_Click" />
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
                                    <tr>
                                        <td colspan="10" align="center" valign="middle">
                                            <asp:Label ID="lblSaveMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                     <asp:MultiView ID="MultiView5" runat="server">
                                                <asp:View ID="View5" runat="server">
                        <asp:Button ID="btnHidden" runat="server" Style="display: none" />
                        <cc1:ModalPopupExtender ID="ModalPopupExtender" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                            Drag="True" TargetControlID="btnHidden" CancelControlID="lbtnClose" OkControlID="lbtnClose"
                            PopupControlID="modal">
                        </cc1:ModalPopupExtender>
                        <div id="modal">
                            <asp:Panel ID="Panel1" runat="server">
                                <table width="500px" style="border: 1px ridge #000000" bgcolor="#FFFFCC">
                                    <tr>
                                        <td align="center">
                                           
                                                
                                            <asp:DetailsView ID="DvGeo" runat="server" AutoGenerateRows="False" DefaultMode="Insert"
                                                HeaderText="Partner Details" OnModeChanging="DvGeo_ModeChanging" Width="500px"
                                                DataKeyNames="id" BorderWidth="0px">
                                                <Fields>
                                                    <asp:TemplateField HeaderText="Partner ID:">
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldvEmployeeID" runat="server"></asp:Label></ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Name:">
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldvEmpName" runat="server"></asp:Label></ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Facility:">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldvfacility" runat="server" Width="80%"></asp:Label></ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Address:">
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldvAddress1" runat="server" Width="300px"></asp:Label></ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Pincode:">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldvPincode" runat="server" Width="80%"></asp:Label></ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Mobile:">
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblMobile" runat="server"></asp:Label><asp:TextBox ID="txtMobile"
                                                                runat="server" Visible="False" CssClass="TextBox" MaxLength="10" Width="80px"></asp:TextBox><asp:LinkButton
                                                                    ID="lbEditMobile" runat="server" OnClick="lbEditMobile_Click" CssClass="linkButton">Edit</asp:LinkButton><asp:LinkButton
                                                                        ID="lbSaveMobile" runat="server" Visible="False" ValidationGroup="SaveMobile"
                                                                        OnClick="lbSaveMobile_Click" CssClass="linkButton">Save</asp:LinkButton><asp:LinkButton
                                                                            ID="lbCancelMobile" runat="server" Visible="False" OnClick="lbCancelMobile_Click"
                                                                            CssClass="linkButton">Cancel</asp:LinkButton><asp:Image ID="imgStatus" runat="server"
                                                                                Visible="False" />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter the mobile no."
                                                                Display="Dynamic" ControlToValidate="txtMobile" ValidationGroup="SaveMobile"
                                                                SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                                    ID="RegularExpressionValidator2" runat="server" ErrorMessage="Mobile no should have 10 digits no."
                                                                    ControlToValidate="txtMobile" ValidationExpression="^((\+)?(\d{2}[-]))?(\d{10}){1}?$"
                                                                    ValidationGroup="SaveMobile" Display="Dynamic" SetFocusOnError="True">*</asp:RegularExpressionValidator></ItemTemplate>
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
                                                            <asp:HyperLink ID="lbChangeAddress" runat="server" Visible="false" CssClass="linkButton"
                                                                NavigateUrl="~/AddressChange.aspx">Change Address</asp:HyperLink></ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                </Fields>
                                                <RowStyle CssClass="DetailsViewRowStyle" />
                                                <FooterStyle CssClass="DetailsViewFooterStyle" />
                                                <PagerStyle CssClass="DetailsViewPagerStyle" />
                                                <HeaderStyle CssClass="DetailsViewHeaderStyle" />
                                                <AlternatingRowStyle CssClass="DetailsViewAltRowStyle" />
                                            </asp:DetailsView>
                                             <asp:LinkButton ID="lbtnClose" runat="server">Close</asp:LinkButton>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                           
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                        </asp:View>
                                            </asp:MultiView>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:MultiView ID="MultiView3" runat="server">
                            <asp:View ID="View3" runat="server">
                                <asp:Button ID="Button2" runat="server" Style="visibility: hidden" />
                                <cc1:ModalPopupExtender ID="ModalPopupExtender2" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                    OkControlID="ImageButton1" TargetControlID="Button2" PopupControlID="Panel3"
                                    CancelControlID="ImageButton1">
                                </cc1:ModalPopupExtender>
                                <table cellpadding="0" cellspacing="0" width="90%" bgcolor="#E6E8E8">
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Panel3" runat="server" CssClass="modal1">
                                                <table cellpadding="0" cellspacing="0" width="100%" align="center">
                                                    <tr>
                                                        <td class="blueHeaderMiddleLeft" width="1%">
                                                            &nbsp;
                                                        </td>
                                                        <td class="blueHeaderMiddleCenter" width="100%">
                                                            Display Route Information
                                                        </td>
                                                        <td class="blueHeaderMiddleCenter1">
                                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Window/CloseOut.gif"
                                                                CssClass="ButtonCloseOver" />
                                                        </td>
                                                        <td class="blueHeaderMiddleRight" width="1%">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4">
                                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                                <tr>
                                                                    <td class="contentInnerTable">
                                                                        <asp:Panel ID="Panel4" runat="server">
                                                                            <table class="tableBorber">
                                                                                <tr>
                                                                                    <td align="left" class="row1" colspan="8">
                                                                                        PickUp Route Information
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="left" class="myTableRowStyle" width="10%">
                                                                                        <b>RouteID:-</b>
                                                                                        <asp:Label ID="lblPickRouteID" runat="server" Text='<%# Eval("RouteID")%>'></asp:Label>
                                                                                    </td>
                                                                                     <td align="left" class="myTableRowStyle" width="10%">
                                                                                        <b>Route#:-</b>
                                                                                        <asp:Label ID="lblRouteNo" runat="server" Text='<%# Eval("sticker")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td align="left" class="myTableRowStyle" width="10%">
                                                                                        <b>Date:-</b>
                                                                                        <asp:Label ID="lblPickShiftDate" runat="server" Text='<%# Eval("shiftDate")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td align="left" class="myTableRowStyle" width="10%">
                                                                                        <b>Shift Time:-</b>
                                                                                        <asp:Label ID="lblPickShiftTime" runat="server" Text='<%# Eval("shiftTime")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td align="left" class="myTableRowStyle" style="font-weight: bold; font-size: 12px;"
                                                                                        width="10%">
                                                                                        <asp:Label ID="lblPickTripType" runat="server" Text='<%# Eval("tripType")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td align="left" class="myTableRowStyle" width="10%">
                                                                                        <b>Vendor Name:-</b>
                                                                                        <asp:Label ID="lblPickVendorName" runat="server" Text='<%# Eval("vendorName")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td align="left" class="myTableRowStyle" width="10%">
                                                                                        <b>Cab ID:-</b>
                                                                                        <asp:Label ID="lblPickStickerNo" runat="server" Text='<%# Eval("vehicleId")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td align="left" class="myTableRowStyle" width="10%">
                                                                                        <b>Facility:-</b>
                                                                                        <asp:Label ID="lblPickFacility" runat="server" Text='<%# Eval("facilityName")%>'></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="8">
                                                                                        <asp:GridView ID="grdShowPickUpRoute" AutoGenerateColumns="False" runat="server"
                                                                                            DataKeyNames="routeid,id,shiftdate" ShowFooter="True" Width="100%" BorderWidth="0px">
                                                                                            <RowStyle CssClass="RowStyle" />
                                                                                            <FooterStyle CssClass="FooterStyle" />
                                                                                            <PagerStyle CssClass="PagerStyle" />
                                                                                            <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                                                            <HeaderStyle CssClass="HeaderStyle" />
                                                                                            <EditRowStyle BackColor="#999999" />
                                                                                            <AlternatingRowStyle CssClass="AltRowStyle" />
                                                                                            <Columns>
                                                                                                <asp:TemplateField HeaderText="Partner Detail" SortExpression="empCode">
                                                                                                    <ItemTemplate>
                                                                                                        <div style="width: 200px;">
                                                                                                            <asp:Label ID="lblEmpName" Text='<%# Eval("EmpName") %>' runat="server"></asp:Label></div>
                                                                                                    </ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="G" SortExpression="Gender">
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Label ID="lbgender" runat="server" Text='<%# Eval("Gender") %>' Width="20px"></asp:Label></ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>' Width="400px"></asp:Label></ItemTemplate>
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="">
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Label ID="lblTripType" runat="server" Text='<%# Eval("tripType") %>' Width="20px"></asp:Label></ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="SNo" SortExpression="stopNo">
                                                                                                    <ItemTemplate>
                                                                                                        <%# Eval("stopNo")%></ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="ETA" SortExpression="ETA">
                                                                                                    <ItemTemplate>
                                                                                                        <%# Eval("ETAhh")%>
                                                                                                        :
                                                                                                        <%# Eval("ETAmm")%></ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                            </Columns>
                                                                                        </asp:GridView>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:Panel>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="contentInnerTable">
                                                                        <asp:Panel ID="Panel5" runat="server">
                                                                            <table class="tableBorber">
                                                                                <tr>
                                                                                    <td align="left" class="row2" colspan="8">
                                                                                        Drop Route Information
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="left" class="myTableAltRowStyle" width="10%">
                                                                                        <b>RouteID:-</b>
                                                                                        <asp:Label ID="lblDropRouteID" runat="server" Text='<%# Eval("RouteID")%>'></asp:Label>
                                                                                    </td>
                                                                                     <td align="left" class="myTableRowStyle" width="10%">
                                                                                        <b>Route#:-</b>
                                                                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("sticker")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td align="left" class="myTableAltRowStyle" width="10%">
                                                                                        <b>Date:-</b>
                                                                                        <asp:Label ID="lblDropShiftDate" runat="server" Text='<%# Eval("shiftDate")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td align="left" class="myTableAltRowStyle" width="10%">
                                                                                        <b>Shift Time:-</b>
                                                                                        <asp:Label ID="lblDropShiftTime" runat="server" Text='<%# Eval("shiftTime")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td align="left" class="myTableAltRowStyle" style="font-weight: bold; font-size: 12px;"
                                                                                        width="10%">
                                                                                        <asp:Label ID="lblDropTripType" runat="server" Text='<%# Eval("tripType")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td align="left" class="myTableAltRowStyle" width="10%">
                                                                                        <b>Vendor Name:-</b>
                                                                                        <asp:Label ID="lblDropVendorName" runat="server" Text='<%# Eval("vendorName")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td align="left" class="myTableAltRowStyle" width="10%">
                                                                                        <b>Cab ID:-</b>
                                                                                        <asp:Label ID="lblDropStickerNo" runat="server" Text='<%# Eval("vehicleId")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td align="left" class="myTableAltRowStyle" width="10%">
                                                                                        <b>Facility:-</b>
                                                                                        <asp:Label ID="lblDropFacility" runat="server" Text='<%# Eval("facilityName")%>'></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="8">
                                                                                        <asp:GridView ID="grdShowDropRoute" AutoGenerateColumns="False" runat="server" DataKeyNames="routeid,id,shiftdate"
                                                                                            ShowFooter="True" CssClass="GridView" Width="100%">
                                                                                            <RowStyle CssClass="RowStyle" />
                                                                                            <FooterStyle CssClass="FooterStyle" />
                                                                                            <PagerStyle CssClass="PagerStyle" />
                                                                                            <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                                                            <HeaderStyle CssClass="HeaderStyle" />
                                                                                            <EditRowStyle BackColor="#999999" />
                                                                                            <AlternatingRowStyle CssClass="AltRowStyle" />
                                                                                            <Columns>
                                                                                                <asp:TemplateField HeaderText="Partner Detail" SortExpression="empCode">
                                                                                                    <ItemTemplate>
                                                                                                        <div style="width: 200px;">
                                                                                                            <asp:Label ID="lblEmpName" Text='<%# Eval("EmpName") %>' runat="server"></asp:Label></div>
                                                                                                    </ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="G" SortExpression="Gender">
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Label ID="lbgender" runat="server" Text='<%# Eval("Gender") %>' Width="20px"></asp:Label></ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>' Width="400px"></asp:Label></ItemTemplate>
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="">
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Label ID="lblTripType" runat="server" Text='<%# Eval("tripType") %>' Width="20px"></asp:Label></ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="SNo" SortExpression="stopNo">
                                                                                                    <ItemTemplate>
                                                                                                        <%# Eval("stopNo")%></ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="ETA" SortExpression="ETA">
                                                                                                    <ItemTemplate>
                                                                                                        <%# Eval("ETAhh")%>
                                                                                                        :
                                                                                                        <%# Eval("ETAmm")%></ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                            </Columns>
                                                                                        </asp:GridView>
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
                                                                    <td class="blueFooterMiddleCenter">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                        </asp:MultiView>
                        <asp:MultiView ID="MultiView2" runat="server">
                            <asp:View ID="View4" runat="server">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="Button3" runat="server" Style="visibility: hidden" />
                                            <cc1:ModalPopupExtender ID="ModalPopupExtender3" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                                TargetControlID="Button3" PopupControlID="pnlModal" CancelControlID="ibtnSMclose">
                                            </cc1:ModalPopupExtender>
                                            <table cellpadding="0" cellspacing="0" width="60%">
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="pnlModal" runat="server" CssClass="modal">
                                                            <table cellpadding="0" cellspacing="0" width="100%" align="center">
                                                                <tr>
                                                                    <td class="blueHeaderMiddleLeft" width="1%">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td class="blueHeaderMiddleCenter" width="100%">
                                                                        Update Transport Schedule
                                                                    </td>
                                                                    <td class="blueHeaderMiddleCenter1">
                                                                        <asp:ImageButton ID="ibtnSMclose" runat="server" ImageUrl="~/images/Window/CloseOut.gif"
                                                                            CssClass="ButtonCloseOver" />
                                                                    </td>
                                                                    <td class="blueHeaderMiddleRight" width="1%">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" class="contenttableBorber">
                                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                                            <tr>
                                                                                <td class="contentInnerTable">
                                                                                    <asp:DetailsView ID="dvEditEmployeeSchedule" runat="server" AutoGenerateRows="False"
                                                                                        Width="80%" DefaultMode="Insert" Height="222px" HeaderText="Partner Shift Details">
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
                                                                                                    <asp:Label ID="lblShiftEmployeeID" runat="server"></asp:Label></ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Name:">
                                                                                                <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="lblShiftEmpName" runat="server"></asp:Label></ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Shift Date:">
                                                                                                <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="lblShiftdate" runat="server" Width="300px"></asp:Label></ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Select Arr. Time:">
                                                                                                <ItemTemplate>
                                                                                                    <asp:DropDownList ID="ddlInFacility" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3"
                                                                                                        AutoPostBack="true" OnSelectedIndexChanged="ddlInFacility_SelectedIndexChanged">
                                                                                                    </asp:DropDownList>
                                                                                                    <asp:CompareValidator ID="CompareValidatddlFacilityIn0" runat="server" ControlToValidate="ddlInFacility"
                                                                                                        Display="Dynamic" ErrorMessage="Select Arrival Facility" Operator="NotEqual" ValidationGroup="saveShift"
                                                                                                        ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                                                                    <asp:DropDownList
                                                                                                            ID="ddlInTime" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                                                        </asp:DropDownList>
                                                                                                    <asp:Label ID="lblInTime" runat="server" Visible="False"></asp:Label><asp:CompareValidator
                                                                                                        ID="CompareValidator1" runat="server" ControlToValidate="ddlInTime" Display="Dynamic"
                                                                                                        ErrorMessage="Select Arrival Shift" Operator="NotEqual" ValidationGroup="saveShift"
                                                                                                        ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator><asp:HyperLink
                                                                                                            ID="lbPickAdhoc" runat="server" Visible="false" CssClass="linkButton" NavigateUrl="~/AdhocRequest.aspx"> Pick Adhoc</asp:HyperLink></ItemTemplate>
                                                                                                <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Select Dep. Time:">
                                                                                                <ItemTemplate>
                                                                                                    <asp:DropDownList ID="ddlOutFacility" runat="server" AppendDataBoundItems="True"
                                                                                                        AutoPostBack="true" OnSelectedIndexChanged="ddlOutFacility_SelectedIndexChanged"
                                                                                                        CssClass="DropDownListBox3">
                                                                                                    </asp:DropDownList>
                                                                                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlOutFacility"
                                                                                                        Display="Dynamic" ErrorMessage="Select Departure Facility" Operator="NotEqual" ValidationGroup="saveShift"
                                                                                                        ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator><asp:DropDownList
                                                                                                            ID="ddlOutTime" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                                                        </asp:DropDownList>
                                                                                                    <asp:Label ID="lblOutTime" runat="server" Visible="False"></asp:Label><asp:CompareValidator
                                                                                                        ID="CompareValidator3" runat="server" ControlToValidate="ddlOutTime" Display="Dynamic"
                                                                                                        ErrorMessage="Select Departure Shift" Operator="NotEqual" ValidationGroup="saveShift"
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
                                                                                                        <asp:Label ID="Label3" runat="server" Text="Label" ForeColor="Red"></asp:Label></asp:Panel>
                                                                                                </ItemTemplate>
                                                                                                <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField>
                                                                                                <ItemTemplate>
                                                                                <br />
                                                                                                  <asp:HyperLink
                                                                                                            ID="lbDropAdhoc" runat="server" Visible="true" CssClass="linkButton" Font-Bold="true" NavigateUrl="~/AdhocRequest.aspx">Raise Aligned Unschedule Request</asp:HyperLink>
                                                                                                
                                                                                                  <asp:Panel ID="pnlCaption" runat="server" Visible="False">
                                                                                                        Shifts are appearing as per TAT.Please select the appropriate shift.</asp:Panel>
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField>
                                                                                                <ItemTemplate>
                                                                                                <br />
                                                                                                <br />
                                                                                                    <asp:Panel ID="pnlUnschedule" runat="server" Visible="true" GroupingText="Raise Unschedule Request" Font-Bold="true">
                                                                                                        <table >
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    Select Facility:
                                                                                                                </td>
                                                                                                                <td bgcolor="#339966">
                                                                                                                    <asp:DropDownList ID="ddlunscheduleFacility" runat="server" AppendDataBoundItems="true">
                                                                                                                    </asp:DropDownList>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td colspan="2" align="center" bgcolor="#339966">
                                                                                                                    <asp:Button ID="btnRaiseUnschedule"  runat="server" Text="Raise"
                                                                                                                        CssClass="Button" OnClick="btnRaiseUnschedule_Click" />
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </asp:Panel>
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                                            </asp:TemplateField>
                                                                                        </Fields>
                                                                                    </asp:DetailsView>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4">
                                                                        <table width="100%" cellpadding="0" cellspacing="0" class="footerInnserTable">
                                                                            <tr>
                                                                                <td class="blueFooterMiddleCenter">
                                                                                </td>
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
                                                                    <td class="blueHeaderMiddleLeft" width="1%">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td class="blueHeaderMiddleCenter" width="100%">
                                                                        Unschedule Drop Request
                                                                    </td>
                                                                    <td class="blueHeaderMiddleCenter1">
                                                                        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Window/CloseOut.gif"
                                                                            CssClass="ButtonCloseOver" />
                                                                    </td>
                                                                    <td class="blueHeaderMiddleRight" width="1%">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" class="contenttableBorber">
                                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                                            <tr>
                                                                                <td class="contentInnerTable">
                                                                                    <asp:Label ID="lblUnscheduleMsg" runat="server" Visible="false"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="contentInnerTable">
                                                                                    <asp:Panel ID="pnlRaise" runat="server" Visible="false">
                                                                                        <table>
                                                                                            <tr>
                                                                                                <td align="center">
                                                                                                    <asp:Label ID="lblStatus" runat="server"></asp:Label>
                                                                                                    <asp:DropDownList ID="ddlShiftAvailable" runat="server">
                                                                                                    </asp:DropDownList>
                                                                                                </td>
                                                                                            </tr>
                                                                                            
                                                                                            <tr>
                                                                                                <td align="center">
                                                                                                    <asp:Button ID="btnAccept" runat="server" Text="Accept" CssClass="Button" OnClick="btnAccept_Click" />
                                                                                                    &nbsp;
                                                                                                    <asp:Button ID="btnReject" runat="server" Text="Reject" CssClass="Button" />
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                            <td align="left">
                                                                                            <br />
                                                                                            <font color="red">Note:Please Enable(Always Allow Pop-Up For this website).</font>
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
                                                                                <td class="blueFooterMiddleCenter">
                                                                                </td>
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
                        <asp:MultiView ID="MultiView4" runat="server">
                            <asp:View ID="View2" runat="server">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="Button4" runat="server" Style="visibility: hidden" />
                                            <cc1:ModalPopupExtender ID="ModalPopupExtender4" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                                TargetControlID="Button4" PopupControlID="Panel6" CancelControlID="ImageButton3">
                                            </cc1:ModalPopupExtender>
                                            <table cellpadding="0" cellspacing="0" width="60%">
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="Panel6" runat="server" CssClass="modal" Width="90%">
                                                            <table cellpadding="0" cellspacing="0" width="100%" align="center">
                                                                <tr>
                                                                    <td class="blueHeaderMiddleLeft" width="1%">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td class="blueHeaderMiddleCenter" width="100%">
                                                                        Unschedule Drop Request Information
                                                                    </td>
                                                                    <td class="blueHeaderMiddleCenter1">
                                                                        <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/images/Window/CloseOut.gif"
                                                                            CssClass="ButtonCloseOver" />
                                                                    </td>
                                                                    <td class="blueHeaderMiddleRight" width="1%">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" class="contenttableBorber">
                                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                                            <tr>
                                                                                <td class="contentInnerTable">
                                                                                    <asp:GridView ID="GvUnschedule" runat="server" ShowFooter="true" AutoGenerateColumns="false"
                                                                                        EmptyDataText="No Request Found!!" Width="50%">
                                                                                        <Columns>
                                                                                            <asp:TemplateField HeaderText="RequestID">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="lblRequestID" runat="server" Text='<%# Eval("ID") %>'></asp:Label></ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:BoundField DataField="empCode" HeaderText="PartnerID" />
                                                                                            <asp:BoundField DataField="empName" HeaderText="PartnerName" />
                                                                                            <asp:BoundField DataField="ShiftDate" HeaderText="ShiftDate" />
                                                                                            <asp:BoundField DataField="Shift" HeaderText="Shift" />
                                                                                            <asp:BoundField DataField="facilityName" HeaderText="Facility" />
                                                                                            <asp:TemplateField HeaderText="Print">
                                                                                                <ItemTemplate>
                                                                                                    <asp:LinkButton ID="lbTakePrint" runat="server" OnClick="lbTakePrint_Click" >
                                                                                                         Print</asp:LinkButton></ItemTemplate>
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
                                                                <tr>
                                                                    <td colspan="4">
                                                                        <table width="100%" cellpadding="0" cellspacing="0" class="footerInnserTable">
                                                                            <tr>
                                                                                <td class="blueFooterMiddleCenter">
                                                                                </td>
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
                             <asp:MultiView ID="MultiView6" runat="server">
                            <asp:View ID="View6" runat="server">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="Button5" runat="server" Style="visibility: hidden" />
                                            <cc1:ModalPopupExtender ID="ModalPopupExtender5" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                                TargetControlID="Button5" PopupControlID="Panel7" CancelControlID="ImageButton4">
                                            </cc1:ModalPopupExtender>
                                            <table cellpadding="0" cellspacing="0" width="60%">
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="Panel7" runat="server" CssClass="modal" Width="90%">
                                                            <table cellpadding="0" cellspacing="0" width="100%" align="center">
                                                                <tr>
                                                                    <td class="blueHeaderMiddleLeft" width="1%">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td class="blueHeaderMiddleCenter" width="100%">
                                                                         Select the Partner for which seperate cab request have to be made
                                                                    </td>
                                                                    <td class="blueHeaderMiddleCenter1">
                                                                        <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/images/Window/CloseOut.gif"
                                                                            CssClass="ButtonCloseOver" />
                                                                    </td>
                                                                    <td class="blueHeaderMiddleRight" width="1%">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" class="contenttableBorber">
                                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                                            <tr>
                                                                            <td align="center">
                                                                           
                                                                            </td>
                                                                            </tr>
                                                                            <tr align="center">
                                                                                <td align="center">
                                                                                    <asp:GridView ID="GVSeperate" runat="server" ShowFooter="true" AutoGenerateColumns="false"
                                                                                        EmptyDataText="No Request Found!!" Width="50%" DataKeyNames="EmployeeId">
                                                                                        <Columns>
                                                                                              <asp:TemplateField HeaderText="ID">
                                                        <ItemStyle Width="20px" />
                                                       
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkBxEmpId" runat="server" />
                                                            <asp:Label runat="server" ID="EmpID" Text='<%# Eval( "EmployeeId" ) %>' Visible="false"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="G">
                                                        <ItemStyle Width="10px" />
                                                        <ItemTemplate>
                                                            <img id="imgGeoCode" src='<%# CheckImage(DataBinder.Eval(Container.DataItem, "geoCode")) %>'
                                                                alt='<%# CheckAltGeocode(DataBinder.Eval(Container.DataItem, "geoCode")) %>' width="15" height="15" /><br />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="T">
                                                        <ItemStyle Width="10px" />
                                                        <ItemTemplate>
                                                            <img id="imgTptReq" src='<%# CheckTptReq(DataBinder.Eval(Container.DataItem, "tptReq")) %>'
                                                                alt='<%# CheckAltTptReq(DataBinder.Eval(Container.DataItem, "tptReq")) %>' width="15" height="15" /><br />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Partner Name">
                                                        <ItemStyle Width="160px" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lnkBtnEmpName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EmpName") %>'></asp:Label></ItemTemplate>
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
                                                                            <tr align="center">
                                                                            <td align="center">Select Facility:
                                                                              <asp:DropDownList ID="ddlSeperateCabFacility" runat="server" AppendDataBoundItems="true">
                                                                                                                    </asp:DropDownList>
                                                                            </td>
                                                                            </tr>
                                                                            <tr>
                                                                            <td align="center">
                                                                            <br />
                                                                            </td>
                                                                            </tr>
                                                                            <tr>
                                                                                            <td align="center">
                                                                                             Reason:   <asp:TextBox ID="txtreason" runat="server"></asp:TextBox>
                                                                                            </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                            <td align="center">
                                                                            <br />
                                                                            </td>
                                                                            </tr>
                                                                            <tr>
                                                                            <td align="center">
                                                                                <asp:Button ID="btnRaiseSeperateCab"  runat="server" Text="Raise"
                                                                                                                        CssClass="Button" 
                                                                                    onclick="btnRaiseSeperateCab_Click" />
                                                                            </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4">
                                                                        <table width="100%" cellpadding="0" cellspacing="0" class="footerInnserTable">
                                                                            <tr>
                                                                                <td class="blueFooterMiddleCenter">
                                                                                </td>
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
                         <asp:MultiView ID="MultiView7" runat="server">
                            <asp:View ID="View7" runat="server">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="Button6" runat="server" Style="visibility: hidden" />
                                            <cc1:ModalPopupExtender ID="ModalPopupExtender6" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                                TargetControlID="Button6" PopupControlID="Panel8" CancelControlID="ImageButton5">
                                            </cc1:ModalPopupExtender>
                                            <table cellpadding="0" cellspacing="0" width="60%">
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="Panel8" runat="server" CssClass="modal" Width="90%">
                                                            <table cellpadding="0" cellspacing="0" width="100%" align="center">
                                                                <tr>
                                                                    <td class="blueHeaderMiddleLeft" width="1%">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td class="blueHeaderMiddleCenter" width="100%">
                                                                         Select the Partner for which IOS Shuttle Request have to be made
                                                                    </td>
                                                                    <td class="blueHeaderMiddleCenter1">
                                                                        <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/images/Window/CloseOut.gif"
                                                                            CssClass="ButtonCloseOver" />
                                                                    </td>
                                                                    <td class="blueHeaderMiddleRight" width="1%">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" class="contenttableBorber">
                                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                                            <tr>
                                                                            <td align="center">
                                                                           
                                                                            </td>
                                                                            </tr>
                                                                            <tr align="center">
                                                                                <td align="center">
                                                                                    <asp:GridView ID="GvShuttle" runat="server" ShowFooter="true" AutoGenerateColumns="false"
                                                                                        EmptyDataText="No Request Found!!" Width="50%" DataKeyNames="EmployeeId">
                                                                                        <Columns>
                                                                                              <asp:TemplateField HeaderText="ID">
                                                        <ItemStyle Width="20px" />
                                                       
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkBxEmpId" runat="server" />
                                                            <asp:Label runat="server" ID="EmpID" Text='<%# Eval( "EmployeeId" ) %>' Visible="false"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="G">
                                                        <ItemStyle Width="10px" />
                                                        <ItemTemplate>
                                                            <img id="imgGeoCode" src='<%# CheckImage(DataBinder.Eval(Container.DataItem, "geoCode")) %>'
                                                                alt='<%# CheckAltGeocode(DataBinder.Eval(Container.DataItem, "geoCode")) %>' width="15" height="15" /><br />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="T">
                                                        <ItemStyle Width="10px" />
                                                        <ItemTemplate>
                                                            <img id="imgTptReq" src='<%# CheckTptReq(DataBinder.Eval(Container.DataItem, "tptReq")) %>'
                                                                alt='<%# CheckAltTptReq(DataBinder.Eval(Container.DataItem, "tptReq")) %>' width="15" height="15" /><br />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Partner Name">
                                                        <ItemStyle Width="160px" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lnkBtnEmpName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EmpName") %>'></asp:Label></ItemTemplate>
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
                                                                            <tr align="center">
                                                                            <td align="center">Select Destination Facility:
                                                                              <asp:DropDownList ID="ddlShuttleFacility" runat="server" 
                                                                                    AppendDataBoundItems="true" AutoPostBack="true" 
                                                                                    onselectedindexchanged="ddlShuttleFacility_SelectedIndexChanged">
                                                                                                                    </asp:DropDownList>
                                                                            </td>
                                                                            </tr>
                                                                             <tr>
                                                                            <td align="center">
                                                                            <br />
                                                                            </td>
                                                                            </tr>
                                                                            <tr align="center">
                                                                            <td align="center">Select Shifts:
                                                                              <asp:DropDownList ID="ddlShiftsShuttle" runat="server" AppendDataBoundItems="true" >
                                                                                                                    </asp:DropDownList>
                                                                            </td>
                                                                            </tr>
                                                                            <tr>
                                                                            <td align="center">
                                                                            <br />
                                                                            </td>
                                                                            </tr>
                                                                            <tr>
                                                                            <td align="center">
                                                                                <asp:Button ID="btnShuttle"  runat="server" Text="Raise"
                                                                                                                        CssClass="Button" 
                                                                                    onclick="btnShuttle_Click" />
                                                                            </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4">
                                                                        <table width="100%" cellpadding="0" cellspacing="0" class="footerInnserTable">
                                                                            <tr>
                                                                                <td class="blueFooterMiddleCenter">
                                                                                </td>
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
                             <asp:MultiView ID="MultiView8" runat="server">
                            <asp:View ID="View8" runat="server">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="Button7" runat="server" Style="visibility: hidden" />
                                            <cc1:ModalPopupExtender ID="ModalPopupExtender7" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                                TargetControlID="Button7" PopupControlID="Panel9" CancelControlID="ImageButton6">
                                            </cc1:ModalPopupExtender>
                                            <table cellpadding="0" cellspacing="0" width="60%">
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="Panel9" runat="server" CssClass="modal" Width="90%">
                                                            <table cellpadding="0" cellspacing="0" width="100%" align="center">
                                                                <tr>
                                                                    <td class="blueHeaderMiddleLeft" width="1%">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td class="blueHeaderMiddleCenter" width="100%">
                                                                        IOS Shuttle Request Information
                                                                    </td>
                                                                    <td class="blueHeaderMiddleCenter1">
                                                                        <asp:ImageButton ID="ImageButton6" runat="server" ImageUrl="~/images/Window/CloseOut.gif"
                                                                            CssClass="ButtonCloseOver" />
                                                                    </td>
                                                                    <td class="blueHeaderMiddleRight" width="1%">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" class="contenttableBorber">
                                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                                            <tr>
                                                                                <td class="contentInnerTable">
                                                                                    <asp:GridView ID="GvShuttleDetails" runat="server" ShowFooter="true" AutoGenerateColumns="false"
                                                                                        EmptyDataText="No Request Found!!" Width="50%" DataKeyNames="ID">
                                                                                        <Columns>
                                                                                            <asp:TemplateField HeaderText="RequestID">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="lblRequestID" runat="server" Text='<%# Eval("ID") %>'></asp:Label></ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:BoundField DataField="empCode" HeaderText="PartnerID" />
                                                                                            <asp:BoundField DataField="empName" HeaderText="PartnerName" />
                                                                                            <asp:BoundField DataField="ShiftDate" HeaderText="ShiftDate" />
                                                                                            <asp:BoundField DataField="Shift" HeaderText="Shift" />
                                                                                            <asp:BoundField DataField="facilityName" HeaderText="Facility" />
                                                                                           <asp:TemplateField>
                                                                                           <ItemTemplate>
                                                                                               <asp:LinkButton ID="lblCancel" runat="server" 
                                                                                                   Enabled='<%# Geticon(DataBinder.Eval(Container.DataItem, "cancel")) %>' 
                                                                                                   onclick="lblCancel_Click">Cancel</asp:LinkButton>
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
                                                                <tr>
                                                                    <td colspan="4">
                                                                        <table width="100%" cellpadding="0" cellspacing="0" class="footerInnserTable">
                                                                            <tr>
                                                                                <td class="blueFooterMiddleCenter">
                                                                                </td>
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
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
