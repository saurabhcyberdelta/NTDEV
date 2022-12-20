﻿<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="SeperateCab.aspx.cs" Inherits="SeperateCab" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" border="0" width="100%">
        <tr>
            <td align="center">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="Submit" Height="16px" />
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Label ID="lblErrorMsg" runat="server" CssClass="error"></asp:Label>
                &nbsp;
            </td>
        </tr>
        <tr align="center">
            <td class="heading">
                
               <div class="gradient2">
                                        <h1>
                                            <span></span>Sepearate Cab Requests
                                        </h1>
                                        <h2>
                                             Allows to View/Accept Seperate Cab Request
                                        </h2>
                                    </div>
                                    
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <table border="0" cellpadding="4" cellspacing="0" align="left" width="90%" class="tableBorber">
                    <tr>
                        <td align="center" class="TDbg" colspan="4">
                            Fill The Selection Criteria
                            <asp:Label ID="lblFacError" runat="server" CssClass="error" Text="Select Facility"
                                Visible="False"></asp:Label>
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
                        <td align="left" rowspan="2" valign="middle">
                            <asp:Button ID="btnSubmit" runat="server" Text="Run Report" ValidationGroup="Submit"
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
                            <asp:TextBox ID="txtEndDate" runat="server" CssClass="TextBox"></asp:TextBox>
                            &nbsp;<asp:ImageButton ID="ibcal2" runat="server" ImageUrl="~/images/calendar_icon.gif"
                                Height="17px" />
                            <br />
                            <cc1:CalendarExtender ID="txtEndDate_CalendarExtender" runat="server" Enabled="True"
                                TargetControlID="txtEndDate" PopupButtonID="ibcal2">
                            </cc1:CalendarExtender>
                            <i>(mm/dd/yyyy)</i>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEndDate"
                                Display="Dynamic" ErrorMessage="Enter Valid End Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                ValidationGroup="Submit">*</asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter End Date"
                                ControlToValidate="txtEndDate" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator15" runat="server" ControlToCompare="txtStartDate"
                                ControlToValidate="txtEndDate" ErrorMessage="End Date cannot be less than Start Date."
                                Operator="GreaterThanEqual" SetFocusOnError="True" Type="Date" ValidationGroup="Submit">*</asp:CompareValidator>
                        </td>
                        <td align="left" valign="top">
                            <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                                Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        </table>
    
                <table align="left" style="width: 104%">
                    <tr>
                        <td align="left">
                            <asp:GridView ID="grdSeperateCab" runat="server" DataKeyNames="ID" AutoGenerateColumns="false">
                            <Columns>
                            <asp:BoundField DataField="PartnerID" HeaderText="PartnerID" />
                            <asp:BoundField DataField="PartberName" HeaderText="Partner Name" />
                            <asp:BoundField DataField="RaisedBY" HeaderText="Request By" />
                            <asp:BoundField DataField="DivisionManager" HeaderText="Division Manager" />
                            <asp:BoundField DataField="subProcessName" HeaderText="Process" />
                            <asp:BoundField DataField="RequestedDate" HeaderText="Requested Date" />
                            <asp:BoundField DataField="RequestedTime" HeaderText="Requested Time" />
                               <asp:BoundField DataField="status" HeaderText="Status" />
                                <asp:BoundField DataField="Reason" HeaderText="reason" />
                                  <asp:BoundField DataField="Acceptedby" HeaderText="Accepted By" />
                                  <asp:BoundField DataField="acceptedat" HeaderText="Accepted At" />
                                  <asp:BoundField DataField="Reason" HeaderText="reason" />
                             <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server"  
                                    Enabled='<%# enableds(DataBinder.Eval(Container.DataItem, "statushide")) %> ' onclick="LinkButton1_Click"
                                    >Accept</asp:LinkButton>
                                </ItemTemplate>
                             </asp:TemplateField>
                            </Columns>
                              <RowStyle CssClass="RowStyle" />
                                    <PagerStyle CssClass="PagerStyle" />
                                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                                    <HeaderStyle CssClass="HeaderStyle1" />
                                    <EditRowStyle CssClass="EditRowStyle" />
                                    <AlternatingRowStyle CssClass="AltRowStyle" />
                                    <FooterStyle CssClass="FooterStyle" />
                                    <EmptyDataRowStyle ForeColor="Red" Font-Bold="true" HorizontalAlign="Left" />

                            </asp:GridView>
                        </td>
                    </tr>
                </table>
           
</asp:Content>



