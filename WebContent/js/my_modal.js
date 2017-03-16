var cache_modal = [];

function do_modal(){
	if(cache_modal.length>0){
		eval(cache_modal.shift());
	}
}

function run_no_modal(this_eval_str){
	eval(this_eval_str);
	if(cache_modal.length>0){
		var eval_str = cache_modal.shift();
		var delay_time=0;
		
		while(eval_str.length<2 && eval_str!=null){
			delay_time += 500;
			eval_str = cache_modal.shift();
		}
		setTimeout(function(){
			eval(eval_str);
		},delay_time);
	}
}

function run_modal(element_name,message,click_to_over,pervent_trigger){
	if($("#"+element_name+"_tmp").length!=0){return;}
	
	
// 	$("body").append('<div class="jquery-modal blocker current"></div>');
	//$(element_name).css("z-index","200");
	//alert(element_name);
	//alert($(element_name).html());
	//return ; 
	var clone_element = $("#"+element_name).clone();
	clone_element.attr('id', element_name+"_tmp");
	$("#"+element_name).after('<div class="jquery-modal my_blocker current" id="platform"></div>');
	$("#platform").html(clone_element);
	$("#platform").append("<div id='modal_explanation' class='my_modal my_modal_explanation' style=''>"+message+"</div>");
	var modal_explanation = $("#modal_explanation");
	if($('html').width()-$("#"+element_name).offset().left>120){
		if(parseInt($("#"+element_name).offset().top)>$('html').height()*0.8){
			modal_explanation.css("bottom",20);
		}else{
			modal_explanation.css("top",parseInt($("#"+element_name).offset().top)-parseInt($("#modal_explanation").css("height"))*0.5+18);
		}
		modal_explanation.css("left",(parseInt($("#"+element_name).offset().left)+20+(parseInt($("#"+element_name).css("width"))>$('html').width()*0.5?300:parseInt($("#"+element_name).css("width")))));
		//alert((parseInt($("#"+element_name).offset().left)+20+parseInt($("#"+element_name).css("width"))));
		if(parseInt($("#"+element_name).css("width"))>$('html').width()*0.5){
			modal_explanation.css("background-color","indianred");
		}
		
	}else{
		if(parseInt($("#"+element_name).offset().top)>$('html').height()*0.8){
			modal_explanation.css("bottom",16);
		}else{
			modal_explanation.css("top",parseInt($("#"+element_name).offset().top)-parseInt($("#modal_explanation").css("height"))*0.5+18);
		}
		modal_explanation.css("left",$("#"+element_name).offset().left-200);
	}
	//這邊是美工 先放棄
// 	if( Math.abs($('html').width()-$("#"+element_name).offset().left*2)
// 			<Math.abs($('html').height()-$("#"+element_name).offset().top*2) ){
// 		//高取向
// 		if($('html').height()>$("#"+element_name).offset().top*2){
// 			modal_explanation.css("top",$("#"+element_name).offset().top+$('html').height()*0.5);
// 			modal_explanation.css("left",$('html').width()*0.5);
// 		}else{
// 			modal_explanation.css("top",$("#"+element_name).offset().top-$('html').height()*0.5);
// 			modal_explanation.css("left",$('html').width()*0.5);
// 		}
// 	}else{
// 		//寬取向
// 		if($('html').width()>$("#"+element_name).offset().left*2){
// 			modal_explanation.css("top",$('html').height()*0.5);
// 			modal_explanation.css("left",$("#"+element_name).offset().left+$('html').width()*0.5);
// 		}else{
// 			modal_explanation.css("top",$('html').height()*0.5);
// 			modal_explanation.css("left",$("#"+element_name).offset().left-$('html').width()*0.5);
// 		}
// 	}
	
	
 	clone_element.attr('class',(clone_element.attr('class')==null?"":clone_element.attr('class'))+' my_modal');
	
// 	clone_element.attr('id', "return"+2).appendTo(".jquery-modal");
// alert($("#"+element_name).css("background-color"));
// alert($("#"+element_name).css("background-color")==null);
 	
	if($("#"+element_name).css("background-color")=="transparent" || $("#"+element_name).css("background-color") == "rgba(0, 0, 0, 0)"){
		clone_element.css("background-color","white");
		clone_element.css("border","2px solid #f00");
	}else{
		//1613???????
//		var iii;
//		for(iii=0;iii<$("#"+element_name).css("background-color").length;iii++){
//			alert( iii+ " : '"+$("#"+element_name).css("background-color").charAt(iii)+"'");
//		}
//		alert($("#"+element_name).css("background-color").length+ "" + "rgba(0,0,0,0)".length);
		
//		alert($("#"+element_name).css("background-color") == "rgba(0, 0, 0, 0)");
	}
	clone_element.css("top",$("#"+element_name).offset().top);
	clone_element.css("left",$("#"+element_name).offset().left);
	
	clone_element.css("margin","0px");
// 	clone_element.css("width",$("#return").css("width"));
// 	clone_element.css("height",$("#return").height());
//  	alert($("#return").css("width"));
// 	clone_element.css("padding","30px");

	if(pervent_trigger!=1){
		clone_element.attr('onclick','$( "#"+"'+element_name+'" ).trigger( "click" );');
	}else{
		clone_element.attr('onclick','');
	}
	console.log("length:" + cache_modal.length);
	clone_element.click(function(){
		if(click_to_over==1){
			$("#platform").remove();
		}
		setTimeout(function(){
			console.log("123");
			console.log("length2:" + cache_modal);
			if(cache_modal.length>0){
				console.log("456");
				var eval_str = cache_modal.shift();
				console.log("length2:" + cache_modal);
				var delay_time=0;
				console.log(eval_str);
				
				while(eval_str.length<2 && eval_str!=null){
					delay_time += 1000;
					eval_str = cache_modal.shift();
					console.log("789");
					console.log("length:" + cache_modal.length);
				}
				console.log("012");
				setTimeout(function(){
					eval(eval_str);
				},delay_time);
			}
		}, 800);
	});
	modal_explanation.click(function(){
		if(click_to_over==1){
			$("#platform").remove();
		}
		setTimeout(function(){
			if(cache_modal.length>0){
				var eval_str = cache_modal.shift();
				var delay_time=0;
				while(eval_str.length<2 && eval_str!=null){
					delay_time += 1000;
					eval_str = cache_modal.shift();
				}
				setTimeout(function(){
					eval(eval_str);
				},delay_time);
			}
		}, 800);
	});
}




function job_explanation(job_id){
	if($("#current_job_detail").length==0){
		$.ajax({
			type : "POST",
			url : "scenarioJob.do",
			data : { 
				action : "get_current_job_info",
				job_id : job_id
			},success : function(result) {
				var json_obj = $.parseJSON(result);
				$("html").append("<div id='current_job_detail' title='情境流程說明'>"+json_obj.next_flow_explanation+"</div>");				
				
				$("#current_job_detail").dialog({
					draggable : true, resizable : false, autoOpen : true,
					width : "auto" ,height : "auto", modal : false,
					show : {effect : "blind", duration : 300 },
					hide : { effect : "fade", duration : 300 },
					buttons : [{
						text : "確定",
						click : function() {$(this).dialog("close");}
					}]
				});
			}
		});
	}else{
		$("#current_job_detail").dialog("open");
	}
	
	
	
}


