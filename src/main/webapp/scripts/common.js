$(document).ready(function() {
	(function($) {
		var MutationObserver = window.MutationObserver || window.WebKitMutationObserver || window.MozMutationObserver;
		$.fn.attrchange = function(callback) {
			if (MutationObserver) {
				var options = {
					subtree: false,
					attributes: true
				};
				var observer = new MutationObserver(function(mutations) {
					mutations.forEach(function(e) {
						callback.call(e.target, e.attributeName);
					});
				});
				return this.each(function() {
					observer.observe(this, options);
				});
			}
		}
	})(jQuery);
	// history.pushState({}, "", "");
	/*$(document).keydown(function(e) {
		if (e.keyCode == 8) {
			history.pushState({}, "", "");
		}
	});*/


    if (typeof $.fn.alphanumeric === 'function') {
        $.fn.numericFloat = function(p) {

            var az = "abcdefghijklmnopqrstuvwxyz";
            az += az.toUpperCase();

            p = $.extend({
                nchars: az,
                allow : "."
              }, p);

            return this.each (function() {
                    $(this).alphanumeric(p);
            });

        };

        $.fn.numericInteger = function(p) {

            var az = "abcdefghijklmnopqrstuvwxyz";
            az += az.toUpperCase();

            p = $.extend({
                nchars: az,
                allow : "-"
            }, p);

            return this.each (function() {
                $(this).alphanumeric(p);
            });

        };

    }

	g_breadcrumbLeftTimeout = -1;
	g_breadcrumbRightTimeout = -1;
	$(document).mouseup(function() {
		clearTimeout(g_breadcrumbLeftTimeout);
		clearTimeout(g_breadcrumbRightTimeout);
		g_breadcrumbLeftTimeout = -1;
		g_breadcrumbRightTimeout = -1;
	});
	$(window).resize(function() {
		setTimeout("resetBreadCrumbButtons(true)", 100);
	});
});

var g_breadcrumbLeftTimeout;
var g_breadcrumbRightTimeout;
function resetBreadCrumbButtons(bInit) {
	if (bInit == null) {
		bInit = false;
	}
	var moveSpeed = 2;
	if ($("div.breadcrumb").length == 0) {
		return;
	}
	var width = $("div.breadcrumb").width();
	var nTotalWidth = 0;
	$("div.breadcrumb ul.crumbs li").each(function() {
		nTotalWidth += $(this).width();
	});
	var bScroll = false;
	if (width < nTotalWidth) {
		bScroll = true;
	}
	if (bScroll) {
		var marginLeft = parseInt($("div.breadcrumb ul.crumbs").css("margin-left").replace("px", ""));
		if (bInit) {
			marginLeft = width - nTotalWidth;
			$("div.breadcrumb ul.crumbs").css("margin-left", marginLeft);
		}
		var bShowLeftButton = false;
		var bShowRightButton = false;
		if (marginLeft < 0) {
			bShowRightButton = true;
		}
		if (nTotalWidth + marginLeft > width) {
			bShowLeftButton = true;
		} else {
			marginLeft = width-nTotalWidth;
			$("div.breadcrumb ul.crumbs").css("margin-left", marginLeft);
		}
		if (bShowRightButton) {
			if ($("#breadcrumbLeftButton").length == 0) {
				var sHtml = "<div id=\"breadcrumbLeftButton\"></div>";
				$("div.breadcrumb").prepend(sHtml);
			}
			$("#breadcrumbLeftButton").mousedown(function() {
				if (g_breadcrumbLeftTimeout > 0) {
					return;
				}
				g_breadcrumbLeftTimeout = setInterval(function() {
					var marginLeft = parseInt($("div.breadcrumb ul.crumbs").css("margin-left").replace("px", ""));
					$("div.breadcrumb ul.crumbs").css("margin-left", marginLeft+moveSpeed);
					resetBreadCrumbButtons();
				}, 10);
			});
		} else {
			$("#breadcrumbLeftButton").remove();
			clearTimeout(g_breadcrumbLeftTimeout);
			g_breadcrumbLeftTimeout = -1;
		}
		if (bShowLeftButton) {
			if ($("#breadcrumbRightButton").length == 0) {
				var sHtml = "<div id=\"breadcrumbRightButton\"></div>";
				$("div.breadcrumb").prepend(sHtml);
			}
			$("#breadcrumbRightButton").css("left", width-19);
			$("#breadcrumbRightButton").mousedown(function() {
				if (g_breadcrumbRightTimeout > 0) {
					return;
				}
				g_breadcrumbRightTimeout = setInterval(function() {
					var marginLeft = parseInt($("div.breadcrumb ul.crumbs").css("margin-left").replace("px", ""));
					$("div.breadcrumb ul.crumbs").css("margin-left", marginLeft-moveSpeed);
					resetBreadCrumbButtons();
				}, 10);
			});
		} else {
			$("#breadcrumbRightButton").remove();
			clearTimeout(g_breadcrumbRightTimeout);
			g_breadcrumbRightTimeout = -1;
		}
	} else {
		$("div.breadcrumb ul.crumbs").css("margin-left", 0);
		$("#breadcrumbLeftButton").remove();
		$("#breadcrumbRightButton").remove();
		clearTimeout(g_breadcrumbLeftTimeout);
		clearTimeout(g_breadcrumbRightTimeout);
		g_breadcrumbLeftTimeout = -1;
		g_breadcrumbRightTimeout = -1;
	}
}

