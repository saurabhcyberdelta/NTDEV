<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="Kmmaster.aspx.cs" Inherits="Kmmaster" %>
<%@ Register Assembly="obout_Grid_NET" Namespace="Obout.Grid" TagPrefix="cc1" %>
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
                        <span></span>Kilometer Master
                    </h1>
                    <h2>
                        Allows to Edit the Kilometer Values.
                    </h2>
                </div>
            </td>
        </tr>
        
        <tr>
            <td align="center" >
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="true" ShowSummary="false" ValidationGroup="Edit"  />
                <asp:DropDownList ID="ddlFacility" runat="server" CssClass="DropDownListBox3" ToolTip="Select Facility"
                    AutoPostBack="True" OnSelectedIndexChanged="ddlFacility_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
         <tr>
                <td align="center">
                     <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="100" AssociatedUpdatePanelID="UpdatePanel1"
                                        DynamicLayout="False">
                                        <ProgressTemplate>
                                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loding..." />
                                            Loading.....Please Wait!!!</ProgressTemplate>
                                    </asp:UpdateProgress></td>
            </tr>
        <tr>
        
        <td>
            <asp:LinkButton ID="LinkButton4" runat="server" CssClass="linkButton" 
                onclick="LinkButton4_Click">Export To Excel</asp:LinkButton>
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
                            <asp:GridView ID="grdkmTemplate" runat="server" AutoGenerateColumns="False" OnRowEditing="grdkmTemplate_RowEditing"
                                OnRowUpdating="grdkmTemplate_RowUpdating" OnRowCancelingEdit="grdkmTemplate_RowCancelingEdit"
                                AllowPaging="True" ShowFooter="True" BorderWidth="0px" 
                                onpageindexchanging="grdkmTemplate_PageIndexChanging" PageSize="10" 
                                DataKeyNames="Id" onrowdeleting="grdkmTemplate_RowDeleting">
                                <RowStyle CssClass="RowStyle" />
                                <FooterStyle CssClass="FooterStyle" />
                                <PagerStyle CssClass="PagerStyle" />
                                <SelectedRowStyle CssClass="SelectedRowStyle" />
                                <HeaderStyle CssClass="HeaderStyle" />
                                <EditRowStyle BackColor="#999999" />
                                <AlternatingRowStyle CssClass="AltRowStyle" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Location">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_Location" runat="server" Text='<%#Eval("Location") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="Txt_Location" runat="server" Text='<%#Eval("Location") %>'
                                                MaxLength="200"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1"  ControlToValidate="Txt_Location"
                                            runat="server"  Text="Enter Location" ErrorMessage="Enter Location" ValidationGroup="Edit" >*</asp:RequiredFieldValidator>   
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                     
                                  
                                    <asp:TemplateField HeaderText="Facility">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_Facility" runat="server" Text='<%#Eval("facilityName") %>'></asp:Label>
                                        </ItemTemplate>
                                      
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Distance">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_Kmdistance" runat="server" Text='<%#Eval("Kmdistance") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="Txt_Kmdistance" runat="server" Text='<%#Eval("Kmdistance") %>'
                                                MaxLength="200"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3"  ControlToValidate="Txt_Kmdistance"
                                            runat="server"  ValidationGroup="Edit" Text="Enter KM" ErrorMessage="Enter KM">*</asp:RequiredFieldValidator> 
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="Txt_Kmdistance" ValidationExpression="^[0-9]*$"
                                              ValidationGroup="Edit" Text="Enter Valid KM" ErrorMessage="Enter Valid KM">*
                                            </asp:RegularExpressionValidator>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField ShowHeader="False">
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="LinkButton1"  ValidationGroup="Edit" runat="server" CausesValidation="True" CommandName="Update"
                                                Text="Update"></asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="Cancel"></asp:LinkButton>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                                                Text="Edit"></asp:LinkButton>
                                                 <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandName="Delete"
                                                Text="Delete"></asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle Width="20%" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                          <center>
                <asp:LinkButton ID="lbtn_AddTemplate" runat="server" 
                    onclick="lbtn_AddTemplate_Click">Add New KM Template</asp:LinkButton></center>
           
                            </asp:View>
                              <asp:View ID="View1" runat="server">
                      <asp:DetailsView ID="dvInsertKM" runat="server" AutoGenerateRows="False" 
                                                                        DefaultMode="Insert" 
                            HeaderText="Insert KM Template"  Width="40%" 
                            oniteminserting="dvInsertKM_ItemInserting" onmodechanging="dvInsertKM_ModeChanging" 
                                                                        >
                                                                        <Fields>
                                                                            <asp:TemplateField HeaderText="Location">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtLocation" runat="server" Text=""
                                                                             MaxLength="200" CssClass="TextBox"></asp:TextBox>
                                                                        
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"  ControlToValidate="txtLocation"
                                                                                    ErrorMessage="Enter the Location" ValidationGroup="add"></asp:RequiredFieldValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                          
                                                                            <asp:TemplateField HeaderText="Facility">
                                                                                <InsertItemTemplate>
                                                                                     <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True"
                                                                            CssClass="DropDownListBox3">
                                                                                         </asp:DropDownList>
                                                                                    <asp:CompareValidator ID="CompareValidatesd" runat="server" ControlToValidate="ddlFacility"
                                                                                   Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="add"
                                                                                   ValueToCompare="0">*</asp:CompareValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                            
                                                                            <asp:TemplateField HeaderText="Km distance">
                                                                                <InsertItemTemplate>
                                                                                    <asp:TextBox ID="txtDistance" runat="server" MaxLength="3" CssClass="TextBox"></asp:TextBox>
                                                                                    <asp:RequiredFieldValidator ID="ReqFieldGeoY" runat="server" ControlToValidate="txtDistance"
                                                                                        Display="Dynamic" ErrorMessage="Enter distance" ValidationGroup="add" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtDistance"
                                                                                        ValidationGroup="add" ErrorMessage="Enter valid km distance" Display="Dynamic"
                                                                                        ValidationExpression="^[0-9]*$" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                                </InsertItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Right" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:TemplateField>
                                                                           
                                                                            <asp:CommandField ShowEditButton="True" ValidationGroup="add" />
                                                                            <asp:CommandField ShowInsertButton="True" ValidationGroup="add" />
                                                                        </Fields>
                                                                        <RowStyle CssClass="DetailsViewRowStyle" />
                                                                        <FooterStyle CssClass="DetailsViewFooterStyle" />
                                                                        <PagerStyle CssClass="DetailsViewPagerStyle" />
                                                                        <HeaderStyle CssClass="DetailsViewHeaderStyle" />
                                                                        <AlternatingRowStyle CssClass="DetailsViewAltRowStyle" />
                                                                    </asp:DetailsView>
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
            <td>
                <center>
                </center>
            </td>
        </tr>        
    </table>
    </ContentTemplate>
    <Triggers>
    <asp:PostBackTrigger ControlID="LinkButton4" />
    </Triggers>
    </asp:UpdatePanel>
</asp:Content>

