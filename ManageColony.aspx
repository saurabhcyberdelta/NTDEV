<%@ Page Title="Manage Colony" Language="C#" MasterPageFile="~/eTMSMaster.master"
    AutoEventWireup="true" CodeFile="ManageColony.aspx.cs" Inherits="ManageColony" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblErrorMsg" runat="server" Visible="False" CssClass="error"></asp:Label>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table width="90%">
                <tr>
                    <td align="left">
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="Manage Colony" CssClass="heading"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <asp:Label ID="Label2" runat="server" Text="Allow User to Add/Edit/Move Colonies"
                            CssClass="subHeading"></asp:Label>
                    </td>
                </tr>
            </table>
            
            <br />
            <br />
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                DisplayAfter="0">
                <ProgressTemplate>
                    <table align="center">
                        <tr>
                            <td>
                                <img src="images/ajax-loader.gif" style="width: 16px; height: 16px" alt="Loading...." />
                            </td>
                            <td class="processing">
                                Loading.....Please Wait!!!
                            </td>
                        </tr>
                    </table>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:Label ID="lblMessage" Visible="False" runat="server" CssClass="message"></asp:Label>
            <asp:GridView ID="gvRouteSequence" runat="server" AutoGenerateColumns="False" DataKeyNames="RouteID"
                Width="100%" OnRowCommand="gvRouteSequence_RowCommand" CssClass="grid" ForeColor="Black">
                <Columns>
                    <asp:TemplateField HeaderText="Route No">
                        <ItemTemplate>
                            <asp:ImageButton ID="imgbtnExpand" runat="server" CausesValidation="False" CommandName="expand"
                                ImageUrl="~/images/plus.gif" />
                            <asp:ImageButton ID="imgbtnClose" runat="server" CausesValidation="False" CommandName="close"
                                ImageUrl="~/images/minus.gif" Visible="False" />
                            <asp:Label ID="lblRouteID" runat="server" Text='<%# Eval("RouteID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Zone">
                        <ItemTemplate>
                            <asp:Label ID="lblZoneName" runat="server" Text='<%# Eval("zoneName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Colony">
                        <ItemTemplate>
                            <asp:Label ID="lblColony" runat="server" Text='<%# Eval("Colony") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <tr>
                                <td colspan="4" align="center">
                                    <asp:GridView ID="gvColony" runat="server" Width="90%" DataKeyNames="Id,RouteID,Location"
                                        Visible="False" AutoGenerateColumns="False" OnRowDeleting="gvColony_RowDeleting"
                                        OnRowEditing="gvColony_RowEditing" OnRowCancelingEdit="gvColony_RowCancelingEdit"
                                        OnRowCommand="gvColony_RowCommand" OnRowUpdating="gvColony_RowUpdating" > 
                                        <RowStyle BackColor="#EFF3FB" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="SeqID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSeqId" runat="server" Text='<%# Eval("SeqId") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:Label ID="lblSeqId" runat="server" Text='<%# Eval("SeqId") %>'></asp:Label>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="City">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCity" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="ddlCity" runat="server" Enabled="false">
                                                    </asp:DropDownList>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Colony">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblColony" runat="server" Text='<%# Eval("Colony") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtColony" Enabled="false" Width="200Px" MaxLength="100" runat="server"
                                                        Text='<%# Eval("Colony") %>'></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFVtxtColony" runat="server" ControlToValidate="txtColony"
                                                        ErrorMessage="Enter Colony" Display="Dynamic" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Zone">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblZoneName" runat="server" Text='<%# Eval("ZoneName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="ddlZoneName" runat="server">
                                                    </asp:DropDownList>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Bus">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBus" runat="server" Text='<%# Eval("Bus") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="ddlBus" runat="server">
                                                        <asp:ListItem Text="No" Value="false"></asp:ListItem>
                                                        <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Metro">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMetro" runat="server" Text='<%# Eval("Metro") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="ddlMetro" runat="server">
                                                        <asp:ListItem Text="No" Value="false"></asp:ListItem>
                                                        <asp:ListItem Text="Yes" Value="True"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="T Time">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTravelTime" runat="server" Text='<%# Eval("travelTime") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtTravelTime" Width="50Px" MaxLength="3" runat="server" Text='<%# Eval("travelTime") %>'></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFVtxtTravelTime" runat="server" ControlToValidate="txtTravelTime"
                                                        ErrorMessage="Enter Travel Time" Display="Dynamic" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                    <asp:RangeValidator ID="RVtxtTravelTime" runat="server" ControlToValidate="txtTravelTime"
                                                        ErrorMessage="Enter Valid Travel Time" Display="Dynamic" MaximumValue="999" MinimumValue="1"
                                                        SetFocusOnError="True" Type="Integer">*</asp:RangeValidator>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Km">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTravelKm" runat="server" Text='<%# Eval("travelKm") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtTravelKm" Width="50Px" MaxLength="3" runat="server" Text='<%# Eval("travelKm") %>'></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RFVtxtTravelKm" runat="server" ControlToValidate="txtTravelKm"
                                                        ErrorMessage="Enter Travel Km" Display="Dynamic" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                    <asp:RangeValidator ID="RVtxtTravelKm" runat="server" ControlToValidate="txtTravelKm"
                                                        ErrorMessage="Enter Valid Travel Km" Display="Dynamic" MaximumValue="999" MinimumValue="1"
                                                        SetFocusOnError="True" Type="Integer">*</asp:RangeValidator>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="imgBtnCut" runat="server" ImageUrl="~/images/cut1.jpg" ToolTip="Cut"
                                                        CommandName="Cut" CommandArgument='<%#((GridViewRow)Container).RowIndex%>' 
                                                        Height="20px" Width="20px"></asp:ImageButton>
                                                    <asp:ImageButton ID="imgBtnPaste" runat="server" ImageUrl="~/images/paste1.jpg"
                                                        ToolTip="Paste" CommandName="Paste" 
                                                        CommandArgument='<%#((GridViewRow)Container).RowIndex%>' Height="20px" 
                                                        Width="20px">
                                                    </asp:ImageButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ShowHeader="False">
                                                <EditItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                        Text="Update"></asp:LinkButton>
                                                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                        Text="Cancel"></asp:LinkButton>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                        Text="Edit"></asp:LinkButton>
                                                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                                        Text="Delete"></asp:LinkButton>
                                                    <cc1:ConfirmButtonExtender ID="LinkButton2_ConfirmButtonExtender" runat="server"
                                                        ConfirmText="Delete this Colony?" Enabled="True" TargetControlID="LinkButton2">
                                                    </cc1:ConfirmButtonExtender>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbtnNew" runat="server" CausesValidation="false" CommandName="Insert"
                                                        CommandArgument='<%#((GridViewRow)Container).RowIndex%>' Text="New">
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#FF3300" Font-Bold="True" ForeColor="#1791B7" />
                                        <HeaderStyle BackColor="#1791B7" Font-Bold="True" />
                                        <EditRowStyle BackColor="#FF3300" />
                                        <AlternatingRowStyle BackColor="White" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#FF3300" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#1791B7" Font-Bold="True" ForeColor="Black" />
                <EditRowStyle BackColor="#999999" />
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
