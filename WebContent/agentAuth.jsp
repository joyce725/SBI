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
	var p_product_id = ""; 
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
	
// 	$.ajax({
// 		type : "POST",
// 		url : "agentAuth.do",
// 		data : {
// 			action : "getGroupAll"
// 		},
// 		success : function(result) {
// 			var json_obj = $.parseJSON(result);
							
// 			$.each(json_obj, function(i, item) {
// 				$("[name^=group_name]").append($('<option></option>').val(json_obj[i].group_id).html(json_obj[i].group_name));	
// 			});
// 		},
// 		error:function(e){
// 			console.log('btn1 click error');
// 		}
// 	});
		
	// 查詢通路商 事件聆聽
	$("#btn_query_agent").click(function(e) {
		$.ajax({
			type : "POST",
			url : "agentAuth.do",
			data : {
				action : "selectAll"
			},
			success : function(result) {
				var json_obj = $.parseJSON(result);
				var result_table = "";
				$.each(json_obj,function(i, item) {
					result_table 
						+= "<tr>"
						+ "<td id='product_id_"+i+"'>" + item.product_id + "</td>"
						+ "<td id='agent_id_"+i+"'>"+ item.agent_id + "</td>"
						+ "<td id='region_code_"+i+"'>"+ item.region_code + "</td>"
						+ "<td id='auth_quantity_"+i+"'>"+ item.auth_quantity + "</td>"
						+ "<td id='sale_quantity_"+i+"'>"+ item.sale_quantity + "</td>"
						+ "<td id='register_quantity_"+i+"'>"+ item.register_quantity + "</td>"
						+ "<td id='seed_"+i+"'>"+ item.seed + "</td>"
						+ "<td><div href='#' class='table-row-func btn-in-table btn-gray'><i class='fa fa-ellipsis-h'></i>"
						+ "<div class='table-function-list'>"
						+ "<button href='#' name='"+i+"' value='" + item.agent_id + "' class='btn-update btn-in-table btn-green'><i class='fa fa-pencil'></i></button>"
						+ "<button href='#' name='" + item.product_id + "' value='" + item.agent_id + "' class='btn-delete btn-in-table btn-orange'><i class='fa fa-trash'></i></button>"
						+ "</div></div></td></tr>";							
				});		
				//判斷查詢結果
				var resultRunTime = 0;
				$.each (json_obj, function (i) {
					resultRunTime+=1;
				});
				if(resultRunTime!=0){
					$("#table_agent_auth tbody").html(result_table);
				}else{
					// todo
				}
			}
		});
	});
	
	// 新增通路商 事件聆聽
	$("#btn_insert_agent_auth").click(function(e) {
		e.preventDefault();	
		// loading agent info
		$.ajax({
			type : "POST",
			url : "agentAuth.do",
			data : {
				action : "getAgentInfo"
			},
			success : function(result) {
				$("#insert_agent_id").find('option').remove();
				var json_obj = $.parseJSON(result);
				$.each(json_obj, function(i, item) {
					$("#insert_agent_id").append($('<option></option>').val(item.agent_id).html(item.agent_name));	
				});			
			},
			error:function(e){
				console.log('getProductInfo Fail.');
			}
		});
		// loading product info
		$.ajax({
			type : "POST",
			url : "agentAuth.do",
			data : {
				action : "getProductInfo"
			},
			success : function(result) {
				$("#insert_product_id").find('option').remove();
				var json_obj = $.parseJSON(result);
				$.each(json_obj, function(i, item) {
					$("#insert_product_id").append($('<option></option>').val(item.product_id).html(item.product_spec));	
				});
			},
			error:function(e){
				console.log('getProductInfo Fail.');
			}
		});
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
						url : "agentAuth.do",
						data : {
							action : "insert",
							agent_id: $("#insert_agent_id").val(),
							product_id: $("#insert_product_id").val(), 
							region_code: $("#insert_region_code").val(),
							auth_quantity: $("#insert_auth_quantity").val(),
							sale_quantity: $("#insert_sale_quantity").val(),
							register_quantity: $("#insert_register_quantity").val(),
							seed: $("#insert_seed").val()
						},
						success : function(result) {
							var json_obj = $.parseJSON(result);
							var result_table = "";
							$.each(json_obj,function(i, item) {
								result_table 
									+= "<tr>"
									+ "<td id='product_id_"+i+"'>" + item.product_id + "</td>"
									+ "<td id='agent_id_"+i+"'>"+ item.agent_id + "</td>"
									+ "<td id='region_code_"+i+"'>"+ item.region_code + "</td>"
									+ "<td id='auth_quantity_"+i+"'>"+ item.auth_quantity + "</td>"
									+ "<td id='sale_quantity_"+i+"'>"+ item.sale_quantity + "</td>"
									+ "<td id='register_quantity_"+i+"'>"+ item.register_quantity + "</td>"
									+ "<td id='seed_"+i+"'>"+ item.seed + "</td>"
									+ "<td><div href='#' class='table-row-func btn-in-table btn-gray'><i class='fa fa-ellipsis-h'></i>"
									+ "<div class='table-function-list'>"
									+ "<button href='#' name='"+i+"' value='" + item.agent_id + "' class='btn-update btn-in-table btn-green'><i class='fa fa-pencil'></i></button>"
									+ "<button href='#' name='" + item.product_id + "' value='" + item.agent_id + "' class='btn-delete btn-in-table btn-orange'><i class='fa fa-trash'></i></button>"
									+ "</div></div></td></tr>";							
							});		
							//判斷查詢結果
							var resultRunTime = 0;
							$.each (json_obj, function (i) {
								resultRunTime+=1;
							});
							if(resultRunTime!=0){
								$("#table_agent_auth tbody").html(result_table);
							}else{
								// todo
							}
						},
						error: function(jqXHR, textStatus, errorThrown) { 
					        alert("Status: " + textStatus); alert("Error: " + errorThrown); 
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
	$("#table_agent_auth").delegate(".btn-update", "click", function(e) {
		e.preventDefault();
		p_agent_id = $(this).val();
		p_row = $(this).attr('name');
		$("#dialog-form-update input[name='agent_id']").val($('#agent_id_' + p_row).html());
		$("#dialog-form-update input[name='product_id']").val($('#product_id_' + p_row).html());
		$("#dialog-form-update input[name='region_code']").val($('#region_code_' + p_row).html());
		$("#dialog-form-update input[name='auth_quantity']").val($('#auth_quantity_' + p_row).html());
		$("#dialog-form-update input[name='sale_quantity']").val($('#sale_quantity_' + p_row).html());
		$("#dialog-form-update input[name='register_quantity']").val($('#register_quantity_' + p_row).html());
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
						url : "agentAuth.do",
						data : {
							action : "update",
							agent_id: $("#update_agent_id").val(),
							product_id: $("#update_product_id").val(), 
							region_code: $("#update_region_code").val(),
							auth_quantity: $("#update_auth_quantity").val(),
							sale_quantity: $("#update_sale_quantity").val(),
							register_quantity: $("#update_register_quantity").val(),
							seed: $("#update_seed").val()
						},
						success : function(result) {
							var json_obj = $.parseJSON(result);
							var result_table = "";
							$.each(json_obj,function(i, item) {
								result_table 
									+= "<tr>"
									+ "<td id='product_id_"+i+"'>" + item.product_id + "</td>"
									+ "<td id='agent_id_"+i+"'>"+ item.agent_id + "</td>"
									+ "<td id='region_code_"+i+"'>"+ item.region_code + "</td>"
									+ "<td id='auth_quantity_"+i+"'>"+ item.auth_quantity + "</td>"
									+ "<td id='sale_quantity_"+i+"'>"+ item.sale_quantity + "</td>"
									+ "<td id='register_quantity_"+i+"'>"+ item.register_quantity + "</td>"
									+ "<td id='seed_"+i+"'>"+ item.seed + "</td>"
									+ "<td><div href='#' class='table-row-func btn-in-table btn-gray'><i class='fa fa-ellipsis-h'></i>"
									+ "<div class='table-function-list'>"
									+ "<button href='#' name='"+i+"' value='" + item.agent_id + "' class='btn-update btn-in-table btn-green'><i class='fa fa-pencil'></i></button>"
									+ "<button href='#' name='" + item.product_id + "' value='" + item.agent_id + "' class='btn-delete btn-in-table btn-orange'><i class='fa fa-trash'></i></button>"
									+ "</div></div></td></tr>";							
							});			
							//判斷查詢結果
							var resultRunTime = 0;
							$.each (json_obj, function (i) {
								resultRunTime+=1;
							});
							if(resultRunTime!=0){
								$("#table_agent_auth tbody").html(result_table);
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
	$("#table_agent_auth").delegate(".btn-delete", "click", function(e) {
		e.preventDefault();
		$("#delete_agent_id").val($(this).val());
		$("#delete_product_id").val($(this).attr('name'));
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
					url : "agentAuth.do",
					data : {
						action: "delete",
						agent_id: $("#delete_agent_id").val(),
						product_id: $("#delete_product_id").val()
					},
					success : function(result) {
						var json_obj = $.parseJSON(result);
						var result_table = "";
						$.each(json_obj,function(i, item) {
							result_table 
								+= "<tr>"
								+ "<td id='product_id_"+i+"'>" + item.product_id + "</td>"
								+ "<td id='agent_id_"+i+"'>"+ item.agent_id + "</td>"
								+ "<td id='region_code_"+i+"'>"+ item.region_code + "</td>"
								+ "<td id='auth_quantity_"+i+"'>"+ item.auth_quantity + "</td>"
								+ "<td id='sale_quantity_"+i+"'>"+ item.sale_quantity + "</td>"
								+ "<td id='register_quantity_"+i+"'>"+ item.register_quantity + "</td>"
								+ "<td id='seed_"+i+"'>"+ item.seed + "</td>"
								+ "<td><div href='#' class='table-row-func btn-in-table btn-gray'><i class='fa fa-ellipsis-h'></i>"
								+ "<div class='table-function-list'>"
								+ "<button href='#' name='"+i+"' value='" + item.agent_id + "' class='btn-update btn-in-table btn-green'><i class='fa fa-pencil'></i></button>"
								+ "<button href='#' name='" + item.product_id + "' value='" + item.agent_id + "' class='btn-delete btn-in-table btn-orange'><i class='fa fa-trash'></i></button>"
								+ "</div></div></td></tr>";							
						});		
						//判斷查詢結果
						$("#table_agent_auth tbody").html(result_table);
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
		<h2 class="page-title">通路商授權</h2>
		<div class="input-field-wrap">
			<div class="form-wrap">
				<div class="form-row">
					<label for="">
						<span class="block-label">通路商查詢</span>
						<input type="text" id="input_agent_name">
					</label>
					<a href="#" id="btn_query_agent" class="btn btn-darkblue">查詢</a>
				</div>
				<div class="form-row">
					<label for="">
						<span class="block-label">商品查詢</span>
						<input type="text" id="input_product_name">
					</label>
					<a href="#" id="btn_query_product" class="btn btn-darkblue">查詢</a>
				</div>
				<div class="btn-row">
					<a href="#" id="btn_insert_agent_auth" class="btn btn-exec btn-wide">新增授權</a>
				</div>
			</div><!-- /.form-wrap -->
		</div><!-- /.input-field-wrap -->
		
		<div class="search-result-wrap">
			<div class="result-table-wrap">
				<table id="table_agent_auth" class="result-table">
					<thead>
						<tr>
							<th>商品規格</th>
							<th>通路商名稱</th>
							<th>區域碼</th>
							<th>授權數量</th>
							<th>已銷售數量</th>
							<th>已登錄數量</th>
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
							<td>
								<select id="insert_agent_id" name="agent_id"></select>
							</td>
							<td><p>商品名稱：</p></td>
							<td>
								<select id="insert_product_id" name="product_id"></select>
							</td>
						</tr>
						<tr>
							<td><p>區域碼：</p></td>
							<td><input type="text" id="insert_region_code" name="region_code" ></td>
							<td><p>授權數量：</p></td>
							<td><input type="text" id="insert_auth_quantity" name="auth_quantity" ></td>
						</tr>
						<tr>
							<td><p>已銷售數量：</p></td>
							<td><input type="text" id="insert_sale_quantity" name="sale_quantity" ></td>
							<td><p>已登錄數量：</p></td>
							<td><input type="text" id="insert_register_quantity" name="register_quantity" ></td>
						</tr>
						<tr>
							<td><p>加密因子：</p></td>
							<td><input type="text" id="insert_seed" name="seed" ></td>
							<td></td>
							<td></td>
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
							<td>
								<input type="text" id="update_agent_id" name="agent_id" disabled="disabled"></input>
							</td>
							<td><p>商品名稱：</p></td>
							<td>
								<input type="text" id="update_product_id" name="product_id" disabled="disabled"></input>
							</td>
						</tr>
						<tr>
							<td><p>區域碼：</p></td>
							<td><input type="text" id="update_region_code" name="region_code" ></td>
							<td><p>授權數量：</p></td>
							<td><input type="text" id="update_auth_quantity" name="auth_quantity" ></td>
						</tr>
						<tr>
							<td><p>已銷售數量：</p></td>
							<td><input type="text" id="update_sale_quantity" name="sale_quantity" ></td>
							<td><p>已登錄數量：</p></td>
							<td><input type="text" id="update_register_quantity" name="register_quantity" ></td>
						</tr>
						<tr>
							<td><p>加密因子：</p></td>
							<td><input type="text" id="update_seed" name="seed" ></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>	
			</form>
		</div>	
		
		<!--對話窗樣式-刪除 -->
		<div id="dialog-form-delete" title="確認刪除此資料?" style="display:none">
			<form name="delete-dialog-form-post" id="delete-dialog-form-post" style="display:inline">
				<p>是否確認刪除：</p>
				<input type="hidden" id="delete_agent_id">
				<input type="hidden" id="delete_product_id">
			</form>
		</div>	
	</div>
<jsp:include page="footer.jsp" flush="true"/>