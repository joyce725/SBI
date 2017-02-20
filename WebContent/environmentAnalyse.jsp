<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="import.jsp" flush="true"/>
<script src="js/d3.v3.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/additional-methods.min.js"></script>
<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>
<!--  css for d3js -->
<style>
	.topnav {
		z-index: 2;
	}
	.header {
		top: 0px;
	}
	.page-wrapper {
	/*     background: #194A6B; */
/* 	    background-color: #EEF3F9; */
	}
	.content-wrap{
	    background: #fff;
	    float: left;
	    margin-left: 0px;
	    margin-top: 100px;
		margin-bottom: 0px;
		padding-bottom: 6px;
		height: calc(100vh - 136px);
	    overflow-y: hidden;
	    width: 100%;
		background-color: #EEF3F9;
	}
	.search-result-wrap{
 		padding: 2px 5px 0px 5px; 
		margin-bottom: 0px;
		height: 100%;
	}
	.floatleft{
		position: absolute;
		left: 20px;
	}
	#map{
		height: 100%;
/* 		width: 1000px; */
 	}
    #map > div {
/*      	height: 90% !important;  */
 	/*	width:80% !important; */
    }
	input[type=checkbox] {
	    position: static;
	}
	input[type=radio] {
	    position: static;
	}
	.bentable{
		font-family: "微軟正黑體", "Microsoft JhengHei", 'LiHei Pro', Arial, Helvetica, sans-serif, \5FAE\8EDF\6B63\9ED1\9AD4,\65B0\7D30\660E\9AD4;
	/*  	margin-left:120px; */
	/* 	margin: 20px auto; */
		font-size:22px;
	/* 	border:2px solid #555; */
	}
	.bentable tr{
	/* 	height:32px; */
	/* 	border:2px solid #33f; */
	}
	.bentable td{
	/* 	padding:8px; */
		
		padding-left:60px;
	/* 	border:2px solid #3f3; */
	}
	/* .bentable td:nth-child(2n+1){ */
	/* 	t */
	/* 	padding:8px; */
	/* 	padding-left:40px; */
	/* } */
	.bentable2 td:nth-child(2n+1){
		text-align:right;
	}
	.bentable2 td{
		padding-left:20px;
	}
	.bentable2 tr{
 		height:50px; 
	}
	.bentable th{
		word-break: keep-all;
		padding:16px 0px 2px 0px;
	/* 	padding-bottom:4px; */
		
		text-align:left;
		font-size:28px;
		font-weight: bold;
		color:#444;
	/* 	border:2px solid #f33; */
	}
</style>
	
