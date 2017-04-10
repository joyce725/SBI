<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="import.jsp" flush="true"/>

<link rel="stylesheet" href="css/jquery-ui.min.1.12.1.css"/>
<link rel="stylesheet" href="css/styles_map.css"/>
<link href="./fancy-tree/skin-xp/ui.fancytree.css" rel="stylesheet">

<script src="js/d3.v3.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/additional-methods.min.js"></script>
<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>
<script src="./js/jquery-ui.custom.js"></script>
<!-- 以下js為 import 畫POImenu和畫WKT的js  -->
<script src="./fancy-tree/jquery.fancytree.js"></script>
<script src="refer_data/js/wicket.js"></script>
<script src="refer_data/js/wicket-gmap3.js"></script>
<!-- 以下為自寫的map相關和POIMenu function -->
<script src="js/mapFunction.js"></script>
<script src="js/menu_of_POI.js"></script>
<style>
	#region_select,#warning{
		font-family: "微軟正黑體", "Microsoft JhengHei", 'LiHei Pro', Arial, Helvetica, sans-serif, \5FAE\8EDF\6B63\9ED1\9AD4,\65B0\7D30\660E\9AD4;
	}
	#search-box-input-view{
		position: fixed;
		left: 140px;
		top: 62px;
		width: 300px;
		box-shadow:  0 2px 6px rgba(0, 0, 0, 0.3);
		z-index:2;
	}
	#search-box-enter{
		position: fixed;
		left: 450px;
		top: 66px;
		box-shadow:  0 2px 6px rgba(0, 0, 0, 0.3);
	}
</style>
<script>
var result="";
var map;

