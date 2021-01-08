/*********************************************************************************************
* Ajax로 File +Data CUD 처리                                                                         *
*********************************************************************************************/
function setAjaxFileData(formId, obj, successCallback, failedCallback){
	$("#"+formId).ajaxForm({
		type:obj.type,
		url:obj.url,
		dataType:obj.dataType,
		beforeSend : function() {
			loading();
		},
		success : function(data){
			loading(true);
			
			returnMsg = data.returnMsg;		// server Exception 처리
			resultMsg = data.resultMsg;
			
			if (returnMsg == "true"){
				fileName = data.fileName;
				successCallback(resultMsg,fileName);
			}else{
				failedCallback(resultMsg);
			}
   		},
   		error: function(e){
   			loading(true); 
   			alert(e.reponseText);
   		},
   		complete : function() {
   			loading(true);
   		}
	});
	$("#"+formId).submit();
}

function successFileUploadFn(res, fileName){
   	alert(res);
   	goSearch();
	/*$("#fileName").val(fileName);
	$("#td_upload_file_name").html("ded : "+fileName);
	$("#btn_file_delete").css("display", "block");*/
}	

function failFn(res){
	alert(res);
}	

function successFileDeleteFn(res, fileName){
   	alert(res);
	$("#fileName").val("");
	$("#td_upload_file_name").html("");
	$("#btn_file_delete").css("display", "none"); 
}	

function deleteFailFn(res){
	alert(res);
}	