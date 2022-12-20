<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="EmployeeToop.aspx.cs" Inherits="EmployeeToop" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td class="heading">
                        <div class="gradient2">
                            <h1>
                                <span></span>Employee Toop / Tracking Module
                            </h1>
                            <h2>
                                Allows To Edit Employee Toop Information.
                            </h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="lblMsg" runat="server" CssClass="error"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/ajax-loader.gif" />
                                Loding Please Wait......!!!!
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <table width="50%">
                            <tr>
                                <td style="width:33%;" align="right">
                                      Enter Employee ID or Name:  </td>
                                <td style="width:34%;" align="left">
                                    <asp:TextBox ID="txtEmpIdName" runat="server" MaxLength="100" 
                                            ValidationGroup="spoc"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                        ControlToValidate="txtEmpIdName" Display="Dynamic" 
                                        ErrorMessage="Please Enter Name or Id" SetFocusOnError="True" 
                                        ValidationGroup="search">*</asp:RequiredFieldValidator>
                                </td>
                                <td style="width:33%;" align="center">
                                    <asp:Button ID="btnSearch" runat="server" CssClass="Button" 
                                            OnClick="btnSearch_Click" Text="Search" ValidationGroup="search" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:MultiView ID="MultiView1" runat="server">
                            <table width="100%">
                                <tr>
                                    <td align="center">
                                        <asp:View ID="View1" runat="server">
                                            <asp:GridView ID="grdSearchEmployee" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
                                                OnPageIndexChanging="grdSearchEmployee_PageIndexChanging" OnSelectedIndexChanging="grdSearchEmployee_SelectedIndexChanging"
                                                AllowPaging="True" CssClass="GridView" BorderWidth="0px" ShowFooter="True" Width="60%">
                                                <Columns>
                                                    <asp:CommandField ShowSelectButton="True" />
                                                    <asp:TemplateField HeaderText="Employee Id">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblEmpId" runat="server" Text='<%# Eval("empCode") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Employee Name">
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
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <br />
                                                    </td>
                                                </tr>
                                                <%--<tr align="center">
                                                    <td>
                                                        <asp:Button ID="Button1" runat="server" Style="display: none" />
                                                        <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                                            TargetControlID="Button1" PopupControlID="Panel3" CancelControlID="btnClose">
                                                        </cc1:ModalPopupExtender>
                                                    </td>
                                                </tr>--%>
                                            </table>
                                        </asp:View>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                            </table>
                        </asp:MultiView>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