var item_marker = function (speed, time, marker, circle) {
	this.speed = speed;
	this.time = time;
	this.marker = marker;
	this.circle = circle;
}

	$(function(){
		
		$("body").append("<div id='msgAlert'></div>")
		$("#shpLegend").draggable({ containment: ".page-wrapper" });
		draw_menu_of_poi({
			action : "select_menu", 
			type : "POI"
		});
		
		$( "#opacity" ).slider({
	      range: "min",
	      value: 100,
	      min: 40,
	      max: 100,
	      slide: function( event, ui ) {
	        $( "#panel" ).css("opacity", (ui.value*0.01) );
	      }
	    });
		
		$("#region_select").dialog({
			draggable : true,
			resizable : false,
			autoOpen : false,
			//minHeight : 125,
            //minWidth : 500 ,
			height : "auto", 
			width : "auto", 
			modal : false,
			
			position: { 
				my: "center", 
				at: "right-180px top+240px ", 
				of: window  
			} ,  
			show : {
				effect : "blind",
				duration : 300
			},
			hide : {
				effect : "fade",
				duration : 300
			},
			open :function(){
				map.setOptions({
					draggableCursor:("url("+location.href.replace('POI.jsp','')
							+"refer_data/cursor2.cur),default")
				});
			},
			close : function() {
				map.setOptions({draggableCursor:null});
				$("#region_select").dialog("close");
			}
		});
		$("#region_select").show();
		
		$( "#speed" ).spinner({
		    min: 0,
		    max: 3000,
		    spin: function(event, ui) {
		    	$("#speed").val(ui.value);
		        $(this).change();
		    }
		});
		$( "#time" ).spinner({
		    min: 0,
		    max: 86400,
		    spin: function(event, ui) {
		    	$("#time").val(ui.value);
		    	$(this).change();
		    }
		});
	    $( "#slider" ).slider({
	    	min: 0,
	        max: 120,
	        value: 30,
	        orientation: "horizontal",
	        range: "min",
	        animate: true,
	        slide: function (event, ui) {
	        	$("#time").val(ui.value);
	        	$("#val_time").html("花費"+ui.value+"分鐘");
	        	$("#rr_pt").val().speed=$("#speed").val();
		    	$("#rr_pt").val().time=$("#time").val();
	        	$("#rr_pt").val().circle.setRadius($("#speed").val()*$("#time").val()*1000*0.016667);
	        }
	    });

	    $("#region_select_next").click(function(){
	    	if(rs_markers.length==0){
    			$("#warning").html("<div style='padding:5px 80px;font-size:28px;'>請放置分析點。</div>");
    			$("#warning").dialog("open");
	    	}else{
	    		map.setOptions({draggableCursor:null});
	    		$("#instruction").hide();
	    		$("#draw_circle").show();
	    		$.each(rs_markers,function(i, item) {
	    			rs_markers[i].circle.setRadius(rs_markers[i].speed* rs_markers[i].time *1000 * 0.016667);
	    		});
	    		$("div[aria-describedby='region_select']").animate({"left": "-=180px"});
	    	}
	    });
	    
	    $("#region_select_last").click(function(){
	    	map.setOptions({
	    		draggableCursor:("url("+location.href.replace('realMap.jsp','')
	    				+"refer_data/cursor2.cur),default")
	    	});
    		$("#instruction").show();
    		$("#draw_circle").hide();
    		$("div[aria-describedby='region_select']").animate({"left": "+=180px"});
	    });

	    $("#speed").change(function(){
	    	$('#val_speed').html("時速"+$(this).val()+"公里");
	    	$("#rr_pt").val().speed=$("#speed").val();
	    	$("#rr_pt").val().time=$("#time").val();
	    	$("#rr_pt").val().circle.setRadius($("#speed").val()*$("#time").val()*1000*0.016667);
		});
	    $("#time").change(function(){
	    	$('#val_time').html("花費"+$(this).val()+"分鐘");
	    	$("#rr_pt").val().speed=$("#speed").val();
	    	$("#rr_pt").val().time=$("#time").val();
	    	$("#rr_pt").val().circle.setRadius($("#speed").val()*$("#time").val()*1000*0.016667);
			$('#slider').slider('option', 'value', $(this).val());   
		});
		
	    $("#tooltip_1").mouseover(function(e){
			 this.newTitle = this.title;
			 this.title = "";
			 var tooltip = "<div id='tooltip'>"+ this.newTitle +"<\/div>";
			 $("body").append(tooltip);
			 $("#tooltip").css({"top": (e.pageY+20) + "px","left": (e.pageX+10)  + "px"}).show("fast");
		 }).mouseout(function(){
		         this.title = this.newTitle;
		         $("#tooltip").remove();
		 }).mousemove(function(e){
		         $("#tooltip").css({"top": (e.pageY+20) + "px","left": (e.pageX+10)  + "px"});
		 });
	    $("#warning").dialog({
			draggable : true, resizable : false, autoOpen : false,
			height : "auto", width : "auto", modal : true,
			show : {effect : "fade",duration : 300},
			hide : {effect : "fade",duration : 300},
			buttons : {
				"確認" : function() {
					$(this).dialog("close");
				}
			}
		});
	    $("#warning").show();
        $("#pdf_layer").menu();
	});
	
</script>

<jsp:include page="header.jsp" flush="true"/>
<div class="content-wrap">
	<input type='text' id='search-box-input-view' placeholder="輸入欲查詢地址">
	
	<a class='btn btn-primary' id='search-box-enter'>查詢</a>
	<div id='panel' style="display:none;"
	onmouseover="$('#panel').css('left','150px');clearTimeout($('#panel').val());" 
	onmouseout="$('#panel').val(setTimeout(function () { $('#panel').css('left','0px'); }, 800));">
		<div id='tree' >
		<script>var timer="";</script>
		<ul id='pdf_layer' onmouseover='clearTimeout(timer);$("#pdf_layer").show();' 
				onmouseout=' timer=setTimeout(function(){$("#pdf_layer").hide();},500);' 
				style='position:absolute;top:200px;left:10px;z-index:30;width:auto;display:none;'>
			<li><div>Books</div></li>
		</ul>
		</div>
		<div id='pin' style='position:absolute;top:5px;right:20px;'' class='on_it' 
				onclick='$("#pin").hide();$("#unpin").show();$("#panel").attr("tmp",$("#panel").attr("onmouseout"));$("#panel").attr("onmouseout","");'><img src='./refer_data/pin.png'></div>
		<div id='unpin' style='position:absolute;top:5px;right:20px;display:none;' class='on_it' 
				onclick='$("#unpin").hide();$("#pin").show();$("#panel").attr("onmouseout",$("#panel").attr("tmp"));'><img src='./refer_data/unpin.png'></div>
		<div style='position:absolute;width:100%;bottom:5px;border-top:2px solid #aaa;padding:10px 0px 5px 0px;'><table><tr><td>&nbsp;&nbsp;透明度：</td><td><div id='opacity' style='width:160px;'></div></td></tr></table></div>
	</div>
	