function openRevisionHistoryModal(title, titleValue, revision) {
	if (titleValue == null || titleValue == "") {
		alert("데이터를 선택하세요.");
		return;
	}
	//var url = "/pcrf/policybuilder/common/revisionHistory.ajax";
	var url = "../common/revisionHistory.ajax";
	var param = new Object();
	param.title = title;
	param.titleValue = titleValue;
	// param.tblName = tblName;
	param.revision = revision;
	openModal(url, param, 500, 400);
}

// 저장 후 호출됨
function goListPage(bSaved, breadCrumbs) {
	if (!bSaved && checkChanged()) {
		return;
	}
	if (breadCrumbs != null && breadCrumbs != "") {
		var arr = breadCrumbs.split(",");
		var url = arr[0].substring(0, arr[0].lastIndexOf("/")) + "/list";
		var keyName = arr[1];
		var keyValue = arr[2];
		movePage(url, keyName, keyValue, "breadCrumbs", breadCrumbs);
	} else {
		movePage("list");
	}
}

// dynatree load 완료 후 호출됨
function getDetailPage(keyName, keyValue, paramBreadCrumbs) {
	showLoading($('#rightView'));
	var param = new Object();
	var url = "detail.ajax";
	if (paramBreadCrumbs != null && paramBreadCrumbs != "") {
		var arr = paramBreadCrumbs.split(",");
		var idx = (arr.length / 4 - 1) * 4;
		url = arr[idx] + ".ajax";
		keyName = arr[idx+1];
		keyValue = arr[idx+2];
		param[keyName] = keyValue;
		var breadCrumbs = "";
		for (var i=0;i<idx;i++) {
			if (breadCrumbs != "") {
				breadCrumbs += ",";
			}
			breadCrumbs += arr[i];
		}
		param.breadCrumbs = breadCrumbs;
	} else {
		param[keyName] = keyValue;
	}
	$.post(url, param, function(data) {
		history.pushState({}, "", "");
		$('#rightView').html(data);
		$('.boxRight').scrollTop(0);
	});
}

function movePage(url, keyName, keyValue) {
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
}

function activateLeftMenu(sName) {
	$("nav li a").each(function() {
		if ($(this).attr("href").indexOf("/"+sName+"/") > 0) {
			/*$(this).parent("li").addClass("active");
			return;*/
			focusLeftMenu($(this));
		}
	});
}

function checkChanged() {
	return false;
}

function bindCheckChangedEvent() {
	// 변경사항이 있는지 체크하고 넘어가도록 링크를 임시 변경
	// 메뉴
	$(".menu li a, #layoutMenu li a").each(function() {
		var href = $(this).attr("href");
		if (href != null) {
			if (href.indexOf("javascript:if (!checkChanged()){") != 0) {
				href = href.replace("javascript:","");
				if (href.indexOf("goLeftMenuPage(''") < 0) {
					// 좌측메뉴에서 단순 확장 메뉴일 경우는 해당 안됨
					$(this).attr("href", "javascript:if (!checkChanged()){"+href+"}");
				}
			}
		}
	});
	// 로고
	var logo = $("#layoutLogo header h1 img:first");
	var href = $(logo).attr("onclick");
	if (href != null) {
		if (href.indexOf("javascript:if (!checkChanged()){") != 0) {
			href = href.replace("javascript:","");
			$(logo).attr("onclick", "javascript:if (!checkChanged()){"+href+"}");
		}
	}
	// 로그아웃버튼
	var layoutLogo = $("#layoutLogo header h1 div a");
	var href = $(layoutLogo).attr("href");
	if (href != null) {
		if (href.indexOf("javascript:if (!checkChanged()){") != 0) {
			href = href.replace("javascript:","");
			$(layoutLogo).attr("href", "javascript:if (!checkChanged()){"+href+"}");
		}
	}
}

