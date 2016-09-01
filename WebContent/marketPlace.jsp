<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>服務業雲端智慧商情支援系統</title>
<link rel="Shortcut Icon" type="image/x-icon" href="./images/cdri-logo.gif" />
<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
</head>
<body>
<%-- 	<jsp:include page="template-old.jsp" flush="true"/> --%>
	<div class="content-wrap">
		<iframe id="ifm1" src="\/marketplace\/MarketPlaceX_MiscCtrl"></iframe>
<!-- 		<object type="text/html" width="100%" height="100%" id="page1" data="\/marketplace\/MarketPlaceX_MiscCtrl" ></object> -->
	</div>
<script>
	$(function() {

		$( document ).ready(function() {
			
			$("#ifm1").load(function() {
				$(this).height( $(this).contents().find("body").height() );
		  		$(this).width( $(this).contents().find("body").width() );
			}); 
			
			$.ajax({
				type : "POST",
				url : "\/marketplace\/AdminLoginCtrl",
				data : {
					Action : "Api_Login",
					Key : "AABBCC",
					
<%-- 					UserId : "<%=user_name%>", --%>
<%-- 					Password : "<%=pwd%>" --%>
					
					UserId : "cdri",
					Password : "c666d37a6d83059d1d2ad25b420fe7e7" //c666d37a6d83059d1d2ad25b420fe7e7, cdri
				},
				success : function(result) {
// 					console.log("marketPlace success");
// 					console.log(result);
// 					document.getElementById("page1").setAttribute('data', "\/marketplace\/MarketPlaceX_MiscCtrl?Action=Home&F=1&PageType=1B");
					
					var $iframe = $('#ifm1');
// 					console.log("$iframe.length:" + $iframe.length);
				    if ( $iframe.length > 0 ) {
// 				    	console.log("set src");
				        $iframe.attr('src', "\/marketplace\/MarketPlaceX_MiscCtrl?Action=Home&F=1&PageType=1B");   
// 				        console.log("set src complete");
				    }
				},
				error : function(result) {
					
				}
			});
		});
	});
</script>
</body>
</html>