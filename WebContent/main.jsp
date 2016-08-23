<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>首頁</title>
<link rel="Shortcut Icon" type="image/x-icon" href="./images/cdri-logo.gif" />
<link rel="stylesheet" type="text/css" href="css/dynamicbrick.css" />
</head>
<body>
	<jsp:include page="template.jsp" flush="true"/>
	<div class="content-wrap">
		<!-- begin -->
		<div class="examples_body">
		  	<ul class="bannerHolder">
				<li>
					<div class="banner"> <a href="#">國家/城巿商圈<img height="100" width="100" src="images/1.png" /> </a>
						<p class="companyInfo">視覺化展示國家及城巿經濟人口等展店參考數據資訊</p>
						<div class="cornerTL"></div>
						<div class="cornerTR"></div>
						<div class="cornerBL"></div>
						<div class="cornerBR"></div>
					</div>
				</li>
			    <li>
			      	<div class="banner"> <a href="#">目標客群定位<img height="100" width="100" src="images/2.png" /> </a>
				        <p class="companyInfo">提供產品主要客群輪廓</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
			    <li>
			      	<div class="banner"> <a href="#">目標商圈定位<img height="100" width="100" src="images/3.png" /> </a>
			        	<p class="companyInfo">提供店址選擇建議</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
			    <li>
			      	<div class="banner"> <a href="#">競爭者定位<img height="100" width="100" src="images/4.png" /> </a>
				        <p class="companyInfo">可能的競爭對手及產品</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
			    <li>
			      	<div class="banner"> <a href="#">商品通路<img height="100" width="100" src="images/5.png" /> </a>
				        <p class="companyInfo">通路選擇建議</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
				<li>
			      	<div class="banner"> <a href="finModel.jsp">新創公司財務損益平衡評估工具<img height="100" width="100" src="images/6.png" /> </a>
				        <p class="companyInfo">財務健康狀況評估模擬器</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
				<li>
			      	<div class="banner"> <a href="population.jsp">台灣人口社經資料庫api<img height="100" width="100" src="images/7.png" /> </a>
				        <p class="companyInfo">提供台灣人口社經資料及分析</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
				<li>
			      	<div class="banner"> <a href="upload.jsp">產業分析基礎資料庫<img height="100" width="100" src="images/8.png" /> </a>
				        <p class="companyInfo">產業分析基礎資料庫</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
				<li>
			      	<div class="banner"> <a href="cloudISS.jsp">服務業雲端智慧商情支援系統<img height="100" width="100" src="images/9.png" /> </a>
				        <p class="companyInfo">服務業雲端智慧商情支援系統</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
				<li>
			      	<div class="banner"> <a href="persona.jsp">東南亞商機定位工具<img height="100" width="100" src="images/10.png" /> </a>
				        <p class="companyInfo">東南亞商機定位工具</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
				<li>
			      	<div class="banner"> <a href="marketPlace.jsp">城市商圈<img height="100" width="100" src="images/11.png" /> </a>
				        <p class="companyInfo">城市商圈</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
				<li>
			      	<div class="banner"> <a href="productForecast.jsp">新產品風向預測<img height="100" width="100" src="images/12.png" /> </a>
				        <p class="companyInfo">新產品風向預測</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
		  	</ul>
		</div>
	</div>
<script>
$(function(){
	$('.banner div').css('opacity',0.4);
	$('.banner').hover(function(){		
		var el = $(this);
		el.find('div').stop().animate({width:200,height:200},'slow',function(){
			el.find('p').fadeIn('fast');
		});
	},function(){
		var el = $(this);
		el.find('p').stop(true,true).hide();
		el.find('div').stop().animate({width:60,height:60},'fast');
	}).click(function(){
		window.open($(this).find('a').attr('href'), "_parent");
	});
})
</script>
</body>
</html>
