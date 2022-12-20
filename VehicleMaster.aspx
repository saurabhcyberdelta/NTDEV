<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="VehicleMaster.aspx.cs" Inherits="VehicleMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style>
        .redcolor {
            background-color: red;
            border-color: Red;
        }

        .style7 {
            height: 65px;
        }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%" align="center">
                <tr>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="add" />
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="edit" />
                    <td style="width: 99%" align="center">
                        <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="heading" style="width: 99%">
                        <div class="gradient2">
                            <h1>
                                <span></span>Vehicle Master
                            </h1>
                            <h2>Allows to View/Edit and Add New Vehicle.</h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 99%" align="center">
                        <table align="center">
                            <tr>
                                <td align="center" class="style7">
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                                        DisplayAfter="0">
                                        <ProgressTemplate>
                                            <table align="center">
                                                <tr>
                                                    <td align="center" class="style7">
                                                        <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" />
                                                    </td>
                                                    <td class="main_bg">Loading.....Please Wait!!!
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
                                            <table align="center" width="1000px">
                                                <tr>
                                                    <td valign="middle" align="center">
                                                        <table width="50%" class="table">
                                                            <tr>
                                                                <td align="center" class="row1">
                                                                    <b>Facility</b>
                                                                </td>
                                                                <td align="center" class="row1">
                                                                    <b>Vendor</b>
                                                                </td>
                                                                <td align="center" class="row1"></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center">
                                                                    <asp:DropDownList ID="ddlSelectFacility" runat="server" AutoPostBack="True"
                                                                        OnSelectedIndexChanged="ddlSelectFacility_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                </td>


                                                                <td align="center">
                                                                    <asp:DropDownList ID="ddlSelectVendor" runat="server" AutoPostBack="True"
                                                                        OnSelectedIndexChanged="ddlSelectVendor_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td align="center">

                                                                    <asp:RadioButtonList ID="rdbvehicle" runat="server" AutoPostBack="True" RepeatDirection="Horizontal" OnSelectedIndexChanged="rdbvehicle_SelectedIndexChanged"
                                                                        >
                                                                        <asp:ListItem Selected="True" Value="0">Detailed</asp:ListItem>
                                                                        <asp:ListItem Value="1">Summary</asp:ListItem>
                                                                       
                                                                    </asp:RadioButtonList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <br />
                                                        <br />
                                                        <br />
                                                        <table width="100%" style="position: static">
                                                            <tr>

                                                                <td align="right">
                                                                    <asp:LinkButton ID="lbtnExportExcel" runat="server"
                                                                        OnClick="lbtnExportExcel_Click">Export To Excel</asp:LinkButton>
                                                                </td>

                                                            </tr>
                                                        </table>



                                                        <table border="1" bordercolor="black">
                                                            <tr>
                                                                <td bgcolor="red">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                                <td>Expired</td>
                                                                <td bgcolor="green">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                                <td>5 Days Left</td>
                                                                <td bgcolor="SteelBlue">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                                <td>7 Days Left</td>
                                                            </tr>
                                                        </table>
                                                        <br />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <asp:GridView ID="GVVehicleMaster" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                            DataKeyNames="Id" OnPageIndexChanging="GVVehicleMaster_PageIndexChanging" OnRowCancelingEdit="GVVehicleMaster_RowCancelingEdit"
                                                            OnRowDeleting="GVVehicleMaster_RowDeleting" OnRowEditing="GVVehicleMaster_RowEditing"
                                                            OnRowUpdating="GVVehicleMaster_RowUpdating" PageSize="20" CssClass="GridView"
                                                            BorderWidth="0" ShowFooter="True" Width="1200px">
                                                            <RowStyle CssClass="RowStyle" />
                                                            <FooterStyle CssClass="FooterStyle" />
                                                            <PagerStyle CssClass="PagerStyle" />
                                                            <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                            <HeaderStyle BackColor="#004f75" ForeColor="White" Font-Bold="true" />
                                                            <EditRowStyle BackColor="#999999" />
                                                            <AlternatingRowStyle CssClass="AltRowStyle" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="CabID">
                                                                    <EditItemTemplate>
                                                                        <asp:Label ID="lblVehicleNoEdit" runat="server" Text='<%# Eval("CabID") %>'></asp:Label>

                                                                    </EditItemTemplate>

                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblVehicleNo" runat="server" Text='<%# Eval("CabID") %>'></asp:Label>
                                                                    </ItemTemplate>

                                                                </asp:TemplateField>
                                                                <asp:BoundField HeaderText="Attrited" DataField="Attrited" />
                                                                <asp:TemplateField HeaderText="Cab Type" HeaderStyle-Wrap="false" HeaderStyle-Width="10%">
                                                                    <EditItemTemplate>
                                                                        <asp:DropDownList ID="ddlVehicleType" runat="server" AppendDataBoundItems="True"
                                                                            Font-Names="verdana" Font-Size="X-Small">
                                                                        </asp:DropDownList>
                                                                        <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="Select Cab Type"
                                                                            ControlToValidate="ddlVehicleType" Display="Dynamic" SetFocusOnError="True" Text="*"
                                                                            ValueToCompare="0" Operator="NotEqual" ValidationGroup="edit"></asp:CompareValidator>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblVehicleType" runat="server" Text='<%# Eval("vehicle") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>


                                                                <asp:TemplateField HeaderText="Registration No." HeaderStyle-Wrap="false" HeaderStyle-Width="10%">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtVehicleRegNo" runat="server" Text='<%# Eval("vehicleRegistrationNo") %>'
                                                                            Width="80px" MaxLength="50" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RegularExpressionValidator ID="RegExpAlphanum3" runat="server" ControlToValidate="txtVehicleRegNo"
                                                                            Display="Dynamic" ErrorMessage="Reg. No Should be Alphanumeric." Text="*"
                                                                            ValidationExpression="^([\w\-]|\s)*$" ValidationGroup="edit"></asp:RegularExpressionValidator>
                                                                    </EditItemTemplate>

                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblVehicleRegistrationNo" runat="server" Text='<%# Eval("vehicleRegistrationNo") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>


                                                                <asp:TemplateField HeaderText="Reg. Date" HeaderStyle-Wrap="false" HeaderStyle-Width="12%">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtRegDate" runat="server" Text='<%# Eval("registrationDate","{0:d}") %>'
                                                                            Width="60px" MaxLength="12" CssClass="TextBox"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtRegstrationDate_CalendarExtender" runat="server" Enabled="True"
                                                                            TargetControlID="txtRegDate" CssClass="cal_Theme1">
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RegularExpressionValidator ID="RegulapresionValdator6" runat="server" ControlToValidate="txtRegDate"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid Regisration Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="edit">*</asp:RegularExpressionValidator>
                                                                    </EditItemTemplate>

                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRegistrationDate" runat="server" Text='<%# Eval("registrationDate","{0:d}") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Model">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtModel" runat="server" Text='<%# Eval("Model") %>' Width="80px"
                                                                            MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator31" runat="server"
                                                                            ErrorMessage="Enter the Model" Display="Dynamic" ValidationGroup="edit" ControlToValidate="txtModel">*</asp:RequiredFieldValidator>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblModel" runat="server" Text='<%# Eval("Model") %>'></asp:Label>
                                                                    </ItemTemplate>

                                                                </asp:TemplateField>


                                                                <asp:TemplateField HeaderText="FC Valid Date" HeaderStyle-Wrap="false" HeaderStyle-Width="10%">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtfcValidDate" runat="server" Text='<%# Eval("FCValidDate","{0:d}") %>'
                                                                            Width="60px" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtRegstrationDate_CalendarExtender0123" runat="server" Enabled="True"
                                                                            TargetControlID="txtfcValidDate" CssClass="cal_Theme1">
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RegularExpressionValidator ID="RegulapresionValdator601" runat="server" ControlToValidate="txtfcValidDate"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid FC Valid Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="edit">*</asp:RegularExpressionValidator>
                                                                    </EditItemTemplate>
                                                                    <ItemStyle />
                                                                    <ItemTemplate>

                                                                        <asp:Label ID="lblfcValidDate" runat="server" Font-Bold='<%# Bolds(DataBinder.Eval(Container.DataItem, "fcValidDaateColor")) %> ' ForeColor='<%# Colors(DataBinder.Eval(Container.DataItem, "fcValidDaateColor")) %> ' Text='<%# Eval("FCValidDate","{0:d}") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="insurance No.">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtInsauranceNo" runat="server" Text='<%# Eval("InsauranceNo") %>' Width="80px"
                                                                            MaxLength="50" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3101" runat="server"
                                                                            ErrorMessage="Enter the insurance Number" Display="Dynamic" ValidationGroup="edit" ControlToValidate="txtInsauranceNo">*</asp:RequiredFieldValidator>
                                                                    </EditItemTemplate>

                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblInsauranceNo" runat="server" Text='<%# Eval("InsauranceNo") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="insurance Co.">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtInsauranceCo" runat="server" Text='<%# Eval("insauranceCompany") %>' Width="80px"
                                                                            MaxLength="50" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3102" runat="server"
                                                                            ErrorMessage="Enter the insurance Number" Display="Dynamic" ValidationGroup="edit" ControlToValidate="txtInsauranceCo">*</asp:RequiredFieldValidator>
                                                                    </EditItemTemplate>

                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblInsauranceCo" runat="server" Text='<%# Eval("insauranceCompany") %>'></asp:Label>
                                                                    </ItemTemplate>

                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Insurance Expiry" HeaderStyle-Wrap="false" HeaderStyle-Width="10%">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtInsuranceDate" runat="server" Text='<%# Eval("insauranceexpiry") %>'
                                                                            Width="60px" MaxLength="12" CssClass="TextBox"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtInsuranceDate_CalendarExtender002" runat="server" Enabled="True"
                                                                            TargetControlID="txtInsuranceDate" CssClass="cal_Theme1">
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RegularExpressionValidator ID="RegularExpressiondator608" runat="server" ControlToValidate="txtInsuranceDate"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid Insurance Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="edit">*</asp:RegularExpressionValidator>
                                                                    </EditItemTemplate>

                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblInsuranceDate" runat="server" Text='<%# Eval("insauranceexpiry") %>' Font-Bold='<%# Bolds(DataBinder.Eval(Container.DataItem, "insauranceexpirycolor")) %> ' ForeColor='<%# Colors(DataBinder.Eval(Container.DataItem, "insauranceexpirycolor")) %> '></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Permit No.">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtPermitNo" runat="server" Text='<%# Eval("permitno") %>' Width="80px"
                                                                            MaxLength="50" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator31010" runat="server"
                                                                            ErrorMessage="Enter the Permit Numer" Display="Dynamic" ValidationGroup="edit" ControlToValidate="txtPermitNo">*</asp:RequiredFieldValidator>
                                                                    </EditItemTemplate>

                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblPermitNo" runat="server" Text='<%# Eval("permitno") %>'></asp:Label>
                                                                    </ItemTemplate>

                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Permit Expiry" HeaderStyle-Wrap="false" HeaderStyle-Width="10%">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtPermitDate" runat="server" Text='<%# Eval("permitExpiryDate","{0:d}") %>'
                                                                            Width="60px" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtPermitExpiryDate_CalendarExtender009" runat="server" Enabled="True"
                                                                            TargetControlID="txtPermitDate" CssClass="cal_Theme1">
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RegularExpressionValidator ID="RegularExpresionValdator6009" runat="server" ControlToValidate="txtPermitDate"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid Permit Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="edit">*</asp:RegularExpressionValidator>
                                                                    </EditItemTemplate>

                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblPermitExpiryDate" runat="server" Font-Bold='<%# Bolds(DataBinder.Eval(Container.DataItem, "Permitexpirycolor")) %> ' ForeColor='<%# Colors(DataBinder.Eval(Container.DataItem, "Permitexpirycolor")) %> ' Text='<%# Eval("permitExpiryDate","{0:d}") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Tax Validity" HeaderStyle-Wrap="false" HeaderStyle-Width="10%">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtTaxValidity" runat="server" Text='<%# Eval("taxExpiryDate","{0:d}") %>'
                                                                            Width="60px" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtFitnessDate_CalendarExtender" runat="server" Enabled="True"
                                                                            TargetControlID="txtTaxValidity" CssClass="cal_Theme1">
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RegularExpressionValidator ID="RegularonValidator6" runat="server" ControlToValidate="txtTaxValidity"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid Tax Validity" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="edit">*</asp:RegularExpressionValidator>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTaxValidity" runat="server" Text='<%# Eval("taxExpiryDate","{0:d}") %>' Font-Bold='<%# Bolds(DataBinder.Eval(Container.DataItem, "taxexpirycolor")) %> ' ForeColor='<%# Colors(DataBinder.Eval(Container.DataItem, "taxexpirycolor")) %> '></asp:Label>
                                                                    </ItemTemplate>

                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Emission Expiry" HeaderStyle-Wrap="false" HeaderStyle-Width="10%">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtEmissionDate" runat="server" Text='<%# Eval("emissionexpiry","{0:d}") %>'
                                                                            Width="60px" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtPUCExpiryDate_CalendarExtender" runat="server" Enabled="True"
                                                                            TargetControlID="txtEmissionDate" CssClass="cal_Theme1">
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RegularExpressionValidator ID="RegularEessionValidator6" runat="server" ControlToValidate="txtEmissionDate"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid Emision Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="edit">*</asp:RegularExpressionValidator>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblEmissionExpiry" runat="server" Text='<%# Eval("emissionexpiry","{0:d}") %>' Font-Bold='<%# Bolds(DataBinder.Eval(Container.DataItem, "emissionexpirycolor")) %> ' ForeColor='<%# Colors(DataBinder.Eval(Container.DataItem, "emissionexpirycolor")) %> '></asp:Label>
                                                                    </ItemTemplate>

                                                                </asp:TemplateField>



                                                                <asp:CommandField HeaderText="Actions" ShowEditButton="True"
                                                                    ValidationGroup="edit" />
                                                            </Columns>

                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr><td  align="center"> <asp:GridView ID="gvsummary" EmptyDataText="No Record Found" runat="server" AutoGenerateColumns="false"
                                                            
                                                            BorderWidth="0px" ShowFooter="True" Width="100%" EnableModelValidation="True" >
                                                       <RowStyle CssClass="RowStyle" />
                                                            <FooterStyle CssClass="FooterStyle" />
                                                            <PagerStyle CssClass="PagerStyle" />
                                                           
                                                            <HeaderStyle BackColor="#004f75" ForeColor="White" Font-Bold="true" />
                                                            <Columns>
                                                                <asp:BoundField DataField="VendorName" HeaderText="Vendor Name" />
                                                                 <asp:BoundField HeaderText="Total Active Vehicles" DataField="Total_Active_Vehicles" />
                                                                 <asp:BoundField HeaderText="Total Attrited Vehicles" DataField="Total_Attrited_Vehicles" />
                                                                 <asp:BoundField HeaderText="Total Small Seater" DataField="Total_Small_Seater" />
                                                                 <asp:BoundField HeaderText="Total Medium Seater" DataField="Total_Medium_Seater" />
                                                                 <asp:BoundField HeaderText="Permit Expired" DataField="Permit_Expired" />
                                                                 <asp:BoundField HeaderText="Permit Expiring in 7 Days" DataField="Permit_Expiring_in_7_Days" />
                                                                 <asp:BoundField HeaderText="Insurance Expired" DataField="Insurance_Expired" />
                                                                 <asp:BoundField HeaderText="Insurance Expiring in 7 Days" DataField="Insurance_Expiring_in_7_Days" />
                                                                 <asp:BoundField HeaderText="Tax Expired" DataField="Tax_Expired" />
                                                                 <asp:BoundField HeaderText="Tax Expiring in 7 Days" DataField="Tax_Expiring_in_7_Days" />
                                                                <asp:BoundField HeaderText="FC Expired" DataField="FC_Expired" />
                                                                <asp:BoundField HeaderText="FC Expiring in 7 Days" DataField="FC_Expiring_in_7_Days" />
                                                                <asp:BoundField HeaderText="Emision Expired" DataField="Emision_Expired" />
                                                                <asp:BoundField HeaderText="Emission Expiring in 7 Days" DataField="Emission_Expiring_in_7_Days" />
                                                       </Columns>
                                                            <EditRowStyle BackColor="#999999" />
                                                            <AlternatingRowStyle CssClass="AltRowStyle" />
                                                    </asp:GridView>


                                                    </td></tr>
                                                <tr>
                                                    <td align="center">
                                                        <asp:LinkButton ID="lbtnAddNew" runat="server" OnClick="lbtnAddNew_Click">Add New</asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                        <asp:View ID="View2" runat="server">
                                            <table align="center">
                                                <tr>
                                                    <td align="center">
                                                        <asp:DetailsView ID="DvVehicle" runat="server" AutoGenerateRows="False" DefaultMode="Insert"
                                                            HeaderText="Add New Vehicle" Height="50px" OnItemInserting="DvVehicle_ItemInserting"
                                                            OnModeChanging="DvVehicle_ModeChanging">
                                                            <Fields>
                                                                <asp:TemplateField HeaderText="Facility">
                                                                    <InsertItemTemplate>
                                                                        <asp:DropDownList ID="ddldvFacility" runat="server" AppendDataBoundItems="True"
                                                                            CssClass="DropDownListBox3" AutoPostBack="True"
                                                                            OnSelectedIndexChanged="ddldvFacility_SelectedIndexChanged">
                                                                        </asp:DropDownList>
                                                                        <asp:CompareValidator ID="CompareVa" runat="server" ControlToValidate="ddldvFacility"
                                                                            Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="add"
                                                                            ValueToCompare="0">*</asp:CompareValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Vendor Name">
                                                                    <InsertItemTemplate>
                                                                        <asp:DropDownList ID="ddldvVendor" runat="server" AppendDataBoundItems="True"
                                                                            AutoPostBack="false" CssClass="DropDownListBox3">
                                                                        </asp:DropDownList>
                                                                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddldvVendor"
                                                                            Display="Dynamic" ErrorMessage="Select Vendor" Operator="NotEqual" ValidationGroup="add"
                                                                            ValueToCompare="0">*</asp:CompareValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Vehicle Type">
                                                                    <InsertItemTemplate>
                                                                        <asp:DropDownList ID="ddldvVehicleType" runat="server" AppendDataBoundItems="True"
                                                                            CssClass="DropDownListBox3">
                                                                        </asp:DropDownList>
                                                                        <asp:CompareValidator ID="CompareValidat" runat="server" ControlToValidate="ddldvVehicleType"
                                                                            Display="Dynamic" ErrorMessage="Select Vehicle" Operator="NotEqual" ValidationGroup="add"
                                                                            ValueToCompare="0">*</asp:CompareValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="CabID">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvVehicleNo" runat="server" MaxLength="20" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtdvVehicleNo"
                                                                            Display="Dynamic" ErrorMessage="Enter Vehicle No" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegExpAlphanum0" runat="server" ControlToValidate="txtdvVehicleNo"
                                                                            Display="Dynamic" ErrorMessage="Vehicle Number Should be Alphanumeric." Text="*"
                                                                            ValidationExpression="^([\w\-]|\s)*$" ValidationGroup="add"></asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Vehicle Reg. No">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvVehicleRegNo" runat="server" MaxLength="50" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtdvVehicleRegNo"
                                                                            Display="Dynamic" ErrorMessage="Enter Vehicle Reg No" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegExpAlphanum1" runat="server" ControlToValidate="txtdvVehicleRegNo"
                                                                            Display="Dynamic" ErrorMessage="Vehicle Reg No Should be Alphanumeric." Text="*"
                                                                            ValidationExpression="^([\w\-]|\s)*$" ValidationGroup="add"></asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Registration Date">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvRegDate" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtdvRegDate_CalendarExtender" runat="server" Enabled="True"
                                                                            TargetControlID="txtdvRegDate" CssClass="cal_Theme1">
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RegularExpressionValidator ID="RegularExpressionVidator6" runat="server" ControlToValidate="txtdvRegDate"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid Registration Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Permit Expiry Date">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvPermitDate" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtPermitDate_CalendarExtender" runat="server" Enabled="True"
                                                                            TargetControlID="txtdvPermitDate" CssClass="cal_Theme1">
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RegularExpressionValidator ID="RegularExpresionValdator6" runat="server" ControlToValidate="txtdvPermitDate"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid Permit Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Insurance Date">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvInsuranceDate" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtdvInsuranceDate_CalendarExtender" runat="server" Enabled="True"
                                                                            TargetControlID="txtdvInsuranceDate" CssClass="cal_Theme1">
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RegularExpressionValidator ID="RegularExpressiondator6" runat="server" ControlToValidate="txtdvInsuranceDate"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid Insurance Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="FC Valid Date">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvFcValidDate" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtFitnessDate_CalendarExtender0" runat="server" Enabled="True"
                                                                            TargetControlID="txtdvFcValidDate" CssClass="cal_Theme1">
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RegularExpressionValidator ID="RegularonValidator6" runat="server" ControlToValidate="txtdvFcValidDate"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid FV Valid Date  Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Tax Expiry Date">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvTaxDate" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtTaxDate_CalendarExtender" runat="server" Enabled="True"
                                                                            TargetControlID="txtdvTaxDate" CssClass="cal_Theme1">
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RegularExpressionValidator ID="RegularsionValidator6" runat="server" ControlToValidate="txtdvTaxDate"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid Tax Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Emmision Expiry Date">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvEmission" runat="server" MaxLength="10" CssClass="TextBox"></asp:TextBox>
                                                                        <cc1:CalendarExtender ID="txtPUCDate_CalendarExtender" runat="server" Enabled="True"
                                                                            TargetControlID="txtdvEmission" CssClass="cal_Theme1">
                                                                        </cc1:CalendarExtender>
                                                                        <asp:RegularExpressionValidator ID="RegularEessionValidator6" runat="server" ControlToValidate="txtdvEmission"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid Emmision Expiry Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                            ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Chasis No.">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvChasis" runat="server" MaxLength="50" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator_txtdvChasis" runat="server"
                                                                            ErrorMessage="Enter the Chasis No." Display="Dynamic" ValidationGroup="add" ControlToValidate="txtdvChasis">*</asp:RequiredFieldValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Model">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvModel" runat="server" MaxLength="30" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator_txtdvModel" runat="server"
                                                                            ErrorMessage="Enter the Model" Display="Dynamic" ValidationGroup="add" ControlToValidate="txtdvModel">*</asp:RequiredFieldValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="insurance Number">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvInsauranceNo" runat="server" MaxLength="30" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator_txtdvInsauranceNo" runat="server"
                                                                            ErrorMessage="Enter the insurance Number" Display="Dynamic" ValidationGroup="add" ControlToValidate="txtdvInsauranceNo">*</asp:RequiredFieldValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="insurance Company">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvInsauranceCo" runat="server" MaxLength="30" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtdvInsauranceCo" runat="server"
                                                                            ErrorMessage="Enter the insurance Company" Display="Dynamic" ValidationGroup="add" ControlToValidate="txtdvInsauranceCo">*</asp:RequiredFieldValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Permit Number">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtdvPermitNo" runat="server" MaxLength="30" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator_txtdvPermitNo" runat="server"
                                                                            ErrorMessage="Enter the Permit Number" Display="Dynamic" ValidationGroup="add" ControlToValidate="txtdvPermitNo">*</asp:RequiredFieldValidator>
                                                                    </InsertItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:CommandField ShowInsertButton="True" InsertText="Save" ValidationGroup="add"
                                                                    CancelText="Close" />
                                                            </Fields>
                                                            <RowStyle CssClass="DetailsViewRowStyle" />
                                                            <FooterStyle CssClass="DetailsViewFooterStyle" />
                                                            <PagerStyle CssClass="DetailsViewPagerStyle" />
                                                            <HeaderStyle CssClass="DetailsViewHeaderStyle" />
                                                            <AlternatingRowStyle CssClass="DetailsViewAltRowStyle" />
                                                        </asp:DetailsView>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                         
                                    </asp:MultiView>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="width: 99%">&nbsp;
                    </td>
                </tr>
                <tr>
                    <td style="width: 99%; height: 13px;" align="center"></td>
                </tr>
                <tr>
                    <td style="width: 99%"></td>
                </tr>
                <tr>
                    <td style="width: 99%"></td>
                </tr>
            </table>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="lbtnExportExcel" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
