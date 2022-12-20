<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DisplayBoard.aspx.cs" Inherits="DisplayBoard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    
    
    <title>Untitled Page</title>
    <style type="text/css">
        .style1
        {
            color: #FFFFFF;
            font-weight: bold;
            font-size: medium;
        }
    </style>
</head>
<body bgcolor="#93CDDD" background="images/background-pattern-015.jpg">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:Timer ID="UpdateGrid" runat="server" Interval="2000" OnTick="MoveNext_Tick">
    </asp:Timer>
    <div>
        <table align="center" width="80%">
        <tr bgcolor="#003399">
                <td align="left" class="style1">
                    North Delhi
                </td>
                <td align="right" class="style1">
                    Shift:1800 Hours
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="UpdateGrid" EventName="Tick" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:GridView ID="grdViewRouteParent" runat="server" AutoGenerateColumns="False"
                                DataKeyNames="RouteID" EmptyDataText="No record found"  
                                AllowPaging="True" PageSize="4" Height="400px" Font-Size="Large" 
                                Width="100%" ShowHeader="False">
                                <Columns>
                                     <asp:TemplateField HeaderText="RouteID">
                                    <ItemTemplate>
                                        RouteID:
                                        <%# Eval("RouteID") %>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="True" Font-Size="Medium" ForeColor="White" Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Vendor">
                                    <ItemTemplate>
                                        Vendor:
                                        <%# Eval("vendorName") %>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="True" Font-Size="Medium" ForeColor="White" Width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Vehicle">
                                    <ItemTemplate>
                                        VehicleNo:
                                        <%# Eval("vehicleNo") %>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="True" Font-Size="Medium" ForeColor="White" Width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        Status:
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="True" Font-Size="Medium" ForeColor="White" Width="5%" />
                                </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" ItemStyle-Width=".5%">
                                        <ItemTemplate>
                                            <tr valign="top">
                                                <td colspan="5" align="center">
                                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                        <ContentTemplate>
                                                            <asp:GridView ID="grdViewRouteChild" runat="server" AutoGenerateColumns="False"
                                                                Width="60%" DataKeyNames="routeid,id,shiftdate"
                                                                CellPadding="2" ShowHeader="False">
                                                                <Columns>
                                                                    <asp:BoundField HeaderText="PartnerID" DataField="empCode">
                                                                        <ItemStyle Font-Size="Large" Width="1%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField HeaderText="Partner Name" DataField="empName" >
                                                                    <ItemStyle Font-Size="Large" Width="10%" />
                                                                    </asp:BoundField>
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
                                <RowStyle  BackColor="#31859C" />
                                <PagerStyle CssClass="PagerStyle" />
                                <HeaderStyle CssClass="HeaderStyle" />
                                <AlternatingRowStyle BackColor="#31859C"/>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
