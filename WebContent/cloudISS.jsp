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
<title>動態磚</title>
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
	<div class="content-wrap" style="margin:56px 0px 0px 0px;">
		<div class="examples_body">
			<div>
				<object type="text/html" data="http://61.218.8.51/SBI/user/login.aspx" width="100%" height="600px" style="overflow:auto;border:5px ridge blue">
				</object>
			</div>
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
		window.open($(this).find('a').attr('href'));
	});
})
</script>
<!-- 代码部分end -->
</body>
</html>