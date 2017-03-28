//　此JS包含
//　0.google map的pan和zoom　
//　1.搜POI 比 type 的　
//　2.搜POI 比subtype的　
//　3.Menu商圈中畫商圈　
//　4~8,10,11.Menu中[開放資源,國家,城市,熱力圖,整體城市概況,中國省份行政分界 ,大麥克 ]
//　9.原SBI的四個function　
// 12,13[畫區位選擇,畫環域分析]
//　皆為畫googlemap相關功能

//googlemap panto zoom
var in_smoothZoom=0;
var in_panTo=0;
function smoothZoom (map, max, cnt) {
	//考量能力，取消smooth
	map.setZoom(max);
	return;
	
	if(in_smoothZoom==1){
		setTimeout(function(){
			map.setZoom(max);
		}, 2000);
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
        setTimeout(function(){map.setZoom(cnt)}, 80); 
    }
}  
var panPath = [];   
var panQueue = [];  
var STEPS = 30;
function panTo(newLat, newLng) {
	//考量能力，取消smooth
	map.panTo( new google.maps.LatLng( newLat, newLng) );
	return;
	
	if(in_panTo==1){
		setTimeout(function(){
			map.panTo( new google.maps.LatLng( newLat, newLng) );
		}, 2000);
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
    panQueue.push([newLat, newLng]);
  } else {
    panPath.push("LAZY SYNCRONIZED LOCK");
    var curLat = map.getCenter().lat();
    var curLng = map.getCenter().lng();
    var dLat = (newLat - curLat)/STEPS;
    var dLng = (newLng - curLng)/STEPS;

    for (var i=0; i < STEPS; i++) {
      panPath.push([curLat + dLat * i, curLng + dLng * i]);
    }
    panPath.push([newLat, newLng]);
    panPath.shift();
    setTimeout(doPan, 20);
  }
}

