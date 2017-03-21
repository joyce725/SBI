<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
	<title>SBI 登入</title>
	<link rel="stylesheet" href="css/styles.css">
	<link rel="Shortcut Icon" type="image/x-icon" href="./images/cdri-logo.gif" />
	<script src="js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript">
	
	<% session.setAttribute("user_id", "026ea277-9c14-11e6-922d-005056af760c"); %>
	<% session.setAttribute("group_id", "6ec1fbf4-6c9c-11e5-ab77-000c29c1d067"); %>
	<% session.setAttribute("user_name", "Avery"); %>
	<% session.setAttribute("role", 0); %>
	<% session.setAttribute("privilege", "1,2,3,4,5,28,29,30,31,32,27,24,22,57,23,7,6,25,11,10,17,9,33,34,35,36,37,38,39,40,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,59,61,63,12,13,14,15,16,18,19,20,21,76"); %>
	<% session.setAttribute("menu","[{\"id\":\"5\",\"menuName\":\"商圈情報網\",\"url\":\"\",\"seqNo\":\"1\",\"parentId\":\"0\",\"photoPath\":\"images/sidenav-store.svg\",\"subMenu\":[{\"id\":\"28\",\"menuName\":\"商圈資訊\",\"url\":\"realMap.jsp\",\"seqNo\":\"1\",\"parentId\":\"5\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"29\",\"menuName\":\"商圈 POI\",\"url\":\"POI.jsp\",\"seqNo\":\"2\",\"parentId\":\"5\",\"photoPath\":\"\",\"subMenu\":[]}]},{\"id\":\"4\",\"menuName\":\"市場商情分析\",\"url\":\"\",\"seqNo\":\"2\",\"parentId\":\"0\",\"photoPath\":\"images/sidenav-analytic.svg\",\"subMenu\":[{\"id\":\"30\",\"menuName\":\"中國商情電子書\",\"url\":\"\",\"seqNo\":\"1\",\"parentId\":\"4\",\"photoPath\":\"\",\"subMenu\":[{\"id\":\"33\",\"menuName\":\"天津市\",\"url\":\"http://61.218.8.51/SBI/pdf/天津市.pdf\",\"seqNo\":\"1\",\"parentId\":\"30\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"34\",\"menuName\":\"瀋陽市\",\"url\":\"http://61.218.8.51/SBI/pdf/瀋陽市.pdf\",\"seqNo\":\"2\",\"parentId\":\"30\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"35\",\"menuName\":\"煙臺市\",\"url\":\"http://61.218.8.51/SBI/pdf/煙臺市.pdf\",\"seqNo\":\"3\",\"parentId\":\"30\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"36\",\"menuName\":\"成都市\",\"url\":\"http://61.218.8.51/SBI/pdf/成都市.pdf\",\"seqNo\":\"4\",\"parentId\":\"30\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"37\",\"menuName\":\"重慶市\",\"url\":\"http://61.218.8.51/SBI/pdf/重慶市.pdf\",\"seqNo\":\"5\",\"parentId\":\"30\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"38\",\"menuName\":\"武漢市\",\"url\":\"http://61.218.8.51/SBI/pdf/武漢市.pdf\",\"seqNo\":\"6\",\"parentId\":\"30\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"39\",\"menuName\":\"鄭州市\",\"url\":\"http://61.218.8.51/SBI/pdf/鄭州市.pdf\",\"seqNo\":\"7\",\"parentId\":\"30\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"40\",\"menuName\":\"西安市\",\"url\":\"http://61.218.8.51/SBI/pdf/西安市.pdf\",\"seqNo\":\"8\",\"parentId\":\"30\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"41\",\"menuName\":\"青島市\",\"url\":\"http://61.218.8.51/SBI/pdf/青島市.pdf\",\"seqNo\":\"9\",\"parentId\":\"30\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"42\",\"menuName\":\"唐山市\",\"url\":\"http://61.218.8.51/SBI/pdf/唐山市.pdf\",\"seqNo\":\"10\",\"parentId\":\"30\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"43\",\"menuName\":\"濟南市\",\"url\":\"http://61.218.8.51/SBI/pdf/濟南市.pdf\",\"seqNo\":\"11\",\"parentId\":\"30\",\"photoPath\":\"\",\"subMenu\":[]}]},{\"id\":\"31\",\"menuName\":\"台灣商情電子書\",\"url\":\"\",\"seqNo\":\"2\",\"parentId\":\"4\",\"photoPath\":\"\",\"subMenu\":[{\"id\":\"44\",\"menuName\":\"大台北\",\"url\":\"http://61.218.8.51/SBI/pdf/大台北.pdf\",\"seqNo\":\"1\",\"parentId\":\"31\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"45\",\"menuName\":\"桃園\",\"url\":\"http://61.218.8.51/SBI/pdf/桃園.pdf\",\"seqNo\":\"2\",\"parentId\":\"31\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"46\",\"menuName\":\"台中\",\"url\":\"http://61.218.8.51/SBI/pdf/台中.pdf\",\"seqNo\":\"3\",\"parentId\":\"31\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"47\",\"menuName\":\"台南\",\"url\":\"http://61.218.8.51/SBI/pdf/台南.pdf\",\"seqNo\":\"4\",\"parentId\":\"31\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"48\",\"menuName\":\"高雄\",\"url\":\"http://61.218.8.51/SBI/pdf/高雄.pdf\",\"seqNo\":\"5\",\"parentId\":\"31\",\"photoPath\":\"\",\"subMenu\":[]}]},{\"id\":\"32\",\"menuName\":\"東南亞商情電子書\",\"url\":\"\",\"seqNo\":\"3\",\"parentId\":\"4\",\"photoPath\":\"\",\"subMenu\":[{\"id\":\"49\",\"menuName\":\"雅加達\",\"url\":\"http://61.218.8.51/SBI/pdf/雅加達.pdf\",\"seqNo\":\"1\",\"parentId\":\"32\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"50\",\"menuName\":\"馬尼拉\",\"url\":\"http://61.218.8.51/SBI/pdf/馬尼拉.pdf\",\"seqNo\":\"2\",\"parentId\":\"32\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"51\",\"menuName\":\"新加坡\",\"url\":\"http://61.218.8.51/SBI/pdf/新加坡.pdf\",\"seqNo\":\"3\",\"parentId\":\"32\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"52\",\"menuName\":\"吉隆坡\",\"url\":\"http://61.218.8.51/SBI/pdf/吉隆坡.pdf\",\"seqNo\":\"4\",\"parentId\":\"32\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"76\",\"menuName\":\"新山\",\"url\":\"新山商圈.pdf\",\"seqNo\":\"5\",\"parentId\":\"32\",\"photoPath\":\"\",\"subMenu\":[]}]},{\"id\":\"27\",\"menuName\":\"動態統計\",\"url\":\"\",\"seqNo\":\"4\",\"parentId\":\"4\",\"photoPath\":\"\",\"subMenu\":[{\"id\":\"53\",\"menuName\":\"國家\",\"url\":\"country.jsp\",\"seqNo\":\"1\",\"parentId\":\"27\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"54\",\"menuName\":\"城市\",\"url\":\"city.jsp\",\"seqNo\":\"2\",\"parentId\":\"27\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"55\",\"menuName\":\"目標產業\",\"url\":\"industry.jsp\",\"seqNo\":\"3\",\"parentId\":\"27\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"56\",\"menuName\":\"中國主要城巿消費力\",\"url\":\"consumer.jsp\",\"seqNo\":\"4\",\"parentId\":\"27\",\"photoPath\":\"\",\"subMenu\":[]}]},{\"id\":\"24\",\"menuName\":\"生活費用\",\"url\":\"costLiving.jsp\",\"seqNo\":\"5\",\"parentId\":\"4\",\"photoPath\":\"\",\"subMenu\":[]}]},{\"id\":\"3\",\"menuName\":\"統計資料\",\"url\":\"\",\"seqNo\":\"3\",\"parentId\":\"0\",\"photoPath\":\"images/sidenav-stastic.svg\",\"subMenu\":[{\"id\":\"22\",\"menuName\":\"台灣人口社經\",\"url\":\"population.jsp\",\"seqNo\":\"1\",\"parentId\":\"3\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"57\",\"menuName\":\"台灣人口社經資料\",\"url\":\"populationNew.jsp\",\"seqNo\":\"2\",\"parentId\":\"3\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"23\",\"menuName\":\"產業分析基礎資料庫\",\"url\":\"upload.jsp\",\"seqNo\":\"3\",\"parentId\":\"3\",\"photoPath\":\"\",\"subMenu\":[]}]},{\"id\":\"2\",\"menuName\":\"決策工具\",\"url\":\"\",\"seqNo\":\"4\",\"parentId\":\"0\",\"photoPath\":\"images/sidenav-strategy.svg\",\"subMenu\":[{\"id\":\"7\",\"menuName\":\"目標客群定位\",\"url\":\"personaNew.jsp\",\"seqNo\":\"1\",\"parentId\":\"2\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"6\",\"menuName\":\"空間決策\",\"url\":\"\",\"seqNo\":\"2\",\"parentId\":\"2\",\"photoPath\":\"\",\"subMenu\":[{\"id\":\"58\",\"menuName\":\"目標市場決策管理\",\"url\":\"case.jsp\",\"seqNo\":\"1\",\"parentId\":\"6\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"59\",\"menuName\":\"目標市場決策評估\",\"url\":\"evaluate.jsp\",\"seqNo\":\"2\",\"parentId\":\"6\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"60\",\"menuName\":\"競爭力決策管理\",\"url\":\"caseCompetition.jsp\",\"seqNo\":\"3\",\"parentId\":\"6\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"61\",\"menuName\":\"競爭力決策評估\",\"url\":\"caseCompetitionEvaluation.jsp\",\"seqNo\":\"4\",\"parentId\":\"6\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"62\",\"menuName\":\"通路決策管理\",\"url\":\"caseChannel.jsp\",\"seqNo\":\"5\",\"parentId\":\"6\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"63\",\"menuName\":\"通路決策評估\",\"url\":\"caseChannelEvaluation.jsp\",\"seqNo\":\"6\",\"parentId\":\"6\",\"photoPath\":\"\",\"subMenu\":[]}]},{\"id\":\"25\",\"menuName\":\"區位選擇\",\"url\":\"regionSelect.jsp\",\"seqNo\":\"3\",\"parentId\":\"2\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"11\",\"menuName\":\"新創公司財務損益平衡評估\",\"url\":\"finModel.jsp\",\"seqNo\":\"4\",\"parentId\":\"2\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"10\",\"menuName\":\"新產品風向評估\",\"url\":\"productForecast.jsp\",\"seqNo\":\"5\",\"parentId\":\"2\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"17\",\"menuName\":\"授權商品檢索機制\",\"url\":\"\",\"seqNo\":\"6\",\"parentId\":\"2\",\"photoPath\":\"\",\"subMenu\":[{\"id\":\"12\",\"menuName\":\"商品管理\",\"url\":\"product.jsp\",\"seqNo\":\"1\",\"parentId\":\"17\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"13\",\"menuName\":\"通路商管理\",\"url\":\"agent.jsp\",\"seqNo\":\"2\",\"parentId\":\"17\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"14\",\"menuName\":\"通路商授權商品管理\",\"url\":\"agentAuth.jsp\",\"seqNo\":\"3\",\"parentId\":\"17\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"15\",\"menuName\":\"服務識別碼指定通路商作業\",\"url\":\"serviceAgentAssign.jsp\",\"seqNo\":\"4\",\"parentId\":\"17\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"16\",\"menuName\":\"商品真偽顧客驗證作業\",\"url\":\"productVerify.jsp\",\"seqNo\":\"5\",\"parentId\":\"17\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"18\",\"menuName\":\"商品真偽通路商驗證作業\",\"url\":\"authVerify.jsp\",\"seqNo\":\"6\",\"parentId\":\"17\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"19\",\"menuName\":\"服務識別碼查詢作業\",\"url\":\"serviceVerify.jsp\",\"seqNo\":\"7\",\"parentId\":\"17\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"20\",\"menuName\":\"商品售後服務註冊\",\"url\":\"serviceRegister.jsp\",\"seqNo\":\"8\",\"parentId\":\"17\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"21\",\"menuName\":\"服務識別碼資訊服務作業\",\"url\":\"serviceQuery.jsp\",\"seqNo\":\"9\",\"parentId\":\"17\",\"photoPath\":\"\",\"subMenu\":[]}]},{\"id\":\"9\",\"menuName\":\"城市定位\",\"url\":\"persona.jsp\",\"seqNo\":\"7\",\"parentId\":\"2\",\"photoPath\":\"\",\"subMenu\":[]}]},{\"id\":\"1\",\"menuName\":\"國家/城巿商圈\",\"url\":\"marketPlace.jsp\",\"seqNo\":\"5\",\"parentId\":\"0\",\"photoPath\":\"images/sidenav-country.svg\",\"subMenu\":[]},{\"id\":\"73\",\"menuName\":\"後台支援系統\",\"url\":\"\",\"seqNo\":\"6\",\"parentId\":\"0\",\"photoPath\":\"images/sidenav-support.svg\",\"subMenu\":[{\"id\":\"74\",\"menuName\":\"公司人員維護\",\"url\":\"groupBackstage.jsp\",\"seqNo\":\"1\",\"parentId\":\"73\",\"photoPath\":\"\",\"subMenu\":[]},{\"id\":\"75\",\"menuName\":\"商機觀測站維護\",\"url\":\"uploaddocsManager.jsp\",\"seqNo\":\"2\",\"parentId\":\"73\",\"photoPath\":\"\",\"subMenu\":[]}]}]"); %>

	<%if(request.getSession().getAttribute("user_name")!=null){%>
		top.location.href="scenarioJob.jsp";
	<%}%>
		
	    function changeImg(){
	        document.getElementById("validateCodeImg").src="HandleDrawValidateCode.do?t=" + Math.random();
	    }
	
	    function to_login(){
	    	$(".error").removeClass("error");
	    	$(".error-msg").remove();
	    	var wrong = 0;
	
	    	if($("#group_name").val().length<1){
	    		$("#group_name").after("<span class='error-msg'>請選擇公司</span>");
	    		wrong=1;
	    	}

	    	if($("#user_name").val().length<1){
	    		$("#user_name").after("<span class='error-msg'>請輸入帳號</span>");
	    		wrong=1;
	    	}
	    	
	    	if($("#pswd").val().length<1){
	    		$("#pswd").after("<span class='error-msg'>請輸入密碼</span>");
	    		wrong=1;
	    	}
	    	
	    	if($("#validateCode").val().length<1){
	    		$("#validateCode").after("<span class='error-msg'>請輸入驗證碼</span>");
	    		wrong=1;
	    	}

	    	if(wrong == 0){
	    		$.ajax({
		    		type : "POST",
					url : "login.do",
					cache : false,
					data : {
						action : "login",
						group_id : $("select[name='group_name']").val(),
	                	user_name : $("#user_name").val(),
						pswd : $("#pswd").val(),
						validateCode : $("#validateCode").val()
	                },
	                success: function(data) {
	                	var json_obj = $.parseJSON(data);
	                	if (json_obj.message=="success"){
	                		window.location.href = "news.jsp";
	                	}
	                	if (json_obj.message=="failure"){
	                		$("#validateCode").val("");
	                		$("#pswd").val("");
	            			$("#pswd").focus();
	    					$("#pswd").after("<span class='error-msg'>密碼錯誤</span>");
	                		changeImg();
	                	}
	                	if (json_obj.message=="code_failure") {
	                		$("#validateCode").val("");
	    					$("#pswd").val("");
	            			$("#validateCode").focus();
	    					$("#validateCode").after("<span class='error-msg'>驗證碼錯誤</span>");
	                	}
	                	if (json_obj.message=="user_failure"){
	                		$("#username").after("<span id='user_err_mes' class='error-msg'>查無此帳號</span>");
	                		changeImg();
	                		wrong=1;
	                	}
	                }
	            });
	    	}
	    }
	    
		$(function() {
			$("#validateCodeImg").click(function() {
				changeImg();
			});
			
			$.ajax({
				type : "POST",
				url : "Group.do",
				data : {
					action : "getGroupAll"
				},
				success : function(result) {
					var json_obj = $.parseJSON(result);
									
					$.each(json_obj, function(i, item) {
						$("[name^=group_name]").append($('<option></option>').val(json_obj[i].group_id).html(json_obj[i].group_name));	
					});
				},
				error:function(e){
// 					console.log('btn1 click error');
				}
			});
	
			$("#user_name").focus();
			$("#user_name").blur(function(){
		    	$(".error").removeClass("error");
		    	$(".error-msg").remove();
		    	
				$.ajax({
	                url : "login.do",
	                type : "POST",
	                cache : false,
	                delay : 1500,
	                data : {
	                	action : "check_user_exist",
	                	group_id : $("select[name='group_name']").val(),
	                	user_name : $("input[name='user_name']").val()
	                },
	                success: function(data) {
	                	var json_obj = $.parseJSON(data);
	                	if (json_obj.message=="user_failure"){
	                		if($("#user_name").val().length >0){
	        					$("#user_name").after("<span class='error-msg'>查無此帳號</span>");
	                		}
	                		
	                		if($("#user_name").val().length ==0){
	                			if($("#user_err_mes").length){
	                    			$("#user_err_mes").remove();
	                			}
	                		}
	                	} else if (json_obj.message=="success") {
	               			if($("#user_err_mes").length){
	                   			$("#user_err_mes").remove();
	               			}                		
	                	}
	                }
	            });
			});
			
			$('#user_name').keypress(function() {
				if($("#user_err_mes").length){
					$("#user_err_mes").remove();
				}
			});
	
			$("#login_btn").click(function(){
				to_login();
		 	});
	
			$("input").keydown(function (event) {
		        if (event.which == 13) {
		        	to_login();
		        }
		    }); 
	
			$("#reset_btn").click(function(){
				$(".error").removeClass("error");
				$(".error-msg").remove();
				$("#group_name").val("");
				$("#user_name").val("");
				$("#pswd").val("");
				$("#validateCode").val("");
				changeImg();
			});
		});
	</script>
