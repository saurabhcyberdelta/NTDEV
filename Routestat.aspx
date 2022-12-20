<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="Routestat.aspx.cs" Inherits="Routestat" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
            <table align="center" border="0" width="100%">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="Submit" Height="16px" />
                <tr align="center">
                    <td class="heading" colspan="2">
                        <div class="gradient2">
                            <h1>
                                <span></span>Route Statistics Window
                            </h1>
                            <h2>
                                Allows User to View the Route Statistics.
                            </h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="subHeading" colspan="2">
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                   
                         
                                <table border="0" cellpadding="4" cellspacing="0" align="left" width="100%" class="tableBorber">
                                    <tr>
                                        <td align="center" class="TDbg" colspan="6">
                                            Fill The Selection Criteria
                                            <asp:Label ID="lblFacError" runat="server" CssClass="error" Text="Select Facility"
                                                Visible="False"></asp:Label>
                                            &nbsp; &nbsp; &nbsp;
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td align="left" valign="top" width="15%">
                                            <b>Shift Date:</b>
                                        </td>
                                        <td align="left" valign="top" width="15%">
                                            <b>Facility Name: </b>
                                        </td>
                                        <td align="left" rowspan="2" valign="middle" width="15%">
                                            <asp:RadioButtonList ID="rdoTripType" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
                                                AutoPostBack="True" OnSelectedIndexChanged="rdoTripType_SelectedIndexChanged">
                                                <asp:ListItem Selected="True" Value="P">Pick</asp:ListItem>
                                                <asp:ListItem Value="D">Drop</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td align="left" valign="top" width="20%">
                                            <b>Shift:</b><br />
                                            
                                        </td>
                                        <td align="left" rowspan="2" valign="middle" width="15%">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" ValidationGroup="Submit"
                                                OnClick="btnSubmit_Click" CssClass="Button" />
                                        </td>
                                        <td align="left" rowspan="2" valign="middle" width="25%">
                                         
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td align="left" valign="top">
                                            <asp:TextBox ID="txtStartDate" runat="server" CssClass="TextBox"></asp:TextBox>
                                            <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" Enabled="true"
                                                TargetControlID="txtStartDate" PopupButtonID="ibcal1">
                                            </cc1:CalendarExtender>
                                            &nbsp;<asp:ImageButton ID="ibcal1" runat="server" ImageUrl="~/images/calendar_icon.gif"
                                                Height="17px" /><br />
                                            <i>(mm/dd/yyyy)</i>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtStartDate"
                                                Display="Dynamic" ErrorMessage="Enter Valid Shift Date" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                ValidationGroup="Submit">*</asp:RegularExpressionValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter Shift Date"
                                                ControlToValidate="txtStartDate" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                                        </td>
                                        <td align="left" valign="top">
                                            <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                OnSelectedIndexChanged="ddlFacility_SelectedIndexChanged" CssClass="DropDownListBox3">
                                            </asp:DropDownList>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                                                Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                                                ValueToCompare="0">*</asp:CompareValidator>
                                        </td>
                                        <td align="left" valign="top">
                                            <asp:ListBox ID="lstShift" runat="server" AppendDataBoundItems="True"  SelectionMode="Multiple">
                                                <asp:ListItem Selected="True" Value="0"></asp:ListItem>
                                            </asp:ListBox>
                                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="lstShift"
                                                ErrorMessage="Select Shift Time" Operator="NotEqual" ValidationGroup="Submit"
                                                ValueToCompare="0">*</asp:CompareValidator>
                                        </td>
                                    </tr>
                                </table>
                            
                    </td>
                </tr>
                <tr align="center">
                    <td align="right" width="80%">
                        &nbsp;
                        
                    </td>
                    <td align="right" width="20%">
                        
                                <asp:HyperLink ID="lbtnPrintHtml" runat="server" Visible="False" Target="new" CssClass="linkButton">Print TripSheet</asp:HyperLink>
                                <br />
                                <asp:HyperLink ID="lbtnPrintExcel" runat="server" Visible="False" Target="new" CssClass="linkButton">Export to Excel</asp:HyperLink>
                                <br />
                                <asp:LinkButton ID="lbtnExportVendorSheet" runat="server" Visible="False" 
                                    CssClass="linkButton" onclick="lbtnExportVendorSheet_Click">Export Vendor Sheet</asp:LinkButton>
                                <br />
                                <asp:LinkButton ID="lbtnDetail" runat="server" Visible="False" 
                                    CssClass="linkButton" onclick="lbtnDetail_Click" >Get Detailed Report</asp:LinkButton><br />
                                    <asp:LinkButton ID="lbtnBoardCopy" runat="server" Visible="False" 
                                    CssClass="linkButton" onclick="lbtnBoardCopy_Click"  >Print Board Copy</asp:LinkButton>
                                    
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                       
                                <asp:DataList ID="DataListVendorCount" runat="server" CellPadding="4" RepeatDirection="Horizontal"
                                    BackColor="White" BorderColor="#336699" BorderStyle="None" BorderWidth="1px"
                                    GridLines="Vertical" ItemStyle-HorizontalAlign="Center" CssClass="DataList" Width="700px">
                                    <FooterStyle CssClass="DataListFooterStyle" />
                                    <AlternatingItemStyle CssClass="DataListAltItemStyle" />
                                    <ItemStyle CssClass="DataListItemStyle" />
                                    <SelectedItemStyle CssClass="DataListSelectedItemStyle" />
                                    <HeaderStyle CssClass="DataListHeaderStyle" />
                                    <HeaderTemplate>
                                        Total Assigned Vendor
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="vendorLabel" runat="server" Text='<%# Eval("vendor") %>' />
                                        <br />
                                        <hr />
                                        <asp:Label ID="AssignedVendorLabel" runat="server" Text='<%# Eval("AssignedVendor") %>' />
                                    </ItemTemplate>
                                </asp:DataList>
                          
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                      
                                  <br />
                                  <asp:DetailsView ID="DvViewStatistics" runat="server" AutoGenerateRows="False" Height="80px"
                                                Visible="False" Width="400px">
                                                <RowStyle CssClass="DetailsViewRowStyle" />
                                                <FooterStyle CssClass="DetailsViewFooterStyle" />
                                                <PagerStyle CssClass="DetailsViewPagerStyle" />
                                                <HeaderStyle CssClass="DetailsViewHeaderStyle" />
                                                <AlternatingRowStyle CssClass="DetailsViewAltRowStyle" />
                                                <Fields>
                                                    <asp:TemplateField HeaderText="Total Routes :">
                                                        <ItemTemplate>
                                                            <%# Eval("TotalRoutes")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Total Employees :">
                                                        <ItemTemplate>
                                                            <%# Eval("TotalEmps")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Total 3-Seater :">
                                                        <ItemTemplate>
                                                            <%# Eval("Count4Seater")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Right" HeaderText="Total 7-Seater :">
                                                        <ItemTemplate>
                                                            <%# Eval("Count8Seater")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                 <asp:TemplateField HeaderStyle-HorizontalAlign="Right" HeaderText="Addition Exception :">
                                                        <ItemTemplate>
                                                            <%# Eval("AdditionException")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                      <asp:TemplateField HeaderStyle-HorizontalAlign="Right" HeaderText="Deletion Exception :">
                                                        <ItemTemplate>
                                                            <%# Eval("DelettionException")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                </Fields>
                                            </asp:DetailsView>
                          
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                     
                                <asp:MultiView ID="MultiView1" runat="server">
                                    <asp:View ID="View1" runat="server">
                                        <table>
                                            <tr>
                                                <td>
                                                   
                                                    <asp:Panel ID="Panel1" runat="server" CssClass="modaltable" 
                                                        Width="600px" ScrollBars="Auto">
                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                                    DataKeyNames="RouteID" EmptyDataText="No record found" CssClass="GridView" Visible="false" ShowFooter="True"
                                   
                                    BorderWidth="0">
                                    <Columns>
                                        <asp:TemplateField HeaderText="RouteID" ItemStyle-Width="10%">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRouteID1" runat="server" Text='<%# Bind("RouteID") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="15%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="shiftTime" HeaderText="Shift" ReadOnly="True" ItemStyle-Width="5%">
                                            <ItemStyle Width="5%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Location">
                                            <ItemTemplate>
                                                <asp:Label ID="Label21" runat="server" Text='<%# Bind("Location") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="45%" />
                                            <FooterTemplate>
                                                <asp:Label ID="lblParentErrorMsg1" runat="server" Font-Bold="True" Font-Size="Small"
                                                    ForeColor="Red"></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ZoneName" HeaderText="Zone Name" />
                                        <asp:TemplateField HeaderText="CabID">
                                            <ItemTemplate>
                                               
                                            </ItemTemplate>
                                            <FooterTemplate>
                                               <%-- <asp:ImageButton ID="ibAssignSticker" runat="server" ImageUrl="~/images/save.png"
                                                    ToolTip="Assign Vendor/StickerNo" ValidationGroup="add" CssClass="ImageButton"
                                                    OnClick="ibAssignSticker_Click" />--%>
                                            </FooterTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Vendor" SortExpression="Vendor">
                                            <ItemTemplate>
                                             </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="totalStop" HeaderText="Total Stop" ReadOnly="True" ItemStyle-Width="5%">
                                            
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle CssClass="RowStyle" />
                                    <PagerStyle CssClass="PagerStyle" />
                                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                                    <HeaderStyle CssClass="HeaderStyle" />
                                    <EditRowStyle CssClass="EditRowStyle" />
                                    <AlternatingRowStyle CssClass="AltRowStyle" />
                                    <FooterStyle CssClass="FooterStyle" />
                                    <EmptyDataRowStyle ForeColor="Red" Font-Bold="true" HorizontalAlign="Left" />
                                </asp:GridView>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:View>
                                </asp:MultiView>
                           
                    </td>
                </tr>
            </table>
        
</asp:Content>


