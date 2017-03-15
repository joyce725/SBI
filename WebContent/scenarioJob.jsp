<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF8">

	<link rel="Shortcut Icon" type="image/x-icon" href="./images/cdri-logo.gif" />

	<link rel="stylesheet" href="css/jquery-ui.min.css">
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<link rel="stylesheet" href="css/styles.css">

	<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
	<script type="text/javascript" src="js/additional-methods.min.js"></script>
	<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>
	<script type="text/javascript" src="js/common.js"></script>
<%
	String group_id = (String) session.getAttribute("group_id");
	String user_id = (String) session.getAttribute("user_id");
	Integer role = (Integer) session.getAttribute("role");
	String menu = (String) request.getSession().getAttribute("menu"); 
	String privilege = (String) request.getSession().getAttribute("privilege"); 
%>
<title>工作流程管理</title>
<style>
.bentable{
	
}
.bentable td{
	padding:3px 5px;
	
}
.bentable td:nth-child(2){
	font-size:16px;
	text-align:left;
	color: red;
}

</style>

<script>
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
		"regionSelect.jsp": "區位選擇",
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
		"uploaddocsManager.jsp": "商機觀測站後臺"
	}


	var explane_txt_arr=["餐飲設址7步驟【如下說明】<br>(1)檢視環境：確認是否有開店的商機【現況發展、未來潛力及競爭強度】<br>(2)選擇區位：人流決定餐廳成功【鎖定客流量最高，選擇商圈區位】<br>(3)人潮分布：辦公大樓、居民社區等機構分布狀況【人潮來源地】<br>(4)環域分析：在既有店面位址【步行5~15分鐘所涵蓋的辦公、社區與機構設施】<br>(5)停車設施：顧客開車來用餐，附近停車方便性【步行10分鐘內所涵蓋的停車場】<br>(6)競爭分布：商圈內餐飲業分佈狀況【投資競爭缺口】<br>(7)消費特性：了解當地消費者對於產品與服務需求缺口【以缺口當作商機】<br><br>","零售設址7步驟【如下說明】<br>(1)評估城市：避開對手已經進入城市，並評估人口／所得是否合適【比較西安／武漢／重慶】<br>(2)評估商圈：評估重慶商圈人流量／消費結構，搭配電子書【了解商圈消費規模及功能定位】<br>(3)檢視環境：檢視競爭分布及效應／交通狀況及工具／人潮分布【深入了解，以利選點】<br>(4)區位選擇：確認是否有擴點商機【未來潛力好及發展現況好，競爭強度】<br>(5)消費特性：了解該商圈消費者偏好到購物環境好的商場的分數？受商場商品促銷吸引分數？【消費偏好】<br>(6)評估成本：經營成本可找到最符合自身進駐的租金成本區塊。【了解投入租金／人事成本】<br>(7)環域分析：步行5～15分鐘內所涵蓋的寫字樓、文教設施及居民社區【進行服務範圍模擬】<br><br>","鎖定目標客群，再點出哪個市場符合，最後為選擇市場，進行評估（SBI全包處理）<br>醫美產業新品進入6步驟【如下說明】<br><br>(1)目標客戶：找出新產品合適的目標客群【個性屬性、消費態度/偏好/特色】<br>(2)評估城市：找出有潛力的亞洲城市【依此頁評估項目進行人品/GDP/消費支出】<br>(3)評估商圈：馬來西亞適合進入的商圈【可搭配地圖/電子書進行了解】<br>(4)空間決策：目標市場→決定主要商圈/競爭分析→了解競爭商分布/銷售通路→評估優先序<br>(5)區位選擇：藉由交通便利性找到最符合進駐的物流及人流區塊【選地點】<br>(6)環域分析：進行服務範圍模擬【步行10分／單車5分所涵蓋的超巿、藥妝及購物百貨】<br><br>","先點出佈局的地點；再點出布局需考慮且評估的項目（SBI全包處理）<br>長照海外布局6步驟【如下說明】<br><br>(1)檢視適合城市：找出適合國際化的亞洲城巿建議的優先序。以電子書依序了解城巿規格及各業態競爭概況。<br>(2)檢視區位環境：確認是否Q有擴點的商機【現況發展、未來潛力及競爭強度】<br>(3)評估消費市場：找出適應的城巿及目標客群／建康產業消費統計指標／家戶結構<br>(4)評估投資成本：馬來西亞各城巿的生活費用來評估可能的投資成本<br>(5)評估競爭分布：了解武吉免登圈內醫院、居民社區、停車場及藥妝店分布。<br>(6)環域分析5min：在既有店面位址【步行5分鐘所涵蓋的範圍】<br>"];
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
						$.each(result_obj, function(i, item) {
							job_content_title="工作歷程";
							print_table+="<tr><td>"+result_obj[i].step+"</td><td>"+result_obj[i].flow_name+"</td><td>"+result_obj[i].category+"</td><td>"+result_obj[i].result+"</td></tr>";
						});
						result_table+= '<tr job_id="'+json_obj[i].job_id+'" job_name="'+json_obj[i].job_name+'">' 
							+ '<td>' +json_obj[i].job_name+ '</td>' 
							+ '<td>' +json_obj[i].scenario_name+"<br>"+item.job_time+ '</td>'
							+ '<td>' +json_obj[i].flow_seq+'/'+ json_obj[i].max_flow_seq+ '</td>'
							+ '<td>' +json_obj[i].flow_name + '</td>'
							+ '<td>' +json_obj[i].next_flow_name + '</td>'
							+ '<td>' + '<a class="btn btn-darkblue btn-update" job_content_title="'+job_content_title+'" result="'+print_table+'" scenario_name="'+json_obj[i].scenario_name+'">內容</a>'+ '</td>'
							+ '<td>' + '<a class="btn btn-exec btn-delete" scenario_name="'+json_obj[i].scenario_name+'">刪除</a>'+ '</td>'
							+ '<td>' + '<a class="btn btn-darkblue btn-next" value="'+json_obj[i].next_flow_page+'">下一步</a>'+ '</td>'
							+'</tr>';
							
						$("#tbl_main tbody").html(result_table);
						
					});
			}
		});				
	}
	$(function() {
		$(document).keypress(function(e) {
			if(e.which == 13) {
		    	event.preventDefault();
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
			$("#job_delete").html("<table class='bentable'>"
				+"<tr><td>工作名稱</td><td>"+$(this).closest("tr").attr("job_name")+"</td></tr>"
				+"<tr><td>所屬情境流程</td><td>"+$(this).attr("scenario_name")+"</td></tr>"
			);
			$("#job_delete").dialog("open");
		});

		$("#tbl_main").delegate(".btn-next", "click", function(e) {
			e.preventDefault();
			var next_page = $(this).attr("value");
			$("#job_next").html("將跳至"+"");
			    
		});
		
		$("#job_next").dialog({
			draggable : true, resizable : false, autoOpen : false,
			width : "auto" ,height : "auto", modal : false,
			show : {effect : "blind", duration : 300 },
			hide : { effect : "fade", duration : 300 },
			buttons : [{
				text : "確定",
				click : function() {
					$.ajax({
					    type : "POST",
					    url : "caseScenario.do",
					    data : {
					    	action :"click_next_step",
					    	scenario_job_id : $(this).closest( "tr" ).attr("value"),
					    	scenario_job_page : $(this).attr("value")
					    },success : function(result) {
					    	window.location.href = next_page ;
					    }
					});
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
		
		$("#job_update").dialog({
			draggable : true, resizable : false, autoOpen : false,
			height : "auto", width : "auto", modal : true,
			show : {effect : "blind", duration : 300},
			hide : {effect : "fade", duration : 300},
			buttons : [{
				text : "修改",
				click : function() {
					if($("#job_name_update").val().length!=0){
						draw_scenario({
							action : "update_job",
							job_id : $("#job_update").val(),
							job_name : $("#job_name_update").val()
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
		        	option_str+="<option value='"+json_obj[i].scenario_id+"'>"+json_obj[i].scenario_name+"</option>"
		        });
		        $("#all_scenario_name").html(option_str);
		    }
		});
		
		
		$("#btn_main_create").click(function(e) {
			e.preventDefault();
			$("#insert_job_name").val('');
			$("#all_scenario_name").val('0');
			$("#insert_job").dialog("open");
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
<!-- 										<th>執行步驟</th> -->
									<th>已完成之步驟</th>
									<th>欲執行之步驟</th>
<!-- 									<th>時間</th> -->
									<th colspan='3'>功能</th>
								</tr>
							</thead>
							<tbody></tbody>
						</table>
					</div>
					
					<div class="btn-row">
						<button id="btn_main_create" class="btn btn-exec btn-wide" >建立工作</button>
						<button id="btn_main_view" class="btn btn-exec btn-wide" >查看情境流程</button>
					</div>
				</div>
			</div>
			
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
			
			<div id='job_update' title='工作內容'>
				<table class='bentable'>
					<tr>
						<td>工作名稱:</td>
						<td><input type='text' id='job_name_update'></td>
					</tr>
					<tr>
						<td id='job_content_title'>工作歷程:</td><td></td>
					</tr>
					<tr>
						<td colspan='2'>
<!-- 							<div id= 'job_content_title' style='padding:5px 10px;'>歷程:</div> -->
							<table id = 'job_content_update' class="result-table">
								<thead>
									<tr>
										<th>步驟</th>
										<th>流程名稱</th>
										<th>項目</th>
										<th>結果</th>
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
			<div id='job_next'>
				
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