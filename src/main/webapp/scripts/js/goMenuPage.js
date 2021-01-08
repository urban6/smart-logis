function goMenuPage(url) {
	if(url==null || url=='')return;
	
	var f = makeform(url);
	
	f.submit();

}
function goTopMenuPage(url, menuNo, selectMenuNo, menuClass) {
	if(url.indexOf('popup:') > -1){
		var popup_url = url.substring('popup:'.length, url.length);
		//console.log("popup_url==>"+popup_url);
		if(popup_url.indexOf("/ofcs/monitor/") > -1) {
			fnOpenWindow(popup_url, "monitor", "", "");
		} else if(popup_url.indexOf("/ofcs/monitor2/") > -1) {
			fnOpenWindow(popup_url, "monitor2", "", "");
		} else {
			fnOpenWindow(popup_url, "", "", "");
		}
		return;
	}
	
	var f = makeform(url);

	if(menuClass!=null){
		f.appendChild(AddData('menuClass', menuClass));
	}
	if(selectMenuNo!=null){
		f.appendChild(AddData('selectMenuNo', selectMenuNo));
	}
	f.appendChild(AddData('menuNo', menuNo));
	f.submit();
	
	/*
	var param = '';
	param+="menuNo="+menuNo;
	if(menuClass!=null){
		param+="menuClass="+menuClass;
	}
	
	$.post(url, param, function(data) {
		$("nav").html(data);
	});
	*/
}

function goLeftMenuPage(url, menuNo, selectMenuNo, menuClass) {
	if(url==null || url=='')return;
	
	if(url.indexOf('popup:') > -1){
		var popup_url = url.substring('popup:'.length, url.length);
		//console.log("left popup_url==>"+popup_url);
		if(popup_url.indexOf("/ofcs/commandline/") > -1) { //Command Line Interface
			fnOpenWindow(popup_url, "command_line_interface", 1310, 800, "");	
		} else if(popup_url.indexOf("/ofcs/monitor/") > -1) { //모니터링
			fnOpenWindow(popup_url, "monitor", "", "", "");	
		} else if(popup_url.indexOf("/ofcs/config/trace/") > -1) { //Trace
			fnOpenWindow(popup_url, "trace", 1000, 620, "");	
		} else {
			fnOpenWindow(popup_url, "", "", "");
		}
		return;
	}
	
	var f = makeform(url);
	
	if(menuClass!=null){
		f.appendChild(AddData('menuClass', menuClass));
	}
	f.appendChild(AddData('menuNo', menuNo));
	f.appendChild(AddData('selectMenuNo', selectMenuNo));
	f.submit();
}

function makeform(ActionURL) {
	var f = document.frmMenuHandle;
	f.action=ActionURL;
	f.method="post";
	f.target="";
	return f;
}
function AddData(name, value) {
	var i = document.createElement("input");
	i.setAttribute("type", "hidden");
	i.setAttribute("name", name);
	i.setAttribute("value", value);
	return i;
}