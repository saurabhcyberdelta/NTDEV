<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="IncidentMaster.aspx.cs" Inherits="IncidentMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style7 {
            width: 50%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <table align="center" width="100%">
        <tr>
            <td align="center">
                <asp:ValidationSummary ID="ValidationSummaryadd" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="add" />
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="heading">
                <div class="gradient2">
                    <h1>
                        <span></span>Incident Master
                    </h1>
                    <h2>Allows User to View/Edit and Add New Incident Master.
                    </h2>
                </div>
            </td>
        </tr>
        <tr>
            <td align="center">&nbsp;
                        <asp:Label ID="lblMsg" runat="server" CssClass="message" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center">
                <table width="50%" class="tableBorber">
                    <tr>
                        <td class="TDbg" colspan="3">&nbsp; &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td style="width:33%;" align="center">
                            <b>Start Date</b>
                        </td>
                        <td style="width:33%;" align="center">
                            <b>End Date</b>
                        </td>
                        <td style="width:33%;" align="center">
                            <b>Facility Name</b>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:33%;" align="center">
                            <asp:TextBox ID="txtStartDate" runat="server" CssClass="TextBox" autocomplete="off"></asp:TextBox>
                             <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" Enabled="true"
                                    TargetControlID="txtStartDate">
                                </cc1:CalendarExtender>
                        </td>
                        <td style="width:33%;" align="center">
                            <asp:TextBox ID="txtEndDate" runat="server" CssClass="TextBox" autocomplete="off"></asp:TextBox>
                           <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="true"
                                    TargetControlID="txtEndDate">
                                </cc1:CalendarExtender>
                        </td>
                        <td style="width:33%;" align="center">
                            <asp:DropDownList ID="ddlSelectFacility" runat="server" AppendDataBoundItems="true"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlSelectFacility_SelectedIndexChanged">
                            </asp:DropDownList>
                            
                        </td>
                        <%--<td style="width: 40%" align="right">Facility Name :</td>
                        <td style="width: 60%" align="left">
                            <asp:DropDownList ID="ddlSelectFacility" runat="server" AppendDataBoundItems="true"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlSelectFacility_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>--%>
                    </tr>
                    <tr>
                    <td align="right">&nbsp; &nbsp;
                        
                    </td>
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
                <table align="center" width="100%">
                    <tr>
                        <td align="center">
                            <asp:MultiView ID="mvFacility" runat="server" ActiveViewIndex="0">
                                <table align="center">
                                    <tr>
                                        <td>
                                            <asp:View ID="View4" runat="server">
                                                <table align="center" width="100%">
                                                    <tr>
                                                        <td align="center">&nbsp;<asp:GridView ID="gvIncedentMaster" runat="server" AllowPaging="True" AllowSorting="True"
                                                            AutoGenerateColumns="False" CssClass="GridView" OnPageIndexChanging="gvIncedent_PageIndexChanging"
                                                            DataKeyNames="Id" BorderWidth="0px" ShowFooter="True"
                                                            OnSelectedIndexChanging="gvIncedentMaster_SelectedIndexChanging">
                                                            <Columns>
                                                                <asp:CommandField ShowSelectButton="True" />
                                                                <asp:TemplateField HeaderText="Facility Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblgvFacilityName" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Vendor Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblgvVendor" runat="server" Text='<%# Eval("vendorName") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Cab Id">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblgvCab" runat="server" Text='<%# Eval("vehicleNo") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Driver Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblgvDriver" runat="server" Text='<%# Eval("DriverName") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Badge No.">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblgvBadge" runat="server" Text='<%# Eval("BadgeNo") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Date">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblgvDate" runat="server" Text='<%# Eval("IncDate") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Shift">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblgvShift" runat="server" Text='<%# Eval("Shift") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Route No.">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblgvRouteNo" runat="server" Text='<%# Eval("RouteId") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Severity">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblgvSeverity" runat="server" Text='<%# Eval("Severity") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Mistake By">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblgvMistake" runat="server" Text='<%# Eval("MistakeBy") %>'></asp:Label></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Attachment">
                                                                    <ItemTemplate>
                                                                        <asp:HyperLink ID="hpAttachment" runat="server" Text='<%# Eval("AttachmentName") %>'
                                                                            NavigateUrl='<%# bind("Attachment") %>'></asp:HyperLink>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <%--<asp:CommandField ShowEditButton="True" ValidationGroup="edit" />--%>
                                                            </Columns>
                                                            <RowStyle CssClass="RowStyle" />
                                                            <FooterStyle CssClass="FooterStyle" />
                                                            <PagerStyle CssClass="PagerStyle" />
                                                            <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                            <HeaderStyle CssClass="HeaderStyle1" />
                                                            <EditRowStyle BackColor="#999999" />
                                                            <AlternatingRowStyle CssClass="AltRowStyle" />
                                                        </asp:GridView>
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:LinkButton ID="lbtnAddNew" runat="server" CausesValidation="False" OnClick="lbtnAddNew_Click">Add New</asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:View>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:View ID="View5" runat="server">
                                                <table width="100%" border="0">
                                                    <%--<tr>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                            </tr>--%>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:DetailsView ID="dvIncedentMaster" runat="server" AutoGenerateRows="False" DataKeyNames="Id"
                                                                DefaultMode="Insert" HeaderText="Add New Incident" OnItemInserting="dvIncedent_ItemInserting"
                                                                OnModeChanging="dvIncedent_ModeChanging" Width="60%">
                                                                <Fields>
                                                                    <asp:TemplateField HeaderText="Facility Name :">
                                                                        <InsertItemTemplate>
                                                                            <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
                                                                                CssClass="DropDownListBox3" OnSelectedIndexChanged="ddlFacility_SelectedIndexChanged">
                                                                            </asp:DropDownList>
                                                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                                                                                Display="Dynamic" ErrorMessage="Please Select Facility Name" Operator="NotEqual"
                                                                                ValidationGroup="add" ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                                        </InsertItemTemplate>
                                                                        <HeaderStyle HorizontalAlign="Right" />
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Vendor Name :">
                                                                        <InsertItemTemplate>
                                                                            <asp:DropDownList ID="ddlVendor" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
                                                                                CssClass="DropDownListBox3" OnSelectedIndexChanged="ddlVendor_SelectedIndexChanged">
                                                                            </asp:DropDownList>
                                                                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlVendor"
                                                                                Display="Dynamic" ErrorMessage="Please Select Vendor Name" Operator="NotEqual"
                                                                                ValidationGroup="add" ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                                        </InsertItemTemplate>
                                                                        <HeaderStyle HorizontalAlign="Right" />
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Cab Id :">
                                                                        <InsertItemTemplate>
                                                                            <asp:DropDownList ID="ddlCab" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
                                                                                CssClass="DropDownListBox3" OnSelectedIndexChanged="ddlCab_SelectedIndexChanged">
                                                                            </asp:DropDownList>
                                                                            <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="ddlCab"
                                                                                Display="Dynamic" ErrorMessage="Please Select Cab No." Operator="NotEqual" ValidationGroup="add"
                                                                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                                        </InsertItemTemplate>
                                                                        <HeaderStyle HorizontalAlign="Right" />
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Driver Name :">
                                                                        <InsertItemTemplate>
                                                                            <asp:TextBox ID="txtDriver" runat="server" MaxLength="30" CssClass="TextBox"></asp:TextBox><asp:RequiredFieldValidator
                                                                                ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter Driver Name"
                                                                                ControlToValidate="txtDriver" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                        </InsertItemTemplate>
                                                                        <HeaderStyle HorizontalAlign="Right" />
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Badge No. :">
                                                                        <InsertItemTemplate>
                                                                            <asp:TextBox ID="txtBadgeNo" runat="server" MaxLength="30" CssClass="TextBox"></asp:TextBox>
                                                                        </InsertItemTemplate>
                                                                        <HeaderStyle HorizontalAlign="Right" />
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Date :">
                                                                        <InsertItemTemplate>
                                                                            <asp:TextBox ID="txtDate" runat="server" CssClass="TextBox" MaxLength="30"></asp:TextBox>
                                                                            <cc1:CalendarExtender
                                                                                ID="txtDate_CalendarExtender" runat="server" TargetControlID="txtDate" PopupButtonID="Image1">
                                                                            </cc1:CalendarExtender>
                                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/calendar_icon.gif" /><asp:RequiredFieldValidator
                                                                                ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Select Date"
                                                                                ControlToValidate="txtDate" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                        </InsertItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Shift :">
                                                                        <InsertItemTemplate>
                                                                            <asp:TextBox ID="txtShift" runat="server" CssClass="TextBox" MaxLength="30"></asp:TextBox><asp:RequiredFieldValidator
                                                                                ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please Enter Shift Time"
                                                                                ControlToValidate="txtShift" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                        </InsertItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Route No. :">
                                                                        <InsertItemTemplate>
                                                                            <asp:TextBox ID="txtRouteNo" runat="server" CssClass="TextBox" MaxLength="30"></asp:TextBox><asp:RequiredFieldValidator
                                                                                ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please Enter Route Id"
                                                                                ControlToValidate="txtRouteNo" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                        </InsertItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Severity :">
                                                                        <InsertItemTemplate>
                                                                            <asp:DropDownList ID="ddlSeverity" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                                <asp:ListItem Text="-Select-" Value="0" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Text="Low" Value="L"></asp:ListItem>
                                                                                <asp:ListItem Text="Medium" Value="M"></asp:ListItem>
                                                                                <asp:ListItem Text="High" Value="H"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                            <asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="ddlSeverity"
                                                                                Display="Dynamic" ErrorMessage="Please Select Severity" Operator="NotEqual" ValidationGroup="add"
                                                                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                                        </InsertItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Mistakeby :">
                                                                        <InsertItemTemplate>
                                                                            <asp:DropDownList ID="ddlMistake" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                                <asp:ListItem Text="-Select-" Value="0" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Text="Third Party" Value="T"></asp:ListItem>
                                                                                <asp:ListItem Text="Self" Value="S"></asp:ListItem>
                                                                                <asp:ListItem Text="Both" Value="B"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                            <asp:CompareValidator ID="CompareValidator5" runat="server" ControlToValidate="ddlMistake"
                                                                                Display="Dynamic" ErrorMessage="Please Select Mistakeby" Operator="NotEqual"
                                                                                ValidationGroup="add" ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                                                        </InsertItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Attchement :">
                                                                        <InsertItemTemplate>
                                                                            <asp:FileUpload ID="FUAttachment" runat="server" /><br />
                                                                            <asp:Label ID="lblAttachment" runat="server"></asp:Label>
                                                                        </InsertItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:CommandField ValidationGroup="add" ShowInsertButton="True" />
                                                                    <asp:CommandField ValidationGroup="add" ShowEditButton="True" />
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
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </asp:MultiView>
                        </td>
                    </tr>
                    <tr>
                        <td align="center"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
    </table>

</asp:Content>

