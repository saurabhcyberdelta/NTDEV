<%@ Page Language="C#" MasterPageFile="~/gMAP.master" AutoEventWireup="true" CodeFile="MapGeocoding.aspx.cs"
    Inherits="MapGeocoding" Title="Map Geocoding" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDiwfV12HbsehWrFbKXBbv8BF5wCmUB4g8"
        type="text/javascript"></script>

    <script type="text/javascript">
        function SearchAddress() {
            var searchAddress = document.getElementById("txtSearch").value;
            document.getElementById('<%= hfLatitude.ClientID %>').value = "0";
            document.getElementById('<%= hfLongitude.ClientID %>').value = "0";
            document.getElementById('<%= hfAddress.ClientID %>').value = searchAddress;
            initialize();
            return false;
        }
    </script>

    <script type="text/javascript">
        function showAddress(address) {
            if (geocoder) {
                geocoder.geocode({ 'address': address }, function(results, status) {
                    if (status != google.maps.GeocoderStatus.OK) {
                        alert(address + " not found");
                    }
                    else {
                        //  gmap.setCenter(point, 13);
                        var marker = new google.maps.Marker({
                            map: gmap,
                            position: results[0].geometry.location
                        });
                        marker.setDraggable(true);
                        point = results[0].geometry.location;

                      
                        gmap.panTo(point);
                       
                        document.getElementById('<%= lblgeoX.ClientID %>').innerHTML = point.lng();
                        document.getElementById('<%= lblgeoY.ClientID %>').innerHTML = point.lat();
                        document.getElementById('<%= hfgeoX.ClientID %>').value = point.lng();
                        document.getElementById('<%= hfgeoY.ClientID %>').value = point.lat();
                        var location = point.lat() + ',' + point.lng();
                        geocode(location,marker);
                        google.maps.event.addListener(marker, "dragend", function() {
                            var point = marker.position;
                            updateLatLonFields(point.lat(), point.lng());
                            var location = point.lat() + ',' + point.lng();
                            geocode(location,marker);
                        });
                    }
                }
        		);
            }
        }


        var map;
        var infowindow = new google.maps.InfoWindow();
        var gdir;
        var addressMarker;
        var waypoints =
		["28.4299, 77.1057", "28.5417, 77.2552", "28.6044, 77.3566"];
        var fromaddress = "28.49543,77.0921";


        var toaddress = "28.5752,77.1747";

        function updateLatLonFields(lat, lon) {
           
            document.getElementById('<%= lblgeoX.ClientID %>').innerHTML = lon;
            document.getElementById('<%= lblgeoY.ClientID %>').innerHTML = lat;
            document.getElementById('<%= hfgeoX.ClientID %>').value = lon;
            document.getElementById('<%= hfgeoY.ClientID %>').value = lat;
           
        }

        function initialize() {
            var IsPasePostBack = "<%=_IsPasePostBack%>";
            if (IsPasePostBack == "true") {
             
                {
                    var latlng = new google.maps.LatLng(-34.397, 150.644);
                    var myOptions = {
                        zoom: 12,
                        center: latlng,
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                       
                    }
                  gmap=  new google.maps.Map(document.getElementById("map_canvas"), myOptions);
            
                 window.geocoder = new google.maps.Geocoder();
                  
                google.maps.event.addListener(gmap, "move", function() {
                       var center = gmap.getCenter();
                       updateLatLonFields(center.lat(), center.lng());
                    });
 google.maps.event.addListener(gmap, "zoomend", function(oldZoom, newZoom) {
                        document.getElementById("zoom").innerHTML = newZoom;
                    });
               google.maps.event.addDomListener(document.getElementById('crosshair'), 'dblclick', function() {
                        gmap.zoomIn();
                   });

                    // Default view of the world
                    var _Latitude = document.getElementById('<%= hfLatitude.ClientID %>').value;
                    var _Longitude = document.getElementById('<%= hfLongitude.ClientID %>').value;
                    var _Address = document.getElementById('<%= hfAddress.ClientID %>').value;
                    if (_Latitude == '0' && _Longitude == '0') {
                        showAddress(_Address);
                        document.getElementById("GeocodeHeader").innerHTML = "Information for this employee has not been geo-coded";
                    }
                    else {
                        var latlng = new google.maps.LatLng(_Latitude, _Longitude);
                   
                        document.getElementById('<%= lblgeoX.ClientID %>').innerHTML = _Longitude;
                        document.getElementById('<%= lblgeoY.ClientID %>').innerHTML = _Latitude;
                        document.getElementById('<%= hfgeoX.ClientID %>').value = _Longitude;
                        document.getElementById('<%= hfgeoY.ClientID %>').value = _Latitude;
                        document.getElementById("GeocodeHeader").innerHTML = "Information for this employee has been geo-coded";
                        var marker;
                        marker = new google.maps.Marker({
                            position: latlng,
                            map: gmap
                        });
                        geocoder.geocode({ 'latLng': latlng }, function(results, status) {
                            if (status == google.maps.GeocoderStatus.OK) {
                            
                                    gmap.setZoom(11);
                                   

                                    geocode(results[0].formatted_address, marker);

                                    marker.setDraggable(true);
                                
                            }
                        });
                        google.maps.event.addListener(marker, "dragend", function() {
                            var point = marker.position;
                            updateLatLonFields(point.lat(), point.lng());
                            var location = point.lat() + ',' + point.lng();
                            geocode(location,marker);
                        });
                       // gmap.addOverlay(marker);
                    };
                }
            }
        }
        function geocode(location,marker) {
            geocoder.geocode({ 'address': location }, function(results, status) {
                geocodeComplete(results, status,marker);
            });
        }


        function geocodeComplete(result, status,marker) {
            if (status != google.maps.GeocoderStatus.OK) {
                alert('Could not geocode "' + result.name + '"');
                return;
            }
             coordinate = result[0].geometry.location;
             place = result[0].formatted_address;
         //   var placemark = result.Placemark[0]; // Only use first result
            //var accuracy = placemark.AddressDetails.Accuracy;
//            var Address = reverse(place.address);
             Address = place.split(",");
            var LandMark = "";
           var subcolony = "";
            if (Address[0] != null) {
              LandMark = (Address[0]);
            }
           if (Address[1] != null) {
               subcolony = (Address[1]);
            }
            //var LandMark = reverse(Address[4]);
          
             infowindow.setContent( '<b>LatLng: </b>' + coordinate.lat() + "," + coordinate.lng() + '<br>' +
              '<b>Address: </b>' + place);
       infowindow.open(gmap, marker);
             



            document.getElementById('<%= txtLandmark.ClientID %>').value = LandMark;
            document.getElementById('<%= txtSubcolony.ClientID %>').value = subcolony;
            
         
           document.getElementById('<%= hfLandmark.ClientID %>').value = LandMark;
        
        }
        function reverse(Address) {
            var inp = Address;
            var outp = "";

            for (i = 0; i <= inp.length; i++) {
                outp = inp.charAt(i) + outp
            }
            return outp;
        }

        function roundVal(val) {
            var dec = 4;
            var result = Math.round(val * Math.pow(10, dec)) / Math.pow(10, dec);
            return result;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table align="center" width="100%">
        <tr>
            <td>
                <table align="center" border="0" style="width: 100%">
                    <tr>
                        <td align="center">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                ShowSummary="False" ValidationGroup="search" />
                                 <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                                ShowSummary="False" ValidationGroup="Save" />
                            <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="heading">
                            <div class="gradient2">
                                <h1>
                                    <span></span>Geo Code Partner by Map</h1>
                                <h2>
                                    Geo Code Partner information by defining the X-Y co-ordinates.</h2>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left">
                <table align="left" width="40%" cellpadding="4" cellspacing="0">
                    <tr>
                        <td align="center">
                            <asp:GridView ID="GvEmpCount" runat="server" AutoGenerateColumns="False"
                                Width="100%" BorderWidth="0" >
                                
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnFac" runat="server" CommandArgument='<%# Eval("Id") %>' CommandName="Select"
                                                Text='<%# "Total No of Partners Not Geo Coded in " + Eval("facilityName")+ " :" %>'
                                                CausesValidation="False" OnClick="lbtnFac_Click"></asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="left" Width="80%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmpCount" runat="server" Text='<%# Eval("Count") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" Width="20%" />
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
                            
                             <asp:GridView ID="gvNotGeocoded" runat="server" AutoGenerateColumns="False"
                                Width="100%" BorderWidth="0" ShowHeader="false" ShowFooter="true">
                                
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnNonGeocodeFac" runat="server" CommandArgument='<%# Eval("Id") %>' CommandName="Select"
                                                Text='<%# "Total No of Address Changed Partners Not Geo Coded in " + Eval("facilityName")+ " :" %>'
                                                CausesValidation="False" OnClick="lbtnNonGeocodeFac_Click"></asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="left" Width="80%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmpCount" runat="server" Text='<%# Eval("Count") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" Width="20%" />
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
                </table>
            </td>
        </tr>
        <tr>
            <td align="left">
                <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch" Width="40%">
                    <fieldset>
                        <legend align="top" style="font-weight: bold;">Search Partner</legend>
                        <table align="left" width="100%">
                            <tr>
                                <td width="50%">
                                    &nbsp;
                                </td>
                                <td width="30%">
                                    &nbsp;
                                </td>
                                <td width="20%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="50%">
                                    Enter Partner ID or Name:
                                </td>
                                <td width="30%">
                                    <asp:TextBox ID="txtEmpIdName" runat="server" CssClass="TextBox1" MaxLength="30"
                                        Width="100px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmpIdName"
                                        Display="Dynamic" ErrorMessage="Please Enter Name or Id" ValidationGroup="search"
                                        SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                </td>
                                <td width="20%">
                                    <asp:Button ID="btnSearch" runat="server" CssClass="Button" OnClick="btnSearch_Click"
                                        Text="Search" ValidationGroup="search" />
                                </td>
                            </tr>
                            <tr>
                                <td width="66%" colspan="2" align="center">
                                    <asp:Label ID="lblMsg" runat="server" CssClass="error"></asp:Label>
                                </td>
                                <td width="33%">
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </asp:Panel>
            </td>
        </tr>
        <asp:Panel ID="pnlShowSearchGrd" runat="server" Visible="False">
            <tr>
                <td align="left">
                    <table width="90%" align="left" border="0">
                        <tr>
                            <td align="left">
                                <asp:GridView ID="GvEmployee" runat="server" AutoGenerateColumns="False" DataKeyNames="Id,empName"
                                    AllowPaging="True" Width="50%" OnPageIndexChanging="GvEmployee_PageIndexChanging" BorderWidth="0">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Partner Id">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbSelectEmp" runat="server" OnClick="lbSelectEmp_Click" Text='<%# Eval("empCode") %>'
                                                    CommandArgument='<%# Eval("ID") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="">
                                            <ItemTemplate>
                                                <img id="imgGeoCode" src='<%# CheckImage(DataBinder.Eval(Container.DataItem, "geoCode")) %>'
                                                    alt='<%# CheckAlt(DataBinder.Eval(Container.DataItem, "geoCode")) %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Partner Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEmpName" runat="server" Text='<%# Eval("empName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        
                                        <asp:TemplateField HeaderText="Facility">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEmpFacility" runat="server" Text='<%# Eval("facilityName") %>'></asp:Label>
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
                </td>
            </tr>
        </asp:Panel>
        <asp:Panel ID="pnlShowMap" runat="server" Visible="False">
            <tr valign="top">
                <td align="left">
                    <asp:Button ID="Button1" runat="server" Text="First Modal Popup" Style="display: none" />
                    <cc1:ModalPopupExtender BackgroundCssClass="modalBackground" DropShadow="False" CancelControlID="btnClose"
                        runat="server" PopupControlID="PanelMeta" ID="ModalPopupExtender1" TargetControlID="Button1"
                        Drag="True" />
                    <br />
                    
               
                    <asp:Panel ID="PanelMeta" runat="server" Style="display: none" 
                        ScrollBars="Horizontal" >
                        <table width="100%" border="1" cellpadding="4">
                            <tr valign="top">
                                <td width="350px">
                               
                                    <asp:DetailsView ID="DvEmpGeoDetails" runat="server" AutoGenerateRows="False" HeaderText="Partner Geocode Details"
                                        Height="50px" Style="margin-right: 0px" Width="350px" BackColor="White" BorderColor="Black"
                                        BorderStyle="Ridge" BorderWidth="1px" CellPadding="3" CssClass="DetailsView"
                                        GridLines="Horizontal" InsertRowStyle-BackColor="White" ForeColor="Black">
                                        <RowStyle CssClass="DetailsViewRowStyle" />
                                        <FooterStyle CssClass="DetailsViewFooterStyle" />
                                        <PagerStyle CssClass="DetailsViewPagerStyle" />
                                        <HeaderStyle CssClass="DetailsViewHeaderStyle" />
                                        <AlternatingRowStyle CssClass="DetailsViewAltRowStyle" />
                                        <Fields>
                                            <asp:TemplateField HeaderText="Partner ID:">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmpID" runat="server" Width="200px" Text='<%# Eval("empCode") %>'>Show Details</asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Partner Name:">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmpName" runat="server" Width="200px" Text='<%# Eval("empName") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Address:">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldvAddress" runat="server" TextMode="MultiLine" Width="200px" Text='<%# Eval("address") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="City:">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldvCity" runat="server" TextMode="MultiLine" Width="200px" Text='<%# Eval("City") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Colony:">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldvColony" runat="server" TextMode="MultiLine" Width="200px" Text='<%# Eval("Colony") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="SubColony:">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldvSubColony" runat="server" TextMode="MultiLine" Width="200px" ></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            
                                            <asp:TemplateField HeaderText="Landmark:">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldvLandmark" runat="server" TextMode="MultiLine" Width="200px" Text='<%# Eval("Landmark") %>'></asp:Label>
                                                    <asp:Label ID="lblGeoX" runat="server" Text='<%# Eval("geoX") %>' Visible="False"></asp:Label>
                                                    <asp:Label ID="lblGeoY" runat="server" Text='<%# Eval("geoY") %>' Visible="False"></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Mobile:">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMobile" runat="server" TextMode="MultiLine" Width="200px" Text='<%# Eval("Mobile") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                        </Fields>
                                        <HeaderStyle BackColor="#CCCCFF" Font-Bold="True" ForeColor="Black" HorizontalAlign="Center"
                                            VerticalAlign="Middle" />
                                        <InsertRowStyle BackColor="White" ForeColor="Black" />
                                        <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                        <AlternatingRowStyle BackColor="#F7F7F7" />
                                    </asp:DetailsView>

                                    <div id="MapGeocodeHeader" style="width: 350px; float: left; background-color: #FFFFFF;"
                                        align="left">
                                        <hr />
                                        <strong><span id="GeocodeHeader"></span></strong>
                                        <hr />
                                    </div>
                                      <div id="ft" style="padding: 4px; border: 1px solid #000000; width: 350px; float: left;
                                        background-color: #FFFFFF;">
                                        <p style="text-align: left">
                                            <strong>Latitude (GeoY):</strong>&nbsp;
                                            <asp:Label ID="lblgeoY" runat="server"></asp:Label>
                                        </p>
                                        <p style="text-align: left">
                                            <strong>Longitude (GeoX): </strong>
                                            <asp:Label ID="lblgeoX" runat="server"></asp:Label>
                                        </p>
                                      <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                      <ContentTemplate>
                                    
                                        <p style="text-align: left">
                                            <strong>City :</strong> 
                                             <asp:DropDownList ID="ddlCity" runat="server" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="ddldvCity_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            
                                           <asp:CompareValidator ID="CompareValidator3" runat="server" 
                                    ControlToValidate="ddlCity" Display="Dynamic" 
                                    ErrorMessage="Select City" Operator="NotEqual" SetFocusOnError="True" 
                                    ValueToCompare="0" ValidationGroup="Save" >*</asp:CompareValidator>
                                            </span>
  
                                        </p>
                                        <p style="text-align: left">
                                            <strong>Colony :</strong>   
                                            <asp:DropDownList ID="ddlColony" runat="server" AutoPostBack="false" AppendDataBoundItems="true">
                                            </asp:DropDownList>
                                            
                                           <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                    ControlToValidate="ddlColony" Display="Dynamic" 
                                    ErrorMessage="Select Colony" Operator="NotEqual" SetFocusOnError="True" 
                                    ValueToCompare="0" ValidationGroup="Save" >*</asp:CompareValidator>
                                               </p>
                                        <p style="text-align: left">
                                            <strong>SubColony :</strong> 
                                      <asp:TextBox ID="txtSubcolony" runat="server"></asp:TextBox>
                                            
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Save" ControlToValidate="txtSubcolony"  ErrorMessage="Enter the SubColony">*</asp:RequiredFieldValidator>
                            
                                                    </p>
                                              </ContentTemplate>
                                       </asp:UpdatePanel>         
                                        <p style="text-align: left">
                                            <strong>Landmark :</strong> <asp:TextBox ID="txtLandmark" runat="server"></asp:TextBox>
                                            
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="Save" ControlToValidate="txtLandmark"  ErrorMessage="Enter the Landmark">*</asp:RequiredFieldValidator>
                                        </p>
                                        <p style="text-align: left">
                                            <strong>Google Maps zoom level:</strong> <span id="zoom"></span>
                                        </p>
                                        <asp:Button ID="btnSave" runat="server" Text="Save Geocode" ValidationGroup="Save" OnClick="btnSave_Click"
                                            CssClass="Button" />
                                        <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="Button" OnClick="btnClose_Click" />
                                    </div>
                                    
                                    
                                                                     
                                </td>
                                <td align="left">
                                    <div id="map_canvas" align="left" style="border: 1px solid #000000; width: 850px;
                                        height: 500px">
                                    </div>
                                    <div id="crosshair">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td align="left" valign="top">
                                <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearchAdd">
                                    <input type="text" name="txtSearch" size="50%" />
                                    <asp:Button ID="btnSearchAdd" runat="server" OnClientClick="return SearchAddress()"
                                        Text="Search" CssClass="Button" />
                                        </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </asp:Panel>
    </table>
    <asp:HiddenField ID="hfLatitude" runat="server" />
    <asp:HiddenField ID="hfLongitude" runat="server" />
    <asp:HiddenField ID="hfAddress" runat="server" />
    <asp:HiddenField ID="hfgeoX" runat="server" />
    <asp:HiddenField ID="hfgeoY" runat="server" />
    <asp:HiddenField ID="hfCity" runat="server" />
    <asp:HiddenField ID="hfColony" runat="server" />
    <asp:HiddenField ID="hfSubColony" runat="server" />
    <asp:HiddenField ID="hfLandmark" runat="server" />
</asp:Content>
