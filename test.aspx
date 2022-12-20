<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Test.aspx.cs" Inherits="Test" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    
    
    </head>
<body>
    <form id="form1" runat="server">
    <div>
        <table cellpadding="0" cellspacing="0" width="60%">
            <tr>
                <td>
                    <asp:Panel ID="modal" runat="server" CssClass="modal">
                        <table cellpadding="0" cellspacing="0" width="100%" align="center">
                            <tr>
                                <td class="blueHeaderMiddleLeft" width="1%">
                                    &nbsp;
                                </td>
                                <td class="blueHeaderMiddleCenter" width="100%">
                                    Display Route Information
                                </td>
                                <td class="blueHeaderMiddleCenter1">
                                    <asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/images/Window/CloseOut.gif"
                                        CssClass="ButtonCloseOver" />
                                </td>
                                <td class="blueHeaderMiddleRight" width="1%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <table width="100%" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td class="contentInnerTable">
                                                <asp:Panel ID="Panel1" runat="server">                                                
                                                <table class="tableBorber">
                                                    <tr>
                                                        <td align="left" class="row1" colspan="7">
                                                            PickUp Route Information</td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" class="myTableRowStyle" width="10%">
                                                            <b>RouteID:-</b>
                                                            <asp:Label ID="lblPickRouteID" runat="server" Text='<%# Eval("RouteID")%>'></asp:Label>
                                                        </td>
                                                        <td align="left" class="myTableRowStyle" width="10%">
                                                            <b>Date:-</b>
                                                            <asp:Label ID="lblPickShiftDate" runat="server" Text='<%# Eval("shiftDate")%>'></asp:Label>
                                                        </td>
                                                        <td align="left" class="myTableRowStyle" width="10%">
                                                            <b>Shift Time:-</b>
                                                            <asp:Label ID="lblPickShiftTime" runat="server" Text='<%# Eval("shiftTime")%>'></asp:Label>
                                                        </td>
                                                        <td align="left" class="myTableRowStyle" 
                                                            style="font-weight: bold; font-size: 12px;" width="10%">
                                                            <asp:Label ID="lblPickTripType" runat="server" Text='<%# Eval("tripType")%>'></asp:Label>
                                                        </td>
                                                        <td align="left" class="myTableRowStyle" width="10%">
                                                            <b>Vendor Name:-</b>
                                                            <asp:Label ID="lblPickVendorName" runat="server" 
                                                                Text='<%# Eval("vendorName")%>'></asp:Label>
                                                        </td>
                                                        <td align="left" class="myTableRowStyle" width="10%">
                                                            <b>Cab ID:-</b>
                                                            <asp:Label ID="lblPickStickerNo" runat="server" Text='<%# Eval("stickerNo")%>'></asp:Label>
                                                        </td>
                                                        <td align="left" class="myTableRowStyle" width="10%">
                                                            <b>Facility:-</b>
                                                            <asp:Label ID="lblPickFacility" runat="server" 
                                                                Text='<%# Eval("facilityName")%>'></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7">
                                                            <asp:GridView ID="grdShowPickUpRoute" AutoGenerateColumns="False" runat="server"
                                                                DataKeyNames="routeid,id,shiftdate" ShowFooter="True" Width="100%" BorderWidth="0px">
                                                                <RowStyle CssClass="RowStyle" />
                                                                <FooterStyle CssClass="FooterStyle" />
                                                                <PagerStyle CssClass="PagerStyle" />
                                                                <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                                <HeaderStyle CssClass="HeaderStyle" />
                                                                <EditRowStyle BackColor="#999999" />
                                                                <AlternatingRowStyle CssClass="AltRowStyle" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Employee Detail" SortExpression="empCode">
                                                                        <ItemTemplate>
                                                                            <div style="width: 200px;">
                                                                                <asp:Label ID="lblEmpName" Text='<%# Eval("EmpName") %>' runat="server"></asp:Label>
                                                                            </div>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="G" SortExpression="Gender">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbgender" runat="server" Text='<%# Eval("Gender") %>' Width="20px"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>' Width="400px"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblTripType" runat="server" Text='<%# Eval("tripType") %>' Width="20px"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="SNo" SortExpression="stopNo">
                                                                        <ItemTemplate>
                                                                            <%# Eval("stopNo")%>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ETA" SortExpression="ETA">
                                                                        <ItemTemplate>
                                                                            <%# Eval("ETAhh")%>
                                                                            :
                                                                            <%# Eval("ETAmm")%>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="contentInnerTable">
                                            <asp:Panel ID="Panel2" runat="server">
                                                <table class="tableBorber">
                                                    <tr>
                                                        <td align="left" class="row2" colspan="7">
                                                            Drop Route Information</td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" class="myTableAltRowStyle" width="10%">
                                                            <b>RouteID:-</b>
                                                            <asp:Label ID="lblDropRouteID" runat="server" Text='<%# Eval("RouteID")%>'></asp:Label>
                                                        </td>
                                                        <td align="left" class="myTableAltRowStyle" width="10%">
                                                            <b>Date:-</b>
                                                            <asp:Label ID="lblDropShiftDate" runat="server" Text='<%# Eval("shiftDate")%>'></asp:Label>
                                                        </td>
                                                        <td align="left" class="myTableAltRowStyle" width="10%">
                                                            <b>Shift Time:-</b>
                                                            <asp:Label ID="lblDropShiftTime" runat="server" Text='<%# Eval("shiftTime")%>'></asp:Label>
                                                        </td>
                                                        <td align="left" class="myTableAltRowStyle" 
                                                            style="font-weight: bold; font-size: 12px;" width="10%">
                                                            <asp:Label ID="lblDropTripType" runat="server" Text='<%# Eval("tripType")%>'></asp:Label>
                                                        </td>
                                                        <td align="left" class="myTableAltRowStyle" width="10%">
                                                            <b>Vendor Name:-</b>
                                                            <asp:Label ID="lblDropVendorName" runat="server" 
                                                                Text='<%# Eval("vendorName")%>'></asp:Label>
                                                        </td>
                                                        <td align="left" class="myTableAltRowStyle" width="10%">
                                                            <b>Cab ID:-</b>
                                                            <asp:Label ID="lblDropStickerNo" runat="server" Text='<%# Eval("stickerNo")%>'></asp:Label>
                                                        </td>
                                                        <td align="left" class="myTableAltRowStyle" width="10%">
                                                            <b>Facility:-</b>
                                                            <asp:Label ID="lblDropFacility" runat="server" 
                                                                Text='<%# Eval("facilityName")%>'></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr><td colspan="7">
                                                    <asp:GridView ID="grdShowDropRoute" AutoGenerateColumns="False" runat="server" DataKeyNames="routeid,id,shiftdate"
                                                    ShowFooter="True" CssClass="GridView" Width="100%">
                                                    <RowStyle CssClass="RowStyle" />
                                                    <FooterStyle CssClass="FooterStyle" />
                                                    <PagerStyle CssClass="PagerStyle" />
                                                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                                                    <HeaderStyle CssClass="HeaderStyle" />
                                                    <EditRowStyle BackColor="#999999" />
                                                    <AlternatingRowStyle CssClass="AltRowStyle" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Employee Detail" SortExpression="empCode">
                                                            <ItemTemplate>
                                                                <div style="width: 200px;">
                                                                    <asp:Label ID="lblEmpName" Text='<%# Eval("EmpName") %>' runat="server"></asp:Label>
                                                                </div>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="G" SortExpression="Gender">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbgender" runat="server" Text='<%# Eval("Gender") %>' Width="20px"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>' Width="400px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTripType" runat="server" Text='<%# Eval("tripType") %>' Width="20px"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="SNo" SortExpression="stopNo">
                                                            <ItemTemplate>
                                                                <%# Eval("stopNo")%>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ETA" SortExpression="ETA">
                                                            <ItemTemplate>
                                                                <%# Eval("ETAhh")%>
                                                                :
                                                                <%# Eval("ETAmm")%>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                                    </td></tr>
                                                </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <table width="100%" cellpadding="0" cellspacing="0" class="footerInnserTable">
                                        <tr>
                                            <td class="blueFooterMiddleCenter">
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
    </div>
    </form>
</body>
</html>