function countChar(str, ch) {
	var count = 0;
	for (var i=0;i<str.length;i++) {
		if (str[i] == ch) {
			count ++;
		}
	}
	return count;
}

function getBytes(msg) {
	var cnt = 0;
	for( var i=0; i< msg.length; i++) {
		cnt += (msg.charCodeAt(i) > 128 ) ? 2 : 1;
	}
	return cnt;
}

function initBreadCrumb() {
	$("div.breadcrumb > ul.crumbs > li").not(":last-child").click(function() {
		var url = $(this).data("url");
		var keyName = $(this).data("keyname");
		var keyValue = $(this).data("keyvalue");
		var releaseVer = $(this).data("releasever");
		goBreadCrumbPage(url, keyName, keyValue, releaseVer, $(this).index());
	});
	setTimeout("resetBreadCrumbButtons(true)", 100);
}

function getBreadCrumbs(idx) {
	if (idx == null) {
		idx = $("div.breadcrumb > ul.crumbs li").length;
	}
	var breadCrumbs = "";
	$("div.breadcrumb > ul.crumbs li:lt("+idx+")").each(function() {
		if (breadCrumbs != "") {
			breadCrumbs += ",";
		}
		breadCrumbs += $(this).data("url");
		breadCrumbs += "," + $(this).data("keyname");
		breadCrumbs += "," + $(this).data("keyvalue");
		breadCrumbs += "," + $(this).data("releasever");
	});
	return breadCrumbs;
}

window.onpopstate = function(event) {
	var len = $("div.breadcrumb > ul.crumbs > li").length;
	switch(len) {
	case 0:
		/*var breadCrumbs = $("#breadCrumbs");
		if (breadCrumbs.length > 0) {
			movePage(document.referrer, "breadCrumbs", breadCrumbs.val());
		} else {
			movePage(document.referrer);
		}*/
		break;
	case 1:
		/*var url = $("div.breadcrumb > ul.crumbs > li").first().data("url");
		url = url.substring(0, url.lastIndexOf("/")) + "/list";
		movePage(url);*/
		loadRightView();
		break;
	default:
		$("div.breadcrumb > ul.crumbs > li").not(":last-child").last().trigger("click");
		break;
	}
};

function goBreadCrumbPage(url, keyName, keyValue, releaseVer, idx) {
	$("#commonForm").remove();
	$("body").append("<form id=\"commonForm\" name=\"commonForm\"></form>");
	if (keyName != null && keyName != "" && keyValue != null && keyValue != "") {
		$("#commonForm").append("<input type=\"hidden\" name=\""+keyName+"\" value=\""+keyValue+"\"/>");
		if (isNotEmpty(releaseVer)) {
		    $("#commonForm").append("<input type=\"hidden\" name=\"releaseVer\" value=\""+releaseVer+"\"/>");
		}
		$("#commonForm").append("<input type=\"hidden\" name=\"breadCrumbs\" value=\""+getBreadCrumbs(idx)+"\"/>");
	}
	var param = $("#commonForm").serialize();
	showLoading($('#rightView'));
	$.post(url+".ajax", param, function(data) {
		history.pushState({}, "", "");
        $('#rightView').html(data);
    });
}

