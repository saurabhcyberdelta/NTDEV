<%@ Page Title="" Language="C#" EnableEventValidation="true" MasterPageFile="~/eTMSMaster.Master"
    AutoEventWireup="true" CodeFile="DummyTripsheetGen.aspx.cs" Inherits="DummyTripsheetGen"
    EnableViewState="True" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            color: #FFFFFF;
            font-size: small;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <table align="center" width="100%">
                <tr>
                    <td>
                        <table align="center" width="100%">
                            <tr>
                                <td align="center">
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                        ShowSummary="False" ValidationGroup="Submit" />
                                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                                        ShowSummary="False" ValidationGroup="Search" />
                                </td>
                            </tr>
                            <tr>
                                <td class="heading">
                                    <div class="gradient2">
                                        <h1>
                                            <span></span>Generate Dummy Roster
                                        </h1>
                                        <h2>
                                            Allows to Generate Dummy Tripsheet as Blank/Non-Blank.
                                        </h2>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <asp:RadioButtonList ID="rbtnSearchType" runat="server" AutoPostBack="True" Font-Bold="True"
                                        OnSelectedIndexChanged="rbtnSearchType_SelectedIndexChanged" RepeatDirection="Horizontal"
                                        Style="margin-left: 0px">
                                        <asp:ListItem Selected="True" Value="Blank">Blank Sheet</asp:ListItem>
                                        <asp:ListItem Value="NonBlank">With Partner</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table border="0" cellpadding="4" cellspacing="0" align="left" width="80%" class="tableBorber">
                            <tr>
                                <td align="center" class="TDbg" colspan="7">
                                    Fill The Selection Criteria
                                    <asp:Label ID="lblFacError" runat="server" CssClass="error" Text="Select Facility"
                                        Visible="False"></asp:Label>
                                    &nbsp; &nbsp; &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <b>Date:</b>
                                </td>
                                <td align="left" valign="middle">
                                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="TextBox"></asp:TextBox>
                                    <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" Enabled="True"
                                        TargetControlID="txtStartDate" PopupButtonID="ImgBtnCalendar">
                                    </cc1:CalendarExtender>
                                    <asp:ImageButton ID="ImgBtnCalendar" runat="server" ImageUrl="Images/calendar_icon.gif"
                                        Height="17px" Width="17px" />
                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtStartDate"
                                        Display="Dynamic" ErrorMessage="Start Date Required" ValidationGroup="Submit"
                                        SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtStartDate"
                                        Display="Dynamic" ErrorMessage="Date Format:mm/dd/yyyy" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                        ValidationGroup="Submit" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                    &nbsp;&nbsp;<br />
                                </td>
                                <td align="right">
                                    &nbsp; <b>Facility Name:</b>
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlfacility" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                        OnSelectedIndexChanged="ddlfacility_SelectedIndexChanged" CssClass="DropDownListBox3">
                                        <asp:ListItem Selected="True" Value="0">-Select-</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlfacility"
                                        ErrorMessage="Select Facility" Operator="NotEqual" ValueToCompare="0" ValidationGroup="Submit"
                                        SetFocusOnError="True">*</asp:CompareValidator>
                                </td>
                                <td align="left">
                                    <asp:RadioButtonList ID="rdbtnlstType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rdbtnlstType_SelectedIndexChanged"
                                        RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True" Value="P">Pick</asp:ListItem>
                                        <asp:ListItem Value="D">Drop</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td align="right">
                                    <b>Shift:<br />
                                    </b>
                                </td>
                                <td align="left">
                                    <asp:ListBox ID="lstShift" runat="server" SelectionMode="Single" AppendDataBoundItems="True">
                                        <asp:ListItem Selected="True" Value="0">-Select-</asp:ListItem>
                                    </asp:ListBox>
                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="lstShift"
                                        Display="Dynamic" ErrorMessage="Select ShiftTime" Operator="NotEqual" ValidationGroup="Submit"
                                        ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <b>Cab:</b>
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlCabType" runat="server" AppendDataBoundItems="true">
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="ddlCabType"
                                        Display="Dynamic" ErrorMessage="Select CabType" Operator="NotEqual" ValidationGroup="Submit"
                                        ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                </td>
                                <td align="right">
                                    <b>Remarks:</b>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtRemarks" runat="server" Height="46px" TextMode="MultiLine" Width="266px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                </td>
                                <caption>
                                    <asp:Panel ID="Panel1" runat="server">
                                        <td align="right" width="80px">
                                            <b>No of Sheets:</b>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtNoOfSheets" runat="server" CssClass="TextBox" MaxLength="4"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNoOfSheets"
                                                Display="Dynamic" ErrorMessage="Enter No of Sheets" SetFocusOnError="True" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                                            <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtNoOfSheets"
                                                Display="Dynamic" ErrorMessage="The value must be from 1 to 999!" MaximumValue="999"
                                                MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="Submit">*</asp:RangeValidator>
                                        </td>
                                        <td align="left">
                                            <asp:Button ID="btnSubmit" runat="server" CssClass="Button" OnClick="btnSubmit_Click"
                                                Text="Generate" ValidationGroup="Submit" />
                                        </td>
                                    </asp:Panel>
                                </caption>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="Panel3" runat="server" Visible="False">
                            <br />
                            <table align="left" cellpadding="4" class="tableBorber" width="80%">
                                <tr style="background-image: url('images/bg-menu-main.png')">
                                    <td align="left" class="style1">
                                        <b>List of to be Added Partners</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:GridView ID="grdShowAddedEmp" runat="server" AutoGenerateColumns="False" BorderWidth="0"
                                            OnPageIndexChanging="grdShowAddedEmp_PageIndexChanging" ShowFooter="True" Width="100%">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Partner Id">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEmpId" runat="server" Text='<%# Eval("empCode") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Partner Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEmpName" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Gender">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEmpFacility" runat="server" Text='<%# Eval("Gender") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField FooterStyle-HorizontalAlign="Right" HeaderText="Address">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEmpEmail" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <asp:Button ID="btnGenerateEmpDummy" runat="server" CssClass="Button" OnClick="btnGenerateEmpDummy_Click"
                                                            Text="Generate Dummy" ValidationGroup="Submit" />
                                                    </FooterTemplate>
                                                    <FooterStyle HorizontalAlign="Right" />
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
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <asp:Panel ID="Panel2" runat="server" DefaultButton="btnSearch" Visible="False">
                            <table>
                                <tr>
                                    <td align="right">
                                        <b>Search Partner:</b>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtEmpIdName" runat="server" CssClass="TextBox1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmpIdName"
                                            Display="Dynamic" ErrorMessage="Please Enter Name or Id" SetFocusOnError="True"
                                            ValidationGroup="Search">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left">
                                        <asp:Button ID="btnSearch" runat="server" CssClass="Button" OnClick="btnSubmit_Click"
                                            Text="Search" ValidationGroup="Search" />
                                        <asp:Label ID="lblMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table align="left" width="80%">
                            <tr>
                                <td align="center">
                                    <asp:GridView ID="GvEmployee" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        BorderWidth="0" DataKeyNames="Id" OnPageIndexChanging="GvEmployee_PageIndexChanging"
                                        OnSelectedIndexChanging="GvEmployee_SelectedIndexChanging" Width="100%">
                                        <Columns>
                                            <asp:CommandField SelectText="ADD" ShowSelectButton="True" />
                                            <asp:TemplateField HeaderText="Partner Id">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmpId" runat="server" Text='<%# Eval("empCode") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Partner Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmpName" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Process">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmpProcess" runat="server" Text='<%# Eval("processName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Facility">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmpFacility" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="E-mail">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmpEmail" runat="server" Text='<%# Eval("email") %>'></asp:Label>
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
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel2"
                            DisplayAfter="0">
                            <ProgressTemplate>
                                <table align="center">
                                    <tr>
                                        <td>
                                            <img alt="Loading" src="images/ajax-loader.gif" style="width: 16px; height: 16px" />
                                        </td>
                                        <td align="center" class="main_bg">
                                            Loading.....Please Wait!!!&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSubmit" />
            <asp:PostBackTrigger ControlID="grdShowAddedEmp" />
        </Triggers>
    </asp:UpdatePanel>

    <script language="javascript" type="text/javascript">
        function RedirectToNewPage() {
            alert("Welcome");
            return false;
        }
    </script>

</asp:Content>
