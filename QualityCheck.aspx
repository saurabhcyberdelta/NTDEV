<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="QualityCheck.aspx.cs" Inherits="QualityCheck" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style7
        {
            width: 132px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
                                            <span></span>Quality Check 
                                        </h1>
                                        <h2>
                                              Allows to Perform Quality Check.
                                        </h2>
                                    </div>
                                </td>
           </tr>
        <tr>
            <td>
                <br />
                <table border="0" cellpadding="4" cellspacing="0" align="left" width="100%" class="tableBorber">
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
                            <b>From Date:</b>
                        </td>
                       
                        <td align="left" valign="top">
                            <b>Facility Name: </b>
                        </td>
                        <td align="left"  valign="top">
                           <b>Vendor</b></td>
                        <td align="left"  valign="top" class="style7">
                            <b>Billing Type</b></td>
                           <td align="left"  valign="top">
                           <b>CabID</b></td>
                           <td align="left" rowspan="2" valign="middle">
                               <asp:RadioButtonList ID="rdbtnWeektype" runat="server" RepeatDirection="Horizontal">
                               <asp:ListItem Text="WeekDay" Value="1" Selected="True"></asp:ListItem>
                               <asp:ListItem Text="WeekEnd" Value="0" ></asp:ListItem>
                               
                               </asp:RadioButtonList>
                           </td>
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
                        <td align="left" valign="top" class="style7" >
                            <asp:DropDownList ID="ddlbillingtripType" runat="server">
                            
                            </asp:DropDownList>
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
            <td>
                <table align="left" width="90%">
                    <tr>
                        <td align="center">
                            <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto" Width="100%">
                                <asp:GridView ID="grdQualityCheck" runat="server" AutoGenerateColumns="false">
                                <Columns>
                                <asp:BoundField DataField="Dates" HeaderText="Date" />
                                <asp:BoundField DataField="cabid" HeaderText="Cabid" />
                                <asp:BoundField DataField="vehicleRegistrationNo" HeaderText="Registration_No" />
                                <asp:BoundField DataField="RouteCount" HeaderText="Actual Trips" />
                                <asp:TemplateField HeaderText="Vendor_Trips" >
                                <ItemTemplate>
                                    <asp:TextBox ID="txtVendortrips" runat="server" 
                                        Text='<%#Eval("VendorTripCount") %>' Height="17px" Width="34px"></asp:TextBox>
                                </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Trips Difference">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtDifference" runat="server" Enabled="false" 
                                        Text='<%#(Convert.ToInt32(Eval("RouteCount"))-Convert.ToInt32(Eval("VendorTripCount"))) %>' 
                                        Height="20px" Width="39px" BackColor='<%# GetColor(DataBinder.Eval(Container.DataItem, "RouteCount"),DataBinder.Eval(Container.DataItem, "VendorTripCount")) %>'></asp:TextBox>
                                </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:BoundField DataField="actualempcount" HeaderText="Actual Partner Count" />
                                <asp:TemplateField HeaderText="Vendor_Partner_Count">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtparttrips" runat="server" 
                                        Text='<%#Eval("vendorempcount") %>' Height="16px" Width="33px"></asp:TextBox>
                                </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Partner Difference">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtempDifference" runat="server" Enabled="false" 
                                        Text='<%#(Convert.ToInt32(Eval("actualempcount"))-Convert.ToInt32(Eval("vendorempcount"))) %>' 
                                        Height="20px" Width="38px" BackColor='<%# GetColor(DataBinder.Eval(Container.DataItem, "Actualempcount"),DataBinder.Eval(Container.DataItem, "vendorempcount")) %>'></asp:TextBox>
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
                                <asp:Button ID="btnQC" runat="server" Text="Save" Visible="false"  CssClass="Button"
                                    onclick="btnQC_Click" />
                                     <asp:Button ID="btnExport" runat="server" Text="Export To Excel" 
                                    Visible="false"  CssClass="Button" onclick="btnExport_Click"
                  />
                   <asp:Button ID="btnCompleteQualitycheckk" runat="server" Text="Freeze Quality Check" 
                                    Visible="false"  CssClass="Button" onclick="btnCompleteQualitycheckk_Click"
                                     />
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>



