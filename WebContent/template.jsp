<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>template</title>
	<link rel="stylesheet" href="css/jquery-ui.min.css">
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<link rel="stylesheet" href="css/styles.css">
	<link rel="stylesheet" href="css/1.11.4/jquery-ui.css">
	<script type="text/javascript" src="js/jquery-3.1.0.min.js"></script>
<script>
function who(){
	switch(location.pathname.split("/")[2]){
//#######  動態磚  ########
	case "brick.jsp":
		return "動態磚";
		break;
	case "finModel.jsp":
		return "新創公司財務損益平衡評估工具";
		break;
	case "population.jsp":
		return "台灣人口社經資料";
		break;
//#######  服務業雲端智慧商情支援系統   #######
	case "cloudISS.jsp":
		return "服務業雲端智慧商情支援系統";
		break;
//#######  城市商圈    #######
	case "marketPlace.jsp":
		return "城市商圈";
		break;
//#######  東南亞商機定位工具    #######
	case "persona.jsp":
		return "東南亞商機定位工具";
		break;
//######線上學院##########################
	case "onlinecourse.jsp":
		return "線上學院";
		break;
	default:
		alert("default_page;");
		return "something_wrong?";
		break;
	}
};
</script>
</head>
<body>
<script>
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
});
</script>
<div class="page-wrapper" >
	<div class="header logoHeader" style="z-index:1;">
		<h1>SBI</h1>
		<div class="userinfo" style="z-index:1;">
			<p>使用者<span><%= (request.getSession().getAttribute("user_name")==null)?"@_@?":request.getSession().getAttribute("user_name").toString() %></span></p>
			<a id="logout" class="btn-logout" >登出</a>
		</div>
<!-- 	<h1 class="logo">sbi Portal</h1>  -->
<!-- 		<div class="menu" style="z-index:3;"> -->
<!--         	<ul class="tabs"> -->
<!-- 				<li>登入</li> -->
<!-- 	                <li><a href="cloudiss.psml">服務業雲端智慧商情支援系統</a></li> -->
<!-- 	                <li><a href="financeModel.psml">新創公司損益平衡財務評估工具</a></li> -->
<!-- 	                <li><a href="population.psml">台灣人口社會經濟資料api</a></li> -->
<!-- 	                <li><a href="marketplace.psml">城市商圈</a></li> -->
<!-- 	                <li><a href="persona.psml">東南亞商機定位工具</a> -->
<!-- 				</li> -->
<!--            	</ul> -->
<!-- 		</div> -->
	</div><!-- /.header -->

	<div class="sidenav" style="z-index:2;">
		<ul>
			<li><img src="images/sidenav-transaction.svg" alt="">動態磚
				<ul>
					<li><a href="brick.jsp">國家/城巿商圈</a></li>
					<li><a href="brick.jsp">目標客群定位</a></li>
					<li><a href="brick.jsp">目標商圈定位</a></li>
					<li><a href="brick.jsp">競爭者定位</a></li>
					<li><a href="brick.jsp">商品通路</a></li>
					<li><a href="finModel.jsp">新創公司財務損益平衡評估工具</a></li>
					<li><a href="population.jsp">台灣人口社經資料</a></li>
				</ul>
			</li>
			<li class="active"><img src="images/sidenav-support.svg" alt="">服務業雲端智慧商情支援系統
				<ul >
					<li><a href="cloudISS.jsp">服務業雲端智慧商情支援系統</a></li>
				</ul>
			</li>
			<li><img src="images/sidenav-report.svg" alt="">城市商圈
				<ul>
					<li><a href="marketPlace.jsp">城市商圈</a></li>
				</ul>
			</li>
			<li><img src="images/sidenav-chart.svg" alt="">東南亞商機定位工具
				<ul>
					<li><a href="persona.jsp">東南亞商機定位工具</a></li>
				</ul>
			</li>
			<li><img src="images/sidenav-school.svg" alt="">線上學院
				<ul>
					<li><a href="onlinecourse.jsp">線上學院</a></li>
				</ul>
			</li>
		</ul>
	</div><!--  /.sidenav  -->
 	<h2 id="title" class="page-title" style="z-index:2">title</h2> 
	<div class="content-wrap" style="display:none">
	

	</div><!-- /.content-wrap -->
<!--################結束###############-->
	<footer class="footer" style="z-index:1;">
		財團法人商業發展研究院  <span>電話(02)7707-4800 | 傳真(02)7713-3366</span> 
	</footer><!-- / .footer -->
</div><!-- /.page-wrapper -->
<script src="js/jquery-3.1.0.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/scripts.js"></script>

</body>
</html>