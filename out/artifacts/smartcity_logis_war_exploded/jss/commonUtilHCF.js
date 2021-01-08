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

/*function movePage(url, keyName, keyValue) {
	// history.pushState({}, "", "");
	$("#commonForm").remove();
	$("body").append("<form id=\"commonForm\" name=\"commonForm\"></form>");
	if (arguments.length > 1) {
		for (var i=1;i<arguments.length;i+=2) {
			var keyName = arguments[i];
			var keyValue = arguments[i+1];
			if (keyName != null && keyName != "" && keyValue != null && keyValue != "") {
				$("#commonForm").append("<input type=\"hidden\" name=\""+keyName+"\" value=\""+keyValue+"\"/>");
			}
		}
	}
	$("#commonForm").attr("method", "post");
	$("#commonForm").attr("target", "");
	$("#commonForm").attr("action", url);
	$("#commonForm").submit();
}*/

function showErrorMessage(el, errorMessage) {
	hideErrorMessage(el);
	
	var element = $("#" + el);
	var label = "<label class=\"error\" for=\""+el+"\" >" + errorMessage + "</label>";
 
	if(element.closest("td").find("div.errorContainer").length === 0) {
		$('<div class="errorContainer"><div class="arrow" id="'+el+'-error"></div></div>').insertAfter(element).find('.arrow').append(label)
	} else {
		$('<div class="arrow" id="'+el+'-error"></div>').insertAfter(element).append(label)
	}

    if(element.hasClass("wfull")) {
        element.next('.errorContainer').addClass("d_block")
    }
    element.prependTo(element.next('.errorContainer'))
}

function hideErrorMessage(el) {
	if(el == null || el == "") {
		$("div.arrow").remove();
	} else {
		$("#" + el).parent().children('div.arrow').remove();
	}
}

/*function hideErrorMessage() {
	$("label.error").remove();
}*/

function hasErrorMessage() {
	if($("div.arrow").length > 0) {
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
