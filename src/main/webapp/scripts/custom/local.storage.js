/******************************************************************************************
 *
 * @Description : HTML5 Local Storage 관련 script
 * @Functions
 *  - fnGetItemValue(key) : Local Storage item value 얻기
 *  - fnRemoveItemValue(key, value) : Local Storage item value 제거한다
 *  - fnAddItemValue(key, value) : Local Storage item value 추가한다 
 *
 * @Author : 
 * @Version :
 * @Date :
 ******************************************************************************************/

/**
 * Local Storage item value 얻기
 * 
 * @param key
 */
function fnGetItemValue(key) {
	try {
		if (typeof(Storage) !== "undefined") { //Yes! localStorage and localStorage support!
			if ((key != "") && (key != null)) {
				return localStorage.getItem(key);
			} else {
				return "";
			}
		}
	} catch(e) {
		return "";
		console.log("Function : fnGetItemValue Exception");
		console.log("error code : "+e);
	}
}

/**
 * Session Storage item value 제거한다
 * 
 * @param key
 * @param value 
 */
function fnRemoveItemValue(key, value) {
	try {
		if (typeof(Storage) !== "undefined") { //Yes! localStorage and localStorage support!
			var item_value = fnGetItemValue(key);
			var array = item_value.split(",");
			var length = array.length;
			var values = "";
			if (length > 0) {
				localStorage.removeItem(key); //key에 해당 되는 value 다 지운다.
				for (var i=0; i < length; i++) {
					if (array[i] != value) values += array[i] + ","; //제거할 value
				}
				var last = values.length - 1;
				if ((values.charAt(last) == ",")) values = values.substr(0, last); //쉼표 마지막 문자열 자르기
				fnAddItemValue(key, values); //session Storage에 추가한다.
			}	
		}
	} catch(e) {
		console.log("Function : fnRemoveItemValue Exception");
		console.log("error code : "+e);
	}
}

/**
 * Session Storage item value 추가한다.
 * 
 * @param key
 * @param value 
 */
function fnAddItemValue(key, value) {
	try {
		if (typeof(Storage) !== "undefined") { //Yes! localStorage and localStorage support!
			var values = fnGetItemValue(key);
			if ((values == null) || (values == "")) {
				localStorage.setItem(key, value);
			} else {
				if (values.indexOf(value) == -1) localStorage.setItem(key, values + "," + value); //중복은 추가하지 않는다
			}	
		}
	} catch(e) {
		console.log("Function : fnAddItemValue Exception");
		console.log("error code : "+e);
	}
}
