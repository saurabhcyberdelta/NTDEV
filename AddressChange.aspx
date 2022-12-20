<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="AddressChange.aspx.cs" Inherits="AddressChange" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <link href="StyleSheets/TMS.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/GridView.css" rel="stylesheet" type="text/css" />
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table width="100%" align="center">
                <tr>
                    <td align="center">
                        <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="Save" />
                        
                    </td>
                </tr>
               
                <tr align="left">
                    <td class="gradient1" align="left">
                      <h1> <span></span> Change Address</h1>
                      <h2>Allows to Change the Address</h2>                   
                         </td>
                </tr>
               
                <tr align="left">
                    <td align="right" >
                                                     <asp:Button ID="btnGoBack" runat="server" 
    CssClass="Button" PostBackUrl="~/MyProfile.aspx"
                                        Text="Go Back" />
                                
                        </td>
                </tr>
                <tr>
                <td>
                <table class="tableBorber" width="90%" align="center">
                    <tr>
                        <td align="center" class="HeaderStyle" >
                            <font color="white"><b>Your Last 5 Request Status</b></font>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="gvChangeRequests" runat="server" Width="100%">
                                <RowStyle CssClass="RowStyle" />
                                <FooterStyle CssClass="FooterStyle" />
                                <PagerStyle CssClass="PagerStyle" />
                                <SelectedRowStyle CssClass="SelectedRowStyle" />
                                <HeaderStyle CssClass="HeaderStyle" />
                                <EditRowStyle BackColor="#999999" />
                                <AlternatingRowStyle CssClass="AltRowStyle" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
               </td>
               </tr>
            <tr>
                 
            </td>
            </tr>
            <tr>
            <td align="center">
                &nbsp;</td>
                 
            </td>
            </tr>
            
                <tr>
                    <td align="center">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Red" Text="" Visible="false"></asp:Label>
                    </td>
                    </td>
                </tr>
                <tr>
                <td>
                <table align="center" width="90%" class="tableBorber">
                <tr>
                    <td align="center" class="HeaderStyle">
                   <font color="white">   <b>  Make a new request</b></font></td>
                
                </tr>
                 <tr>
            
                    <td align="center">
                       
                        <table width="80%" align="center" class="tableBorber" cellspacing="0">
                        <tr>
                        <td colspan="2" class="TDbg">Address Change Form</td>
                        </tr>
                        <tr>
                        <td align="left" class="myTableRowStyle"><b>Partner ID</b></td>
                        <td align="left" class="myTableRowStyle">
                            <asp:Label ID="lblEmployeeID" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr>
                        <td align="left" class="myTableAltRowStyle" ><b>Partner Name</b></td>
                        <td align="left" class="myTableAltRowStyle">
                            <asp:Label ID="lblEmployeeName" runat="server" Text=""></asp:Label></td>
                        </tr>
                         <tr>
                        
                        <td align="left" class="myTableRowStyle"><b>Address</b></td>
                        <td align="left" class="myTableRowStyle">
                            <asp:Label ID="lblPrimaryAddress" runat="server" Text=""></asp:Label></td>
                        </tr>
                        <tr>
                        <td align="left" class="myTableAltRowStyle" ><b>Address LandMark</b></td>
                        <td align="left" class="myTableAltRowStyle">
                            <asp:Label ID="lblPrimaryLdmrk" runat="server" Text=""></asp:Label></td>
                        </tr>
                        
                        <tr>
                        <td align="left" class="myTableAltRowStyle"><b>New Address</b></td>
                        <td align="left" class="myTableAltRowStyle">
                            <asp:TextBox ID="txtNewaddress" runat="server" TextMode="MultiLine" 
                                Height="80px" Width="288px" MaxLength="250" ></asp:TextBox>  
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Text="*" ValidationGroup="Save" 
                            ControlToValidate="txtNewaddress"
                            ErrorMessage="Enter the New Address" SetFocusOnError="true"></asp:RequiredFieldValidator> 
                        </td>
                        </tr>
                       <tr>
                        <td align="left" class="myTableRowStyle"><b>Effective Date</b></td>
                        <td align="left" class="myTableRowStyle" >
                        
                            <asp:TextBox ID="txtCalendar" runat="server" 
                                    CssClass="TextBox" CausesValidation="True" ValidationGroup="Submit" 
                               ></asp:TextBox>
                                <asp:ImageButton ID="ImgBtnCalendar" runat="server" ImageUrl="Images/calendar_icon.gif"
                                    Height="17px" Width="17px" />
                                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Animated="true" TargetControlID="txtCalendar"
                                    PopupButtonID="ImgBtnCalendar"  />
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Text="*" ValidationGroup="Save" 
                            ControlToValidate="txtCalendar"
                            ErrorMessage="Enter the Effective Date"></asp:RequiredFieldValidator> 
                              
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtCalendar" Display="Dynamic" 
                            
                            ValidationGroup="Save" Type="Date" SetFocusOnError="true" Operator="GreaterThanEqual" ControlToCompare="lblDatecheck" ErrorMessage="Address change effective date should be greater than 2 days from Today">*</asp:CompareValidator>
                              &nbsp;<i>(mm/dd/yyyy)</i>
                                   <asp:TextBox ID="lblDatecheck" runat="server" style="visibility:hidden"></asp:TextBox>
                      
                       </tr>
                     
                      <tr>
                      <td class="myTableAltRowStyle"></td>
                        <td align="center" class="myTableAltRowStyle" >
                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="Button" ValidationGroup="Save"
                                onclick="btnSave_Click"  Width="42px" />
                        </td>
                                   
                         </tr>
                      <tr>
                        <td align="center" colspan="2" class="myTableRowStyle">
                            
                            </b>
                        </td>
                                   
                         </tr>
                          </table>
                       
                    </td>
                </tr>
                </table>
                </td>
                </tr>
            
               
                 <tr>
                                    <td align="center">
                                       <asp:MultiView ID="multiview2" runat="server">
                                       
                                     <asp:View ID="view1" runat="server">
                                       <asp:Panel ID="Panel3" runat="server"  Width="80%"   >
                                        <table width="60%" class="table" align="center">
                                        <tr>
                                        <td  bgcolor="blue" colspan="2" align="right" >
                                       
                                        <asp:ImageButton ID="btnClose" runat="server" 
                    ImageUrl ="~/images/no_icon.jpg" onclick="btnClose_Click" />
                   
                   
                    </td>
                                        </tr>
            
                                    
                                        <tr><td colspan="2" align="left" bgcolor="white">
                                        <asp:Panel ID="Panel4" runat="server" BackColor="White">
                                        <center><b>DECLARATION</b></center>
                                        <font face="Calibri" size="2">I declare that the residential addresses provided by me are true and correct and that I will be picked up or dropped off, by the transport provided by the organisation, to either of these addresses, as per the roster schedule provided by me in eTMS, within the stipulated timelines. </font></asp:Panel>
                                        </td></tr>
                                        <tr>
                                        <td align="center" colspan="2" bgcolor="white">
                                        
                                          <asp:Button ID="btnAgree" runat="server" Text="Agree" CssClass="Button" 
                                                onclick="btnAgree_Click" />
                                                  <asp:Button ID="btnDisagree" runat="server" Text="DisAgree" CssClass="Button" />
                                       
                                        </td>

                                        </tr>
                                        </table>
                                         <asp:Button ID="Button2" runat="server" Style="visibility: hidden" />
                       
                                       <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" Enabled="True"  BackgroundCssClass="modalBackground"
                            TargetControlID="Button2" PopupControlID="Panel3" CancelControlID="btnClose"
                            DropShadow="false">
                        </cc1:ModalPopupExtender>
                                       </asp:Panel>
                                      
                                    </asp:View>
                                    </asp:MultiView>
                                    </td>
                                    
                                    
                                    </tr>
                <tr>
                    <td>
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                            DisplayAfter="0">
                            <ProgressTemplate>
                                <table align="center">
                                    <tr>
                                        <td>
                                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" />
                                        </td>
                                        <td class="main_bg">
                                            Loading.....Please Wait!!!
                                        </td>
                                    </tr>
                                   
                                </table>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

