var cache_modal = [];
var page_comparison={
		"realMap.jsp": "商圈資訊",
		"POI.jsp": "商圈POI",
		"country.jsp": "動態統計-國家",
		"city.jsp": "動態統計-目標城市",
		"industry.jsp": "動態統計-目標產業",
		"consumer.jsp": "動態統計-中國城市消費力",
		
		"costLiving.jsp": "生活費用",
		"population.jsp": "台灣人口社經",
		"populationNew.jsp": "台灣人口社會經濟資料",
		"upload.jsp": "產業分析基礎資料庫",
		"personaNew.jsp": "目標客群定位",
		"evaluate.jsp": "目標市場決策評估",
		"caseCompetitionEvaluation.jsp": "競爭力決策評估",
		"caseChannelEvaluation.jsp": "通路決策評估",
		"regionSelect.jsp": "區位選擇、環域分析",
		"finModel.jsp": "新創公司財務損益平衡評估工具",
		"productForecast.jsp": "新產品風向評估",
		
		"product.jsp": "商品管理",
		"agent.jsp": "通路商管理",
		"agentAuth.jsp": "通路商授權商品管理",
		"serviceAgentAssign.jsp": "服務識別碼指定通路商作業",
		"productVerify.jsp": "商品真偽顧客驗證作業",
		"authVerify.jsp": "商品真偽通路商驗證作業",
		"serviceVerify.jsp": "服務識別碼查詢作業",
		"serviceRegister.jsp": "商品售後服務註冊",
		"serviceQuery.jsp": "服務識別碼查詢作業",
		"persona.jsp": "東南亞商機定位工具",
		"marketPlace.jsp": "城市商圈",
		
		"news.jsp": "新聞專區",
		"uploaddocs.jsp": "商機觀測站",
		"groupBackstage.jsp": "公司後台管理",
		"uploaddocsManager.jsp": "商機觀測站後臺",
		"white_page.jsp" : "測試頁面",
		
		"pdf.jsp" : "電子書"
	}
function do_modal(){
	if(cache_modal.length>0){
		eval(cache_modal.shift());
	}
}

function run_no_modal(this_eval_str){
	if(this_eval_str=="stop"){return;}
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
	if($("#"+element_name+"_tmp").length!=0){alert("發生未知錯誤!!!");return;}
	if(element_name=="place_center"){
		$("#place_center").remove();
		$("html").append("<div id='place_center' style='position:fixed;background-color:red;left:calc(20vw);top:calc(32vh);height:0px;width:calc(60vw);'></div>");
	}
	var clone_element = $("#"+element_name).clone();
	clone_element.attr('id', element_name+"_tmp");
	$("#"+element_name).after('<div class="jquery-modal my_blocker current" id="platform"></div>');
	$("#platform").html(clone_element);
	$("#platform").append("<div id='modal_explanation' class='my_modal my_modal_explanation' style=''>"+message+"</div>");
	var modal_explanation = $("#modal_explanation");
	if($('html').width()-$("#"+element_name).offset().left>400){
		if(parseInt($("#"+element_name).offset().top)>$('html').height()*0.8){
			modal_explanation.css("bottom",20);
		}else{
			modal_explanation.css("top",parseInt($("#"+element_name).offset().top)-parseInt($("#modal_explanation").css("height"))*0.5+18);
		}
		modal_explanation.css("left",(parseInt($("#"+element_name).offset().left)+20+(parseInt($("#"+element_name).css("width"))>$('html').width()*0.5?300:parseInt($("#"+element_name).css("width")))));
		if(parseInt($("#"+element_name).css("width"))>$('html').width()*0.5){
			modal_explanation.css("background-color","indianred");
		}
		
	}else{
		if(parseInt($("#"+element_name).offset().top)>$('html').height()*0.8){
			modal_explanation.css("bottom",16);
		}else{
			modal_explanation.css("top",parseInt($("#"+element_name).offset().top)-parseInt($("#modal_explanation").css("height"))*0.5+18);
		}
		modal_explanation.css("left",$("#"+element_name).offset().left-modal_explanation.width()-50);
	}
 	clone_element.attr('class',(clone_element.attr('class')==null?"":clone_element.attr('class'))+' my_modal');
	if($("#"+element_name).css("background-color")=="transparent" || $("#"+element_name).css("background-color") == "rgba(0, 0, 0, 0)"){
		clone_element.css("background-color","white");
		clone_element.css("border","2px solid #f00");
	}
	
	clone_element.css( "right","");
	clone_element.css( "bottom","");
	clone_element.css("position","absolute");
	clone_element.css("top",$("#"+element_name).offset().top);
	clone_element.css("left",$("#"+element_name).offset().left);
	clone_element.css("margin","0px");
	
	if(pervent_trigger!=1){
		clone_element.attr('onclick','setTimeout(function(){$( "#"+"'+element_name+'" ).trigger( "click" );},100);');
	}else{
		clone_element.attr('onclick','');
		clone_element.attr('href','#');
	}

	clone_element.click(function(){
		$("#platform").remove();
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
	modal_explanation.click(function(){
		if(click_to_over==1){
			$("#platform").remove();
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
		}
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
				$("html").append("<div id='current_job_detail' title='情境流程說明' style='margin:10px 20px;'>"
						+"<table class='bentable-style1'>"
						+"<tr><td>工作名稱:</td><td>"+json_obj.job_name+"</td></tr>"
						+"<tr><td>所屬情境:</td><td>"+json_obj.scenario_name+"</td></tr>"
						+"<tr><td>項目:</td><td>"+json_obj.next_flow_name+"</td></tr>"
						+"<tr><td>說明:</td><td style='max-width:calc(50vw);'>"+json_obj.next_flow_explanation+"</td></tr>"
						+"</table>"
						+"</div>");				
				
				$("#current_job_detail").dialog({
					draggable : true, resizable : false, autoOpen : true,
					width : "auto" ,height : "auto", modal : false, minWidth: 300,
					show : {effect : "blind", duration : 300 },
					hide : { effect : "fade", duration : 300 },
					buttons : [{
						text : "確定",
						click : function() {$(this).dialog("close");}
					},{
						text : "結束情境流程",
						click : function() {
							$.ajax({
								type : "POST",
								url : "scenarioJob.do",
								data : { 
									action : "clear_session",
								},success : function(result) {
									if(result=="success"){
										location.replace(location);	
									}
								}
							});
							$(this).dialog("close");
						}
					}]
				});
			}
		});
	}else{
		$("#current_job_detail").dialog("open");
	}
}

