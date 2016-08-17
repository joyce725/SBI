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
<title>台灣人口社會經濟資料api</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value="css/css.css" />" rel="stylesheet">
<link href="<c:url value="css/jquery.dataTables.min.css" />" rel="stylesheet">
<link href="<c:url value="css/1.11.4/jquery-ui.css" />" rel="stylesheet">
<link rel="stylesheet" href="css/1.11.4/jquery-ui.css">
<link rel="stylesheet" href="css/styles.css">
<link rel="stylesheet" type="text/css" href="css/dynamicbrick.css" />
<script type="text/javascript" src="http://d3js.org/d3.v3.min.js"></script>
</head>
<body>
	<jsp:include page="template.jsp" flush="true"/>
	<script type="text/javascript" src="js/jquery-3.1.0.min.js"></script>
	<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
	<script type="text/javascript" src="js/additional-methods.min.js"></script>
	<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>
	<div class="content-wrap" style="margin:56px 0px 28px 120px;">
	
    <br/>
	<div>       
		類別：&nbsp;&nbsp;&nbsp;
	    <input type="radio" name="data_kind" value="sex_age" onclick="showSexAge();">性別人口統計&nbsp;&nbsp;&nbsp; 
	    <input type="radio" name="data_kind" value="sex_age_edu" onclick="showSexAgeEdu();">年齡組與性別與教育程度人口統計&nbsp;&nbsp;&nbsp;      
	    <input type="radio" name="data_kind" value="sex_marriage" onclick="showSexMarriage();">性別與婚姻狀況統計<br>
	<!--
	    資料格式：&nbsp;&nbsp;&nbsp;
	    <input type="radio" name="data_type" value="json">JSON&nbsp;&nbsp;&nbsp;
	    <input type="radio" name="data_type" value="csv">CSV
	-->
	    <br/>
	    <div id="divAdminTable" class="datalistWrap">
	    	<div class="row aCenter">
				<table class="formTable aCenter" style="width:80%; margin-left:100px;"> 
					<thead>
						<tr>
							<th style="width:15%">縣市資料</th>
							<th style="width:55%">資料內容</th>
							<th style="width:15%">更新資料庫</th>
							<th style="width:15%">下載資料</th>
						</tr>
					</thead>
					<tbody>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form0">
				    			<td>新北市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form0');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5A4BD546BD98169DDF74E9E925806DB7CD8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5A4BD546BD98169DDF74E9E925806DB7CD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form1">
				    			<td>臺北市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form1');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C53EC2490B4BC27DD1F74E9E925806DB7CD8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C53EC2490B4BC27DD1F74E9E925806DB7CD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form2">
				    			<td>桃園市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form2');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C598450F1BD67D4B02F74E9E925806DB7CD8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C598450F1BD67D4B02F74E9E925806DB7CD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form3">
				    			<td>臺中市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form3');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C55BB2F8B8A1BC0667F74E9E925806DB7CD8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C55BB2F8B8A1BC0667F74E9E925806DB7CD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form4">
				    			<td>臺南市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form4');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C55C075678FCE6CFB3F74E9E925806DB7CD8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C55C075678FCE6CFB3F74E9E925806DB7CD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form5">
				    			<td>高雄市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form5');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5DC17510EEACC9371F74E9E925806DB7CD8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5DC17510EEACC9371F74E9E925806DB7CD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form6">
				    			<td>宜蘭縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form6');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F302DBAFC3AA67551AD8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F302DBAFC3AA67551AD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form7">
				    			<td>新竹縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form7');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F37BABE5A2B035F632D8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F37BABE5A2B035F632D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form8">
				    			<td>苗栗縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form8');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F3B3F50B8F7A26BC4FD8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F3B3F50B8F7A26BC4FD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form9">
				    			<td>彰化縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form9');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F371F479EBD1A8F092D8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F371F479EBD1A8F092D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form10">
				    			<td>南投縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form10');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F338683B55ACF9C526D8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F338683B55ACF9C526D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form11">
				    			<td>雲林縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form11');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F32ED8E655064FC348D8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F32ED8E655064FC348D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form12">
				    			<td>嘉義縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form12');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F39FCE5FC322E6E899D8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F39FCE5FC322E6E899D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form13">
				    			<td>屏東縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form13');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F376040AB4C5AF04A8D8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F376040AB4C5AF04A8D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form14">
				    			<td>臺東縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form14');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F341DA03395C03F9FAD8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F341DA03395C03F9FAD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form15">
				    			<td>花蓮縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form15');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F37F3EBA7587914FF3D8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F37F3EBA7587914FF3D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form16">
				    			<td>澎湖縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form16');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F3A5F948415CECE92AD8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F3A5F948415CECE92AD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form17">
				    			<td>基隆市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form17');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F3699FE03026989671D8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F3699FE03026989671D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form18">
				    			<td>新竹市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form18');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F33C270B8191D0C5E9D8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F33C270B8191D0C5E9D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form19">
				    			<td>嘉義市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form19');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F3EA09C6570D6B90B5D8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F3EA09C6570D6B90B5D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form20">
				    			<td>金門縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form20');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C59B8468D8E9726F6FEA09C6570D6B90B5D8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C59B8468D8E9726F6FEA09C6570D6B90B5D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form21">
				    			<td>連江縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form21');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C59B8468D8E9726F6F71F479EBD1A8F092D8BBECC4B34231B0" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C59B8468D8E9726F6F71F479EBD1A8F092D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form22">
				    			<td>新北市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form22');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA5AF51EE58102DB3A0956DEC9A8D69E14C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA5AF51EE58102DB3A0956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form23">
				    			<td>臺北市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form23');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA3A3DF3C036C92FFF0956DEC9A8D69E14C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA3A3DF3C036C92FFF0956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form24">
				    			<td>桃園市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form24');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65A63574C79B563547C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65A63574C79B563547C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form25">
				    			<td>臺中市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form25');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAD4123DE6BDBCDB7D0956DEC9A8D69E14C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAD4123DE6BDBCDB7D0956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form26">
				    			<td>臺南市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form26');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA6EE67DC3679E00D20956DEC9A8D69E14C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA6EE67DC3679E00D20956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form27">
				    			<td>高雄市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form27');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA1CD388FE1FC545A90956DEC9A8D69E14C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA1CD388FE1FC545A90956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form28">
				    			<td>宜蘭縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form28');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65B23873BCCAF65274C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65B23873BCCAF65274C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form29">
				    			<td>新竹縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form29');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65EC8B3D43E19BC0ACC93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65EC8B3D43E19BC0ACC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form30">
				    			<td>苗栗縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form30');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B658F58070F44009671C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B658F58070F44009671C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form31">
				    			<td>彰化縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form31');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65417218D4C8282395C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65417218D4C8282395C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form32">
				    			<td>南投縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form32');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65E4291A3C37F0F2CAC93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65E4291A3C37F0F2CAC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form33">
				    			<td>雲林縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form33');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65B4E07A27A9DCBC06C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65B4E07A27A9DCBC06C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form34">
				    			<td>嘉義縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form34');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B652B8FA2C70207CBC9C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B652B8FA2C70207CBC9C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form35">
				    			<td>屏東縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form35');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B657D04EB2CAA3BDF8EC93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B657D04EB2CAA3BDF8EC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form36">
				    			<td>臺東縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form36');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65970DA659475E3BACC93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65970DA659475E3BACC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form37">
				    			<td>花蓮縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form37');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B655A06EBF1E2126985C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B655A06EBF1E2126985C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form38">
				    			<td>澎湖縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form38');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B652DAC6E70D47487BEC93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B652DAC6E70D47487BEC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form39">
				    			<td>基隆市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form39');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65658B6629E77FF018C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65658B6629E77FF018C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form40">
				    			<td>新竹市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form40');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65118135321DF5C2FCC93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65118135321DF5C2FCC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form41">
				    			<td>嘉義市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form41');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B6587B08BA6EC353C5CC93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B6587B08BA6EC353C5CC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form42">
				    			<td>金門縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form42');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA0E8A254FE121C41F87B08BA6EC353C5CC93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA0E8A254FE121C41F87B08BA6EC353C5CC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form43">
				    			<td>連江縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form43');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA0E8A254FE121C41F417218D4C8282395C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA0E8A254FE121C41F417218D4C8282395C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form44">
				    			<td>新北市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form44');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F409EB1DC5F1F8A2D2B0956DEC9A8D69E14C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F409EB1DC5F1F8A2D2B0956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form45">
				    			<td>臺北市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form45');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F404505D4DF893B8CAB0956DEC9A8D69E14C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F404505D4DF893B8CAB0956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form46">
				    			<td>桃園市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form46');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8A63574C79B563547C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8A63574C79B563547C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form47">
				    			<td>臺中市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form47');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F406183AA7E3F83C5C50956DEC9A8D69E14C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F406183AA7E3F83C5C50956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form48">
				    			<td>臺南市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form48');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F401C1584EE437DFED60956DEC9A8D69E14C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F401C1584EE437DFED60956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form49">
				    			<td>高雄市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form49');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40E2FC4DF7621F05000956DEC9A8D69E14C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40E2FC4DF7621F05000956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form50">
				    			<td>宜蘭縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form50');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8B23873BCCAF65274C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8B23873BCCAF65274C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form51">
				    			<td>新竹縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form51');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8EC8B3D43E19BC0ACC93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8EC8B3D43E19BC0ACC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form52">
				    			<td>苗栗縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form52');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA88F58070F44009671C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA88F58070F44009671C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form53">
				    			<td>彰化縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form53');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8417218D4C8282395C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8417218D4C8282395C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form54">
				    			<td>南投縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form54');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8E4291A3C37F0F2CAC93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8E4291A3C37F0F2CAC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form55">
				    			<td>雲林縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form55');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8B4E07A27A9DCBC06C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8B4E07A27A9DCBC06C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form56">
				    			<td>嘉義縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form56');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA82B8FA2C70207CBC9C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA82B8FA2C70207CBC9C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form57">
				    			<td>屏東縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form57');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA87D04EB2CAA3BDF8EC93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA87D04EB2CAA3BDF8EC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form58">
				    			<td>臺東縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form58');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8970DA659475E3BACC93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8970DA659475E3BACC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form59">
				    			<td>花蓮縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form59');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA85A06EBF1E2126985C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA85A06EBF1E2126985C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form60">
				    			<td>澎湖縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form60');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA82DAC6E70D47487BEC93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA82DAC6E70D47487BEC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form61">
				    			<td>基隆市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form61');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8658B6629E77FF018C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8658B6629E77FF018C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form62">
				    			<td>新竹市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form62');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8118135321DF5C2FCC93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8118135321DF5C2FCC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form63">
				    			<td>嘉義市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form63');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA887B08BA6EC353C5CC93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA887B08BA6EC353C5CC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form64">
				    			<td>金門縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form64');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F405BFC8E6AA103483187B08BA6EC353C5CC93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F405BFC8E6AA103483187B08BA6EC353C5CC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form65">
				    			<td>連江縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="update_database('form65');">更新</a></td>
				    			<td><a href="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F405BFC8E6AA1034831417218D4C8282395C93C1F4155955501" target="_blank">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F405BFC8E6AA1034831417218D4C8282395C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
					</tbody>
				</table>
			</div>
		</div>
	</div>

