<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="import.jsp" flush="true"/>
<script src="js/d3.v3.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/additional-methods.min.js"></script>
<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>
<!-- <script src="http://html2canvas.hertzen.com/build/html2canvas.js"></script> -->

<!-- <script src="https://arthur-e.github.io/Wicket/wicket.js"></script> -->
<!-- <script src="https://arthur-e.github.io/Wicket/wicket-leaflet.js"></script> -->



<!-- <script src="./js/jquery-1.12.4.min.js"></script> -->
<script src="./js/jquery-ui.custom.js"></script>

<link href="./fancy-tree/skin-xp/ui.fancytree.css" rel="stylesheet">
<script src="./fancy-tree/jquery.fancytree.js"></script>

<script src="refer_data/js/wicket.js"></script>
<script src="refer_data/js/wicket-gmap3.js"></script>
<script src="js/mapFunction.js"></script>

<!-- <script src="refer_data/js/country_economy.js"></script> -->

<style>
	
/* 	以下為SBI CSS */
	.shpLegend {
	    border: 2px groove #dfd9c3;
/* 	    background-color: rgba(177,207,254,.3); */
	    background-color:#F0F0F0;
	    position: absolute;
/* 	    top: initial; */
/* 	    left: initial; */
		bottom : 50px;
		right :50px;
	    display: block;
	    z-index: 9999;
	    height: 183.5px;
	}

    .shpLegend tbody tr.even td {
        background: none;
    }
    .shpLegend th { padding:3px;}
    .shpLegend td  {
        padding:6px 5px;
    }
	.shpLegend td:nth-child(2n+1)  {
        text-align:right;
    }
    /*#businessDistrictLegend button {*/
    .shpLegend button {
        position: absolute;
        top: 2px;
        right: 3px;
        padding: 0 .1em .1em 0.2em;
        line-height: 9px;
        font-size: 12px;
    }
	.mapLegend {
	    width: 10px;
	    height: 10px;
	}
/* 	以上為SBI CSS */
	
	.header { top: 0px; }
	.content-wrap{
	    background: #fff;
	    float: left;
	    margin-left: 0px;
	    margin-top: 100px;
 	    margin-bottom: 20px; 
 	    padding-bottom: 62px; 
	    overflow-y: scroll;
	    width: 100%;
		background-color: #EEF3F9;
	}
	.search-result-wrap{
 		padding: 2px 5px 0px 5px; 
		margin-bottom: 20px;
		height: 100%;
	}
/* 	以上為整體介面CSS */
/* 	以下為自製CSS */
	.blink {
	    animation-duration: 1s;
	    animation-name: blink;
	    animation-iteration-count: infinite;
	    animation-direction: alternate;
	    animation-timing-function: ease-in-out;
	}
	@keyframes blink {
	    from {
	        opacity: 0.8;
	    }
	    to {
	        opacity: 0.5;
	    }
	}
	.bentable {
		margin: 0px 20px 0px 20px;
		width:400px;
	}
	.bentable tr{
		padding:5px;
		height: 30px;
	}
	.bentable td:nth-child(2n+1){
		word-break: keep-all;
	}
	.bentable img:hover{
		background: #d8d8d8;
		box-shadow:1px 1px 2px #999;
	}
	#panel{
		background: url(./fancy-tree/skin-xp/bg.png) repeat;
		transition: all .3s linear;
		position:fixed;
		left:0px;
		top:96px; 
		min-width:200px;
		width:auto;
		height:calc(100vh - 129px);
		
		z-index:99;
		overflow-y: auto;
		overflow-x: auto;
		border: 2px solid #777;
		border-radius: 2px;
		box-shadow:5px 5px 5px #999;
	}

	#map{
		height: 100%;
		
 	}
 	
    #map > div {}
    #tooltip{
        position:absolute;
        border:1px solid #333;
        background:#f7f5d1;
        padding:3px;
        color:#333;
        display:none;
        z-index:999;
	}
</style>
	
