<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="tw.com.sbi.login.controller.Login"%>
<%@ page import="tw.com.sbi.validation.HandleDrawValidateCode"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<title>Login</title>
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
<script type="text/javascript">
    function changeImg(){
        document.getElementById("validateCodeImg").src="HandleDrawValidateCode.do?t=" + Math.random();
    }
</script>
<script type="text/javascript">
	$(function() {
		$("#validateCodeImg").tooltip();
// 		validator_login = $("#login-form-post").validate({
// 			rules : {
// 				user_name : {
// 					required : true
// 				},
// 				pswd : {
// 					required : true,
// 					maxlength : 10
// 				},
// 				validateCode : {
// 					required : true
// 				}
// 			},
// 			messages : {
// 				pswd : {
// 					maxlength : "長度不能超過10個字"
// 				},
// 				user_name : {
// 					maxlength : "長度不能超過10個字"
// 				}
// 			},
// 			errorPlacement: function(error, element) {  
// 			    error.appendTo(element.parent());  
// 			}
// 		});
		$("#user_name").blur(function(){
			$.ajax({
                url : "login.do",
                type : "POST",
                cache : false,
                delay : 1500,
                data : {
                	action : "check_user_exist",
                	user_name : $("input[name='user_name'").val()
                },
                success: function(data) {
                	var json_obj = $.parseJSON(data);
                	if (json_obj.message=="user_failure"){
                		if($("#user_name").val().length >0){
                			$("#user_name").focus();
                			if(!$("#user_err_mes").length){
                				$("<p id='user_err_mes'>查無此帳號</p>").appendTo($("#user_name").parent());
                			}else{
                				$("#user_err_mes").html("查無此帳號");
                			}
                		}
                		if($("#user_name").val().length ==0){
                			if($("#user_err_mes").length){
                    			$("#user_err_mes").remove();
                			}
                		}
                	}
                	else if (json_obj.message=="success"){
               			if($("#user_err_mes").length){
                   			$("#user_err_mes").remove();
               			}                		
                	}
                }
            });
		});
		$('#user_name').keypress(function() {
			if($("#user_err_mes").length){
				$("#user_err_mes").remove();
			}
		  });
		$("#login_btn").button().on("click", function(e) {
			e.preventDefault();
			$.ajax({
				type : "POST",
				url : "login.do",
				data : {
					action : "login",
					user_name : $("input[name='user_name'").val(),
					pswd : $("input[name='pswd'").val(),
					validateCode : $("input[name='validateCode'").val()
				},
				success : function(result) {
// 					if ($('#login-form-post').valid()) {
// 						var json_obj = $.parseJSON(result);
// 						if (json_obj.message=="success") {
// 							alert("success");
							//var url="";
							//url+=window.location.protocol+"//"+window.location.host+"/VirtualBusiness/main.jsp"
							//window.location.href = url;
							window.location.href = "main.jsp";
// 						} 
// 						if (json_obj.message=="failure") {
// 							failure_dialog.dialog("open");
// 						}
// 						if (json_obj.message=="code_failure") {
// 							$("input").attr("value","");
// 							if(!$("#code_err_mes").length){
//                 				$("<p id='code_err_mes'>驗證碼錯誤</p>").appendTo($("#validateCode").parent());
//                 			}else{
//                 				$("#code_err_mes").html("驗證碼錯誤");
//                 			}
// 						}
// 					}
				}
			});
		});
		failure_dialog = $("#dialog-failure").dialog({
			draggable : false,//防止拖曳
			resizable : false,//防止縮放
			autoOpen : false,
			height : 140,
			modal : true,
			buttons : {
				"確認" : function() {
					$("input").attr("value","");
					$(this).dialog("close");
				}
			}
		});		
		$('#validateCode').keypress(function() {
			$("#code_err_mes").remove();
		  });
		$("#reset_btn").button().on("click", function(e) {
			e.preventDefault();
			$("input").attr("value","");
			validator_login.resetForm();
		});
		$("button").css("padding","5px").css("width","150px");
	})
</script>

</head>
<body style="background-image: url('./images/background.png');background-size: cover;">
<div align="center" style="margin:50px auto;">
	<!--對話窗樣式-登入失敗 -->
	<div id="dialog-failure" title="登入失敗">
		<br><p>請重新輸入帳密</p>
	</div>
	<h1 style="font-size:25px;">使用者登入</h1>
	<form name="login-form-post" id="login-form-post">
		<table id="login" style="border-collapse: separate;border-spacing: 10px 20px;">
			<tr>
				<td style="font-size:20px;" align="right">
					<p>帳號:</p>
				</td>
				<td>
					<input type="text" id="user_name" name="user_name" value="Kip" placeholder="請輸入帳號" style="width:225px;padding: 4px 5px;">
				</td>
			</tr>
			<tr>
				<td style="font-size:20px;"align="right">
					<p>密碼:</p>
				</td>
				<td>
					<input type="password" id="pswd" name="pswd" value="1234" placeholder="請輸入密碼" style="width:225px;padding: 4px 5px;">
				</td>
			</tr>
			<tr>
				<td style="font-size:20px;float:left;"align="right">
					<p>驗證碼 :</p>
                </td>
                <td>
	                <input type="text" id ="validateCode"name="validateCode" placeholder="不區分大小寫)" style="width:100px;padding: 4px 5px;float:left;">
                	&nbsp;&nbsp;<img title="看不清楚? 點擊圖片可換一張" src="HandleDrawValidateCode.do" id="validateCodeImg" onclick="changeImg()">
                </td>
			</tr>
			<tr>
				<td align="center" colspan="3">
					<button id="login_btn">登入</button> &nbsp; <button id="reset_btn">重新輸入</button>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>