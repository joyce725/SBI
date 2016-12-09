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
	
	<div class="sidenav">
		<h1 class="sys-title"><a href="login.jsp">SBI</a></h1>
		<ul>
			<li><a href="marketPlace.jsp"><img src="images/sidenav-country.svg" alt="">國家/城巿商圈</a></li>
			<li class="active"><img src="images/sidenav-strategy.svg" alt="">決策工具
				<ul style="top: -100px;height:320px;">
					<li><a href="cloudISS.jsp">目標市場定位</a></li>
					<li><a href="cloudISS.jsp">目標客群定位</a></li>
					<li><a href="cloudISS.jsp">競爭者定位</a></li>
<!-- 					<li><a href="cloudISS.jsp">商品通路</a></li> -->
					<li><a href="persona.jsp">城市定位</a></li>
					<li><a href="productForecast.jsp">新產品風向評估</a></li>
					<li><a href="finModel.jsp">新創公司財務損益平衡評估</a></li>
<!-- 					<li><a href="#">海外布局選擇</a></li> -->
				</ul>
				<ul style="top: -100px;left: 370px;height:320px;">
					<li><a href="product.jsp">商品管理</a></li>
					<li><a href="agent.jsp">通路商管理</a></li>
					<li><a href="agentAuth.jsp">通路商授權商品管理</a></li>
					<li><a href="serviceAgentAssign.jsp">服務識別碼指定通路商作業</a></li>
					<li><a href="productVerify.jsp">商品真偽顧客驗證作業</a></li>
					<li><a href="authVerify.jsp">商品真偽通路商驗證作業</a></li>
					<li><a href="serviceVerify.jsp">服務識別碼查詢作業</a></li>
					<li><a href="serviceRegister.jsp">商品售後服務註冊</a></li>
				</ul>
			</li>
			<li><img src="images/sidenav-stastic.svg" alt="">統計資料
				<ul>
					<li><a href="population.jsp">台灣人口社經</a></li>
					<li><a href="upload.jsp">產業分析基礎資料庫</a></li>
				</ul>
			</li>
			<li><img src="images/sidenav-analytic.svg" alt="">市場商情分析
				<ul>
					<li><a href="cloudISS.jsp">生活費用</a></li>
					<li><a href="regionSelect.jsp">區位選擇</a></li>
					<li><a href="cloudISS.jsp">環域分析</a></li>
					<li><a href="cloudISS.jsp">動態統計</a></li>
				</ul>
			</li>
			<li><a href="cloudISS.jsp"><img src="images/sidenav-store.svg" alt="">POI</a>
			</li>
		</ul>
	</div><!-- /.sidenav -->