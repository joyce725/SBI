<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="import.jsp" flush="true"/>

<link rel="stylesheet" href="css/styles_map.css"/>
<link href="./fancy-tree/skin-xp/ui.fancytree.css" rel="stylesheet">

<script src="js/d3.v3.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/additional-methods.min.js"></script>
<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>
<script src="./js/jquery-ui.custom.js"></script>
<script src="./fancy-tree/jquery.fancytree.js"></script>
<script src="refer_data/js/wicket.js"></script>
<script src="refer_data/js/wicket-gmap3.js"></script>
<script src="js/mapFunction.js"></script>

<script>
var result="";
var map;
var transitLayer;
var trafficLayer;
var country_polygen=[];
var chinaProvincial=[];
var chinaCities={};
var all_markers={};
var all_BDs={};
var action={};
var have_visited={};
var population_Markers=[];
function hidecheckbox(json){
	var i=0;
	i=0;
	for(item in json){
		i++;
	}
	if(i==0){
		return;
	}
	for (key in json){
		if(key=="folder" && json[key]=="true"){
			json["hideCheckbox"]=true;
		}
		if(key=="action"){
			action[json["key"]]=json[key];
		}
		
		i=0;
		
		for(item in json[key]){
			i++;
		}
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
		$.ajax({
			type : "POST",
			url : "realMap.do",
			async : false,
			data : {
				action : "select_menu", type : "RealMap"
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
						if($(node.span.childNodes[1]).hasClass('loading')) { 
							return false; 
						}
						
					    if(!data.node.isFolder()){
					    	event.preventDefault();
					    	node.setSelected( !node.isSelected() );
					    	
				    		if(action[data.node.key].length==0){
				    			$("#warning").dialog("open");
				    			node.setSelected(false);
				    		}
				    		eval(action[data.node.key]);
					    }else{
					    	if(have_visited[node.key]==null){
					    		have_visited[node.key]=true;
					    		eval(action[node.key]);
					    	}
					    }
					},
					activate: function (event, data) {
					    var node = data.node;
					    if($(node.span.childNodes[1]).hasClass('loading')) { 
					    	return false; 
					    }
					    node.setSelected( !node.isSelected() );
					    
					    if(data.node.isFolder()&&have_visited[node.key]!=null){
					    	eval(action[data.node.key]);
					    }
					},
					
					select: function(event, data) {
						var node = data.node;
						if($(node.span.childNodes[1]).hasClass('loading')) { 
							return false; 
						}
					}
				}).on("mouseover", ".fancytree-title", function(event){
				    var pdf_layer=["19","20","21","22","23","24","25","26","27","28","29","31","32","33","34","35","42","44","46","48"];
				    var node = $.ui.fancytree.getNode(event);
				    if(pdf_layer.indexOf(node.key)!=-1){
				    	$('#pdf_layer').children().html('<div onclick=\'window.open(\"http://61.218.8.51/SBI/pdf/'
				    			+$("#ftal_"+node.key).text().replace('商圈','')+'.pdf\", \"_blank\");\'> '
				    			+$("#ftal_"+node.key).text().replace('商圈','')+"電子書"+'</div>');
				    	$('#pdf_layer').css({
				    		"display": "inline",
				    		"top":($("#ftal_"+node.key).offset().top-120),
				    		"left":($("#ftal_"+node.key).offset().left-160+($("#ftal_"+node.key).text().length*12))
				    	});
				    }
				    node.info(event.type);
				});
			}
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
					draggableCursor:("url("+location.href.replace('realMap.jsp','')
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
	    		alert("請放置分析點。");
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
			draggable : true, 
			resizable : false, 
			autoOpen : false,
			height : "auto", 
			width : "auto", 
			modal : true,
			show : {
				effect : "fade",
				duration : 300
			},
			hide : {
				effect : "fade",
				duration : 300
			},
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
	<div id='panel' 
	onmouseover="$('#panel').css('left','150px');clearTimeout($('#panel').val());" 
	tmp="$('#panel').val(setTimeout(function () { $('#panel').css('left','0px'); }, 800));" style="left:150px;">
		<div id='tree' >
		<script>var timer="";</script>
		<ul id='pdf_layer' onmouseover='clearTimeout(timer);$("#pdf_layer").show();' 
				onmouseout=' timer=setTimeout(function(){$("#pdf_layer").hide();},500);' 
				style='position:absolute;top:200px;left:10px;z-index:30;width:auto;display:none;'>
			<li><div>Books</div></li>
		</ul>
		</div>
		<div id='pin' style='position:absolute;top:5px;right:20px;display:none;' class='on_it' 
				onclick='$("#pin").hide();$("#unpin").show();$("#panel").attr("tmp",$("#panel").attr("onmouseout"));$("#panel").attr("onmouseout","");'><img src='./refer_data/pin.png'></div>
		<div id='unpin' style='position:absolute;top:5px;right:20px;' class='on_it' 
				onclick='$("#unpin").hide();$("#pin").show();$("#panel").attr("onmouseout",$("#panel").attr("tmp"));'><img src='./refer_data/unpin.png'></div>
		<div style='position:absolute;width:100%;bottom:5px;border-top:2px solid #aaa;padding:10px 0px 5px 0px;'>
			<table><tr><td>&nbsp;透明度：</td><td><div id='opacity' style='width:160px;'></div></td></tr></table>
		</div>
	</div>
	
<h2 class="page-title">商圈資訊</h2>
	<div class="search-result-wrap">
	<div id="map"></div>
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
				<button class='ui-button' id='region_select_last'>上一步</button>
				　<button class='ui-button' onclick='$("#region_select").dialog("close");'>結束</button>
			</div>
		</div>
	</div>
<!-- 左下角的框框 -->
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
<!-- 左下角的框框 -->
	<div id="detail_1"></div>
	<div id='warning' title='公告' style='display:none;padding:20px 20px 10px 20px;word-break: keep-all;'>
		為了提供您更好的使用品質，該功能維護中。
	</div>
	
    <script>
    var rs_markers=[];
	    function initMap() {
			// Create the map.
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
			trafficLayer = new google.maps.TrafficLayer();
			transitLayer = new google.maps.TransitLayer();
   		}
    </script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC8QEQE4TX2i6gpGIrGbTsrGrRPF23xvX4&signed_in=true&libraries=places&callback=initMap"></script> 
	<div id='picture' style='position:fixed;left:10%;top:20%;z-index:-1;'ondblclick='$("#picture").css("z-index","-1");'></div>
	</div>
</div>

<jsp:include page="footer.jsp" flush="true"/>