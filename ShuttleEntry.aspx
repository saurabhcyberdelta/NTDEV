<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="ShuttleEntry.aspx.cs" Inherits="ShuttleEntry" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="Submit" />
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="save" />
                         <asp:ValidationSummary ID="ValidationSummary3" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="EditFCS" />
                           <asp:ValidationSummary ID="ValidationSummary4" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="EditIOS" />
                    <td>
                        <table width="50%">
                            <tr>
                                <td class="heading">
                                    <div class="gradient2">
                                        <h1>
                                            <span></span>Shuttle Entry
                                        </h1>
                                        <h2>
                                            Allows User to Enter Shuttle Details.
                                        </h2>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table border="0" cellpadding="4" cellspacing="0" align="left" width="71%" class="tableBorber">
                            <tr>
                                <td align="center" class="TDbg" colspan="4">
                                    Fill The Selection Criteria
                                </td>
                            </tr>
                            <tr>
                                <td align="left" valign="middle">
                                    <b>Choose Shuttle Type</b>
                                </td>
                                <td valign="middle">
                                    <b>ShiftDate</b>
                                </td>
                                <td valign="middle">
                                    <b>Facility</b>
                                </td>
                                <td rowspan="2">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" ValidationGroup="Submit"
                                        OnClick="btnSubmit_Click" CssClass="Button" />
                                </td>
                            </tr>
                            <tr>
                                <td valign="middle">
                                    <asp:RadioButtonList ID="rbShuttleType" runat="server" OnSelectedIndexChanged="rbShuttleType_SelectedIndexChanged"
                                        AutoPostBack="True" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="IOS" Selected="True">Inter-Office Shuttle</asp:ListItem>
                                        <asp:ListItem Value="FCS">Food Court Shuttle</asp:ListItem>
                                        <asp:ListItem Value="BFC">Buffer Cabs</asp:ListItem>
                                         <asp:ListItem Value="Toll">Toll Entry</asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rbShuttleType"
                                        ErrorMessage="You must choose an option" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                                </td>
                                <td valign="middle">
                                    <asp:TextBox ID="txtShiftDate" runat="server" CssClass="TextBox"></asp:TextBox>
                                    <cc1:CalendarExtender ID="txtShiftDate_CalendarExtender" runat="server" Enabled="true"
                                        PopupButtonID="ibcal1" TargetControlID="txtShiftDate">
                                    </cc1:CalendarExtender>
                                    &nbsp;<asp:ImageButton ID="ibcal1" runat="server" Height="17px" ImageUrl="~/images/calendar_icon.gif" />
                                    <br />
                                    <i>(mm/dd/yyyy)</i>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtShiftDate"
                                        Display="Dynamic" ErrorMessage="Enter Valid Start Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                        ValidationGroup="Submit">*</asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtShiftDate"
                                        ErrorMessage="Enter Start Date" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                                </td>
                                <td valign="middle">
                                    <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                                        Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                                        ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                            DisplayAfter="0" DynamicLayout="false">
                            <ProgressTemplate>
                                <table align="center">
                                    <tr>
                                        <td>
                                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loading" />
                                        </td>
                                        <td class="main_bg" align="left">
                                            Loading.....Please Wait!!!&nbsp;&nbsp;&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="View1" runat="server">
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            
                                            <asp:GridView ID="gvFCS" runat="server" AllowPaging="True" AllowSorting="True" 
                                                AutoGenerateColumns="False" BorderWidth="0px" CellPadding="0" DataKeyNames="ID" 
                                                EmptyDataText="No Record Found!" onrowcancelingedit="gvFCS_RowCancelingEdit" 
                                                onrowdeleting="gvFCS_RowDeleting" onrowediting="gvFCS_RowEditing" 
                                                onrowupdating="gvFCS_RowUpdating" ShowFooter="True" Width="100%">
                                                <EmptyDataTemplate>
                                                    <asp:Label ID="lblEmptySearch" runat="server">No Results Found</asp:Label>
                                                </EmptyDataTemplate>
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Date">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtShiftdateedit" runat="server" 
                                                                Text='<%# Bind("ShiftDateedit") %>'></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidatorEditFCS" 
                                                                runat="server" ControlToValidate="txtShiftdateedit" Display="Dynamic" 
                                                                ErrorMessage="Enter Valid Shift Date" 
                                                                ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$" 
                                                                ValidationGroup="EditFCS">*</asp:RegularExpressionValidator>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("ShiftDate") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="CAB ID">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtCabidFCS" runat="server" MaxLength="20" 
                                                                Text='<%# Bind("CabID") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1234" runat="server" 
                                                                ControlToValidate="txtCabidFCS" ErrorMessage="Enter CabID" 
                                                                ValidationGroup="EditFCS">*</asp:RequiredFieldValidator>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtCabID" runat="server" AutoPostBack="True" 
                                                                CssClass="TextBox" MaxLength="20" OnTextChanged="txtCabID_TextChanged"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                                                ControlToValidate="txtCabID" Display="Dynamic" ErrorMessage="Enter CAB ID" 
                                                                SetFocusOnError="True" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("CabID") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="CAB NUMERIC">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtVehicleNoFCS" runat="server" MaxLength="20" 
                                                                Text='<%# Bind("CabRegNo") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorEditFCS" runat="server" 
                                                                ControlToValidate="txtVehicleNoFCS" ErrorMessage="Enter Vehcile Number" 
                                                                ValidationGroup="EditFCS">*</asp:RequiredFieldValidator>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtCABNUMERIC" runat="server" CssClass="TextBox" 
                                                                MaxLength="20"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                                                ControlToValidate="txtCABNUMERIC" Display="Dynamic" 
                                                                ErrorMessage="Enter CAB NUMERIC" SetFocusOnError="True" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("CabRegNo") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="TIME IN">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtTimeinEdit" runat="server" MaxLength="5" 
                                                                Text='<%# Bind("TimeIN") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorTimeinEditFCS" 
                                                                runat="server" ControlToValidate="txtTimeinEdit" ErrorMessage="Enter Time IN" 
                                                                ValidationGroup="EditFCS">*</asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidatorTimein" 
                                                                runat="server" ControlToValidate="txtTimeinEdit" 
                                                                ErrorMessage="Enter valid TIME IN - 00:00" SetFocusOnError="True" 
                                                                ValidationExpression="^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))$|^([01]\d|2[0-3])(:[0-5]\d){0,2}$" 
                                                                ValidationGroup="EditFCS">*</asp:RegularExpressionValidator>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtTIMEIN" runat="server" CssClass="TextBox" MaxLength="5"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                                                ControlToValidate="txtTIMEIN" Display="Dynamic" ErrorMessage="Enter TIME IN" 
                                                                SetFocusOnError="True" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                                                                ControlToValidate="txtTIMEIN" ErrorMessage="Enter valid TIME IN - 00:00" 
                                                                SetFocusOnError="True" 
                                                                ValidationExpression="^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))$|^([01]\d|2[0-3])(:[0-5]\d){0,2}$" 
                                                                ValidationGroup="save">*</asp:RegularExpressionValidator>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("TimeIN") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="TIME OUT">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtTIMEOUTFCS" runat="server" MaxLength="5" 
                                                                Text='<%# Bind("TimeOut") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorTimeoutEditFCS" 
                                                                runat="server" ControlToValidate="txtTIMEOUTFCS" ErrorMessage="Enter Time Out" 
                                                                ValidationGroup="EditFCS">*</asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidatorTimeout" 
                                                                runat="server" ControlToValidate="txtTIMEOUTFCS" 
                                                                ErrorMessage="Enter valid TIME Out - 00:00" SetFocusOnError="True" 
                                                                ValidationExpression="^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))$|^([01]\d|2[0-3])(:[0-5]\d){0,2}$" 
                                                                ValidationGroup="EditFCS">*</asp:RegularExpressionValidator>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtTIMEOUT" runat="server" CssClass="TextBox" MaxLength="5"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                                                                ControlToValidate="txtTIMEOUT" Display="Dynamic" ErrorMessage="Enter TIME OUT" 
                                                                SetFocusOnError="True" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                                                                ControlToValidate="txtTIMEOUT" ErrorMessage="Enter valid TIME Out - 00:00" 
                                                                SetFocusOnError="True" 
                                                                ValidationExpression="^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))$|^([01]\d|2[0-3])(:[0-5]\d){0,2}$" 
                                                                ValidationGroup="save">*</asp:RegularExpressionValidator>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("TimeOut") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="DRIVER NAME">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtDriverFCS" runat="server" MaxLength="20" 
                                                                Text='<%# Bind("DriverName") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorDriverEditFCS" 
                                                                runat="server" ControlToValidate="txtDriverFCS" 
                                                                ErrorMessage="Enter Driver Name" ValidationGroup="EditFCS">*</asp:RequiredFieldValidator>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtDRIVERNAME" runat="server" CssClass="TextBox" 
                                                                MaxLength="20"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                                                                ControlToValidate="txtDRIVERNAME" Display="Dynamic" 
                                                                ErrorMessage="Enter DRIVER NAME" SetFocusOnError="True" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("DriverName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="DURATION">
                                                        <FooterTemplate>
                                                            <asp:Button ID="btnSave" runat="server" CssClass="Button" 
                                                                OnClick="btnSave_Click" Text="Save" ValidationGroup="save" />
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("DURATION") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <EditItemTemplate>
                                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                                                                CommandName="Update" Text="Update" ValidationGroup="EditFCS"></asp:LinkButton>
                                                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                                                CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                                                CommandName="Edit" Text="Edit"></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDelete" runat="server" CausesValidation="False" 
                                                                CommandName="Delete" Text="Delete"></asp:LinkButton>
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
                                                <EmptyDataRowStyle Font-Bold="true" ForeColor="Red" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </asp:View>
                    <asp:View ID="View2" runat="server">
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                           <asp:GridView ID="gvIOS" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                                                Width="100%" CellPadding="0" EmptyDataText="No Record Found!" DataKeyNames="ID"
                                                ShowFooter="True" BorderWidth="0px" 
                                                onrowcancelingedit="gvIOS_RowCancelingEdit" onrowediting="gvIOS_RowEditing" 
                                                onrowupdating="gvIOS_RowUpdating" onrowdeleting="gvIOS_RowDeleting" 
                                                OnRowDataBound="gvIOS_RowDataBound" 
                                                onselectedindexchanged="gvIOS_SelectedIndexChanged" >
                                                <EmptyDataTemplate>
                                                    <asp:Label ID="lblEmptySearch" runat="server">No Results Found</asp:Label>
                                                </EmptyDataTemplate>
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Date">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtShiftDateIOS" runat="server" 
                                                                Text='<%# Bind("ShiftDateedit") %>'></asp:TextBox>
                                                             <asp:RegularExpressionValidator ID="RegularExpressionValidatorEditIOS" 
                                                                runat="server" ControlToValidate="txtShiftDateIOS"
                                                             Display="Dynamic" ErrorMessage="Enter Valid Shift Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                              ValidationGroup="EditIOS">*</asp:RegularExpressionValidator>
                                                            </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("ShiftDate") %>'></asp:Label></ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="CAB ID">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtCabIDIOS" runat="server" MaxLength="20" 
                                                                Text='<%# Bind("CabID") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorcabid1234" runat="server" 
                                                                ErrorMessage="Enter CabID" ControlToValidate="txtCabIDIOS"
                                                             ValidationGroup="EditIOS">*</asp:RequiredFieldValidator>
                                                            </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtCabID" runat="server" MaxLength="20" CssClass="TextBox" AutoPostBack="True"
                                                                OnTextChanged="txtCabID_TextChanged"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3"
                                                                    runat="server" ControlToValidate="txtCabID" Display="Dynamic" ErrorMessage="Enter CAB ID"
                                                                    ValidationGroup="save" SetFocusOnError="True">*</asp:RequiredFieldValidator></FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("CabID") %>'></asp:Label></ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="CAB NUMERIC">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtVehicleNoIOS" runat="server" MaxLength="20" 
                                                                Text='<%# Bind("CabRegNo") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorVehicle1234" 
                                                                runat="server" ErrorMessage="Enter Vehicle No" ControlToValidate="txtVehicleNoIOS"
                                                             ValidationGroup="EditIOS">*</asp:RequiredFieldValidator>
                                                            </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtCABNUMERIC" runat="server" MaxLength="20" CssClass="TextBox"></asp:TextBox><asp:RequiredFieldValidator
                                                                ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtCABNUMERIC"
                                                                Display="Dynamic" ErrorMessage="Enter CAB NUMERIC" ValidationGroup="save" SetFocusOnError="True">*</asp:RequiredFieldValidator></FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("CabRegNo") %>'></asp:Label></ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Start From">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtStartLocIOS" runat="server" MaxLength="5" 
                                                                Text='<%# Bind("StartLocation") %>'></asp:TextBox>
                                                             <asp:RequiredFieldValidator ID="RequiredFieldValidatorfacility1234" 
                                                                runat="server" ErrorMessage="Enter Start Location" ControlToValidate="txtStartLocIOS"
                                                             ValidationGroup="EditIOS">*</asp:RequiredFieldValidator>
                                                            </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:DropDownList ID="ddlFromLoc" runat="server">
                                                            </asp:DropDownList>
                                                            <asp:CompareValidator ID="CompareValidator11" runat="server" 
                                                                ControlToValidate="ddlFromLoc" Display="Dynamic" ErrorMessage="Select From" 
                                                                Operator="NotEqual" SetFocusOnError="True" ValidationGroup="save" 
                                                                ValueToCompare="0">*</asp:CompareValidator>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblStartLocation" runat="server" 
                                                                Text='<%# Bind("StartLocation") %>'></asp:Label></ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="TIME">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtTimeoutIOS" runat="server" MaxLength="5" 
                                                                Text='<%# Bind("TimeOut") %>'></asp:TextBox>
                                                             <asp:RequiredFieldValidator ID="RequiredFieldValidatorTimeout1234" 
                                                                runat="server" ErrorMessage="Enter Time OUT" ControlToValidate="txtTimeoutIOS"
                                                             ValidationGroup="EditIOS">*</asp:RequiredFieldValidator>
                                                             <asp:RegularExpressionValidator
                                                                    ID="RegularExpressionValidatortimeoutreg" runat="server" ControlToValidate="txtTimeoutIOS"
                                                                    ErrorMessage="Enter valid TIME - 00:00" SetFocusOnError="True" ValidationExpression="^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))$|^([01]\d|2[0-3])(:[0-5]\d){0,2}$"
                                                                    ValidationGroup="EditIOS">*</asp:RegularExpressionValidator>
                                                            </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtTIMEOUT" runat="server" MaxLength="5" CssClass="TextBox"></asp:TextBox>
                                                            <asp:RequiredFieldValidator
                                                                ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtTIMEOUT" Display="Dynamic"
                                                                ErrorMessage="Enter TIME" ValidationGroup="save" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator
                                                                    ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtTIMEOUT"
                                                                    ErrorMessage="Enter valid TIME - 00:00" SetFocusOnError="True" ValidationExpression="^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))$|^([01]\d|2[0-3])(:[0-5]\d){0,2}$"
                                                                    ValidationGroup="save">*</asp:RegularExpressionValidator></FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("TimeOut") %>'></asp:Label></ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Partner Count">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtEmpCountIOS" runat="server" MaxLength="20" 
                                                                Text='<%# Bind("EmpCount") %>'></asp:TextBox>
                                                               <asp:RequiredFieldValidator ID="RequiredFieldValidatorpartnert1234" 
                                                                runat="server" ErrorMessage="Enter Partner Count" ControlToValidate="txtEmpCountIOS"
                                                             ValidationGroup="EditIOS">*</asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidatorpartnereg" 
                                                                runat="server" ControlToValidate="txtEmpCountIOS" 
                                                                ErrorMessage="Enter Valid Partner Count" ValidationExpression="^[0-9]*$" 
                                                                ValidationGroup="EditIOS">*</asp:RegularExpressionValidator>
                                                            </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtEmpCount" runat="server" MaxLength="20" CssClass="TextBox"></asp:TextBox><asp:RequiredFieldValidator
                                                                ID="RequiredFieldValidatoremppcomrh" runat="server" ControlToValidate="txtEmpCount"
                                                                Display="Dynamic" ErrorMessage="Enter Partner Count" 
                                                                ValidationGroup="save" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator10sasa" 
                                                                runat="server" ControlToValidate="txtEmpCount" 
                                                                ErrorMessage="Enter Valid Partner Count" ValidationExpression="^[0-9]*$" 
                                                                ValidationGroup="save">*
                                                            </asp:RegularExpressionValidator>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("EmpCount") %>'></asp:Label></ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Document">
                                                        
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtDocumentIOS" runat="server" 
                                                                Text='<%# Bind("IsDocument") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator60sdds" runat="server" 
                                                                ControlToValidate="txtDocumentIOS" Display="Dynamic" 
                                                                ErrorMessage="Enter Document(Yes/No)" SetFocusOnError="True" 
                                                                ValidationGroup="EditIOS">*</asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator10dsdsdsds" 
                                                                runat="server" ControlToValidate="txtDocumentIOS" 
                                                                ErrorMessage="Enter Valid Document value(Yes/No)" 
                                                                ValidationExpression="(Yes|No)" ValidationGroup="EditIOS">*</asp:RegularExpressionValidator>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("IsDocument") %>'></asp:Label></ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                        
                                                        <FooterTemplate>
                                                            <asp:RadioButtonList ID="rblDocument" runat="server" 
                                                                RepeatDirection="Horizontal">
                                                                <asp:ListItem Selected="True" Value="1">Yes</asp:ListItem>
                                                                <asp:ListItem Value="0">No</asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </FooterTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="">
                                                    <EditItemTemplate>
                                            <asp:LinkButton ID="LinkButton1sdwd"  ValidationGroup="EditIOS" runat="server" 
                                                            CausesValidation="True" CommandName="Update"
                                                Text="Update"></asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton2qw" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="Cancel"></asp:LinkButton>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1asd" runat="server" CausesValidation="False" CommandName="Edit"
                                                Text="Edit"></asp:LinkButton>
                                                 <asp:LinkButton ID="LinkButtonDeleteIOS" runat="server" 
                                                CausesValidation="False" CommandName="Delete"
                                                Text="Delete"></asp:LinkButton>
                                               
                                        </ItemTemplate>
                                        
                                                        <FooterTemplate>
                                                            <asp:Button ID="btnSave" runat="server" CssClass="Button" 
                                                                OnClick="btnSaveIOS_Click" Text="Save" ValidationGroup="save" />
                                                        </FooterTemplate>
                                        
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
                                            </asp:GridView></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </asp:View>
                    <asp:View ID="View3" runat="server">
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                           <asp:GridView ID="gvBFC" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                                                Width="100%" CellPadding="0" EmptyDataText="No Record Found!" DataKeyNames="ID"
                                                ShowFooter="True" BorderWidth="0px" 
                                                onrowcancelingedit="gvBFC_RowCancelingEdit" onrowediting="gvBFC_RowEditing" 
                                                onrowupdating="gvBFC_RowUpdating" onrowdeleting="gvBFC_RowDeleting" >
                                                <EmptyDataTemplate>
                                                    <asp:Label ID="lblEmptySearch" runat="server">No Results Found</asp:Label>
                                                </EmptyDataTemplate>
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Date">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtShiftdateedit" runat="server" 
                                                                Text='<%# Bind("ShiftDateedit") %>'></asp:TextBox>
                                                             <asp:RegularExpressionValidator ID="RegularExpressionValidatorEditBFC" 
                                                                runat="server" ControlToValidate="txtShiftdateedit"
                                                             Display="Dynamic" ErrorMessage="Enter Valid Shift Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                              ValidationGroup="EditBFC">*</asp:RegularExpressionValidator>
                                                            </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label8" runat="server" Text='<%# Bind("ShiftDate") %>'></asp:Label></ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="CAB ID">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtCabidBFC" runat="server" MaxLength="20" 
                                                                Text='<%# Bind("CabID") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12351" runat="server" 
                                                                ErrorMessage="Enter CabID" ControlToValidate="txtCabidBFC"
                                                             ValidationGroup="EditBFC">*</asp:RequiredFieldValidator>
                                                            </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtCabID" runat="server" MaxLength="20" CssClass="TextBox" AutoPostBack="True"
                                                                OnTextChanged="txtCabID_TextChanged"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12365"
                                                                    runat="server" ControlToValidate="txtCabID" Display="Dynamic" ErrorMessage="Enter CAB ID"
                                                                    ValidationGroup="save" SetFocusOnError="True">*</asp:RequiredFieldValidator></FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label9" runat="server" Text='<%# Bind("CabID") %>'></asp:Label></ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="CAB NUMERIC">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtVehicleNoBFC" runat="server" MaxLength="20" 
                                                                Text='<%# Bind("CabRegNo") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorEditBFC" 
                                                                runat="server" ErrorMessage="Enter Vehcile Number" ControlToValidate="txtVehicleNoBFC"
                                                             ValidationGroup="EditBFC">*</asp:RequiredFieldValidator>
                                                            </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtCABNUMERIC" runat="server" MaxLength="20" CssClass="TextBox"></asp:TextBox>
                                                            <asp:RequiredFieldValidator
                                                                ID="RequiredFieldValidator122" runat="server" ControlToValidate="txtCABNUMERIC"
                                                                Display="Dynamic" ErrorMessage="Enter CAB NUMERIC" ValidationGroup="save" SetFocusOnError="True">*</asp:RequiredFieldValidator></FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label10" runat="server" Text='<%# Bind("CabRegNo") %>'></asp:Label></ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="TIME IN">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtTimeinEdit" runat="server" MaxLength="5" 
                                                                Text='<%# Bind("TimeIN") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorTimeinEditBFC" 
                                                                runat="server" ControlToValidate="txtTimeinEdit" ErrorMessage="Enter Time IN" 
                                                                ValidationGroup="EditBFC">*</asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidatorTimein" 
                                                                runat="server" ControlToValidate="txtTimeinEdit" 
                                                                ErrorMessage="Enter valid TIME IN - 00:00" SetFocusOnError="True" 
                                                                ValidationExpression="^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))$|^([01]\d|2[0-3])(:[0-5]\d){0,2}$" 
                                                                ValidationGroup="EditBFC">*</asp:RegularExpressionValidator>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtTIMEIN" runat="server" CssClass="TextBox" MaxLength="5"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                                                ControlToValidate="txtTIMEIN" Display="Dynamic" ErrorMessage="Enter TIME IN" 
                                                                SetFocusOnError="True" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                                                                ControlToValidate="txtTIMEIN" ErrorMessage="Enter valid TIME IN - 00:00" 
                                                                SetFocusOnError="True" 
                                                                ValidationExpression="^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))$|^([01]\d|2[0-3])(:[0-5]\d){0,2}$" 
                                                                ValidationGroup="save">*</asp:RegularExpressionValidator>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("TimeIN") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="TIME OUT">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtTIMEOUTBFC" runat="server" MaxLength="5" 
                                                                Text='<%# Bind("TimeOut") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorTimeoutEditBFC1" 
                                                                runat="server" ControlToValidate="txtTIMEOUTBFC" ErrorMessage="Enter Time Out" 
                                                                ValidationGroup="EditFCS">*</asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidatorTimeout" 
                                                                runat="server" ControlToValidate="txtTIMEOUTBFC" 
                                                                ErrorMessage="Enter valid TIME Out - 00:00" SetFocusOnError="True" 
                                                                ValidationExpression="^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))$|^([01]\d|2[0-3])(:[0-5]\d){0,2}$" 
                                                                ValidationGroup="EditBFC">*</asp:RegularExpressionValidator>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtTIMEOUT" runat="server" CssClass="TextBox" MaxLength="5"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                                                                ControlToValidate="txtTIMEOUT" Display="Dynamic" ErrorMessage="Enter TIME OUT" 
                                                                SetFocusOnError="True" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                                                                ControlToValidate="txtTIMEOUT" ErrorMessage="Enter valid TIME Out - 00:00" 
                                                                SetFocusOnError="True" 
                                                                ValidationExpression="^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))$|^([01]\d|2[0-3])(:[0-5]\d){0,2}$" 
                                                                ValidationGroup="save">*</asp:RegularExpressionValidator>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("TimeOut") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="DURATION">
                                                        
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label14" runat="server" Text='<%# Bind("DURATION") %>'></asp:Label></ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" />
                                                        
                                                        <FooterTemplate>
                                                            <asp:Button ID="btnSaveBFC" runat="server" CssClass="Button" OnClick="btnSaveBFC_Click" Text="Save" ValidationGroup="save" />
                                                        </FooterTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                    <EditItemTemplate>
                                            <asp:LinkButton ID="LinkButton3"  ValidationGroup="EditBFC" runat="server" 
                                                            CausesValidation="True" CommandName="Update"
                                                Text="Update"></asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="Cancel"></asp:LinkButton>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="False" CommandName="Edit"
                                                Text="Edit"></asp:LinkButton>
                                                 <asp:LinkButton ID="lbtnDelete" runat="server" 
                                                CausesValidation="False" CommandName="Delete"
                                                Text="Delete"></asp:LinkButton>
                                               
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
                                                <EmptyDataRowStyle ForeColor="Red" Font-Bold="true" />
                                            </asp:GridView></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </asp:View>
                    <asp:View ID="View4" runat="server">
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            
                                            <asp:GridView ID="gvToll" runat="server" AllowPaging="True" AllowSorting="True" 
                                                AutoGenerateColumns="False" BorderWidth="0px" CellPadding="0" DataKeyNames="ID" 
                                                EmptyDataText="No Record Found!" onrowcancelingedit="gvToll_RowCancelingEdit" 
                                                onrowdeleting="gvToll_RowDeleting" onrowediting="gvToll_RowEditing" 
                                                onrowupdating="gvToll_RowUpdating" ShowFooter="True" Width="100%">
                                                <EmptyDataTemplate>
                                                    <asp:Label ID="lblEmptySearch" runat="server">No Results Found</asp:Label>
                                                </EmptyDataTemplate>
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Date">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtShiftdateedit" runat="server" 
                                                                Text='<%# Bind("ShiftDateedit") %>'></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidatorEditFCS" 
                                                                runat="server" ControlToValidate="txtShiftdateedit" Display="Dynamic" 
                                                                ErrorMessage="Enter Valid Shift Date" 
                                                                ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$" 
                                                                ValidationGroup="EditToll">*</asp:RegularExpressionValidator>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblshiftdate" runat="server" Text='<%# Bind("ShiftDate") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="CAB ID">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtCabidToll" runat="server" MaxLength="20" 
                                                                Text='<%# Bind("CabID") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1234Toll" runat="server" 
                                                                ControlToValidate="txtCabidToll" ErrorMessage="Enter CabID" 
                                                                ValidationGroup="EditToll">*</asp:RequiredFieldValidator>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtCabID" runat="server" AutoPostBack="True" 
                                                                CssClass="TextBox" MaxLength="20" OnTextChanged="txtCabID_TextChanged"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3Toll" runat="server" 
                                                                ControlToValidate="txtCabID" Display="Dynamic" ErrorMessage="Enter CAB ID" 
                                                                SetFocusOnError="True" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("CabID") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="CAB NUMERIC">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtVehicleNoToll" runat="server" MaxLength="20" 
                                                                Text='<%# Bind("CabRegNo") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorEditToll" runat="server" 
                                                                ControlToValidate="txtVehicleNoToll" ErrorMessage="Enter Vehcile Number" 
                                                                ValidationGroup="EditToll">*</asp:RequiredFieldValidator>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtCABNUMERIC" runat="server" CssClass="TextBox" 
                                                                MaxLength="20"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4Toll" runat="server" 
                                                                ControlToValidate="txtCABNUMERIC" Display="Dynamic" 
                                                                ErrorMessage="Enter CAB NUMERIC" SetFocusOnError="True" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("CabRegNo") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="TIME">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtTimeinEdit" runat="server" MaxLength="5" 
                                                                Text='<%# Bind("Time") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorTimeinEditToll" 
                                                                runat="server" ControlToValidate="txtTimeinEdit" ErrorMessage="Enter Time IN" 
                                                                ValidationGroup="EditToll">*</asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidatorTimein" 
                                                                runat="server" ControlToValidate="txtTimeinEdit" 
                                                                ErrorMessage="Enter valid TIME - 00:00" SetFocusOnError="True" 
                                                                ValidationExpression="^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))$|^([01]\d|2[0-3])(:[0-5]\d){0,2}$" 
                                                                ValidationGroup="EditToll">*</asp:RegularExpressionValidator>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtTIMEIN" runat="server" CssClass="TextBox" MaxLength="5"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                                                ControlToValidate="txtTIMEIN" Display="Dynamic" ErrorMessage="Enter TIME" 
                                                                SetFocusOnError="True" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                                                                ControlToValidate="txtTIMEIN" ErrorMessage="Enter valid TIME - 00:00" 
                                                                SetFocusOnError="True" 
                                                                ValidationExpression="^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))$|^([01]\d|2[0-3])(:[0-5]\d){0,2}$" 
                                                                ValidationGroup="save">*</asp:RegularExpressionValidator>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("Time") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    
                                                    <asp:TemplateField HeaderText="Plaza">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtTollPlaza" runat="server" MaxLength="20" 
                                                                Text='<%# Bind("Plaza") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorDriverEditToll" 
                                                                runat="server" ControlToValidate="txtTollPlaza" 
                                                                ErrorMessage="Enter Plaza" ValidationGroup="EditToll">*</asp:RequiredFieldValidator>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtToll" runat="server" CssClass="TextBox" 
                                                                MaxLength="20"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7Toll" runat="server" 
                                                                ControlToValidate="txtToll" Display="Dynamic" 
                                                                ErrorMessage="Enter Plaza" SetFocusOnError="True" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("Plaza") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Amount">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtTollAmount" runat="server" MaxLength="20" 
                                                                Text='<%# Bind("Amount") %>'></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorDriverEditAmount" 
                                                                runat="server" ControlToValidate="txtTollAmount" 
                                                                ErrorMessage="Enter Amount" ValidationGroup="EditToll">*</asp:RequiredFieldValidator>
                                                        </EditItemTemplate>
                                                        
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtAmount" runat="server" CssClass="TextBox" 
                                                                MaxLength="20"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7Tolla" runat="server" 
                                                                ControlToValidate="txtAmount" Display="Dynamic" 
                                                                ErrorMessage="Enter Amount" SetFocusOnError="True" ValidationGroup="save">*</asp:RequiredFieldValidator>
                                                        </FooterTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                        
                                                    </asp:TemplateField>
                                                    
                                                    <asp:TemplateField>
                                                        <EditItemTemplate>
                                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                                                                CommandName="Update" Text="Update" ValidationGroup="EditToll"></asp:LinkButton>
                                                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                                                CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                                                CommandName="Edit" Text="Edit"></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDelete" runat="server" CausesValidation="False" 
                                                                CommandName="Delete" Text="Delete"></asp:LinkButton>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Button ID="btnSaveToll" runat="server" CssClass="Button" 
                                                                OnClick="btnSaveToll_Click" Text="Save" ValidationGroup="save" />
                                                        </FooterTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <RowStyle CssClass="RowStyle" />
                                                <FooterStyle CssClass="FooterStyle" />
                                                <PagerStyle CssClass="PagerStyle" />
                                                <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                <HeaderStyle CssClass="HeaderStyle" />
                                                <EditRowStyle BackColor="#999999" />
                                                <AlternatingRowStyle CssClass="AltRowStyle" />
                                                <EmptyDataRowStyle Font-Bold="true" ForeColor="Red" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </asp:View>
                </asp:MultiView>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
