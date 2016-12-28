<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="import.jsp" flush="true"/>
<script src="js/d3.v3.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/additional-methods.min.js"></script>
<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>
<!-- <script src="http://html2canvas.hertzen.com/build/html2canvas.js"></script> -->
<!-- <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.9.1.js "></script> -->
<!-- <script src="http://ajax.aspnetcdn.com/ajax/knockout/knockout-3.0.0.js "></script> -->

<script src="./js/jquery-1.12.4.min.js"></script>
<script src="./js/jquery-ui.custom.js"></script>

<link href="./fancy-tree/skin-xp/ui.fancytree.css" rel="stylesheet">
<script src="./fancy-tree/jquery.fancytree.js"></script>
<style>
	.header {
		top: 0px;
	}
	.page-wrapper {
	    background-color: #EEF3F9;
	}
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
	.ben-table{
  	/*	border:1px solid #000;  */
 	/*	height:180px; */
 	/*	margin: 10px 120px; */
 	/*	width:70%; */
		width: 100%;
		height: 20px;
	}
	.ben-table td:nth-child(2n+1){
 	/*	padding:30px 30px; */
		vertical-align:text-top;
		width: 30%;
	}
	.ben-table td{
		padding:10px;
		height: 100%;
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
/* 		text-align: right; */
	}
	.bentable img:hover{
		background: #d8d8d8;
		box-shadow:1px 1px 2px #999;
	}
	.bgnone {background: none;}
	#panel{
		background: url(./fancy-tree/skin-xp/bg.png) repeat;
		transition: all .3s linear;
		position:fixed;
		left:0px;
		top:96px; 
/* 		width:20px; */
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
var map;
var all_markers={};
var all_BDs={};
var action={};

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

function select_poi(poi_name){
	if(all_markers[poi_name]!=null){
		for (var i = 0; i < all_markers[poi_name].length; i++) {   
			all_markers[poi_name][i].setMap(null);   
        }   
		all_markers[poi_name]=null;
		return;
	}
	
	$.ajax({
		type : "POST",
		url : "realMap.do",
// 		async : false,
		data : {
			action : "select_poi",
			name : poi_name,
			lat : map.getCenter().lat,
			lng : map.getCenter().lng,
			zoom : map.getZoom()
		},
		success : function(result) {
			//alert(result);
			if(result=="fail!!!!!")return;
			var json_obj = $.parseJSON(result);
			var result_table = "";
			all_markers[poi_name]=[];
			if(json_obj.length>1000){
				if(confirm("搜尋資料量達"+json_obj.length+"筆\n是否繼續查詢?","確認繼續","取消")){}else{
					return;
			}}
				
			$.each(json_obj,function(i, item) {
				var  icon = json_obj[i].icon.length>3?json_obj[i].icon:false;
				var marker = new google.maps.Marker({
				    position: json_obj[i].center,
				    title: json_obj[i].name,
				    map: map,
				    icon : icon
				});
				var infowindow = new google.maps.InfoWindow({content:( "名稱:　"+json_obj[i].name+"<br/>地址:　"+json_obj[i].addr)});
				google.maps.event.addListener(marker, "mouseover", function(event) { 
		        	infowindow.open(marker.get('map'), marker);
		        	setTimeout(function () { infowindow.close(); }, 2000);
		        });
				all_markers[poi_name].push(marker);
			});
		}
	});
}
function select_poi_2(poi_name){
	if(all_markers[poi_name]!=null){
		for (var i = 0; i < all_markers[poi_name].length; i++) {   
			all_markers[poi_name][i].setMap(null);   
        }   
		all_markers[poi_name]=null;
		return;
	}
	
	$.ajax({
		type : "POST",
		url : "realMap.do",
// 		async : false,
		data : {
			action : "select_poi_2",
			name : poi_name,
			lat : map.getCenter().lat,
			lng : map.getCenter().lng,
			zoom : map.getZoom()
		},
		success : function(result) {
			if(result=="fail!!!!!")return;
			var json_obj = $.parseJSON(result);
			var result_table = "";
			all_markers[poi_name]=[];
			if(json_obj.length>1000){
				if(confirm("搜尋資料量達"+json_obj.length+"筆\n是否繼續查詢?","確認繼續","取消")){}else{
					return;
			}}
			
			$.each(json_obj,function(i, item) {
				//alert(json_obj[i].name);
				var  icon = json_obj[i].icon.length>3?json_obj[i].icon:false
				var marker = new google.maps.Marker({
				    position: json_obj[i].center,
				    title: json_obj[i].name,
				    map: map,
				    icon : icon
				});
				var infowindow = new google.maps.InfoWindow({content:( "名稱:　"+json_obj[i].name+"<br/>地址:　"+json_obj[i].addr)});
				google.maps.event.addListener(marker, "mouseover", function(event) { 
		        	infowindow.open(marker.get('map'), marker);
		        	setTimeout(function () { infowindow.close(); }, 2000);
		        }); 
				all_markers[poi_name].push(marker);
			});
		}
	});
}
function select_BD(BD_name){
//  	alert(BD_name);
	if(all_BDs[BD_name]!=null){
		for (var i = 0; i < all_BDs[BD_name].length; i++) {   
			all_BDs[BD_name][i].setMap(null);   
        }   
		all_BDs[BD_name]=null;
		return;
	}
	$.ajax({
		type : "POST",
		url : "realMap.do",
		data : {
			action : "select_BD",
			name : BD_name
		},
		success : function(result) {
// 			alert(result);
			var json_obj = $.parseJSON(result);
			var result_table = "";
			all_BDs[BD_name]=[];
			$.each(json_obj,function(i, item) {
				map.panTo(new google.maps.LatLng(json_obj[i].lat,json_obj[i].lng));
// 				map.setZoom(15);
				smoothZoom(map, 15, map.getZoom());
				var bermudaTriangle = new google.maps.Polygon({
					paths: json_obj[i].center,
					strokeColor: '#FF0000',
					strokeOpacity: 0.8,
					strokeWeight: 2,
					fillColor: '#FF0000',
					fillOpacity: 0.1
				});
				bermudaTriangle.setMap(map);
				//bermudaTriangle.setMap(null);
				all_BDs[BD_name].push(bermudaTriangle);
			});
		}
	});
}


