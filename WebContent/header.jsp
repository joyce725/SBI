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
			<a href="personaNew.jsp" class="dropbtn">目標客群定位</a>
<!-- 			<div class="dropdown-content"> -->
<!-- 				<a href="#">品類</a> -->
<!-- 				<a href="personaNew.jsp">目標族群</a> -->
<!-- 				<a href="#">市場價格定位</a> -->
<!-- 			</div> -->
		</li>
		<li class="dropdown">
			<a href="#" class="dropbtn">空間決策</a>
			<div class="dropdown-content">
				<a href="#">目標市場確認</a>
				<a href="#">競爭力評估</a>
				<a href="#">銷售通路決策</a>
			</div>
		</li>
		<li class="dropdown">
			<a href="#" class="dropbtn">生活費用</a>
<!-- 			<div class="dropdown-content"> -->
<!-- 				<a href="#">零售業</a> -->
<!-- 				<a href="#">餐飲業</a> -->
<!-- 			</div> -->
		</li>
		<li class="dropdown">
			<a href="#" class="dropbtn">電子書</a>
<!-- 			<div class="dropdown-content"> -->
<!-- 				<a href="#">人口/市場</a> -->
<!-- 				<a href="#">商圈/競爭</a> -->
<!-- 				<a href="#">經濟/交通</a> -->
<!-- 			</div> -->
		</li>
		<li class="dropdown">
			<a href="#" class="dropbtn">動態統計</a>
			<div class="dropdown-content">
				<a href="#">國家</a>
				<a href="#">目標城市</a>
				<a href="#">目標產業</a>
				<a href="#">消費力</a>
				<a href="population.jsp">台灣人口社經資料庫</a>
				<a href="upload.jsp">產業分析基礎資料庫</a>
				<a href="populationNew.jsp">台灣人口社經</a>
			</div>
		</li>
		<li class="dropdown">
			<a href="#" class="dropbtn">環域分析</a>
<!-- 			<div class="dropdown-content"> -->
<!-- 				<a href="#">分析地點</a> -->
<!-- 				<a href="#">交通速度</a> -->
<!-- 				<a href="#">時間劃分</a> -->
<!-- 			</div> -->
		</li>
		<li class="dropdown">
			<a href="#" class="dropbtn">區位選擇</a>
<!-- 			<div class="dropdown-content"> -->
<!-- 				<a href="#">商圈評估</a> -->
<!-- 				<a href="#">問卷建立</a> -->
<!-- 				<a href="#">建議區位</a> -->
<!-- 				<a href="#">競爭分佈</a> -->
<!-- 			</div> -->
		</li>
<!-- 		<li class="dropdown"> -->
<!-- 			<a href="#" class="dropbtn">市場商情分析</a> -->
<!-- 			<div class="dropdown-content"> -->
<!-- 				<a href="cloudISS.jsp">生活費用</a> -->
<!-- 				<a href="cloudISS.jsp">區位選擇</a> -->
<!-- 				<a href="cloudISS.jsp">環域分析</a> -->
<!-- 				<a href="cloudISS.jsp">動態統計</a> -->
<!-- 			</div> -->
<!-- 		</li> -->
<!-- 		<li><a href="businessdistrict.jsp">定位</a></li> -->
		<li class="dropdown">
			<a href="businessdistrict.jsp" class="dropbtn">定位</a>
<!-- 			<div class="dropdown-content"> -->
<!-- 				<a href="#">國家</a> -->
<!-- 				<a href="#">城市</a> -->
<!-- 				<a href="#">商圈</a> -->
<!-- 			</div> -->
		</li>
	</ul>
