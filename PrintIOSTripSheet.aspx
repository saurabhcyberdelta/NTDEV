<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeFile="PrintIOSTripSheet.aspx.cs" Inherits="PrintIOSTripSheet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <title>Print TripSheet</title>
    <link href="StyleSheets/TMS.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="PrintTripSheet" runat="server">
    <div>
        <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
       
                <table width="950px" cellpadding="1" cellspacing="0" align="left" style="border: thin solid #666666;
                    page-break-after: always;">
                    <tr valign="top">
                        <td align="left" valign="top">
                            <table border="1" cellpadding="4" width="100%" cellspacing="0" bordercolor="#999999"
                                style="border-collapse: collapse">
                                <tr>
                                    <td width="20%">
                                        <asp:Label ID="lblRouteID" Text='Shuttle' runat="server" Font-Size="Large"></asp:Label>
                                        <br />
                                        
                                    </td>
                                    <td width="20%" style="border-collapse: collapse" align="center">
                                     Facility:-
                                         <asp:Label ID="lblFacility"  runat="server" ></asp:Label>
                                    
                                    </td>
                                    <td width="20%" style="font-weight: bold; font-size: 12px;" align="center">
                                        
                                    </td>
                                    <td width="20%">
                                        Vehicle Type:-
                                       
                                        <br />
                                        CabID:-
                                       
                                    </td>
                                    <td width="20%" align="center">
                                  Route #:
                                       
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Date:-
                                         <asp:Label ID="lblDate"  runat="server" ></asp:Label>
                                    </td>
                                    <td>
                                        Shift Time:-
                                        <asp:Label ID="lblShift"  runat="server" ></asp:Label>
                                    </td>
                                    <td colspan="2" align="center">
                                        
                                    </td>
                                    <td>
                                        Vendor Name:-
                                     
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
                                           
                                            <asp:BoundField DataField="" HeaderText="ETA" />
                                            <asp:BoundField DataField="empcode" HeaderText="EmployeeID" ItemStyle-Width="5%" />
                                            <asp:BoundField DataField="EmpName" HeaderText="Employee Name" />
                                            
                                          
                                               
                                           
                                            <asp:BoundField DataField="" HeaderText="Sign" />
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
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <b>Vehicle Number</b>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="1" rowspan="1">
                                                           
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
         
    </div>
    </form>
</body>
</html>
