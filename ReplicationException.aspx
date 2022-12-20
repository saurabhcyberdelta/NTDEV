<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="ReplicationException.aspx.cs" Inherits="ReplicationException" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <table align="center" width="100%" cellpadding="4" cellspacing="2">
                <tr>
                    <td align="center">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="order" />
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="heading">
                        <div class="gradient2">
                            <h1>
                                <span></span>Exceptions for Replicated Routes
                            </h1>
                            <h2>
                                Allows to Delete/Make a New Route for Employees in Replicated Routes.
                            </h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                            DisplayAfter="0" DynamicLayout="False">
                            <ProgressTemplate>
                                <table align="center">
                                    <tr>
                                        <td>
                                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loading" />
                                        </td>
                                        <td class="main_bg" align="left">
                                            Loading.....Please Wait!!!
                                        </td>
                                    </tr>
                                </table>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                        <table border="0" cellpadding="5" cellspacing="0" align="center" width="100%" class="tableBorber">
                            <tr>
                                <td align="center" class="TDbg" colspan="5">
                                    Fill the Selection Creiteria
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="middle" width="25%">
                                    Date:
                                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="TextBox"></asp:TextBox>
                                    <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" Enabled="True"
                                        TargetControlID="txtStartDate" PopupButtonID="ImgBtnCalendar">
                                    </cc1:CalendarExtender>
                                    <asp:ImageButton ID="ImgBtnCalendar" runat="server" ImageUrl="Images/calendar_icon.gif"
                                        Height="17px" Width="17px" /><br />
                                    <i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(mm/dd/yyyy)</i> &nbsp;<asp:RequiredFieldValidator
                                        ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtStartDate"
                                        Display="Dynamic" ErrorMessage="Start Date Required" ValidationGroup="order"
                                        SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtStartDate"
                                        Display="Dynamic" ErrorMessage="Date Format:mm/dd/yyyy" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                        ValidationGroup="order" SetFocusOnError="True">*</asp:RegularExpressionValidator>&nbsp;&nbsp;<br />
                                    <asp:CompareValidator ID="CompareValidator3" ControlToValidate="txtStartDate" Operator="GreaterThanEqual"
                                        Type="Date" runat="server" ErrorMessage="Date must be greater than equal to current date"
                                        ValidationGroup="order" Display="Dynamic">*</asp:CompareValidator>
                                </td>
                                <td align="center" valign="middle" width="25%" style="border: 1px solid #000000;">
                                    Facility Name:
                                    <asp:DropDownList ID="ddlfacility" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                        OnSelectedIndexChanged="ddlfacility_SelectedIndexChanged" CssClass="DropDownListBox3">
                                        <asp:ListItem Selected="True" Value="0">Select Facility</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlfacility"
                                        ErrorMessage="Select Facility" Operator="NotEqual" ValueToCompare="0" ValidationGroup="order"
                                        SetFocusOnError="True">*</asp:CompareValidator>
                                </td>
                                <td align="center" valign="middle" width="15%" style="border: 1px solid #000000;">
                                    <asp:RadioButtonList ID="rdbtnlstType" runat="server" AutoPostBack="True" RepeatDirection="Horizontal"
                                        OnSelectedIndexChanged="rdbtnlstType_SelectedIndexChanged">
                                        <asp:ListItem Selected="True" Value="P">Pick</asp:ListItem>
                                        <asp:ListItem Value="D">Drop</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td align="center" valign="middle" width="15%" style="border: 1px solid #000000;">
                                    Shift:
                                    <asp:ListBox ID="lstShift" runat="server" AppendDataBoundItems="True" Rows="1">
                                        <asp:ListItem Selected="True" Value="0">-Select-</asp:ListItem>
                                    </asp:ListBox>
                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="lstShift"
                                        Display="Dynamic" ErrorMessage="Select ShiftTime" Operator="NotEqual" ValidationGroup="order"
                                        ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                                </td>
                                <td align="center" valign="middle" width="15%" style="border: 1px solid #000000;">
                                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit"
                                        ValidationGroup="order" CssClass="Button" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <asp:MultiView ID="MultiView1" runat="server">
                <asp:View ID="View1" runat="server">
                    <table align="center" width="100%">
                        <tr>
                            <td align="center">
                                &nbsp;<asp:Label ID="lblDelData" runat="server" Font-Bold="True" Text="Employee List For Deletion in Routes"
                                    Visible="False"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:GridView ID="gvDeleteData" runat="server" AllowPaging="True" AllowSorting="True"
                                    AutoGenerateColumns="False" Width="99%" CellPadding="0" EmptyDataText="No Record Found!"
                                    DataKeyNames="EmpId" OnPageIndexChanging="gvDeleteData_PageIndexChanging" ShowFooter="True"
                                    PageSize="20" BorderWidth="0">
                                    <Columns>
                                        <asp:BoundField DataField="RouteID" HeaderText="Route ID">
                                            <ItemStyle Width="10%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="empCode" HeaderText="Employee ID">
                                            <ItemStyle Width="12%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="EmpName" HeaderText="Employee Name">
                                            <ItemStyle Width="10%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ProcessName" HeaderText="Department">
                                            <ItemStyle Width="10%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="mobile" HeaderText="Mobile">
                                            <ItemStyle Width="10%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="stopNo" HeaderText="StopNo">
                                            <ItemStyle Width="5%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="address" HeaderText="Location">
                                            <ItemStyle Width="30%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Reason" HeaderText="Reason">
                                            <ItemStyle Width="10%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Track">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkTrack" runat="server" />
                                            </ItemTemplate>
                                            <ItemStyle Width="3%"></ItemStyle>
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="chkBxHeader" AutoPostBack="true" OnCheckedChanged="CheckAll" runat="server" />
                                            </HeaderTemplate>
                                            <FooterTemplate>
                                                &nbsp;<asp:ImageButton ID="ibDeleteData" runat="server" ImageUrl="~/images/remove.png"
                                                    OnClick="ibDelete_Click" ToolTip="Delete Selected" />
                                                <cc1:ConfirmButtonExtender ID="ConfirmButton_ibDelete" TargetControlID="ibDeleteData"
                                                    runat="server" ConfirmOnFormSubmit="False" ConfirmText="Are you sure you want to delete the selected employee?">
                                                </cc1:ConfirmButtonExtender>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle CssClass="RowStyle" />
                                    <FooterStyle CssClass="FooterStyle" />
                                    <PagerStyle CssClass="PagerStyle" />
                                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                                    <HeaderStyle CssClass="HeaderStyle" />
                                    <EditRowStyle BackColor="#999999" />
                                    <AlternatingRowStyle CssClass="AltRowStyle" />
                                    <EmptyDataRowStyle ForeColor="Red" Font-Bold="true" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Label ID="lblAddData" runat="server" Font-Bold="True" Text="Employee List For Addition in Routes"
                                    Visible="False"></asp:Label>
                                <br />
                                <asp:Label ID="lblmsg" runat="server" Font-Bold="True" ForeColor="Red" Visible="False"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:GridView ID="gvAddData" runat="server" AllowPaging="True" AllowSorting="True"
                                    AutoGenerateColumns="False" Width="99%" CellPadding="0" EmptyDataText="No Record Found!"
                                    DataKeyNames="Id" OnPageIndexChanging="gvAddData_PageIndexChanging" ShowFooter="True"
                                    PageSize="20" BorderWidth="0">
                                    <Columns>
                                        <asp:BoundField DataField="empCode" HeaderText="Employee ID">
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="EmpName" HeaderText="Employee Name">
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ProcessName" HeaderText="Department">
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="mobile" HeaderText="Mobile">
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Location" HeaderText="Location">
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Shift">
                                        <ItemTemplate>
                                        <asp:Label ID="lblgridShift" runat="server" Text='<%#Eval("shift") %>'></asp:Label>
                                        </ItemTemplate>
                                          <FooterTemplate>
                                                &nbsp;<asp:ImageButton ID="ibaligndata" runat="server" ImageUrl="~/images/link.png"
                                                     ToolTip="Align to the routes" Height="26px" Width="27px" 
                                                    onclick="ibaligndata_Click"   />
                                                </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Track">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkTrack" runat="server" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="chkBxHeader" AutoPostBack="true" OnCheckedChanged="CheckAllAdd"
                                                    runat="server" />
                                            </HeaderTemplate>
                                            <FooterTemplate>
                                                &nbsp;<asp:ImageButton ID="ibAddData" runat="server" ImageUrl="~/images/MakeNewRoute.png"
                                                    OnClick="ibAddData_Click" ToolTip="Make A New route" />
                                                <cc1:ConfirmButtonExtender ID="ConfirmButton_ibAdd" TargetControlID="ibAddData" runat="server"
                                                    ConfirmOnFormSubmit="True" ConfirmText="Are you sure you want to make a new route for selected employee?">
                                                </cc1:ConfirmButtonExtender>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle CssClass="RowStyle" />
                                    <FooterStyle CssClass="FooterStyle" />
                                    <PagerStyle CssClass="PagerStyle" />
                                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                                    <HeaderStyle CssClass="HeaderStyle" />
                                    <EditRowStyle BackColor="#999999" />
                                    <AlternatingRowStyle CssClass="AltRowStyle" />
                                    <EmptyDataRowStyle ForeColor="Red" Font-Bold="true" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </asp:View>
            </asp:MultiView>
            <asp:MultiView ID="MultiView2" runat="server">
                <asp:View ID="View2" runat="server">
                <center>
                  <asp:Panel ID="Panel1" runat="server"  ScrollBars="vertical" Height="80%"  Width="100%" >
             <table>
            <tr>
            <td align="right" bgcolor="blue">
                <asp:ImageButton ID="btnClose" runat="server"   
                    ImageUrl ="~/images/no_icon.jpg" onclick="btnClose_Click"  /></td>
            </tr>
            <tr align="center">
            <td align="center">
             <asp:Label ID="lblAssignEmpID" runat="server" Text="" Visible="false"></asp:Label>
               
                <asp:GridView ID="grdRoutes" Width="100%" runat="server" AutoGenerateColumns="false" CssClass="GridView">
                <Columns>
                <asp:TemplateField HeaderText="RouteID">
                <ItemTemplate>
                <asp:Label ID="lblRouteID" runat="server" Text='<%#Eval("RouteID") %>'></asp:Label>
                </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Shift Time">
                <ItemTemplate>
                <asp:Label ID="lblShiftTime" runat="server" Text='<%#Eval("ShiftTime") %>'></asp:Label>
                </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Location">
                <ItemTemplate>
                <asp:Label ID="lblAddress" runat="server" Text='<%#Eval("Location") %>'></asp:Label>
                </ItemTemplate>
                </asp:TemplateField>
               <asp:BoundField DataField="vehicleid" HeaderText="CabID" />
                <asp:TemplateField HeaderText="Total Stop">
                <ItemTemplate>
                <asp:Label ID="lblTotalStop" runat="server" Text='<%#Eval("totalstop") %>'></asp:Label>
                </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                <asp:LinkButton ID="lbRouteAssign" Text="Assign" runat="server" 
                        onclick="lbRouteAssign_Click"></asp:LinkButton>
                </ItemTemplate>
                </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="RowStyle" />
                <FooterStyle CssClass="FooterStyle" />
                <PagerStyle CssClass="PagerStyle" />
                <SelectedRowStyle CssClass="SelectedRowStyle" />
                <HeaderStyle CssClass="HeaderStyle1" />
                <EditRowStyle BackColor="#999999" />
                <AlternatingRowStyle CssClass="AltRowStyle" />
            
                </asp:GridView>
                </td>
                </tr>
                </table>
            </asp:Panel>
            </center>
             <asp:Button ID="Button2" runat="server" Style="visibility: hidden" />
                       
                                       <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" Enabled="True"  BackgroundCssClass="modalBackground"
                            TargetControlID="Button2" PopupControlID="Panel1" 
                            DropShadow="false">
                        </cc1:ModalPopupExtender>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
