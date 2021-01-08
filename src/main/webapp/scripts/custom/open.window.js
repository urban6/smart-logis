/*****************************************************************************************
 *
 * @Description : pop up window 관련 script
 * @Functions
 *  - fnOpenWindow(url, target, width, height, parameter) : window open 새창 열기
 *  - fnCloseWindow(target) : window open 특정 창 닫기
 *  - fnCloseWindowAll() : window open 창 전부 닫기
 *  
 * @Author : 
 * @Version :
 * @Date :
 *****************************************************************************************/

var storage_key_name = "windows";

/**
 * window open 새창 열기
 * 
 * @param url
 * @param target 
 * @param width 
 * @param height 
 * @param parameter 
 */
function fnOpenNewTab(url, storage, parameter) {
	/*console.log("fnOpenNewTab");
	console.log(url);
	console.log(storage);
	console.log(parameter);*/
	try {
		if ((storage != "") && (storage != null)) {
			
			var storageValue = fnGetItemValue(storage_key_name);
			/*console.log(storageValue);*/
			if ((storageValue != null) && (storageValue != "")) { 
				if (storageValue.indexOf(storage) > -1) { //이미 창이 존재하면 다시 띄우지 않는다.
					openAlertModal("", duplicatedTabMsg, null, null);
		    		/*if (storage.indexOf("monitor") > -1) {
						alert('The Monitoring window is active. Close it first to open a new one.');
					} else if (storage.indexOf("trace") > -1) {
						alert('The Trace window is active. Close it first to open a new one.');
					} else if (storage.indexOf("command_line_interface") > -1) {
						alert('The CLI window is active. Close it first to open a new one.');
					}	*/				
					return;
				}
			}
			
			window.name = storage;
				
			var form;
			form = document.createElement("form");		
			form.setAttribute("target", "_blank");
			form.setAttribute("action", url);
			form.setAttribute("method", "post");
			
			if ((parameter != "") && (parameter != null) && (typeof(parameter) != "undefined")) {
				var params = parameter.split("&");
				var array;
				var hiddenField;
				for (var i=0; i < params.length; i++) { 
					array = params[i].split("=");
					hiddenField = document.createElement("input"); 
					hiddenField.setAttribute("type", "hidden"); 
					hiddenField.setAttribute("name", array[0]); 
					hiddenField.setAttribute("value", array[1]);
					form.appendChild(hiddenField); 
				}
				document.body.appendChild(form); 
			}			
			form.submit();
			
			fnAddItemValue(storage_key_name, storage); //local storage 추가
			/*if (storage.indexOf("monitor") > -1) { //브라우저별로 local storage 생성되므로 아래는 자식에 local storage 생기므로 문제가 생김..
				fnAddItemValue(storage_key_name, "individualMonitor0001"); //local storage 추가
				fnAddItemValue(storage_key_name, "individualMonitor0002"); //local storage 추가
			}*/
		}
	} catch(e) {
		console.log("Function : fnOpenNewTab Exception");
		console.log("error code : "+e);
	}
}

/**
 * window open 특정 창 닫기
 * 
 * @param target
 */
function fnCloseWindow(target) {
	try {
		if((target != "") && (target != null)) {		
			var targetWindow = window.open("", target, "width=0, height=0, left=999999, top=999999, scrollbars=0, fullscreen=0, toolbar=0, scrollbars=0, location=0, status=0, menubar=0");
			targetWindow.close();
			fnRemoveItemValue(storage_key_name, target); //session storage 제거
		}
	} catch(e) {
		console.log("fnCloseWindow failed");
		console.log("error code : "+e);
	}	
}

/**
 * window open 창 전부 닫기
 * 
 * @param
 */
function fnCloseWindowAll() {
	try {
		if (typeof(Storage) !== "undefined") { //Yes! localStorage and sessionStorage support!	
			var values = fnGetItemValue(storage_key_name);
			if ((values != null) && (values != "")) {
				var array = values.split(",");
				var length = array.length;
				if (length > 0) {
					//var targetWindow;
					//var target;
					for (var i=0; i < length; i++) {
						//target = array[i];
						//fnRemoveItemValue(storage_key_name, target); //local storage 제거
						//targetWindow = window.open("", target, "width=0, height=0, left=999999, top=999999, scrollbars=0, fullscreen=0, toolbar=0, scrollbars=0, location=0, status=0, menubar=0");						
						//targetWindow.close(); //팝업이 업는 경우 예외로 빠지므로. 꼭 local storage 먼저 지우고 예외 이동후 재귀호출한다.
						fnRemoveItemValue(storage_key_name, array[i]);
					}
				}		
			}
		}
	} catch(e) {
		fnCloseWindowAll(); //재귀호출
		console.log("fnCloseWindowAll failed");
		console.log("error code : "+e);
	}	
}