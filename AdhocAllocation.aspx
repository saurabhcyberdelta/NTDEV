<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="AdhocAllocation.aspx.cs" Inherits="AdhocAllocation" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="StyleSheets/GridView.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/TMS.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
<table border="0" width="100%">
      <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="Submit" Height="16px" />
        <tr >
        
            <td class="gradient2">
           
                <div class="gradient2">
                            <h1>
                                <span></span>   Aligned Unschedule Allocation
                            </h1>
                            <h2>
                               Allows to Allocate An Aligned Unschedule Request
                            </h2>
                        </div>
            
          
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <table border="0" cellpadding="4" cellspacing="0" width="100%" class="tableBorber">
                    <tr>
                        <td align="center" class="TDbg" colspan="5">
                            Fill The Selection Criteria
                            <asp:Label ID="lblFacError" runat="server" CssClass="error" Text="Select Facility"
                                Visible="False"></asp:Label>
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
                           <b> Trip Type</b></td>
                        <td align="left" valign="top">
                            <b>Shift</b></td>
                        <td align="left" rowspan="2" valign="middle">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit"  CssClass="Button" 
                onclick="btnSubmit_Click" ValidationGroup="Submit"/>
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="left" valign="top">
                            <asp:TextBox ID="txtStartDate" runat="server" CssClass="TextBox" 
                                ></asp:TextBox>
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
                            <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" 
                                CssClass="DropDownListBox3" AutoPostBack="true" 
                                onselectedindexchanged="ddlFacility_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlFacility"
                                Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                       
                        </td>
                        <td align="left" valign="top">
                            <asp:DropDownList ID="ddlTripType" runat="server" AutoPostBack="True" 
                                onselectedindexchanged="ddlTripType_SelectedIndexChanged">
                                <asp:ListItem Value="P">Pick</asp:ListItem>
                                <asp:ListItem Value="D">Drop</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td align="left" valign="top">
                            <asp:DropDownList ID="ddlShift" runat="server" AppendDataBoundItems="True">
                                <asp:ListItem Selected="True" Value="0">Select</asp:ListItem>
                            </asp:DropDownList>
                              <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlShift"
                                Display="Dynamic" ErrorMessage="Select Shift Time" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                       
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
          <td align="right">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                            DisplayAfter="0">
                            <ProgressTemplate>
                                <table align="center" style="width: 400px">
                                    <tr>
                                        <td colspan="4" style="width: 200px">
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
        
        <td align="left">
              <cc1:TabContainer ID="AJX" runat="server" Visible="false">
                 <cc1:TabPanel ID="TabPanel2" runat="server" HeaderText="Approved" >
            <ContentTemplate>
            <asp:GridView ID="GrdEmployeeAccepted" runat="server" DataKeyNames="id,Empid"  AutoGenerateColumns="false" width="100%" EmptyDataText="No Records Found">
            <Columns>
            <asp:TemplateField HeaderText="PartnerName">
            <ItemTemplate>
             <%# DataBinder.Eval(Container.DataItem, "empName")%>
            </ItemTemplate>
            </asp:TemplateField><asp:TemplateField HeaderText="ShiftTime">
            <ItemTemplate>
            <%# DataBinder.Eval(Container.DataItem, "ShiftTime")%>
                          
            </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Facility">
            <ItemTemplate>
            
            <%# DataBinder.Eval(Container.DataItem, "FacilityID")%>
            </ItemTemplate>
            </asp:TemplateField><asp:TemplateField HeaderText="Status">
            <ItemTemplate>
             <%# DataBinder.Eval(Container.DataItem, "Status")%>
            </ItemTemplate></asp:TemplateField>
            <asp:TemplateField HeaderText="Location">
            <ItemTemplate>
            <%# DataBinder.Eval(Container.DataItem, "Location") %>
            </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Align">
                          <ItemTemplate>
                          <asp:LinkButton ID="lbtnUpdate" Text="Align" runat="server" Enabled='<%# enableds(DataBinder.Eval(Container.DataItem, "Enableds")) %> '
                    onclick="lbtnUpdate_Click1"></asp:LinkButton>
                    </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="New Route">
                          <ItemTemplate>
                          <asp:LinkButton ID="lbtnNewRoute" Text="Add" runat="server" onclick="lbtnNewRoute_Click" Enabled='<%# enableds(DataBinder.Eval(Container.DataItem, "Enableds")) %>'
                   ></asp:LinkButton>
                    </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="RouteID">
            <ItemTemplate>
            <%# DataBinder.Eval(Container.DataItem, "routeid") %>
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
                         </cc1:TabContainer>
             
        </td>
        </tr>
        <tr>
        <td align="center">
            <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto" Width="90%" Height="50%" BackColor="White">
             <table>
            <tr>
            <td align="right" bgcolor="blue"><asp:ImageButton ID="btnClose" runat="server"   
                    ImageUrl ="~/images/no_icon.jpg" onclick="btnClose_Click" /></td>
            </tr>
            <tr align="center">
            <td align="center">
             <asp:Label ID="lblAssignEmpID" runat="server" Text="" Visible="false"></asp:Label>
               
                <asp:GridView ID="grdRoutes" Width="100%" runat="server" AutoGenerateColumns="false" CssClass="GridView">
                <Columns>
                <asp:TemplateField HeaderText="RouteID">
                <ItemTemplate>
                <asp:Label ID="lblRouteID" runat="server" Text='<%#Eval("RouteID") %>'></asp:Label>
                </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Shift Time">
                <ItemTemplate>
                <asp:Label ID="lblShiftTime" runat="server" Text='<%#Eval("ShiftTime") %>'></asp:Label>
                </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Address">
                <ItemTemplate>
                <asp:Label ID="lblAddress" runat="server" Text='<%#Eval("Address") %>'></asp:Label>
                </ItemTemplate>
                </asp:TemplateField>
               
                <asp:TemplateField HeaderText="Total Stop">
                <ItemTemplate>
                <asp:Label ID="lblTotalStop" runat="server" Text='<%#Eval("totalstop") %>'></asp:Label>
                </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                <asp:LinkButton ID="lbRouteAssign" Text="Assign" runat="server" 
                        onclick="lbRouteAssign_Click"></asp:LinkButton>
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
                </td>
                </tr>
                </table>
            </asp:Panel>
             <asp:Button ID="Button2" runat="server" Style="visibility: hidden" />
                       
                                       <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" Enabled="True"  BackgroundCssClass="modalBackground"
                            TargetControlID="Button2" PopupControlID="Panel1" 
                            DropShadow="false">
                        </cc1:ModalPopupExtender>
        </td>
        </tr>
      
    </table>
    </ContentTemplate>
    <Triggers>
    <asp:PostBackTrigger ControlID="lblexport" />
    </Triggers>
    </asp:UpdatePanel>

</asp:Content>

