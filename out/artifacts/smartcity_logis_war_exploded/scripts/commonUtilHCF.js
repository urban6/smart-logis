/**
 * @author 
 * 화면이동
 */
function movePage(sUrl, param) {
	$("#_tempForm").remove();
	var sHtml = "";
	sHtml += "<form id=\"_tempForm\" action=\""+sUrl+"\" method=\"post\">";
	sHtml += "</form>";
	$("body").append(sHtml);
	if (param != null) {
		var keys = Object.keys(param);
		for (var i=0;i<keys.length;i++) {
			var key = keys[i];
			$("#_tempForm").append("<input type=\"hidden\" name=\""+key+"\"/>");
			$("#_tempForm input:last").val(param[key]);
		}
	}
	$("#_tempForm").submit();
}

function showErrorMessage(el, errorMessage) {
	$("#" + el).parent("div").next("span.alert").remove();
	//$("#" + el).parent("div").addClass("error");		// 테두리
	$("#" + el).parent().after("<span class=\"alert\"><br />" + errorMessage + "</span>");
}

function hideErrorMessage(el) {
	//$("#" + el).parent("div").removeClass("error");	// 테두리
	$("#" + el).parent("div").next("span.alert").remove();
}

function hideErrorMessage() {
	$("div").next("span.alert").remove();
}

function hasErrorMessage() {
	if($("span.alert").length > 0) {
		return true;
	} else {
		return false;
	}
}

function getBytes(msg) {
	var cnt = 0;
	for( var i=0; i< msg.length; i++) {
		cnt += (msg.charCodeAt(i) > 128 ) ? 2 : 1;
	}
	return cnt;
}

function showLoading() {
	$("#divLoading").removeClass("hide");
}

function hideLoading() {
	$("#divLoading").addClass("hide");
}