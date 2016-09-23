<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">

<link rel="Shortcut Icon" type="image/x-icon" href="./images/Rockettheme-Ecommerce-Shop.ico" />
<link rel="stylesheet" href="css/styles.css" />
<link href="css/jquery-ui-1.12.0/jquery-ui.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="css/jquery-ui-1.12.0/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/additional-methods.min.js"></script>
<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>

<%
	String group_id = (String) session.getAttribute("group_id");
	String user_id = (String) session.getAttribute("user_id");
	Integer role = (Integer) session.getAttribute("role");
%>
<title>新產品風向預測</title>

<script>
	$(function() {
		var user_count = 0;
		
		$( document ).ready(function() {
			mainLoad();
		});
		
		$("#create").click(function() {

		    $("#divMain").hide();
		    $("#div1").show();
			$("#div2").hide();
			$("#div3").hide();
			$("#divTest").hide();
		});
		
		$("#next1").click(function() {

			if ( !$(".customDiv1").valid() ) {
				return;
			}
			
			var func_no = $("#function_no").val(),
				nfunc_no = $("#nfunction_no").val(),
				serv_no = $("#service_no").val();
			
			for (var i = 1; i <= func_no; i++) {
// 				$("#function").append('<tr><td><input type="text" id="function_name-' + i + '" name="function_name-' + i + '"></td>' + 
// 						'<td><input type="text" id="function_score-' + i + '" name="function_score-' + i + '" value="0"></td></tr>');
				$("#function").append('<tr><td><select id="cmb-function_name-' + i + '" name="cmb-function_name-' + i + '"></select></td>' + 
						'<td><input type="text" id="function_score-' + i + '" name="function_score-' + i + '" value="0"></td></tr>');
			}
			
			for (var j = 1; j <= nfunc_no; j++) {
// 				$("#nfunction").append('<tr><td><input type="text" id="nfunction_name-' + j + '" name="nfunction_name-' + j + '"></td>' + 
// 						'<td><input type="text" id="nfunction_score-' + j + '" name="nfunction_score-' + j + '" value="0"></td></tr>');
				$("#nfunction").append('<tr><td><select id="cmb-nfunction_name-' + j + '" name="cmb-nfunction_name-' + j + '"></select></td>' + 
						'<td><input type="text" id="nfunction_score-' + j + '" name="nfunction_score-' + j + '" value="0"></td></tr>');
			}
			
			for (var k = 1; k <= serv_no; k++) {
// 				$("#service").append('<tr><td><input type="text" id="service_name-' + k + '" name="service_name-' + k + '"></td>' + 
// 						'<td><input type="text" id="service_score-' + k + '" name="service_score-' + k + '" value="0"></td></tr>');
				$("#service").append('<tr><td><select id="cmb-service_name-' + k + '" name="cmb-service_name-' + k + '"></select></td>' + 
						'<td><input type="text" id="service_score-' + k + '" name="service_score-' + k + '" value="0"></td></tr>');
			}
			
			//register event
			$( "[name^=function_score-]" ).blur(function() {
				checkDiv2("gt");
			});
			
			$( "[name^=nfunction_score-]" ).blur(function() {
				checkDiv2("gt");
			});
			
			$( "[name^=service_score-]" ).blur(function() {
				checkDiv2("gt");
			});
			
			//========== validate rules (dynamic) ==========
			$( ".customDiv2" ).validate();
			
			$("[name^=cmb-function_name-]").each(function(){
				$(this).rules("add", {
				  	required: true
				});
		   	});
			$("[name^=function_score-]").each(function(){
				$(this).rules("add", {
				  	required: true,
					digits: true
				});
		   	});
			
			$("[name^=cmb-nfunction_name-]").each(function(){
				$(this).rules("add", {
				  	required: true
				});   
		   	});
			$("[name^=nfunction_score-]").each(function(){
				$(this).rules("add", {
				  	required: true,
					digits: true
				});
		   	});
			
			$("[name^=cmb-service_name-]").each(function(){
				$(this).rules("add", {
				  	required: true
				});   
		   	});
			$("[name^=service_score-]").each(function(){
				$(this).rules("add", {
				  	required: true,
					digits: true
				});
		   	});
			
			$.ajax({
				type : "POST",
				url : "ProductForecastItem.do",
				data : {
					action : "getGroupAndKind",
					group_id : "6ec1fbf4-6c9c-11e5-ab77-000c29c1d067",
					item_kind : "func"
				},
				success : function(result) {
					console.log('ProductForecastItem.do success');
					console.log(result);
					var json_obj = $.parseJSON(result);
									
					$.each(json_obj, function(i, item) {
						console.log("i:" + i);
						console.log("item:" + item);
						console.log(json_obj[i].item_name);
// 						$("#combo").get(0).add(json_obj[i].item_name);
						$("[name^=cmb-function_name-]").append($('<option></option>').val(json_obj[i].item_name).html(json_obj[i].item_name));	
					});
				},
				error:function(e){
					console.log('btn1 click error');
				}
			});

			$.ajax({
				type : "POST",
				url : "ProductForecastItem.do",
				data : {
					action : "getGroupAndKind",
					group_id : "6ec1fbf4-6c9c-11e5-ab77-000c29c1d067",
					item_kind : "nfunc"
				},
				success : function(result) {
					console.log('ProductForecastItem.do success');
					console.log(result);
					var json_obj = $.parseJSON(result);
									
					$.each(json_obj, function(i, item) {
						console.log("i:" + i);
						console.log("item:" + item);
						console.log(json_obj[i].item_name);
// 						$("#combo").get(0).add(json_obj[i].item_name);
						$("[name^=cmb-nfunction_name-]").append($('<option></option>').val(json_obj[i].item_name).html(json_obj[i].item_name));	
					});
				},
				error:function(e){
					console.log('btn1 click error');
				}
			});

			$.ajax({
				type : "POST",
				url : "ProductForecastItem.do",
				data : {
					action : "getGroupAndKind",
					group_id : "6ec1fbf4-6c9c-11e5-ab77-000c29c1d067",
					item_kind : "service"
				},
				success : function(result) {
					console.log('ProductForecastItem.do success');
					console.log(result);
					var json_obj = $.parseJSON(result);
									
					$.each(json_obj, function(i, item) {
						console.log("i:" + i);
						console.log("item:" + item);
						console.log(json_obj[i].item_name);
// 						$("#combo").get(0).add(json_obj[i].item_name);
						$("[name^=cmb-service_name-]").append($('<option></option>').val(json_obj[i].item_name).html(json_obj[i].item_name));	
					});
				},
				error:function(e){
					console.log('btn1 click error');
				}
			});
			
			$("#divMain").hide();
			$("#div1").hide();
			$("#div2").show();
			$("#div3").hide();
			$("#divTest").hide();
		});
		
		$("#next2").click(function() {
						
			if ( !$(".customDiv2").valid() ) {
				return;
			}
			
			if ( checkDiv2("eq") ) {
				$.ajax({
					type : "POST",
					url : "user.do",
					data : {
						action : "selectAll"
					},
					success : function(result) {
						var json_obj = $.parseJSON(result);
						var result_table = "";
						var str = "";
						
						user_count = json_obj.length;
						
						$.each(json_obj, function(i, item) {
							
							$("#point").append('<tr><td><label>' + json_obj[i].user_name + '</label></td>' + 
									'<td><input type="text" id="weight-' + i + '" name="weight-' + i + '"></td>' + 
									'<td><input type="hidden" id="user-' + i + '" name="user-' + i + '" value="' + json_obj[i].user_id + '"></td></tr>');
								
						});
						
						//========== validate rules (dynamic) ==========
						$( ".customDiv3" ).validate();
						
						$("[name^=weight-]").each(function(){
							$(this).rules("add", {
							  	required: true,
								digits: true,
								max: 5,
								min: 1
							});
					   	});

						$("#divMain").hide();
						$("#div1").hide();
						$("#div2").hide();
						$("#div3").show();
						$("#divTest").hide();
					}
				});
			}
		});
		
		$("#confirm").click(function() {
			
			if ( !$(".customDiv3").valid() ) {
				return;
			}
			
			var 
			cost = $("#cost").val(),
			temp = '',
			func_no = $("#function_no").val(),
			nfunc_no = $("#nfunction_no").val(),
			serv_no = $("#service_no").val(),
			func_name_list = "", nfunc_name_list = "", service_name_list = "",
			func_score_list = "", nfunc_score_list = "", service_score_list = "";
		
			for (var i = 1; i <= func_no; i++) {
				func_name_list = func_name_list + $("#cmb-function_name-" + i).val() + ',';
				
				temp = $("#function_score-" + i).val() / cost * 100;
				
				func_score_list = func_score_list + roundDecimal(temp, 2) + ',';
			}

			func_name_list = func_name_list.substr(0, func_name_list.length - 1);
			func_score_list = func_score_list.substr(0, func_score_list.length - 1);
			
			for (var j = 1; j <= nfunc_no; j++) {
				nfunc_name_list = nfunc_name_list + $("#cmb-nfunction_name-" + j).val() + ',';
				
				temp = $("#nfunction_score-" + j).val() / cost * 100;
				
				nfunc_score_list = nfunc_score_list + roundDecimal(temp, 2) + ',';
			}

			nfunc_name_list = nfunc_name_list.substr(0, nfunc_name_list.length - 1);
			nfunc_score_list = nfunc_score_list.substr(0, nfunc_score_list.length - 1);
			
			for (var k = 1; k <= serv_no; k++) {
				service_name_list = service_name_list + $("#cmb-service_name-" + k).val() + ',';
				
				temp = $("#service_score-" + k).val() / cost * 100;
				
				service_score_list = service_score_list + roundDecimal(temp, 2) + ',';
			}
			
			service_name_list = service_name_list.substr(0, service_name_list.length - 1);
			service_score_list = service_score_list.substr(0, service_score_list.length - 1);
			
			$.ajax({
				type : "POST",
				url : "productForecast.do",
				data : {
					action : "insert",
					group_id : '<%=group_id%>',
					product_name : $("#product_name").val(),
					cost : $("#cost").val(),
					function_no : $("#function_no").val(),
					function_name : func_name_list,
					function_score : func_score_list,
					nfunction_no : $("#nfunction_no").val(),
					nfunction_name : nfunc_name_list,
					nfunction_score : nfunc_score_list,
					service_no : $("#service_no").val(),
					service_name : service_name_list,
					service_score : service_score_list,
					score_time : $("#score_time").val(),
					result : $("#result").val(),
					isfinish : 0
				},
				success : function(result) {
					var json_obj = $.parseJSON(result);
					var len=json_obj.length;

					point(json_obj);
				}
			});
		});
		
		$("#create2").click(function() {
			var isChecked = $('.maincheck').attr('checked')?true:false;
			
			$('#main').find('tr').each(function () {
				var row = $(this);
				
				if ( row.find('input[type="checkbox"]').is(':checked') ) {
					var forecast_id = row.find('.forecast_id_main').html();
					
		        	$.ajax({
						type : "POST",
						url : "productForecast.do",
						data : {
							action : "selectByForecastId",
							forecast_id : forecast_id
						},
						success : function(result) {
							var json_obj = $.parseJSON(result);
							
							$.each(json_obj, function(i, item) {
								
								$('#forecast_id_test').val(json_obj[i].forecast_id);
								$('#user_id_test').val('<%=user_id%>');
								
								$("#product_name_test").html("產品名稱：" + json_obj[i].product_name);
								
								var function_name = json_obj[i].function_name.split(',');
								
								$.each( function_name, function( index, value ){
									$("#function-test").append('<tr><td>' + value + '</td><td>' + '<input type="text" id="function-test-' + index + '" name="function-test-' + index + '">' + '</td></tr>');
								});
								
								var nfunction_name = json_obj[i].nfunction_name.split(',');
								
								$.each( nfunction_name, function( index, value ){
									$("#nfunction-test").append('<tr><td>' + value + '</td><td>' + '<input type="text" id="nfunction-test-' + index + '" name="nfunction-test-' + index + '">' + '</td></tr>');
								});
								
								var service_name = json_obj[i].service_name.split(',');
								
								$.each( service_name, function( index, value ){
									$("#service-test").append('<tr><td>' + value + '</td><td>' + '<input type="text" id="service-test-' + index + '" name="service-test-' + index + '">' + '</td></tr>');
								});
								
								//========== validate rules (dynamic) ==========
								$( ".customDivTest" ).validate();
								
								$("[name^=function-test-]").each(function(){
									$(this).rules("add", {
									  	required: true,
		                                number: true,
		                                max: 5,
		                                min: 1,
		                                customWeight: true
									});
							   	});
								
								$("[name^=nfunction-test-]").each(function(){
									$(this).rules("add", {
									  	required: true,
		                                number: true,
		                                max: 5,
		                                min: 1,
		                                customWeight: true
									});
							   	});

								$("[name^=service-test-]").each(function(){
									$(this).rules("add", {
									  	required: true,
		                                number: true,
		                                max: 5,
		                                min: 1,
		                                customWeight: true
									});
							   	});
								
								$.validator.addMethod('customWeight',function(value, element, param) {
	                             	var regEx = /^\d(\.\d{1})?\d{0}$/;
	                             	
									if(regEx.test(value)){
										return true ;
									} else {
										return false ;
									}

		                           	return isValid; // return bool here if valid or not.
		                       	}, '請輸入數值介於1~5，小數點後1位!' );

								$("#divMain").hide();
								$("#div1").hide();
								$("#div2").hide();
								$("#div3").hide();
								$("#divTest").show();
							});
							
							$('input.maincheck').on('change', function() {
							    $('input.maincheck').not(this).prop('checked', false);  
							});
						}
					});
		            
		        }
		    });
		});
		
		$("#confirmTest").click(function() {

			if ( !$(".customDivTest").valid() ) {
				return;
			}
			
			var 
			forecast_id = "", user_id = "";
			func_point_list = "", nfunc_point_list = "", service_point_list = "";
			
			forecast_id = $("#forecast_id_test").val();
			user_id	= '<%=user_id%>';
			
			$('#function-test').find('tr').each(function () {
				var row = $(this);
				if ( row.find('input[type="text"]').val()  ) {
					func_point_list = func_point_list + row.find('[name^=function-test-]').val() + ',';
				}
				
			});
			
			func_point_list = func_point_list.substr(0, func_point_list.length - 1);
			
			$('#nfunction-test').find('tr').each(function () {
				var row = $(this);
				if ( row.find('input[type="text"]').val() ) {
					nfunc_point_list = nfunc_point_list + row.find('[name^=nfunction-test-]').val() + ',';
				}
			});
			
			nfunc_point_list = nfunc_point_list.substr(0, nfunc_point_list.length - 1);
			
			$('#service-test').find('tr').each(function () {
				var row = $(this);
				if (  row.find('input[type="text"]').val() ) {
					service_point_list = service_point_list + row.find('[name^=service-test-]').val() + ',';
				}
			});
			
			service_point_list = service_point_list.substr(0, service_point_list.length - 1);
			
			$.ajax({
				type : "POST",
				url : "productForecastPoint.do",
				data : {
					action : "update",
					forecast_id : forecast_id,
					user_id : user_id,
					function_point : func_point_list,
					nfunction_point : nfunc_point_list,
					service_point : service_point_list
				},
				success : function(result) {
					var json_obj = $.parseJSON(result);
					var len=json_obj.length;
					
				}
			});
			
			$("#function-test").html('');
			$("#nfunction-test").html('');
			$("#service-test").html('');
			
			$("#divMain").show();
		    $("#div1").hide();
			$("#div2").hide();
			$("#div3").hide();
			$("#divTest").hide();
		});
		
		function point(productForecast) {
			var user = "", weight = "";
			
			for (var i = 0; i < user_count; i++) {
				user = $("#user-" + i).val();
				weight = $("#weight-" + i).val();
				
				$.ajax({
					type : "POST",
					url : "productForecastPoint.do",
					data : {
						action : "insert",
						forecast_id : productForecast[0].forecast_id,
						user_id : user,
						weight : weight,
						function_point : '',
						nfunction_point : '',
						service_point : '',
						score_seq : ''
					},
					success : function(result) {
						var json_obj = $.parseJSON(result);
						var len=json_obj.length;
						
						$( ":input" ).val('');
						$("#function").html('');
						$("#nfunction").html('');
						$("#service").html('');
						$("#point").html('');
					}
				});
			}
			
			mainLoad();
			
			$("#divMain").show();
			$("#div1").hide();
			$("#div2").hide();
			$("#div3").hide();
			$("#divTest").hide();
		}
		
		function validateDecimal(value)    {
		    var RE = /^\d(\.\d{1})?\d{0}$/;
		    if(RE.test(value)){
		       return true;
		    }else{
		       return false;
		    }
		}
		
		function roundDecimal(val, precision) {
  			return Math.round(Math.round(val * Math.pow(10, (precision || 0) + 1)) / 10) / Math.pow(10, (precision || 0));
		}
		
		function mainLoad() {
			
			var h_str_checkbox = "", str_checkbox = "", str_button = "";
			
			if ('<%=role%>' == '0') {
				$('#create').hide();
				$('#create2').show();
				h_str_checkbox = '<td><label>選擇</label></td>';
			} else if ('<%=role%>' == '1') {
				$('#create').show();
				$('#create2').hide();
				h_str_checkbox = '<label></label>';
			}
			
			$("#main").html(
				'<tr>' + 
					h_str_checkbox +
					'<td><label>產品名稱</label></td>' +
					'<td><label>總成本</label></td>' + 
					'<td>結果</td>' + 
				'</tr>'
			);
			
			$.ajax({
				type : "POST",
				url : "productForecast.do",
				data : {
					action : "selectByGroupId",
					group_id : '<%=group_id%>'
				},
				success : function(result) {
					var json_obj = $.parseJSON(result);
					
					$.each(json_obj, function(i, item) {
						
						if ('<%=role%>' == '0') {
							str_checkbox = '<td><input type="checkbox" class="maincheck" /></td>';
						} else if ('<%=role%>' == '1') {
							str_checkbox = '';
						}
						
						if (json_obj[i].isfinish === 1) {
// 							str_button = '<button id="btn-result-' + i + '" class="btn btn-primary btn-lg">顯示</button>';
							str_button = "<label>顯示結果請點擊兩次本列資料</label>";
						} else {
							str_button = '';
						}
						
						$("#main").append('<tr>' + 
							str_checkbox +
							'<td class="product_name_main">' + json_obj[i].product_name + '</td>' +
							'<td>' + json_obj[i].cost + '</td>' + 
							'<td>' + str_button + '</td>' +
							'<td class="forecast_id_main" hidden="true">' + json_obj[i].forecast_id + '</td>' +
							'</tr>'
						);
					});
					
					$('input.maincheck').on('change', function() {
					    $('input.maincheck').not(this).prop('checked', false);  
					});
					
					$("#divMain").show();
					$("#div1").hide();
					$("#div2").hide();
					$("#div3").hide();
					$("#divTest").hide();
					
					$('#main td').dblclick(function () {
						
						var $this = $(this);
						var row = $this.closest("tr");
						
						if ( row.find('label').val() == '' ) {
							var forecast_id = row.find('.forecast_id_main').html();
							
				        	$.ajax({
								type : "POST",
								url : "productForecast.do",
								data : {
									action : "selectByForecastId",
									forecast_id : forecast_id
								},
								success : function(result) {
									var json_obj = $.parseJSON(result);
									
									$.each(json_obj, function(i, item) {
										var result_list = json_obj[i].result.split(',');
										
										$("#resultModal").append('<table id="tblResult" class="formTable"></table>');
										
										$("#tblResult").append('<tr>' + 
													'<th>優先次序</th>' + 
													'<th>名稱</th>' +
												'</tr>');
										
										$.each( result_list, function(index, value){
											$("#tblResult").append('<tr><td>' + index + '</td><td><label>' + value + '</label></td></tr>');
										});

				 						$("#resultModal").dialog({
				 							title: "結果",
				 							draggable : true,
				 							resizable : false, //防止縮放
				 							autoOpen : false,
				 							height : "auto",
				 							modal : true,
				 							buttons : {
				 								"確認" : function() {
				 									$("#tblResult").html('');
				 									
				 									$(this).dialog("close");
				 								}
				 							}
				 						});
											
				 						$("#resultModal").dialog("open");
									});
									
								}
							});
				            
				        }
					});
					
				}
			});
		}
		
		function checkDiv2(type) {
			var sum = 0,
			cost = $("#cost").val(),
			func_no = $("#function_no").val(),
			nfunc_no = $("#nfunction_no").val(),
			serv_no = $("#service_no").val();
				
			for (var i = 1; i <= func_no; i++) {
				sum = sum + parseInt( $("#function_score-" + i).val() );
			}

			for (var j = 1; j <= nfunc_no; j++) {
				sum = sum + parseInt( $("#nfunction_score-" + j).val() );
			}

			for (var k = 1; k <= serv_no; k++) {
				sum = sum + parseInt( $("#service_score-" + k).val() );
			}
			
			if ((type == "eq" && cost != sum) || (type == "gt" && sum > cost)) {
				
				$("#productAlert").html("您輸入的成本總和與總成本不符，請重新輸入。" + "總成本為 " + cost + " ，成本總和為 " + sum + " 。");
				
				$("#productAlert").dialog({
					title: "警告",
					draggable : true,
					resizable : false, //防止縮放
					autoOpen : false,
					height : "auto",
					modal : true,
					buttons : {
						"確認" : function() {
							$(this).dialog("close");
						}
					}
				});
					
				$("#productAlert").dialog("open");
					
				return false;
			}
			
			return true;
		}
		
		//========== validate rules ==========
		$( ".customDiv1" ).validate({
			rules: {
				product_name: {
					required: true
				},
				cost: {
					required: true,
					digits: true
				},
				function_no: {
					required: true,
					digits: true
				},
				nfunction_no: {
					required: true,
					digits: true
				},
				service_no: {
					required: true,
					digits: true
				}
			}
		});
	});