<h2 class="page-title">商圈POI</h2>
	<div class="search-result-wrap">
	<a class="btn btn-orange" onclick='$("#region_select").dialog("open");' style='position:absolute;right:5%;top:110px;z-index:99;'>環域分析</a>
	<div id="map"></div>
	<div id='region_select' title='環域分析' style='display:none;'>
		<div id="instruction">
			<div style="margin:14px 20px;font-size:22px;color:#F00;font-weight:900;word-break: keep-all;" class='blink'>請點擊地圖新增分析點。</div>
			<hr style='height:1px;border:none;border-top:1px solid #ddd;'>
			<div style="margin:0px 20px;float:right;">
				<button class='ui-button' id='region_select_next'>下一步</button>
				<button class='ui-button' onclick='while(rs_markers.length>0){var tmp = rs_markers.pop();tmp.marker.setMap(null);tmp.circle.setMap(null)};'>清除所有點</button>
			</div>
		</div>
		<div id="draw_circle" style='display:none'>
			<table id="region_step_2" class="bentable">
				<tr style=''>
					<td colspan='3' valign="bottom">
						　&nbsp;<br>調整<span style='font-weight: bold;line-height:40px;'>點位<span id="rr_pt" style="transition: all .3s linear;">1</span></span>的[交通方式]與[通勤時間]
						<a  style="float:right;" id="suggest_time_html" href="./refer_data/Traffic_Time.htm" target="_blank">建議時數</a>
					</td>
				</tr>
				<tr>
					<td>
						<div class="col" id="tooltip_1" title="預設時速為車行60公里、步行4公里、單車15公里">
							<span style='font-weight: bold;'>交通方式：</span>
						</div>
					</td>
					<td>
						<img src='./refer_data/car.png' title="車行" val="60" 
							onclick='$("#speed").val(60);$("#speed").change();'>
						<img src='./refer_data/walk.png' title="步行" val="4" 
							onclick='$("#speed").val(4);$("#speed").change();'>
						<img src='./refer_data/bike.png' title="單車" val="15"
							 onclick='$("#speed").val(15);$("#speed").change();'>
					</td>
					<td>
						　時速：<input id='speed' style='width:40px;height:20px;padding:0px;' value='10'>　公里
					</td>
				</tr>
				<tr>
					<td>
						<span style='font-weight: bold;'>通勤時間：</span>
					</td>
					<td>
						<div id='slider'></div>
					</td>
					<td>
						　需時：<input id='time' style='width:40px;height:20px;padding:0px;' value='30'>　分鐘
					</td>
				</tr>
				<tr style='height:50px;'>
					<td>
						預設：
					</td>
					<td colspan='2'>
						<a id="val_speed" style='color: #c33;text-decoration:underline;font-size:18px;font-weight: bold;'>時速4公里</a>&nbsp;
						<a id="val_time" style='color: #c33;text-decoration:underline;font-size:18px;font-weight: bold;'>花費15分鐘</a>&nbsp;
						之可達範圍
					</td>
				</tr>
			</table>
			<hr style='height:1px;border:none;border-top:1px solid #ddd;'>
			<div style="margin:0px 20px;float:right;">
				<button class='ui-button' id='region_select_last'>上一步</button>
				　<button class='ui-button' id='end' onclick='$("#region_select").dialog("close");'>結束</button>
			</div>
		</div>
	</div>