function doPan() {
  var next = panPath.shift();
  if (next != null) {
    map.panTo( new google.maps.LatLng(next[0], next[1]));
    setTimeout(doPan, 20 );
  } else {
    var queued = panQueue.shift();
    if (queued != null) {
    	panTo_layer(queued[0], queued[1]);
    }else{
    	 in_panTo=0;
    }
  }
}
//POI[type]
function select_poi(poi_name,record){
	if(all_markers[poi_name]!=null){
		for (var i = 0; i < all_markers[poi_name].length; i++) {   
			all_markers[poi_name][i].setMap(null);   
        }   
		all_markers[poi_name]=null;
		return;
	}
	if(record!="no_record"){
		var this_node;
		var sibling_node = $('#tree').fancytree('getTree').getSelectedNodes();
		sibling_node.forEach(function(sib_node) {
			if(sib_node.title==poi_name){
				this_node=sib_node;
			}
		});
		$(this_node.span.childNodes[1]).addClass('loading');
		if(!$(this_node.span.childNodes[1]).hasClass('poi')){
			$(this_node.span.childNodes[1]).addClass('poi');
			$(this_node.span.childNodes[1]).attr('scenario_lat',new Number(map.getCenter().lat()).toFixed(4));
			$(this_node.span.childNodes[1]).attr('scenario_lng',new Number(map.getCenter().lng()).toFixed(4));
			$(this_node.span.childNodes[1]).attr('scenario_zoom',map.getZoom());
		}
	} 
	
	$.ajax({
		type : "POST",
		url : "realMap.do",
//		async : false,
		data : {
			action : "select_poi",
			name : poi_name,
			lat : map.getCenter().lat,
			lng : map.getCenter().lng,
			zoom : map.getZoom()
		},
		success : function(result) {
			var tmp_str="";
			if(result=="fail!!!!!")return;
			var json_obj = $.parseJSON(result);
			var result_table = "";
			if(record!="no_record"){
				all_markers[poi_name]=[];
			}
			if(json_obj.length>1000){
				if(confirm("搜尋資料量達"+json_obj.length+"筆\n是否繼續查詢?","確認繼續","取消")){}else{
					return;
			}}
//			var tmp_time= new Date().getTime();
			$.each(json_obj,function(i, item) {
//				console.log(" time: "+(new Date().getTime()-tmp_time)+"名: "+json_obj[i].name);
				var  icon = json_obj[i].icon.length>3?json_obj[i].icon:"./refer_data/poi_icon/Q2.png";
				var marker = new google.maps.Marker({
				    position: json_obj[i].center,
				    title: json_obj[i].name,
				    map: map,
 				    icon : icon
				});
				var poi_flow_str=""
				if(poi_name=="捷運" && json_obj[i].memo.length>0){
					poi_flow_str+='<tr><td>平均人流：</td><td>'+json_obj[i].memo+'人</td></tr>';
				}
				var tmp_table='<table class="info_window">'+
				'<tr><th colspan="2">'+json_obj[i].type+'　</th></tr>'+
				'<tr><td>名稱：</td><td>'+json_obj[i].name+'</td></tr>'+
				((json_obj[i].addr!=null)?'<tr><td>地址：</td><td>'+json_obj[i].addr+'</td></tr>':"")+
				((json_obj[i].subtype!=null&&json_obj[i].subtype!='NULL')?'<tr><td>類型：</td><td>'+json_obj[i].subtype+'</td></tr>':"")+
				poi_flow_str+
				'</table>';
				var infowindow = new google.maps.InfoWindow({content:tmp_table});
				if(json_obj.length<30){
					google.maps.event.addListener(marker, "mouseover", function(event) { 
			        	infowindow.open(marker.get('map'), marker);
			        });
					google.maps.event.addListener(marker, "mouseout", function(event) { 
			        	setTimeout(function () { infowindow.close(); }, 2000);
			        });
				}else{
					google.maps.event.addListener(marker, "click", function(event) { 
						var infowindow_open = infowindow.getMap();
					    if(infowindow_open !== null && typeof infowindow_open !== "undefined"){
					    	infowindow.close();					    	
					    }else{
					    	infowindow.open(marker.get('map'), marker);
					    }
			        });
				}
				if(record!="no_record"){
					all_markers[poi_name].push(marker);
				}
			});
			if(record!="no_record"){
				$(this_node.span.childNodes[1]).removeClass('loading');
			}
			console.log(tmp_str);
		}
	});
}
//POI 所有 [停車場,ATM,圖書館,日式豬排] 這四個使用而已
function select_poi_2(poi_name,record){
	if(all_markers[poi_name]!=null){
		for (var i = 0; i < all_markers[poi_name].length; i++) {   
			all_markers[poi_name][i].setMap(null);   
        }   
		all_markers[poi_name]=null;
		return;
	}
	if(record!="no_record"){
		var this_node;
		var sibling_node = $('#tree').fancytree('getTree').getSelectedNodes();
		sibling_node.forEach(function(sib_node) {
			if(sib_node.title=="所有"+poi_name){
				this_node=sib_node;
			}
		});
		$(this_node.span.childNodes[1]).addClass('loading');
		if(!$(this_node.span.childNodes[1]).hasClass('poi2')){
			$(this_node.span.childNodes[1]).addClass('poi2');
			$(this_node.span.childNodes[1]).attr('scenario_lat',new Number(map.getCenter().lat()).toFixed(4));
			$(this_node.span.childNodes[1]).attr('scenario_lng',new Number(map.getCenter().lng()).toFixed(4));
			$(this_node.span.childNodes[1]).attr('scenario_zoom',map.getZoom());
		}
	} 
	$.ajax({
		type : "POST",
		url : "realMap.do",
		async : false,
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
			if(record!="no_record"){
				all_markers[poi_name]=[];
			}
			if(json_obj.length>1000){
				if(confirm("搜尋資料量達"+json_obj.length+"筆\n是否繼續查詢?","確認繼續","取消")){}else{
					return;
			}}
			$.each(json_obj,function(i, item) {
				var  icon = json_obj[i].icon.length>3?json_obj[i].icon:false
				var marker = new google.maps.Marker({
				    position: json_obj[i].center,
				    title: json_obj[i].name,
				    map: map,
				    icon : icon
				});
				var tmp_table='<table class="info_window">'+
				'<tr><th colspan="2"># '+json_obj[i].type+'　#</th></tr>'+
				'<tr><td>名稱：</td><td>'+json_obj[i].name+'</td></tr>'+
				'<tr><td>地址：</td><td>'+json_obj[i].addr+'</td></tr>'+
				((json_obj[i].subtype!=null&&json_obj[i].subtype!='NULL')?'<tr><td>類型：</td><td>'+json_obj[i].subtype+'</td></tr>':"")+
				'</table>';
				var infowindow = new google.maps.InfoWindow({content:tmp_table});
				if(json_obj.length<30){
					google.maps.event.addListener(marker, "mouseover", function(event) { 
			        	infowindow.open(marker.get('map'), marker);
			        });
				}else{
					google.maps.event.addListener(marker, "click", function(event) { 
					    var infowindow_open = infowindow.getMap();
					    if(infowindow_open !== null && typeof infowindow_open !== "undefined"){
					    	infowindow.close();					    	
					    }else{
					    	infowindow.open(marker.get('map'), marker);
					    }
			        });
				}
				google.maps.event.addListener(marker, "mouseout", function(event) { 
		        	setTimeout(function () { infowindow.close(); }, 2000);
		        });
				if(record!="no_record"){
					all_markers[poi_name].push(marker);
				}
			});
			if(record!="no_record"){
				$(this_node.span.childNodes[1]).removeClass('loading');
			}
		}
	});
}
//畫BD
function select_BD(BD_name,record){
	
	if(all_BDs[BD_name]!=null){
		for (var i = 0; i < all_BDs[BD_name].length; i++) {   
			all_BDs[BD_name][i].setMap(null);   
        }   
		all_BDs[BD_name]=null;
		return;
	}
	if(record!="no_record"){
		var this_node;
		var sibling_node = $('#tree').fancytree('getTree').getSelectedNodes();
		sibling_node.forEach(function(sib_node) {
			if(sib_node.title==BD_name){
				this_node=sib_node;
			}
		});
		$(this_node.span.childNodes[1]).addClass('loading');
		if(!$(this_node.span.childNodes[1]).hasClass('BD')){
			$(this_node.span.childNodes[1]).addClass('BD');
		}
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
			var result_table = "";
			if(record!="no_record"){
				all_BDs[BD_name]=[];
			}
			$.each(json_obj,function(i, item) {
				if(record!="no_record"){
					map.panTo(new google.maps.LatLng(json_obj[i].lat,json_obj[i].lng));
					smoothZoom(map, 15, map.getZoom());
				} 
				var bermudaTriangle = new google.maps.Polygon({
					paths: json_obj[i].center,
					strokeColor: '#FF0000',
					strokeOpacity: 0.8,
					strokeWeight: 2,
					fillColor: '#FF0000',
					fillOpacity: 0.1
				});
				bermudaTriangle.setMap(map);
				var isChinaCity = ['天津市','瀋陽市','煙臺市','成都市','重慶市','武漢市','鄭州市','西安市','青島市','唐山市','濟南市'].indexOf(json_obj[i].city)!=-1;
				var tmp_table="";
				if(isChinaCity){
					$.ajax({
						type : "POST",
						url : "realMap.do",
						async : false,
						data : {
							action : "get_ChinaCity_Data",
							name : json_obj[i].city
						},success : function(result2) {
							var json_obj2 = $.parseJSON(result2);
							tmp_table='<table class="info_window">'+
								'<tr class="title"><th colspan="2"><br>'+json_obj[i].BD_name+'　</th></tr>'+
								'<tr><td align="right">城市：</td><td>' + json_obj[i].city + '</td></tr>'+
								'<tr><td align="right">商業營業面積：</td><td>' + json_obj[i].area + '</td></tr>'+
	                        	'<tr><td align="right">人流與顧客結構：</td><td>' + json_obj[i].population + '</td></tr>'+
	                        	'<tr><td align="right">市場地位：</td><td>' + json_obj[i].status + '</td></tr>'+
	                        	'<tr><td align="right">商業輻射範圍：</td><td>' + json_obj[i].radiation + '</td></tr>'+
	                        	'<tr><td align="right">商圈通達性：</td><td>' + json_obj[i].traffic + '</td></tr>'+
	                        	
	                        	'<tr class="title"><th colspan="2"><br>消費發展潛力</th></tr>'+
	                        	'<tr><td align="right">常住人口增長率：</td><td>' + (json_obj[i].resident == '' ? '-' : (json_obj[i].resident + ' %')) + '</td></tr>'+
	                        	'<tr><td align="right">人均可支配所得增長率：</td><td>' + (json_obj[i].income == '' ? '-' : (json_obj[i].income + ' %')) + '</td></tr>'+
	                        	'<tr class="title"><th colspan="2"><br>市場消費規模</th></tr>'+
	                        	'<tr><td align="right">人均可支配收入：</td><td>' + (json_obj[i].revenue == '' ? '-' : (json_obj[i].revenue + ' RMB/年')) + '</td></tr>'+
	                        	'<tr><td align="right">家庭人均消費支出：</td><td>' + (json_obj[i].expenditur == '' ? '-' : (json_obj[i].expenditur + ' RMB/年')) + '</td></tr>'+
	                        	'<tr><td colspan="2" >'+
	                        	"<a target='_blank' href=\"http://live.amcharts.com/" + json_obj2.link1 + "/embed/\">交通便利性</a>"+
	                        	"<a target='_blank' href=\"http://live.amcharts.com/" + json_obj2.link2 + "/embed/\">日均客流量(人次)</a>"+
	                        	"<a target='_blank' href=\"http://live.amcharts.com/" + json_obj2.link3 + "/embed/\">設施吸引力(家數)</a>"+
	                        	"<a target='_blank' href=\"http://live.amcharts.com/" + json_obj2.link4 + "/embed/\">設施吸引力(密度)</a>"+
	                        	'</td></tr>'+
	                        	'<tr class="title"><th colspan="2"><br>經營成本</th></tr>'+
	                            '<tr><td align="right">臨街平均租金：</td><td>' + (json_obj[i].nearstreet == '' ? '-' : (json_obj[i].nearstreet + ' RMB/平方米/月')) + '</td></tr>'+
	                            '<tr><td align="right">百貨商場平均租金：</td><td>' + (json_obj[i].dept_store == '' ? '-' : (json_obj[i].dept_store + ' RMB/平方米/月')) + '</td></tr>'+                 
	                            '<tr><td align="right">職工平均工資：</td><td>' + (json_obj[i].working_po == '' ? '-' : (json_obj[i].working_po + ' RMB/年')) + '</td></tr>'+
	                            '<tr><td align="right">五險一金：</td><td>' + (json_obj[i].risk_5 == '' ? '-' : (json_obj[i].risk_5 + ' %')) + '</td></tr>'+
	                            '<tr class="title"><th colspan="2"><br>業種業態組成</th></tr>'+
	                            '<tr><td colspan="2">'+
	                            "<a target='_blank' href=\"http://live.amcharts.com/" + json_obj2.link5 + "/embed/\">業種組成</a>"+
	                            "<a target='_blank' href=\"http://live.amcharts.com/" + json_obj2.link6 + "/embed/\">業態組成</a>"+
	                            '</td></tr>'+
	                            '<tr class="title"><th colspan="2"><br>商圈競爭狀況</th></tr>'+
	                            '<tr><td colspan="2">'+
	                            "<a target='_blank' href=\"http://live.amcharts.com/" + json_obj2.link7 + "/embed/\">競爭優勢-同業種店家數</a>"+
	                            "<a target='_blank' href=\"http://live.amcharts.com/" + json_obj2.link8 + "/embed/\">知名店家數</a>"+
	                            '</td></tr>'+
	                            '</table>';
						}
					});
				}else{
					tmp_table='<table class="info_window">'+
						'<tr><th colspan="2">'+json_obj[i].BD_name+'　</th></tr>'+
						(json_obj[i].city.length<2?"":'<tr><td>城市：</td><td>'+json_obj[i].city+'</td></tr>')+
						(json_obj[i].area.length<2?"":'<tr><td>面積：</td><td>'+json_obj[i].area+'</td></tr>')+
						(json_obj[i].population.length<2?"":'<tr><td>人流：</td><td>'+json_obj[i].population+'</td></tr>')+
						(json_obj[i].status.length<2?"":'<tr><td>地位：</td><td>'+json_obj[i].status+'</td></tr>')+
						(json_obj[i].radiation.length<2?"":'<tr><td>輻射：</td><td>'+json_obj[i].radiation+'</td></tr>')+
						(json_obj[i].traffic.length<2?"":'<tr><td>通達：</td><td>'+json_obj[i].traffic+'</td></tr>')+
						(json_obj[i].business_cost.length<2?"":'<tr><td>經營成本：</td><td>'+json_obj[i].business_cost+'</td></tr>')+
						'</table>';
				}
				var infowindow = new google.maps.InfoWindow({content:tmp_table});
		        var infoMarker = new google.maps.Marker({
		            position: new google.maps.LatLng(json_obj[i].lat,json_obj[i].lng),
		            icon: {
		                path: google.maps.SymbolPath.CIRCLE,
		                scale: 0
		            },
		            map: map
		        });
		        
		        var update_timeout = null;
				google.maps.event.addListener(bermudaTriangle, "click", function(event) { 
					 update_timeout = setTimeout(function(){
						if($("#region_select").length==0 && $("#env_analyse").length==0){
							infowindow.open(bermudaTriangle.get('map'), infoMarker);
							return;
						} 
						if(( ($("#env_analyse").length!=0&&$("#env_analyse").dialog("isOpen")) ||($("#env_analyse").length!=0&&$("#region_select").dialog("isOpen")) )&& $("#draw_circle").css("display")=="none"){
							google.maps.event.trigger(map, 'click',event);
						}else{
							infowindow.open(bermudaTriangle.get('map'), infoMarker);
						}
					}, 200);
					
		        });
				
				google.maps.event.addListener(bermudaTriangle, "dblclick", function(event) { 
					clearTimeout(update_timeout);
					infowindow.open(bermudaTriangle.get('map'), infoMarker);
		        });
				google.maps.event.addListener(infowindow, "closeclick", function () {
		            infoMarker.setMap(null);
		        });
				if(record!="no_record"){
					all_BDs[BD_name].push(bermudaTriangle);
				}
			});
			if(record!="no_record"){
				$(this_node.span.childNodes[1]).removeClass('loading');
			}
		}
	});
}

