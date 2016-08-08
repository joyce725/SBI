<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="vendor/css/jquery-ui.min.css">
	<link rel="stylesheet" href="vendor/css/font-awesome.min.css">
	<link rel="stylesheet" href="css/styles.css">
	<link rel="stylesheet" href="css/1.11.4/jquery-ui.css">
	<script type="text/javascript" src="js/jquery-3.1.0.min.js"></script>
<script>
function who(){
	switch(location.pathname.split("/")[2]){
//####交易處理############################
	case "upload.jsp":
		return "訂單拋轉作業";
		break;
//####後臺支援系統############################
	case "purchase.jsp":
		return "進貨管理";
		break;
	case "purchreturn.jsp":
		return "進貨退回管理";
		break;
	case "sale.jsp":
		return "銷貨管理";
		break;
	case "salereturn.jsp":
		return "銷貨退回管理";
		break;
	case "stock.jsp":
		return "庫存管理";
		break;
	case "producttype.jsp":
		return "商品類型管理";
		break;
	case "productunit.jsp":
		return "商品單位管理";
		break;
	case "product.jsp":
		return "商品管理";
		break;
	case "supply.jsp":
		return "供應商管理";
		break;
	case "user.jsp":
		return "用戶管理";
		break;
	case "group.jsp":
		return "公司管理";
		break;
	case "customer.jsp":
		return "客戶管理";
		break;
	case "accreceive.jsp":
		return "應收帳款管理";
		break;
	case "accpay.jsp":
		return "應付帳款管理";
		break;
	case "changepassword.jsp":
		return "密碼修改";
		break;
	case "tagprint.jsp":
		return "標籤列印";
		break;
//####報表管理############################
	case "salereport.jsp":
		return "訂單報表";
		break;
	case "distributereport.jsp":
		return "配送報表";
		break;
	case "salereturnreport.jsp":
		return "退貨報表";
		break;
	case "shipreport.jsp":
		return "出貨報表";
		break;
	case "purchreport.jsp":
		return "進貨報表";
		break;
	case "purchreturnreport.jsp":
		return "進貨退回報表";
		break;
//######分析圖表##########################
	case "salechart.jsp":
		return "出貨量統計圖";
		break;
	case "saleamountchart.jsp":
		return "銷售金額統計圖";
		break;
	case "saleamountstaticchart.jsp":
		return "銷售金額比例統計圖";
		break;
//######線上學院##########################
	case "onlinecourse.jsp":
		return "線上學院";
		break;
	case "template.jsp":
		return "暫時的";
		break;
	case "welcome.jsp":
		return "請安心使用";
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
// 	$("#title").html(who());
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

<!-- 	<div class="sidenav" style="z-index:2;"> -->
<!-- 		<ul> -->
<!-- 			<li><img src="images/sidenav-transaction.svg" alt="">交易處理 -->
<!-- 				<ul> -->
<!-- 					<li><a href="upload.jsp">訂單拋轉作業</a></li> -->
<!-- 					<li><a href="ui-elements.html">UI 元件列表</a></li> -->
<!-- 				</ul> -->
<!-- 			</li> -->
<!-- 			<li class="active"><img src="images/sidenav-support.svg" alt="">後臺支援系統 -->
<!-- 				<ul > -->
<!-- 					<li><a href="purchase.jsp">進貨管理</a></li> -->
<!-- 					<li><a href="purchreturn.jsp">進貨退回管理</a></li> -->
<!-- 					<li><a href="sale.jsp">銷貨管理</a></li> -->
<!-- 					<li><a href="salereturn.jsp">銷貨退回管理</a></li> -->
<!-- 					<li><a href="stock.jsp">庫存管理</a></li> -->
<!-- 					<li><a href="producttype.jsp">商品類型管理</a></li> -->
<!-- 					<li><a href="productunit.jsp">商品單位管理</a></li> -->
<!-- 					<li><a href="product.jsp">商品管理</a></li> -->
<!-- 					<li><a href="supply.jsp">供應商管理</a></li> -->
<!-- 					<li><a href="user.jsp">用戶管理</a></li> -->
<!-- 					<li><a href="group.jsp">公司管理</a></li> -->
<!-- 					<li><a href="customer.jsp">客戶管理</a></li> -->
<!-- 					<li><a href="accreceive.jsp">應收帳款管理</a></li> -->
<!-- 					<li><a href="accpay.jsp">應付帳款管理</a></li> -->
<!-- 					<li><a href="changepassword.jsp">用戶帳密管理</a></li> -->
<!-- 					<li><a href="tagprint.jsp">標籤列印</a></li> -->
<!-- 				</ul> -->
<!-- 			</li> -->
<!-- 			<li><img src="images/sidenav-report.svg" alt="">報表管理 -->
<!-- 				<ul> -->
<!-- 					<li><a href="salereport.jsp">訂單報表</a></li> -->
<!-- 					<li><a href="shipreport.jsp">出貨報表</a></li> -->
<!-- 					<li><a href="distributereport.jsp">配送報表</a></li> -->
<!-- 					<li><a href="salereturnreport.jsp">退貨報表</a></li> -->
<!-- 					<li><a href="purchreport.jsp">進貨報表</a></li> -->
<!-- 					<li><a href="purchreturnreport.jsp">進貨退回報表</a></li> -->
<!-- 				</ul> -->
<!-- 			</li> -->
<!-- 			<li><img src="images/sidenav-chart.svg" alt="">分析圖表 -->
<!-- 				<ul> -->
<!-- 					<li><a href="salechart.jsp">出貨量統計圖</a></li> -->
<!-- 					<li><a href="saleamountchart.jsp">銷售金額統計圖</a></li> -->
<!-- 					<li><a href="saleamountstaticchart.jsp">銷售金額比例統計圖</a></li> -->
<!-- 				</ul> -->
<!-- 			</li> -->
<!-- 			<li><img src="images/sidenav-school.svg" alt="">線上學院 -->
<!-- 				<ul> -->
<!-- 					<li><a href="onlinecourse.jsp">線上學院</a></li> -->
<!-- 				</ul> -->
<!-- 			</li> -->
<!-- 		</ul> -->
<!-- 	</div>/.sidenav --> 
	<div class="content-wrap" style="display:none">
	

	</div><!-- /.content-wrap -->
<!--################結束###############-->
	<footer class="footer" style="z-index:1;">
		財團法人商業發展研究院  <span>電話(02)7707-4800 | 傳真(02)7713-3366</span> 
	</footer><!-- / .footer -->
</div><!-- /.page-wrapper -->
<script src="vendor/js/jquery-1.12.4.min.js"></script>
<script src="vendor/js/jquery-ui.min.js"></script>
<script src="js/scripts.js"></script>

</body>
</html>