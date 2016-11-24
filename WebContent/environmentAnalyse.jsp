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
 	    margin-bottom: 20px; 
 	    padding-bottom: 62px; 
/* 	    height: 900px; */
	    overflow-y: scroll;
	    width: 100%;
		background-color: #EEF3F9;
	}
	.search-result-wrap{
 		padding: 10px 10px 10px 10px; 
		margin-bottom: 20px;
		height: 100%;
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
		height: 100%;
/* 		width: 1000px; */
 	}
    #map > div {
/*      	height: 90% !important;  */
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
	},{//捷運站出口
		'POI_0':{'name':' ','icon':' ','addr':' ','loca':' ',center: {lat: 25.045982, lng:121.514999}},'POI_1':{'name':'頂埔站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.959306,lng:121.418218}},'POI_2':{'name':'頂埔站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.95931,lng:121.419}}, 'POI_3':{'name':'頂埔站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.95962,lng:121.4196}}, 'POI_4':{'name':'頂埔站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.96039,lng:121.4201}}, 'POI_5':{'name':'松山機場站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.063717,lng:121.552335}}, 'POI_6':{'name':'松山機場站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.063673,lng:121.551294}}, 'POI_7':{'name':'松山機場站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.062923,lng:121.552241}}, 'POI_8':{'name':'中山國中站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.060889,lng:121.544031}}, 'POI_9':{'name':'忠孝復興站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041797,lng:121.543143}}, 'POI_10':{'name':'忠孝復興站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041355,lng:121.543422}}, 'POI_11':{'name':'忠孝復興站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041467,lng:121.544806}}, 'POI_12':{'name':'忠孝復興站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041772,lng:121.54506}}, 'POI_13':{'name':'忠孝復興站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.04202,lng:121.543985}}, 'POI_14':{'name':'大安站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033508,lng:121.541949}}, 'POI_15':{'name':'大安站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033515,lng:121.541826}}, 'POI_16':{'name':'大安站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033241,lng:121.54233}}, 'POI_17':{'name':'大安站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033066,lng:121.544057}}, 'POI_18':{'name':'大安站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.032862,lng:121.543719}}, 'POI_19':{'name':'大安站出口6','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.034006,lng:121.543749}}, 'POI_20':{'name':'科技大樓站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.026154,lng:121.543636}}, 'POI_21':{'name':'六張犁站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.023852,lng:121.552737}}, 'POI_22':{'name':'麟光站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.018554,lng:121.558606}}, 'POI_23':{'name':'辛亥站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.005119,lng:121.557021}}, 'POI_24':{'name':'萬芳醫院站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.999383,lng:121.557737}}, 'POI_25':{'name':'萬芳社區站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.99858,lng:121.568409}}, 'POI_26':{'name':'木柵站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.998174,lng:121.573417}}, 'POI_27':{'name':'動物園站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.99825,lng:121.579916}}, 'POI_28':{'name':'動物園站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.997948,lng:121.579417}}, 'POI_29':{'name':'大直站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.080118,lng:121.547104}}, 'POI_30':{'name':'大直站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.079584,lng:121.546823}}, 'POI_31':{'name':'大直站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.07931,lng:121.546901}}, 'POI_32':{'name':'劍南路站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.085174,lng:121.555226}}, 'POI_33':{'name':'劍南路站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.084754,lng:121.555097}}, 'POI_34':{'name':'劍南路站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.084484,lng:121.556098}}, 'POI_35':{'name':'西湖站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.082339,lng:121.566647}}, 'POI_36':{'name':'西湖站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.082023,lng:121.567141}}, 'POI_37':{'name':'港墘站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.080152,lng:121.57556}}, 'POI_38':{'name':'港墘站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.080065,lng:121.574704}}, 'POI_39':{'name':'文德站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.078671,lng:121.58564}}, 'POI_40':{'name':'文德站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.078408,lng:121.58447}}, 'POI_41':{'name':'內湖站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.083745,lng:121.594266}}, 'POI_42':{'name':'內湖站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.083636,lng:121.594612}}, 'POI_43':{'name':'大湖公園站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.083894,lng:121.602377}}, 'POI_44':{'name':'大湖公園站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.083675,lng:121.60221}}, 'POI_45':{'name':'葫洲站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.072638,lng:121.608047}}, 'POI_46':{'name':'葫洲站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.072534,lng:121.607197}}, 'POI_47':{'name':'東湖站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.067218,lng:121.611129}}, 'POI_48':{'name':'東湖站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.067111,lng:121.611239}}, 'POI_49':{'name':'東湖站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.067053,lng:121.611724}}, 'POI_50':{'name':'南港軟體園區站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.059995,lng:121.615817}}, 'POI_51':{'name':'南港軟體園區站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.059883,lng:121.616091}}, 'POI_52':{'name':'南港展覽館站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.055847,lng:121.616936}}, 'POI_53':{'name':'南港展覽館站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.055308,lng:121.616984}}, 'POI_54':{'name':'南港展覽館站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.055123,lng:121.618239}}, 'POI_55':{'name':'南港展覽館站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.055386,lng:121.618266}}, 'POI_56':{'name':'南港展覽館站出口2A','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.05524,lng:121.617043}}, 'POI_57':{'name':'南港展覽館站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.054917,lng:121.616861}}, 'POI_58':{'name':'南港展覽館站出口6','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.054739,lng:121.618183}}, 'POI_59':{'name':'南港展覽館站出口7','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.054035,lng:121.618148}}, 'POI_60':{'name':'小碧潭站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.971684,lng:121.530311}}, 'POI_61':{'name':'小碧潭站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.973192,lng:121.52995}}, 'POI_62':{'name':'新店站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.957877,lng:121.537558}}, 'POI_63':{'name':'新店區公所站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.967393,lng:121.541124}}, 'POI_64':{'name':'新店區公所站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.967986,lng:121.541845}}, 'POI_65':{'name':'七張站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.975025,lng:121.543068}}, 'POI_66':{'name':'七張站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.97691,lng:121.542641}}, 'POI_67':{'name':'大坪林站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.982754,lng:121.540874}}, 'POI_68':{'name':'大坪林站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.982051,lng:121.541619}}, 'POI_69':{'name':'大坪林站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.982982,lng:121.541572}}, 'POI_70':{'name':'大坪林站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.983539,lng:121.541405}}, 'POI_71':{'name':'景美站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.992296,lng:121.540933}}, 'POI_72':{'name':'景美站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.993069,lng:121.541517}}, 'POI_73':{'name':'景美站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.992744,lng:121.540546}}, 'POI_74':{'name':'萬隆站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.001367,lng:121.538896}}, 'POI_75':{'name':'萬隆站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.00151,lng:121.539613}}, 'POI_76':{'name':'萬隆站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.002215,lng:121.539195}}, 'POI_77':{'name':'萬隆站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.002676,lng:121.538572}}, 'POI_78':{'name':'公館站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.014509,lng:121.534377}}, 'POI_79':{'name':'公館站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.014718,lng:121.534721}}, 'POI_80':{'name':'公館站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.015413,lng:121.534055}}, 'POI_81':{'name':'公館站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.015148,lng:121.533623}}, 'POI_82':{'name':'台電大樓站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.01962,lng:121.528577}}, 'POI_83':{'name':'台電大樓站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.020192,lng:121.529093}}, 'POI_84':{'name':'台電大樓站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.021179,lng:121.527849}}, 'POI_85':{'name':'台電大樓站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.021018,lng:121.527297}}, 'POI_86':{'name':'台電大樓站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.020758,lng:121.527739}}, 'POI_87':{'name':'古亭站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.025976,lng:121.522973}}, 'POI_88':{'name':'古亭站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.025502,lng:121.523353}}, 'POI_89':{'name':'古亭站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.026078,lng:121.523353}}, 'POI_90':{'name':'古亭站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.026424,lng:121.523069}}, 'POI_91':{'name':'古亭站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.027184,lng:121.522873}}, 'POI_92':{'name':'古亭站出口6','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.027537,lng:121.522297}}, 'POI_93':{'name':'古亭站出口7','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.02742,lng:121.521937}}, 'POI_94':{'name':'古亭站出口8','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.027056,lng:121.521894}}, 'POI_95':{'name':'古亭站出口9','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.026798,lng:121.522404}}, 'POI_96':{'name':'中正紀念堂站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033034,lng:121.517764}}, 'POI_97':{'name':'中正紀念堂站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.032406,lng:121.518261}}, 'POI_98':{'name':'中正紀念堂站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.032281,lng:121.519}}, 'POI_99':{'name':'中正紀念堂站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033525,lng:121.51796}}, 'POI_100':{'name':'中正紀念堂站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.035148,lng:121.517109}}, 'POI_101':{'name':'中正紀念堂站出口6','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.03588,lng:121.516543}}, 'POI_102':{'name':'中正紀念堂站出口7','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.034565,lng:121.515983}}, 'POI_103':{'name':'小南門站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.036434,lng:121.509752}}, 'POI_104':{'name':'小南門站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.035736,lng:121.509865}}, 'POI_105':{'name':'小南門站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.035309,lng:121.510988}}, 'POI_106':{'name':'小南門站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.035226,lng:121.511455}}, 'POI_107':{'name':'頂溪站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.012895,lng:121.515414}}, 'POI_108':{'name':'頂溪站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.014222,lng:121.515446}}, 'POI_109':{'name':'永安市場站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.002375,lng:121.510962}}, 'POI_110':{'name':'景安站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.993731,lng:121.504632}}, 'POI_111':{'name':'南勢角站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.990016,lng:121.508639}}, 'POI_112':{'name':'南勢角站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.989919,lng:121.508853}}, 'POI_113':{'name':'南勢角站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.989651,lng:121.509395}}, 'POI_114':{'name':'南勢角站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.989486,lng:121.509776}}, 'POI_115':{'name':'台大醫院站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.040913,lng:121.515731}}, 'POI_116':{'name':'台大醫院站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041224,lng:121.516589}}, 'POI_117':{'name':'台大醫院站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.042808,lng:121.516632}}, 'POI_118':{'name':'台大醫院站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.042876,lng:121.516299}}, 'POI_119':{'name':'台北車站M5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.046755,lng:121.516246}}, 'POI_120':{'name':'台北車站M6','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.046234,lng:121.516787}}, 'POI_121':{'name':'台北車站M7','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.046077,lng:121.518643}}, 'POI_122':{'name':'台北車站M8','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.045948,lng:121.517479}}, 'POI_123':{'name':'台北車站M1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.048232,lng:121.518193}}, 'POI_124':{'name':'台北車站M2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.048064,lng:121.519067}}, 'POI_125':{'name':'台北車站M3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.046337,lng:121.517882}}, 'POI_126':{'name':'台北車站M4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.046485,lng:121.517345}}, 'POI_127':{'name':'雙連站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.057499,lng:121.520588}}, 'POI_128':{'name':'雙連站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.057825,lng:121.520615}}, 'POI_129':{'name':'民權西路站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.062641,lng:121.519454}}, 'POI_130':{'name':'民權西路站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.061936,lng:121.519867}}, 'POI_131':{'name':'民權西路站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.061766,lng:121.519786}}, 'POI_132':{'name':'民權西路站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.061878,lng:121.519614}}, 'POI_133':{'name':'民權西路站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.063122,lng:121.518558}}, 'POI_134':{'name':'民權西路站出口6','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.062693,lng:121.51853}}, 'POI_135':{'name':'民權西路站出口7','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.06267,lng:121.520092}}, 'POI_136':{'name':'民權西路站出口8','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.06266,lng:121.520602}}, 'POI_137':{'name':'民權西路站出口9','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.063027,lng:121.520744}}, 'POI_138':{'name':'民權西路站出口10','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.063063,lng:121.519791}}, 'POI_139':{'name':'圓山站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.070785,lng:121.520033}}, 'POI_140':{'name':'圓山站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.071776,lng:121.520108}}, 'POI_141':{'name':'劍潭站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.08503,lng:121.525175}}, 'POI_142':{'name':'劍潭站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.083466,lng:121.524807}}, 'POI_143':{'name':'士林站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.094106,lng:121.525966}}, 'POI_144':{'name':'士林站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.092901,lng:121.526433}}, 'POI_145':{'name':'芝山站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.102046,lng:121.522636}}, 'POI_146':{'name':'芝山站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.103804,lng:121.522356}}, 'POI_147':{'name':'明德站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.109298,lng:121.519153}}, 'POI_148':{'name':'石牌站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.115007,lng:121.515171}}, 'POI_149':{'name':'石牌站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.113602,lng:121.516205}}, 'POI_150':{'name':'唭哩岸站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.120673,lng:121.506987}}, 'POI_151':{'name':'唭哩岸站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.120854,lng:121.50589}}, 'POI_152':{'name':'奇岩站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.126169,lng:121.50096}}, 'POI_153':{'name':'北投站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.132316,lng:121.49824}}, 'POI_154':{'name':'新北投站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.136968,lng:121.503524}}, 'POI_155':{'name':'復興崗站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.137325,lng:121.485159}}, 'POI_156':{'name':'復興崗站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.137665,lng:121.485373}}, 'POI_157':{'name':'忠義站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.131056,lng:121.473169}}, 'POI_158':{'name':'忠義站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.130905,lng:121.473657}}, 'POI_159':{'name':'關渡站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.125431,lng:121.467215}}, 'POI_160':{'name':'關渡站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.12547,lng:121.466861}}, 'POI_161':{'name':'竹圍站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.136971,lng:121.459726}}, 'POI_162':{'name':'竹圍站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.136854,lng:121.459383}}, 'POI_163':{'name':'紅樹林站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.154137,lng:121.459039}}, 'POI_164':{'name':'紅樹林站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.153831,lng:121.458583}}, 'POI_165':{'name':'淡水站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.168084,lng:121.445355}}, 'POI_166':{'name':'淡水站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.167577,lng:121.445988}}, 'POI_167':{'name':'永寧站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.966714,lng:121.435254}}, 'POI_168':{'name':'永寧站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.966102,lng:121.43568}}, 'POI_169':{'name':'永寧站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.966947,lng:121.436799}}, 'POI_170':{'name':'永寧站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.967191,lng:121.436412}}, 'POI_171':{'name':'土城站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.973251,lng:121.444173}}, 'POI_172':{'name':'土城站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.972663,lng:121.443671}}, 'POI_173':{'name':'土城站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.973714,lng:121.445266}}, 'POI_174':{'name':'海山站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.985375,lng:121.448615}}, 'POI_175':{'name':'海山站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.985329,lng:121.448956}}, 'POI_176':{'name':'海山站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.98609,lng:121.449127}}, 'POI_177':{'name':'亞東醫院站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.998933,lng:121.452581}}, 'POI_178':{'name':'亞東醫院站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.998252,lng:121.452388}}, 'POI_179':{'name':'亞東醫院站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:24.998875,lng:121.45287}}, 'POI_180':{'name':'府中站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.008486,lng:121.459077}}, 'POI_181':{'name':'府中站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.008943,lng:121.459501}}, 'POI_182':{'name':'府中站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.009162,lng:121.45897}}, 'POI_183':{'name':'板橋站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.013416,lng:121.461754}}, 'POI_184':{'name':'板橋站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.013192,lng:121.462483}}, 'POI_185':{'name':'板橋站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.014554,lng:121.462589}}, 'POI_186':{'name':'新埔站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.023063,lng:121.467457}}, 'POI_187':{'name':'新埔站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.0222,lng:121.468176}}, 'POI_188':{'name':'新埔站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.022844,lng:121.468574}}, 'POI_189':{'name':'新埔站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.023638,lng:121.468728}}, 'POI_190':{'name':'新埔站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.024163,lng:121.468138}}, 'POI_191':{'name':'江子翠站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.030298,lng:121.471914}}, 'POI_192':{'name':'江子翠站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.029782,lng:121.471903}}, 'POI_193':{'name':'江子翠站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.029459,lng:121.472156}}, 'POI_194':{'name':'江子翠站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.029763,lng:121.472719}}, 'POI_195':{'name':'江子翠站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.031027,lng:121.473609}}, 'POI_196':{'name':'江子翠站出口6','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.031095,lng:121.473126}}, 'POI_197':{'name':'龍山寺站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.035484,lng:121.49953}}, 'POI_198':{'name':'龍山寺站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.035109,lng:121.499798}}, 'POI_199':{'name':'龍山寺站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.035421,lng:121.501622}}, 'POI_200':{'name':'善導寺站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.045097,lng:121.523009}}, 'POI_201':{'name':'善導寺站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.044796,lng:121.523053}}, 'POI_202':{'name':'善導寺站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.044568,lng:121.523734}}, 'POI_203':{'name':'善導寺站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.044111,lng:121.524217}}, 'POI_204':{'name':'善導寺站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.044256,lng:121.52482}}, 'POI_205':{'name':'善導寺站出口6','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.044632,lng:121.524898}}, 'POI_206':{'name':'忠孝新生站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.042103,lng:121.532065}}, 'POI_207':{'name':'忠孝新生站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041783,lng:121.53368}}, 'POI_208':{'name':'忠孝新生站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.042458,lng:121.533213}}, 'POI_209':{'name':'忠孝新生站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.042784,lng:121.531829}}, 'POI_210':{'name':'忠孝新生站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041214,lng:121.532232}}, 'POI_211':{'name':'忠孝新生站出口6','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.040791,lng:121.533068}}, 'POI_212':{'name':'忠孝新生站出口7','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041729,lng:121.533068}}, 'POI_213':{'name':'忠孝敦化站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041642,lng:121.550578}}, 'POI_214':{'name':'忠孝敦化站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041632,lng:121.551694}}, 'POI_215':{'name':'忠孝敦化站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.04134,lng:121.551586}}, 'POI_216':{'name':'忠孝敦化站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.04135,lng:121.550567}}, 'POI_217':{'name':'忠孝敦化站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041238,lng:121.549824}}, 'POI_218':{'name':'忠孝敦化站出口6','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041029,lng:121.549174}}, 'POI_219':{'name':'忠孝敦化站出口7','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041661,lng:121.549913}}, 'POI_220':{'name':'忠孝敦化站出口8','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041928,lng:121.549194}}, 'POI_221':{'name':'國父紀念館站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041838,lng:121.556663}}, 'POI_222':{'name':'國父紀念館站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041029,lng:121.556704}}, 'POI_223':{'name':'國父紀念館站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041195,lng:121.557981}}, 'POI_224':{'name':'國父紀念館站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.04117,lng:121.558539}}, 'POI_225':{'name':'國父紀念館站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041501,lng:121.558002}}, 'POI_226':{'name':'市政府站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041408,lng:121.565459}}, 'POI_227':{'name':'市政府站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.040971,lng:121.565062}}, 'POI_228':{'name':'市政府站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.040903,lng:121.567149}}, 'POI_229':{'name':'市政府站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041263,lng:121.567181}}, 'POI_230':{'name':'永春站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.040995,lng:121.57512}}, 'POI_231':{'name':'永春站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.040704,lng:121.575383}}, 'POI_232':{'name':'永春站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.040704,lng:121.576155}}, 'POI_233':{'name':'永春站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.040699,lng:121.576574}}, 'POI_234':{'name':'永春站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.040961,lng:121.576622}}, 'POI_235':{'name':'後山埤站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.044422,lng:121.58141}}, 'POI_236':{'name':'後山埤站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.043703,lng:121.581854}}, 'POI_237':{'name':'後山埤站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.045232,lng:121.583277}}, 'POI_238':{'name':'後山埤站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.045653,lng:121.582441}}, 'POI_239':{'name':'昆陽站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.050319,lng:121.592726}}, 'POI_240':{'name':'昆陽站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.050402,lng:121.592825}}, 'POI_241':{'name':'昆陽站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.050599,lng:121.59363}}, 'POI_242':{'name':'昆陽站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.050572,lng:121.593799}}, 'POI_243':{'name':'南港站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051911,lng:121.606357}}, 'POI_244':{'name':'南港站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.052025,lng:121.60743}}, 'POI_245':{'name':'象山站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033025,lng:121.569394}}, 'POI_246':{'name':'象山站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.032366,lng:121.569809}}, 'POI_247':{'name':'象山站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.03302,lng:121.570408}}, 'POI_248':{'name':'台北101/世貿站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033107,lng:121.561671}}, 'POI_249':{'name':'台北101/世貿站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.032733,lng:121.561564}}, 'POI_250':{'name':'台北101/世貿站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.032742,lng:121.563646}}, 'POI_251':{'name':'台北101/世貿站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033034,lng:121.564112}}, 'POI_252':{'name':'台北101/世貿站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033102,lng:121.563292}}, 'POI_253':{'name':'信義安和站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033377,lng:121.552602}}, 'POI_254':{'name':'信義安和站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033032,lng:121.552332}}, 'POI_255':{'name':'信義安和站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033022,lng:121.553282}}, 'POI_256':{'name':'信義安和站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033022,lng:121.5534}}, 'POI_257':{'name':'信義安和站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033326,lng:121.553526}}, 'POI_258':{'name':'大安森林公園站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033693,lng:121.534442}}, 'POI_259':{'name':'大安森林公園站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033391,lng:121.534487}}, 'POI_260':{'name':'大安森林公園站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033396,lng:121.534882}}, 'POI_261':{'name':'大安森林公園站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033391,lng:121.535292}}, 'POI_262':{'name':'大安森林公園站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033369,lng:121.535989}}, 'POI_263':{'name':'大安森林公園站出口6','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033654,lng:121.535952}}, 'POI_264':{'name':'輔大站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.032932,lng:121.435264}}, 'POI_265':{'name':'輔大站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.032315,lng:121.435277}}, 'POI_266':{'name':'輔大站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.032776,lng:121.436541}}, 'POI_267':{'name':'輔大站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033175,lng:121.43652}}, 'POI_268':{'name':'新莊站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.03615,lng:121.452168}}, 'POI_269':{'name':'新莊站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.036014,lng:121.4525}}, 'POI_270':{'name':'頭前庄站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.03963,lng:121.460783}}, 'POI_271':{'name':'頭前庄站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.039068,lng:121.460931}}, 'POI_272':{'name':'頭前庄站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.039853,lng:121.462247}}, 'POI_273':{'name':'頭前庄站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.040485,lng:121.462242}}, 'POI_274':{'name':'先嗇宮站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.046497,lng:121.471319}}, 'POI_275':{'name':'先嗇宮站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.046094,lng:121.471372}}, 'POI_276':{'name':'先嗇宮站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.046239,lng:121.471801}}, 'POI_277':{'name':'三重站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.055303,lng:121.483748}}, 'POI_278':{'name':'三重站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.055429,lng:121.484451}}, 'POI_279':{'name':'三重站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.056134,lng:121.485282}}, 'POI_280':{'name':'菜寮站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.05971,lng:121.490673}}, 'POI_281':{'name':'菜寮站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.059287,lng:121.491106}}, 'POI_282':{'name':'菜寮站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.060556,lng:121.492111}}, 'POI_283':{'name':'臺北橋站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.062966,lng:121.500281}}, 'POI_284':{'name':'大橋頭站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.06318,lng:121.512319}}, 'POI_285':{'name':'大橋頭站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.063195,lng:121.513258}}, 'POI_286':{'name':'大橋頭站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.063739,lng:121.51344}}, 'POI_287':{'name':'中山國小站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.06284,lng:121.526095}}, 'POI_288':{'name':'中山國小站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.062461,lng:121.526148}}, 'POI_289':{'name':'中山國小站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.062476,lng:121.527114}}, 'POI_290':{'name':'中山國小站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.062835,lng:121.526835}}, 'POI_291':{'name':'行天宮站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.058316,lng:121.533004}}, 'POI_292':{'name':'行天宮站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.058792,lng:121.533342}}, 'POI_293':{'name':'行天宮站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.059868,lng:121.533393}}, 'POI_294':{'name':'行天宮站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.060365,lng:121.532991}}, 'POI_295':{'name':'東門站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.034157,lng:121.527994}}, 'POI_296':{'name':'東門站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.03422,lng:121.527565}}, 'POI_297':{'name':'東門站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033676,lng:121.527854}}, 'POI_298':{'name':'東門站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033646,lng:121.528879}}, 'POI_299':{'name':'東門站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033564,lng:121.529506}}, 'POI_300':{'name':'東門站出口6','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033924,lng:121.529957}}, 'POI_301':{'name':'東門站出口7','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.033962,lng:121.529678}}, 'POI_302':{'name':'東門站出口8','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.034074,lng:121.528965}}, 'POI_303':{'name':'蘆洲站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.091463,lng:121.464565}}, 'POI_304':{'name':'蘆洲站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.091609,lng:121.464597}}, 'POI_305':{'name':'蘆洲站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.091618,lng:121.464425}}, 'POI_306':{'name':'三民高中站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.085494,lng:121.472542}}, 'POI_307':{'name':'三民高中站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.085791,lng:121.473739}}, 'POI_308':{'name':'徐匯中學站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.080303,lng:121.47988}}, 'POI_309':{'name':'徐匯中學站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.080332,lng:121.480583}}, 'POI_310':{'name':'三和國中站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.076586,lng:121.486398}}, 'POI_311':{'name':'三和國中站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.076946,lng:121.486752}}, 'POI_312':{'name':'三重國小站出口','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.070536,lng:121.496656}}, 'POI_313':{'name':'迴龍站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.021864,lng:121.411264}}, 'POI_314':{'name':'迴龍站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.02118,lng:121.41077}}, 'POI_315':{'name':'迴龍站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.022637,lng:121.412482}}, 'POI_316':{'name':'丹鳳站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.029048,lng:121.422282}}, 'POI_317':{'name':'丹鳳站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.028742,lng:121.422615}}, 'POI_318':{'name':'南京復興站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.052625,lng:121.542121}}, 'POI_319':{'name':'南京復興站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051748,lng:121.541863}}, 'POI_320':{'name':'南京復興站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051719,lng:121.543237}}, 'POI_321':{'name':'南京復興站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051719,lng:121.543237}}, 'POI_322':{'name':'南京復興站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051727,lng:121.544338}}, 'POI_323':{'name':'南京復興站出口6','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.052057,lng:121.544908}}, 'POI_324':{'name':'南京復興站出口8','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.052018,lng:121.543819}}, 'POI_325':{'name':'南京復興站出口7','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.052329,lng:121.54447}}, 'POI_326':{'name':'中山站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.052414,lng:121.520303}}, 'POI_327':{'name':'中山站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.052858,lng:121.520306}}, 'POI_328':{'name':'中山站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.052382,lng:121.521063}}, 'POI_329':{'name':'中山站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.052611,lng:121.521154}}, 'POI_330':{'name':'中山站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.053037,lng:121.519329}}, 'POI_331':{'name':'中山站出口6','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.052833,lng:121.519007}}, 'POI_332':{'name':'西門站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.042137,lng:121.507566}}, 'POI_333':{'name':'西門站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041545,lng:121.508435}}, 'POI_334':{'name':'西門站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.041789,lng:121.508888}}, 'POI_335':{'name':'西門站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.042203,lng:121.509006}}, 'POI_336':{'name':'西門站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.042935,lng:121.508789}}, 'POI_337':{'name':'西門站出口6','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.042573,lng:121.507602}}, 'POI_338':{'name':'松江南京站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051842,lng:121.532388}}, 'POI_339':{'name':'松江南京站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051342,lng:121.532875}}, 'POI_340':{'name':'松江南京站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051085,lng:121.53287}}, 'POI_341':{'name':'松江南京站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051624,lng:121.53324}}, 'POI_342':{'name':'松江南京站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051882,lng:121.534081}}, 'POI_343':{'name':'松江南京站出口6','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.052095,lng:121.533727}}, 'POI_344':{'name':'松江南京站出口7','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.05247,lng:121.533195}}, 'POI_345':{'name':'松江南京站出口8','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.05257,lng:121.532826}}, 'POI_346':{'name':'北門站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.048737,lng:121.509862}}, 'POI_347':{'name':'北門站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.049583,lng:121.510506}}, 'POI_348':{'name':'北門站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.049943,lng:121.510227}}, 'POI_349':{'name':'台北小巨蛋站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051836,lng:121.55153}}, 'POI_350':{'name':'台北小巨蛋站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051571,lng:121.550715}}, 'POI_351':{'name':'台北小巨蛋站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.05152,lng:121.552549}}, 'POI_352':{'name':'台北小巨蛋站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051534,lng:121.552898}}, 'POI_353':{'name':'台北小巨蛋站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051838,lng:121.552069}}, 'POI_354':{'name':'南京三民站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051517,lng:121.563643}}, 'POI_355':{'name':'南京三民站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051215,lng:121.563073}}, 'POI_356':{'name':'南京三民站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051328,lng:121.564595}}, 'POI_357':{'name':'南京三民站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.051588,lng:121.56471}}, 'POI_358':{'name':'松山站出口1','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.050171,lng:121.577022}}, 'POI_359':{'name':'松山站出口2','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.050171,lng:121.576244}}, 'POI_360':{'name':'松山站出口3','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.049799,lng:121.577464}}, 'POI_361':{'name':'松山站出口4','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.049799,lng:121.577971}}, 'POI_362':{'name':'松山站出口5','icon':'./images/captcha.jpg','addr':' ',center: {lat:25.050557,lng:121.57813}}, 
	},{//豬排店
		'POI_0':{'name':'勝博殿(新光三越天母店)','icon':'./images/captcha.jpg','addr':'臺北市士林區天母東路68號7F',center: {lat: 25.1179204, lng: 121.5339295}},'POI_1':{'name':'勝博殿(新光三越天母店)','icon':'./images/captcha.jpg','addr':'臺北市士林區天母東路68號7F',center: {lat: 25.1179204, lng: 121.5339295}},'POI_2':{'name':'勝博殿(新光三越站前店 )','icon':'./images/captcha.jpg','addr':'臺北市中正區忠孝西路一段66號12F',center: {lat: 25.0461278, lng: 121.515325}},'POI_3':{'name':'勝博殿(新光三越信義店A9館 )','icon':'./images/captcha.jpg','addr':'臺北市信義區松壽路9號6F',center: {lat: 25.036018, lng: 121.566575}},'POI_4':{'name':'勝博殿(臺北光復店)','icon':'./images/captcha.jpg','addr':'臺北市大安區光復南路290巷2號 ',center: {lat: 25.0394015, lng: 121.5568514}},'POI_5':{'name':'勝博殿(SOGO忠孝店)','icon':'./images/captcha.jpg','addr':'臺北市大安區忠孝東路四段45號11F',center: {lat: 25.0419689, lng: 121.544902099999}},'POI_6':{'name':'勝博殿(南西店)','icon':'./images/captcha.jpg','addr':'臺北市南京西路15號7F',center: {lat: 25.0527485, lng: 121.520683599999}},'POI_7':{'name':'勝博殿(劍南店 )','icon':'./images/captcha.jpg','addr':'臺北市中山區敬業3路11號1樓',center: {lat: 25.07925, lng: 121.5569768}},'POI_8':{'name':'勝博殿(台中店 )','icon':'./images/captcha.jpg','addr':'台中市中港路二段111號',center: {lat: 24.1603815, lng: 120.6520957}},'POI_9':{'name':'勝博殿(台中崇德店)','icon':'./images/captcha.jpg','addr':'台中市北屯區崇德路二段101號1F',center: {lat: 24.171048, lng: 120.685204}},'POI_10':{'name':'勝博殿(夢時代店)','icon':'./images/captcha.jpg','addr':'高雄市前鎮區中華五路789號7F',center: {lat: 22.5950447, lng: 120.3071367}},'POI_11':{'name':'勝博殿(漢神巨蛋店 )','icon':'./images/captcha.jpg','addr':'高雄市左營區博愛二路767號4F',center: {lat: 22.6693284, lng: 120.3026041}},'POI_12':{'name':'勝博殿(大立店(高雄大立精品館) )','icon':'./images/captcha.jpg','addr':'高雄市前金區五福三路57號B2F',center: {lat: 22.6217077, lng: 120.2982807}},'POI_13':{'name':'勝博殿(新光三越桃園店)','icon':'./images/captcha.jpg','addr':'桃園市中正路19號10F',center: {lat: 24.9899876, lng: 121.312985}},'POI_14':{'name':'勝博殿(南崁店)','icon':'./images/captcha.jpg','addr':'桃園縣蘆竹鄉中正路1號1F',center: {lat: 25.0596697, lng: 121.2099129}},'POI_15':{'name':'勝博殿(宜蘭店(新月廣場))','icon':'./images/captcha.jpg','addr':'宜蘭縣宜蘭市民權路二段38巷2號4F',center: {lat: 24.7545179, lng: 121.751108599999}},'POI_16':{'name':'勝博殿(新光三越台南西門店)','icon':'./images/captcha.jpg','addr':'台南市中西區西門路一段 658號6F ',center: {lat: 22.9868277, lng: 120.1977034}},'POI_17':{'name':'勝博殿(新光三越台南中山店)','icon':'./images/captcha.jpg','addr':'台南市中西區中山路162號12F ',center: {lat: 22.9955009, lng: 120.2098201}},'POI_18':{'name':'勝博殿(台中新時代店)','icon':'./images/captcha.jpg','addr':'台中市東區復興路四段186號3F',center: {lat: 24.1363062, lng: 120.6877167}},'POI_19':{'name':'勝博殿(新竹巨城店)','icon':'./images/captcha.jpg','addr':'新竹市中央路229號7F',center: {lat: 24.8090149, lng: 120.974780199999}},'POI_20':{'name':'勝博殿(桃園T2 Express店)','icon':'./images/captcha.jpg','addr':'桃園國際機場第2航廈出境大廳4F ',center: {lat: 24.9936281, lng: 121.3009798}},'POI_21':{'name':'勝博殿(臺北淡水店 )','icon':'./images/captcha.jpg','addr':'新北市淡水區中山路8號8F',center: {lat: 25.1734469, lng: 121.440778099999}},'POI_22':{'name':'勝博殿(松山店 (松山火車站citylink 內) )','icon':'./images/captcha.jpg','addr':'臺北市信義區松山路11號2F',center: {lat: 25.0491901, lng: 121.578299399999}},'POI_23':{'name':'勝博殿(Express鼎山店 (高雄鼎山家樂福內))','icon':'./images/captcha.jpg','addr':'高雄市三民區大順二路849號1樓',center: {lat: 22.6532977, lng: 120.318947999999}},'POI_24':{'name':'勝博殿(臺北高島屋店 (大葉高島屋內))','icon':'./images/captcha.jpg','addr':'臺北市士林區忠誠路二段55號12F',center: {lat: 25.1118264, lng: 121.5315215}},'POI_25':{'name':'勝博殿(中信店 (中國信託金融園區內))','icon':'./images/captcha.jpg','addr':'臺北市南港區經貿二路166號2樓',center: {lat: 25.0586969, lng: 121.6167802}},'POI_26':{'name':'勝博殿(中和環球Express店 (中和環球購物中心內))','icon':'./images/captcha.jpg','addr':'新北市中和區中山路三段122號B2樓',center: {lat: 25.0065836, lng: 121.474825199999}},'POI_27':{'name':'勝博殿(南紡店 (南紡夢時代購物中心內))','icon':'./images/captcha.jpg','addr':'台南市東區中華東路一段366號3樓',center: {lat: 22.9907349, lng: 120.233097}},'POI_28':{'name':'勝博殿(林口環球店/環球購物中心林口店)','icon':'./images/captcha.jpg','addr':'桃園市龜山區復興一路8號 2F',center: {lat: 25.0600937, lng: 121.3694582}},'POI_29':{'name':'勝博殿(嘉義秀泰店(1月底開幕))','icon':'./images/captcha.jpg','addr':'嘉義市西區國華裡文化路299號',center: {lat: 23.4803964, lng: 120.4242401}},'POI_30':{'name':'勝博殿(大魯閣草衙道店)','icon':'./images/captcha.jpg','addr':'高雄市前鎮區中山四路100號3樓',center: {lat: 22.5823718, lng: 120.3285246}},'POI_31':{'name':'日本靜岡勝政豬排 (台北統一時代店(統一時代百貨B2))','icon':'./images/captcha.jpg','addr':'台北市忠孝東路五段8號 B2',center: {lat: 25.0408461, lng: 121.5653964}},'POI_32':{'name':'日本靜岡勝政豬排 (中壢大江店 (大江購物中心GBF))','icon':'./images/captcha.jpg','addr':'桃園縣中壢市中園路二段501號GB',center: {lat: 25.0006585, lng: 121.229209999999}},'POI_33':{'name':'日本靜岡勝政豬排 (南港citylink店)','icon':'./images/captcha.jpg','addr':'台北市忠孝東路七段369號CITY LINK南港車站C棟9樓',center: {lat: 25.0525582, lng: 121.604517999999}},'POI_34':{'name':'日本靜岡勝政豬排 (台北SOGO天母店)','icon':'./images/captcha.jpg','addr':'台北市中山北路6段77號8樓',center: {lat: 25.1047446, lng: 121.5245359}},'POI_35':{'name':'日本靜岡勝政豬排 (大直美麗華店 (美麗華百樂園B1))','icon':'./images/captcha.jpg','addr':'台北市中山區敬業三路20號B1',center: {lat: 25.083576, lng: 121.557098499999}},'POI_36':{'name':'日本靜岡勝政豬排 (板橋遠百中山店)','icon':'./images/captcha.jpg','addr':'新北市板橋區中山路一段152號13樓',center: {lat: 25.0110399, lng: 121.464423}},'POI_37':{'name':'日本靜岡勝政豬排 (林口三井店 (林口三井Outlet 2樓))','icon':'./images/captcha.jpg','addr':'新北市林口區文化三路一段356號2樓',center: {lat: 25.0707347, lng: 121.3639607}},'POI_38':{'name':'伊勢路勝勢日式豬排(台北微風松高店)','icon':'./images/captcha.jpg','addr':'台北市信義區松高路16號',center: {lat: 25.0387252, lng: 121.5672796}},'POI_39':{'name':'伊勢路勝勢日式豬排(SOGO復興館)','icon':'./images/captcha.jpg','addr':'台北市忠孝東路三段300號10樓',center: {lat: 25.041211, lng: 121.543251199999}},'POI_40':{'name':'赤神日式豬排(公館店)','icon':'./images/captcha.jpg','addr':'台北市羅斯福路3段286巷4弄14號',center: {lat: 25.0157709, lng: 121.53188}},'POI_41':{'name':'赤神日式豬排(信義ATT店 (ATT 4 FUN))','icon':'./images/captcha.jpg','addr':'台北市信義區松壽路12號5樓',center: {lat: 25.03531, lng: 121.5660665}},'POI_42':{'name':'赤神日式豬排(復興店)','icon':'./images/captcha.jpg','addr':'台北市復興北路48號',center: {lat: 25.0495873, lng: 121.5437589}},'POI_43':{'name':'斑鳩的窩(草衙店)','icon':'./images/captcha.jpg','addr':'高雄市前鎮區中山四路100號',center: {lat: 22.5823718, lng: 120.3285246}},'POI_44':{'name':'斑鳩的窩(民族店(特力家居DÉCOR HOUSE 2樓))','icon':'./images/captcha.jpg','addr':'高雄市左營區民族一路948號2樓',center: {lat: 22.6752361, lng: 120.3193695}},'POI_45':{'name':'斑鳩的窩(裕誠店)','icon':'./images/captcha.jpg','addr':'高雄市左營區裕誠路303-1號',center: {lat: 22.6652495, lng: 120.307132799999}},'POI_46':{'name':'斑鳩的窩(光華店（家樂福光華店）)','icon':'./images/captcha.jpg','addr':'高雄市前鎮區光華二路157號 ',center: {lat: 22.6109204, lng: 120.3171752}},'POI_47':{'name':'斑鳩的窩(新田店)','icon':'./images/captcha.jpg','addr':'高雄市新興區新田路155號',center: {lat: 22.6220365, lng: 120.303259799999}},'POI_48':{'name':'斑鳩的窩(青年店)','icon':'./images/captcha.jpg','addr':'高雄市鳳山區青年路二段455號',center: {lat: 22.6454434, lng: 120.3497302}},'POI_49':{'name':'斑鳩的窩(文化店 (大潤發鳳山文化店1樓))','icon':'./images/captcha.jpg','addr':'高雄市鳳山區文化路59號1樓',center: {lat: 22.633408, lng: 120.355441499999}},'POI_50':{'name':'斑鳩的窩(後昌店（寶雅百貨正對面）)','icon':'./images/captcha.jpg','addr':'高雄市楠梓區後昌路650-5號 ',center: {lat: 22.7086548, lng: 120.298211199999}},'POI_51':{'name':'斑鳩的窩(華夏店)','icon':'./images/captcha.jpg','addr':'高雄市左營區華夏路755號',center: {lat: 22.6790451, lng: 120.302867399999}},'POI_52':{'name':'斑鳩的窩(愛河店（家樂福愛河店1樓）)','icon':'./images/captcha.jpg','addr':'高雄市三民區河東路356號1樓 ',center: {lat: 22.633664, lng: 120.286082099999}},'POI_53':{'name':'斑鳩的窩(中華店 (家樂福成功店－IKEA旁))','icon':'./images/captcha.jpg','addr':'高雄市前鎮區中華五路1111號1F ',center: {lat: 22.6050663, lng: 120.304911899999}},'POI_54':{'name':'斑鳩的窩(義大店-義大世界廣場)','icon':'./images/captcha.jpg','addr':'高雄市大樹區三和村學城路一段12號4樓',center: {lat: 22.6272784, lng: 120.301435299999}},'POI_55':{'name':'福勝亭日式豬排專賣(基隆店)','icon':'./images/captcha.jpg','addr':'基隆市仁愛區愛四路45號2樓',center: {lat: 25.129519, lng: 121.743964}},'POI_56':{'name':'福勝亭日式豬排專賣(民權店)','icon':'./images/captcha.jpg','addr':'台北市中山區民權西路56-1號2樓(靠近捷運民權西路站)',center: {lat: 25.0626034, lng: 121.5202947}},'POI_57':{'name':'福勝亭日式豬排專賣(興隆店)','icon':'./images/captcha.jpg','addr':'台北市文山區興隆路3段55號2樓',center: {lat: 25.0003793, lng: 121.556177199999}},'POI_58':{'name':'福勝亭日式豬排專賣(士林店)','icon':'./images/captcha.jpg','addr':'台北市士林區文林路438號(中正路口)',center: {lat: 25.095078, lng: 121.524605399999}},'POI_59':{'name':'福勝亭日式豬排專賣(SOGO店)','icon':'./images/captcha.jpg','addr':'台北市大安區忠孝東路4段96-1號2樓(大安路口)',center: {lat: 25.0416592, lng: 121.546131}},'POI_60':{'name':'福勝亭日式豬排專賣(站前店)','icon':'./images/captcha.jpg','addr':'台北市中正區許昌街30號B1、B2(新光三越後門)',center: {lat: 25.0454166, lng: 121.5158347}},'POI_61':{'name':'福勝亭日式豬排專賣(南京店)','icon':'./images/captcha.jpg','addr':'台北市中山區南京東路二段160號B1 (華南銀行樓下)',center: {lat: 25.05173, lng: 121.534453999999}},'POI_62':{'name':'福勝亭日式豬排專賣(西門店)','icon':'./images/captcha.jpg','addr':'台北市萬華區峨嵋街49號2.3樓',center: {lat: 25.045053, lng: 121.503097}},'POI_63':{'name':'福勝亭日式豬排專賣(西寧店)','icon':'./images/captcha.jpg','addr':'台北市萬華區西寧南路167號2-4樓',center: {lat: 25.0431933, lng: 121.5062158}},'POI_64':{'name':'福勝亭日式豬排專賣(宜蘭店)','icon':'./images/captcha.jpg','addr':'宜蘭縣宜蘭市民權路二段38巷2號B2(家樂福量販店)',center: {lat: 24.7545179, lng: 121.751108599999}},'POI_65':{'name':'福勝亭日式豬排專賣(樹林店)','icon':'./images/captcha.jpg','addr':'新北市樹林區大安路118號1樓(家樂福量販店)',center: {lat: 24.9966801, lng: 121.421018499999}},'POI_66':{'name':'福勝亭日式豬排專賣(幸福店)','icon':'./images/captcha.jpg','addr':'新北市新莊區幸福路718號1樓',center: {lat: 25.0493254, lng: 121.4493486}},'POI_67':{'name':'福勝亭日式豬排專賣(長榮店)','icon':'./images/captcha.jpg','addr':'新北市蘆洲區長榮路30號1、2樓',center: {lat: 25.082554, lng: 121.463553}},'POI_68':{'name':'福勝亭日式豬排專賣(新店店)','icon':'./images/captcha.jpg','addr':'新北市新店區中正路130號1．2樓',center: {lat: 24.971456, lng: 121.541989999999}},'POI_69':{'name':'福勝亭日式豬排專賣(淡水店)','icon':'./images/captcha.jpg','addr':'新北市淡水區英專路6號2樓',center: {lat: 25.1691429, lng: 121.445359699999}},'POI_70':{'name':'福勝亭日式豬排專賣(三重二)','icon':'./images/captcha.jpg','addr':'新北市三重區自強路一段73號2樓',center: {lat: 25.066971, lng: 121.49711}},'POI_71':{'name':'福勝亭日式豬排專賣(新埔店)','icon':'./images/captcha.jpg','addr':'新北市板橋區文化路一段360號B1之13(捷運新埔站四號出口)',center: {lat: 25.0236277, lng: 121.4687999}},'POI_72':{'name':'福勝亭日式豬排專賣(環球店)','icon':'./images/captcha.jpg','addr':'新北市中和區中山路三段122號3F(環球購物中心)',center: {lat: 25.0065836, lng: 121.474825199999}},'POI_73':{'name':'福勝亭日式豬排專賣(汐止店)','icon':'./images/captcha.jpg','addr':'新北市汐止區新台五路一段95號B1',center: {lat: 25.0609322, lng: 121.6465679}},'POI_74':{'name':'福勝亭日式豬排專賣(南平店)','icon':'./images/captcha.jpg','addr':'桃園市桃園區南平路336號1、2樓',center: {lat: 25.0182551, lng: 121.2982907}},'POI_75':{'name':'福勝亭日式豬排專賣(內壢店)','icon':'./images/captcha.jpg','addr':'桃園市中壢區中華路一段450號(家樂福量販店)',center: {lat: 24.9727564, lng: 121.253447999999}},'POI_76':{'name':'福勝亭日式豬排專賣(中山店)','icon':'./images/captcha.jpg','addr':'桃園市中壢區中山東路二段510號1樓(家樂福量販店)',center: {lat: 24.9465528, lng: 121.2461428}},'POI_77':{'name':'福勝亭日式豬排專賣(桃園店)','icon':'./images/captcha.jpg','addr':'桃園市桃園區中正路117號2樓(近大廟口)',center: {lat: 24.9931322, lng: 121.311897199999}},'POI_78':{'name':'福勝亭日式豬排專賣(中壢店)','icon':'./images/captcha.jpg','addr':'桃園市中壢區中山路128號',center: {lat: 24.956049, lng: 121.225308999999}},'POI_79':{'name':'福勝亭日式豬排專賣(新竹店)','icon':'./images/captcha.jpg','addr':'新竹市東區民族路21號2.3樓',center: {lat: 24.803522, lng: 120.971694}},'POI_80':{'name':'福勝亭日式豬排專賣(竹北店)','icon':'./images/captcha.jpg','addr':'新竹縣竹北市縣政九路94號2樓(家樂福旁三商巧福2樓)',center: {lat: 24.8268973, lng: 121.0096888}},'POI_81':{'name':'銀座杏子日式豬排(信義威秀店)','icon':'./images/captcha.jpg','addr':'台北市信義區松壽路20號2Ｆ',center: {lat: 25.0356356, lng: 121.5670989}},'POI_82':{'name':'銀座杏子日式豬排(微風南京店)','icon':'./images/captcha.jpg','addr':'台北市松山區南京東路三段337號B2',center: {lat: 25.052006, lng: 121.548289}},'POI_83':{'name':'銀座杏子日式豬排(新莊幸福店)','icon':'./images/captcha.jpg','addr':'新北市新莊區幸福路748號2樓',center: {lat: 25.0491477, lng: 121.448331899999}},'POI_84':{'name':'銀座杏子日式豬排(微風信義店)','icon':'./images/captcha.jpg','addr':'台北市忠孝東路五段68號4樓',center: {lat: 25.0405044, lng: 121.5668964}},'POI_85':{'name':'銀座杏子日式豬排(台北京站店)','icon':'./images/captcha.jpg','addr':'台北市大同區承德路一段１號1號4樓',center: {lat: 25.049308, lng: 121.5171935}},'POI_86':{'name':'銀座杏子日式豬排(板橋環球店)','icon':'./images/captcha.jpg','addr':'新北市板橋區縣民大道二段7號B1',center: {lat: 25.0143985, lng: 121.4634922}},'POI_87':{'name':'銀座杏子日式豬排(微風台北車站店)','icon':'./images/captcha.jpg','addr':'台北市中正區北平西路3號2樓',center: {lat: 25.0479239, lng: 121.517080999999}},'POI_88':{'name':'銀座杏子日式豬排(台北忠孝店)','icon':'./images/captcha.jpg','addr':'台北市大安區忠孝東路四段98號3樓',center: {lat: 25.0415216, lng: 121.546365799999}},'POI_89':{'name':'銀座杏子日式豬排(新店家樂福店)','icon':'./images/captcha.jpg','addr':'新北市新店區中興路三段1號1樓',center: {lat: 24.9761049, lng: 121.5465953}},'POI_90':{'name':'銀座杏子日式豬排(桃園台茂店)','icon':'./images/captcha.jpg','addr':'桃園縣蘆竹市南崁路一段112號5樓',center: {lat: 24.9936281, lng: 121.3009798}},'POI_91':{'name':'銀座杏子日式豬排(中壢SOGO店)','icon':'./images/captcha.jpg','addr':'桃園市中壢區元化路357號8樓',center: {lat: 24.9623843, lng: 121.2234983}},'POI_92':{'name':'銀座杏子日式豬排(廣三SOGO店)','icon':'./images/captcha.jpg','addr':'台中市西區台灣大道2段459號14樓',center: {lat: 24.155469, lng: 120.661887999999}},'POI_93':{'name':'銀座杏子日式豬排(左營新光店)','icon':'./images/captcha.jpg','addr':'高雄市左營區高鐵路115號3樓',center: {lat: 22.6877345, lng: 120.3094095}},'POI_94':{'name':'銀座杏子日式豬排(台南西門新光店)','icon':'./images/captcha.jpg','addr':'台南市中西區西門路一段658號B2',center: {lat: 22.9868277, lng: 120.1977034}},'POI_95':{'name':'銀座杏子日式豬排(高雄夢時代店)','icon':'./images/captcha.jpg','addr':'高雄市前鎮區中華五路789號B1',center: {lat: 22.5950447, lng: 120.3071367}},'POI_96':{'name':'銀座杏子日式豬排(高雄三多SOGO店)','icon':'./images/captcha.jpg','addr':'高雄市前鎮區三多三路217號B2',center: {lat: 22.6142119, lng: 120.306045499999}},'POI_97':{'name':'樹太老(板橋南雅愛買店)','icon':'./images/captcha.jpg','addr':'新北市板橋區貴興路101號',center: {lat: 25.002656, lng: 121.456194999999}},'POI_98':{'name':'樹太老(桃園愛買店台)','icon':'./images/captcha.jpg','addr':'桃園縣桃園市中山路939號 (武陵高中旁)',center: {lat: 24.9848335, lng: 121.2861718}},'POI_99':{'name':'樹太老(中文心店台)','icon':'./images/captcha.jpg','addr':'台中市文心路四段813號(近昌平路口)',center: {lat: 24.1716824, lng: 120.691533299999}},'POI_100':{'name':'樹太老(中中港愛買店)','icon':'./images/captcha.jpg','addr':'台中市台灣大道(原中港路)二段71號(中港愛買1F)',center: {lat: 24.1477358, lng: 120.6736482}},'POI_101':{'name':'樹太老(台中復興愛買店)','icon':'./images/captcha.jpg','addr':'台中市南區復興路一段359號(復興愛買1F)',center: {lat: 24.1127973, lng: 120.652059799999}},'POI_102':{'name':'樹太老(台中大里店)','icon':'./images/captcha.jpg','addr':'台中市大里區德芳南路487號(近國光路口)',center: {lat: 24.1045029, lng: 120.681915}},'POI_103':{'name':'樹太老(台中青海家樂福店)','icon':'./images/captcha.jpg','addr':'台中市西屯區青海路二段207-18號B1(青海家樂福)',center: {lat: 24.1660279, lng: 120.651891299999}},'POI_104':{'name':'樹太老(高雄裕誠店)','icon':'./images/captcha.jpg','addr':'高雄市左營區裕誠路429號(台灣銀行斜對面)',center: {lat: 22.665423, lng: 120.306062}},'POI_105':{'name':'樹太老(高雄左營三越店)','icon':'./images/captcha.jpg','addr':'高雄市左營區高鐵路115號4樓 (新光三越二館-彩虹市集4F)',center: {lat: 22.6877345, lng: 120.3094095}},'POI_106':{'name':'吉豚屋(HOYII北車站店)','icon':'./images/captcha.jpg','addr':'臺北市中正區忠孝西路一段36號B1',center: {lat: 25.0459051, lng: 121.5168449}},'POI_107':{'name':'吉豚屋(家樂福重新店)','icon':'./images/captcha.jpg','addr':'新北市三重區重新路5段654號',center: {lat: 25.0432925, lng: 121.467511599999}},'POI_108':{'name':'吉豚屋(誠品信義店)','icon':'./images/captcha.jpg','addr':'臺北市信義區松高路11號 誠品信義店B2',center: {lat: 25.0397197, lng: 121.5658739}},'POI_109':{'name':'品田牧場(台北家樂福重慶店)','icon':'./images/captcha.jpg','addr':'台北市大同區重慶北路二段171號',center: {lat: 25.0591761, lng: 121.5138362}},'POI_110':{'name':'品田牧場(台北南京東店)','icon':'./images/captcha.jpg','addr':'台北市中山區南京東路二段146號2樓',center: {lat: 25.051721, lng: 121.534016999999}},'POI_111':{'name':'品田牧場(台北家樂福桂林店)','icon':'./images/captcha.jpg','addr':'台北市萬華區桂林路1號4樓',center: {lat: 25.0377674, lng: 121.5063009}},'POI_112':{'name':'品田牧場(板橋中山店)','icon':'./images/captcha.jpg','addr':'新北市板橋區中山路一段7號2樓',center: {lat: 25.008019, lng: 121.459856899999}},'POI_113':{'name':'品田牧場(三峽學成店)','icon':'./images/captcha.jpg','addr':'新北市三峽區學成路398號4樓',center: {lat: 24.9441518, lng: 121.378224}},'POI_114':{'name':'品田牧場(蘆洲家樂福店)','icon':'./images/captcha.jpg','addr':'新北市三重區五華街282號4樓',center: {lat: 25.0880018, lng: 121.486473299999}},'POI_115':{'name':'品田牧場(竹北縣政店)','icon':'./images/captcha.jpg','addr':'竹北市縣政二路476號',center: {lat: 24.8296414, lng: 121.017469099999}},'POI_116':{'name':'品田牧場(中壢家樂福中原店)','icon':'./images/captcha.jpg','addr':'桃園市中壢區中華路二段501號2樓',center: {lat: 24.9623587, lng: 121.232050899999}},'POI_117':{'name':'品田牧場(桃園家樂福經國店)','icon':'./images/captcha.jpg','addr':'桃園市桃園區經國路369號2樓',center: {lat: 25.0158516, lng: 121.3049144}},'POI_118':{'name':'品田牧場(頭份尚順店)','icon':'./images/captcha.jpg','addr':'苗栗縣頭份鎮尚順路87號',center: {lat: 24.6885164, lng: 120.901013899999}},'POI_119':{'name':'品田牧場(苗栗家樂福店)','icon':'./images/captcha.jpg','addr':'苗栗市國華路599號',center: {lat: 24.5737588, lng: 120.8176455}},'POI_120':{'name':'品田牧場(台中公益店)','icon':'./images/captcha.jpg','addr':'台中市西區公益路152-1號',center: {lat: 24.151091, lng: 120.659345}},'POI_121':{'name':'品田牧場(大里德芳南店)','icon':'./images/captcha.jpg','addr':'台中市大里區德芳南路208號',center: {lat: 24.1045836, lng: 120.682050399999}},'POI_122':{'name':'品田牧場(彰化中正店)','icon':'./images/captcha.jpg','addr':'彰化市中正路二段777號',center: {lat: 24.0656994, lng: 120.534913899999}},'POI_123':{'name':'品田牧場(嘉義國華店)','icon':'./images/captcha.jpg','addr':'嘉義市西區國華街212號',center: {lat: 23.4804446, lng: 120.448454699999}},'POI_124':{'name':'品田牧場(斗六家樂福店)','icon':'./images/captcha.jpg','addr':'斗六市雲林路二段297號',center: {lat: 23.7017443, lng: 120.5298657}},'POI_125':{'name':'品田牧場(安平家樂福店)','icon':'./images/captcha.jpg','addr':'台南市中西區中華西路二段16號2F',center: {lat: 22.988433, lng: 120.187106299999}},'POI_126':{'name':'品田牧場(台南勝利店)','icon':'./images/captcha.jpg','addr':'台南市東區勝利路118號(成大綜合商場)',center: {lat: 22.9959131, lng: 120.218392}},'POI_127':{'name':'品田牧場(宜蘭友愛店)','icon':'./images/captcha.jpg','addr':'宜蘭市舊城東路50號B1',center: {lat: 24.7577933, lng: 121.756603499999}},'POI_128':{'name':'品田牧場(台東秀泰店)','icon':'./images/captcha.jpg','addr':'台東市新生路93號2樓',center: {lat: 22.7522768, lng: 121.148497599999}},'POI_129':{'name':'品田牧場(高雄中山店)','icon':'./images/captcha.jpg','addr':'高雄市前金區中山二路507號',center: {lat: 22.6202915, lng: 120.301791999999}},'POI_130':{'name':'品田牧場(高雄家樂福楠梓店)','icon':'./images/captcha.jpg','addr':'高雄市楠梓區藍田路288號',center: {lat: 22.7275609, lng: 120.290942299999}},'POI_131':{'name':'品田牧場(屏東中正店)','icon':'./images/captcha.jpg','addr':'屏東市中正路34號',center: {lat: 22.6724877, lng: 120.489226599999}},'POI_132':{'name':'矢場味噌豬排 ()','icon':'./images/captcha.jpg','addr':'台北市中正區信義路二段171號',center: {lat: 25.034033, lng: 121.52913}},'POI_133':{'name':'知多家(中山店)','icon':'./images/captcha.jpg','addr':'台北市中山北路2段45巷31號',center: {lat: 25.0545699, lng: 121.524678199999}},'POI_134':{'name':'知多家(士林店)','icon':'./images/captcha.jpg','addr':'台北市中正路179號',center: {lat: 25.036208, lng: 121.454091}},'POI_135':{'name':'知多家(景美店)','icon':'./images/captcha.jpg','addr':'台北市景興路188號B2(瀚星百貨)',center: {lat: 24.9923, lng: 121.543815}},'POI_136':{'name':'知多家(新莊店)','icon':'./images/captcha.jpg','addr':'新北市新莊區幸福路763號2樓(佳瑪百貨)',center: {lat: 25.0490919, lng: 121.447471299999}},'POI_137':{'name':'知多家(新店店)','icon':'./images/captcha.jpg','addr':'新北市新店區建國路268號1樓(佳瑪百貨)',center: {lat: 24.9832192, lng: 121.5377541}},'POI_138':{'name':'小吉藏豬排專賣店()','icon':'./images/captcha.jpg','addr':'台南市中西區健康路一段188號',center: {lat: 22.9813652, lng: 120.206382599999}},'POI_139':{'name':'勝里日式豬排專賣店(台北館前店)','icon':'./images/captcha.jpg','addr':'台北市中正區信暘街27號',center: {lat: 25.044706, lng: 121.5157446}},'POI_140':{'name':'勝里日式豬排專賣店(台中大遠百店 (大食代勝里豬排))','icon':'./images/captcha.jpg','addr':'台中市西屯區台灣大道3段251號12樓 ',center: {lat: 24.1648631, lng: 120.6447169}},'POI_141':{'name':'​居食屋「和民」(站前店)','icon':'./images/captcha.jpg','addr':'台北市中正區館前路6號2樓',center: {lat: 25.0460494, lng: 121.5148727}},'POI_142':{'name':'​居食屋「和民」(西門店)','icon':'./images/captcha.jpg','addr':'台北市峨眉街37號 JUN PLAZA 3樓',center: {lat: 25.043566, lng: 121.507125999999}},'POI_143':{'name':'​居食屋「和民」(士林店)','icon':'./images/captcha.jpg','addr':'台北市士林區中正路115號1樓',center: {lat: 25.0957243, lng: 121.528914999999}},'POI_144':{'name':'​居食屋「和民」(中和店)','icon':'./images/captcha.jpg','addr':'新北市中和區中山路三段122號 環球購物中心 4樓',center: {lat: 25.0065836, lng: 121.474825199999}},'POI_145':{'name':'​居食屋「和民」(台茂店)','icon':'./images/captcha.jpg','addr':'桃園市蘆竹區南崁路一段112號',center: {lat: 25.0531423, lng: 121.287867699999}},'POI_146':{'name':'​居食屋「和民」(板橋店)','icon':'./images/captcha.jpg','addr':'新北市板橋區中山路一段152號遠東百貨13樓',center: {lat: 25.0110399, lng: 121.464423}},'POI_147':{'name':'​居食屋「和民」(美麗華店)','icon':'./images/captcha.jpg','addr':'台北市中山區敬業三路20號 美麗華百樂園 3樓',center: {lat: 25.083576, lng: 121.557098499999}},'POI_148':{'name':'​居食屋「和民」(遠百店)','icon':'./images/captcha.jpg','addr':'台中市西屯區臺灣大道三段251號 遠東百貨11樓',center: {lat: 24.1648631, lng: 120.6447169}},'POI_149':{'name':'​居食屋「和民」(金典店)','icon':'./images/captcha.jpg','addr':'台中市健行路1049號金典綠園道4樓',center: {lat: 24.1559729, lng: 120.66317}},'POI_150':{'name':'​居食屋「和民」(高雄五福店)','icon':'./images/captcha.jpg','addr':'高雄市五福二路262號 大統百貨五福店3樓',center: {lat: 22.6235473, lng: 120.3014068}},'POI_151':{'name':'​居食屋「和民」(漢神巨蛋店)','icon':'./images/captcha.jpg','addr':'高雄市左營區博愛二路777號漢神巨蛋購物廣場 4F',center: {lat: 22.6699973, lng: 120.302775}},'POI_152':{'name':'​居食屋「和民」(左營環球店)','icon':'./images/captcha.jpg','addr':'高雄市左營區站前北路1號環球新左營4樓',center: {lat: 22.6875442, lng: 120.306787799999}},'POI_153':{'name':'​居食屋「和民」(宜蘭店)','icon':'./images/captcha.jpg','addr':'宜蘭市民權路二段38巷6號 新月廣場4樓',center: {lat: 24.7548524, lng: 121.750711}},'POI_154':{'name':'CoCo壹番屋(台北-漢口店)','icon':'./images/captcha.jpg','addr':'台北市中正區漢口街一段19號B1',center: {lat: 25.0453009, lng: 121.5140301}},'POI_155':{'name':'CoCo壹番屋(台北-公館台大店)','icon':'./images/captcha.jpg','addr':'台北市大安區羅斯福路4段1號',center: {lat: 25.0169587, lng: 121.5338507}},'POI_156':{'name':'CoCo壹番屋(台北-南京東路店)','icon':'./images/captcha.jpg','addr':'台北市松山區南京東路三段259號2樓',center: {lat: 25.0520289, lng: 121.5449105}},'POI_157':{'name':'CoCo壹番屋(高雄-漢神巨蛋店)','icon':'./images/captcha.jpg','addr':'高雄市左營區博愛二路777號4樓(漢神巨蛋購物中心4F)',center: {lat: 22.6699973, lng: 120.302775}},'POI_158':{'name':'CoCo壹番屋(高雄-漢神本館店)','icon':'./images/captcha.jpg','addr':'高雄市前金區成功一路266之1號B3(漢神百貨本館店B3)',center: {lat: 22.6193292, lng: 120.2959226}},'POI_159':{'name':'CoCo壹番屋(宜蘭-新月廣場店)','icon':'./images/captcha.jpg','addr':'宜蘭縣宜蘭市民權路二段38巷6號4樓(宜蘭蘭城新月廣場4F)',center: {lat: 24.7548524, lng: 121.750711}},'POI_160':{'name':'CoCo壹番屋(台北-蘆洲徐匯店)','icon':'./images/captcha.jpg','addr':'新北市蘆洲區中山一路8號4樓(徐匯購物廣場4F)',center: {lat: 25.0805211, lng: 121.480265}},'POI_161':{'name':'CoCo壹番屋(新竹-巨城店)','icon':'./images/captcha.jpg','addr':'新竹市東區中央路229號4樓(SOGOBIG-CITY遠東巨城購物中心新竹店4F)',center: {lat: 24.8090149, lng: 120.974780199999}},'POI_162':{'name':'CoCo壹番屋(台北-西門漢中店)','icon':'./images/captcha.jpg','addr':'台北市萬華區漢中街49號2樓',center: {lat: 25.044151, lng: 121.507532999999}},'POI_163':{'name':'CoCo壹番屋(台北-松山商場店)','icon':'./images/captcha.jpg','addr':'台北市信義區松山路11號1樓(松山車站內1F)',center: {lat: 25.0491901, lng: 121.578299399999}},'POI_164':{'name':'CoCo壹番屋(屏東-環球店)','icon':'./images/captcha.jpg','addr':'屏東縣屏東市仁愛路90號5樓(環球購物中心5F)',center: {lat: 22.6732667, lng: 120.4934017}},'POI_165':{'name':'CoCo壹番屋(台中-中友店)','icon':'./images/captcha.jpg','addr':'台中市北區三民路三段161號C棟B3(台中中友百貨C棟B3)',center: {lat: 24.1520729, lng: 120.684754}},'POI_166':{'name':'CoCo壹番屋(台北-大直美麗華店)','icon':'./images/captcha.jpg','addr':'台北市中山區敬業三路20號B1(美麗華百樂園F館B1)',center: {lat: 25.083576, lng: 121.557098499999}},'POI_167':{'name':'CoCo壹番屋(台北-板橋環球店)','icon':'./images/captcha.jpg','addr':'新北市板橋區縣民大道二段7號B1',center: {lat: 25.0143985, lng: 121.4634922}},'POI_168':{'name':'CoCo壹番屋(高雄-高鐵Express店)','icon':'./images/captcha.jpg','addr':'高雄市左營區高鐵路105號2樓(高鐵車站內2F)',center: {lat: 22.6871352, lng: 120.3076584}},'POI_169':{'name':'CoCo壹番屋(高雄-三越左營店)','icon':'./images/captcha.jpg','addr':'高雄市左營區高鐵路123號3樓(彩虹市集3F)',center: {lat: 22.6879004, lng: 120.3091679}},'POI_170':{'name':'CoCo壹番屋(台中-三越Kitchen店)','icon':'./images/captcha.jpg','addr':'台中市西屯區台灣大道三段301號B2(新光三越台中店B2)',center: {lat: 24.1652572, lng: 120.6437083}},'POI_171':{'name':'CoCo壹番屋(台北-誠品站前Express店)','icon':'./images/captcha.jpg','addr':'台北市中正區忠孝西路一段49號B1(台北誠品站前地下街7之6櫃)',center: {lat: 25.0463087, lng: 121.517878399999}},'POI_172':{'name':'CoCo壹番屋(花蓮店)','icon':'./images/captcha.jpg','addr':'花蓮縣花蓮市中山路176號1樓',center: {lat: 23.9778657, lng: 121.608812299999}},'POI_173':{'name':'CoCo壹番屋(桃園店)','icon':'./images/captcha.jpg','addr':'桃園市桃園區復興路129號2樓',center: {lat: 24.9902429, lng: 121.312542}},'POI_174':{'name':'CoCo壹番屋(台南-中山Kitchen店)','icon':'./images/captcha.jpg','addr':'台南市中西區中山路162號B2(新光三越台南中山店B2)',center: {lat: 22.9955009, lng: 120.2098201}},'POI_175':{'name':'CoCo壹番屋(台北-高島屋Kitchen店)','icon':'./images/captcha.jpg','addr':'台北市士林區忠誠路二段55號B1(天母大葉高島屋店B1)',center: {lat: 25.1118264, lng: 121.5315215}},'POI_176':{'name':'CoCo壹番屋(台南-南紡店)','icon':'./images/captcha.jpg','addr':'台南市東區中華東路一段366號B1(南紡購物中心B1)',center: {lat: 22.9907349, lng: 120.233097}},'POI_177':{'name':'CoCo壹番屋(台南-西門新天地B2)','icon':'./images/captcha.jpg','addr':'台南市中西區西門路一段658號B2',center: {lat: 22.9868277, lng: 120.1977034}},'POI_178':{'name':'CoCo壹番屋(台北--松高微風店)','icon':'./images/captcha.jpg','addr':'台北市信義區松高路16號B2',center: {lat: 25.0387252, lng: 121.5672796}},'POI_179':{'name':'CoCo壹番屋(台北--新莊佳瑪店)','icon':'./images/captcha.jpg','addr':'新北市新莊區幸福路736號B1',center: {lat: 25.0491571, lng: 121.4486079}},'POI_180':{'name':'CoCo壹番屋(中壢店)','icon':'./images/captcha.jpg','addr':'桃園市中壢區中正路51號3樓',center: {lat: 24.9543457, lng: 121.2240039}},'POI_181':{'name':'CoCo壹番屋(新北-林口三井)','icon':'./images/captcha.jpg','addr':'新北市林口區文化三路一段356號2樓',center: {lat: 25.0707347, lng: 121.3639607}},'POI_182':{'name':'Izumi Curry(南港店)','icon':'./images/captcha.jpg','addr':'台北市南港區忠孝東路七段369號C棟10F (City Link)',center: {lat: 25.0525582, lng: 121.604517999999}},'POI_183':{'name':'Izumi Curry(京站店)','icon':'./images/captcha.jpg','addr':'台北市大同區承德路一段一號B3(京站)',center: {lat: 25.049308, lng: 121.5171935}},'POI_184':{'name':'PaPa Egg日式蛋包工房( 大安店)','icon':'./images/captcha.jpg','addr':' 台北市大安區大安路一段51巷11號',center: {lat: 25.0432472, lng: 121.5467489}},'POI_185':{'name':'PaPa Egg日式蛋包工房(    遠百店(一店) )','icon':'./images/captcha.jpg','addr':'新北市板橋區新站路28號B1大食代',center: {lat: 25.013487, lng: 121.4668732}},'POI_186':{'name':'PaPa Egg日式蛋包工房(    遠百店(二店) )','icon':'./images/captcha.jpg','addr':'新北市板橋區新站路28號B1大食代',center: {lat: 25.013487, lng: 121.4668732}},'POI_187':{'name':'PaPa Egg日式蛋包工房(    安東店)','icon':'./images/captcha.jpg','addr':' 台北市大安區安東街57-2號',center: {lat: 25.0420606, lng: 121.543047699999}},'POI_188':{'name':'PaPa Egg日式蛋包工房(    大直店)','icon':'./images/captcha.jpg','addr':' 台北市中山區樂群三路218號1樓',center: {lat: 25.0824879, lng: 121.5580935}},'POI_189':{'name':'PaPa Egg日式蛋包工房(    寶慶店)','icon':'./images/captcha.jpg','addr':' 台北市中正區寶慶路32號B1',center: {lat: 25.0415964, lng: 121.509077899999}},'POI_190':{'name':'Tamoya太盛16烏龍麵(屏東太平洋店FC店)','icon':'./images/captcha.jpg','addr':'屏東市中華路80號',center: {lat: 22.6741188, lng: 120.4906223}},'POI_191':{'name':'Tamoya太盛16烏龍麵(台北101店FC店)','icon':'./images/captcha.jpg','addr':'台北市信義区市府路45號',center: {lat: 25.0334929, lng: 121.564100999999}},'POI_192':{'name':'Tamoya太盛16烏龍麵(高雄義大店FC店)','icon':'./images/captcha.jpg','addr':'高雄市大樹區學城路一段10號C區4樓(義大世界購物廣場)',center: {lat: 22.7296392, lng: 120.4069259}},'POI_193':{'name':'Tamoya太盛16烏龍麵(桃園經國店FC店)','icon':'./images/captcha.jpg','addr':'桃園市桃園區經國路369號 2階',center: {lat: 25.0158516, lng: 121.3049144}},'POI_194':{'name':'Tamoya太盛16烏龍麵(嘉義耐斯松屋店FC店)','icon':'./images/captcha.jpg','addr':'嘉義市東區忠孝路600號 地下1階 （松屋百貨店)',center: {lat: 23.5025236, lng: 120.4483637}},'POI_195':{'name':'Tamoya太盛16烏龍麵(台北微風南京店FC店)','icon':'./images/captcha.jpg','addr':'台北市松山區南京東路三段337號4階',center: {lat: 25.052006, lng: 121.548289}},'POI_196':{'name':'Tamoya太盛16烏龍麵(台北内湖大潤發店FC店)','icon':'./images/captcha.jpg','addr':'台北市内湖區舊宗路一段128號1褸(大潤發RT-MART)',center: {lat: 25.0609683, lng: 121.5780389}},'POI_197':{'name':'Tamoya太盛16烏龍麵(家樂福台南仁德店FC店)','icon':'./images/captcha.jpg','addr':'台南市仁德區中山路711號(家樂福 仁德店)',center: {lat: 22.9721967, lng: 120.246959}},'POI_198':{'name':'Tamoya太盛16烏龍麵(新竹清大店FC店)','icon':'./images/captcha.jpg','addr':'新竹市東區光復路二段334號',center: {lat: 24.7959729, lng: 120.9982181}},'POI_199':{'name':'Tamoya太盛16烏龍麵(淡新家樂福店FC店)','icon':'./images/captcha.jpg','addr':'新北市淡水區中山北路二段383號',center: {lat: 25.1853442, lng: 121.444267299999}},'POI_200':{'name':'Tamoya太盛16烏龍麵(彰化家樂福店FC店)','icon':'./images/captcha.jpg','addr':'彰化懸彰化市金馬路二段34號',center: {lat: 24.0968099, lng: 120.547912}},'POI_201':{'name':'Tamoya太盛16烏龍麵(高雄五福店FC店)','icon':'./images/captcha.jpg','addr':'高雄市新興區五福二路262號1F（大統百貨 五福店）',center: {lat: 22.6235473, lng: 120.3014068}},'POI_202':{'name':'天屋食堂(桃園店)','icon':'./images/captcha.jpg','addr':'桃園市中正路19號B1 (桃園新光三越B1)',center: {lat: 24.9899795, lng: 121.312653299999}},'POI_203':{'name':'鶿克米tsukumi()','icon':'./images/captcha.jpg','addr':'台北市忠孝東路五段68號4F',center: {lat: 25.0405044, lng: 121.5668964}},'POI_204':{'name':'YAYOI - Japanese Teishoku Restaurant(南京松江店)','icon':'./images/captcha.jpg','addr':'台北市中山區南京東路二段97號１樓',center: {lat: 25.0522894, lng: 121.532259}},'POI_205':{'name':'YAYOI - Japanese Teishoku Restaurant(天母店)','icon':'./images/captcha.jpg','addr':'台北市士林區忠誠路二段70巷2號１樓',center: {lat: 25.1114833, lng: 121.5304562}},'POI_206':{'name':'YAYOI - Japanese Teishoku Restaurant(七張店)','icon':'./images/captcha.jpg','addr':'新北市新店區北新路二段128號2樓',center: {lat: 24.975087, lng: 121.543144999999}},'POI_207':{'name':'YAYOI - Japanese Teishoku Restaurant(南京三民店)','icon':'./images/captcha.jpg','addr':'台北市松山區南京東路五段92.94.96號１樓',center: {lat: 25.0512527, lng: 121.561705599999}},'POI_208':{'name':'YAYOI - Japanese Teishoku Restaurant(敦南和平店)','icon':'./images/captcha.jpg','addr':'台北市大安區敦化南路二段269.271號1樓',center: {lat: 25.025102, lng: 121.549144999999}},'POI_209':{'name':'YAYOI - Japanese Teishoku Restaurant(站前懷寧店)','icon':'./images/captcha.jpg','addr':'台北市中正區懷寧街21號2F',center: {lat: 25.0453785, lng: 121.514284399999}},'POI_210':{'name':'YAYOI - Japanese Teishoku Restaurant(南港車站店)','icon':'./images/captcha.jpg','addr':'台北市南港區忠孝東路七段371號B1F',center: {lat: 25.0519455, lng: 121.604659399999}},'POI_211':{'name':'八番赤野日式料理(臺大醫院B1)','icon':'./images/captcha.jpg','addr':'台北市中山南路7號',center: {lat: 25.0403647, lng: 121.5191025}},'POI_212':{'name':'八番赤野日式料理(大江購物中心GBF)','icon':'./images/captcha.jpg','addr':'桃園市中壢區中園路二段501號',center: {lat: 25.0006585, lng: 121.229209999999}},'POI_213':{'name':'八番赤野日式料理(台茂購物中心)','icon':'./images/captcha.jpg','addr':'桃園市蘆竹區南崁路一段112號',center: {lat: 25.0531423, lng: 121.287867699999}},'POI_214':{'name':'八番赤野日式料理(微風廣場B1)','icon':'./images/captcha.jpg','addr':'台北市松山區復興南路一段39號',center: {lat: 25.0460629, lng: 121.544171699999}},'POI_215':{'name':'八番赤野日式料理(微風站前2F)','icon':'./images/captcha.jpg','addr':'台北市中正區北平西路3號',center: {lat: 25.0479239, lng: 121.517080999999}},'POI_216':{'name':'三田製麺所(統一時代店)','icon':'./images/captcha.jpg','addr':'台北市信義區忠孝東路五段8號B2',center: {lat: 25.0408461, lng: 121.5653964}},'POI_217':{'name':'三田製麺所(夢時代高雄店)','icon':'./images/captcha.jpg','addr':'高雄市前鎮區中華五路789號B1',center: {lat: 22.5950447, lng: 120.3071367}},'POI_218':{'name':'三田製麺所(台中中友店)','icon':'./images/captcha.jpg','addr':'台中市北區三民路三段161號C棟B3(台中中友百貨C棟B3)',center: {lat: 24.1520729, lng: 120.684754}},'POI_219':{'name':'三田製麺所(夢時代台南店)','icon':'./images/captcha.jpg','addr':'台南市東區中華路一段366號B1',center: {lat: 22.9907349, lng: 120.233097}},'POI_220':{'name':'三田製麺所(微風台北車站店)','icon':'./images/captcha.jpg','addr':'台北市中正區北平西路3號2樓',center: {lat: 25.0479239, lng: 121.517080999999}},'POI_221':{'name':'三次魚屋(第一支店（北平店）)','icon':'./images/captcha.jpg','addr':'台中市北平路三段168號',center: {lat: 24.1709059, lng: 120.684416999999}},'POI_222':{'name':'三次魚屋(第二支店（中港店）)','icon':'./images/captcha.jpg','addr':'台中市台中港路三段118之59號',center: {lat: 24.1711909, lng: 120.631727599999}},'POI_223':{'name':'大戶屋(新光三越南西二館店)','icon':'./images/captcha.jpg','addr':'台北市中山區南京西路14號B1',center: {lat: 25.0521315, lng: 121.520676999999}},'POI_224':{'name':'大戶屋(民權東路一段店)','icon':'./images/captcha.jpg','addr':'台北市中山區民權東路一段9號B1',center: {lat: 25.062924, lng: 121.523366099999}},'POI_225':{'name':'大戶屋(長春店)','icon':'./images/captcha.jpg','addr':'台北市中山區長春路50號2F',center: {lat: 25.0548202, lng: 121.525803399999}},'POI_226':{'name':'大戶屋(美麗華店)','icon':'./images/captcha.jpg','addr':'台北市中山區敬業三路20號B1',center: {lat: 25.083576, lng: 121.557098499999}},'POI_227':{'name':'大戶屋(台北凱撒店)','icon':'./images/captcha.jpg','addr':'台北市中正區忠孝西路一段38號B1(捷運台北車站6號出口)',center: {lat: 25.0329636, lng: 121.5654268}},'POI_228':{'name':'大戶屋(遠百寶慶店)','icon':'./images/captcha.jpg','addr':'台北市中正區寶慶路32號B1',center: {lat: 25.0415964, lng: 121.509077899999}},'POI_229':{'name':'大戶屋(微風台北車站店)','icon':'./images/captcha.jpg','addr':'台北市中正區北平西路3號2F(東3門)',center: {lat: 25.0477505, lng: 121.5170599}},'POI_230':{'name':'大戶屋(忠孝復興店--新開幕)','icon':'./images/captcha.jpg','addr':'台北市大安區忠孝東路四段52號2樓(捷運忠孝復興站三號出口)',center: {lat: 25.0414172, lng: 121.5450226}},'POI_231':{'name':'大戶屋(統一時代台北店)','icon':'./images/captcha.jpg','addr':'台北市信義區忠孝東路五段8號B2',center: {lat: 25.0408461, lng: 121.5653964}},'POI_232':{'name':'大戶屋(ATT信義店)','icon':'./images/captcha.jpg','addr':'台北市信義區松壽路12號5F',center: {lat: 25.03531, lng: 121.5660665}},'POI_233':{'name':'大戶屋(松山車站店)','icon':'./images/captcha.jpg','addr':'台北市信義區松山路11號1樓',center: {lat: 25.0491901, lng: 121.578299399999}},'POI_234':{'name':'大戶屋(南港車站店)','icon':'./images/captcha.jpg','addr':'台北市南港區忠孝東路七段369號7樓',center: {lat: 25.0525582, lng: 121.604517999999}},'POI_235':{'name':'大戶屋(微風廣場店)','icon':'./images/captcha.jpg','addr':'台北市松山區復興南路一段39號GF',center: {lat: 25.0460629, lng: 121.544171699999}},'POI_236':{'name':'大戶屋(南京復興店)','icon':'./images/captcha.jpg','addr':'台北市松山區南京東路三段258號2F',center: {lat: 25.0516097, lng: 121.5448268}},'POI_237':{'name':'大戶屋(大安店)','icon':'./images/captcha.jpg','addr':'台北市大安區復興南路一段323號B1',center: {lat: 25.0336797, lng: 121.543891799999}},'POI_238':{'name':'大戶屋(土城金城店)','icon':'./images/captcha.jpg','addr':'新北市土城區金城路三段10.12號2樓',center: {lat: 24.9860703, lng: 121.4648819}},'POI_239':{'name':'大戶屋(桃園遠百店)','icon':'./images/captcha.jpg','addr':'桃園市桃園區中正路20號9樓(桃園遠東百貨9樓)',center: {lat: 24.9916895, lng: 121.3126287}},'POI_240':{'name':'大戶屋(中壢中原店)','icon':'./images/captcha.jpg','addr':'桃園市中壢區中華路二段501號1F(家樂福中原店內)',center: {lat: 24.9623587, lng: 121.232050899999}},'POI_241':{'name':'大戶屋(竹北光明店)','icon':'./images/captcha.jpg','addr':'新竹縣竹北市光明一路218號',center: {lat: 24.8305701, lng: 121.0155755}},'POI_242':{'name':'大戶屋(台中老虎城店)','icon':'./images/captcha.jpg','addr':'台中市西屯區河南路三段120號3F',center: {lat: 24.1640826, lng: 120.638127599999}},'POI_243':{'name':'大戶屋(台中大墩店)','icon':'./images/captcha.jpg','addr':'台中市南屯區大墩路533號2F',center: {lat: 24.1496326, lng: 120.6496563}},'POI_244':{'name':'大戶屋(台中高鐵店)','icon':'./images/captcha.jpg','addr':'台中市烏日區站區二路8號2F',center: {lat: 24.1129508, lng: 120.6155309}},'POI_245':{'name':'大戶屋(南紡購物中心店)','icon':'./images/captcha.jpg','addr':'台南市東區中華東路一段366號',center: {lat: 22.9907349, lng: 120.233097}},'POI_246':{'name':'大戶屋(台南遠百公園店)','icon':'./images/captcha.jpg','addr':'台南市中西區公園路60號1F',center: {lat: 22.9954491, lng: 120.2060681}},'POI_247':{'name':'大戶屋(高雄漢神店)','icon':'./images/captcha.jpg','addr':'高雄市前金區成功一路266-1號B3',center: {lat: 22.6193292, lng: 120.2959226}},'POI_248':{'name':'大戶屋(高雄大遠百店)','icon':'./images/captcha.jpg','addr':'高雄市苓雅區三多四路21號11F(捷R8一號出口)',center: {lat: 22.6130726, lng: 120.303950699999}},'POI_249':{'name':'大戶屋(漢神巨蛋店)','icon':'./images/captcha.jpg','addr':'高雄市左營區博愛二路777號4F',center: {lat: 22.6699973, lng: 120.302775}},'POI_250':{'name':'旬彩神樂家((台北)忠孝店)','icon':'./images/captcha.jpg','addr':'台北市忠孝東路四段45號11樓 ',center: {lat: 25.0419689, lng: 121.544902099999}},'POI_251':{'name':'元定食(台北京站店)','icon':'./images/captcha.jpg','addr':'台北市承德路一段1號B3樓',center: {lat: 25.049308, lng: 121.5171935}},'POI_252':{'name':'元定食(新竹巨城店)','icon':'./images/captcha.jpg','addr':'新竹市東區中央路229號7樓',center: {lat: 24.8090149, lng: 120.974780199999}},'POI_253':{'name':'元定食(台中大遠百店)','icon':'./images/captcha.jpg','addr':'台中市台中港路二段105號11樓',center: {lat: 24.1606915, lng: 120.6516123}},'POI_254':{'name':'元定食(高雄夢時代店)','icon':'./images/captcha.jpg','addr':'高雄市前鎮區中華五路789號7樓',center: {lat: 22.5950447, lng: 120.3071367}},'POI_255':{'name':'元定食( 高雄SOGO店)','icon':'./images/captcha.jpg','addr':'高雄市三多三路217號14樓',center: {lat: 22.6142119, lng: 120.306045499999}},'POI_256':{'name':'天吉屋(忠孝店)','icon':'./images/captcha.jpg','addr':'台北市忠孝東路4段216巷27弄10號',center: {lat: 25.0397982, lng: 121.5536199}},'POI_257':{'name':'天吉屋(京站店)','icon':'./images/captcha.jpg','addr':'台北市大同區承德路一段1號1樓',center: {lat: 25.049308, lng: 121.5171935}},'POI_258':{'name':'天吉屋(巨城店)','icon':'./images/captcha.jpg','addr':'新竹市東區中央路229號7樓(遠東巨城購物中心)',center: {lat: 24.8090149, lng: 120.974780199999}},'POI_259':{'name':'天吉屋(遠百店)','icon':'./images/captcha.jpg','addr':'新北市板橋區新站路28號B1(板橋大遠百B1)',center: {lat: 25.0136682, lng: 121.466922399999}},'POI_260':{'name':'天吉屋(微風店)','icon':'./images/captcha.jpg','addr':'台北市復興南路一段39號GF (微風廣場)',center: {lat: 25.0329636, lng: 121.5654268}},'POI_261':{'name':'百八魚場(水竹圍店)','icon':'./images/captcha.jpg','addr':'新北市淡水區民權路91號',center: {lat: 25.1381347, lng: 121.460218899999}},'POI_262':{'name':'百八魚場(林口店)','icon':'./images/captcha.jpg','addr':'新北市林口區文化一路一段40號 ',center: {lat: 25.0693296, lng: 121.3713678}},'POI_263':{'name':'百八魚場(愛買南雅店)','icon':'./images/captcha.jpg','addr':'新北市板橋區貴興路101號',center: {lat: 25.002656, lng: 121.456194999999}},'POI_264':{'name':'百八魚場(新店店)','icon':'./images/captcha.jpg','addr':'新北市新店區民權路104號',center: {lat: 24.9831539, lng: 121.53591}},'POI_265':{'name':'百八魚場(汐止店)','icon':'./images/captcha.jpg','addr':'新北市汐止區新台五路1段160號一樓',center: {lat: 25.0622636, lng: 121.6542474}},'POI_266':{'name':'百八魚場(愛買永和店)','icon':'./images/captcha.jpg','addr':'新北市永和區民生路46巷56號',center: {lat: 24.9964804, lng: 121.521018899999}},'POI_267':{'name':'百八魚場(石牌店)','icon':'./images/captcha.jpg','addr':'台北市北投區石牌路二段90巷6、8號',center: {lat: 25.1170878, lng: 121.5166257}},'POI_268':{'name':'百八魚場(民生店)','icon':'./images/captcha.jpg','addr':'台北市中山區民生西路44號 ',center: {lat: 25.0576215, lng: 121.5214318}},'POI_269':{'name':'百八魚場(西湖店)','icon':'./images/captcha.jpg','addr':'台北市內湖區瑞光路583巷22號',center: {lat: 25.080444, lng: 121.568152999999}},'POI_270':{'name':'百八魚場(士林店)','icon':'./images/captcha.jpg','addr':'台北市士林區文林路424‧426號',center: {lat: 25.0950492, lng: 121.524607699999}},'POI_271':{'name':'百八魚場(瑞光店)','icon':'./images/captcha.jpg','addr':'台北市內湖區瑞光路305號 ',center: {lat: 25.075952, lng: 121.575955}},'POI_272':{'name':'百八魚場(南京店)','icon':'./images/captcha.jpg','addr':'台北市松山區南京東路五段208號 ',center: {lat: 25.0512503, lng: 121.565033599999}},'POI_273':{'name':'百八魚場(重慶店)','icon':'./images/captcha.jpg','addr':'台北市中正區重慶南路一段113號',center: {lat: 25.0426189, lng: 121.5133601}},'POI_274':{'name':'百八魚場(古亭店)','icon':'./images/captcha.jpg','addr':'台北市中正區南昌路二段216號 ',center: {lat: 25.023938, lng: 121.524421999999}},'POI_275':{'name':'百八魚場(忠孝店)','icon':'./images/captcha.jpg','addr':'台北市中正區忠孝東路一段152號',center: {lat: 25.043997, lng: 121.525810299999}},'POI_276':{'name':'百八魚場(三創店)','icon':'./images/captcha.jpg','addr':'台北市中正區市民大道三段2號B2',center: {lat: 25.0454815, lng: 121.531127299999}},'POI_277':{'name':'百八魚場(家樂福重慶店)','icon':'./images/captcha.jpg','addr':'台北市大同區重慶北路二段171號',center: {lat: 25.0591761, lng: 121.5138362}},'POI_278':{'name':'百八魚場(基隆碼頭店)','icon':'./images/captcha.jpg','addr':'基隆市仁愛區港西街6之2號2樓',center: {lat: 25.1319062, lng: 121.740265899999}},'POI_279':{'name':'百八魚場(南平店)','icon':'./images/captcha.jpg','addr':'桃園市桃園區南平路290號 ',center: {lat: 25.0188057, lng: 121.299306699999}},'POI_280':{'name':'百八魚場(愛買桃園店)','icon':'./images/captcha.jpg','addr':'桃園市桃園區中山路939號',center: {lat: 24.9848335, lng: 121.2861718}},'POI_281':{'name':'百八魚場(大潤發中壢店)','icon':'./images/captcha.jpg','addr':'桃園市中壢區中北路二段468號B1',center: {lat: 24.954739, lng: 121.234989999999}},'POI_282':{'name':'百八魚場(統領桃園店)','icon':'./images/captcha.jpg','addr':'桃園市桃園區中正路61號B2',center: {lat: 24.9910614, lng: 121.312372999999}},'POI_283':{'name':'百八魚場(巨城店)','icon':'./images/captcha.jpg','addr':'新竹市東區中央路229號',center: {lat: 24.8090149, lng: 120.974780199999}},'POI_284':{'name':'百八魚場(家樂福青海店)','icon':'./images/captcha.jpg','addr':'台中市西屯區青海路二段207-18號B1',center: {lat: 24.1704719, lng: 120.644873599999}},'POI_285':{'name':'百八魚場(家樂福中清店)','icon':'./images/captcha.jpg','addr':'台中市西屯區中清路三段436號',center: {lat: 24.20641, lng: 120.652542}},'POI_286':{'name':'百八魚場(家樂福嘉義店)','icon':'./images/captcha.jpg','addr':'嘉義市西區博愛路二段461號B1',center: {lat: 23.4713112, lng: 120.4311895}},'POI_287':{'name':'百八魚場(高雄草衙道店)','icon':'./images/captcha.jpg','addr':'高雄市前鎮區中山四路100號3F',center: {lat: 22.5823718, lng: 120.3285246}},'POI_288':{'name':'汐科食堂(101食堂)','icon':'./images/captcha.jpg','addr':'台北市市府路45號B1',center: {lat: 25.0334929, lng: 121.564100999999}},'POI_289':{'name':'汐科食堂(台中高鐵食堂)','icon':'./images/captcha.jpg','addr':'台中市烏日區站區二路8號',center: {lat: 24.1129508, lng: 120.6155309}},'POI_290':{'name':'汐科食堂(汐科食堂（遠雄）)','icon':'./images/captcha.jpg','addr':'新北市汐止區新台五路一段95號B1之1',center: {lat: 25.0565746, lng: 121.634819699999}},'POI_291':{'name':'汐科食堂(晶冠食堂)','icon':'./images/captcha.jpg','addr':'新北市新莊區五工路66號2樓',center: {lat: 25.0639598, lng: 121.4589273}},'POI_292':{'name':'汐科食堂(大安森林食堂)','icon':'./images/captcha.jpg','addr':'台北市大安區新生南路一段161-3號',center: {lat: 25.03449, lng: 121.533114}},'POI_293':{'name':'味一亭(草衙道店)','icon':'./images/captcha.jpg','addr':'高雄市前鎮區中山四路100號',center: {lat: 22.5823718, lng: 120.3285246}},'POI_294':{'name':'味一亭(義大店)','icon':'./images/captcha.jpg','addr':'高雄市大樹區學城路一段10號 (義大世界購物廣場)',center: {lat: 22.7296392, lng: 120.4069259}},'POI_295':{'name':'信州王滝(中友店)','icon':'./images/captcha.jpg','addr':'台中市北區三民路三段161號 (中友百貨A棟14樓)',center: {lat: 24.1520729, lng: 120.684754}},'POI_296':{'name':'烏丼亭烏龍麵專賣(義大店)','icon':'./images/captcha.jpg','addr':'高雄市大樹區學城路一段12號A區5樓',center: {lat: 22.7289906, lng: 120.4056332}},'POI_297':{'name':'烏丼亭烏龍麵專賣(誠品敦南B2)','icon':'./images/captcha.jpg','addr':'台北市大安區敦化南路一段245號B1',center: {lat: 25.0394894, lng: 121.5493278}},'POI_298':{'name':'烏丼亭烏龍麵專賣(漢神巨蛋百貨 B1)','icon':'./images/captcha.jpg','addr':'高雄市左營區博愛二路777號',center: {lat: 22.6699973, lng: 120.302775}},'POI_299':{'name':'烏丼亭烏龍麵專賣(科學教育館孔龍食堂B1)','icon':'./images/captcha.jpg','addr':'台北市士林區士商路189號 (恐龍食堂B1)',center: {lat: 25.0961275, lng: 121.5166874}},'POI_300':{'name':'熊本家鐵板料理(豐原太平洋B1)','icon':'./images/captcha.jpg','addr':'台中市豐原區復興路2號',center: {lat: 24.2509879, lng: 120.720606099999}},'POI_301':{'name':'熊本家鐵板料理(台中中港店)','icon':'./images/captcha.jpg','addr':'台中市西屯區台灣大道三段301號',center: {lat: 24.1652572, lng: 120.6437083}},'POI_302':{'name':'熊本家鐵板料理(嘉義耐斯松屋)','icon':'./images/captcha.jpg','addr':'嘉義市東區忠孝路600號',center: {lat: 23.5025236, lng: 120.4483637}},'POI_303':{'name':'熊本家鐵板料理(嘉義垂楊店 B1)','icon':'./images/captcha.jpg','addr':'嘉義市西區垂楊路726號',center: {lat: 23.4731161, lng: 120.441370499999}},'POI_304':{'name':'熊本家鐵板料理(新竹站前店)','icon':'./images/captcha.jpg','addr':'新竹市民族路2號 ',center: {lat: 24.8030583, lng: 120.972018899999}},'POI_305':{'name':'嘿鬥日式定食專賣(勤美店)','icon':'./images/captcha.jpg','addr':'台中市公益路68號   勤美誠品綠園道B',center: {lat: 24.1512354, lng: 120.663848}},'POI_306':{'name':'鮮五丼(延吉店)','icon':'./images/captcha.jpg','addr':'台北市大安區延吉街137巷18號',center: {lat: 25.0419014, lng: 121.5550773}},'POI_307':{'name':'鮮五丼(西門店)','icon':'./images/captcha.jpg','addr':'台北市萬華區成都路86號2樓(國賓戲院旁)',center: {lat: 25.0430189, lng: 121.504538}},'POI_308':{'name':'鮮五丼(湖潤店)','icon':'./images/captcha.jpg','addr':'台北市內湖區舊宗路一段188號(大潤發量販店二店)',center: {lat: 25.0629017, lng: 121.5758964}},'POI_309':{'name':'鮮五丼(東興店)','icon':'./images/captcha.jpg','addr':'台北市信義區東興路45號1F(家樂福量販店)',center: {lat: 25.0481469, lng: 121.5660421}},'POI_310':{'name':'鮮五丼(舊宗店)','icon':'./images/captcha.jpg','addr':'台北市內湖區舊宗路一段128號(大潤發量販店)',center: {lat: 25.0609683, lng: 121.5780389}},'POI_311':{'name':'鮮五丼(南港店)','icon':'./images/captcha.jpg','addr':'台北市南港區經貿二路186號3樓(中信大樓C棟)',center: {lat: 25.0598601, lng: 121.6153587}},'POI_312':{'name':'鮮五丼(新店店)','icon':'./images/captcha.jpg','addr':'新北市新店區民權路12號',center: {lat: 24.983111, lng: 121.542268899999}},'POI_313':{'name':'鮮五丼(佳瑪店)','icon':'./images/captcha.jpg','addr':'新北市新店區建國路268號',center: {lat: 24.9832192, lng: 121.5377541}},'POI_314':{'name':'鮮五丼(樹林店)','icon':'./images/captcha.jpg','addr':'新北市樹林區大安路118號(家樂福量販店)',center: {lat: 24.9966801, lng: 121.421018499999}},'POI_315':{'name':'鮮五丼(汐止店)','icon':'./images/captcha.jpg','addr':'新北市汐止區新台五路一段99號B1(遠雄購物中心)',center: {lat: 25.0619968, lng: 121.6484837}},'POI_316':{'name':'鮮五丼(環球店)','icon':'./images/captcha.jpg','addr':'新北市中和區中山路三段122號3樓 (環球購物中心)',center: {lat: 25.0065836, lng: 121.474825199999}},'POI_317':{'name':'鮮五丼(經國店)','icon':'./images/captcha.jpg','addr':'桃園縣桃園市經國路369號2樓(家樂福量販店)',center: {lat: 25.0158516, lng: 121.3049144}},'POI_318':{'name':'鮮五丼(內壢店)','icon':'./images/captcha.jpg','addr':'桃園縣中壢市中華路一段450號(家樂福量販店)',center: {lat: 24.9727564, lng: 121.253447999999}},'POI_319':{'name':'鮮五丼(壢福店)','icon':'./images/captcha.jpg','addr':'桃園縣中壢市中山東路二段510號(家樂福量販店)',center: {lat: 24.9465528, lng: 121.2461428}},'POI_320':{'name':'鮮五丼(桃愛店)','icon':'./images/captcha.jpg','addr':'桃園縣桃園市中山路939號(愛買量販店)',center: {lat: 24.9848335, lng: 121.2861718}},'POI_321':{'name':'鮮五丼(新潤店)','icon':'./images/captcha.jpg','addr':'新竹市東區忠孝路300號(大潤發量販店)',center: {lat: 24.8052292, lng: 120.9845166}},'POI_322':{'name':'鮮五丼(嘉義店)','icon':'./images/captcha.jpg','addr':'嘉義市西區博愛路二段281號1樓(大潤發量販店)',center: {lat: 23.4781873, lng: 120.438057}},'POI_323':{'name':'鮮五丼(忠明店)','icon':'./images/captcha.jpg','addr':'台中市北區忠明路499號B1(大潤發量販店)',center: {lat: 24.16341, lng: 120.6719255}},'POI_324':{'name':'鮮五丼(文心店)','icon':'./images/captcha.jpg','addr':'台中市南屯區文心路一段521號B1(家樂福量販店)',center: {lat: 24.1539166, lng: 120.6464058}},'POI_325':{'name':'鮮五丼(黎明店)','icon':'./images/captcha.jpg','addr':'台中市南屯區大墩十一街666號(楓康超市內)',center: {lat: 24.1484804, lng: 120.635247299999}},'POI_326':{'name':'鮮五丼(南京店)','icon':'./images/captcha.jpg','addr':'台北市中山區南京東路三段115號',center: {lat: 25.052204, lng: 121.539888}},'POI_327':{'name':'鮮五丼(鳳山店)','icon':'./images/captcha.jpg','addr':'高雄市鳳山區文化路59號B1(大潤發量販店）',center: {lat: 22.633408, lng: 120.355441499999}},'POI_328':{'name':'藍屋日本料理(板橋大遠百新站店)','icon':'./images/captcha.jpg','addr':'新北市板橋區新站路28號9F',center: {lat: 25.013487, lng: 121.4668732}},'POI_329':{'name':'藍屋日本料理(中壢大江店)','icon':'./images/captcha.jpg','addr':'中壢區中園路二段501號4F',center: {lat: 25.0006585, lng: 121.229209999999}},'POI_330':{'name':'藍屋日本料理(台中中友店)','icon':'./images/captcha.jpg','addr':'台中市北區三民路三段161號A棟14F',center: {lat: 24.1520729, lng: 120.684754}},'POI_331':{'name':'藍屋日本料理(台南南紡店)','icon':'./images/captcha.jpg','addr':'台南市東區中華東路一段366號5樓',center: {lat: 22.9907349, lng: 120.233097}},'POI_332':{'name':'藍屋日本料理(新光三越左營店)','icon':'./images/captcha.jpg','addr':'高雄市左營區高鐵路123號9樓',center: {lat: 22.6883153, lng: 120.3099674}},'POI_333':{'name':'東京咖哩Tokyo Curry(統一阪急店)','icon':'./images/captcha.jpg','addr':'台北市忠孝東路五段8號(統一阪急百貨Ｂ2美食廣場內）',center: {lat: 25.0408461, lng: 121.5653964}},'POI_334':{'name':'東京咖哩Tokyo Curry(台北101店)','icon':'./images/captcha.jpg','addr':'台北市信義路五段7號 B1',center: {lat: 25.0339226, lng: 121.5646368}},'POI_335':{'name':'東京咖哩Tokyo Curry(八德外帶店)','icon':'./images/captcha.jpg','addr':'台北市八德路四段317號',center: {lat: 25.0492515, lng: 121.566915}},'POI_336':{'name':'東京咖哩Tokyo Curry(桃園機場店)','icon':'./images/captcha.jpg','addr':'臺灣桃園國際機場第二航廈B2',center: {lat: 25.0796514, lng: 121.234216999999}},'POI_337':{'name':'奧里安達魯咖哩 Oriental Curry(遠企店)','icon':'./images/captcha.jpg','addr':'臺北市大安區敦化南路二段203號B2',center: {lat: 25.026208, lng: 121.549263}},'POI_338':{'name':'奧里安達魯咖哩 Oriental Curry(光華店)','icon':'./images/captcha.jpg','addr':'新竹市光華北街81號',center: {lat: 24.817144, lng: 120.97162}},'POI_339':{'name':'奧里安達魯咖哩 Oriental Curry(新竹店)','icon':'./images/captcha.jpg','addr':'新竹縣竹北市光明六路1號',center: {lat: 24.824477, lng: 121.0148056}},'POI_340':{'name':'元氣咖哩(高雄大遠百)','icon':'./images/captcha.jpg','addr':'高雄市苓雅區三多四路21號',center: {lat: 22.6130726, lng: 120.303950699999}},'POI_341':{'name':'元氣咖哩(高雄夢時代店)','icon':'./images/captcha.jpg','addr':'高雄市前鎮區中華五路789號B1F',center: {lat: 22.5950447, lng: 120.3071367}},'POI_342':{'name':'元氣咖哩(台南大遠百)','icon':'./images/captcha.jpg','addr':'台南市東區前鋒路210號B2F',center: {lat: 22.9963719, lng: 120.213886099999}},'POI_343':{'name':'元氣咖哩(南紡夢時代)','icon':'./images/captcha.jpg','addr':'台南市東區中華東路一段366號B1F',center: {lat: 22.9907349, lng: 120.233097}},'POI_344':{'name':'元氣咖哩(屏東太平洋SOGO)','icon':'./images/captcha.jpg','addr':'屏東縣中正路72號B1F',center: {lat: 22.5519759, lng: 120.5487597}},'POI_345':{'name':'元氣咖哩(高雄義大世界)','icon':'./images/captcha.jpg','addr':'高雄市大樹區學城路一段12號',center: {lat: 22.7296392, lng: 120.4069259}},'POI_346':{'name':'茄子咖哩(公館店)','icon':'./images/captcha.jpg','addr':'台北市羅斯福路四段 85 號 2F',center: {lat: 25.012971, lng: 121.536381}},'POI_347':{'name':'茄子咖哩(玩笑亭拉麵店)','icon':'./images/captcha.jpg','addr':'台中市中港路三段118號之51',center: {lat: 24.1711909, lng: 120.631727599999}},'POI_348':{'name':'魔法咖哩(台北凱撒店)','icon':'./images/captcha.jpg','addr':'台北市忠孝西路一段38號B1',center: {lat: 25.0462585, lng: 121.516421799999}},'POI_349':{'name':'魔法咖哩(台北西門店)','icon':'./images/captcha.jpg','addr':'台北市峨眉街37號4樓',center: {lat: 25.043566, lng: 121.507125999999}},'POI_350':{'name':'魔法咖哩(台北內湖店)','icon':'./images/captcha.jpg','addr':'台北市內湖區舊宗路一段150巷25號',center: {lat: 25.0620359, lng: 121.5765051}},'POI_351':{'name':'魔法咖哩(台北景美店)','icon':'./images/captcha.jpg','addr':'台北市文山區景興路188號B2',center: {lat: 24.9923, lng: 121.543815}},'POI_352':{'name':'魔法咖哩(新北淡水店)','icon':'./images/captcha.jpg','addr':'新北市淡水區中山路8號8樓',center: {lat: 25.1691616, lng: 121.4446153}},'POI_353':{'name':'魔法咖哩(新北板橋店)','icon':'./images/captcha.jpg','addr':'新北市板橋區中山路一段46號B1',center: {lat: 25.00873, lng: 121.460659999999}},'POI_354':{'name':'魔法咖哩(苗栗頭份店)','icon':'./images/captcha.jpg','addr':'苗栗縣頭份市中央路103號2樓',center: {lat: 24.6937825, lng: 120.8977582}},'POI_355':{'name':'魔法咖哩(台中大墩店)','icon':'./images/captcha.jpg','addr':'台中市南屯區大墩路533號2樓',center: {lat: 24.1496326, lng: 120.6496563}}
	},{//勝博殿
		'POI_0':{'name':'勝博殿(新光三越天母店)','icon':'./images/captcha.jpg','addr':'臺北市士林區天母東路68號7F',center: {lat: 25.1179204, lng: 121.5339295}},'POI_1':{'name':'勝博殿(新光三越天母店)','icon':'./images/captcha.jpg','addr':'臺北市士林區天母東路68號7F',center: {lat: 25.1179204, lng: 121.5339295}},'POI_2':{'name':'勝博殿(新光三越站前店 )','icon':'./images/captcha.jpg','addr':'臺北市中正區忠孝西路一段66號12F',center: {lat: 25.0461278, lng: 121.515325}},'POI_3':{'name':'勝博殿(新光三越信義店A9館 )','icon':'./images/captcha.jpg','addr':'臺北市信義區松壽路9號6F',center: {lat: 25.036018, lng: 121.566575}},'POI_4':{'name':'勝博殿(臺北光復店)','icon':'./images/captcha.jpg','addr':'臺北市大安區光復南路290巷2號 ',center: {lat: 25.0394015, lng: 121.5568514}},'POI_5':{'name':'勝博殿(SOGO忠孝店)','icon':'./images/captcha.jpg','addr':'臺北市大安區忠孝東路四段45號11F',center: {lat: 25.0419689, lng: 121.544902099999}},'POI_6':{'name':'勝博殿(南西店)','icon':'./images/captcha.jpg','addr':'臺北市南京西路15號7F',center: {lat: 25.0527485, lng: 121.520683599999}},'POI_7':{'name':'勝博殿(劍南店 )','icon':'./images/captcha.jpg','addr':'臺北市中山區敬業3路11號1樓',center: {lat: 25.07925, lng: 121.5569768}},'POI_8':{'name':'勝博殿(台中店 )','icon':'./images/captcha.jpg','addr':'台中市中港路二段111號',center: {lat: 24.1603815, lng: 120.6520957}},'POI_9':{'name':'勝博殿(台中崇德店)','icon':'./images/captcha.jpg','addr':'台中市北屯區崇德路二段101號1F',center: {lat: 24.171048, lng: 120.685204}},'POI_10':{'name':'勝博殿(夢時代店)','icon':'./images/captcha.jpg','addr':'高雄市前鎮區中華五路789號7F',center: {lat: 22.5950447, lng: 120.3071367}},'POI_11':{'name':'勝博殿(漢神巨蛋店 )','icon':'./images/captcha.jpg','addr':'高雄市左營區博愛二路767號4F',center: {lat: 22.6693284, lng: 120.3026041}},'POI_12':{'name':'勝博殿(大立店(高雄大立精品館) )','icon':'./images/captcha.jpg','addr':'高雄市前金區五福三路57號B2F',center: {lat: 22.6217077, lng: 120.2982807}},'POI_13':{'name':'勝博殿(新光三越桃園店)','icon':'./images/captcha.jpg','addr':'桃園市中正路19號10F',center: {lat: 24.9899876, lng: 121.312985}},'POI_14':{'name':'勝博殿(南崁店)','icon':'./images/captcha.jpg','addr':'桃園縣蘆竹鄉中正路1號1F',center: {lat: 25.0596697, lng: 121.2099129}},'POI_15':{'name':'勝博殿(宜蘭店(新月廣場))','icon':'./images/captcha.jpg','addr':'宜蘭縣宜蘭市民權路二段38巷2號4F',center: {lat: 24.7545179, lng: 121.751108599999}},'POI_16':{'name':'勝博殿(新光三越台南西門店)','icon':'./images/captcha.jpg','addr':'台南市中西區西門路一段 658號6F ',center: {lat: 22.9868277, lng: 120.1977034}},'POI_17':{'name':'勝博殿(新光三越台南中山店)','icon':'./images/captcha.jpg','addr':'台南市中西區中山路162號12F ',center: {lat: 22.9955009, lng: 120.2098201}},'POI_18':{'name':'勝博殿(台中新時代店)','icon':'./images/captcha.jpg','addr':'台中市東區復興路四段186號3F',center: {lat: 24.1363062, lng: 120.6877167}},'POI_19':{'name':'勝博殿(新竹巨城店)','icon':'./images/captcha.jpg','addr':'新竹市中央路229號7F',center: {lat: 24.8090149, lng: 120.974780199999}},'POI_20':{'name':'勝博殿(桃園T2 Express店)','icon':'./images/captcha.jpg','addr':'桃園國際機場第2航廈出境大廳4F ',center: {lat: 24.9936281, lng: 121.3009798}},'POI_21':{'name':'勝博殿(臺北淡水店 )','icon':'./images/captcha.jpg','addr':'新北市淡水區中山路8號8F',center: {lat: 25.1734469, lng: 121.440778099999}},'POI_22':{'name':'勝博殿(松山店 (松山火車站citylink 內) )','icon':'./images/captcha.jpg','addr':'臺北市信義區松山路11號2F',center: {lat: 25.0491901, lng: 121.578299399999}},'POI_23':{'name':'勝博殿(Express鼎山店 (高雄鼎山家樂福內))','icon':'./images/captcha.jpg','addr':'高雄市三民區大順二路849號1樓',center: {lat: 22.6532977, lng: 120.318947999999}},'POI_24':{'name':'勝博殿(臺北高島屋店 (大葉高島屋內))','icon':'./images/captcha.jpg','addr':'臺北市士林區忠誠路二段55號12F',center: {lat: 25.1118264, lng: 121.5315215}},'POI_25':{'name':'勝博殿(中信店 (中國信託金融園區內))','icon':'./images/captcha.jpg','addr':'臺北市南港區經貿二路166號2樓',center: {lat: 25.0586969, lng: 121.6167802}},'POI_26':{'name':'勝博殿(中和環球Express店 (中和環球購物中心內))','icon':'./images/captcha.jpg','addr':'新北市中和區中山路三段122號B2樓',center: {lat: 25.0065836, lng: 121.474825199999}},'POI_27':{'name':'勝博殿(南紡店 (南紡夢時代購物中心內))','icon':'./images/captcha.jpg','addr':'台南市東區中華東路一段366號3樓',center: {lat: 22.9907349, lng: 120.233097}},'POI_28':{'name':'勝博殿(林口環球店/環球購物中心林口店)','icon':'./images/captcha.jpg','addr':'桃園市龜山區復興一路8號 2F',center: {lat: 25.0600937, lng: 121.3694582}},'POI_29':{'name':'勝博殿(嘉義秀泰店(1月底開幕))','icon':'./images/captcha.jpg','addr':'嘉義市西區國華裡文化路299號',center: {lat: 23.4803964, lng: 120.4242401}},'POI_30':{'name':'勝博殿(大魯閣草衙道店)','icon':'./images/captcha.jpg','addr':'高雄市前鎮區中山四路100號3樓',center: {lat: 22.5823718, lng: 120.3285246}}
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
		
		getNewPosition();
	}
	