var item_marker = function (speed, time, marker, circle) {
	this.speed = speed;
	this.time = time;
	this.marker = marker;
	this.circle = circle;
}


	$(function(){
// 		select_poi("超市便利商店");
// 		select_BD("後驛商圈");
// 		select_poi_2("圖書館");
// setTimeout(function () {
// 	smoothZoom(map, 12, map.getZoom());
// panTo(12.736504830663572,122.92672729492188);
// 	smoothZoom(map, 5, map.getZoom());
// select_poi_2("便利商店");select_poi_2("超市");select_poi_2("NULL");select_poi_2("速食便當");select_poi_2("咖啡店");select_poi_2("火鍋");select_poi_2("異國料理");select_poi_2("小吃店");select_poi_2("飲料店");select_poi_2("西餐廳");select_poi_2("速食店");select_poi_2("中餐廳");select_poi_2("甜點店");select_poi_2("Buffet");select_poi_2("其他");select_poi_2("早餐店");select_poi_2("文具店");select_poi_2("書店");select_poi_2("百貨公司");select_poi_2("購物中心");select_poi_2("大廈");select_poi_2("寫字樓");select_poi_2("網吧");select_poi_2("酒吧");select_poi_2("娛樂會所");select_poi_2("電影院");select_poi_2("KTV");select_poi_2("桌遊吧");select_poi_2("舞廳");select_poi_2("動漫館");select_poi_2("藥妝");select_poi_2("餐飲");select_poi_2("ATM");select_poi_2("零售");select_poi_2("零售業");select_poi_2("電信業");select_poi_2("電信零售業");select_poi_2("連鎖早餐店");select_poi_2("量販店");select_poi_2("咖啡店");select_poi_2("連鎖飲料");select_poi_2("醫學中心");select_poi_2("區域醫院");select_poi_2("地區醫院");select_poi_2("診所");select_poi_2("藥局");select_poi_2("居家護理");select_poi_2("醫事檢驗所");select_poi_2("康復之家");select_poi_2("助產所");select_poi_2("物理治療所");select_poi_2("醫事放射所");select_poi_2("速食餐飲");select_poi_2("連鎖藥局");select_poi_2("北北基景點");select_poi_2("桃竹苗景點");select_poi_2("中彰投景點");select_poi_2("雲南嘉景點");select_poi_2("高屏觀光景點");select_poi_2("宜花東景點");select_poi_2("澎金馬景點");select_poi_2("飯店旅館");select_poi_2("中央政府機關");select_poi_2("直轄市");select_poi_2("地方政府機關");select_poi_2("NET");select_poi_2("UNIQLO");select_poi_2("佐丹奴");select_poi_2("ESPRIT");select_poi_2("HANTEN");select_poi_2("堡獅龍");select_poi_2("G2000");select_poi_2("鱷魚");select_poi_2("日式豬排");select_poi_2("日式豬排 (複合店)");select_poi_2("赤神日式豬排");select_poi_2("吉豚屋");select_poi_2("矢場味噌豬排");select_poi_2("知多家");select_poi_2("小吉藏豬排專賣店");select_poi_2("勝里日式豬排專賣店");select_poi_2("Izumi Curry");select_poi_2("天屋食堂");select_poi_2("鶿克米tsukumi");select_poi_2("八番赤野日式料理");select_poi_2("三田製所");select_poi_2("三次魚屋");select_poi_2("旬彩神樂家");select_poi_2("元定食");select_poi_2("天吉屋");select_poi_2("汐科食堂");select_poi_2("味一亭");select_poi_2("信州王");select_poi_2("烏丼亭烏龍麵專賣");select_poi_2("熊本家鐵板料理");select_poi_2("嘿鬥日式定食專賣");select_poi_2("藍屋日本料理");select_poi_2("東京咖哩Tokyo Curry");select_poi_2("奧里安達魯咖哩");select_poi_2("伊勢路勝勢日式豬排");select_poi_2("茄子咖哩");select_poi_2("停車場");select_poi_2("圖書館");
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
// 				alert(result);
				json_obj = $.parseJSON(result);
// 				var test = [{'title': 'Node 1', 'key': 'hell-_-','action':'alert("11111");'},
// 						    {'title': 'Folder 2', 'key': '2', 'folder': 'true', "hideCheckbox": true , 'children': [
// 						        {'title': 'Node 2.1', 'key': '32222', 'myOwnAttr': 'abc'},
// 						        {'title': 'Node 2.2', 'key': '4'}
// 						    ]},
// 						    {'title': 'Folder 2', 'key': '2', 'folder': 'true', 'children': [
// 								{'title': 'Node 2.2', 'key': '4'}                                                   
// 						    ]}];
// 				hidecheckbox(test);
				hidecheckbox(json_obj);
				$("#tree").fancytree({
					aria: true,
					checkbox: true,
					selectMode: 2,
					quicksearch: true,
					focusOnSelect: true,
					source : json_obj,
// 					source : test,
					click: function (event, data) {
						var node = data.node;
						
					    if(!data.node.isFolder()){
					    	event.preventDefault();
					    	node.setSelected( !node.isSelected() );
					    	eval(action[data.node.key]);
// 					    	alert(node.isChecked());
// 					    	node.setSelected( !node.isSelected() );
					    }
					},
					activate: function (event, data) {
					    var node = data.node;
					    node.setSelected( !node.isSelected() );
					    
					    if(data.node.isFolder()){eval(action[data.node.key]);}
					},
					
					select: function(event, data) {
						var node = data.node;
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
// 			buttons : [{
// 				text : "下一步",
// 				click : function() {
// // 					$("#region_select").dialog("close");
// 					$("#instruction").hide();
// 					$("#draw_circle").show();
// 				}
// 			},{
// 				text : "清除所有點",
// 				click : function() {
// 					$("#region_select").dialog("close");
// 					while(rs_markers.length>0){rs_markers.pop().setMap(null)};
// 				}
// 			}],
			close : function() {
				$("#region_select").dialog("close");
			}
		});
// 		$("#region_select").dialog( 'moveToTop' ) ;
		$("#region_select").dialog("open");
		
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
	<div id='region_select' title='環域分析'>
		<div id="instruction">
			<div style="margin:14px 20px;">請點擊地圖新增分析點。</div>
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
    <script>
    var rs_markers=[];
	    function initMap() {
			// Create the map.
			map = new google.maps.Map(document.getElementById('map'), {
				panControl: true, //要不要出現可以上下左右移動的面板
			    zoomControl: true, //要不要出現可以放大縮小的面板
			    mapTypeControl: false, //切換地圖檢視類型的面板
			    scaleControl: true, //比例尺資訊
			    streetViewControl: true,  //顯示街景服務的面板
			    overviewMapControl: true,
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
				}
			});
   		}
	    
	    function smoothZoom (map, max, cnt) {
	        if (cnt == max) {
	            return;
	        }
	        else if(cnt > max){
	        	map.setZoom(max);
	        }else{
	            z = google.maps.event.addListener(map, 'zoom_changed', function(event){
	                google.maps.event.removeListener(z);
	                smoothZoom(map, max, cnt + 1);
	            });
	            setTimeout(function(){map.setZoom(cnt)}, 80); // 80ms is what I found to work well on my system -- it might not work well on all systems
	        }
	    }
	    var panPath = [];   // An array of points the current panning action will use
	    var panQueue = [];  // An array of subsequent panTo actions to take
	    var STEPS = 30;     // The number of steps that each panTo action will undergo
		
	    function panTo(newLat, newLng) {
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
	          panTo(queued[0], queued[1]);
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
     
      
<!-- 		background-color:#F00; -->
	<div id='picture' style='position:fixed;left:10%;top:20%;z-index:-1;'ondblclick='$("#picture").css("z-index","-1");'></div>
	</div>
</div>

<jsp:include page="footer.jsp" flush="true"/>