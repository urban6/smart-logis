// check ip address
function isValidIpAddress(str) {
	return /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/.test(str);
}

//check ip bandwidth
function isValidIpBandWidth(str) {
	return /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|\*)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|\*)$/.test(str);
}

function isValidAdvIpBandWidth(str) {
	return /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|\*)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|\*)(\/\d+)*$/.test(str);
}

//check email
function isValidEmail(str){
	return /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i.test(str);
}

//User Password 체크
function isValidPasswd(str){
	return str.match(/([a-zA-Z0-9].*[`,!,”,￡,$,%,^,&,*,(,),_,+,\-,=,{,},\[,\],:,@,~,;,’,#,<,>,?,.,\/,\,|])|([`,!,”,￡,$,%,^,&,*,(,),_,+,\-,=,{,},\[,\],:,@,~,;,’,#,<,>,?,.,\/,\,|].*[a-zA-Z0-9])/);
}

//check alpha or number
function isValidAlphaOrNum(str){
	return /^[A-Za-z0-9]+$/.test(str);
}

//check number or hyphen(-)
function isValidNumOrHyphen(str){
	return /^[0-9]{1}[0-9-]+$/.test(str);
}

// 알파벳 : a-z, A-Z
// 숫자 : 0 - 9
// 특수문자 : 언더바(_) 하이픈(-) 슬래쉬(/) 파이프(|)
function isValidName(str) {
	return /^[A-Za-z][A-Za-z0-9\_]*$/.test(str);
}

// check natural number
// isValidNaturalNumber("111") -> true
// isValidNaturalNumber("011") -> false
// isValidNaturalNumber("abc") -> false
function isValidNaturalNumber(str) {
	return /^([0-9]|[1-9][0-9]*)$/.test(str);
}

function isValidNumber(str) {
	return /^[0-9]+$/.test(str);
}

function isValidPositiveNumber(str) {
	return /^[1-9]|[1-9][0-9]*$/.test(str);
}

function isValidPort(str) {
	if (isValidNaturalNumber(str) && parseInt(str) <= 65535) {
		return true;
	}
	return false;
}

// check color code
// ex) #ffffff
function isValidColorCode(str) {
	return /^\#[0-9a-fA-F]{6}$/.test(str);
}

function isEmpty(str) {
	var bRet = false;
	if (str == null || str == "") {
		bRet = true;
	}
	return bRet;
}

function nullCheck(str, replace) {
	if (replace == null) {
		replace = "";
	}
	if (isEmpty(str)) {
		return replace;
	}
	return str;
}

function getImagePath(str) {
	str = str.replace("url(\"", "").replace("\")", "");
	var idx = str.indexOf("/images/");
	str = str.substring(idx, str.length);
	return str;
}

function rgbToHexColor(colorval) {
	var parts = colorval.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
	delete(parts[0]);
	for (var i=1;i<=3;++i) {
		parts[i] = parseInt(parts[i]).toString(16);
		if (parts[i].length == 1) {
			parts[i] = '0' + parts[i];
		}
	}
	color = '#' + parts.join('');
	return color;
}

//숫자 타입에서 쓸 수 있도록 format() 함수 추가
Number.prototype.format = function() {
	if (this==0) return 0;
	var reg = /(^[+-]?\d+)(\d{3})/;
	var n = (this + '');
	while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
	return n;
};
 
// 문자열 타입에서 쓸 수 있도록 format() 함수 추가
String.prototype.format = function(){
	var num = parseFloat(this);
	if (isNaN(num)) return "0";
	return num.format();
};

function calculateBytes (str) {
	var tcount = 0;
	var tmpStr = new String(str);
	var temp = tmpStr.length;
	var onechar;
	
	for ( k=0; k<temp; k++ ) {
		onechar = tmpStr.charAt(k);
		if (escape(onechar).length > 4) {
			tcount += 2;
		} else {
			tcount += 1;
		}
	}
	
	return tcount;
}

function stringToHtml(sSrc)
{
	if (sSrc == null)
		return "";
	var sData = new String(sSrc);
	var sBuf = "";
	var nCount = sData.length;
	for (var i=0;i<nCount;i++)
	{
		var cChar = sData.charAt(i);
		if (cChar == '\"')
		{
			sBuf += "&#34;";
			continue;
		}	
		// &#39; = '
		if (cChar == '\'')
		{
			sBuf += "&#39;";
			continue;
		}
		if (cChar == '#')
		{
			sBuf += "&#35;";
			continue;
		}
		if (cChar == '&')
		{
			sBuf += "&#38;";
			continue;
		}
		if (cChar == '<')
		{
			sBuf += "&#60;";
			continue;
		}
		if (cChar == '>')
		{
			sBuf += "&#62;";
			continue;
		}
		if (cChar == '\r')
		{
			continue;
		}
		if (cChar == '\n')
		{
			sBuf += "<br>"; // "\\n";
			continue;
		}
		sBuf += sData.charAt(i);
	}
	return sBuf;
}

/**
 * @param sStr
 * @param cChar
 * @returns
 * 파일 경로에서 파일명을 리턴한다.
 */
function getFileName(sStr, cChar) {
	if (isEmpty(sStr)) {
		return "";
	}
	if (cChar == null) {
		cChar = "\\";
	}
	return sStr.substring(sStr.lastIndexOf("\\")+1);
}

/**
 * @param sStr
 * @returns
 * 파일의 확장자를 리턴한다.
 */
function getFileExt(sStr) {
	if (isEmpty(sStr)) {
		return "";
	}
	return sStr.substring(sStr.lastIndexOf(".")+1);
}

function getFormatNumber(number, format) {
	var sNumber = "" + number;
	var nIdx = sNumber.length - 1;
	var sRet = "";
	for (var i=format.length-1;i>=0;i--) {
		var ch = format[i];
		if (ch == "#") {
			if (nIdx >= 0) {
				sRet = sNumber[nIdx] + sRet;
				nIdx --;
			}
		} else if (ch == "0") {
			if (nIdx < 0) {
				sRet = "0" + sRet;
			} else {
				sRet = sNumber[nIdx] + sRet;
				nIdx --;
			}
		} else {
			if (nIdx >= 0) {
				sRet = ch + sRet;
			}
		}
	}
	return sRet;
}

function number_format( number )

{
  var nArr = String(number).split('').join(',').split('');
  for( var i=nArr.length-1, j=1; i>=0; i--, j++)  if( j%6 != 0 && j%2 == 0) nArr[i] = '';
  return nArr.join('');

}

function ValidUrl(str) {
	var pattern = new RegExp('^(https?:\\/\\/)?'+ // protocol
	'((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|'+ // domain name
	'((\\d{1,3}\\.){3}\\d{1,3}))'+ // OR ip (v4) address
	'(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*'+ // port and path
	'(\\?[;&a-z\\d%_.~+=-]*)?'+ // query string
	'(\\#[-a-z\\d_]*)?$','i'); // fragment locator
	
	if(!pattern.test(str)) {
		return false;
	} else {
		return true;
	}
}

//bytes 변환
function byteCalculation(bytes, decimals) {
	if(bytes == null || bytes == "undefined"){
		return "N/A";
	}
	if(decimals == null || decimals == "undefined"){
		decimals = 0;
	}
    var bytes = parseFloat(bytes);
    var s = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
    var idx = 0;
    while (bytes >= 1024) {
    	bytes /= 1024;
    	idx ++;
    }
    return bytes.toFixed(decimals).split(/(?=(?:\d{3})+(?:\.|$))/g).join(',') + " " + s[idx];
}

//bps 변환
function bpsCalculation(bytes, decimals) {
	if(bytes == null || bytes == "undefined"){
		return "N/A";
	}
	if(decimals == null || decimals == "undefined"){
		decimals = 0;
	}
    var bytes = parseFloat(bytes);
    var s = ['', 'K', 'M', 'G', 'T', 'P'];
    var idx = 0;
    while (bytes >= 1000) {
    	bytes /= 1000;
    	idx ++;
    }
    return bytes.toFixed(decimals).split(/(?=(?:\d{3})+(?:\.|$))/g).join(',') + " " + s[idx];
    
    /*var e = Math.floor(Math.log(bytes)/Math.log(1000));
   
    if(e == "-Infinity") return "0 "+s[0]; 
    else 
    return (bytes/Math.pow(1000, Math.floor(e))).toFixed(2)+" "+s[e];*/
}

function calculation(str,unit) {
	if(str == null || str == "undefined"){
		return "N/A";
	}
    var str = parseFloat(str);
    var s = [unit, 'K'+unit, 'M'+unit, 'G'+unit, 'T'+unit, 'P'+unit];
    var idx = 0;
    while (str > 1000) {
    	str /= 1000;
    	idx ++;
    }
    return str.toFixed(2) + " " + s[idx];
    
    /*var e = Math.floor(Math.log(bytes)/Math.log(1000));
   
    if(e == "-Infinity") return "0 "+s[0]; 
    else 
    return (bytes/Math.pow(1000, Math.floor(e))).toFixed(2)+" "+s[e];*/
}

function calculationInt(str,unit) {
	if(str == null || str == "undefined"){
		return "N/A";
	}
    var str = parseFloat(str);
    var s = [unit, 'K'+unit, 'M'+unit, 'G'+unit, 'T'+unit, 'P'+unit];
    var idx = 0;
    while (str > 1000) {
    	str /= 1000;
    	idx ++;
    }
    return Math.round(str) + " " + s[idx];
    
    /*var e = Math.floor(Math.log(bytes)/Math.log(1000));
   
    if(e == "-Infinity") return "0 "+s[0]; 
    else 
    return (bytes/Math.pow(1000, Math.floor(e))).toFixed(2)+" "+s[e];*/
}

Date.prototype.format = function(f) {
	if (!this.valueOf()) return " ";
	var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
	var d = this;
	return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
		switch ($1) {
		case "yyyy": return d.getFullYear();
		case "yy": return (d.getFullYear() % 1000).zf(2);
		case "MM": return (d.getMonth() + 1).zf(2);
		case "dd": return d.getDate().zf(2);
		case "E": return weekName[d.getDay()];
		case "HH": return d.getHours().zf(2);
		case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
		case "mm": return d.getMinutes().zf(2);
		case "ss": return d.getSeconds().zf(2);
		case "a/p": return d.getHours() < 12 ? "오전" : "오후";
		default: return $1;
		}
	});
};
String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};