function AAA(){
	console.log("AAA");
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
		
		$("#businessdistrict").dialog({
			draggable : true, 
			resizable : false, 
			autoOpen : false,
			height : "auto", 
			width : "auto", 
			modal : true,
			show : {
				effect : "blind",
				duration : 300
			},
			hide : {
				effect : "fade",
				duration : 300
			},
			buttons : [{
				text : "回到地圖",
				click : function() {
					$("#businessdistrict").dialog("close");
				}
			}],
			close : function() {
				$("#businessdistrict").dialog("close");
			}
		});
		
		$("#businessdistrict").show();
		
		$("#selectRegion").change(function(){
			console.log('selectRegion');
		
			var selecttable="<option value=''>請選擇商圈</option>";
			deleteMarker();
			
			for (var BD in businessdistrict) {
				console.log(BD);

				if($(this).val()==''){ 
					selecttable = "<option value=''>請先選擇地區</option>";
					map.panTo(new google.maps.LatLng(23.900,121.000));
					map.setZoom(7);
				} else {
					map.setZoom(13);
					$("#selectPOI").html(
						"<option value='0'>請選擇POI</option>"+
						"<option value='6'>餐廳</option>"+
						"<option value='1'>ATM</option>"+
						"<option value='8'>百貨公司</option>"+
						"<option value='10'>捷運站</option>"+
						"<option value='11'>豬排店</option>"+
						"<option value='12'>勝博殿</option>"+
						"<option value='3'>加油站</option>"+
						"<option value='4'>速食店</option>"+
						"<option value='5'>全聯</option>"+
						"<option value='7'>量販店</option>"+
						"<option value='9'>便利商店</option>"+
						"<option value='2'>停車場</option>"
					);
				}
				if($(this).val()=="Taipei" && businessdistrict[BD].n < 14){ 
					console.log(selecttable);
					selecttable+= "<option value='"+BD+"'>"+businessdistrict[BD].name+"</option>";
					map.panTo(new google.maps.LatLng(25.044,121.524));
				}
				if($(this).val()=="Taoyuan" && businessdistrict[BD].n>13 && businessdistrict[BD].n < 25){ 
					selecttable+= "<option value='"+BD+"'>"+businessdistrict[BD].name+"</option>";
					map.panTo(new google.maps.LatLng(24.995,121.298));
				}
				if($(this).val()=="Taichung" && businessdistrict[BD].n>24 && businessdistrict[BD].n < 32){ 
					selecttable+= "<option value='"+BD+"'>"+businessdistrict[BD].name+"</option>";
					map.panTo(new google.maps.LatLng(24.148,120.685));
				}
				if($(this).val()=="Tainan" && businessdistrict[BD].n>31 && businessdistrict[BD].n < 44){ 
					selecttable+= "<option value='"+BD+"'>"+businessdistrict[BD].name+"</option>";
					map.panTo(new google.maps.LatLng(22.994,120.218));
				}
				if($(this).val()=="Kaohsiung" && businessdistrict[BD].n > 43){ 
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
				
				console.log($(this).val());
				console.log(businessdistrict[$(this).val()].center);
				
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
						console.log("myLoop");
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
								if (i < 20||(thisval==10&&i<362)||(thisval==12&&i<30)||(thisval==11&&i<356)) {            //  if the counter < 10, call the loop function
									myLoop();             //  ..  again which will trigger another 
								}                        //  ..  setTimeout()
					   }, 0)
					}
					
					myLoop();                      //  start the loop
			}
		});	
		
	});
	
	$( document ).ready(function() {
		$("#businessdistrict").dialog("open");
	});