// 4.開放資源功能
function country_POLY_for_country_economy (year,type){
	panTo( 8.0, 112.0);
	smoothZoom(map, 4, map.getZoom());
	var polygen = country_polygen.pop();
	while(polygen != null){
		if (Wkt.isArray(polygen)) {
		       for (i in polygen) {
		           if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
		           	polygen[i].setMap(null);
		       }
		    }
		} else {
		   	polygen.setMap(null);
		}
		polygen = country_polygen.pop();
	}
	
	
	$.ajax({
		type : "POST",
		url : "countryEconomy.do",
		async : false,
		data : {
			action : "change_select",
			year : year,
			type : type
		},
		success : function(result) {
			var json_obj = $.parseJSON(result);
			var timer;
			$.each(json_obj,function(i, item) {
				var wkt = new Wkt.Wkt();
				wkt.read(json_obj[i].geom);
	            var config = {
	                fillColor: '#F0F0F0',
	                strokeColor: '#5C5C5C',
	                fillOpacity: 0.7,
	                strokeOpacity: 1,
	                strokeWeight: 1,
	            }
	            var _data = json_obj[i].economy_detail_statistic;
                switch (true) {
                    case +_data <= +TILE[0]:
                        config.fillColor = "#41A85F";
                        break;
                    case +_data > +TILE[0] && +_data <= +TILE[1]:
                        config.fillColor = "#8db444";
                        break;
                    case +_data > +TILE[1] && +_data <= +TILE[2]:
                        config.fillColor = "#FAC51C";
                        break;
                    case +_data > +TILE[2] && +_data <= +TILE[3]:
                        config.fillColor = "#d87926";
                        break;
                    case +_data > +TILE[3]:
                        config.fillColor = "#B8312F";
                        break;
                }
                var msg = "<table>"
                + "<tr><td align='center'>國家：</td><td align='center'>" + json_obj[i].country_name + "</td></tr>"
                + "<tr><td align='center'>" + $('#span_legend').text() + "：</td><td align='center'>" + json_obj[i].economy_detail_statistic + "</td></tr>"
                +"</table>";
                
	            var polygen = wkt.toObject(config);
	            if (Wkt.isArray(polygen)) {
	                for (i in polygen) {
	                    if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
	                    	polygen[i].setMap(map);
	                    	google.maps.event.addListener(polygen[i], 'mouseover', function () {
	                    		clearTimeout(timer);
	                    		detail_1.innerHTML = '<div style="width: 380px; height: 230px;">' + msg + '</div>';
	                    	});
	                    	google.maps.event.addListener(polygen[i], 'mouseout', function () {
	                    		timer = setTimeout(function(){ detail_1.innerHTML = ''; }, 1500);
	                    	});
	                    }
	                }
	            } else {
	            	polygen.setMap(map);
	            	google.maps.event.addListener(polygen, 'mouseover', function () {
                		clearTimeout(timer);
                		detail_1.innerHTML = '<div style="width: 380px; height: 230px;">' + msg + '</div>';
                	});
                	google.maps.event.addListener(polygen, 'mouseout', function () {
                		timer = setTimeout(function(){ detail_1.innerHTML = ''; }, 1500);
                	});
	            }
	            country_polygen.push(polygen);
			});
			
            $("#shpLegend").show();
            var _height = $('#shpLegend div').height();
            if (_height > 0) {
                $('#shpLegend').height(_height);
            }
		}
    });
}

