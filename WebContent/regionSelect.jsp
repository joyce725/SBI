<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="import.jsp" flush="true"/>
<script src="js/d3.v3.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/additional-methods.min.js"></script>
<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>
<link rel="stylesheet" href="css/styles_map.css"/>
<style>
	.topnav {
		z-index: 2;
	}
	.header {
		top: 0px;
	}
	.page-wrapper {
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
 	}
    #map > div {
    }
	input[type=checkbox] {
	    position: static;
	}
	input[type=radio] {
	    position: static;
	}

	.bentable2 {
		font-family: "微軟正黑體", "Microsoft JhengHei", 'LiHei Pro', Arial, Helvetica, sans-serif, \5FAE\8EDF\6B63\9ED1\9AD4,\65B0\7D30\660E\9AD4;
	}
	.bentable2 img:hover{
		background: #d8d8d8;
		box-shadow:1px 1px 2px #999;
	}
	.bentable2 td:nth-child(2n+1){
		text-align:left;
		word-break: keep-all;
	}
	.bentable2 td{
		padding-left:5px;
		padding:3px 5px;
	}
	.bentable2 th{
		word-break: keep-all;
		padding:16px 0px 2px 0px;
		text-align:left;
		font-size:22px;
		font-weight: bold;
		color:#444;
	}
</style>
	
<style>
h2.ui-list-title {
	border-bottom: 1px solid #ccc;
	color: #307CB0;
}
</style>	
<script>
var businessdistrict;
var map;
var all_BDs={};

	function checkboxstr(selector) {
		var str = '';
		$('#' + selector).each(function(i) {
			if (i != 0)
				str += ",";
			str += $(this).val();
		});
		return str;
	}

	var item_marker = function(speed, time, marker, circle) {
		this.speed = speed;
		this.time = time;
		this.marker = marker;
		this.circle = circle;
	}
</script>

