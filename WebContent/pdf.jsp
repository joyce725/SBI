<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="import.jsp" flush="true"/>

<style>
.func2{
	work-break:keep-all;
	font-size:14px;
}
.func2:hover{
	background: #DDD;
	box-shadow: 3px 2px 2px #aaa;
}
.tmp_table td{
	padding:8px;
	text-align:center;
}
.tmp_table a{
    text-decoration:none;
    color:#000;
}
.tmp_table a:hover{
    text-decoration:none;
    color:#88f;
}
.tmp_table caption{
    font-size:22px;
    color:#888;
    padding-bottom:8px;
}
</style>
<jsp:include page="header.jsp" flush="true"/>

<script>
$(function(){
	$(".tmp_table a").click(function(){
		if(window.scenario_record){scenario_record("參閱電子書",$(this).text());} 
		//alert($(this).text());
	});
});

</script>
<div class="content-wrap">
	<h2 class="page-title">電子書</h2>
	<div class="search-result-wrap">
		<div id='pdf-table'></div>
		<div id='view' style='background:#f8f8f8;padding:20px;border: 3px solid #666;margin:20px auto;width:760px;	border-radius: 8px;box-shadow: 10px 10px 5px #999;'>
			<table class='tmp_table'>
				<caption>
					<little>--各種不同面向的專業評估--</little>
				</caption>
				<tbody>
					<tr>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=大台北" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>大台北電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=桃園" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>桃園電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=台中" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>台中電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=台南" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>台南電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=高雄" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>高雄電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=新加坡" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>新加坡電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=雅加達" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>雅加達電子書</a></td>
					</tr>
					<tr>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=馬尼拉" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>馬尼拉電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=吉隆坡" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>吉隆坡電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=濟南市" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>濟南市電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=瀋陽市" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>瀋陽市電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=煙臺市" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>煙臺市電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=鄭州市" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>鄭州市電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=唐山市" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>唐山市電子書</a></td>
					</tr>
					<tr>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=重慶市" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>重慶市電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=青島市" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>青島市電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=西安市" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>西安市電子書</a></td>
						<td width="104px" id='wuhan' class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=武漢市" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>武漢市電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=成都市" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>成都市電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=天津市" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>天津市電子書</a></td>
						<td width="100px" class="func2"><a target="_blank" href="./uploaddoc.do?action=download_ebook&ebook_name=新山商圈" class="no_alert"><img src="./refer_data/e-book.png" style='height:80px;'><br>新山電子書</a></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>

<jsp:include page="footer.jsp" flush="true"/>