function country_economy(node,type){
	if(!node.isSelected()){
	 	var polygen = country_polygen.pop();
	 	while(polygen != null){
	 		if (Wkt.isArray(polygen)) {
	 		       for (i in polygen) {
	 		           if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
	 		           	polygen[i].setMap(null);
	 		       }
	 		    }
	 		} else {
	 		   	polygen.setMap(null);
	 		}
	 		polygen = country_polygen.pop();
	 	}
	 	$("#shpLegend").hide();
	 	return;
	}

	if(!$(node.span.childNodes[1]).hasClass('diagrammap')){
		$(node.span.childNodes[1]).addClass('diagrammap');
	}
	var sibling_node = $('#tree').fancytree('getTree').getSelectedNodes();
	sibling_node.forEach(function(sib_node) {
		if($(sib_node.span).length>0){
			if($(sib_node.span.childNodes[1]).hasClass('diagrammap')){
				sib_node.setSelected(false);
			}
		}
	});
	node.setSelected(true);
	$(node.span.childNodes[1]).addClass('loading');
	$('#span_legend').text(node.title);
    $('#tr_year').show();
    $('#ddl_year').empty();
    var ddl_year = document.getElementById('ddl_year');
    var _select = document.createElement('select');
    ddl_year.appendChild(_select);
    if(window.scenario_record){scenario_record("參閱CountryEconomy資料",type);} 
	$.ajax({
		type : "POST",
		url : "countryEconomy.do",
		data : {
			action : "draw_shpLegend",
			type : type
		},
		success : function(msg) {
			
			if (msg !== undefined) {
                var arrMsg = msg.split('|');

                TILE = arrMsg[0].split(',');
                var MIN = arrMsg[1];
                var MAX = arrMsg[2];
                var UNIT = arrMsg[3];
                var YEAR = arrMsg[4].split(',');

                for (var i = 0; i < YEAR.length; i++) {
                    var option = document.createElement('option');
                    option.value = YEAR[i];
                    option.text = YEAR[i];
                    _select.appendChild(option);
                }
                $('#span_unit').text(UNIT);

                $('#span_level1').text(' ~ ' + TILE[0]);
                for (var i = 0; i < 4; i++) {
                    $('#span_level' + (i + 2)).text(TILE[i] + ' ~ ' + TILE[i + 1]);
                }
                $('#span_level5').text(TILE[3] + ' ~ ');
                country_POLY_for_country_economy(YEAR[0],type);
                _select.addEventListener('change', function () {
                	country_POLY_for_country_economy(_select.value,type);
                });
                $(node.span.childNodes[1]).removeClass('loading');
    			return;
            }
		}
	});
}

//5.國家功能
function country_POLY_for_countryData (year,type){
	panTo( 28.0, 130.0);
	smoothZoom(map, 2, map.getZoom());
	var polygen = country_polygen.pop();
	while(polygen != null){
		if (Wkt.isArray(polygen)) {
		       for (i in polygen) {
		           if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
		           	polygen[i].setMap(null);
		       }
		    }
		} else {
		   	polygen.setMap(null);
		}
		polygen = country_polygen.pop();
	}
	
	$.ajax({
		type : "POST",
		url : "countryData.do",
		async : false,
		data : {
			action : "change_select",
			year : year,
			type : type
		},
		success : function(result) {
			var json_obj = $.parseJSON(result);
			var timer;
			$.each(json_obj,function(i, item) {
				var wkt = new Wkt.Wkt();
				wkt.read(json_obj[i].geom);
	            var config = {
	                fillColor: '#F0F0F0',
	                strokeColor: '#5C5C5C',
	                fillOpacity: 0.7,
	                strokeOpacity: 1,
	                strokeWeight: 1,
	            }
	            var _data = json_obj[i].economy_detail_statistic;
	            
                switch (true) {
                    case +_data <= +TILE[0]:
                        config.fillColor = "#41A85F";
                        break;
                    case +_data > +TILE[0] && +_data <= +TILE[1]:
                        config.fillColor = "#8db444";
                        break;
                    case +_data > +TILE[1] && +_data <= +TILE[2]:
                        config.fillColor = "#FAC51C";
                        break;
                    case +_data > +TILE[2] && +_data <= +TILE[3]:
                        config.fillColor = "#d87926";
                        break;
                    case +_data > +TILE[3]:
                        config.fillColor = "#B8312F";
                        break;
                }
                var msg = "<table>"
                + "<tr><td align='center'>國家：</td><td align='center'>" + json_obj[i].country_name + "</td></tr>"
                + "<tr><td align='center'>"+ $('#span_legend').text() +"：</td><td align='center'>" + json_obj[i].economy_detail_statistic + "</td></tr>"
                +"</table>";
	            var polygen = wkt.toObject(config);
	            if (Wkt.isArray(polygen)) {
	                for (i in polygen) {
	                    if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
	                    	polygen[i].setMap(map);
	                    	google.maps.event.addListener(polygen[i], 'mouseover', function () {
	                    		clearTimeout(timer);
	                    		detail_1.innerHTML = '<div style="width: 380px; height: 230px;">' + msg + '</div>';
	                    	});
	                    	google.maps.event.addListener(polygen[i], 'mouseout', function () {
	                    		
	                    		timer = setTimeout(function(){ detail_1.innerHTML = ''; }, 1500);
	                    	});
	                    }
	                }
	            } else {
	            	polygen.setMap(map);
	            	google.maps.event.addListener(polygen, 'mouseover', function () {
                		clearTimeout(timer);
                		detail_1.innerHTML = '<div style="width: 380px; height: 230px;">' + msg + '</div>';
                	});
                	google.maps.event.addListener(polygen, 'mouseout', function () {
                		
                		timer = setTimeout(function(){ detail_1.innerHTML = ''; }, 1500);
                	});
	            }
	            country_polygen.push(polygen);
			});
			
            $("#shpLegend").show();
            var _height = $('#shpLegend div').height();
            if (_height > 0) {
                $('#shpLegend').height(_height);
            }
		}
    });
}

function countryData(node,type){//country_data
	if(!node.isSelected()){
	 	var polygen = country_polygen.pop();
	 	while(polygen != null){
	 		if (Wkt.isArray(polygen)) {
	 		       for (i in polygen) {
	 		           if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
	 		           	polygen[i].setMap(null);
	 		       }
	 		    }
	 		} else {
	 		   	polygen.setMap(null);
	 		}
	 		polygen = country_polygen.pop();
	 	}
	 	$("#shpLegend").hide();
	 	return;
	}

	if(!$(node.span.childNodes[1]).hasClass('diagrammap')){
		$(node.span.childNodes[1]).addClass('diagrammap');
	}
	var sibling_node = $('#tree').fancytree('getTree').getSelectedNodes();
	sibling_node.forEach(function(sib_node) {
		if($(sib_node.span).length>0){
			if($(sib_node.span.childNodes[1]).hasClass('diagrammap')){
				sib_node.setSelected(false);
			}
		}
	});
	node.setSelected(true);
	$(node.span.childNodes[1]).addClass('loading');
	$('#span_legend').text(node.title);
    $('#tr_year').show();
    $('#ddl_year').empty();
    var ddl_year = document.getElementById('ddl_year');
    var _select = document.createElement('select');
    ddl_year.appendChild(_select);
    if(window.scenario_record){scenario_record("參閱國家資料",type);} 
	$.ajax({
		type : "POST",
		url : "countryData.do",
		data : {
			action : "draw_shpLegend",
			type : type
		},
		success : function(msg) {
			if (msg !== undefined) {
                var arrMsg = msg.split('|');
                TILE = arrMsg[0].split(',');
                var MIN = arrMsg[1];
                var MAX = arrMsg[2];
                var UNIT = arrMsg[3];
                var YEAR = arrMsg[4].split(',');
                for (var i = 0; i < YEAR.length; i++) {
                    var option = document.createElement('option');
                    option.value = YEAR[i];
                    option.text = YEAR[i];
                    _select.appendChild(option);
                }
                $('#span_unit').text(UNIT);

                $('#span_level1').text(' ~ ' + TILE[0]);
                for (var i = 0; i < 4; i++) {
                    $('#span_level' + (i + 2)).text(TILE[i] + ' ~ ' + TILE[i + 1]);
                }
                $('#span_level5').text(TILE[3] + ' ~ ');
                country_POLY_for_countryData(YEAR[0],type);
                _select.addEventListener('change', function () {
                	country_POLY_for_countryData(_select.value,type);
                });
            }
			$(node.span.childNodes[1]).removeClass('loading');
		}
	});
}

