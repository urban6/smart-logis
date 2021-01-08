//clsoe시 삭제할 modal select array
var modalCloseList = [];
// 윈도우 창 크기 변경시 호출 됨
$(window).resize(function(){
	// overlay 크기 변경
	$("div[name='overlay']").css({
		width:$(document).innerWidth() + "px",
		height:$(document).innerHeight() + "px"
	});
	
	// container 중앙 정렬
	var container = $("div[name='container']");
	for(var i = 0; i < container.length; i++){
		container[i].style.top = (window.innerHeight - container.eq(i).height())/2 +"px";
		container[i].style.left = (window.innerWidth - container.eq(i).width())/2 + "px";
	}
});

// modla 창 open 함수
// selector : jquery selector string(ex:"#testDiv")
// option : simplemodal options, http://www.ericmmartin.com/projects/simplemodal/
// draggableSelector : draggable jquery selector(ex:"#testDiv")
// isTempModal : if isTempModal is true, modal tag removed after modal closed
function openModal(selector, option, draggableSelector, isTempModal) {
	// 같은 ID를 사용하는 활성화 된 모달이 존재시 return
	if(selector.indexOf("#") >= 0 && $(selector+".simplemodal-data").length > 0){
		return;
	}
	
	var defaultOption = new Object();
	defaultOption.escClose = false;
	defaultOption.focus = false;	
	option = $.extend({}, defaultOption, option);
		
	// 이미 모달이 존재하면 컨테이너에 모달을 추가한다.
	if(hasModal()){
		// option에 zIndex를 입력한 경우 사용하고 아니면 기본값 사용
		addOverlay(option.zIndex || $.modal.defaults.zIndex + 2);
		appendModal(selector, option);
	}
	// 모달이 없다면 새로 만든다.
	else{
		$(selector).modal(option);		
	}
	
	// draggableSelector이 매개변수로 입력시 해당 selector가 draggable 상태가 된다
	if(draggableSelector){
		$(selector).parents(".simplemodal-container").draggable({
			handle: draggableSelector,
			containment: "window",
			drag:function(event, ui){
				// select box 목록이 open시 모달창과 같이 움직이지 않는 현상보완
				multiSelectReposition();
			}
				
		});
	}
	
	// close event binding
	// 모달창 헤더의 "X"버튼의 onclick 이벤트 unbind
	// unbind 하지 않으면 먼저 바인딩된 jquery라이브러리의 $.modal.close()가 먼저 실행되어 에러 발생
	$(".simplemodal-close").unbind('click');
	
	// closeModal을 사용하도록 이벤트 바인딩
	$(".simplemodal-close").click(function(event){
		closeModal(selector, isTempModal);
	});
	
	// ok 버튼에 항상 포커스, ok버튼 클래스(primary) 변경시 소스도 변경해야함
	$(selector).find("button.primary").focus();
	
	//close시 삭제할 selector
	if(isTempModal && modalCloseList.indexOf(selector) < 0){
		modalCloseList.push(selector);
	}
}

/**
 * 모달 창을 닫는 펑션
 * selector에 해당 하는 모달창을 닫는다.
 * selector를 입력하지 않으면 모든 모달창들과 overlay를 닫는다.
 * @param selector : 닫으려는 모달창의 jquery selector
 */
function closeModal(selector, isTempModal) {
	// 매개변수 selector를 입력하지 않으면 모든 모달 창을 닫는다.
	if(!selector){
		$.modal.close();
		return;
	}
	
	var container = $(".simplemodal-container").has($(selector));

	if(container.length == 0){
		container = $("#simplemodal-container")
	}
	
	// overlay를 삭제한다.
	var overlay = container.prev(".simplemodal-overlay, [name='overlay']");
	overlay.remove();
	
	if(!isTempModal){
		$('body').append($(selector));
	}
	$(selector).removeClass("simplemodal-data");
	$(selector).hide();
	
	// 해당 모달창을 삭제한다.
	container.remove();
	
	// 삭제 후 남아 있는 모달이 없으면 #simplemodal-overlay도 닫고 selector는 삭제한다.
	if(!hasModal()){
		$.modal.close();

		if(modalCloseList){
			for(var i = 0; i < modalCloseList.length; i++){
				$(modalCloseList[i]).remove();
			}
		}
	}
	
	if(isTempModal){
		$(selector).html("");
	}
}

