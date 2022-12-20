<%@ Page Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="RouteEditing.aspx.cs" Inherits="RouteEditing" Title="eTMS:Route Editing" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
        <ContentTemplate>
            <table align="center" border="0" width="100%">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="Submit" Height="16px" />
                <tr align="center">
                    <td class="heading" colspan="3">
                        <div class="gradient2">
                            <h1>
                                <span></span>Route Editing Window for Transport
                            </h1>
                            <h2>
                                Allows User to Edit/Delete/Add/Insert Route Information.
                            </h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="3">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
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
                                        <td align="left" valign="top" width="15%">
                                            <b>Shift:</b>
                                        </td>
                                        <td align="left" rowspan="2" valign="middle" width="15%">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" ValidationGroup="Submit"
                                                OnClick="btnSubmit_Click" CssClass="Button" />
                                        </td>
                                        <td align="left" rowspan="2" valign="middle" width="25%">
                                            <asp:DetailsView ID="DvViewStatistics" runat="server" AutoGenerateRows="False" Height="30px"
                                                Visible="False" Width="200px">
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
                                            <asp:ListBox ID="lstShift" runat="server" AppendDataBoundItems="True">
                                                <asp:ListItem Selected="True" Value="0"></asp:ListItem>
                                            </asp:ListBox>
                                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="lstShift"
                                                ErrorMessage="Select Shift Time" Operator="NotEqual" ValidationGroup="Submit"
                                                ValueToCompare="0">*</asp:CompareValidator>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <asp:Button ID="btnFinalize" runat="server" Text="Finalize Route" Visible="False"
                            OnClick="btnFinalize_Click" CssClass="Button" />
                        <cc1:ConfirmButtonExtender ID="ConfirmButton_btnSave" TargetControlID="btnFinalize"
                            runat="server" ConfirmOnFormSubmit="False">
                        </cc1:ConfirmButtonExtender>
                    </td>
                    <td align="right" width="80%">
                        &nbsp;
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel4"
                            DisplayAfter="0">
                            <ProgressTemplate>
                                <table align="center" style="width: 400px">
                                    <tr>
                                        <td colspan="4" style="width: 200px">
                                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loding..." />
                                        </td>
                                        <td class="main_bg" style="width: 200px" align="left">
                                            Loading.....Please Wait!!!
                                        </td>
                                    </tr>
                                </table>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                    <td align="right" width="20%">
                        <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                            <ContentTemplate>
                                <asp:HyperLink ID="lbtnPrintHtml" runat="server" Visible="False" Target="new" CssClass="linkButton">Print Tripsheet</asp:HyperLink>
                                <br />
                                <asp:HyperLink ID="lbtnPrintExcel" runat="server" Visible="False" Target="new" CssClass="linkButton">Export to Excel</asp:HyperLink>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="3">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="grdViewRouteParent" runat="server" AutoGenerateColumns="False"
                                    DataKeyNames="RouteID" EmptyDataText="No record found" ShowFooter="True" BorderWidth="0">
                                    <Columns>
                                      <asp:TemplateField  ItemStyle-Width="7%"  >
                                     <ItemTemplate>
                                       <asp:ImageButton ID="imgaddicon" runat="server" ImageUrl="~/images/empaddition.png" visible='<%# Geticon(DataBinder.Eval(Container.DataItem, "addflag")) %>' Enabled="false"  />
                                       <asp:ImageButton ID="imgdeleticon" runat="server" ImageUrl="~/images/icon_delete.gif" visible='<%# Geticon(DataBinder.Eval(Container.DataItem, "deleteflag")) %>' Enabled="false" />
                                     <asp:Image AlternateText="Partner with disability" runat="server" ImageUrl="images/Disabled.gif" Visible='<%# (Eval("IsDisabled")).ToString()=="Y"?true:false %>' />         
                                     </ItemTemplate>
                                     </asp:TemplateField>
                                        <asp:TemplateField HeaderText="RouteID" ItemStyle-Width="25%">
                                            <FooterTemplate>
                                                <asp:LinkButton ID="linkbtMerge" runat="server" OnClick="linkbtMerge_Click">Merge</asp:LinkButton>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                             
                                                <asp:CheckBox ID="chkBxRouteID" runat="server" />
                                                <asp:ImageButton ID="ibViewRouteID" runat="server" ImageUrl="images/plus.gif" OnClick="ibViewRouteID_Click" />
                                                <asp:HyperLink ID="lblRouteID" runat="server" Target="new" CssClass="linkButton"
                                                    Text='<%# Bind("RouteID") %>' 
                                                    NavigateUrl='<%# GetURL(DataBinder.Eval(Container.DataItem, "RouteID")) %>'
                                                    ></asp:HyperLink>
                                            </ItemTemplate>
                                            <ItemStyle Width="10%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="shiftTime" HeaderText="Shift" ReadOnly="True" ItemStyle-Width="5%">
                                            <ItemStyle Width="5%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Location">
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Location") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="25%" />
                                            <FooterTemplate>
                                                <asp:Label ID="lblParentErrorMsg" runat="server"></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ZoneName" HeaderText="ZoneName" ReadOnly="True" ItemStyle-Width="10%">
                                            <ItemStyle Width="10%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="totalStop" HeaderText="Pax" ReadOnly="True" ItemStyle-Width="5%">
                                            <ItemStyle Width="2%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="vendorName" HeaderText="Vendor" ReadOnly="True" ItemStyle-Width="5%">
                                            <ItemStyle Width="5%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="vehicleId" HeaderText="CabID" ReadOnly="True" ItemStyle-Width="5%">
                                            <ItemStyle Width="5%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="ibDeleteRoute" runat="server" ImageUrl="~/images/remove.png"
                                                    ToolTip="Delete Route" CssClass="ImageButton" Enabled='<%# GetAdmin() %>' OnClick="ibDeleteRoute_Click" />
                                                <cc1:ConfirmButtonExtender ID="ibDeleteRoute_ConfirmButtonExtender" runat="server"
                                                    ConfirmText="Are you sure you want to delete this RouteID?" Enabled="True" TargetControlID="ibDeleteRoute">
                                                </cc1:ConfirmButtonExtender>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="1%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="" ItemStyle-Width=".5%">
                                            <ItemTemplate>
                                                <tr>
                                                    <td colspan="8" align="center">
                                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                            <ContentTemplate>
                                                                <asp:GridView ID="grdViewRouteChild" runat="server" CssClass="Childgrid" AutoGenerateColumns="False"
                                                                    Width="90%" Visible="False" ShowFooter="True" DataKeyNames="routeid,id,shiftdate"
                                                                    OnRowDataBound="grdViewRouteChild_RowDataBound" CellPadding="2">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Employee Detail">
                                                                            <FooterTemplate>
                                                                                <%--<asp:ImageButton ID="ImbtSplit" runat="server" BackColor="Black" CausesValidation="false"
                                                                                    Height="20px" ImageAlign="Left" ImageUrl="~/images/Split1.png" ToolTip="Split Route"
                                                                                    Width="20px" OnClick="ImbtSplit_Click" />
                                                                                &nbsp;&nbsp;--%>
                                                                                <asp:ImageButton ID="ImbtInsert" runat="server" ImageUrl="~/images/user_add.png"
                                                                                    ToolTip="Insert Employee" CausesValidation="false" ImageAlign="AbsMiddle" OnClick="ImbtInsert_Click" />
                                                                            </FooterTemplate>
                                                                            <ItemTemplate>
                                                                                  <asp:Label ID="lblnewemp" runat="server"  Text='<%# Eval("isNewAdded") %> ' visible="false" ></asp:Label>
                                                                                <%# Eval("empCode") %>
                                                                                -
                                                                                <%# Eval("EmpName") %>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="20%"></ItemStyle>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="G">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Gender") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="1%"></ItemStyle>
                                                                            <FooterTemplate>
                                                                            </FooterTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="address">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("address") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="45%"></ItemStyle>
                                                                            <FooterTemplate>
                                                                                <asp:Label ID="lblChildErrorMsg" runat="server" Font-Bold="True" Font-Size="Small"
                                                                                    ForeColor="Red"></asp:Label>
                                                                            </FooterTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="tripType" HeaderText="" ItemStyle-Width="1%">
                                                                            <ItemStyle Width="1%" />
                                                                        </asp:BoundField>
                                                                        <asp:TemplateField HeaderText="SNo">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtstopNo" Text='<%# Eval("stopNo")%>' runat="server" Width="15px"
                                                                                    MaxLength="2" TabIndex="1" CssClass="TextBox"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="1%"></ItemStyle>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="ETA" SortExpression="ETA">
                                                                            <ItemTemplate>
                                                                                <div style="width: 50px;">
                                                                                    <asp:TextBox ID="txtETA" runat="server" MaxLength="5" Width="30px" Text='<%# Eval("ETA")%>' CssClass="TextBox" TabIndex="1"></asp:TextBox>
                                                                                    <%--<asp:TextBox ID="txtETAhh" Text='<%# Eval("ETAhh")%>' runat="server" CssClass="TextBox"
                                                                                        Width="15px" MaxLength="2" TabIndex="2"></asp:TextBox>
                                                                                    <asp:TextBox ID="txtETAmm" Text='<%# Eval("ETAmm")%>' runat="server" CssClass="TextBox"
                                                                                        Width="15px" MaxLength="2" TabIndex="2"></asp:TextBox>--%>
                                                                                </div>
                                                                            </ItemTemplate>
                                                                            <FooterTemplate>
                                                                                <asp:ImageButton ID="ibUpdateStopNo" runat="server" ImageUrl="~/images/save.png"
                                                                                    ToolTip="Update Stop No & ETA" CommandName="UpdateStopNo" OnClick="ibUpdateStopNo_Click"
                                                                                    TabIndex="2" />
                                                                            </FooterTemplate>
                                                                            <ItemStyle Width="1%"></ItemStyle>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="">
                                                                            <ItemTemplate>
                                                                                <asp:CheckBox ID="chkBxEmployeeID" runat="server" />
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="2%"></ItemStyle>
                                                                            <FooterTemplate>
                                                                                <asp:ImageButton ID="ImbtAddNewRoute" runat="server" CausesValidation="false" ImageAlign="AbsMiddle"
                                                                                    ImageUrl="~/images/MakeNewRoute.png" ToolTip="Make a New Route" OnClick="ImbtAddNewRoute_Click" />
                                                                            </FooterTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="">
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="ibPasteEmployee" runat="server" ImageUrl="~/images/Move.png"
                                                                                    ToolTip="Move Employee" ValidationGroup="Update" OnClick="ibPasteEmployee_Click" />
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="2%"></ItemStyle>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="">
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="ibDeleteEmployee" runat="server" ImageUrl="~/images/user_remove.png" Enabled='<%# GetAdmin()%>'
                                                                                    ToolTip="Delete Employee" Height="17px" Width="17px" CommandName="Delete" OnClick="ibDeleteEmployee_Click" />
                                                                                <cc1:ConfirmButtonExtender ID="ibDeleteEmployee_ConfirmButtonExtender" runat="server"
                                                                                    ConfirmText="Are you sure you want to delete this Employee?" Enabled="True" TargetControlID="ibDeleteEmployee">
                                                                                </cc1:ConfirmButtonExtender>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="2%"></ItemStyle>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <RowStyle BackColor="#E7E7FF" HorizontalAlign="Left" />
                                                                    <AlternatingRowStyle BackColor="#F7F7F7" BorderColor="Black" HorizontalAlign="Left" />
                                                                    <PagerStyle BackColor="#E7E7FF" HorizontalAlign="Right" />
                                                                    <HeaderStyle CssClass="ChildgridHeaderStyle" />
                                                                    <FooterStyle CssClass="ChildgridFooterStyle" />
                                                                </asp:GridView>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                            <ItemStyle Width="1%"></ItemStyle>
                                        </asp:TemplateField>
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
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="3">
                        <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                            <ContentTemplate>
                                <asp:MultiView ID="MultiView1" runat="server">
                                    <asp:View ID="View1" runat="server">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnHidden" runat="server" Style="display: none" />
                                                    <cc1:ModalPopupExtender ID="ModalPopupExtender" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                                        Drag="True" TargetControlID="btnHidden" CancelControlID="ibtnSMclose" PopupControlID="Panel1">
                                                    </cc1:ModalPopupExtender>
                                                    <asp:Panel ID="Panel1" runat="server" CssClass="modaltable" DefaultButton="btnEmpSearch"
                                                        Width="600px" ScrollBars="Auto">
                                                        <table width="600">
                                                            <tr>
                                                                <td width="95%" bgcolor="#003366" style="color: #FFFFFF" align="center">
                                                                    <b>Allow User to Insert New Employee in the Route.</b>
                                                                </td>
                                                                <td bgcolor="#003366">
                                                                    <asp:ImageButton ID="ibtnSMclose" runat="server" ImageUrl="~/Images/Exit.jpg" OnClick="lbtnClose_Click" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" colspan="2">
                                                                    &nbsp;&nbsp;
                                                                    <asp:Label ID="lblSearch" runat="server" CssClass="error"></asp:Label>
                                                                    <table width="100%" class="tableBorber">
                                                                        <tr>
                                                                            <td style="text-align: right">
                                                                                Stop NO:
                                                                            </td>
                                                                            <td style="text-align: left">
                                                                                <asp:DropDownList ID="ddlStopNO" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                                </asp:DropDownList>
                                                                                <asp:CompareValidator ID="CompareValidator14" runat="server" ControlToValidate="ddlStopNO"
                                                                                    Display="Dynamic" ErrorMessage="Select Stop No" Operator="NotEqual" ValidationGroup="Add"
                                                                                    ValueToCompare="0"></asp:CompareValidator>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="text-align: right" align="right" width="40%">
                                                                                Enter&nbsp; ID or Name:
                                                                            </td>
                                                                            <td style="text-align: left" align="left" width="60%">
                                                                                <asp:TextBox ID="txtEmpIdName" runat="server" ValidationGroup="spoc" CssClass="TextBox1"></asp:TextBox>
                                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEmpIdName"
                                                                                    Display="Dynamic" ErrorMessage="Please Enter Name or Id" ValidationGroup="search"></asp:RequiredFieldValidator>
                                                                                &nbsp;
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="text-align: right">
                                                                                &nbsp;
                                                                            </td>
                                                                            <td style="text-align: left" align="left">
                                                                                <asp:Button ID="btnEmpSearch" runat="server" OnClick="btnEmpSearch_Click" Text="Search"
                                                                                    ValidationGroup="search" CssClass="Button" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:GridView ID="GvEmployee" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                                    DataKeyNames="Id" OnPageIndexChanging="GvEmployee_PageIndexChanging" OnSelectedIndexChanging="GvEmployee_SelectedIndexChanging"
                                                                                    CssClass="GridView" Visible="False" Width="550px">
                                                                                    <Columns>
                                                                                        <asp:TemplateField HeaderText="Employee Id">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblEmpId1" runat="server" Text='<%# Eval("empCode") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Employee Name">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblEmpName1" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Process">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblEmpProcess" runat="server" Text='<%# Eval("processName") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Facility">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblFacility" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField ShowHeader="False">
                                                                                            <ItemTemplate>
                                                                                                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" Text="Add" ValidationGroup="Add"></asp:LinkButton>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                    </Columns>
                                                                                    <RowStyle CssClass="RowStyle" />
                                                                                    <PagerStyle CssClass="PagerStyle" />
                                                                                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                                                    <HeaderStyle CssClass="HeaderStyle" />
                                                                                    <EditRowStyle CssClass="EditRowStyle" />
                                                                                    <AlternatingRowStyle CssClass="AltRowStyle" />
                                                                                    <FooterStyle CssClass="FooterStyle" />
                                                                                </asp:GridView>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:View>
                                </asp:MultiView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
