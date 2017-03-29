<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="import.jsp" flush="true"/>

<jsp:include page="header.jsp" flush="true"/>
<div class="content-wrap">
<h2 class="page-title">測試頁面</h2>
<div class="search-result-wrap">
<script>
	$(function() {
		$("#go_eat").click(function(){
			var geocoder = new google.maps.Geocoder();
            geocoder.geocode({
                "address": $("#addr").val()
            }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                	alert( results[0].geometry.location.lat()+" ## "+ results[0].geometry.location.lng());
                } else {
                    alert( "查無經緯度\n");
                }
            });
			
		});
	});	
</script>
			
			<div style="width:80vh;margin:30px auto;">
				<table id="temp" class="result-table">
<%-- 					<caption><button class='btn_insert'>新增</button><br>　</caption> --%>
						<thead>
							<tr>
								<th>功能 </th>
								<th>使用者名稱</th>
								<th>使用者email</th>
								<th>管理者</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1</td>
								<td>2</td>
								<td>3</td>
								<td>4</td>
							</tr>
							<tr>
								<td>2</td>
								<td>2</td>
								<td>3</td>
								<td>4</td>
							</tr>
						</tbody>
				</table>
				<div style="padding:50px;">
					<input id='addr' type='text' value='台北市內湖區文湖街18號' style='width:400px;'>
					<a id='go_eat' class='btn btn-darkblue'>哈哈哈 吃便便啦</a>
				</div>
			</div>
		</div>
	</div>
	 <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBSQDx-_LzT3hRhcQcQY3hHgX2eQzF9weQ&signed_in=true&libraries=places&callback=initMap">
	</script> 
<jsp:include page="footer.jsp" flush="true"/>