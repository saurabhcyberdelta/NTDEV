<%@ Page Title="My Schedule" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="MySchedule.aspx.cs" Inherits="MySchedule" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
    
    
    <style type="text/css">
        #imgTptReq
        {
            height: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table  border="0" width="100%">
        <asp:Label ID="lblErrorMsg" runat="server" Visible="False" CssClass="error"></asp:Label>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
            ShowSummary="False" ValidationGroup="PageSize" />
        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
            ShowSummary="False" ValidationGroup="SaveMobile" />
        <asp:ValidationSummary ID="ValidationSummary3" runat="server" ShowMessageBox="True"
            ShowSummary="False" ValidationGroup="saveShift" />
        <asp:ValidationSummary ID="ValidationSummary4" runat="server" ShowMessageBox="True"
            ShowSummary="False" ValidationGroup="Submit" />
        <tr>
            <td class="heading">
                <div class="gradient2">
                    <h1>
                        <span></span>View/Edit Transport Schedule</h1>
                    <h2>
                        Allows Employee/Manager to View/Edit Schedule Details</h2>
                </div>
            </td>
        </tr>
        <tr>
            <td align="left">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                            <asp:View ID="View1" runat="server">
                                <table width="100%" align="center">
                                    <tr>
                                        <td align="center" valign="middle" width="80%">
                                            <strong>From Date:</strong>
                                            <asp:TextBox ID="txtCalendar" runat="server" AutoPostBack="True" OnTextChanged="txtCalendar_TextChanged"
                                                CssClass="TextBox" CausesValidation="True" ValidationGroup="Submit"></asp:TextBox>
                                            <asp:ImageButton ID="ImgBtnCalendar" runat="server" ImageUrl="Images/calendar_icon.gif"
                                                Height="17px" Width="17px" />
                                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Animated="False" TargetControlID="txtCalendar"
                                                PopupButtonID="ImgBtnCalendar" />
                                            &nbsp;<i>(mm/dd/yyyy)</i>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtCalendar"
                                                Display="Dynamic" ErrorMessage="Enter Date Format:mm/dd/yyyy" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                ValidationGroup="Submit" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter From Date"
                                                ControlToValidate="txtCalendar" ValidationGroup="Submit" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                        </td>
                                        <td align="right" valign="middle" width="20%">
                                            <asp:Button ID="btnNewSchedule" runat="server" CssClass="Button" Text="New Schedule"
                                                PostBackUrl="~/NewScheduler.aspx" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="lblIsBlocked" runat="server" Font-Bold="True" ForeColor="Red" Visible="False"></asp:Label>
                                        </td>
                                        <td style="text-align: right; font-weight: 700;" align="right">
                                            Page Size<asp:TextBox ID="txt_PageSize" runat="Server" AutoPostBack="True" OnTextChanged="txt_PageSize_SelectedIndexChanged"
                                                Width="25" ValidationGroup="PageSize" CausesValidation="True" MaxLength="4"></asp:TextBox><asp:RangeValidator
                                                    ID="RangeValidator1" runat="server" ControlToValidate="txt_PageSize" ErrorMessage="Please provide page size as a numeric value Range: [10 and above]"
                                                    MaximumValue="100000" MinimumValue="10" SetFocusOnError="true" Type="Double"
                                                    ValidationGroup="PageSize">*</asp:RangeValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="2">
                                            <asp:GridView ID="grdEmployeeSchedule" runat="server" AutoGenerateColumns="False"
                                                AllowPaging="True" OnPageIndexChanging="grdEmployeeSchedule_PageIndexChanging"
                                                CssClass="GridView" ShowFooter="True" Width="100%" DataKeyNames="EmployeeID"
                                                OnRowDataBound="grdEmployeeSchedule_RowDataBound" BorderWidth="0px">
                                                <RowStyle CssClass="RowStyle" />
                                                <FooterStyle CssClass="FooterStyle" />
                                                <PagerStyle CssClass="PagerStyle" />
                                                <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                <HeaderStyle CssClass="HeaderStyle1" />
                                                <EditRowStyle BackColor="#999999" />
                                                <AlternatingRowStyle CssClass="AltRowStyle" />
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemStyle Width="20px" />
                                                        <ItemTemplate>
                                                            <img id="imgGeoCode" src='<%# CheckImage(DataBinder.Eval(Container.DataItem, "geoCode")) %>'
                                                                alt='<%# CheckAltGeocode(DataBinder.Eval(Container.DataItem, "geoCode")) %>' /><br />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemStyle Width="20px" />
                                                        <ItemTemplate>
                                                            <img id="imgTptReq" src='<%# CheckTptReq(DataBinder.Eval(Container.DataItem, "tptReq")) %>'
                                                                alt='<%# CheckAltTptReq(DataBinder.Eval(Container.DataItem, "tptReq")) %>' width="20"
                                                                height="10" /><br />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Employee Name">
                                                        <ItemStyle Width="200px" HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkBtnEmpName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EmpName") %>'
                                                                OnClick="lnkBtnEmpName_Click" CommandArgument='<%# Eval( "EmployeeId" ) %>' CssClass="linkButton"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In0">
                                                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkbtnSETime0" runat="server" Text='<%# (Eval("SETime0").ToString()!=""? Eval("SETime0").ToString().Substring(0, Eval("SETime0").ToString().IndexOf("!")):Eval("SETime0"))%>'
                                                                OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(0) %>' CssClass="linkButton"
                                                                Enabled='<%# GetEnableOrNot(0) %>'></asp:LinkButton>
                                                            <br />
                                                            <asp:ImageButton ID="imgBtnRouteIn0" ImageUrl="~/Images/TptReq.gif" Height="10px"
                                                                Width="20px" Visible='<%# (Eval("SETime0").ToString()!=""?(Eval("SETime0").ToString().Substring(Eval("SETime0").ToString().IndexOf("!") + 1, Eval("SETime0").ToString().Length - (Eval("SETime0").ToString().IndexOf("!") + 1))).Trim()== "false" ?false:true:false) %>'
                                                                OnClick="imgBtnRoute_Click" runat="server" CommandArgument='<%# GetShiftdate(0) %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In1">
                                                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkbtnSETime1" runat="server" Text='<%# (Eval("SETime1").ToString() != string.Empty ? Eval("SETime1").ToString().Substring(0, Eval("SETime1").ToString().IndexOf("!")) : Eval("SETime1"))%>'
                                                                OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(1) %>' CssClass="linkButton"
                                                                Enabled='<%# GetEnableOrNot(1) %>'></asp:LinkButton>
                                                            <br />
                                                            <asp:ImageButton ID="imgBtnRouteIn1" ImageUrl="~/Images/TptReq.gif" Height="10px"
                                                                Width="20px" Visible='<%# (Eval("SETime1").ToString()!=""?(Eval("SETime1").ToString().Substring(Eval("SETime1").ToString().IndexOf("!") + 1, Eval("SETime1").ToString().Length - (Eval("SETime1").ToString().IndexOf("!") + 1))).Trim()== "false" ?false:true:false) %>'
                                                                OnClick="imgBtnRoute_Click" runat="server" CommandArgument='<%# GetShiftdate(1) %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In2">
                                                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkbtnSETime2" runat="server" Text='<%# (Eval("SETime2").ToString() != string.Empty ? Eval("SETime2").ToString().Substring(0, Eval("SETime2").ToString().IndexOf("!")) : Eval("SETime2"))%>'
                                                                OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(2) %>' CssClass="linkButton"
                                                                Enabled='<%# GetEnableOrNot(2) %>'></asp:LinkButton>
                                                            <br />
                                                            <asp:ImageButton ID="imgBtnRouteIn2" ImageUrl="~/Images/TptReq.gif" Height="10px"
                                                                Width="20px" Visible='<%# (Eval("SETime2").ToString()!=""?(Eval("SETime2").ToString().Substring(Eval("SETime2").ToString().IndexOf("!") + 1, Eval("SETime2").ToString().Length - (Eval("SETime2").ToString().IndexOf("!") + 1))).Trim()== "false" ?false:true:false) %>'
                                                                OnClick="imgBtnRoute_Click" runat="server" CommandArgument='<%# GetShiftdate(2) %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In3">
                                                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkbtnSETime3" runat="server" Text='<%# (Eval("SETime3").ToString() != string.Empty ? Eval("SETime3").ToString().Substring(0, Eval("SETime3").ToString().IndexOf("!")) : Eval("SETime3"))%>'
                                                                OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(3) %>' CssClass="linkButton"
                                                                Enabled='<%# GetEnableOrNot(3) %>'></asp:LinkButton>
                                                            <br />
                                                            <asp:ImageButton ID="imgBtnRouteIn3" ImageUrl="~/Images/TptReq.gif" Height="10px"
                                                                Width="20px" Visible='<%# (Eval("SETime3").ToString()!=""?(Eval("SETime3").ToString().Substring(Eval("SETime3").ToString().IndexOf("!") + 1, Eval("SETime3").ToString().Length - (Eval("SETime3").ToString().IndexOf("!") + 1))).Trim()== "false" ?false:true:false) %>'
                                                                OnClick="imgBtnRoute_Click" runat="server" CommandArgument='<%# GetShiftdate(3) %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In4">
                                                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkbtnSETime4" runat="server" Text='<%# (Eval("SETime4").ToString() != string.Empty ? Eval("SETime4").ToString().Substring(0, Eval("SETime4").ToString().IndexOf("!")) : Eval("SETime4"))%>'
                                                                OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(4) %>' CssClass="linkButton"
                                                                Enabled='<%# GetEnableOrNot(4) %>'></asp:LinkButton>
                                                            <br />
                                                            <asp:ImageButton ID="imgBtnRouteIn4" ImageUrl="~/Images/TptReq.gif" Height="10px"
                                                                Width="20px" Visible='<%# (Eval("SETime4").ToString()!=""?(Eval("SETime4").ToString().Substring(Eval("SETime4").ToString().IndexOf("!") + 1, Eval("SETime4").ToString().Length - (Eval("SETime4").ToString().IndexOf("!") + 1))).Trim()== "false" ?false:true:false) %>'
                                                                OnClick="imgBtnRoute_Click" runat="server" CommandArgument='<%# GetShiftdate(4) %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In5">
                                                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkbtnSETime5" runat="server" Text='<%# (Eval("SETime5").ToString() != string.Empty ? Eval("SETime5").ToString().Substring(0, Eval("SETime5").ToString().IndexOf("!")) : Eval("SETime5"))%>'
                                                                OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(5) %>' CssClass="linkButton"
                                                                Enabled='<%# GetEnableOrNot(5) %>'></asp:LinkButton>
                                                            <br />
                                                            <asp:ImageButton ID="imgBtnRouteIn5" ImageUrl="~/Images/TptReq.gif" Height="10px"
                                                                Width="20px" Visible='<%# (Eval("SETime5").ToString()!=""?(Eval("SETime5").ToString().Substring(Eval("SETime5").ToString().IndexOf("!") + 1, Eval("SETime5").ToString().Length - (Eval("SETime5").ToString().IndexOf("!") + 1))).Trim()== "false" ?false:true:false) %>'
                                                                OnClick="imgBtnRoute_Click" runat="server" CommandArgument='<%# GetShiftdate(5) %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="In6">
                                                        <FooterTemplate>
                                                            <footertemplate>
                                                                <asp:Label ID="lblRecordsPerPage" runat="server" ToolTip="Records Per Page"></asp:Label>
                                                            </footertemplate>
                                                        </FooterTemplate>
                                                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkbtnSETime6" runat="server" Text='<%# (Eval("SETime6").ToString() != string.Empty ? Eval("SETime6").ToString().Substring(0, Eval("SETime6").ToString().IndexOf("!")) : Eval("SETime6"))%>'
                                                                OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(6) %>' CssClass="linkButton"
                                                                Enabled='<%# GetEnableOrNot(6) %>'></asp:LinkButton>
                                                            <br />
                                                            <asp:ImageButton ID="imgBtnRouteIn6" ImageUrl="~/Images/TptReq.gif" Height="10px"
                                                                Width="20px" Visible='<%# (Eval("SETime6").ToString()!=""?(Eval("SETime6").ToString().Substring(Eval("SETime6").ToString().IndexOf("!") + 1, Eval("SETime6").ToString().Length - (Eval("SETime6").ToString().IndexOf("!") + 1))).Trim()== "false" ?false:true:false) %>'
                                                                OnClick="imgBtnRoute_Click" runat="server" CommandArgument='<%# GetShiftdate(6) %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <table align="center" width="80%">
                                    <tr>
                                        <td align="center">
                                            <asp:DetailsView ID="DvGeo" runat="server" AutoGenerateRows="False" DefaultMode="Insert"
                                                HeaderText="Employee Details" OnModeChanging="DvGeo_ModeChanging" Width="500px"
                                                DataKeyNames="id" BorderWidth="0px">
                                                <Fields>
                                                    <asp:TemplateField HeaderText="Employee ID:">
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
                                                    <asp:TemplateField HeaderText="Facility:">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldvfacility" runat="server" Width="80%"></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
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
                                                    <asp:TemplateField HeaderText="Mobile:">
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblMobile" runat="server"></asp:Label>
                                                            <asp:TextBox ID="txtMobile" runat="server" Visible="False" CssClass="TextBox" MaxLength="10"
                                                                Width="80px"></asp:TextBox>
                                                            <asp:LinkButton ID="lbEditMobile" runat="server" OnClick="lbEditMobile_Click" CssClass="linkButton">Edit</asp:LinkButton>
                                                            <asp:LinkButton ID="lbSaveMobile" runat="server" Visible="False" ValidationGroup="SaveMobile"
                                                                OnClick="lbSaveMobile_Click" CssClass="linkButton">Save</asp:LinkButton>
                                                            <asp:LinkButton ID="lbCancelMobile" runat="server" Visible="False" OnClick="lbCancelMobile_Click"
                                                                CssClass="linkButton">Cancel</asp:LinkButton>
                                                            <asp:Image ID="imgStatus" runat="server" Visible="False" />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter the mobile no."
                                                                Display="Dynamic" ControlToValidate="txtMobile" ValidationGroup="SaveMobile"
                                                                SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Mobile no should have 10 digits no."
                                                                ControlToValidate="txtMobile" ValidationExpression="^((\+)?(\d{2}[-]))?(\d{10}){1}?$"
                                                                ValidationGroup="SaveMobile" Display="Dynamic" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                        </ItemTemplate>
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
                                                    <asp:TemplateField ShowHeader="False">
                                                        <InsertItemTemplate>
                                                            <asp:LinkButton ID="DvLnkBtnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                Text="Close"></asp:LinkButton>
                                                        </InsertItemTemplate>
                                                        <ItemTemplate>
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
                            </asp:View>
                        </asp:MultiView>
                        <asp:MultiView ID="MultiView3" runat="server">
                            <asp:View ID="View3" runat="server">
                                <asp:Button ID="btnHidden" runat="server" Style="visibility: hidden" />
                                <cc1:ModalPopupExtender ID="ModalPopupExtender" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                    Drag="True" TargetControlID="btnHidden" PopupControlID="modal" CancelControlID="btnClose">
                                </cc1:ModalPopupExtender>
                                <table cellpadding="0" cellspacing="0" width="90%" bgcolor="#E6E8E8">
                                    <tr>
                                        <td>
                                            <asp:Panel ID="modal" runat="server" CssClass="modal1">
                                                <table cellpadding="0" cellspacing="0" width="100%" align="center">
                                                    <tr>
                                                        <td class="blueHeaderMiddleLeft" width="1%">
                                                            &nbsp;
                                                        </td>
                                                        <td class="blueHeaderMiddleCenter" width="100%">
                                                            Display Route Information
                                                        </td>
                                                        <td class="blueHeaderMiddleCenter1">
                                                            <asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/images/Window/CloseOut.gif"
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
                                                                        <asp:Panel ID="Panel1" runat="server">
                                                                            <table class="tableBorber">
                                                                                <tr>
                                                                                    <td align="left" class="row1" colspan="7">
                                                                                        PickUp Route Information
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="left" class="myTableRowStyle" width="10%">
                                                                                        <b>RouteID:-</b>
                                                                                        <asp:Label ID="lblPickRouteID" runat="server" Text='<%# Eval("RouteID")%>'></asp:Label>
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
                                                                                        <asp:Label ID="lblPickStickerNo" runat="server" Text='<%# Eval("stickerNo")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td align="left" class="myTableRowStyle" width="10%">
                                                                                        <b>Facility:-</b>
                                                                                        <asp:Label ID="lblPickFacility" runat="server" Text='<%# Eval("facilityName")%>'></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="7">
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
                                                                                                <asp:TemplateField HeaderText="Employee Detail" SortExpression="empCode">
                                                                                                    <ItemTemplate>
                                                                                                        <div style="width: 200px;">
                                                                                                            <asp:Label ID="lblEmpName" Text='<%# Eval("EmpName") %>' runat="server"></asp:Label>
                                                                                                        </div>
                                                                                                    </ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="G" SortExpression="Gender">
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Label ID="lbgender" runat="server" Text='<%# Eval("Gender") %>' Width="20px"></asp:Label>
                                                                                                    </ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>' Width="400px"></asp:Label>
                                                                                                    </ItemTemplate>
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="">
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Label ID="lblTripType" runat="server" Text='<%# Eval("tripType") %>' Width="20px"></asp:Label>
                                                                                                    </ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="SNo" SortExpression="stopNo">
                                                                                                    <ItemTemplate>
                                                                                                        <%# Eval("stopNo")%>
                                                                                                    </ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="ETA" SortExpression="ETA">
                                                                                                    <ItemTemplate>
                                                                                                        <%# Eval("ETAhh")%>
                                                                                                        :
                                                                                                        <%# Eval("ETAmm")%>
                                                                                                    </ItemTemplate>
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
                                                                        <asp:Panel ID="Panel2" runat="server">
                                                                            <table class="tableBorber">
                                                                                <tr>
                                                                                    <td align="left" class="row2" colspan="7">
                                                                                        Drop Route Information
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="left" class="myTableAltRowStyle" width="10%">
                                                                                        <b>RouteID:-</b>
                                                                                        <asp:Label ID="lblDropRouteID" runat="server" Text='<%# Eval("RouteID")%>'></asp:Label>
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
                                                                                        <asp:Label ID="lblDropStickerNo" runat="server" Text='<%# Eval("stickerNo")%>'></asp:Label>
                                                                                    </td>
                                                                                    <td align="left" class="myTableAltRowStyle" width="10%">
                                                                                        <b>Facility:-</b>
                                                                                        <asp:Label ID="lblDropFacility" runat="server" Text='<%# Eval("facilityName")%>'></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="7">
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
                                                                                                <asp:TemplateField HeaderText="Employee Detail" SortExpression="empCode">
                                                                                                    <ItemTemplate>
                                                                                                        <div style="width: 200px;">
                                                                                                            <asp:Label ID="lblEmpName" Text='<%# Eval("EmpName") %>' runat="server"></asp:Label>
                                                                                                        </div>
                                                                                                    </ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="G" SortExpression="Gender">
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Label ID="lbgender" runat="server" Text='<%# Eval("Gender") %>' Width="20px"></asp:Label>
                                                                                                    </ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>' Width="400px"></asp:Label>
                                                                                                    </ItemTemplate>
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="">
                                                                                                    <ItemTemplate>
                                                                                                        <asp:Label ID="lblTripType" runat="server" Text='<%# Eval("tripType") %>' Width="20px"></asp:Label>
                                                                                                    </ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="SNo" SortExpression="stopNo">
                                                                                                    <ItemTemplate>
                                                                                                        <%# Eval("stopNo")%>
                                                                                                    </ItemTemplate>
                                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                                </asp:TemplateField>
                                                                                                <asp:TemplateField HeaderText="ETA" SortExpression="ETA">
                                                                                                    <ItemTemplate>
                                                                                                        <%# Eval("ETAhh")%>
                                                                                                        :
                                                                                                        <%# Eval("ETAmm")%>
                                                                                                    </ItemTemplate>
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
                                            <asp:Button ID="Button1" runat="server" Style="visibility: hidden" />
                                            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                                TargetControlID="Button1" PopupControlID="pnlModal" CancelControlID="ibtnSMclose">
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
                                                                        <table width="100%" cellpadding="0" cellspacing="0" >
                                                                            <tr>
                                                                                <td class="contentInnerTable" >
                                                                                    <asp:DetailsView ID="dvEditEmployeeSchedule" runat="server" AutoGenerateRows="False"
                                                                                        Width="80%" DefaultMode="Insert" Height="222px" HeaderText="Employee Shift Details">
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
                                                                                                <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField>
                                                                                                <ItemTemplate>
                                                                                                    <asp:Panel ID="pnlCaption" runat="server" Visible="False">
                                                                                                        Shifts are appearing as per TAT.Please select the appropriate shift.</asp:Panel>
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
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnNewSchedule" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0" AssociatedUpdatePanelID="UpdatePanel1">
                    <ProgressTemplate>
                        <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loding..." />
                        Loading.....Please Wait!!!</ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>
    </table>
</asp:Content>