<div id="shpLegend" class="shpLegend" style=" height: 235.5px;display:none;">
    <button onclick='$("#shpLegend").hide();'>x</button>
    <div style="display: block; background-color: #F0F0F0;">
        <table style="width:280px;">
            <tr>
                <th colspan="2" style="font-size: large;">
                    <span id="span_legend">TITLE</span>
                </th>
            </tr>
            <tr id="tr_year">
                <td style="width: 80px;">年份&nbsp;:</td><td><span id="ddl_year">Year</span></td>
            </tr>
            <tr>
                <td style="width: 80px;">單位&nbsp;:</td><td><span id="span_unit">Unit</span></td>
            </tr>
            <tr>
                <td style="vertical-align: top;">圖例&nbsp;:</td>
                <td>
                    <table>
                        <tr>
                            <td style="width: 10px;">
                                <div class="mapLegend" style="background-color: #41A85F;"></div>
                            </td>
                            <td><span id="span_level1">Level 1</span></td>
                        </tr>
                        <tr>
                            <td>
                                <div class="mapLegend" style="background-color: #8db444;"></div>
                            </td>
                            <td><span id="span_level2">Level 2</span></td>
                        </tr>
                        <tr>
                            <td>
                                <div class="mapLegend" style="background-color: #FAC51C;"></div>
                            </td>
                            <td><span id="span_level3">Level 3</span></td>
                        </tr>
                        <tr>
                            <td>
                                <div class="mapLegend" style="background-color: #d87926;"></div>
                            </td>
                            <td><span id="span_level4">Level 4</span></td>
                        </tr>
                        <tr>
                            <td>
                                <div class="mapLegend" style="background-color: #B8312F;"></div>
                            </td>
                            <td><span id="span_level5">Level 5</span></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</div>
	<div id="detail_1"></div>
	<div id='warning' title='系統訊息' style='display:none;padding:20px 20px 10px 20px;word-break: keep-all;'>
		為了提供您更好的使用品質，該功能維護中。
	</div>
	
    <script>
    var rs_markers=[];
	    function initMap() {
			map = new google.maps.Map(document.getElementById('map'), {
				panControl: true,
			    zoomControl: true,
			    mapTypeControl: false,
			    scaleControl: true,
			    streetViewControl: true,
			    overviewMapControl: true,
			    zoom: 7,
				center: {lat: 23.598321171324468, lng: 120.97802734375}
			});
			google.maps.event.addListener(map, 'click', function(event) {
				if($("#region_select").dialog("isOpen")&& $("#draw_circle").css("display")=="none"){
					
					if(rs_markers.length>=5){warningMsg('警告', "最多五個點");return;}
					var order=(rs_markers.length+1)+"";
					var rs_marker = new google.maps.Marker({
					    position: event.latLng,
					    animation: google.maps.Animation.DROP,
					    icon: 'http://maps.google.com/mapfiles/kml/paddle/' + order + '.png',
					    map: map,
					    draggable:true,
					    title: ("--分析點"+order+"--")
					});
					var rs_circle = new google.maps.Circle({
						  strokeColor: '#FF0000',
						  strokeOpacity: 0.5,
						  strokeWeight: 2,
						  fillColor: '#FF8700',
						  fillOpacity: 0.2,
						  map: map,
						  center: event.latLng,
						  radius: 0 
					});
					var marker_obj = new item_marker( 4, 15, rs_marker, rs_circle);
					
					$("#rr_pt").html(order);
					$("#rr_pt").val(marker_obj);
					$("#speed").val(marker_obj.speed);
					$("#time").val(marker_obj.time);
					$('#slider').slider('option', 'value', marker_obj.time);
			        rs_markers.push(marker_obj);
					google.maps.event.addListener(rs_marker, "click", function(event) { 
						$.each(rs_markers, function(i, node){
							rs_markers[i].marker.setAnimation(null);
						});
						$("#rr_pt").css("font-size","38px");
						setTimeout(function(){$("#rr_pt").css("font-size","16px");},1000);
						$("#rr_pt").css("color","red");
						setTimeout(function(){$("#rr_pt").css("color","black");},1000);
						$("#rr_pt").html(order);
						$("#rr_pt").val(marker_obj);
						$("#speed").val(marker_obj.speed);
						$("#time").val(marker_obj.time);
						$('#val_time').html("花費"+marker_obj.time+"分鐘");
						$('#val_speed').html("時速"+marker_obj.speed+"公里");
						$('#slider').slider('option', 'value', marker_obj.time);
			        }); 
			        
				    google.maps.event.addListener(rs_marker, 'drag', function(marker){
				    	rs_circle.setCenter(marker.latLng);
				    });
				    google.maps.event.addListener(rs_marker, 'dragstart', function(marker){
				    	rs_marker.setAnimation(null);
				    	$.each(rs_markers, function(i, node){
							rs_markers[i].marker.setAnimation(null);
						});
						$("#rr_pt").css("font-size","38px");
						setTimeout(function(){$("#rr_pt").css("font-size","16px");},1000);
						$("#rr_pt").css("color","red");
						setTimeout(function(){$("#rr_pt").css("color","black");},1000);
						$("#rr_pt").html(order);
						$("#rr_pt").val(marker_obj);
						$("#speed").val(marker_obj.speed);
						$("#time").val(marker_obj.time);
						$('#slider').slider('option', 'value', marker_obj.time);
				    });
				}
			});
			
			$("#search-box-input-view").keypress(function(e) {
				if(e.which == 13) {
			    	e.preventDefault();
			    	$("#search-box-enter").trigger("click");
			    }
			});
			
			$("#search-box-enter").click(function(e){
				e.preventDefault();
				var search_str = $("#search-box-input-view").val();
				if($("#search-box-input-view").val().length==0){
					warningMsg('警告', "請輸入關鍵字以供查詢");
		            return;
				}
				//先查POI
				var poi_amount=0;
				$.ajax({
					type : "POST",
					url : "realMap.do",
					async : false,
					data : {
						action : "select_poi",
						name : search_str,
						lat : map.getCenter().lat,
						lng : map.getCenter().lng,
						zoom : map.getZoom()
					},success : function(result) {
						var json_obj = $.parseJSON(result);
						if(json_obj.length>0){
							poi_amount=json_obj.length;
							select_poi(search_str,"no_record");
						}
					}
				});
				
				if(poi_amount!=0){
					return;
				}
						
				//沒有POI接著查地址
				var str_to_place_service = new google.maps.places.AutocompleteService();
				str_to_place_service.getPlacePredictions({
					    input: search_str,
					    offset: search_str.length
					}, function listentoresult(list, status) {
						if (status != google.maps.places.PlacesServiceStatus.OK || list==null ) {
							warningMsg('警告', "查無結果請輸入更詳細關鍵字");
							return;
				    	}
						if (list[0].description!=search_str){
							console.log("您搜尋的地點或許是:"+list[0].description);
							warningMsg('警告', "查無結果請輸入更詳細關鍵字");
				            return;
						}
								
						if(list[0].description.length-search_str.length>4){
							warningMsg('警告', ("您搜尋的地點或許是: "+list[0].description));
							$("#search-box-input-view").val(list[0].description);
						}
						var place_to_latlng_service = new google.maps.places.PlacesService(map);
						place_to_latlng_service.getDetails({ 
								placeId: list[0].place_id
							}, function(place, status) {
								if (status == google.maps.places.PlacesServiceStatus.OK) {
									address = [
				 					    (place.address_components[0] && place.address_components[0].short_name || ''),
				 					    (place.address_components[1] && place.address_components[1].short_name || ''),
				 					    (place.address_components[2] && place.address_components[2].short_name || '')
				 					  ].join(' ');
									if(false){//$("#region_select").dialog("isOpen")&& $("#draw_circle").css("display")=="none"){
										if(rs_markers.length>=5){
											warningMsg('警告', "最多五個點");
											return;
										}
										var order=(rs_markers.length+1)+"";
										var rs_marker = new google.maps.Marker({
										    position: place.geometry.location,
										    animation: google.maps.Animation.DROP,
										    icon: 'http://maps.google.com/mapfiles/kml/paddle/' + order + '.png',
										    map: map,
										    draggable:true,
										    title: ("--分析點"+order+"--")
										});
										var rs_circle = new google.maps.Circle({
											  strokeColor: '#FF0000',
											  strokeOpacity: 0.5,
											  strokeWeight: 2,
											  fillColor: '#FF8700',
											  fillOpacity: 0.2,
											  map: map,
											  center: place.geometry.location,
											  radius: 0 
										});
										var marker_obj = new item_marker( 4, 15, rs_marker, rs_circle);
										
										$("#rr_pt").html(order);
										$("#rr_pt").val(marker_obj);
										$("#speed").val(marker_obj.speed);
										$("#time").val(marker_obj.time);
										$('#env_slider').slider('option', 'value', marker_obj.time);
								        rs_markers.push(marker_obj);

										google.maps.event.addListener(rs_marker, "click", function(event) { 
											$.each(rs_markers, function(i, node){
												rs_markers[i].marker.setAnimation(null);
											});
											$("#rr_pt").css("font-size","38px");
											setTimeout(function(){$("#rr_pt").css("font-size","16px");},1000);
											$("#rr_pt").css("color","red");
											setTimeout(function(){$("#rr_pt").css("color","black");},1000);
											$("#rr_pt").html(order);
											$("#rr_pt").val(marker_obj);
											$("#speed").val(marker_obj.speed);
											$("#time").val(marker_obj.time);
											$('#val_time').html("花費"+marker_obj.time+"分鐘");
											$('#val_speed').html("時速"+marker_obj.speed+"公里");
											$('#env_slider').slider('option', 'value', marker_obj.time);
								        }); 
								        
									    google.maps.event.addListener(rs_marker, 'drag', function(marker){
									    	rs_circle.setCenter(marker.latLng);
									    });

									    google.maps.event.addListener(rs_marker, 'dragstart', function(marker){
									    	rs_marker.setAnimation(null);
									    	$.each(rs_markers, function(i, node){
												rs_markers[i].marker.setAnimation(null);
											});
											$("#rr_pt").css("font-size","38px");
											setTimeout(function(){$("#rr_pt").css("font-size","16px");},1000);
											$("#rr_pt").css("color","red");
											setTimeout(function(){$("#rr_pt").css("color","black");},1000);
											$("#rr_pt").html(order);
											$("#rr_pt").val(marker_obj);
											$("#speed").val(marker_obj.speed);
											$("#time").val(marker_obj.time);
											$('#env_slider').slider('option', 'value', marker_obj.time);
									    });
										
									}else{
										//只放info
										var infowindow = new google.maps.InfoWindow({
											content: ("<div style='padding:6px;'><strong>" + place.name + "</strong><br>" + address+"</div>"),
											disableAutoPan: true
										});
										var marker = new google.maps.Marker({
										    position: place.geometry.location,
										    animation: google.maps.Animation.DROP,
										    icon: null,
										    map: map,
										    draggable:true,
										});
										map.setCenter(place.geometry.location);
										if($("#region_select").dialog("isOpen")&& $("#draw_circle").css("display")=="none"){
										}else{
											map.fitBounds(place.geometry.viewport);
										}
										marker.setVisible(false);
										infowindow.open(map, marker);
										google.maps.event.addListener(infowindow, "closeclick", function () {
											marker.setMap(null);
											infowindow.setMap(null);
								        });
									}
								}
						});
				});
				return ;
			});
   		}
    </script>
    
<!--     	給markercluster用的 -->
    <script src="js/markerclusterer.js"></script>
<!--     libraries=visualization 是給熱力圖用的 -->
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBSQDx-_LzT3hRhcQcQY3hHgX2eQzF9weQ&signed_in=true&libraries=places,visualization&callback=initMap"></script>
<!--     <script async defer -->
<!--         src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBSQDx-_LzT3hRhcQcQY3hHgX2eQzF9weQ&signed_in=true&libraries=visualization&callback=initMap"> -->
<!--     </script> -->
	<div id='picture' style='position:fixed;left:10%;top:20%;z-index:-1;'ondblclick='$("#picture").css("z-index","-1");'></div>
	</div>
</div>

<jsp:include page="footer.jsp" flush="true"/>