<style>
h2.ui-list-title {
	border-bottom: 1px solid #ccc;
	color: #307CB0;
}
</style>	
<!-- /**************************************  以下管理者JS區塊    *********************************************/		-->
<script>
// var businessdistrict = {
// 		BD_1: {n:1,name: "北車商圈",center: {lat: 25.045982, lng: 121.514999}},BD_2: {n:2,name: "新板特區商圈",center: {lat: 25.013372, lng: 121.465019}},BD_3: {n:3,name: "信義商圈",center: {lat: 25.035910, lng: 121.565300}},BD_4: {n:4,name: "西門商圈",center: {lat: 25.044571, lng: 121.506409}},BD_5: {n:5,name: "公館商圈",center: {lat: 25.014906, lng: 121.533882}},BD_6: {n:6,name: "忠孝商圈",center: {lat: 25.041836, lng: 121.545212}},BD_7: {n:7,name: "南西商圈",center: {lat: 25.056343, lng: 121.524147}},BD_8: {n:8,name: "天母商圈",center: {lat: 25.112495, lng: 121.531334}},BD_9: {n:9,name: "士林商圈",center: {lat: 25.088177, lng: 121.525116}},BD_10: {n:10,name: "淡水商圈",center: {lat: 25.169636, lng: 121.441689}},BD_11: {n:11,name: "府中商圈",center: {lat: 25.008665, lng: 121.460594}},BD_12: {n:12,name: "三和夜市商圈",center: {lat: 25.065723, lng: 121.500481}},BD_13: {n:13,name: "頂溪商圈",center: {lat: 25.012350, lng: 121.517319}},BD_14: {n:14,name: "大園竹圍漁港魅力商圈",center: {lat: 25.015139, lng: 121.298866}},BD_15: {n:15,name: "中壢火車站前商圈",center: {lat: 24.954807, lng: 121.223114}},BD_16: {n:16,name: "龍元宮商圈",center: {lat: 24.865213, lng: 121.213867}},BD_17: {n:17,name: "復興區角板山商圈",center: {lat: 24.822550, lng: 121.353409}},BD_18: {n:18,name: "中壢觀光夜市",center: {lat: 24.960838, lng: 121.215279}},BD_19: {n:19,name: "中原夜市商圈",center: {lat: 24.955498, lng: 121.240547}},BD_20: {n:20,name: "桃園區火車站前商圈",center: {lat: 24.992674, lng: 121.312767}},BD_21: {n:21,name: "桃園觀光夜市",center: {lat: 25.001781, lng: 121.307854}},BD_22: {n:22,name: "中壢區六和商圈",center: {lat: 24.962227, lng: 121.223885}},BD_23: {n:23,name: "桃園中正藝文特區商圈",center: {lat: 25.017681, lng: 121.297813}},BD_24: {n:24,name: "大溪老街商圈",center: {lat: 24.884075, lng: 121.287758}},BD_25: {n:25,name: "逢甲商圈",center: {lat: 24.177917, lng: 120.645721}},BD_26: {n:26,name: "一中商圈",center: {lat: 24.148779, lng: 120.685211}},BD_27: {n:27,name: "精明一街",center: {lat: 24.156441, lng: 120.655380}},BD_28: {n:28,name: "美術園道商圈",center: {lat: 24.139286, lng: 120.663506}},BD_29: {n:29,name: "自由路商圈",center: {lat: 24.142656, lng: 120.684937}},BD_30: {n:30,name: "市政商圈",center: {lat: 24.161242, lng: 120.644402}},BD_31: {n:31,name: "東海商圈",center: {lat: 24.182249, lng: 120.591202}},BD_32: {n:32,name: "成大商圈",center: {lat: 22.994476, lng: 120.218056}},BD_33: {n:33,name: "海安商圈",center: {lat: 22.992544, lng: 120.197235}},BD_34: {n:34,name: "中正銀座商圈",center: {lat: 22.992867, lng: 120.197701}},BD_35: {n:35,name: "國華友愛新商圈",center: {lat: 22.992512, lng: 120.197197}},BD_36: {n:36,name: "孔廟形象商圈",center: {lat: 22.990108, lng: 120.205772}},BD_37: {n:37,name: "新化商圈",center: {lat: 23.035398, lng: 120.308151}},BD_38: {n:38,name: "安平商圈",center: {lat: 23.000124, lng: 120.163048}},BD_39: {n:39,name: "新營商圈",center: {lat: 23.304497, lng: 120.316727}},BD_40: {n:40,name: "關子嶺商圈",center: {lat: 23.337807, lng: 120.505386}},BD_41: {n:41,name: "東山商圈",center: {lat: 23.290840, lng: 120.500504}},BD_42: {n:42,name: "善化商圈",center: {lat: 23.128122, lng: 120.297371}},BD_43: {n:43,name: "玉井商圈",center: {lat: 23.124012, lng: 120.460495}},BD_44: {n:44,name: "三多商圈",center: {lat: 22.613955, lng: 120.304558}},BD_45: {n:45,name: "新崛江商圈",center: {lat: 22.622780, lng: 120.302757}},BD_46: {n:46,name: "後驛商圈",center: {lat: 22.640680, lng: 120.299347}},BD_47: {n:47,name: "巨蛋商圈",center: {lat: 22.666962, lng: 120.304108}},BD_48: {n:48,name: "夢時代商圈",center: {lat: 22.594856, lng: 120.307228}}
// }
var businessdistrict ;
var map;
	