/**
 * 열려있는 모달이 있는지 확인하는 펑션
 * @returns 열려있는 모달이 있으면 true 아니면 false를 반환한다
 */
function hasModal(){	
	return countModal() > 0 ? true : false;
}

/**
 * 열려있는 모달창의 개수를 확인하는 펑션
 */
function countModal(){
	return $(".simplemodal-wrap").length;
}

/**
 * 이미 모달창에 존재하는 메시지인지 확인한다.
 * 메시지가 현재 h4태그에 표시되는데 HTML구조가 변경될 수 있어 html 문자열을 모두 가져와 검색합니다.
 * @param modalMsg : 모달 창에 띄울 메시지
 * @returns boolean : 이미 존재하는 메시지일 경우 true, 아니면 false를 리턴한다.
 */
function isExistModalMsg(modalMsg){
	
	// 존재함
	var sHtml = $('.popup .alert_txt01').html();
	if(sHtml && sHtml.indexOf(modalMsg) !== -1){
		return true;
	}
	
	//존재 안 함
	return false;
}

/**
 * 컨테이너에 모달을 추가하는 펑션
 * 기존 jquery.simple.js는 1개의 모달창만 만들 수 있다.
 * 모달 창 중첩 기능 구현을 위하여 해당 펑션을 제작함
 * @param	selector : 새롭게 모달을 띄울 태그의 jquery selector
 */
function appendModal(selector, options){
	
	var modalOption = $.extend({}, $.modal.defaults, options);
	
	var modalId = $(selector).attr('id') || modalOption.dataId + countModal();
	
	var modalWidth = $(selector).width();
	var modalHeight = $(selector).height();
	
	var modal = $(selector)
				.attr('id', modalId)
				.addClass('simplemodal-data')
				.css($.extend(modalOption.dataCss, {
					display: 'none'
				}))
				.show();

	var wrapper = $('<div></div>')
					.attr('tabIndex', -1)
					.addClass('simplemodal-wrap')
					.css({outline: 0, position :'absolute'});

	var container = $('<div name="container"></div>')
					.addClass('simplemodal-container')
					.css($.extend(
						{position: 'fixed'},
						modalOption.containerCss,
						{display: 'none', zIndex: modalOption.zIndex + 2}
					))
					.append(modalOption.close && modalOption.closeHTML
						? $(modalOption.closeHTML).addClass(modalOption.closeClass)
						: '')
					.show();
	
	// element 추가
	wrapper.append(modal);
	$(selector).remove();
	container.append(wrapper);
	container.appendTo(modalOption.appendTo);

	container.height(modalHeight);
	container.width(modalWidth);
	
	var containerTop = window.innerHeight/2 - container.outerHeight(!0)/2;
	var containerLeft = $(window).width()/2 - container.outerWidth(!0)/2;
	container.css({top:containerTop + 'px', left:containerLeft + 'px'});
}

/**
 * overlay 추가하는 펑션
 * @param zIndex : 오버레이의 zIndex
 * @returns
 */
function addOverlay(zIndex){
	var overlayHeight = document.body.scrollHeight > document.body.clientHeight ? document.body.scrollHeight : document.body.clientHeight;
	var overlayWidth = document.body.scrollWidth > document.body.clientWidth ? document.body.scrollWidth : document.body.clientWidth;
	$("body").append('<div name="overlay" style="background-color:rgba(227, 229, 232, 0.9);height:'+ overlayHeight +'px; width:'+ overlayWidth +'px; position: fixed; left: 0px; top: 0px; z-index:'+ zIndex +';"></div>');
}


/**
 * 가장 마지막에 열린 overlay를 닫는 펑션
 * @returns
 */
function closeLastOverlay(){
	$("div[name='overlay']").last().remove();
}

/*
 * openConfirmModal("Message", "Description", function() {console.log("ok");}, function() {console.log("cancel")}, "OK", "Cancel");
 */
