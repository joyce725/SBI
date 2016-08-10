<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">

<link rel="Shortcut Icon" type="image/x-icon" href="./images/Rockettheme-Ecommerce-Shop.ico" />
<link rel="stylesheet" href="css/styles.css" />
<link href="<c:url value="css/css.css" />" rel="stylesheet">
<link href="<c:url value="css/jquery.dataTables.min.css" />" rel="stylesheet">
<link href="<c:url value="css/1.11.4/jquery-ui.css" />" rel="stylesheet">
<script type="text/javascript" src="js/jquery-3.1.0.min.js"></script>
<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/additional-methods.min.js"></script>
<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>

<%
	String group_id = (String) session.getAttribute("group_id");
	String user_id = (String) session.getAttribute("user_id"); 
%>
<title>新產品風向預測</title>

<script>
	$(function() {
		
				
		$("#next1").click(function() {
			var func_no = $("#function_no").val(),
				nfunc_no = $("#nfunction_no").val(),
				serv_no = $("#service_no").val();
			
			for (var i = 1; i <= func_no; i++) {
				$("#function").append('<tr><td><input type="text" id="function_name-' + i + '" name="function_name-' + i + '"></td>' + 
						'<td><input type="text" id="function_score-' + i + '" name="function_score-' + i + '"></td></tr>');
			}
			
			for (var j = 1; j <= nfunc_no; j++) {
				$("#nfunction").append('<tr><td><input type="text" id="nfunction_name-' + j + '" name="nfunction_name-' + j + '"></td>' + 
						'<td><input type="text" id="nfunction_score-' + j + '" name="nfunction_score-' + j + '"></td></tr>');
			}
			
			for (var k = 1; k <= serv_no; k++) {
				$("#service").append('<tr><td><input type="text" id="service_name-' + k + '" name="service_name-' + k + '"></td>' + 
						'<td><input type="text" id="service_score-' + k + '" name="service_score-' + k + '"></td></tr>');
			}
			
			$("#div1").hide();
			$("#div2").show();
			$("#div3").hide();
		});
		
		$("#next2").click(function() {
			$.ajax({
				type : "POST",
				url : "user.do",
				data : {
					action : "search",
					user_name : ''
				},
				success : function(result) {
					var json_obj = $.parseJSON(result);
					var result_table = "";
					var str="";

					$.each(json_obj,function(i, item) {
						
						$("#point").append('<tr><td><label>' + json_obj[i].user_name + '</label></td>' + 
								'<td><input type="text" id="weight-' + i + '" name="weight-' + i + '"></td>' + 
								'<td><input type="text" id="user-' + i + '" name="user-' + i + '" value="' + json_obj[i].user_id + '"></td></tr>');
							
					});

					$("#div1").hide();
					$("#div2").hide();
					$("#div3").show();
				}
			});
			
			$("#confirm").click(function() {
				
				var func_no = $("#function_no").val(),
				nfunc_no = $("#nfunction_no").val(),
				serv_no = $("#service_no").val(),
				func_name_list = "", nfunc_name_list = "", service_name_list = "",
				func_score_list = "", nfunc_score_list = "", service_score_list = "";
			
				for (var i = 1; i <= func_no; i++) {
					func_name_list = func_name_list + $("#function_name-" + i).val() + ',';
					func_score_list = func_score_list + $("#function_score-" + i).val() + ',';
				}

				func_name_list = func_name_list.substr(0, func_name_list.length - 1);
				func_score_list = func_score_list.substr(0, func_score_list.length - 1);
				
				for (var j = 1; j <= nfunc_no; j++) {
					nfunc_name_list = nfunc_name_list + $("#nfunction_name-" + j).val() + ',';
					nfunc_score_list = nfunc_score_list + $("#nfunction_score-" + j).val() + ',';
				}

				nfunc_name_list = nfunc_name_list.substr(0, nfunc_name_list.length - 1);
				nfunc_score_list = nfunc_score_list.substr(0, nfunc_score_list.length - 1);
				
				for (var k = 1; k <= serv_no; k++) {
					service_name_list = service_name_list + $("#service_name-" + k).val() + ',';
					service_score_list = service_score_list + $("#service_score-" + k).val() + ',';
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
						console.log(json_obj);
						point(json_obj);
					}
				});
				
				$("#div1").show();
				$("#div2").show();
				$("#div3").show();
			});
			
		});
		
		function point(productForecast) {
			$.ajax({
				type : "POST",
				url : "productForecastPoint.do",
				data : {
					action : "insert",
					forecast_id : productForecast.forecast_id,
					user_id : '<%=user_id%>',
					weight : $("#weight").val(),
					function_point : $("#function_point").val(),
					nfunction_point : $("#nfunction_point").val(),
					service_point : $("#service_point").val(),
					score_seq : $("#score_seq").val()
				},
				success : function(result) {
					var json_obj = $.parseJSON(result);
					var len=json_obj.length;
				}
			});
		}
		
	});
</script>
</head>
<body>
	<div id="div1">
		<h2>新產品風向預測</h2>
		
		<table>
			<tr>
				<td>
					<label>產品名稱</label>
					<input type="text" id="product_name" name="product_name" placeholder="輸入產品名稱">
				</td>
				<td>
					<label>總成本</label>
					<input type="text" id="cost" name="cost" placeholder="輸入總成本">
				</td>
			</tr>
			
			<tr>
				<td>
					<label>功能性項目</label>
				</td>
				<td>
					共<input type="text" id="function_no" name="function_no">項 
				</td>
				
			</tr>
			
			<tr>
				<td>
					<label>非功能性項目</label>
				</td>
				<td>
					共<input type="text" id="nfunction_no" name="nfunction_no">項
				</td>
			</tr>
			
			<tr>
				<td>
					<label>服務性項目</label>
				</td>
				<td>
					共<input type="text" id="service_no" name="service_no">項
				</td>
			</tr>
		</table>
		
		<button id="next1">下一步</button>	
	</div>
	
	<div id="div2" hidden="true">
		<h2>新產品風向預測</h2>
		
		<table id="function">
			<tr>
				<th colspan="2">功能性項目</th>
		 	</tr>
			<tr>
				<th>名稱</th>
				<th>比重(成本)</th>
		 	</tr>	
		</table>
		
		<table id="nfunction">
			<tr>
				<th colspan="2">非功能性項目</th>
		 	</tr>
			<tr>
				<th>名稱</th>
				<th>比重(成本)</th>
		 	</tr>	
		</table>
		
		<table id="service">
			<tr>
				<th colspan="2">服務性項目</th>
		 	</tr>
			<tr>
				<th>名稱</th>
				<th>比重(成本)</th>
		 	</tr>	
		</table>
		
		<button id="next2">下一步</button>
	</div>
	
	<div id="div3" hidden="true">
		<table id="point">
			<tr>
				<th colspan="3">受測者權重設定</th>
		 	</tr>
		 	<tr>
				<th>使用者名稱</th>
				<th>權重</th>
				<th>userid</th>
		 	</tr>
		</table>
		
		<button id="confirm">建立量表</button>
	</div>
</body>
</html>