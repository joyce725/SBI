<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<style type="text/css">
	button {
		padding: 5px;
		width: 150px;
	}
</style>
<title>使用者登入</title>
<link rel="Shortcut Icon" type="image/x-icon" href="./images/Rockettheme-Ecommerce-Shop.ico" />
<link rel="stylesheet" href="css/css.css" />
<link rel="stylesheet" href="css/styles.css" />
<link rel="stylesheet" href="css/jquery-ui-1.12.0/jquery-ui.css">
<script src="js/jquery-1.12.4.js"></script>
<script src="js/jquery-ui.min.js"></script>
<!-- <script src="js/jquery.validate.min.js"></script> -->
<!-- <script src="js/messages_zh_TW.min.js"></script> -->
<script type="text/javascript">

<%if(request.getSession().getAttribute("user_name")!=null){%>
	top.location.href="main.jsp";
<%}%>
	
    function changeImg(){
        document.getElementById("validateCodeImg").src="HandleDrawValidateCode.do?t=" + Math.random();
    }

    function to_login(){
    	$(".error").removeClass("error");
    	$(".error-msg").remove();
    	var wrong=0;

    	if($("#user_name").val().length<1){
//     		$("#username").addClass("error");
    		$("#username").after("<span class='error-msg'>請輸入帳號</span>");
    		wrong=1;
    	}
    	if($("#pswd").val().length<1){
//     		$("#pswd").addClass("error");
    		$("#pswd").after("<span class='error-msg'>請輸入密碼</span>");
    		wrong=1;
    	}
    	if($("#validateCode").val().length<1){
//     		$("#validateCode").addClass("error");
    		$("#validateCode").after("<span class='error-msg'>請輸入驗證碼</span>");
    		wrong=1;
    	}
//     	if($("#pswd").val().length>10){
//     		$("#pswd").addClass("error");
//     		$("#pswd").after("<span class='error-msg'>長度不可超過十個字</span>");
//     		wrong=1;
//     	}
    	if(wrong==0){
    		$.ajax({
	    		type : "POST",
				url : "login.do",
				cache : false,
				data : {
					action : "login",
					user_name : $("#user_name").val(),
					pswd : $("#pswd").val(),
					validateCode : $("#validateCode").val()
                },
                success: function(data) {
                	var json_obj = $.parseJSON(data);
                	if (json_obj.message=="success"){
                		window.location.href = "main.jsp";
                	}
                	if (json_obj.message=="failure"){
                		$("#validateCode").val("");
                		$("#pswd").val("");
            			$("#pswd").focus();
//     					$("#pswd").addClass("error");
    					$("#pswd").after("<span class='error-msg'>密碼錯誤</span>");
                		changeImg();
                	}
                	if (json_obj.message=="code_failure") {
                		$("#validateCode").val("");
    					$("#pswd").val("");
            			$("#validateCode").focus();
//     					$("#validateCode").addClass("error");
    					$("#validateCode").after("<span class='error-msg'>驗證碼錯誤</span>");
                	}
                	if (json_obj.message=="user_failure"){
//                 		$("#username").addClass("error");
                		$("#username").after("<span class='error-msg'>查無此帳號</span>");
                		changeImg();
                		wrong=1;
                	}
                }
            });
    	}
    }
	$(function() {
		$("#validateCodeImg").click(function() {
			changeImg();
		});

		$("#user_name").focus();
		$("#user_name").blur(function(){
	    	$(".error").removeClass("error");
	    	$(".error-msg").remove();
			$.ajax({
                url : "login.do",
                type : "POST",
                cache : false,
                delay : 1500,
                data : {
                	action : "check_user_exist",
                	user_name : $("input[name='user_name']").val()
                },
                success: function(data) {
                	var json_obj = $.parseJSON(data);
                	if (json_obj.message=="user_failure"){
                		if($("#user_name").val().length >0){
                			$("#user_name").focus();
//         					$("#user_name").addClass("error");
        					$("#user_name").after("<span class='error-msg'>查無此帳號</span>");
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

		$("#login_btn").click(function(){
			to_login();
	 	});

		$("input").keydown(function (event) {
	        if (event.which == 13) {
	        	to_login();
	        }
	    }); 

		$("#reset_btn").click(function(){
			$(".error").removeClass("error");
			$(".error-msg").remove();
			$("#user_name").val("");
			$("#pswd").val("");
			$("#validateCode").val("");
			changeImg();
		});
	});
</script>
</head>
<body class="login-body">
	<div class="bkg-upper"></div>
	<div class="bkg-lower"></div>
	<div class="login-wrapper">
		<h1>服務雲端智慧商情系統</h1>
		<div class="login-panel-wrap">
			<div class="login-panel">
				<h2>使用者登入</h2>
				<form id="login-form-post">
					<label for="user_name" name="login-label">
						<span class="block-label">帳號：</span>
						<input type="text" id="user_name" name="user_name" >
					</label>
					<label for="pswd" name="login-label">
						<span class="block-label">密碼：</span>
						<input type="password" id="pswd" name="pswd" >
					</label>
					<div class="verify-wrap">
						<label for="validateCode" name="login-label">
							<span class="block-label">認證碼：</span>
							<input type="text" id ="validateCode"name="validateCode" >
						</label>
						<div class="captcha-wrap">
							<img title="看不清楚? 點擊圖片可換一張" src="HandleDrawValidateCode.do" id="validateCodeImg">
						</div>
					</div><!-- /.verify-wrap -->
					<div class="login-btn-wrap">
						<a class="login-button" id="login_btn">登入</a>
						<a class="login-reset-button" id="reset_btn">清除重填</a>					
					</div><!-- /.login-btn-wrap -->
				</form>
			</div><!-- /.login-panel -->
		</div><!-- /.login-panel-wrap -->

		<div class="login-footer">
			財團法人商業發展研究院  <span>電話(02)7707-4800 | 傳真(02)7713-3366</span> 
		</div><!-- /.login-footer -->

	</div><!-- /.login-wrapper -->
</body>
</html>