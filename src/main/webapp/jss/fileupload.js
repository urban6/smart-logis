/*********************************************************************************************
* Ajax로 File +Data CUD 처리                                                                         *
*********************************************************************************************/
function setAjaxFileData(formId, obj, successCallback, failedCallback){
	$("#"+formId).ajaxForm({
		type:obj.type,
		url:obj.url,
		dataType:obj.dataType,
		beforeSend : function() {
			showLoading();
		},
		success : function(data){
			
			var returnObj = JSON.parse(data);
			
        	if(returnObj.resultMsg =="OK"){
        		successCallback(returnObj);
        	} else {
        		failedCallback(returnObj);
        	}
   		},
   		error: function(e){
   			alert(e.reponseText);
   		},
   		complete : function() {
   			hideLoading(true);
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