function showGlanceViewContextMenu(node) {
	$("#glanceViewContextMenu").remove();
	var updateUrl = "";
	var copyUrl = "";
	if (node.data.type == "UseCase") {
		updateUrl = "javascript:movePage('../usecase/update', 'name', '"+node.data.title+"')";
		copyUrl = "javascript:movePage('../usecase/copy', 'name', '"+node.data.title+"')";
	} else if (node.data.type == "RuleSet") {
		updateUrl = "javascript:movePage('../ruleset/update', 'ruleSetName', '"+node.data.title+"')";
		copyUrl = "javascript:movePage('../ruleset/copy', 'ruleSetName', '"+node.data.title+"')";
	} else if (node.data.type == "Rule") {
		updateUrl = "javascript:movePage('../rule/update', 'name', '"+node.data.title+"')";
		copyUrl = "javascript:movePage('../rule/copy', 'name', '"+node.data.title+"')";
	} else {
		return;
	}
	var top = $(node.li).position().top + 20 + $("#glanceViewTree").scrollTop();
	var left = $(node.li).position().left + $(node.li).children("span").width();
	var sHtml = "";
	sHtml += "<div id=\"glanceViewContextMenu\" class=\"layer_select\" style=\"top:"+top+"px;left:"+left+"px;\">";
	sHtml += "	<a href=\""+updateUrl+"\">수정</a>";
	sHtml += "	<a href=\""+copyUrl+"\">복제</a>";
	sHtml += "</div>";
	$("#glanceViewTree").prepend(sHtml);
}

function expandGlanceTreeAll() {
	$("#glanceViewContextMenu").remove();
	$("#glanceViewTree").dynatree("getRoot").visit(function(node){
	    node.expand(true);
	});
}

function collapseGlanceTreeAll() {
	$("#glanceViewContextMenu").remove();
	$("#glanceViewTree").dynatree("getRoot").visit(function(node){
	    node.expand(false);
	});
}

function showLoader(sMessage) {
	var sHtml = "";
	sHtml += "<table style=\"width:100%;background:white;\">";
	sHtml += "<tr>";
	sHtml += "<td align=\"center\"><p/><img src=\"/images/loading.gif\"/><p/>"+sMessage+"<br/>잠시만 기다려 주십시오.<p/></td>";
	sHtml += "<tr>";
	sHtml += "</table>";

	viewSecondLayer(sHtml, 100, 126);
}

function hideLoader() {
	closeSecondModal();
}

function openAffectedList(keyName, keyValue, layerNm) {
    //var url = "/pcrf/policybuilder/common/affectedList.ajax";
    var url = "../common/affectedList.ajax";
    var param = new Object();
    param.layerName = layerNm;
    //param.name = 'GUI_Policy_table_test01';
    param.keyName = keyName;
    param.keyValue = keyValue;
    openModal(url, param, 500, 400);
    return false;
}

function getAffectListMessage(data) {
	var sConfirm = "";
	var sServiceAffectText = "";
	var serviceAffectList = data.serviceAffectList;
	if (serviceAffectList != null) {
		for (var i=0;i<serviceAffectList.length;i++) {
			if (sServiceAffectText != "") {
				sServiceAffectText += ", ";
			}
			sServiceAffectText += serviceAffectList[i];
		}
		if (sServiceAffectText != "") {
			sConfirm += "\n\n※ Biz-Event\n" + sServiceAffectText + "";
		}
	}
	var sUseCaseAffectText = "";
	var useCaseAffectList = data.useCaseAffectList;
	if (useCaseAffectList != null) {
		for (var i=0;i<useCaseAffectList.length;i++) {
			if (sUseCaseAffectText != "") {
				sUseCaseAffectText += ", ";
			}
			sUseCaseAffectText += useCaseAffectList[i];
		}
		if (sUseCaseAffectText != "") {
			sConfirm += "\n\n※ Catalog\n" + sUseCaseAffectText + "";
		}
	}
	var sRuleSetAffectText = "";
	var ruleSetAffectList = data.ruleSetAffectList;
	if (ruleSetAffectList != null) {
		for (var i=0;i<ruleSetAffectList.length;i++) {
			if (sRuleSetAffectText != "") {
				sRuleSetAffectText += ", ";
			}
			sRuleSetAffectText += ruleSetAffectList[i];
		}
		if (sRuleSetAffectText != "") {
			sConfirm += "\n\n※ Rule-Set\n" + sRuleSetAffectText + "";
		}
	}
	var sRuleAffectText = "";
	var ruleAffectList = data.ruleAffectList;
	if (ruleAffectList != null) {
		for (var i=0;i<ruleAffectList.length;i++) {
			if (sRuleAffectText != "") {
				sRuleAffectText += ", ";
			}
			sRuleAffectText += ruleAffectList[i];
		}
		if (sRuleAffectText != "") {
			sConfirm += "\n\n※ Rule\n" + sRuleAffectText + "";
		}
	}
	var sPolicyTableAffectText = "";
	var policyTableAffectList = data.policyTableAffectList;
	if (policyTableAffectList != null) {
		for (var i=0;i<policyTableAffectList.length;i++) {
			if (sPolicyTableAffectText != "") {
				sPolicyTableAffectText += ", ";
			}
			sPolicyTableAffectText += policyTableAffectList[i];
		}
		if (sPolicyTableAffectText != "") {
			sConfirm += "\n\n※ Policy-Table\n" + sPolicyTableAffectText + "";
		}
	}
	var sPolicyVariableAffectText = "";
	var policyVariableAffectList = data.policyVariableAffectList;
	if (policyVariableAffectList != null) {
		for (var i=0;i<policyVariableAffectList.length;i++) {
			if (sPolicyVariableAffectText != "") {
				sPolicyVariableAffectText += ", ";
			}
			sPolicyVariableAffectText += policyVariableAffectList[i];
		}
		if (sPolicyVariableAffectText != "") {
			sConfirm += "\n\n※ Policy-Variable\n" + sPolicyVariableAffectText + "";
		}
	}
	return sConfirm;
}

