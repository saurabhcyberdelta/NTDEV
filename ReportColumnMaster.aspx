<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="ReportColumnMaster.aspx.cs" Inherits="ReportColumnMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
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
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="heading">
                        Report Column Configuration
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="Label2" runat="server" Font-Bold="False" Font-Overline="False" Text=" Allow to configure report column."
                            CssClass="subHeading"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        &nbsp;
                        </td>
                </tr>
                <tr>
                    <td align="center">
                        Select Report To Display Column:</td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:RadioButtonList ID="rdbListReport" runat="server" AutoPostBack="True" 
                            CssClass="DetailsView" DataTextField="ReportName" DataValueField="Id" 
                            onselectedindexchanged="rdbListReport_SelectedIndexChanged">
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <table align="center">
                            <tr>
                                <td align="center" width="100%">
                                    <asp:GridView ID="gvColumns" runat="server"  AllowSorting="True"
                                        AutoGenerateColumns="False" CssClass="GridView" 
                                        DataKeyNames="Id" 
                                        HorizontalAlign="Center" 
                                        Width="600px" onpageindexchanging="gvColumns_PageIndexChanging1">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Columns">
                                                <AlternatingItemTemplate>
                                                    <asp:Label ID="lblColumn" runat="server" Text='<%# Eval("Caption") %>'></asp:Label>
                                                </AlternatingItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblColumn" runat="server" Text='<%# Eval("Caption") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ControlStyle Width="70%" />
                                                <ItemStyle Width="70%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="&nbsp;&nbsp;Normal&nbsp;&nbsp;">
                                                <AlternatingItemTemplate>
                                                    <asp:RadioButton ID="rdbNormal" runat="server" GroupName="col" Checked='<%#  Convert.ToInt32(Eval("Rights"))==0?true:false %>'/>
                                                </AlternatingItemTemplate>
                                                <ItemTemplate>
                                                    <asp:RadioButton ID="rdbNormal" runat="server" GroupName="col" Checked='<%#  Convert.ToInt32(Eval("Rights"))==0?true:false %>'/>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Mandatory">
                                                <AlternatingItemTemplate>
                                                    <asp:RadioButton ID="rdbMandatory" runat="server" GroupName="col" Checked='<%#  Convert.ToInt32(Eval("Rights"))==1?true:false %>'/>
                                                </AlternatingItemTemplate>
                                                <ItemTemplate>
                                                    <asp:RadioButton ID="rdbMandatory" runat="server" GroupName="col" Checked='<%#  Convert.ToInt32(Eval("Rights"))==1?true:false %>'/>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Restricted">
                                                <AlternatingItemTemplate>
                                                    <asp:RadioButton ID="rdbRestricted" runat="server" GroupName="col" Checked='<%#  Convert.ToInt32(Eval("Rights"))==2?true:false %>'/>
                                                </AlternatingItemTemplate>
                                                <ItemTemplate>
                                                    <asp:RadioButton ID="rdbRestricted" runat="server" GroupName="col" Checked='<%#  Convert.ToInt32(Eval("Rights"))==2?true:false %>'/>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
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
                                    <br />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr><td align="center">
                    <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red" 
                        Text="Data Successfully Saved!"></asp:Label>
                    </td></tr>
                <tr>
                    <td align="center">
                        <asp:Button ID="btnSave" runat="server" CssClass="Button" 
                            OnClick="btnSave_Click" Text="Save" ValidationGroup="editemp" Width="90px" />
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                            DisplayAfter="0">
                            <ProgressTemplate>
                                <table>
                                    <tr>
                                        <td>
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
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
