<%@ Page Title="" Language="C#" MasterPageFile="~/Header.Master" AutoEventWireup="true" CodeFile="AdhocRequest.aspx.cs" Inherits="AdhocRequest" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="StyleSheets/GridView.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/TMS.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
 <table align="center" border="0" width="100%">
       
        
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="Submit" Height="16px" />
         
        <tr align="center">
            <td class="heading">
              <div class="gradient2">
                            <h1>
                                <span></span>   Aligned Unschedule Request
                            </h1>
                            <h2>
                               Allows to Generate An Aligned Unschedule request
                            </h2>
                        </div>
               
             
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Button ID="btnGoBack" runat="server" CssClass="Button" PostBackUrl="~/EmpScheduler.aspx"
                                        Text="Go Back" /></td>
        </tr>
        <tr>
            <td>
                <br />
                <table align="left" border="0" cellpadding="4" cellspacing="0" 
                    class="tableBorber" width="100%">
                    <tr>
                        <td align="center" class="TDbg" colspan="5">
                            Fill The Selection Criteria
                            <asp:Label ID="lblFacError" runat="server" CssClass="error" 
                                Text="Select Facility" Visible="False"></asp:Label>
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
                            <b>Trip Type</b></td>
                        <td align="left" valign="top">
                            <b>Shift</b></td>
                        <td align="left" rowspan="2" valign="middle">
                            <asp:Button ID="btnSubmit" runat="server" CssClass="Button" 
                                onclick="btnSubmit_Click" Text="Raise Request" ValidationGroup="Submit" />
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="left" valign="top">
                            <asp:TextBox ID="txtStartDate" runat="server" AutoPostBack="false" 
                             ontextchanged="txtStartDate_TextChanged"></asp:TextBox>
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
                            <asp:DropDownList ID="ddlFacility1" runat="server" AppendDataBoundItems="True" 
                                AutoPostBack="True" CssClass="DropDownListBox3" 
                                onselectedindexchanged="ddlFacility1_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator2" runat="server" 
                                ControlToValidate="ddlFacility1" Display="Dynamic" 
                                ErrorMessage="Select Facility" Operator="NotEqual" SetFocusOnError="True" 
                                ValidationGroup="Submit" ValueToCompare="0">*</asp:CompareValidator>
                        </td>
                        <td align="left" valign="top">
                            <asp:DropDownList ID="ddlTripType" runat="server" AutoPostBack="false" 
                                onselectedindexchanged="ddlTripType_SelectedIndexChanged">
                                <asp:ListItem Value="P">Pick</asp:ListItem>
                                <asp:ListItem Value="D">Drop</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td align="left" valign="top">
                            <asp:DropDownList ID="ddlShift" runat="server" AppendDataBoundItems="True">
                                <asp:ListItem Selected="True" Value="0">Select</asp:ListItem>
                            </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                ControlToValidate="ddlShift" Display="Dynamic" ErrorMessage="Select Shift Time" 
                                Operator="NotEqual" SetFocusOnError="True" ValidationGroup="Submit" 
                                ValueToCompare="0">*</asp:CompareValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grdEmployeeSchedule" runat="server" AutoGenerateColumns="False"
                                                AllowPaging="False" DataKeyNames="EmployeeId" 
                    CssClass="GridView" Width="100%" BorderWidth="0px" ShowFooter="True">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="ID" HeaderStyle-Width="10" ItemStyle-Width="10">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkBxHeader" AutoPostBack="true" Checked="true" OnCheckedChanged="CheckAll" runat="server" />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkBxEmpId" runat="server"  Checked="true"/>
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
                                                    <asp:TemplateField HeaderText="Partner Details" >
                                                        <ItemTemplate>
                                                                <asp:Label ID="Label2" runat="server" Text='<%#Eval("EmpName") %>'></asp:Label>
                                                       
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
                                    <EmptyDataRowStyle ForeColor="Red" Font-Bold="true" HorizontalAlign="Left" />
                                            </asp:GridView>
            </td>
        </tr>
        <tr>
        <td align="center">
        <asp:Label ID="lblMessage" runat="server" />
       
        </td>
        </tr>
        <tr>
        <td align="center">
            &nbsp;</td>
            </tr>
            <tr>
                <td align="center">
                    &nbsp;</td>
                    </tr>
                <tr>
                    <td align="center">
                        &nbsp;</td>
                        </tr>
                        
                <tr>
                        <td align="center" bgcolor="silver" bordercolor="black" class="row2" 
                            style="border-width:1">
                            <b><font color="White">My Last 100 Aligned Unschedule Requests</font></b></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="GVAdhoc" runat="server" AllowPaging="true" 
                                AutoGenerateColumns="False" BorderWidth="0px" CssClass="GridView" 
                                DataKeyNames="Id" EmptyDataText="No Request Found " 
                                onpageindexchanging="GVAdhoc_PageIndexChanging" PageSize="10" ShowFooter="True" 
                                Width="100%">
                                <Columns>
                                    <asp:TemplateField HeaderText="Shift Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDate" runat="server" Text='<%# Eval("AdhocDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Shift">
                                        <ItemTemplate>
                                            <asp:Label ID="lblShift" runat="server" Text='<%# Eval("ShiftTime") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Trip Type">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAction" runat="server" Text='<%# Eval("TripType") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="FacilityID">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFacility" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Raised At">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRaisedTime" runat="server" Text='<%# Eval("RaisedTime") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnUpdate" runat="server" 
                                                Enabled='<%# enableds(DataBinder.Eval(Container.DataItem, "Enableds"),DataBinder.Eval(Container.DataItem, "action")) %> ' 
                                                onclick="lbtnUpdate_Click" Text="Cancel"></asp:LinkButton>
                                                <cc1:ConfirmButtonExtender ID="ConfirmButton_btnSave" TargetControlID="lbtnUpdate" runat="server"
                                                    ConfirmOnFormSubmit="False" ConfirmText="Are you sure you want to cancel the selected request">
                                                </cc1:ConfirmButtonExtender>
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
                                <EmptyDataRowStyle Font-Bold="true" ForeColor="Red" HorizontalAlign="Left" />
                            </asp:GridView>
                        </td>
                    </tr>
                 
                </tr>
                <tr align="center">
                    <td align="right">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" 
                            AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0">
                            <ProgressTemplate>
                                <table align="center" style="width: 400px">
                                    <tr>
                                        <td colspan="4" style="width: 200px">
                                            <img alt="Loding..." src="images/ajax-loader.gif" 
                                                style="width: 16px; height: 16px" />
                                        </td>
                                        <td align="left" class="main_bg" style="width: 200px">
                                            Loading.....Please Wait!!!
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="3">
                                        </td>
                                    </tr>
                                </table>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </tr>
        </tr>
        </tr>
    </table>
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