// 한눈에보기 범례 표시
function showGlanceViewRemarkDiv(treeName) {
	if (treeName == null) {
		treeName = "glanceViewTree";
	}
	$("#"+treeName+"RemarkDiv").remove();
	var sHtml = "";
	sHtml += "<div id=\""+treeName+"RemarkDiv\">";
	sHtml += "	<table style=\"width:410px;float:right;\">";
	sHtml += "		<colgroup>";
	sHtml += "			<col width=\"5%\">";
	sHtml += "			<col width=\"20%\">";
	sHtml += "			<col width=\"5%\">";
	sHtml += "			<col width=\"20%\">";
	sHtml += "			<col width=\"5%\">";
	sHtml += "			<col width=\"20%\">";
	sHtml += "			<col width=\"5%\">";
	sHtml += "			<col width=\"20%\">";
	sHtml += "		</colgroup>";
	sHtml += "		<tr>";
	sHtml += "			<td><img src=\"/scripts/tree/skin/tree_map_purple.gif\"/></td><td>Biz-Event</td>";
	sHtml += "			<td><img src=\"/scripts/tree/skin/tree_map_d_blue.gif\"/></td><td>Catalog</td>";
	sHtml += "			<td><img src=\"/scripts/tree/skin/tree_map_blue.gif\"/></td><td>Rule-Set</td>";
	sHtml += "			<td><img src=\"/scripts/tree/skin/tree_map_d_green.gif\"/></td><td>Rule-Set/Rule</td>";
	sHtml += "		</tr>";
	sHtml += "		<tr>";
	sHtml += "			<td><img src=\"/scripts/tree/skin/tree_map_y_green.gif\"/></td><td>Rule</td>";
	sHtml += "			<td><img src=\"/scripts/tree/skin/tree_map_yellow.gif\"/></td><td>Condition</td>";
	sHtml += "			<td><img src=\"/scripts/tree/skin/tree_map_red.gif\"/></td><td>Action</td>";
	sHtml += "			<td><img src=\"/scripts/tree/skin/tree_map_piece.gif\"/></td><td>Leaf</td>";
	sHtml += "		</tr>";
	sHtml += "	</table>";
	sHtml += "</div>";
	$("#"+treeName).prepend(sHtml);
}

function expandUntil(type, treeName) {
	if (treeName == null) {
		treeName = "glanceViewTree";
	}
	$("#glanceViewContextMenu").remove();
	$("#"+treeName).dynatree("getRoot").visit(function(node){
		if ((type == "service" && node.data.icon == "tree_map_purple.gif")
				|| (type == "usecase" && (node.data.icon == "tree_map_purple.gif" || node.data.icon == "tree_map_d_blue.gif")
						|| (node.data.icon == "tree_map_yellow.gif" && node.parent.data.icon == "tree_map_d_blue.gif") || node.data.icon == "tree_map_d_green.gif")
				|| (type == "ruleset" && (node.data.icon == "tree_map_purple.gif" || node.data.icon == "tree_map_d_blue.gif"
						|| (node.data.icon == "tree_map_yellow.gif" && node.parent.data.icon == "tree_map_d_blue.gif") || node.data.icon == "tree_map_d_green.gif" || node.data.icon == "tree_map_blue.gif"))
				) {
		    node.expand(true);
		} else {
			node.expand(false);
		}
	});
}