</script>
<!-- /**************************************  以上使用者JS區塊    *********************************************/	-->

<jsp:include page="header.jsp" flush="true"/>
<div class="content-wrap">
<h2 class="page-title">商圈定位</h2>
	<div class="search-result-wrap">
<!-- 	<button id='btn' onclick='console.log(result);' >TEST</button> -->
	<input id="pac-input" class="controls" type="text" placeholder="Search Box">
	
<!-- 	<button onclick='$("#businessdistrict").dialog("open");' style='position:absolute;left:50%;top:100px;z-index:99;'>打開</button> -->
	<a class="btn btn-orange" onclick='$("#businessdistrict").dialog("open");' style='position:absolute;left:23%;top:110px;z-index:99;'>選單</a>
	
	<div id='businessdistrict' title='商圈選擇' style='display:none;'>
	<div style='padding: 10px 60px'>
	
	<a class='btn btn-gray' style='font-size:24px;font-weight:lighter; margin:10px;float:right;' onclick="myreset()">&nbsp;&nbsp;重設&nbsp;&nbsp;</a>
	   <h3>搜尋條件</h3>
		　<!-- 地區： -->　<select id='selectRegion' hidden="true">
			  	 <option value="">請選擇</option>
	             <option value="Taipei">台北</option>
	             <option value="Taoyuan">桃園</option>
	             <option value="Taichung">台中</option>
	             <option value="Tainan">台南</option>
	             <option value="Kaohsiung">高雄</option>
			 </select>
