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
	#panel{
		background: url(./fancy-tree/skin-xp/bg.png) repeat;
		transition: all .3s linear;
		position:fixed;
		left:0px;
		top:96px; 
/* 		width:20px; */
		min-width:200px;
		width:auto;
		height:calc(100vh - 126px);
		
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
    #map > div {
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
// 	alert(all_markers[poi_name]);
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
			name : poi_name
		},
		success : function(result) {
			//alert(result);
			if(result=="fail!!!!!")return;
			var json_obj = $.parseJSON(result);
			var result_table = "";
			all_markers[poi_name]=[];
			$.each(json_obj,function(i, item) {
				//alert(json_obj[i].name);
				var marker = new google.maps.Marker({
				    position: json_obj[i].center,
				    title: json_obj[i].name,
				    map: map
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
			name : poi_name
		},
		success : function(result) {
			if(result=="fail!!!!!")return;
			var json_obj = $.parseJSON(result);
			var result_table = "";
			$.each(json_obj,function(i, item) {
				//alert(json_obj[i].name);
				var marker = new google.maps.Marker({
				    position: json_obj[i].center,
				    title: json_obj[i].name,
				    map: map
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
				map.setZoom(15);
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

	$(function(){
// 		select_poi("超市便利商店");
// 		select_BD("後驛商圈");
// 		select_poi_2("圖書館");
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
	});
</script>

<jsp:include page="header.jsp" flush="true"/>
<div class="content-wrap">
	<div id='panel' onmouseover="$('#panel').css('left','0px');clearTimeout($('#panel').val());" onmouseout="$('#panel').val(setTimeout(function () { $('#panel').css('left',(10-parseInt($('#panel').css('width'),10))); }, 500));">
		<div id='tree'></div>
	</div>
<h2 class="page-title">商圈定位</h2>
	<div class="search-result-wrap">
	<div id="map"></div>
    <script>
	    function initMap() {
			// Create the map.
			map = new google.maps.Map(document.getElementById('map'), {
				zoom: 8,
				center: {lat: 23.900, lng: 121.000},
				mapTypeId: google.maps.MapTypeId.ROADMAP
			});
    	  
   		}
    </script>
    
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBSQDx-_LzT3hRhcQcQY3hHgX2eQzF9weQ&signed_in=true&libraries=places&callback=initMap">
     </script> 
<!-- 		background-color:#F00; -->
	<div id='picture' style='position:fixed;left:10%;top:20%;z-index:-1;'ondblclick='$("#picture").css("z-index","-1");'></div>
	</div>
</div>

<jsp:include page="footer.jsp" flush="true"/>