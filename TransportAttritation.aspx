<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="TransportAttritation.aspx.cs" Inherits="TransportAttritation" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style type="text/css">
        .style7
        {
            border-left: thin solid #99C65B;
            border-right: thin solid #99C65B;
            border-top: thin none #99C65B;
            border-bottom: thin none #99C65B;
            width: 38%;
            padding: 15px;
            vertical-align: top;
            text-align: right;
        }
        .style8
        {
            border-left: thin solid #99C65B;
            border-right: thin solid #99C65B;
            border-top: thin none #99C65B;
            border-bottom: thin none #99C65B;
            width: 62%;
            padding: 15px;
            vertical-align: top;
            text-align: left;
        }
    .style9
    {
        border-left: thin solid #99C65B;
        border-right: thin solid #99C65B;
        border-top: thin none #99C65B;
        border-bottom: thin none #99C65B;
        width: 38%;
        padding: 15px;
        vertical-align: top;
        text-align: right;
        height: 18px;
    }
    .style10
    {
        border-left: thin solid #99C65B;
        border-right: thin solid #99C65B;
        border-top: thin none #99C65B;
        border-bottom: thin none #99C65B;
        width: 62%;
        padding: 15px;
        vertical-align: top;
        text-align: left;
        height: 18px;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table align="center" border="0" width="100%">
                <tr align="center">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="spoc" />
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="save" />
                    <td class="heading">
                        <div class="gradient2">
                            <h1>
                                <span></span>Employee Transport Opt Out/Opt In
                            </h1>
                            <h2>
                               
                            </h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch">
                            <table align="center">
                                <tr>
                                    <td align="center" width="33%">
                                        &nbsp; Enter Employee ID or Name:&nbsp;
                                    </td>
                                    <td width="33%">
                                        <asp:TextBox ID="txtEmpIdName" runat="server" MaxLength="100" 
                                            ValidationGroup="spoc"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                            ControlToValidate="txtEmpIdName" Display="Dynamic" 
                                            ErrorMessage="Please Enter Name or Id" SetFocusOnError="True" 
                                            ValidationGroup="search">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td width="33%">
                                        <asp:Button ID="btnSearch" runat="server" CssClass="Button" 
                                            OnClick="btnSearch_Click" Text="Search" ValidationGroup="search" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="33%">
                                        &nbsp;
                                    </td>
                                    <td width="33%">
                                        <asp:Label ID="lblMsg" runat="server" CssClass="error"></asp:Label>
                                    </td>
                                    <td width="33%">
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:MultiView ID="MultiView1" runat="server">
                            <table width="100%">
                                <tr>
                                    <td>
                                        <asp:View ID="View1" runat="server">
                                            <table width="100%" align="center">
                                                <tr>
                                                    <td align="center">
                                                        <asp:GridView ID="grdSearchEmployee" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
                                                            OnPageIndexChanging="grdSearchEmployee_PageIndexChanging" OnSelectedIndexChanging="grdSearchEmployee_SelectedIndexChanging"
                                                            AllowPaging="True" CssClass="GridView" BorderWidth="0px" ShowFooter="True" Width="60%">
                                                            <Columns>
                                                                <asp:CommandField ShowSelectButton="True" />
                                                                <asp:TemplateField HeaderText="Employee Id"><ItemTemplate><asp:Label ID="lblEmpId" runat="server" Text='<%# Eval("empCode") %>'></asp:Label></ItemTemplate></asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Employee Name"><ItemTemplate><asp:Label ID="lblEmpName" runat="server" Text='<%# Eval("empName") %>'></asp:Label></ItemTemplate></asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Process"><ItemTemplate><asp:Label ID="lblEmpProcess" runat="server" Text='<%# Eval("processName") %>'></asp:Label></ItemTemplate></asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Facility"><ItemTemplate><asp:Label ID="lblEmpFacility" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label></ItemTemplate></asp:TemplateField>
                                                                <asp:TemplateField HeaderText="E-mail"><ItemTemplate><asp:Label ID="lblEmpEmail" runat="server" Text='<%# Eval("email") %>'></asp:Label></ItemTemplate></asp:TemplateField>
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
                                        </asp:View>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:View ID="View2" runat="server">
                                            <table width="90%" border="0" cellpadding="2" cellspacing="0" align="center">
                                                <tr>
                                                    <td align="center">
                                                        <table align="center" width="90%" cellpadding="4" cellspacing="0" class="myTable">
                                                            <tr>
                                                                <td colspan="4" class="TDbg">
                                                                    <asp:Label ID="lblempName" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="20%" class="myTableRowStyle">
                                                                    EmployeeID :
                                                                </td>
                                                                <td width="40%" class="myTableRowStyle">
                                                                    <asp:Label ID="lblEmpID" runat="server"></asp:Label>
                                                                    &nbsp;
                                                                </td>
                                                                <td width="25%" class="myTableRowStyle">
                                                                    Employee Name :
                                                                </td>
                                                                <td width="20%" class="myTableRowStyle">
                                                                    <asp:Label ID="lblEmployeeName" runat="server"></asp:Label>
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="myTableAltRowStyle" width="20%">
                                                                    Department :
                                                                </td>
                                                                <td class="myTableAltRowStyle" width="40%">
                                                                    <asp:Label ID="lblDepartment" runat="server"></asp:Label>
                                                                </td>
                                                                <td class="myTableAltRowStyle" width="25%">
                                                                    Facility :
                                                                </td>
                                                                <td class="myTableAltRowStyle" width="20%">
                                                                    <asp:Label ID="lblFacility" runat="server"></asp:Label>
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="myTableRowStyle" width="20%">
                                                                    Mobile Number :
                                                                </td>
                                                                <td class="myTableRowStyle" width="40%">
                                                                    <asp:Label ID="lblMobile" runat="server"></asp:Label>
                                                                </td>
                                                                <td class="myTableRowStyle" width="25%">
                                                                    Other Number :
                                                                </td>
                                                                <td class="myTableRowStyle" width="20%">
                                                                    <asp:Label ID="lblPhone" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr class="myTableAltRowStyle">
                                                                <td class="myTableAltRowStyle" width="20%">
                                                                    Address :
                                                                </td>
                                                                <td class="myTableAltRowStyle" width="40%">
                                                                    <asp:Label ID="lblAddress" runat="server"></asp:Label>
                                                                </td>
                                                                <td class="myTableAltRowStyle" width="25%">
                                                                    Location :
                                                                </td>
                                                                <td class="myTableAltRowStyle" width="20%">
                                                                    <asp:Label ID="lblLocation" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="myTableRowStyle" width="20%">
                                                                    Reporting Manager :
                                                                </td>
                                                                <td class="myTableRowStyle" width="40%">
                                                                    <asp:Label ID="lblRepManager" runat="server"></asp:Label>
                                                                </td>
                                                                <td class="myTableRowStyle" width="25%">
                                                                    Manager Mobile No. :
                                                                </td>
                                                                <td class="myTableRowStyle" width="20%">
                                                                    <asp:Label ID="lblManagerNo" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="myTableAltRowStyle" width="20%">
                                                                    Cost Center :
                                                                </td>
                                                                <td class="myTableAltRowStyle" width="40%">
                                                                    <asp:Label ID="lblCostcenter" runat="server"></asp:Label>
                                                                </td>
                                                                <td class="myTableAltRowStyle" width="25%">
                                                                    Division Manager :
                                                                </td>
                                                                <td class="myTableAltRowStyle" width="20%">
                                                                    <asp:Label ID="lblDivisionManager" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="myTableRowStyle" width="20%">
                                                                    IsGeoCoded :
                                                                </td>
                                                                <td class="myTableRowStyle" width="40%">
                                                                    <asp:Image ID="imgIsGeoCoded" runat="server" />
                                                                </td>
                                                                <td class="myTableRowStyle" width="25%">
                                                                    Transport Required :
                                                                </td>
                                                                <td class="myTableRowStyle" width="20%">
                                                                    <asp:Image ID="imgIsTptReq" runat="server" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                            <td class="myTableAltRowStyle">Effective Date :</td>
                                                            <td class="myTableAltRowStyle">
                                                             <asp:Label ID="lblEffectiveDate" runat="server"></asp:Label>
                                                            </td>
                                                             <td class="myTableAltRowStyle"></td>
                                                            <td class="myTableAltRowStyle">
                                                            
                                                            </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <asp:Button ID="btnSubmit" runat="server" CssClass="Button" 
                                                            onclick="btnSubmit_Click" Text="Edit Toop" Width="144px" />
                                                        <br />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                    </td>
                                </tr>
                            </table>
                        </asp:MultiView>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="Button1" runat="server" Text="Show Modal" Style="visibility: hidden" />
                            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modal-bg"
                                TargetControlID="Button1" PopupControlID="pnlModal" CancelControlID="ibtnSMclose">
                            </cc1:ModalPopupExtender>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <asp:Panel ID="pnlModal" runat="server" CssClass="modal" DefaultButton="btnSave">
                                        <table cellpadding="0" cellspacing="0" width="80%" align="center">
                                            <tr>
                                              
                                                <td class="blueHeaderMiddleCenter" width="100%">
                                                    <%--RouteID:-
                                                    <asp:Label ID="lblDelayRouteID" runat="server"></asp:Label>
                                                    PartnerID:-
                                                    <asp:Label ID="lblDelayEmpID" runat="server"></asp:Label>--%>
                                                </td>
                                                <td class="blueHeaderMiddleCenter1">
                                                    <asp:ImageButton ID="ibtnSMclose" runat="server" ImageUrl="~/images/Window/CloseOut.gif"
                                                        CssClass="ButtonCloseOver" />
                                                </td>
                                              
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <table cellpadding="0" cellspacing="0" style="height: 149px; width: 100%">
                                                        <tr>
                                                            <td class="style9">
                                                                Tpt Req :</td>
                                                            <td class="style10">
                                                                <asp:CheckBox ID="chkTpt" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style7">
                                                                Employee TOOP Date :
                                                            </td>
                                                            <td class="style8">
                                                                <asp:TextBox ID="txtStartDate" runat="server" CssClass="TextBox1" 
                                                                    MaxLength="40"></asp:TextBox>
                                                                <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" 
                                                                    Enabled="true" PopupButtonID="Image1" TargetControlID="txtStartDate">
                                                                </cc1:CalendarExtender>
                                                                &nbsp;<asp:Image ID="Image1" runat="server" ImageUrl="~/images/calendar_icon.gif" />
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtStartDate"
                                                                    ErrorMessage="Please Select TOOP Date !" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style7">
                                                                Description :</td>
                                                            <td class="style8">
                                                                <asp:TextBox ID="txtDescp" runat="server" CssClass="TextBox1" 
                                                                    MaxLength="40" TextMode="MultiLine" ValidationGroup="save"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDescp"
                                                                    ErrorMessage="Please Enter Description !" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style7">
                                                                &nbsp;</td>
                                                            <td class="style8">
                                                                <asp:Button ID="btnSave" runat="server" CssClass="Button" 
                                                                    OnClick="btnSave_Click" Text="Save" ValidationGroup="save"/>
                                                                <asp:Button ID="btnCancel" runat="server" CssClass="Button" Text="Cancel" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <table width="100%" cellpadding="0" cellspacing="0" class="footerInnserTable">
                                                        <tr>
                                                            <td class="blueFooterMiddleCenter">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <%--<asp:MultiView ID="MultiView5" runat="server">
                            <asp:View ID="View7" runat="server">
                                <asp:Button ID="Button2" runat="server" Text="Show Modal" Style="visibility: hidden" />
                                <cc1:ModalPopupExtender ID="ModalPopupExtender2" runat="server" BackgroundCssClass="modal-bg"
                                    TargetControlID="Button2" PopupControlID="pnlModal" CancelControlID="ibtnSMclose">
                                </cc1:ModalPopupExtender>
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td>
                                            <asp:Panel ID="pnlModal" runat="server" CssClass="modal" DefaultButton="btnSaveDelayReason">
                                                <table cellpadding="0" cellspacing="0" width="100%" align="center">
                                                    <tr>
                                                        <td class="blueHeaderMiddleLeft" width="1%">
                                                            &nbsp;
                                                        </td>
                                                        <td class="blueHeaderMiddleCenter" width="100%">
                                                            RouteID:-
                                                            <asp:Label ID="lblDelayRouteID" runat="server"></asp:Label>
                                                            PartnerID:-
                                                            <asp:Label ID="lblDelayEmpID" runat="server"></asp:Label>
                                                        </td>
                                                        <td class="blueHeaderMiddleCenter1">
                                                            <asp:ImageButton ID="ibtnSMclose" runat="server" ImageUrl="~/images/Window/CloseOut.gif"
                                                                CssClass="ButtonCloseOver" />
                                                        </td>
                                                        <td class="blueHeaderMiddleRight" width="1%">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6">
                                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                                <tr>
                                                                    <td class="style7">
                                                                        Enter the Delay Reason:
                                                                    </td>
                                                                    <td class="style8">
                                                                        <asp:TextBox ID="txtDelayReason" runat="server" MaxLength="40" CssClass="TextBox1"></asp:TextBox>
                                                                    </td>
                                                                    <td class="contentInnerTable" width="60%">
                                                                        <asp:Button ID="btnSaveDelayReason" runat="server" Text="Save" OnClick="btnSaveDelayReason_Click"
                                                                            CssClass="Button" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4">
                                                            <table width="100%" cellpadding="0" cellspacing="0" class="footerInnserTable">
                                                                <tr>
                                                                    <td class="blueFooterMiddleCenter">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                        </asp:MultiView>--%>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

