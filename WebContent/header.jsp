<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
</head>
<body>
<div class="page-wrapper">
	<div class="header">
		<div class="userinfo">
			<p>使用者<span><%= (request.getSession().getAttribute("user_name")==null)?"Guest?":request.getSession().getAttribute("user_name").toString() %></span></p>
			<a href="#" id="logout" class="btn-logout">登出</a>
		</div>
	</div><!-- /.header -->
	
	<jsp:include page="menu.jsp"></jsp:include>