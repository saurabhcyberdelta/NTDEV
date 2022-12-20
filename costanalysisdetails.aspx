<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="costanalysisdetails.aspx.cs" Inherits="costanalysisdetails" %>




<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
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
                                            <span></span>Cost Analysis Details
                                        </h1>
                                        <h2>
                                         </h2>
                                    </div>
                                    
            </td>
        </tr>
        <tr>
            <td align="center">
                <br />
                <table border="0" cellpadding="4" cellspacing="0" align="left" width="90%" class="tableBorber">
                    <tr>
                        <td align="center" class="TDbg" colspan="4">
                            Fill The Selection Criteria
                            <asp:Label ID="lblFacError" runat="server" CssClass="error" Text="Select Facility"
                                Visible="False"></asp:Label>
                            &nbsp; &nbsp; &nbsp;
                        </td>
                    </tr>
                    <tr align="center">
                      
                        <td align="left" valign="top">
                            <b>Facility Name: </b>
                        </td>
                         <td align="left" valign="top">
                            <b>Year </b>
                        </td>
                        <td align="left" rowspan="2" valign="middle">
                            <asp:Button ID="btnSubmit" runat="server" Text="Run Report" ValidationGroup="Submit"
                                OnClick="btnSubmit_Click" CssClass="Button" />
                        </td>
                    </tr>
                    <tr align="center">
                      
                        <td align="left" valign="top">
                            <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                                Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                        </td>
                          <td align="left" valign="top">
                            <asp:DropDownList ID="ddlYear" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlYear"
                                Display="Dynamic" ErrorMessage="Select Year" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        </table>
    
                <table align="left" style="width: 104%">
                    <tr>
                        <td align="left">
                            <asp:GridView ID="Grdanalysis" runat="server" AutoGenerateColumns="false" DataKeyNames="id">
                            <Columns>
                            <asp:TemplateField HeaderText="Analysis">
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtnAnalysisName" runat="server" 
                                    Text='<%#Eval("analysis") %>' onclick="lbtnAnalysisName_Click"></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle Width="50px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Jan">
                            <ItemTemplate>
                                <asp:TextBox ID="txtjan" runat="server" Text='<%#Eval("jan") %>'  Width="55px"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Feb">
                            <ItemTemplate>
                                <asp:TextBox ID="txtfeb" runat="server" Text='<%#Eval("feb") %>'  Width="55px"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mar">
                            <ItemTemplate>
                                <asp:TextBox ID="txtmar" runat="server" Text='<%#Eval("mar") %>'  Width="55px"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Apr">
                            <ItemTemplate>
                                <asp:TextBox ID="txtapr" runat="server" Text='<%#Eval("apr") %>'  Width="55px"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="May">
                            <ItemTemplate>
                                <asp:TextBox ID="txtmay" runat="server" Text='<%#Eval("May") %>'  Width="55px"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Jun">
                            <ItemTemplate>
                                <asp:TextBox ID="txtjun" runat="server" Text='<%#Eval("jun") %>'  Width="55px"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="July">
                            <ItemTemplate>
                                <asp:TextBox ID="txtjul" runat="server" Text='<%#Eval("jul") %>'  Width="55px"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Aug">
                            <ItemTemplate>
                                <asp:TextBox ID="txtaug" runat="server" Text='<%#Eval("Aug") %>'  Width="55px"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sep">
                            <ItemTemplate>
                                <asp:TextBox ID="txtsep" runat="server" Text='<%#Eval("Sep") %>'  Width="55px"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Oct">
                            <ItemTemplate>
                                <asp:TextBox ID="txtoct" runat="server" Text='<%#Eval("Oct") %>'  Width="55px"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Nov">
                            <ItemTemplate>
                                <asp:TextBox ID="txtnov" runat="server" Text='<%#Eval("Nov") %>'  Width="55px"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dec">
                            <ItemTemplate>
                                <asp:TextBox ID="txtdec" runat="server" Text='<%#Eval("Dec") %>'  Width="55px"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
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
                </table>
           
</asp:Content>



