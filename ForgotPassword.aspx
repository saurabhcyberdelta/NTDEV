<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="ForgotPassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9" />
    <title>e-Transport Management System</title>
    <link href="StyleSheets/DataList.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/DetailsView.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/GridView.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/Menu.css" rel="stylesheet" type="text/css" />   
    <link href="StyleSheets/Text-gradient.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/TMS.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/Window.css" rel="stylesheet" type="text/css" />
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico">
  
    <style type="text/css">
        .style3
        {
            width: 100%;
        }
        .style4
        {
            font-size: x-large;
            color: #FFFFFF;
            font-weight: bold;
        }
        .style6
        {
            font-size: small;
        }
    </style>
</head>
<body style="padding: 0px; margin: 0px">

    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server" />
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
   <ContentTemplate>
    <div>
       
        
        <table cellspacing="0" class="style3">
            <tr>
                <td colspan="2">
                    <table cellspacing="0" class="tableBorber" width="100%">
                        <tr>
                            <td class="bg-menu-Logo" width="15%" align="center" rowspan="2">
                                <img alt="logo" src="images/logo.png" height="44px" />
                            </td>
                            <td class="bg-menu-main">
                                e-Transport Management System
                            </td>
                        </tr>
                        <tr>
                            <td class="bg-menu-main">
                                <asp:Label ID="lblCuurDate" runat="server" ForeColor="White"
                                    Font-Bold="True" CssClass="style6"></asp:Label></td>
                        </tr>
                        <tr>
                            <td class="bg-menu-TD">
                            </td>
                            <td class="bg-menu-TD">
                               <asp:LinkButton ID="lbtnHome" runat="server" CausesValidation="False"
                                    PostBackUrl="~/Default.aspx" CssClass="linkButton">Home</asp:LinkButton>&nbsp
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top" width="15%">
                    
                </td>
                <td>
                    <table width="100%">
                        <tr>
                            <td width="100%">
                              <table align="center" width="100%">
        <tr>
            <td align="center">
               <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="reset" />
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
                        <span></span>Forgot Password 
                    </h1>
                    <h2>
                       Allows to Reset Your Password
                    </h2>
                </div>
            </td>
        </tr>
        
        <tr>
        
        <td><br /></td>
        </tr>
        
        <tr>
        
        <td><br /></td>
        </tr>
        
        <tr align="center">
        <td align="center">
        
        <table class="table"> 
        <tr>
        <td  colspan="2" class="TDbg"> Enter the Authentication Details</td>
        
        
        </tr>
        <tr>
        <td>
        Enter the Employee ID:
        </td>
        <td>
            <asp:TextBox ID="txtEmployeeID"  runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtEmployeeID" runat="server" ErrorMessage="*" ValidationGroup="reset"></asp:RequiredFieldValidator>
        </td>
        </tr>
        
        <tr>
        <td>
        Enter the e-mail ID:
        </td>
        <td>
            <asp:TextBox ID="txtEmailID"  runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtEmailID" runat="server" ErrorMessage="*" ValidationGroup="reset"></asp:RequiredFieldValidator>
     
        </td>
        </tr>
        
        <tr>
        <td colspan="2" align="center">
            <asp:Button ID="btnResetPassword" runat="server" Text="Reset Password" 
                ValidationGroup="reset" CssClass="Button" onclick="btnResetPassword_Click" />
        </td>
        </tr>
        </table>
        
        </td>
        </tr>
        
        </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="15%">
                    &nbsp;
                </td>
                <td>
                    
                </td>
            </tr>
        </table>
       
    </div>
      </ContentTemplate>
             </asp:UpdatePanel>
    </form>
   
</body>
</html>