function iframeSubmit(url, param, idx) {
	var iframeId = "commonIframe" + idx;
	var iframeSelector = "#" + iframeId;
	var formId = "commonForm" + idx;
	var formSelector = "#" + formId;
	$(iframeSelector).remove();
	$(formSelector).remove();
	$("body").append("<iframe id=\""+iframeId+"\" name=\""+iframeId+"\" style=\"display:none;\"></iframe>");
	$("body").append("<form id=\""+formId+"\" name=\""+formId+"\" style=\"display:none;\"></form>");
	for (var i=0;i<param.length;i++) {
		var obj = param[i];
		var keyName = obj.keyName;
		var keyValue = obj.keyValue;
		if (keyName != null && keyName != "" && keyValue != null && keyValue != "") {
			$(formSelector).append("<input type=\"hidden\" name=\""+keyName+"\" value=\""+keyValue+"\"/>");
		}
	}
	$(formSelector).attr("method", "post");
	$(formSelector).attr("target", iframeId);
	$(formSelector).attr("action", url);
	$(formSelector).submit();
}

function showLoading(target, margin) {
	var top = null;

	if(margin == null || margin == "") top = "100px";
	else top = margin + "px";

	var loadImage = "<div id='loadZone'><span style='font:13px Arial; display:block; width:50px; height:50px; padding:60px 0 0 0; margin:" + top + " auto 0 auto; background:url(/images/loading.gif) no-repeat'>loading</span></div>";

    target.children().remove();
    target.append(loadImage);
}

function updateAPcrfProgressBarWidth(nPercent) {
	$("#aPcrfProgressBar").css("width", nPercent+"%");
	$("#aPcrfProgressText").text(nPercent+"%");
}

function showProgressLoader(sStartMessage, fSuccCallback, nTimeout, bShowPercent) {
	if (nTimeout == null) {
		nTimeout = 500;
	}
	if (bShowPercent == null) {
		bShowPercent = true;
	}

	var sHtml = "";
	sHtml += "<table style=\"width:100%;background:white;\">";
	if (bShowPercent) {
		sHtml += "<tr>";
		sHtml += "<td style=\"background-color:black;width:100%;height:20px;padding:0px 0px 0px 0px;\" valign=\"top\">";
		sHtml += "<div id=\"aPcrfProgressBar\" style=\"width:0%;height:20px;background-color:red;position:absolute;\"></div>";
		sHtml += "<div id=\"aPcrfProgressText\" style=\"width:100%;height:20px;position:absolute;text-align:center;background-color:transparent;color:white;padding-top:3px;\">0%</div>";
		sHtml += "</td>";
		sHtml += "</tr>";
	} else {
		sHtml += "<tr>";
		sHtml += "<td style=\"background-color:white;width:100%;height:20px;padding:0px 0px 0px 0px;\" valign=\"top\">";
		sHtml += "</td>";
		sHtml += "</tr>";
	}
	sHtml += "<tr>";
	sHtml += "<td align=\"center\"><p/><img src=\"/images/loading.gif\"/><p/>";
	if (sStartMessage != null) {
		sHtml += sStartMessage+"<br/>";
	}
	sHtml += "잠시만 기다려 주십시오.<p/></td>";
	sHtml += "<tr>";
	sHtml += "</table>";

	viewSecondLayer(sHtml, 100, 146);

	nUpdateProgressTimeout = setTimeout(function() {
		updateProgress(fSuccCallback, nTimeout);
	}, nTimeout);
}

var nUpdateProgressTimeout;
function updateProgress(fSuccCallback, nTimeout) {
	var param = new Object();
	$.ajax({
		url : "getExportActionProgress.json",
		type : "post",
		data : param,
		processData : false,
		contentType : false,
		success : function(data) {
			var result = data.result;
			updateAPcrfProgressBarWidth(result);
			if (result < 100) {
				nUpdateProgressTimeout = setTimeout(function() {
					updateProgress(fSuccCallback, nTimeout);
				}, nTimeout);
			} else {
				if (fSuccCallback != null) {
					fSuccCallback();
				}
				resetExportActionProgress();
			}
		},
		error : function() {
			resetExportActionProgress();
		}
	});
}