<!-- 					 <a class='btn btn-darkblue' href="./大臺北地區.pdf" style='font-size:24px;font-weight:lighter; margin:10px;'>電子書</a> -->
<!-- 			 <br><br><br> -->
			 
		　<!-- 商圈： -->　<select id='selectBusinessdistrict' hidden="true">
			  	 <option value="">請先選擇地區</option>
			 </select>
<!-- 			 <br><br><br> -->
		　POI ：　<select id='selectPOI'>
			  	 <option value="">請先選擇地區</option>
			 </select>
	</div>
	</div>
	<div id="map"></div>
    <script>
	    var markers = [];
	    
	    function initMap() {
	    	console.log("initMap");
	    	
			// Create the map.
			map = new google.maps.Map(document.getElementById('map'), {
				zoom: 8,
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
    	    
			getNewPosition();
   		}

	    function getNewPosition() {
			var myLatLng = {lat: 25.044571, lng: 121.506409};

			map.panTo(businessdistrict["BD_4"].center);
			map.setZoom(16);
			
			var marker = new google.maps.Marker({
				position: myLatLng,
				map: map,
				title: ''
			});
			
			var cityCircle = new google.maps.Circle({
			      strokeColor: '#FF0000',
			      strokeOpacity: 0.5,
			      strokeWeight: 2,
			      fillColor: '#FF8700',
			      fillOpacity: 0.2,
			      map: map,
			      center: myLatLng,
			      radius: 800
		    });
			
			marker.setMap(map);
			
			g_markers.push(marker);
			g_markers.push(cityCircle);
			
			$("#selectPOI").html(
				"<option value='0'>請選擇POI</option>"+
				"<option value='6'>餐廳</option>"+
				"<option value='1'>ATM</option>"+
				"<option value='8'>百貨公司</option>"+
				"<option value='10'>捷運站</option>"+
				"<option value='11'>豬排店</option>"+
				"<option value='12'>勝博殿</option>"+
				"<option value='3'>加油站</option>"+
				"<option value='4'>速食店</option>"+
				"<option value='5'>全聯</option>"+
				"<option value='7'>量販店</option>"+
				"<option value='9'>便利商店</option>"+
				"<option value='2'>停車場</option>"
			);
	    }
	    
	    function deleteMarker() {
	    	console.log("deleteMarker");

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