<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF8">

	<link rel="Shortcut Icon" type="image/x-icon" href="./images/cdri-logo.gif" />

	<link rel="stylesheet" href="css/jquery-ui.min.css">
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<link rel="stylesheet" href="css/styles.css">
	<link rel="stylesheet" href="./css/my_modal.css" type="text/css" media="screen" />
	<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
	<script type="text/javascript" src="js/additional-methods.min.js"></script>
	<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>
	<script type="text/javascript" src="js/common.js"></script>
	<script src="./js/my_modal.js" type="text/javascript"></script>
<%
	String group_id = (String) session.getAttribute("group_id");
	String user_id = (String) session.getAttribute("user_id");
	Integer role = (Integer) session.getAttribute("role");
	String menu = (String) request.getSession().getAttribute("menu"); 
	String privilege = (String) request.getSession().getAttribute("privilege"); 
%>
<title>工作流程管理</title>
<style>
#tbl_main a.btn{
	word-break: keep-all;
}
.bentable th{
	text-align:center;
}
.bentable td{
	padding:5px 15px;
	word-break: keep-all;
	text-align:left;
	font-family: "微軟正黑體", "Microsoft JhengHei", 'LiHei Pro', Arial, Helvetica, sans-serif, \5FAE\8EDF\6B63\9ED1\9AD4,\65B0\7D30\660E\9AD4;
}
.bentable td:nth-child(1){
	text-align:right;
}
.bentable td:nth-child(2){
	font-size:16px;
	word-break: normal;
	text-align:left;
	color: red;
}
.bentable.nobreak td:nth-child(2){
	word-break: keep-all;
}
.bentable td:nth-child(4){
	word-break: break-all;
	max-width:600px;
}
</style>