//6.城市功能 
function country_POLY_for_chinaCity (type){//country_polygen
	panTo( 35.0, 100.0);
	smoothZoom(map, 4, map.getZoom());
	var polygen = country_polygen.pop();
	while(polygen != null){
		if (Wkt.isArray(polygen)) {
		       for (i in polygen) {
		           if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
		           	polygen[i].setMap(null);
		       }
		    }
		} else {
		   	polygen.setMap(null);
		}
		polygen = country_polygen.pop();
	}
	
	$.ajax({
		type : "POST",
		url : "chinaCity.do",
		async : false,
		data : {
			action : "change_select",
			//year : year,
			type : type
		},
		success : function(result) {
			var json_obj = $.parseJSON(result);
			var timer;
			$.each(json_obj,function(i, item) {
				var wkt = new Wkt.Wkt();
				wkt.read(json_obj[i].geom);
	            var config = {
	                fillColor: '#F0F0F0',
	                strokeColor: '#5C5C5C',
	                fillOpacity: 0.7,
	                strokeOpacity: 1,
	                strokeWeight: 1,
	            }
	            var _data = json_obj[i].data;
                switch (true) {
                    case +_data <= +TILE[0]:
                        config.fillColor = "#41A85F";
                        break;
                    case +_data > +TILE[0] && +_data <= +TILE[1]:
                        config.fillColor = "#8db444";
                        break;
                    case +_data > +TILE[1] && +_data <= +TILE[2]:
                        config.fillColor = "#FAC51C";
                        break;
                    case +_data > +TILE[2] && +_data <= +TILE[3]:
                        config.fillColor = "#d87926";
                        break;
                    case +_data > +TILE[3]:
                        config.fillColor = "#B8312F";
                        break;
                }
                var msg = "<table>"
                	+ "<tr><td align='center'>國家：</td><td align='center'>" + json_obj[i].country_name + "</td></tr>"
                	+ "<tr><td align='center'>"+ $('#span_legend').text() +"：</td><td align='center'>" + json_obj[i].data + "</td></tr>"
                	+"</table>";
	            var polygen = wkt.toObject(config);
	            if (Wkt.isArray(polygen)) {
	                for (i in polygen) {
	                    if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
	                    	polygen[i].setMap(map);
	                    }
	                }
	            } else {
	            	polygen.setMap(map);
	            	google.maps.event.addListener(polygen, 'mouseover', function () {
                		clearTimeout(timer);
                		detail_1.innerHTML = '<div style="width: 380px; height: 230px;">' + msg + '</div>';
                	});
                	google.maps.event.addListener(polygen, 'mouseout', function () {
                		
                		timer = setTimeout(function(){ detail_1.innerHTML = ''; }, 1500);
                	});
	            }
				
	            country_polygen.push(polygen);
			});
			
            $("#shpLegend").show();
            var _height = $('#shpLegend div').height();
            if (_height > 0) {
                $('#shpLegend').height(_height);
            }
		}
    });
}

function chinaCity(node,type){//chinaCity
	if(!node.isSelected()){
	 	var polygen = country_polygen.pop();
	 	while(polygen != null){
	 		if (Wkt.isArray(polygen)) {
	 		       for (i in polygen) {
	 		           if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
	 		           	polygen[i].setMap(null);
	 		       }
	 		    }
	 		} else {
	 		   	polygen.setMap(null);
	 		}
	 		polygen = country_polygen.pop();
	 	}
	 	$("#shpLegend").hide();
	 	return;
	}

	if(!$(node.span.childNodes[1]).hasClass('diagrammap')){
		$(node.span.childNodes[1]).addClass('diagrammap');
	}
	var sibling_node = $('#tree').fancytree('getTree').getSelectedNodes();
	sibling_node.forEach(function(sib_node) {
		if($(sib_node.span).length>0){
			if($(sib_node.span.childNodes[1]).hasClass('diagrammap')){
				sib_node.setSelected(false);
			}
		}
	});
	node.setSelected(true);
	if(window.scenario_record){scenario_record("參閱城市資料",type);} 
	$(node.span.childNodes[1]).addClass('loading');
	$('#span_legend').text(node.title);
    $('#tr_year').hide();
	$.ajax({
		type : "POST",
		url : "chinaCity.do",
		data : {
			action : "draw_shpLegend",
			type : type
		},
		success : function(msg) {
			
			if (msg !== undefined) {
                var arrMsg = msg.split('|');
                TILE = arrMsg[0].split(',');
                var MIN = arrMsg[1];
                var MAX = arrMsg[2];
                var UNIT = arrMsg[3];
                $('#span_unit').text(UNIT);

                $('#span_level1').text(' ~ ' + TILE[0]);
                for (var i = 0; i < 4; i++) {
                    $('#span_level' + (i + 2)).text(TILE[i] + ' ~ ' + TILE[i + 1]);
                }
                $('#span_level5').text(TILE[3] + ' ~ ');
                country_POLY_for_chinaCity(type);
            }
			$(node.span.childNodes[1]).removeClass('loading');
		}
	});
	
}
//7.商圈中熱力圖  
function country_POLY_for_heatMap (type){
	var polygen = country_polygen.pop();
	while(polygen != null){
		if (Wkt.isArray(polygen)) {
		       for (i in polygen) {
		           if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
		           	polygen[i].setMap(null);
		       }
		    }
		} else {
		   	polygen.setMap(null);
		}
		polygen = country_polygen.pop();
	}
	
	
	$.ajax({
		type : "POST",
		url : "heatMap.do",
		async : false,
		data : {
			action : "change_select",
			type : type
		},
		success : function(result) {
			var json_obj = $.parseJSON(result);
			$.each(json_obj,function(i, item) {
				var wkt = new Wkt.Wkt();
				wkt.read(json_obj[i].geom);
	            var config = {
	                fillColor: '#F0F0F0',
	                strokeColor: '#5C5C5C',
	                fillOpacity: 0.7,
	                strokeOpacity: 1,
	                strokeWeight: 1,
	            }
	            var _data = json_obj[i].data;
              switch (true) {
                  case +_data <= +TILE[1]:
                      config.fillColor = "#41A85F";
                      break;
                  case +_data > +TILE[1] && +_data <= +TILE[2]:
                      config.fillColor = "#8db444";
                      break;
                  case +_data > +TILE[2] && +_data <= +TILE[3]:
                      config.fillColor = "#FAC51C";
                      break;
                  case +_data > +TILE[3] && +_data <= +TILE[4]:
                      config.fillColor = "#d87926";
                      break;
                  case +_data > +TILE[4]:
                      config.fillColor = "#B8312F";
                      break;
              }
	            var polygen = wkt.toObject(config);
	            if (Wkt.isArray(polygen)) {
	                for (i in polygen) {
	                    if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
	                    	polygen[i].setMap(map);
	                    }
	                }
	            } else {
	            	polygen.setMap(map);
	            }
				
	            country_polygen.push(polygen);
			});
			
          $("#shpLegend").show();
          var _height = $('#shpLegend div').height();
          if (_height > 0) {
              $('#shpLegend').height(_height);
          }
		}
  });
}

