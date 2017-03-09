/**
 * 存放共用的 function
 */


function warningMsg(title, msg) {
	$("#msgAlert").html(msg);
	
	$("#msgAlert").dialog({
		title: title,
		draggable : true,
		resizable : false,
		autoOpen : true,
		height : "auto",
		modal : true,
		buttons : [{
			text: "確認", 
			click: function() { 
				$(this).dialog("close");
			}
		}]
	});
}
