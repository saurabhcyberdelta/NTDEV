<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="ProcessMaster.aspx.cs" Inherits="ProcessMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table align="center" width="100%" border="0">
                <tr>
                    <td align="center">
                        <asp:ValidationSummary ID="ValidationSummaryEdit" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="editprocess" />
                        <asp:ValidationSummary ID="ValidationSummaryadd" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="addprocess" />
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="editsub" />
                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="addsub" />
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="heading">
                        <div class="gradient2">
                            <h1>
                                <span></span>Process Master
                            </h1>
                            <h2>
                                Allows to View/Edit and Add New Process/SubProcess.
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
                        <table align="center" border="0" width="90%">
                            <tr>
                                <td align="center">
                                    <asp:GridView ID="gvProcess" runat="server" AllowPaging="True" AllowSorting="True"
                                        AutoGenerateColumns="False" CssClass="GridView" DataKeyNames="Id" Width="80%"
                                        OnPageIndexChanging="gvProcess_PageIndexChanging" OnRowCancelingEdit="gvProcess_RowCancelingEdit"
                                        OnRowEditing="gvProcess_RowEditing" OnRowUpdating="gvProcess_RowUpdating" OnSelectedIndexChanging="gvProcess_SelectedIndexChanging"
                                        BorderWidth="0px" ShowFooter="True">
                                        <Columns>
                                            <asp:CommandField CausesValidation="False" SelectText="View Sub-Process" ShowSelectButton="True">
                                                <ItemStyle Width="30%" />
                                            </asp:CommandField>
                                            <asp:TemplateField HeaderText="Process Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProcess" runat="server" Text='<%# Eval("processName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtProcessName" runat="server" Text='<%# Eval("processName") %>'
                                                        CssClass="TextBox" Width="250"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="ReqFieldProcessName" runat="server" ControlToValidate="txtProcessName"
                                                        Display="Dynamic" ErrorMessage="Enter Process Name" ValidationGroup="editprocess">*</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegExpAlphanum3" runat="server" ControlToValidate="txtProcessName"
                                                        Display="Dynamic" ErrorMessage="Process Nem Should be Alphanumeric." Text="*"
                                                        ValidationExpression="^([\w\-]|\s)*$" ValidationGroup="editprocess"></asp:RegularExpressionValidator>
                                                </EditItemTemplate>
                                                <HeaderStyle HorizontalAlign="Left" />
                                                <ItemStyle Width="60%" />
                                            </asp:TemplateField>
                                            <asp:CommandField ShowEditButton="True" ValidationGroup="editprocess">
                                                <ItemStyle Width="10%" />
                                            </asp:CommandField>
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
                                    <asp:LinkButton ID="lbtnAddNew" runat="server" CausesValidation="False" OnClick="lbtnAddNew_Click">Add New Process</asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Label ID="lblMsg" runat="server" CssClass="message" Visible="False"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table align="center" width="80%">
                                        <tr>
                                            <td align="center">
                                                <asp:MultiView ID="mvProcess" runat="server" ActiveViewIndex="0">
                                                    <table align="center" width="100%">
                                                        <tr>
                                                            <td align="center">
                                                                <table align="center">
                                                                    <tr>
                                                                        <td width="50%" align="center">
                                                                            <asp:View ID="View1" runat="server">
                                                                                <table align="center" width="100%">
                                                                                    <tr>
                                                                                        <td align="center">
                                                                                            &nbsp;<asp:GridView ID="gvSubProcess" runat="server" AutoGenerateColumns="False"
                                                                                                CssClass="GridView" DataKeyNames="Id" OnPageIndexChanging="gvSubProcess_PageIndexChanging"
                                                                                                OnRowCancelingEdit="gvSubProcess_RowCancelingEdit" OnRowEditing="gvSubProcess_RowEditing"
                                                                                                OnRowUpdating="gvSubProcess_RowUpdating" Width="100%" BorderWidth="0px" ShowFooter="True">
                                                                                                <Columns>
                                                                                                    <asp:TemplateField HeaderText="Sub Process Name">
                                                                                                        <EditItemTemplate>
                                                                                                            <asp:TextBox ID="txtSubProcessName" runat="server" Text='<%# Eval("subProcessName") %>'
                                                                                                                MaxLength="50" CssClass="TextBox" Width="200px"></asp:TextBox>
                                                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSubProcessName"
                                                                                                                Display="Dynamic" ErrorMessage="Select Sub-Process Name" ValidationGroup="editsub">*</asp:RequiredFieldValidator>
                                                                                                          
                                                                                                        </EditItemTemplate>
                                                                                                        <ItemTemplate>
                                                                                                            <asp:Label ID="lblSubProcessName" runat="server" Text='<%# Eval("subProcessName") %>'></asp:Label>
                                                                                                        </ItemTemplate>
                                                                                                        <ItemStyle Width="70%" />
                                                                                                    </asp:TemplateField>
                                                                                                    <asp:CommandField ShowEditButton="True" ValidationGroup="editsub">
                                                                                                        <ItemStyle Width="30%" />
                                                                                                    </asp:CommandField>
                                                                                                </Columns>
                                                                                                <RowStyle CssClass="RowStyle" />
                                                                                                <FooterStyle CssClass="FooterStyle" />
                                                                                                <PagerStyle CssClass="PagerStyle" />
                                                                                                <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                                                                <HeaderStyle CssClass="HeaderStyle" />
                                                                                                <EditRowStyle BackColor="#999999" />
                                                                                                <AlternatingRowStyle CssClass="AltRowStyle" />
                                                                                            </asp:GridView>
                                                                                            &nbsp; &nbsp;
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center">
                                                                                            <asp:LinkButton ID="lbtnNewSubProcess" runat="server" OnClick="lbtnNewSubProcess_Click">Add New Sub-Process</asp:LinkButton>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </asp:View>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">
                                                                <asp:View ID="View2" runat="server">
                                                                    <table align="center">
                                                                        <tr>
                                                                            <td align="center">
                                                                                <asp:DetailsView ID="dvProcess" runat="server" AutoGenerateRows="False" DataKeyNames="Id"
                                                                                    DefaultMode="Insert" HeaderText="Add New Process" OnItemInserting="dvProcess_ItemInserting"
                                                                                    OnModeChanging="dvProcess_ModeChanging" Width="100%">
                                                                                    <Fields>
                                                                                        <asp:TemplateField HeaderText="Process Name">
                                                                                            <InsertItemTemplate>
                                                                                                <asp:TextBox ID="txtdvProcessName" runat="server" CssClass="TextBox" MaxLength="50"
                                                                                                    Width="175px"></asp:TextBox>
                                                                                                <asp:RequiredFieldValidator ID="ReqFieldProcessName0" runat="server" ControlToValidate="txtdvProcessName"
                                                                                                    Display="Dynamic" ErrorMessage="Enter Process Name" ValidationGroup="addprocess">*</asp:RequiredFieldValidator>
                                                                                                 </InsertItemTemplate>
                                                                                            <HeaderStyle HorizontalAlign="Right" />
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:CommandField ShowInsertButton="True" ValidationGroup="addprocess" CancelText="Close"
                                                                                            InsertText="Save" />
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
                                                                <asp:View ID="View3" runat="server">
                                                                    <table align="center" width="100%">
                                                                        <tr>
                                                                            <td align="center">
                                                                                <asp:DetailsView ID="dvSubProcess" runat="server" AutoGenerateRows="False" DefaultMode="Insert"
                                                                                    HeaderText="Add New Sub-Process" Height="50px" OnModeChanging="dvSubProcess_ModeChanging"
                                                                                    OnItemInserting="dvSubProcess_ItemInserting" Width="100%">
                                                                                    <Fields>
                                                                                        <asp:TemplateField HeaderText="Process Name">
                                                                                            <InsertItemTemplate>
                                                                                                <asp:DropDownList ID="ddldvProcess" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                                                </asp:DropDownList>
                                                                                                <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddldvProcess"
                                                                                                    Display="Dynamic" ErrorMessage="Select Process" Operator="NotEqual" ValidationGroup="addsub"
                                                                                                    ValueToCompare="0">*</asp:CompareValidator>
                                                                                            </InsertItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Sub Process Name">
                                                                                            <InsertItemTemplate>
                                                                                                <asp:TextBox runat="server" ID="txtdvSubProcess" MaxLength="50" CssClass="TextBox"></asp:TextBox>
                                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtdvSubProcess"
                                                                                                    Display="Dynamic" ErrorMessage="Enter Sub Process" ValidationGroup="addsub">*</asp:RequiredFieldValidator>
                                                                                                </InsertItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:CommandField ShowInsertButton="True" ValidationGroup="addsub" CancelText="Close"
                                                                                            InsertText="Save" />
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
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:MultiView>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                                                    DisplayAfter="0">
                                                    <ProgressTemplate>
                                                        <table align="center">
                                                            <tr>
                                                                <td align="center">
                                                                    <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" />
                                                                </td>
                                                                <td>
                                                                    Please Wait!!!
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
                <tr>
                    <td>
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
