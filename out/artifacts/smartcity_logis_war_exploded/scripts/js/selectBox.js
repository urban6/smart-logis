/**
 * option 항목
 * A all
 * S select
 * N null
 * */ 

function getOptionItem(url, target, option){
	var param = null;
	var nlen = arguments.length;
	var paramCount = 3;
	
	for(var i = paramCount; i < nlen; i++){
		if(arguments[i].value!='')param += "&"+arguments[i].id+'='+arguments[i].value;
	}
	
	if('A'==option) $(target).html('<option value="all">All</option>');
	if('S'==option) $(target).html('<option value="">Selection</option>');
	if('I'==option) $(target).html('<option value="">Input</option>');
	if(('N'==option) || (''==option)) $(target).html('');
	
	if(''==url){
		return;
	}
	
	$(target).append('');

	$.post(url, param, function(data) {
		//if(data.error!=null)alert(data.error);
		var array = data;
		var optionTag;
		
		$.each(array,function(index,appObj) {
			optionTag = $('<option value="'+appObj.ID+'">'+stringToHtml(appObj.NAME)+'</option>');
			$(target).append(optionTag);
			//$(target).append(optionTag).multipleSelect('refresh');
			//$('select.multi,select.group').multipleSelect('checkAll');
		});
	},'json');
}

function getOptionItemWithDefault(url, target, option, defaultValue){
	var param = null;
	var nlen = arguments.length;
	var paramCount = 4;

	for(var i = paramCount; i < nlen; i++){
		if(arguments[i]!='')param += "&"+arguments[i];
	}
	if('A'==option) $(target).html('<option value="all">All</option>');
	if('S'==option) $(target).html('<option value="">Selection</option>');
	if('I'==option) $(target).html('<option value="">Input</option>');
	if(('N'==option) || (''==option)) $(target).html('');
	
	if(''==url){
		return;
	}
	
	$.post(url, param, function(data) {
		//if(data.error!=null)alert(data.error);
		var array = data;
		var optionTag;
		
		$.each(array,function(index,appObj) {
			optionTag = $('<option value="'+appObj.ID+'">'+stringToHtml(appObj.NAME)+'</option>');
			$(target).append(optionTag);
			//$(target).append(optionTag).multipleSelect('refresh');
			//$('select.multi,select.group').multipleSelect('checkAll');
		});
		
		if(defaultValue!=null && defaultValue!=''){
			$(target).val(defaultValue);
			//$(target).multipleSelect('setSelects',[defaultValue]);
		}
	});
}

function getOptionItem_parameter_url(url, target, option, params){
	
	if('A'==option)$(target).html('<option value="all">All</option>');
	if('S'==option)$(target).html('<option value="">Selection</option>');
	if('I'==option)$(target).html('<option value="">Input</option>');
	if('N'==option)$(target).html('');
	
	if(''==url){
		return;
	}
	
	$.post(url, params, function(data) {
		//if(data.error!=null)alert(data.error);
		var array = data;
		var optionTag;
		
		$.each(array,function(index,appObj) {
			optionTag = $('<option value="'+appObj.ID+'">'+appObj.NAME+'</option>');
			$(target).append(optionTag);
		});
	});
}

function getOptionItemReset(target, option){
	if('A'==option) $(target).html('<option value="all">All</option>');
	if('S'==option) $(target).html('<option value="">Selection</option>');
	if('I'==option) $(target).html('<option value="">Input</option>');
	if(('N'==option) || (''==option)) $(target).html('');
	
	var $select_name = $(target).find('option:selected').text();
    $(target).siblings('label').text($select_name);
}

function getOptionItemCallback(url, target, option, defaultIndex, callback, combo ){
	var param = null;
	var nlen = arguments.length;
	var paramCount = 3;
	
	for(var i = paramCount; i < nlen; i++){
		if(arguments[i].value!='')param += "&"+arguments[i].id+'='+arguments[i].value;
	}
	
	if('A'==option) $(target).html('<option value="all">All</option>');
	if('S'==option) $(target).html('<option value="">Selection</option>');
	if('I'==option) $(target).html('<option value="">Input</option>');
	if(('N'==option) || (''==option)) $(target).html('');
	
	if(''==url){
		return;
	}
	
	$(target).append('');

	var sel = "";
	$.post(url, param, function(data) {
		//if(data.error!=null)alert(data.error);
		var array = data;
		var optionTag;
		
		$.each(array,function(index,appObj) {
			if (index == defaultIndex) { sel = appObj.ID; }
			optionTag = $('<option value="'+appObj.ID+'">'+stringToHtml(appObj.NAME)+'</option>');
			$(target).append(optionTag);
			//$(target).append(optionTag).multipleSelect('refresh');
			//$('select.multi,select.group').multipleSelect('checkAll');
		});
	},'json')
	.done(function(){
		$(target).find("option[value='"+sel+"']").attr("selected", true);
		var $selectTarget = $('.select');
		selectCustom($selectTarget);
		if(combo == null || combo == ""){
			eval(callback);
		} else {
			eval(combo);
			eval(callback);
		}
		
	});
	
}
