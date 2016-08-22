<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>動態磚</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="css/jquery.dataTables.min.css">
<script type="text/javascript" src="http://d3js.org/d3.v3.min.js"></script>
<!-- css for tab -->
<style>
/* Style the list */
ul.tab {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    border: 1px solid #ccc;
    background-color: #f1f1f1;
}

/* Float the list items side by side */
ul.tab li {float: left;}

/* Style the links inside the list items */
ul.tab li a {
    display: inline-block;
    color: black;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
    transition: 0.3s;
    font-size: 17px;
}

/* Change background color of links on hover */
ul.tab li a:hover {background-color: #ddd;}

/* Create an active/current tablink class */
ul.tab li a:focus, .active {background-color: #BFE9EC;}

/* Style the tab content */
.tabcontent {
    display: none;
    padding: 6px 12px;
    border: 1px solid #ccc;
    border-top: none;
}

.tabcontent {
    -webkit-animation: fadeEffect 1s;
    animation: fadeEffect 1s; /* Fading effect takes 1 second */
}

@-webkit-keyframes fadeEffect {
    from {opacity: 0;}
    to {opacity: 1;}
}

@keyframes fadeEffect {
    from {opacity: 0;}
    to {opacity: 1;}
}
</style>

<!--  css for d3js -->
<style>
.axis path,
.axis line {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}

.grid path,
.grid line {
  fill: none;
  stroke: rgba(0, 0, 0, 0.25);
  shape-rendering: crispEdges;
}

.x.axis path {
  display: none;
}

.line {
  fill: none;
  stroke-width: 2.5px;
}
</style>
</head>
<body onload="openTab(event, 'finTool')">
	<jsp:include page="template.jsp" flush="true"/>
	<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
	<script type="text/javascript" src="js/additional-methods.min.js"></script>
	<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>
	
<!-- /**************************************  以下共用JS區塊    *********************************************/ 	-->
	<script>
		$(function(){
			$('.banner div').css('opacity',0.4);
			$('.banner').hover(function(){		
				var el = $(this);
				el.find('div').stop().animate({width:200,height:200},'slow',function(){
					el.find('p').fadeIn('fast');
				});
			},function(){
				var el = $(this);
				el.find('p').stop(true,true).hide();
				el.find('div').stop().animate({width:60,height:60},'fast');
			}).click(function(){
				window.open($(this).find('a').attr('href'));
			});
		})
			
		
		function openTab(evt, cityName) {
		    // Declare all variables
		    var i, tabcontent, tablinks;
		
		    // Get all elements with class="tabcontent" and hide them
		    tabcontent = document.getElementsByClassName("tabcontent");
		    for (i = 0; i < tabcontent.length; i++) {
		        tabcontent[i].style.display = "none";
		    }
		
		    // Get all elements with class="tablinks" and remove the class "active"
		    tablinks = document.getElementsByClassName("tablinks");
		    for (i = 0; i < tablinks.length; i++) {
		        tablinks[i].className = tablinks[i].className.replace(" active", "");
		    }
		
		    // Show the current tab, and add an "active" class to the link that opened the tab
		    document.getElementById(cityName).style.display = "block";
		    evt.currentTarget.className += " active";
		}
	</script>
<!-- /**************************************  以上共用JS區塊    **********************************************/ 		-->	

<!-- /**************************************  以下管理者JS區塊    *********************************************/		-->
	<c:if test="${sessionScope.role==1}">
		<script>
// 			alert("admin");
			$(function(){
				var uuid = "";
					
				// 建立模型 事件聆聽
				$("#create-model-button").click( function(e) {
					e.preventDefault();		
					create_dialog.dialog("open");
				});	
				// 建立模型Dialog相關設定
				create_dialog = $("#dialog-form-create").dialog({
					draggable : false,//防止拖曳
					resizable : false,//防止縮放
					autoOpen : false,
					show : {
						effect : "blind",
						duration : 1000
					},
					hide : {
						effect : "explode",
						duration : 1000
					},
					width : 'auto',
					modal : true,
					buttons : [{
								id : "create",
								text : "建立",
								click : function() {
// 									if ($('#insert-dialog-form-post').valid()) {
										$.ajax({
											type : "POST",
											url : "finModel.do",
											data : {
												action : "create",
												case_name : $("#dialog-form-create input[name='case_name']").val(),
												amount : $("#dialog-form-create input[name='amount']").val(),
												safety_money : $("#dialog-form-create input[name='safety_money']").val()
											},
											success : function(result) {
// 												alert("success");
												var json_obj = $.parseJSON(result);
												var result_table = "";
												$.each(json_obj,function(i, item) {
													result_table += 
															"<tr><td>"+json_obj[i].case_name+"</td><td>"+json_obj[i].create_date+"</td><td>"
															+ "<button value='"+ json_obj[i].case_id+"' name='"+ json_obj[i].case_id
															+ "' class='btn-simu btn btn-wide btn-primary btn_delete'>產生</button></td></tr>";;
												});
												//判斷查詢結果
												var resultRunTime = 0;
												$.each (json_obj, function (i) {
													resultRunTime+=1;
												});
												$("#fincase-table-admin").dataTable().fnDestroy();
												if(resultRunTime!=0){
													$("#fincase-table-admin tbody").html(result_table);
													//$("#products").dataTable({"bFilter": false, "bInfo": false, "paging": false, "language": {"url": "js/dataTables_zh-tw.txt","zeroRecords": "沒有符合的結果"}});
													$(".validateTips").text("");
												}else{
													$(".validateTips").text("查無此結果");
												}
											}
										});
										create_dialog.dialog("close");
// 									}
								}
							}, {
								text : "取消",
								click : function() {
	// 								validator_insert.resetForm();
	// 								$("#insert-dialog-form-post").trigger("reset");
									create_dialog.dialog("close");
								}
							} ],
					close : function() {
	// 					validator_insert.resetForm();
	// 					$("#insert-dialog-form-post").trigger("reset");
						create_dialog.dialog("close");
					}
				}); 
				
				// onload 時帶入fincase資料
				$.ajax({
					type : "POST",
					url : "finModel.do",
					data : {
						action : "onload"
					},
					success : function(result) {
// 							alert("success");
						var json_obj = $.parseJSON(result);
						var result_table = "";
						$.each(json_obj,function(i, item) {
							result_table += 
									"<tr><td>"+json_obj[i].case_name+"</td><td>"+json_obj[i].create_date+"</td><td>"
									+ "<button value='"+ json_obj[i].case_id+"' name='"+ json_obj[i].case_id
									+ "' class='btn-simu btn btn-wide btn-primary'>產生</button></td></tr>";;
						});					
						//判斷查詢結果
						var resultRunTime = 0;
						$.each (json_obj, function (i) {
							resultRunTime+=1;
						});
						$("#fincase-table-admin").dataTable().fnDestroy();
						if(resultRunTime!=0){
							$("#fincase-table-admin tbody").html(result_table);
							//$("#products").dataTable({"bFilter": false, "bInfo": false, "paging": false, "language": {"url": "js/dataTables_zh-tw.txt","zeroRecords": "沒有符合的結果"}});
							$(".validateTips").text("");
						}else{
							$(".validateTips").text("查無此結果");
						}
					}
				});
				
				// 產生模擬圖
				$("#fincase-table-admin").delegate(".btn-simu", "click", function() {
// 					alert("click");
					uuid = $(this).val();
// 					alert(uuid);
					$.ajax({
						type : "POST",
						url : "finModel.do",
						data : {
							action : "gen_d3js",
							case_id: uuid
						},
						success : function(result) {
							var obj = JSON.parse(result);
							var income = obj[0].income;
							var outlay = obj[1].outlay;
							var detailData = obj[2].detailData;
							var fincase = obj[3].fincase;
							var totalIncome = obj[4].totalIncome;
							var totalOutlay = obj[5].totalOutlay;
							genSimuGraph(income, outlay, detailData, fincase, totalIncome, totalOutlay);
						}
					});	
				});
			})
		</script>
	</c:if>
<!-- /**************************************  以上管理者JS區塊    *********************************************/	-->
 

<!-- /**************************************  以下使用者JS區塊    *********************************************/ 	-->
	<c:if test="${sessionScope.role==0}">
		<script>
// 			alert("user");
			$(function(){
				var uuid = "";
					
				// 建立模型Dialog相關設定
				create_dialog = $("#dialog-form-create").dialog({
					draggable : false,//防止拖曳
					resizable : false,//防止縮放
					autoOpen : false,
					show : {
						effect : "blind",
						duration : 1000
					},
					hide : {
						effect : "explode",
						duration : 1000
					},
					width : 'auto',
					modal : true,
					buttons : [{
								id : "create",
								text : "建立",
								click : function() {
		// 							if ($('#insert-dialog-form-post').valid()) {
										$.ajax({
											type : "POST",
											url : "finModel.do",
											data : {
												action : "create",
												case_name : $("#dialog-form-create input[name='case_name']").val(),
												amount : $("#dialog-form-create input[name='amount']").val(),
												safety_money : $("#dialog-form-create input[name='safety_money']").val()
											},
											success : function(result) {
	// 											alert("success");
												var json_obj = $.parseJSON(result);
												var result_table = "";
												$.each(json_obj,function(i, item) {
													result_table += 
															"<tr><td>"+json_obj[i].case_name+"</td><td>"+json_obj[i].create_date+"</td><td>"
														+ "<button value='"+ json_obj[i].case_id+"' name='"+ json_obj[i].case_id
														+ "' class='btn_update btn btn-wide btn-primary btn_delete'>刪除</button></td></tr>";
												});
												//判斷查詢結果
												var resultRunTime = 0;
												$.each (json_obj, function (i) {
													resultRunTime+=1;
												});
												$("#fincase-table-user").dataTable().fnDestroy();
												if(resultRunTime!=0){
													$("#fincase-table-user tbody").html(result_table);
													//$("#products").dataTable({"bFilter": false, "bInfo": false, "paging": false, "language": {"url": "js/dataTables_zh-tw.txt","zeroRecords": "沒有符合的結果"}});
													$(".validateTips").text("");
												}else{
													$(".validateTips").text("查無此結果");
												}
											}
										});
										create_dialog.dialog("close");
		// 							}
								}
							}, {
								text : "取消",
								click : function() {
	// 								validator_insert.resetForm();
	// 								$("#insert-dialog-form-post").trigger("reset");
									create_dialog.dialog("close");
								}
							} ],
					close : function() {
	// 					validator_insert.resetForm();
	// 					$("#insert-dialog-form-post").trigger("reset");
					}
				}); 
				
				// onload時帶入fincase資料
				$.ajax({
					type : "POST",
					url : "finModel.do",
					data : {
						action : "onload"
					},
					success : function(result) {
						var json_obj = $.parseJSON(result);
						var result_table = "";
						$.each(json_obj,function(i, item) {
							result_table += 
									"<tr><td>"+json_obj[i].case_name+"</td><td>"+json_obj[i].create_date+"</td><td>"
								+ "<button value='"+ json_obj[i].case_id+"' name='user_query'"
								+ "' class='btn_query btn_update btn btn-wide btn-primary'>查看</button></td><td>"
								+ "<button value='"+ json_obj[i].case_id+"' name='"+ json_obj[i].case_id
								+ "' class='btn-simu btn btn-wide btn-primary'>產生</button></td></tr>";
						});					
						//判斷查詢結果
						var resultRunTime = 0;
						$.each (json_obj, function (i) {
							resultRunTime+=1;
						});
						$("#fincase-table-user").dataTable().fnDestroy();
						if(resultRunTime!=0){
							$("#fincase-table-user tbody").html(result_table);
							//$("#products").dataTable({"bFilter": false, "bInfo": false, "paging": false, "language": {"url": "js/dataTables_zh-tw.txt","zeroRecords": "沒有符合的結果"}});
							$(".validateTips").text("");
						}else{
							$(".validateTips").text("查無此結果");
						}
					}
				});
				
				// 查看財務計畫 事件聆聽
				$("#fincase-table-user").delegate(".btn_query", "click", function() {
					uuid = $(this).val();					
					$.ajax({
						type : "POST",
						url : "finModel.do",
						data : {
							action : "case_query",
							case_id: uuid
						},
						success : function(result) {
// 							alert("uuid:" + uuid);
// 							alert("success");
							$("#fincase-div-user").hide();
							$("#finsimu-div-user").show();
							$("#gen-simu-button").prop('name', uuid);
							$("#switch-simu-button").prop('name', uuid);
							$("#insert-simu-button").prop('name', uuid);
							$("#hidden_case_id").val(uuid);
// 							alert("hidden_case_id value: " + $("#hidden_case_id").val());
							var json_obj = $.parseJSON(result);
							var result_table = "";
							$.each(json_obj,function(i, item) {
								result_table 
									+= "<tr>"
									+ "<td id='f_date_"+i+"'>"+ json_obj[i].f_date+ "</td>"
									+ "<td id='f_type_"+i+"'>"+ json_obj[i].f_type+ "</td>"
									+ "<td id='action_"+i+"'>"+ json_obj[i].action+ "</td>"
									+ "<td id='amount_"+i+"'>"+ json_obj[i].amount+ "</td>"
									+ "<td id='f_kind_"+i+"'>"+ json_obj[i].f_kind+ "</td>"
									+ "<td id='description_"+i+"'>"+ json_obj[i].description+ "</td>"
									+ "<td id='strategy_"+i+"'>"+ json_obj[i].strategy+ "</td>"
									+ "<td><button id='"+i+"' value='"+ json_obj[i].simulation_id+"' name='"+ json_obj[i].case_id
									+ "' class='btn_query btn_update btn btn-wide btn-primary'>修改</button>"
									+ "<button value='"+ json_obj[i].simulation_id+"' name='"+ json_obj[i].case_id
									+ "' class='btn_delete btn btn-wide btn-primary'>刪除</button></td></tr>";
							});		
							//判斷查詢結果
							var resultRunTime = 0;
							$.each (json_obj, function (i) {
								resultRunTime+=1;
							});
							$("#finsimu-table-user").dataTable().fnDestroy();
							if(resultRunTime!=0){
								$("#finsimu-table-user tbody").html(result_table);
								//$("#products").dataTable({"bFilter": false, "bInfo": false, "paging": false, "language": {"url": "js/dataTables_zh-tw.txt","zeroRecords": "沒有符合的結果"}});
								$(".validateTips").text("");
							}else{
								$(".validateTips").text("查無此結果");
							}
						}
					});					
				});
				
				
				//新增事件聆聽
				$("#insert-simu-button").click(function(e) {
					uuid = $(this).attr('name');
					e.preventDefault();		
					insert_dialog.dialog("open");
				});
				
				// "新增" Dialog相關設定
				insert_dialog = $("#dialog-form-insert").dialog({
					draggable : false,//防止拖曳
					resizable : false,//防止縮放
					autoOpen : false,
					show : {
						effect : "blind",
						duration : 1000
					},
					hide : {
						effect : "explode",
						duration : 1000
					},
					width : 'auto',
					modal : true,
					buttons : [{
						id : "insert",
						text : "新增",
						click : function() {
// 							if ($('#insert-dialog-form-post').valid()) {
								$.ajax({
									type : "POST",
									url : "finModel.do",
									data : {
										action : "insert",
			 							case_id: uuid,
			 							f_date : $("#dialog-form-insert input[name='f_date']").val(),
			 							f_type : $("#dialog-form-insert input[name='f_type']").val(),
			 							p_action : $("#dialog-form-insert input[name='action']").val(),
			 							amount : $("#dialog-form-insert input[name='amount']").val(),
			 							f_kind : $("#dialog-form-insert input[name='f_kind']").val(),
										description : $("#dialog-form-insert input[name='description']").val(),
										strategy : $("#dialog-form-insert input[name='strategy']").val()
									},
									success : function(result) {
										var json_obj = $.parseJSON(result);
										var result_table = "";
										$.each(json_obj,function(i, item) {
											result_table 
												+= "<tr>"
												+ "<td id='f_date_"+i+"'>"+ json_obj[i].f_date+ "</td>"
												+ "<td id='f_type_"+i+"'>"+ json_obj[i].f_type+ "</td>"
												+ "<td id='action_"+i+"'>"+ json_obj[i].action+ "</td>"
												+ "<td id='amount_"+i+"'>"+ json_obj[i].amount+ "</td>"
												+ "<td id='f_kind_"+i+"'>"+ json_obj[i].f_kind+ "</td>"
												+ "<td id='description_"+i+"'>"+ json_obj[i].description+ "</td>"
												+ "<td id='strategy_"+i+"'>"+ json_obj[i].strategy+ "</td>"
												+ "<td><button id='"+i+"' value='"+ json_obj[i].simulation_id+"' name='"+ json_obj[i].case_id
												+ "' class='btn_query btn_update btn btn-wide btn-primary'>修改</button>"
												+ "<button value='"+ json_obj[i].simulation_id+"' name='"+ json_obj[i].case_id
												+ "' class='btn_delete btn btn-wide btn-primary'>刪除</button></td></tr>";
										});		
										//判斷查詢結果
										var resultRunTime = 0;
										$.each (json_obj, function (i) {
											resultRunTime+=1;
										});
										$("#finsimu-table-user").dataTable().fnDestroy();
										if(resultRunTime!=0){
											$("#finsimu-table-user tbody").html(result_table);
											//$("#products").dataTable({"bFilter": false, "bInfo": false, "paging": false, "language": {"url": "js/dataTables_zh-tw.txt","zeroRecords": "沒有符合的結果"}});
											$(".validateTips").text("");
										}else{
											$(".validateTips").text("查無此結果");
										}
									}
								});
								insert_dialog.dialog("close");
// 							}
						}
					}, {
						text : "取消",
						click : function() {
// 							validator_insert.resetForm();
// 							$("#insert-dialog-form-post").trigger("reset");
							insert_dialog.dialog("close");
						}
					} ],
					close : function() {
// 						validator_insert.resetForm();
// 						$("#insert-dialog-form-post").trigger("reset");
						insert_dialog.dialog("close");
					}
				});
				
				// 修改 事件聆聽
				$("#finsimu-table-user").delegate(".btn_update", "click", function(e) {
					e.preventDefault();
					var p_simulation_id = $(this).val();
					var p_case_id = $(this).attr('name');
					row = $(this).attr("id");
// 					$("#dialog-form-update input[name='customer_id']").val(customer_id);
					$("#dialog-form-update input[name='f_date']").val($('#f_date_'+row).html());
					$("#dialog-form-update input[name='f_type']").val($('#f_type_'+row).html());
					$("#dialog-form-update input[name='action']").val($('#action_'+row).html());
					$("#dialog-form-update input[name='amount']").val($('#amount_'+row).html());
					$("#dialog-form-update input[name='f_kind']").val($('#f_kind_'+row).html());
					$("#dialog-form-update input[name='description']").val($('#description_'+row).html());
					$("#dialog-form-update input[name='strategy']").val($('#strategy_'+row).html());
					$("#dialog-form-update input[name='simulation_id']").val(p_simulation_id);
					$("#dialog-form-update input[name='case_id']").val(p_case_id);
					update_dialog.dialog("open");
				});
				
				// "修改" Dialog相關設定
				update_dialog = $("#dialog-form-update").dialog({
					draggable : false,//防止拖曳
					resizable : false,//防止縮放
					autoOpen : false,
					width : 'auto',
					modal : true,
					buttons : [{
						text : "修改",
						click : function() {
							update_dialog.dialog("close");						
						}
					}, {
						text : "取消",
						click : function() {
							update_dialog.dialog("close");
						}
					} ],
					close : function() {
						validator_update.resetForm();
					}
				});
				
				//刪除事件聆聽 : 因為聆聽事件動態產生，所以採用delegate來批量處理，節省資源
				$("#finsimu-table-user").delegate(".btn_delete", "click", function() {
					var p_simulation_id = $(this).val();
					var p_case_id = $(this).attr('name');
					$("#delete_case_id").val(p_case_id);
					$("#delete_simu_id").val(p_simulation_id);
					confirm_dialog.dialog("open");
				});
				// "刪除" Dialog相關設定
				confirm_dialog = $("#dialog-confirm").dialog({
					draggable : false,//防止拖曳
					resizable : false,//防止縮放
					autoOpen : false,
					height : 'auto',
					modal : true,
					buttons : {
						"確認刪除" : function() {
							$.ajax({
								type : "POST",
								url : "finModel.do",
								data : {
									action : "delete",
									case_id : $("#delete_case_id").val(),
									simulation_id : $("#delete_simu_id").val()
								},
								success : function(result) {
									var json_obj = $.parseJSON(result);
									var result_table = "";
									$.each(json_obj,function(i, item) {
										result_table 
											+= "<tr>"
											+ "<td id='f_date_"+i+"'>"+ json_obj[i].f_date+ "</td>"
											+ "<td id='f_type_"+i+"'>"+ json_obj[i].f_type+ "</td>"
											+ "<td id='action_"+i+"'>"+ json_obj[i].action+ "</td>"
											+ "<td id='amount_"+i+"'>"+ json_obj[i].amount+ "</td>"
											+ "<td id='f_kind_"+i+"'>"+ json_obj[i].f_kind+ "</td>"
											+ "<td id='description_"+i+"'>"+ json_obj[i].description+ "</td>"
											+ "<td id='strategy_"+i+"'>"+ json_obj[i].strategy+ "</td>"
											+ "<td><button id='"+i+"' value='"+ json_obj[i].simulation_id+"' name='"+ json_obj[i].case_id
											+ "' class='btn_query btn_update btn btn-wide btn-primary'>修改</button>"
											+ "<button value='"+ json_obj[i].simulation_id+"' name='"+ json_obj[i].case_id
											+ "' class='btn_delete btn btn-wide btn-primary'>刪除</button></td></tr>";
									});					
									//判斷查詢結果
									var resultRunTime = 0;
									$.each (json_obj, function (i) {
										resultRunTime+=1;
									});
									$("#finsimu-table-user").dataTable().fnDestroy();
									if(resultRunTime!=0){
										$("#finsimu-table-user tbody").html(result_table);
										//$("#products").dataTable({"bFilter": false, "bInfo": false, "paging": false, "language": {"url": "js/dataTables_zh-tw.txt","zeroRecords": "沒有符合的結果"}});
										$(".validateTips").text("");
									}else{
										$(".validateTips").text("查無此結果");
									}
								}
							});
							$(this).dialog("close");
						},
						"取消刪除" : function() {
							$(this).dialog("close");
						}
					}
				});

				// 切換至產生模擬資料頁面
				$("#switch-simu-button").click( function() {
					uuid = $(this).attr('name');
					$("#panel-user").hide();
					$("#panel-simu").show();
				});
				
				// 產生模擬資料
				$("#gen-simu-button").click( function() {
					uuid = $(this).attr('name');
// 					alert(uuid);
					$('body').css('cursor', 'progress');
					uuid = $("#switch-simu-button").attr('name');
					degree = $("#degree").val();
					blndel = document.querySelector('input[name="blndel"]:checked').value;
// 					alert("gen-simu-button uuid:" + uuid);
// 					alert("blndel: " + );
// 					alert("degree:" + degree);
					$.ajax({
						type : "POST",
						url : "finModel.do",
						data : {
							action : "gen_simu_data",
							case_id: uuid,
							degree: degree, 
							blndel:	blndel
						},
						success : function(result) {
// 							alert("success");
							$("#panel-user").show();
							$("#panel-simu").hide();
							$("body").css("cursor", "default");	
							var json_obj = $.parseJSON(result);
							var result_table = "";
							$.each(json_obj,function(i, item) {
								result_table 
									+= "<tr>"
									+ "<td id='f_date_"+i+"'>"+ json_obj[i].f_date+ "</td>"
									+ "<td id='f_type_"+i+"'>"+ json_obj[i].f_type+ "</td>"
									+ "<td id='action_"+i+"'>"+ json_obj[i].action+ "</td>"
									+ "<td id='amount_"+i+"'>"+ json_obj[i].amount+ "</td>"
									+ "<td id='f_kind_"+i+"'>"+ json_obj[i].f_kind+ "</td>"
									+ "<td id='description_"+i+"'>"+ json_obj[i].description+ "</td>"
									+ "<td id='strategy_"+i+"'>"+ json_obj[i].strategy+ "</td>"
									+ "<td><button id='"+i+"' value='"+ json_obj[i].simulation_id+"' name='"+ json_obj[i].case_id
									+ "' class='btn_query btn_update btn btn-wide btn-primary'>修改</button>"
									+ "<button value='"+ json_obj[i].simulation_id+"' name='"+ json_obj[i].case_id
									+ "' class='btn_delete btn btn-wide btn-primary'>刪除</button></td></tr>";
							});					
							//判斷查詢結果
							var resultRunTime = 0;
							$.each (json_obj, function (i) {
								resultRunTime+=1;
							});
							$("#finsimu-table-user").dataTable().fnDestroy();
							if(resultRunTime!=0){
								$("#finsimu-table-user tbody").html(result_table);
								//$("#products").dataTable({"bFilter": false, "bInfo": false, "paging": false, "language": {"url": "js/dataTables_zh-tw.txt","zeroRecords": "沒有符合的結果"}});
								$(".validateTips").text("");
							}else{
								$(".validateTips").text("查無此結果");
							}
						}
					});	
				});
				
				// 產生模擬圖
				$("#gen_d3js_button").click( function() {
					uuid = $("#hidden_case_id").val();
// 					alert(uuid);
					$.ajax({
						type : "POST",
						url : "finModel.do",
						data : {
							action : "gen_d3js",
							case_id: uuid
						},
						success : function(result) {
							var obj = JSON.parse(result);
							var income = obj[0].income;
							var outlay = obj[1].outlay;
							var detailData = obj[2].detailData;
							var fincase = obj[3].fincase;
							var totalIncome = obj[4].totalIncome;
							var totalOutlay = obj[5].totalOutlay;
							genSimuGraph(income, outlay, detailData, fincase, totalIncome, totalOutlay);
						}
					});	
				});
				
				// 產生模擬圖
				$("#fincase-table-user").delegate(".btn-simu", "click", function() {
// 					alert("click");
					uuid = $(this).val();
// 					alert(uuid);
					$.ajax({
						type : "POST",
						url : "finModel.do",
						data : {
							action : "gen_d3js",
							case_id: uuid
						},
						success : function(result) {
							var obj = JSON.parse(result);
							var income = obj[0].income;
							var outlay = obj[1].outlay;
							var detailData = obj[2].detailData;
							var fincase = obj[3].fincase;
							var totalIncome = obj[4].totalIncome;
							var totalOutlay = obj[5].totalOutlay;
							genSimuGraph(income, outlay, detailData, fincase, totalIncome, totalOutlay);
						}
					});	
				});
			})
// 			alert("user");
		</script>
	</c:if>
<!-- /**************************************  以上使用者JS區塊    *********************************************/	-->
		
	<div class="content-wrap">
		<ul class="tab">
			<li><a href="#" class="tablinks" onclick="openTab(event, 'finTool')">財務評估工具</a></li>
			<li><a href="#" class="tablinks" onclick="openTab(event, 'simuGraph')">模擬圖</a></li>
		</ul>

		<div id="finTool" class="tabcontent">
			<!--==================    財務評估工具 (管理者)    ==================-->
	       	<c:if test="${sessionScope.role==1}">
				<div id="panel-manage" class="panelWrap">
				    <div class="panel-title">
				        <h2>財務評估工具</h2>
				    </div>
				    <!-- /.panel-title -->			
					<div class="panel-content">
					    <div id="divAdminTable" class="datalistWrap">
					        <div class="row">
					            <table id="fincase-table-admin" class="formTable aCenter">
									<thead>
										<tr>
											<th>案件名稱</th>
											<th>案件產生日期</th>
											<th>產生模擬圖</th>
										</tr>
									<thead>
									<tbody>
									</tbody>
								</table><br/>
					        </div>
				   			<div class="btn-control aCenter">
					       		<input id="create-model-button" name="" class="btn btn-primary btn-lg" type="button" value="建立模型" />
	<!-- 				       		<input class="btn btn-primary btn-lg" type="button" value="產生模擬圖" onclick="adminQuery('graph');" /> -->
				        	</div>
				   		</div>	
				    </div>
				</div>
       		</c:if>
			
			<!--==================    財務評估工具 (使用者)    ==================-->
        	<c:if test="${sessionScope.role==0}">
				<div id="panel-user" class="panelWrap">
				    <div class="panel-title">
				        <h2>財務評估工具</h2>
				    </div>
				    <div class="panel-content">
				        <div id="fincase-div-user" class="datalistWrap">
				            <div class="row">
				                <table id="fincase-table-user" class="formTable aCenter">
									<thead>
										<tr>
											<th>案件名稱</th>
											<th>案件產生日期</th>
											<th>財務計畫</th>
											<th>產生模擬圖</th>
										</tr>
									<thead>
									<tbody>
									</tbody>
								</table>
				           	</div>			
				        </div>   
				        <div id="finsimu-div-user" class="datalistWrap" style="display:none;">
				            <div id="div01" class="datalistWrap"> 
				                <div class="divMargin aCenter">				    
			                		<input type="hidden" id="hidden_case_id" name="hidden_case_id" />                
				                    <input id="insert-simu-button" type="button" class="btn btn-primary btn-lg" value="新增" />
				                    <input id="gen_d3js_button" type="button" class="btn btn-primary btn-lg" value="產生模擬圖" />
				                    <input id="switch-simu-button" type="button" class="btn btn-primary btn-lg" value="產生模擬資料" />		
				                    <input type="button" class="btn btn-primary btn-lg btn-red" value="回上頁" onClick="location.reload()" />     
				                </div>					                
				                <div class="row">
				                    <table id="finsimu-table-user" class="formTable aCenter">
				                    	<thead>
				                    		<tr>
				                    			<th>資金動態日期</th>
				                    			<th>動態類別</th>
				                    			<th>實際/模擬</th>
				                    			<th>資金金額</th>
				                    			<th>資金動態類別</th>
				                    			<th>資金動態說明</th>
				                    			<th>策略因應說明</th>
				                    			<th>功能</th>
				                    		</tr>
				                    	</thead>
				                    	<tbody>
										</tbody>  
									</table> 
				                </div>
				            </div>
				        </div>     
				    </div>
				</div>     		

			    <div id="panel-simu" class="panelWrap" style="display:none;">
					<div class="panel-title">
				        <h2>產生模擬資料</h2>
				    </div>
				    <div class="panel-content">
				    	<div class="datalistWrap">
				            <div class="datalistWrap aCenter">
				                <div class="row">
				                	<p>
								    	<label>產生比例:</label>
					                    <select id="degree" name="degree">
							    			<option value="1">1</option>
											<option value="2">2</option>
							    			<option value="3">3</option>
											<option value="4">4</option>
							    			<option value="5">5</option>
											<option value="6">6</option>
							    			<option value="7">7</option>
											<option value="8">8</option>
							    			<option value="9">9</option>
							    		</select> 
				                    </p>           
				                    <p>
								    	<label>舊模擬資料是否刪除:</label>
					                    <input type="radio" name="blndel" value="Y" checked>是&nbsp;&nbsp;&nbsp; 
									    <input type="radio" name="blndel" value="N" >否<br/>  
				                    </p>                                      
				            	</div>
				                <div class="divMargin">				                	
				                    <input id="gen-simu-button" type="button" class="btn btn-primary btn-lg" value="產生模擬資料" />	
					                <input type="button" class="btn btn-primary btn-lg btn-red" value="回上頁" onClick="location.reload()" />
					                <input type="hidden" name="user_action" value="sim"/>
				                </div>	                
				            </div>
				        </div>
				    </div> 
				</div>
       		</c:if>
		</div>
		
		<div id="simuGraph" class="tabcontent">         
       		<div class="content">
       			<div id="z" style="margin-left: 100px"></div>
			</div>
		</div>
		
		<c:if test="${sessionScope.role==1}">
			<!--對話窗樣式- 建立模型 -->
			<div id="dialog-form-create" title="建立模型" style="display:none">
				<form name="create-dialog-form-post" id="create-dialog-form-post">
					<fieldset>
						<table style="border-collapse: separate;border-spacing: 10px 20px;">
							<tr>
								<td><p>案件名稱：</p></td>
								<td><input type="text" id="case_name" name="case_name"></td>
								<td><p>期初資金：</p></td>
								<td><input type="text" id="amount" name="amount"></td>
							</tr>
							<tr>
								<td><p>資金安全餘額： </p></td>
								<td><input type="text" id="safety_money" name="safety_money"></td>
								<td></td>
								<td></td>
							</tr>
						</table>
					</fieldset>
				</form>
			</div>
		</c:if>
		<c:if test="${sessionScope.role==0}">
			<!--對話窗樣式-新增 -->
			<div id="dialog-form-insert" title="新增資料" style="display:none">
				<form name="insert-dialog-form-post" id="insert-dialog-form-post" style="display:inline">
					<fieldset>
						<table style="border-collapse: separate;border-spacing: 10px 20px;">
							<tbody>
								<tr>
									<td><p>資金動態日期：</p></td>
									<td><input type="text" id="insert_f_date" name="f_date"></td>
									<td><p>動態類別：</p></td>
									<td><input type="text" id="insert_f_type" name="f_type"></td>
								</tr>
								<tr>
									<td><p>實際/模擬：</p></td>
									<td><input type="text" id="insert_action" name="action"></td>
									<td><p>資金金額：</p></td>
									<td><input type="text" id="insert_amount" name="amount"></td>
								</tr>
								<tr>
									<td><p>資金動態類別：</p></td>
									<td><input type="text" id="insert_f_kind" name="f_kind"></td>
									<td><p>資金動態說明：</p></td>
									<td><input type="text" id="insert_description" name="description"></td>
								</tr>
								<tr>
									<td><p>策略因應說明：</p></td>
									<td><input type="text" id="insert_strategy" name="strategy"></td>
									<td></td>
									<td><input type="hidden" id="insert_case_id" name="case_id"></td>
								</tr>
							</tbody>
						</table>	
					</fieldset>
				</form>
			</div>	
				
			<!--對話窗樣式-修改 -->
			<div id="dialog-form-update" title="修改資料" style="display:none">
				<form name="update-dialog-form-post" id="update-dialog-form-post">
					<fieldset>
						<table style="border-collapse: separate;border-spacing: 10px 20px;">
							<tbody>
								<tr>
									<td><p>資金動態日期：</p></td>
									<td><input type="text" id="edit_f_date" name="f_date"></td>
									<td><p>動態類別：</p></td>
									<td><input type="text" id="edit_f_type" name="f_type"></td>
								</tr>
								<tr>
									<td><p>實際/模擬：</p></td>
									<td><input type="text" id="edit_action" name="action"></td>
									<td><p>資金金額：</p></td>
									<td><input type="text" id="edit_amount" name="amount"></td>
								</tr>
								<tr>
									<td><p>資金動態類別：</p></td>
									<td><input type="text" id="edit_f_kind" name="f_kind"></td>
									<td><p>資金動態說明：</p></td>
									<td><input type="text" id="edit_description" name="description"></td>
								</tr>
								<tr>
									<td><p>策略因應說明：</p></td>
									<td><input type="text" id="edit_strategy" name="strategy"></td>
									<td><input type="hidden" id="edit_simulation_id" name="simulation_id"></td>
									<td><input type="hidden" id="edit_case_id" name="case_id"></td>
								</tr>
							</tbody>
						</table>	
					</fieldset>
				</form>
			</div>	
			
			<!--對話窗樣式-確認 -->
			<div id="dialog-confirm" title="確認刪除資料嗎?" style="display:none">
				<p>是否確認刪除該筆資料</p>
				<input id="delete_simu_id" type="hidden">
				<input id="delete_case_id" type="hidden">
			</div>	
		</c:if>
	</div>

<script>

function genSimuGraph(income, outlay, detailData, fincase, totalIncome, totalOutlay){
	
	d3.select("svg").remove();
	var outputDetail = [];
	var outputIncome = [];
	var outputOutlay = [];
	var outputAlarm = [];
	var firstDate;
	var endDate;
	var alarm = 0;
	var balance = 0;
	var maxAmount = 0;

		if(income.length>0){
	        var parseDate = d3.time.format("%Y-%m-%d").parse;
			alarm = Number(fincase[0].safety_money);
			balance = Number(fincase[0].Amount);

			//　取出Ｘ軸的最早日期及最晚日期
			firstDate = fincase[0].create_date;
			endDate = income[income.length-1].date;
			if (Date.parse(endDate) > Date.parse(outlay[outlay.length-1].date)){
				endDate = outlay[outlay.length-1].date;
			}

			// 如果第一筆收入日期大於期初日期，將期初資金及期初日期塞進 收入 的第一筆資料
			if (Date.parse(income[0].date) > Date.parse(fincase[0].create_date)){
				var firstIncome = "{\"date\":\"" + fincase[0].create_date + "\", \"pv\":\"" + fincase[0].Amount + "\"}";
				outputIncome.push(JSON.parse(firstIncome));
				outputDetail.push(JSON.parse(firstIncome));
				for(i=0;i<income.length;i++){
					var incomeData = "{\"date\":\"" + income[i].date + "\", \"pv\":\"" + income[i].pv + "\"}";
					outputIncome.push(JSON.parse(incomeData));
					outputDetail.push(JSON.parse(incomeData));
					if(Number(income[i].pv) > maxAmount){
						maxAmount = Number(income[i].pv);
					}
				}	
			}
			else{	
				var initial =  Number(fincase[0].Amount) + Number(income[0].pv);
				var firstIncome = "{\"date\":\"" + fincase[0].create_date + "\", \"pv\":\"" + initial + "\"}";
				outputIncome.push(JSON.parse(firstIncome));
				outputDetail.push(JSON.parse(firstIncome));
				if(initial > maxAmount){
						maxAmount = initial;
				}
			
				for(i=1;i<income.length;i++){
					var incomeData = "{\"date\":\"" + income[i].date + "\", \"pv\":\"" + income[i].pv + "\"}";
					outputIncome.push(JSON.parse(incomeData));
					outputDetail.push(JSON.parse(incomeData));
					if(Number(income[i].pv) > maxAmount){
						maxAmount = Number(income[i].pv);
					}
				}			
			}
					
			// 以下處理支出資料
			for(j=0;j<outlay.length;j++){
				var outlayData = "{\"date\":\"" + outlay[j].date + "\", \"pv\":\"" + outlay[j].pv + "\"}";
				outputOutlay.push(JSON.parse(outlayData));
				outputDetail.push(JSON.parse(outlayData));

				if(Math.abs(Number(outlay[j].pv)) > maxAmount){
					maxAmount = Number(outlay[j].pv);
				}
			}	
			
			// 以下處理安全警戒線
			for(k=0;k<detailData.length;k++){
				balance = Number(detailData[k].pv) + balance;
				if(balance<=alarm){
					var alarmData1 = "{\"date\":\"" + detailData[k].date + "\", \"pv\":\"" + 0 + "\"}";
					var alarmData2 = "{\"date\":\"" + detailData[k].date + "\", \"pv\":\"" + maxAmount + "\"}";
					outputAlarm.push(JSON.parse(alarmData1));
					outputAlarm.push(JSON.parse(alarmData2));	
					break;	
				}
			}	
		}

//	    alert(JSON.stringify(outputDetail));
	CreateLines(outputIncome, outputOutlay, outputAlarm);

	function CreateLines(item1,item2,item3){
	    var dataset = [];
	    var lines = [];//保存折线图对象
	    var lineNames=["收入","支出","資金安全餘額"];//保存系列名称
	    var lineColor = ["#0F0","#09F","#F00"];
	    var currentLineNum = 0;
	    var maxdata;//y轴最大值
	    var margin = {top: 20, right: 80, bottom: 50, left: 80};
	    var width = 960;
	    var height = 450;

	    getData();
	    currentLineNum = dataset.length;
	    maxdata = getMaxData(dataset);
	    getDetailData(outputDetail);
	    
	    var svg = d3.select("#z").append("svg")
	    .attr("width", width + margin.left + margin.right)							
	    .attr("height", height + margin.top + margin.bottom);

	    var xScale = d3.time.scale()
//	    				.domain([firstDate, endDate])
	   					.domain([d3.min(outputDetail, function(d) { return d.date; }),d3.max(outputDetail, function(d) { return d.date; })])
	    				.range([0, width - margin.left - margin.right]);		
	    var yScale = d3.scale.linear()
					    .domain([0,maxdata])
					    .range([height - margin.top - margin.bottom, 0]);
	    var xAxis = d3.svg.axis()
					    .scale(xScale)
					    .orient("bottom")
					    .tickFormat(d3.time.format('%Y-%m-%d'));				  
	    var yAxis = d3.svg.axis()
					    .scale(yScale)
					    .orient("left");
	    
	    svg.append("g")
	        .attr("class","axis")
	        .attr("transform","translate(" + margin.left + "," + (height - margin.bottom) + ")")
	        .call(xAxis)
			.selectAll("text")
			.attr("transform", "rotate(65)")
			.style("text-anchor", "start")
	        .append('text')
	        .text("時間")
	        .attr('transform', 'translate(' + (width - margin.left - margin.right-20) + ', 0)');
	        
	    svg.append("g")
	        .attr("class","axis")
	        .attr("transform","translate(" + (margin.left)+ "," + margin.top + ")")
	        .call(yAxis)
	        .append('text')
	        .text("金額");
	    
	    svg.append('g').selectAll('text')
	                 .data(dataset).enter().append('text')
	                 .attr({'x': (width - margin.right) ,'y':30 }).text("總收入："+totalIncome)
	                 .attr("fill", "#0F0")
	                 .attr("font-size", "16px");
	    
	    svg.append('g').selectAll('text')
	                 .data(dataset).enter().append('text')
	                 .attr({'x':(width - margin.right) ,'y':60 }).text("總支出："+totalOutlay)
	                 .attr("fill", "#09F")
	                 .attr("font-size", "16px");
	    
	    svg.append('g').selectAll('text')
	                 .data(dataset).enter().append('text')
	                 .attr({'x':(width - margin.right) ,'y':90 }).text("資金安全餘額："+ alarm)
	                 .attr("fill", "#F00")
	                 .attr("font-size", "16px");
	    addlegend();

	    for(i=0;i<currentLineNum;i++){
	        var newLine=new CreateLineObject();
	        newLine.init(i);
	        lines.push(newLine);		
	    }	
	    function CreateLineObject(){

	        this.init = function(id){
	        	if(id<2){
		            var arr = dataset[id];
		            xScale = d3.time.scale()
		                .domain([d3.min(outputDetail, function(d) { return d.date; }),d3.max(outputDetail, function(d) { return d.date; })])
		                .range([0, width - margin.left - margin.right]);	        
		            var line = d3.svg.line()
						            .x(function(d) { return xScale(d.date); })
						            .y(function(d) { return yScale(d.pv); })
						            .interpolate('linear');
		            svg.append("path")
		                .datum(arr)
		                .attr("transform","translate(" + margin.left + "," +  margin.top  + ")")
		                .attr("class", "line")
		                .transition()
		                .ease("elastic")
		                .duration(1000)
		                .delay(function(d,j){
		                return 200*j;
		            	})
		                .style("stroke",lineColor[id])
		                .attr("d", line)
		            ;
		            svg.append('g').selectAll('circle')
		                .data(arr)
		                .enter() 
		                .append('circle')
		                .on('mouseover', function(d) {
		                d3.select(this).transition().duration(500).attr('r', 5);
		                d3.select('.tips').style('display', 'block');
		                var tx = parseFloat(d3.select(this).attr("cx"));
		                var ty = parseFloat(d3.select(this).attr("cy"));	
		                var tipRectx = tx+60+180>width?tx+10-180:tx+60,
		                    tipRecty= ty+20+60>height?ty+10-60:ty+20;
		                var theDate = d3.time.format('%Y-%m-%d')(d.date);
		                var thePv= d.pv;
		                var tips = svg.append("g")
		                .attr("id","tips");
		                var tipRect = tips.append("rect")
		                .attr("x",tipRectx)
		                .attr("y",tipRecty)
		                .attr("width",180)
		                .attr("height",60)
		                .attr("fill","#FFF")
		                .attr("stroke","#CCC")
		                var tipText = tips.append("text")
		                .attr("class","tiptools")
		                .text("日期: "+theDate)
		                .attr("x",tipRectx+20)
		                .attr("y",tipRecty+20);
		                var tipText = tips.append("text")
		                .attr("class","tiptools")
		                .text("金額: "+thePv)
		                .attr("x",tipRectx+20)
		                .attr("y",tipRecty+50);
		            })
		                .on('mouseout', function() {
		                d3.select(this).transition().duration(500).attr('r', 3.5);
		                d3.select('.tips').style('display', 'none');
		                d3.select("#tips").remove();
		            })
		                .transition()
		                .ease("elastic")
		                .duration(1000)
		                .delay(function(d,j){
		                return 200*j;
		            })
		                .attr("transform","translate(" + margin.left + "," +  margin.top  + ")")
		                .attr('cx', line.x())
		                .attr('cy', line.y())
		                .attr('r', 5)
		                .attr("fill",lineColor[id]);
		        } else {
		            var arr = dataset[id];
		            var arr1 = dataset[1];
		            xScale = d3.time.scale()
		                .domain([d3.min(outputDetail, function(d) { return d.date; }),d3.max(outputDetail, function(d) { return d.date; })])
		                .range([0, width - margin.left - margin.right]);	        
		            var line = d3.svg.line()
		            .x(function(d) { return xScale(d.date); })
		            .y(function(d) { return yScale(d.pv); })
		            .interpolate('linear');
		            svg.append("path")
		                .datum(arr)
		                .attr("transform","translate(" + margin.left + "," +  margin.top  + ")")
		                .attr("class", "line")
		                .transition()
		                .ease("elastic")
		                .duration(1000)
		                .delay(function(d,j){
		                return 200*j;
		            	})
		                .style("stroke",lineColor[id])
		                .attr("d", line)
		            ;
		            svg.append('g').selectAll('circle')
		                .data(arr)
		                .enter() 
		                .append('circle')
		                .on('mouseover', function(d) {
		                d3.select(this).transition().duration(500).attr('r', 5);
		                d3.select('.tips').style('display', 'block');
		                var tx = parseFloat(d3.select(this).attr("cx"));
		                var ty = parseFloat(d3.select(this).attr("cy"));	
		                var tipRectx = tx+60+180>width?tx+10-180:tx+60,
		                    tipRecty= ty+20+60>height?ty+10-60:ty+20;
		                var theDate = d3.time.format('%Y-%m-%d')(d.date);
		                var thePv= d.pv;
		                var tips = svg.append("g")
		                .attr("id","tips");
		                var tipRect = tips.append("rect")
		                .attr("x",tipRectx)
		                .attr("y",tipRecty)
		                .attr("width",180)
		                .attr("height",30)
		                .attr("fill","#FFF")
		                .attr("stroke","#CCC")
		                var tipText = tips.append("text")
		                .attr("class","tiptools")
		                .text("日期: "+theDate)
		                .attr("x",tipRectx+20)
		                .attr("y",tipRecty+20);
		            })
		                .on('mouseout', function() {
		                d3.select(this).transition().duration(500).attr('r', 3.5);
		                d3.select('.tips').style('display', 'none');
		                d3.select("#tips").remove();
		            })
		                .transition()
		                .ease("elastic")
		                .duration(1000)
		                .delay(function(d,j){
		                return 200*j;
		            })
		                .attr("transform","translate(" + margin.left + "," +  margin.top  + ")")
		                .attr('cx', line.x())
		                .attr('cy', line.y())
		                .attr('r', 5)
		                .attr("fill",lineColor[id]);
		        }
	        }
	    }

	    function getData(){
	        dataset.push(item1);
	        dataset.push(item2);
	        if(item3.length>0){
	        	dataset.push(item3);
	        }
	    }
	    function getMaxData(arr){
	        var maxdata = 0;
	        var parseDate = d3.time.format("%Y-%m-%d").parse;
	        for(var i =0;i<arr.length;i++){
	            arr[i].forEach(function(d) {
	    			d.date = parseDate(d.date);
	                d.pv = + d.pv;
	        	});
	            dataset[i]=arr[i];
	            maxdata = d3.max([maxdata,d3.max(arr[i], function(d) { return d.pv; })]);
	        }
	        return maxdata;
	    }
	    function getDetailData(detailArr){
	        var parseDate = d3.time.format("%Y-%m-%d").parse;
	        detailArr.forEach(function(d) {
	    		d.date = parseDate(d.date);
	            d.pv = + d.pv;
	        });
	        outputDetail=detailArr;
	    }
	    function addlegend(){

	        var legend = svg.append('g');
	        legend.selectAll("text")
	            .data(lineNames)
	            .enter()
	            .append("text")
	            .text(function(d){return d;})
	            .attr("class","legend")
	            .attr("x", function(d,i) {return i*100;}) 
	            .attr("y",0)
	            .attr("fill",function(d,i){ return lineColor[i];});

	        legend.selectAll("rect")
	            .data(lineNames)
	            .enter()
	            .append("rect")
	            .attr("x", function(d,i) {return i*100-20;}) 
	            .attr("y",-10)
	            .attr("width",12)
	            .attr("height",12)
	            .attr("fill",function(d,i){ return lineColor[i];});
	        legend.attr("transform","translate("+((width-lineNames.length*100)/2)+","+(height+50)+")");	
	    }
	}
	openTab(event, 'simuGraph');
}
</script>
</body>
</html>
