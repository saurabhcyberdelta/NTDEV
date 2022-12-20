<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NoAccess.aspx.cs" Inherits="NoAccess" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>eTMS:NoAccess</title>
    
</head>
<body>
    <form id="form1" runat="server">
    <div align="center" style="vertical-align: top;">
        <asp:Image ID="imgNoAccess" runat="server" AlternateText="No Access" Height="132px"
            ImageUrl="~/images/NoAccessHand.jpg" Width="142px" ImageAlign="Top" />
        <br />
        <br />
        <asp:Label ID="lblAccess" runat="server" Font-Bold="True" Style="z-index: 100; left: 39px;"
            Text="The Following error occurred. Please contact your Transport administrator."></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblErrorMsg" runat="server" Visible="False" ForeColor="Red"></asp:Label>
        <br />
        <br />
    </div>
    </form>
</body>
</html>
