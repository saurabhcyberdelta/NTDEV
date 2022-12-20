<%@ Page Title="" Language="C#" MasterPageFile="~/eTMSMaster.Master" AutoEventWireup="true"
    CodeFile="Employeemast1.aspx.cs" Inherits="Employeemast1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   <script type="text/javascript">
       function CalenderShown(sender, args)
    {
        sender._popupBehavior._element.style.zIndex = 1000005;
    }
</script>

    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table width="100%" align="center">
                <tr>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="addemp" />
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="editemp" />
                    <asp:ValidationSummary ID="ValidationSummary3" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="addgeo" />
                    <asp:ValidationSummary ID="ValidationSummary4" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="editgeo" />
                    <asp:ValidationSummary ID="ValidationSummary5" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="search" />
                    <td align="center">
                        <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="heading">
                        <div class="gradient2">
                            <h1>
                                <span></span>Partner Master
                            </h1>
                            <h2>
                                Allows User to View/Edit and Add New Partner Information.
                            </h2>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch">
                            <table align="center" width="60%">
                                <tr>
                                    <td width="30%">
                                        Enter Partner ID or Name:
                                    </td>
                                    <td width="20%" align="left">
                                        <asp:TextBox ID="txtEmpIdName" runat="server" CssClass="TextBox1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmpIdName"
                                            Display="Dynamic" ErrorMessage="Please Enter Name or Id" ValidationGroup="search"
                                            SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td width="10%">
                                        <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search"
                                            ValidationGroup="search" CssClass="Button" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td width="20%" align="center" colspan="3">
                                        <asp:LinkButton ID="lbtnAddnew" runat="server" CausesValidation="False" OnClick="lbtnAddnew_Click">Add New Partner</asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="center">
                                        <asp:Label ID="lblMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:MultiView ID="MultiView1" runat="server">
                            <table align="center" width="90%">
                                <tr>
                                    <td align="center">
                                        <asp:View ID="View1" runat="server">
                                            <table width="80%" align="center">
                                                <tr>
                                                    <td align="center" width="100%">
                                                        <asp:GridView ID="GvEmployee" runat="server" AutoGenerateColumns="False" CssClass="GridView"
                                                            DataKeyNames="Id" OnPageIndexChanging="GvEmployee_PageIndexChanging" OnSelectedIndexChanging="GvEmployee_SelectedIndexChanging"
                                                            AllowPaging="True" BorderWidth="0" ShowFooter="True" Width="100%">
                                                            <Columns>
                                                                <asp:CommandField SelectText="Edit Details" ShowSelectButton="True" />
                                                                <asp:TemplateField HeaderText="Partner Id">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblEmpId" runat="server" Text='<%# Eval("empCode") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Partner Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblEmpName" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Process">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblEmpProcess" runat="server" Text='<%# Eval("processName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Facility">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblEmpFacility" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="E-mail">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblEmpEmail" runat="server" Text='<%# Eval("email") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
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
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:View>
                                    </td>
                                </tr>
                            </table>
                        </asp:MultiView>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <asp:MultiView ID="MultiView2" runat="server">
                            <asp:View ID="View2" runat="server">
                                <asp:Button ID="Button2" runat="server" Style="visibility: hidden" />
                                <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" Enabled="True" BackgroundCssClass="modalBackground"
                                    TargetControlID="Button2" PopupControlID="Panel3" DropShadow="false" CancelControlID="Button1">
                                </cc1:ModalPopupExtender>
                                <asp:Panel ID="Panel3" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                    CssClass="modal2">
                                    <cc1:TabContainer ID="AJX" runat="server" CssClass="fancy">
                                        <cc1:TabPanel ID="TabPanel1" runat="server" HeaderText="Personal Details">
                                            <HeaderTemplate>
                                                Personal Details
                                            </HeaderTemplate>
                                            <ContentTemplate>
                                                <asp:FormView ID="fvEmployee" runat="server" DefaultMode="Edit" Width="100%" BorderStyle="Ridge"
                                                    BorderColor="Black" BorderWidth="0px" CssClass="tableBorber">
                                                    <EditItemTemplate>
                                                        <table class="tableBorber" width="100%" align="center">
                                                            <tr>
                                                                <td colspan="6" class="row1">
                                                                    <b>Edit Partner Details</b>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="14%" class="myTableRowStyle">
                                                                    Partner Id:
                                                                </td>
                                                                <td width="21%" class="myTableRowStyle">
                                                                    <asp:TextBox ID="txtdvEmpId" runat="server" ReadOnly="true" Text='<%# Eval("empCode") %>'
                                                                        MaxLength="15" CssClass="TextBox"></asp:TextBox>
                                                                </td>
                                                                <td width="14%" class="myTableRowStyle">
                                                                    Partner Name:
                                                                </td>
                                                                <td width="21%" class="myTableRowStyle">
                                                                    <asp:TextBox ID="txtdvEmpName" runat="server" Text='<%# Eval("empName") %>' MaxLength="30"
                                                                        CssClass="TextBox1" ValidationGroup="editemp"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtdvEmpName"
                                                                        Display="Dynamic" ErrorMessage="Enter Partner Name" ValidationGroup="editemp"
                                                                        SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Please enter only character value in Partner name."
                                                                        SetFocusOnError="True" Text="*" ValidationGroup="editemp" ValidationExpression="^[a-zA-Z\s]+$"
                                                                        ControlToValidate="txtdvEmpName"></asp:RegularExpressionValidator>
                                                                </td>
                                                                <td width="14%" class="myTableRowStyle">
                                                                    User Name:
                                                                </td>
                                                                <td width="12%" class="myTableRowStyle">
                                                                    <asp:TextBox ID="txtdvUserName" runat="server" Text='<%# Eval("userName") %>' MaxLength="20"
                                                                        CssClass="TextBox"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                    Gender:
                                                                </td>
                                                                <td width="23%" class="myTableAltRowStyle">
                                                                    <asp:RadioButton ID="rdbtndvM" runat="server" Checked='<%# Convert.ToString(Eval("Gender"))=="M"?true:false %>'
                                                                        GroupName="gender" Text="M" />
                                                                    <asp:RadioButton ID="rdbtndvF" runat="server" Checked='<%# Convert.ToString(Eval("Gender"))=="F"?true:false %>'
                                                                        GroupName="gender" Text="F" />
                                                                    
                                                                    <asp:RadioButton ID="rdbtndvT" runat="server" Checked='<%# Convert.ToString(Eval("Gender"))=="T"?true:false %>'
                                                                        GroupName="gender" Text="Transgender " />
                                                                    <asp:RadioButton ID="rdbtndvO" runat="server" Checked='<%# Convert.ToString(Eval("Gender"))=="O"?true:false %>'
                                                                        GroupName="gender" Text="Other" />
                                                                </td>
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                    Mobile:
                                                                </td>
                                                                <td width="23%" class="myTableAltRowStyle" valign="middle">
                                                                    <asp:TextBox ID="txtdvMobile" runat="server" CssClass="TextBox" MaxLength="12" Text='<%# Eval("mobile") %>'></asp:TextBox>
                                                                </td>
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                    Phone:
                                                                </td>
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                    <asp:TextBox ID="txtdvPhone" runat="server" CssClass="TextBox" MaxLength="12" Text='<%# Eval("phone") %>'></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="12%" class="myTableRowStyle">
                                                                    E-mail:
                                                                </td>
                                                                <td width="23%" class="myTableRowStyle">
                                                                    <asp:TextBox ID="txtdvEmail" runat="server" CssClass="TextBox1" MaxLength="30" Text='<%# Eval("email") %>'
                                                                        ValidationGroup="editemp"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtdvEmail"
                                                                        Display="Dynamic" ErrorMessage="Enter Valid E-Mail" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                                        ValidationGroup="editemp">*</asp:RegularExpressionValidator>
                                                                </td>
                                                                <td width="12%" class="myTableRowStyle">
                                                                    Tpt Required:
                                                                </td>
                                                                <td width="23%" class="myTableRowStyle">
                                                                    <asp:CheckBox ID="chkdvTptReq" Enabled="false" runat="server" Checked='<%# Convert.ToString(Eval("tptReq"))=="Y"?true:false %>'
                                                                        Text=" " />
                                                                </td>
                                                                <td width="12%" class="myTableRowStyle">
                                                                    Attrited:
                                                                </td>
                                                                <td width="12%" class="myTableRowStyle">
                                                                    <asp:CheckBox ID="chkdvAttrited" runat="server" Checked='<%# Convert.ToString(Eval("attrited"))=="Y"?true:false %>'
                                                                        Text=" " />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                    Manager:
                                                                </td>
                                                                <td width="23%" class="myTableAltRowStyle">
                                                                    <asp:DropDownList ID="ddldvManager" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                    </asp:DropDownList>
                                                                    &nbsp;
                                                                </td>
                                                                
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                Division Manager
                                                                </td>
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                    <asp:DropDownList ID="ddldvisionManager" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                    </asp:DropDownList>
                                                                
                                                                </td>
                                                                  <td width="12%" class="myTableAltRowStyle">
                                                                   Cost Center
                                                                </td>
                                                                <td width="23%" class="myTableAltRowStyle">
                                                                    <asp:DropDownList ID="ddlCostcenter" runat="server" AppendDataBoundItems="true">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                 
                                                               
                                                            </tr>
                                                            <tr>
                                                             <td width="12%" class="myTableRowStyle">
                                                                    Facility:
                                                                </td>
                                                                <td width="23%" class="myTableRowStyle">
                                                                    <asp:DropDownList ID="ddldvFacility" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3"
                                                                        ValidationGroup="editemp">
                                                                    </asp:DropDownList>
                                                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddldvFacility"
                                                                        Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="editemp"
                                                                        ValueToCompare="0">*</asp:CompareValidator>
                                                                </td>
                                                             <td width="12%" class="myTableRowStyle">
                                                                    Process:
                                                                </td>
                                                                <td width="23%" valign="middle" class="myTableRowStyle">
                                                                    <asp:DropDownList ID="ddldvProcess" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                        OnSelectedIndexChanged="ddldvProcess_SelectedIndexChanged" CssClass="DropDownListBox3">
                                                                    </asp:DropDownList>
                                                                </td>
                                                              <td width="12%" class="myTableRowStyle">
                                                                    Sub Process:
                                                                </td>
                                                                <td width="12%" class="myTableRowStyle">
                                                                    <asp:DropDownList ID="ddldvSubProcess" runat="server" AppendDataBoundItems="True"
                                                                        CssClass="DropDownListBox3">
                                                                    </asp:DropDownList>
                                                                </td>
                                                              
                                                            </tr>
                                                              <tr>
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                   Special Case:
                                                                </td>
                                                                <td width="23%" class="myTableAltRowStyle">
                                                                    <asp:CheckBox ID="chkspecialCase" runat="server" AutoPostBack="true"  Checked='<%# Convert.ToString(Eval("SpecialCase"))=="1"?true:false %>'
                                                                        oncheckedchanged="chkspecialCase_CheckedChanged" />
                                                                    &nbsp;
                                                                </td>
                                                                
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                    <asp:Label ID="lblFromDate" runat="server" Text="From Date:" Visible="false"></asp:Label>
                                                                    <asp:TextBox ID="txtFromDate" runat="server" Visible="false" CssClass="TextBox"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtFromDate"
                                                                   Display="Dynamic" ErrorMessage="Enter Valid Start Date" enabled="false" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                  ValidationGroup="editemp">*</asp:RegularExpressionValidator>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Enabled="false" Display="Dynamic" ErrorMessage="From Date Required" ValidationGroup="editemp" ControlToValidate="txtFromDate">*</asp:RequiredFieldValidator>
                                                                </td>
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                    <asp:Label ID="lbltoDate" runat="server" Text="To Date:" Visible="false"></asp:Label>
                                                                  <asp:TextBox ID="txttoDate" runat="server" Visible="false" CssClass="TextBox"></asp:TextBox>
                                                                       <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txttoDate"
                                                                   Display="Dynamic" ErrorMessage="Enter Valid End Date" enabled="true" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                  ValidationGroup="editemp">*</asp:RegularExpressionValidator>
                                                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ValidationGroup="editemp" Display="Dynamic"
                                                                     ErrorMessage="From Date Could not be greater than To Date" ControlToValidate="txttoDate"  Enabled="false" ControlToCompare="txtFromDate" Type="Date" Operator="GreaterThan">*</asp:CompareValidator>
                                                                   <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Enabled="false" Display="Dynamic" ErrorMessage="From Date Required" ValidationGroup="editemp" ControlToValidate="txttoDate">*</asp:RequiredFieldValidator>
                                                                    
                                                                </td>
                                                                  <td width="12%" class="myTableAltRowStyle">
                                                                      Partner with Disability :
                                                                </td>
                                                                <td width="23%" class="myTableAltRowStyle">
                                                                    <asp:CheckBox ID="ChkDisability" runat="server"/>
                                                                
                                                                </td>
                                                                 
                                                               
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                    <EditRowStyle BackColor="White" />
                                                    <FooterStyle CssClass="FooterStyle" />
                                                    <InsertItemTemplate>
                                                        <table class="tableBorber" width="100%" align="center">
                                                            <tr>
                                                                <td colspan="6" class="row1">
                                                                    <b>Add Partner Details</b>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="14%" class="myTableRowStyle">
                                                                    Partner Id:
                                                                </td>
                                                                <td width="21%" class="myTableRowStyle">
                                                                    <asp:TextBox ID="txtdvEmpId" runat="server" Text='<%# Eval("empCode") %>' MaxLength="15"
                                                                        CssClass="TextBox"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtdvEmpId"
                                                                        Display="Dynamic" ErrorMessage="Enter Partner ID" ValidationGroup="editemp"
                                                                        SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                </td>
                                                                <td width="14%" class="myTableRowStyle">
                                                                    Partner Name:
                                                                </td>
                                                                <td width="21%" class="myTableRowStyle">
                                                                    <asp:TextBox ID="txtdvEmpName" runat="server" Text='<%# Eval("empName") %>' MaxLength="30"
                                                                        CssClass="TextBox1" ValidationGroup="editemp"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtdvEmpName"
                                                                        Display="Dynamic" ErrorMessage="Enter Partner Name" ValidationGroup="editemp"
                                                                        SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Please entry only character value in Partner name."
                                                                        SetFocusOnError="True" Text="*" ValidationGroup="editemp" ValidationExpression="^[a-zA-Z\s]+$"
                                                                        ControlToValidate="txtdvEmpName"></asp:RegularExpressionValidator>
                                                                </td>
                                                                <td width="14%" class="myTableRowStyle">
                                                                    User Name:
                                                                </td>
                                                                <td width="12%" class="myTableRowStyle">
                                                                    <asp:TextBox ID="txtdvUserName" runat="server" Text='<%# Eval("userName") %>' MaxLength="20"
                                                                        CssClass="TextBox"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                    Gender:
                                                                </td>
                                                                <td width="23%" class="myTableAltRowStyle">
                                                                    <asp:RadioButton ID="rdbtndvM" runat="server" Checked='<%# Convert.ToString(Eval("Gender"))=="M"?true:false %>'
                                                                        GroupName="gender" Text="M" />
                                                                    <asp:RadioButton ID="rdbtndvF" runat="server" Checked='<%# Convert.ToString(Eval("Gender"))=="F"?true:false %>'
                                                                        GroupName="gender" Text="F" />
                                                                    <asp:RadioButton ID="rdbtndvT" runat="server" Checked='<%# Convert.ToString(Eval("Gender"))=="T"?true:false %>'
                                                                        GroupName="gender" Text="Transgender" />
                                                                    <asp:RadioButton ID="rdbtndvO" runat="server" Checked='<%# Convert.ToString(Eval("Gender"))=="O"?true:false %>'
                                                                        GroupName="gender" Text="Other" />
                                                                </td>
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                    Mobile:
                                                                </td>
                                                                <td width="23%" class="myTableAltRowStyle" valign="middle">
                                                                    <asp:TextBox ID="txtdvMobile" runat="server" CssClass="TextBox" MaxLength="12" Text='<%# Eval("mobile") %>'></asp:TextBox>
                                                                </td>
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                    Phone:
                                                                </td>
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                    <asp:TextBox ID="txtdvPhone" runat="server" CssClass="TextBox" MaxLength="12" Text='<%# Eval("phone") %>'></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="12%" class="myTableRowStyle">
                                                                    E-mail:
                                                                </td>
                                                                <td width="23%" class="myTableRowStyle">
                                                                    <asp:TextBox ID="txtdvEmail" runat="server" CssClass="TextBox1" MaxLength="30" Text='<%# Eval("email") %>'
                                                                        ValidationGroup="editemp"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtdvEmail"
                                                                        Display="Dynamic" ErrorMessage="Enter Valid E-Mail" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                                        ValidationGroup="editemp">*</asp:RegularExpressionValidator>
                                                                </td>
                                                                <td width="12%" class="myTableRowStyle">
                                                                    Tpt Required:
                                                                </td>
                                                                <td width="23%" class="myTableRowStyle">
                                                                    <asp:CheckBox ID="chkdvTptReq" runat="server" Enabled="false" Checked='<%# Convert.ToString(Eval("tptReq"))=="Y"?true:false %>'
                                                                        Text=" " />
                                                                </td>
                                                                <td width="12%" class="myTableRowStyle">
                                                                    Attrited:
                                                                </td>
                                                                <td width="12%" class="myTableRowStyle">
                                                                    <asp:CheckBox ID="chkdvAttrited" runat="server" Checked='<%# Convert.ToString(Eval("attrited"))=="Y"?true:false %>'
                                                                        Text=" " />
                                                                </td>
                                                            </tr>
                                                           <tr>
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                    Manager:
                                                                </td>
                                                                <td width="23%" class="myTableAltRowStyle">
                                                                    <asp:DropDownList ID="ddldvManager" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                    </asp:DropDownList>
                                                                    &nbsp;
                                                                </td>
                                                                
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                Division Manager
                                                                </td>
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                    <asp:DropDownList ID="ddldvisionManager" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3">
                                                                    </asp:DropDownList>
                                                                
                                                                </td>
                                                                  <td width="12%" class="myTableAltRowStyle">
                                                                   Cost Center
                                                                </td>
                                                                <td width="23%" class="myTableAltRowStyle">
                                                                    <asp:DropDownList ID="ddlCostcenter" runat="server" AppendDataBoundItems="true">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                 
                                                               
                                                            </tr>
                                                            <tr>
                                                             <td width="12%" class="myTableRowStyle">
                                                                    Facility:
                                                                </td>
                                                                <td width="23%" class="myTableRowStyle">
                                                                    <asp:DropDownList ID="ddldvFacility" runat="server" AppendDataBoundItems="True" CssClass="DropDownListBox3"
                                                                        ValidationGroup="editemp">
                                                                    </asp:DropDownList>
                                                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddldvFacility"
                                                                        Display="Dynamic" ErrorMessage="Select Facility" Operator="NotEqual" ValidationGroup="editemp"
                                                                        ValueToCompare="0">*</asp:CompareValidator>
                                                                </td>
                                                             <td width="12%" class="myTableRowStyle">
                                                                    Process:
                                                                </td>
                                                                <td width="23%" valign="middle" class="myTableRowStyle">
                                                                    <asp:DropDownList ID="ddldvProcess" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                        OnSelectedIndexChanged="ddldvProcess_SelectedIndexChanged" CssClass="DropDownListBox3">
                                                                    </asp:DropDownList>
                                                                </td>
                                                              <td width="12%" class="myTableRowStyle">
                                                                    Sub Process:
                                                                </td>
                                                                <td width="12%" class="myTableRowStyle">
                                                                    <asp:DropDownList ID="ddldvSubProcess" runat="server" AppendDataBoundItems="True"
                                                                        CssClass="DropDownListBox3">
                                                                    </asp:DropDownList>
                                                                </td>
                                                              
                                                            </tr>
                                                              <tr>
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                   Special Case:
                                                                </td>
                                                                <td width="23%" class="myTableAltRowStyle">
                                                                    <asp:CheckBox ID="chkspecialCase" runat="server" AutoPostBack="true"   oncheckedchanged="chkspecialCase_CheckedChanged"/>
                                                                    &nbsp;
                                                                </td>
                                                                
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                    <asp:Label ID="lblFromDate" runat="server" Text="From Date:" Visible="false"></asp:Label>
                                                                    <asp:TextBox ID="txtFromDate" runat="server" Visible="false" CssClass="TextBox"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtFromDate"
                                                                   Display="Dynamic" ErrorMessage="Enter Valid Start Date" enabled="false" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                  ValidationGroup="editemp">*</asp:RegularExpressionValidator>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Enabled="false" Display="Dynamic" ErrorMessage="From Date Required" ValidationGroup="editemp" ControlToValidate="txtFromDate">*</asp:RequiredFieldValidator>
                                                                </td>
                                                                <td width="12%" class="myTableAltRowStyle">
                                                                    <asp:Label ID="lbltoDate" runat="server" Text="To Date:" Visible="false"></asp:Label>
                                                                  <asp:TextBox ID="txttoDate" runat="server" Visible="false" CssClass="TextBox"></asp:TextBox>
                                                                       <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txttoDate"
                                                                   Display="Dynamic" ErrorMessage="Enter Valid End Date" enabled="true" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                                  ValidationGroup="editemp">*</asp:RegularExpressionValidator>
                                                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ValidationGroup="editemp" Display="Dynamic"
                                                                     ErrorMessage="From Date Could not be greater than To Date" ControlToValidate="txttoDate"  Enabled="false" ControlToCompare="txtFromDate" Type="Date" Operator="GreaterThan">*</asp:CompareValidator>
                                                                   <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Enabled="false" Display="Dynamic" ErrorMessage="From Date Required" ValidationGroup="editemp" ControlToValidate="txttoDate">*</asp:RequiredFieldValidator>
                                                                    
                                                                </td>
                                                                  <td width="12%" class="myTableAltRowStyle">
                                                                      Partner with Disability :
                                                                </td>
                                                                <td width="23%" class="myTableAltRowStyle">
                                                                    <asp:CheckBox ID="ChkDisability" runat="server"/>
                                                                
                                                                </td>
                                                                 
                                                               
                                                            </tr>
                                                        </table>
                                                    </InsertItemTemplate>
                                                    <PagerStyle CssClass="PagerStyle" />
                                                    <RowStyle BackColor="White" />
                                                </asp:FormView>
                                            </ContentTemplate>
                                        </cc1:TabPanel>
                                        <cc1:TabPanel ID="TabPanel2" runat="server" HeaderText="Address Details">
                                            <ContentTemplate>
                                                <asp:FormView ID="fvadress" runat="server" DefaultMode="Edit" Width="100%" BorderStyle="Ridge"
                                                    BorderColor="Black" BorderWidth="0px" CssClass="tableBorber">
                                                    <EditItemTemplate>
                                                        <table class="tableBorber" width="100%" align="center">
                                                            <tr>
                                                                <td colspan="6" class="row1">
                                                                    <b>Edit Partner Address Details</b>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="myTableRowStyle" width="14%">
                                                                    Address:
                                                                </td>
                                                                <td style="text-align: left; width: 400px;" colspan="3" class="myTableRowStyle">
                                                                    <asp:TextBox ID="txtdvAddress" runat="server" TextMode="MultiLine" Width="400px"
                                                                        ValidationGroup="editemp" Height="75"></asp:TextBox>
                                                                    <br>
                                                                    Max 150 characters.
                                                                    <asp:RegularExpressionValidator ID="txtConclusionValidator1" ControlToValidate="txtdvAddress"
                                                                        ValidationExpression="^[\s\S]{0,150}$" runat="server" ValidationGroup="editemp"
                                                                        ErrorMessage="Address exceeding 150 characters." SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                    &nbsp;<asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="ddldvLandmark"
                                                                        Display="Dynamic" ErrorMessage="Transport is required so please enter address and do the geocode."
                                                                        OnServerValidate="CustomValidator1_ServerValidate" SetFocusOnError="True" ValidationGroup="editemp"></asp:CustomValidator>
                                                                </td>
                                                                <td class="myTableRowStyle" width="12%">
                                                                    Pincode:
                                                                </td>
                                                                <td class="myTableRowStyle" width="12%">
                                                                    <asp:TextBox ID="txtdvPincode" runat="server" MaxLength="6" CssClass="TextBox"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="myTableAltRowStyle" width="12%">
                                                                    City:
                                                                </td>
                                                                <td width="23%" class="myTableAltRowStyle">
                                                                    <asp:DropDownList ID="ddldvCity" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                        OnSelectedIndexChanged="ddldvCity_SelectedIndexChanged" CssClass="DropDownListBox3">
                                                                    </asp:DropDownList>
                                                                    &nbsp;
                                                                </td>
                                                                <td class="myTableAltRowStyle" width="12%">
                                                                Colony:
                                                                </td>
                                                                <td class="myTableAltRowStyle" width="23%">
                                                                    <asp:DropDownList ID="ddldvColony" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                        OnSelectedIndexChanged="ddldvColony_SelectedIndexChanged" CssClass="DropDownListBox3">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="myTableAltRowStyle">
                                                                  SubColony:
                                                                </td>
                                                                <td class="myTableAltRowStyle">
                                                                    <asp:DropDownList ID="ddldvSubColony" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                      CssClass="DropDownListBox3" OnSelectedIndexChanged="ddldvSubColony_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="myTableRowStyle" width="12%">
                                                                    Landmark:
                                                                </td>
                                                                <td class="myTableRowStyle" width="12%">
                                                                    <asp:DropDownList ID="ddldvLandmark" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                        OnSelectedIndexChanged="ddldvLandmark_SelectedIndexChanged" CssClass="DropDownListBox3">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="myTableRowStyle" width="12%">
                                                                    X-Cord:
                                                                </td>
                                                                <td class="myTableRowStyle" width="23%">
                                                                    <asp:Label ID="lblX" runat="server"></asp:Label>
                                                                </td>
                                                                <td class="myTableRowStyle" width="12%">
                                                                    Y-Cord:
                                                                </td>
                                                                <td class="myTableRowStyle" width="23%">
                                                                    <asp:Label ID="lblY" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <table class="tableBorber" width="100%" align="center">
                                                            <tr>
                                                                <td colspan="6" class="row1">
                                                                    <b>Add Partner Address Details</b>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="14%" class="myTableRowStyle">
                                                                    Address:
                                                                </td>
                                                                <td class="myTableRowStyle" width="400px" colspan="3">
                                                                    <asp:TextBox ID="txtdvAddress" runat="server" TextMode="MultiLine" Width="400px"
                                                                        ValidationGroup="editemp" Height="75"></asp:TextBox>
                                                                    <br>
                                                                    Max 150 characters.
                                                                    <asp:RegularExpressionValidator ID="txtConclusionValidator1" ControlToValidate="txtdvAddress"
                                                                        ValidationExpression="^[\s\S]{0,150}$" runat="server" ValidationGroup="editemp"
                                                                        ErrorMessage="Address exceeding 150 characters." SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                                                    &nbsp;<asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="ddldvLandmark"
                                                                        Display="Dynamic" ErrorMessage="Transport is required so please enter address and do the geocode."
                                                                        OnServerValidate="CustomValidator2_ServerValidate" SetFocusOnError="True" ValidationGroup="editemp"></asp:CustomValidator>
                                                                </td>
                                                                <td class="myTableRowStyle" width="12%">
                                                                    Pincode:
                                                                </td>
                                                                <td class="myTableRowStyle" width="12%">
                                                                    <asp:TextBox ID="txtdvPincode" runat="server" MaxLength="6" CssClass="TextBox"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="myTableAltRowStyle" width="12%">
                                                                    City:
                                                                </td>
                                                                <td class="myTableAltRowStyle" width="23%">
                                                                    <asp:DropDownList ID="ddldvCity" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                        OnSelectedIndexChanged="ddldvCity_SelectedIndexChanged" CssClass="DropDownListBox3">
                                                                    </asp:DropDownList>
                                                                    &nbsp;
                                                                </td>
                                                                <td class="myTableAltRowStyle" width="12%">
                                                                    Colony:
                                                                </td>
                                                                <td class="myTableAltRowStyle" width="23%">
                                                                    <asp:DropDownList ID="ddldvColony" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                        OnSelectedIndexChanged="ddldvColony_SelectedIndexChanged" CssClass="DropDownListBox3">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                 <td class="myTableAltRowStyle">
                                                                  SubColony:
                                                                </td>
                                                                <td class="myTableAltRowStyle">
                                                                    <asp:DropDownList ID="ddldvSubColony" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                      CssClass="DropDownListBox3" OnSelectedIndexChanged="ddldvSubColony_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="myTableRowStyle" width="12%">
                                                                    Landmark:
                                                                </td>
                                                                <td class="myTableRowStyle" width="12%">
                                                                    <asp:DropDownList ID="ddldvLandmark" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                                        OnSelectedIndexChanged="ddldvLandmark_SelectedIndexChanged" CssClass="DropDownListBox3">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="myTableRowStyle" width="12%">
                                                                    X-Cord:
                                                                </td>
                                                                <td class="myTableRowStyle" width="23%">
                                                                    <asp:Label ID="lblX" runat="server"></asp:Label>
                                                                </td>
                                                                <td class="myTableRowStyle" width="12%">
                                                                    Y-Cord:
                                                                </td>
                                                                <td class="myTableRowStyle" width="23%">
                                                                    <asp:Label ID="lblY" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </InsertItemTemplate>
                                                    <RowStyle BackColor="White" />
                                                    <FooterStyle CssClass="FooterStyle" />
                                                    <PagerStyle CssClass="PagerStyle" />
                                                    <EditRowStyle BackColor="White" />
                                                </asp:FormView>
                                            </ContentTemplate>
                                        </cc1:TabPanel>
                                    </cc1:TabContainer>
                                    <table width="100%" align="center" class="tableBorber">
                                        <tr>
                                            <td align="center" class="row2" valign="middle">
                                                <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" Width="90px"
                                                    CssClass="Button" ValidationGroup="editemp" />
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:Button ID="Button1" runat="server" OnClick="btnClose_Click" Text="Close" Width="90px"
                                                    CssClass="Button" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </asp:View>
                        </asp:MultiView>
                    </td>
                </tr>
                <tr>
                    <td align="center">
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
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