<script>
var result="";
//Map相關的參數們
var map;
var transitLayer;
var trafficLayer;
var country_polygen=[];
var all_markers={};
var all_BDs={};
//Map相關的參數們
var action={};//記錄所有 tb_data_menu出來的action 對應每一個fancytreenode
var have_visited={};


function hidecheckbox(json){
	var i=0;
	i=0;for(item in json){i++;}
	if(i==0)return;
	for (key in json){
		if(key=="folder" && json[key]=="true"){
			json["hideCheckbox"]=true;
		}
// 		alert(key);
		if(key=="action"){
			action[json["key"]]=json[key];
		}
		
		i=0;for(item in json[key]){i++;}
		if(i>0 && (typeof json[key]!="string")){
			hidecheckbox(json[key]);
		}
	}
}

var item_marker = function (speed, time, marker, circle) {
	this.speed = speed;
	this.time = time;
	this.marker = marker;
	this.circle = circle;
}

	$(function(){
		
		
		$("#shpLegend").draggable({ containment: ".page-wrapper" });
// 		select_poi("超市便利商店");
// 		select_BD("後驛商圈");
// 		select_poi_2("圖書館");
// setTimeout(function () {
// 	smoothZoom(map, 12, map.getZoom());
// panTo(12.736504830663572,122.92672729492188);
// 	smoothZoom(map, 5, map.getZoom());
// },3000);
		$('#panel').css('left',(10-parseInt($('#panel').css('width'),10)));
		$.ajax({
			type : "POST",
// 			url : "test.do",
			url : "realMap.do",
			async : false,
			data : {
// 				action : "select_area"
				action : "select_menu", name : ""
			},
			success : function(result) {
				json_obj = $.parseJSON(result);
				hidecheckbox(json_obj);
				$("#tree").fancytree({
					aria: true,
					checkbox: true,
					selectMode: 2,
					quicksearch: true,
					focusOnSelect: true,
					source : json_obj,
					click: function (event, data) {
						var node = data.node;
						//alert(node.span.innerHTML);
						if($(node.span.childNodes[1]).hasClass('loading')) { return false; }
						//alert(node.span.childNodes[1]);
						//alert(data.node.key);
						//alert($("#tree").fancytree("getTree").getNodeByKey(data.node.key));
					    if(!data.node.isFolder()){
					    	event.preventDefault();
					    	 //alert($(node.span).html());//addClass(".fancytree-loading");
					    	//$(node.span.childNodes[1]).addClass('loading');
					    	node.setSelected( !node.isSelected() );
// 					    	alert(data.node.key);
					    	if(false){//data.node.key=="50007"){
					    		//heatMap(node,"3c");
					    		//select_poi("超市便利商店");
					    		//panTo( 39.1290932, 117.1853255 );smoothZoom(map, 14, map.getZoom());
					    		//smoothZoom(map, 13, map.getZoom());
					    	}else{
					    		
					    		//cb.addClass('loading');
					    		// $cb.removeClass('loading');
					    		if(action[data.node.key].length==0){
					    			$("#warning").dialog("open");
					    			node.setSelected(false);
					    		}
					    		eval(action[data.node.key]);
					    	}
 					    	//console.log("out");
// 					    	node.setSelected( !node.isSelected() );
					    }else{
					    	if(have_visited[node.key]==null){
					    		have_visited[node.key]=true;
					    		eval(action[node.key]);
					    	}
					    }
					},
					activate: function (event, data) {
					    var node = data.node;
					    if($(node.span.childNodes[1]).hasClass('loading')) { return false; }
					    node.setSelected( !node.isSelected() );
					    
					    if(data.node.isFolder()&&have_visited[node.key]!=null){eval(action[data.node.key]);}
					},
					
					select: function(event, data) {
						var node = data.node;
						if($(node.span.childNodes[1]).hasClass('loading')) { return false; }
						if(node.isSelected()){
// 							eval(action[data.node.key]);
// 							alert('selected: '+ data.node.key+"  "+data.node.title);
							//用key去叫動作
						}
						//var s = data.tree.getSelectedNodes().join("#_# ");
						//console.log(s);
						//$("#echoSelected").text(s);
					}
				});
			}
		});
// 		$("#ftal_hell-_-").parent().attr("onclick","alert('@_@');");
		
		$("#region_select").dialog({
			draggable : true,resizable : false,autoOpen : false,
			height : "auto", width : "auto", 
			modal : false,
			position: { my: "center", at: "right-180px top+240px ", of: window  } ,  
// 			bgiframe: true,
			show : {effect : "blind",duration : 300},
			hide : {effect : "fade",duration : 300},
			open :function(){
				map.setOptions({draggableCursor:("url("+location.href.replace('realMap.jsp','')+"refer_data/cursor2.cur),default")});
			},
			close : function() {
				map.setOptions({draggableCursor:null});
				//map.setOptions({draggableCursor:'url("https://maps.gstatic.com/mapfiles/openhand_8_8.cur"), default'});
				//map.setOptions({draggableCursor:'url(./refer_data/cursor.cur), default'});
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
	  //##############################################
	  //###########  以下是環域分析step1相關  ###############
	  //##############################################
	    $("#region_select_next").click(function(){
	    	if(rs_markers.length==0){
	    		alert("請放置分析點。");
	    	}else{
	    		map.setOptions({draggableCursor:null});
	    		$("#instruction").hide();
	    		$("#draw_circle").show();
	    		$.each(rs_markers,function(i, item) {
	    			rs_markers[i].circle.setRadius(rs_markers[i].speed* rs_markers[i].time *1000 * 0.016667);
	    		});
// 	    		alert($('div[aria-describedby="region_select"]').html());
	    		$("div[aria-describedby='region_select']").animate({"left": "-=180px"});
	    	}
	    });
	    $("#region_select_last").click(function(){
	    	map.setOptions({draggableCursor:("url("+location.href.replace('realMap.jsp','')+"refer_data/cursor2.cur),default")});
    		$("#instruction").show();
    		$("#draw_circle").hide();
    		$("div[aria-describedby='region_select']").animate({"left": "+=180px"});
	    });
		  //##############################################
		  //###########  以下是環域分析step2相關  ###############
		  //##############################################
	    $("#speed").change(function(){
// 			alert("444 "+$(this).val()); 
	    	$('#val_speed').html("時速"+$(this).val()+"公里");
	    	$("#rr_pt").val().speed=$("#speed").val();
	    	$("#rr_pt").val().time=$("#time").val();
	    	$("#rr_pt").val().circle.setRadius($("#speed").val()*$("#time").val()*1000*0.016667);
// 	    	alert($(this).val()*$("#time").val()*1000);
		});
	    $("#time").change(function(){
// 	    	alert($("#rr_pt").val());
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
	});
</script>

<jsp:include page="header.jsp" flush="true"/>
<div class="content-wrap">
	<div id='panel' onmouseover="$('#panel').css('left','0px');clearTimeout($('#panel').val());" onmouseout="$('#panel').val(setTimeout(function () { $('#panel').css('left',(10-parseInt($('#panel').css('width'),10))); }, 800));">
		<div id='tree'></div>
	</div>
	
<h2 class="page-title">商圈定位</h2>
	<div class="search-result-wrap">
	<div id="map"></div>
	<button id='btn' onclick='$("#region_select").dialog("open");' style="float:right;">打開環域分析</button>
<!-- 	<button id='test' onclick="alert('hello');" style="float:right;">test func</button> -->
	<div id='region_select' title='環域分析' style='display:none;'>
		<div id="instruction">
			<div style="margin:14px 20px;font-size:22px;color:#F00;font-weight:900;" class='blink'>請點擊地圖新增分析點。</div>
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
<!-- 					</td><td> -->
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
						<img src='./refer_data/car.png' title="車行" val="60" onclick='$("#speed").val(60);$("#speed").change();'>
						<img src='./refer_data/walk.png' title="步行" val="4" onclick='$("#speed").val(4);$("#speed").change();'>
						<img src='./refer_data/bike.png' title="單車" val="15" onclick='$("#speed").val(15);$("#speed").change();'>
					</td>
					<td>
						　時速：<input id='speed' style='width:40px;height:14px;' value='10'>　公里
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
						　需時：<input id='time' style='width:40px;height:14px;' value='30'>　分鐘
					</td>
				</tr>
<!-- 				＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃ -->
				<tr style='height:50px;'>
					<td>
						預設：
					</td>
					<td colspan='2'>
						<a id="val_speed" style='color: #c33;text-decoration:underline;font-size:18px;font-weight: bold;'>時速10公里</a>&nbsp;
						<a id="val_time" style='color: #c33;text-decoration:underline;font-size:18px;font-weight: bold;'>花費30分鐘</a>&nbsp;
						之可達範圍
					</td>
<!-- 					<td> -->
<!-- 						需時:<input id='time' style='width:100px;'>分鐘 -->
<!-- 					</td> -->
				</tr>
			</table>
			<hr style='height:1px;border:none;border-top:1px solid #ddd;'>
			<div style="margin:0px 20px;float:right;">
				<button class='ui-button' id='region_select_last'>上一步</button>
				　<button class='ui-button' onclick='$("#region_select").dialog("close");'>結束</button>
			</div>
		</div>
	</div>

<!-- 左下角的框框 -->
<div id="shpLegend" class="shpLegend" style=" height: 235.5px;display:none;">
    <button onclick='$("#shpLegend").hide();'>x</button>
    <div style="display: block; background-color: #F0F0F0;">
        <table style="width: 280px;">
            <tr>
                <th colspan="2" style="font-size: large;">
                    <span id="span_legend">TITLE</span>
                </th>
            </tr>
            <tr id="tr_year">
                <td style="width: 50px;">年份&nbsp;:</td><td><span id="ddl_year">Year</span></td>
            </tr>
            <tr>
                <td style="width: 50px;">單位&nbsp;:</td><td><span id="span_unit">Unit</span></td>
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
<!-- 左下角的框框 -->
		
	<div id='warning' title='公告' style='display:none;padding:20px 20px 10px 20px;word-break: keep-all;'>
		為了提供您更好的使用品質，該功能維護中。
	</div>
	
    <script>
    var rs_markers=[];
	    function initMap() {
			// Create the map.
			map = new google.maps.Map(document.getElementById('map'), {
				panControl: true, //要不要出現可以上下左右移動的面板
			    zoomControl: true, //要不要出現可以放大縮小的面板
			    mapTypeControl: false, //切換地圖檢視類型的面板
			    scaleControl: true, //比例尺資訊
			    streetViewControl: false,  //顯示街景服務的面板
			    overviewMapControl: true,
// 			    zoom: 4,
// 			    center: {lat: 8.0, lng: 110.0}
			    
			    zoom: 7,
				center: {lat: 23.598321171324468, lng: 120.97802734375}
			});
			google.maps.event.addListener(map, 'click', function(event) {
				if($("#region_select").dialog("isOpen")&& $("#draw_circle").css("display")=="none"){
					//alert(map.getCenter()+"  "+map.getZoom());
					if(rs_markers.length>=5){alert("最多五個點");return;}
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
						  radius: 0 //10 * 30 *1000*0.016667
					});
					
// 					rs_markers.push(rs_marker);

					var marker_obj = new item_marker( 10, 30, rs_marker, rs_circle);
					
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
						rs_marker.setAnimation(google.maps.Animation.BOUNCE);
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

				    google.maps.event.addListener(rs_marker, 'dragend', function(marker){
				    	rs_marker.setAnimation(google.maps.Animation.BOUNCE);
				    });
				}else{
					//alert(map.getCenter());
				}
			});
			trafficLayer = new google.maps.TrafficLayer();
			//trafficLayer.setMap(map);
			transitLayer = new google.maps.TransitLayer();
		    //transitLayer.setMap(map);
// 			weatherLayer = new google.maps.weather.WeatherLayer({
// 		        temperatureUnits: google.maps.weather.TemperatureUnit.FAHRENHEIT
// 		    });
// 			weatherLayer.setMap(map);
// 		    cloudLayer = new google.maps.weather.CloudLayer();
// 		    cloudLayer.setMap(map);
// 			TEST_FUNC();
			
   		}
	    var in_smoothZoom=0;
    	var in_panTo=0;
	    function smoothZoom (map, max, cnt) {
	    	console.log("zoom: "+ in_smoothZoom);
	    	if(in_smoothZoom==1){
// 	    		map.setZoom(max);
	    		return;
	    	}
	    	if(cnt>max){
	    		map.setZoom(max);
	    		return;
	    	}
	    	in_smoothZoom=1;
	    	smoothZoom_layer (map, max, cnt);
	    }
	    function smoothZoom_layer (map, max, cnt) {
	        if (cnt >= max) {
	        	in_smoothZoom=0;
	            return;
	        }
	        else {
	            z = google.maps.event.addListener(map, 'zoom_changed', function(event){
	                google.maps.event.removeListener(z);
	                smoothZoom_layer(map, max, cnt + 1);
	            });
	            setTimeout(function(){map.setZoom(cnt)}, 80); // 80ms is what I found to work well on my system -- it might not work well on all systems
	        }
	    }  
	    var panPath = [];   // An array of points the current panning action will use
	    var panQueue = [];  // An array of subsequent panTo actions to take
	    var STEPS = 30;     // The number of steps that each panTo action will undergo
	    function panTo(newLat, newLng) {
	    	console.log("pan: "+ in_panTo);
	    	if(in_panTo==1){
// 	    		map.panTo( new google.maps.LatLng(newLat, newLng));
	    		return;
	    	}
	    	if(map.getZoom()>8){
	    		map.panTo( new google.maps.LatLng(newLat, newLng));
	    		return;
	    	}
	    	
	    	in_panTo=1;
	    	panTo_layer(newLat, newLng);
	    }
	    function panTo_layer(newLat, newLng) {
	      if (panPath.length > 0) {
	        // We are already panning...queue this up for next move
	        panQueue.push([newLat, newLng]);
	      } else {
	        // Lets compute the points we'll use
	        panPath.push("LAZY SYNCRONIZED LOCK");  // make length non-zero - 'release' this before calling setTimeout
	        var curLat = map.getCenter().lat();
	        var curLng = map.getCenter().lng();
	        var dLat = (newLat - curLat)/STEPS;
	        var dLng = (newLng - curLng)/STEPS;

	        for (var i=0; i < STEPS; i++) {
	          panPath.push([curLat + dLat * i, curLng + dLng * i]);
	        }
	        panPath.push([newLat, newLng]);
	        panPath.shift();      // LAZY SYNCRONIZED LOCK
	        setTimeout(doPan, 20);
	      }
	    }

	    function doPan() {
	      var next = panPath.shift();
	      if (next != null) {
	        // Continue our current pan action
	        map.panTo( new google.maps.LatLng(next[0], next[1]));
	        setTimeout(doPan, 20 );
	      } else {
	    	 
	        // We are finished with this pan - check if there are any queue'd up locations to pan to 
	        var queued = panQueue.shift();
	        if (queued != null) {
	        	panTo_layer(queued[0], queued[1]);
	        }else{
	        	 in_panTo=0;
	        }
	      }
	    }
    </script>
    
<!--     <script async defer -->
<!--     src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDc2oSzYl-UJ6brhxL3-BoNPvl3nbjNogk&signed_in=true&libraries=places&callback=initMap"> -->
<!--      </script> -->

    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC8QEQE4TX2i6gpGIrGbTsrGrRPF23xvX4&signed_in=true&libraries=places&callback=initMap">
    </script> 
     
<!--     <script async defer -->
<!--     src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBSQDx-_LzT3hRhcQcQY3hHgX2eQzF9weQ&signed_in=true&libraries=places&callback=initMap"> -->
<!--      </script> -->
     
	<div id='picture' style='position:fixed;left:10%;top:20%;z-index:-1;'ondblclick='$("#picture").css("z-index","-1");'></div>
	</div>
</div>

<jsp:include page="footer.jsp" flush="true"/>