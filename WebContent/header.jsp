<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
String menu = (String) request.getSession().getAttribute("menu"); 
String privilege = (String) request.getSession().getAttribute("privilege"); 
%>
</head>
<body>
<input type="hidden" id="glb_menu" value='<%= menu %>' />
<input type="hidden" id="glb_privilege" value="<%= privilege %>" />

<div id="msgAlert"></div>

<div class="page-wrapper">
	<div class="header">
		<div class="userinfo">
			<p>使用者<span><%= (request.getSession().getAttribute("user_name")==null)?"Guest?":request.getSession().getAttribute("user_name").toString() %></span></p>
			<a href="#" id="logout" class="btn-logout">登出</a>
		</div>
	</div><!-- /.header -->
	
	<jsp:include page="menu.jsp"></jsp:include>