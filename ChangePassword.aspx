<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="ChangePassword.aspx.cs" Inherits="ChangePassword" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    <style type="text/css">
        p.MsoPlainText
        {
            margin-bottom: .0001pt;
            font-size: 10.5pt;
            font-family: Consolas;
            margin-left: 0cm;
            margin-right: 0cm;
            margin-top: 0cm;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <asp:UpdatePanel ID="UpdatePanel4" runat="server">
        <ContentTemplate>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
        ShowSummary="False" ValidationGroup="ChangePassword1" />
    <table width="90%" align="left">
        
        <tr>
            <td align="center" class="heading">
                <div class="gradient2">
                    <h1>
                        <span></span>Manage Change Password
                    </h1>
                    <h2>
                        Allows Partner to Change Password Details.
                    </h2>
                </div>                
            </td>
        </tr>
        
        <tr>
            <td align="center">
                <br />
               
                        <table border="0" cellpadding="4" cellspacing="0" class="tableBorber">
                            <tr>
                                <td>
                                <asp:Panel ID="pnlChange" runat="server">
                                    <table border="0" cellpadding="0" style="height: 193px; width: 495px;">
                                        <tr>
                                            <td align="center" colspan="2" style="color: White; background-color: #5D7B9D; font-size: 0.9em;
                                                font-weight: bold;">
                                                Change Your Password
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Old Password:</asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="CurrentPassword" runat="server" Font-Size="0.8em" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword"
                                                    ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">New Password:</asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="NewPassword" runat="server" Font-Size="0.8em" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword"
                                                    ErrorMessage="New Password is required." ToolTip="New Password is required."
                                                    ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Confirm New Password:</asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="ConfirmNewPassword" runat="server" Font-Size="0.8em" TextMode="Password"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword"
                                                    ErrorMessage="Confirm New Password is required." ToolTip="Confirm New Password is required."
                                                    ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2">
                                                <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword"
                                                    ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="The Confirm New Password must match the New Password entry."
                                                    ValidationGroup="ChangePassword1"></asp:CompareValidator>
                                                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="CurrentPassword"
                                                    ControlToValidate="NewPassword" Display="Dynamic" ErrorMessage="The Confirm Current Password must not match the New Password entry."
                                                    ValidationGroup="ChangePassword1" Operator="NotEqual"></asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2" style="color: Red;">
                                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Your password must be at least 7 characters long, and contain at least one number and one special character."
                                                    ControlToValidate="NewPassword" Display="Dynamic" ValidationExpression="^.*(?=.{7,})(?=.*[a-zA-Z])(?=.*[@#$%^&amp;!+=]).*$"
                                                    ValidationGroup="ChangePassword1"></asp:RegularExpressionValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2" style="color: Red;">
                                                <asp:CustomValidator ID="CustomValidator1" runat="server" Display="Dynamic" ErrorMessage="Old Password Mismatched."
                                                    OnServerValidate="CustomValidator1_ServerValidate" ValidationGroup="ChangePassword1"></asp:CustomValidator>
                                                <br />
                                                <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="The password cannot contain the User Id as part of it."
                                                    OnServerValidate="CustomValidator2_ServerValidate" ValidationGroup="ChangePassword1"></asp:CustomValidator>
                                                <br />
                                                <asp:CustomValidator ID="CustomValidator3" runat="server" ErrorMessage="Your new password already exists in last eight passwords."
                                                    OnServerValidate="CustomValidator3_ServerValidate" ValidationGroup="ChangePassword1"></asp:CustomValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Button ID="ChangePasswordPushButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC"
                                                    BorderStyle="Solid" BorderWidth="1px" CommandName="ChangePassword" Font-Names="Verdana"
                                                    Font-Size="Small" ForeColor="#284775" Text="Change Password" 
                                                    ValidationGroup="ChangePassword1" onclick="ChangePasswordPushButton_Click" />
                                                <cc1:ConfirmButtonExtender ID="ConfirmButton_btnSave" TargetControlID="ChangePasswordPushButton"
                                                    runat="server" ConfirmOnFormSubmit="False" ConfirmText="Are you sure you want to change the password?">
                                                </cc1:ConfirmButtonExtender>
                                            </td>
                                            <td>
                                                <asp:Button ID="CancelPushButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC"
                                                    BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" CommandName="Cancel"
                                                    Font-Names="Verdana" Font-Size="Small" ForeColor="#284775" Text="Cancel" />
                                            </td>
                                        </tr>
                                    </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                
            </td>
        </tr>
         <tr>
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
        </tr>
        <tr>
            <td align="left">
                        <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" 
                    Visible="False"></asp:Label>
                    </td>
        </tr>
        <tr>
            <td align="left">
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <p class="MsoPlainText">
                    <b style="mso-bidi-font-weight:normal"><i style="mso-bidi-font-style:normal">
                    <span style="font-size:12.0pt;font-family:
&quot;Calibri&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:Arial;mso-font-kerning:.5pt;
mso-fareast-language:AR-SA">Password Policy</span></i></b><span style="font-size:12.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;mso-fareast-font-family:
Arial;mso-font-kerning:.5pt;mso-fareast-language:AR-SA"><o:p></o:p></span></p>
                <p class="MsoPlainText">
                    <![if !supportLists]>
                    <span style="font-size:12.0pt;font-family:
Symbol;mso-fareast-font-family:Symbol;mso-bidi-font-family:Symbol;mso-font-kerning:
.5pt;mso-fareast-language:AR-SA"><span style="mso-list:Ignore">·<span 
                        style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </span></span></span><![endif]>
                    <span style="font-size:12.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
mso-fareast-font-family:Arial;mso-font-kerning:.5pt;mso-fareast-language:AR-SA">User can change 
                    password only once in 24 hrs (Minimum Password age).<o:p></o:p></span></p>
                <p class="MsoPlainText">
                    <![if !supportLists]>
                    <span style="font-size:12.0pt;font-family:
Symbol;mso-fareast-font-family:Symbol;mso-bidi-font-family:Symbol;mso-font-kerning:
.5pt;mso-fareast-language:AR-SA"><span style="mso-list:Ignore">·<span 
                        style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </span></span></span><![endif]>
                    <span style="font-size:12.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
mso-fareast-font-family:Arial;mso-font-kerning:.5pt;mso-fareast-language:AR-SA">Password should be 
                    at least 8 positions in length.<o:p></o:p></span></p>
                <p class="MsoPlainText">
                    <![if !supportLists]>
                    <span style="font-size:12.0pt;font-family:
Symbol;mso-fareast-font-family:Symbol;mso-bidi-font-family:Symbol;mso-font-kerning:
.5pt;mso-fareast-language:AR-SA"><span style="mso-list:Ignore">·<span 
                        style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </span></span></span><![endif]>
                    <span style="font-size:12.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
mso-fareast-font-family:Arial;mso-font-kerning:.5pt;mso-fareast-language:AR-SA">Contains a mix of 
                    alphabetic and non-alphabetic characters (numbers, punctuation or special 
                    characters).<o:p></o:p></span></p>
                <p class="MsoPlainText">
                    <![if !supportLists]>
                    <span style="font-size:12.0pt;font-family:
Symbol;mso-fareast-font-family:Symbol;mso-bidi-font-family:Symbol;mso-font-kerning:
.5pt;mso-fareast-language:AR-SA"><span style="mso-list:Ignore">·<span 
                        style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </span></span></span><![endif]>
                    <span style="font-size:12.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
mso-fareast-font-family:Arial;mso-font-kerning:.5pt;mso-fareast-language:AR-SA">Should not contain 
                    user id as part of the password.<o:p></o:p></span></p>
                <p class="MsoPlainText">
                    <![if !supportLists]>
                    <span style="font-size:12.0pt;font-family:
Symbol;mso-fareast-font-family:Symbol;mso-bidi-font-family:Symbol;mso-font-kerning:
.5pt;mso-fareast-language:AR-SA"><span style="mso-list:Ignore">·<span 
                        style="font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </span></span></span><![endif]>
                    <span style="font-size:12.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
mso-fareast-font-family:Arial;mso-font-kerning:.5pt;mso-fareast-language:AR-SA">New Password should 
                    not be from the list of last 8 used passwords..<o:p></o:p></span></p>
                <p class="MsoPlainText">
                    <![if !supportLists]>
                    </p>
            </td>
        </tr>
        
    </table>
 </ContentTemplate>
 </asp:UpdatePanel>
</asp:Content>
