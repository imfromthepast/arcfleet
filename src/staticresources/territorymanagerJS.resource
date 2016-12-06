				var address;
                var myOptions;
                var color;
                var map;
                var marker;
                var kingdomHall;
                var drawingManager;
                var mapBounds;
                var mode;
                var showMarkers;
                var layer = "toner";
                var territories;
                $j = jQuery.noConflict();
                $j(document).ready(function() {
                    
                    $j("[id$='fields']").hide();
                    $j("[id$='addpopover']").hide();
                    $j("[id$='openpopover']").hide();
                    $j("[id$='setuppopover']").hide();
                    $j('#tmstime').val(convertTimeBack($j("[id$='tmstimefield']").val()));
                    $j('#ptwtime').val(convertTimeBack($j("[id$='ptwtimefield']").val()));
                    var v;
                    var fv;
                    var sv;
                    territories = $j("[id$='territoriesCoords']").val().split('|');
                    if(showMarkers == null) showMarkers = true;
                    updateOrientation();
                    
                    var addv;
                    $j('#add').click(function(){
                        if(addv){
                            $j("[id$='addpopover']").hide();
                            addv = false;
                        }else{
                            $j("[id$='addpopover']").show();
                            addv = true;
                        }
                    });
                    $j("[id$='openmap']").hover(function(){
                        $j("[id$='openpopover']").show();},
                        function(){
                        $j("[id$='openpopover']").hide();
                    });
                    $j('#info').click(function(){
                        if(fv){
                            $j("[id$='fields']").hide(); 
                            fv=false;
                        }else{
                            $j("[id$='setuppopover']").hide(); 
                            $j("[id$='fields']").show();
                            fv=true;
                            sv=false;
                        }
                    });
                    
                    $j('#setup').click(function(){
                        if(sv){
                            $j("[id$='setuppopover']").hide(); 
                            sv=false;
                        }else{
                            $j("[id$='fields']").hide();
                            $j("[id$='setuppopover']").show();
                            sv=true;
                            fv=false;
                        }
                    });
                    
                    address = $j("[id$='search']").val();
                    
                    myOptions = {
                        zoom: 15,
                        streetViewControl: false,
                        mapTypeControl: true,
                        scaleControl: true,
                        draggable: true,
                		mapTypeId: google.maps.MapTypeId.ROADMAP
                    };
                    //alert('nope');
                    map = new google.maps.Map(document.getElementById("map_edit"), myOptions);
                    kingdomHall = new google.maps.Marker({
                        title: "Kingdom Hall",
                        icon: 'https://chart.googleapis.com/chart?chst=d_simple_text_icon_below&chld=Kingdom+Hall|12|0000ff|books|16|0000ff|ffffff'
                    });
                    marker = new google.maps.Marker({
                        title: "Found it"
                    });
                    
                    mapBounds = new google.maps.LatLngBounds();
                    mode = $j("[id$='mode']").val();
                    
                    geocode();
                    $j("#search").keyup(function(event){
                        if(event.keyCode == 13){
                            search();
                        }
                    });
                    var v;
                    var h = $j('#unplotted').height();
                    var w = $j('#unplotted').width();
                    $j('#others').click(function(){
                        if(v){
                            $j('#unplotted').fadeOut(300, function(){v=false});
                        }else{
                            $j('#unplotted').fadeIn(300, function(){v=true});
                        }
                    });
                    
                });
                
				function plotTerritory(id, name, coords, clickfunction, scolor, fcolor, marker, markercoord, markerdraggable, markersize, cid){
                    var territory;
                    var territoryCoords = new Array();
                    var coordsArray = coords.split(';');
                    var markers = new Array();
                    
                    for (var i =0; i < coordsArray.length; i++) {
                        var coordArray = coordsArray[i].split(',');
                        territoryCoords.push(new google.maps.LatLng(coordArray[0],coordArray[1]));
                    }
                    
                    territory = new google.maps.Polygon({
                        paths: territoryCoords,
                        strokeColor: scolor,
                        strokeOpacity: 0.8,
                        strokeWeight: 2,
                        fillColor: fcolor,
                        fillOpacity: 0.35,
                        editable: false
                    });
                    territory.setMap(map);
                    
                    var terrbounds = new google.maps.LatLngBounds();
                    for (i = 0; i < territoryCoords.length; i++) {
                        mapBounds.extend(territoryCoords[i]);
                        terrbounds.extend(territoryCoords[i]);
                    }
                    
                    if(markercoord == 'none'){
                        markercoord = terrbounds.getCenter();
                    }else{
                        var coords = new google.maps.LatLng(markercoord.split(',')[0],markercoord.split(',')[1],true);
                        markercoord = coords;
                    }
                    
                    var terrmarker = new google.maps.Marker({
                        position: markercoord,
                        draggable: markerdraggable,
                        title: ""+name,
                        visible: marker,
                        icon: 'https://chart.googleapis.com/chart?chst=d_text_outline&chld=000000|'+markersize+'|h|ffffff|_|'+name
                    });
                    terrmarker.setMap(map);
                    markers.push(terrmarker);
                    google.maps.event.addListener(terrmarker, 'dragend', function(){
                        UpdateMarker(terrmarker.getPosition());
                    });
                    google.maps.event.addListener(territory.getPath(), 'set_at', function() {
                        UpdateCoords(territory.getPath());
                    });
                    google.maps.event.addListener(territory.getPath(), 'insert_at', function() {
                        UpdateCoords(territory.getPath());
                    });
                    google.maps.event.addListener(territory.getPath(), 'remove_at', function() {
                        UpdateCoords(territory.getPath());
                    });
                    $j("[id$='infocontent']").hide();
                    var coveredtext = '';
                    var contentString = '<h2>Territory #'+name+'</h2>'+
                        ' <a href=\"../apex/territory?id='+id+'\"><i>edit</i></a><p/>'+
                        coveredtext +
                        
                        $j("[id$='infocontent']").html();
                    
                    var infowindow = new google.maps.InfoWindow({
                        content: contentString,
                        position: terrbounds.getCenter()
                    });
                    google.maps.event.addListener(territory, 'click', function() {
                        if(clickfunction == 'edit'){    
                            var territoryOptions = {
                                editable: !territory.getEditable()
                            };
                            territory.setOptions(territoryOptions);
                        }else if(clickfunction == 'link'){
                            window.location = '../apex/territory?id=' + id;
                        }else if(clickfunction == 'viewCong'){
                            window.location = '../apex/congregationmap2?id='+ cid;
                        }else if(clickfunction == 'viewTerr'){
                            window.location = '../apex/territorymap2?id='+ id + '&ks=' + name;
                        }else if(clickfunction == 'info'){
                            infowindow.open(map);
                        }
                    });
                    if(clickfunction == 'edit' || clickfunction == 'viewCong' || clickfunction == 'viewTerr'){
                        map.setCenter(terrbounds.getCenter());
                        map.fitBounds(terrbounds);
                    }
                }
                
                function getColor(covered,checkedout){
                    var c = "#FF0000";
                    if(covered == 'true'){
                        c = "Green";
                    }else if(checkedout == 'true'){
                        c = 'blue';
                    }
                    return c;
                }
                
                function plotTerritories(territories,clickfunction,cid){
                    for (var i =0; i < territories.length; i++) {
                        var idname = territories[i].split('/')[0];
                        var coords = territories[i].split('/')[1];
                        var id = idname.split(':')[0];
                        var name = idname.split(':')[1];
                        var covered = idname.split(':')[2];
                        var checked = idname.split(':')[3];
                        var markercoords = idname.split(':')[4];
                        if(color == 'none') color = getColor(covered,checked);
                        plotTerritory(id, name, coords, clickfunction, color, color, true, markercoords,false,12,cid);
                    }
                }
                function UpdateCoords(vertices){
                    var coordinates = '';
                    for (var i =0; i < vertices.length; i++) {
                        var xy = vertices.getAt(i);
                        coordinates += xy.lat() +',' + xy.lng();
                        if(i<vertices.length-1) coordinates += ';';
                    }
                    $j("[id$='coords']").val(coordinates);
                }
                function UpdateMarker(coords){
                    
                    $j("[id$='markercoords']").val(coords.lat()+','+coords.lng());
                }
                function reveal(){
                    $j('#unplotted').show();
                } 
                function hideEditButtons(){
                    $j("[id$='savebtn']").hide();
                    $j("[id$='cancelbtn']").hide();
                }   
                
                function addnewcongregation(){
                    $j("[id$='cName']").val($j('#cName').val());
                    newCongregation();
                }
                
                function addnewterritories(){
                    $j("[id$='amountofterritories']").val($j('#numberofterritories').val());
                    addterritories();
                }
                
                function goto(p){
                    window.location.replace(p);
                }
                function updateOrientation(){
                    var w=window,d=document,e=d.documentElement,g=d.getElementsByTagName('body')[0],x=w.innerWidth||e.clientWidth||g.clientWidth,y=w.innerHeight||e.clientHeight||g.clientHeight;
                    $j('.wrapper').css({'height':y-55+'px'}); 
                    $j('.touchscrollable').css({'height':y-40+'px'}); 
                    $j('.publisherlist').css({'width':x*0.25+'px'});
                    $j('.territorylist').css({'width':x*0.75+'px'});
                }
                function upsertCongregation(){
                    $j("[id$='ptwtimefield']").val(convertTime($j('#ptwtime').val()));
                    $j("[id$='tmstimefield']").val(convertTime($j('#tmstime').val()));
                    save();
                }
                function convertTime(t){
                    var h;
                    var m;
                    var ham = t.split(':');
                    if(ham[0] > 12){
                        h = ham[0] - 12;
                        m = 'pm';
                    }else{
                        h = ham[0];
                        m = 'am';
                    }
                    return h+':'+ham[1]+' '+m;
                }
                function convertTimeBack(t){
                    if(t != null){
                        if(t != ''){
                            var a = t.split(':');
                            var hs = a[0];
                            var ms = a[1];
                            var m = ms.split(' ');
                            
                            if(m[1] == 'pm'){
                                var hi = parseInt(hs) + 12;
                                hs = hi.toString();
                            }
                            
                            return hs+':'+m[0];
                        }
                    }
                }