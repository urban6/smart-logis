var $frmObj = null;
var $frmModalObj = null;
var validator = null; 

function fnLogOut() {
	var $form = $('<form></form>');
    $form.attr('action', '/management/login/logoutAction');
    $form.attr('method', 'post');
    $form.attr('target', '""');
    $form.appendTo('body');
    $form.submit();
}

//Search Form Submit
function frmSubmit(){
	$frmObj.attr("method", "post");
	$frmObj.attr("enctype", "");
	$frmObj.submit();
}

//Paging go Page Submit
function goPage(No){
	$("#page").val(No);
	frmSubmit();
}

//wysiwyg editor
function tinymce_init(seletorInfo) {
	tinymce.init({
		selector: seletorInfo,
		schema: 'html5',
		theme: 'modern',
		language_url : '../../scripts/tinymce/langs/ko_KR.js',
		height: 200,
		plugins: [
			'advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker',
			'searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking',
			'save table contextmenu directionality emoticons template paste textcolor'
		],
		//content_css: 'css/content.css',
		menubar: false, // removes the menubar
		// toolbar: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | print preview media fullpage | forecolor backcolor emoticons',
		toolbar: 'fontselect fontsizeselect | bold italic forecolor backcolor | alignleft aligncenter alignright | table link | code preview',
		statusbar: false // removes the menubar
	});
}

//wysiwyg editor save
function tinymce_save() {
	tinyMCE.triggerSave();
}

function initAddMethod() {
	$.validator.addMethod("compareDateGtelmnt", function(value, element, params) {
		return $.datepicker.parseDate('yy-mm-dd',$("#" + params.sDate).val()) <= $.datepicker.parseDate('yy-mm-dd',$("#" + params.eDate).val());
	}, "종료일자가 시작일자보다 이전입니다. 확인해주세요.");
	
	$.validator.addMethod("compareDateGeelmnt", function(value, element, params) {
		return $.datepicker.parseDate('yy-mm-dd',$("#" + params.sDate).val()) < $.datepicker.parseDate('yy-mm-dd',$("#" + params.eDate).val());
	}, "종료일자가 시작일자보다 같거나 그 이전입니다. 확인해주세요.");
	
	// ignore accept
	$.validator.addMethod("accept", function(value, element, params) {return true;});

	$.validator.addMethod("test", function(value, element, params) {
		alert("value : " + value + ", element : " + element);
		return false;
	}, "test");
}

function initValdate(formObj) {
	
	initAddMethod();

	validator = $(formObj).validate({
		//debug: true,   //debug가 true인 경우 validation 후 submit을 수행하지 않음
		focusCleanup: true,
		focusInvalid: false,
		onclick: false,
		onfocusout: false,
		onkeyup: false,
		ignore: '*:not([name])', //name을 부여하지 않은 tag ignore
		rules: {},
		messages: {},
		errorPlacement: function (error, element){
			console.log(error);
		},
		submitHandler: function(form) {
			if(typeof fnBeforSubmit === "function" && fnBeforSubmit(form) == false){
				return false;
			}
			form.submit();
		},
		invalidHandler: function(form, validator){
			var errors = validator.numberOfInvalids();
			if (errors) {
				alert(validator.errorList[0].message);
				validator.errorList[0].element.focus();
			}
		}
	});
}

