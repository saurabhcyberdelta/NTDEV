<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="VehicleAttrition.aspx.cs" Inherits="VehicleAttrition" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%" align="center">
                <tr>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        ValidationGroup="save" />
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="add" />
                   
                    <td style="width: 99%" align="center">
                        <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="heading" style="width: 99%">
                        <div class="gradient2">
                            <h1>
                                <span></span>Vehicle Attrition
                            </h1>
                            <h2>
                                Allows to Attrite/Unattrite Vehicle.</h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 99%" align="center">
                        <table align="center">
                            <tr>
                                <td align="center" class="style7">
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                            DisplayAfter="0" >
                                        <ProgressTemplate>
                                            <table align="center" >
                                                <tr>
                                                    <td align="center" class="style7">
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
                            <tr>
                                <td align="center">
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="width: 99%" align="center">
                        &nbsp;<table class="table" width="60%">
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
                                    <asp:DropDownList ID="ddlSelectFacility" runat="server" AutoPostBack="True" 
                                        onselectedindexchanged="ddlSelectFacility_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td align="center">
                                    <asp:DropDownList ID="ddlSelectVendor" runat="server" AutoPostBack="True" 
                                        onselectedindexchanged="ddlSelectVendor_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td align="center">
                                    <asp:CheckBox ID="chkAtt" runat="server" AutoPostBack="true" 
                                        oncheckedchanged="chkAtt_CheckedChanged"/>
                                </td>
                            </tr>
                        </table>
                        <asp:GridView ID="GVVehicleMaster" runat="server" AllowPaging="True" 
                            AutoGenerateColumns="False" BorderWidth="0px" CssClass="GridView" 
                            DataKeyNames="Id" PageSize="20" ShowFooter="True" Width="1200px" 
                            onpageindexchanging="GVVehicleMaster_PageIndexChanging">
                            <RowStyle CssClass="RowStyle" />
                            <FooterStyle CssClass="FooterStyle" />
                            <PagerStyle CssClass="PagerStyle" />
                            <SelectedRowStyle CssClass="SelectedRowStyle" />
                            <HeaderStyle BackColor="#004f75" Font-Bold="true" ForeColor="White" />
                            <EditRowStyle BackColor="#999999" />
                            <AlternatingRowStyle CssClass="AltRowStyle" />
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkAll" runat="server" AutoPostBack="true"
                                            oncheckedchanged="chkAll_CheckedChanged" />
                                        &nbsp;Select All
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkId" runat="server" />
                                        <asp:Label ID="VehID" runat="server" Text='<%# Eval("CabID") %>' 
                                            Visible="False"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CabID">
                                    <%--<EditItemTemplate>
                                        <asp:Label ID="lblVehicleNoEdit" runat="server" Text='<%# Eval("CabID") %>'></asp:Label>
                                    </EditItemTemplate>--%>
                                    <ItemTemplate>
                                        <asp:Label ID="lblVehicleNo" runat="server" Text='<%# Eval("CabID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="10%" HeaderStyle-Wrap="false" 
                                    HeaderText="Cab Type">
                                    <%--<EditItemTemplate>
                                        <asp:DropDownList ID="ddlVehicleType" runat="server" 
                                            AppendDataBoundItems="True" Font-Names="verdana" Font-Size="X-Small">
                                        </asp:DropDownList>
                                        <asp:CompareValidator ID="CompareValidator2" runat="server" 
                                            ControlToValidate="ddlVehicleType" Display="Dynamic" 
                                            ErrorMessage="Select Cab Type" Operator="NotEqual" SetFocusOnError="True" 
                                            Text="*" ValidationGroup="edit" ValueToCompare="0"></asp:CompareValidator>
                                    </EditItemTemplate>--%>
                                    <ItemTemplate>
                                        <asp:Label ID="lblVehicleType" runat="server" Text='<%# Eval("vehicle") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="10%" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="10%" HeaderStyle-Wrap="false" 
                                    HeaderText="Registration No.">
                                    <%--<EditItemTemplate>
                                        <asp:TextBox ID="txtVehicleRegNo" runat="server" CssClass="TextBox" 
                                            MaxLength="50" Text='<%# Eval("vehicleRegistrationNo") %>' Width="80px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegExpAlphanum3" runat="server" 
                                            ControlToValidate="txtVehicleRegNo" Display="Dynamic" 
                                            ErrorMessage="Reg. No Should be Alphanumeric." Text="*" 
                                            ValidationExpression="^([\w\-]|\s)*$" ValidationGroup="edit"></asp:RegularExpressionValidator>
                                    </EditItemTemplate>--%>
                                    <ItemTemplate>
                                        <asp:Label ID="lblVehicleRegistrationNo" runat="server" 
                                            Text='<%# Eval("vehicleRegistrationNo") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="10%" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12%" HeaderStyle-Wrap="false" 
                                    HeaderText="Reg. Date">
                                    <%--<EditItemTemplate>
                                        <asp:TextBox ID="txtRegDate" runat="server" CssClass="TextBox" MaxLength="12" 
                                            Text='<%# Eval("registrationDate","{0:d}") %>' Width="60px"></asp:TextBox>
                                        <cc1:CalendarExtender ID="txtRegstrationDate_CalendarExtender" runat="server" 
                                            CssClass="cal_Theme1" Enabled="True" TargetControlID="txtRegDate">
                                        </cc1:CalendarExtender>
                                        <asp:RegularExpressionValidator ID="RegulapresionValdator6" runat="server" 
                                            ControlToValidate="txtRegDate" Display="Dynamic" 
                                            ErrorMessage="Enter Valid Regisration Date" 
                                            ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$" 
                                            ValidationGroup="edit">*</asp:RegularExpressionValidator>
                                    </EditItemTemplate>--%>
                                    <ItemTemplate>
                                        <asp:Label ID="lblRegistrationDate" runat="server" 
                                            Text='<%# Eval("registrationDate","{0:d}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="12%" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Model">
                                    <%--<EditItemTemplate>
                                        <asp:TextBox ID="txtModel" runat="server" CssClass="TextBox" MaxLength="10" 
                                            Text='<%# Eval("Model") %>' Width="80px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator31" runat="server" 
                                            ControlToValidate="txtModel" Display="Dynamic" ErrorMessage="Enter the Model" 
                                            ValidationGroup="edit">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>--%>
                                    <ItemTemplate>
                                        <asp:Label ID="lblModel" runat="server" Text='<%# Eval("Model") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="insurance No.">
                                    <%--<EditItemTemplate>
                                        <asp:TextBox ID="txtInsauranceNo" runat="server" CssClass="TextBox" 
                                            MaxLength="50" Text='<%# Eval("InsauranceNo") %>' Width="80px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3101" runat="server" 
                                            ControlToValidate="txtInsauranceNo" Display="Dynamic" 
                                            ErrorMessage="Enter the insurance Number" ValidationGroup="edit">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>--%>
                                    <ItemTemplate>
                                        <asp:Label ID="lblInsauranceNo" runat="server" 
                                            Text='<%# Eval("InsauranceNo") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="10%" HeaderStyle-Wrap="false" 
                                    HeaderText="Insurance Expiry">
                                    <%--<EditItemTemplate>
                                        <asp:TextBox ID="txtInsuranceDate" runat="server" CssClass="TextBox" 
                                            MaxLength="12" Text='<%# Eval("insauranceexpiry") %>' Width="60px"></asp:TextBox>
                                        <cc1:CalendarExtender ID="txtInsuranceDate_CalendarExtender002" runat="server" 
                                            CssClass="cal_Theme1" Enabled="True" TargetControlID="txtInsuranceDate">
                                        </cc1:CalendarExtender>
                                        <asp:RegularExpressionValidator ID="RegularExpressiondator608" runat="server" 
                                            ControlToValidate="txtInsuranceDate" Display="Dynamic" 
                                            ErrorMessage="Enter Valid Insurance Date" 
                                            ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$" 
                                            ValidationGroup="edit">*</asp:RegularExpressionValidator>
                                    </EditItemTemplate>--%>
                                    <ItemTemplate>
                                        <asp:Label ID="lblInsuranceDate" runat="server" 
                                            Font-Bold='<%# Bolds(DataBinder.Eval(Container.DataItem, "insauranceexpirycolor")) %> ' 
                                            ForeColor='<%# Colors(DataBinder.Eval(Container.DataItem, "insauranceexpirycolor")) %> ' 
                                            Text='<%# Eval("insauranceexpiry") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="10%" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Permit No.">
                                    <%--<EditItemTemplate>
                                        <asp:TextBox ID="txtPermitNo" runat="server" CssClass="TextBox" MaxLength="50" 
                                            Text='<%# Eval("permitno") %>' Width="80px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator31010" runat="server" 
                                            ControlToValidate="txtPermitNo" Display="Dynamic" 
                                            ErrorMessage="Enter the Permit Numer" ValidationGroup="edit">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>--%>
                                    <ItemTemplate>
                                        <asp:Label ID="lblPermitNo" runat="server" Text='<%# Eval("permitno") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="10%" HeaderStyle-Wrap="false" 
                                    HeaderText="Permit Expiry">
                                    <%--<EditItemTemplate>
                                        <asp:TextBox ID="txtPermitDate" runat="server" CssClass="TextBox" 
                                            MaxLength="10" Text='<%# Eval("permitExpiryDate","{0:d}") %>' Width="60px"></asp:TextBox>
                                        <cc1:CalendarExtender ID="txtPermitExpiryDate_CalendarExtender009" 
                                            runat="server" CssClass="cal_Theme1" Enabled="True" 
                                            TargetControlID="txtPermitDate">
                                        </cc1:CalendarExtender>
                                        <asp:RegularExpressionValidator ID="RegularExpresionValdator6009" 
                                            runat="server" ControlToValidate="txtPermitDate" Display="Dynamic" 
                                            ErrorMessage="Enter Valid Permit Date" 
                                            ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$" 
                                            ValidationGroup="edit">*</asp:RegularExpressionValidator>
                                    </EditItemTemplate>--%>
                                    <ItemTemplate>
                                        <asp:Label ID="lblPermitExpiryDate" runat="server" 
                                            Font-Bold='<%# Bolds(DataBinder.Eval(Container.DataItem, "Permitexpirycolor")) %> ' 
                                            ForeColor='<%# Colors(DataBinder.Eval(Container.DataItem, "Permitexpirycolor")) %> ' 
                                            Text='<%# Eval("permitExpiryDate","{0:d}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="10%" Wrap="False" />
                                </asp:TemplateField>
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
                        &nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 99%" align="center">
                        <asp:CustomValidator ID="CustomValidatorCheckBox" runat="server" 
                            Display="Dynamic" 
                            ErrorMessage="Cannot proceed because either you did not choose any Vehicle" 
                            OnServerValidate="CustomValidatorCheckBox_ServerValidate" 
                            ValidationGroup="save">*</asp:CustomValidator>
                        <asp:Button ID="btnSave" runat="server" CssClass="Button" 
                            onclick="btnSave_Click" Text="Save" Width="60px" ValidationGroup="save" />
                        <asp:Button ID="btnCancel" runat="server" CssClass="Button" Text="Cancel" 
                            Width="60px" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 99%">
                    </td>
                </tr>
                <tr>
                    <td style="width: 99%">
                        &nbsp;</td>
                </tr>
            </table>
        </ContentTemplate>
        <%--<Triggers>
            <asp:PostBackTrigger ControlID="lbtnExportExcel" />
        </Triggers>--%>
    </asp:UpdatePanel>
</asp:Content>

