<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="SystemSetting.aspx.cs" Inherits="SystemSetting" %>

<%@ Register Assembly="obout_Grid_NET" Namespace="Obout.Grid" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" border="0" width="100%">
        <tr>
            <td align="center">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="Submit" Height="16px" />
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Label ID="lblErrorMsg" runat="server" CssClass="error"></asp:Label>
                &nbsp;
            </td>
        </tr>
        <tr align="center">
            <td class="heading">
                <div class="gradient2">
                    <h1>
                        <span></span>Display System Settings
                    </h1>
                    <h2>
                        Allows to Edit the Setting Values.
                    </h2>
                </div>
            </td>
        </tr>
        
        <tr>
            <td align="center" >
                <asp:DropDownList ID="ddlFacility" runat="server" CssClass="DropDownListBox3" ToolTip="Select Facility"
                    AutoPostBack="True" OnSelectedIndexChanged="ddlFacility_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <table border="0" cellpadding="4" cellspacing="0" align="left" width="90%">
                    <tr>
                        <td align="center" colspan="4">
                            <asp:GridView ID="grdSysSettings" runat="server" AutoGenerateColumns="False" OnRowEditing="grdSysSettings_RowEditing"
                                OnRowUpdating="grdSysSettings_RowUpdating" OnRowCancelingEdit="grdSysSettings_RowCancelingEdit"
                                AllowPaging="True" ShowFooter="True" BorderWidth="0px" 
                                onpageindexchanging="grdSysSettings_PageIndexChanging">
                                <RowStyle CssClass="RowStyle" />
                                <FooterStyle CssClass="FooterStyle" />
                                <PagerStyle CssClass="PagerStyle" />
                                <SelectedRowStyle CssClass="SelectedRowStyle" />
                                <HeaderStyle CssClass="HeaderStyle" />
                                <EditRowStyle BackColor="#999999" />
                                <AlternatingRowStyle CssClass="AltRowStyle" />
                                <Columns>
                                    <asp:TemplateField HeaderText="ConfigName">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_ConfigName" runat="server" Text='<%#Eval("configName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ConfigValue">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_configValue" runat="server" Text='<%#Eval("configValue") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="Txt_configValue" runat="server" Text='<%#Eval("configValue") %>'
                                                MaxLength="200"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Description">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_description" runat="server" Text='<%#Eval("description") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="Txt_description" runat="server" Text='<%#Eval("description") %>'
                                                MaxLength="200"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="CreatedBy">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_created" runat="server" Text='<%#Eval("CreatedBy") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ChangedDate">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_ChangedDate" runat="server" Text='<%#Eval("ChangedDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                                                Text="Update"></asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="Cancel"></asp:LinkButton>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                                                Text="Edit"></asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle Width="20%" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <center>
                    <font color="red">
                        <asp:Label ID="lbl_error" runat="server"></asp:Label></font>
                </center>
            </td>
        </tr>        
    </table>
</asp:Content>