<script>
var explane_txt_arr={"0":"<div style='height:340px;width:calc(70vw);text-align:center;line-height:290px;font-size:40px;'>請選擇情境</div>"};
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
		
		"pdf.jsp" : "電子書",
		"scenarioJob.jsp" : "情境流程"
	}
	
	function draw_scenario(parameter){
		$.ajax({
			type : "POST",
			url : "scenarioJob.do",
			data : parameter,
			success : function(result) {
				var json_obj = $.parseJSON(result);
				var result_table = "";
				$.each(json_obj, function(i, item) {
					
					var print_table="";
					var result_obj = $.parseJSON(json_obj[i].result);
					var job_content_title="";
					$.each(result_obj, function(j, item) {
						job_content_title="工作歷程:";
						print_table+="<tr><td>"+result_obj[j].step+"</td><td><div style='max-width:200px'>"+result_obj[j].flow_name+"</div></td><td>"+result_obj[j].category+"</td><td><div style='max-width:400px'>"+result_obj[j].result+"</div></td></tr>";
					});
					result_table+= '<tr job_id="'+json_obj[i].job_id+'" job_name="'+json_obj[i].job_name+'" job_pro="'+json_obj[i].flow_seq+'/'+ json_obj[i].max_flow_seq+'">' 
						+ '<td><b style="font-size:16px;">' +json_obj[i].job_name+ '</b></td>' 
						+ '<td>' +json_obj[i].scenario_name+"<br>"+item.job_time+ '</td>'
						+ '<td style="text-align:center;">' +json_obj[i].flow_seq+'/'+ json_obj[i].max_flow_seq+ '</td>'
						+ '<td><div style="max-width:200px">' +json_obj[i].flow_name + '</div></td>'
						+ '<td><div style="max-width:200px">' +json_obj[i].next_flow_name + '</div></td>'
						+((item.finished == "1")?
							('<td colspan="3" style="font-size:18px;text-align:center;">已於 '+item.finish_time+' 完成<br>'
							+ '<a class="btn btn-darkblue btn-update" job_content_title="'+job_content_title+'" result=\"'+print_table+'\" scenario_name="'+json_obj[i].scenario_name+'">內容</a>&nbsp;&nbsp;&nbsp;&nbsp;'
							+"<a class='btn btn-exec btn-delete' style='margin-top:5px;' value='"+item.finish_time+"' job_name='"+item.job_name+"' scenario_name='"+item.scenario_name+"'>刪除</a>" + '</td>'+
							'</tr>')
									
						:('<td style="text-align:center;">' + '<a class="btn btn-darkblue btn-update" job_content_title="'+job_content_title+'" result=\"'+print_table+'\" scenario_name="'+json_obj[i].scenario_name+'">內容</a>'+ '</td>'
						+ '<td style="text-align:center;">' + '<a class="btn btn-exec btn-delete" scenario_name="'+json_obj[i].scenario_name+'">刪除</a>'+ '</td>'
						+ '<td style="text-align:center;">' + '<a class="btn btn-darkblue btn-next" value="'+json_obj[i].next_flow_page+'" next_flow_name="'+json_obj[i].next_flow_name +'" next_flow_explanation="'+json_obj[i].next_flow_explanation+'">下一步</a>'+ '</td>'
						+'</tr>'));
						
					$("#tbl_main tbody").html(result_table);
				});
			}
		});				
	}
	$(function() {
		
		$(document).keypress(function(e) {
			if(e.which == 13) {
		    	e.preventDefault();
		    }
		});

		draw_scenario({action : "getJobInfo"});
		$("#tbl_main").delegate(".btn-update", "click", function(e) {
			e.preventDefault();
			$("#job_name_update").val($(this).closest("tr").attr("job_name"));
			$("#job_content_update").val($(this).attr("result"));
			$("#job_update").val($(this).closest("tr").attr("job_id"));
			$("#job_content_title").html($(this).attr("job_content_title"));
			$("#job_content_update tbody").html($(this).attr("result"));
			
			
			if($(this).attr("result").length>2){
				$("#job_content_update").show();
			}else{
				$("#job_content_update").hide();
			}
			$("#job_update").dialog("open");
		});
		$("#tbl_main").delegate(".btn-delete", "click", function(e) {
			e.preventDefault();
			$("#job_delete").val($(this).closest("tr").attr("job_id"));
			$("#job_delete").html("<table class='bentable nobreak'>"
				+"<tr><td>工作名稱</td><td>"+$(this).closest("tr").attr("job_name")+"</td></tr>"
				+"<tr><td>所屬情境流程</td><td>"+$(this).attr("scenario_name")+"</td></tr>"
			);
			$("#job_delete").dialog("open");
		});

		$("#tbl_main").delegate(".btn-next", "click", function(e) {
			$("#scenario_controller").remove();
			e.preventDefault();
 			$("#job_next").attr("next_page",$(this).attr("value"));
			$("#job_next").html(
				"<table class='bentable'>"
				+"<tr><td>接下來的步驟: </td><td>"+$(this).attr("next_flow_name")+"</td></tr>"
				+"<tr><td>步驟說明: </td><td style='max-width:calc(50vw);'>"+$(this).attr("next_flow_explanation")+"</td></tr>"
				+"<tr><td>將跳至頁面:</td><td>"+(page_comparison[$(this).attr("value")]==null?"":page_comparison[$(this).attr("value")])+"</td></tr>"
				+"</table>"
			);
			$("#job_next").attr("scenario_job_id",$(this).closest( "tr" ).attr("job_id"));
			$("#job_next").attr("scenario_job_page",$(this).attr("value"));
			var tmp = $(this).closest( "tr" ).attr("job_id");
			$("html").append("<div id='scenario_controller' class='scenario_controller' style=''>"
					+ "    <span id = 'job_title' class='focus' onclick='job_explanation(\""+tmp+"\")'>"+$(this).closest( "tr" ).attr("job_name")+" "+$(this).closest( "tr" ).attr("job_pro")+"</span>"
					+ "    <a id='next_step_btn' style='float:right;margin-left:10px;' href='./"+$(this).attr("value")+"'><img class='func' style='height:22px;' title='跳至將執行頁面' src='./refer_data/next_step.png'></a>"
					+ "    <img id='check_btn' onclick='finish_step()' class='func' style='float:right;height:22px;margin-left:10px;' title='完成此步驟' src='./refer_data/check.png'>"
					+ "    <img id='reverse_btn' onclick='reverse_step()' class='func' style='float:right;height:22px;margin-left:20px;' title='退回上一個步驟' src='./refer_data/reverse.png'>"
					+ "</div>");
			tooltip("func");
			$.ajax({
			    type : "POST",
			    url : "scenarioJob.do",
			    data : {
			    	action :"click_next_step",
			    	scenario_job_id : $("#job_next").attr("scenario_job_id"),
			    	scenario_job_page : $("#job_next").attr("scenario_job_page")
			    },success : function(result) {
			    	if(result!="success"){
			    		alert("系統異常，並未進入情境");
			    	}
			    }
			});
			
			if($("#checkbox-t").prop("checked")){
				cache_modal.push('run_modal("scenario_controller","歡迎使用本系統的情境流程，當您進入特定工作流後，將於左下角為您顯示現在的<b style=\'color:#33FFFF;font-size:22px;\'>工作進度</b>若為開放式情境，評估完後可於此點選跳轉至下一步。",1);');
				cache_modal.push('run_modal("next_step_btn","此按鈕可以讓您跳至欲執行頁面，進入下一步",1,1);');
				cache_modal.push('run_modal("check_btn","此按鈕可以讓您在任何時間完成此階段，進入下一步",1,1);');
				cache_modal.push('run_modal("job_title","點擊工作名稱瀏覽詳細敘述",1,1);');
			}
			cache_modal.push('run_no_modal("$(\'#job_next\').dialog(\'open\');");');
			cache_modal.push(' ');
			if($("#checkbox-t").prop("checked")){
				cache_modal.push('run_modal("job_next_enter","點擊此，可跳轉至目前進度頁面",1,1);');
			}
			do_modal();
		});
		
		$("#job_next").dialog({
			draggable : true, resizable : false, autoOpen : false,
			width : "auto" ,height : "auto", modal : true,
			show : {effect : "blind", duration : 300 },
			hide : { effect : "fade", duration : 300 },
			buttons : [{
				id : "job_next_enter",
				text : "確定跳轉",
				click : function() {
			    	window.location.href = $("#job_next").attr("next_page") ;
			    	$("#job_next").dialog("close");
				}
			},{
				text : "取消",
				click : function() {
					$(this).dialog("close");
				}
			},]
		});
		$("#job_next").show();
		
		$("#insert_job").dialog({
			draggable : true, resizable : false, autoOpen : false,
			width : "auto" ,height : "auto", modal : false,
			show : {effect : "blind", duration : 300 },
			hide : { effect : "fade", duration : 300 },
			buttons : [{
				text : "確定",
				click : function() {
					if($("#all_scenario_name").val()!=0 && $("#insert_job_name").val().length!=0){
						draw_scenario({
							action : "insert_job",
							scenario_id : $("#all_scenario_name").val(),
							job_name : $("#insert_job_name").val()
						});
						$(this).dialog("close");
					}else{
						alert("請填寫完整");
					}
				}
			},{
				text : "取消",
				click : function() {
					$(this).dialog("close");
				}
			},]
		});
		$("#insert_job").show();
		$("#job_update_button").click(function(){
			if($("#job_name_update").val().length!=0){
				draw_scenario({
					action : "update_job",
					job_id : $("#job_update").val(),
					job_name : $("#job_name_update").val()
				});
				$("#job_update").dialog("close");
			}else{
				alert("請填寫完整");
			}
		});
		$("#job_update").dialog({
			draggable : true, resizable : false, autoOpen : false,
			height : "auto", width : "auto", modal : true,
			show : {effect : "blind", duration : 300},
			hide : {effect : "fade", duration : 300},
			open : function(){
				$("#job_update").css("max-height", "calc(78vh)");
			},
			buttons : [{
				text : "確定",
				click : function() {
					$(this).dialog("close");
				}
			}]
		});
		
		$("#job_update").show();
		$("#job_delete").dialog({
			draggable : true, resizable : false, autoOpen : false,
			height : "auto", width : "auto", modal : true,
			show : {effect : "blind", duration : 300},
			hide : {effect : "fade", duration : 300},
			buttons : [{
				text : "確定刪除",
				click : function() {
					draw_scenario({
						action : "delete_job",
						job_id : $("#job_delete").val()
					});
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
			},{
				text : "取消",
				click : function() {
					$(this).dialog("close");
				}
			}]
		});
		$("#job_delete").show();
		$("#job_delete_detail").dialog({
			draggable : true, resizable : false, autoOpen : false,
			height : "auto", width : "auto", modal : true,
			show : {effect : "blind", duration : 300},
			hide : {effect : "fade", duration : 300},
			buttons : [{
				text : "確定刪除",
				click : function() {
// 					draw_scenario({
// 						action : "delete_job",
// 						job_id : $("#job_delete").val()
// 					});
// 					$.ajax({
// 						type : "POST",
// 						url : "scenarioJob.do",
// 						data : { 
// 							action : "clear_session",
// 						},success : function(result) {
// 							if(result=="success"){
// 								location.replace(location);	
// 							}
// 						}
// 					});
					$(this).dialog("close");
				}
			},{
				text : "取消",
				click : function() {
					$(this).dialog("close");
				}
			}]
		});
		$("#job_delete_detail").show();
		
		
		
		
		$("#logout").click(function(e) {
			$.ajax({
				type : "POST",
				url : "login.do",
				data : {
					action : "logout"
				},
				success : function(result) {
					top.location.href = "login.jsp";
				}
			});
		});
		$.ajax({
		    type : "POST",
		    url : "scenarioJob.do",
		    data : {action :"select_all_scenario"},
		    success : function(result) {
		        var json_obj = $.parseJSON(result);
		        var option_str='<option value="0">請選擇</option>';
		        
		        $.each (json_obj, function (i) {
		        	if(json_obj[i].scenario_name.indexOf('教學')==-1){
			        	option_str+="<option value='"+json_obj[i].scenario_id+"'>"+json_obj[i].scenario_name+"</option>";
			        	var explane_txt = "<div style='text-align:center;font-size:30px;'>"+json_obj[i].scenario_name + "</div><div style='max-width:calc(60vw);margin:10px auto;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+json_obj[i].result+"</div><hr><div style='max-width:calc(70vw);'>";
			        	$.each (json_obj[i].child, function (j) {
			        		if(json_obj[i].child[j].flow_seq!=0){
			        			explane_txt += "步驟 " +json_obj[i].child[j].flow_seq+": "+json_obj[i].child[j].next_flow_explanation + "<br>";
			        		}
			        	});
			        	explane_txt += "</div>";
		        	}
		        	explane_txt_arr[json_obj[i].scenario_id] = explane_txt;
		        });
		        $("#explane_select").html(option_str);
		        $("#all_scenario_name").html(option_str);
		        $("#explane_txt").html("<div style='height:340px;width:calc(70vw);text-align:center;line-height:290px;font-size:40px;'>請選擇情境</div>");
		    }
		});
		
		$("#btn_main_create").click(function(e) {
			e.preventDefault();
			$("#insert_job_name").val('');
			$("#all_scenario_name").val('0');
			$("#insert_job").dialog("open");
		});
		
		$("#explane").dialog({
			draggable : true, resizable : false, autoOpen : false,
			width : "auto" ,height : "auto", modal : false,
			show : { effect : "blind", duration : 300 },
			hide : { effect : "fade", duration : 300 },
			buttons : {
				"確定" : function() {$(this).dialog("close");}
			}
		});
		$("#explane").show();
		$("#explane_select").change(function(){
			$("#explane_txt").html(explane_txt_arr[$("#explane_select").val()]);
		});
	});
</script>
</head>
<body>
<input type="hidden" id="glb_menu" value='<%= menu %>' />
<input type="hidden" id="glb_privilege" value="<%= privilege %>" />

	<div class="page-wrapper" >
	
		<div class="header">
			<div class="userinfo">
				<p>使用者<span><%= (request.getSession().getAttribute("user_name")==null)?"":request.getSession().getAttribute("user_name").toString() %></span></p>
				<a href="#" id="logout" class="btn-logout">登出</a>
			</div>
		</div>
	
		<jsp:include page="menu.jsp"></jsp:include>
		<div id="msgAlert"></div>
	 	<h2 id="title" class="page-title">工作管理</h2>
		
		<!-- content-wrap -->
		<div class="content-wrap">
			<div id="caseAlert"></div>
		
			<div id="div_main" class="form-row" >
				<div class="search-result-wrap">
					<div class="form-row">
						<h2>決策管理</h2>
					</div>
					
					<div class="result-table-wrap">
						<table id="tbl_main" class="result-table">
							<thead>
								<tr>
									<th>工作名稱</th>
									<th>所屬情境流程</th>
									<th>進度</th>
									<th>已完成之步驟</th>
									<th>欲執行之步驟</th>
									<th colspan='3'>功能</th>
								</tr>
							</thead>
							<tbody></tbody>
						</table>
					</div>
					
					<div class="btn-row">
						<a id="btn_main_create" class="btn btn-exec btn-wide" >建立工作</a>
						<a id="btn_main_view" class="btn btn-exec btn-wide" onclick='$("#explane").dialog("open");'>查看情境流程</a>
						<input id="checkbox-t" type="checkbox" style='top:-99999px;left:0px;'><label for="checkbox-t" style='float:right;display:none;'><span class="form-label">解說</span></label>
					</div>
				</div>
			</div>
			<div id='job_next' title='即將跳轉頁面' style='display:none;'></div>
			<div id='insert_job' title='新增情境流程工作' style='display:none;'>
				<table class='bentable'>
					<tr>
						<td>工作名稱:</td>
						<td><input type='text' id='insert_job_name'></td>
					</tr>
					<tr>
						<td>情境流程:</td>
						<td><select id='all_scenario_name'></select></td>
					</tr>
				</table>
				<div id='explane_txt_insert' style='line-height:26px;'></div>
			</div>
			
			<div id='job_update' title='工作內容' style='display:none;'>
				<table class='bentable'>
					<tr>
						<td>工作名稱:</td>
						<td><input type='text' id='job_name_update'></td>
						<td><button id='job_update_button' class='btn btn-exec'>修改名稱</button></td>
					</tr>
					<tr>
						<td id='job_content_title'>工作歷程:</td><td></td>
					</tr>
					<tr>
						<td colspan='3'>
							<table id = 'job_content_update' class="result-table">
								<thead>
									<tr>
										<th>步驟</th>
										<th>流程名稱</th>
										<th>項目</th>
										<th style='max-width:400px;'>結果</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</table>
				
			</div>
			<div id='job_delete' title='是否確認刪除此工作'>
				
			</div>
			<div id='job_delete_detail' title='是否刪除此工作紀錄'>
				
			</div>
			<div id='explane' title='情境流程說明' style='display:none;'>
				<select id='explane_select'>
					<option value="0">餐飲設址</option>
					<option value="1">零售設址</option>
					<option value="2">醫美產業新品進入</option>
					<option value="3">長照海外布局</option>
				</select>
				<div id='explane_txt' style='line-height:26px;'>
					餐飲設址7步驟【如下說明】<br>(1)檢視環境：確認是否有開店的商機【現況發展、未來潛力及競爭強度】<br>(2)選擇區位：人流決定餐廳成功【鎖定客流量最高，選擇商圈區位】<br>(3)人潮分布：辦公大樓、居民社區等機構分布狀況【人潮來源地】<br>(4)環域分析：在既有店面位址【步行5~15分鐘所涵蓋的辦公、社區與機構設施】<br>(5)停車設施：顧客開車來用餐，附近停車方便性【步行10分鐘內所涵蓋的停車場】<br>(6)競爭分布：商圈內餐飲業分佈狀況【投資競爭缺口】<br>(7)消費特性：了解當地消費者對於產品與服務需求缺口【以缺口當作商機】<br><br>
				</div>
			</div>
		</div>
		<!-- content-wrap -->
		
		<script src="js/sbi/menu.js"></script>
		<footer class="footer">
			財團法人商業發展研究院  <span>電話(02)7707-4800 | 傳真(02)7713-3366</span> 
		</footer>
	</div>
	
</body>
</html>