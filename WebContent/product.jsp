<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="import.jsp" flush="true"/>
<script type="text/javascript" src="js/jquery-migrate-1.4.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/additional-methods.min.js"></script>
<script type="text/javascript" src="js/messages_zh_TW.min.js"></script>
<script>
$(function(){
	
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
	
	// 查詢商品資料 事件聆聽
	$("#btn_query").click(function(e) {
		$.ajax({
			type : "POST",
			url : "product.do",
			data : {
				action : "selectAll"
			},
			success : function(result) {
				var json_obj = $.parseJSON(result);
				var result_table = "";
				$.each(json_obj,function(i, item) {
					result_table 
						+= "<tr>"
						+ "<td id='product_spec_"+i+"'>" + item.product_spec + "</td>"
						+ "<td id='photo_"+i+"'>"+ item.photo + "</td>"
						+ "<td id='seed_"+i+"'>"+ item.seed + "</td>"
						+ "<td><div href='#' class='table-row-func btn-in-table btn-gray'><i class='fa fa-ellipsis-h'></i>"
						+ "<div class='table-function-list'>"
						+ "<button href='#' name='"+i+"' value='" + item.product_id + "' class='btn-update btn-in-table btn-green'><i class='fa fa-pencil'></i></button>"
						+ "<button href='#' name='" + item.product_spec + "' value='" + item.product_id + "' class='btn-delete btn-in-table btn-orange'><i class='fa fa-trash'></i></button>"
						+ "</div></div></td></tr>";								
				});		
				//判斷查詢結果
				var resultRunTime = 0;
				$.each (json_obj, function (i) {
					resultRunTime+=1;
				});
				if(resultRunTime!=0){
					$("#table_product tbody").html(result_table);
				}else{
					// todo
				}
			}
		});
	});
	
	// 新增商品資料 事件聆聽
	$("#btn_insert_product").click(function(e) {
		e.preventDefault();		
		insert_dialog.dialog("open");
	});
	
	// "新增商品資料" Dialog相關設定
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
						url : "product.do",
						data : {
							action : "insert",
							product_spec: $("#insert_product_spec").val(),
							photo: $("#insert_photo").val(),
							seed: $("#insert_seed").val()
						},
						success : function(result) {
							var json_obj = $.parseJSON(result);
							var result_table = "";
							$.each(json_obj,function(i, item) {
								result_table 
									+= "<tr>"
									+ "<td id='product_spec_"+i+"'>" + item.product_spec + "</td>"
									+ "<td id='photo_"+i+"'>"+ item.photo + "</td>"
									+ "<td id='seed_"+i+"'>"+ item.seed + "</td>"
									+ "<td><div href='#' class='table-row-func btn-in-table btn-gray'><i class='fa fa-ellipsis-h'></i>"
									+ "<div class='table-function-list'>"
									+ "<button href='#' name='"+i+"' value='" + item.product_id + "' class='btn-update btn-in-table btn-green'><i class='fa fa-pencil'></i></button>"
									+ "<button href='#' name='" + item.product_spec + "' value='" + item.product_id + "' class='btn-delete btn-in-table btn-orange'><i class='fa fa-trash'></i></button>"
									+ "</div></div></td></tr>";							
							});		
							//判斷查詢結果
							var resultRunTime = 0;
							$.each (json_obj, function (i) {
								resultRunTime+=1;
							});
							if(resultRunTime!=0){
								$("#table_product tbody").html(result_table);
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
	$("#table_product").delegate(".btn-update", "click", function(e) {
		e.preventDefault();
		p_product_id = $(this).val();
		p_row = $(this).attr('name');
		$("#dialog-form-update input[name='product_spec']").val($('#product_spec_' + p_row).html());
		$("#dialog-form-update input[name='photo']").val($('#photo_' + p_row).html());
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
						url : "product.do",
						data : {
 							action : "update",
 							product_id: p_product_id,
 							product_spec: $("#update_product_spec").val(),
 							photo : $("#update_photo").val(),
 							seed : $("#update_seed").val()
						},
						success : function(result) {
							var json_obj = $.parseJSON(result);
							var result_table = "";
							$.each(json_obj,function(i, item) {
								result_table 
									+= "<tr>"
									+ "<td id='product_spec_"+i+"'>" + item.product_spec + "</td>"
									+ "<td id='photo_"+i+"'>"+ item.photo + "</td>"
									+ "<td id='seed_"+i+"'>"+ item.seed + "</td>"
									+ "<td><div href='#' class='table-row-func btn-in-table btn-gray'><i class='fa fa-ellipsis-h'></i>"
									+ "<div class='table-function-list'>"
									+ "<button href='#' name='"+i+"' value='" + item.product_id + "' class='btn-update btn-in-table btn-green'><i class='fa fa-pencil'></i></button>"
									+ "<button href='#' name='" + item.product_spec + "' value='" + item.product_id + "' class='btn-delete btn-in-table btn-orange'><i class='fa fa-trash'></i></button>"
									+ "</div></div></td></tr>";									
							});			
							//判斷查詢結果
							var resultRunTime = 0;
							$.each (json_obj, function (i) {
								resultRunTime+=1;
							});
							if(resultRunTime!=0){
								$("#table_product tbody").html(result_table);
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
	$("#table_product").delegate(".btn-delete", "click", function(e) {
		e.preventDefault();
		p_product_id = $(this).val();
		$("#delete_product_spec").html($(this).attr('name'));
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
					url : "product.do",
					data : {
						action: "delete",
						product_id: p_product_id
					},
					success : function(result) {
						var json_obj = $.parseJSON(result);
						var result_table = "";
						$.each(json_obj,function(i, item) {
							result_table 
								+= "<tr>"
								+ "<td id='product_spec_"+i+"'>" + item.product_spec + "</td>"
								+ "<td id='photo_"+i+"'>"+ item.photo + "</td>"
								+ "<td id='seed_"+i+"'>"+ item.seed + "</td>"
								+ "<td><div href='#' class='table-row-func btn-in-table btn-gray'><i class='fa fa-ellipsis-h'></i>"
								+ "<div class='table-function-list'>"
								+ "<button href='#' name='"+i+"' value='" + item.product_id + "' class='btn-update btn-in-table btn-green'><i class='fa fa-pencil'></i></button>"
								+ "<button href='#' name='" + item.product_spec + "' value='" + item.product_id + "' class='btn-delete btn-in-table btn-orange'><i class='fa fa-trash'></i></button>"
								+ "</div></div></td></tr>";							
						});		
						//判斷查詢結果
						var resultRunTime = 0;
						$.each (json_obj, function (i) {
							resultRunTime+=1;
						});
						if(resultRunTime!=0){
							$("#table_product tbody").html(result_table);
						}else{
							// todo
						}
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
		<h2 class="page-title">商品通路</h2>
		<div class="input-field-wrap">
			<div class="form-wrap">
				<div class="form-row">
					<label for="">
						<span class="block-label">產品名稱查詢</span>
						<input type="text">
					</label>
					<a href="#" id="btn_query" class="btn btn-darkblue">查詢</a>
				</div>
				<div class="btn-row">
					<a href="#" id="btn_insert_product" class="btn btn-exec btn-wide">新增商品資料</a>
				</div>
			</div><!-- /.form-wrap -->
		</div><!-- /.input-field-wrap -->
		
		<div class="search-result-wrap">
			<div class="result-table-wrap">
				<table id="table_product" class="result-table">
					<thead>
						<tr>
							<th>商品規格</th>
							<th>產品圖片名稱</th>
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
							<td><p>商品規格：</p></td>
							<td><input type="text" id="insert_product_spec" name="product_spec" ></td>
							<td><p>產品圖片名稱：</p></td>
							<td><input type="text" id="insert_photo" name="photo" ></td>
						</tr>
						<tr>
							<td><p>加密因子</p></td>
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
							<td><p>商品規格：</p></td>
							<td><input type="text" id="update_product_spec" name="product_spec" ></td>
							<td><p>產品圖片名稱：</p></td>
							<td><input type="text" id="update_photo" name="photo" ></td>
						</tr>
						<tr>
							<td><p>加密因子</p></td>
							<td><input type="text" id="update_seed" name="seed" ></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>	
			</form>
		</div>	
		
		<!--對話窗樣式-刪除 -->
		<div id="dialog-form-delete" title="確認刪除資料嗎?" style="display:none">
			<form name="delete-dialog-form-post" id="delete-dialog-form-post" style="display:inline">
				<p>是否確認刪除:</p>
				<div style="text-align:center">
					<label id="delete_product_spec"></label>
				</div>
			</form>
		</div>	
	</div>
<jsp:include page="footer.jsp" flush="true"/>