</script>
</head>
<body>

<%-- 	<jsp:include page="template-old.jsp" flush="true"/> --%>
	<div class="content-wrap"><br/>    
		
		<div id="productAlert"></div>
		<div id="resultModal"></div>
	
		<div id="divMain" class="panelWrap expand" hidden="true">
			<div class="panel-title">
				<h2>新產品風向預測</h2>
			</div>
	
			<form class="customDivMain">
				<table id="main" class="formTable">
					<tr>
						<td><label>產品名稱</label></td>
						<td><label>總成本</label></td>
						<td><label>功能性項目</label></td>
						<td><label>名稱</label></td>
						<td><label>比重</label></td>
						<td><label>非功能性項目</label></td>
						<td><label>名稱</label></td>
						<td><label>比重</label></td>
						<td><label>服務性項目</label></td>
						<td><label>名稱</label></td>
						<td><label>比重</label></td>
					</tr>
				</table>
			</form>
	
			<div class="btn-control aCenter">
				<button id="create" class="btn btn-primary btn-lg" hidden="true">建立量表</button>
				<button id="create2" class="btn btn-primary btn-lg" hidden="true">開始評分</button>
			</div>
		</div>
	
		<div id="div1" class="panelWrap expand" hidden="true">
			<div class="panel-title">
				<h2>新產品風向預測</h2>
			</div>
	
			<form class="customDiv1">
				<table class="formTable">
					<tr>
						<td><label>產品名稱</label></td>
						<td><input type="text" id="product_name" name="product_name"
							placeholder="輸入產品名稱"></td>
						<td><label>總成本</label></td>
						<td><input type="text" id="cost" name="cost"
							placeholder="輸入總成本"></td>
					</tr>
	
					<tr>
						<td><label>功能性項目</label></td>
						<td align="right">共計</td>
						<td><input type="text" id="function_no" name="function_no">
						</td>
						<td align="left">項</td>
					</tr>
	
					<tr>
						<td><label>非功能性項目</label></td>
						<td align="right">共計</td>
						<td><input type="text" id="nfunction_no" name="nfunction_no">
						</td>
						<td align="left">項</td>
					</tr>
	
					<tr>
						<td><label>服務性項目</label></td>
						<td align="right">共計</td>
						<td><input type="text" id="service_no" name="service_no">
						</td>
						<td align="left">項</td>
					</tr>
				</table>
			</form>
	
			<div class="btn-control aCenter">
				<button id="next1" class="btn btn-primary btn-lg">下一步</button>
			</div>
		</div>
	
		<div id="div2" class="panelWrap expand" hidden="true">
			<form class="customDiv2">
				<table id="function" class="formTable">
					<div class="panel-title">
						<h2>功能性項目</h2>
					</div>
					<tr>
						<th>名稱</th>
						<th>比重(成本)</th>
					</tr>
				</table>
	
				<div class="panel-title">
					<h2>非功能性項目</h2>
				</div>
	
				<table id="nfunction" class="formTable">
					<tr>
						<th>名稱</th>
						<th>比重(成本)</th>
					</tr>
				</table>
	
				<div class="panel-title">
					<h2>服務性項目</h2>
				</div>
	
				<table id="service" class="formTable">
					<tr>
						<th>名稱</th>
						<th>比重(成本)</th>
					</tr>
				</table>
			</form>
	
			<div class="btn-control aCenter">
				<button id="next2" class="btn btn-primary btn-lg">下一步</button>
			</div>
		</div>
	
		<div id="div3" class="panelWrap expand" hidden="true">
			<div class="panel-title">
				<h2>受測者權重設定</h2>
			</div>
	
			<form class="customDiv3">
				<table id="point" class="formTable">
					<tr>
						<th>使用者名稱</th>
						<th>權重</th>
						<th hidden="true">userid</th>
					</tr>
				</table>
			</form>
	
			<div class="btn-control aCenter">
				<button id="confirm" class="btn btn-primary btn-lg">建立量表</button>
			</div>
		</div>
		
		<div id="divTest" class="panelWrap expand" hidden="true">
			<div class="panel-title">
				<h2 id="product_name_test"></h2>
				<input type="hidden" id="forecast_id_test"></input>
				<input type="hidden" id="user_id_test"></input>
			</div>
	
			<form class="customDivTest">
				<table id="function-test" class="formTable">
					<div class="panel-title">
						<h2>功能性項目</h2>
					</div>
					<tr>
						<th>名稱</th>
						<th>分數</th>
					</tr>
				</table>
	
				<div class="panel-title">
					<h2>非功能性項目</h2>
				</div>
	
				<table id="nfunction-test" class="formTable">
					<tr>
						<th>名稱</th>
						<th>分數</th>
					</tr>
				</table>
	
				<div class="panel-title">
					<h2>服務性項目</h2>
				</div>
	
				<table id="service-test" class="formTable">
					<tr>
						<th>名稱</th>
						<th>分數</th>
					</tr>
				</table>
			</form>
	
			<div class="btn-control aCenter">
				<button id="confirmTest" class="btn btn-primary btn-lg">完成</button>
			</div>
		</div>
	</div>
</body>
</html>