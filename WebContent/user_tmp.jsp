<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="import.jsp" flush="true"/>
<script src="js/d3.v3.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/additional-methods.min.js"></script>
<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>

<jsp:include page="header.jsp" flush="true"/>
<div class="content-wrap">
<h2 class="page-title">user管理</h2>
<div class="search-result-wrap">
<style>
table.result {
	font-family: "微軟正黑體", "Microsoft JhengHei", 'LiHei Pro', Arial, Helvetica, sans-serif, \5FAE\8EDF\6B63\9ED1\9AD4,\65B0\7D30\660E\9AD4;
    border: 1px solid #ccc;
    font-size: 13px;
    width: 80%;
}
table.result tr { background: #eee;}
table.result tr:nth-child(2n+1) { background: #fff;}
table.result tbody tr:hover {background: #d8d8d8;}
table.result tbody tr:hover:nth-child(2n+1) {background: #d8d8d8;}
table.result th {
    background: #194A6B;
    border: 1px solid #62E0E9;
    color: #fff;
    word-break: keep-all;
}
table.result th, table.result td {
	border: 1px solid #777;
    padding: 10px;
    align: center;
}
</style>
<script>
function draw_group(parameter){
	$.ajax({
		type : "POST",
		url : "Usertmp.do",
		data : parameter,
		success : function(result) {
// 			console.log(result);
			var json_obj = $.parseJSON(result);
			var result_table = "";
			$.each(json_obj,function(i, item) {
				result_table  
				+="<tr><td><div align='center'>"
				+"   <button value='"+json_obj[i].user_id+"' class='btn_update'>修改</button>"
				+"   <button value='"+json_obj[i].user_id+"' class='btn_delete'>刪除</button>"
				+"</div></td><td name='name'>"+json_obj[i].user_name+"</td>"
				+"</td><td name='email'>"+(json_obj[i].email==null?"":json_obj[i].email)+"</td>"
				+"</td><td name='administrator' value='"+json_obj[i].administrator+"'>"+(json_obj[i].administrator==1?"管理者":"普通使用者")+"</td>"
				+ "</tr>";
			});
			//判斷查詢結果
			var resultRunTime = 0;
			$.each (json_obj, function (i) {
				resultRunTime+=1;
			});
			if(resultRunTime!=0){
				$("#products-contain").show();
				$("#products tbody").html(result_table);
				$(".validate").html("");
			}else{
				$("#products-contain").hide();
				$(".validate").html("---查無此結果---");
			}
		}
	});
}
	$(function() {
// 		$(".bdyplane").animate({"opacity":"1"});
		draw_group({action : "search"});
		//修改Dialog相關設定
		$("#dialog-form-update").dialog({
			draggable : false, resizable : false, autoOpen : false,
			height : "auto", width : "auto", modal : true,
			show : {effect : "blind",duration : 300},
			hide : {effect : "fade",duration : 300},
			buttons : [{
				text : "修改",
				click : function() {
					draw_group({
						action : "update",
						user_id : $(this).val(),
						username : $("#dialog-form-update input[name='name']").val(),
						email : $("#dialog-form-update input[name='email']").val(),
						administrator : $("#dialog-form-update select[name='administrator']").val(),
					});
					$("#dialog-form-update").dialog("close");
				}
			},{
				text : "取消",
				click : function() {
					$("#dialog-form-update").dialog("close");
				}
			}],
			close : function() {
				$("#dialog-form-update").dialog("close");
			}
		});
		$("#dialog-form-delete").dialog({
			draggable : false, resizable : false, autoOpen : false,
			height : "auto", width : "auto", modal : true,
			show : {effect : "blind",duration : 300},
			hide : {effect : "fade",duration : 300},
			buttons : [{
				text : "刪除",
				click : function() {
					draw_group({
						action : "delete",
						user_id : $(this).val(),
					});
					$("#dialog-form-delete").dialog("close");
				}
			},{
				text : "取消",
				click : function() {
					$("#dialog-form-delete").dialog("close");
				}
			}]
		});
		$("#dialog-form-insert").dialog({
			draggable : false, resizable : false, autoOpen : false,
			height : "auto", width : "auto", modal : true,
			show : {effect : "blind",duration : 300},
			hide : {effect : "fade",duration : 300},
			buttons : [{
				text : "新增",
				click : function() {
					draw_group({
						action : "insert",
						user_name : $("#dialog-form-insert input[name='name']").val(),
						email : $("#dialog-form-insert input[name='email']").val(),
						administrator : $("#dialog-form-insert select[name='administrator']").val()
						
					});
					$("#dialog-form-insert").dialog("close");
				}
			},{
				text : "取消",
				click : function() {
					$("#dialog-form-insert").dialog("close");
				}
			}]
		});
		//修改事件聆聽
		$("#products").delegate(".btn_update", "click", function(e) {
			e.preventDefault();
			$("#dialog-form-update").val($(this).val());
			$("#dialog-form-update input[name='name']").val($(this).parents("tr").find("td[name='name']").html());
			$("#dialog-form-update input[name='email']").val($(this).parents("tr").find("td[name='email']").html());
			$("#dialog-form-update select[name='administrator']").val($(this).parents("tr").find("td[name='administrator']").attr("value"));
			$("#dialog-form-update").dialog("open");
		});
		$("#products").delegate(".btn_delete", "click", function(e) {
			e.preventDefault();
			$("#dialog-form-delete").val($(this).val());
			$("#dialog-form-delete").html("<div style='padding:5px 40px;' color=red>"+$(this).parents("tr").find("td[name='name']").html()+"</div>");
			$("#dialog-form-delete").dialog("open");
		});
		$("#products").delegate(".btn_insert", "click",  function(e) {
			e.preventDefault();
			$("#dialog-form-insert input[name='name']").val('');
			$("#dialog-form-insert input[name='email']").val('');
			$("#dialog-form-insert select[name='administrator']").val('');
			$("#dialog-form-insert").dialog("open");
		});
	});	
</script>
			<div id="dialog-form-update" title="修改使用者資料" style="padding:20px;display:none;">
				<table>
					<tr><td>使用者名稱：</td><td><input type="text" name="name"  /></td></tr>
					<tr><td>使用者email：</td><td><input type="text" name="email"  /></td></tr>
					<tr><td>使用者權限：</td><td>
						<select name='administrator'>
						  <option value="0">普通使用者</option>
						  <option value="1">管理者</option>
						</select>
					</td></tr>
				</table>
			</div>
			<div id="dialog-form-delete" title="是否刪除此使用者" style="padding:20px;display:none;"></div>
			<div id="dialog-form-insert" title="新增使用者資料" style="padding:20px;display:none;">
				<table>
					<tr><td>使用者名稱：</td><td><input type="text" name="name"  /></td></tr>
					<tr><td>使用者email：</td><td><input type="text" name="email"  /></td></tr>
					<tr><td>使用者權限：</td><td>
						<select name='administrator'>
						  <option value="0">普通使用者</option>
						  <option value="1">管理者</option>
						</select>
					</td></tr>
				</table>
			</div>
			<!-- 第二列 -->
			
			<div align="center" style="width:600px;margin:30px auto;">
				<div id="products-contain" style="display:none">
					<table id="products" class="result">
					<caption><button class='btn_insert'>新增</button><br>　</caption>
						<thead>
							<tr>
								<th>功能 </th>
								<th>使用者名稱</th>
								<th>使用者email</th>
								<th>管理者</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
				<span class="validateTips" style='color:red;font:22px;'> </span>
			</div>
		</div>
	</div>
<jsp:include page="footer.jsp" flush="true"/>