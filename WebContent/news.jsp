<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="import.jsp" flush="true"/>
	<link rel="stylesheet" href="css/jquery-ui.min.css">
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<link rel="stylesheet" href="css/styles.css">
	<link rel="stylesheet" href="css/styles_news.css">
	<link rel="stylesheet" href="css/jquery.dataTables.min.css" />
	<link rel="stylesheet" href="css/buttons.dataTables.min.css"/>
	
	<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="js/dataTables.buttons.min.js"></script>
	
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
	<script type="text/javascript" src="js/additional-methods.min.js"></script>
	<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>
<jsp:include page="header.jsp" flush="true"/>
<div class="content-wrap">
	<h2 class="page-title">新聞專區</h2>
	
	<div class="search-result-wrap">
		<div id="tabs" >
			<ul>
				<li><a href="#tabs-1"><span>每日產業重點訊息</span></a></li>
				<li><a href="#tabs-2"><span>商機觀測站</span></a></li>
			</ul>
			
			<div id="tabs-1">
				<div id="news-area" class="panel">
					<table id="news-table"></table>
				</div>
		  	</div>
			<div id="tabs-2">
				<div class="panel">
					<table id="group-backstage-table"class="result-table2 smoothbottom">
						<thead>
							<tr>
								<th>編號</th>
								<th>標題</th>
								<th>上架時間</th>					
								<th>功能</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div class="data_source"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	
	$( "#tabs" ).tabs();
	
	draw_uploaddocs({"action": "select_all_uploaddoc"});
	$.ajax({
		type : "POST",
		url : "news.do",
		data : {
			action : "onload"
		},
		success : function(result) {

			var head = "";
			var rows = "";
			var data = "";
			var json_obj = $.parseJSON(result);
			
			head = 	"<tr>" +
						"<td align='center'><h4>類別</h4></td>" + 
						"<td align='center'><h4>標題</h4></td>" + 
						"<td align='center'><h4>來源</h4></td>"+
					"</tr>";

			$.each(json_obj, function(i, item) {
				
				var source = item.source;
				var url = item.Url;
				var title = item.Title;
				var type = item.Type;
				
				rows += "<tr>" +
							"<td align='left'><a>『" + type + "』</a></td>" + 
							"<td align='left'><a href='" + url + "' target='_blank'>《" + title + "》</a></td>" + 
							"<td align='left'><a>【" + source + "】</a></td>"+
 						"</tr>";
				
			});
			
			data = head + rows;
			$("#news-area").find('#news-table').html('').html(data);
		}
	});
	
	//init data_source
	$('.data_source').empty();
	var obj_a = $("<a></a>")
		.attr("href", "http://www.dataa.com.tw/")
		.attr("target", "_blank")
		.text("Dataa大數據研究中心");
	var obj_h6 = $("<h6></h6>")
		.attr("style", "margin:5px;")
		.append("<span>資料來源: <span>")
		.append(obj_a);

	$('.data_source').append(obj_h6);
});

function draw_uploaddocs(parameter){
	var count=1;
	$("#group-backstage-table").DataTable({
		dom: "<t>p",
		destroy: true,
		language: {
			"search" : "搜尋:",
			"paginate": { 
		        "previous": "←",
		        "next":     "→",
		    }
		},
		"order": [],
		ajax: {
			url : "uploaddoc.do",
			dataSrc: "",
			type : "POST",
			data : parameter
		},
        columnDefs: [{
			targets: -1,
			searchable: false,
			orderable: false,
			render: function ( data, type, row ) {
				$("#group-backstage-table").fadeIn();
				var options =
					"<div class='table-row-func'><a class='btn btn-darkblue btn-wide'"
					+" onclick=\'window.open(\"./uploaddoc.do?action=download_doc&file_name="
					+ row.store_name
					+ "&ori_name=" + row.show_name+"\", \"_blank\");\'"
					+ " value='"
					+ row.id
					+ "'>下載</a></div>";
				return options;
			}
		},{
			targets: 0,
			searchable: true,
			orderable: false,
			render: function ( data, type, row ) {
				return count;
			},
		},{
			targets: 1,
			searchable: false,
			orderable: false,
			render: function ( data, type, row ) {
				var options = "<div class='' style='text-align:left;font-size:22px;'><a href=\"./uploaddocs.jsp?id="+(count++)+"\">"+row.title+"</a></div>";
				return options;
			}
		}],
		columns: [
			{"data": "id" ,"defaultContent":""},
			{"data": "title" ,"defaultContent":""},
			{"data": "upload_time" ,"defaultContent":""},
			{"data": null ,"defaultContent":""}
		]
	});	
}
</script>
<jsp:include page="footer.jsp" flush="true"/>