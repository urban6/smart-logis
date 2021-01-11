function changePhoneFormat(objName, num) {
	var formatNum = phoneFormat(num);
	$("#"+objName ).text(formatNum);
}

function phoneFormat(num) {
	if(!num) return "";
    var formatNum = '';
    num=num.replace(/\s/gi, "");
	try {
		if (num.length == 11) {
			formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
		} else if (num.length == 8) {
			formatNum = num.replace(/(\d{4})(\d{4})/, '$1-$2');
		} else {
			if (num.indexOf('02') == 0) {
				formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
			} else {
				formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
			}
		}
	} catch (e) {
		formatNum = num;
//		console.log(e);
	}
//	console.log(formatNum);
	return formatNum;
}

function bizNoFormat(num) {
	if(!num) return "";
    var formatNum = '';
    num=num.replace(/\s/gi, "");
    try{
         if (num.length == 10) {
    	 	formatNum = num.replace(/(\d{3})(\d{2})(\d{5})/, '$1-$2-$3');
         }
    } catch(e) {
         formatNum = num;
//         console.log(e);
    }
    return formatNum;
}

function YMDFormatter(num){
    if(!num) return "";
    var formatNum = '';
    num=num.replace(/\s/gi, "");
    try{
         if(num.length == 8) {
        	 formatNum = num.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
         }
    } catch(e) {
         formatNum = num;
//         console.log(e);
    }
    return formatNum;

}
