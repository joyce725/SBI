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
    padding-bottom: 130px;
    height: 100%;
    overflow-y: scroll;
    width: 100%;
	background-color: #EEF3F9;
}
.search-result-wrap{
	padding: 20px;
	padding-left: 200px;
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
	width:240px;
	background:#eee url('./images/dropdown.svg') no-repeat 99% 2px;
}
.ben-table{
 	/*	border:1px solid #000;  */
	height:180px;
	margin: 10px 120px;
	width:70%;
}
.ben-table td:nth-child(2n+1){
	padding-right:12px;
	text-align:right;
	font-size:20px;
		font-weight:bold;
		width:160px;
}
.ben-table td{
	padding:12px;
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
	function myreset() {
		$('#selectSearchYear').val('');
		$('#selectSearchCity').val('');
		$('#selectSearchTown').html('<option value="">請先選擇縣市</option>');
		$('#selectSearchVillage').html('<option value="">請先選擇縣市/行政區</option>');
	
		$('[id^=selectSearchSex]').val('');
		$('[id^=selectSearchSchool]').val('');
		$('[id^=selectSearchAge]').val('');
		
		$('#selectSearchMarriage').val('');
	}
	
	function myconcate(){
		var url="http://61.218.8.51/population/";
		
		if($("#selectSearchYear").val() != '') {
			url+=$("#selectSearchYear").val();
		} else {
			alert("請選擇年份!!");
			return;
		}
		if($("#selectSearchCity").val() != '') {
			url+=$("#selectSearchCity").val();
		} else {
			alert("請選擇縣市!!");
			return;
		}
		if($("#selectSearchTown").val() != '') {
			url+=$("#selectSearchTown").val();
		}
		if($("#selectSearchVillage").val() != '') {
			url+=$("#selectSearchVillage").val();
		}
		
		url+=".htm";
		
		$.ajax({
			url: url,
			dataType: 'jsonp', 
			crossDomain: true,
			type: 'GET',
			timeout: 1000,
			complete: function(response) {
				if(response.status == 200) {
					window.open(url, "_blank", "", false);
				} else {
					alert("此查詢條件無資料!!!");
				}
			}
		});
	}
	
	function searchPopulation(x) {
	    var htmlStr = "http://61.218.8.51/population/";
	    if ($('#selectSearchYear').val() == "") {
	        alert("請選擇年");
	        $('#selectSearchYear').focus();
	    } else {
	        if (x == 1) {
	            //if ($('#selectSearchYear').val() == "106") {
	            //    alert("此搜尋條件尚無104年資料，請更改搜尋日期");
	            //    $('#selectSearchYear').focus();
	            //    return;
	            //} else 
	           	if ($('#selectSearchSex1').val() == "") {
	                alert("請選擇性別");
	                $('#selectSearchSex1').focus();
	                return;
	            } else if ($('#selectSearchSchool1').val() == "") {
	                alert("請選擇學歷");
	                $('#selectSearchSchool1').focus();
	                return;
	            } else {
	                htmlStr += "sex_edu/" + $('#selectSearchYear').val();
	                htmlStr += ($('#selectSearchSex1').val() == "MF") ? "" : $('#selectSearchSex1').val();
	                htmlStr += "_" + $('#selectSearchSchool1').val() + ".htm";
	            }
	        } else if (x == 2) {
	           if ($('#selectSearchSex2').val() == "") {
	                alert("請選擇性別");
	                $('#selectSearchSex2').focus();
	                return;
	           } else if ($('#selectSearchAge2').val() == "") {
	               alert("請選擇年齡層");
	               $('#selectSearchAge2').focus();
	               return;
	           } else {
	               htmlStr += "sex_age/" + $('#selectSearchYear').val();
	               htmlStr += ($('#selectSearchSex2').val() == "MF") ? "" : $('#selectSearchSex2').val();
	               htmlStr += "_" + $('#selectSearchAge2').val() + ".htm";
	            }
	        } else if (x == 3) {
	            //if ($('#selectSearchYear').val() == "104") {
	            //    alert("此搜尋條件尚無104年資料，請更改搜尋日期");
	            //    $('#selectSearchYear').focus();
	            //    return;
	            //} else 
	       		if ($('#selectSearchSex3').val() == "") {
	                alert("請選擇性別");
	                $('#selectSearchSex3').focus();
	                return;
	            } else if ($('#selectSearchAge3').val() == "") {
	                alert("請選擇年齡層");
	                $('#selectSearchAge3').focus();
	                return;
	            } else if ($('#selectSearchSchool3').val() == "") {
	                alert("請選擇學歷");
	                $('#selectSearchSchool3').focus();
	                return;
	            } else {
	                switch ($('#selectSearchAge3').val()) {
	                    case "0_4":
	                    case "5_9":
	                    case "10_14":
	                        alert("選擇之年齡層尚無學歷資料，將顯示不包含學歷之資料");
	                        $('#selectSearchSchool3').val("");
	                        $('#selectSearchSchool3').enabled(false);
	                        htmlStr += "sex_age/" + $('#selectSearchYear').val();
	                        htmlStr += ($('#selectSearchSex3').val() == "MF") ? "" : $('#selectSearchSex3').val();
	                        htmlStr += "_" + $('#selectSearchAge3').val() + ".htm";
	                        break;
	                    case "65_69":
	                    case "70_74":
	                    case "75_79":
	                    case "80_84":
	                    case "85_89":
	                    case "90_94":
	                    case "95_99":
	                    case "100":
	                        htmlStr += "sex_age_edu/" + $('#selectSearchYear').val();
	                        htmlStr += ($('#selectSearchSex3').val() == "MF") ? "" : $('#selectSearchSex3').val();
	                        htmlStr += "_65_" + $('#selectSearchSchool3').val() + ".htm";
	                        break;
	                    default:
	                        htmlStr += "sex_age_edu/" + $('#selectSearchYear').val();
	                        htmlStr += ($('#selectSearchSex3').val() == "MF") ? "" : $('#selectSearchSex3').val();
	                        htmlStr += "_" + $('#selectSearchAge3').val() + "_" + $('#selectSearchSchool3').val() + ".htm";
	                        break;
	                }
	            }
	        } else if (x == 4) {
	            //if ($('#selectSearchYear').val() == "104") {
	            //    alert("此搜尋條件尚無104年資料，請更改搜尋日期");
	            //    $('#selectSearchYear').focus();
	            //    return;
	            //} else 
	           	if ($('#selectSearchSex4').val() == "") {
	                alert("請選擇性別");
	                $('#selectSearchSex4').focus();
	                return;
	            } else if ($('#selectSearchMarriage').val() == "") {
	                alert("請選擇婚姻狀況");
	                $('#selectSearchMarriage').focus();
	                return;
	            } else {
	                htmlStr += "sex_marriage/" + $('#selectSearchYear').val();
	                htmlStr += ($('#selectSearchSex4').val() == "MF") ? "" : $('#selectSearchSex4').val();
	                htmlStr += "_" + $('#selectSearchMarriage').val() + ".htm";
	            }
	        }
	        
	        $.ajax({
				url: htmlStr,
				dataType: 'jsonp', 
				crossDomain: true,
				type: 'GET',
				timeout: 1000,
				complete: function(response) {
					if(response.status == 200) {
						window.open(htmlStr, "_blank", "", false);
					} else {
						alert("此查詢條件無資料!!!");
					}
				}
			});
	    }
	}

	$(function(){
		
		$.ajax({
			type : "POST",
			url : "populationNew.do",
			data : {
				action : "search_county",
			},
			success : function(result) {
				var result_html="<option value=''>請選擇縣市</option>";
				var json_obj = $.parseJSON(result);
				if(json_obj.result.length>0){
					$.each(json_obj.result,function(i, item) {
						result_html+="<option value='"+json_obj.result_id[i]+"'>"+json_obj.result[i]+"</option>";
					});
				}
				$("#selectSearchCity").html(result_html);
			}
		});
		
		$("#selectSearchCity").change(function(){
			var county_id = $(this).val();
			$.ajax({
				type : "POST",
				url : "populationNew.do",
				data : {
					action : "search_town",
					county :county_id
				},
				success : function(result) {
					var result_html="<option value=''>請選擇行政區</option>";
					var json_obj = $.parseJSON(result);
					if(json_obj.result.length>0){
						$.each(json_obj.result,function(i, item) {
							result_html+="<option value='"+json_obj.result_id[i]+"'>"+json_obj.result[i]+"</option>";
						});
					} else {
						result_html="<option value=''>請先選擇縣市</option>";
					}
					$("#selectSearchTown").html(result_html);
				}
			});
		});
		
		$("#selectSearchTown").change(function(){
			var town_id = $(this).val();
			$.ajax({
				type : "POST",
				url : "populationNew.do",
				data : {
					action : "search_village",
					town : town_id
				},
				success : function(result) {
					var result_html="<option value=''>請選擇鄉里</option>";
					var json_obj = $.parseJSON(result);
					if(json_obj.result.length>0){
						$.each(json_obj.result,function(i, item) {
							result_html+="<option value='"+json_obj.result_id[i]+"'>"+json_obj.result[i]+"</option>";
						});
					} else {
						result_html="<option value=''>請先選擇縣市/行政區</option>";
					}
					$("#selectSearchVillage").html(result_html);
				}
			});
		});
		
	    var _showTab = 0;
		var $defaultLi = $('ul.tabs li').eq(_showTab).addClass('active');
		
		$($defaultLi.find('a').attr('href')).siblings().hide();
		
		// 當 li 頁籤被點擊時...
		// 若要改成滑鼠移到 li 頁籤就切換時, 把 click 改成 mouseover
		$('ul.tabs li').click(function() {
			//reset all selections
			myreset();
			
			var $this = $(this),
				_clickTab = $this.find('a').attr('href');
			$this.addClass('active').siblings('.active').removeClass('active');
			$(_clickTab).stop(false, true).fadeIn().siblings().hide();

			return false;
		}).find('a').focus(function(){
			this.blur();
		});
		
		$("body").keydown(function (event) {
			if (event.which == 13) {
				$("#send").trigger("click");
			}
		}); 
	});
</script>
<!-- /**************************************  以上使用者JS區塊    *********************************************/	-->

<jsp:include page="header.jsp" flush="true"/>
<div class="content-wrap">
<h2 class="page-title">台灣人口社會經濟資料</h2>
	<div class="search-result-wrap">
		<div style='margin:20px;width:920px;'>
			<h4>搜尋條件</h4>
			民國：
			<select id='selectSearchYear'>
			  <option value="">請選擇</option>
              <option value="101">101</option>
              <option value="102">102</option>
              <option value="103">103</option>
              <option value="104">104</option>
			</select>
			<br><br>
			<ul class="tabs">
				<li><a href="#tab1">縣巿人口社經資料查詢</a></li>
				<li><a href="#tab2">人口結構分析查詢<br>-教育程度-</a></li>
				<li><a href="#tab3">人口結構分析查詢<br>-年齡層-</a></li>
				<li><a href="#tab4">人口結構分析查詢<br>-各年齡及學歷-</a></li>
				<li><a href="#tab5">人口結構分析查詢<br>-婚姻狀況-</a></li>
			</ul>
			<div class="tab_container">
				<div id="tab1" class="tab_content">
					<table class='ben-table'>
						<tr>
							<td>
								縣市：
							</td>
							<td>
								<select id="selectSearchCity"><option value="">請選擇縣市</option></select>
							</td>
							<td rowspan='3'>
								<a class='btn btn-darkblue' style='font-size:24px;font-weight:lighter; margin:10px;' onclick='myconcate()'>搜尋</a>
								<a class='btn btn-darkblue' style='font-size:24px;font-weight:lighter; margin:10px;' onclick="myreset()">重設</a>
							</td>
						</tr>
						<tr>
							<td>
								行政區：</td><td><select id="selectSearchTown"><option value="">請先選擇縣市</option></select>
							</td>
						</tr>
						<tr>
							<td>
								鄉里：</td><td><select id="selectSearchVillage"><option value="">請先選擇縣市/行政區</option></select>
							</td>
						</tr>
					</table>
				</div>
				<div id="tab2" class="tab_content">
					<table class='ben-table'>
						<tr>
							<td>
								性別：
							</td>
							<td>
								<select id="selectSearchSex1">
	                                <option value="">請選擇</option>
	                                <option value="M">男</option>
	                                <option value="F">女</option>
	                                <option value="MF">不限</option>
	                            </select>
							</td>
							<td rowspan='2'>
								<a class='btn btn-darkblue' style='font-size:24px;font-weight:lighter; margin:10px;' onclick="searchPopulation(1)">搜尋</a>
								<a class='btn btn-darkblue' style='font-size:24px;font-weight:lighter; margin:10px;' onclick="myreset()">重設</a>
							</td>
						</tr>
						<tr>
							<td>
								學歷：
							</td>
							<td>
								<select id="selectSearchSchool1">
	                                <option value="">請選擇</option>
	                                <option value="phd">博士</option>
	                                <option value="master">碩士</option>
	                                <option value="university">大學</option>
	                                <option value="college">專科</option>
	                                <option value="senior">高中</option>
	                                <option value="junior">國中</option>
	                                <option value="primary">國小</option>
	                                <option value="self">自學</option>
	                                <option value="no">不識字</option>
	                            </select>
							</td>
						</tr>
					</table>
				</div>
				<div id="tab3" class="tab_content">
					<table class='ben-table'>
						<tr>
							<td>
								性別：
							</td>
							<td>
								<select id="selectSearchSex2">
	                                <option value="">請選擇</option>
	                                <option value="M">男</option>
	                                <option value="F">女</option>
	                                <option value="MF">不限</option>
	                            </select>
							</td>
							<td rowspan='2'>
								<a class='btn btn-darkblue' style='font-size:24px;font-weight:lighter; margin:10px;' onclick="searchPopulation(2)">搜尋</a>
								<a class='btn btn-darkblue' style='font-size:24px;font-weight:lighter; margin:10px;' onclick="myreset()">重設</a>
							</td>
						</tr>
						<tr>
							<td>
								年齡層：
							</td>
							<td>
								<select id="selectSearchAge2">
                                    <option value="">請選擇</option>
                                    <option value="0_4">0~4歲</option>
                                    <option value="5_9">5~9歲</option>
                                    <option value="10_14">10~14歲</option>
                                    <option value="15_19">15~19歲</option>
                                    <option value="20_24">20~24歲</option>
                                    <option value="25_29">25~29歲</option>
                                    <option value="30_34">30~34歲</option>
                                    <option value="35_39">35~39歲</option>
                                    <option value="40_44">40~44歲</option>
                                    <option value="45_49">45~49歲</option>
                                    <option value="50_54">50~54歲</option>
                                    <option value="55_59">55~59歲</option>
                                    <option value="60_64">60~64歲</option>
                                    <option value="65_69">65~69歲</option>
                                    <option value="70_74">70~74歲</option>
                                    <option value="75_79">75~79歲</option>
                                    <option value="80_84">80~84歲</option>
                                    <option value="85_89">85~89歲</option>
                                    <option value="90_94">90~94歲</option>
                                    <option value="95_99">95~99歲</option>
                                    <option value="100">100歲以上</option>
                                </select>
							</td>
						</tr>
					</table>
				</div>
				<div id="tab4" class="tab_content">
					<table class='ben-table'>
						<tr>
							<td>
								性別：
							</td>
							<td>
								<select id="selectSearchSex3">
                                    <option value="">請選擇</option>
                                    <option value="M">男</option>
                                    <option value="F">女</option>
                                    <option value="MF">不限</option>
                                </select>
							</td>
							<td rowspan='3'>
								<a class='btn btn-darkblue' style='font-size:24px;font-weight:lighter; margin:10px;' onclick="searchPopulation(3)">搜尋</a>
								<a class='btn btn-darkblue' style='font-size:24px;font-weight:lighter; margin:10px;' onclick="myreset()">重設</a>
							</td>
						</tr>
						<tr>
							<td>
								年齡層：
							</td>
							<td>
								<select id="selectSearchAge3">
                                    <option value="">請選擇</option>
                                    <option value="0_4">0~4歲</option>
                                    <option value="5_9">5~9歲</option>
                                    <option value="10_14">10~14歲</option>
                                    <option value="15_19">15~19歲</option>
                                    <option value="20_24">20~24歲</option>
                                    <option value="25_29">25~29歲</option>
                                    <option value="30_34">30~34歲</option>
                                    <option value="35_39">35~39歲</option>
                                    <option value="40_44">40~44歲</option>
                                    <option value="45_49">45~49歲</option>
                                    <option value="50_54">50~54歲</option>
                                    <option value="55_59">55~59歲</option>
                                    <option value="60_64">60~64歲</option>
                                    <option value="65_69">65~69歲</option>
                                    <option value="70_74">70~74歲</option>
                                    <option value="75_79">75~79歲</option>
                                    <option value="80_84">80~84歲</option>
                                    <option value="85_89">85~89歲</option>
                                    <option value="90_94">90~94歲</option>
                                    <option value="95_99">95~99歲</option>
                                    <option value="100">100歲以上</option>
                                </select>
							</td>
						</tr>
						<tr>
							<td>
								學歷：
							</td>
							<td>
								<select id="selectSearchSchool3">
                                    <option value="">請選擇</option>
                                    <option value="phd">博士</option>
                                    <option value="master">碩士</option>
                                    <option value="university">大學</option>
                                    <option value="college">專科</option>
                                    <option value="senior">高中</option>
                                    <option value="junior">國中</option>
                                    <option value="primary">國小</option>
                                    <option value="self">自學</option>
                                    <option value="no">不識字</option>
                                </select>
							</td>
						</tr>
					</table>
				</div>
				<div id="tab5" class="tab_content">
					<table class='ben-table'>
						<tr>
							<td>
								性別：
							</td>
							<td>
								<select id="selectSearchSex4">
	                                <option value="">請選擇</option>
	                                <option value="M">男</option>
	                                <option value="F">女</option>
	                                <option value="MF">不限</option>
	                            </select>
							</td>
							<td rowspan='2'>
								<a class='btn btn-darkblue' style='font-size:24px;font-weight:lighter; margin:10px;' onclick="searchPopulation(4)">搜尋</a>
								<a class='btn btn-darkblue' style='font-size:24px;font-weight:lighter; margin:10px;' onclick="myreset()">重設</a>
							</td>
						</tr>
						<tr>
							<td>
								婚姻狀況：
							</td>
							<td>
								<select id="selectSearchMarriage" name="searchMarriage" >
                                    <option value="">請選擇</option>
                                    <option value="unmarried">未婚</option>
                                    <option value="married">已婚</option>
                                    <option value="divorde">離婚</option>
                                    <option value="widowed">喪偶</option>
                                </select>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="footer.jsp" flush="true"/>