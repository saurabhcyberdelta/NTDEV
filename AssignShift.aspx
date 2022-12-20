<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true" CodeFile="AssignShift.aspx.cs" Inherits="AssignShift" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
    <table width="100%">
        <tr>
            <td align="center" width="100%">
                <table width="100%" style="position:absolute;top:16%;left:-8%;">
                    <tr>
                        <td align="center">
                            <b>Partner ID's:</b>
                            <br />
                            <br />
                            <asp:TextBox ID="txtEmpIDs" runat="server" TextMode="MultiLine" Columns="36" Rows="6"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmpIDs"
                                        Display="Dynamic" ErrorMessage="Please Enter PartnerId" ValidationGroup="search"
                                        SetFocusOnError="True">*</asp:RequiredFieldValidator>
                <br />
                            <br />
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="Button" OnClick="btnSearch_Click"
                                        ValidationGroup="search" />
                        </td>
                    </tr>
                    <tr>
            <td colspan="2" align="center">
                <asp:GridView ID="grdEmployeeSchedule" runat="server" AutoGenerateColumns="False"
                                                        AllowPaging="False" DataKeyNames="EmployeeId" CssClass="GridView" EmptyDataText="No Record were found."
                                                        Width="50%" BorderWidth="0px" ShowFooter="True">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="ID">
                                                                <ItemStyle Width="5px" />
                                                                <HeaderTemplate>
                                                                    <asp:CheckBox ID="chkBxHeader" AutoPostBack="true" OnCheckedChanged="CheckAll" runat="server" />
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkBxEmpId" runat="server" />
                                                                    <asp:Label runat="server" ID="EmpID" Text='<%# Eval( "EmployeeId" ) %>' Visible="false"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="EmpName">
                                                                <ItemStyle Width="50%" HorizontalAlign="Left" />
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkBtnEmpName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EmpName") %>'
                                                                         CssClass="linkButton"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="G">
                                                                <ItemStyle Width="5px" />
                                                                <ItemTemplate>
                                                                    <img id="imgGeoCode" src='<%# CheckImage(DataBinder.Eval(Container.DataItem, "geoCode")) %>'
                                                                        alt="GeoCode" width="15" height="15" /><br />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="T">
                                                                <ItemStyle Width="5px" />
                                                                <ItemTemplate>
                                                                    <img id="imgTptReq" src='<%# CheckTptReq(DataBinder.Eval(Container.DataItem, "tptReq")) %>'
                                                                        alt="Transport Required" width="15" height="15" /><br />
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
                                                        <EmptyDataRowStyle Font-Bold="true" ForeColor="Red" />
                                                    </asp:GridView>
            </td>
        </tr>
                </table>
                 
            </td>
            <td>
                <table align="right" border="1" width="400px" style="border-radius:5px;">
                                                            <tr>
                                                                <td width="350" align="center">
                                                                    <strong>&nbsp; Shift Time Pick</strong>
                                                                    <br />
                                                                    <asp:CheckBox ID="chkPick" runat="server" AutoPostBack="true" OnCheckedChanged="chkPick_CheckedChanged"/>
                                                                    <br />
                                                                </td>
                                                                <td width="350" align="center">
                                                                    <strong>&nbsp; Shift Time Drop</strong><br />
                                                                    <asp:CheckBox ID="chkDrop" runat="server" AutoPostBack="true" OnCheckedChanged="chkDrop_CheckedChanged"/>
                                                                    <br />
                                                                </td>
                                                               
                                                            </tr>
                                                            <tr>
                                                                <td width="350">
                                                                    <asp:CustomValidator ID="CustomValidator1" runat="server" Display="dynamic"
                                                                        Text="Select PickUp ShiftTime" ValidationGroup="grid" />
                                                                    <asp:CheckBoxList ID="ChkBxLstShiftTimePick" runat="server" CssClass="DetailsView"
                                                                        RepeatColumns="3" Width="200px">
                                                                    </asp:CheckBoxList>
                                                                </td>
                                                                <td width="350">
                                                                    <asp:CustomValidator ID="CustomValidator2" runat="server" Display="dynamic"
                                                                        Text="Select Drop ShiftTime" ValidationGroup="grid" />
                                                                    <asp:CheckBoxList ID="ChkBxLstShiftTimeDrop" runat="server" CssClass="DetailsView"
                                                                        RepeatColumns="3" Width="200px">
                                                                    </asp:CheckBoxList>
                                                                </td>
                                                            </tr>
                    <tr>
                        <td colspan="4" align="center">
                            <asp:checkbox id="chkIsWeekend" text="IsWeekend" runat="server" ValidationGroup="search"></asp:checkbox>
                            <asp:Button ID="btnAssignShift" runat="server" Text="Assign Shift" CssClass="Button"
                                        ValidationGroup="search" OnClick="btnAssignShift_Click" />
                        </td>
                    </tr>
                                                        </table>
            </td>
        </tr>
        
    </table>
                                                        
      </ContentTemplate>
    </asp:UpdatePanel>                                           
</asp:Content>

