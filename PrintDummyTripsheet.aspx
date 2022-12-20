<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintDummyTripsheet.aspx.cs"
    Inherits="PrintDummyTripsheet" ValidateRequest="True" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Print Dummy Tripsheet</title>
    <link href="StyleSheets/TMS.css" rel="stylesheet" type="text/css" />
    
</head>
<body>
    <form id="form1" runat="server">
    <table align="left" cellspacing="0" >
        <tr>
            <td align="center">
                <asp:Label ID="lblErrorMsg" runat="server" CssClass="error"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left">
                <asp:DataList ID="dlShowRoutes" runat="server" Width="700" RepeatDirection="Vertical" >
                    <ItemTemplate>
                        <table border="" width="700" cellpadding="0" cellspacing="0" class="" align="left" style="border: thin solid #666666;
                    page-break-after: always;">
                            <tr>
                                <td align="left">
                                    <table border="1" cellpadding="4" width="100%" cellspacing="0" 
                                bordercolor="#999999" style="border-collapse: collapse">
                                        <tr>
                                            <td width="20%">
                                                <asp:Label ID="lblRouteID" Text='<%# Eval("RouteID") %>' runat="server" Font-Size="Large"></asp:Label>
                                                <br />
                                                RouteID:-
                                                <%# DataBinder.Eval(Container.DataItem, "RouteID")%>
                                            </td>
                                            <td width="20%">
                                            </td>
                                            <td width="20%" style="font-weight: bold; font-size: 12px;" align="center">
                                                <%# DataBinder.Eval(Container.DataItem, "TripType")%>
                                            </td>
                                            <td width="20%">
                                                CabID.:- &nbsp;
                                            </td>
                                            <td width="20%">
                                                Facility:-
                                                <%# DataBinder.Eval(Container.DataItem, "facilityName")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Date:-
                                                <%# DataBinder.Eval(Container.DataItem, "shiftDate")%>
                                            </td>
                                            <td>
                                                Shift Time:-
                                                <%# DataBinder.Eval(Container.DataItem, "Shift")%>
                                            </td>
                                            <td colspan="2" align="center">
                                                Cab Type:- <b>
                                                    <%# DataBinder.Eval(Container.DataItem, "CabType")%></b>
                                            </td>
                                            <td>
                                                Vendor Name:- &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table border="0" width="100%" cellpadding="0" cellspacing="2">
                                        <tr>
                                            <td>
                                                <asp:GridView ID="grdViewRouteDetails" AutoGenerateColumns="False" runat="server"
                                                    BorderStyle="Solid" BorderColor="Black" CellPadding="4" Width="100px" CssClass="GridView">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Sr.No">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblsno" runat="server" Text=" " Width="30px"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ETA">
                                                            <ItemTemplate>
                                                                <div style="width: 50px;">
                                                                    <asp:Label ID="lblETAhh" runat="server" Text=""></asp:Label>
                                                                </div>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Employee Detail">
                                                            <ItemTemplate>
                                                                <div style="width: 200px;">
                                                                  <asp:Label ID="Label1" Text='<%# Eval("empCode") %>' runat="server"></asp:Label>-
                                                                    <asp:Label ID="lblEmpName" Text='<%# Eval("EmpName") %>' runat="server"></asp:Label>
                                                                </div>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="G">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbgender" runat="server" Text='<%# Eval("Gender") %>' Width="20px"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="center" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Address">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>' Width="400px"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Time">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTime" runat="server" Text=" " Width="50px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Meter Reading">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblMeterRed" runat="server" Text=" " Width="100px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Sign">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSign" runat="server" Text=" " Width="50px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table border="0" cellpadding="0" cellspacing="2" width="100%">
                                        <tr>
                                            <td width="30%">
                                                <table cellpadding="2" width="100%" class="table">
                                                    <tr>
                                                        <td>
                                                            &nbsp; Summary
                                                        </td>
                                                        <td>
                                                            &nbsp; Actual
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Start Time
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            End Time
                                                        </td>
                                                        <td class="table">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Start K.M.
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            End K.M.
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Total Time
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Total K.M.
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="30%">
                                                <table cellpadding="2" width="100%" class="table">
                                                    <tr>
                                                        <td>
                                                            <b>Driver Name</b>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <b>Vehicle Number</b>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <b>Vendor Name</b>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td width="40%">
                                                <table cellpadding="2" width="100%" class="table">
                                                    <tr>
                                                        <td colspan="3">
                                                            <b>Remarks:</b>&nbsp;<br />
                                                            <br />
                                                            <br />
                                                            <br />
                                                            <br />
                                                            <br />
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            EscortID/Name
                                                        </td>
                                                        <td>
                                                            Signature
                                                        </td>
                                                        <td>
                                                            Approval
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                    <SeparatorTemplate>
                        <br />
                        <br style="page-break-after: always" />
                    </SeparatorTemplate>
                </asp:DataList>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
