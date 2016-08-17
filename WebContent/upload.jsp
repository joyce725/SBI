<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="tw.com.sbi.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>


<!DOCTYPE html>
<html>
<head>
<title>檔案匯入</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value="css/css.css" />" rel="stylesheet">
<link href="<c:url value="css/jquery.dataTables.min.css" />" rel="stylesheet">
<link href="<c:url value="css/1.11.4/jquery-ui.css" />" rel="stylesheet">
<link rel="stylesheet" href="css/1.11.4/jquery-ui.css">
<link rel="stylesheet" href="css/styles.css">
<link rel="stylesheet" type="text/css" href="css/dynamicbrick.css" />
<script type="text/javascript" src="http://d3js.org/d3.v3.min.js"></script>
</head>
<body onload="openTab(event, 'finTool')">
	<jsp:include page="template.jsp" flush="true"/>
	<script type="text/javascript" src="js/jquery-3.1.0.min.js"></script>
	<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
	<script type="text/javascript" src="js/additional-methods.min.js"></script>
	<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>
	<script>
		function setV(){
			//alert("hello".indexOf('he')!=-1);
			//return false;
			if($("#file").val()<1){
				alert("請選擇檔案");
				return false;
			}
			return true;
		};
		$(function(){
			$("td").css("border","0px solid #aaa");
			$("td img").css("width","30px");	
		});
	</script>
<%
	String str=(String)request.getAttribute("action");
	if(str!=null){
		if("success".equals(str)){
			out.println("<script>alert('傳輸成功');$('body').css('cursor', 'default');window.location.href = './upload.jsp';</script>");
		}else{
			out.println("<script>alert('傳輸失敗 ');$('body').css('cursor', 'default');window.location.href = './upload.jsp';</script>");
		}
	}
%>
	<div class="content-wrap" style="margin:56px 0px 28px 120px;">
	
<div style="text-align:center; margin:0px auto;font-size:35px;"></div>
	<form action="upload.do" id="form1" method="post" enctype="multipart/form-data" style="margin:20px;">
		<input type="file" id="file" name="file" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" style="opacity:0.7;position:absolute;margin:6px;"/>
		<input type="text" id="upload_name" size="40" style="z-index:-1" />
		<input type="submit" onclick="$('body').css('cursor', 'wait');return setV();" value="檔案匯入" class="btn btn-exec btn-wide" style="color: #fff;margin-left:20px"/>
		<div id="msg" style="color:red;margin:5px;display:none;">請稍候片刻...</div>
	</form>
</div>
<%-- <h4>${action}</h4> --%>
</body>
</html>