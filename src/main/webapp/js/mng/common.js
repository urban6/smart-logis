// 임시 개발 확인용
var devFlag = false;
$(function(){
	var cntrlIsPressed = false;
	$(document).keydown(function(event){ if(event.which=="17"){ cntrlIsPressed = true; }	});
	$(document).keyup(function(){ cntrlIsPressed = false; });
	$(document).keydown(function(event){		
		if (cntrlIsPressed ){
			if(event.which=="81"){
				if ( devFlag ){ hideDev(); } else { showDev(); }
			}
		}
	});
});
function showDev(){
	$("input[type='text'], input[type='password'], select, textarea").each(function(){
		var pos = $(this).offset();
		if ( $(this).attr("name") == undefined ){
			$("body").append("<div class='inputDebug' style='left:"+pos.left+"px; top:"+pos.top+"px; background-color:orange;'>#"+ $(this).attr("id") +"</div>");
		} else {
			$("body").append("<div class='inputDebug' style='left:"+pos.left+"px; top:"+pos.top+"px;'>@"+ $(this).attr("name") +"</div>");
		}		
	});
	$("form").addClass("Debug");	
	devFlag = true;
}
function hideDev(){
	$(".inputDebug").remove();
	$("form").removeClass("Debug");
	devFlag = false;
}







// GNB 하일라이트
$(function(){
	var gnb_cd = $("#gnb_cd").val();	
	$("#gnb li."+gnb_cd).addClass("active");
});

// 상단 네비게이션 영역
$(function(){
	var navi1_nm = $("#navi1_nm").val();
	var navi2_nm = $("#navi2_nm").val();
	var navi1_url = $("#navi1_url").val();
	if ( $.trim(navi1_nm) == "" ){ $("#navigationArea").hide(); }
	if ( $.trim(navi2_nm) == "" ){ $("#navigationArea li").eq(1).hide(); }
	$("#navigationArea li").eq(0).find("a").text(navi1_nm);
	$("#navigationArea li").eq(0).find("a").attr("href", navi1_url);
	$("#navigationArea li").eq(1).find("span").text(navi2_nm);
	if (navi2_nm != undefined && navi2_nm != "") {
		$("#navigationArea li").eq(0).find("a").attr("href", $("#navi1_url_mod").val());
	} else {
		$("#navigationArea li").eq(0).addClass("last-child");
	}
});


/* Link, Popup Modula */
function goLink(URL) {
	location.href = URL;
}
function goPopup(URL) {
	window.open(URL);
}

/* Page Inner Popup */
function showModal(URL){
	hideModal();

	$.ajax({
		type : "GET",
		url :  URL,
		cache : false,
		success : function(data){
			if ( data ){
				$("#popupArea").append($.trim(data)).show();
				$("#popupArea .popup").bPopup();
			}
		},
		error : function(request,status,error){
			//alert("Server Connection Failure");
		}
	});
}
function hideModal(){
	$(".popup").bPopup().close();
	$(".popup").remove();
	$("#popupArea").html("");
}

function showModalTimer(URL){
	hideModalTimer();
	setTimeout(function(){
		$.ajax({
			type : "GET",
			url :  URL,
			cache : false,
			success : function(data){			
				if ( data ){
					$("#popupArea").append($.trim(data)).show();				
					$("#popupArea .popup").bPopup();							
				}			
			},
			error : function(request,status,error){
				//alert("Server Connection Failure");
			}
		});	
	}, 100);
}
function hideModalTimer(){
	$(".popup").bPopup().close();
		setTimeout(function(){
		$(".popup").remove();
		$("#popupArea").html("");	
	}, 100);
}

/**
 * NHN Editor 호출
 * @returns
 */
$(function() {
	var oEditors = [];
	$("textarea[name].nhneditor").each(function(){
		var editorNm = $(this).attr("name");
		var editorId = "nhneditor_"+ (Math.floor(Math.random() * 999) + 111).toString() +  (Math.floor(Math.random() * 999) + 111).toString();
		$(this).attr("id", editorId);
		
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: editorId,	
			sSkinURI: "/resources/lib/se2/SmartEditor2Skin.html",
			fCreator: "createSEditor2",
			htParams: { fOnBeforeUnload : function(){	}}
		});

		setInterval(function(){
			if ( $("#"+editorId).val() != oEditors.getById[editorId].getIR() ){			
				$("#"+editorId).val( oEditors.getById[editorId].getIR() );
			}
		}, 100);		
	});		
});	


/***
 * (버튼) 로그아웃 
 * @returns
 */
function logout(){
	alert("로그아웃 되었습니다.");
	location.href="../member/logout";
}

