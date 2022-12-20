<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="LastTripEntry.aspx.cs" Inherits="LastTripEntry" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
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
                                            <span></span>Last Trip Entry
                                        </h1>
                                        <h2>
                                              Allows to Make a Last Trip Entry.
                                        </h2>
                                    </div>
                                </td>
           </tr>
        <tr>
            <td>
                <br />
                <table border="0" cellpadding="4" cellspacing="0" align="left" width="90%" class="tableBorber">
                    <tr>
                        <td align="center" class="TDbg" colspan="8">
                            Fill The Selection Criteria
                            <asp:Label ID="lblFacError" runat="server" CssClass="error" Text="Select Facility"
                                Visible="False"></asp:Label>
                            &nbsp; &nbsp; &nbsp;
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="left" valign="top">
                            <b> Date:</b>
                        </td>
                      
                        <td align="left" valign="top">
                            <b>Facility Name: </b>
                        </td>
                        <td align="left"  valign="top">
                           <b>Vendor</b></td>
                           <td align="left"  valign="top">
                           <b>CabID</b></td>
                          
                        <td align="left" rowspan="2" valign="middle">
                            <asp:Button ID="btnSubmit" runat="server" Text="Run Report" ValidationGroup="Submit"
                                OnClick="btnSubmit_Click" CssClass="Button" />
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="left" valign="top">
                            <asp:TextBox ID="txtStartDate" runat="server" CssClass="TextBox"></asp:TextBox>
                            <cc1:calendarextender ID="txtStartDate_CalendarExtender" runat="server" Enabled="true"
                                TargetControlID="txtStartDate" PopupButtonID="ibcal1">
                            </cc1:calendarextender>
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
                            <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" 
                                CssClass="DropDownListBox3" AutoPostBack="True" 
                                onselectedindexchanged="ddlFacility_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                                Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                        </td>
                        <td align="left" valign="top" >
                            <asp:DropDownList ID="ddlVendor" runat="server" AppendDataBoundItems="True" 
                                CssClass="DropDownListBox3" AutoPostBack="True" 
                                onselectedindexchanged="ddlVendor_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlVendor"
                                Display="Dynamic" ErrorMessage="Select Vendor" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                        </td>
                          <td align="left" valign="top" >
                              <asp:ListBox ID="lstCabID" runat="server" SelectionMode="Multiple" 
                                  AppendDataBoundItems="True">
                              <asp:ListItem Text="Select Cabid" Value="0" Selected="True"></asp:ListItem>
                              </asp:ListBox>
                            <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="lstCabID"
                                Display="Dynamic" ErrorMessage="Select CabIDs" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
        <td align="center">
        
        <asp:UpdateProgress ID="UpdateProgress2" runat="server" DisplayAfter="0" DynamicLayout="False">
                                                               
                                                                <ProgressTemplate>
                                                                    <table>
                                                                <tr>
                                                                <td> 
                                                                    <img src="images/ajax-loader.gif" alt="Loading..." />
                                                                </td>
                                              
                                              <td>
                                              Loading Please Wait.....
                                              </td>                  </tr>
                                                                </table>
                                                                </ProgressTemplate>
                                           </asp:UpdateProgress>
                                                               
                                                                              
        </td>
        </tr>
        <tr>
        <td align="right">
        <asp:LinkButton ID="lbtnExport" runat="server" Text="Export To Excel" 
                onclick="lbtnExport_Click" ValidationGroup="Submit"></asp:LinkButton>
        </td>
        </tr>
        <tr>
            <td>
                <table align="center" width="90%">
                    <tr>
                        <td align="left">
                            <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto" Width="100%">
                                <asp:GridView ID="gvRoutesFinal" runat="server" CssClass="table"  Width="80%" AutoGenerateColumns="false" ShowFooter="true">
                                <Columns>
                                <asp:BoundField datafield="Vehicleid" HeaderText="CabID" />
                                <asp:BoundField DataField="Id" HeaderText="Route ID" />
                                <asp:BoundField DataField="Shiftdate" HeaderText="ShiftDate" />
                                <asp:BoundField DataField="shiftTime" HeaderText="Shift" />
                                <asp:BoundField DataField="TripType" HeaderText="Trip Type" />
                                <asp:TemplateField HeaderText="Lasttrip">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkLasttrip" runat="server" checked='<%# getTrip(DataBinder.Eval(Container.DataItem, "lasttrip")) %>'>
                                    </asp:CheckBox>
                                    </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="Button" 
                                        onclick="btnSave_Click" />
                                </FooterTemplate>
                                </asp:TemplateField>
                                
                                
                                </Columns>
                               <RowStyle BackColor="#E7E7FF" HorizontalAlign="Left" />
                                                <AlternatingRowStyle BackColor="#F7F7F7" BorderColor="Black" HorizontalAlign="Left" />
                                                <FooterStyle CssClass="FooterStyle" />
                                                <PagerStyle CssClass="PagerStyle" />
                                                <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                <HeaderStyle CssClass="HeaderStyle1" />
                                                <EditRowStyle BackColor="#999999" />
                                               
                                </asp:GridView>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
  </ContentTemplate>
  <Triggers>
  <asp:PostBackTrigger ControlID="lbtnExport" />
  </Triggers>
  </asp:UpdatePanel>
</asp:Content>