function openConfirmModal(sMessage, sDescription, fnOK, fnCancel, sOK, sCancel, bModal) {
	if (sMessage == null) {
		sMessage = "";
	}
	if (sDescription == null) {
		sDescription = "";
	}
	
	// sMessage가 ""이고 sDescription가 ""가 sMessage = sDescription, sDescription = ""
	// 이는 모달 타이틀의 글자색이 검은색이고 모달 설명이 회색인데
	// 글자색을 모두 검정색으로 바꿔달라는 요청이 있었기 때문입니다.
	// ex)openAlertModa("",errorMsg); 이런 경우에 글자색이 회색으로 나오고 있었습니다.
	if(sMessage === "" && sDescription !== ""){
		sMessage = sDescription;
		sDescription = "";
	}
	
	if (sOK == null) {
		sOK = "Continue";
	}
	if (sCancel == null) {
		sCancel = "Go Back";
	}
	if (bModal == null) {
		bModal = true;
	}

	var divID = "confirmModalDiv" + countModal();
	var divSelector = "#" + divID;
	var okID = "confirmModal_okButton" + countModal();
	var okSelector = "#" + okID;
	var cancelID = "confirmModal_cancelButton" + countModal();
	var cancelSelector = "#" + cancelID;
	var closeID = "confirmModal_closeButton" + countModal();
	var closeSelector = "#" + closeID;
	
	var sHtml = "";
	sHtml += "<div id=\"" + divID + "\" class=\"popup w380\">\n";
	sHtml += "	<div class=\"p_header\">\n";
	sHtml += "		<p class=\"title\">"+stringToHtml(sMessage)+"</p>\n";
	sHtml += "		<a href=\"#\" class=\"btn_close\"><em>닫기</em></a>\n";
	sHtml += "	</div>\n";
	sHtml += "	<div class=\"p_body min\">\n";
	sHtml += "		<p class=\"comment center\">\n";
	sHtml += "			"+stringToHtml(sDescription)+"\n";
	sHtml += " 		</p>\n";
	sHtml += "		<div class=\"p_btns\">\n";
	sHtml += "			<div class=\"center\">\n";
	sHtml += "				<a href=\"#\" id=\"" + cancelID +"\" class=\"btn_white btn_line_gray mr8\">"+sCancel+"</a>\n";
	sHtml += "				<a href=\"#\" id=\"" + okID +"\" class=\"btn_red\">"+sOK+"</a>\n";
	sHtml += "			</div>\n";
	sHtml += "		</div>\n";
	sHtml += "	</div>\n";
	sHtml += "</div>\n";

	/*sHtml += "<section id=\"" + divID + "\" class=\"popup\">\n";
	sHtml += "	<div class=\"pop_wrap\">\n";
	sHtml += "		<div class=\"pop_head\">\n";
	sHtml += "			<h1>"+stringToHtml(sMessage)+"</h1>\n";
	sHtml += "			<button class=\"btn close simplemodal-close\" type=\"button\" id=\"" + closeID +"\"></button>\n";
	sHtml += "		</div>\n";
	sHtml += "		<div class=\"pop_cont\">\n";
	sHtml += "			<p class=\"text_cont\">\n";
	sHtml += "					"+stringToHtml(sDescription)+"\n";
	sHtml += "			</p>\n";
	sHtml += "		</div>\n";
	sHtml += "		<div class=\"btn_area\">\n";
	sHtml += "			<button type=\"button\" id=\"" + cancelID +"\" class=\"btn type_01\">"+sCancel+"</button>\n";
	sHtml += "			<button type=\"button\" id=\"" + okID +"\" class=\"btn type_01 primary\">"+sOK+"</button>\n";
	sHtml += "		</div>\n";
	sHtml += "	</div>\n";
	sHtml += "</section>\n";*/
	$("body").append(sHtml);
	
	if (bModal) {
		$(okSelector).click(function() {
			closeModal(divSelector, true);
			if (fnOK != null) {
				fnOK.call();
			}
		});
		$(cancelSelector).click(function() {
			closeModal(divSelector, true);
			if (fnCancel != null) {
				fnCancel.call();
			}
		});
		$(closeSelector).click(function() {
			closeModal(divSelector, true);
			if (fnCancel != null) {
				fnCancel.call();
			}
		});
		
		var option = new Object();
		option.close = false;
		openModal(divSelector, option, null, true);
	} else {
		$(okSelector).click(function() {
			$(divSelector).hide();
			if (fnOK != null) {
				fnOK.call();
			}
		});
		$(cancelSelector).click(function() {
			$(divSelector).hide();
			if (fnCancel != null) {
				fnCancel.call();
			}
		});

		var left = ($(window).width() - $(divSelector).width()) / 2;
		var top = ($(window).height() - $(divSelector).height()) / 2;
		//$(divSelector).css("z-index", 1003);
		$(divSelector).css("left", left+"px");
		$(divSelector).css("top", top+"px");
		$(divSelector).css("position", "absolute");
		$(divSelector).show();
	}

	$(okSelector).focus();
}

