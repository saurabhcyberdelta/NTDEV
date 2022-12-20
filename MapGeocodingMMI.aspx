<%@ Page Language="C#" MasterPageFile="~/gMAP.master" AutoEventWireup="true" CodeFile="MapGeocodingMMI.aspx.cs" Inherits="MapGeocodingMMI" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        /*map css **/
        #map-container {
            position: absolute;
            left: 312px;
            top: 1px;
            right: 2px;
            bottom: 2px;
            border: 1px solid #cccccc;
        }
        #menu1 {
            position: absolute;
            left: 2px;
            top: 1px;
            width: 306px;
            bottom: 2px;
            border: 1px solid #cccccc;
            background-color: #FAFAFA;
            overflow-x: hidden;
            overflow-y: auto;
        }
        li {
            padding: 0 5px 10px 0;
            cursor: pointer;
            color: #333;
        }
            li:hover {
                color: #00adff;
                cursor: pointer;
                text-decoration: underline;
            }
        .my-div-span {
            position: relative;
        }
    </style>

    <script type="text/javascript" src="Js/jquery.min.js"></script>
    <script type="text/javascript" src="https://apis.mapmyindia.com/advancedmaps/v1/hqnk8oeamxr1takexcxs2vlibib59hpp/map_load?v=1.3&plugin=polylinedecorator,path.drag"></script>
    <script type="text/javascript">

        var lng = 77.229455;
        var lat = 28.612960;
        var url_result;
        var all_result = [];
        var markerGroup = new Array();
        var markers = new Array();
        var map;
        var marker = [];
        var center = new L.LatLng(28.549948, 77.268241);
        var fieldList = ["eLoc", "geocodeLevel", "houseNumber", "houseName", "poi", "street", "subSubLocality", "subLocality", "locality", "subDistrict", "district", "city", "state", "pincode", "formattedAddress", "confidenceScore"];
        var labelList = ["eLoc", "Geocode Level", "House Number", "House Name", "POI", "Street", "Sub Sub Locality", "Sub Locality", "Locality", "Sub District", "District", "City", "State", "Pincode", "Address", "confidenceScore"];
        var _tokenNo;
        var _Latitude;
        var _Longitude;
        <%--window.onload = function () {
            _tokenNo = document.getElementById('<%= hfToken.ClientID %>').value;
            var centre = new L.LatLng(lat, lng);
            alert("Token No:"+_tokenNo);
            map = new MapmyIndia.Map('map-container', { center: centre, zoomControl: true, hybrid: true });
            get_geocode_result();
        };--%>       

        function initialize() {

            var IsPasePostBack = "<%=_IsPasePostBack%>";
            if (IsPasePostBack == "true") {
                _Latitude = document.getElementById('<%= hfLatitude.ClientID %>').value;
                _Longitude = document.getElementById('<%= hfLongitude.ClientID %>').value;
                var _LatitudeFAC = document.getElementById('<%= hfLatitudeFAC.ClientID %>').value;
                var _LongitudeFAC = document.getElementById('<%= hfLongitudeFAC.ClientID %>').value;
                var _Address = document.getElementById('<%= hfAddress.ClientID %>').value;
                //document.getElementById('search').value = _Address;

                document.getElementById('txtSearch').value = _Address;

                //var latlng = new google.maps.LatLng(_Latitude, _Longitude);
                //alert("Address:" + _Address + ";Latitude:" + _Latitude + ";Longitude:" + _Longitude + ";LatitudeFac" + _LatitudeFAC + ";Longitude" + _LongitudeFAC);

                _tokenNo = document.getElementById('<%= hfToken.ClientID %>').value;

                var centre = new L.LatLng(_Latitude, _Longitude);
                //if (_Latitude > 0 && _Longitude > 0) {
                //    var centre = new L.LatLng(_Latitude, _Longitude);
                //}
                //else {
                //    var centre = new L.LatLng(lat, lng);
                //    alert(_Latitude + "Hello" + _Longitude + ";" + lat + ";" + lng);
                //}
                //document.getElementById('latitude').innerHTML = lat;
                //document.getElementById('longitude').innerHTML = lng;
                //alert("Token No:" + _tokenNo);
                map = new MapmyIndia.Map('map-container', { center: centre, zoomControl: true, hybrid: true });
                //get_geocode_result(); // by anurag
                show_markers(0, centre);

            }
        }

        function searchAddress() {

            document.getElementById('<%= hfAddress.ClientID %>').value = document.getElementById('txtSearch').value;
            var IsPasePostBack = "<%=_IsPasePostBack%>";
            //remove_markers();
            if (IsPasePostBack == "true") {
                _Latitude = document.getElementById('<%= hfLatitude.ClientID %>').value;
                _Longitude = document.getElementById('<%= hfLongitude.ClientID %>').value;
                var _LatitudeFAC = document.getElementById('<%= hfLatitudeFAC.ClientID %>').value;
                var _LongitudeFAC = document.getElementById('<%= hfLongitudeFAC.ClientID %>').value;
                var _Address = document.getElementById('<%= hfAddress.ClientID %>').value;
                //document.getElementById('search').value = _Address;

                document.getElementById('txtSearch').value = _Address; ///on 20Apr

                //var latlng = new google.maps.LatLng(_Latitude, _Longitude);
                //alert("Address:" + _Address + ";Latitude:" + _Latitude + ";Longitude:" + _Longitude + ";LatitudeFac" + _LatitudeFAC + ";Longitude" + _LongitudeFAC);

                _tokenNo = document.getElementById('<%= hfToken.ClientID %>').value;
                
                //alert("Token No:" + _tokenNo);
                //map = new MapmyIndia.Map('map-container', { center: centre, zoomControl: true, hybrid: true });
                get_geocode_result();

                //var centre = new L.LatLng(lat, lng);

            }
            return false;
        }


        /*function to get geocode result from the url*/
        function get_geocode_result() {
            var search_id = document.getElementById('txtSearch');
            var address = search_id.value;
            if (address !== undefined && address.trim().length === 0) {
                //alert("Please enter address.");
                search_id.focus();
                return false;
            }
            //document.getElementById('result').innerHTML = '<div style="padding: 0 12px; color: #777">Loading..</div>'; /*update best result */
            //document.getElementById('otherresult').innerHTML = '<div style="padding: 0 12px; color: #777">Loading..</div>'; /*update other result */
            //initialize();
            getUrlResult(address); /*get JSON resp*/
            //display_geocode_result();

        }

        function validateInput(input) {
            var flag = true;
            if (input < 1 || input > 10) {
                flag = false;
            }
            return flag;
        }

        /*function to get Json response from the url*/
        function getUrlResult(address) {
            $.ajax({
                cache: false,
                type: "GET",
                dataType: 'text',
                //url: "getrespgeocode.php",
                url: "https://atlas.mapmyindia.com/api/places/geocode?address=" + address + "&access_token=" + _tokenNo, //"&access_token=9383fc73-3073-4b0a-8013-82400c70be3f",
                async: true,
                success: function (result) {
                    if (result !== undefined) {
                        var copResults1 = [];
                        console.log(result);
                        var jsondata = JSON.parse(result);
                        copResults = jsondata.copResults;
                        console.log(jsondata);
                        copResults1.push(copResults);
                        console.log(copResults1);
                        if (copResults1.length > 0) {
                            display_geocode_result(copResults1); /*display results on success*/
                        }
                    } else {
                        /*handle the error codes and put the responses in divs more error codes can be seen in the documentation*/
                        var error_response = "No result."
                        document.getElementById('result').innerHTML = error_response + '</ul></div>'; /***put response result in div****/
                        //document.getElementById('otherresult').innerHTML = "" + '</ul></div>'; /***put response result in div****/
                    }
                }
            });
        }

        /*function to display geocode result*/
        function display_geocode_result(data) {
            details = [];
            /***********remove existing marker from map***********/
            //mapmyindia_removeMarker();
            remove_markers();
            //var result_string = '<div style="padding: 0 12px;color:green;font-size:13px">Best Match</div><div style="font-size: 13px"><ul style="list-style-type:decimal;color:green; padding:2px 2px 0 30px">';
            //var other_result_string = '<div style="padding: 0 12px;color:green;font-size:13px">Others</div><div style="font-size: 13px"><ul style="list-style-type:decimal; padding:2px 2px 0 30px">';
            var num = 1;

            var item = data[0];

            var otheritem = data;

            /*show the best item data*/
            if (item !== '' && item !== null && item !== "undefined") {
                var lng = item.longitude;
                var lat = item.latitude;
                var address = item.formattedAddress;
                var confidenceScore = item.confidenceScore;
                var pos = new L.LatLng(lat, lng); /***position of marker*****/
                show_markers(num, pos, address); /**display markers***/

                details.push(createPopupContent(item));
                
                if (_Latitude > 0 && _Longitude > 0) {
                    document.getElementById('latitude').innerHTML = _Latitude;
                    document.getElementById('longitude').innerHTML = _Longitude;
                }
                else {
                    document.getElementById('latitude').innerHTML = lat;
                    document.getElementById('longitude').innerHTML = lng;
                }

                document.getElementById('<%= hfLatitude.ClientID %>').value = lat;
                document.getElementById('<%= hfLongitude.ClientID %>').value = lng;

                //result_string += '<li onclick="show_geocode_details(' + (num++) + ',' + lng + ',' + lat + ')">' + address + '</li><span style="color:black;"><b>confidenceScore : </b>' + confidenceScore + '</span><br/><span style="color:black;"><b>geocodeLevel : </b>' + item.geocodeLevel + '</span><br/><span style="color:black;"><b>Latitude : </b>' + lat + '</span><br/><span style="color:black;"><b>Longitude : </b>' + lng + '</span>';
                var centre = new L.LatLng(lat, lng);
            } else {
                var error_response = "Not found."
                document.getElementById('result').innerHTML = error_response + '</ul></div>'; /***put response result in div***/


            }

            /*show other item in other result*/
            var c = 0;
            //document.getElementById('result').innerHTML = result_string + '</ul></div>'; /***put geocode result in div***/
            //document.getElementById('otherresult').innerHTML = "";
            //if (c > 1) {
            //    document.getElementById('otherresult').innerHTML = other_result_string + '</ul></div>'; /***put geocode result in div***/
            //}
            mapmyindia_fit_markers_into_bound(); /***fit map in marker area***/
        }

        function createPopupContent(item) {

            var content = new Array();
            for (var i = 0; i < fieldList.length; i++) {
                if (item[fieldList[i]] !== "") {
                    content.push("<tr><th style='white-space:nowrap;vertical-align: top;text-align: left;'>");
                    content.push(labelList[i]);
                    content.push("</th><th style='width:5px;vertical-align: top;text-align: left;'>:</th><td>");
                    // content.push(item[fieldList[i]].trim().split(";")[0]);
                    content.push(item[fieldList[i]]);
                    content.push("</td></tr>");
                }
            }
            return content.join("");
        }

        function showotherplaces(place_id) {
            alert("To view this place, please access 'POI Details API' with the eloc: " + place_id);
        }

        function show_markers(num, pos) {
            //mapmyindia_removeMarker();
            //remove_markers();
            num = 0;
            var icon_marker = L.divIcon({
                className: 'my-div-icon',
                html: "<img style='position:relative;' \n\
                        src=" + "'https://maps.mapmyindia.com/images/2.png'>" + '<span style="position: absolute;left:1.6em;right:\n\
                        1em;top:1.4em;bottom:3.5em; font-size:9px;font-weight:bold;width: 1px; color:black;" class="my-div-span">' + num + '</span>',
                iconSize: [10, 10],
                popupAnchor: [12, -10]

            }); /*creating a div icon*/

            markers[num] = L.marker(pos, { icon: icon_marker, draggable: true }).addTo(map);
            map.setView(pos, 19);
            markerGroup.push(markers[num]);

            var event_div = document.getElementById("event-log");
            event_div.innerHTML = "Draggable Marker created, Drag the Marker to the new position"

            /* following events can be assigned handler (for every instance of draggable marker(s))*/
            markers[num].on("dragstart", function (e) {
                event_div.innerHTML = "Marker drag start<br>" + event_div.innerHTML;
            });
            markers[num].on("dragend", function (e) {
                var pt = e.target._latlng;/*event returns lat lng of dragged position*/
                markers[num].setLatLng(pt);/*set marker position to dragged position*/
                document.getElementById('<%= hfLatitude.ClientID %>').value = pt.lat;
                document.getElementById('<%= hfLongitude.ClientID %>').value = pt.lng;
                document.getElementById('latitude').innerHTML = pt.lat;
                document.getElementById('longitude').innerHTML = pt.lng;
                event_div.innerHTML = "Draggable:</br> lat:" + pt.lat + "</br>lng:" + pt.lng + "</br>";
            });

            markers[num].on("click", function (e) {
                event_div.innerHTML = "Marker clicked<br>"+event_div.innerHTML ;
                markers[num].bindPopup(event_div.innerHTML);
            });
        }

        function show_geocode_details(num, lng, lat) {
            show_info_window(num - 1, markers[num]);
        }

        /*function to show pop up on marker**/
        function show_info_window(num, marker) {
            marker.bindPopup("");
            var popup = marker.getPopup();
            popup.setContent('<table style="line-height:14px" cellspacing="5">' + details[num] + '</table>').update();
            marker.openPopup();
        }

        /*function to remove  marker from the map*/
        function remove_markers() {
            //map.removeLayer(markerGroup[k]);
            for (k = 0; k < markerGroup.length; k++) {
                map.removeLayer(markerGroup[k]); /*Remove markers from map*/
            }
        }

        function mapmyindia_removeMarker() {
            var markerlength = markers.length;
            if (markerlength > 0) {
                for (var i = 0; i < markerlength; i++) {
                    map.removeLayer(markers[i]); /* deletion of marker object from the map */
                }
            }

            delete markers;
            marker = [];
        }

        /*function to fit the maps in the bounds of the marker*/
        function mapmyindia_fit_markers_into_bound() {
            var group = new L.featureGroup(markerGroup);
            map.fitBounds(group.getBounds());
        }

        function hideLoader() {
            $("#loader").hide();
        }

        function showLoader() {
            $("#loader").show();
        }

        /*function to make  marker draggable*/
        function mapmyindia_draggable_marker() {
            //mapmyindia_removeMarker();
            remove_markers();
            var postion = new L.LatLng(28.5628, 77.6856);/*WGS location object*/
            var mk = addMarker(postion, '', "Draggable marker sample", true);/*call the add marker function*/
            var event_div = document.getElementById("event-log");
            event_div.innerHTML = "Draggable Marker created, Drag the Marker to the new position"

            /* following events can be assigned handler (for every instance of draggable marker(s))*/
            mk.on("dragstart", function (e) {
                event_div.innerHTML = "Marker drag start<br>" + event_div.innerHTML;
            });
            mk.on("dragend", function (e) {
                var pt = e.target._latlng;/*event returns lat lng of dragged position*/
                mk.setLatLng(pt);/*set marker position to dragged position*/
                document.getElementById('latitude').innerHTML = pt.lat;
                document.getElementById('longitude').innerHTML = pt.lng;
                document.getElementById('<%= hfLatitude.ClientID %>').value = pt.lat;
                document.getElementById('<%= hfLongitude.ClientID %>').value = pt.lng;
                event_div.innerHTML = "Draggable:</br> lat:" + pt.lat + "</br>lng:" + pt.lng + "</br>";
            });
        }

        function addMarker(position, icon, title, draggable) {
            /* position must be instance of L.LatLng that replaces current WGS position of this object. Will always return current WGS position.*/
            var event_div = document.getElementById("event-log");
            if (icon == '') {
                var mk = new L.Marker(position, { draggable: draggable, title: title });/*marker with a default icon and optional param draggable, title */
                mk.bindPopup(title);
            }
            else {
                var mk = new L.Marker(position, { icon: icon, draggable: draggable, title: title });/*marker with a custom icon */
                mk.bindPopup(title);
            }
            map.addLayer(mk);/*add the marker to the map*/
            /* marker events:*/
            mk.on("click", function (e) {
                event_div.innerHTML = "Marker clicked<br>" + event_div.innerHTML;
            });

            return mk;
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
        <tr>
            <td align="left">
                <asp:Panel ID="pnlShowSearchGrd" runat="server" Visible="False">
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
        </asp:Panel>
            </td>
        </tr>        
    </table>    

    <asp:Panel ID="pnlShowMap" runat="server" Visible="False" Width="80%" Height="80%">
        <asp:Button ID="Button1" runat="server" Text="First Modal Popup" Style="display: none" />
        <cc1:ModalPopupExtender BackgroundCssClass="modalBackground" DropShadow="False" 
            runat="server" PopupControlID="PanelMeta" ID="ModalPopupExtender1" TargetControlID="Button1"
            Drag="True" />
        <br />
        <asp:Panel ID="PanelMeta" runat="server" ScrollBars="Horizontal" Width="95%" Height="90%" BorderStyle="Ridge">
            <div id="menu1">
          
                <asp:DetailsView ID="DvEmpGeoDetails" runat="server" AutoGenerateRows="False" HeaderText="Employee Geocode Details"
                    Height="50px" Style="margin-right: 0px" Width="100%" BackColor="White" BorderColor="Black"
                    BorderStyle="Ridge" BorderWidth="1px" CellPadding="4" CssClass="DetailsView"
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

                <div id="MapGeocodeHeader" style="width: 100%; float: left; background-color: #ECEFF1;"
                    align="left">
                    <hr />
                    <strong><span id="GeocodeHeader"></span></strong>
                    <hr />
                </div>
                <div id="ft" style="padding: 4px; border: 1px solid #333333; width: 96%; float: left; background-color: #ECEFF1;"
                    class="DetailsView">
                    <p style="text-align: left">
                        <strong>Latitude (GeoY):</strong>&nbsp;
                        <label id="latitude"></label>
                        <asp:Label ID="lblgeoY" runat="server"></asp:Label>
                    </p>
                    <p style="text-align: left">
                        <strong>Longitude (GeoX): </strong>
                        <label id="longitude"></label>
                        <asp:Label ID="lblgeoX" runat="server"></asp:Label>
                        <br />
                        <br />
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
                                      <asp:TextBox ID="txtSubcolony" runat="server" ></asp:TextBox>
                                            
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
                    <asp:Button ID="btnSave" runat="server" Text="Save Geocode" ValidationGroup="Save"
                        OnClick="btnSave_Click" CssClass="Button" />
                    &nbsp;
                    <asp:Button ID="btnClose" runat="server" Text="Close"  CssClass="Button" OnClick="btnClose_Click" />
                </div>
<%--  <div id="map_canvas" align="left" style="border: 1px solid #000000; width: 850px;
                                        height: 500px">
                                    </div>
                                    <div id="crosshair">
                                    </div>--%>

                <div id="MapGeocodeHeader1" style="width: 100%; float: left; background-color: #ECEFF1;"
                    align="left">
                    <hr />
                    <strong><span id="GeocodeHeader1"></span></strong>
                    <hr />
                </div>
                <div id="ft1" style="padding: 4px; border: 1px solid #333333; width: 96%; float: left; background-color: #ECEFF1;"
                    class="DetailsView">
                    <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearchAdd">
                        <input type="text" id="txtSearch" name="txtSearch" placeholder="Address" style="width: 254px; margin-right: 10px; padding: 5px; border: 1px solid #ddd; color: #555" /><br />
                        <br />
                        <button type="button" onclick="searchAddress()" style="margin-top: 10px; cursor: pointer;" class="Button">Search</button>
                        <asp:Button ID="btnSearchAdd" runat="server" OnClientClick="searchAddress()"
                            Text="Search" CssClass="Button" Visible="false" />
                    </asp:Panel>
                </div>
                <div style="border-top: 1px solid #e9e9e9; padding: 10px; margin-top: 12px; display: none;" id="result"></div>
                <div style="padding: 14px 12px 6px 38px; color: #666; display: none;">Event Logs</div>
                <div style="padding: 6px 12px 6px 38px; color: #777; font-size: 12px; line-height: 22px; display: none;" id="event-log"></div>
            </div>
            <div id="map-container" style="vertical-align: top; align-self: center"></div>

        </asp:Panel>
    </asp:Panel>
    
   
   <asp:HiddenField ID="hfnogeocode" Value="0" runat="server" />
    <asp:HiddenField ID="hfLatitude" runat="server" />
    <asp:HiddenField ID="hfLongitude" runat="server" />
    <asp:HiddenField ID="hfLatitudeFAC" runat="server" />
    <asp:HiddenField ID="hfLongitudeFAC" runat="server" />
    <asp:HiddenField ID="hfAddress" runat="server" />
    <asp:HiddenField ID="hfgeoX" runat="server" />
    <asp:HiddenField ID="hfgeoY" runat="server" />
    <asp:HiddenField ID="hfCity" runat="server" />
    <asp:HiddenField ID="hfColony" runat="server" />
    <asp:HiddenField ID="hfSubColony" runat="server" />
    <asp:HiddenField ID="hfLandmark" runat="server" />
    <asp:HiddenField ID="hfToken" runat="server" />
</asp:Content>
