<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="import.jsp" flush="true"/>

	<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="js/jquery-ui.min.js"></script>

  <script src="http://jquerymodal.com/jquery.modal.js" type="text/javascript" charset="utf-8"></script>
  <link rel="stylesheet" href="http://jquerymodal.com/jquery.modal.css" type="text/css" media="screen" />
  <script src="./js/my_modal.js" type="text/javascript"></script>
  <link rel="stylesheet" href="./css/my_modal.css" type="text/css" media="screen" />
	
<style>
.search-result-wrap {
    margin-bottom: 20px;
}
</style>
<script>
	$(function(){
		//#####################################################
		//######################要拆出去的#####################
	
		var scenario_job_id = "<%=(String)((request.getSession().getAttribute("scenario_job_id")==null)?"":request.getSession().getAttribute("scenario_job_id"))%>";
		var scenario_job_page = "<%=(String)((request.getSession().getAttribute("scenario_job_page")==null)?"":request.getSession().getAttribute("scenario_job_page"))%>";
		
		var current_page = location.pathname.split("/").pop();
		
		if( scenario_job_id.length > 2 && $("#scenario_controller").length==0){
			$.ajax({
				type : "POST",
				url : "scenarioJob.do",
				data : { 
					action : "get_current_job_info",
					job_id : scenario_job_id
				},success : function(result) {
					var json_obj = $.parseJSON(result);
					
					$("html").append("<div id='scenario_controller' class='scenario_controller' ondblclick='job_explanation(\""+json_obj.job_id+"\")' style=''>"+json_obj.job_name+" <img style='float:right;height:22px;margin-left:10px;'src='./refer_data/next_step.png'><img style='float:right;height:22px;margin-left:10px;'src='./refer_data/check.png'></div>");
				}
			});
		}
		
		if( scenario_job_id.length > 2 && current_page == scenario_job_page){
			
			$.ajax({
				type : "POST",
				url : "scenarioJob.do",
				data : { 
					action : "get_current_job_info",
					job_id : scenario_job_id,
				},success : function(result) {
					var json_obj = $.parseJSON(result);
// 					$.each(json_obj,function(i, item) {
						eval(json_obj.next_flow_guide);
// 					});
				}
			});
			
			$("html").append("<div style='height:40px;width:200px;background-color:gray;position:fixed;bottom:3px;left:16px;'>123</div>");
		}
		//######################要拆出去的#####################		
		//#####################################################			
		
		//div0: 左下角顯示狀態 和簡易操作介面 #job_status
		//div1: guide 偵測session 給出指示訊息 及提醒要跳下一步可按右下角 #job_guide
		//div2: 某些jsp上的按鈕代表紀錄後跳出下一步 #job
		//div3: 紀錄使用者在頁面上做的事情
		//沒有import到也不error的record
// 		$("#return").modal({
// 			  escapeClose: false,
// 			  clickClose: false,
// 			  showClose: false
// 			});
// 		var element_name = "info";
// 		var element_name = "f_name";
// 		var element_name = "summary";
// 		var element_name = "title";
// 		var element_name = "return";
// 		var element_name = "download";
		setTimeout(function(){
// 			alert("###"+$("#info").css("background-color")+"###");
// 			cache_modal.push('run_modal("info","這邊寫的是時間文章時間",1);');
// 			cache_modal.push('run_modal("f_name","這裡寫的是檔案名稱",1);');
// 			cache_modal.push('run_modal("summary","這裡寫內文簡介",1);');
// 			cache_modal.push('run_modal("title","觀測站文章標題",1);');
// 			cache_modal.push('run_modal("return","點這個回到首頁",1,1);');
// 			cache_modal.push('run_modal("download","guide 偵測session 給出指示訊息 及提醒要跳下一步可按右下角 #job_guide",1,1);');
// 			do_modal();
			//run_modal(element_name,"guide 偵測session 給出指示訊息 及提醒要跳下一步可按右下角 #job_guide",1);
		},1000);
		
		if($("#job_status").length==100){
			$("body").append("<div id='job_status'><a class='btn btn-darkblue' id = 'next_step'></a> <a class='btn btn-exec' id = 'next_step'></a></div>");
			$("#job_status").dialog({
				draggable : true, resizable : false, autoOpen : false,
				height : "auto", width : "auto", modal : true,
				position: { my: "left bottom", at: "left+20px bottom-20px ", of: window  } , 
				show : {effect : "blind", duration : 300},
				hide : {effect : "fade", duration : 300},
// 				buttons : [{
// 					text : "修改",
// 					click : function() {
// 						//alert($("#job_update").val());
// 						$(this).dialog("close");
// 					}
// 				},{
// 					text : "取消",
// 					click : function() {
// 						$(this).dialog("close");
// 					}
// 				}]
			});
			$("#job_status").dialog("open");
		}
		
		//alert(window.helloWorld);
	    if (window.helloWorld) {  
	    	helloWorld();  
	    } else {
// 	    	alert("OAO");
	    	
	        //functionA not exist  
	    }  
	});
</script>
<jsp:include page="header.jsp" flush="true"/>
<div class="content-wrap">
	<h2 class="page-title">商機觀測站</h2>
	<div class="search-result-wrap">
		<div id='essay' style='display:none;padding:20px;'>
			<div id='title' style='font-size: 18px;color: #000066;line-height: 1.4em;font-size: 20px;pdpadding-bottom:5px;border-bottom:1px dashed #888;'></div>
			<div id='info' style='color: #6D6D6D;padding-top: 16px;padding-bottom: 10px;'></div>
			<div id='summary' style='color: #262626;line-height: 1.8em;padding: 16px;margin-bottom: 10px;clear: both;max-width:600px;'></div>
			
			<div id='f_name'></div><br>
			<input type='button' id='download' class='btn btn-exec' onclick='' value='下載' style='margin-left:380px'>
			&nbsp;&nbsp;<input type='button' id='return' class='btn btn-primary' onclick='alert(this.width);' value='返回'>
		</div>
	</div>
</div>
<script>
	$(function(){
		//if(location.search.indexOf("id")!=-1){
			//var essay_id = location.search.split("?id=")[1]-1;
			var essay_id = 0;
			$.ajax({
				type : "POST",
				url : "uploaddoc.do",
				data : { action : "select_all_uploaddoc" },
				success : function(result) {
					var jsonObj = $.parseJSON(result);
					
					$("#title").html(jsonObj[essay_id].title);
					$("#info").html("上架時間： "+jsonObj[essay_id].upload_time);
					$("#summary").html("摘要:<br>&nbsp;&nbsp;&nbsp;&nbsp;"+jsonObj[essay_id].summary);
					$("#download").attr("onclick","window.open(\"./uploaddoc.do?action=download_doc"
							+"&file_name=" + jsonObj[essay_id].store_name
							+ "&ori_name=" + jsonObj[essay_id].show_name+"\", \"_blank\");");
					$("#f_name").html("檔名: " + jsonObj[essay_id].show_name);
					$("#essay").fadeIn();
				}
			});
		//}else{
			//window.location.href ="./news.jsp?tab=1";
		//}
	});
</script>
<jsp:include page="footer.jsp" flush="true"/>