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
	.header {
		top: 0px;
	}
	.page-wrapper {
	/*     background: #194A6B; */
	    background-color: #EEF3F9;
	}
	.content-wrap{
	/* 	height: calc(100vh - 84px); */
	/* 	width: calc(100% - 136px); */
	/* 	margin: 56px 0 28px 136px; */
		
	    background: #fff;
	    float: left;
	    margin-left: 0px;
	    margin-top: 100px;
 	    margin-bottom: 20px; 
 	    padding-bottom: 62px; 
/* 	    height: 900px; */
	    overflow-y: scroll;
	    width: 100%;
		background-color: #EEF3F9;
	}
	.search-result-wrap{
 		padding: 10px 10px 10px 10px; 
		margin-bottom: 20px;
		height: 70vh;
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
		font-size:16px;
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
	
	.bentable th{
		word-break: keep-all;
		padding:16px 0px 2px 0px;
	/* 	padding-bottom:4px; */
		
		text-align:left;
		font-size:22px;
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

var businessdistrict = {
		BD_1: {n:1,name: "北車商圈",center: {lat: 25.045982, lng: 121.514999}},BD_2: {n:2,name: "新板特區商圈",center: {lat: 25.013372, lng: 121.465019}},BD_3: {n:3,name: "信義商圈",center: {lat: 25.035910, lng: 121.565300}},BD_4: {n:4,name: "西門商圈",center: {lat: 25.044571, lng: 121.506409}},BD_5: {n:5,name: "公館商圈",center: {lat: 25.014906, lng: 121.533882}},BD_6: {n:6,name: "忠孝商圈",center: {lat: 25.041836, lng: 121.545212}},BD_7: {n:7,name: "南西商圈",center: {lat: 25.056343, lng: 121.524147}},BD_8: {n:8,name: "天母商圈",center: {lat: 25.112495, lng: 121.531334}},BD_9: {n:9,name: "士林商圈",center: {lat: 25.088177, lng: 121.525116}},BD_10: {n:10,name: "淡水商圈",center: {lat: 25.169636, lng: 121.441689}},BD_11: {n:11,name: "府中商圈",center: {lat: 25.008665, lng: 121.460594}},BD_12: {n:12,name: "三和夜市商圈",center: {lat: 25.065723, lng: 121.500481}},BD_13: {n:13,name: "頂溪商圈",center: {lat: 25.012350, lng: 121.517319}},BD_14: {n:14,name: "大園竹圍漁港魅力商圈",center: {lat: 25.015139, lng: 121.298866}},BD_15: {n:15,name: "中壢火車站前商圈",center: {lat: 24.954807, lng: 121.223114}},BD_16: {n:16,name: "龍元宮商圈",center: {lat: 24.865213, lng: 121.213867}},BD_17: {n:17,name: "復興區角板山商圈",center: {lat: 24.822550, lng: 121.353409}},BD_18: {n:18,name: "中壢觀光夜市",center: {lat: 24.960838, lng: 121.215279}},BD_19: {n:19,name: "中原夜市商圈",center: {lat: 24.955498, lng: 121.240547}},BD_20: {n:20,name: "桃園區火車站前商圈",center: {lat: 24.992674, lng: 121.312767}},BD_21: {n:21,name: "桃園觀光夜市",center: {lat: 25.001781, lng: 121.307854}},BD_22: {n:22,name: "中壢區六和商圈",center: {lat: 24.962227, lng: 121.223885}},BD_23: {n:23,name: "桃園中正藝文特區商圈",center: {lat: 25.017681, lng: 121.297813}},BD_24: {n:24,name: "大溪老街商圈",center: {lat: 24.884075, lng: 121.287758}},BD_25: {n:25,name: "逢甲商圈",center: {lat: 24.177917, lng: 120.645721}},BD_26: {n:26,name: "一中商圈",center: {lat: 24.148779, lng: 120.685211}},BD_27: {n:27,name: "精明一街",center: {lat: 24.156441, lng: 120.655380}},BD_28: {n:28,name: "美術園道商圈",center: {lat: 24.139286, lng: 120.663506}},BD_29: {n:29,name: "自由路商圈",center: {lat: 24.142656, lng: 120.684937}},BD_30: {n:30,name: "市政商圈",center: {lat: 24.161242, lng: 120.644402}},BD_31: {n:31,name: "東海商圈",center: {lat: 24.182249, lng: 120.591202}},BD_32: {n:32,name: "成大商圈",center: {lat: 22.994476, lng: 120.218056}},BD_33: {n:33,name: "海安商圈",center: {lat: 22.992544, lng: 120.197235}},BD_34: {n:34,name: "中正銀座商圈",center: {lat: 22.992867, lng: 120.197701}},BD_35: {n:35,name: "國華友愛新商圈",center: {lat: 22.992512, lng: 120.197197}},BD_36: {n:36,name: "孔廟形象商圈",center: {lat: 22.990108, lng: 120.205772}},BD_37: {n:37,name: "新化商圈",center: {lat: 23.035398, lng: 120.308151}},BD_38: {n:38,name: "安平商圈",center: {lat: 23.000124, lng: 120.163048}},BD_39: {n:39,name: "新營商圈",center: {lat: 23.304497, lng: 120.316727}},BD_40: {n:40,name: "關子嶺商圈",center: {lat: 23.337807, lng: 120.505386}},BD_41: {n:41,name: "東山商圈",center: {lat: 23.290840, lng: 120.500504}},BD_42: {n:42,name: "善化商圈",center: {lat: 23.128122, lng: 120.297371}},BD_43: {n:43,name: "玉井商圈",center: {lat: 23.124012, lng: 120.460495}},BD_44: {n:44,name: "三多商圈",center: {lat: 22.613955, lng: 120.304558}},BD_45: {n:45,name: "新崛江商圈",center: {lat: 22.622780, lng: 120.302757}},BD_46: {n:46,name: "後驛商圈",center: {lat: 22.640680, lng: 120.299347}},BD_47: {n:47,name: "巨蛋商圈",center: {lat: 22.666962, lng: 120.304108}},BD_48: {n:48,name: "夢時代商圈",center: {lat: 22.594856, lng: 120.307228}}
}
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

	
</script>
<!-- /**************************************  以上使用者JS區塊    *********************************************/	-->

<jsp:include page="header.jsp" flush="true"/>
<div class="content-wrap">
<h2 class="page-title">商圈定位</h2>
	<div class="search-result-wrap">

<!-- 	<button onclick='$("#regionselect").dialog("open");' style='position:absolute;left:50%;top:100px;z-index:99;'>打開</button> -->
	<a class="btn btn-orange" onclick='$("#regionselect").dialog("open");' style='position:absolute;left:23%;top:110px;z-index:99;'>選單</a>

	<div id='regionselect' title='區位選擇' style='display:none;background:#E7E7E7;'>
		<div id='QA' style='height:400px;width:800px;'>
		   <embed id='pdf' src='http://61.218.8.51/SBI/func/formview/QA.html' style='width:99%;height:400px;'>
		</div>
		<div id='over' style='display:none;'>
			<div style='padding:20px 40px;'>完成分析！請於地圖檢視結果。<br><br>請參考本系統提供之「決策建議」。<br><br>按下「確認」關閉視窗，或按「上一步」重新分析！</div>
		</div>
		<div id='choose' style='display:none;padding:0 20px;'>
			<table class='bentable'>
				<tr><th>一、請選擇欲觀察城市商圈範圍：</th></tr>
				<tr>
					<td>
						國家：<select id='selectcountry'><option value="0">請選擇國家</option><option value="Taiwan">台灣</option></select>
					</td>
				</tr>
				<tr>
					<td>
						城市：<select id='selectRegion'><option value="">請先選擇國家</option></select>
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
						<input type="radio" name='hee' id='a' value='1'>零售業&nbsp;<input type="radio" name='hee' id='b' value='2'>餐飲業
					</td>
				</tr>
				<tr>
					<td style="height:40px;vertical-align:bottom;">
						&nbsp;&nbsp;　權重：<div id="slider" style='position:relative;top:-14px;left:80px;'></div>
					</td>
				</tr>
			</table>
			
			<table style='width:600px;'>
				<tr>
					<td>
						未來潛力<input type='text' id='rs1' style='width:40px' value='33.56'/>%<br>
						　├<input type="checkbox" checked>未來區域規劃<br>　└<input type="checkbox" checked>消費發展潛力
					</td>
					<td>
						<td>現況發展<input type='text' id='rs2' style='width:40px' value='39.74'/>%<br>
						　├<input type="checkbox" checked>市場消費規模<br>　└<input type="checkbox" checked>消費發展潛力
					</td>
					<td>
						<td>競爭強度<input type='text' id='rs3' style='width:40px' value='26.70'/>%<br>
						　├<input type="checkbox" checked>業種業態組成<br>　└<input type="checkbox" checked>商圈競爭狀況
					</td>
				</tr>
				<tr>
					<td colspan=3>
					(權重預設為該業平均值，可依實際需求進行調整。)
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div id="map"></div>
    <script type="text/javascript">
	    var markers = [];
	    var words=['4','2','3','1','5','7','6','8','9','10','11','12','13','14','15'];
	    
	    function initMap() {
			// Create the map.
			map = new google.maps.Map(document.getElementById('map'), {
				zoom: 7,
				center: {lat: 23.900, lng: 121.000},
				mapTypeId: google.maps.MapTypeId.ROADMAP
			});
    	  
   		}
	    
	    function draw_BDS(BDs,n){
	    	var marker = new google.maps.Marker({
			    position: businessdistrict[BDs].center,
//				    animation: google.maps.Animation.DROP,
				label : words[n],
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
//	 			height : 525, width : 830, modal : true,
				height : "auto", width : "auto", modal : true,
				show : {effect : "blind",duration : 300},
				hide : {effect : "fade",duration : 300},
				buttons : [{
					text : "重新輸入",
					id : "rewrite",
					click : function() {
						if($("#gointo").html().length==4||$("#gointo").html().length==2){
							$("#regionselect").dialog("close");
						}else if($("#gointo").html().length==6){
							$("#QA").html("<embed id='pdf' src='http://61.218.8.51/SBI/func/formview/QA.html' style='width:99%;height:400px;'>");
						}
					}
				},{
					text : "進入商圈評估",
					id : "gointo",
					click : function() {
						if($("#gointo").html().length==4){
							
							$('div[aria-describedby="regionselect"]').animate({
							    left: '+=100px',
							});
							$('div[aria-describedby="regionselect"]').css("top","20%");
							$("#choose").hide();
							$('#over').show();
// 							$('#regionselect').html("<div style='padding:20px 40px;'>完成分析！請於地圖檢視結果。<br><br>請參考本系統提供之「決策建議」。<br><br>按下「確認」關閉視窗，或按「上一步」重新分析！</div>");
							$("#rewrite").html("上一步");
							$("#gointo").html("確認");
							$("#jump").html("決策建議");
							$("#jump").css('display','inline');
							
							for (var BD in businessdistrict) {
								if($("#selectRegion").val()=="Taipei"&& businessdistrict[BD].n<14){
									draw_BDS(BD, businessdistrict[BD].n-1);
								}
								if($("#selectRegion").val()=="Taoyuan"&& businessdistrict[BD].n>13&& businessdistrict[BD].n<25){ 
									draw_BDS(BD,businessdistrict[BD].n-14);
								}
								if($("#selectRegion").val()=="Taichung"&& businessdistrict[BD].n>24&& businessdistrict[BD].n<32){ 
									draw_BDS(BD,businessdistrict[BD].n-25);
								}
								if($("#selectRegion").val()=="Tainan"&& businessdistrict[BD].n>31&& businessdistrict[BD].n<44){ 
									draw_BDS(BD,businessdistrict[BD].n-32);
								}
								if($("#selectRegion").val()=="Kaohsiung"&& businessdistrict[BD].n>43){ 
									draw_BDS(BD,businessdistrict[BD].n-44);
								}
							}
							
						}else if($("#gointo").html().length==2){
							//###########################################################
							map.panTo(new google.maps.LatLng(25.044571, 121.506409));
							map.setZoom(15);
							
							$("#regionselect").dialog("close");
							//###########################################################
						}else if($("#gointo").html().length==6){
							$("#regionselect").css("background","none");
							$("#QA").hide(function(){
								$("#choose").show();
								$("#jump").hide();
								$("#rewrite").html("取消");
								$("#gointo").html("執行分析");
								$('div[aria-describedby="regionselect"]').animate({
								    left: '+=100px',
								});
							});
						}
					}
				},{
					text : "跳過",
					"class": 'floatleft',
					id : "jump",
					click : function() {
						if($("#gointo").html().length==6){
							$("#regionselect").css("background","none");
							$("#QA").hide(function(){
								$("#choose").show();
								$("#jump").hide();
								$("#rewrite").html("取消");
								$("#gointo").html("執行分析");
								$('div[aria-describedby="regionselect"]').animate({
								    left: '+=100px',
								});
							});
						}else if($("#gointo").html().length==2){
							window.open("http://61.218.8.51/CDRI_data/region/餐飲業決策建議_s.jpg", "_blank", "", false);
						}
					}
				}],
				close : function() {
					$("#regionselect").dialog("close");
				}
			});
			$("#regionselect").show();
			$("#selectcountry").change(function(){
				if($(this).val()=="Taiwan"){
					$("#selectRegion").html('<option value="">請選擇</option><option value="Taipei">台北</option><option value="Taoyuan">桃園</option><option value="Taichung">台中</option><option value="Tainan">台南</option><option value="Kaohsiung">高雄</option>');
				}
			});
			$("#selectRegion").change(function(){
				
				var selecttable="商圈：<div id='BD' style='max-width:400px;min-height:60px;float:right;'>";
				for (var BD in businessdistrict) {
					if($(this).val()=="Taipei"&& businessdistrict[BD].n<14){ 
						if(businessdistrict[BD].n==1){}else{selecttable+="、";}
						selecttable+= businessdistrict[BD].name;
						map.panTo(new google.maps.LatLng(25.034,121.524));
						map.setZoom(14);
					}
					if($(this).val()=="Taoyuan"&& businessdistrict[BD].n>13&& businessdistrict[BD].n<25){ 
						if(businessdistrict[BD].n==14){}else{selecttable+="、";}
						selecttable+= businessdistrict[BD].name;
						map.panTo(new google.maps.LatLng(24.995, 121.298));
						map.setZoom(12);
					}
					if($(this).val()=="Taichung"&& businessdistrict[BD].n>24&& businessdistrict[BD].n<32){ 
						if(businessdistrict[BD].n==25){}else{selecttable+="、";}
						selecttable+= businessdistrict[BD].name;
						map.panTo(new google.maps.LatLng(24.148, 120.685));
						map.setZoom(12);
					}
					if($(this).val()=="Tainan"&& businessdistrict[BD].n>31&& businessdistrict[BD].n<44){ 
						if(businessdistrict[BD].n==32){}else{selecttable+="、";}
						selecttable+=businessdistrict[BD].name;
						map.panTo(new google.maps.LatLng(22.994, 120.218));
						map.setZoom(12);
					}
					if($(this).val()=="Kaohsiung"&& businessdistrict[BD].n>43){ 
						if(businessdistrict[BD].n==44){}else{selecttable+="、";}
						selecttable+=businessdistrict[BD].name;
						map.panTo(new google.maps.LatLng(22.624, 120.307));
						map.setZoom(12);
					}
				}
				
				selecttable+="</div>";
				$("#BD").html(selecttable);
			});
			
		});
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBSQDx-_LzT3hRhcQcQY3hHgX2eQzF9weQ&signed_in=true&libraries=places&callback=initMap">
     </script> 

	</div>
</div>

<jsp:include page="footer.jsp" flush="true"/>