function heatMap(node,type){
	if(!node.isSelected()){
	 	var polygen = country_polygen.pop();
	 	while(polygen != null){
	 		if (Wkt.isArray(polygen)) {
	 		       for (i in polygen) {
	 		           if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
	 		           	polygen[i].setMap(null);
	 		       }
	 		    }
	 		} else {
	 		   	polygen.setMap(null);
	 		}
	 		polygen = country_polygen.pop();
	 	}
	 	$("#shpLegend").hide();
	 	return;
	}
	if(!$(node.span.childNodes[1]).hasClass('heatmap')){
		$(node.span.childNodes[1]).addClass('heatmap');
	}
	var sibling_node = $('#tree').fancytree('getTree').getSelectedNodes();
	sibling_node.forEach(function(sib_node) {
		if($(sib_node.span).length>0){
			if($(sib_node.span.childNodes[1]).hasClass('heatmap')){
				sib_node.setSelected(false);
			}
		}
	});
	node.setSelected(true);
	$(node.span.childNodes[1]).addClass('loading');
	$('#span_legend').text(node.title);
	$('#tr_year').hide();
	if(window.scenario_record){scenario_record("參閱熱力圖資料",type);} 
	$.ajax({
		type : "POST",
		url : "heatMap.do",
		data : {
			action : "draw_shpLegend",
			type : type
		},
		success : function(msg) {
			if (msg !== undefined) {
              var arrMsg = msg.split('|');
              TILE = arrMsg[0].split(',');
              var UNIT = arrMsg[3];
              $('#span_unit').text("數量");
              for (var i = 0; i < 5; i++) {
                  $('#span_level' + (i + 1)).text(TILE[i] + ' ~ ' + TILE[i + 1]);
              }
              country_POLY_for_heatMap(type);
          }
			$(node.span.childNodes[1]).removeClass('loading');
		}
	});
	
}

//8.城市整體概況[那11個城市各別用到而已]
function country_POLY_for_city (node,city_name){
	if(!node.isSelected()){
		var polygen = chinaCities[city_name].pop();
		while(polygen != null){
			if (Wkt.isArray(polygen)) {
			       for (i in polygen) {
			           if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
			           	polygen[i].setMap(null);
			       }
			    }
			} else {
			   	polygen.setMap(null);
			}
			polygen = chinaCities[city_name].pop();
		}
	 	return;
	}
	$(node.span.childNodes[1]).addClass('loading');
	if(window.scenario_record){scenario_record("參閱中國省份資料",city_name);} 
	$.ajax({
		type : "POST",
		url : "chinaprovincial.do",
		data : {
			action : "selectall_SHP_City",
			city :  city_name
		},
		success : function(result) {

			var json_obj = $.parseJSON(result);
			$.each(json_obj,function(i, item) {
				var wkt = new Wkt.Wkt();
				wkt.read(json_obj[i].geom);
				var config = {
                    fillColor: '#7092BE',
                    strokeColor: '#3F48CC',
                    fillOpacity: 0.5,
                    strokeOpacity: 1,
                    strokeWeight: 1,
                }
	            
	            var polygen = wkt.toObject(config);
	            if (Wkt.isArray(polygen)) {
	                for (i in polygen) {
	                    if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
	                    	polygen[i].setMap(map);
	                    }
	                }
	            } else {
	            	polygen.setMap(map);
	            }
	            chinaCities[city_name]=[];
	            chinaCities[city_name].push(polygen);
	            
	            var tmp_table='<table class="info_window">'+
				'<tr><th colspan="2">'+json_obj[i].country_name+'　</th></tr>'+
				(json_obj[i].living==null?"":'<tr><td>常住人口：</td><td>'+json_obj[i].living+'萬人</td></tr>')+
				(json_obj[i].household==null?"":'<tr><td>戶籍人口：</td><td>'+json_obj[i].household+'萬人</td></tr>')+
				(json_obj[i].male==null?"":'<tr><td>男性：</td><td>'+json_obj[i].male+'%</td></tr>')+
				(json_obj[i].female==null?"":'<tr><td>女性：</td><td>'+json_obj[i].female+'%</td></tr>')+
				'</table>';
				
				var infowindow = new google.maps.InfoWindow({content:tmp_table});
		        var infoMarker = new google.maps.Marker({
		            position: new google.maps.LatLng(json_obj[i].cY,json_obj[i].cX),
		            icon: {
		                path: google.maps.SymbolPath.CIRCLE,
		                scale: 0
		            },
		            map: map
		        });
				google.maps.event.addListener(polygen, "click", function(event) { 
		        	infowindow.open(polygen.get('map'), infoMarker);
		        });
				google.maps.event.addListener(infowindow, "closeclick", function () {
		            infoMarker.setMap(null);
		        });
			});
			$(node.span.childNodes[1]).removeClass('loading');
		}
    });
}

//9. 人口結構資料*3 + 畫圓餅圖
function draw_population_data(node,type){
	if(!node.isSelected()){
		if (population_Markers) {
            for (i in population_Markers) {
            	population_Markers[i].setMap(null);
            }
            population_Markers.length = 0;
        }
		return ;
	}
	if(!$(node.span.childNodes[1]).hasClass('populationData')){
		$(node.span.childNodes[1]).addClass('populationData');
	}
	var sibling_node = $('#tree').fancytree('getTree').getSelectedNodes();
	sibling_node.forEach(function(sib_node) {
		if($(sib_node.span).length>0){
			if($(sib_node.span.childNodes[1]).hasClass('populationData')){
				sib_node.setSelected(false);
			}
		}
	});
	node.setSelected(true);
	$(node.span.childNodes[1]).addClass('loading');
	
	if (population_Markers) {
        for (i in population_Markers) {
        	population_Markers[i].setMap(null);
        }
        population_Markers.length = 0;
    }
	if(window.scenario_record){scenario_record("人口資料",type);} 
	if(type=="Gender"){
		$.ajax({
			type : "POST",
			url : "populationData.do",
			data : {
				action : "selectall_Statistics_Gender"
			},success : function(result) {
				var json_obj = $.parseJSON(result);
				$.each(json_obj,function(i, item) {
					SetPieTwoMarker(json_obj[i].country_name, json_obj[i].lat, json_obj[i].lng, json_obj[i].data1, json_obj[i].data2, "男性", "女性", "性別人口數");
				});
				$(node.span.childNodes[1]).removeClass('loading');
			}
		});
	}else if (type=="Countryage"){
		$.ajax({
			type : "POST",
			url : "populationData.do",
			data : {
				action : "selectall_Statistics_Countryage"
			},success : function(result) {
				var json_obj = $.parseJSON(result);
				$.each(json_obj,function(i, item) {
					SetAgeMarker(json_obj[i].country_name, json_obj[i].lat, json_obj[i].lng, json_obj[i].data1, json_obj[i].data2,json_obj[i].data3);
				});
				$(node.span.childNodes[1]).removeClass('loading');
			}
		});
	}else if (type=="CountryLaborForce"){
		$.ajax({
			type : "POST",
			url : "populationData.do",
			data : {
				action : "selectall_Statistics_CountryLaborForce"
			},success : function(result) {
				var json_obj = $.parseJSON(result);
				$.each(json_obj,function(i, item) {
					SetPieTwoMarker(json_obj[i].country_name, json_obj[i].lat, json_obj[i].lng, json_obj[i].data1, json_obj[i].data2, "男性", "女性", "性別就業人數");
				});
				$(node.span.childNodes[1]).removeClass('loading');
			}
		});
	}
}

