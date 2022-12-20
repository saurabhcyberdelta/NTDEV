<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="AnalysisMast.aspx.cs" Inherits="AnalysisMast" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
     <table align="center" border="0" width="100%">
        <tr>
            <td align="center">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true"
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
                        <span></span>Analysis Master
                    </h1>
                    <h2>
                        Allows to Add Delete Analysis
                    </h2>
                </div>
            </td>
        </tr>
        
        <tr>
            <td align="center" >
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="true" ShowSummary="false" ValidationGroup="Edit"  />
               <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="100" AssociatedUpdatePanelID="UpdatePanel1"
                                        DynamicLayout="False">
                                        <ProgressTemplate>
                                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loding..." />
                                            Loading.....Please Wait!!!</ProgressTemplate>
                                    </asp:UpdateProgress>
            </td>
        </tr>
        <tr>
            <td align="center">
                    <font color="red">
                        <asp:Label ID="lbl_error" runat="server"></asp:Label></font>
                <br />
                <table border="0" cellpadding="4" cellspacing="0" align="left" width="100%">
                    <tr>
                        <td align="center" colspan="4">
                         <asp:MultiView ID="MultiView1" runat="server">
                         <asp:View ID="View2" runat="server">
                            <asp:GridView ID="grdManager" runat="server" AutoGenerateColumns="False" 
                                
                                AllowPaging="True" ShowFooter="True" BorderWidth="0px" 
                                onpageindexchanging="grdManager_PageIndexChanging" PageSize="10" 
                                DataKeyNames="Id" onrowdeleting="grdManager_RowDeleting">
                                <RowStyle CssClass="RowStyle" />
                                <FooterStyle CssClass="FooterStyle" />
                                <PagerStyle CssClass="PagerStyle" />
                                <SelectedRowStyle CssClass="SelectedRowStyle" />
                                <HeaderStyle CssClass="HeaderStyle" />
                                <EditRowStyle BackColor="#999999" />
                                <AlternatingRowStyle CssClass="AltRowStyle" />
                                <Columns>
                                   <asp:TemplateField HeaderText="Analysis">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_empcode" runat="server" Text='<%#Eval("analysis") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="40%" />
                                      
                                    </asp:TemplateField>
                                     
                                   
                                     
                                     <asp:TemplateField ShowHeader="False">
                                        
                                        <ItemTemplate>
                                           
                                                 <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandName="Delete"
                                                Text="Delete" onclick="LinkButton3_Click"></asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle Width="20%" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                                
            
             <center> <asp:LinkButton ID="lbtn_AddTemplate" runat="server" 
                    onclick="lbtn_AddTemplate_Click">Add New Analysis</asp:LinkButton></center>
           
                            </asp:View>
                              <asp:View ID="View1" runat="server">
                  <table width="80%" align="center">
                  <tr align="center">
                  <td>
                  <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch">
                  <table align="center" width="60%">
                                <tr>
                                    <td width="30%">
                                        Enter New Analysis:
                                    </td>
                                    <td width="20%" align="left">
                                        <asp:TextBox ID="txtEmpIdName" runat="server" CssClass="TextBox1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmpIdName"
                                            Display="Dynamic" ErrorMessage="Please Enter the Analysis" ValidationGroup="search"
                                            SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td width="10%">
                                        <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Add"
                                            ValidationGroup="search" CssClass="Button" />
                                    </td>
                                </tr>
                                </table>
                                </asp:Panel>
                  </td>
                  </tr>
                                                <tr>
                                                    <td align="center">
                                                        
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
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
            <td align="center">
                
            </td>
        </tr>        
        <tr>
            <td align="center">
               
                  
               
                
                </td>
        </tr>        
        <tr>
            <td>
                <center>
                </center>
            </td>
        </tr>        
    </table>
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


