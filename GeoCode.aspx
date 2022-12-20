<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="GeoCode.aspx.cs" Inherits="GeoCode" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style2
        {
            width: 43%;
        }
        .style3
        {
            width: 90%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" width="100%">
        <tr>
            <td align="center">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <table align="center" border="0" style="width: 98%">
                            <tr>
                                <td>
                                    <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                        ShowSummary="False" ValidationGroup="search" />
                                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                                        ShowSummary="False" ValidationGroup="geo" />
                                    <asp:ValidationSummary ID="ValidationSummary3" runat="server" ShowMessageBox="true"
                                        ShowSummary="false" ValidationGroup="set" />
                                         <asp:ValidationSummary ID="ValidationSummary4" runat="server" ShowMessageBox="true"
                                        ShowSummary="false" ValidationGroup="insertcolony" />
                                </td>
                            </tr>
                            <tr>
                                <td class="heading">
                                    <div class="gradient2">
                                        <h1>
                                            <span></span>Geo Code Partner Data</h1>
                                        <h2>
                                            Geo Code Partner information by defining the X-Y co-ordinates.</h2>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <table align="left" width="50%" cellpadding="4" cellspacing="0">
                                        <tr>
                                            <td align="center" colspan="2">
                                                <asp:GridView ID="GvEmpCount" runat="server" AutoGenerateColumns="False" Width="100%"
                                                    BorderWidth="0" ShowFooter="True" AllowPaging="False">
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lbtnFac" runat="server" CommandArgument='<%# Eval("Id") %>' CommandName="Select"
                                                                    Text='<%# "Total No of Partners Not Geo Coded in " + Eval("facilityName")+ " :" %>'
                                                                    CausesValidation="False" OnClick="lbtnFac_Click" CssClass="linkButton"></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="left" Width="80%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblEmpCount" runat="server" Text='<%# Eval("Count") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Right" Width="20%" />
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
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch" >
                                        <table align="left">
                                         
                                    
                                            <tr>
                                                <td width="33%">
                                                    Enter Partner ID or Name:
                                                </td>
                                                <td width="33%">
                                                    <asp:TextBox ID="txtEmpIdName" runat="server" MaxLength="30" CssClass="TextBox1"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmpIdName"
                                                        Display="Dynamic" ErrorMessage="Please Enter Name or Id" ValidationGroup="search"
                                                        SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                </td>
                                                <td width="33%">
                                                    <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search"
                                                        ValidationGroup="search" CssClass="Button" />
                                                </td>
                                            </tr>
                                     </table>
                                     </asp:Panel>
                                        <asp:Panel ID="Panel3" runat="server" DefaultButton="btnSearchaddr">
                                            <table>
                                            <tr>
                                                <td width="33%" align="right">
                                                    <asp:Label ID="lblSearchaddr" runat="server" Text="Search the location:" Visible="false"></asp:Label>
                                                </td>
                                                <td width="33%">
                                                    <asp:TextBox ID="txtSearchaddr" runat="server" CssClass="TextBox1" Visible="false"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSearchaddr"
                                                        Display="Dynamic" ErrorMessage="Please Enter The Address" ValidationGroup="set"
                                                        SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                </td>
                                                <td width="33%">
                                                    <asp:Button ID="btnSearchaddr" runat="server" Text="Search" CssClass="Button" Visible="false"
                                                        OnClick="btnSearchaddr_Click" ValidationGroup="set" />
                                                </td>
                                            </tr>
                                            </table>
                                            </asp:panel>
                                           <table width="66%" align="center">
                                            <tr>
                                                <td width="66%">
                                                    <asp:Label ID="lblMsg" runat="server" CssClass="error"></asp:Label>
                                                </td>
                                                </tr>
                                                <tr>
                                                <td width="100%" align="left" >
                                                  <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                                        DisplayAfter="0" DynamicLayout="false">
                                        <ProgressTemplate>
                                            <table align="center">
                                                <tr>
                                                    <td align="center">
                                                        <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" />
                                                    </td>
                                                    <td valign="top">
                                                      Loading.....Please Wait!!!&nbsp;
                                                       
                                                    </td>
                                                </tr>
                                            </table>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <asp:MultiView ID="MultiView1" runat="server">
                                        <asp:View ID="View1" runat="server">
                                            <table width="90%" align="left" border="0">
                                                <tr>
                                                    <td align="left">
                                                        <asp:GridView ID="GvEmployee" runat="server" AutoGenerateColumns="False" DataKeyNames="Id,empName"
                                                            OnPageIndexChanging="GvEmployee_PageIndexChanging" OnSelectedIndexChanging="GvEmployee_SelectedIndexChanging"
                                                            AllowPaging="True" Width="70%" BorderWidth="0" ShowFooter="True">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Partner Id">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lbSelectEmp" runat="server" Text='<%# Eval("empCode") %>' CommandArgument='<%# Eval("ID") %>'
                                                                            CommandName="Select" CssClass="linkButton" OnClick="lbSelectEmp_Click"></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="">
                                                                    <ItemTemplate>
                                                                        <img id="imgGeoCode" src='<%# CheckImage(DataBinder.Eval(Container.DataItem, "geoCode")) %>'
                                                                            alt='<%# CheckAlt(DataBinder.Eval(Container.DataItem, "geoCode")) %>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Partner Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblEmpName" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Process">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblEmpProcess" runat="server" Text='<%# Eval("processName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Facility">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblEmpFacility" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="E-mail">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblEmpEmail" runat="server" Text='<%# Eval("email") %>'></asp:Label>
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
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                        <asp:View ID="View2" runat="server" EnableTheming="False">
                                            <table align="left" class="style3">
                                                <tr>
                                                    <td align="left" valign="top" width="30%">
                                                        <asp:DetailsView ID="DvGeo" runat="server" AutoGenerateRows="False" DefaultMode="Insert"
                                                            HeaderText="Edit Geo-Code Details" OnItemInserting="DvGeo_ItemInserting" OnModeChanging="DvGeo_ModeChanging"
                                                            Width="400px" BorderWidth="0px">
                                                            <RowStyle CssClass="DetailsViewRowStyle" />
                                                            <FooterStyle CssClass="DetailsViewFooterStyle" />
                                                            <PagerStyle CssClass="DetailsViewPagerStyle" />
                                                            <HeaderStyle CssClass="DetailsViewHeaderStyle" />
                                                            <AlternatingRowStyle CssClass="DetailsViewAltRowStyle" />
                                                            <Fields>
                                                                <asp:TemplateField HeaderText="Address:">
                                                                    <InsertItemTemplate>
                                                                        <asp:Label ID="lbldvAddress" runat="server" TextMode="MultiLine" Width="300px"></asp:Label>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="City:">
                                                                    <InsertItemTemplate>
                                                                        <asp:DropDownList ID="ddldvCity" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                            CssClass="DropDownListBox3" OnSelectedIndexChanged="ddldvCity_SelectedIndexChanged">
                                                                        </asp:DropDownList>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Colony:">
                                                                    <InsertItemTemplate>
                                                                        <asp:DropDownList ID="ddldvColony" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                            CssClass="DropDownListBox3" OnSelectedIndexChanged="ddldvColony_SelectedIndexChanged">
                                                                        </asp:DropDownList>
                                                                        <asp:LinkButton ID="lbtncolony" runat="server" Visible="false" 
                                                                            onclick="lbtncolony_Click">Add New</asp:LinkButton>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Block/Sectors:">
                                                                    <InsertItemTemplate>
                                                                        <asp:DropDownList ID="ddldvSubColony" runat="server" AppendDataBoundItems="True"
                                                                            AutoPostBack="True" OnSelectedIndexChanged="ddldvSubColony_SelectedIndexChanged"
                                                                            CssClass="DropDownListBox3">
                                                                        </asp:DropDownList>
                                                                        <asp:LinkButton ID="lbtnSubcolony" runat="server" Visible="false" 
                                                                            onclick="lbtnSubcolony_Click">Add New</asp:LinkButton>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Landmark:">
                                                                    <InsertItemTemplate>
                                                                        <asp:DropDownList ID="ddldvLandmark" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                            CssClass="DropDownListBox3" OnSelectedIndexChanged="ddldvLandmark_SelectedIndexChanged">
                                                                        </asp:DropDownList>
                                                                        <asp:LinkButton ID="lbtnLandmark" runat="server" Visible="false" 
                                                                            onclick="lbtnLandmark_Click">Add New</asp:LinkButton>
                                                                        <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="ddldvLandmark"
                                                                            Display="Dynamic" ErrorMessage="Select Landmark" Operator="NotEqual" ValidationGroup="geo"
                                                                            ValueToCompare="0">*</asp:CompareValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="X-Cord:">
                                                                    <InsertItemTemplate>
                                                                        <asp:Label ID="lblX" runat="server"></asp:Label>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Y-Cord:">
                                                                    <InsertItemTemplate>
                                                                        <asp:Label ID="lblY" runat="server"></asp:Label>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:CommandField CancelText="Close" InsertText="Save" ShowInsertButton="True" ValidationGroup="geo" />
                                                            </Fields>
                                                        </asp:DetailsView>
                                                    </td>
                                                    <td align="left" valign="top" class="style2">
                                                        <asp:GridView ID="gdsearchgecode" runat="server" AutoGenerateColumns="false" EmptyDataText="No  Search Record Found"
                                                            BorderWidth="0" Width="100%" ShowFooter="True">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Colony">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblcolonySearch" runat="server" Text='<%#Eval("colony") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Block/Sectors">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblblockSearch" runat="server" Text='<%#Eval("SubColony") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Landmark">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbllandmarkSearch" runat="server" Text='<%#Eval("landmark") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="City">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblcitySearch" runat="server" Text='<%#Eval("city") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Assign">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lbassign" runat="server" OnClick="lbassign_Click">Assign</asp:LinkButton>
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
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                    </asp:MultiView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:MultiView ID="MultiView2" runat="server">
                                        <asp:View ID="View3" runat="server">
                                          <asp:Button ID="Button1" runat="server" Text="Show Modal" Style="visibility: hidden" />
                                            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modal-bg"
                                                TargetControlID="Button1" PopupControlID="pnlModal" >
                                            </ajaxToolkit:ModalPopupExtender>
                                            <asp:Panel ID="pnlModal" runat="server">
                                            
                                          <asp:DetailsView ID="DvInsertColony" runat="server" AutoGenerateRows="False" DefaultMode="Insert"
                                                            HeaderText="Add Colony" 
                                                            Width="400px" BorderWidth="0px" 
                                                oniteminserting="DvInsertColony_ItemInserting" 
                                                    onmodechanging="DvInsertColony_ModeChanging">
                                                            <RowStyle CssClass="DetailsViewRowStyle" />
                                                            <FooterStyle CssClass="DetailsViewFooterStyle" />
                                                            <PagerStyle CssClass="DetailsViewPagerStyle" />
                                                            <HeaderStyle CssClass="DetailsViewHeaderStyle" />
                                                            <AlternatingRowStyle CssClass="DetailsViewAltRowStyle" />
                                                            <Fields>
                                                               
                                                                <asp:TemplateField HeaderText="Colony:">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtColony" runat="server"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator69" runat="server" 
                                                                        ErrorMessage="Enter Colony" ControlToValidate="txtColony" ValidationGroup="insertcolony"></asp:RequiredFieldValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Block/Sectors:">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtSubColony" runat="server"></asp:TextBox>
                                                                          <asp:RequiredFieldValidator ID="RequiredFieldValidator68" runat="server" 
                                                                        ErrorMessage="Enter SubColony" ControlToValidate="txtSubColony" ValidationGroup="insertcolony"></asp:RequiredFieldValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Landmark:">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtLandmark" runat="server"></asp:TextBox>
                                                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator67" runat="server" 
                                                                        ErrorMessage="Enter Landmark" ControlToValidate="txtLandmark" ValidationGroup="insertcolony"></asp:RequiredFieldValidator>
                                                                  
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="X-Cord:">
                                                                    <InsertItemTemplate>
                                                                       <asp:TextBox ID="txtGeoX" runat="server"></asp:TextBox>
                                                                        
                                                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator70" runat="server" 
                                                                        ErrorMessage="Enter X-Cord" ControlToValidate="txtGeoX" ValidationGroup="insertcolony"></asp:RequiredFieldValidator>
                                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                                                        ControlToValidate="txtGeoX"  ValidationGroup="insertcolony" ErrorMessage="Enter valid X-Cord" Text="*" ValidationExpression="[-]?[0-9][0-9][.]{0,1}[0-9]{0,4}">
                                                                        </asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Y-Cord:">
                                                                    <InsertItemTemplate>
                                                                        <asp:TextBox ID="txtGeoY" runat="server"></asp:TextBox>
                                                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator71" runat="server" 
                                                                        ErrorMessage="Enter Y-Cord" ControlToValidate="txtGeoY" ValidationGroup="insertcolony"></asp:RequiredFieldValidator>
                                                                   <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server"
                                                                        ControlToValidate="txtGeoY"  ValidationGroup="insertcolony" ErrorMessage="Enter Valid Y-Cord" Text="*"  ValidationExpression="[-]?[0-9][0-9][.]{0,1}[0-9]{0,4}">
                                                                        </asp:RegularExpressionValidator>
                                                                    </InsertItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Right" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:TemplateField>
                                                                <asp:CommandField CancelText="Close" InsertText="Save" ShowInsertButton="True" ValidationGroup="insertcolony" />
                                                            </Fields>
                                                        </asp:DetailsView>
                                           </asp:Panel>
                                        </asp:View>
                                    </asp:MultiView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                   
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
</asp:Content>
