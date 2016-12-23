<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>城市商圈</title>
<link rel="Shortcut Icon" type="image/x-icon" href="./images/cdri-logo.gif" />
<link rel="stylesheet" href="css/styles.css" />
<link href="css/jquery-ui-1.12.0/jquery-ui.css" rel="stylesheet">
<link rel="stylesheet" href="css/font-awesome.min.css">

<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="css/jquery-ui-1.12.0/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/additional-methods.min.js"></script>
<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>
</head>
<body>
<script>
	$(function() {
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
		
		$( document ).ready(function() {
			
			$("#ifm1").load(function() {
				$(this).height( $(this).contents().find("body").height() );
		  		$(this).width( $(this).contents().find("body").width() );
			}); 
			
			$.ajax({
				type : "POST",
				url : "\/marketplace\/AdminLoginCtrl",
				data : {
					Action : "Api_Login",
					Key : "AABBCC",
					
<%-- 					UserId : "<%=user_name%>", --%>
<%-- 					Password : "<%=pwd%>" --%>
					
					UserId : "cdri",
					Password : "c666d37a6d83059d1d2ad25b420fe7e7" //c666d37a6d83059d1d2ad25b420fe7e7, cdri
				},
				success : function(result) {
// 					console.log("marketPlace success");
// 					console.log(result);
// 					document.getElementById("page1").setAttribute('data', "\/marketplace\/MarketPlaceX_MiscCtrl?Action=Home&F=1&PageType=1B");
					
					var $iframe = $('#ifm1');
// 					console.log("$iframe.length:" + $iframe.length);
				    if ( $iframe.length > 0 ) {
// 				    	console.log("set src");
				        $iframe.attr('src', "\/marketplace\/MarketPlaceX_MiscCtrl?Action=Home&F=1&PageType=1B");   
// 				        console.log("set src complete");
				    }
				},
				error : function(result) {
					
				}
			});
		});
	});
	
</script>

	<div class="page-wrapper" >
	
		<div class="header">
			<div class="userinfo">
				<p>使用者<span><%= (request.getSession().getAttribute("user_name")==null)?"":request.getSession().getAttribute("user_name").toString() %></span></p>
				<a href="#" id="logout" class="btn-logout">登出</a>
			</div>
		</div>
	
		<jsp:include page="menu.jsp"></jsp:include>	
			
	 	<h2 id="title" class="page-title">城市商圈</h2>
	 	
		<div class="content-wrap" style="display:none">
		</div>
		
		<footer class="footer">
			財團法人商業發展研究院  <span>電話(02)7707-4800 | 傳真(02)7713-3366</span> 
		</footer>
	</div>
	
	<div class="content-wrap">
		<div class="search-result-wrap" style="height:100%">
			<iframe id="ifm1" width="100%" height="100%" src="\/marketplace\/MarketPlaceX_MiscCtrl"></iframe>
<!-- 		<object type="text/html" width="100%" height="100%" id="page1" data="\/marketplace\/MarketPlaceX_MiscCtrl" ></object> -->
		</div>
	</div>
	
</body>
</html>