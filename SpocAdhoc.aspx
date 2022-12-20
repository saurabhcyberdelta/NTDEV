<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="SpocAdhoc.aspx.cs" Inherits="SpocAdhoc" %>

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
    <asp:Label ID="lblErrorMsg" runat="server" Visible="False" CssClass="error"></asp:Label>
    <table width="90%" align="center">
        <tr>
            <td align="left">
                &nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Label ID="Label1" runat="server" CssClass="heading" Font-Bold="True" Font-Overline="False"
                    Text="View Transport Adhocs "></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Label ID="Label2" runat="server" Font-Bold="False" Font-Overline="False" Text="Allows Spoc to View Adhoc Details "
                    CssClass="subHeading"></asp:Label>
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
                        </tr>
                        <tr>
                            <td align="left">
                                &nbsp;
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
                                    CssClass="GridView" ShowFooter="True" Width="100%" DataKeyNames="EmployeeID">
                                    <RowStyle CssClass="RowStyle" />
                                    <FooterStyle CssClass="FooterStyle" />
                                    <PagerStyle CssClass="PagerStyle" />
                                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                                    <HeaderStyle CssClass="HeaderStyle" />
                                    <EditRowStyle BackColor="#999999" />
                                    <AlternatingRowStyle CssClass="AltRowStyle" />
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemStyle Width="20px" />
                                            <ItemTemplate>
                                                <img id="imgGeoCode" src='<%# (DataBinder.Eval(Container.DataItem, "geoCode").ToString() ==  "Y" || DataBinder.Eval(Container.DataItem, "geoCode").ToString() ==  "y" )? "Images/GeoCode.gif" : "Images/NonGeoCode.gif" %>'
                                                    alt='<%# (DataBinder.Eval(Container.DataItem, "geoCode").ToString() ==  "Y" || DataBinder.Eval(Container.DataItem, "geoCode").ToString() ==  "y" )? "Geocoded" : "Not Geocoded" %>'
                                                    width="20" height="15" /><br />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemStyle Width="20px" />
                                            <ItemTemplate>
                                                <img id="imgTptReq" src='<%# (DataBinder.Eval(Container.DataItem, "tptReq").ToString() ==  "Y" || DataBinder.Eval(Container.DataItem, "tptReq").ToString() ==  "y" )? "Images/TptReq.gif" : "Images/TptNotReq.gif"  %>'
                                                    alt='<%# (DataBinder.Eval(Container.DataItem, "tptReq").ToString() ==  "Y" || DataBinder.Eval(Container.DataItem, "tptReq").ToString() ==  "y" )? "Availing Transport." : "Not Availing Transport."   %>'
                                                    width="20" height="10" /><br />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Employee Name">
                                            <ItemStyle Width="200px" HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:Label ID="lnkBtnEmpName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EmpName") %>'
                                                   />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="In0">
                                            <ItemStyle Width="100px" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnSETime0" runat="server" Text='<%# Eval("SETime0").ToString()%>'
                                                    OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(0) %>' CssClass="linkButton"
                                                   ></asp:LinkButton>
                                                <br />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="In1">
                                            <ItemStyle Width="100px" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnSETime1" runat="server" Text='<%# Eval("SETime1").ToString() %>'
                                                    OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(1) %>' CssClass="linkButton"
                                                  ></asp:LinkButton>
                                                <br />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="In2">
                                            <ItemStyle Width="100px" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnSETime2" runat="server" Text='<%# Eval("SETime2").ToString() %>'
                                                    OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(2) %>' CssClass="linkButton"
                                                ></asp:LinkButton>
                                                <br />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="In3">
                                            <ItemStyle Width="100px" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnSETime3" runat="server" Text='<%# Eval("SETime3").ToString() %>'
                                                    OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(3) %>' CssClass="linkButton"
                                                  ></asp:LinkButton>
                                                <br />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="In4">
                                            <ItemStyle Width="100px" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnSETime4" runat="server" Text='<%# Eval("SETime4").ToString() %>'
                                                    OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(4) %>' CssClass="linkButton"
                                                    ></asp:LinkButton>
                                                <br />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="In5">
                                            <ItemStyle Width="100px" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnSETime5" runat="server" Text='<%# Eval("SETime5").ToString() %>'
                                                    OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(5) %>' CssClass="linkButton"
                                                 ></asp:LinkButton>
                                                <br />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="In6">
                                            <ItemStyle Width="100px" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnSETime6" runat="server" Text='<%# Eval("SETime6").ToString() %>'
                                                    OnClick="lnkBtnShift_Click" CommandArgument='<%# GetShiftdate(6) %>' CssClass="linkButton"
                                                    ></asp:LinkButton>
                                                <br />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </asp:View>
            </asp:MultiView>
                    <asp:Button ID="btnHidden" runat="server" Style="visibility: hidden" />
                    <cc1:ModalPopupExtender ID="ModalPopupExtender" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                        Drag="True" TargetControlID="btnHidden" PopupControlID="modal">
                    </cc1:ModalPopupExtender>
                    <asp:Panel ID="modal" runat="server">
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td bgcolor="blue">
                                    <asp:ImageButton ID="btnClose" runat="server" OnClick="btnClose_Click"  ImageUrl ="~/images/no_icon.jpg" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                <cc1:TabContainer ID="AJX" runat="server" Visible="false">
                 <cc1:TabPanel ID="TabPanel2" runat="server" HeaderText="Approved" >
            <ContentTemplate>
            <asp:GridView ID="GrdEmployeeAccepted" runat="server" AutoGenerateColumns="false" width="100%" EmptyDataText="No Records Found">
             <Columns>
                                            <asp:TemplateField HeaderText="Shift Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDate" runat="server" 
                                                        Text='<%# Eval("AdhocDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Shift">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblShift" runat="server" 
                                                        Text='<%# Eval("ShiftTime") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Trip Type">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAction" runat="server" 
                                                        Text='<%# Eval("TripType") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="FacilityID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFacility" runat="server" 
                                                        Text='<%# Eval("facilityName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblStatus" runat="server" 
                                                        Text='<%# Eval("Status") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Approved By">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblApproved" runat="server" 
                                                        Text='<%# Eval("AprovedBy") %>'></asp:Label>
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
                        <cc1:TabPanel ID="TabPanel1" runat="server" HeaderText="Pending" >
                        <HeaderTemplate>Pending</HeaderTemplate>
                        <ContentTemplate>
                        <asp:GridView ID="GrdEmployeePending" runat="server" AutoGenerateColumns="False" width="100%" 
                              EmptyDataText="No Records Found"><AlternatingRowStyle CssClass="AltRowStyle" />
                           <Columns>
                                            <asp:TemplateField HeaderText="Shift Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDatep" runat="server" 
                                                        Text='<%# Eval("AdhocDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Shift">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblShiftp" runat="server" 
                                                        Text='<%# Eval("ShiftTime") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Trip Type">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblActionp" runat="server" 
                                                        Text='<%# Eval("TripType") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="FacilityID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFacilitp" runat="server" 
                                                        Text='<%# Eval("facilityName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblStatusp" runat="server" 
                                                        Text='<%# Eval("Status") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Approved By">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblApprovedp" runat="server" 
                                                        Text='<%# Eval("AprovedBy") %>'></asp:Label>
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
                    </ContentTemplate></cc1:TabPanel>
         
                <cc1:TabPanel ID="TabPanel3" runat="server" HeaderText="Rejected" >
                <ContentTemplate>
                <asp:GridView ID="GrdEmployeeRejected" runat="server" AutoGenerateColumns="false" width="100%" EmptyDataText="No Records Found">
                  <Columns>
                                            <asp:TemplateField HeaderText="Shift Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDater" runat="server" 
                                                        Text='<%# Eval("AdhocDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Shift">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblShiftr" runat="server" 
                                                        Text='<%# Eval("ShiftTime") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Trip Type">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblActionr" runat="server" 
                                                        Text='<%# Eval("TripType") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="FacilityID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFacilityr" runat="server" 
                                                        Text='<%# Eval("facilityName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblStatusr" runat="server" 
                                                        Text='<%# Eval("Status") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Approved By">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblApprovedr" runat="server" 
                                                        Text='<%# Eval("AprovedBy") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns><RowStyle CssClass="RowStyle" /><FooterStyle CssClass="FooterStyle" /><PagerStyle CssClass="PagerStyle" /><SelectedRowStyle CssClass="SelectedRowStyle" /><HeaderStyle CssClass="HeaderStyle" /><EditRowStyle BackColor="#999999" /><AlternatingRowStyle CssClass="AltRowStyle" /></asp:GridView></ContentTemplate></cc1:TabPanel>
             </cc1:TabContainer>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
