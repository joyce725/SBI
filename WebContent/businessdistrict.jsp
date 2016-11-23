<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="import.jsp" flush="true"/>
<script src="js/d3.v3.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/additional-methods.min.js"></script>
<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>
<!--  css for d3js -->
<style>
	.header {
		top: 0px;
	}
	.page-wrapper {
	/*     background: #194A6B; */
	    background-color: #EEF3F9;
	}
	.content-wrap{
	/* 	height: calc(100vh - 84px); */
	/* 	width: calc(100% - 136px); */
	/* 	margin: 56px 0 28px 136px; */
		
	    background: #fff;
	    float: left;
	    margin-left: 0px;
	    margin-top: 100px;
/* 	    padding-bottom: 100px; */
/* 	    height: 900px; */
	    overflow-y: scroll;
	    width: 100%;
		background-color: #EEF3F9;
	}
	.search-result-wrap{
		padding: 5px 20px 0px 20px;
		margin-bottom: 0px;
		height: 590px;
	}
	ul, li {
		margin: 0;
		padding: 0;
		list-style: none;
	}
	.abgne_tab {
		position:relative;
		top: -43px;
		left:5px;
		clear: left;
		width: 99.3%;
		margin: 10px 0;

	}
	ul.tabs {
		width: 100%;
		height: 68px;
 	/*	border-bottom: 1px solid #999; */
 	/*	border-left: 1px solid #999; */
	}
	ul.tabs li {
 	/* 	border-radius: 15px 15px 0 0; */
		float: left;
		height: 67px;
		line-height: 24px;
		overflow: hidden;
		position: relative;
		margin-bottom: -1px;	/* 讓 li 往下移來遮住 ul 的部份 border-bottom */
 	/*	border: 1px solid #999; */
		border:0px solid #fff;
		border-left: none;
 	/*	background: #e1e1e1; */
		background:#85b9fF;
	}
	ul.tabs li a {
		text-align:center;
		height:68px;
		display: block;
		padding: 10px 20px;
		color: #000;
		border: 1px solid #fff;
		text-decoration: none;
	}
	ul.tabs li.active a {
		color: #fff;
	}
	ul.tabs li a:hover {
		background: #5599FF;
	}
	ul.tabs li.active  {
		
		background: #194A6B;
 	/*	#fff; */
 	/*	border-bottom: 1px solid #fff; */
	}
	ul.tabs li.active a:hover {
 	/*	background: #cEd3d9; */
		background: #192A4B;
	}
	div.tab_container {
		clear: left;
		width: 885px;
		height:250px;
 		border: 3px solid #192A4B; 
 		border:0px solid #fff; 
		border-top: none;
		background: #EEF3F9;
	}
	div.tab_container .tab_content {
 		padding: 20px; 
	}
	select{
		width:180px;
		background:#eee url('./images/dropdown.svg') no-repeat 99% 2px;
	}
	.ben-table{
  	/*	border:1px solid #000;  */
 	/*	height:180px; */
 	/*	margin: 10px 120px; */
 	/*	width:70%; */
		width: 100%;
		height: 20px;
	}
	.ben-table td:nth-child(2n+1){
 	/*	padding:30px 30px; */
		vertical-align:text-top;
		width: 30%;
	}
	.ben-table td{
		padding:10px;
		height: 100%;
	}
	#map{
		height: 600px;
		width: 1000px;
 	}
    #map > div {
    /* 	height: 90% !important; */
 	/*	width:80% !important; */
    }
</style>
	
<style>