<jsp:include page="header.jsp" flush="true"/>
<div class="content-wrap">
<h2 class="page-title">區位選擇</h2>
	<div class="search-result-wrap">

	<a class="btn btn-orange" id='region_btn' onclick='$("#regionselect").dialog("open");' style='position:absolute;left:15%;top:110px;z-index:1;'>區位選擇</a>
	<a class="btn btn-orange" id='env_btn'onclick='$("#env_analyse").dialog("open");' style='position:absolute;left:23%;top:110px;z-index:1;'>環域分析</a>

	<div id="map"></div>


	<div id='regionselect' title='區位選擇' style='display:none;'>
		<div id='QA' style='height:50%;width:70%;margin:5px 10px;'>
			<form id='QA_form'>
				<table class='bentable2'>
					<tr><th colspan='4'>一、基本資料：<span style='position:relative;top:-20px;margin-left:20px; font-size:28px;'>商圈選擇評估問卷</span></th></tr>
					<tr>
						<td>姓名：</td><td><input type="text" name='QA_name'></td>
						<td>職稱：</td><td><input type="text" name='QA_propost'></td>
					</tr>
					<tr>
						<td>公司統編：</td><td><input type="text" name='QA_taxid'></td>
						<td>E-mail：</td><td><input type="text" name='QA_email'></td>
					</tr>
					<tr>
						<td>預計投資國家：</td><td><input type="text" name='QA_investcountry'></td>
					</tr>
					
					<tr><th colspan='3'>二、現在所屬產業：</th></tr>
					<tr>
						<td>現在所屬產業：</td>
						<td colspan='2'>
							<input type="radio" name='QA_industry' value='1' onclick='$(".dinning").fadeOut(function(){$(".retail").fadeIn();});'>零售業&nbsp;<input type="radio" name='QA_industry' value='2' onclick='$(".retail").fadeOut(function(){$(".dinning").fadeIn();});'>餐飲業
						</td>
					</tr>
					<tr class='retail' style='display:none;'>
						<td>主要營業項目：<br>(零售業)　</td>
						<td colspan='3'>
							<input type="checkbox" name='QA_industry_item' value='1'>綜合商品類 &nbsp;<input type="checkbox" name='QA_industry_item' value='2'>食品、飲料製品類 &nbsp;<input type="checkbox" name='QA_industry_item' value='3'>服飾品類 &nbsp;<input type="checkbox" name='QA_industry_item' value='4'>家庭器具及用品類&nbsp;<br><input type="checkbox" name='QA_industry_item' value='5'>文教、育樂用品類 &nbsp;<input type="checkbox" name='QA_industry_item' value='6'>藥品、醫療用品及化妝品類&nbsp;
						</td>
					</tr>
					<tr class='dinning' style='display:none;'>
						<td>主要營業項目：<br>(餐飲業)　</td>
						<td colspan='3'>
							<input type="radio" name='QA_industry_item2' value='1'>餐館類 &nbsp;<input type="radio" name='QA_industry_item2' value='2'>飲料類 &nbsp;
						</td>
					</tr>
					
					<tr><th colspan='3'>二、預計投資產業：</th></tr>
					<tr>
						<td>預計投資產業：</td>
						<td colspan='2'>
							<input type="radio" name='QA_invest_industry' value='1' onclick='$(".invest_item").animate({opacity: "0"});'>本業&nbsp;<input type="radio" name='QA_invest_industry' value='2' onclick='$(".invest_item").animate({opacity: "1"});'>非本業
						</td>
					</tr>
					<tr class='invest_item dinning' style='display:none;opacity:0;'>
						<td>預計投資項目：<br>(餐飲業-非本業)　</td>
						<td colspan='3'>
							<input type="checkbox" name='QA_invest_industry_item' value='1'>綜合商品類 &nbsp;<input type="checkbox" name='QA_invest_industry_item' value='2'>食品、飲料製品類 &nbsp;<input type="checkbox" name='QA_invest_industry_item' value='3'>服飾品類 &nbsp;<input type="checkbox" name='QA_invest_industry_item' value='4'>家庭器具及用品類&nbsp;<br><input type="checkbox" name='QA_invest_industry_item' value='5'>文教、育樂用品類 &nbsp;<input type="checkbox" name='QA_invest_industry_item' value='6'>藥品、醫療用品及化妝品類&nbsp;
						</td>
					</tr>
					<tr class='invest_item retail' style='display:none;opacity:0;'>
						<td>預計投資項目：<br>(零售業-非本業)　</td>
						<td colspan='3'>
							<input type="radio" name='QA_invest_industry_item2' value='1'>餐館類 &nbsp;<input type="radio" name='QA_invest_industry_item2' value='2'>飲料類 &nbsp;
						</td>
					</tr>
					<tr>
						<td>預計投資品牌：</td>
						<td colspan='2'>
							<input type="radio" name='QA_invest_brand' value='1'>既有品牌 &nbsp;<input type="radio" name='QA_invest_brand' value='2'>新品牌
						</td>
					</tr>
					<tr>
						<td>預計投資型態：<br>(可複選)　</td>
						<td colspan='3'>
							<input type="checkbox" name='QA_invest_pattern' value='1'>獨資 &nbsp;<input type="checkbox" name='QA_invest_pattern' value='2'>合資&nbsp;<input type="checkbox" name='QA_invest_pattern' value='3'>購併 &nbsp;<input type="checkbox" name='QA_invest_pattern' value='4'>加盟
						</td>
					</tr>
					<tr>
						<td>預計投資型式：</td>
						<td colspan='2'>
							<input type="radio" name='QA_invest_type' value='1'>實體店面 &nbsp;<input type="radio" name='QA_invest_type' value='2'>網路店面
						</td>
					</tr>
					<tr>
						<td>預計投資金額：</td>
						<td colspan='3'>
							<input type="radio" name='QA_invest_amount' value='1'>＜100萬元&nbsp;<input type="radio" name='QA_invest_amount' value='2'>100-500萬元&nbsp;<input type="radio" name='QA_invest_amount' value='3'>500-1,000萬元&nbsp;<br>
							<input type="radio" name='QA_invest_amount' value='4'>1,000-1,500萬元&nbsp;<input type="radio" name='QA_invest_amount' value='5'>1,500-2,000萬元&nbsp;<input type="radio" name='QA_invest_amount' value='6'>＞2,000萬元
						</td>
					</tr>
				</table>
				<br><br>
			</form>
		</div>
		<div id='over' style='display:none;'>
			<div style='padding:20px 40px;'>完成分析！請於地圖檢視結果。<br><br>請參考本系統<span id='insert'></span>提供之「決策建議」。<br><br>按下「確認」關閉視窗，或按「上一步」重新分析！</div>
		</div>
		<div id='choose' style='display:none;padding:0 20px;background-color:#fafafa;'>
			<table class='bentable2'>
				<tr><th>一、請選擇欲觀察城市商圈範圍：</th></tr>
				<tr>
					<td>
						國家：<select id='selectcountry'><option value="0">請選擇國家</option><option value="Taiwan">台灣</option></select>
					</td>
				</tr>
				<tr>
					<td>
						城市：<select id='selectRegion'><option value="0">請先選擇國家</option></select>
					</td>
				</tr>
				<tr>
					<td id='BD'>
						商圈：<div style='width:400px;min-height:60px;float:right;'>請先選擇城市</div>
					</td>
				</tr>
				
				<tr><th>二、城市商圈選擇評估試算：</th></tr>
				<tr>
					<td>
						<input type="radio" id='retail_radio' name='hee' value='零售業'>零售業&nbsp;<input type="radio" name='hee' value='餐飲業'>餐飲業
					</td>
				</tr>
				<tr>
					<td style="height:40px;vertical-align:bottom;">
						<br>權重：<div id="slider" style='position:relative;top:-19px;left:110px;'></div>
					</td>
				</tr>
			</table>
			
			<table style='width:720px;font-size:16px'>
				<tr>
					<td>
						未來潛力<input type='text' id='rs1' style='width:60px' value='33.56'/>%<br>
						　├<input type="checkbox" name='check1' checked>未來區域規劃<br>　└<input type="checkbox" name='check2' checked>消費發展潛力
					</td>
					<td>
						<td>現況發展<input type='text' id='rs2' style='width:60px' value='39.74'/>%<br>
						　├<input type="checkbox" name='check3' checked>市場消費規模<br>　└<input type="checkbox" name='check4' checked>消費發展潛力
					</td>
					<td>
						<td>競爭強度<input type='text' id='rs3' style='width:60px' value='26.70'/>%<br>
						　├<input type="checkbox" name='check5' checked>業種業態組成<br>　└<input type="checkbox" name='check6' checked>商圈競爭狀況
					</td>
				</tr>
				<tr>
					<td colspan=3>
					<br>
					(權重預設為該業平均值，可依實際需求進行調整。)
					</td>
				</tr>
			</table>
		</div>
	</div>
	
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
						　時速：<input id='speed' style='padding:0px;width:40px;height:14px;' value='10'>　公里
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
						　需時：<input id='time' style='padding:0px;width:40px;height:14px;' value='30'>　分鐘
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
				　<button class='ui-button' id='end' onclick='$("#env_analyse").dialog("close");'>結束</button>
			</div>
		</div>
	</div>
	
	<div id="msgAlert"></div>
	
    <script type="text/javascript">
	    var markers = [];
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
					
					if(rs_markers.length>=5){
						warningMsg('警告', "最多五個點");
						return;
					}
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
					var marker_obj = new item_marker( 10, 20, rs_marker, rs_circle);
					
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
				}
			});
			trafficLayer = new google.maps.TrafficLayer();
			transitLayer = new google.maps.TransitLayer();
   		
   		}
	    
	    function draw_BDS(BDs,n){
	    	var BD_name=BDs.replace("商圈","")+"商圈";
	    	if(BDs=="新板"){BD_name="新板特區商圈";}
	    	
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
	    			var json_obj = $.parseJSON(result);
	    			all_BDs[BD_name]=[];
	    			$.each(json_obj,function(i, item) {
		    			var bermudaTriangle = new google.maps.Polygon({
							paths: json_obj[i].center,
							strokeColor: '#FF0000',
							strokeOpacity: 0.8,
							strokeWeight: 2,
							fillColor: '#FF0000',
							fillOpacity: 0.1
						});
						bermudaTriangle.setMap(map);
						var marker = new google.maps.Marker({
						    position: businessdistrict[BDs].center,
							label : n,
						    title: businessdistrict[BDs].name,
						    map: map
						});
						var timer;
						var infowindow = new google.maps.InfoWindow({content: businessdistrict[BDs].name});
						google.maps.event.addListener(marker, "mouseover", function(event) { 
				        	infowindow.open(marker.get('map'), marker);
				        	clearTimeout(timer);
				        }); 
						google.maps.event.addListener(marker, "mouseout", function(event) { 
				        	timer = setTimeout(function () { infowindow.close(); }, 3000);
				        });
						google.maps.event.addListener(infowindow, "closeclick", function(event) { 
				            bermudaTriangle.setMap(null);
				            infowindow.setMap(null);
				            marker.setMap(null);
				        });
						all_BDs[BD_name].push(bermudaTriangle);
						google.maps.event.addListener(bermudaTriangle, "click", function(event) { 
							if($("#region_select").dialog("isOpen")&& $("#draw_circle").css("display")=="none"){
								google.maps.event.trigger(map, 'click',event);
							}
				        });
	    			});
	    		}
	    	});
			
	    	return;
	    	var marker = new google.maps.Marker({
			    position: businessdistrict[BDs].center,
				label : n,
			    title: businessdistrict[BDs].name,
			    map: map
			});
			
			var infowindow = new google.maps.InfoWindow({content: businessdistrict[BDs].name});
			
			var cityCircle = new google.maps.Circle({
		      strokeColor: '#FF0000',
		      strokeOpacity: 0.5,
		      strokeWeight: 2,
		      fillColor: '#FF8700',
		      fillOpacity: 0.2,
		      map: map,
		      center: businessdistrict[BDs].center,
		      radius: 800
		    });
			
		  	google.maps.event.addListener(marker, "mouseover", function(event) { 
	        	infowindow.open(marker.get('map'), marker);
	        	setTimeout(function () { infowindow.close(); }, 2000);
	        }); 
		  	
		  	google.maps.event.addListener(marker, "dblclick", function(event) { 
	        	marker.setAnimation(null);
	        });
	    }
	    
	    $(function(){
	    	$.ajax({
				type : "POST",
				url : "regionselect.do",
				data : {
					action : "select_area"
				},
				success : function(result) {
	    			var json_obj = $.parseJSON(result);
					var result_table = "<option value='0'>請選擇國家</option>";
					if(json_obj.length>0){
						$.each(json_obj,function(i, item) {
							result_table+="<option value='"+item+"'>"+item+"</option>";
						});
		    			$("#selectcountry").html(result_table);
					}else{
						$("#selectcountry").html("<option value='0'>無國家資料</option>");
					}
				}
	    	});
	    	$("#selectcountry").change(function(){
	    		$.ajax({
					type : "POST",
					url : "regionselect.do",
					data : {
						action : "select_city",
						area : $(this).val()
					},
					success : function(result) {
		    			var json_obj = $.parseJSON(result);
						var result_table = "<option value='0'>請選擇城市</option>";
						if(json_obj.length>0){
							$.each(json_obj,function(i, item) {
								result_table+="<option value='"+item+"'>"+item+"</option>";
							});
			    			$("#selectRegion").html(result_table);
						}else{
							$("#selectRegion").html("<option value='0'>請先選擇國家</option>");
						}
					}
		    	});
	    	});
	    	$("#selectRegion").change(function(){
	    		$.ajax({
					type : "POST",
					url : "regionselect.do",
					data : {
						action : "select_CBD",
						area : $("#selectcountry").val(),
						city : $(this).val()
					},
					success : function(result) {
		    			var json_obj = $.parseJSON(result);
						var result_table = "商圈：";
						if(json_obj.length>0){
							businessdistrict={};
							var midlng=0.0,midlat=0.0;
							$.each(json_obj,function(i, item) {
								businessdistrict[json_obj[i].name]={};
								businessdistrict[json_obj[i].name].n=i;
								businessdistrict[json_obj[i].name].name=json_obj[i].name;
								businessdistrict[json_obj[i].name].center={};
								businessdistrict[json_obj[i].name].center.lat=parseFloat(json_obj[i].lat);
								businessdistrict[json_obj[i].name].center.lng=parseFloat(json_obj[i].lng);
								midlat+=parseFloat(json_obj[i].lat);
								midlng+=parseFloat(json_obj[i].lng);
								if(i!=0) {
									result_table+= "、";
								}
								result_table += json_obj[i].name;
							});
							
							midlng/=json_obj.length;
							midlat/=json_obj.length;
							map.panTo(new google.maps.LatLng(midlat,midlng));
							map.setZoom(12);
							result_table += "</div>";
							$("#BD").html(result_table);
			    			$("#BD").html(result_table);
						}else{
							$("#BD").html("請選擇國家、城市。");
						}
					}
		    	});
	    	});
	    	
			$("#slider").slider({
				range: true,
		        min: 0,
		        max: 1,
		        step: 0.0001,
		        values: [0.3, 0.6],
		        slide: function (event, ui) {
		            var v0 = ui.values[0];
		            var v1 = ui.values[1];
		            var p1 = v0;
		            var p2 = v1 - v0;
		            var p3 = 1 - p1 - p2;
		            $("#rs1").val((p1 * 100).toFixed(2));
		            $("#rs2").val((p2 * 100).toFixed(2));
		            $("#rs3").val((p3 * 100).toFixed(2));
		        }
			});
			$("#regionselect").dialog({
				draggable : true, resizable : false, autoOpen : false,
				height : "auto", width : "auto", modal : true,
				show : {effect : "blind",duration : 300},
				hide : {effect : "fade",duration : 300},
				open : function(event, ui) {
					$(this).parent().children().children('.ui-dialog-titlebar-close').hide();
				},
				buttons : [{
					text : "重新輸入",
					id : "rewrite",
					click : function() {
						if($("#gointo").html().length==4){
							// stage2 取消
							$("#regionselect").dialog("close");
							setTimeout(function () { 
								$("#QA").show();
								$("#choose").hide();
								$("#jump").html('跳過');
								$("#rewrite").html('重新輸入');
								$("#gointo").html('進入商圈評估');
								$("#jump").css('display','inline');
							}, 200);
						}else if($("#gointo").html().length==2){
							// stage3 上一步
							$("#choose").show();
							$("#over").hide();
							$('div[aria-describedby="regionselect"]').animate({left: '-=150px',});
							$("#jump").html('跳過');
							$("#rewrite").html('取消');
							$("#gointo").html('執行分析');
							$("#jump").css('display','none');
						}else if($("#gointo").html().length==6){
							$('#QA input[name="QA_name"]').val('');
							$('#QA input[name="QA_propost"]').val('');
							$('#QA input[name="QA_taxid"]').val('');
							$('#QA input[name="QA_email"]').val('');
							$('#QA input[name="QA_investcountry"]').val('');
							$('#QA input[name="QA_industry"]:checked').prop('checked',false);
							$('#QA input[name="QA_industry_item"]:checked').prop('checked',false);
							$('#QA input[name="QA_industry_item2"]:checked').prop('checked',false);
							$('#QA input[name="QA_invest_industry"]:checked').prop('checked',false);
							$('#QA input[name="QA_invest_industry_item"]:checked').prop('checked',false);
							$('#QA input[name="QA_invest_industry_item2"]:checked').prop('checked',false);
							$('#QA input[name="QA_invest_brand"]:checked').prop('checked',false);
							$('#QA input[name="QA_invest_pattern"]:checked').prop('checked',false);
							$('#QA input[name="QA_invest_type"]:checked').prop('checked',false);
							$('#QA input[name="QA_invest_amount"]:checked').prop('checked',false);
						}
					}
				},{
					text : "進入商圈評估",
					id : "gointo",
					click : function() {
						if($("#gointo").html().length==4){
							// stage2 執行分析
							var warning = "";
							if($("#selectcountry").val()==0) {
								warning+="請選擇國家<br/>";
							}
							if($("#selectRegion").val()==0) {
								warning+="請選擇城市<br/>";
							}
							if($('#choose input[name="hee"]:checked').length==0) {
								warning+="請選擇產業<br/>";
							}
							if(warning.length>0){
								warningMsg('警告', warning);
								return;
							}
							
							
							var scoreSTR = "";
							$.ajax({
								type : "POST",
								url : "regionselect.do",
								async : false,
								data : {
									action : "call_web_service",
									country : $("#selectcountry").val(),
									region : $("#selectRegion").val(),
									industry : $('#choose input[name="hee"]:checked').val(),
									check1 : $('#choose input[name="check1"]:checked').length,
									check2 : $('#choose input[name="check2"]:checked').length,
									check3 : $('#choose input[name="check3"]:checked').length,
									check4 : $('#choose input[name="check4"]:checked').length,
									check5 : $('#choose input[name="check5"]:checked').length,
									check6 : $('#choose input[name="check6"]:checked').length,
									rs1 : $('#rs1').val(),
									rs2 : $('#rs2').val(),
									rs3 : $('#rs3').val(),
									score : ""
								},
								success : function(result) {
									var json_obj = $.parseJSON(result);
									var result_table = "";
									if(window.scenario_record){scenario_record("區位選擇","["+$("#selectcountry").val()+","+$("#selectRegion").val()+","+$('#choose input[name="hee"]:checked').val()+","+$('#choose input[name="check1"]:checked').length+","+$('#choose input[name="check2"]:checked').length+","+$('#choose input[name="check3"]:checked').length+","+$('#choose input[name="check4"]:checked').length+","+$('#choose input[name="check5"]:checked').length+","+$('#choose input[name="check6"]:checked').length+","+$('#rs1').val()+","+$('#rs2').val()+","+$('#rs3').val()+", "+result.replace(/"([^"]*)"/g, "'$1'")+"]");}
									$.each(json_obj,function(i, item) {
										scoreSTR += json_obj[i].City+ "," +json_obj[i].Score+";" ;
										draw_BDS(json_obj[i].City,(i+1)+"");
									});
									if(json_obj.length>0){
										$("#insert").html("對這"+json_obj.length+"個商圈")
										map.panTo(new google.maps.LatLng(businessdistrict[json_obj[0].City].center.lat,businessdistrict[json_obj[0].City].center.lng));
									}else{
										warningMsg('警告', "此分析有點困難，你安靜點讓我好好想想。<br/>半個小時後給你答案。");
									}									
								}
							});
							
							$.ajax({
								type : "POST",
								url : "regionselect.do",
								data : {
									action : "insert_Regionselect",
									country : $("#selectcountry").val(),
									region : $("#selectRegion").val(),
									industry : $('#choose input[name="hee"]:checked').val(),
									check1 : $('#choose input[name="check1"]:checked').length,
									check2 : $('#choose input[name="check2"]:checked').length,
									check3 : $('#choose input[name="check3"]:checked').length,
									check4 : $('#choose input[name="check4"]:checked').length,
									check5 : $('#choose input[name="check5"]:checked').length,
									check6 : $('#choose input[name="check6"]:checked').length,
									rs1 : $('#rs1').val(),
									rs2 : $('#rs2').val(),
									rs3 : $('#rs3').val(),
									score : scoreSTR
								},
								success : function(result) {
					    			if("success"==result){
					    				$('div[aria-describedby="regionselect"]').animate({left: '+=150px',});
										$('div[aria-describedby="regionselect"]').css("top","20%");
										$("#choose").hide();
										$('#over').show();
										$("#rewrite").html("上一步");
										$("#gointo").html("確認");
										$("#jump").html("決策建議");
										$("#jump").css('display','inline');
					    			}else{
					    				warningMsg('警告', "產生異常問題，請重整");
					    			}
								}
					    	});
						}else if($("#gointo").html().length==2){
							// stage3 確認
							$("#regionselect").dialog("close");
							setTimeout(function () { 
								$("#QA").show();
								$("#choose").hide();
								$("#over").hide();
								$("#jump").html('跳過');
								$("#rewrite").html('重新輸入');
								$("#gointo").html('進入商圈評估');
								$("#jump").css('display','inline');
							}, 200);
						}else if($("#gointo").html().length==6){ 
							// stage1 進入商圈評估
							var warning="";
							if($('#QA input[name="QA_name"]').val().length==0) {
								warning+="請填寫姓名<br/>";
							}
							if($('#QA input[name="QA_propost"]').val().length==0) {
								warning+="請填寫職稱<br/>";
							}
							if($('#QA input[name="QA_taxid"]').val().length==0) {
								warning+="請填寫公司統編<br/>";
							}
							if($('#QA input[name="QA_email"]').val().length==0) {
								warning+="請填寫email<br/>";
							}
							if($('#QA input[name="QA_investcountry"]').val().length==0) {
								warning+="請填寫預計投資國家<br/>";
							}
							if($('#QA input[name="QA_industry"]:checked').length==0) {
								warning+="請填寫現在所屬產業<br/>";
							}
							if(($('#QA input[name="QA_industry"]:checked').val()==1?
									checkboxstr('QA input[name="QA_industry_item"]:checked'):checkboxstr('QA input[name="QA_industry_item2"]:checked')).length==0) {
								warning+="請填寫主要營業項目<br/>";
							}
							if($('#QA input[name="QA_invest_industry"]:checked').length==0) {
								warning+="請填寫預計投資產業<br/>";
							}
							if($('#QA input[name="QA_invest_industry"]:checked').val()==2
									&& ($('#QA input[name="QA_invest_industry"]:checked').val()==1?"":($('#QA input[name="QA_industry"]:checked').val()==1?checkboxstr('QA input[name="QA_invest_industry_item2"]:checked'):checkboxstr('QA input[name="QA_invest_industry_item"]:checked'))).length==0) {
								warning+="請填寫預計投資項目<br/>";
							}
							if($('#QA input[name="QA_invest_brand"]:checked').length==0) {
								warning+="請填寫預計投資品牌<br/>";
							}
							if(checkboxstr('QA input[name="QA_invest_pattern"]:checked').length==0) {
								warning+="請填寫預計投資型態<br/>";
							}
							if($('#QA input[name="QA_invest_type"]:checked').length==0) {
								warning+="請填寫預計投資型式<br/>";
							}
							if($('#QA input[name="QA_invest_amount"]:checked').length==0) {
								warning+="請填寫預計投資金額<br/>";
							}
							
							if(warning.length!=0){
								warningMsg('警告', warning);
								return;
							}
							if(window.scenario_record){scenario_record("區位選擇問卷","["+$('#QA input[name="QA_name"]').val()+","+$('#QA input[name="QA_propost"]').val()+","+$('#QA input[name="QA_taxid"]').val()+","+$('#QA input[name="QA_email"]').val()+","+$('#QA input[name="QA_investcountry"]').val()+","+$('#QA input[name="QA_industry"]:checked').val()+",("+($('#QA input[name="QA_industry"]:checked').val()==1?checkboxstr('QA input[name="QA_industry_item"]:checked'):checkboxstr('QA input[name="QA_industry_item2"]:checked'))+"),"+$('#QA input[name="QA_invest_industry"]:checked').val()+",("+($('#QA input[name="QA_invest_industry"]:checked').val()==1?"":($('#QA input[name="QA_industry"]:checked').val()==1?checkboxstr('QA input[name="QA_invest_industry_item2"]:checked'):checkboxstr('QA input[name="QA_invest_industry_item"]:checked')))+"),"+$('#QA input[name="QA_invest_brand"]:checked').val()+",("+checkboxstr('QA input[name="QA_invest_pattern"]:checked')+"),"+$('#QA input[name="QA_invest_type"]:checked').val()+","+$('#QA input[name="QA_invest_amount"]:checked').val()+"]");}
							$.ajax({
								type : "POST",
								url : "regionselect.do",
								data : {
									action : "insert_QA",
									QA_name : $('#QA input[name="QA_name"]').val(),
									QA_propost : $('#QA input[name="QA_propost"]').val(),
									QA_taxid : $('#QA input[name="QA_taxid"]').val(),
									QA_email : $('#QA input[name="QA_email"]').val(),
									QA_investcountry : $('#QA input[name="QA_investcountry"]').val(),
									QA_industry : $('#QA input[name="QA_industry"]:checked').val(),
									QA_industry_item : ($('#QA input[name="QA_industry"]:checked').val()==1?checkboxstr('QA input[name="QA_industry_item"]:checked'):checkboxstr('QA input[name="QA_industry_item2"]:checked')),
									QA_invest_industry : $('#QA input[name="QA_invest_industry"]:checked').val(),
									QA_invest_industry_item : ($('#QA input[name="QA_invest_industry"]:checked').val()==1?"":($('#QA input[name="QA_industry"]:checked').val()==1?checkboxstr('QA input[name="QA_invest_industry_item2"]:checked'):checkboxstr('QA input[name="QA_invest_industry_item"]:checked'))),
									QA_invest_brand : $('#QA input[name="QA_invest_brand"]:checked').val(),
									QA_invest_pattern : checkboxstr('QA input[name="QA_invest_pattern"]:checked'),
									QA_invest_type : $('#QA input[name="QA_invest_type"]:checked').val(),
									QA_invest_amount : $('#QA input[name="QA_invest_amount"]:checked').val()
								},
								success : function(result) {
									
					    			if("success"==result){
					    				$("#selectcountry").val('0');
										$("#selectRegion").val('0');
										$('#QA input[name="hee"]:checked').prop('checked',false);
										$('#BD').html('商圈：');
					    				$("#regionselect").css("background","none");
										$("#QA").hide(function(){
											$("#choose").show();
											$("#jump").hide();
											$("#rewrite").html("取消");
											$("#gointo").html("執行分析");
											$('div[aria-describedby="regionselect"]').animate({
											    left: '-=100px',
											});
										});
					    			}else{
					    				warningMsg('警告', "產生異常問題，請重整");
					    			}
								}
					    	});
						}
					}
				},{
					text : "跳過",
					"class": 'floatleft',
					id : "jump",
					click : function() {
						if($("#gointo").html().length==6){
							// stage1 跳過
							$("#regionselect").css("background","none");
							$("#selectcountry").val('0');
							$("#selectRegion").val('0');
							$('#QA input[name="hee"]:checked').prop('checked',false);
							$('#BD').html('商圈：');
							$("#QA").hide(function(){
								$("#choose").show();
								$("#jump").hide();
								$("#rewrite").html("取消");
								$("#gointo").html("執行分析");
								$('div[aria-describedby="regionselect"]').animate({
								    left: '-=100px',
								});
							});
						}else if($("#gointo").html().length==2){ 
							// stage3 兩張圖
							if($('#choose input[name="hee"]:checked').val()=="零售業"){
								window.open("./images/區位選擇決策建議_零售業_s.jpg", "_blank", "", false);
							}else if($('#choose input[name="hee"]:checked').val()=="餐飲業"){
								window.open("./images/餐飲業決策建議_s.jpg", "_blank", "", false);
							}else{
								warningMsg('警告', "沒有選擇行業類別");
							}
						}
					}
				}],
				close : function() {
					$("#regionselect").dialog("close");
				}
			});
			$("#regionselect").show();
			$("#selectRegion").change(function(){
				return;
				var selecttable="商圈：<div style='max-width:400px;min-height:60px;float:right;'>";
				for (var BD in businessdistrict) {
					if($(this).val()=="Taipei"&& businessdistrict[BD].n<14){ 
						if(businessdistrict[BD].n==1){
							
						}else{
							selecttable+="、";
						}
						selecttable+= businessdistrict[BD].name;
						map.panTo(new google.maps.LatLng(25.034,121.524));
						map.setZoom(14);
					}
					if($(this).val()=="Taoyuan"&& businessdistrict[BD].n>13&& businessdistrict[BD].n<25){ 
						if(businessdistrict[BD].n==14){
							
						}else{
							selecttable+="、";
						}
						selecttable+= businessdistrict[BD].name;
						map.panTo(new google.maps.LatLng(24.995, 121.298));
						map.setZoom(12);
					}
					if($(this).val()=="Taichung"&& businessdistrict[BD].n>24&& businessdistrict[BD].n<32){ 
						if(businessdistrict[BD].n==25){
							
						}else{
							selecttable+="、";
						}
						selecttable+= businessdistrict[BD].name;
						map.panTo(new google.maps.LatLng(24.148, 120.685));
						map.setZoom(12);
					}
					if($(this).val()=="Tainan"&& businessdistrict[BD].n>31&& businessdistrict[BD].n<44){ 
						if(businessdistrict[BD].n==32){
							
						}else{
							selecttable+="、";
						}
						selecttable+=businessdistrict[BD].name;
						map.panTo(new google.maps.LatLng(22.994, 120.218));
						map.setZoom(12);
					}
					if($(this).val()=="Kaohsiung"&& businessdistrict[BD].n>43){ 
						if(businessdistrict[BD].n==44){
							
						}else{
							selecttable+="、";
						}
						selecttable+=businessdistrict[BD].name;
						map.panTo(new google.maps.LatLng(22.624, 120.307));
						map.setZoom(12);
					}
				}
				
				selecttable+="</div>";
				$("#BD").html(selecttable);
			});

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
		    		warningMsg('警告', "請放置分析點。");
		    	}else{
		    		map.setOptions({draggableCursor:null});
		    		$("#instruction").hide();
		    		$("#draw_circle").show();
		    		$.each(rs_markers,function(i, item) {
		    			rs_markers[i].circle.setRadius(rs_markers[i].speed* rs_markers[i].time *1000 * 0.016667);
		    		});
		    		$("div[aria-describedby='env_analyse']").animate({"left": "-=180px"});
		    	}
		    });
		    $("#env_analyse_last").click(function(){
		    	map.setOptions({draggableCursor:("url("+location.href.replace('realMap.jsp','')+"refer_data/cursor2.cur),default")});
	    		$("#instruction").show();
	    		$("#draw_circle").hide();
	    		$("div[aria-describedby='env_analyse']").animate({"left": "+=180px"});
		    });
		    
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
		    
			$("#env_slider").slider({
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

			$("#end").click(function(){
				var result_str="[經度,緯度,半徑,時速,時間]=>";
				$.each(rs_markers, function(i, node){
					result_str+="點"+(i+1);
					result_str+="["+node.marker.position.lat()+", "+node.marker.position.lng()+", "+node.circle.radius+"m, "+node.speed+"km/hr, "+node.time+"mins]";
				});
				if(window.scenario_record){scenario_record("環域分析",result_str);}
			});
		});
    </script>
    
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBSQDx-_LzT3hRhcQcQY3hHgX2eQzF9weQ&signed_in=true&libraries=places&callback=initMap">
	</script> 
	</div>
</div>

<jsp:include page="footer.jsp" flush="true"/>