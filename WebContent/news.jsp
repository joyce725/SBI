<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="import.jsp" flush="true"/>
<style>
.content-wrap ul {
    list-style-type:none;
}
.content-wrap ul li {
    width:600px;
    line-height:24px;
}
.content-wrap ul li a, ul li a:active {
    padding:5px;
    color:#888;
    text-decoration:none;
    display:block;
}
.content-wrap ul li a:hover {
    color: #08c;
}
h3.ui-list-title {
	border-bottom: 1px solid #ccc;
	color: #307CB0;
}
section {
	margin-bottom: 60px;
}
</style>
<script>
	$(function(){
		// onload 時帶入news資料
		$.ajax({
			type : "POST",
			url : "news.do",
			data : {
				action : "onload"
			},
			success : function(result) {
				var news_list = "";
				var jsonObejct = $.parseJSON(result);
// 				for(var i in jsonObejct){
// 					alert(jsonObejct[i].data);
// 					for(var j in jsonObejct[i].data){
// 						alert("test");
// 						var jsonItem = $.parseJSON(jsonObejct[i].data);
// 						alert(jsonItem[j].title);
// 					}
// 				}

				news_list += "<section><ul>";

				$.each(jsonObejct,function(index, value) {
					var source = value.source;
// 					news_list += "<section><h3 class='ui-list-title'>" + source + "</h3><ul>"
					$.each(value.data,function(i, item) {
						var jsonItem = $.parseJSON(item);
						news_list += "<li><a href='" + jsonItem.link + "' target='_blank'>" + jsonItem.title + "   (" + source + ")</a></li>";
					});
				});
				news_list += "</ul></section>";
// 				$.each(json_obj,function(i, item) {
// 					result_table += "<tr>"
// 							+ "<td>" + json_obj[i].source + "</td>"
// 							+ "<td>" + json_obj[i].title + "</td>"
// 							+ "<td>" + json_obj[i].date + "</td>"
// 							+ "</tr>";
// 				});					
// 				//判斷查詢結果
// 				var resultRunTime = 0;
// 				$.each (json_obj, function (i) {
// 					resultRunTime+=1;
// 				});
// 				$("#fincase-table-admin").dataTable().fnDestroy();
// 				if(resultRunTime!=0){
					$("#news-area").html(news_list);
// 				}else{
					// todo
// 				}
			}
		});
		
	});
</script>
<jsp:include page="header.jsp" flush="true"/>
<div class="content-wrap">
	<h2 class="page-title">新聞專區</h2>
	<div class="search-result-wrap">
		<h3 class="ui-list-title">每日產業重點訊息</h3>
		<div id="news-area"></div>
	</div>
</div>
<jsp:include page="footer.jsp" flush="true"/>