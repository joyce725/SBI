<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="import.jsp" flush="true"/>
<script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/additional-methods.min.js"></script>
<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>
<script>
$(function(){
	
	var p_agent_id = ""; 
	var p_row = "";
	
	var validator_insert = $("#insert-dialog-form-post").validate({
		rules : {
// 			f_date : {
// 				required : true,
// 				dateISO : true
// 			},
// 			amount : {
// 				number : true
// 			}
		}
	});
	var validator_update = $("#update-dialog-form-post").validate({
		rules : {
// 			f_date : {
// 				required : true,
// 				dateISO : true
// 			},
// 			amount : {
// 				number : true
// 			}
		}
	});	
	
	// 查詢通路商 事件聆聽
	$("#btn_query").click(function(e) {
		$.ajax({
			type : "POST",
			url : "agent.do",
			data : {
				action : "selectAll"
			},
			success : function(result) {
				var json_obj = $.parseJSON(result);
				var result_table = "";
				$.each(json_obj,function(i, item) {
					result_table 
						+= "<tr>"
						+ "<td id='agent_name_"+i+"'>" + item.agent_name + "</td>"
						+ "<td id='web_site_"+i+"'>"+ item.web_site + "</td>"
						+ "<td id='region_code_"+i+"'>"+ item.region_code + "</td>"
						+ "<td id='contact_mail_"+i+"'>"+ item.contact_mail + "</td>"
						+ "<td id='contact_phone_"+i+"'>"+ item.contact_phone + "</td>"
						+ "<td id='seed_"+i+"'>"+ item.seed + "</td>"
						+ "<td><div href='#' class='table-row-func btn-in-table btn-gray'><i class='fa fa-ellipsis-h'></i>"
						+ "<div class='table-function-list'>"
						+ "<button href='#' name='"+i+"' value='" + item.agent_id + "' class='btn-update btn-in-table btn-green'><i class='fa fa-pencil'></i></button>"
						+ "<button href='#' name='" + item.agent_name + "' value='" + item.agent_id + "' class='btn-delete btn-in-table btn-orange'><i class='fa fa-trash'></i></button>"
						+ "</div></div></td></tr>";							
				});		
				//判斷查詢結果
				var resultRunTime = 0;
				$.each (json_obj, function (i) {
					resultRunTime+=1;
				});
				if(resultRunTime!=0){
					$("#table_agent tbody").html(result_table);
				}else{
					// todo
				}
			}
		});
	});
	
	// 新增通路商 事件聆聽
	$("#btn_insert_agent").click(function(e) {
		e.preventDefault();		
		insert_dialog.dialog("open");
	});
	
	// "新增通路商" Dialog相關設定
	insert_dialog = $("#dialog-form-insert").dialog({
		draggable : false,//防止拖曳
		resizable : false,//防止縮放
		autoOpen : false,
		show : {
			effect : "clip",
			duration : 500
		},
		hide : {
			effect : "fade",
			duration : 500
		},
		width : 'auto',
		modal : true,
		buttons : [{
			id : "insert",
			text : "新增",
			click : function() {
				if ($('#insert-dialog-form-post').valid()) {
					$.ajax({
						type : "POST",
						url : "agent.do",
						data : {
							action : "insert",
							agent_name: $("#insert_agent_name").val(),
							web_site: $("#insert_web_site").val(),
							region_code: $("#insert_region_code").val(),
							contact_mail: $("#insert_contact_mail").val(),
							contact_phone: $("#insert_contact_phone").val(),
							seed: $("#insert_seed").val()
						},
						success : function(result) {
							var json_obj = $.parseJSON(result);
							var result_table = "";
							$.each(json_obj,function(i, item) {
								result_table 
									+= "<tr>"
									+ "<td id='agent_name_"+i+"'>" + item.agent_name + "</td>"
									+ "<td id='web_site_"+i+"'>"+ item.web_site + "</td>"
									+ "<td id='region_code_"+i+"'>"+ item.region_code + "</td>"
									+ "<td id='contact_mail_"+i+"'>"+ item.contact_mail + "</td>"
									+ "<td id='contact_phone_"+i+"'>"+ item.contact_phone + "</td>"
									+ "<td id='seed_"+i+"'>"+ item.seed + "</td>"
									+ "<td><div href='#' class='table-row-func btn-in-table btn-gray'><i class='fa fa-ellipsis-h'></i>"
									+ "<div class='table-function-list'>"
									+ "<button href='#' name='"+i+"' value='" + item.agent_id + "' class='btn-update btn-in-table btn-green'><i class='fa fa-pencil'></i></button>"
									+ "<button href='#' name='" + item.agent_name + "' value='" + item.agent_id + "' class='btn-delete btn-in-table btn-orange'><i class='fa fa-trash'></i></button>"
									+ "</div></div></td></tr>";							
							});		
							//判斷查詢結果
							var resultRunTime = 0;
							$.each (json_obj, function (i) {
								resultRunTime+=1;
							});
							if(resultRunTime!=0){
								$("#table_agent tbody").html(result_table);
							}else{
								// todo
							}
						}
					});
					insert_dialog.dialog("close");
				}
			}
		}, {
			text : "取消",
			click : function() {
				validator_insert.resetForm();
				$("#insert-dialog-form-post").trigger("reset");
				insert_dialog.dialog("close");
			}
		} ],
		close : function() {
			validator_insert.resetForm();
			$("#insert-dialog-form-post").trigger("reset");
			insert_dialog.dialog("close");
		}
	});
	
	// 修改 事件聆聽
	$("#table_agent").delegate(".btn-update", "click", function(e) {
		e.preventDefault();
		p_agent_id = $(this).val();
		p_row = $(this).attr('name');
		$("#dialog-form-update input[name='agent_name']").val($('#agent_name_' + p_row).html());
		$("#dialog-form-update input[name='web_site']").val($('#web_site_' + p_row).html());
		$("#dialog-form-update input[name='region_code']").val($('#region_code_' + p_row).html());
		$("#dialog-form-update input[name='contact_mail']").val($('#contact_mail_' + p_row).html());
		$("#dialog-form-update input[name='contact_phone']").val($('#contact_phone_' + p_row).html());
		$("#dialog-form-update input[name='seed']").val($('#seed_' + p_row).html());
		update_dialog.dialog("open");
	});
	
	// "修改" Dialog相關設定
	update_dialog = $("#dialog-form-update").dialog({
		draggable : false,//防止拖曳
		resizable : false,//防止縮放
		autoOpen : false,
		show : {
			effect : "clip",
			duration : 500
		},
		hide : {
			effect : "fade",
			duration : 500
		},
		width : 'auto',
		modal : true,
		buttons : [{
			id : "update",
			text : "修改",
			click : function() {
// 				if ($('#update-dialog-form-post').valid()) {
					$.ajax({
						type : "POST",
						url : "agent.do",
						data : {
 							action : "update",
 							agent_id: p_agent_id,
 							agent_name: $("#update_agent_name").val(),
 							web_site : $("#update_web_site").val(),
 							region_code: $("#update_region_code").val(),
 							contact_mail: $("#update_contact_mail").val(),
 							contact_phone : $("#update_contact_phone").val(),
 							seed : $("#update_seed").val()
						},
						success : function(result) {
							var json_obj = $.parseJSON(result);
							var result_table = "";
							$.each(json_obj,function(i, item) {
								result_table 
									+= "<tr>"
									+ "<td id='agent_name_"+i+"'>" + item.agent_name + "</td>"
									+ "<td id='web_site_"+i+"'>"+ item.web_site + "</td>"
									+ "<td id='region_code_"+i+"'>"+ item.region_code + "</td>"
									+ "<td id='contact_mail_"+i+"'>"+ item.contact_mail + "</td>"
									+ "<td id='contact_phone_"+i+"'>"+ item.contact_phone + "</td>"
									+ "<td id='seed_"+i+"'>"+ item.seed + "</td>"
									+ "<td><div href='#' class='table-row-func btn-in-table btn-gray'><i class='fa fa-ellipsis-h'></i>"
									+ "<div class='table-function-list'>"
									+ "<button href='#' name='"+i+"' value='" + item.agent_id + "' class='btn-update btn-in-table btn-green'><i class='fa fa-pencil'></i></button>"
									+ "<button href='#' name='" + item.agent_name + "' value='" + item.agent_id + "' class='btn-delete btn-in-table btn-orange'><i class='fa fa-trash'></i></button>"
									+ "</div></div></td></tr>";							
							});			
							//判斷查詢結果
							var resultRunTime = 0;
							$.each (json_obj, function (i) {
								resultRunTime+=1;
							});
							if(resultRunTime!=0){
								$("#table_agent tbody").html(result_table);
							}else{
								// todo
							}
						}
					});
					update_dialog.dialog("close");
// 				}
			}
		}, {
			text : "取消",
			click : function() {
				validator_update.resetForm();
				$("#update-dialog-form-post").trigger("reset");
				update_dialog.dialog("close");
			}
		} ],
		close : function() {
			$("#update-dialog-form-post").trigger("reset");
			validator_update.resetForm();
			update_dialog.dialog("close");
		}
	});
	
// 	//刪除事件聆聽 : 因為聆聽事件動態產生，所以採用delegate來批量處理，節省資源
	$("#table_agent").delegate(".btn-delete", "click", function(e) {
		e.preventDefault();
		p_agent_id = $(this).val();
		$("#delete_agent_name").html($(this).attr('name'));
		del_dialog.dialog("open");
	});
// 	// "刪除" Dialog相關設定
	del_dialog = $("#dialog-form-delete").dialog({
		draggable : false,//防止拖曳
		resizable : false,//防止縮放
		autoOpen : false,
		show : {
			effect : "clip",
			duration : 500
		},
		hide : {
			effect : "fade",
			duration : 500
		},
		height : 'auto',
		modal : true,
		buttons : [{
			id : "delete",
			text : "確認刪除",
			click : function() {
				$.ajax({
					type : "POST",
					url : "agent.do",
					data : {
						action: "delete",
						agent_id: p_agent_id
					},
					success : function(result) {
						var json_obj = $.parseJSON(result);
						var result_table = "";
						$.each(json_obj,function(i, item) {
							result_table 
								+= "<tr>"
								+ "<td id='agent_name_"+i+"'>" + item.agent_name + "</td>"
								+ "<td id='web_site_"+i+"'>"+ item.web_site + "</td>"
								+ "<td id='region_code_"+i+"'>"+ item.region_code + "</td>"
								+ "<td id='contact_mail_"+i+"'>"+ item.contact_mail + "</td>"
								+ "<td id='contact_phone_"+i+"'>"+ item.contact_phone + "</td>"
								+ "<td id='seed_"+i+"'>"+ item.seed + "</td>"
								+ "<td><div href='#' class='table-row-func btn-in-table btn-gray'><i class='fa fa-ellipsis-h'></i>"
								+ "<div class='table-function-list'>"
								+ "<button href='#' name='"+i+"' value='" + item.agent_id + "' class='btn-update btn-in-table btn-green'><i class='fa fa-pencil'></i></button>"
								+ "<button href='#' name='" + item.agent_name + "' value='" + item.agent_id + "' class='btn-delete btn-in-table btn-orange'><i class='fa fa-trash'></i></button>"
								+ "</div></div></td></tr>";							
						});		
						//判斷查詢結果
						var resultRunTime = 0;
						$.each (json_obj, function (i) {
							resultRunTime+=1;
						});
						$("#table_agent tbody").html(result_table);
					}
				});
				$(this).dialog("close");
			}
		}, {
			text : "取消",
			click : function() {
				$(this).dialog("close");
			}
		} ],
		close : function() {
			$(this).dialog("close");
		}
	});
})
</script>
<jsp:include page="header.jsp" flush="true"/>
	<div class="content-wrap">
		<h2 class="page-title">授權商品通路商</h2>
		<div class="input-field-wrap">
			<div class="form-wrap">
				<div class="form-row">
					<label for="">
						<span class="block-label">通路商查詢</span>
						<input type="text">
					</label>
					<a href="#" id="btn_query" class="btn btn-darkblue">查詢</a>
				</div>
				<div class="btn-row">
					<a href="#" id="btn_insert_agent" class="btn btn-exec btn-wide">新增通路商</a>
				</div>
			</div><!-- /.form-wrap -->
		</div><!-- /.input-field-wrap -->
		
		<div class="search-result-wrap">
			<div class="result-table-wrap">
				<table id="table_agent" class="result-table">
					<thead>
						<tr>
							<th>通路商名稱</th>
							<th>網址</th>
							<th>區域碼</th>
							<th>聯絡人Email</th>
							<th>聯絡人電話</th>
							<th>加密因子</th>
							<th>功能</th>
						</tr>
					</thead>
					<tbody style="text-align:center">
					</tbody>
				</table>
			</div>
		</div>
		
		<!--對話窗樣式-新增 -->
		<div id="dialog-form-insert" title="新增資料" style="display:none">
			<form name="insert-dialog-form-post" id="insert-dialog-form-post" style="display:inline">
				<table style="border-collapse: separate;border-spacing: 10px 20px;">
					<tbody>
						<tr>
							<td><p>通路商名稱：</p></td>
							<td><input type="text" id="insert_agent_name" name="agent_name" ></td>
							<td><p>網址：</p></td>
							<td><input type="text" id="insert_web_site" name="web_site" ></td>
						</tr>
						<tr>
							<td><p>區域碼：</p></td>
							<td><input type="text" id="insert_region_code" name="region_code" ></td>
							<td><p>聯絡人Email：</p></td>
							<td><input type="text" id="insert_contact_mail" name="contact_mail" ></td>
						</tr>
						<tr>
							<td><p>聯絡人電話：</p></td>
							<td><input type="text" id="insert_contact_phone" name="contact_phone" ></td>
							<td><p>加密因子：</p></td>
							<td><input type="text" id="insert_seed" name="seed" ></td>
						</tr>
					</tbody>
				</table>	
			</form>
		</div>	
			
		<!--對話窗樣式-修改 -->
		<div id="dialog-form-update" title="修改資料" style="display:none">
			<form name="update-dialog-form-post" id="update-dialog-form-post">
				<table style="border-collapse: separate;border-spacing: 10px 20px;">
					<tbody>
						<tr>
							<td><p>通路商名稱：</p></td>
							<td><input type="text" id="update_agent_name" name="agent_name" ></td>
							<td><p>網址：</p></td>
							<td><input type="text" id="update_web_site" name="web_site" ></td>
						</tr>
						<tr>
							<td><p>區域碼：</p></td>
							<td><input type="text" id="update_region_code" name="region_code" ></td>
							<td><p>聯絡人Email：</p></td>
							<td><input type="text" id="update_contact_mail" name="contact_mail" ></td>
						</tr>
						<tr>
							<td><p>聯絡人電話：</p></td>
							<td><input type="text" id="update_contact_phone" name="contact_phone" ></td>
							<td><p>加密因子：</p></td>
							<td><input type="text" id="update_seed" name="seed" ></td>
						</tr>
					</tbody>
				</table>	
			</form>
		</div>	
		
		<!--對話窗樣式-刪除 -->
		<div id="dialog-form-delete" title="確認刪除此資料?" style="display:none">
			<form name="delete-dialog-form-post" id="delete-dialog-form-post" style="display:inline">
				<p>是否確認刪除：</p>
				<div style="text-align:center">
					<label id="delete_agent_name"></label>
				</div>
			</form>
		</div>	
	</div>
<jsp:include page="footer.jsp" flush="true"/>