<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="vehicleTypeMaster.aspx.cs" Inherits="vehicleTypeMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%">
        <tr>
            <td>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="add" />
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="edit" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="heading">
                <div class="gradient2">
                    <h1>
                        <span></span>Manage Vehicle Type
                    </h1>
                    <h2>
                        Allows to View/Edit and Add New Vehicle Type.
                    </h2>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <table align="center" width="100%">
                            <tr>
                                <td align="center">
                                    <asp:DropDownList ID="ddlVendor" runat="server" OnSelectedIndexChanged="ddlVendor_SelectedIndexChanged"
                                        AppendDataBoundItems="True" AutoPostBack="True" CssClass="DropDownListBox3" Visible="false">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Label ID="lblMsg" runat="server" CssClass="error"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:MultiView ID="MultiView1" runat="server">
                                        <asp:View ID="View1" runat="server">
                                            <table width="100%">
                                                <tr>
                                                    <td width="100%">
                                                        <asp:GridView ID="GVVehicleType" runat="server" AutoGenerateColumns="False" CssClass="GridView"
                                                            OnRowCancelingEdit="GVVehicleType_RowCancelingEdit" OnRowDeleting="GVVehicleType_RowDeleting"
                                                            OnRowEditing="GVVehicleType_RowEditing" OnRowUpdating="GVVehicleType_RowUpdating"
                                                            DataKeyNames="Id" BorderWidth="0" ShowFooter="True" Width="80%">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Vehicle">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtVehicle" runat="server" Text='<%# Eval("vehicle") %>' MaxLength="30"
                                                                            CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldVali" runat="server" ControlToValidate="txtVehicle"
                                                                            Display="Dynamic" ErrorMessage="Enter Vehicle Type" ValidationGroup="edit">*</asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegExpAlphanum1" runat="server" ControlToValidate="txtVehicle"
                                                                            Display="Dynamic" ErrorMessage="Vehicle Type Should be Alphanumeric." Text="*"
                                                                            ValidationExpression="^([\w\-_]|\s)*$" ValidationGroup="edit"></asp:RegularExpressionValidator>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblVehicle" runat="server" Text='<%# Eval("vehicle") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Mileage">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtMileage" runat="server" Text='<%# Eval("mileage") %>' Width="80px"
                                                                            MaxLength="5" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RangeValidator ID="RangeValiCostAc" runat="server" ControlToValidate="txtMileage"
                                                                            ErrorMessage="Please Enter the Numeric Value" MaximumValue="100000" MinimumValue="0"
                                                                            SetFocusOnError="true" Type="Integer" ValidationGroup="edit">*</asp:RangeValidator>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblMileage" runat="server" Text='<%# Eval("mileage") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                               
                                                                <asp:TemplateField HeaderText="Occupancy">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtOccupancy" runat="server" Text='<%# Eval("occupancy") %>' Width="80px"
                                                                            MaxLength="3" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RangeValidator ID="RangeValiOcc" runat="server" ControlToValidate="txtOccupancy"
                                                                            ErrorMessage="Please Enter the Numeric Value" MaximumValue="40" MinimumValue="0"
                                                                            SetFocusOnError="true" Type="Integer" ValidationGroup="edit">*</asp:RangeValidator>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblOccupancy" runat="server" Text='<%# Eval("occupancy") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                               
                                                               
                                                                <asp:TemplateField HeaderText="Actions" ShowHeader="False">
                                                                    <EditItemTemplate>
                                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                                                                            Text="Update" ValidationGroup="edit"></asp:LinkButton>
                                                                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                            Text="Cancel"></asp:LinkButton>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                                                                            Text="Edit"></asp:LinkButton>
                                                                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete"
                                                                            Text="Delete"></asp:LinkButton>
                                                                        <cc1:ConfirmButtonExtender ID="ConfirmButton_LinkButton2" TargetControlID="LinkButton2"
                                                                            runat="server" ConfirmOnFormSubmit="False" ConfirmText="Are you sure you want to delete this vehicle type?">
                                                                        </cc1:ConfirmButtonExtender>
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
                                                <tr>
                                                    <td align="center">
                                                        <asp:LinkButton ID="lbtnAddNew" runat="server" OnClick="lbtnAddNew_Click">Add New</asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                        <asp:View ID="View2" runat="server">
                                            <asp:DetailsView ID="DVVehicle" runat="server" AutoGenerateRows="False" DefaultMode="Insert"
                                                HeaderText="Add New Vehicle Type" OnItemInserting="DVVehicle_ItemInserting" OnModeChanging="DVVehicle_ModeChanging"
                                                Width="245px">
                                                <Fields>
                                                    <asp:TemplateField HeaderText="Vehicle:">
                                                        <InsertItemTemplate>
                                                            <asp:TextBox ID="txtdvVehicle" runat="server" MaxLength="30" CssClass="TextBox"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtdvVehicle"
                                                                Display="Dynamic" ErrorMessage="Enter Vehicle Type" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegExpAlphanum0" runat="server" ControlToValidate="txtdvVehicle"
                                                                Display="Dynamic" ErrorMessage="Vehicle Type Should be Alphanumeric." Text="*"
                                                                ValidationExpression="^([\w\-_]|\s)*$" ValidationGroup="add"></asp:RegularExpressionValidator>
                                                        </InsertItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Mileage:">
                                                        <InsertItemTemplate>
                                                            <asp:TextBox ID="txtdvCostAC" runat="server" MaxLength="5" CssClass="TextBox"></asp:TextBox>
                                                            <asp:RangeValidator ID="RangeValiCostAc" runat="server" ControlToValidate="txtdvCostAC"
                                                                ErrorMessage="Please Enter the Numeric Value" MaximumValue="100000" MinimumValue="0"
                                                                SetFocusOnError="true" Type="Integer" ValidationGroup="add">*</asp:RangeValidator>
                                                        </InsertItemTemplate>
                                                    </asp:TemplateField>
                                                    
                                                    <asp:TemplateField HeaderText="Occupancy:">
                                                        <InsertItemTemplate>
                                                            <asp:TextBox ID="txtdvOccupancy" runat="server" MaxLength="3" CssClass="TextBox"></asp:TextBox>
                                                            <asp:RangeValidator ID="RangeValiOcc" runat="server" ControlToValidate="txtdvOccupancy"
                                                                ErrorMessage="Please Enter the Numeric Value in Occupancy" MaximumValue="40"
                                                                MinimumValue="0" SetFocusOnError="true" Type="Integer" ValidationGroup="add">*</asp:RangeValidator>
                                                        </InsertItemTemplate>
                                                    </asp:TemplateField>
                                                    
                                                    <asp:CommandField ShowInsertButton="True" InsertText="Save" CancelText="Close" ValidationGroup="add" />
                                                </Fields>
                                                <RowStyle CssClass="DetailsViewRowStyle" />
                                                <FooterStyle CssClass="DetailsViewFooterStyle" />
                                                <PagerStyle CssClass="DetailsViewPagerStyle" />
                                                <HeaderStyle CssClass="DetailsViewHeaderStyle" />
                                                <AlternatingRowStyle CssClass="DetailsViewAltRowStyle" />
                                            </asp:DetailsView>
                                        </asp:View>
                                    </asp:MultiView>
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
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
