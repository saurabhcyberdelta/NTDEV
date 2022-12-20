<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="ShiftTimeMaster.aspx.cs" Inherits="ShiftTimeMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table align="center" width="100%">
                <tr>
                    <td align="center">
                        <asp:ValidationSummary ID="ValidationSummaryEdit" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="edit" />
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
                    <td>
                        &nbsp;&nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="heading">
                        <div class="gradient2">
                            <h1>
                                <span></span>Shift Time Master
                            </h1>
                            <h2>
                                Allows User to View/Edit and Add New Shift Timings.
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
                    <td align="center">
                        <table class="style1" align="center">
                            <tr>
                                <td align="center">
                                    <table class="style1" align="center">
                                        <tr>
                                            <td align="center">
                                                <asp:Label ID="lblMsg" runat="server" CssClass="message" Visible="False"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <asp:MultiView ID="mvShiftTime" runat="server" ActiveViewIndex="0">
                                                    <asp:View ID="View1" runat="server">
                                                        <table width="620px" align="center">
                                                            <tr>
                                                                <td width="33%" valign="top" align="center">
                                                                    Facility:&nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <asp:DropDownList ID="ddlFacilitySort" runat="server" AppendDataBoundItems="True"
                                                                        AutoPostBack="True" OnSelectedIndexChanged="ddlFacilitySort_SelectedIndexChanged"
                                                                        Style="font-family: Verdana; font-size: x-small;" CssClass="DropDownListBox3">
                                                                        <asp:ListItem Value="0">All</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td width="33%" align="center">
                                                                    <asp:LinkButton ID="lbtnAddNew0" runat="server" CausesValidation="False" OnClick="lbtnAddNew_Click">Add New</asp:LinkButton>
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                 <%--   <asp:LinkButton ID="lbtnAddNewGrid" runat="server" CausesValidation="False" OnClick="lbtnAddNewGrid_Click">Add New Grid</asp:LinkButton>
                                                     --%>           </td>
                                                                <td width="33%" valign="top" align="center">
                                                                    &nbsp;&nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="33%">
                                                                    &nbsp;
                                                                </td>
                                                                <td width="33%">
                                                                    &nbsp;&nbsp;
                                                                </td>
                                                                <td width="33%">
                                                                    &nbsp;&nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <asp:GridView ID="gvShiftTime" runat="server" AllowPaging="True" AllowSorting="True"
                                                            AutoGenerateColumns="False" CssClass="GridView" DataKeyNames="Id" OnPageIndexChanging="gvShiftTime_PageIndexChanging"
                                                            OnRowCancelingEdit="gvShiftTime_RowCancelingEdit" OnRowDeleting="gvShiftTime_RowDeleting"
                                                            OnRowEditing="gvShiftTime_RowEditing" OnRowUpdating="gvShiftTime_RowUpdating"
                                                            Width="100%" PageSize="20" BorderWidth="0" ShowFooter="True">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Shift Time">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblShiftTime" runat="server" Text='<%# Eval("shiftTime") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtShiftTime" runat="server" MaxLength="4" Text='<%# Eval("shiftTime") %>'
                                                                            Width="60px" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="ReqFieldFacName" runat="server" ControlToValidate="txtShiftTime"
                                                                            Display="Dynamic" ErrorMessage="Enter Shift Time" ValidationGroup="edit">*</asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtShiftTime"
                                                                            Display="Dynamic" ErrorMessage="The shift time must be with in 0000 hrs to 2359 hrs."
                                                                            ValidationExpression="^(20|21|22|23|[01]\d|\d)(([0-5]\d){1,2})$" ValidationGroup="edit">*</asp:RegularExpressionValidator>
                                                                    </EditItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Shift Type">
                                                                    <EditItemTemplate>
                                                                        <asp:RadioButton ID="rdbtnPick" runat="server" Checked='<%# Convert.ToString(Eval("Type"))=="Pick"?true:false %>'
                                                                            GroupName="type" Text="Pick" />
                                                                        <asp:RadioButton ID="rdbtnDrop" runat="server" Checked='<%# Convert.ToString(Eval("Type"))=="Drop"?true:false %>'
                                                                            GroupName="type" Text="Drop" />
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblShiftType" runat="server" Text='<%# Eval("Type") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Faciltiy Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblFacilityName" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" Visible="False"
                                                                            CssClass="DropDownListBox3">
                                                                            <asp:ListItem Value="0">Select Facility</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:Label ID="lblFacilityNameEdit" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                                    </EditItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Day">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblDay" runat="server" Text='<%# Eval("Day") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:RadioButton ID="rdbtnWeekDay" runat="server" Checked='<%# Convert.ToString(Eval("Day"))=="WeekDay"?true:false %>'
                                                                            GroupName="day" Text="WeekDay" />
                                                                        <asp:RadioButton ID="rdbtnWeekEnd" runat="server" Checked='<%# Convert.ToString(Eval("Day"))=="WeekEnd"?true:false %>'
                                                                            GroupName="day" Text="WeekEnd" />
                                                                    </EditItemTemplate>
                                                                </asp:TemplateField>
                                                                 <asp:TemplateField HeaderText="Buffer(Min)">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblBuffer" runat="server" Text='<%# Eval("buffer") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="txtBuffer" runat="server" MaxLength="4" Text='<%# Eval("buffer") %>'
                                                                            Width="60px" CssClass="TextBox"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="ReqFieldbufName" runat="server" ControlToValidate="txtBuffer"
                                                                            Display="Dynamic" ErrorMessage="Enter Buffer Time" ValidationGroup="edit">*</asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator134" runat="server" ControlToValidate="txtBuffer"
                                                                            Display="Dynamic" ErrorMessage="Enter Valid Buffer Time in min."
                                                                            ValidationExpression="^[0-9][0-9]$" ValidationGroup="edit">*</asp:RegularExpressionValidator>
                                                                    </EditItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField ShowHeader="False">
                                                                    <EditItemTemplate>
                                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                                                                            Text="Update" ValidationGroup="edit"></asp:LinkButton>
                                                                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                            Text="Cancel"></asp:LinkButton>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                                                                            Text="Edit"></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField ShowHeader="False">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandName="Delete"
                                                                            Text="Delete"></asp:LinkButton>
                                                                        <cc1:ConfirmButtonExtender ID="ConfirmButton_LinkButton3" TargetControlID="LinkButton3"
                                                                            runat="server" ConfirmOnFormSubmit="False" ConfirmText="Are you sure you want to delete this Shift?">
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
                                                    </asp:View>
                                                    <asp:View ID="View3" runat="server">
                                                        <table align="center">
                                                            <tr>
                                                                <td align="center">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center">
                                                                    <asp:DetailsView ID="dvShiftTimeAdd" runat="server" AutoGenerateRows="False" DataKeyNames="Id"
                                                                        DefaultMode="Insert" EnablePagingCallbacks="True" HeaderText="Add New Shift Time"
                                                                        OnItemInserting="dvShiftTimeAdd_ItemInserting" OnModeChanging="dvShiftTimeAdd_ModeChanging"
                                                                        Width="300px">
                                                                        <Fields>
                                                                            <asp:TemplateField HeaderText="Shift Time">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtShiftTimeAdd" runat="server" MaxLength="4" Width="80px" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldShiftTime1" runat="server" ControlToValidate="txtShiftTimeAdd"
                                                                                        Display="Dynamic" ErrorMessage="Enter Shift Time" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtShiftTimeAdd"
                                                                                        Display="Dynamic" ErrorMessage="The shift time must be with in 0000 hrs to 2359 hrs."
                                                                                        ValidationExpression="^(20|21|22|23|[01]\d|\d)(([0-5]\d){1,2})$" ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Shift Type">
                                                                                <InsertItemTemplate>
                                                                                    <asp:RadioButton ID="rdbtndvPick" runat="server" Checked="True" GroupName="type"
                                                                                        Text="Pick" />
                                                                                    <asp:RadioButton ID="rdbtndvDrop" runat="server" GroupName="type" Text="Drop" />
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Facility Name">
                                                                                <InsertItemTemplate>
                                                                                    <asp:DropDownList ID="ddlFacilityAdd" runat="server" AppendDataBoundItems="True"
                                                                                        CssClass="DropDownListBox3">
                                                                                        <asp:ListItem Value="0">Select Facility</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlFacilityAdd"
                                                                                        ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="add" ValueToCompare="0">*</asp:CompareValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Day">
                                                                                <InsertItemTemplate>
                                                                                    <asp:RadioButton ID="rdbtndvWeekDay" runat="server" Checked="True" GroupName="day"
                                                                                        Text="WeekDay" />
                                                                                    <asp:RadioButton ID="rdbtndvWeekEnd" runat="server" Checked='<%# Convert.ToString(Eval("Day"))=="WeekEnd"?true:false %>'
                                                                                        GroupName="day" Text="WeekEnd" />
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                             <asp:TemplateField HeaderText="Buffer (MIN)">
                                                                                <InsertItemTemplate>
                                                                                     <asp:TextBox ID="txtBuffer" runat="server" MaxLength="4" Width="80px" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldShiftTime123" runat="server" ControlToValidate="txtBuffer"
                                                                                        Display="Dynamic" ErrorMessage="Enter Buffer in Min" ValidationGroup="add">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator126" runat="server" ControlToValidate="txtBuffer"
                                                                                        Display="Dynamic" ErrorMessage="Enter Valid Buffer Time"
                                                                                        ValidationExpression="^[0-9][0-9]$" ValidationGroup="add">*</asp:RegularExpressionValidator>
                                                                             
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            <asp:CommandField ValidationGroup="add" CancelText="Close" InsertText="Save" ShowInsertButton="True" />
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
                                                    <asp:View ID="View4" runat="server">
                                                        <table border="1" width="600" align="center">
                                                            <tr>
                                                                <td width="350">
                                                                    <strong>&nbsp; Shift Time Pick</strong>
                                                                    <br />
                                                                </td>
                                                                <td width="350">
                                                                    <strong>&nbsp; Shift Time Drop</strong>
                                                                    <br />
                                                                </td>
                                                                <td width="350">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="350">
                                                                    <asp:CustomValidator ID="CustomValidator1" runat="server" Display="dynamic" OnServerValidate="ChkBxLstShiftTimePick_Validate"
                                                                        Text="Select PickUp ShiftTime" ValidationGroup="grid" />
                                                                    <asp:CheckBoxList ID="ChkBxLstShiftTimePick" runat="server" RepeatColumns="2" Width="200px">
                                                                    </asp:CheckBoxList>
                                                                </td>
                                                                <td width="350">
                                                                    <asp:CustomValidator ID="CustomValidator2" runat="server" Display="dynamic" OnServerValidate="ChkBxLstShiftTimeDrop_Validate"
                                                                        Text="Select Drop ShiftTime" ValidationGroup="grid" />
                                                                    <asp:CheckBoxList ID="ChkBxLstShiftTimeDrop" runat="server" RepeatColumns="2" Width="200px">
                                                                    </asp:CheckBoxList>
                                                                </td>
                                                                <td valign="top" width="350">
                                                                    <table width="200">
                                                                        <tr>
                                                                            <td>
                                                                                <strong>Facility:</strong><asp:CompareValidator ID="CompareValidator3" runat="server"
                                                                                    ControlToValidate="ddlFacilityGrid" Display="Dynamic" ErrorMessage="Select Facility"
                                                                                    Operator="NotEqual" ValidationGroup="grid" ValueToCompare="0"></asp:CompareValidator>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddlFacilityGrid" runat="server" AppendDataBoundItems="True"
                                                                                    CssClass="DropDownListBox3">
                                                                                    <asp:ListItem Selected="True" Value="0">Select Facility</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                &nbsp;
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:RadioButton ID="rdbtnWeek" runat="server" Checked="True" GroupName="day" Text="Weekday" />
                                                                                <asp:RadioButton ID="rdbtnEnd" runat="server" GroupName="day" Text="Weekend" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:LinkButton ID="lbtnSave" runat="server" OnClick="lbtnSave_Click" ValidationGroup="grid">Save</asp:LinkButton>
                                                                                &nbsp;&nbsp;
                                                                                <asp:LinkButton ID="lbtnClose" runat="server" CausesValidation="False" OnClick="lbtnClose_Click">Close</asp:LinkButton>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="350">
                                                                </td>
                                                                <td width="350">
                                                                </td>
                                                                <td width="350">
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
                                <td>
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                                        DisplayAfter="0">
                                        <ProgressTemplate>
                                            <table align="center">
                                                <tr>
                                                    <td>
                                                        <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" />
                                                    </td>
                                                    <td>
                                                        Please Wait!!
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
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
