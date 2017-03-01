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
	i=0;for(item in json){i++;}
	if(i==0)return;
	for (key in json){
		if(key=="folder" && json[key]=="true"){
			json["hideCheckbox"]=true;
		}
		if(key=="action"){
			action[json["key"]]=json[key];
		}
		
		i=0;for(item in json[key]){i++;}
		if(i>0 && (typeof json[key]!="string")){
			hidecheckbox(json[key]);
		}
	}
}

	$(function(){
		$("#shpLegend").draggable({ containment: ".page-wrapper" });
		$.ajax({
			type : "POST",
			url : "realMap.do",
			async : false,
			data : {
				action : "select_menu", type : "POI"
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
						if($(node.span.childNodes[1]).hasClass('loading')) { return false; }
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
					    if($(node.span.childNodes[1]).hasClass('loading')) { return false; }
					    node.setSelected( !node.isSelected() );
					    
					    if(data.node.isFolder()&&have_visited[node.key]!=null){eval(action[data.node.key]);}
					},
					
					select: function(event, data) {
						var node = data.node;
						if($(node.span.childNodes[1]).hasClass('loading')) { return false; }
					}
				}).on("mouseenter, mouseleave", ".fancytree-title", function(event){
				    var pdf_layer=["19","20","21","22","23","24","25","26","27","28","29","31","32","33","34","35","42","44","46","48"];
				    var node = $.ui.fancytree.getNode(event);
				    if(pdf_layer.indexOf(node.key)!=-1){
				    }
				    node.info(event.type);
				}).on("mouseover", ".fancytree-title", function(event){
				    var pdf_layer=["19","20","21","22","23","24","25","26","27","28","29","31","32","33","34","35","42","44","46","48"];
				    var node = $.ui.fancytree.getNode(event);
				    if(pdf_layer.indexOf(node.key)!=-1){
				    	$('#pdf_layer').children().html('<div onclick=\'window.open(\"http://61.218.8.51/SBI/pdf/'+$("#ftal_"+node.key).text().replace('商圈','')+'.pdf\", \"_blank\");\'> '+$("#ftal_"+node.key).text().replace('商圈','')+"電子書"+'</div>');
				    	//$('#pdf_layer').children().html('<div onclick=\'window.open(\"./refer_data/pdf/'+$("#ftal_"+node.key).text().replace('商圈','')+'.pdf\", \"_blank\");\'> '+$("#ftal_"+node.key).text().replace('商圈','')+"電子書"+'</div>');
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
	<div id='panel' 
	onmouseover="$('#panel').css('left','150px');clearTimeout($('#panel').val());" 
	tmp="$('#panel').val(setTimeout(function () { $('#panel').css('left','0px'); }, 800));">
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
		<div style='position:absolute;width:100%;bottom:5px;border-top:2px solid #aaa;padding:10px 0px 5px 0px;'><table><tr><td>&nbsp;透明度：</td><td><div id='opacity' style='width:110px;'></div></td></tr></table></div>
	</div>
	
<h2 class="page-title">商圈POI</h2>
	<div class="search-result-wrap">
	<div id="map"></div>
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
	<div id="detail_1"></div>
	<div id='warning' title='公告' style='display:none;padding:20px 20px 10px 20px;word-break: keep-all;'>
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
			trafficLayer = new google.maps.TrafficLayer();
			transitLayer = new google.maps.TransitLayer();
   		}
    </script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC8QEQE4TX2i6gpGIrGbTsrGrRPF23xvX4&signed_in=true&libraries=places&callback=initMap"></script>
	<div id='picture' style='position:fixed;left:10%;top:20%;z-index:-1;'ondblclick='$("#picture").css("z-index","-1");'></div>
	</div>
</div>

<jsp:include page="footer.jsp" flush="true"/>