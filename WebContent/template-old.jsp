<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>template</title>
<!-- 	<link rel="stylesheet" href="css/jquery-ui.min.css"> -->
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<link rel="stylesheet" href="css/styles.css">
<!-- 	<link rel="stylesheet" href="css/1.11.4/jquery-ui.css"> -->
	<link href="css/jquery-ui-1.12.0/jquery-ui.css" rel="stylesheet">
<!-- 	<script type="text/javascript" src="js/jquery-3.1.0.min.js"></script> -->
	<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="css/jquery-ui-1.12.0/jquery-ui.min.js"></script>
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
	<!-- <script src="js/scripts.js"></script> -->
</head>
<body>
	<script>
	
	function who(){
		switch(location.pathname.split("/")[2]){
		case "main.jsp":
			return "首頁";
			break;
		case "finModel.jsp":
			return "新創公司財務損益平衡評估工具";
			break;
		case "population.jsp":
			return "台灣人口社經資料庫api";
			break;
		case "upload.jsp":
			return "檔案匯入";
			break;
		case "cloudISS.jsp":
			return "服務業雲端智慧商情支援系統";
			break;
		case "marketPlace.jsp":
			return "城市商圈";
			break;
		case "persona.jsp":
			return "東南亞商機定位工具";
			break;
		case "productForecast.jsp":
			return "新產品風向預測";
			break;
		default:
			alert("default_page;");
			return "something_wrong?";
			break;
		}
	};
	
	$(function() {
		$("#title").html(who());
		
		$("#my").click(function(e) {
			alert("hello");
		});
		
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
		
		$("#back").click(function(e) {
			top.location.href = "main.jsp";
		});
	});
	</script>
	
	<div class="page-wrapper" >
	
		<div class="header logoHeader" style="z-index:1;">
			<h1>SBI</h1>
			<div class="userinfo" style="z-index:1;">
				<p>使用者<span><%= (request.getSession().getAttribute("user_name")==null)?"@_@?":request.getSession().getAttribute("user_name").toString() %></span></p>
				<a id="back" class="btn-back" >回首頁</a>
				<a id="logout" class="btn-logout" >登出</a>
			</div>
		</div><!-- /.header -->
	
		<div class="sidenav" style="z-index:2;">
		</div><!--  /.sidenav  -->
		
	 	<h2 id="title" class="page-title" style="z-index:2">title</h2> 
	 	
		<div class="content-wrap" style="display:none">
		</div><!-- /.content-wrap -->
		
	<!--################結束###############-->
		<footer class="footer" style="z-index:1;">
			財團法人商業發展研究院  <span>電話(02)7707-4800 | 傳真(02)7713-3366</span> 
		</footer><!-- / .footer -->
	</div><!-- /.page-wrapper -->


</body>
</html>