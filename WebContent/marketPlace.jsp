<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>城市商圈</title>
<link rel="Shortcut Icon" type="image/x-icon" href="./images/cdri-logo.gif" />
<link rel="stylesheet" href="cssPS/styles.css" />
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
		
		<ul class="topnav">
<!-- 			<li class="dropdown"> -->
<!-- 				<a href="marketPlace.jsp">國家/城巿商圈</a> -->
<!-- 			</li> -->
			<li class="dropdown">
				<a href="#" class="dropbtn">統計資料</a>
				<div class="dropdown-content">
					<a href="population.jsp">台灣人口社經資料庫</a>
					<a href="upload.jsp">產業分析基礎資料庫</a>
					<a href="populationNew.jsp">台灣人口社經</a>
				</div>
			</li>
			<li class="dropdown">
				<a href="#" class="dropbtn">決策工具</a>
				<div class="dropdown-content">
<!-- 					<a href="cloudISS.jsp">目標市場定位</a> -->
					<a href="personaNew.jsp">目標客群定位</a>
<!-- 					<a href="cloudISS.jsp">競爭者定位</a> -->
<!-- 					<a href="cloudISS.jsp">商品通路</a> -->
<!-- 					<a href="cloudISS.jsp">城市定位</a> -->
<!-- 					<a href="productForecast.jsp">新產品風向評估</a> -->
<!-- 					<a href="finModel.jsp">新創公司財務損益平衡評估</a> -->
<!-- 					<a href="product.jsp">商品管理</a> -->
<!-- 					<a href="agent.jsp">通路商管理</a> -->
<!-- 					<a href="agentAuth.jsp">通路商授權商品管理</a> -->
<!-- 					<a href="productVerify.jsp">商品真偽顧客驗證作業</a> -->
<!-- 					<a href="authVerify.jsp">商品真偽通路商驗證作業</a> -->
				</div>
			</li>
<!-- 			<li class="dropdown"> -->
<!-- 				<a href="#" class="dropbtn">市場商情分析</a> -->
<!-- 				<div class="dropdown-content"> -->
<!-- 					<a href="cloudISS.jsp">生活費用</a> -->
<!-- 					<a href="cloudISS.jsp">區位選擇</a> -->
<!-- 					<a href="cloudISS.jsp">環域分析</a> -->
<!-- 					<a href="cloudISS.jsp">動態統計</a> -->
<!-- 				</div> -->
<!-- 			</li> -->
			<li><a href="businessdistrict.jsp">POI</a></li>
		</ul>
		
	 	<h2 id="title" class="page-title">城市商圈</h2>
	 	
		<div class="content-wrap" style="display:none">
		</div>
		
		<footer class="footer">
<!-- 			財團法人商業發展研究院  <span>電話(02)7707-4800 | 傳真(02)7713-3366</span>  -->
			北祥股份有限公司 <span>服務電話：+886-2-2658-1910 | 傳真：+886-2-2658-1920</span>
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