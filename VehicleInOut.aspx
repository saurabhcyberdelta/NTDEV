<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="VehicleInOut.aspx.cs" Inherits="VehicleInOut" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" border="0" width="100%">
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
            ShowSummary="False" ValidationGroup="Submit" Height="16px" />
        <tr align="center">
            <td class="heading" colspan="3">
                <div class="gradient2">
                    <h1>
                        <span></span>
                        Vehicle In/Out
                    </h1>
                    <h2>
                        Allows User to enter In/Out.
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
                                <td align="center" class="TDbg" colspan="6">
                                    Fill The Selection Criteria                                    
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
                                <td align="left" rowspan="2" valign="middle" width="25%">
                                </td>
                            </tr>
                            <tr align="center">
                                <td align="left" valign="top">
                                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="TextBox"></asp:TextBox>
                                    <cc1:calendarextender id="txtStartDate_CalendarExtender" runat="server" enabled="true"
                                        targetcontrolid="txtStartDate" popupbuttonid="ibcal1">
                                            </cc1:calendarextender>
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
        <tr align="center">
            <td>
            </td>
            <td align="right" width="80%">
                &nbsp;
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
            <td align="right" width="20%">
            </td>
        </tr>
        <tr>
            <td align="left" colspan="3">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="grdViewRouteParent" runat="server" AutoGenerateColumns="False"
                            DataKeyNames="RouteID" EmptyDataText="No record found" ShowFooter="True" BorderWidth="0px">
                            <Columns>
                            <asp:TemplateField  ItemStyle-Width="2%"  >
                                     <ItemTemplate>
                                       <asp:ImageButton ID="imgaddicon" runat="server" ImageUrl="~/images/checkmark.gif" visible='<%# Geticon(DataBinder.Eval(Container.DataItem, "inoutUpdate")) %>' Enabled="false"  />
                                             </ItemTemplate>
                                     </asp:TemplateField>
                                <asp:TemplateField HeaderText="RouteID" ItemStyle-Width="10%">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="lblRouteID" runat="server" Target="new" CssClass="linkButton"
                                            Text='<%# Bind("RouteID") %>' NavigateUrl='<%# GetURL(DataBinder.Eval(Container.DataItem, "RouteID")) %>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%"></ItemStyle>
                                </asp:TemplateField>
                                <asp:BoundField DataField="shiftTime" HeaderText="Shift" ReadOnly="True" ItemStyle-Width="5%">
                                    <ItemStyle Width="5%"></ItemStyle>
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Location">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Location") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="45%" />
                                    <FooterTemplate>
                                        <asp:Label ID="lblParentErrorMsg" runat="server"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="totalStop" HeaderText="" ReadOnly="True" ItemStyle-Width="5%">
                                    <ItemStyle Width="2%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="vendorName" HeaderText="Vendor" ReadOnly="True" ItemStyle-Width="5%">
                                    <ItemStyle Width="5%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="vehicleId" HeaderText="CabID" ReadOnly="True" ItemStyle-Width="5%">
                                    <ItemStyle Width="5%"></ItemStyle>
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Time IN">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtSDate" runat="server" Text='<%# Eval("Etimings")%>' MaxLength="10"
                                            CssClass="TextBox" TabIndex="1" Enabled='<%# getenablepick() %>'></asp:TextBox>&nbsp;
                                        <asp:TextBox ID="txtTIMEIN" runat="server" MaxLength="5" Text='<%# getintime(DataBinder.Eval(Container.DataItem, "actVehicleSTime"),DataBinder.Eval(Container.DataItem, "actVehicleETime"))%>' Enabled='<%# getenablepick() %>' CssClass="TextBox" TabIndex="1"></asp:TextBox>
                                        <itemstyle width="10%" ></itemstyle>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Time Out">
                                    <FooterTemplate>
                                        <asp:ImageButton ID="imbSaveInOut" runat="server" ImageUrl="~/images/save.png" 
                                            onclick="imbSaveInOut_Click" />
                                    </FooterTemplate>
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtEDate" runat="server" Text='<%# Eval("Stimings")%>' MaxLength="10"
                                            CssClass="TextBox" TabIndex="1" Enabled='<%# getenabledrop() %>'></asp:TextBox>&nbsp;
                                        <asp:TextBox ID="txtTIMEOut" runat="server" MaxLength="5" Text='<%# getouttime(DataBinder.Eval(Container.DataItem, "actVehicleSTime"),DataBinder.Eval(Container.DataItem, "actVehicleETime"))%>' Enabled='<%# getenabledrop() %>' CssClass="TextBox" TabIndex="1"></asp:TextBox>
                                        <itemstyle width="10%"></itemstyle>
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
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
</asp:Content>
