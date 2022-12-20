<%@ Page Title="New Schedule" Language="C#" MasterPageFile="~/Header.Master" AutoEventWireup="true"
    CodeFile="NewScheduler.aspx.cs" Inherits="NewScheduler" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
    <style type="text/css">
        .style1
        {
            width: 128px;
        }
        .style2
        {
            width: 137px;
        }
        .style5
        {
            height: 37px;
        }
    </style>

    <script type="text/javascript">
        function check() {



            var lstGroups = document.getElementById('<%=chkWeeklyOff.ClientID%>');
            chkboxcount = lstGroups.getElementsByTagName("input");
            //  alert(chkboxcount);
            var ddllogout = document.getElementById('<%= ddlEndLogout.ClientID%>');
            var ddllogin = document.getElementById('<%= ddlEndLogin.ClientID%>');
            var loginvalidator = document.getElementById('<%=CompareValidator4.ClientID %>');
            var logoutvalidator = document.getElementById('<%=CompareValidator6.ClientID %>');
            if (chkboxcount[5].checked == true) {
                if (chkboxcount[6].checked == false) {

                    ddllogin.disabled = false;
                    ddllogout.disabled = false;
                    ValidatorEnable(loginvalidator, true);
                    ValidatorEnable(logoutvalidator, true);



                }
                else {
                    ddllogin.disabled = true;
                    ddllogout.disabled = true;
                    ddllogin.value = "0";
                    ddllogout.value = "0";
                    ValidatorEnable(loginvalidator, false);
                    ValidatorEnable(logoutvalidator, false);


                }
            }
            else {

                ddllogin.disabled = false;
                ddllogout.disabled = false;
                ValidatorEnable(loginvalidator, true);
                ValidatorEnable(logoutvalidator, true);


            }

            if (chkboxcount[6].checked == true) {
                if (chkboxcount[5].checked == false) {
                    ddllogin.disabled = false;
                    ddllogout.disabled = false;
                    ValidatorEnable(loginvalidator, true);
                    ValidatorEnable(logoutvalidator, true);

                }
                else {
                    ddllogin.disabled = true;
                    ddllogout.disabled = true;
                    ddllogin.value = "0";
                    ddllogout.value = "0";
                    ValidatorEnable(loginvalidator, false);
                    ValidatorEnable(logoutvalidator, false);
                }
            }
            else {
                ddllogin.disabled = false;
                ddllogout.disabled = false;
                ValidatorEnable(loginvalidator, true);
                ValidatorEnable(logoutvalidator, true);
            }
        }
        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <table align="left" cellpadding="4" cellspacing="0" width="100%">
                <tr>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="PageSize" />
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" DisplayMode="BulletList"
                        EnableClientScript="true" ValidationGroup="SetAll" ShowMessageBox="True" ShowSummary="False" />
                    <td  colspan="4">                        
                        <div class="gradient2">
                            <h1>
                                <span></span>Employee Transport New Schedule</h1>
                            <h2>
                                Allows to make New Schedule</h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="4">
                        <asp:ValidationSummary ID="ValidationSummary3" runat="server" DisplayMode="BulletList"
                            EnableClientScript="true" HeaderText="Please correct the following information : "
                            ValidationGroup="save" ShowMessageBox="True" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <table align="left" cellpadding="4" cellspacing="0" width="100%" class="tableBorber">
                            <tr>
                                <td colspan="6" class="TDbg" align="center">
                                    Select Shift Schedule Details
                                </td>
                            </tr>
                            <tr>
                                <td align="left" valign="middle" width="18%">
                                    <b>From Date: </b>
                                </td>
                                <td align="left" valign="middle" colspan="5">
                                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="TextBox"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBtnCalendar" runat="server" ImageUrl="Images/calendar_icon.gif"
                                        Height="17px" Width="17px" />
                                    <i>&nbsp;(mm/dd/yyyy)</i>
                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Animated="True" TargetControlID="txtFromDate"
                                        PopupButtonID="ImgBtnCalendar" />
                                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtFromDate"
                                        Type="Date" ValidationGroup="save">*
                                    </asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" valign="middle">
                                    <b>To Date: </b>
                                </td>
                                <td align="left" valign="middle" colspan="5">
                                    <asp:TextBox ID="txtToDate" runat="server" AutoPostBack="False" CssClass="TextBox"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBtnCalendar2" runat="server" ImageUrl="Images/calendar_icon.gif"
                                        Height="17px" Width="17px" />
                                    <i>&nbsp;(mm/dd/yyyy)</i>
                                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Animated="False" TargetControlID="txtToDate"
                                        PopupButtonID="ImgBtnCalendar2" />
                                    <asp:CompareValidator ID="CompareValidator15" runat="server" ControlToCompare="txtFromDate"
                                        ControlToValidate="txtToDate" ErrorMessage="To Date cannot be less than From Date."
                                        Operator="GreaterThanEqual" SetFocusOnError="True" Type="Date" ValidationGroup="save">*</asp:CompareValidator>
                                    <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="txtToDate"
                                        Type="Date" ValidationGroup="save">*
                                    </asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" valign="middle">
                                    <b>Weekly Off: </b>
                                </td>
                                <td align="left" valign="middle" colspan="5">
                                    <asp:CheckBoxList ID="chkWeeklyOff" runat="server" RepeatDirection="Horizontal" Width="80%"
                                        AutoPostBack="False">
                                        <asp:ListItem Text="Mon" Value="2">Mon</asp:ListItem>
                                        <asp:ListItem Text="Tues" Value="3">Tues</asp:ListItem>
                                        <asp:ListItem Text="Wed" Value="4">Wed</asp:ListItem>
                                        <asp:ListItem Text="Thur" Value="5">Thur</asp:ListItem>
                                        <asp:ListItem Text="Fri" Value="6">Fri</asp:ListItem>
                                        <asp:ListItem Text="Sat" Value="7" Selected="True" onclick="check()">Sat</asp:ListItem>
                                        <asp:ListItem Text="Sun" Value="1" Selected="True" onclick="check()">Sun</asp:ListItem>
                                    </asp:CheckBoxList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                </td>
                                <td rowspan="3" colspan="2">
                                    <table class="table" width="70%">
                                        <tr>
                                            <td colspan="2" align="center">
                                                <b>WeekDays</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="middle" class="style1">
                                                <b>Log-IN Shift:</b>
                                            </td>
                                            <td align="left" valign="middle" class="style2">
                                                <asp:DropDownList ID="ddlLogIn" runat="server" CssClass="DropDownListBox2" Height="18px">
                                                    <asp:ListItem Text="-Select-" Value="">-Select-</asp:ListItem>
                                                    <asp:ListItem Text="N/A" Value="N/A">N/A</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:CompareValidator ID="CompareValidatddlFacilityIn0" runat="server" ControlToValidate="ddlFacilityIn"
                                                    Display="Dynamic" ErrorMessage="Select Login Facility" Operator="NotEqual" ValidationGroup="save"
                                                    ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                <asp:CompareValidator ID="CompareValidatddlLogIn0" runat="server" ControlToValidate="ddlLogIn"
                                                    Display="Dynamic" ErrorMessage="Select Weekday Login Shift" Operator="NotEqual"
                                                    ValidationGroup="save" ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="middle" class="style1">
                                                <b>Log-Out Shift:</b>
                                            </td>
                                            <td align="left" valign="middle" class="style2">
                                                <asp:DropDownList ID="ddlLogOut" runat="server" CssClass="DropDownListBox2">
                                                    <asp:ListItem Value="">-Select-</asp:ListItem>
                                                    <asp:ListItem Text="N/A" Value="N/A">N/A</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:CompareValidator ID="CompareValidatorddlFacilityOut" runat="server" ControlToValidate="ddlFacilityOut"
                                                    Display="Dynamic" ErrorMessage="Select Logout Facility" Operator="NotEqual" ValidationGroup="save"
                                                    ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                <asp:CompareValidator ID="CompareValidatorddlLogOut" runat="server" ControlToValidate="ddlLogOut"
                                                    Display="Dynamic" ErrorMessage="Select weekday Logout Shift" Operator="NotEqual"
                                                    ValidationGroup="save" ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td rowspan="3">
                                    <table class="table">
                                        <tr>
                                            <td colspan="2" align="center">
                                                <b>Weekends</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="middle" class="style1">
                                                <b>Log-IN Shift:</b>
                                            </td>
                                            <td align="left" valign="middle" class="style2">
                                                <asp:DropDownList ID="ddlEndLogin" runat="server" CssClass="DropDownListBox2" Height="18px">
                                                    <asp:ListItem Text="-Select-" Value="0">-Select-</asp:ListItem>
                                                    <asp:ListItem Text="N/A" Value="N/A">N/A</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:CompareValidator ID="compareLogin" runat="server" ControlToValidate="ddlFacilityIn"
                                                    Display="Dynamic" ErrorMessage="Select Login Facility" Operator="NotEqual" ValidationGroup="save"
                                                    ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                <asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="ddlEndLogin"
                                                    Display="Dynamic" ErrorMessage="Select Weekend Login Shift" Operator="NotEqual"
                                                    ValidationGroup="save" ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="middle" class="style1">
                                                <b>Log-Out Shift:</b>
                                            </td>
                                            <td align="left" valign="middle" class="style2">
                                                <asp:DropDownList ID="ddlEndLogout" runat="server" CssClass="DropDownListBox2">
                                                    <asp:ListItem Value="0">-Select-</asp:ListItem>
                                                    <asp:ListItem Text="N/A" Value="N/A">N/A</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:CompareValidator ID="CompareValidator5" runat="server" ControlToValidate="ddlFacilityOut"
                                                    Display="Dynamic" ErrorMessage="Select Logout Facility" Operator="NotEqual" ValidationGroup="save"
                                                    ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                <asp:CompareValidator ID="CompareValidator6" runat="server" ControlToValidate="ddlEndLogout"
                                                    Display="Dynamic" ErrorMessage="Select Weekend Logout Shift" Operator="NotEqual"
                                                    ValidationGroup="save" ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" valign="middle">
                                    <b>Log-IN Facility:</b>
                                </td>
                                <td align="left" valign="middle" width="10%">
                                    <asp:DropDownList ID="ddlFacilityIn" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFacilityIn_SelectedIndexChanged"
                                        CssClass="DropDownListBox2" ToolTip="Select Login Facility">
                                        <asp:ListItem Text="-Select-" Value="">-Select-</asp:ListItem>
                                        <asp:ListItem Text="N/A" Value="N/A">N/A</asp:ListItem>
                                    </asp:DropDownList>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left" valign="middle">
                                    <b>Log-Out Facility:</b>
                                </td>
                                <td align="left" valign="middle">
                                    <asp:DropDownList ID="ddlFacilityOut" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlFacilityOut_SelectedIndexChanged"
                                        CssClass="DropDownListBox2" ToolTip="Select LogOut Facility">
                                        <asp:ListItem Value="">-Select-</asp:ListItem>
                                        <asp:ListItem Text="N/A" Value="N/A">N/A</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="3" class="style5">
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="100" AssociatedUpdatePanelID="UpdatePanel1"
                                        DynamicLayout="False">
                                        <ProgressTemplate>
                                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loding..." />
                                            Loading.....Please Wait!!!</ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                                <td align="right" colspan="3" class="style5">
                                    <asp:Button ID="btnGoBack" runat="server" CssClass="Button" PostBackUrl="~/MySchedule.aspx"
                                        Text="Go Back" />
                                    <asp:CustomValidator ID="CustomValidatorCheckBox" runat="server" ErrorMessage="Cannot proceed because either you did not choose any employee or any shift pattern."
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
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <table align="left" width="100%">
                                    <tr>
                                        <td align="left" valign="middle">
                                            <asp:GridView ID="grdEmployeeSchedule" runat="server" AutoGenerateColumns="False"
                                                AllowPaging="False" DataKeyNames="EmployeeId" CssClass="GridView" Width="100%"
                                                BorderWidth="0px" ShowFooter="True">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="ID" HeaderStyle-Width="10" ItemStyle-Width="10">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkBxHeader" AutoPostBack="true" OnCheckedChanged="CheckAll" runat="server" />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkBxEmpId" runat="server" />
                                                            <asp:Label runat="server" ID="EmpID" Text='<%# Eval( "EmployeeId" ) %>' Visible="false"></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="10px" />
                                                        <ItemStyle Width="10px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="" HeaderStyle-Width="10" ItemStyle-Width="10">
                                                        <ItemTemplate>
                                                            <img id="imgGeoCode" src='<%# CheckImage(DataBinder.Eval(Container.DataItem, "geoCode")) %>'
                                                                alt="GeoCode" width="15" height="15" /><br />
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="10px" />
                                                        <ItemStyle Width="10px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="" HeaderStyle-Width="10" ItemStyle-Width="10">
                                                        <ItemTemplate>
                                                            <img id="imgTptReq" src='<%# CheckTptReq(DataBinder.Eval(Container.DataItem, "tptReq")) %>'
                                                                alt="Transport Required" width="15" height="15" /><br />
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="10px" />
                                                        <ItemStyle Width="10px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Employee Details" HeaderStyle-Width="90%" ItemStyle-Width="90%">
                                                        <ItemTemplate>
                                                            <%# DataBinder.Eval(Container.DataItem, "EmpName") %>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="90%" />
                                                        <ItemStyle Width="90%" />
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
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" valign="middle">
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
                        <asp:Button ID="Button1" runat="server" Style="visibility: hidden" />
                        <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                            TargetControlID="Button1" PopupControlID="Panel3" CancelControlID="ibtnexit"
                            DropShadow="True">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="Panel3" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                            Style="visibility: hidden">
                            <table width="400px" style="border: 1px ridge #000000" cellpadding="0" cellspacing="0">
                                <tr bgcolor="#003366" height="20">
                                    <td align="left" style="color: #FFFFFF">
                                        <b>Following associate roster cannot update because of they are falling under non hiring
                                            zone. </b>
                                    </td>
                                    <td align="right" width="10%">
                                        <asp:ImageButton ID="ibtnexit" runat="server" ImageUrl="images/Exit.jpg" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:GridView ID="grdScheduleNotUpdated" runat="server" ShowFooter="True" CssClass="GridView"
                                            Width="100%" HorizontalAlign="Center">
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
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
