<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="OpCompliance.aspx.cs" Inherits="OpCompliance" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="left" width="100%">
        <tr>
            <td align="center">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="submit" />
            </td>
        </tr>
        <tr>
            <td class="heading">
                <div class="gradient2">
                    <h1>
                        <span></span>Operations Check / Penalty Sheet
                    </h1>
                    <h2>
                        Allow to Operations Compliance check for every vehicle.
                    </h2>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                         <table border="0" cellpadding="0" cellspacing="0" align="left" width="100%" 
                            class="tableBorber">
                            
                            <tr>
                                <td align="center" class="TDbg" colspan="7">
                                    Fill The Selection Criteria
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>ShiftDate</b>
                                </td>
                                
                                 <td align="left" rowspan="2" valign="middle" width="15%">
                                            <asp:RadioButtonList ID="rdoTripType" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                                                AutoPostBack="True" OnSelectedIndexChanged="rdoTripType_SelectedIndexChanged">
                                                <asp:ListItem Selected="True" Value="P">Pick</asp:ListItem>
                                                <asp:ListItem Value="D">Drop</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td>
                                    <b>Facility</b>
                                </td>
                                        <td>
                                       <b> Shift</b>
                                        </td>
                                <td>
                                    <b>Vendor</b>
                                </td>
                                
                                <td>
                                    <b>Cab Id</b>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" width="15%" >
                                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="TextBox"></asp:TextBox>
                                    <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" Enabled="True"
                                        TargetControlID="txtStartDate" PopupButtonID="ibcal1">
                                    </cc1:CalendarExtender>
                                    <asp:ImageButton ID="ibcal1" runat="server" ImageUrl="~/images/calendar_icon.gif"
                                        Height="17px" />
                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtStartDate"
                                        Display="Dynamic" ErrorMessage="Start Date Required" ValidationGroup="submit"
                                        SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtStartDate"
                                        Display="Dynamic" ErrorMessage="Date Format:mm/dd/yyyy" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                        ValidationGroup="submit" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                    &nbsp;&nbsp;<br />
                                </td>
                                <td align="left" width="15%" valign="middle">
                                    <asp:DropDownList ID="ddlfacility" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                        CssClass="DropDownListBox3" OnSelectedIndexChanged="ddlfacility_SelectedIndexChanged">
                                        <asp:ListItem Selected="True" Value="0">Select Facility</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="ddlfacility"
                                        ErrorMessage="Select Facility" Operator="NotEqual" SetFocusOnError="True" ValidationGroup="submit"
                                        ValueToCompare="0">*</asp:CompareValidator>
                                </td>
                                  <td align="left" valign="top">
                                            <asp:ListBox ID="lstShift" runat="server" AppendDataBoundItems="True">
                                                <asp:ListItem Selected="True" Value="0"></asp:ListItem>
                                            </asp:ListBox>
                                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="lstShift"
                                                ErrorMessage="Select Shift Time" Operator="NotEqual" ValidationGroup="submit"
                                                ValueToCompare="0">*</asp:CompareValidator>
                                        </td>
                                <td align="left" valign="middle">
                                    <asp:DropDownList ID="ddlVendor" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3"
                                        AutoPostBack="True" OnSelectedIndexChanged="ddlVendor_SelectedIndexChanged">
                                        <asp:ListItem>Select Vendor</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlVendor"
                                        Display="Dynamic" ErrorMessage="Select Vendor" Operator="NotEqual" ValidationGroup="submit"
                                        ValueToCompare="0">*</asp:CompareValidator>
                                </td>
                                <td align="left" valign="middle">
                                 <asp:Panel ID="Panel1" runat="server" HorizontalAlign="Center" DefaultButton="btnSubmit">
                           
                                    <asp:TextBox ID="txtCabID" runat="server" MaxLength="20" CssClass="TextBox"></asp:TextBox>
                                    <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="txtCabID"
                                        ErrorMessage="Enter Vehicle Number" Operator="NotEqual" SetFocusOnError="True"
                                        ValidationGroup="submit" ValueToCompare="0">*</asp:CompareValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCabID"
                                        Display="Dynamic" ErrorMessage="Enter Vehicle Number" SetFocusOnError="True"
                                        ValidationGroup="submit">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtCabID"
                                        ErrorMessage="Cab ID should be alphanumeric only." SetFocusOnError="True" ValidationExpression="^[0-9a-zA-Z]+$"
                                        ValidationGroup="submit">*</asp:RegularExpressionValidator>
                                  </asp:Panel>
                                </td>
                               
                                <td align="left" valign="middle">
                                    <asp:Button ID="btnSubmit" runat="server" CssClass="Button" Height="26px" OnClick="btnSubmit_Click"
                                        Text="Submit" ValidationGroup="submit"  />
                                </td>
                             
                            </tr>
                          
                            <tr>
                                <td align="right" colspan="7">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="7">
                                    <asp:Panel ID="pnlDetail" runat="server" HorizontalAlign="Center">
                                    Registration No:  <asp:TextBox ID="txtRegistrationNo" runat="server" Visible="false"></asp:TextBox>
                                         
                                        <asp:GridView ID="gvDetail" runat="server" AutoGenerateColumns="False" Width="100%"
                                            DataKeyNames="HeadID,Status" EmptyDataText="No Data Found !" ShowFooter="True"
                                            CssClass="GridView" BorderWidth="0px">
                                            <EmptyDataRowStyle BorderStyle="Dotted" />
                                            <Columns>
                                           
                                                <asp:BoundField DataField="HeadName" HeaderText="Heads">
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30%" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                                            <asp:ListItem Value="N/A">N/A</asp:ListItem>
                                                            <asp:ListItem Value="OK">OK</asp:ListItem>
                                                            <asp:ListItem Value="NOT OK">NOT OK</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Remark">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtRemark" runat="server" Text='<%# Eval("Remark") %>' Width="180px"
                                                            Enabled="False"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegExpAlphanum" runat="server" ControlToValidate="txtRemark"
                                                            Display="Dynamic" ErrorMessage="Remark Should be Alphanumeric." Text="*" ValidationExpression="^([\w\-.,]|\s)*$"
                                                            ValidationGroup="save"></asp:RegularExpressionValidator>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Penalty">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Penalty") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPenalty" runat="server" Text='<%# Bind("Penalty") %>' Visible="False"></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <RowStyle CssClass="RowStyle" />
                                        <FooterStyle CssClass="FooterStyle" />
                                        <PagerStyle CssClass="PagerStyle" />
                                        <SelectedRowStyle CssClass="SelectedRowStyle" />
                                        <HeaderStyle CssClass="HeaderStyle" />
                                        <EditRowStyle BackColor="#999999" />
                                        <AlternatingRowStyle CssClass="AltRowStyle" />
                                        <EmptyDataRowStyle ForeColor="Red" Font-Bold="true" />
                                        </asp:GridView>
                                        <br />
                                        <asp:CheckBox ID="chkOther" runat="server" AutoPostBack="True" OnCheckedChanged="chkOther_CheckedChanged"
                                            Text="Not in the list, Enter Other !"  Visible="false"/>
                                       
                                        <asp:Button ID="btnSave" runat="server" CssClass="Button" Height="26px" OnClick="btnSave_Click"
                                            Text="Save" Visible="False" Width="60px" ValidationGroup="save" />
                                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                                            ShowSummary="False" ValidationGroup="save" />
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="7">
                                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                    DisplayAfter="0">
                    <ProgressTemplate>
                        <table align="center">
                            <tr>
                                <td>
                                    <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loading" />
                                </td>
                                <td class="main_bg" align="left">
                                    Loading.....Please Wait!!!&nbsp;
                                </td>
                            </tr>
                        </table>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>
    </table>
</asp:Content>