</head>
<body class="login-body">
	<div class="login-wrapper">

		<div class="login-panel-wrap">
		<div class="login-panel">
			<h1 class="sys-logo">SBI</h1>
			<h2>使用者登入</h2>
			<form id="login-form-post">
				<label for="uninumber">
					<span class="block-label">公司</span>
					<select id="group_name" name="group_name"></select>
				</label>
				<label for="username">
					<span class="block-label">帳號</span>
					<input type="text" id="user_name" name="user_name">
				</label>
				<label for="pswd">
					<span class="block-label">密碼</span>
					<input type="password" id="pswd" name="pswd">
				</label>
				<div class="verify-wrap">
					<label for="validateCode">
						<span class="block-label">認證碼</span>
						<input type="text" id="validateCode" name="validateCode">
					</label>
					<div class="captcha-wrap">
						<img title="點選圖片可重新產生驗證碼" src="HandleDrawValidateCode.do" id="validateCodeImg">
					</div>
				</div><!-- /.verify-wrap -->
				<div class="login-btn-wrap">
					<a href="#" class="login-button" id="login_btn">登入</a>
					<a href="#" class="login-reset-button" id="reset_btn">清除重填</a>					
				</div><!-- /.login-btn-wrap -->
			</form>
		</div><!-- /.login-panel -->
		</div><!-- /.login-panel-wrap -->

		<div class="login-footer">
			<p>委辦單位：<a href="http://www.moea.gov.tw/Mns/doit/home/Home1.aspx" target="_blank"><img src="images/經濟部技術處logo.jpg" style="width: 8.5%">經濟部技術處</a>&nbsp;&nbsp;執行單位：<a href="http://www.cdri.org.tw/MainPage.aspx?func=884C5749-91C8-4730-9941-794" target="_blank"><img src="images/商研院LOGO.jpg" style="width: 7%">財團法人商業發展研究院</a></p>
            <p>Copyright © Commerce Development Research Institute <strong>財團法人商業發展研究院</strong>登載的內容係屬本院版權所有</p>
            <p>10665臺北市復興南路一段303號4樓&nbsp;&nbsp;&nbsp;電話：02-7713-1010&nbsp;&nbsp;&nbsp;傳真：02-7713-3366</p>
            <p>請使用IE8以上版本&nbsp;&nbsp;&nbsp;最佳瀏覽解析度<!-- start: 2013 correcting -->1280×1024<!-- end: 2013 correcting --></p>

<!-- 			北祥股份有限公司 <span>服務電話：+886-2-2658-1910 | 傳真：+886-2-2658-1920</span> -->
		</div><!-- /.login-footer -->

	</div><!-- /.login-wrapper -->
</body>
</html>