function SetPieTwoMarker(country, lat, lng, data1, data2, data1_desc, data2_desc, type) {
    var LatLng = new google.maps.LatLng(lat, lng);

    var data1_percent = (data1 - 0) / ((data1 - 0) + (data2 - 0));
    var data2_percent = (data2 - 0) / ((data1 - 0) + (data2 - 0));

    var image = {
        url: "http://chart.apis.google.com/chart?cht=p&chbh=a&chco=0000ff&chd=t:" + data1_percent + "," + data2_percent + "&chs=50x50&chf=bg,s,ffffff00",
        size: new google.maps.Size(150, 70),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(0, 0)
    };
    var marker = new google.maps.Marker({
        position: LatLng,
        map: map,
        icon: image,
        title: country
    });

    if (data1 == null)
        data1 = "";
    else
        data1 = data1 - 0;
    if (data2 == null)
        data2 = "";
    else
        data2 = data2 - 0;

    var msg = "<table><caption>" + type + " (" + country + ")</caption>"
            + "<tr><td align='center'>" + data1_desc + "</td><td align='center'>"+data2_desc +"</td></tr>"
            + "<tr><td align='center'>" + data1 + "</td><td align='center'>" + data2 + "</td></tr></table>";

    SetMarkerAttribute(marker, country, LatLng, msg);

    population_Markers.push(marker);
}
function SetMarkerAttribute(marker, city, LatLng, msg) {
    var infowindow = new google.maps.InfoWindow({
        content: '<div style="width: 320px; height: 230px;">' + city + "</br></br>" + msg + '</div>',
        position: LatLng
    });

    google.maps.event.addListener(marker, 'mouseover', function () {
        detail_1.innerHTML = '<div style="width: 320px; height: 230px;">' + msg + '</div>';
    });
    google.maps.event.addListener(marker, 'mouseout', function () {
        detail_1.innerHTML = '';
    });
}

function SetAgeMarker(country, lat, lng, under14, between1564, up65) {
    var LatLng = new google.maps.LatLng(lat, lng);

    var total = (under14 - 0) + (between1564 - 0) + (up65 - 0);
    var percent_14 = (under14 - 0) / total;
    var percent_1564 = (between1564 - 0) / total;
    var percent_65 = (up65 - 0) / total;

    var image = {
        url: "http://chart.apis.google.com/chart?cht=p&chbh=a&chco=0000ff&chd=t:" + percent_14 + "," + percent_1564 + "," + percent_65 + "&chs=150x65&chl=14↓|15-64|65↑&chf=bg,s,ffffff00",
        size: new google.maps.Size(150, 70),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(0, 0)
    };
    var marker = new google.maps.Marker({
        position: LatLng,
        map: map,
        icon: image,
        title: country
    });

    var msg = "<table><caption>年齡人口數 (" + country + ")</caption>"
            + "<tr><td align='center'>未滿14歲</td><td align='center'>15-64歲</td><td align='center'>高於65歲</td></tr>"
            + "<tr><td align='center'>" + under14 + "</td><td align='center'>" + between1564 + "</td><td align='center'>" + up65 + "</td></tr></table>";
    SetMarkerAttribute(marker, country, LatLng, msg);
    population_Markers.push(marker);
}

//10.中國省份行政分界 
function country_POLY_for_chinaProvincial(node){
	if(!node.isSelected()){
		var polygen = chinaProvincial.pop();
		while(polygen != null){
			if (Wkt.isArray(polygen)) {
			       for (i in polygen) {
			           if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
			           	polygen[i].setMap(null);
			       }
			    }
			} else {
			   	polygen.setMap(null);
			}
			polygen = chinaProvincial.pop();
		}
		return ;
	}
	if(window.scenario_record){scenario_record("中國行政區劃分","畫");} 
	$(node.span.childNodes[1]).addClass('loading');
	$.ajax({
		type : "POST",
		url : "chinaprovincial.do",
		data : {
			action : "selectall_SHP_ChinaProvincial",
		},
		success : function(result) {
			panTo( 35.99498458547868,97.060791015625 );smoothZoom(map, 4, map.getZoom());
			var json_obj = $.parseJSON(result);
			$.each(json_obj,function(i, item) {
				var wkt = new Wkt.Wkt();
				wkt.read(json_obj[i].geom);
				var config = {
                    fillColor: '#7092BE',
                    strokeColor: '#3F48CC',
                    fillOpacity: 0.5,
                    strokeOpacity: 1,
                    strokeWeight: 1,
                }
	            var polygen = wkt.toObject(config);
				if (Wkt.isArray(polygen)) {
	                for (i in polygen) {
	                    if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
	                    	polygen[i].setMap(map);
	                    }
	                }
	            } else {
	            	polygen.setMap(map);
	            }
				chinaProvincial.push(polygen);
			});
			$(node.span.childNodes[1]).removeClass('loading');
		}
	});
}
//11大麥克 
function bigmac(node){
	
	if(!node.isSelected()){
	 	var polygen = country_polygen.pop();
	 	while(polygen != null){
	 		if (Wkt.isArray(polygen)) {
	 		       for (i in polygen) {
	 		           if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
	 		           	polygen[i].setMap(null);
	 		       }
	 		    }
	 		} else {
	 		   	polygen.setMap(null);
	 		}
	 		polygen = country_polygen.pop();
	 	}
	 	$("#shpLegend").hide();
	 	return;
	}
	
	panTo( 28.0, 130.0);
	smoothZoom(map, 2, map.getZoom());
 	var polygen = country_polygen.pop();
 	while(polygen != null){
 		if (Wkt.isArray(polygen)) {
 		       for (i in polygen) {
 		           if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
 		           	polygen[i].setMap(null);
 		       }
 		    }
 		} else {
 		   	polygen.setMap(null);
 		}
 		polygen = country_polygen.pop();
 	}
 	$("#shpLegend").hide();
	
	if(!$(node.span.childNodes[1]).hasClass('diagrammap')){
		$(node.span.childNodes[1]).addClass('diagrammap');
	}
	var sibling_node = $('#tree').fancytree('getTree').getSelectedNodes();
	sibling_node.forEach(function(sib_node) {
		if($(sib_node.span).length>0){
			if($(sib_node.span.childNodes[1]).hasClass('diagrammap')){
				sib_node.setSelected(false);
			}
		}
	});
	node.setSelected(true);
	$(node.span.childNodes[1]).addClass('loading');
	if(window.scenario_record){scenario_record("大麥克指數","");} 
	$.ajax({
		type : "POST",
		url : "countryData.do",
		async : false,
		data : {
			action : "bigmac_select",
		},
		success : function(result) {
			var json_obj = $.parseJSON(result);
			var TILE = [];
			var mac_price_array=[];
			var timer;
			$.each(json_obj,function(i, item) {
				mac_price_array.push(+json_obj[i].price);
			});
			mac_price_array.sort();
			for(var i=0;i<4;i++){
				TILE[i]=+mac_price_array[Math.round(mac_price_array.length/5)*(i+1)];
			}
			 $('#span_level1').text(' ~ ' + TILE[0]);
             for (var i = 0; i < 4; i++) {
                 $('#span_level' + (i + 2)).text(TILE[i] + ' ~ ' + TILE[i + 1]);
             }
             $('#span_level5').text(TILE[3] + ' ~ ');
             $('#span_legend').text("大麥克指數");
             $('#span_unit').text("大麥克售價比");
             $('#tr_year').hide();
             
			$.each(json_obj,function(i, item) {
				var wkt = new Wkt.Wkt();
				wkt.read(json_obj[i].geom);
	            var config = {
	            	fillColor: ("hsla(" + Math.floor(Math.random()*360) + ", 85%, 50%, 0.8)"),
	                strokeColor: '#5C5C5C',
	                fillOpacity: 0.7,
	                strokeOpacity: 1,
	                strokeWeight: 1,
	            }
	            var _data = json_obj[i].price;
	            switch (true) {
	                case +_data <= +TILE[0]:
	                    config.fillColor = "#41A85F";
	                    break;
	                case +_data > +TILE[0] && +_data <= +TILE[1]:
	                    config.fillColor = "#8db444";
	                    break;
	                case +_data > +TILE[1] && +_data <= +TILE[2]:
	                    config.fillColor = "#FAC51C";
	                    break;
	                case +_data > +TILE[2] && +_data <= +TILE[3]:
	                    config.fillColor = "#d87926";
	                    break;
	                case +_data > +TILE[3]:
	                    config.fillColor = "#B8312F";
	                    break;
	            }
	            
	            
	            var msg = "<table><caption>大麥克指數 (" + json_obj[i].country_name + ")</caption>"
	            + "<tr><td align='center'>大麥克售價：</td><td align='center'>" + json_obj[i].price + "</td></tr>"
	            + "<tr><td align='center'>高/低估比率：</td><td align='center'>" + json_obj[i].rawIndex + "</td></tr>"
	            + "<tr><td align='center'>實際匯率：</td><td align='center'>" + json_obj[i].actualExchangeRate + "</td></tr>"
	            + "<tr><td align='center'>隱含匯率：</td><td align='center'>" + json_obj[i].impliedExchangeRate + "</td></tr>"
	            +"</table>";
	            var polygen = wkt.toObject(config);
	            if (Wkt.isArray(polygen)) {
	                for (i in polygen) {
	                    if (polygen.hasOwnProperty(i) && !Wkt.isArray(polygen[i])) {
	                    	polygen[i].setMap(map);
	                    	
	                    	google.maps.event.addListener(polygen[i], 'mouseover', function () {
	                    		clearTimeout(timer);
	        	                detail_1.innerHTML = '<div style="width: 320px; height: 230px;">' + msg + '</div>';
	        	            });
	        	            google.maps.event.addListener(polygen[i], 'mouseout', function () {
	        	                
	        	            	timer = setTimeout(function(){ detail_1.innerHTML = ''; }, 1500);
	        	            });
	                    }
	                }
	            } else {
	            	google.maps.event.addListener(polygen, 'mouseover', function () {
    	                detail_1.innerHTML = '<div style="width: 320px; height: 230px;">' + msg + '</div>';
    	            });
    	            google.maps.event.addListener(polygen, 'mouseout', function () {
    	                detail_1.innerHTML = '';
    	            });
	            	polygen.setMap(map);
	            }
	            country_polygen.push(polygen);
			});
			$("#shpLegend").show();
	        $(node.span.childNodes[1]).removeClass('loading');
		}
	});
}

