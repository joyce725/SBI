<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>智能雲端市場定位系統</title>
<link rel="Shortcut Icon" type="image/x-icon" href="./images/cdri-logo.gif" />
<link rel="stylesheet" href="css/jquery-ui.min.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="cssPS/styles.css">
<script src="js/jquery-1.12.4.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/scripts.js"></script>
<script>
$(function() {
	$("#logout").click(function(e) {
		$.ajax({
			type : "POST",
			url : "login.do",
			data : {
				action : "logout"
			},
			success : function(result) {
				top.location.href = "login.jsp";
			}
		});
	});
});
</script>