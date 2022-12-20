<%@ Page Language="C#" MasterPageFile="~/gMAP.master" AutoEventWireup="true" CodeFile="GenerateRoutes.aspx.cs"
    Inherits="GenerateRoutes" Title="Generate Routes" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="http://maps.googleapis.com/maps/api/js?sensor=false"
        type="text/javascript"></script>

    
    

    <script language="javascript" type="text/javascript">
        function switchViews(obj, row) {
            var div = document.getElementById(obj);
            var img = document.getElementById('img' + obj);

            if (div.style.display == "none") {
                div.style.display = "inline";
                {
                    img.src = "images/minus.gif";
                    mce_src = "images/minus.gif";
                }
                img.alt = "Click to hide the Route Detail";
            }
            else {
                div.style.display = "none";

                {
                    img.src = "images/plus.gif";
                    mce_src = "images/plus.gif";
                }
                img.alt = "Click to show Route Detail";
            }
        }
    </script>

    <script language="javascript" type="text/javascript">
        var directionsService = new google.maps.DirectionsService();

        function ShowWayPointOnMap(WayPoints) {
            var directionsDisplay;
            var length = WayPoints.length;
            var ways;
            var origin, origins;
          
          var way=WayPoints[0].split(',');
          ways = new google.maps.LatLng(way[0], way[1]);
          origin = WayPoints[length - 1].split(',');
          origins = new google.maps.LatLng(origin[0], origin[1]);
          var waypoints = [];
        

   
        
        
          for (var w = 1; w < length-1; w++) {
           var t = WayPoints[w].split(',');
              waypoints.push({
            location:  new google.maps.LatLng(t[0], t[1]),
            stopover:true
        });
              
        // console.log(waypoints);         
     
          }
          
        
            directionsDisplay = new google.maps.DirectionsRenderer();
           // if (GBrowserIsCompatible())
             {
                     var latlng = new google.maps.LatLng(ways);
                var myOptions = {
                    zoom: 12,
                    center: ways,
                    mapTypeId: google.maps.MapTypeId.ROADMAP

                }
                map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
                directionsDisplay.setMap(map);
                var request = {
                origin: ways,
                destination: origins,
              waypoints:waypoints,
        optimizeWaypoints: true,
        travelMode: google.maps.DirectionsTravelMode.DRIVING
    };
    directionsService.route(request, function(response, status) {
        if (status == google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);
        }
    });
    directionsDisplay.setMap(map);
//                directions = new GDirections(map);
//                directions.loadFromWaypoints(WayPoints);
//                map.setUIToDefault();
            }
        }
    </script>

    <script language="javascript" type="text/javascript">
        var progressEnd = 20; // set to number of progress <span>'s.
        var progressColor = 'blue'; // set to progress bar color
        var progressInterval = 1000; // set to time between updates (milli-seconds)

        var progressAt = progressEnd;
        var progressTimer;
        function progress_clear() {
            for (var i = 1; i <= progressEnd; i++) document.getElementById('progress' + i).style.backgroundColor = 'transparent';
            progressAt = 0;
        }
        function progress_update() {
            document.getElementById("showbar").style.visibility = 'visible';
            progressAt++;
            if (progressAt > progressEnd) progress_clear();
            else document.getElementById('progress' + progressAt).style.backgroundColor = progressColor;
            progressTimer = setTimeout('progress_update()', progressInterval);
        }
        function progress_stop() {
            clearTimeout(progressTimer);
            progress_clear();
            document.getElementById('showbar').style.visibility = 'hidden';
        }
        //progress_update(); // start progress bar

    </script>

    <script type="text/javascript">
        var gdir;
        var i = 0;
        var myArray = new Array();
        var MyEmpArray1 = new Array();
        var myRouteArray = new Array();
        var routeArrayCounter = 0;
        var routeNo = 1;
        var stopNo = 1;
        var nearestEmpCount = 0;
        var nearestEmp = 7; // for 10 employee
        var MyEmpArray2 = new Array(nearestEmp + 1);
        var vehicleCapCount = 1;
        var vehicleCap = 7;
        var routesPrevEmpID;
        var routesPrevEmpBaseDist;
        var routesTravelDuration = 7200; // fixed travel time in seconds(2 hrs) for a route
        var routesPrevEmpBaseDuration = 0;
        var lastEmpBaseDuration = 0;
        var routesPrevToNextEmpDist;
        var routesPrevEmpGeoY;
        var routesPrevEmpGeoX;
       
        function initialize() {
           // if (GBrowserIsCompatible()) 
            {
                if (MyEmpArray != "") {
                    progress_update();
                    setDirections();
                    document.getElementById('divTotReocrds').innerHTML = MyEmpArray.length + 1;
                    document.getElementById('divShift').innerHTML = '<%=_shift%>';

                }
            }
        }
        function setDirections() {
            document.getElementById('divTotRecProcess').innerHTML = routeArrayCounter + 1;
            document.getElementById('divTotRouteProcess').innerHTML = routeNo;
            //New Route
            if (i == 0) {
            //------- Changed by rachit on 02022011
                MyEmpArray.sort(sortBaseDistDsc);
                routesPrevEmpID = MyEmpArray[0][0]; //empid
                routesPrevEmpBaseDist = MyEmpArray[0][1]; //base Dist
                routesPrevEmpGeoY = MyEmpArray[0][2]; //y
                routesPrevEmpGeoX = MyEmpArray[0][3]; //x
                routesPrevEmpBaseDuration = 0; //MyEmpArray[0][4]; //base Duration in sec
                //Copy to Route Array
                myRouteArray[routeArrayCounter] = new Array(5);
                myRouteArray[routeArrayCounter][0] = routeNo;
                myRouteArray[routeArrayCounter][1] = routesPrevEmpID   //empid
                myRouteArray[routeArrayCounter][2] = routesPrevEmpBaseDist; //base Dist
                myRouteArray[routeArrayCounter][3] = routesPrevEmpGeoY; //y
                myRouteArray[routeArrayCounter][4] = routesPrevEmpGeoX; //x
                myRouteArray[routeArrayCounter][5] = stopNo; //stop no
                myRouteArray[routeArrayCounter][6] = routesPrevEmpBaseDuration; //routesPrevEmpBaseDuration
                removeByElement(MyEmpArray, routesPrevEmpID);
            }

            if (MyEmpArray.length == 0) {//employee array is null then submit form

                result = document.getElementById('<%= hfResults.ClientID %>');
                var str = "";
                for (var k = 0; k < myRouteArray.length; k++) {

                    //str += "Route Number:" + myRouteArray[k][0] + " EmpID:" + myRouteArray[k][1] + " Base Dist:" + myRouteArray[k][2] + " geoY:" + myRouteArray[k][3] + " geoX:" + myRouteArray[k][4] + "\n";
                    str += "|" + myRouteArray[k][0] + "," + myRouteArray[k][1] + "," + myRouteArray[k][5] + "," + myRouteArray[k][2] + "," + myRouteArray[k][6];
                }
                result.value = str;
                document.forms[0].submit();
                return;
            }
            if (nearestEmpCount == 0) {
                MyEmpArray1 = new Array(MyEmpArray.length)
                for (j = 0; j < MyEmpArray.length; j++) {
                    var arrialDist = udfComputeDistance(routesPrevEmpGeoX, routesPrevEmpGeoY, MyEmpArray[j][3], MyEmpArray[j][2])
                    MyEmpArray1[j] = new Array(5);
                    MyEmpArray1[j][0] = MyEmpArray[j][0]; //employeeid
                    MyEmpArray1[j][1] = MyEmpArray[j][1]; // BaseDistance
                    MyEmpArray1[j][2] = MyEmpArray[j][2]; // geoy
                    MyEmpArray1[j][3] = MyEmpArray[j][3]; // geox
                    MyEmpArray1[j][4] = arrialDist;    // Arial Distance
                    MyEmpArray1[j][5] = MyEmpArray[j][4];    // Base Duration
                }
                MyEmpArray1.sort(sortArialDistAsc);
            }
            //
            if (nearestEmp >= MyEmpArray.length) {
                nearestEmp = MyEmpArray.length - 1;
            }
            var service = new google.maps.DistanceMatrixService();
            service.getDistanceMatrix(
          {
              origins: [routesPrevEmpGeoY + "," + routesPrevEmpGeoX],
              destinations: [MyEmpArray1[nearestEmpCount][2] + "," + MyEmpArray1[nearestEmpCount][3]],
              travelMode: google.maps.TravelMode.DRIVING,
              unitSystem: google.maps.UnitSystem.METRIC,
              avoidHighways: false,
              avoidTolls: false
          }, function(response, status){
          
           if (status == google.maps.DirectionsStatus.OK) {
                    onGDirectionsLoad(response);
                }
                else {
                    setDirections();
                }
            });
          

           
//            gdir = new GDirections()
//            GEvent.addListener(gdir, "load", onGDirectionsLoad)
//            gdir.load("from: " + routesPrevEmpGeoY + "," + routesPrevEmpGeoX + " to: " + MyEmpArray1[nearestEmpCount][2] + "," + MyEmpArray1[nearestEmpCount][3]);
        }

        function onGDirectionsLoad(response) {

            var route = response.rows[0].elements[0];
                //alert(gdir.getSummaryHtml());
                MyEmpArray2[nearestEmpCount] = new Array(5);
                MyEmpArray2[nearestEmpCount][0] = MyEmpArray1[nearestEmpCount][0]; //employeeid
                //MyEmpArray2[nearestEmpCount][1] = MyEmpArray1[nearestEmpCount][1] + gdir.getDistance().meters / 1000; // BaseDistance
                MyEmpArray2[nearestEmpCount][1] = route.distance.value; // distance prevEmp to next emp
                MyEmpArray2[nearestEmpCount][2] = MyEmpArray1[nearestEmpCount][2]; // geoy
                MyEmpArray2[nearestEmpCount][3] = MyEmpArray1[nearestEmpCount][3]; // geox
                MyEmpArray2[nearestEmpCount][4] = MyEmpArray1[nearestEmpCount][4];    // Arial Distance
                MyEmpArray2[nearestEmpCount][5] = route.duration.value;    // prevEmp to next emp duration
                MyEmpArray2[nearestEmpCount][6] = MyEmpArray1[nearestEmpCount][5];    // Base Duration
                MyEmpArray2[nearestEmpCount][7] = MyEmpArray1[nearestEmpCount][1];    // Base Distance
                MyEmpArray2[nearestEmpCount][8] = routesPrevEmpBaseDist - MyEmpArray1[nearestEmpCount][1];    // Base Distance

                if (nearestEmpCount == nearestEmp) {
                    //remove routesPrevEmp from the MyEmpArray

                    if ((vehicleCapCount == vehicleCap) || (routesTravelDuration <= routesPrevEmpBaseDuration + lastEmpBaseDuration)) {
                        vehicleCapCount = 0;
                        routesPrevEmpBaseDuration = 0;
                        lastEmpBaseDuration = 0;
                        stopNo = 1;
                        routeNo++;
                        i = -1;
                        routeArrayCounter++;
                        // if route complete check farthest distance in EmpArray
                        // MyEmpArray.sort(sortBaseDistAsc);
                        // if route complete check farthest distance in EmpArray ends here

                    }
                    else {
                        MyEmpArray2.sort(sortBaseDistAsc);

                        for (j = 0; j < MyEmpArray2.length; j++) {
                            //if ((MyEmpArray2[j][8] >= -1000) && (MyEmpArray2[j][8] <= 5000)) {
                            if (MyEmpArray2[j][8] >= -500) {
                                var outofroute = routesPrevEmpBaseDist / 2;
                                if (outofroute <= 4000) {
                                    outofroute = 5000;
                                }
                                if (MyEmpArray2[j][1] < outofroute) {
                                    routeArrayCounter++;
                                    stopNo++;
                                    routesPrevEmpID = MyEmpArray2[j][0];
                                    routesPrevToNextEmpDist = MyEmpArray2[j][1];
                                    routesPrevEmpGeoY = MyEmpArray2[j][2];
                                    routesPrevEmpGeoX = MyEmpArray2[j][3];
                                    routesPrevEmpBaseDuration += MyEmpArray2[j][5];
                                    lastEmpBaseDuration = MyEmpArray2[j][6];
                                    routesPrevEmpBaseDist = MyEmpArray2[j][7];

                                    //Copy to Route Array
                                    myRouteArray[routeArrayCounter] = new Array(2);
                                    myRouteArray[routeArrayCounter][0] = routeNo;
                                    myRouteArray[routeArrayCounter][1] = routesPrevEmpID   //empid
                                    myRouteArray[routeArrayCounter][2] = routesPrevToNextEmpDist; //base Dist
                                    myRouteArray[routeArrayCounter][3] = routesPrevEmpGeoY; //y
                                    myRouteArray[routeArrayCounter][4] = routesPrevEmpGeoX; //x
                                    myRouteArray[routeArrayCounter][5] = stopNo; //x
                                    myRouteArray[routeArrayCounter][6] = MyEmpArray2[j][5]; //routesPrevEmpBaseDuration
                                    removeByElement(MyEmpArray, routesPrevEmpID);
                                }
                                else {
                                    vehicleCapCount = 0;
                                    routesPrevEmpBaseDuration = 0;
                                    lastEmpBaseDuration = 0;
                                    stopNo = 1;
                                    routeNo++;
                                    i = -1;
                                    routeArrayCounter++;
                                }
                                break;
                            }
                        }
                    }
                    nearestEmpCount = -1;
                    //alert(MyEmpArray);               
                    vehicleCapCount++;

                }
                nearestEmpCount++;
                i++;
                setDirections();
         
        }

        function sortDesc(a, b) {
            // this sorts the array using the second element
            return ((a[1] > b[1]) ? -1 : ((a[1] < b[1]) ? 1 : 0));
        }
        function sortBaseDist(a, b) {
            // this sorts the array using the second element
            return ((a[1] > b[1]) ? -1 : ((a[1] < b[1]) ? 1 : 0));
        }

        function sortArialDistAsc(a, b) {
            // this sorts the array using the second element
            return ((a[4] < b[4]) ? -1 : ((a[4] > b[4]) ? 1 : 0));
        }

        function sortBaseDistAsc(a, b) {
            // this sorts the array using the second element
            return ((a[1] < b[1]) ? -1 : ((a[1] > b[1]) ? 1 : 0));
        }

        function sortBaseDistDsc(a, b) {
            // this sorts the array using the second element
            return ((a[1] > b[1]) ? -1 : ((a[1] < b[1]) ? 1 : 0));
        }

        function sortAsc(a, b) {
            // this sorts the array using the second element
            return ((a[1] < b[1]) ? -1 : ((a[1] > b[1]) ? 1 : 0));
        }
        function distance(lat1, lon1, lat2, lon2) {
            var R = 6371; // km (change this constant to get miles)
            var dLat = (lat2 - lat1) * Math.PI / 180;
            var dLon = (lon2 - lon1) * Math.PI / 180;
            var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
		                Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
		                    Math.sin(dLon / 2) * Math.sin(dLon / 2);
            var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
            var d = R * c;
            if (d > 1) return Math.round(d) + "km";
            else if (d <= 1) return Math.round(d * 1000) + "m";
            return d;
        }
        function udfComputeDistance(lat1, lon1, lat2, lon2) {
            var R = 6371; // km (change this constant to get miles)
            var dLat = (lat2 - lat1) * Math.PI / 180;
            var dLon = (lon2 - lon1) * Math.PI / 180;
            var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        					Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
        							Math.sin(dLon / 2) * Math.sin(dLon / 2);
            var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
            var d = R * c;
            //if (d > 1) return d;
            //else if (d <= 1) return d * 1000;
            return d;
        }

        function removeArrayItem(arrayName) {
            for (var i = 0; i < arrayName.length; i++) {
                //if (arrayName[i] == arrayElement)
                arrayName.splice(i, 1);
            }
        }
        function removeByElement(arrayName, arrayElement) {
            for (var m = 0; m < arrayName.length; m++) {
                if (arrayName[m][0] == arrayElement)
                    arrayName.splice(m, 1);
            }
        }
        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" border="0" width="100%">
        <tr>
            <td align="center">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="order" />
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Label ID="lblErrorMsg" runat="server" CssClass="error" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="heading" colspan="2">
                        <div class="gradient2">
                            <h1>
                                <span></span>Generate Routes
                            </h1>
                            <h2>
                                Allows User to Generate Routes
                            </h2>
                        </div>
                    </td>
        </tr>
        <tr>
           
        </tr>
    </table>
    <table cellpadding="4" align="left">
        <tr valign="top">
            <td valign="top" style="width: 40%" align="left">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="False">
                    <ContentTemplate>
                        <fieldset>
                            &nbsp;&nbsp; <legend align="top" style="font-weight: bold;">Selection Criteria</legend>
                            <table border="0" cellpadding="4" cellspacing="1" align="center" width="100%">
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblFacError" runat="server" CssClass="error" Text="Select Facility"
                                            Visible="False"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Date:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtStartDate" runat="server" CssClass="TextBox"></asp:TextBox>
                                        <cc1:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" Enabled="True"
                                            TargetControlID="txtStartDate">
                                        </cc1:CalendarExtender>
                                        &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtStartDate"
                                            Display="Dynamic" ErrorMessage="Start Date Required" ValidationGroup="order"
                                            SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtStartDate"
                                                Display="Dynamic" ErrorMessage="Date Format:mm/dd/yyyy" ValidationExpression="^(([0]?[1-9]|1[0-2])/([0-2]?[0-9]|3[0-1])/[1-2]\d{3})? ?((([0-1]?\d)|(2[0-3])):[0-5]\d)?(:[0-5]\d)?$"
                                                ValidationGroup="order" SetFocusOnError="True">*</asp:RegularExpressionValidator>&nbsp;&nbsp;<br />
                                    </td>
                                    <td align="left">
                                        Facility Name:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlfacility" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                            OnSelectedIndexChanged="ddlfacility_SelectedIndexChanged" CssClass="DropDownListBox3">
                                            <asp:ListItem Selected="True" Value="0">Select Facility</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlfacility"
                                            ErrorMessage="Select Facility" Operator="NotEqual" ValueToCompare="0" ValidationGroup="order"
                                            SetFocusOnError="True">*</asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td rowspan="2" align="right">
                                        Shift:<br />
                                        <em>ctrl-click for multi-select</em>
                                    </td>
                                    <td align="left" rowspan="2">
                                        <asp:ListBox ID="lstShift" runat="server" AppendDataBoundItems="True" SelectionMode="Multiple">
                                            <asp:ListItem Selected="True" Value="0">-Select-</asp:ListItem>
                                        </asp:ListBox>
                                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="lstShift"
                                            Display="Dynamic" ErrorMessage="Select ShiftTime" Operator="NotEqual" SetFocusOnError="True"
                                            ValidationGroup="order" ValueToCompare="0">*</asp:CompareValidator>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:RadioButtonList ID="rdbtnlstType" runat="server" AutoPostBack="True" RepeatDirection="Horizontal"
                                            OnSelectedIndexChanged="rdbtnlstType_SelectedIndexChanged">
                                            <asp:ListItem Selected="True" Value="P">Pick</asp:ListItem>
                                            <asp:ListItem Value="D">Drop</asp:ListItem>
                                            
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="middle">
                                        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit"
                                            ValidationGroup="order" CssClass="Button" />
                                    </td>
                                    <td align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="btnSubmit" />
                        <asp:AsyncPostBackTrigger ControlID="ddlfacility" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="rdbtnlstType" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
            <td rowspan="5" style="width: 40%" valign="top">
                <div id="map_canvas" style="width: 620px; height: 550px; float: left; border: 0px solid black;
                    position: absolute; z-index: auto;" align="left">
                </div>
            </td>
        </tr>
        <tr valign="top">
            <td align="left">
                <asp:Panel ID="pnlProcessBar" Visible="false" runat="server">
                    <fieldset style="width: 462px">
                        &nbsp;&nbsp; <legend align="top" style="font-weight: bold;">Routing In Progress Please
                            Wait</legend>
                        <table align="center">
                            <tr>
                                <td align="right">
                                    Total Records :
                                </td>
                                <td>
                                    <div id="divTotReocrds" style="font-size: 8pt; width: 50px; padding: 2px;">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Route Processing :
                                </td>
                                <td>
                                    <div id="divTotRouteProcess" style="font-size: 8pt; padding: 2px;">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Total Records Processed :
                                </td>
                                <td>
                                    <div id="divTotRecProcess" style="font-size: 8pt; width: 50px; padding: 2px;">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div id="showbar" style="font-size: 8pt; padding: 2px; border: solid black 1px; visibility: hidden">
                                        <span id="progress1">&nbsp; &nbsp;</span> <span id="progress2">&nbsp; &nbsp;</span>
                                        <span id="progress3">&nbsp; &nbsp;</span> <span id="progress4">&nbsp; &nbsp;</span>
                                        <span id="progress5">&nbsp; &nbsp;</span> <span id="progress6">&nbsp; &nbsp;</span>
                                        <span id="progress7">&nbsp; &nbsp;</span> <span id="progress8">&nbsp; &nbsp;</span>
                                        <span id="progress9">&nbsp; &nbsp;</span> <span id="progress10">&nbsp; &nbsp;</span>
                                        <span id="progress11">&nbsp; &nbsp;</span> <span id="progress12">&nbsp; &nbsp;</span>
                                        <span id="progress13">&nbsp; &nbsp;</span> <span id="progress14">&nbsp; &nbsp;</span>
                                        <span id="progress15">&nbsp; &nbsp;</span> <span id="progress16">&nbsp; &nbsp;</span>
                                        <span id="progress17">&nbsp; &nbsp;</span> <span id="progress18">&nbsp; &nbsp;</span>
                                        <span id="progress19">&nbsp; &nbsp;</span> <span id="progress20">&nbsp; &nbsp;</span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" valign="middle">
                                    <div id="divShift" style="font-size: 8pt;">
                                    </div>
                                    hrs shift is processing...
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </asp:Panel>
            </td>
        </tr>
        <tr valign="top">
            <td align="left" valign="top">
                <table align="left" width="100%">
                    <tr>
                        <td align="left" valign="top">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                   <asp:GridView ID="grdViewRouteParent" runat="server" AutoGenerateColumns="False"
                                    DataKeyNames="RouteID" EmptyDataText="No record found" ShowFooter="True" BorderWidth="0">
                                    <Columns>
                                     
                                        <asp:TemplateField HeaderText="RouteID" ItemStyle-Width="100px">
                                            <FooterTemplate>
                                                <asp:LinkButton ID="linkbtMerge" runat="server" OnClick="linkbtMerge_Click">Merge</asp:LinkButton>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                             
                                                <asp:CheckBox ID="chkBxRouteID" runat="server" />
                                                <asp:ImageButton ID="ibViewRouteID" runat="server" ImageUrl="images/plus.gif" OnClick="ibViewRouteID_Click" />
                                                <asp:HyperLink ID="lblRouteID" runat="server" Target="new" CssClass="linkButton"
                                                    Text='<%# Bind("RouteID") %>' 
                                                   
                                                    ></asp:HyperLink>
                                            </ItemTemplate>
                                            <ItemStyle Width="10%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="shiftTime" HeaderText="Shift" ReadOnly="True" ItemStyle-Width="5%">
                                            <ItemStyle Width="5%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Location">
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Location") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="25%" />
                                            <FooterTemplate>
                                                <asp:Label ID="lblParentErrorMsg" runat="server"></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                       
                                        <asp:BoundField DataField="totalStop" HeaderText="Pax" ReadOnly="True" ItemStyle-Width="5%">
                                            <ItemStyle Width="2%"></ItemStyle>
                                        </asp:BoundField>
                                       <asp:TemplateField HeaderText="OnMap">
                                                <ItemTemplate>
                                                    <a href='#' onclick='javascript:ShowWayPointOnMap([<%# DataBinder.Eval(Container.DataItem, "WayPoints") %>]);'>
                                                        Click Here</a>
                                                </ItemTemplate>
                                                <ItemStyle Width="5%"></ItemStyle>
                                       </asp:TemplateField>
                                       
                                        <asp:TemplateField HeaderText="" ItemStyle-Width=".5%">
                                            <ItemTemplate>
                                                <tr>
                                                    <td colspan="8" align="center">
                                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                            <ContentTemplate>
                                                                <asp:GridView ID="grdViewRouteChild" runat="server" CssClass="Childgrid" AutoGenerateColumns="False"
                                                                    Width="90%" Visible="False" ShowFooter="True" DataKeyNames="routeid,id,shiftdate"
                                                                    OnRowDataBound="grdViewRouteChild_RowDataBound" CellPadding="2">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Employee Detail">
                                                                            <FooterTemplate>
                                                                                <%--<asp:ImageButton ID="ImbtSplit" runat="server" BackColor="Black" CausesValidation="false"
                                                                                    Height="20px" ImageAlign="Left" ImageUrl="~/images/Split1.png" ToolTip="Split Route"
                                                                                    Width="20px" OnClick="ImbtSplit_Click" />
                                                                                &nbsp;&nbsp;--%>
                                                                                <%--<asp:ImageButton ID="ImbtInsert" runat="server" ImageUrl="~/images/user_add.png"
                                                                                    ToolTip="Insert Employee" CausesValidation="false" ImageAlign="AbsMiddle" OnClick="ImbtInsert_Click" />
                                                                          --%>
                                                                            </FooterTemplate>
                                                                            <ItemTemplate>
                                                                                  <asp:Label ID="lblnewemp" runat="server"  Text='<%# Eval("isNewAdded") %> ' visible="false" ></asp:Label>
                                                                                <%# Eval("empCode") %>
                                                                                -
                                                                                <%# Eval("EmpName") %>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="20%"></ItemStyle>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="G">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Gender") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="1%"></ItemStyle>
                                                                            <FooterTemplate>
                                                                            </FooterTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="address">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("address") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="45%"></ItemStyle>
                                                                            <FooterTemplate>
                                                                                <asp:Label ID="lblChildErrorMsg" runat="server" Font-Bold="True" Font-Size="Small"
                                                                                    ForeColor="Red"></asp:Label>
                                                                            </FooterTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="tripType" HeaderText="" ItemStyle-Width="1%">
                                                                            <ItemStyle Width="1%" />
                                                                        </asp:BoundField>
                                                                        <asp:TemplateField HeaderText="SNo">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtstopNo" Text='<%# Eval("stopNo")%>' runat="server" Width="15px"
                                                                                    MaxLength="2" TabIndex="1" CssClass="TextBox"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="1%"></ItemStyle>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="ETA" SortExpression="ETA">
                                                                            <ItemTemplate>
                                                                                <div style="width: 50px;">
                                                                                    <asp:TextBox ID="txtETA" runat="server" MaxLength="5" Width="30px" Text='<%# Eval("ETA")%>' CssClass="TextBox" TabIndex="1"></asp:TextBox>
                                                                                    <%--<asp:TextBox ID="txtETAhh" Text='<%# Eval("ETAhh")%>' runat="server" CssClass="TextBox"
                                                                                        Width="15px" MaxLength="2" TabIndex="2"></asp:TextBox>
                                                                                    <asp:TextBox ID="txtETAmm" Text='<%# Eval("ETAmm")%>' runat="server" CssClass="TextBox"
                                                                                        Width="15px" MaxLength="2" TabIndex="2"></asp:TextBox>--%>
                                                                                </div>
                                                                            </ItemTemplate>
                                                                            <FooterTemplate>
                                                                                <asp:ImageButton ID="ibUpdateStopNo" runat="server" ImageUrl="~/images/save.png"
                                                                                    ToolTip="Update Stop No & ETA" CommandName="UpdateStopNo" OnClick="ibUpdateStopNo_Click"
                                                                                    TabIndex="2" />
                                                                            </FooterTemplate>
                                                                            <ItemStyle Width="1%"></ItemStyle>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="">
                                                                            <ItemTemplate>
                                                                                <asp:CheckBox ID="chkBxEmployeeID" runat="server" />
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="2%"></ItemStyle>
                                                                            <FooterTemplate>
                                                                                <asp:ImageButton ID="ImbtAddNewRoute" runat="server" CausesValidation="false" ImageAlign="AbsMiddle"
                                                                                    ImageUrl="~/images/MakeNewRoute.png" ToolTip="Make a New Route" OnClick="ImbtAddNewRoute_Click" />
                                                                            </FooterTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="">
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="ibPasteEmployee" runat="server" ImageUrl="~/images/Move.png"
                                                                                    ToolTip="Move Employee" ValidationGroup="Update" OnClick="ibPasteEmployee_Click" />
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="2%"></ItemStyle>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="">
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="ibDeleteEmployee" runat="server" ImageUrl="~/images/user_remove.png" Enabled='<%# GetAdmin()%>'
                                                                                    ToolTip="Delete Employee" Height="17px" Width="17px" CommandName="Delete" OnClick="ibDeleteEmployee_Click" />
                                                                                <cc1:ConfirmButtonExtender ID="ibDeleteEmployee_ConfirmButtonExtender" runat="server"
                                                                                    ConfirmText="Are you sure you want to delete this Employee?" Enabled="True" TargetControlID="ibDeleteEmployee">
                                                                                </cc1:ConfirmButtonExtender>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="2%"></ItemStyle>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <RowStyle BackColor="#E7E7FF" HorizontalAlign="Left" />
                                                                    <AlternatingRowStyle BackColor="#F7F7F7" BorderColor="Black" HorizontalAlign="Left" />
                                                                    <PagerStyle BackColor="#E7E7FF" HorizontalAlign="Right" />
                                                                    <HeaderStyle CssClass="ChildgridHeaderStyle" />
                                                                    <FooterStyle CssClass="ChildgridFooterStyle" />
                                                                </asp:GridView>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                            <ItemStyle Width="1%"></ItemStyle>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle CssClass="RowStyle" />
                                    <PagerStyle CssClass="PagerStyle" />
                                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                                    <HeaderStyle CssClass="HeaderStyle" />
                                    <EditRowStyle CssClass="EditRowStyle" />
                                    <AlternatingRowStyle CssClass="AltRowStyle" />
                                    <FooterStyle CssClass="FooterStyle" />
                                    <EmptyDataRowStyle ForeColor="Red" Font-Bold="true" HorizontalAlign="Left" />
                                </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <script language="javascript" type="text/javascript">
    <asp:Literal id="litCordinates" runat="server"></asp:Literal>
    </script>

    <asp:HiddenField ID="hfResults" runat="server" />
</asp:Content>
