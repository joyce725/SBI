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
			<li><a href="#"><img src="images/sidenav-country.svg" alt="">國家/城巿商圈</a></li>
			<li class="active"><img src="images/sidenav-strategy.svg" alt="">決策工具
				<ul>
					<li><a href="#">目標市場定位</a></li>
					<li><a href="#">目標客群定位</a></li>
					<li><a href="">競爭者定位</a></li>
					<li><a href="#">商品通路</a></li>
					<li><a href="#">授權商品檢索機制</a></li>
					<li><a href="productForecast.jsp">新產品風向預測</a></li>
					<li><a href="finModel.jsp">新創公司財務損益平衡評估</a></li>
					<li><a href="#">海外布局選擇</a></li>
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
					<li><a href="#">生活費用</a></li>
					<li><a href="#">區位選擇</a></li>
					<li><a href="#">環域分析</a></li>
					<li><a href="#">動態統計</a></li>
				</ul>
			</li>
		</ul>
	</div><!-- /.sidenav -->