/*
 * openAlertModal("Message", "Description", function() {console.log("ok");}, "OK");
 */
function openAlertModal(sMessage, sDescription, fnOK, sOK, bModal) {
	if (sMessage == null) {
		sMessage = "";
	}
	if (sDescription == null) {
		sDescription = "";
	}
	
	// sMessage가 ""이고 sDescription가 ""가 sMessage = sDescription, sDescription = ""
	// 이는 모달 타이틀의 글자색이 검은색이고 모달 설명이 회색인데
	// 글자색을 모두 검정색으로 바꿔달라는 요청이 있었기 때문입니다.
	// ex)openAlertModa("",errorMsg); 이런 경우에 글자색이 회색으로 나오고 있었습니다.
	if(sMessage === "" && sDescription !== ""){
		sMessage = sDescription;
		sDescription = "";
	}
	
	// 이미 존재하는 메시지일 경우 modal open하지 않고 function 종료
	//if(isExistModalMsg(sMessage)){
	//	return;
	//}
	
	if (sOK == null) {
		sOK = "OK";
	}
	if (bModal == null) {
		bModal = true;
	}

	var sHtml = "";
	var className = "";
	if (sMessage.toLowerCase() == "success") {
		className = "noti ok";
	} else if (sMessage.toLowerCase() == "warning") {
		className = "noti warning";
	} else if (sMessage.toLowerCase() == "fail" || sMessage.toLowerCase() == "error") {
		className = "noti fail";
	}
	var divID = "alertModalDiv" + countModal();
	var divSelector = "#" + divID;
	var okID = "alertModal_okButton" + countModal();
	var okSelector = "#" + okID;
	
	sHtml += "<section id=\"" + divID + "\" class=\"popup\">\n";
	sHtml += "	<div class=\"pop_wrap\">\n";
	sHtml += "		<div class=\"alert\">\n";
	sHtml += "			<p class=\""+className+"\">"+sMessage.toUpperCase()+"</p>\n";
	sHtml += "			<div class=\"text_cont\">\n";
	sHtml += "				"+sDescription+"\n";
	sHtml += "			</div>\n";
	sHtml += "			<div class=\"btn_area\">\n";
	sHtml += "				<button type=\"button\" id=\"" + okID +"\" class=\"btn type_01 primary\">"+sOK+"</button>\n";
	sHtml += "			</div>\n";
	sHtml += "		</div>\n";
	sHtml += "	</div>\n";
	sHtml += "</section>\n";
	$("body").append(sHtml);

	if (bModal) {
		$(okSelector).click(function() {
			closeModal(divSelector, true);
			if (fnOK != null) {
				fnOK.call();
			}
		});
		
		var option = new Object();
		option.close = false;
		openModal(divSelector, option, null, true);
	} else {
		$(okSelector).click(function() {
			$(divSelector).hide();
			if (fnOK != null) {
				fnOK.call();
			}
		});

		var left = ($(window).width() - $(divSelector).width()) / 2;
		var top = ($(window).height() - $(divSelector).height()) / 2;
//		$(divSelector).css("z-index", 1003);
		$(divSelector).css("left", left+"px");
		$(divSelector).css("top", top+"px");
		$(divSelector).css("position", "absolute");
		$(divSelector).show();
	}

	$(okSelector).focus();
}