function resetExportActionProgress() {
	clearTimeout(nUpdateProgressTimeout);
	closeSecondModal();
	var param = new Object();
	$.ajax({
		url : "resetExportActionProgress.json",
		type : "post",
		data : param,
		processData : false,
		contentType : false,
	});
}

function initDivSize() {
	var splitterHeight = parseInt($('#box_cols>.boxLeft').css('min-height'), 10);
    if (window.innerHeight - $('#box_cols').offset().top - 30 > splitterHeight) {
        splitterHeight = window.innerHeight - $('#box_cols').offset().top - 30;
    }
    console.log("==> splitterHeight : " + splitterHeight);
    //splitter
    $('#box_cols').height(splitterHeight).split({orientation:'vertical', limit:250, position:'34%', onDragEnd:function() {
    	resetBreadCrumbButtons(true);
    }});
    $("#treeView").height(splitterHeight-32);
    $("#rightView").height(splitterHeight-52);
    $("#rightView").css("overflow-y", "auto");
}


function getDispNameEditFlag(flag) {
	if (flag === 0) {
		return "편집 불가능";
	} else {
		return "편집 가능";
	}
}

function getDispNameEnumFlag(flag) {
    if (flag === 0) {
        return "미지원";
    } else {
        return "지원";
    }
}

function getDispNameValueType(type) {
    switch (type) {
    case 0 :
    	return "문자 형";
    case 1 :
    	return "숫자 형(int, long)";
    case 2 :
    	return "Float 형";
    case 3 :
    	return "time_t 형";
    case 4 :
    	return "날짜형";
    case 5 :
    	return "CSV 형";
    case 6 :
    	return "Binary 형";
    }
}

function openImportHistoryModal() {
	var url = "/pcrf/policybuilder/apcrfservice/importHistory.ajax";
	openModal(url, null, 1000, 600)
}


/**
 * 파라미터가 비어있는지 체크함.
 * isEmpty('')     === true
 * isEmpty(' ') === false
 * isEmpty([])     === true
 * isEmpty([1]) === false
 * isEmpty({})     === true
 * isEmpty({a:1}) === false
 * isEmpty(1)     === false
 * isEmpty(1.1)    === false
 * @param s : parameter - 문자열, 숫자, 배열, 오브젝트,
 * @returns {Boolean}
 */
function isEmpty(s) {
    if (s === undefined || s === null) {
        return true;
    } else
    if (s.constructor === String && s.length === 0) {
        return true;
    } else
    if (s.constructor === Array && s.length === 0) {
        return true;
    } else
    if (s.constructor === Object) {
        for (var k in s) return false; return true;
    } else {
        return false;
    }
}

/**
 * 파라미터가 비어있지 않은지 체크함.
 * @param s
 * @returns {Boolean}
 */
function isNotEmpty(s) {
    return !isEmpty(s);
}


function defaultString(s) {
    return defaultString(s, "");
}

function defaultString(s, defaultStr) {
    return (s === undefined || s === null) ? defaultStr : s;
}


// ===================================================================================
// default writable:false, enumarable: false, configurable: false
const VALUE_TYPE = {};
Object.defineProperty(VALUE_TYPE, 'String',     { value: 0 });
Object.defineProperty(VALUE_TYPE, 'Number',     { value: 1 });
Object.defineProperty(VALUE_TYPE, 'Float',      { value: 2 });
Object.defineProperty(VALUE_TYPE, 'time_t',     { value: 3 });
Object.defineProperty(VALUE_TYPE, 'Date',       { value: 4 });
Object.defineProperty(VALUE_TYPE, 'CSV',        { value: 5 });
Object.defineProperty(VALUE_TYPE, 'Binary',     { value: 6 });

const REFERENCE_TYPE = {};
Object.defineProperty(REFERENCE_TYPE, 'String',         { value: 0 });
Object.defineProperty(REFERENCE_TYPE, 'Number',         { value: 1 });
Object.defineProperty(REFERENCE_TYPE, 'PCC_Profile',    { value: 2 });
Object.defineProperty(REFERENCE_TYPE, 'SVC_Profile',    { value: 3 });
Object.defineProperty(REFERENCE_TYPE, 'Policy_Variable',{ value: 4 });
Object.defineProperty(REFERENCE_TYPE, 'Policy_Table',   { value: 5 });
Object.defineProperty(REFERENCE_TYPE, 'float',          { value: 6 });
Object.defineProperty(REFERENCE_TYPE, 'Related_99',     { value: 99});

