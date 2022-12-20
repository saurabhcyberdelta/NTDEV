<%@ Page Title="" Language="C#" MasterPageFile="~/ChangePasswordFirstTimeMasterPage.master" AutoEventWireup="true" CodeFile="ChangePasswordFirstTime.aspx.cs" Inherits="ChangePasswordFirstTime" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
                <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
               
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
                                                <asp:TextBox ID="CurrentPassword" runat="server" Font-Size="0.8em" 
                                                    TextMode="Password" ontextchanged="CurrentPassword_TextChanged"></asp:TextBox>
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
                                                    Font-Size="Small" ForeColor="#284775" Text="Change Password" ValidationGroup="ChangePassword1" OnClick="ChangePasswordPushButton_Click" />
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
                   
                 </asp:View>
    </asp:MultiView>
            </td>
        </tr>
       
        <tr>
            <td align="left">
                        <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" 
                    Visible="False"></asp:Label>
                    </td>
        </tr>
        <tr><td>
        <asp:MultiView ID="MultiView2" runat="server">
                                        <asp:View ID="View3" runat="server">
                                            <asp:Button ID="Button1" runat="server" Text="Show Modal" Style="visibility: hidden" />
                                            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modal-bg"
                                                TargetControlID="Button1" PopupControlID="pnlModal" >
                                            </cc1:ModalPopupExtender>
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="pnlModal" runat="server" CssClass="modal">
                                                            <table cellpadding="0" cellspacing="0" width="100%" align="center">
                                                                <tr>
                                                                    <td class="blueHeaderMiddleLeft" width="1%">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td class="blueHeaderMiddleCenter" width="100%">
                                                                       Message
                                                                    </td>
                                                                    <td class="blueHeaderMiddleCenter1">
                                                                        <asp:ImageButton ID="ibtnSMclose" runat="server" ImageUrl="~/images/Window/CloseOut.gif"
                                                                            CssClass="ButtonCloseOver" onclick="ibtnSMclose_Click" />
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
                                                                                    Your Password has been changed successfully!!!
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
                                        </asp:View>
                                    </asp:MultiView>
        </td></tr>
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
                    not be from the list of last 8 used passwords.<o:p></o:p></span></p>
                <p class="MsoPlainText">
                    <![if !supportLists]>
                  </p>
            </td>
        </tr>
        
    </table>
 </ContentTemplate>
 </asp:UpdatePanel>
</asp:Content>