//12.帶出區位選擇結果
function draw_region_select(polydiagram){
	var json_obj = eval(polydiagram);
	$.each(json_obj[12],function(i, item) {
		var BD_name=item['City'].replace("商圈","")+"商圈";
    	if(item['City']=="新板"){BD_name="新板特區商圈";}		$.ajax({
    		type : "POST",
    		url : "realMap.do",
    		async : false,
    		data : {
    			action : "select_BD",
    			name : BD_name
    		},
    		success : function(result) {
    			var json_obj = $.parseJSON(result);
    			var timer;
    			$.each(json_obj,function(j, item) {
    				var infowindow = new google.maps.InfoWindow({content: ("<div style='padding:6px;'>區位選擇 - 第"+(i+1)+"名<br><a style='font-size:16px;'>"+BD_name+"</a></div>")});
	    			var bermudaTriangle = new google.maps.Polygon({
						paths: json_obj[j].center,
						strokeColor: '#FF0000',
						strokeOpacity: 0.8,
						strokeWeight: 2,
						fillColor: '#FF0000',
						fillOpacity: 0.1
					});
					bermudaTriangle.setMap(map);
					var marker = new google.maps.Marker({
					    position: new google.maps.LatLng( json_obj[j].lat, json_obj[j].lng),//; .lat,
						label : (i+1+""),
					    title: json_obj[j].BD_name,
					    map: map
					});
					google.maps.event.addListener(marker, "mouseover", function(event) { 
				    	infowindow.open(map, marker);
				    	clearTimeout(timer);
				    });
					google.maps.event.addListener(marker, "mouseout", function(event) { 
				    	timer = setTimeout(function () { infowindow.close(); }, 1500);
				    });
					google.maps.event.addListener(infowindow, "closeclick", function(event) { 
						marker.setMap(null);
						bermudaTriangle.setMap(null);
						infowindow.setMap(null);
				    });
					google.maps.event.addListener(bermudaTriangle, "click", function(event) { 
						if($("#region_select").length==0 && $("#env_analyse").length==0){
							return;
						} 
						if(( ($("#env_analyse").length!=0&&$("#env_analyse").dialog("isOpen")) ||($("#env_analyse").length!=0&&$("#region_select").dialog("isOpen")) )&& $("#draw_circle").css("display")=="none"){
							google.maps.event.trigger(map, 'click',event);
						}
					});
    			});
    		}
		});
	});
}
//13.帶出環域分析結果
function draw_env_analyse(points){
	var json_obj = eval(points);
	$.each(json_obj,function(i, item) {
		var order = item[0].replace("點","");
		var google_latlng = new google.maps.LatLng( item[1], item[2]);
		var infowindow ;
		var rs_marker ;
		var rs_circle ; 
		var timer ;
//		infowindow = new google.maps.InfoWindow({content: ("<div style='padding:10px;'><table><tr><td>環域分析 - 點"+order+"<br>時速："+item[4]+"<br>時間："+item[5]+"</td><td><img src='./refer_data/delete.png' class='func' style='height:22px;' onclick='rs_marker.setMap(null);rs_circle.setMap(null);infowindow.setMap(null);alert();'></td></tr></div>")});
		infowindow = new google.maps.InfoWindow({content: ("<div style='padding:6px;'>環域分析 - 點"+order+"<br>時速："+item[4]+"<br>時間："+item[5]+"</div>")});
		rs_marker = new google.maps.Marker({
		    position: google_latlng,
		    animation: google.maps.Animation.DROP,
		    icon: 'http://maps.google.com/mapfiles/kml/paddle/' + order + '.png',
		    map: map,
		    draggable:true,
		    title: ("--分析點"+order+"--")
		});
		rs_circle = new google.maps.Circle({
			  strokeColor: '#FF0000',
			  strokeOpacity: 0.5,
			  strokeWeight: 2,
			  fillColor: '#FF8700',
			  fillOpacity: 0.2,
			  map: map,
			  center: google_latlng,
			  radius: parseInt(item[3].replace("m",""),10)
		});
		google.maps.event.addListener(rs_marker, "mouseover", function(event) { 
	    	infowindow.open(map, rs_marker);
	    	clearTimeout(timer);
	    });
		google.maps.event.addListener(rs_marker, "mouseout", function(event) { 
	    	timer = setTimeout(function () { infowindow.close(); }, 1500);
	    });
		google.maps.event.addListener(infowindow, "closeclick", function(event) { 
			rs_marker.setMap(null);
			rs_circle.setMap(null);
			infowindow.setMap(null);
	    });
		google.maps.event.addListener(rs_circle, "click", function(event) { 
			if($("#region_select").length==0 && $("#env_analyse").length==0){
				return;
			} 
			if(( ($("#env_analyse").length!=0&&$("#env_analyse").dialog("isOpen")) ||($("#env_analyse").length!=0&&$("#region_select").dialog("isOpen")) )&& $("#draw_circle").css("display")=="none"){
				google.maps.event.trigger(map, 'click',event);
			}
		});
	});
	return ;
}