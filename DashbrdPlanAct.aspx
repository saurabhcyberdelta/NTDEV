<%@ Page Title="" Language="C#" MasterPageFile="~/Header.Master" AutoEventWireup="true" CodeFile="DashbrdPlanAct.aspx.cs" Inherits="DashbrdPlanAct" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
    
    
    <style type="text/css">
        .style1
        {
            width: 11px;
        }
       

</style>

    
    
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" border="0" width="100%">
        <tr align="center">
            <td class="heading">
                                Dashboard
                <br />
            </td>
        </tr>
        <tr>
        
        
            <td class="style7">
                <asp:Button ID="Button1" runat="server" onclick="Button1_Click" CssClass="Button"
                    Text="Plan vs Actual" />
                <asp:Button ID="btnBudget" runat="server" Text="Budget" CssClass="Button"
                    onclick="btnBudget_Click" />
            

            </td>
        </tr>
        <tr>
            <td class="style7">
                <br />
                <table border="0" cellpadding="4" cellspacing="0" align="left" width="90%" class="tableBorber">
                    <tr align="center">
                        <td align="right" valign="middle" width="36px">
                            <b>FacilityName:</b></td>
                       
                        <td align="left" valign="middle" width="163px">
                            <asp:DropDownList ID="ddlFacility" runat="server" AppendDataBoundItems="True" 
                                CssClass="DropDownListBox3" 
                                onselectedindexchanged="ddlFacility_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlFacility"
                                Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="Submit"
                                ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator>
                        </td>
                       
                        <td align="right" valign="middle" width="163px">
                            <b>Months:</b></td>
                       
                        <td align="left" valign="top" width="163px">
                            
                            <asp:RadioButtonList ID="rblistMonth" runat="server" 
                                RepeatDirection="Horizontal" 
                                onselectedindexchanged="rblistMonth_SelectedIndexChanged">
                            <asp:ListItem Text="Jan" Value="1" />
                            <asp:ListItem Text="Feb" Value="2" />
                           <asp:ListItem Text="Mar" Value="3" />
                            <asp:ListItem Text="Apr" Value="4" />
                            <asp:ListItem Text="May" Value="5" />
                            <asp:ListItem Text="Jun" Value="6" />
                            <asp:ListItem Text="Jul" Value="7" />
                            
                            <asp:ListItem Text="Aug" Value="8" />
                            <asp:ListItem Text="Sep" Value="9" />
                            <asp:ListItem Text="Oct" Value="10" />
                            <asp:ListItem Text="Nov" Value="11" />
                            <asp:ListItem Text="Dec" Value="12" />
                            </asp:RadioButtonList>
                            
                        </td>
                        <td align="right" valign="middle">
                            <b>Years:</b></td>
                        <td align="left" width="249px" valign="middle">
                            <asp:DropDownList ID="ddlyear" runat="server" 
                                onselectedindexchanged="ddlyear_SelectedIndexChanged">
                            </asp:DropDownList> 
                        </td>
                    </tr>
                    </table>
            </td>
        </tr>
        <tr>
            <td>
                <table align="left" width="80%">
                    <tr>
                        <td align="left">
                            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Visible="False" Font-Names="Verdana"
                                Font-Size="8pt" ShowFindControls="False" ShowPrintButton="False" 
                                Width="100%" ShowBackButton="True" 
                                ShowZoomControl="False" ZoomMode="FullPage" Height="700px">
                                
                              
                            </rsweb:ReportViewer>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            &nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>