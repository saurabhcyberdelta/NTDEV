<%@ Page Title="Replicate Schedule" Language="C#" MasterPageFile="~/Header.Master"
    AutoEventWireup="true" CodeFile="EmpReplicateSchedule.aspx.cs" Inherits="EmpReplicateSchedule"
    EnableViewStateMac="False" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table align="left" cellpadding="4" cellspacing="0" width="100%">
                <tr>
                    <td colspan="10">
                        <table align="left" cellpadding="4" cellspacing="0" width="80%">
                            <tr>
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                    ShowSummary="False" ValidationGroup="PageSize" />
                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" DisplayMode="BulletList"
                                    EnableClientScript="true" ValidationGroup="SetAll" ShowMessageBox="True" ShowSummary="False" />
                                <td align="center" class="heading" colspan="2">
                                    <div class="gradient2">
                                        <h1>
                                            <span></span>Replicate Schedule
                                        </h1>
                                        <h2>
                                            Allows Partner/Manager to Replicate Schedule.
                                        </h2>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2">
                                    &nbsp;
                                    <asp:ValidationSummary ID="ValidationSummary3" runat="server" DisplayMode="BulletList"
                                        EnableClientScript="true" HeaderText="Please correct the following information : "
                                        ValidationGroup="save" ShowMessageBox="True" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="right">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <table cellpadding="4" width="80%" class="table">
                                        <tr>
                                            <td class="TDbg" colspan="2" align="center">
                                                Current Week
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" valign="middle">
                                                <b>Start Date:&nbsp; </b>
                                            </td>
                                            <td align="center" valign="middle">
                                                <b>End Date:&nbsp; </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" valign="middle">
                                                <asp:Label ID="lblFromWSDate" runat="server" AutoPostBack="True" Width="70px" CssClass="Label"></asp:Label>
                                            </td>
                                            <td align="center" valign="middle">
                                                <asp:Label ID="lblFromWEDate" runat="server" AutoPostBack="True" Width="70px" CssClass="TextBox"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td valign="top">
                                    <table cellpadding="4" width="80%" class="table">
                                        <tr>
                                            <td class="TDbg" colspan="2">
                                                Next Week
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" valign="middle">
                                                <b>Start Date:&nbsp; </b>
                                            </td>
                                            <td align="center" valign="middle">
                                                <b>End Date:&nbsp; </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" valign="middle">
                                                <asp:Label ID="lblToWSDate" runat="server" AutoPostBack="True" Width="70px" CssClass="TextBox"></asp:Label>
                                            </td>
                                            <td align="center" valign="middle">
                                                <asp:Label ID="lblToWEDate" runat="server" AutoPostBack="True" Width="70px" CssClass="TextBox"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" valign="middle">
                                                <asp:LinkButton ID="lbtPrevWeek" runat="server" Visible="False" OnClick="lbtPrevWeek_Click">&lt;&lt;Prev Week</asp:LinkButton>
                                            </td>
                                            <td align="center" valign="middle">
                                                <asp:LinkButton ID="lbtNextWeek" runat="server" OnClick="lbtNextWeek_Click">Next Week&gt;&gt;</asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="middle" colspan="2">
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="100" AssociatedUpdatePanelID="UpdatePanel1"
                                        DynamicLayout="False">
                                        <ProgressTemplate>
                                            <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loding..." />
                                            Loading.....Please Wait!!!</ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table align="left" cellpadding="3" cellspacing="0" width="100%">
                            <tr>
                                <td align="right">
                                    <asp:Button ID="btnGoBack" runat="server" CssClass="Button" 
                                        PostBackUrl="~/EmpScheduler.aspx" Text="Go Back" />
                                    <asp:CustomValidator ID="CustomValidatorCheckBox" runat="server" ErrorMessage="Cannot proceed because you did not choose any Partner."
                                        OnServerValidate="CustomValidatorCheckBox_ServerValidate" ValidationGroup="save"
                                        Display="Dynamic">*</asp:CustomValidator>
                                    <asp:Button ID="btnReplicate" runat="server" Text="Replicate Schedule" OnClick="btnReplicate_Click"
                                        ValidationGroup="save" CssClass="Button" />
                                    <cc1:ConfirmButtonExtender ID="ConfirmButton_btnReplicate" TargetControlID="btnReplicate"
                                        runat="server" ConfirmOnFormSubmit="False" ConfirmText="Are you sure you want to save the selected shift pattern?">
                                    </cc1:ConfirmButtonExtender>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" valign="middle" colspan="10">
                                    <asp:GridView ID="grdEmployeeSchedule" runat="server" AutoGenerateColumns="False"
                                        AllowPaging="False" DataKeyNames="EmployeeId" CssClass="GridView" BorderWidth="0px"
                                        ShowFooter="True" Width="100%">
                                        <Columns>
                                            <asp:TemplateField HeaderText="ID">
                                                <ItemStyle Width="20px" />
                                                <HeaderTemplate>
                                                    <asp:CheckBox ID="chkBxHeader" AutoPostBack="true" OnCheckedChanged="CheckAll" runat="server" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkBxEmpId" runat="server" Checked='<%# checkemp(DataBinder.Eval(Container.DataItem, "EmployeeId")) %>' />
                                                    <asp:Label runat="server" ID="EmpID" Text='<%# Eval( "EmployeeId" ) %>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="G">
                                                <ItemStyle Width="10px" />
                                                <ItemTemplate>
                                                    <img id="imgGeoCode" src='<%# CheckImage(DataBinder.Eval(Container.DataItem, "geoCode")) %>'
                                                        alt='<%# CheckAltGeocode(DataBinder.Eval(Container.DataItem, "geoCode")) %>' width="15" height="15" /><br />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="T">
                                                <ItemStyle Width="10px" />
                                                <ItemTemplate>
                                                    <img id="imgTptReq" src='<%# CheckTptReq(DataBinder.Eval(Container.DataItem, "tptReq")) %>'
                                                      alt='<%# CheckAltTptReq(DataBinder.Eval(Container.DataItem, "tptReq")) %>'  width="15" height="15" /><br />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Partner Name">
                                                <ItemStyle Width="160px" HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                    <%# DataBinder.Eval(Container.DataItem, "EmpName") %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="In0">
                                                <ItemStyle Width="110px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <%# (Eval("SETime0").ToString()!=""? Eval("SETime0").ToString().Substring(0, Eval("SETime0").ToString().IndexOf("!")):Eval("SETime0"))%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="In1">
                                                <ItemStyle Width="110px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <%# (Eval("SETime1").ToString() != string.Empty ? Eval("SETime1").ToString().Substring(0, Eval("SETime1").ToString().IndexOf("!")) : Eval("SETime1"))%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="In2">
                                                <ItemStyle Width="110px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <%# (Eval("SETime2").ToString() != string.Empty ? Eval("SETime2").ToString().Substring(0, Eval("SETime2").ToString().IndexOf("!")) : Eval("SETime2"))%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="In3">
                                                <ItemStyle Width="110px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <%# (Eval("SETime3").ToString() != string.Empty ? Eval("SETime3").ToString().Substring(0, Eval("SETime3").ToString().IndexOf("!")) : Eval("SETime3"))%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="In4">
                                                <ItemStyle Width="110px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <%# (Eval("SETime4").ToString() != string.Empty ? Eval("SETime4").ToString().Substring(0, Eval("SETime4").ToString().IndexOf("!")) : Eval("SETime4"))%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="In5">
                                                <ItemStyle Width="110px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <%# (Eval("SETime5").ToString() != string.Empty ? Eval("SETime5").ToString().Substring(0, Eval("SETime5").ToString().IndexOf("!")) : Eval("SETime5"))%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="In6">
                                                <ItemStyle Width="110px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <%# (Eval("SETime6").ToString() != string.Empty ? Eval("SETime6").ToString().Substring(0, Eval("SETime6").ToString().IndexOf("!")) : Eval("SETime6"))%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <RowStyle CssClass="RowStyle" />
                                        <FooterStyle CssClass="FooterStyle" />
                                        <PagerStyle CssClass="PagerStyle" />
                                        <SelectedRowStyle CssClass="SelectedRowStyle" />
                                        <HeaderStyle CssClass="HeaderStyle1" />
                                        <EditRowStyle BackColor="#999999" />
                                        <AlternatingRowStyle CssClass="AltRowStyle" />
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="10" align="center" valign="middle">
                                    <asp:Label ID="lblSaveMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
