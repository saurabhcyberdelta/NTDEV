<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="SmsSend.aspx.cs" Inherits="SmsSend" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


  

    <style type="text/css">
        .style1
        {
            width: 162px;
        }
        .style2
        {
            width: 326px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

            <table width="100%">
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="empsearch"
                            ShowMessageBox="true" ShowSummary="false" />
                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="routesearch"
                            ShowMessageBox="true" ShowSummary="false" />
                        <asp:ValidationSummary ID="ValidationSummary3" runat="server" ValidationGroup="processsearch"
                            ShowMessageBox="true" ShowSummary="false" />
                        <asp:ValidationSummary ID="ValidationSummary4" runat="server" ValidationGroup="shiftsearch"
                            ShowMessageBox="true" ShowSummary="false" />
                        <asp:ValidationSummary ID="ValidationSummary5" runat="server" ValidationGroup="savefinal"
                            ShowMessageBox="true" ShowSummary="false" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%"  class="tableBorber">
                            <tr class="TDbg">
                                <td width="100px">
                                    Search By:
                                </td>
                                <td align="left">
                                    <asp:RadioButtonList ID="rdbSearch" RepeatDirection="Horizontal" AutoPostBack="true"
                                        runat="server" OnSelectedIndexChanged="rdbSearch_SelectedIndexChanged">
                                        
                                       
                                       
                                        <asp:ListItem Text="ShiftDate" Selected="True" ></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                        <asp:MultiView ID="MultiView1" runat="server">
                            <asp:View ID="View1" runat="server">
                                <table width="100%">
                                    <tr>
                                        <td align="right" valign="middle">
                                            Enter the employee Ids:
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtempid" runat="server" TextMode="MultiLine" MaxLength="5000" Rows="6"
                                                Columns="36" Width="475px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter the EmployeeId`s"
                                                ControlToValidate="txtempid" Text="*" ValidationGroup="empsearch"></asp:RequiredFieldValidator>
                                            <asp:Button ID="btnsubmemp" runat="server" Text="Submit" CssClass="Button" OnClick="btnsubmemp_Click"
                                                ValidationGroup="empsearch" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <table width="100%">
                                    <tr>
                                        <td colspan="3" align="center" class="TDbg">
                                            Fill the selection criteria:
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            Facility:
                                            <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                OnSelectedIndexChanged="ddlFacility_SelectedIndexChanged">
                                                <asp:ListItem Selected="True" Value="0">--Select--</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Enter The Facility"
                                                Text="*" ControlToValidate="ddlFacility" ValueToCompare="0" ValidationGroup="processsearch"
                                                Operator="NotEqual"></asp:CompareValidator>
                                        </td>
                                        <td align="center">
                                            Process:<asp:DropDownList ID="ddlProcess" runat="server" AppendDataBoundItems="True"
                                                AutoPostBack="True" Width="183px" OnSelectedIndexChanged="ddlProcess_SelectedIndexChanged">
                                                <asp:ListItem Selected="True" Value="0">--Select--</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="Enter The Process"
                                                Text="*" ControlToValidate="ddlProcess" ValueToCompare="0" ValidationGroup="processsearch"
                                                Operator="NotEqual"></asp:CompareValidator>
                                        </td>
                                        <td align="left">
                                            SubProcess:<asp:DropDownList ID="ddlSubProcess" runat="server" AppendDataBoundItems="True"
                                                Width="103px">
                                                <asp:ListItem Selected="True" Value="0">--Select--</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:CompareValidator ID="CompareValidator3" runat="server" ErrorMessage="Enter The SubProcess"
                                                Text="*" ControlToValidate="ddlSubProcess" ValueToCompare="0" ValidationGroup="processsearch"
                                                Operator="NotEqual"></asp:CompareValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="3">
                                            <asp:Button ID="btnprocess" runat="server" Text="Submit" OnClick="btnprocess_Click"
                                                ValidationGroup="processsearch" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="View4" runat="server">
                                <asp:Panel ID="Panel1" runat="server" DefaultButton="btnRouteSubmit">
                                    <table width="100%">
                                        <tr>
                                            <td colspan="2" align="center" class="TDbg">
                                                Enter the Route ID:
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="middle">
                                                Enter the Route Id:
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="TxtrouteId" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtrouteId"
                                                    ErrorMessage="Enter the RouteId" Text="*" ValidationGroup="routesearch"></asp:RequiredFieldValidator>
                                                <asp:Button ID="btnRouteSubmit" runat="server" CssClass="Button" OnClick="btnRouteSubmit_Click"
                                                    Text="Submit" ValidationGroup="routesearch" />
                                            </td>
                                    </table>
                                </asp:Panel>
                            </asp:View>
                            <asp:View ID="View5" runat="server">
                                <table border="0" class="tableBorber" cellpadding="4" cellspacing="0" align="left" width="100%" >
                                    <tr>
                                        <td align="center" class="TDbg" colspan="6">
                                            Fill The Selection Criteria &nbsp; &nbsp; &nbsp;
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
                                            <b>Shift:</b><br />
                                            <em>ctrl-click for multi - select</em>
                                        </td>
                                        <td align="left" rowspan="2" valign="middle" width="15%" >
                                            <asp:RadioButtonList ID="rdosextype" runat="server" visible="false" RepeatColumns="3" RepeatDirection="Horizontal">
                                                <asp:ListItem Value="M" Selected="True">Male</asp:ListItem>
                                                <asp:ListItem Value="F">Female</asp:ListItem>
                                                <asp:ListItem Value="M" >All</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td align="left" rowspan="2" valign="middle" width="15%">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Export" ValidationGroup="shiftsearch"
                                                CssClass="Button" OnClick="btnSubmit_Click" />
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
                                                ValidationGroup="shiftsearch">*</asp:RegularExpressionValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Shift Date"
                                                ControlToValidate="txtStartDate" ValidationGroup="shiftsearch">*</asp:RequiredFieldValidator>
                                        </td>
                                        <td align="left" valign="top">
                                            <asp:DropDownList ID="ddlFacilityshift" runat="server" AppendDataBoundItems="True"
                                                AutoPostBack="True" CssClass="DropDownListBox3" OnSelectedIndexChanged="ddlFacilityshift_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="ddlFacilityshift"
                                                Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="shiftsearch"
                                                ValueToCompare="0">*</asp:CompareValidator>
                                        </td>
                                        <td align="left" valign="top">
                                            <asp:ListBox ID="lstShift" runat="server" AppendDataBoundItems="True" SelectionMode="Multiple">
                                                <asp:ListItem Selected="True" Value="0"></asp:ListItem>
                                            </asp:ListBox>
                                            <asp:CompareValidator ID="CompareValidator5" runat="server" ControlToValidate="lstShift"
                                                ErrorMessage="Select Shift Time" Operator="NotEqual" ValidationGroup="shiftsearch"
                                                ValueToCompare="0">*</asp:CompareValidator>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                        </asp:MultiView>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Label ID="lblmsg" runat="server" Text="" CssClass="error"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                        <asp:MultiView ID="MultiView2" runat="server">
                            <asp:View ID="View3" runat="server">
                                <asp:GridView ID="GVemployee" CssClass="GridView" runat="server" AutoGenerateColumns="false" Visible="false">
                                  
                                    <RowStyle CssClass="RowStyle" />
                                    <FooterStyle CssClass="FooterStyle" />
                                    <PagerStyle CssClass="PagerStyle" />
                                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                                    <HeaderStyle CssClass="HeaderStyle" />
                                    <EditRowStyle BackColor="#999999" />
                                    <AlternatingRowStyle CssClass="AltRowStyle" />
                                </asp:GridView>
                                <br />
                                <br />
                              
                            </asp:View>
                        </asp:MultiView>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                       
                    </td>
                </tr>
            </table>
      
</asp:Content>
