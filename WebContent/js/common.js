/**
 * 存放共用的 function
 */


function warningMsg(title, msg) {
	$("#msgAlert").html(msg);
	
	$("#msgAlert").dialog({
		title: title,
		draggable : true,
		resizable : false,
		autoOpen : false,
		height : "auto",
		modal : true,
		buttons : {
			"確認" : function() {
				$(this).dialog("close");
			}
		}
	});
		
	$("#msgAlert").dialog("open");
}