function analysis(){
// 	$("#pac-input").focus();
// 	$("#pac-input").val("ATM");
// 	$("#pac-input").trigght();
// 	searchBox.getPlaces();
	
	//map.panTo(new google.maps.LatLng(map.getCenter().lat()+0.01,map.getCenter().lng()+0.01));
// 	map.setCenter( new google.maps.LatLng(map.getCenter().lat(),map.getCenter().lng()+0.01), 10);
// 	google.maps.smoothZoom(map, 17, map.getZoom());
// 	map.setZoom(17);
	return;
}
function checkboxstr(selector){
	var str='';
	$( '#'+selector).each( function(i){
		if(i!=0)str+=",";
		str+=$( this ).val();
	});
	return str;
}

var item_marker = function (speed, time, marker, circle) {
	this.speed = speed;
	this.time = time;
	this.marker = marker;
	this.circle = circle;
}
</script>
<!-- /**************************************  以上使用者JS區塊    *********************************************/	-->

<jsp:include page="header.jsp" flush="true"/>
<div class="content-wrap">
<h2 class="page-title">環域分析</h2>
	<div class="search-result-wrap">

<!-- 	<button onclick='$("#regionselect").dialog("open");' style='position:absolute;left:50%;top:100px;z-index:99;'>打開</button> -->
	<a class="btn btn-orange" onclick='$("#env_analyse").dialog("open");' style='position:absolute;left:23%;top:110px;z-index:99;'>環域分析</a>

	<div id="map"></div>

	<div id='env_analyse' title='環域分析' style='display:none;'>
		<div id="instruction">
			<div style="margin:14px 20px;font-size:22px;color:#F00;font-weight:900;" class='blink'>請點擊地圖新增分析點。</div>
			<hr style='height:1px;border:none;border-top:1px solid #ddd;'>
			<div style="margin:0px 20px;float:right;">
				<button class='ui-button' id='env_analyse_next'>下一步</button>
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
						<div id='env_slider'></div>
					</td>
					<td>
						　需時：<input id='time' style='width:40px;height:14px;' value='30'>　分鐘
					</td>
				</tr>
				<tr style='height:50px;'>
					<td>
						預設：
					</td>
					<td colspan='2'>
						<a id="val_speed" style='color: #c33;text-decoration:underline;font-size:18px;font-weight: bold;'>時速10公里</a>&nbsp;
						<a id="val_time" style='color: #c33;text-decoration:underline;font-size:18px;font-weight: bold;'>花費30分鐘</a>&nbsp;
						之可達範圍
					</td>
				</tr>
			</table>
			<hr style='height:1px;border:none;border-top:1px solid #ddd;'>
			<div style="margin:0px 20px;float:right;">
				<button class='ui-button' id='env_analyse_last'>上一步</button>
				　<button class='ui-button' onclick='$("#env_analyse").dialog("close");'>結束</button>
			</div>
		</div>
	</div>
	
	
    <script type="text/javascript">
	    var markers = [];
	    var words=['4','2','3','1','5','7','6','8','9','10','11','12','13','14','15'];
	    
	    var rs_markers=[];
	    
	    function initMap() {
			// Create the map.
			map = new google.maps.Map(document.getElementById('map'), {
				zoom: 7,
				center: {lat: 23.900, lng: 121.000},
				mapTypeId: google.maps.MapTypeId.ROADMAP
			});
    	  
			
			google.maps.event.addListener(map, 'click', function(event) {
				if($("#env_analyse").dialog("isOpen")&& $("#draw_circle").css("display")=="none"){
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
						  radius: 0 
					});
					var marker_obj = new item_marker( 10, 30, rs_marker, rs_circle);
					
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
						$('#env_slider').slider('option', 'value', marker_obj.time);
				    });

				    google.maps.event.addListener(rs_marker, 'dragend', function(marker){
				    	rs_marker.setAnimation(google.maps.Animation.BOUNCE);
				    });
				}
			});
			trafficLayer = new google.maps.TrafficLayer();
			transitLayer = new google.maps.TransitLayer();
   		
   		}
	    
	    
	    
	    $(function(){
	    	
			
			//環域分析
			$("#env_analyse").dialog({
				draggable : true,resizable : false,autoOpen : false,
				height : "auto", width : "auto", 
				modal : false,
				position: { my: "center", at: "right-180px top+240px ", of: window  } ,  
				show : {effect : "blind",duration : 300},
				hide : {effect : "fade",duration : 300},
				open :function(){
					map.setOptions({draggableCursor:("url("+location.href.replace('realMap.jsp','')+"refer_data/cursor2.cur),default")});
				},
				close : function() {
					map.setOptions({draggableCursor:null});
					$("#env_analyse").dialog("close");
				}
			});
			$("#env_analyse").show();

			
			$("#env_analyse_next").click(function(){
		    	if(rs_markers.length==0){
		    		alert("請放置分析點。");
		    	}else{
		    		map.setOptions({draggableCursor:null});
		    		$("#instruction").hide();
		    		$("#draw_circle").show();
		    		$.each(rs_markers,function(i, item) {
		    			rs_markers[i].circle.setRadius(rs_markers[i].speed* rs_markers[i].time *1000 * 0.016667);
		    		});
//	 	    		alert($('div[aria-describedby="env_analyse"]').html());
		    		$("div[aria-describedby='env_analyse']").animate({"left": "-=180px"});
		    	}
		    });
		    $("#env_analyse_last").click(function(){
		    	map.setOptions({draggableCursor:("url("+location.href.replace('realMap.jsp','')+"refer_data/cursor2.cur),default")});
	    		$("#instruction").show();
	    		$("#draw_circle").hide();
	    		$("div[aria-describedby='env_analyse']").animate({"left": "+=180px"});
		    });
		    
		    
		    $("#speed").change(function(){
		    	$('#val_speed').html("時速"+$(this).val()+"公里");
		    	$("#rr_pt").val().speed=$("#speed").val();
		    	$("#rr_pt").val().time=$("#time").val();
		    	$("#rr_pt").val().circle.setRadius($("#speed").val()*$("#time").val()*1000*0.016667);
		    	
		    	$.each(rs_markers,function(i, item) {
	    			rs_markers[i].circle.setRadius($("#speed").val() * $("#time").val() *1000 * 0.016667);
	    		});
			});
		    $("#time").change(function(){
		    	$('#val_time').html("花費"+$(this).val()+"分鐘");
		    	$("#rr_pt").val().speed=$("#speed").val();
		    	$("#rr_pt").val().time=$("#time").val();
		    	$("#rr_pt").val().circle.setRadius($("#speed").val()*$("#time").val()*1000*0.016667);
				$('#env_slider').slider('option', 'value', $(this).val()); 
				
				$.each(rs_markers,function(i, item) {
	    			rs_markers[i].circle.setRadius($("#speed").val() * $("#time").val() *1000 * 0.016667);
	    		});
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
		    
		    $("#env_slider").slider({
				range: true,
		        min: 0,
		        max: 1,
		        step: 0.0001,
		        values: [],
		        slide: function (event, ui) {
		        	$("#time").val((ui.value * 120).toFixed(0));
		        }
			});

			
		});
    </script>
    
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBSQDx-_LzT3hRhcQcQY3hHgX2eQzF9weQ&signed_in=true&libraries=places&callback=initMap">
	</script> 

	</div>
</div>

<jsp:include page="footer.jsp" flush="true"/>