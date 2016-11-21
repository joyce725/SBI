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
	
	<ul class="topnav">
		<li class="dropdown">
			<a href="marketPlace.jsp">國家/城巿商圈</a>
		</li>
		<li class="dropdown">
			<a href="#" class="dropbtn">決策工具</a>
			<div class="dropdown-content">
				<a href="cloudISS.jsp">目標市場定位</a>
				<a href="cloudISS.jsp">目標客群定位</a>
				<a href="cloudISS.jsp">競爭者定位</a>
				<a href="cloudISS.jsp">商品通路</a>
				<a href="personaNew.jsp">城市定位</a>
<!-- 				<a href="productForecast.jsp">新產品風向評估</a> -->
<!-- 				<a href="finModel.jsp">新創公司財務損益平衡評估</a> -->
<!-- 				<a href="product.jsp">商品管理</a> -->
<!-- 				<a href="agent.jsp">通路商管理</a> -->
<!-- 				<a href="agentAuth.jsp">通路商授權商品管理</a> -->
<!-- 				<a href="productVerify.jsp">商品真偽顧客驗證作業</a> -->
<!-- 				<a href="authVerify.jsp">商品真偽通路商驗證作業</a> -->
			</div>
		</li>
		<li class="dropdown">
			<a href="#" class="dropbtn">統計資料</a>
			<div class="dropdown-content">
				<a href="population.jsp">台灣人口社經</a>
				<a href="populationNew.jsp">台灣人口社經(new)</a>
				<a href="upload.jsp">產業分析基礎資料庫</a>
			</div>
		</li>
		<li class="dropdown">
			<a href="#" class="dropbtn">市場商情分析</a>
			<div class="dropdown-content">
				<a href="cloudISS.jsp">生活費用</a>
				<a href="cloudISS.jsp">區位選擇</a>
				<a href="cloudISS.jsp">環域分析</a>
				<a href="cloudISS.jsp">動態統計</a>
			</div>
		</li>
		<li><a href="cloudISS.jsp">POI</a></li>
	</ul>
