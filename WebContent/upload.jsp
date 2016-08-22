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
<body>
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
			if($("#file").val()<1){
				alert("請選擇檔案");
				return false;
			}
			var i=0;
			while(!document.getElementsByName("db_name")[i].checked){
				i++;
			}
			document.getElementById("form1").action+="?db_name="+document.getElementsByName("db_name")[i].value;
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
	<div class="content-wrap">
		<br/>
		<div class="panelWrap">
			<div class="panel-title">
		        <h2>選擇欲上傳資料表</h2>
		    </div>
			<form action="upload.do" id="form1" method="post" enctype="multipart/form-data" style="margin:20px;">
				<table class="formTable aCenter" style="width: 80%; margin:auto">
					<thead>
						<tr>
							<td COLSPAN="8">  </td>
						</tr>
		           	</thead>
		           	<tbody>
						<tr>
							<td><input type="radio" name="db_name" value="City" /></td>
							<td class="aLeft">城市資料表</td>
							<td><input type="radio" name="db_name" value="CityCivilCar" /></td>
							<td class="aLeft">城市民用汽車擁有量資料表</td>
							<td><input type="radio" name="db_name" value="CityConsumptionExpenditure" /></td>
							<td class="aLeft">城市消費支出資料表</td>
							<td><input type="radio" name="db_name" value="CityEstateAvgSale" /></td>
							<td class="aLeft">城市房地產平均銷售價格資料表</td>
						</tr>
						<tr>
							<td><input type="radio" name="db_name" value="CityEstateCompletion" /></td>
							<td class="aLeft">城市房地產竣工面積資料表</td>
							<td><input type="radio" name="db_name" value="CityEstateSaleAmount" /></td>
							<td class="aLeft">城市房地產銷售額資料表</td>
							<td><input type="radio" name="db_name" value="CityEstateSaleArea" /></td>
							<td class="aLeft">城市房地產銷售面積資料表</td>
							<td><input type="radio" name="db_name" value="CityGender" /></td>
							<td class="aLeft">城市性別人口數資料表</td>
						</tr>
						<tr>
							<td><input type="radio" name="db_name" value="CityGoodsTraffic" /></td>
							<td class="aLeft">城市貨運量資料表</td>
							<td><input type="radio" name="db_name" value="CityIncome" /></td>
							<td class="aLeft">城市所得資料表</td>
							<td><input type="radio" name="db_name" value="CityPassengerTraffic" /></td>
							<td class="aLeft">城市客運量資料表</td>
							<td><input type="radio" name="db_name" value="CityPractitioners" /></td>
							<td class="aLeft">城市從業人員數資料表</td>
						</tr>
						<tr>
							<td><input type="radio" name="db_name" value="CityRetailExponent" /></td>
							<td class="aLeft">城市商品零售價格指數資料表</td>
							<td><input type="radio" name="db_name" value="CitySocialConsume" /></td>
							<td class="aLeft">城市社會消費品零售總額資料表</td>
							<td><input type="radio" name="db_name" value="CityStaff" /></td>
							<td class="aLeft">城市國有單位職工人數資料表</td>
							<td><input type="radio" name="db_name" value="CityTertiaryIncrease" /></td>
							<td class="aLeft">城市第三產業增加趨勢資料表</td>
						</tr>
						<tr>
							<td><input type="radio" name="db_name" value="CityTertiaryIndustry" /></td>
							<td class="aLeft">城市第三產業GDP比重資料表</td>
							<td><input type="radio" name="db_name" value="CityWholesaleRetail" /></td>
							<td class="aLeft">城市批發零售社會消費品零售總額資料表</td>
							<td><input type="radio" name="db_name" value="consumer_intelligence" /></td>
							<td class="aLeft">消費力情報資料表</td>
							<td><input type="radio" name="db_name" value="Country" /></td>
							<td class="aLeft">國家資料表</td>
						</tr>
						<tr>
							<td><input type="radio" name="db_name" value="CountryAge" /></td>
							<td class="aLeft">國家年齡人口數資料表</td>
							<td><input type="radio" name="db_name" value="CountryLaborForce" /></td>
							<td class="aLeft">國家勞動力結構資料表</td>
							<td><input type="radio" name="db_name" value="Gender" /></td>
							<td class="aLeft">國家性別人口數資料表</td>
							<td><input type="radio" name="db_name" value="MarketSize" /></td>
							<td class="aLeft">國家產業數據資料表</td>
						</tr>
						<tr>
							<td><input type="radio" name="db_name" value="Variables" /></td>
							<td class="aLeft">變數資料表</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<div style="text-align:center; margin:0px auto;font-size:35px;">
						<input type="file" id="file" name="file" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" style="opacity:0.7;position:absolute;margin:18px 0 0 5px;"/>
						<input type="text" id="upload_name" size="40" style="z-index:-1" />
						<input type="submit" onclick="$('body').css('cursor', 'wait');return setV();" value="檔案匯入" class="btn btn-exec btn-wide" style="color: #fff;margin-left:20px"/>
				</div> 
			</form>
		</div>
	</div>
<%-- <h4>${action}</h4> --%>
</body>
</html>