h2.ui-list-title {
	border-bottom: 1px solid #ccc;
	color: #307CB0;
}
</style>	
<!-- /**************************************  以下管理者JS區塊    *********************************************/		-->
<script>
var POI =[{//ATM
	'POI_0':{'name':'永豐銀行ATM','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'100台灣台北市中正區中山南路8號B1樓','loca':'(25.0443837, 121.51872579999997)',center: {lat: 25.0443837, lng:121.51872579999997}},'POI_1':{'name':'永豐銀行-西門簡易型分行','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/bank_dollar-71.png','addr':'108台灣台北市萬華區台北市萬華區成都路75、77號1樓、67號2樓之5、2樓之6','loca':'(25.042974, 121.50552600000003)',center: {lat: 25.042974, lng:121.50552600000003}},'POI_2':{'name':'永豐銀行ATM','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'103台灣台北市大同區西寧北路35號','loca':'(25.0535051, 121.50884389999999)',center: {lat: 25.0535051, lng:121.50884389999999}},'POI_3':{'name':'台新銀行ATM','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'100台灣台北市中正區信陽街15號','loca':'(25.0447631, 121.51621890000001)',center: {lat: 25.0447631, lng:121.51621890000001}},'POI_4':{'name':'台新銀行ATM','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'100台灣台北市中正區懷寧街7-1號','loca':'(25.046255, 121.51429299999995)',center: {lat: 25.046255, lng:121.51429299999995}},'POI_5':{'name':'華南銀行ATM','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'103台灣台北市大同區南京西路228號','loca':'(25.0534329, 121.51620400000002)',center: {lat: 25.0534329, lng:121.51620400000002}},'POI_6':{'name':'華南銀行ATM','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'104台灣台北市中山區長安東路一段18號','loca':'(25.0492259, 121.52360899999996)',center: {lat: 25.0492259, lng:121.52360899999996}},'POI_7':{'name':'華南銀行ATM','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'100台灣台北市中正區博愛路93號','loca':'(25.0431939, 121.51164599999993)',center: {lat: 25.0431939, lng:121.51164599999993}},'POI_8':{'name':'華南銀行ATM','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'100台灣台北市中正區紹興南街6號','loca':'(25.04171699999999, 121.52420289999998)',center: {lat: 25.04171699999999, lng:121.52420289999998}},'POI_9':{'name':'台灣銀行ATM(設置點群賢分行)','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'100台灣台北市中正區中山南路1號','loca':'(25.0434362, 121.52000650000002)',center: {lat: 25.0434362, lng:121.52000650000002}},'POI_10':{'name':'台灣銀行ATM','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'台灣台北市中正區武昌街一段49號','loca':'(25.044282, 121.51089990000003)',center: {lat: 25.044282, lng:121.51089990000003}},'POI_11':{'name':'台灣銀行ATM(設置點城中分行)','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'100台灣台北市中正區青島東路47號','loca':'(25.043089, 121.52570300000002)',center: {lat: 25.043089, lng:121.52570300000002}},'POI_12':{'name':'台灣銀行ATM','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'108台灣台北市萬華區貴陽街二段26號','loca':'(25.039378, 121.50572599999998)',center: {lat: 25.039378, lng:121.50572599999998}},'POI_13':{'name':'兆豐銀行ATM(設置點衡陽分行)','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'100台灣台北市中正區衡陽路91號','loca':'(25.0424455, 121.51028710000003)',center: {lat: 25.0424455, lng:121.51028710000003}},'POI_14':{'name':'遠東銀行 重慶分行','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'台灣台北市大同區重慶北路一段30號','loca':'(25.050805, 121.51353300000005)',center: {lat: 25.050805, lng:121.51353300000005}},'POI_15':{'name':'華南銀行','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/bank_dollar-71.png','addr':'100台灣台北市中正區重慶南路一段38號','loca':'(25.044804, 121.51309390000006)',center: {lat: 25.044804, lng:121.51309390000006}},'POI_16':{'name':'遠東商銀ATM','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'100台灣台北市中正區重慶南路一段86號3樓','loca':'(25.043099, 121.51298399999996)',center: {lat: 25.043099, lng:121.51298399999996}},'POI_17':{'name':'國泰世華ATM (館前分行)','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'100台灣台北市中正區館前路65號','loca':'(25.04442, 121.51510400000006)',center: {lat: 25.04442, lng:121.51510400000006}},'POI_18':{'name':'遠東商銀ATM(設置點-襄陽分行)','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'100台灣台北市中正區襄陽路1號','loca':'(25.043498, 121.51650700000005)',center: {lat: 25.043498, lng:121.51650700000005}},'POI_19':{'name':'國泰世華ATM (群益金鼎證券館前分公司)','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/atm-71.png','addr':'100台灣台北市中正區館前路49號5樓','loca':'(25.04496, 121.51516300000003)',center: {lat: 25.04496, lng:121.51516300000003}}
	},{//停車場
		'POI_0':{'name':'台灣聯通停車場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'108台灣台北市萬華區武昌街二段77號B2~B3','loca':'(25.0454063, 121.50562339999999)',center: {lat: 25.0454063, lng:121.50562339999999}},'POI_1':{'name':'台灣聯通停車場 阿曼TIT場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'108台灣台北市萬華區西寧南路123號','loca':'(25.0445402, 121.50673159999997)',center: {lat: 25.0445402, lng:121.50673159999997}},'POI_2':{'name':'Times 24h普客二四(中山北路停車場)','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'104台灣台北市中山區中山北路一段83巷10號','loca':'(25.050179, 121.52274999999997)',center: {lat: 25.050179, lng:121.52274999999997}},'POI_3':{'name':'台灣聯通停車場重慶場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'100台灣台北市中正區重慶南路一段57號','loca':'(25.0446322, 121.51405090000003)',center: {lat: 25.0446322, lng:121.51405090000003}},'POI_4':{'name':'台灣聯通停車場天津場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'104台灣台北市中山區中山北路一段105巷3-3號','loca':'(25.0509269, 121.52273100000002)',center: {lat: 25.0509269, lng:121.52273100000002}},'POI_5':{'name':'Times 24h普客二四(延平南路停車場)','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'100台灣台北市中正區延平南路154號','loca':'(25.038391, 121.50840900000003)',center: {lat: 25.038391, lng:121.50840900000003}},'POI_6':{'name':'應安停車場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'100台灣台北市中正區忠孝東路二段85號旁','loca':'(25.0434342, 121.5308245)',center: {lat: 25.0434342, lng:121.5308245}},'POI_7':{'name':'塔城公園地下停車場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'103台灣台北市大同區塔城街7號','loca':'(25.0508661, 121.51085519999992)',center: {lat: 25.0508661, lng:121.51085519999992}},'POI_8':{'name':'應安停車場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'100台灣台北市中正區博愛路38號B3樓','loca':'(25.0459416, 121.5109698)',center: {lat: 25.0459416, lng:121.5109698}},'POI_9':{'name':'西門町 峨眉立體停車場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'108台灣台北市萬華區峨眉街83號','loca':'(25.0443534, 121.50540909999995)',center: {lat: 25.0443534, lng:121.50540909999995}},'POI_10':{'name':'艋舺公園地下停車場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'108台灣台北市萬華區西園路一段145號B1','loca':'(25.03615, 121.49949600000002)',center: {lat: 25.03615, lng:121.49949600000002}},'POI_11':{'name':'建成國中地下停車場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'103台灣台北市大同區長安西路','loca':'(25.0503946, 121.51958230000002)',center: {lat: 25.0503946, lng:121.51958230000002}},'POI_12':{'name':'普客24','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'104台灣台北市中山區','loca':'(25.0478194, 121.53114329999994)',center: {lat: 25.0478194, lng:121.53114329999994}},'POI_13':{'name':'中山堂地下停車場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'100台灣台北市中正區延平南路98號B1樓','loca':'(25.0440852, 121.51061189999996)',center: {lat: 25.0440852, lng:121.51061189999996}},'POI_14':{'name':'普客24','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'100台灣台北市中正區','loca':'(25.03946659999999, 121.52663150000001)',center: {lat: 25.03946659999999, lng:121.52663150000001}},'POI_15':{'name':'台灣聯通 大世界場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'108台灣台北市萬華區成都路81號','loca':'(25.043089, 121.505268)',center: {lat: 25.043089, lng:121.505268}},'POI_16':{'name':'K區地下街停車場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'100台灣台北市中正區忠孝西路一段47號B2','loca':'(25.047005, 121.51774599999999)',center: {lat: 25.047005, lng:121.51774599999999}},'POI_17':{'name':'聯通醒吾場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'100台灣台北市中正區杭州南路一段15-1號','loca':'(25.0427653, 121.52673140000002)',center: {lat: 25.0427653, lng:121.52673140000002}},'POI_18':{'name':'台大醫院訪客停車場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'100台灣台北市中正區中山南路7號B1','loca':'(25.0407564, 121.51861580000002)',center: {lat: 25.0407564, lng:121.51861580000002}},'POI_19':{'name':'林森公園地下停車場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'104台灣台北市中山區南京東路一段35號','loca':'(25.0524859, 121.52646589999995)',center: {lat: 25.0524859, lng:121.52646589999995}}
	},{//加油站
		'POI_0':{'name':'台灣中油(直營)-林森北路站','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'100台灣台北市中正區林森北路11號','loca':'(25.0460596, 121.52398119999998)',center: {lat: 25.0460596, lng:121.52398119999998}},'POI_1':{'name':'台灣中油','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'104台灣台北市中山區吉林路31號','loca':'(25.050893, 121.53019999999992)',center: {lat: 25.050893, lng:121.53019999999992}},'POI_2':{'name':'台灣中油(直營)桂林路站','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'108台灣台北市萬華區桂林路53號','loca':'(25.038283, 121.50331789999996)',center: {lat: 25.038283, lng:121.50331789999996}},'POI_3':{'name':'台灣中油','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'104台灣台北市中山區長安東路二段34號','loca':'(25.0483369, 121.53119400000003)',center: {lat: 25.0483369, lng:121.53119400000003}},'POI_4':{'name':'台灣中油','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'106台灣台北市大安區仁愛路三段1號','loca':'(25.0384906, 121.53310590000001)',center: {lat: 25.0384906, lng:121.53310590000001}},'POI_5':{'name':'台灣中油 新生北路站','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'104台灣台北市中山區新生北路二段71號','loca':'(25.0565519, 121.52805000000001)',center: {lat: 25.0565519, lng:121.52805000000001}},'POI_6':{'name':'台灣中油(直營)-莒光路站','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'100台灣台北市中正區莒光路2號','loca':'(25.0315389, 121.50693869999998)',center: {lat: 25.0315389, lng:121.50693869999998}},'POI_7':{'name':'台灣中油(直營)-金山南路站','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'106台灣台北市大安區金山南路二段77號','loca':'(25.031564, 121.5269419)',center: {lat: 25.031564, lng:121.5269419}},'POI_8':{'name':'勝利加油站','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'106台灣台北市大安區建國南路二段75-1號','loca':'(25.0310535, 121.53776770000002)',center: {lat: 25.0310535, lng:121.53776770000002}},'POI_9':{'name':'台灣中油','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'106台灣台北市大安區建國南路一段57-1號','loca':'(25.0443825, 121.5368178)',center: {lat: 25.0443825, lng:121.5368178}},'POI_10':{'name':'陽光加油站','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'106台灣台北市大安區建國南路一段57-1號','loca':'(25.0444648, 121.53678820000005)',center: {lat: 25.0444648, lng:121.53678820000005}},'POI_11':{'name':'台灣中油(直營)民權西路站','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'103台灣台北市大同區民權西路194號','loca':'(25.0627713, 121.51441369999998)',center: {lat: 25.0627713, lng:121.51441369999998}},'POI_12':{'name':'山隆加油站萬大站','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'108台灣台北市萬華區萬大路207號','loca':'(25.0271405, 121.50073850000001)',center: {lat: 25.0271405, lng:121.50073850000001}},'POI_13':{'name':'台灣中油(直營)中崙站','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'104台灣台北市中山區八德路二段214號','loca':'(25.046359, 121.53960089999998)',center: {lat: 25.046359, lng:121.53960089999998}},'POI_14':{'name':'台灣中油(直營)環河南路站','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'108台灣台北市萬華區環河南路二段274之2號','loca':'(25.0329071, 121.49188849999996)',center: {lat: 25.0329071, lng:121.49188849999996}},'POI_15':{'name':'台灣中油(直營)龍安站','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'106台灣台北市大安區和平東路二段2號','loca':'(25.025812, 121.53530599999999)',center: {lat: 25.025812, lng:121.53530599999999}},'POI_16':{'name':'台灣中油(直營)-復興北路站','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'105台灣台北市松山區復興北路31號','loca':'(25.049515, 121.54441599999996)',center: {lat: 25.049515, lng:121.54441599999996}},'POI_17':{'name':'台灣中油(直營)-建國北路站','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'104台灣台北市中山區建國北路三段91之1號','loca':'(25.0650722, 121.53691000000003)',center: {lat: 25.0650722, lng:121.53691000000003}},'POI_18':{'name':'山隆加油站華中站','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'108台灣台北市萬華區萬大路388號','loca':'(25.0219383, 121.49861820000001)',center: {lat: 25.0219383, lng:121.49861820000001}},'POI_19':{'name':'台灣中油 菜寮站','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/gas_station-71.png','addr':'241台灣新北市三重區重新路三段157號','loca':'(25.058761, 121.48951090000003)',center: {lat: 25.058761, lng:121.48951090000003}}
	},{//速食店
		'POI_0':{'name':'儂特利','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'106台灣台北市大安區信義路三段109號','loca':'(25.0337025, 121.53906589999997)',center: {lat: 25.0337025, lng:121.53906589999997}},'POI_1':{'name':'釋道素食賓館','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'10058台灣台北市中正區八德路一段82巷9弄4號','loca':'(25.0435888, 121.53199300000006)',center: {lat: 25.0435888, lng:121.53199300000006}},'POI_2':{'name':'儂特利','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'100台灣台北市中正區仁愛路一段8號','loca':'(25.038524, 121.52197890000002)',center: {lat: 25.038524, lng:121.52197890000002}},'POI_3':{'name':'張三速食餐館','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'241台灣新北市三重區集美街149號','loca':'(25.0530799, 121.49070180000001)',center: {lat: 25.0530799, lng:121.49070180000001}},'POI_4':{'name':'梅園速食店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'號, No. 92武漢路龍潭區桃園市台灣 325','loca':'(24.8712109, 121.23461079999993)',center: {lat: 24.8712109, lng:121.23461079999993}},'POI_5':{'name':'漢堡王（八德店）','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'105台灣台北市松山區八德路二段449號','loca':'(25.0483859, 121.54735700000003)',center: {lat: 25.0483859, lng:121.54735700000003}},'POI_6':{'name':'MR.TKK Cafe','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'100台灣台北市中正區南昌路二段3號','loca':'(25.02864589999999, 121.51923699999998)',center: {lat: 25.02864589999999, lng:121.51923699999998}},'POI_7':{'name':'亨利派複合式速食店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'260台灣宜蘭縣宜蘭市東港路43號','loca':'(24.754557, 121.76277099999993)',center: {lat: 24.754557, lng:121.76277099999993}},'POI_8':{'name':'森速食店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'420台灣台中市豐原區民生街23號','loca':'(24.2486741, 120.71703860000002)',center: {lat: 24.2486741, lng:120.71703860000002}},'POI_9':{'name':'麥當勞','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'22067台灣新北市板橋區中山路二段257號','loca':'(25.0176652, 121.47749569999996)',center: {lat: 25.0176652, lng:121.47749569999996}},'POI_10':{'name':'立林速食店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'260台灣宜蘭縣宜蘭市農權路二段23號','loca':'(24.748137, 121.74458400000003)',center: {lat: 24.748137, lng:121.74458400000003}},'POI_11':{'name':'麥當勞','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'104台灣台北市中山區長春路172號','loca':'(25.0546815, 121.5337558)',center: {lat: 25.0546815, lng:121.5337558}},'POI_12':{'name':'麥當勞','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'103台灣台北市大同區承德路一段34號','loca':'(25.0507222, 121.51676629999997)',center: {lat: 25.0507222, lng:121.51676629999997}},'POI_13':{'name':'麥當勞','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'100台灣台北市寶慶路32號B1','loca':'(25.0416679, 121.50909999999999)',center: {lat: 25.0416679, lng:121.50909999999999}},'POI_14':{'name':'麥當勞','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'100台灣台北市中正區中山南路8號B1','loca':'(25.0442304, 121.51881890000004)',center: {lat: 25.0442304, lng:121.51881890000004}},'POI_15':{'name':'肯德基KFC-台北峨嵋餐廳','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'108台灣台北市萬華區峨嵋街14-16號','loca':'(25.0433696, 121.50711720000004)',center: {lat: 25.0433696, lng:121.50711720000004}},'POI_16':{'name':'喬治素食漢堡','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'243台灣新北市泰山區中山路二段666號','loca':'(25.038118, 121.42734399999995)',center: {lat: 25.038118, lng:121.42734399999995}},'POI_17':{'name':'肯德基KFC-蘆洲三民餐廳','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'247台灣新北市蘆洲區三民路116號','loca':'(25.0872036, 121.47158820000004)',center: {lat: 25.0872036, lng:121.47158820000004}},'POI_18':{'name':'維珍特','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'300台灣新竹市北區西大路388號','loca':'(24.8025676, 120.96532960000002)',center: {lat: 24.8025676, lng:120.96532960000002}},'POI_19':{'name':'肯德基KFC-台北承德餐廳','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'103台灣台北市大同區承德路一段38號','loca':'(25.050797, 121.516795)',center: {lat: 25.050797, lng:121.516795}}
	},{//全聯
		'POI_0':{'name':'全聯福利中心','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'104台灣台北市中山區吉林路26巷34號','loca':'(25.0513851, 121.52880060000007)',center: {lat: 25.0513851, lng:121.52880060000007}},'POI_1':{'name':'全聯福利中心-西門町店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'108台灣台北市萬華區長沙街二段110號','loca':'(25.0403049, 121.50402299999996)',center: {lat: 25.0403049, lng:121.50402299999996}},'POI_2':{'name':'全聯福利中心華山店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'100台灣台北市中正區忠孝東路一段86號','loca':'(25.0443904, 121.52447059999997)',center: {lat: 25.0443904, lng:121.52447059999997}},'POI_3':{'name':'全聯福利中心','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'103台灣台北市大同區南京西路165號','loca':'(25.054084, 121.51299289999997)',center: {lat: 25.054084, lng:121.51299289999997}},'POI_4':{'name':'全聯福利中心','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'103台灣台北市大同區民生西路280號','loca':'(25.0568739, 121.51301699999999)',center: {lat: 25.0568739, lng:121.51301699999999}},'POI_5':{'name':'全聯福利中心','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'108台灣台北市萬華區廣州街263號','loca':'(25.0368879, 121.49646589999998)',center: {lat: 25.0368879, lng:121.49646589999998}},'POI_6':{'name':'全聯福利中心','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'106台灣台北市大安區金山南路二段12號','loca':'(25.0334849, 121.52698899999996)',center: {lat: 25.0334849, lng:121.52698899999996}},'POI_7':{'name':'全聯福利中心','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'100台灣台北市中正區延平南路189號','loca':'(25.0337231, 121.5075157)',center: {lat: 25.0337231, lng:121.5075157}},'POI_8':{'name':'全聯福利中心','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'106台灣台北市大安區永康街7巷6號','loca':'(25.0330519, 121.530531)',center: {lat: 25.0330519, lng:121.530531}},'POI_9':{'name':'全聯福利中心','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'100台灣台北市中正區寧波東街18號','loca':'(25.0329007, 121.52036250000003)',center: {lat: 25.0329007, lng:121.52036250000003}},'POI_10':{'name':'全聯福利中心','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'106台灣台北市大安區仁愛路三段24巷12號','loca':'(25.035214, 121.53581699999995)',center: {lat: 25.035214, lng:121.53581699999995}},'POI_11':{'name':'全聯福利中心','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'104台灣台北市中山區錦西街8號','loca':'(25.060227, 121.52163989999997)',center: {lat: 25.060227, lng:121.52163989999997}},'POI_12':{'name':'全聯福利中心','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'100台灣台北市中正區南昌路一段51巷1號','loca':'(25.031641, 121.51732600000003)',center: {lat: 25.031641, lng:121.51732600000003}},'POI_13':{'name':'全聯吉林店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'104台灣台北市中山區吉林路213號','loca':'(25.0604993, 121.53038919999995)',center: {lat: 25.0604993, lng:121.53038919999995}},'POI_14':{'name':'全聯福利中心','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'241台灣新北市三重區重新路二段78號B1樓','loca':'(25.0619493, 121.49742990000004)',center: {lat: 25.0619493, lng:121.49742990000004}},'POI_15':{'name':'全聯福利中心','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'108台灣台北市萬華區西藏路125巷9號','loca':'(25.02863289999999, 121.50234390000003)',center: {lat: 25.02863289999999, lng:121.50234390000003}},'POI_16':{'name':'全聯福利中心','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'241台灣新北市三重區集美街61之1號','loca':'(25.0541724, 121.48808780000002)',center: {lat: 25.0541724, lng:121.48808780000002}},'POI_17':{'name':'全聯福利中心','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'104台灣台北市中山區林森北路561號','loca':'(25.06459599999999, 121.5258159)',center: {lat: 25.06459599999999, lng:121.5258159}},'POI_18':{'name':'全聯福利中心北市和平店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'106台灣台北市大安區和平東路一段63號','loca':'(25.0271529, 121.52460500000007)',center: {lat: 25.0271529, lng:121.52460500000007}},'POI_19':{'name':'全聯福利中心','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'104台灣台北市中山區松江路318號','loca':'(25.0606608, 121.53293669999994)',center: {lat: 25.0606608, lng:121.53293669999994}}
	},{//餐廳
		'POI_0':{'name':'貳樓餐廳 Second Floor Cafe 微風台北車站店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'100台灣台北市中正區北平西路3號2樓','loca':'(25.047749, 121.51704399999994)',center: {lat: 25.047749, lng:121.51704399999994}},'POI_1':{'name':'星期五美式餐廳(西門餐廳)','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'108台灣台北市萬華區武昌街二段72號2樓','loca':'(25.044807, 121.50621100000001)',center: {lat: 25.044807, lng:121.50621100000001}},'POI_2':{'name':'蘇杭餐廳','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'100台灣台北市中正區濟南路一段2-1號','loca':'(25.043022, 121.51964599999997)',center: {lat: 25.043022, lng:121.51964599999997}},'POI_3':{'name':'便所主題餐廳','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'108台灣台北市萬華區西寧南路50巷7號2樓','loca':'(25.044443, 121.50575300000003)',center: {lat: 25.044443, lng:121.50575300000003}},'POI_4':{'name':'新港茶餐廳 (西門店)','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'108台灣台北市萬華區漢中街52號7F','loca':'(25.04385, 121.5070895)',center: {lat: 25.04385, lng:121.5070895}},'POI_5':{'name':'Psalms Cafe詩篇咖啡餐廳','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'100台灣台北市中正區中山南路20號B1','loca':'(25.0369722, 121.51673110000002)',center: {lat: 25.0369722, lng:121.51673110000002}},'POI_6':{'name':'北海漁村-台北杭州店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'100台灣台北市中正區杭州南路一段8號','loca':'(25.0432664, 121.52650160000007)',center: {lat: 25.0432664, lng:121.52650160000007}},'POI_7':{'name':'貳樓餐廳 Second Floor Cafe 仁愛店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'100台灣台北市中正區仁愛路二段108號','loca':'(25.037913, 121.53245300000003)',center: {lat: 25.037913, lng:121.53245300000003}},'POI_8':{'name':'維記茶餐廳','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'108台灣台北市萬華區成都路27巷19號','loca':'(25.043175, 121.50690959999997)',center: {lat: 25.043175, lng:121.50690959999997}},'POI_9':{'name':'番紅花城土耳其餐廳','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'104台灣台北市中山區南京東路二段60號','loca':'(25.0518894, 121.52995280000005)',center: {lat: 25.0518894, lng:121.52995280000005}},'POI_10':{'name':'祥發港式茶餐廳 西門店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'108台灣台北市萬華區漢中街35-1號台灣','loca':'(25.0450099, 121.50775199999998)',center: {lat: 25.0450099, lng:121.50775199999998}},'POI_11':{'name':'君品酒店- 雲軒西餐廳','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'103台灣台北市大同區承德路一段3號6樓','loca':'(25.049456, 121.51686999999993)',center: {lat: 25.049456, lng:121.51686999999993}},'POI_12':{'name':'金鐘香港茶餐廳','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'100台灣台北市中正區衡陽路1號','loca':'(25.0424568, 121.51393310000003)',center: {lat: 25.0424568, lng:121.51393310000003}},'POI_13':{'name':'典藏藝術餐廳','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'104台灣台北市中山區中山北路一段135巷16號','loca':'(25.051444, 121.52358400000003)',center: {lat: 25.051444, lng:121.52358400000003}},'POI_14':{'name':'小魏川菜餐廳','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'100台灣台北市中正區公園路13號3樓','loca':'(25.0454999, 121.51741390000007)',center: {lat: 25.0454999, lng:121.51741390000007}},'POI_15':{'name':'Vegas Fresh Cafe 義達餐廳','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'104台灣台北市中山區南京東路一段19號','loca':'(25.0523992, 121.5238362)',center: {lat: 25.0523992, lng:121.5238362}},'POI_16':{'name':'(台北花園大酒店)六國餐廳','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'100台灣台北市中正區中華路二段1號','loca':'(25.0365506, 121.50690780000002)',center: {lat: 25.0365506, lng:121.50690780000002}},'POI_17':{'name':'ACHOI','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'104台灣台北市中山區中山北路二段57-1號1樓','loca':'(25.0557464, 121.52302250000002)',center: {lat: 25.0557464, lng:121.52302250000002}},'POI_18':{'name':'青葉台灣料理-中山店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'104台灣台北市中山區中山北路一段105巷10號','loca':'(25.0506023, 121.52349430000004)',center: {lat: 25.0506023, lng:121.52349430000004}},'POI_19':{'name':'台糖台北會館-甜心餐廳','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'100台灣台北市中正區中華路一段39號','loca':'(25.0454199, 121.50952099999995)',center: {lat: 25.0454199, lng:121.50952099999995}}
	},{//量販店
		'POI_0':{'name':'大潤發中崙店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'10058台灣台北市中正區八德路二段306號B2','loca':'(25.046781, 121.54260899999997)',center: {lat: 25.046781, lng:121.54260899999997}},'POI_1':{'name':'DA量販店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'100台灣台北市中正區和平西路一段30號3樓','loca':'(25.026574, 121.52055900000005)',center: {lat: 25.026574, lng:121.52055900000005}},'POI_2':{'name':'愛買三重店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'241台灣新北市三重區中正北路193巷45號','loca':'(25.071368, 121.47601299999997)',center: {lat: 25.071368, lng:121.47601299999997}},'POI_3':{'name':'愛買忠孝店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'110台灣台北市信義區忠孝東路五段297號B1.B2.B3','loca':'(25.0411478, 121.57381850000002)',center: {lat: 25.0411478, lng:121.57381850000002}},'POI_4':{'name':'大潤發內湖一店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'114台灣台北市內湖區舊宗路一段128號','loca':'(25.06072, 121.57811600000002)',center: {lat: 25.06072, lng:121.57811600000002}},'POI_5':{'name':'虹文圖書文具量販店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'台灣台北市松山區興安街174巷1號','loca':'(25.055859, 121.54487100000006)',center: {lat: 25.055859, lng:121.54487100000006}},'POI_6':{'name':'順發3C量販-台北店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'100台灣台北市中正區八德路一段23號B1樓','loca':'(25.0440397, 121.53106760000003)',center: {lat: 25.0440397, lng:121.53106760000003}},'POI_7':{'name':'愛買景美店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'116台灣台北市文山區景中街30巷12號','loca':'(24.992179, 121.54244599999993)',center: {lat: 24.992179, lng:121.54244599999993}},'POI_8':{'name':'愛買永和店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'234台灣新北市永和區民生路46巷56號','loca':'(24.9964759, 121.52101210000001)',center: {lat: 24.9964759, lng:121.52101210000001}},'POI_9':{'name':'大潤發內湖二店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'114台灣台北市內湖區舊宗路一段188號','loca':'(25.06245999999999, 121.575651)',center: {lat: 25.06245999999999, lng:121.575651}},'POI_10':{'name':'正五味食品量販店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'235台灣新北市中和區南山路148號','loca':'(24.9921615, 121.5041655)',center: {lat: 24.9921615, lng:121.5041655}},'POI_11':{'name':'大鑼鼓平價果汁量販店(南機場夜市)','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png','addr':'100台灣台北市中正區中華路二段307巷7號','loca':'(25.0290094, 121.50548490000006)',center: {lat: 25.0290094, lng:121.50548490000006}},'POI_12':{'name':'大潤發中和店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'235台灣新北市中和區中山路2段228號B1','loca':'(25.002827, 121.49885700000004)',center: {lat: 25.002827, lng:121.49885700000004}},'POI_13':{'name':'大潤發景平店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'235台灣新北市中和區景平路182號','loca':'(24.992431, 121.51635899999997)',center: {lat: 24.992431, lng:121.51635899999997}},'POI_14':{'name':'愛買南雅店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'220台灣新北市板橋區貴興路101號','loca':'(25.0016932, 121.4568888)',center: {lat: 25.0016932, lng:121.4568888}},'POI_15':{'name':'豐妮襪子量販店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'108中華民國台北市萬華區中華路一段114巷5-23號 108中華民國台北市萬華區中華路一段114巷5-23號台灣','loca':'(25.0439025, 121.50789069999996)',center: {lat: 25.0439025, lng:121.50789069999996}},'POI_16':{'name':'順發3C量販-板橋四川店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'22065台灣新北市板橋區四川路一段105號','loca':'(25.0053461, 121.4597281)',center: {lat: 25.0053461, lng:121.4597281}},'POI_17':{'name':'愛買大直店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'104台灣台北市中山區敬業三路123號','loca':'(25.081345, 121.55564099999992)',center: {lat: 25.081345, lng:121.55564099999992}},'POI_18':{'name':'台糖北大健康超市','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'237台灣新北市三峽區學成路398號','loca':'(24.9443073, 121.37824679999994)',center: {lat: 24.9443073, lng:121.37824679999994}},'POI_19':{'name':'順發3C量販-輔大店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png','addr':'24257台灣新北巿新莊區建國一路7號','loca':'(25.032009, 121.43383440000002)',center: {lat: 25.032009, lng:121.43383440000002}}
	},{//百貨公司
		'POI_0':{'name':'新光三越台北南西店一館','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'104台灣台北市中山區南京西路12號','loca':'(25.052264, 121.52109399999995)',center: {lat: 25.052264, lng:121.52109399999995}},'POI_1':{'name':'新光三越台北站前店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'100台灣台北市忠孝西路一段66號','loca':'(25.04624, 121.51529800000003)',center: {lat: 25.04624, lng:121.51529800000003}},'POI_2':{'name':'黛德美飾品百貨有限公司','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'103台灣台北市大同區重慶北路一段1-1號','loca':'(25.049577, 121.51362700000004)',center: {lat: 25.049577, lng:121.51362700000004}},'POI_3':{'name':'寶慶遠百','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'100台灣台北市中正區寶慶路32號','loca':'(25.04167199999999, 121.509008)',center: {lat: 25.04167199999999, lng:121.509008}},'POI_4':{'name':'太平洋SOGO 忠孝館','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'106台灣台北市大安區忠孝東路四段45號','loca':'(25.0420291, 121.54492989999994)',center: {lat: 25.0420291, lng:121.54492989999994}},'POI_5':{'name':'太平洋Sogo百貨敦化館','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'106台灣台北市大安區敦化南路一段246號','loca':'(25.0401408, 121.54832729999998)',center: {lat: 25.0401408, lng:121.54832729999998}},'POI_6':{'name':'明曜百貨公司','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'106台灣台北市大安區忠孝東路四段200號','loca':'(25.041291, 121.55202680000002)',center: {lat: 25.041291, lng:121.55202680000002}},'POI_7':{'name':'太平洋Sogo 復興館','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'106台灣台北市大安區忠孝東路三段300號','loca':'(25.0412891, 121.54318269999999)',center: {lat: 25.0412891, lng:121.54318269999999}},'POI_8':{'name':'樹德百貨(股)','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'103台灣台北市大同區重慶北路一段13號','loca':'(25.04999999999999, 121.51374099999998)',center: {lat: 25.04999999999999, lng:121.51374099999998}},'POI_9':{'name':'微風廣場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'105台灣台北市松山區復興南路一段39號','loca':'(25.0459484, 121.54411949999997)',center: {lat: 25.0459484, lng:121.54411949999997}},'POI_10':{'name':'京站時尚廣場 Q Square','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'103台灣台北市大同區承德路一段1號','loca':'(25.049311, 121.51703399999997)',center: {lat: 25.049311, lng:121.51703399999997}},'POI_11':{'name':'統一時代百貨台北店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'110台灣台北市信義區忠孝東路五段8號','loca':'(25.0408723, 121.56548220000002)',center: {lat: 25.0408723, lng:121.56548220000002}},'POI_12':{'name':'欣欣百貨','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'104台灣台北市中山區林森北路247號','loca':'(25.0541363, 121.52578779999999)',center: {lat: 25.0541363, lng:121.52578779999999}},'POI_13':{'name':'大葉高島屋百貨公司','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'111台灣台北市士林區忠誠路二段55號','loca':'(25.111857, 121.53136700000005)',center: {lat: 25.111857, lng:121.53136700000005}},'POI_14':{'name':'BELLAVITA寶麗廣塲','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'110台灣台北市信義區松仁路28號','loca':'(25.039436, 121.56804699999998)',center: {lat: 25.039436, lng:121.56804699999998}},'POI_15':{'name':'麗寶百貨廣場','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'220台灣新北市板橋區縣民大道二段3號','loca':'(25.0122683, 121.4620516)',center: {lat: 25.0122683, lng:121.4620516}},'POI_16':{'name':'Diffa太平洋SOGO百貨(天母店)','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'111台灣台北市士林區中山北路六段77號','loca':'(25.1046455, 121.52442169999995)',center: {lat: 25.1046455, lng:121.52442169999995}},'POI_17':{'name':'瀚星百貨 edoraPARK','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'116台灣台北市文山區景興路188號','loca':'(24.9924338, 121.5439341)',center: {lat: 24.9924338, lng:121.5439341}},'POI_18':{'name':'新光三越台北信義新天地A9','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'110台灣台北市信義區松壽路9號','loca':'(25.0366148, 121.56666719999998)',center: {lat: 25.0366148, lng:121.56666719999998}},'POI_19':{'name':'誠品站前店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'100台灣台北市中正區忠孝西路一段47號','loca':'(25.046392, 121.51743039999997)',center: {lat: 25.046392, lng:121.51743039999997}}
	},{//便利商店
		'POI_0':{'name':'萊爾富便利商店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'100台灣台北市中正區寶慶路35號','loca':'(25.04155100000001, 121.51034290000007)',center: {lat: 25.04155100000001, lng:121.51034290000007}},'POI_1':{'name':'全家便利商店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'100台灣台北市中正區信陽街15號','loca':'(25.044802, 121.51621990000001)',center: {lat: 25.044802, lng:121.51621990000001}},'POI_2':{'name':'全家便利商店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'100台灣台北市中正區許昌街26號','loca':'(25.0454731, 121.5164115)',center: {lat: 25.0454731, lng:121.5164115}},'POI_3':{'name':'全家便利商店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'100台灣台北市中正區懷寧街7之1號','loca':'(25.0462549, 121.51429289999999)',center: {lat: 25.0462549, lng:121.51429289999999}},'POI_4':{'name':'OK便利商店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'108台灣台北市萬華區開封街二段84號','loca':'(25.0470701, 121.50469329999999)',center: {lat: 25.0470701, lng:121.50469329999999}},'POI_5':{'name':'OK便利商店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'103台灣台北市大同區南京西路258號','loca':'(25.0536549, 121.51529290000008)',center: {lat: 25.0536549, lng:121.51529290000008}},'POI_6':{'name':'萊爾富便利商店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'100台灣台北市中正區館前路45號','loca':'(25.0451649, 121.51515399999994)',center: {lat: 25.0451649, lng:121.51515399999994}},'POI_7':{'name':'全家便利商店 FamilyMart','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'100台灣台北市中正區信陽街15號','loca':'(25.044802, 121.51621999999998)',center: {lat: 25.044802, lng:121.51621999999998}},'POI_8':{'name':'萊爾富便利商店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'103台灣台北市大同區民大道一段209號','loca':'(25.0487857, 121.51856900000007)',center: {lat: 25.0487857, lng:121.51856900000007}},'POI_9':{'name':'7-ELEVEN 鑫華福門市','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'100台灣台北市中正區懷寧街30號','loca':'(25.045291, 121.51405039999997)',center: {lat: 25.045291, lng:121.51405039999997}},'POI_10':{'name':'萊爾富便利商店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'103台灣台北市大同區迪化街一段50號','loca':'(25.055113, 121.50993590000007)',center: {lat: 25.055113, lng:121.50993590000007}},'POI_11':{'name':'全家便利商店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'100台灣台北市中正區中山南路7號','loca':'(25.0409653, 121.51903419999996)',center: {lat: 25.0409653, lng:121.51903419999996}},'POI_12':{'name':'OK便利商店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'104台灣台北市中山區中原街8號','loca':'(25.0561779, 121.52880989999994)',center: {lat: 25.0561779, lng:121.52880989999994}},'POI_13':{'name':'Ok便利店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'104台灣台北市中山區林森北路362號','loca':'(25.05740299999999, 121.52541799999995)',center: {lat: 25.05740299999999, lng:121.52541799999995}},'POI_14':{'name':'OK便利商店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'106台灣台北市大安區金華街241之1號','loca':'(25.02984, 121.53047689999994)',center: {lat: 25.02984, lng:121.53047689999994}},'POI_15':{'name':'萊爾富便利商店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'106台灣台北市大安區和平東路一段162號','loca':'(25.02608889999999, 121.52835049999999)',center: {lat: 25.02608889999999, lng:121.52835049999999}},'POI_16':{'name':'萊爾富便利商店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'104台灣台北市中山區中山北路二段40號','loca':'(25.0666114, 121.52189040000007)',center: {lat: 25.0666114, lng:121.52189040000007}},'POI_17':{'name':'全家便利商店-萬年店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'108台灣台北市萬華區西寧南路155號','loca':'(25.0435309, 121.50628400000005)',center: {lat: 25.0435309, lng:121.50628400000005}},'POI_18':{'name':'萊爾富','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'241台灣新北市三重區中央北路68號','loca':'(25.06619, 121.50027499999999)',center: {lat: 25.06619, lng:121.50027499999999}},'POI_19':{'name':'全家便利商店','icon':'https://maps.gstatic.com/mapfiles/place_api/icons/shopping-71.png','addr':'100台灣台北市中正區信義路一段1號','loca':'(25.0382225, 121.51930820000007)',center: {lat: 25.0382225, lng:121.51930820000007}}
}];
var result="";

var businessdistrict = {
	BD_1: {
		n:1,
		name: "北車商圈",
		center: {lat: 25.045982, lng: 121.514999}
	},
	BD_2: {
		n:2,
		name: "新板特區商圈",
		center: {lat: 25.013372, lng: 121.465019}
	},
	BD_3: {
		n:3,
		name: "信義商圈",
		center: {lat: 25.035910, lng: 121.565300}
	},
	BD_4: {
		n:4,
		name: "西門商圈",
		center: {lat: 25.044571, lng: 121.506409}
	},
	BD_5: {
		n:5,
		name: "公館商圈",
		center: {lat: 25.014906, lng: 121.533882}
	},
	BD_6: {
		n:6,
		name: "忠孝商圈",
		center: {lat: 25.041836, lng: 121.545212}
	},
	BD_7: {
		n:7,
		name: "南西商圈",
		center: {lat: 25.056343, lng: 121.524147}
	},
	BD_8: {
		n:8,
		name: "天母商圈",
		center: {lat: 25.112495, lng: 121.531334}
	},
	BD_9: {
		n:9,
		name: "士林商圈",
		center: {lat: 25.088177, lng: 121.525116}
	},
	BD_10: {
		n:10,
		name: "淡水商圈",
		center: {lat: 25.169636, lng: 121.441689}
	},
	BD_11: {
		n:11,
		name: "府中商圈",
		center: {lat: 25.008665, lng: 121.460594}
	},
	BD_12: {
		n:12,
		name: "三和夜市商圈",
		center: {lat: 25.065723, lng: 121.500481}
	},
	BD_13: {
		n:13,
		name: "頂溪商圈",
		center: {lat: 25.012350, lng: 121.517319}
	},
	BD_14: {
		n:14,
		name: "大園竹圍漁港魅力商圈",
		center: {lat: 25.015139, lng: 121.298866}
	},
	BD_15: {
		n:15,
		name: "中壢火車站前商圈",
		center: {lat: 24.954807, lng: 121.223114}
	},
	BD_16: {
		n:16,
		name: "龍元宮商圈",
		center: {lat: 24.865213, lng: 121.213867}
	},
	BD_17: {
		n:17,
		name: "復興區角板山商圈",
		center: {lat: 24.822550, lng: 121.353409}
	},
	BD_18: {
		n:18,
		name: "中壢觀光夜市",
		center: {lat: 24.960838, lng: 121.215279}
	},
	BD_19: {
		n:19,
		name: "中原夜市商圈",
		center: {lat: 24.955498, lng: 121.240547}
	},
	BD_20: {
		n:20,
		name: "桃園區火車站前商圈",
		center: {lat: 24.992674, lng: 121.312767}
	},
	BD_21: {
		n:21,
		name: "桃園觀光夜市",
		center: {lat: 25.001781, lng: 121.307854}
	},
	BD_22: {
		n:22,
		name: "中壢區六和商圈",
		center: {lat: 24.962227, lng: 121.223885}
	},
	BD_23: {
		n:23,
		name: "桃園中正藝文特區商圈",
		center: {lat: 25.017681, lng: 121.297813}
	},
	BD_24: {
		n:24,
		name: "大溪老街商圈",
		center: {lat: 24.884075, lng: 121.287758}
	},
	BD_25: {
		n:25,
		name: "逢甲商圈",
		center: {lat: 24.177917, lng: 120.645721}
	},
	BD_26: {
		n:26,
		name: "一中商圈",
		center: {lat: 24.148779, lng: 120.685211}
	},
	BD_27: {
		n:27,
		name: "精明一街",
		center: {lat: 24.156441, lng: 120.655380}
	},
	BD_28: {
		n:28,
		name: "美術園道商圈",
		center: {lat: 24.139286, lng: 120.663506}
	},
	BD_29: {
		n:29,
		name: "自由路商圈",
		center: {lat: 24.142656, lng: 120.684937}
	},
	BD_30: {
		n:30,
		name: "市政商圈",
		center: {lat: 24.161242, lng: 120.644402}
	},
	BD_31: {
		n:31,
		name: "東海商圈",
		center: {lat: 24.182249, lng: 120.591202}
	},
	BD_32: {
		n:32,
		name: "成大商圈",
		center: {lat: 22.994476, lng: 120.218056}
	},
	BD_33: {
		n:33,
		name: "海安商圈",
		center: {lat: 22.992544, lng: 120.197235}
	},
	BD_34: {
		n:34,
		name: "中正銀座商圈",
		center: {lat: 22.992867, lng: 120.197701}
	},
	BD_35: {
		n:35,
		name: "國華友愛新商圈",
		center: {lat: 22.992512, lng: 120.197197}
	},
	BD_36: {
		n:36,
		name: "孔廟形象商圈",
		center: {lat: 22.990108, lng: 120.205772}
	},
	BD_37: {
		n:37,
		name: "新化商圈",
		center: {lat: 23.035398, lng: 120.308151}
	},
	BD_38: {
		n:38,
		name: "安平商圈",
		center: {lat: 23.000124, lng: 120.163048}
	},
	BD_39: {
		n:39,
		name: "新營商圈",
		center: {lat: 23.304497, lng: 120.316727}
	},
	BD_40: {
		n:40,
		name: "關子嶺商圈",
		center: {lat: 23.337807, lng: 120.505386}
	},
	BD_41: {
		n:41,
		name: "東山商圈",
		center: {lat: 23.290840, lng: 120.500504}
	},
	BD_42: {
		n:42,
		name: "善化商圈",
		center: {lat: 23.128122, lng: 120.297371}
	},
	BD_43: {
		n:43,
		name: "玉井商圈",
		center: {lat: 23.124012, lng: 120.460495}
	},
	BD_44: {
		n:44,
		name: "三多商圈",
		center: {lat: 22.613955, lng: 120.304558}
	},
	BD_45: {
		n:45,
		name: "新崛江商圈",
		center: {lat: 22.622780, lng: 120.302757}
	},
	BD_46: {
		n:46,
		name: "後驛商圈",
		center: {lat: 22.640680, lng: 120.299347}
	},
	BD_47: {
		n:47,
		name: "巨蛋商圈",
		center: {lat: 22.666962, lng: 120.304108}
	},
	BD_48: {
		n:48,
		name: "夢時代商圈",
		center: {lat: 22.594856, lng: 120.307228}
	}
}
var map;
var g_markers = [];
//以上global變數

	function myreset() {
		$('#selectRegion').val('');
		$('#selectBusinessdistrict').val('');
		$('#selectPOI').val('');
		
		$('#selectBusinessdistrict').html('<option value="">請先選擇地區</option>');
		$('#selectPOI').html('<option value="">請先選擇地區</option>');
		
		deleteMarker();
	}
	
function AAA(){

// 	$("#pac-input").focus();
// 	$("#pac-input").val("ATM");
// 	$("#pac-input").trigght();
// 	searchBox.getPlaces();
	
	//map.panTo(new google.maps.LatLng(map.getCenter().lat()+0.01,map.getCenter().lng()+0.01));
// 	map.setCenter( new google.maps.LatLng(map.getCenter().lat(),map.getCenter().lng()+0.01), 10);
// 	google.maps.smoothZoom(map, 17, map.getZoom());
// 	map.setZoom(17);
	return;
}

	$(function(){
		$("#selectRegion").change(function(){
			console.log('selectRegion');
		
			var selecttable="<option value=''>請選擇商圈</option>";
			deleteMarker();
			
			for (var BD in businessdistrict) {
				if($(this).val()==''){ 
					selecttable = "<option value=''>請先選擇地區</option>";
					map.panTo(new google.maps.LatLng(23.900,121.000));
					map.setZoom(7);
				} else {
					map.setZoom(13);
					$("#selectPOI").html(
						"<option value=''>請選擇POI</option>"+
						"<option value='1'>ATM</option>"+
						"<option value='2'>停車場</option>"+
						"<option value='3'>加油站</option>"+
						"<option value='4'>速食店</option>"+
						"<option value='5'>全聯</option>"+
						"<option value='6'>餐廳</option>"+
						"<option value='7'>量販店</option>"+
						"<option value='8'>百貨公司</option>"+
						"<option value='9'>便利商店</option>"
					);
				}
				if($(this).val()=="Taipei"&& businessdistrict[BD].n<14){ 
					selecttable+= "<option value='"+BD+"'>"+businessdistrict[BD].name+"</option>";
					map.panTo(new google.maps.LatLng(25.044,121.524));
				}
				if($(this).val()=="Taoyuan"&& businessdistrict[BD].n>13&& businessdistrict[BD].n<25){ 
					selecttable+= "<option value='"+BD+"'>"+businessdistrict[BD].name+"</option>";
					map.panTo(new google.maps.LatLng(24.995,121.298));
				}
				if($(this).val()=="Taichung"&& businessdistrict[BD].n>24&& businessdistrict[BD].n<32){ 
					selecttable+= "<option value='"+BD+"'>"+businessdistrict[BD].name+"</option>";
					map.panTo(new google.maps.LatLng(24.148,120.685));
				}
				if($(this).val()=="Tainan"&& businessdistrict[BD].n>31&& businessdistrict[BD].n<44){ 
					selecttable+= "<option value='"+BD+"'>"+businessdistrict[BD].name+"</option>";
					map.panTo(new google.maps.LatLng(22.994,120.218));
				}
				if($(this).val()=="Kaohsiung"&& businessdistrict[BD].n>43){ 
					selecttable+= "<option value='"+BD+"'>"+businessdistrict[BD].name+"</option>";
					map.panTo(new google.maps.LatLng(22.624,120.307));
				}
			}
			$("#selectBusinessdistrict").html(selecttable);
			
		});
		
		$("#selectBusinessdistrict").change(function(){
			console.log('selectBusinessdistrict');

			deleteMarker();
			
			if($(this).val()!=''){
				
				map.panTo(businessdistrict[$(this).val()].center);
				map.setZoom(16);
				
				var marker = new google.maps.Marker({
				    position: businessdistrict[$(this).val()].center,
// 				    animation: google.maps.Animation.DROP,
				    title: businessdistrict[$(this).val()].name,
				    map: map
				});
				
				var infowindow = new google.maps.InfoWindow({content: businessdistrict[$(this).val()].name});
				
				var cityCircle = new google.maps.Circle({
			      strokeColor: '#FF0000',
			      strokeOpacity: 0.5,
			      strokeWeight: 2,
			      fillColor: '#FF8700',
			      fillOpacity: 0.2,
			      map: map,
			      center: businessdistrict[$(this).val()].center,
			      radius: 800
			    });
				
			  	google.maps.event.addListener(marker, "mouseover", function(event) { 
// 		        	marker.setAnimation(google.maps.Animation.BOUNCE);
		        	infowindow.open(marker.get('map'), marker);
		        	setTimeout(function () { infowindow.close(); }, 2000);
		        }); 
			  	
			  	google.maps.event.addListener(marker, "dblclick", function(event) { 
		        	marker.setAnimation(null);
		        });
			  	
			  	g_markers.push(marker);
			  	g_markers.push(cityCircle);
			}
// 			alert(businessdistrict[$(this).val()].name);
		});
		
		$("#selectPOI").change(function(){
			console.log('selectPOI');

			var thisval=$(this).val();
			
			if($(this).val()!=''){
// 				for (var shop in POI[$(this).val()]) {
					var i = 0;                     //  set your counter to 1
					function myLoop () {  //  create a loop function
					   setTimeout(
						   function () {    //  call a 3s setTimeout when the loop is called
							   var shop="POI_"+i;
							   var marker = new google.maps.Marker({
								    position: POI[thisval-1][shop].center,
// 								    animation: google.maps.Animation.DROP,
								    title: POI[thisval-1][shop]['name'],
								    map: map
// 								    icon: POI[thisval-1][shop]['icon']
								});
								var infowindow = new google.maps.InfoWindow({content:( "名稱:　"+POI[thisval-1][shop]['name']+"<br/>地址:　"+POI[thisval-1][shop]['addr'])});
								google.maps.event.addListener(marker, "mouseover", function(event) { 
// 						        	marker.setAnimation(google.maps.Animation.BOUNCE);

						        	infowindow.open(marker.get('map'), marker);
						        	setTimeout(function () { infowindow.close(); }, 2000);
						        }); 
							  	google.maps.event.addListener(marker, "dblclick", function(event) { 
// 						        	marker.setAnimation(null);
						        }); 
								g_markers.push(marker);
								
								i++;                     //  increment the counter
								if (i < 20) {            //  if the counter < 10, call the loop function
									myLoop();             //  ..  again which will trigger another 
								}                        //  ..  setTimeout()
					   }, 10)
					}
					
					myLoop();                      //  start the loop
			}
		});	
		
	});
</script>
<!-- /**************************************  以上使用者JS區塊    *********************************************/	-->

<jsp:include page="header.jsp" flush="true"/>
<div class="content-wrap">
<h2 class="page-title">商圈定位</h2>
	<div class="search-result-wrap">
<!-- 	<button id='btn' onclick='console.log(result);' >TEST</button> -->
	<input id="pac-input" class="controls" type="text" placeholder="Search Box">
	<table class='ben-table'>
		<tr>
			<td style=>
			<h4>搜尋條件</h4>
				　地區：　<select id='selectRegion'>
					  	 <option value="">請選擇</option>
			             <option value="Taipei">台北</option>
			             <option value="Taoyuan">桃園</option>
			             <option value="Taichung">台中</option>
			             <option value="Tainan">台南</option>
			             <option value="Kaohsiung">高雄</option>
					 </select><br><br><br>
					 
				　商圈：　<select id='selectBusinessdistrict'>
					  	 <option value="">請先選擇地區</option>
					 </select><br><br><br>
				　POI ：　<select id='selectPOI'>
					  	 <option value="">請先選擇地區</option>
					 </select>
				  <a class='btn btn-darkblue' style='font-size:24px;font-weight:lighter; margin:10px;' onclick="myreset()">重設</a>	 
			</td>
			<td><div id="map"></div></td>			
		</tr>
	</table>
	
    <script>
	    var markers = [];
	    
	    function initMap() {
			// Create the map.
			map = new google.maps.Map(document.getElementById('map'), {
				zoom: 7,
				center: {lat: 23.900, lng: 121.000},
				mapTypeId: google.maps.MapTypeId.ROADMAP
			});
			
			
			var input = document.getElementById('pac-input');
			var searchBox = new google.maps.places.SearchBox(input);
			map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
			map.addListener('bounds_changed', function() {
		  		searchBox.setBounds(map.getBounds());
			});
			
			var markers = [];
			var i=0;
			searchBox.addListener('places_changed', function() {
				var places = searchBox.getPlaces();
				if (places.length == 0) {return;}
				
				// Clear out the old markers.
				markers.forEach(function(marker) {
				  marker.setMap(null);
				});
				markers = [];
				
				// For each place, get the icon, name and location.
				var bounds = new google.maps.LatLngBounds();
				places.forEach(function(place) {
					//result+=(place.name+"   "+place.formatted_address+"  "+place.geometry.location);
					result += "'POI_"+i+ "':{'name':'"+place.name+"','icon':'"+place.icon+"','addr':'"+place.formatted_address+"','loca':'"+place.geometry.location+"',center: {lat: "+place.geometry.location.lat()+", lng:"+place.geometry.location.lng()+"}},";
					i++;
					
					console.log('icon');
					var icon = {
					  url: place.icon,
					  size: new google.maps.Size(71, 71),
					  origin: new google.maps.Point(0, 0),
					  anchor: new google.maps.Point(17, 34),
					  scaledSize: new google.maps.Size(25, 25)
					};
					
					// Create a marker for each place.
					markers.push(new google.maps.Marker({
					  map: map,
					  icon: icon,
					  title: place.name,
					  position: place.geometry.location
					}));
					
					if (place.geometry.viewport) {
					  // Only geocodes have viewport.
					  bounds.union(place.geometry.viewport);
					} else {
					  bounds.extend(place.geometry.location);
					}
				});
				map.fitBounds(bounds);
			});
    	  
   		}
	    
	    function deleteMarker() {
	    	for (var i = 0; i < g_markers.length; i++) {   
	            g_markers[i].setMap(null);   
	        }   
	    	g_markers = [];
	    }
    </script>
<!--     <script src="http://maps.google.com/maps?file=api&v=2&key=ABQIAAAAsYV7UusYC8W-CUCDLpFQYRREFBcOGxpqCCUdK6ZnJW0Tb_Kj_BRWDfzZYc6lwJiQloNiuOKFThoUBQ" -->
<!-- type="text/javascript"></script> -->
    
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBSQDx-_LzT3hRhcQcQY3hHgX2eQzF9weQ&signed_in=true&libraries=places&callback=initMap">
     </script> 
<!-- 	------------------------------------------------------------------------------------- -->
<!-- 	------------------------------------------------------------------------------------- -->
<!-- 	------------------------------------------------------------------------------------- -->
	</div>
</div>

<jsp:include page="footer.jsp" flush="true"/>