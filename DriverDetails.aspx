<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="DriverDetails.aspx.cs" Inherits="DriverDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>            
            <table width="100%">
                <tr>
                    <td align="center">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="add" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
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
                    <td align="center" style="width:100%">
                        <table width="100%">
                            <tr>
                                <td align="center">
                                    <table width="50%">
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
                                           <%-- <caption>
                                                &gt;
                                            </caption>--%>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">&nbsp; &nbsp;
                                    <asp:LinkButton ID="lkbExport" runat="server" CausesValidation="False" OnClick="lkbExport_Click">Export to Excel</asp:LinkButton>&nbsp; &nbsp;&nbsp; &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                    <asp:MultiView ID="MultiView1" runat="server">
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <asp:View ID="View1" runat="server">
                                                        <table align="center" width="100%">
                                                            <tr>
                                                                <td align="center">
                                                                    <asp:GridView ID="GVDriverMaster" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                        BorderWidth="0px" CssClass="GridView" DataKeyNames="ID,vehicleNo" EmptyDataText="No record found"
                                                                        OnPageIndexChanging="GVDriverMaster_PageIndexChanging" OnRowDataBound="GVDriverMaster_RowDataBound"
                                                                        PageSize="20" ShowFooter="True" Width="1200px">
                                                                        <RowStyle CssClass="RowStyle" />
                                                                        <FooterStyle CssClass="FooterStyle" />
                                                                        <PagerStyle CssClass="PagerStyle" />
                                                                        <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                                        <HeaderStyle BackColor="#004f75" Font-Bold="true" ForeColor="White" />
                                                                        <EditRowStyle BackColor="#999999" />
                                                                        <AlternatingRowStyle CssClass="AltRowStyle" />
                                                                        <EmptyDataRowStyle Font-Bold="true" ForeColor="Red" HorizontalAlign="Left" />
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="CabIds">
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="lkbCabId" runat="server" Text='<%# Eval("vehicleNo") %>' 
                                                                                        onclick="lkbCabId_Click"></asp:LinkButton>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>                                                                            
                                                                            <asp:BoundField DataField="DriverName" HeaderText="Driver Name" />
                                                                            <asp:BoundField DataField="DateOfJoining" HeaderText="Date Of Joining" />
                                                                            <asp:BoundField DataField="BadgeNo" HeaderText="BadgeNo" />
                                                                            <asp:BoundField DataField="BadgeIssueDate" HeaderText="Badge Issue Date" />
                                                                            <asp:BoundField DataField="BadgeExpiryDate" HeaderText="Badge Expiry Date" />
                                                                            <asp:BoundField DataField="LicenseNumber" HeaderText="License Number" />
                                                                            <asp:BoundField DataField="LicenseIssuedDate" 
                                                                                HeaderText="License Issued Date" />
                                                                            <asp:BoundField DataField="LicenseExpiryDate" 
                                                                                HeaderText="License Expiry Date" />
                                                                            <asp:BoundField DataField="TotalExperience" HeaderText="Total Experience" />
                                                                            <asp:BoundField DataField="AreaofResidence" HeaderText="Area Of Residence" />
                                                                            <asp:BoundField DataField="BloodGroup" HeaderText="Blood Group" />
                                                                            <asp:BoundField DataField="Contact1" HeaderText="Contact1" />
                                                                            <asp:BoundField DataField="Contact2" HeaderText="Contact2" />
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center">
                                                                    <asp:LinkButton ID="lbtnAddNew" runat="server" OnClick="lbtnAddNew_Click">Click Add/Update Driver</asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:View>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center">
                                                    <asp:View ID="View2" runat="server">
                                                        <table width="80%">
                                                            <tr>
                                                                <td align="center">                                                                
                                                                    <asp:FormView ID="FVDriver" runat="server" DefaultMode="Insert" Width="100%" BorderStyle="Ridge"
                                                                        BorderColor="Black" BorderWidth="0px" CssClass="tableBorber">
                                                                        <EditRowStyle BackColor="White" />
                                                                        <FooterStyle CssClass="FooterStyle" />
                                                                        <InsertItemTemplate>
                                                                            <table class="tableBorber" width="100%">
                                                                                <tr>
                                                                                    <td colspan="4" class="row1">
                                                                                        <b>Add Driver Details</b>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td width="20%" class="myTableRowStyle">
                                                                                        Facility :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableRowStyle">
                                                                                        <asp:DropDownList ID="ddldvFacility" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                                            CssClass="DropDownListBox3" OnSelectedIndexChanged="ddldvFacility_SelectedIndexChanged">
                                                                                        </asp:DropDownList>
                                                                                        <asp:CompareValidator ID="CompareVa" runat="server" ControlToValidate="ddldvFacility"
                                                                                            Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" SetFocusOnError="true"
                                                                                            ValidationGroup="add" ValueToCompare="0">*</asp:CompareValidator>
                                                                                    </td>
                                                                                    <td width="20%" class="myTableRowStyle">
                                                                                        CabId :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableRowStyle">
                                                                                        <asp:DropDownList ID="ddlDvCabID" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                                            CssClass="DropDownListBox3" OnSelectedIndexChanged="ddlDvCabID_SelectedIndexChanged">
                                                                                            <asp:ListItem Text="Select CabID" Value="0"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                        <asp:CompareValidator ID="CompareValidat" runat="server" ControlToValidate="ddlDvCabID"
                                                                                            Display="Dynamic" ErrorMessage="Select CabID" Operator="NotEqual" SetFocusOnError="true"
                                                                                            ValidationGroup="add" ValueToCompare="0">*</asp:CompareValidator>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td width="20%" class="myTableAltRowStyle">
                                                                                        Driver Name :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableAltRowStyle">
                                                                                        <asp:TextBox ID="txtDvDriverName" runat="server" CssClass="TextBox" MaxLength="50"></asp:TextBox>
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDvDriverName"
                                                                                            Display="Dynamic" ErrorMessage="Enter Driver Name" SetFocusOnError="true" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                        <asp:RegularExpressionValidator ID="RegExpAlphanum1" runat="server" ControlToValidate="txtDvDriverName"
                                                                                            Display="Dynamic" ErrorMessage="Driver Name Should be Alphanumeric." SetFocusOnError="true"
                                                                                            Text="*" ValidationExpression="^([\w\-]|\s)*$" ValidationGroup="add"></asp:RegularExpressionValidator>
                                                                                    </td>
                                                                                    <td width="20%" class="myTableAltRowStyle">
                                                                                        Blood Group :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableAltRowStyle">
                                                                                        <asp:DropDownList ID="ddlBloodGroup" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                                            <asp:ListItem Text="Select CabID" Value="0"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlDvCabID"
                                                                                            Display="Dynamic" ErrorMessage="Select CabID" Operator="NotEqual" SetFocusOnError="true"
                                                                                            ValidationGroup="add" ValueToCompare="0">*</asp:CompareValidator>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td width="20%" class="myTableRowStyle">
                                                                                        Date Of Joining :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableRowStyle" valign="middle">
                                                                                        <asp:TextBox ID="txtDateOfJoining" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                                        <cc1:CalendarExtender ID="txtDateOfJoining_CalendarExtender" runat="server" Enabled="True"
                                                                                            TargetControlID="txtDateOfJoining">
                                                                                        </cc1:CalendarExtender>
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDateOfJoining"
                                                                                            Display="Dynamic" ErrorMessage="Enter Date Of Joining" SetFocusOnError="true"
                                                                                            ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                        <asp:RegularExpressionValidator ID="RegularExpressionVidator6" runat="server" ControlToValidate="txtDateOfJoining"
                                                                                            Display="Dynamic" ErrorMessage="Enter Valid Date Of Joining" SetFocusOnError="true"
                                                                                            ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                                            ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                                    </td>
                                                                                    <td width="20%" class="myTableRowStyle">
                                                                                        Badge No. :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableRowStyle">
                                                                                        <asp:TextBox ID="txtdvBadgeNo" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtdvBadgeNo"
                                                                                            Display="Dynamic" ErrorMessage="Enter BadgeNo" SetFocusOnError="true" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td width="20%" class="myTableAltRowStyle">
                                                                                        Badge Date :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableAltRowStyle">
                                                                                        <asp:TextBox ID="txtdvBadgeIssueDate" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                                        <cc1:CalendarExtender ID="txtdvBadgeIssueDate_CalendarExtender" runat="server" Enabled="True"
                                                                                            TargetControlID="txtdvBadgeIssueDate">
                                                                                        </cc1:CalendarExtender>
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtdvBadgeIssueDate"
                                                                                            Display="Dynamic" ErrorMessage="Enter Badge Issue Date" SetFocusOnError="true"
                                                                                            ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                        <asp:RegularExpressionValidator ID="RegularExpressiondator6" runat="server" ControlToValidate="txtdvBadgeIssueDate"
                                                                                            Display="Dynamic" ErrorMessage="Enter Valid Badge Issue Date" SetFocusOnError="true"
                                                                                            ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                                            ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                                    </td>
                                                                                    <td width="20%" class="myTableAltRowStyle">
                                                                                        Badge Expiry Date :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableAltRowStyle">
                                                                                        <asp:TextBox ID="txtdvBadgeExpiryDate" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                                        <cc1:CalendarExtender ID="txtdvBadgeExpiryDate_CalendarExtender0" runat="server"
                                                                                            Enabled="True" TargetControlID="txtdvBadgeExpiryDate">
                                                                                        </cc1:CalendarExtender>
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtdvBadgeExpiryDate"
                                                                                            Display="Dynamic" ErrorMessage="Enter Badge Expiry Date" SetFocusOnError="true"
                                                                                            ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                        <asp:RegularExpressionValidator ID="RegularonValidator6" runat="server" ControlToValidate="txtdvBadgeExpiryDate"
                                                                                            Display="Dynamic" ErrorMessage="Enter Valid Badge Expiry Date" SetFocusOnError="true"
                                                                                            ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                                            ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td width="20%" class="myTableRowStyle">
                                                                                        License No. :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableRowStyle">
                                                                                        <asp:TextBox ID="txtdvLicenseNumber" runat="server" CssClass="TextBox" MaxLength="20"></asp:TextBox>
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtdvLicenseNumber"
                                                                                            Display="Dynamic" ErrorMessage="Enter License Number" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                    </td>
                                                                                    <td width="20%" class="myTableRowStyle">
                                                                                        License Issued Date :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableRowStyle">
                                                                                        <asp:TextBox ID="txtdvLicenseIssuedDate" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                                        <cc1:CalendarExtender ID="txtdvLicenseIssuedDate_CalendarExtender" runat="server"
                                                                                            Enabled="True" TargetControlID="txtdvLicenseIssuedDate">
                                                                                        </cc1:CalendarExtender>
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtdvLicenseIssuedDate"
                                                                                            Display="Dynamic" ErrorMessage="Enter License Issued Date" SetFocusOnError="true"
                                                                                            ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                        <asp:RegularExpressionValidator ID="RegularEessionValidator7" runat="server" ControlToValidate="txtdvLicenseIssuedDate"
                                                                                            Display="Dynamic" ErrorMessage="Enter Valid License Issued Date" SetFocusOnError="true"
                                                                                            ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                                            ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td width="20%" class="myTableAltRowStyle">
                                                                                        License Expiry Date :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableAltRowStyle">
                                                                                        <asp:TextBox ID="txtdvLicenseExpiryDate" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                                        <cc1:CalendarExtender ID="txtdvLicenseExpiryDate_CalendarExtender" runat="server"
                                                                                            Enabled="True" TargetControlID="txtdvLicenseExpiryDate">
                                                                                        </cc1:CalendarExtender>
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtdvLicenseExpiryDate"
                                                                                            Display="Dynamic" ErrorMessage="Enter License Expiry Date" SetFocusOnError="true"
                                                                                            ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                        <asp:RegularExpressionValidator ID="RegularEessionValidator6" runat="server" ControlToValidate="txtdvLicenseExpiryDate"
                                                                                            Display="Dynamic" ErrorMessage="Enter Valid License Expiry Date" SetFocusOnError="true"
                                                                                            ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                                            ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                                    </td>
                                                                                    <td width="20%" class="myTableAltRowStyle">
                                                                                        Total Experience :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableAltRowStyle">
                                                                                        <asp:TextBox ID="txtdvTotalExperience" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtdvTotalExperience"
                                                                                            Display="Dynamic" ErrorMessage="Enter Total Experience" SetFocusOnError="true"
                                                                                            ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td width="20%" class="myTableRowStyle">
                                                                                        Area of Residence :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableRowStyle">
                                                                                        <asp:TextBox ID="txtdvAreaOfResidence" runat="server" CssClass="TextBox" MaxLength="100"></asp:TextBox>
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtdvAreaOfResidence"
                                                                                            Display="Dynamic" ErrorMessage="Enter Area Of Residence" SetFocusOnError="true"
                                                                                            ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                    </td>
                                                                                    <td width="20%" class="myTableRowStyle">
                                                                                        Contact-1 :
                                                                                    </td>
                                                                                    <td width="30%" valign="middle" class="myTableRowStyle">
                                                                                        <asp:TextBox ID="txtdvContact1" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtdvContact1"
                                                                                            Display="Dynamic" ErrorMessage="Enter Contact1" SetFocusOnError="true" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td width="20%" class="myTableAltRowStyle">
                                                                                        Contact-2 :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableAltRowStyle">
                                                                                        <asp:TextBox ID="txtdvContact2" runat="server" CssClass="TextBox" MaxLength="10"></asp:TextBox>
                                                                                    </td>
                                                                                    <td width="20%" class="myTableAltRowStyle">
                                                                                        Attrited :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableAltRowStyle">
                                                                                        <asp:CheckBox ID="chkAttrited" runat="server" Enabled="false" />
                                                                                        &nbsp;
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td width="20%" class="myTableRowStyle">
                                                                                        Photo :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableRowStyle">
                                                                                        <asp:FileUpload ID="FileUploadPhoto" runat="server" />
                                                                                    </td>
                                                                                    <td width="20%" class="myTableRowStyle">
                                                                                        Finger Print :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableRowStyle">
                                                                                        <asp:FileUpload ID="FileUploadFinger" runat="server" />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td width="20%" class="myTableAltRowStyle">
                                                                                        Contact-2 :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableAltRowStyle">
                                                                                        <asp:Image ID="imgfvdPhoto" runat="server" Width="100px" Height="100px" ImageUrl='<%# Eval("Photo") %>' />
                                                                                        <asp:Label ID="lblfvdPhoto" runat="server"></asp:Label>
                                                                                    </td>
                                                                                    <td width="20%" class="myTableAltRowStyle">
                                                                                        Attrited :
                                                                                    </td>
                                                                                    <td width="30%" class="myTableAltRowStyle">                                                                                        
                                                                                        <asp:Image ID="imgfvdFinger" runat="server" Width="100px" Height="100px" ImageUrl='<%# Eval("FingerPrint") %>' />
                                                                                        <asp:Label ID="lblfvdFinger" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </InsertItemTemplate>
                                                                        <PagerStyle CssClass="PagerStyle" />
                                                                        <RowStyle BackColor="White" />
                                                                    </asp:FormView>                                                                    
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnSave" runat="server" CssClass="Button" Text="Save" 
                                                                        onclick="btnSave_Click" ValidationGroup="add" />
                                                                    <asp:Button ID="btnCancel" runat="server" CssClass="Button" Text="Cancel" 
                                                                        onclick="btnCancel_Click" />
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
                                <td style="width:100%" align="center">
                                    <asp:Button ID="Button1" runat="server" Style="display: none" />
                                    <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                        TargetControlID="Button1" PopupControlID="Panel3" CancelControlID="btnClose">
                                    </cc1:ModalPopupExtender>
                                    <asp:Panel ID="Panel3" runat="server" Width="80%">
                                        <table width="100%" style="border: 1px ridge #000000" bgcolor="#FFFFCC">
                                            <tr>
                                                <td bgcolor="#0000CC" align="right">
                                                    <asp:ImageButton ID="btnClose" runat="server" ImageUrl="images/Exit.jpg" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:FormView ID="FVDriverDetails" runat="server" Width="100%"
                                                        BorderStyle="Ridge" BorderColor="Black" BorderWidth="0px" CssClass="tableBorber">
                                                        <EditRowStyle BackColor="White" />
                                                        <FooterStyle CssClass="FooterStyle" />
                                                        <ItemTemplate>
                                                            <table class="tableBorber" width="100%">
                                                                <tr>
                                                                    <td colspan="4" class="row1">
                                                                        <b>Driver Details</b>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td width="20%" class="myTableRowStyle">
                                                                        Facility :
                                                                    </td>
                                                                    <td width="30%" class="myTableRowStyle">
                                                                        <%# Eval("facilityName")%>
                                                                    </td>
                                                                    <td width="20%" class="myTableRowStyle">
                                                                        CabId :
                                                                    </td>
                                                                    <td width="30%" class="myTableRowStyle">
                                                                        <%# Eval("vehicleNo") %>
                                                                    </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="20%" class="myTableAltRowStyle">
                                                                            Driver Name :
                                                                        </td>
                                                                        <td width="30%" class="myTableAltRowStyle">                                                                            
                                                                            <%# Eval("DriverName") %>
                                                                        </td>
                                                                        <td width="20%" class="myTableAltRowStyle">
                                                                            Blood Group :
                                                                        </td>
                                                                        <td width="30%" class="myTableAltRowStyle">                                                                            
                                                                            <%# Eval("BloodGroup")%>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="20%" class="myTableRowStyle">
                                                                            Date Of Joing :
                                                                        </td>
                                                                        <td width="30%" class="myTableRowStyle">                                                                            
                                                                            <%# Eval("DateOfJoining")%>
                                                                        </td>
                                                                        <td width="20%" class="myTableRowStyle">
                                                                            Badge No. :
                                                                        </td>
                                                                        <td width="30%" class="myTableRowStyle">                                                                            
                                                                            <%# Eval("BadgeNo") %>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="20%" class="myTableAltRowStyle">
                                                                            Badge Date :
                                                                        </td>
                                                                        <td width="30%" class="myTableAltRowStyle">                                                                            
                                                                            <%# Eval("BadgeIssueDate")%>
                                                                        </td>
                                                                        <td width="20%" class="myTableAltRowStyle">
                                                                            Badge Expiry Date :
                                                                        </td>
                                                                        <td width="30%" class="myTableAltRowStyle">                                                                            
                                                                            <%# Eval("BadgeExpiryDate") %>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="20%" class="myTableRowStyle">
                                                                            License No. :
                                                                        </td>
                                                                        <td width="30%" class="myTableRowStyle">                                                                            
                                                                            <%# Eval("LicenseNumber")%>
                                                                        </td>
                                                                        <td width="20%" class="myTableRowStyle">
                                                                            License Issued Date :
                                                                        </td>
                                                                        <td width="30%" class="myTableRowStyle">                                                                            
                                                                            <%# Eval("LicenseIssuedDate") %>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="20%" class="myTableAltRowStyle">
                                                                            License Expiry Date :
                                                                        </td>
                                                                        <td width="30%" class="myTableAltRowStyle">                                                                            
                                                                            <%# Eval("LicenseExpiryDate")%>
                                                                        </td>
                                                                        <td width="20%" class="myTableAltRowStyle">
                                                                            Total Experience :
                                                                        </td>
                                                                        <td width="30%" class="myTableAltRowStyle">                                                                            
                                                                            <%# Eval("TotalExperience") %>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="20%" class="myTableRowStyle">
                                                                            Area of Residence :
                                                                        </td>
                                                                        <td width="30%" class="myTableRowStyle">                                                                            
                                                                            <%# Eval("AreaofResidence")%>
                                                                        </td>
                                                                        <td width="20%" class="myTableRowStyle">
                                                                            Contact-1 :
                                                                        </td>
                                                                        <td width="30%" class="myTableRowStyle">                                                                            
                                                                            <%# Eval("Contact1")%>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="20%" class="myTableAltRowStyle">
                                                                            Contact-2 :
                                                                        </td>
                                                                        <td width="30%" class="myTableAltRowStyle">                                                                            
                                                                            <%# Eval("Contact2")%>
                                                                        </td>
                                                                        <td width="20%" class="myTableAltRowStyle">
                                                                            Attrited :
                                                                        </td>
                                                                        <td width="30%" class="myTableAltRowStyle">                                                                            
                                                                            <%# Eval("Attrited")%>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="20%" class="myTableRowStyle">
                                                                            Photo :
                                                                        </td>
                                                                        <td width="30%" class="myTableRowStyle">
                                                                            <asp:Image ID="imgPhoto" runat="server" Width="100px" Height="100px" ImageUrl='<%# Eval("Photo") %>' />
                                                                        </td>
                                                                        <td width="20%" class="myTableRowStyle">
                                                                            Finger Print :
                                                                        </td>
                                                                        <td width="30%" class="myTableRowStyle">
                                                                            <asp:Image ID="imgFinger" runat="server" Width="100px" Height="100px" ImageUrl='<%# Eval("FingerPrint") %>' />
                                                                        </td>
                                                                    </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                        <PagerStyle CssClass="PagerStyle" />
                                                        <RowStyle BackColor="White" />
                                                    </asp:FormView>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
            <asp:PostBackTrigger ControlID="FVDriver" />
            <asp:PostBackTrigger ControlID="lkbExport" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

