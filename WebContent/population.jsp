<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>台灣人口社會經濟資料api</title>
<link rel="Shortcut Icon" type="image/x-icon" href="./images/cdri-logo.gif" />
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style type="text/css">
	#overlayBackground {
		background:#000;
		position:absolute;
		top:0px;
		left:0px;
		z-index:5;
	}
	
	#progress {
		position:absolute;
		top: 50%;
		left:15%;
		z-index:10;
		width: 70%;
	 	display: none;
	}
</style> 
</head>
<body onload="showSexAge()">	
	<jsp:include page="template.jsp" flush="true"/>
	<div class="content-wrap"><br/> 
		<div id="dialog" title="提示訊息" style="display:none">
			<label>資料更新完成</label>
		</div>
		<div id="progress" class="progress">
		    <div id="progress_bar" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">
		      0%
		    </div>
	 	</div>
		<div>		   
			<table>
				<thead>
					<tr style="width:70%">
						<td align="right">類別：</td>
						<td align="center">&nbsp;&nbsp;&nbsp;<input type="radio" name="data_kind" value="sex_age" onclick="showSexAge();" checked>性別人口統計&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td align="center"><input type="radio" name="data_kind" value="sex_age_edu" onclick="showSexAgeEdu();">年齡組與性別與教育程度人口統計&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td align="center"><input type="radio" name="data_kind" value="sex_marriage" onclick="showSexMarriage();">性別與婚姻狀況統計</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td align="right">全部更新：</td>
						<td>&nbsp;&nbsp;&nbsp;<a href="javascript:{}" onclick="$('body').css('cursor', 'wait');updata_all()">更新</a></td>
					</tr>
				</thead>
			</table>
	    </div>
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
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5A4BD546BD98169DDF74E9E925806DB7CD8BBECC4B34231B0', '性別人口統計_新北市.json')">下載</a></td>
				    			<input type="hidden" id="url" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5A4BD546BD98169DDF74E9E925806DB7CD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form1">
				    			<td>臺北市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form1');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C53EC2490B4BC27DD1F74E9E925806DB7CD8BBECC4B34231B0', '性別人口統計_臺北市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C53EC2490B4BC27DD1F74E9E925806DB7CD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form2">
				    			<td>桃園市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form2');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C598450F1BD67D4B02F74E9E925806DB7CD8BBECC4B34231B0', '性別人口統計_桃園市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C598450F1BD67D4B02F74E9E925806DB7CD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form3">
				    			<td>臺中市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form3');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C55BB2F8B8A1BC0667F74E9E925806DB7CD8BBECC4B34231B0', '性別人口統計_臺中市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C55BB2F8B8A1BC0667F74E9E925806DB7CD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form4">
				    			<td>臺南市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form4');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C55C075678FCE6CFB3F74E9E925806DB7CD8BBECC4B34231B0', '性別人口統計_臺南市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C55C075678FCE6CFB3F74E9E925806DB7CD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form5">
				    			<td>高雄市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form5');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5DC17510EEACC9371F74E9E925806DB7CD8BBECC4B34231B0', '性別人口統計_高雄市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5DC17510EEACC9371F74E9E925806DB7CD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form6">
				    			<td>宜蘭縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form6');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F302DBAFC3AA67551AD8BBECC4B34231B0', '性別人口統計_宜蘭縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F302DBAFC3AA67551AD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form7">
				    			<td>新竹縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form7');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F37BABE5A2B035F632D8BBECC4B34231B0', '性別人口統計_新竹縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F37BABE5A2B035F632D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form8">
				    			<td>苗栗縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form8');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F3B3F50B8F7A26BC4FD8BBECC4B34231B0', '性別人口統計_苗栗縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F3B3F50B8F7A26BC4FD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form9">
				    			<td>彰化縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form9');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F371F479EBD1A8F092D8BBECC4B34231B0', '性別人口統計_彰化縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F371F479EBD1A8F092D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form10">
				    			<td>南投縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form10');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F338683B55ACF9C526D8BBECC4B34231B0', '性別人口統計_南投縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F338683B55ACF9C526D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form11">
				    			<td>雲林縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form11');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F32ED8E655064FC348D8BBECC4B34231B0', '性別人口統計_雲林縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F32ED8E655064FC348D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form12">
				    			<td>嘉義縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form12');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F39FCE5FC322E6E899D8BBECC4B34231B0', '性別人口統計_嘉義縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F39FCE5FC322E6E899D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form13">
				    			<td>屏東縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form13');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F376040AB4C5AF04A8D8BBECC4B34231B0', '性別人口統計_屏東縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F376040AB4C5AF04A8D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form14">
				    			<td>臺東縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form14');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F341DA03395C03F9FAD8BBECC4B34231B0', '性別人口統計_臺東縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F341DA03395C03F9FAD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form15">
				    			<td>花蓮縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form15');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F37F3EBA7587914FF3D8BBECC4B34231B0', '性別人口統計_花蓮縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F37F3EBA7587914FF3D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form16">
				    			<td>澎湖縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form16');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F3A5F948415CECE92AD8BBECC4B34231B0', '性別人口統計_澎湖縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F3A5F948415CECE92AD8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form17">
				    			<td>基隆市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form17');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F3699FE03026989671D8BBECC4B34231B0', '性別人口統計_基隆市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F3699FE03026989671D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form18">
				    			<td>新竹市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form18');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F33C270B8191D0C5E9D8BBECC4B34231B0', '性別人口統計_新竹市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F33C270B8191D0C5E9D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form19">
				    			<td>嘉義市</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form19');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F3EA09C6570D6B90B5D8BBECC4B34231B0', '性別人口統計_嘉義市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C5E4BD6BD69354D4F3EA09C6570D6B90B5D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form20">
				    			<td>金門縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form20');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C59B8468D8E9726F6FEA09C6570D6B90B5D8BBECC4B34231B0', '性別人口統計_金門縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C59B8468D8E9726F6FEA09C6570D6B90B5D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age" id="form21">
				    			<td>連江縣</td>
				    			<td>統計區五歲年齡組性別人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form21');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C59B8468D8E9726F6F71F479EBD1A8F092D8BBECC4B34231B0', '性別人口統計_連江縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBAA621E921CCAA2C59B8468D8E9726F6F71F479EBD1A8F092D8BBECC4B34231B0" />
				    			<input type="hidden" name="kind" value="sex_age" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form22">
				    			<td>新北市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form22');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA5AF51EE58102DB3A0956DEC9A8D69E14C93C1F4155955501', '性別與教育程度人口統計_新北市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA5AF51EE58102DB3A0956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form23">
				    			<td>臺北市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form23');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA3A3DF3C036C92FFF0956DEC9A8D69E14C93C1F4155955501', '性別與教育程度人口統計_臺北市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA3A3DF3C036C92FFF0956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form24">
				    			<td>桃園市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form24');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65A63574C79B563547C93C1F4155955501', '性別與教育程度人口統計_桃園市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65A63574C79B563547C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form25">
				    			<td>臺中市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form25');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAD4123DE6BDBCDB7D0956DEC9A8D69E14C93C1F4155955501', '性別與教育程度人口統計_臺中市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAD4123DE6BDBCDB7D0956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form26">
				    			<td>臺南市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form26');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA6EE67DC3679E00D20956DEC9A8D69E14C93C1F4155955501', '性別與教育程度人口統計_臺南市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA6EE67DC3679E00D20956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form27">
				    			<td>高雄市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form27');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA1CD388FE1FC545A90956DEC9A8D69E14C93C1F4155955501', '性別與教育程度人口統計_高雄市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA1CD388FE1FC545A90956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form28">
				    			<td>宜蘭縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form28');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65B23873BCCAF65274C93C1F4155955501', '性別與教育程度人口統計_宜蘭縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65B23873BCCAF65274C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form29">
				    			<td>新竹縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form29');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65EC8B3D43E19BC0ACC93C1F4155955501', '性別與教育程度人口統計_新竹縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65EC8B3D43E19BC0ACC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form30">
				    			<td>苗栗縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form30');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B658F58070F44009671C93C1F4155955501', '性別與教育程度人口統計_苗栗縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B658F58070F44009671C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form31">
				    			<td>彰化縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form31');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65417218D4C8282395C93C1F4155955501', '性別與教育程度人口統計_彰化縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65417218D4C8282395C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form32">
				    			<td>南投縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form32');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65E4291A3C37F0F2CAC93C1F4155955501', '性別與教育程度人口統計_南投縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65E4291A3C37F0F2CAC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form33">
				    			<td>雲林縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form33');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65B4E07A27A9DCBC06C93C1F4155955501', '性別與教育程度人口統計_雲林縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65B4E07A27A9DCBC06C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form34">
				    			<td>嘉義縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form34');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B652B8FA2C70207CBC9C93C1F4155955501', '性別與教育程度人口統計_嘉義縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B652B8FA2C70207CBC9C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form35">
				    			<td>屏東縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form35');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B657D04EB2CAA3BDF8EC93C1F4155955501', '性別與教育程度人口統計_屏東縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B657D04EB2CAA3BDF8EC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form36">
				    			<td>臺東縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form36');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65970DA659475E3BACC93C1F4155955501', '性別與教育程度人口統計_臺東縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65970DA659475E3BACC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form37">
				    			<td>花蓮縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form37');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B655A06EBF1E2126985C93C1F4155955501', '性別與教育程度人口統計_花蓮縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B655A06EBF1E2126985C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form38">
				    			<td>澎湖縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form38');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B652DAC6E70D47487BEC93C1F4155955501', '性別與教育程度人口統計_澎湖縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B652DAC6E70D47487BEC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form39">
				    			<td>基隆市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form39');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65658B6629E77FF018C93C1F4155955501', '性別與教育程度人口統計_基隆市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65658B6629E77FF018C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form40">
				    			<td>新竹市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form40');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65118135321DF5C2FCC93C1F4155955501', '性別與教育程度人口統計_新竹市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B65118135321DF5C2FCC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form41">
				    			<td>嘉義市</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form41');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B6587B08BA6EC353C5CC93C1F4155955501', '性別與教育程度人口統計_嘉義市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BAA1CDA15D71E92B6587B08BA6EC353C5CC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form42">
				    			<td>金門縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form42');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA0E8A254FE121C41F87B08BA6EC353C5CC93C1F4155955501', '性別與教育程度人口統計_金門縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA0E8A254FE121C41F87B08BA6EC353C5CC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_age_edu" id="form43">
				    			<td>連江縣</td>
				    			<td>統計區15歲以上人口五歲年齡組與性別與教育程度人口統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form43');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA0E8A254FE121C41F417218D4C8282395C93C1F4155955501', '性別與教育程度人口統計_連江縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DB24A8D456DDA4E3BA0E8A254FE121C41F417218D4C8282395C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_age_edu" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form44">
				    			<td>新北市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form44');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F409EB1DC5F1F8A2D2B0956DEC9A8D69E14C93C1F4155955501', '性別與婚姻狀況統計_新北市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F409EB1DC5F1F8A2D2B0956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form45">
				    			<td>臺北市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form45');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F404505D4DF893B8CAB0956DEC9A8D69E14C93C1F4155955501', '性別與婚姻狀況統計_臺北市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F404505D4DF893B8CAB0956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form46">
				    			<td>桃園市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form46');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8A63574C79B563547C93C1F4155955501', '性別與婚姻狀況統計_桃園市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8A63574C79B563547C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form47">
				    			<td>臺中市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form47');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F406183AA7E3F83C5C50956DEC9A8D69E14C93C1F4155955501', '性別與婚姻狀況統計_臺中市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F406183AA7E3F83C5C50956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form48">
				    			<td>臺南市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form48');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F401C1584EE437DFED60956DEC9A8D69E14C93C1F4155955501', '性別與婚姻狀況統計_臺南市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F401C1584EE437DFED60956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form49">
				    			<td>高雄市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form49');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40E2FC4DF7621F05000956DEC9A8D69E14C93C1F4155955501', '性別與婚姻狀況統計_高雄市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40E2FC4DF7621F05000956DEC9A8D69E14C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form50">
				    			<td>宜蘭縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form50');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8B23873BCCAF65274C93C1F4155955501', '性別與婚姻狀況統計_宜蘭縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8B23873BCCAF65274C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form51">
				    			<td>新竹縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form51');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8EC8B3D43E19BC0ACC93C1F4155955501', '性別與婚姻狀況統計_新竹縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8EC8B3D43E19BC0ACC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form52">
				    			<td>苗栗縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form52');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA88F58070F44009671C93C1F4155955501', '性別與婚姻狀況統計_苗栗縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA88F58070F44009671C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form53">
				    			<td>彰化縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form53');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8417218D4C8282395C93C1F4155955501', '性別與婚姻狀況統計_彰化縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8417218D4C8282395C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form54">
				    			<td>南投縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form54');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8E4291A3C37F0F2CAC93C1F4155955501', '性別與婚姻狀況統計_南投縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8E4291A3C37F0F2CAC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form55">
				    			<td>雲林縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form55');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8B4E07A27A9DCBC06C93C1F4155955501', '性別與婚姻狀況統計_雲林縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8B4E07A27A9DCBC06C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form56">
				    			<td>嘉義縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form56');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA82B8FA2C70207CBC9C93C1F4155955501', '性別與婚姻狀況統計_嘉義縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA82B8FA2C70207CBC9C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form57">
				    			<td>屏東縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form57');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA87D04EB2CAA3BDF8EC93C1F4155955501', '性別與婚姻狀況統計_屏東縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA87D04EB2CAA3BDF8EC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form58">
				    			<td>臺東縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form58');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8970DA659475E3BACC93C1F4155955501', '性別與婚姻狀況統計_臺東縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8970DA659475E3BACC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form59">
				    			<td>花蓮縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form59');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA85A06EBF1E2126985C93C1F4155955501', '性別與婚姻狀況統計_花蓮縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA85A06EBF1E2126985C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form60">
				    			<td>澎湖縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form60');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA82DAC6E70D47487BEC93C1F4155955501', '性別與婚姻狀況統計_澎湖縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA82DAC6E70D47487BEC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form61">
				    			<td>基隆市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form61');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8658B6629E77FF018C93C1F4155955501', '性別與婚姻狀況統計_基隆市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8658B6629E77FF018C93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form62">
				    			<td>新竹市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form62');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8118135321DF5C2FCC93C1F4155955501', '性別與婚姻狀況統計_新竹市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA8118135321DF5C2FCC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form63">
				    			<td>嘉義市</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form63');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA887B08BA6EC353C5CC93C1F4155955501', '性別與婚姻狀況統計_嘉義市.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F40784066447C59ACA887B08BA6EC353C5CC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form64">
				    			<td>金門縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form64');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F405BFC8E6AA103483187B08BA6EC353C5CC93C1F4155955501', '性別與婚姻狀況統計_金門縣.json')">下載</a></td>
				    			<input type="hidden" name="url" value="http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F405BFC8E6AA103483187B08BA6EC353C5CC93C1F4155955501" />
				    			<input type="hidden" name="kind" value="sex_marriage" />
				    			<input type="hidden" name="type" value="json" />
				    		</tr>
				    	</form>
						<form action="population.do" method="POST">
				    		<tr name="sex_marriage" id="form65">
				    			<td>連江縣</td>
				    			<td>統計區15歲以上人口性別與婚姻狀況統計</td>
				    			<td><a href="javascript:{}" onclick="$('body').css('cursor', 'wait');update_database('form65');">更新</a></td>
				    			<td><a href="javascript:{}" onclick="downloadInJson('http://segisws.moi.gov.tw/STATWSSTData/OpenService.asmx/GetStatSTDataForOpenCode?oCode=6E03CA29B955A854D8F52522E38D8C7051A1FBEE829C41DBC09B9B1454506F405BFC8E6AA1034831417218D4C8282395C93C1F4155955501', '性別與婚姻狀況統計_連江縣.json')">下載</a></td>
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
	$( function() {	    
	   	$( "#dialog" ).dialog({
	      	autoOpen: false,
	      	height: 90,
	      	width: 130,
	      	show: {
	        	effect: "slide",
	        	duration: 1000
	      	},
	      	hide: {
	        	effect: "fade",
	        	duration: 1000
	     	}
		});
	   	
		if (!/*@cc_on!@*/0) return;
	    var e = "abbr,article,aside,audio,bb,canvas,datagrid,datalist,details,dialog,eventsource,figure,footer,header,hgroup,mark,menu,meter,nav,output,progress,section,time,video".split(','), i=e.length;
	    while (i--) {
	        document.createElement(e[i])
	    }
	});	

	function downloadInJson(url, filename){		    
	  	$.getJSON(url,function(data){
	  		var jsonData = JSON.stringify(data);
	  		var link = document.createElement('a');
		    link.download = filename;
		    link.href = 'data:text/json;charset=utf8,' + jsonData;
		    link.click();
	  	});
	}
	
	function showSexAge(){
		$("table tr[name='sex_age']").show();
		$("table tr[name='sex_age_edu']").hide();
		$("table tr[name='sex_marriage']").hide();
	}
	function showSexAgeEdu(){
		$("table tr[name='sex_age']").hide();
		$("table tr[name='sex_age_edu']").show();
		$("table tr[name='sex_marriage']").hide();
	}
	function showSexMarriage(){
		$("table tr[name='sex_age']").hide();
		$("table tr[name='sex_age_edu']").hide();
		$("table tr[name='sex_marriage']").show();
	}
	
	function updata_all(){
		var background = $('<div/>');
	    $(background).attr('id','overlayBackground')
					.animate ({'opacity':'.8'},1000)
					.css ({'width':$(document).width(),'height':$(document).height()});
	    $('body').append(background);
		$("#progress").show();
		
		$.each($("input[name='data_kind']"), function(i, item){
			if(item.checked){
				var group = item.value;
// 				alert(group);
// 				alert($("#divAdminTable tbody tr[name='"+ group + "']").length);
				var status = 0;
				var progress = new Number(100/$("#divAdminTable tbody tr[name='"+ group + "']").length);
				var ceilProgress = Math.ceil(progress*10)/10;
				for(var index=0; index<$("#divAdminTable tbody tr[name='"+ group + "']").length; index++) {
					var input_url = $("#form" + index + " input[name='url']").val();
					var input_kind = $("#form" + index + " input[name='kind']").val();
					var input_type = $("#form" + index + " input[name='type']").val();
					$.ajax({
						type : "POST",
						url : "population.do",
						data : {
							action : "update_db",
							url : input_url,
							kind : input_kind,
							type : input_type
						},
						success : function(result) {
							status += ceilProgress;
							if(status>100){
								status = 100;
							}
							$("#progress_bar").attr('style', 'width:'+ status + '%');
							$("#progress_bar").html(status.toFixed(1)+"%");
						},
					});	
				}
			}
		});
		
		$(document).ajaxStop(function () {
			$("#progress_bar").attr('style', 'width:100%');
			$("#progress_bar").html(100+"%");
	      	$('div#overlayBackground').fadeOut(1000,function() {
			    $("#progress").hide();
	 		});
	      	$('body').css('cursor', 'default')
			$("#progress_bar").attr('style', 'width:0%');
			$("#progress_bar").html(0+"%");
			$( "#dialog" ).dialog( "open" );
		});		
	}

	function update_database(form_name){	
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
		$(document).ajaxStop(function () {
			$('body').css('cursor', 'default');			
		});
	}
</script>
</body>
</html>