<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<jsp:directive.page import="java.sql.SQLException" />
<!DOCTYPE html>
<html>
<head>
<title>首頁</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value="css/css.css" />" rel="stylesheet">
<link href="<c:url value="css/jquery.dataTables.min.css" />" rel="stylesheet">
<link href="<c:url value="css/1.11.4/jquery-ui.css" />" rel="stylesheet">
<link rel="stylesheet" href="css/1.11.4/jquery-ui.css">
<link rel="stylesheet" href="css/styles.css">
<link rel="stylesheet" type="text/css" href="css/dynamicbrick.css" />
</head>
<body>
	<jsp:include page="template.jsp" flush="true"/>
	<div class="content-wrap">
		<!-- begin -->
		<div class="examples_body">
		  	<ul class="bannerHolder">
				<li>
					<div class="banner"> <a href="marketPlace.jsp">國家/城巿商圈 <img height="125" width="125" src="images/6.jpg" /> </a>
						<p class="companyInfo">視覺化展示國家及城巿經濟人口等展店參考數據資訊</p>
						<div class="cornerTL"></div>
						<div class="cornerTR"></div>
						<div class="cornerBL"></div>
						<div class="cornerBR"></div>
					</div>
				</li>
			    <li>
			      	<div class="banner"> <a href="#"> 目標客群定位 <img height="125" width="125" src="images/2.jpg" /> </a>
				        <p class="companyInfo">提供產品主要客群輪廓</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
			    <li>
			      	<div class="banner"> <a href="#"> 目標商圈定位<img height="125" width="125" src="images/5.jpg" /> </a>
			        	<p class="companyInfo">提供店址選擇建議</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
			    <li>
			      	<div class="banner"> <a href="#">競爭者定位<img height="125" width="125" src="images/4.jpg" /> </a>
				        <p class="companyInfo">可能的競爭對手及產品</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
			    <li>
			      	<div class="banner"> <a href="#"> 商品通路 <img height="125" width="125" src="images/1.jpg" /> </a>
				        <p class="companyInfo">通路選擇建議</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
				<li>
			      	<div class="banner"> <a href="finModel.jsp"> 新創公司財務損益平衡評估工具 <img height="125" width="125" src="images/3.jpg" /> </a>
				        <p class="companyInfo">財務健康狀況評估模擬器</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
				<li>
			      	<div class="banner"> <a href="#"> 台灣人口社經資料庫api <img height="125" width="125" src="images/7.jpg" /> </a>
				        <p class="companyInfo">提供台灣人口社經資料及分析</p>
				        <div class="cornerTL"></div>
				        <div class="cornerTR"></div>
				        <div class="cornerBL"></div>
				        <div class="cornerBR"></div>
			      	</div>
			    </li>
		  	</ul>
		</div>
	</div>
<script type="text/javascript" src="js/jquery-3.1.0.min.js"></script>
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