function scenario_record(category,result){
	$.ajax({
		type : "POST",
		url : "scenarioJob.do",
		data : { 
			action : "set_scenario_result",
			current_page : location.pathname.split("/").pop(),
			category : category,
			result : result,
		},success : function(result) {
			if(result!='success'&&result !='not_in_scenario'){
				alert("程序異常?\n儲存結果失敗。");
			}
		}
	});
}
function reverse_step(){
	alert("確定要跳到上一步?");
}
function finish_step(){
	if($("#current_job_finish").length==0){
		var step_name="";
		$.ajax({
			type : "POST",
			url : "scenarioJob.do",
			async : false,
			data : { action : "get_session" },
			success : function(result) {
				var json_obj = $.parseJSON(result);
				var scenario_job_id = json_obj.scenario_job_id;
				$.ajax({
					type : "POST",
					async : false,
					url : "scenarioJob.do",
					data : { 
						action : "get_current_job_info",
						job_id : scenario_job_id
					},success : function(result) {
						var json_obj = $.parseJSON(result);
						step_name = json_obj.next_flow_name;
					}
				});
			}
		});
		$("html").append("<div id='current_job_finish' title='是否完成此步驟' style='margin:10px 20px;color:red'>"+step_name+"</div>");				
		
		$("#current_job_finish").dialog({
			draggable : true, resizable : false, autoOpen : true,
			width : "auto" ,height : "auto", modal : true, minWidth: 300,
			show : {effect : "blind", duration : 300 },
			hide : { effect : "fade", duration : 300 },
			buttons : [{
				text : "確定完成",
				click : function() {
					$.ajax({
						type : "POST",
						url : "scenarioJob.do",
						data : { 
							action : "over_a_step"
						},success : function(result) {
							if(result.indexOf(".jsp")!=-1){
								alert("下一步。將跳至"+(page_comparison[result]==null?"":page_comparison[result])+"介面");
								window.location.href =  result ;
							}else if(result=='finished'){
								alert("完成此情境流程。將跳轉回工作介面");
								window.location.href = "scenarioJob.jsp" ;
							}else{
								alert("完成步驟發生異常?\n執行失敗。");
							}
						}
					});
					$(this).dialog("close");
				}
			},{
				text : "取消",
				click : function() {$(this).dialog("close");}
			}]
		});
	}else{
		$("#current_job_finish").dialog("open");
	}
}


