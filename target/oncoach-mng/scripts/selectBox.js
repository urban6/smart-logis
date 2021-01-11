/**
 * option 항목
 * A all
 * S select
 * N null
 * */

function getOptionItem(target,command,option){
	var param = 'command='+command;

	var nlen = arguments.length;
	var i = 3;
	for(i; i < nlen; i++){
		if(arguments[i].value!='')param += "&"+arguments[i].id+'='+arguments[i].value;
	}
	if('A'==option)$(target).html('<option value="all">전체</option>');
	if('S'==option)$(target).html('<option value="">선택</option>');
	if('N'==option)$(target).html('');

	if(''==command){
		return;
	}

	$.post("/common/list", param, function(data) {
		if(data.error!=null)return;//alert(data.error);
		var array = data;
		var option;

		$.each(array,function(index,appObj) {
			if(command != "user") {
				option = $('<option value="'+appObj.ID+'">'+appObj.NAME+'</option>');
			} else {
				//option = $('<option value="'+appObj.ID+'">['+ appObj.ID + ":" + appObj.NAME+']</option>');
				option = $('<option value="'+appObj.ID+'">'+ appObj.ID + " / " + appObj.NAME+'</option>');
			}
			$(target).append(option);
		});

		array = null;
		option = null;
		data = null;
	});

	param = null;
	nlen = null;
	i = null;
}

function getOptionItemWithDefault(target,command,option,defaultValue){
	var param = 'command='+command;
	
	var nlen = arguments.length;
	var i = 4;
	
	for(i; i < nlen; i++){		
		if (arguments[i].id == 'system_type' ||arguments[i].id == 'exclude_system_type') {
			if(arguments[i].value!='')param += "&"+arguments[i].id+'='+arguments[i].value;
		} else if(command == "componet_type" || command == "code") {
			if(arguments[i]!='')param += "&"+arguments[i];
		} else {
			if(arguments[i].value!='')param += "&"+arguments[i].id+'='+arguments[i].value;
			//if(arguments[i]!='')param += "&"+arguments[i];
		}
	}
	if('A'==option)$(target).html('<option value="all">전체</option>');
	if('S'==option)$(target).html('<option value="">선택</option>');
	if('N'==option)$(target).html('');
	
	if(''==command){
		return;
	}

	$.post("/common/list", param, function(data) {
		//if(data.error!=null)alert(data.error);
		var array = data;
		var option;
		
		$.each(array,function(index,appObj) {
			if(command != "user") {
				option = $('<option value="'+appObj.ID+'">'+appObj.NAME+'</option>');
			} else {
				//option = $('<option value="'+appObj.ID+'">['+ appObj.ID + ":" + appObj.NAME+']</option>');
				option = $('<option value="'+appObj.ID+'">'+ appObj.ID + " / " + appObj.NAME+'</option>');
			}
			$(target).append(option);
			
			if(defaultValue!=null && defaultValue!=''){
				$(target).val(defaultValue);
			}
		});
	});
}

/*
 * function getOptionItemWithDefault(target,command,option,defaultValue){
	var param = 'command='+command;

	var nlen = arguments.length;
	var i = 4;
	for(i; i < nlen; i++){
		if (arguments[i].id == 'system_type' ||arguments[i].id == 'exclude_system_type') {
			if(arguments[i].value!='')param += "&"+arguments[i].id+'='+arguments[i].value;
		} else {
			if(arguments[i]!='')param += "&"+arguments[i];
		}
	}
	if('A'==option)$(target).html('<option value="all">전체</option>');
	if('S'==option)$(target).html('<option value="">선택</option>');
	if('N'==option)$(target).html('');

	if(''==command){
		return;
	}
	
	$.ajax({
		url : '/common/list',
		type : 'POST',
		data : param,
		async: false,
		success : function(data) {
			var array = data;
			var option;

			$.each(array,function(index,appObj) {
				if(command != "user") {
					option = $('<option value="'+appObj.ID+'">'+appObj.NAME+'</option>');
				} else {
					//option = $('<option value="'+appObj.ID+'">['+ appObj.ID + ":" + appObj.NAME+']</option>');
					option = $('<option value="'+appObj.ID+'">'+ appObj.ID + " / " + appObj.NAME+'</option>');
				}
				$(target).append(option);
				
				if(defaultValue!=null && defaultValue!=''){
					$(target).val(defaultValue);
				}
			});

			array = null;
			option = null;
			data = null;
		},
	    error: function(e){
	        //alert(e.reponseText);
	    },
		complete : function() {
		}	    
	});		

	param = null;
	nlen = null;
	i = null;
}
*/
 