<script>
	function showSexAge(){
		var group1 = "tr[name='sex_age']";
		var group2 = "tr[name='sex_age_edu']";
		var group3 = "tr[name='sex_marriage']";
    	$(group1).show();
    	$(group2).hide();
		$(group3).hide();
	}
	function showSexAgeEdu(){
		var group1 = "tr[name='sex_age']";
		var group2 = "tr[name='sex_age_edu']";
		var group3 = "tr[name='sex_marriage']";
    	$(group2).show();
    	$(group1).hide();
		$(group3).hide();
	}
	function showSexMarriage(){
		var group1 = "tr[name='sex_age']";
		var group2 = "tr[name='sex_age_edu']";
		var group3 = "tr[name='sex_marriage']";
    	$(group3).show();
    	$(group2).hide();
		$(group1).hide();
	}
	function update_database(form_name){
// 		alert(form_name);
// 		alert($("#formXXX input[name='url']").val());
// 		alert("url: " + $("#"+ form_name + " input[name='url']").val());
// 		alert("kind: " + $('#'+ form_name + " input[name='kind']").val());
// 		alert("type: " + $('#'+ form_name + " input[name='type']").val());
		$.ajax({
			type : "POST",
			url : "population.do",
			data : {
				action : "update_db",
				url : $('#'+ form_name + " input[name='url']").val(),
				kind : $('#'+ form_name + " input[name='kind']").val(),
				type : $('#'+ form_name + " input[name='type']").val()
			},
			success : function(result) {
				alert(result);
			}
		});
		$('body').css('cursor', 'default');
	}
</script>
</body>
</html>