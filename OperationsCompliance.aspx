<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="OperationsCompliance.aspx.cs" Inherits="OperationsCompliance" %>


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
                                <td align="center">
                                    <asp:Label ID="lblErrorMsg" runat="server" CssClass="error"></asp:Label>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="heading">
                                    <div class="gradient2">
                                        <h1>
                                            <span></span>Operations Compliance Entry
                                        </h1>
                                        <h2>
                                            Allows User to Enter Operations Compliance.
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
                                                 <asp:DetailsView ID="fvTrip" runat="server" AutoGenerateRows="False" Height="30px"
                                               Width="600px">
                                                <RowStyle CssClass="DetailsViewRowStyle" />
                                                <FooterStyle CssClass="DetailsViewFooterStyle" />
                                                <PagerStyle CssClass="DetailsViewPagerStyle" />
                                                <HeaderStyle CssClass="DetailsViewHeaderStyle" />
                                                <AlternatingRowStyle CssClass="DetailsViewAltRowStyle" />
                                                <Fields>
                                                    <asp:TemplateField HeaderText="CabID">
                                                        <ItemTemplate>
                                                            <%# Eval("vehicleId")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Registration No.">
                                                        <ItemTemplate>
                                                            
                                                             <asp:TextBox ID="txtVehicle" runat="server" Text='<%# Eval("vehicleNo")%>'
                                                        CssClass="TextBox"></asp:TextBox>
                                                         
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Vehicle Type">
                                                        <ItemTemplate>
                                                            <%# Eval("vehicle")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Right" HeaderText="Vendor">
                                                        <ItemTemplate>
                                                            <%# Eval("vendorname")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                     <asp:TemplateField HeaderStyle-HorizontalAlign="Right" HeaderText="Trip Type">
                                                        <ItemTemplate>
                                                            <%# Eval("tripType")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                     <asp:TemplateField HeaderStyle-HorizontalAlign="Right" HeaderText="Shift Time">
                                                        <ItemTemplate>
                                                            <%# Eval("shiftTime")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                     
                                                     <asp:TemplateField HeaderStyle-HorizontalAlign="Right" HeaderText="Remarks">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtRemarks" runat="server"  Text='<%# Eval("remark") %>'
                                                                                    TextMode="MultiLine" CssClass="TextBox" MaxLength="100" Width="90%"></asp:TextBox>
                                                                    
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                      <asp:TemplateField HeaderStyle-HorizontalAlign="Right" HeaderText="Penalty">
                                                        <ItemTemplate>
                                                           <asp:DropDownList ID="ddlPenalty" runat="server"  AutoPostBack="true" AppendDataBoundItems="true"
                                                                onselectedindexchanged="ddlPenalty_SelectedIndexChanged">
                                                                                <asp:ListItem Text="-Select-" Value="0"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                                 <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlPenalty"
                                                Display="Dynamic" ErrorMessage="Select Penalty" Operator="NotEqual" ValidationGroup="trip"
                                                ValueToCompare="0">*</asp:CompareValidator>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Right" HeaderText="Penalty:">
                                                        <ItemTemplate>
                                                        <asp:Label ID="lblPenalty" runat="server" Text='<%#Eval("PenaltyAmount") %>' ></asp:Label>
                              
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                </Fields>
                                            </asp:DetailsView>
                                                          
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">
                                                            <table width="100%" cellpadding="0" cellspacing="0" class="style8" >
                                                                <tr >
                                                                    <td style="background-image: url('images/Grid/footer.gif'); background-repeat: repeat; height: 25px; vertical-align: middle; text-align: center;" 
                                                                        bgcolor="#D6D6D6">
                                                                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" ValidationGroup="trip"
                                                                            Width="100px" CssClass="Button" />
                                                                    </td>
                                                                    
                                                                    <td style="background-image: url('images/Grid/footer.gif'); background-repeat: repeat; height: 25px; vertical-align: middle; text-align: right;" 
                                                                        bgcolor="#D6D6D6">
                                                                        &nbsp;</td>
                                                                </tr>
                                                            </table>
                                            </asp:Panel>
                                        </asp:View>
                                    </asp:MultiView></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                       
                       
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
