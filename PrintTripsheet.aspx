<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintTripsheet.aspx.cs" Inherits="PrintTripsheet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <title>Print TripSheet</title>
    <link href="StyleSheets/TMS.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="PrintTripSheet" runat="server">
    <div>
        <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
        <asp:DataList ID="dlShowRoutes" runat="server" RepeatDirection="Vertical" OnItemDataBound="dlShowRoutes_ItemDataBound">
            <ItemTemplate>
                <table width="1200px" height="300px" cellpadding="1" cellspacing="0" align="left" style="border: thin solid #666666;
                    page-break-after: always; float:none;">
                    <tr valign="top">
                        <td align="left" valign="top">
                            <table border="1" cellpadding="4" width="100%" cellspacing="0" bordercolor="#999999"
                                style="border-collapse: collapse">
                                <tr>
                                    <td width="20%">
                                        <asp:Label ID="lblRouteID" Text='<%# Eval("RouteID") %>' runat="server" Font-Size="Large"></asp:Label>
                                        <br />
                                        RouteID:-
                                        <%# DataBinder.Eval(Container.DataItem, "RouteID")%>
                                    </td>
                                    <td width="20%" style="border-collapse: collapse" align="center">
                                     Facility:-
                                        <%# DataBinder.Eval(Container.DataItem, "facilityName")%>
                                    
                                    </td>
                                    <td width="20%" style="font-weight: bold; font-size: 12px;" align="center">
                                        <%# DataBinder.Eval(Container.DataItem, "tripType")%>
                                    </td>
                                    <td width="20%">
                                        Vehicle Type:-
                                        <%# DataBinder.Eval(Container.DataItem, "type")%>
                                        <br />
                                        CabID:-
                                        <%# DataBinder.Eval(Container.DataItem, "Vehicleid")%>
                                    </td>
                                    <td width="20%" align="center">
                                  Route #:
                                        <%# DataBinder.Eval(Container.DataItem, "Sticker")%></font>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Date:-
                                        <%# DataBinder.Eval(Container.DataItem, "shiftDate1")%>
                                    </td>
                                    <td>
                                        Shift Time:-
                                     <b>   <%# DataBinder.Eval(Container.DataItem, "shiftTime")%></b>
                                    </td>
                                    <td colspan="2" align="center">
                                        <%# DataBinder.Eval(Container.DataItem, "remark")%>
                                    </td>
                                    <td>
                                        Vendor Name:-
                                        <%# DataBinder.Eval(Container.DataItem, "vendorName")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5">
                                        <asp:Label ID="lblMsg" runat="server" Visible="False"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <tr>
                                <td>
                                    <%-- <table border="0" width="100%" cellpadding="0">
                                                    <tr valign="top">
                                                        <td valign="top">--%>
                                    <asp:GridView ID="grdViewRouteDetails" AutoGenerateColumns="False" runat="server"
                                        CellPadding="4" Width="100%" Font-Names="Verdana" Font-Size="X-Small">
                                        <Columns>
                                            <asp:BoundField DataField="SNo" HeaderText="Sr. No" />
                                            <asp:BoundField DataField="ETA" HeaderText="ETA" />
                                            <asp:BoundField DataField="empcode" HeaderText="EmployeeID" />
                                            <asp:BoundField DataField="EmpName" HeaderText="Employee Name" />
                                             <asp:BoundField DataField="subProcessName" HeaderText="Process" />
                                            <asp:BoundField DataField="Gender" HeaderText="G" />
                                            <asp:BoundField DataField="Address" HeaderText="Address">
                                                <ItemStyle Width="300px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Location" HeaderText="Location" />
                                            <asp:BoundField DataField="MaleEmpMobile" HeaderText="Male EmpMobile" />
                                            <asp:BoundField DataField="" HeaderText="Sign" >
                                            <ItemStyle Width="100px" />
                                       </asp:BoundField>
                                       <asp:BoundField DataField="" HeaderText="Actual" >
                                         
                                       </asp:BoundField>
                                        </Columns>
                                    </asp:GridView>
                                    <%--</td>
                                                    </tr>
                                                </table>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table border="0" cellpadding="1" cellspacing="0" width="100%">
                                        <tr>
                                            <td width="30%" valign="top">
                                                <table border="1px" cellpadding="3" width="100%" cellspacing="0" bordercolor="#999999"
                                                    style="border-collapse: collapse">
                                                    <tr>
                                                        <td>
                                                            &nbsp;Summary
                                                        </td>
                                                        <td>
                                                            Actual
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
                                                        <td>
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
                                                </table>
                                            </td>
                                            <td width="30%" valign="top">
                                                <table border="1px" cellpadding="3" width="100%" cellspacing="0" bordercolor="#999999"
                                                    style="border-collapse: collapse">
                                                    <tr>
                                                        <td>
                                                            <b>Driver Name</b>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <%# DataBinder.Eval(Container.DataItem, "DriverName")%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <b>Vehicle Number</b>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="1" rowspan="1">
                                                            &nbsp;<%# DataBinder.Eval(Container.DataItem, "vehicleNo")%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="1">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td valign="top">
                                                <table border="1px" cellpadding="3" width="100%" cellspacing="0" bordercolor="#999999"
                                                    style="border-collapse: collapse">
                                                    <tr>
                                                        <td colspan="3" valign="top">
                                                            <b>Remarks:</b>&nbsp;<br />
                                                            <br />
                                                         <asp:Label ID="lblMedical" runat="server" Text=""></asp:Label>
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
                                       <tr>
                                       <td>
                                    
                                       </td>
                                       </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                            <td align="center">
                              Note: Partners are requested to sign the tripsheet after completion of the trip
                            </td>
                            </tr>
                            <tr>
                            <td align="center">
                            <br />
                            <b>
                             Departure Seal
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<span style="text-align:right"> Arrival Seal</span></b>
                           
                            </td>
                           
                            </tr>
                       </table>
                 <table>
                    <tr>
                        <td>
                            <asp:Literal ID="litSeparator" runat="server"></asp:Literal>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
            <SeparatorTemplate>
                <br />
                <br style="page-break-after: always" />
            </SeparatorTemplate>
        </asp:DataList>
    </div>
    </form>
</body>
</html>
