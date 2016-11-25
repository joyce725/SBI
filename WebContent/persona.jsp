<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>東南亞商機定位工具</title>
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
				url : "\/persona\/AdminLoginCtrl",
				data : {
					Action : "Api_Login",
					Key : "A7BBMK3",
					
<%-- 					UserId : "<%=user_name%>", --%>
<%-- 					Password : "<%=pwd%>" --%>
					
					UserId : "admin1",
					GroupId  : "group1",
					Password : "caf1a3dfb505ffed0d024130f58c5cfa"
				},
				success : function(result) {
// 					console.log("persona success");
// 					console.log(result);
					//document.getElementById("page1").setAttribute('data', "\/persona\/Persona_ProductAdminCtrl?Action=Page1BL");
// 					document.getElementById("page1").setAttribute('data', "\/marketplace\/MarketPlaceX_MiscCtrl?Action=Home&F=1&PageType=1B");
// 					var page1 = document.getElementById("page1");
// 					page1.data = "\/marketplace\/MarketPlaceX_MiscCtrl?Action=Home&F=1&PageType=1B";

					var $iframe = $('#ifm1');
// 					console.log("$iframe.length:" + $iframe.length);
				    if ( $iframe.length > 0 ) {
				        $iframe.attr('src', "\/persona\/Persona_OpportunityUser1Ctrl?Action=Page1BF");   
				    }
				    
// 					var page1 = document.querySelector("page1"); 
// 					page1.setAttribute("data", "\/persona\/Persona_OpportunityUser1Ctrl?Action=Page1BF");
				},
				error : function(result) {
// 					console.log('error');
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
			<li class="dropdown">
				<a href="#" class="dropbtn">目標客群定位</a>
				<div class="dropdown-content">
					<a href="#">品類</a>
					<a href="personaNew.jsp">目標族群</a>
					<a href="#">市場價格定位</a>
				</div>
			</li>
			<li class="dropdown">
				<a href="#" class="dropbtn">空間決策</a>
				<div class="dropdown-content">
					<a href="#">目標市場確認</a>
					<a href="#">競爭力評估</a>
					<a href="#">銷售通路決策</a>
				</div>
			</li>
			<li class="dropdown">
				<a href="#" class="dropbtn">生活費用</a>
				<div class="dropdown-content">
					<a href="#">零售業</a>
					<a href="#">餐飲業</a>
				</div>
			</li>
			<li class="dropdown">
				<a href="#" class="dropbtn">電子書</a>
				<div class="dropdown-content">
					<a href="#">人口/市場</a>
					<a href="#">商圈/競爭</a>
					<a href="#">經濟/交通</a>
				</div>
			</li>
			<li class="dropdown">
				<a href="#" class="dropbtn">動態統計</a>
				<div class="dropdown-content">
					<a href="#">國家</a>
					<a href="#">目標城市</a>
					<a href="#">目標產業</a>
					<a href="#">消費力</a>
				</div>
			</li>
			<li class="dropdown">
				<a href="#" class="dropbtn">環域分析</a>
				<div class="dropdown-content">
					<a href="#">分析地點</a>
					<a href="#">交通速度</a>
					<a href="#">時間劃分</a>
				</div>
			</li>
			<li class="dropdown">
				<a href="regionselect.jsp" class="dropbtn">區位選擇</a>
				<div class="dropdown-content">
					<a href="#">商圈評估</a>
					<a href="#">問卷建立</a>
					<a href="#">建議區位</a>
					<a href="#">競爭分佈</a>
				</div>
			</li>
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
	<!-- 				<a href="cloudISS.jsp">目標市場定位</a> -->
					<a href="personaNew.jsp">目標客群定位</a>
	<!-- 				<a href="cloudISS.jsp">競爭者定位</a> -->
	<!-- 				<a href="cloudISS.jsp">商品通路</a> -->
	<!-- 				<a href="cloudISS.jsp">城市定位</a> -->
	<!-- 				<a href="productForecast.jsp">新產品風向評估</a> -->
	<!-- 				<a href="finModel.jsp">新創公司財務損益平衡評估</a> -->
	<!-- 				<a href="product.jsp">商品管理</a> -->
	<!-- 				<a href="agent.jsp">通路商管理</a> -->
	<!-- 				<a href="agentAuth.jsp">通路商授權商品管理</a> -->
	<!-- 				<a href="productVerify.jsp">商品真偽顧客驗證作業</a> -->
	<!-- 				<a href="authVerify.jsp">商品真偽通路商驗證作業</a> -->
				</div>
			</li>
	<!-- 		<li class="dropdown"> -->
	<!-- 			<a href="#" class="dropbtn">市場商情分析</a> -->
	<!-- 			<div class="dropdown-content"> -->
	<!-- 				<a href="cloudISS.jsp">生活費用</a> -->
	<!-- 				<a href="cloudISS.jsp">區位選擇</a> -->
	<!-- 				<a href="cloudISS.jsp">環域分析</a> -->
	<!-- 				<a href="cloudISS.jsp">動態統計</a> -->
	<!-- 			</div> -->
	<!-- 		</li> -->
	<!-- 		<li><a href="businessdistrict.jsp">定位</a></li> -->
			<li class="dropdown">
				<a href="businessdistrict.jsp" class="dropbtn">定位</a>
	<!-- 			<div class="dropdown-content"> -->
	<!-- 				<a href="#">國家</a> -->
	<!-- 				<a href="#">城市</a> -->
	<!-- 				<a href="#">商圈</a> -->
	<!-- 			</div> -->
			</li>
		</ul>
		
	 	<h2 id="title" class="page-title">東南亞商機定位工具</h2>
	 	
		<div class="content-wrap" style="display:none">
		</div>
		
		<footer class="footer">
<!-- 			財團法人商業發展研究院  <span>電話(02)7707-4800 | 傳真(02)7713-3366</span>  -->
			北祥股份有限公司 <span>服務電話：+886-2-2658-1910 | 傳真：+886-2-2658-1920</span>
		</footer>
	</div>


	<div class="content-wrap">
		<div class="search-result-wrap" style="height:100%">
			<iframe id="ifm1" width="100%" height="100%" src="\/persona\/Persona_ProductAdminCtrl"></iframe>
<!-- 		<object type="text/html" width="100%" height="100%" id="page1" data="\/persona\/Persona_ProductAdminCtrl"></object> -->
		</div>
	</div>

</body>
</html>