$(function(){
	var scenario_job_id = "";
	var scenario_job_page ="";

	$.ajax({
		type : "POST",
		url : "scenarioJob.do",
		async : false,
		data : { action : "get_session" },
		success : function(result) {
			var json_obj = $.parseJSON(result);
			scenario_job_id = json_obj.scenario_job_id;
			scenario_job_page = json_obj.scenario_job_page;
		}
	});
	var current_page = location.pathname.split("/").pop();
	if( scenario_job_id.length > 2 && $("#scenario_controller").length==0){
		$.ajax({
			type : "POST",
			url : "scenarioJob.do",
			data : { 
				action : "get_current_job_info",
				job_id : scenario_job_id
			},success : function(result) {
				
				var json_obj = $.parseJSON(result);
				
				$("html").append("<div id='scenario_controller' class='scenario_controller' style=''>"
						+ "    <span id = 'job_title' class='focus'  onclick='job_explanation(\""+json_obj.job_id+"\")'>"+json_obj.job_name+" "+json_obj.flow_seq+'/'+ json_obj.max_flow_seq+"</span>"
						+ "    <a id='next_step_btn' style='float:right;margin-left:10px;'href='./"+json_obj.next_flow_page+"'><img class='func' style='height:22px;' title='跳至將執行頁面' src='./refer_data/next_step.png'></a>"
						+ "    <img id='check_btn' class='func' onclick='finish_step()' style='float:right;height:22px;margin-left:10px;' title='完成此步驟' src='./refer_data/check.png'>"
						+ "    <img id='reverse_btn' onclick='reverse_step()' class='func' style='float:right;height:22px;margin-left:20px;' title='退回上一個步驟' src='./refer_data/reverse.png'>"
						+ "</div>");
				
				tooltip("func");
			}
		});
	}
	
	if( scenario_job_id.length > 2 && current_page == scenario_job_page){
		$.ajax({
			type : "POST",
			url : "scenarioJob.do",
			async : false,
			data : { 
				action : "get_current_job_info",
				job_id : scenario_job_id,
			},success : function(result) {
				var json_obj = $.parseJSON(result);
					setTimeout(function(){
						eval(json_obj.next_flow_guide);
					},3000);
			}
		});
	}
});
function tooltip(clas){
	$("."+clas).mouseover(function(e){
		 this.newTitle = this.title;
		 this.title = "";
		 var tooltip = "<div id='tooltip'>"+ this.newTitle +"<\/div>";
		 $("body").append(tooltip);
		 $("#tooltip").css({"top": (e.pageY+20) + "px","left": (e.pageX+10)  + "px"}).show("fast");
	 }).mouseout(function(){
	         this.title = this.newTitle;
	         $("#tooltip").remove();
	 }).mousemove(function(e){
	         $("#tooltip").css({"top": (e.pageY-20) + "px","left": (e.pageX+10)  + "px"});
	 });
}

function run_modal_s(element_name,message,click_to_over,pervent_trigger){
	if($("#"+$(element_name).attr("id")+"_tmp").length!=0){alert("發生未知錯誤!!!");return;}
	if($(element_name).length>1){return;}
	var clone_element = $(element_name).clone();
	clone_element.attr('id', $(element_name).attr("id")+"_tmp");
	$(element_name).after('<div class="jquery-modal my_blocker current" id="platform"></div>');
	$("#platform").html(clone_element);
	$("#platform").append("<div id='modal_explanation' class='my_modal my_modal_explanation' style=''>"+message+"</div>");
	var modal_explanation = $("#modal_explanation");
	if($('html').width()-$(element_name).offset().left>400){
		if(parseInt($(element_name).offset().top)>$('html').height()*0.8){
			modal_explanation.css("bottom",20);
		}else{
			modal_explanation.css("top",parseInt($(element_name).offset().top)-parseInt($("#modal_explanation").css("height"))*0.5+18);
		}
		modal_explanation.css("left",(parseInt($(element_name).offset().left)+20+(parseInt($(element_name).css("width"))>$('html').width()*0.5?300:parseInt($(element_name).css("width")))));
		if(parseInt($(element_name).css("width"))>$('html').width()*0.5){
			modal_explanation.css("background-color","indianred");
		}
		
	}else{
		if(parseInt($(element_name).offset().top)>$('html').height()*0.8){
			modal_explanation.css("bottom",16);
		}else{
			modal_explanation.css("top",parseInt($(element_name).offset().top)-parseInt($("#modal_explanation").css("height"))*0.5+18);
		}
		modal_explanation.css("left",$(element_name).offset().left-modal_explanation.width()-50);
	}
	
 	clone_element.attr('class',(clone_element.attr('class')==null?"":clone_element.attr('class'))+' my_modal');
	if($(element_name).css("background-color")=="transparent" || $(element_name).css("background-color") == "rgba(0, 0, 0, 0)"){
		clone_element.css("background-color","white");
		clone_element.css("border","2px solid #f00");
	}
	
	clone_element.css( "right","");
	clone_element.css( "bottom","");
	clone_element.css("position","absolute");
	clone_element.css("top",$(element_name).offset().top);
	clone_element.css("left",$(element_name).offset().left);
	
	clone_element.css("margin","0px");
	if(pervent_trigger!=1){
		clone_element.attr('onclick','setTimeout(function(){$("'+element_name+'" ).trigger( "click" );},100);');
	}else{
		clone_element.attr('onclick','');
	}

	clone_element.click(function(){
		$("#platform").remove();
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
	
	modal_explanation.click(function(){
		if(click_to_over==1){
			$("#platform").remove();
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
		}
	});
}

function check_name(name){
	$("input[name='"+name+"']").prop("checked",true);
	$("input[name='"+name+"']").trigger("change");
}
