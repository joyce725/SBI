if(!window.action){
	var action={};
}
if(!window.have_visited){
	var have_visited={};
}

function draw_menu_of_poi(parameter){
	$.ajax({
		type : "POST",
		url : "realMap.do",
		//async : false,
		data : parameter,
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
			    			$("#warning").html("為了提供您更好的使用品質，該功能維護中。");
			    			$("#warning").dialog("open");
			    			node.setSelected(false);
			    		}
			    		eval(action[data.node.key]);
				    	
				    }else{
				    	if(have_visited[node.key]==null && $("#scenario_controller").length==0){
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
				},init: function(event, data, flag) {
					$("#panel").show();
			    }
			}).on("mouseover", ".fancytree-title", function(event){
			    var pdf_layer=["19","20","21","22","23","24","25","26","27","28","29","31","32","33","34","35","42","44","46","48"];
			    var node = $.ui.fancytree.getNode(event);
			    if(pdf_layer.indexOf(node.key)!=-1){
			    	//$('#pdf_layer').children().html('<div onclick=\'window.open(\"http://61.218.8.51/SBI/pdf/'+$("#ftal_"+node.key).text().replace('商圈','')+'.pdf\", \"_blank\");\'> '+$("#ftal_"+node.key).text().replace('商圈','')+"電子書"+'</div>');
			    	$('#pdf_layer').children().html('<div onclick=\'window.open(\"./uploaddoc.do?action=download_ebook&ebook_name='
			    			+$("#ftal_"+node.key).text().replace('商圈','')+'\", \"_blank\");\'> '
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
}

function hidecheckbox(json){
	var i=0;
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
