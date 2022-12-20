<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="DriverAttritation.aspx.cs" Inherits="DriverAttritation" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        ValidationGroup="save" />
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="add" />
            <table width="60%">
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lblErrorMsg" runat="server" CssClass="error"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="heading" style="width: 99%">
                                    <div class="gradient2">
                                        <h1>
                                            <span></span>Driver Master
                                        </h1>
                                        <h2>
                                            Allows to View/Edit and Add New Driver.</h2>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%">
                            <tr>
                                <td align="center">
                                    <table width="60%">
                                        <tr>
                                            <td valign="middle" align="left">
                                                <table width="100%" class="table">
                                                    <tr>
                                                        <td align="center" class="row1">
                                                            <b>Facility</b>
                                                        </td>
                                                        <td align="center" class="row1">
                                                            <b>Vendor</b>
                                                        </td>
                                                        <td align="center" class="row1">
                                                            Attrited</td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:DropDownList ID="ddlSelectFacility" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSelectFacility_SelectedIndexChanged"
                                                                AppendDataBoundItems="True">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td align="center">
                                                            <asp:DropDownList ID="ddlSelectVendor" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSelectVendor_SelectedIndexChanged"
                                                                AppendDataBoundItems="True">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td align="center">
                                                            <asp:CheckBox ID="ChkAtt" runat="server" AutoPostBack="true" 
                                                                oncheckedchanged="ChkAtt_CheckedChanged"/>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <table border="1" bordercolor="black" align="center">
                                                    <tr>
                                                        <td bgcolor="red">
                                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                                        </td>
                                                        <td>
                                                            Expired
                                                        </td>
                                                        <td bgcolor="green">
                                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                                        </td>
                                                        <td>
                                                            5 Days Left
                                                        </td>
                                                        <td bgcolor="SteelBlue">
                                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                                        </td>
                                                        <td>
                                                            7 Days Left
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                                                    DisplayAfter="0">
                                                    <ProgressTemplate>
                                                        <table align="center" align="center">
                                                            <tr>
                                                                <td align="center">
                                                                    <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" />
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
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%--<asp:MultiView ID="MultiView1" runat="server">
                                        <asp:View ID="View1" runat="server">--%>
                                            <table align="center" width="100%">
                                                <tr>
                                                    <td align="center">
                                                        <asp:GridView ID="GVDriverMaster" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                            DataKeyNames="ID" OnPageIndexChanging="GVDriverMaster_PageIndexChanging" PageSize="20"
                                                            CssClass="GridView" BorderWidth="0px" EmptyDataText="No record found" ShowFooter="True" Width="1200px" OnRowDataBound="GVDriverMaster_RowDataBound">
                                                            <RowStyle CssClass="RowStyle" />
                                                            <FooterStyle CssClass="FooterStyle" />
                                                            <PagerStyle CssClass="PagerStyle" />
                                                            <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                            <HeaderStyle BackColor="#004f75" ForeColor="White" Font-Bold="true" />
                                                            <EditRowStyle BackColor="#999999" />
                                                            <AlternatingRowStyle CssClass="AltRowStyle" />
                                                            <EmptyDataRowStyle ForeColor="Red" Font-Bold="true" HorizontalAlign="Left" />
                                                            <Columns>
                                                                <asp:TemplateField>
                                                                    <HeaderTemplate>
                                                                        <asp:CheckBox ID="ChkAll" runat="server" 
                                                                            oncheckedchanged="ChkAll_CheckedChanged" AutoPostBack="true"/>
                                                                        Select All
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkId" runat="server" />
                                                                        <asp:Label ID="lblCabId" runat="server" Text='<%#Eval("ID") %>' Visible="false"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="vehicleNo" HeaderText="CabID" />
                                                                <asp:BoundField DataField="DriverName" HeaderText="Driver Name" />
                                                                <asp:BoundField DataField="DateOfJoining" HeaderText="Date Of Joining" />
                                                                <asp:BoundField DataField="BadgeNo" HeaderText="BadgeNo" />
                                                                <asp:BoundField DataField="BadgeIssueDate" HeaderText="Badge Issue Date" />
                                                                <asp:BoundField DataField="BadgeExpiryDate" HeaderText="Badge Expiry Date" />
                                                                <asp:BoundField DataField="LicenseNumber" HeaderText="License Number" />
                                                                <asp:BoundField DataField="LicenseIssuedDate" HeaderText="License Issued Date" />
                                                                <asp:BoundField DataField="LicenseExpiryDate" HeaderText="License Expiry Date" />
                                                                <asp:BoundField DataField="Contact1" HeaderText="Contact1" />
                                                                <asp:BoundField DataField="Contact2" HeaderText="Contact2" />
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 99%; height: 13px;" align="center">
                                                        <asp:Button ID="Button1" runat="server" Style="visibility: hidden" />
                                                        <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                                            TargetControlID="Button1" PopupControlID="Panel1" CancelControlID="btnCancelDetails">
                                                        </cc1:ModalPopupExtender>
                                                        <asp:Panel ID="Panel1" runat="server">
                                                                <table width="500px" style="border: 1px ridge #000000" bgcolor="#FFFFCC">
                                                                    <tr>
                                                                        <td align="right" style="width:30%">
                                                                            Description :</td>
                                                                        <td align="left" style="width:30%">
                                                                            <asp:TextBox ID="txtDescp" runat="server" Width="300px" TextMode="MultiLine" 
                                                                                CssClass="TextBox" Height="25px" ValidationGroup="add"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDescp"
                                                                                ErrorMessage="Please Enter Description !" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2" align="center">
                                                                            <asp:Button ID="ButtonSave" runat="server" CssClass="Button" 
                                                                                onclick="ButtonSave_Click" Text="Save" Width="60px" 
                                                                                ValidationGroup="add" />
                                                                            <asp:Button ID="btnCancelDetails" runat="server" CssClass="Button" 
                                                                                Text="Cancel" Width="60px" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="left" style="width:30%">
                                                                            &nbsp;</td>
                                                                        <td align="left" style="width:70%">
                                                                            &nbsp;</td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 99%" align="center">
                                                        <asp:CustomValidator ID="CustomValidatorCheckBox" runat="server" 
                                                            Display="Dynamic" 
                                                            ErrorMessage="Cannot Proceed Because Either You Did Not Choose Any Driver !" 
                                                            OnServerValidate="CustomValidatorCheckBox_ServerValidate" 
                                                            ValidationGroup="save">*</asp:CustomValidator>
                                                        <asp:Button ID="btnSave" runat="server" CssClass="Button" 
                                                            onclick="btnSave_Click" Text="OK" Width="60px" ValidationGroup="save" />
                                                    </td>
                                                </tr>
                                            </table>
                                        <%--</asp:View>
                                    </asp:MultiView>--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