/* Page Inner Popup */
function searchModal(URL){	
	hideModal();
	$.ajax({
		type : "POST",
		url :  URL,
		cache : false,
		data : $frmModalObj.serialize(),
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

/**
 * 파일업로드 체크 (최종본) - input type=text 사용 시
 */
function fileCheck (fileName, obj, txtId) {
	var tmpFileName = $(obj).val().substring($(obj).val().lastIndexOf("\\")+1, $(obj).val().length); 
	$("#" + txtId).val(tmpFileName === "" ? fileName : tmpFileName);
	return tmpFileName !== "";
}

/**
 * 파일업로드 체크 (수정본) 
 */
function file_check (fileName, obj) {
	var tmpFileName = $(obj).val().substring($(obj).val().lastIndexOf("\\")+1, $(obj).val().length); 
	// alert(fileName + " : " + "#span" + $(obj).attr("id") + " : " + tmpFileName + " : " + ($(obj).val() == ""));
	$("#span" + $(obj).attr("id")).text(tmpFileName === ""? fileName : tmpFileName);
	return tmpFileName !== "";
}

/**
 * 다중 첨부파일 추가 
 */
var lastId = 0;
var addFile = function(fileObj, txtFileObj, labelObj, ulFileObj) {
	if ($(fileObj).val() == "") return false;
	var limitSeq = 100; // 첨부파일  발급 제한 일련번호
	var lastIdArr = $("input:file[name^='fileTemp_']:last").attr("id");
	// lastId = lastIdArr != undefined && lastIdArr.length > 0 ? parseInt(lastIdArr.split("_")[1]): 1;
	
	if (lastId > limitSeq) {
		alert("파일 선택 할당 일련번호가 모두 소진되었습니다.\n화면을 새로고침 하세요.");
		$(fileObj).val("");
		return false;
	}
	
	lastId += 1;
	var idCnt = new String(lastId).lpad(3, "0");
	var $li= $("<li id='liFile_" + idCnt + "' style='display: flex;'></li>");
	
	// 가변 생성 파일정보 저장을 위한 span
	$li.append($("<span id='spanFile_" + idCnt + "'>" + ($(fileObj).val().substring($(fileObj).val().lastIndexOf("\\")+1, $(fileObj).val().length)) + "</span>"));
	
	// 가변 생성 File Object
	var cloneElmt = $(fileObj).clone(true);
	cloneElmt.attr('id', 'fileTemp_' + idCnt);
	cloneElmt.attr('name', 'fileTemp_' + idCnt);
	cloneElmt.addClass('tmpMultiFile');
	cloneElmt.attr("accept", ".jpg,.png");
	//$li.append(cloneElmt);
	$(fileObj).after(cloneElmt);
	$li.append($(fileObj));
	
	//	chage Lavel
	$(labelObj).attr("for", $(cloneElmt).attr("id"));

	// 가변 생성 파일 span 삭제 span
	$li.append("<div onclick=\"javascript:deleteFileById('" + $li.attr("id") + "')\"  style=\"cursor: pointer;\"><img src=\"/image/mng/icon_clear.png\" width=\"15\" height=\"15\" style=\"vertical-align: middle;\"></div>");
	$(cloneElmt).val("");
	$(txtFileObj).val("");

	$(ulFileObj).append($li);
}

/**
 * 첨부파일 삭제 
 */
var deleteFileById = function(fileId) {
	$frmObj.find("#" + fileId).remove();
}

//1 file upload
function fileUpload(data_seq, data_cd, data_cd2, inpObj) {
	var rtnSeq = 0;
	

	if ($(inpObj).val() == undefined || $(inpObj).val() == "") {
		return rtnSeq;
	}
	
	$frmObj.attr("action", "../comFile/upload");
	$frmObj.attr("method", "POST");
	$frmObj.attr("enctype", "multipart/form-data");
	$frmObj.attr("accept-charset", "utf-8");
	
	var formData = new FormData($frmObj);
	formData.append("data_seq", data_seq); // 게시물 번호
	formData.append("data_cd", data_cd); // 데이터 코드 (대분류)
	formData.append("data_cd2", data_cd2); // 데이터 코드 (중분류)
	formData.append($(inpObj).attr('id'), inpObj[0].files[0]); // 첨부파일 정보
	
	$.ajax({
     url : $frmObj.attr("action"),
     type : 'POST',
     dataType : "json",
     data : formData,
		async : false,
		cache : false,
		contentType : false, // tell jQuery not to process the data
		processData : false, // tell jQuery not to set contentType
     success : function(data) {
        	if (data.rtnFlag == 'Y') {
        		rtnSeq = data.rtnSeq;
        	}
     },
     error: function(request,status,error){
     	var err = JSON.parse(request.responseText);
			alert(err.errorMsg.localizedMessage);
     },
     complete : function() {
     }
	});
	
	return rtnSeq;
}

// number type commna add
function numberWithCommas(xobj) {
	$(xobj).val($(xobj).val().toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
}

// number type commna remove
function removeCommas(xobj) {
	$(xobj).val($(xobj).val().toString().replace(",", ""));
}

// lpad
String.prototype.lpad = function(n, str) { 
     return Array(n - String(this).length + 1).join(str || '0') + this;  // 참고 설명
}

// rpad
String.prototype.rpad = function(n, str) { 
     return this + Array(n - String(this).length + 1).join(str || '0');  
}

//숫자 여부 확인
function isNumber(value) {
  return typeof value === 'number' && isFinite(value);
}