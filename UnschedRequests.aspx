<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="UnschedRequests.aspx.cs" Inherits="UnschedRequests" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
        <ContentTemplate>
            <table align="center" border="0" width="100%">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="Submit" Height="16px" />
                <tr align="center">
                    <td class="heading" colspan="3">
                        <div class="gradient2">
                            <h1>
                                <span></span>Unschedule Request Prints
                            </h1>
                            <h2>
                                Allows User to Print the Unschedule Requests.
                            </h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="3">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table border="0" cellpadding="4" cellspacing="0" align="left" width="100%" class="tableBorber">
                                    <tr>
                                        <td align="center" class="TDbg" colspan="5">
                                            Fill The Selection Criteria
                                            <asp:Label ID="lblFacError" runat="server" CssClass="error" Text="Select Facility"
                                                Visible="False"></asp:Label>
                                            &nbsp; &nbsp; &nbsp;
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td align="left" valign="top" width="15%">
                                            <b>Shift Date:</b>
                                        </td>
                                        <td align="left" valign="top" width="15%">
                                            <b>Facility Name: </b>
                                        </td>
                                        <td align="left" rowspan="2" valign="middle" width="15%">
                                            <asp:RadioButtonList ID="rdoTripType" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                                                AutoPostBack="True" OnSelectedIndexChanged="rdoTripType_SelectedIndexChanged">
                                                <asp:ListItem Selected="True" Value="P">Pick</asp:ListItem>
                                                <asp:ListItem Value="D">Drop</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td align="left" valign="top" width="15%">
                                            <b>Shift:</b>
                                        </td>
                                        <td align="left" rowspan="2" valign="middle" width="15%">
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
                                                Display="Dynamic" ErrorMessage="Enter Valid Shift Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                ValidationGroup="Submit">*</asp:RegularExpressionValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Shift Date"
                                                ControlToValidate="txtStartDate" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                                        </td>
                                        <td align="left" valign="top">
                                            <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                OnSelectedIndexChanged="ddlFacility_SelectedIndexChanged" CssClass="DropDownListBox3">
                                            </asp:DropDownList>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                                                Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                                                ValueToCompare="0">*</asp:CompareValidator>
                                        </td>
                                        <td align="left" valign="top">
                                            <asp:ListBox ID="lstShift" runat="server" AppendDataBoundItems="True">
                                                <asp:ListItem Selected="True" Value="0"></asp:ListItem>
                                            </asp:ListBox>
                                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="lstShift"
                                                ErrorMessage="Select Shift Time" Operator="NotEqual" ValidationGroup="Submit"
                                                ValueToCompare="0">*</asp:CompareValidator>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                <td align="center">
                 
                     
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel4"
                            DisplayAfter="0" DynamicLayout="false">
                            <ProgressTemplate>
                                <table align="center" >
                                    <tr>
                                        <td  align="right">
                                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loding..." />
                                        </td>
                                        <td class="main_bg" style="width: 200px" align="left">
                                            Loading.....Please Wait!!!
                                        </td>
                                    </tr>
                                </table>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
          
                </td>
                
                </tr>
                <tr>
                <td align="right">
                <asp:LinkButton ID="lblexport" runat="server"  Text="Export to Excel" 
                        onclick="lblexport_Click" Visible="false" />
               
                </td>
                </tr>
                <tr>
                <td align="center">
                <asp:GridView ID="gvUnsched" runat="server" Width="90%" DataKeyNames="ID" 
                        AutoGenerateColumns="false" EmptyDataText="No Record Found" ShowFooter="true">
                <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" />
                <asp:BoundField DataField="EmployeeDetail" HeaderText="Partner" />
                <asp:BoundField DataField="Location" HeaderText="Location" />
                
                <asp:TemplateField HeaderText="Shiftdate">
                
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%#Eval("ShiftDate") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                </FooterTemplate>
                </asp:TemplateField>
                
                <asp:BoundField DataField="Shift" HeaderText="Shift" />
                <asp:BoundField DataField="processName" HeaderText="Business Unit" />
                <asp:BoundField DataField="subProcessName" HeaderText="Process" />
              <asp:TemplateField HeaderText="Print">
              <ItemTemplate>
                   <asp:LinkButton ID="lbTakePrint" runat="server" OnClick="lbTakePrint_Click" >
                                                                                                         Print</asp:LinkButton>
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
                </table>
                </ContentTemplate>
                <Triggers>
                <asp:PostBackTrigger ControlID="lblexport" />
                </Triggers>
                </asp:UpdatePanel>
     </asp:content>
                
