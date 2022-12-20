<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="TripSheetEntry.aspx.cs" Inherits="TripSheetEntry" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table align="center" width="100%">
                <tr>
                    <td align="center">
                        <table align="center" width="100%">
                            <tr>
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error" ShowMessageBox="True"
                                    ShowSummary="False" ValidationGroup="trip" />
                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="error" ShowMessageBox="True"
                                    ShowSummary="False" ValidationGroup="Search" />
                                <asp:ValidationSummary ID="ValidationSummary3" runat="server" CssClass="error" ShowMessageBox="True"
                                    ShowSummary="False" ValidationGroup="align" />
                               <asp:ValidationSummary ID="ValidationSummary4" runat="server" CssClass="error" ShowMessageBox="True"
                                    ShowSummary="False" ValidationGroup="Club" />    
                                <td align="center">
                                    <asp:Label ID="lblErrorMsg" runat="server" CssClass="error"></asp:Label>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="heading">
                                    <div class="gradient2">
                                        <h1>
                                            <span></span>TripSheet Entry
                                        </h1>
                                        <h2>
                                            Allows User to Enter Tripsheet Details.
                                        </h2>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Panel ID="Panel2" runat="server" DefaultButton="btnSearch">
                                        <table align="center">
                                            <tr>
                                              <td align="right">
                                        Facility:</td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlSelectFacility" runat="server" AutoPostBack="True" 
                                                onselectedindexchanged="ddlSelectFacility_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                                <td style="text-align: right">
                                                    Shift Date:
                                                </td>
                                                <td style="text-align: left">
                                                    <asp:TextBox ID="txtShiftDate" runat="server" MaxLength="10" Style="margin-left: 4px"
                                                        CssClass="TextBox" ValidationGroup="Search"></asp:TextBox>
                                                    <cc1:CalendarExtender ID="txtShiftDate_CalendarExtender" runat="server" Enabled="True"
                                                        Format="MM/dd/yyyy" TargetControlID="txtShiftDate" PopupButtonID="ibcal1">
                                                    </cc1:CalendarExtender>
                                                    <asp:ImageButton ID="ibcal1" runat="server" ImageUrl="~/images/calendar_icon.gif"
                                                        CssClass="ImageButton" />
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtShiftDate"
                                                        Display="Dynamic" ErrorMessage="Date Format is :mm/dd/yyyy" ValidationGroup="Search"
                                                        ValidationExpression="(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d"
                                                        SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                        
                                                </td>
                                                <td>
                                                 <asp:RadioButtonList ID="rdoTripType" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                                                AutoPostBack="True" OnSelectedIndexChanged="rdoTripType_SelectedIndexChanged">
                                                <asp:ListItem Selected="True" Value="P">Pick</asp:ListItem>
                                                <asp:ListItem Value="D">Drop</asp:ListItem>
                                            </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                 <asp:ListBox ID="lstShift" runat="server" AppendDataBoundItems="True" 
                                                        AutoPostBack="True" onselectedindexchanged="lstShift_SelectedIndexChanged" Visible="false">
                                                <asp:ListItem Selected="True" Value="0"></asp:ListItem>
                                            </asp:ListBox>
                                                </td>
                                                <td style="text-align: right">
                                                    Route Id:&nbsp;
                                                    <asp:Label ID="lblRouteId" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: left">
                                                    <asp:TextBox ID="txtRouteId" runat="server" MaxLength="4" Style="margin-left: 4px"
                                                        CssClass="TextBox" ValidationGroup="Search"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtRouteId"
                                                        Display="Dynamic" ErrorMessage="Please Enter RouteID." ValidationGroup="Search"
                                                        SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                </td>
                                                <td style="text-align: left">
                                                    <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search"
                                                        ValidationGroup="Search" CssClass="Button" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                                        DisplayAfter="0" DynamicLayout="False">
                                        <ProgressTemplate>
                                            <table align="center">
                                                <tr>
                                                    <td>
                                                        <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loading..." />
                                                    </td>
                                                    <td class="main_bg">
                                                        Loading.....Please Wait!!!
                                                    </td>
                                                </tr>
                                            </table>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:MultiView ID="MultiView1" runat="server">
                                        <asp:View ID="View1" runat="server">
                                            <asp:Panel ID="panelLink" runat="server" DefaultButton="btnSave">
                                                <table border="0" align="center" width="100%">
                                                    <tr>
                                                        <td align="center">
                                                            <asp:FormView ID="fvTrip" runat="server" DefaultMode="Edit" Width="100%" CellPadding="4"
                                                                ForeColor="#333333" DataKeyNames="shiftDate,shiftTime,tripType">
                                                                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                                                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />                                                                                                                              
                                                                <EditItemTemplate>
                                                                    <table border="1" cellpadding="4" cellspacing="0" width="100%" class="table" style="border: thin solid #000000">
                                                                        <tr>
                                                                            <td style="text-align: right">
                                                                               CABID
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                <asp:TextBox ID="txtCabID" runat="server"  CssClass="TextBox"  AutoPostBack="true"
                                                                                    ontextchanged="txtCabID_TextChanged" ></asp:TextBox> Reg No:
                                                                                <asp:TextBox ID="txtVehicleReg" runat="server" CssClass="TextBox"  Text='<%# Eval("vehicleId") %>'></asp:TextBox>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtVehicleReg"
                                                                                    Display="Dynamic" ErrorMessage="Enter Vehicle Number" SetFocusOnError="True"
                                                                                    ValidationGroup="trip">*</asp:RequiredFieldValidator>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCabID" ErrorMessage="Enter the CabID"
                                                                                ValidationGroup="trip" >*</asp:RequiredFieldValidator>
                                                                            </td>
                                                                            <td style="text-align: right">
                                                                                Vehicle Type:
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                            <asp:TextBox ID="txtVehicleType" runat="server"  enabled="false" ></asp:TextBox>
                                                                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtVehicleType" ErrorMessage="Enter the Vehicle Type"
                                                                                ValidationGroup="trip" >*</asp:RequiredFieldValidator>
                                                                                &nbsp; <font color="blue">Plan:
                                                                                    <%# Eval("PlanVehicleType")%>
                                                                                </font>
                                                                            </td>
                                                                             <td style="text-align: right">
                                                                                Vendor:
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                <asp:TextBox ID="txtVendor" runat="server"   enabled="false" ></asp:TextBox>
                                                                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtVendor" ErrorMessage="Enter the Vendor"
                                                                                ValidationGroup="trip" >*</asp:RequiredFieldValidator>
                                                                            </td>
                                                                           
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="text-align: right">
                                                                                Start KM:
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                <asp:TextBox ID="txtStartKm" runat="server" MaxLength="6" CssClass="TextBox" Text='<%# Eval("actStartKm") %>'></asp:TextBox>
                                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtStartKm"
                                                                                    ErrorMessage="Enter valid Start KM"  ValidationExpression="^\d+(?:\.\d{0,2})?$"
                                                                                    ValidationGroup="trip">*</asp:RegularExpressionValidator>
                                                                            </td>
                                                                            <td style="text-align: right">
                                                                                End KM:
                                                                            </td>
                                                                            <td style="text-align: left" valign="middle">
                                                                                <asp:TextBox ID="txtEndKm" runat="server" AutoPostBack="True" OnTextChanged="txtEndKM_TextChanged"
                                                                                    MaxLength="6" CssClass="TextBox" Text='<%# Eval("actEndKm") %>'></asp:TextBox>
                                                                                <asp:CompareValidator ID="CompareValidator8" runat="server" ControlToCompare="txtStartKm" Type="Double"
                                                                                    ControlToValidate="txtEndKm" Display="Dynamic" ErrorMessage="End Km Cannot be less than Start Km"
                                                                                    Operator="GreaterThanEqual" ValidationGroup="trip" >*</asp:CompareValidator>
                                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtEndKm"
                                                                                    ErrorMessage="Enter valid End KM" SetFocusOnError="True" ValidationExpression="^\d+(?:\.\d{0,2})?$"
                                                                                    ValidationGroup="trip" Display="Dynamic">*</asp:RegularExpressionValidator>
                                                                            </td>
                                                                            <td style="text-align: right">
                                                                                Shift Time:
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                <asp:Label ID="lblShiftTime" runat="server" Text='<%# Eval("shiftTime")+"-"+Eval("tripType")+"-"+Eval("facility") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="text-align: right">
                                                                                Act KM:
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                <asp:TextBox ID="txtActKm" runat="server" ReadOnly="True" CssClass="TextBox" Text='<%# Eval("actTotalKm") %>'></asp:TextBox>
                                                                            </td>
                                                                            <td style="text-align: right">
                                                                                Approved KM:
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                <asp:TextBox ID="txtAppKM" runat="server" MaxLength="6" Enabled="false" Text='<%# Eval("approvedKm") %>'></asp:TextBox>
                                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtAppKM"
                                                                                    ErrorMessage="Enter valid Approved KM" SetFocusOnError="True" ValidationExpression="^\d+(?:\.\d{0,2})?$"
                                                                                    ValidationGroup="trip">*</asp:RegularExpressionValidator>
                                                                            </td>
                                                                            <td style="text-align: right">
                                                                                Driver:
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                <asp:TextBox ID="txtDriver" runat="server" MaxLength="20" CssClass="TextBox" Text='<%# Eval("driver") %>'></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr valign="middle">
                                                                            <td style="text-align: right" valign="middle">
                                                                                Time IN:
                                                                            </td>
                                                                            <td style="text-align: left" valign="middle">
                                                                                <asp:TextBox ID="txtStartTime" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                <cc1:CalendarExtender ID="txtStartTime_CalendarExtender" runat="server" Format="MM/dd/yyyy"
                                                                                    Enabled="True" TargetControlID="txtStartTime" Animated="true" CssClass="cal_Theme1">
                                                                                </cc1:CalendarExtender>
                                                                                <asp:RegularExpressionValidator ID="RegularExpressionV" runat="server" ControlToValidate="txtStartTime"
                                                                                    Display="Dynamic" ErrorMessage="Date Format:MM/dd/yyyy" ValidationExpression="(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d"
                                                                                    ValidationGroup="trip" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                <asp:RangeValidator ID="RangeValidatorStartTime" runat="server" ControlToValidate="txtStartTime"
                                                                                    Type="Date" ValidationGroup="trip" Display="Dynamic" SetFocusOnError="True">*
                                                                                </asp:RangeValidator>
                                                                                <asp:ListBox ID="lstStartHH" runat="server" AppendDataBoundItems="True" Rows="1"
                                                                                    CssClass="DropDownListBox3">
                                                                                    <asp:ListItem Value="0">HH</asp:ListItem>
                                                                                </asp:ListBox>
                                                                                <asp:CompareValidator ID="CompareValidator10" runat="server" ControlToValidate="lstStartHH"
                                                                                    ErrorMessage="Select Start HH" Operator="NotEqual" ValidationGroup="trip" ValueToCompare="0"
                                                                                    SetFocusOnError="True" Display="Dynamic">*</asp:CompareValidator>&nbsp;
                                                                                <asp:ListBox ID="lstStartMM" runat="server" AppendDataBoundItems="True" Rows="1"
                                                                                    CssClass="DropDownListBox3">
                                                                                    <asp:ListItem Value="0">MM</asp:ListItem>
                                                                                </asp:ListBox>
                                                                                <asp:CompareValidator ID="CompareValidator12" runat="server" ControlToValidate="lstStartMM"
                                                                                    ErrorMessage="Select Start MM" Operator="NotEqual" ValidationGroup="trip" ValueToCompare="0"
                                                                                    SetFocusOnError="True">*</asp:CompareValidator>
                                                                            </td>
                                                                            <td style="text-align: right">
                                                                                Time Out:
                                                                            </td>
                                                                            <td style="text-align: left" valign="middle">
                                                                                <asp:TextBox ID="txtEndTime" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                                <cc1:CalendarExtender ID="txtEndTime_CalendarExtender" runat="server" Format="MM/dd/yyyy"
                                                                                    Enabled="True" TargetControlID="txtEndTime" CssClass="cal_Theme1">
                                                                                </cc1:CalendarExtender>
                                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEndTime"
                                                                                    Display="Dynamic" ErrorMessage="Date Format:MM/dd/yyyy" ValidationExpression="(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d"
                                                                                    ValidationGroup="trip" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                <asp:RangeValidator ID="RangeValidatorEndTime" runat="server" ControlToValidate="txtEndTime"
                                                                                    Type="Date" ValidationGroup="trip" Display="Dynamic" SetFocusOnError="True">*
                                                                                </asp:RangeValidator>
                                                                                <asp:CompareValidator ID="CompareValidator15" runat="server" ControlToCompare="txtStartTime"
                                                                                    ControlToValidate="txtEndTime" Display="Dynamic" ErrorMessage="End Time Cannot be less than Start Time"
                                                                                    Operator="GreaterThanEqual" SetFocusOnError="True" Type="Date" ValidationGroup="trip">*</asp:CompareValidator>&nbsp;
                                                                                <asp:ListBox ID="lstEndHH" runat="server" AppendDataBoundItems="True" Rows="1" AutoPostBack="false"
                                                                                    OnSelectedIndexChanged="lstEndMM_SelectedIndexChanged" CssClass="DropDownListBox3">
                                                                                    <asp:ListItem Value="0">HH</asp:ListItem>
                                                                                </asp:ListBox>
                                                                                <asp:CompareValidator ID="CompareValidator11" runat="server" ControlToValidate="lstEndHH"
                                                                                    ErrorMessage="Select End HH" Operator="NotEqual" ValidationGroup="trip" ValueToCompare="0"
                                                                                    SetFocusOnError="True" Display="Dynamic">*</asp:CompareValidator>&nbsp;
                                                                                <asp:ListBox ID="lstEndMM" runat="server" Rows="1" AppendDataBoundItems="True" AutoPostBack="false"
                                                                                    OnSelectedIndexChanged="lstEndMM_SelectedIndexChanged" CssClass="DropDownListBox3">
                                                                                    <asp:ListItem Value="0">MM</asp:ListItem>
                                                                                </asp:ListBox>
                                                                                <asp:CompareValidator ID="CompareValidator13" runat="server" ControlToValidate="lstEndMM"
                                                                                    ErrorMessage="Select End MM" Operator="NotEqual" ValidationGroup="trip" ValueToCompare="0"
                                                                                    SetFocusOnError="True" Display="Dynamic">*</asp:CompareValidator>
                                                                            </td>
                                                                            <td style="text-align: right">
                                                                                <asp:CheckBox ID="chkGuard" runat="server" Checked='<%# Convert.ToString(Eval("guard"))=="T"?true:false %>'
                                                                                    Text="Guard" />
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                 <asp:CheckBox ID="chkLastTrip" runat="server" Checked='<%# Convert.ToString(Eval("LastTrip"))=="T"?true:false %>'
                                                                                    Text="Last Trip" Enabled="false" /></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="right">
                                                                                Penalty Type:
                                                                            </td>
                                                                            <td align="left">
                                                                                <asp:DropDownList ID="ddlPenaltyType" runat="server" CssClass="DropDownListBox3" AutoPostBack="false"
                                                                                    AppendDataBoundItems="True" Enabled="false" 
                                                                                   >
                                                                                </asp:DropDownList>
                                                                            <td style="text-align: right">
                                                                                Cost Location:</td>
                                                                            <td colspan="1" align="left">
                                                                                <asp:DropDownList ID="ddlCostLocation" runat="server" 
                                                                                    onselectedindexchanged="ddlCostLocation_SelectedIndexChanged">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td align="right">
                                                                                Billing Type:
                                                                            </td>
                                                                            <td align="left">
                                                                                <asp:DropDownList ID="ddlBillingTripType" runat="server" AppendDataBoundItems="True"
                                                                                   AutoPostBack="true" onselectedindexchanged="ddlBillingTripType_SelectedIndexChanged">
                                                                                </asp:DropDownList>
                                                                                <asp:CompareValidator ID="CompareValidator16" runat="server" ControlToValidate="ddlBillingTripType"
                                                                                    Display="Dynamic" ErrorMessage="Select Billing Trip Type" Operator="NotEqual"
                                                                                    SetFocusOnError="True" ValidationGroup="trip" ValueToCompare="0">*</asp:CompareValidator>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="text-align: right">
                                                                                Remarks:
                                                                            </td>
                                                                            <td colspan="3" align="left">
                                                                                <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Width="400" Text='<%# Eval("remark") %>'></asp:TextBox><br />
                                                                                Max 100 characters.
                                                                                <asp:RegularExpressionValidator ID="txtConclusionValidator1" ControlToValidate="txtRemarks"
                                                                                    ValidationExpression="^[\s\S]{0,100}$" runat="server" ValidationGroup="trip"
                                                                                    ErrorMessage="Remarks exceeding 100 characters." SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                            </td>
                                                                            <td>
                                                                                Toll :<asp:ListBox ID="lbToll" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" ></asp:ListBox>
                                                                            </td>
                                                                            <td height="85px" align="left">
                                                                                <asp:RadioButtonList ID="rdbBillType" runat="server">
                                                                                    <asp:ListItem Text="Slab Billing" Value="1"></asp:ListItem>
                                                                                    <asp:ListItem Text="Medical Billing" Value="2"></asp:ListItem>
                                                                                    <%--<asp:ListItem Text="Additional Billing" Value="3"></asp:ListItem>--%>
                                                                                </asp:RadioButtonList>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="rdbBillType" ErrorMessage="Select billing Category"
                                                                                ValidationGroup="trip" >*</asp:RequiredFieldValidator>
                                                                           
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <table width="90%" border="1" bordercolor="black">
                                                                       
                                                                        <tr>
                                                                        
                                                                            <td style="text-align: right">
                                                                             <b>  CabID</b>
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("vehicleId") %>'></asp:Label>
                                                                               <b> Reg No:</b>
                                                                                <asp:Label ID="Label16" runat="server" Text='<%# Eval("vehicleNo") %>'></asp:Label>
                                                                            </td>
                                                                            <td style="text-align: right">
                                                                                <b>Vehicle Type:</b>
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("vehicle") %>'></asp:Label>
                                                                            </td>
                                                                            <td align="right">
                                                                               <b>Vendor Name:</b>
                                                                            </td>
                                                                            <td align="left">
                                                                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("vendorname") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="text-align: right">
                                                                              <b>  Start KM:</b>
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("actStartKm") %>'></asp:Label>
                                                                            </td>
                                                                            <td style="text-align: right">
                                                                                <b>End KM:</b>
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("actEndKm") %>'></asp:Label>
                                                                            </td>
                                                                            <td align="Right">
                                                                             <b>   Shift Time:</b>
                                                                            </td>
                                                                            <td align="Left">
                                                                                <asp:Label ID="lblShiftTime" runat="server" Text='<%# Eval("shiftTime")+"-"+Eval("tripType")+"-"+Eval("facility") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="text-align: right">
                                                                                <b>Act KM:</b>
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                <asp:Label ID="Label6" runat="server" Text='<%# Eval("actTotalKm") %>'></asp:Label>
                                                                            </td>
                                                                            <td style="text-align: right">
                                                                                <b>Approved KM:</b>
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("approvedKm") %>'></asp:Label>
                                                                            </td>
                                                                            <td align="Right">
                                                                                <b>Driver:</b>
                                                                            </td>
                                                                            <td align="Left">
                                                                                <asp:Label ID="Label8" runat="server" Text='<%# Eval("driver") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="text-align: right">
                                                                                <b>Start Time:</b>
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                <asp:Label ID="Label9" runat="server" Text='<%# Eval("actVehicleStartTime") %>'></asp:Label>
                                                                            </td>
                                                                            <td style="text-align: right">
                                                                                <b>End Time:</b>
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                <asp:Label ID="Label10" runat="server" Text='<%# Eval("actVehicleEndTime") %>'></asp:Label>
                                                                            </td>
                                                                            <td align="right">
                                                                                <asp:CheckBox ID="chkReadGuard" runat="server" Checked='<%# Convert.ToString(Eval("guard"))=="T"?true:false %>'
                                                                                    Text="Guard" />
                                                                            </td>
                                                                            <td align="left">
                                                                        
                                                                              
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="text-align: right">
                                                                                <b>Last Trip:</b>
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                      <asp:CheckBox ID="chklastrip" runat="server"  Enabled="false" Checked='<%# Convert.ToString(Eval("LastTrip"))=="T"?true:false %>'
                                                                                    Text="" />
                                                                                    
                                                                                          </td>
                                                                            <td style="text-align: right">
                                                                                <b>Billing Type:</b>
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                 <asp:DropDownList ID="ddlBillingTripTyperead" runat="server" AppendDataBoundItems="True">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td align="right">
                                                                               <b>Cost Location</b>
                                                                            </td>
                                                                            <td align="left">
                                                                                 <asp:DropDownList ID="ddlCostLocationread" runat="server" AppendDataBoundItems="True">
                                                                                </asp:DropDownList>
                                                                                                 </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="text-align: right">
                                                                               <b> Remarks:</b>
                                                                            </td>
                                                                            <td colspan="3" style="text-align: left;">
                                                                                <asp:TextBox ID="txtRemarks" runat="server" ReadOnly="True" Text='<%# Eval("remark") %>'
                                                                                    TextMode="MultiLine" CssClass="TextBox" MaxLength="100" Width="40%"></asp:TextBox>
                                                                            </td>
                                                                            <td align="right">
                                                                                Toll :<asp:ListBox ID="lbToll" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" ></asp:ListBox>
                                                                            </td>
                                                                            <td align="left">
                                                                                <asp:RadioButtonList ID="BillType" runat="server" Enabled="false">
                                                                                    <asp:ListItem Text="Slab Billing" Selected="True" Value="1"></asp:ListItem>
                                                                                    <asp:ListItem Text="Medical Billing" Value="2"></asp:ListItem>
                                                                                    <%--<asp:ListItem Text="Additional Billing" Value="3"></asp:ListItem>--%>
                                                                                </asp:RadioButtonList>
                                                                                  </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                                                                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                                            </asp:FormView>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:GridView ID="GvEmpInfo" runat="server" AutoGenerateColumns="False" CssClass="GridView"
                                                                DataKeyNames="employeeId" OnRowDeleting="GvEmpInfo_RowDeleting" Width="100%"
                                                                BorderWidth="0px" ShowFooter="True">
                                                                <RowStyle CssClass="RowStyle" />
                                                                <FooterStyle CssClass="FooterStyle" />
                                                                <PagerStyle CssClass="PagerStyle" />
                                                                <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                                <HeaderStyle CssClass="HeaderStyle" />
                                                                <EditRowStyle BackColor="#999999" />
                                                                <AlternatingRowStyle CssClass="AltRowStyle" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Sno">
                                                                        <EditItemTemplate>
                                                                            <asp:Label ID="lblSno" runat="server" Text='<%# Eval("stopNo") %>' Width="30px"></asp:Label>
                                                                        </EditItemTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblStopNo" runat="server" Text='<%# Eval("stopNo") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Emp Id">
                                                                        <EditItemTemplate>
                                                                            <asp:Label ID="lblEmpId" runat="server" Text='<%# Eval("empCode") %>'></asp:Label>
                                                                        </EditItemTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblEmpId0" runat="server" Text='<%# Eval("empCode") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Emp Name">
                                                                        <EditItemTemplate>
                                                                            <asp:Label ID="lblEmpName" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                                                        </EditItemTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblEmpName0" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Location">
                                                                        <EditItemTemplate>
                                                                            <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("locationName") %>'></asp:Label>
                                                                        </EditItemTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblLocation0" runat="server" Text='<%# Eval("locationName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                     <asp:TemplateField HeaderText="Km Distance">
                                                                        <EditItemTemplate>
                                                                            <asp:Label ID="lblkmdistance" runat="server" Text='<%# Eval("Kmdistance") %>'></asp:Label>
                                                                        </EditItemTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblkmdistance0" runat="server" Text='<%# Eval("Kmdistance") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Status">
                                                                        <EditItemTemplate>
                                                                            <asp:Label ID="lblStatus" runat="server"></asp:Label>
                                                                        </EditItemTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="DropDownListBox2">
                                                                                <asp:ListItem Value="0">Select Status</asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="B">Boarded</asp:ListItem>
                                                                                <asp:ListItem Value="C">Cancelled</asp:ListItem>
                                                                                <asp:ListItem Value="N">No Show</asp:ListItem>
                                                                                <asp:ListItem Value="M">Moved</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                            <asp:CompareValidator ID="CompareValidator6" runat="server" ControlToValidate="ddlStatus"
                                                                                ErrorMessage="Select Status" Operator="NotEqual" ValidationGroup="trip" ValueToCompare="0"
                                                                                Display="Dynamic">*</asp:CompareValidator>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Remark">
                                                                        <EditItemTemplate>
                                                                            <asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("trackingRemark") %>'></asp:Label>
                                                                        </EditItemTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtgvRemarks" runat="server" Text='<%# Eval("trackingRemark") %>'
                                                                                CssClass="TextBox" MaxLength="100"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField ShowHeader="False">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lbtnRemove" runat="server" CausesValidation="False" CommandName="Delete"
                                                                                Text="Remove" Visible='<%# Convert.ToString(Eval("isNewAdded"))=="True"?true:false %>'></asp:LinkButton>
                                                                            <asp:Label ID="lblNew" runat="server" Font-Bold="True" Font-Size="X-Small" Text=""
                                                                                Visible="False"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">
                                                            <table width="100%" cellpadding="0" cellspacing="0" class="style8" >
                                                                <tr >
                                                                    <td style="background-image: url('images/Grid/footer.gif'); background-repeat: repeat; height: 25px; vertical-align: middle; text-align: center;" 
                                                                        bgcolor="#D6D6D6">
                                                                        <asp:ImageButton ID="imbbtnAddEmp" runat="server" ImageUrl="~/images/user_add.png"
                                                                            CausesValidation="False" OnClick="btnAddEmp_Click" ToolTip="Add Employee"
                                                                            BorderStyle="Ridge" BorderWidth="0px" />
                                                                    </td>
                                                                     <td style="background-image: url('images/Grid/footer.gif'); background-repeat: repeat; height: 25px; vertical-align: middle; text-align: center;" 
                                                                        bgcolor="#D6D6D6">
                                                                         <asp:ImageButton ID="imgbtnAddUnschedule" runat="server" ImageUrl="~/images/add_employee.gif"
                                                                            CausesValidation="False"  ToolTip="Add Unschedule Employee"
                                                                            BorderStyle="Ridge" BorderWidth="0px" onclick="imgbtnAddUnschedule_Click" />
                                                                    </td>
                                                                     <td style="background-image: url('images/Grid/footer.gif'); background-repeat: repeat; height: 25px; vertical-align: middle; text-align: center;" 
                                                                        bgcolor="#D6D6D6">
                                                                         <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/images/clubroute.png"
                                                                            CausesValidation="False"  ToolTip="Club Routes"
                                                                            BorderStyle="Ridge" BorderWidth="0px" onclick="ImageButton3_Click"  />
                                                                    </td>
                                                                    <td style="background-image: url('images/Grid/footer.gif'); background-repeat: repeat; height: 25px; vertical-align: middle; text-align: center;" 
                                                                        bgcolor="#D6D6D6">
                                                                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" ValidationGroup="trip"
                                                                            Width="100px" CssClass="Button" />
                                                                    </td>
                                                                    
                                                                    <td style="background-image: url('images/Grid/footer.gif'); background-repeat: repeat; height: 25px; vertical-align: middle; text-align: right;" 
                                                                        bgcolor="#D6D6D6">
                                                                        <asp:Button ID="btnCancelTrip0" runat="server" CausesValidation="False" OnClick="btnCancelTrip_Click"
                                                                            Text="Cancel TripSheet" Width="130px" CssClass="Button" />
                                                                        <cc1:ConfirmButtonExtender ID="btnCancelTrip0_ConfirmButtonExtender" runat="server"
                                                                            ConfirmText="Are you sure? You want to cancel this Tripsheet." Enabled="True"
                                                                            TargetControlID="btnCancelTrip0">
                                                                        </cc1:ConfirmButtonExtender>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                            </asp:Panel>
                                        </asp:View>
                                    </asp:MultiView>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                       
                        <table width="100%">
                            <tr>
                                <td>
                                 <asp:MultiView ID="MultiView3" runat="server">
                                 <asp:View ID="View3" runat="server">
                                    <asp:Button ID="btnHidden" runat="server" Style="display: none" />
                                    <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                        Drag="True" TargetControlID="btnHidden"  PopupControlID="Panel1">
                                    </cc1:ModalPopupExtender>
                                 
                     
                                    <asp:Panel ID="Panel1" runat="server" CssClass="modaltable" DefaultButton="btnEmpSearch"
                                        Width="600px" Style="visibility: hidden">
                                        <table width="600">
                                            <tr>
                                                <td width="95%" bgcolor="#003366" style="color: #FFFFFF" align="center">
                                                    <b>Allow User to Insert New Employee in the Route.</b>
                                                </td>
                                                <td bgcolor="#003366">
                                                    <asp:ImageButton ID="ibtnSMclose" runat="server" ImageUrl="~/Images/Exit.jpg" OnClick="lbtnClose_Click" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    &nbsp;&nbsp;
                                                    <asp:Label ID="lblSearch" runat="server" CssClass="error"></asp:Label>
                                                    <table width="100%" class="tableBorber">
                                                        <tr>
                                                            <td style="text-align: right">
                                                                Stop NO:
                                                            </td>
                                                            <td style="text-align: left">
                                                                <asp:DropDownList ID="ddlStopNO" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                </asp:DropDownList>
                                                                <asp:CompareValidator ID="CompareValidator14" runat="server" ControlToValidate="ddlStopNO"
                                                                    Display="Dynamic" ErrorMessage="Select Stop No" Operator="NotEqual" ValidationGroup="Add"
                                                                    ValueToCompare="0"></asp:CompareValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right" align="right" width="40%">
                                                                Enter&nbsp; ID or Name:
                                                            </td>
                                                            <td style="text-align: left" align="left" width="60%">
                                                                <asp:TextBox ID="txtEmpIdName" runat="server" ValidationGroup="spoc" CssClass="TextBox1"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEmpIdName"
                                                                    Display="Dynamic" ErrorMessage="Please Enter Name or Id" ValidationGroup="search"></asp:RequiredFieldValidator>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right">
                                                                &nbsp;
                                                            </td>
                                                            <td style="text-align: left" align="left">
                                                                <asp:Button ID="btnEmpSearch" runat="server" OnClick="btnEmpSearch_Click" Text="Search"
                                                                    ValidationGroup="search" CssClass="Button" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:GridView ID="GvEmployee" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                    DataKeyNames="Id" OnPageIndexChanging="GvEmployee_PageIndexChanging" OnSelectedIndexChanging="GvEmployee_SelectedIndexChanging"
                                                                    CssClass="GridView" Visible="False" Width="600px" BorderWidth="0px" ShowFooter="True">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Employee Id">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblEmpId1" runat="server" Text='<%# Eval("empCode") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Employee Name">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblEmpName1" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Process">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblEmpProcess" runat="server" Text='<%# Eval("processName") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Facility">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblFacility" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                         <asp:TemplateField HeaderText="Km Distance">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblkmdistance" runat="server" Text='<%# Eval("Kmdistance") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField ShowHeader="False">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" Text="Add" ValidationGroup="Add"></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <RowStyle CssClass="RowStyle" />
                                                                    <PagerStyle CssClass="PagerStyle" />
                                                                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                                    <HeaderStyle CssClass="HeaderStyle" />
                                                                    <EditRowStyle CssClass="EditRowStyle" />
                                                                    <AlternatingRowStyle CssClass="AltRowStyle" />
                                                                    <FooterStyle CssClass="FooterStyle" />
                                                                </asp:GridView>
                                                            </td>
                                                                                                                    </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                           </asp:View>
                                     </asp:MultiView>
                                </td>
                                </tr>
                                <tr>
                                <td>
                                     
                                     <asp:MultiView ID="multiview2" runat="server">
                                       
                                     <asp:View ID="view2" runat="server">
                                     <asp:Button ID="btnUnscheduleHidden" runat="server" Style="display: none" />
                                    <cc1:ModalPopupExtender ID="ModalPopupExtender2" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                        Drag="True" TargetControlID="btnUnscheduleHidden"  PopupControlID="Panel3">
                                    </cc1:ModalPopupExtender>
                                       <asp:Panel ID="Panel3" runat="server" CssClass="modaltable" DefaultButton="btnEmpSearch"
                                        Width="600px" >
                                        <table width="600">
                                            <tr>
                                                <td width="95%" bgcolor="#003366" style="color: #FFFFFF" align="center">
                                                    <b>Allow User to Insert Unschedule Employee.</b>
                                                </td>
                                                <td bgcolor="#003366">
                                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/Exit.jpg" OnClick="lbtnClose_Click1" />
                                                </td>
                                            </tr>
                                            </table>
                                             <table width="100%" class="tableBorber">
                                             <tr>
                                                            <td style="text-align: right">
                                                                Stop NO:
                                                            </td>
                                                            <td style="text-align: left">
                                                                <asp:DropDownList ID="ddlUnschDropStop" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                </asp:DropDownList>
                                                                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlUnschDropStop"
                                                                    Display="Dynamic" ErrorMessage="Select Stop No" Operator="NotEqual" ValidationGroup="align"
                                                                    ValueToCompare="0"></asp:CompareValidator>
                                                            </td>
                                                        </tr>
                                             
                                                        <tr>
                                                                 <td style="text-align: right">
                                                                Enter Request ID:
                                                            </td>
                                                            <td style="text-align: left">
                                                                <asp:Label ID="lblPrefix" runat="server" ></asp:Label>
                                                                 <asp:TextBox ID="txt" runat="server"></asp:TextBox> 
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                                ControlToValidate="txt" ValidationGroup="align"
                                                                 ErrorMessage="Enter request ID"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        
                                                    
                                            <tr>
                                                <td align="center" colspan="2">
                                                    &nbsp;&nbsp;
                                                    <asp:Label ID="lblunscheduleerror" runat="server" CssClass="error"></asp:Label>
                                                    </td>
                                                    </tr>
                                                        <tr>
                                                            <td style="text-align: right">
                                                                &nbsp;
                                                            </td>
                                                            <td style="text-align: left" align="left">
                                                                <asp:Button ID="Button1" runat="server"  Text="Add" ValidationGroup="align"
                                                                     CssClass="Button" onclick="Button1_Click" />
                                                            </td>
                                                        </tr>
                                                        
                                                           </table>
                                                           
                                                          
                                                           </asp:Panel>
                                                           </asp:View>
                                                           </asp:MultiView>
                                                           
                                </td>
                            </tr>
                             <tr>
                                <td>
                                     
                                     <asp:MultiView ID="multiview4" runat="server">
                                       
                                     <asp:View ID="view4" runat="server">
                                     <asp:Button ID="Button2" runat="server" Style="display: none" />
                                    <cc1:ModalPopupExtender ID="ModalPopupExtender3" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                        Drag="True" TargetControlID="Button2"  PopupControlID="Panel4">
                                    </cc1:ModalPopupExtender>
                                       <asp:Panel ID="Panel4" runat="server" CssClass="modaltable" DefaultButton="btnEmpSearch"
                                        Width="600px" >
                                        <table width="600">
                                            <tr>
                                                <td width="95%" bgcolor="#003366" style="color: #FFFFFF" align="center">
                                                    <b>Partner Already Exists in Another Route.</b>
                                                </td>
                                                <td bgcolor="#003366">
                                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Images/Exit.jpg" OnClick="lbtnClose_Click2" />
                                                </td>
                                            </tr>
                                            <tr>
                                            <td colspan="2">
                                            Following Partner Already Boarded in the following routes. Please Change either the status from these routes or in your current tripsheet to save the tripsheet.
                                            </td>
                                            </tr>
                                            </table>
                                                   <asp:GridView ID="gvDupEmpInfo" runat="server" 
                                               AutoGenerateColumns="False" CssClass="GridView"
                                                                DataKeyNames="Id" Width="100%"
                                                                BorderWidth="0px" ShowFooter="True">
                                                                <RowStyle CssClass="RowStyle" />
                                                                <FooterStyle CssClass="FooterStyle" />
                                                                <PagerStyle CssClass="PagerStyle" />
                                                                <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                                <HeaderStyle CssClass="HeaderStyle" />
                                                                <EditRowStyle BackColor="#999999" />
                                                                <AlternatingRowStyle CssClass="AltRowStyle" />
                                                                <Columns>
                                                                 <asp:TemplateField HeaderText="Route ID">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDupRouteID" runat="server" Text='<%# Eval("routeid") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Sno">
                                                                        <EditItemTemplate>
                                                                            <asp:Label ID="lbDuplSno" runat="server" Text='<%# Eval("stopNo") %>' Width="30px"></asp:Label>
                                                                        </EditItemTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDupStopNo" runat="server" Text='<%# Eval("stopNo") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Emp Id">
                                                                        <EditItemTemplate>
                                                                            <asp:Label ID="lblDupEmpId" runat="server" Text='<%# Eval("empCode") %>'></asp:Label>
                                                                        </EditItemTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDupEmpId0" runat="server" Text='<%# Eval("empCode") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Emp Name">
                                                                        <EditItemTemplate>
                                                                            <asp:Label ID="lblDupEmpName" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                                                        </EditItemTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDupEmpName0" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ShiftDate">
                                                                        <EditItemTemplate>
                                                                            <asp:Label ID="lblDupShiftDate" runat="server" Text='<%# Eval("ShiftDate") %>'></asp:Label>
                                                                        </EditItemTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDupShiftDate0" runat="server" Text='<%# Eval("ShiftDate") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                     <asp:TemplateField HeaderText="ShiftTime">
                                                                        <EditItemTemplate>
                                                                            <asp:Label ID="lblDupShiftTime" runat="server" Text='<%# Eval("shiftTimeId") %>'></asp:Label>
                                                                        </EditItemTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDupShiftTime0" runat="server" Text='<%# Eval("shiftTimeId") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Status">
                                                                        <EditItemTemplate>
                                                                            <asp:Label ID="lblStatus" runat="server"></asp:Label>
                                                                        </EditItemTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="DropDownListBox2">
                                                                                <asp:ListItem Value="0">Select Status</asp:ListItem>
                                                                                <asp:ListItem Selected="True" Value="B">Boarded</asp:ListItem>
                                                                                <asp:ListItem Value="C">Cancelled</asp:ListItem>
                                                                                <asp:ListItem Value="N">No Show</asp:ListItem>
                                                                                <asp:ListItem Value="M">Moved</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                            <asp:CompareValidator ID="CompareValidator6" runat="server" ControlToValidate="ddlStatus"
                                                                                ErrorMessage="Select Status" Operator="NotEqual" ValidationGroup="Duplicate" ValueToCompare="0"
                                                                                Display="Dynamic">*</asp:CompareValidator>
                                                                        </ItemTemplate>
                                                                        <FooterTemplate>
                                                                            <asp:Button ID="btnDupSaveChanges" runat="server" Text="Save" CssClass="Button" 
                                                                                onclick="btnDupSaveChanges_Click" />
                                                                        </FooterTemplate>
                                                                        
                                                                    </asp:TemplateField>
                                                                   
                                                                   
                                                                </Columns>
                                                            </asp:GridView>
                                                  
                                                          
                                                           </asp:Panel>
                                                           </asp:View>
                                                           </asp:MultiView>
                                                           
                                </td>
                            </tr>
                            <tr>
                            <td>
                              <asp:MultiView ID="multiview6" runat="server">
                                       
                                     <asp:View ID="view5" runat="server">
                                     <asp:Button ID="Button3" runat="server" Style="display: none" />
                                    <cc1:ModalPopupExtender ID="ModalPopupExtender4" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                        Drag="True" TargetControlID="Button3"  PopupControlID="Panel5">
                                    </cc1:ModalPopupExtender>
                                       <asp:Panel ID="Panel5" runat="server" CssClass="modaltable" DefaultButton="btnEmpSearch"
                                        Width="600px" >
                                        <table width="600">
                                            <tr>
                                                <td width="95%" bgcolor="#003366" style="color: #FFFFFF" align="center">
                                                    <b>Allow User to Club Two routes.</b>
                                                </td>
                                                <td bgcolor="#003366">
                                                    <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/Images/Exit.jpg" OnClick="lbtnClose_Click1" />
                                                </td>
                                            </tr>
                                            </table>
                                             <table width="100%" class="tableBorber">
                                             <tr>
                                                            <td style="text-align: right">
                                                              Enter Route ID:
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblClubPrefix" runat="server" ></asp:Label></td>
                                                            <td style="text-align: left">
                                                                <asp:TextBox ID="txtrid" runat="server"></asp:TextBox> 
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"
                                                                ControlToValidate="txtrid" ValidationGroup="Club"
                                                                 ErrorMessage="Enter Route ID"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                             
                                                      
                                                        
                                                    
                                            <tr>
                                                <td align="center" colspan="2">
                                                    &nbsp;&nbsp;
                                                    <asp:Label ID="Label12" runat="server" CssClass="error"></asp:Label>
                                                    </td>
                                                    </tr>
                                                        <tr>
                                                            <td style="text-align: right">
                                                                &nbsp;
                                                            </td>
                                                            <td style="text-align: left" align="left">
                                                                <asp:Button ID="Button4" runat="server"  Text="Add" ValidationGroup="Club"
                                                                     CssClass="Button" onclick="Button4_Click" />
                                                            </td>
                                                        </tr>
                                                        
                                                           </table>
                                                           
                                                          
                                                           </asp:Panel>
                                                           </asp:View>
                                                           </asp:MultiView>
                            </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