// sMsgArray : array 형태
function openAlertListModal(sMsgArray, sTitle, fnOK, sOK, bModal) {
	/*if (sMessage == null) {
		sMessage = "";
	}*/
	if (sTitle == null) {
		sTitle = "";
	}
	if (sOK == null) {
		sOK = "OK";
	}
	if (bModal == null) {
		bModal = true;
	}

	var divID = "alertModalDiv" + countModal();
	var divSelector = "#" + divID;
	var okID = "alertModal_okButton" + countModal();
	var okSelector = "#" + okID;
	var sHtml = "";
	
	sHtml += "<section id=\"" + divID + "\" class=\"popup m\">";
	sHtml += "    <div class=\"pop_wrap\">";
	sHtml += "      <div class=\"pop_head\">";
	sHtml += "        <h1>Error</h1>";
	sHtml += "        <button class=\"btn close simplemodal-close\" type=\"button\" title=\"close\"></button>";
	sHtml += "      </div>";
	sHtml += "      <div class=\"pop_cont\">";
	sHtml += "        <div class=\"pop_area type_02\">";
	sHtml += "          <div class=\"board_top\">";
	sHtml += "            <div class=\"cell nth_01 total_result\">";
	sHtml += "              "+sTitle+" <span class=\"value\"><em>"+sMsgArray.length+"</em>rows</span>";
	sHtml += "            </div>";
	sHtml += "          </div>";
	sHtml += "          <div class=\"table type_06\">";
	sHtml += "            <div class=\"tbody\">";
	sHtml += "              <table>";
	sHtml += "                <colgroup>";
	sHtml += "                  <col width=\"70px\">";
	sHtml += "                  <col width=\"*\">";
	sHtml += "                </colgroup>";
	sHtml += "                <tbody>";
	$.each(sMsgArray, function(idx,item){
	sHtml += "                  <tr>";
	sHtml += "                    <td class=\"tac\">"+(idx+1)+"</td>";
	sHtml += "                    <td>"+item+"</td>";
	sHtml += "                  </tr>";
	});
	sHtml += "                </tbody>";
	sHtml += "              </table>";
	sHtml += "            </div>";
	sHtml += "          </div>";
	sHtml += "        </div>";
	sHtml += "        <div class=\"btn_area\">";
	sHtml += "			<a href=\"javascript:void(0);\">";
	sHtml += "          	<button type=\"button\" id=\"" +okID + "\" class=\"btn type_01 primary\">"+sOK+"</button>";
	sHtml += "          </a>";
	sHtml += "        </div>";
	sHtml += "      </div>";
	sHtml += "    </div>";
	sHtml += "  </section>";
	
	$("body").append(sHtml);

	if (bModal) {
		$(okSelector).click(function() {
			closeModal(divSelector, true);
			if (fnOK != null) {
				fnOK.call();
			}
		});
		
		var option = new Object();
		option.close = false;
		openModal(divSelector, option, null, true);
	} else {
		$(okSelector).click(function() {
			$(divSelector).hide();
			if (fnOK != null) {
				fnOK.call();
			}
		});

		var left = ($(window).width() - $(divSelector).width()) / 2;
		var top = ($(window).height() - $(divSelector).height()) / 2;
//		$(divSelector).css("z-index", 1003);
		$(divSelector).css("left", left+"px");
		$(divSelector).css("top", top+"px");
		$(divSelector).css("position", "absolute");
		$(divSelector).show();
	}
	
	$(okSelector).focus();
}

/**
 * open div modal
 * @param sDivId - target div id
 * @param sHtml - popup content
 */
function openDivModal(sDivId, sHtml){
	$("#"+sDivId).empty();
	$("#"+sDivId).remove();
	$("body").append(sHtml);

	$("#"+sDivId).css("position", "absolute");
	$("#"+sDivId).css("z-index", 1003);
	var left = ($(window).width() - $("#"+sDivId).width()) / 2;
	var top = ($(window).height() - $("#"+sDivId).height()) / 2;
	$("#"+sDivId).css("left", left+"px");
	$("#"+sDivId).css("top", top+"px");
	$("#"+sDivId).show();
	setScroll();
}

/**
 * close div modal
 * @param sDivId - target div id
 */
function closeDivModal(sDivId){
	$("#"+sDivId).empty();
	$("#"+sDivId).remove();
	setScroll();
}

/**
 * 팝업 존재 여부에 따라, Scroll 활성/비활성
 * (팝업 O : 비활성, 팝업 X : 활성)
 */
function setScroll(){
  if($('.popup.on').length){
    if($('html').hasClass('ie8')){
      $('html,body').scrollTop(0);
    }
    window.setTimeout(function(){
      $('body').addClass('oh')
    }, 50);
  }else{
    $('body').removeClass('oh');
  }
}
