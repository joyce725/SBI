<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>東南亞商機定位工具</title>
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
	
		<div class="sidenav">
			<h1 class="sys-title"><a href="login.jsp">SBI</a></h1>
			<ul>
				<li><a href="marketPlace.jsp"><img src="images/sidenav-country.svg" alt="">國家/城巿商圈</a></li>
				<li><img src="images/sidenav-strategy.svg" alt="">決策工具
					<ul>
						<li><a href="cloudISS.jsp">目標市場定位</a></li>
						<li><a href="personaNew.jsp">目標客群定位</a></li>
						<li><a href="cloudISS.jsp">競爭者定位</a></li>
<!-- 						<li><a href="cloudISS.jsp">商品通路</a></li> -->
						<li><a href="persona.jsp">城市定位</a></li>
						<li><a href="productForecast.jsp">新產品風向評估</a></li>
						<li><a href="finModel.jsp">新創公司財務損益平衡評估</a></li>
<!-- 						<li><a href="#">海外布局選擇</a></li> -->
						<li>
							<a>授權商品檢索機制</a>
							<ul>
								<li><a href="product.jsp">商品管理</a></li>
								<li><a href="agent.jsp">通路商管理</a></li>
								<li><a href="agentAuth.jsp">通路商授權商品管理</a></li>
								<li><a href="serviceAgentAssign.jsp">服務識別碼指定通路商作業</a></li>
								<li><a href="productVerify.jsp">商品真偽顧客驗證作業</a></li>
								<li><a href="authVerify.jsp">商品真偽通路商驗證作業</a></li>
								<li><a href="serviceVerify.jsp">服務識別碼查詢作業</a></li>
								<li><a href="serviceRegister.jsp">商品售後服務註冊</a></li>
							</ul>
						</li>
					</ul>
				</li>
				<li><img src="images/sidenav-stastic.svg" alt="">統計資料
					<ul>
						<li><a href="population.jsp">台灣人口社經</a></li>
						<li><a href="populationNew.jsp">台灣人口社經資料</a></li>
						<li><a href="upload.jsp">產業分析基礎資料庫</a></li>
						<li>
							<a>電子書</a>
							<ul>
								<li><a href="./images/大台北地區商圈.pdf" target="_blank">大台北地區</a></li>
								<li><a href="./images/桃園商圈.pdf" target="_blank">桃園地區</a></li>
								<li><a href="./images/台中商圈.pdf" target="_blank">台中地區</a></li>
								<li><a href="./images/台南商圈.pdf" target="_blank">台南地區</a></li>
								<li><a href="./images/高雄商圈.pdf" target="_blank">高雄地區</a></li>
							</ul>
						</li>
					</ul>
				</li>
				<li><img src="images/sidenav-analytic.svg" alt="">市場商情分析
					<ul>
						<li><a href="cloudISS.jsp">生活費用</a></li>
						<li><a href="regionSelect1221O.jsp">區位選擇</a></li>
						<li><a href="environmentAnalyseKao.jsp">環域分析</a></li>
						<li><a href="cloudISS.jsp">動態統計</a></li>
					</ul>
				</li>
				<li><a href="cloudISS.jsp"><img src="images/sidenav-store.svg" alt="">POI</a>
				</li>
			</ul>		
		</div>
		
	 	<h2 id="title" class="page-title">東南亞商機定位工具</h2>
	 	
		<div class="content-wrap" style="display:none">
		</div>
		
		<footer class="footer">
			財團法人商業發展研究院  <span>電話(02)7707-4800 | 傳真(02)7713-3366</span> 
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