const ARG_DEPTH = {};
Object.defineProperty(ARG_DEPTH, 'No_Reference',{ value: 0 });
Object.defineProperty(ARG_DEPTH, 'Instance',    { value: 1 });
Object.defineProperty(ARG_DEPTH, 'Property',    { value: 2 });
Object.defineProperty(ARG_DEPTH, 'Output',      { value: 3 });

const USE_WAY = {};
Object.defineProperty(USE_WAY, 'Condition_Only',{ value: 0 });
Object.defineProperty(USE_WAY, 'Action_Only',   { value: 1 });
Object.defineProperty(USE_WAY, 'Both',          { value: 2 });

const ACTION_TYPE = {};
Object.defineProperty(ACTION_TYPE, 'Control_Action',{ value: 0 });
Object.defineProperty(ACTION_TYPE, 'Flow_Action',   { value: 1 });

const ARG_TYPE = {};
Object.defineProperty(ARG_TYPE, 'Instance',     { value: 0 });    // without quotation
Object.defineProperty(ARG_TYPE, 'String',       { value: 1 });    // with quotation

const FACTOR_INFO_SOURCE = {};
Object.defineProperty(FACTOR_INFO_SOURCE, 'Factors',    { value: 0 });    // FACTOR/ITEM/SUB_ITEM Table
Object.defineProperty(FACTOR_INFO_SOURCE, 'Inst_Ref',   { value: 1 });    // INSTANCE & REFERENCE

const HAS_TYPE = {}; // COMMAND_TYPE, FACTOR_TYPE, ITEM_TYPE, ENUM_FLAG
Object.defineProperty(HAS_TYPE, 'HAS-NOT',  { value: 0 });
Object.defineProperty(HAS_TYPE, 'HAS-A',    { value: 1 });


const FACTOR_CAT_ID = {};
Object.defineProperty(FACTOR_CAT_ID, 'PCEF-Request'    ,{ value: 1 });
Object.defineProperty(FACTOR_CAT_ID, 'AF-Request'      ,{ value: 2 });
Object.defineProperty(FACTOR_CAT_ID, 'DPI-Request'     ,{ value: 3 });
Object.defineProperty(FACTOR_CAT_ID, 'IP-CAN-Session'  ,{ value: 4 });
Object.defineProperty(FACTOR_CAT_ID, 'DPI-Session'     ,{ value: 5 });
Object.defineProperty(FACTOR_CAT_ID, 'Subscriber-Info' ,{ value: 6 });
Object.defineProperty(FACTOR_CAT_ID, 'Indication'      ,{ value: 7 });
Object.defineProperty(FACTOR_CAT_ID, 'DIAMETER-Message',{ value: 8 });
Object.defineProperty(FACTOR_CAT_ID, 'Policy-Table'    ,{ value: 9 });
Object.defineProperty(FACTOR_CAT_ID, 'Policy-Variable' ,{ value: 10 });
Object.defineProperty(FACTOR_CAT_ID, 'PCC-Profile'     ,{ value: 11 });
Object.defineProperty(FACTOR_CAT_ID, 'Service-Profile' ,{ value: 12 });
Object.defineProperty(FACTOR_CAT_ID, 'ToD 상품'        ,{ value: 13 });
Object.defineProperty(FACTOR_CAT_ID, 'ToD 종합 결과'  ,{ value: 14 });
Object.defineProperty(FACTOR_CAT_ID, 'Request-Info'    ,{ value: 15 });

(function() {
    'use strict';
    var root = this;
    var rowNumOfCondition = 0;
    var rowNumOfAction = 0;
    var rowNum = 0;
    var RowNumMgmt;
    if (typeof exports !== 'undefined') {
        RowNumMgmt = exports;
    } else {
        RowNumMgmt = root.RowNumMgmt = {};
    }
    RowNumMgmt.createRowNumCondition = function() {
        return rowNumOfCondition++;
    }
    RowNumMgmt.createRowNumAction = function() {
        return rowNumOfAction++;
    }
    RowNumMgmt.createRowNum = function() {
        return rowNum++;
    }
}).call(this);
