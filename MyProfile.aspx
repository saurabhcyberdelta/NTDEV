<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="MyProfile.aspx.cs" Inherits="MyProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
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
                                            <span></span>My Profile
                                        </h1>
                                        <h2>
                                              Allows to View/Edit My Profile.
                                        </h2>
                                    </div>
                                </td>
           </tr>
        <tr>
            <td>
                 <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="100" AssociatedUpdatePanelID="UpdatePanel1"
                                        DynamicLayout="False">
                                        <ProgressTemplate>
                                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loding..." />
                                            Loading.....Please Wait!!!</ProgressTemplate>
                                    </asp:UpdateProgress>
            </td>
        </tr>
        <tr>
            <td  align="left">
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 <asp:HyperLink ID="lbChangeAddress" runat="server" Visible="true" CssClass="linkButton" NavigateUrl="~/AddressChange.aspx">Change Address</asp:HyperLink></td>
        </tr>
        <tr>
            <td align="left">
                  <asp:DetailsView ID="DvGeo" runat="server" AutoGenerateRows="False" DefaultMode="Insert"
                                                HeaderText="My Profile"  Width="600px"
                                                DataKeyNames="id" BorderWidth="0px" FooterText="The details changed will be reflected immediately" FooterStyle-HorizontalAlign="Center">
                                                <Fields>
                                                    <asp:TemplateField HeaderText="Partner ID:" HeaderStyle-Width="200px">
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left"/>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldvEmployeeID" runat="server"></asp:Label>
                                                          
                                                            </ItemTemplate></asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Name:">
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldvEmpName" runat="server"></asp:Label>
                                                              <asp:TextBox ID="txtEmpName" runat="server" Visible="false" MaxLength="50"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Name" 
                                                            ControlToValidate="txtEmpName" ValidationGroup="Edit"></asp:RequiredFieldValidator>                                                              
                                                            </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Gender:">
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left"/>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblGender" runat="server"></asp:Label>
                                                            <asp:RadioButton ID="rdbtndvM" runat="server" GroupName="gender" Text="Male" Visible="False" />
                                                            <asp:RadioButton ID="rdbtndvF" runat="server" GroupName="gender" Text="Female" Visible="False" />
                                                            <asp:RadioButton ID="rdbtndvT" runat="server" GroupName="gender" Text="Transgender" Visible="False" />
                                                            <asp:RadioButton ID="rdbtndvO" runat="server" GroupName="gender" Text="Other" Visible="False" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Facility:">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldvfacility" runat="server" Width="80%"></asp:Label>
                                                            <asp:DropDownList ID="ddlFacility" runat="server" Visible="false" AppendDataBoundItems="true" >
                                                            </asp:DropDownList>
                                                             <asp:CompareValidator ID="CompareValidatddlFacilityIn0" runat="server" ControlToValidate="ddlFacility"
                                                              Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Edit"
                                                              ValueToCompare="0" SetFocusOnError="True"></asp:CompareValidator>
                                                            </ItemTemplate><HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Address:">
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldvAddress1" runat="server" Width="300px"></asp:Label><br />
                                                              
                                                  
                                                            </ItemTemplate></asp:TemplateField>
                                                        
                                                    <asp:TemplateField HeaderText="Mobile1:">
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                              <ItemTemplate>
                                                            <asp:Label ID="lblMobile" runat="server"></asp:Label>
                                                             <asp:TextBox ID="txtMobile" runat="server" Visible="false" MaxLength="10"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator28" Display="Dynamic" ControlToValidate="txtMobile" runat="server" ValidationGroup="Edit" ErrorMessage="Enter Mobile No">
                                                        </asp:RequiredFieldValidator> 
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Enter valid Mobile No."
                                                            ControlToValidate="txtMobile" Display="Dynamic"  ValidationExpression="^((\+)?(\d{2}[-]))?(\d{10}){1}?$" ValidationGroup="Edit"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                           
                                                            </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Mobile2:">
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblMobile2" runat="server"></asp:Label>
                                                             <asp:TextBox ID="txtMobile2" runat="server" Visible="false" MaxLength="10"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server" ErrorMessage="Enter valid Mobile No."
                                                            ControlToValidate="txtMobile"  ValidationExpression="^((\+)?(\d{2}[-]))?(\d{10}){1}?$" ValidationGroup="Edit"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                           
                                                            </asp:TemplateField>
                                                            
                                                            
                                                            <asp:TemplateField HeaderText="Email Id:">
                                                                <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                                <ItemStyle HorizontalAlign="Left"/>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblEmail" runat="server"></asp:Label>
                                                                    <asp:TextBox ID="txtEmail" runat="server" Visible="False"></asp:TextBox>
                                                                </ItemTemplate>
                                                    </asp:TemplateField>
                                                            
                                                            
                                                            <asp:TemplateField HeaderText="Transport Required:">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkBxTptReq" runat="server" Enabled="false" />
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                     <asp:TemplateField HeaderText="Business Unit">
                                                        <ItemTemplate>
                                                          <asp:Label ID="lblProcess" runat="server"></asp:Label>
                                                            <asp:DropDownList ID="ddlProcess" runat="server" Visible="False" 
                                                                AppendDataBoundItems="true" AutoPostBack="True" 
                                                                onselectedindexchanged="ddlProcess_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                               <asp:CompareValidator ID="CompareValidatddlFacilityIn14" runat="server" ControlToValidate="ddlProcess"
                                                              Display="Dynamic" ErrorMessage="Select Business Unit" Operator="NotEqual" ValidationGroup="Edit"
                                                              ValueToCompare="0" SetFocusOnError="True"></asp:CompareValidator>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Process">
                                                        <ItemTemplate>
                                                          <asp:Label ID="lblsubProcess" runat="server"></asp:Label>
                                                            <asp:DropDownList ID="ddlsubProcess" runat="server" Visible="false" AppendDataBoundItems="true" AutoPostBack="False">
                                                            </asp:DropDownList>
                                                               <asp:CompareValidator ID="CompareValidatddlFacilityIn124" runat="server" ControlToValidate="ddlsubProcess"
                                                              Display="Dynamic" ErrorMessage="Select Process" Operator="NotEqual" ValidationGroup="Edit"
                                                              ValueToCompare="0" SetFocusOnError="True"></asp:CompareValidator>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Reporting Manager">
                                                        <ItemTemplate>
                                                          <asp:Label ID="lblReportmgr" runat="server"></asp:Label>
                                                             <asp:DropDownList ID="ddlReportingManager" runat="server" Visible="false" AppendDataBoundItems="true" >
                                                            </asp:DropDownList>
                                                              <asp:CompareValidator ID="CompareValidatddlFacilityIn12" runat="server" ControlToValidate="ddlReportingManager"
                                                              Display="Dynamic" ErrorMessage="Select Reporting Manager" Operator="NotEqual" ValidationGroup="Edit"
                                                              ValueToCompare="0" SetFocusOnError="True"></asp:CompareValidator>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Division Manager">
                                                        <ItemTemplate>
                                                          <asp:Label ID="lbldvmgr" runat="server"></asp:Label>
                                                             <asp:DropDownList ID="ddlDvManager" runat="server" Visible="false" AppendDataBoundItems="true" >
                                                            </asp:DropDownList>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Cost Center">
                                                        <ItemTemplate>
                                                          <asp:Label ID="lblCostcenter" runat="server"></asp:Label>
                                                           <asp:DropDownList ID="ddlCostcenter" runat="server" Visible="false" AppendDataBoundItems="true" >
                                                            </asp:DropDownList>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Location:">
                                                        <ItemTemplate>
                                                             <asp:Label ID="lblLocation" runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                     <asp:TemplateField HeaderText="">
                                                        <ItemTemplate>
                                                          <asp:LinkButton ID="lblEditDetails" runat="server" onclick="lblEditDetails_Click" 
                                        >Edit Details</asp:LinkButton>
                                         <asp:LinkButton ID="lbtnSave" runat="server"  Visible="false" CausesValidation="true" 
                                                                ValidationGroup="Edit" onclick="lbtnSave_Click">Save</asp:LinkButton> &nbsp;
                                         <asp:LinkButton ID="lbtnCancel" runat="server" onclick="lbtnCancel_Click" Visible="false">Cancel</asp:LinkButton>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Right" Font-Bold="True" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                       
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
 </ContentTemplate>
 </asp:UpdatePanel> 
</asp:Content>

