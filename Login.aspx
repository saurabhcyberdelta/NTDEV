<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Cache-Control" content="no-cache" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <link href="StyleSheets/style.css" rel="stylesheet" type="text/css" />
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico">
    <title>eTMS Login</title>

    <script type="text/javascript">
        window.history.forward(1); 
    </script>

</head>
<body style="background-image: url('images/bg.png')">
    <form id="form1" runat="server">
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
        ShowSummary="False" ValidationGroup="Login1" />
    <!-- Start of logo -->
    <div id="logo" class="logo">
        e-Transport Management System
    </div>
    <!-- End of logo -->
    <hr />
    <!-- Start of actual page -->
    <div id="page" class="page">
        <div id="content" class="content">
            <div class="news">
                <h1 class="title">
                    <a href="#">e-Transport Management System</a></h1>
                <p class="meta">
                    <small>Posted on April 30th, 2012 by <a href="#">Sundar Muthyala</a></small></p>
                <div class="entry">
                    <p>
                        eTMS solution consists of two Applications: Transport Management System (eTMS) &
                        Infor Route planning. eTMS is a ‘Web based Roster’ application that automates the
                        transportation process.
                    </p>
                    <p>
                        This Project provides a user-friendly system with Graphical User Interface for online
                        submission & authentication of the web based scheduling of employees by and timely
                        information at various levels to assist the concerned authorities and providing
                        securities at various levels to the user. The application is also integrated to
                        Exchange server, SMS gateway.</p>
                    
                </div>
            </div>
        </div>
        <div id="right" class="right">
            <ul>
                <li>
                    <h2>
                        <asp:LoginStatus ID="LoginStatus1" runat="server" />
                    </h2>
                    <asp:Login ID="Login1" runat="server" BackColor="#F7F6F3" BorderColor="#E6E2D8" BorderPadding="4"
                        BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="Large"
                        ForeColor="#333333" Height="174px" Width="299px" PasswordRecoveryText="Forgot Password"
                        PasswordRecoveryUrl="~/forgotPassword.aspx" OnAuthenticate="Login1_Authenticate" 
                        OnLoggedIn="Login1_LoggedIn" DisplayRememberMe="False">
                        <TextBoxStyle Font-Size="Small" />
                        <LoginButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px"
                            Font-Names="Verdana" Font-Size="Small" ForeColor="#284775" />
                        <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                        <LabelStyle Font-Size="Small" />
                        <TitleTextStyle BackColor="#124D78" Font-Bold="True" Font-Size="Medium" ForeColor="White" />
                    </asp:Login>
                </li>
            </ul>
        </div>
        <div style="clear: both;">
            &nbsp;</div>
    </div>
    <!-- End of actual page -->
    <!-- Start of footer -->
    <!-- Do not remove copyright, thank you. -->
    <div id="footer" class="footer">
    </div>
    <!-- End of footer -->
    </form>
</body>
</html>
