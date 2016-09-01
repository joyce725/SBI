<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>東南亞商機定位工具</title>
<link rel="Shortcut Icon" type="image/x-icon" href="./images/cdri-logo.gif" />
<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
</head>
<body>
<%-- 	<jsp:include page="template.jsp" flush="true"/> --%>
	<div class="content-wrap">
		<iframe id="ifm1" src="\/persona\/Persona_ProductAdminCtrl"></iframe>
<!-- 		<object type="text/html" width="100%" height="100%" id="page1" data="\/persona\/Persona_ProductAdminCtrl"></object> -->
	</div>
<script>
	$(function() {

		$( document ).ready(function() {

			$("#ifm1").load(function() {
				$(this).height( $(this).contents().find("body").height() - 190 );
				$(this).width( $(this).contents().find("body").width() );
			}); 
			
			$.ajax({
				type : "POST",
				url : "\/persona\/AdminLoginCtrl",
				data : {
					Action : "Api_Login",
					Key : "A7BBMK3",
					
<%-- 					UserId : "<%=user_name%>", --%>
<%-- 					Password : "<%=pwd%>" --%>
					
					UserId : "admin1",
					GroupId  : "group1",
					Password : "caf1a3dfb505ffed0d024130f58c5cfa"
				},
				success : function(result) {
// 					console.log("persona success");
// 					console.log(result);
					//document.getElementById("page1").setAttribute('data', "\/persona\/Persona_ProductAdminCtrl?Action=Page1BL");
// 					document.getElementById("page1").setAttribute('data', "\/marketplace\/MarketPlaceX_MiscCtrl?Action=Home&F=1&PageType=1B");
// 					var page1 = document.getElementById("page1");
// 					page1.data = "\/marketplace\/MarketPlaceX_MiscCtrl?Action=Home&F=1&PageType=1B";

					var $iframe = $('#ifm1');
// 					console.log("$iframe.length:" + $iframe.length);
				    if ( $iframe.length > 0 ) {
				        $iframe.attr('src', "\/persona\/Persona_OpportunityUser1Ctrl?Action=Page1BF");   
				    }
				    
// 					var page1 = document.querySelector("page1"); 
// 					page1.setAttribute("data", "\/persona\/Persona_OpportunityUser1Ctrl?Action=Page1BF");
				},
				error : function(result) {
					console.log('error');
				}
			});
		});
	});
</script>
</body>
</html>