/**
 * 이슈 확인 후 삭제 예정입니다. 필요할 경우 오준호 과장님에게 문의 바랍니다.
 * ( issue : target이 undefined로 넘어오는 경우가 발생. )
 * */

function getOptionItem_temp(target,command,option){
	var param = 'command='+command;

	var nlen = arguments.length;
	var i = 3;
	for(i; i < nlen; i++){
		if(arguments[i].value!='')param += "&"+arguments[i].id+'='+arguments[i].value;
	}
	if('A'==option)target.html('<option value="all">전체</option>');
	if('S'==option)target.html('<option value="">선택</option>');
	if('N'==option)target.html('');

	if(''==command){
		return;
	}

	$.post("/common/list", param, function(data) {
		if(data.error!=null)return;//alert(data.error);
		var array = data;
		var option;

		$.each(array,function(index,appObj) {
			if(command != "user") {
				option = $('<option value="'+appObj.ID+'">'+appObj.NAME+'</option>');
			} else {
				//option = $('<option value="'+appObj.ID+'">['+ appObj.ID + ":" + appObj.NAME+']</option>');
				option = $('<option value="'+appObj.ID+'">'+ appObj.ID + " / " + appObj.NAME+'</option>');
			}
			target.append(option);
		});

		array = null;
		option = null;
		data = null;
	});

	param = null;
	nlen = null;
	i = null;
}

function getOptionItemWithDefault_temp(target,command,option,defaultValue){
	var param = 'command='+command;

	var nlen = arguments.length;
	var i = 4;
	for(i; i < nlen; i++){
		if(arguments[i]!='')param += "&"+arguments[i];
	}
	if('A'==option)target.html('<option value="all">전체</option>');
	if('S'==option)target.html('<option value="">선택</option>');
	if('N'==option)target.html('');

	if(''==command){
		return;
	}

	$.post("/common/list", param, function(data) {
		if(data.error!=null)return;//alert(data.error);
		var array = data;
		var option;

		$.each(array,function(index,appObj) {
			if(command != "user") {
				option = $('<option value="'+appObj.ID+'">'+appObj.NAME+'</option>');
			} else {
				//option = $('<option value="'+appObj.ID+'">['+ appObj.ID + ":" + appObj.NAME+']</option>');
				option = $('<option value="'+appObj.ID+'">'+ appObj.ID + " / " + appObj.NAME+'</option>');
			}
			target.append(option);

			if(defaultValue!=null && defaultValue!=''){
				target.val(defaultValue);
			}
		});

		array = null;
		option = null;
		data = null;
	});

	param = null;
	nlen = null;
	i = null;
}

function getOptionItemDefault(target,command,option,defaultValue){
	var param = 'command='+command;

	var nlen = arguments.length;
	var i = 3;
	for(i; i < nlen; i++){
		if(arguments[i].value!='')param += "&"+arguments[i].id+'='+arguments[i].value;
	}
	if('A'==option)$(target).html('<option value="all">전체</option>');
	if('S'==option)$(target).html('<option value="">선택</option>');
	if('N'==option)$(target).html('');

	if(''==command){
		return;
	}

	$.post("/common/list", param, function(data) {
		if(data.error!=null)return;//alert(data.error);
		var array = data;
		var option;

		$.each(array,function(index,appObj) {
			if(command != "user") {
				option = $('<option value="'+appObj.ID+'">'+appObj.NAME+'</option>');
			} else {
				//option = $('<option value="'+appObj.ID+'">['+ appObj.ID + ":" + appObj.NAME+']</option>');
				option = $('<option value="'+appObj.ID+'">'+ appObj.ID + " / " + appObj.NAME+'</option>');
			}
			$(target).append(option);

			if(defaultValue!=null && defaultValue!=''){
				$(target).val(defaultValue);
			}
		});

		array = null;
		option = null;
		data = null;
	});

	param = null;
	nlen = null;
	i = null;
}
