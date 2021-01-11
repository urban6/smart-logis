/**
 * FORM에서 ENTER키 방지
 */
var keyEvent13flag = true;
$(function () {
    $("textarea").focus(function(){ keyEvent13flag = false; });
    $("textarea").blur(function(){ keyEvent13flag = true; });
    $(window).keydown(function (event) {
        if (event.keyCode == 13) {
            if (keyEvent13flag) {
                event.preventDefault();
                return false;
            }            
        }
    });
    $("BUTTON[onclick]").click(function (event) {
        event.preventDefault();
        return false;
    });
});

/**
 * INPUT NUMBER에서 MAXLENGTH 인식하도록 예외처리
 */
$(function () {
    $("input[type='number'][maxlength]").keydown(function (event) {
        if ($(this).val().length >= $(this).attr("maxlength")) {
            if (event.keyCode >= 48 && event.keyCode <= 57) {
                $(this).val($(this).val().slice(0, $(this).attr("maxlength")));
                event.preventDefault();
                return false;
            }
        }
    });
});


/**
 * 초기값 셋팅 (SELECT, RADIO, CHECKBOX)
 */
function setValues() {
    $("select[val]").each(function () {						// Select 초기값 셋팅
        var setVal = $(this).attr("val");
        if (setVal != "") {
            if ($(this).find("option[value='" + setVal + "']").length > 0) {
                $(this).val(setVal);
            } else {
                if ($(this).find("option[value='']").length > 0) {
                    $(this).val('');
                }
            }            
        }
    });
    $("input[type='radio'][val]").each(function () {		// Radio 초기값 셋팅		
        if ($(this).val() == $(this).attr("val")) { $(this).attr("checked", true); } else { $(this).attr("checked", false); }
    });
    $("input[type='checkbox'][val]").each(function () {		// checkbox 초기값 셋팅
        if ($(this).val() == $(this).attr("val")) { $(this).attr("checked", true); } else { $(this).attr("checked", false); }
    });
}
$(function () { setValues(); });	// 페이지 로딩시에 셋팅


/**
 * 라디오, 체크박스에서 기본적인 체크
 */
$(function () {
    setTimeout(function () {
        $("*[defaultChecked]").each(function () {
            var ObjName = $(this).attr("name");
            if (ObjName == "") {
                $(this).prop("checked", true);
            } else {
                if ($("[name='" + ObjName + "']:checked").length == 0) {
                    $(this).prop("checked", true);
                }
            }
        });
    }, 100);    
});


/**
 * Validation Check
 */
function ValidGetObj(Name) {
    var $Obj;
    if (Name.substring(0, 1) == "#" || Name.substring(0, 1) == ".") { $Obj = $(Name); }
    else { $Obj = $("input[name='" + Name + "'], select[name='" + Name + "'], textarea[name='" + Name + "']"); }
    return $Obj;
}
function ValidRequired(Name, Msg) {
    var result = true;
    var $Obj = ValidGetObj(Name);    
    $Obj.each(function () {
        if ($.trim($(this).val()) == "") { alert(Msg); $(this).focus(); result = false; }
    });
    return result;
}
function ValidMinLen(Name, LenMin, Msg) {
    var result = true;
    var $Obj = ValidGetObj(Name);
    $Obj.each(function () {
        if ($.trim($(this).val()).length < LenMin) { alert(Msg); $(this).focus(); result = false; }
    });
    return result;
}
function ValidMaxLen(Name, LenMax, Msg) {
    var result = true;
    var $Obj = ValidGetObj(Name);
    $Obj.each(function () {
        if ($.trim($(this).val()).length > LenMax) { alert(Msg); $(this).focus(); result = false; }
    });
    return result;
}
function ValidRange(Name, LenMin, LenMax, Msg) {
    var result = true;
    var $Obj = ValidGetObj(Name);
    $Obj.each(function () {
        if ($.trim($(this).val()).length < LenMin || $.trim($(this).val()).length > LenMax) { alert(Msg); $(this).focus(); result = false; }
    });
    return result;
}
function ValidEq(Name, Val, Msg) {
    var result = true;
    var $Obj = ValidGetObj(Name);
    $Obj.each(function () {
        console.log($.trim($(this).val()));
        console.log(Val);
        if ($.trim($(this).val()) == Val) { alert(Msg); $(this).focus(); result = false; }
    });
    return result;
}
function ValidNe(Name, Val, Msg) {
    var result = true;
    var $Obj = ValidGetObj(Name);
    $Obj.each(function () {
        if ($.trim($(this).val()) != Val) { alert(Msg); $(this).focus(); result = false; }
    });
    return result;
}
function ValidChecked(Name, Msg) {    
    var result = true;
    var $Obj = ValidGetObj(Name);
    $Obj.each(function () {
        if ($(this).prop("checked") == false) { alert(Msg); $(this).focus(); result = false; }
    });
    return result;
}
function ValidEmail(Name, Msg){
	var result = true;
    var $Obj = ValidGetObj(Name);
    var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    $Obj.each(function () {
    	if ( !regEmail.test( $(this).val() ) ){
    		alert(Msg); $(this).focus(); result = false;
    	}    	
    });
    return result;
}


/**
 * 날짜함수 : 연도, 월, 일 구하기
 */
function getYear(){
	var today = new Date();
	return parseInt(today.getFullYear(),10);
}
function getMonth(){
	var today = new Date();
	return parseInt((today.getMonth()+1),10);
}
function getDay(){
	var today = new Date();
	return parseInt(today.getDate(),10);
}


/**
 * SelectBox 연도 설정
 */
function setOptYear(Obj, ago){
	var today = new Date();
	var dayPart = parseInt(today.getFullYear(),10);
	for(i=today.getFullYear();i>=today.getFullYear()-ago;i--){
		Obj.append('<option value="'+i+'">'+i+'</option>');
	}
}
function setOptMonth(Obj){
	var today = new Date();
	var dayPart = parseInt((today.getMonth()+1),10);
	for(i=1;i<=12;i++){
		Obj.append('<option value="'+i+'">'+i+'</option>');
	}
}
function setOptDay(Obj){
	var today = new Date();
	var dayPart = parseInt(today.getDate(),10);
	for(i=1;i<=31;i++){
		Obj.append('<option value="'+i+'">'+i+'</option>');
	}
}


/**
 * 숫자에 3자리 마다 쉼표 표시
 */
function setComma(num) {
    var len, point, str;
    if (isNaN(num)) { num = 0; }
    //num = num.replace(/,/gi,"")
    num = num + "";
    point = num.length % 3;
    len = num.length;
    str = num.substring(0, point);
    while (point < len) {
        if (str != "") str += ",";
        str += num.substring(point, point + 3);
        point += 3;
    }
    return str;
}
$(function () { $(".comma").each(function () { $(this).text(setComma($(this).text())); }); });


/**
 * 8글자 날짜에 구분 기호 추가
 */
function setDateSep(dateStr, Separator) {
    var str;
    dateStr = $.trim(dateStr);
    if (dateStr.length != 8) { return ""; }
    str = dateStr.substring(0, 4);
    str += Separator;
    str += dateStr.substring(4, 6);
    str += Separator;
    str += dateStr.substring(6, 8);
    return str;
}
$(function () {
    $(".dateDot").each(function () { $(this).text(setDateSep($(this).text(), ".")); });
    $(".dateDash").each(function () { $(this).text(setDateSep($(this).text(), "-")); });
    $(".dateSlash").each(function () { $(this).text(setDateSep($(this).text(), "/")); });
});

/**
 * 숫자만 입력받음
 */
$(function () {
    $(document).on("keyup", "input:text[numberOnly]", function () {
        var numVal = $(this).val().replace(/[^0-9]/gi, "");
        if (isNaN(numVal)) { numVal = ''; }       
        $(this).val(numVal);
    });
});

/**
 * 금액만 입력받음
 */
$(function () {
    $(document).on("keyup", "input:text[moneyOnly]", function () {       
        var numVal = parseInt($(this).val().replace(/[^0-9]/gi, ""));
        if (isNaN(numVal)) { numVal = ''; }
        $(this).val(numVal);
    });
});

/**
 * 특수문자 금지
 */
$(function () {
    $(document).on("keyup", "input:text[noSpecial]", function () {
        var tmpVal = $(this).val().replace(/[\`\~\!\@\#\$\%\^\&\*\(\)\_\-\=\+\|\\\?\/\>\.\<\,\[\]\{\}\;\:\\'\\"]/gi, "");      
        $(this).val(tmpVal);
    });
});

/**
 * 한글 입력 금지
 */
$(function () {
    $(document).on("keyup", "input:text[noKorean]", function () {
        var tmpVal = $(this).val().replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi, "");      
        $(this).val(tmpVal);
    });
});

/**
 * onEnter Event
 */
$(function(){
	$("[onenter]").keydown(function(key){
		var actFunc = $(this).attr("onenter");		
		if ( key.keyCode == 13 && actFunc != "" ){
			eval(actFunc);
		}
	});
});

/**
 * 파일업로드 체크 
 */
var fileset;
$(function(){
	 fileset = $('#file01').clone(true); 
});
function file_check (obj) {
    var wsize=$(obj).attr("wsize");
    var hsize=$(obj).attr("hsize");
    var fsize=$(obj).attr("fsize");
    var fval = $(obj).attr("fval");
    var fval_arr = fval.split(',');
    var setFileName = true;

    if(fval != undefined) {
		if( $(obj).val() != " " ){
			var ext = $(obj).val().split('.').pop().toLowerCase();
            if($.inArray(ext,fval_arr) == -1){
                alert(fval_arr +'파일만 업로드 할수 있습니다.');
                $('#filereset').empty();
                $('#filereset').append(fileset);
                setFileName = false;
                return;
            }
        }
     }

    if(fsize != undefined) {
        var fileSize= obj.files[0].size;
        var maxsize =  fsize * 1000000;
        if(fileSize > maxsize){
            alert("파일 용량 " + fsize +"MB까지 업로드 가능합니다.");
            $('#filereset').empty();
            $('#filereset').append(fileset);
            setFileName = false;
      }
    }

	if(wsize == undefined && hsize == undefined){ }
      else{
       var file  = obj.files[0];
       var _URL = window.URL || window.webkitURL;
       var img = new Image();

        img.src = _URL.createObjectURL(file);
        img.onload = function() {
            if(img.width != wsize || img.height != hsize) {
                alert("이미지 가로"+ wsize + "px, 세로 " + hsize + "px로 맞춰서 올려주세요.");
                setFileName = false;
                return;
            }
        }
     }

     if(setFileName) {
         // 파일명 표시
         var fileNm = $(obj).val().substring( $(obj).val().lastIndexOf("\\")+1, $(obj).val().length );
         $("span[filename='COACH_PHOTO']").text(fileNm);
         $("span[filename='PROGRAM']").text(fileNm);
         $("span[filename='CARD_PICTURE']").text(fileNm);
     }else{
         $("span[filename='COACH_PHOTO']").text("");
         $("span[filename='PROGRAM']").text(fileNm);
         $("span[filename='CARD_PICTURE']").text(fileNm);
     }

}
/**
 * [chageSet] input/select의 값이 변경되면 값을 셋팅하는 기능
 */

$(function () {
    $("input[changeSet], select[changeSet]").change(function () {
        var targetValue = $(this).val();
        var targetField = $(this).attr("changeSet");
        if (targetField.substring(0, 1) == "#" || targetField.substring(0, 1) == ".") {
            $(targetField).each(function () {
                if ($(this).tagName == "input" || $(this).tagName == "select") {
                    $(targetField).val(targetValue);
                } else {
                    $(targetField).text(targetValue);
                }
            });
        } else {
            $("input[name='"+targetField+"']").val(targetValue);
        }
    });
});


/**
 * AJAX통신으로 데이터 응답 받기
 */
function getAjaxCall(URL, FormId, Recall) {
    $.ajax({
        url: URL,
        type: 'POST',
        data: {
            "MNG_MOBILE_1" : $("select[name='MNG_MOBILE_1']").val(),
            "MNG_MOBILE_2" : $("input[name='MNG_MOBILE_2']").val(),
            "MNG_MOBILE_3" : $("input[name='MNG_MOBILE_3']").val(),
            "CERTI_NO" : $("input[name='CERTI_NO']").val()
        },
        cache: false,
        success: function (data) {
            Recall(data);
        },
        error: function (request, status, error) {
            //alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            alert('통신오류가 발생하였습니다.');
        }
    });
}


/**
 * 쿠키 관련 함수
 */
function setCookie(name, value, expiredays) {
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}
function getCookie(c_name) {
	var i,x,y,ARRcookies=document.cookie.split(";");
	for (i=0;i<ARRcookies.length;i++) {
		x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
		y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
		x=x.replace(/^\s+|\s+$/g,"");
		if (x==c_name) {
			return unescape(y);
		}
	}
}


/**
 * JSON 라이브러리
 */
Map = function () {
    this.map = new Object();
};
Map.prototype = {
    put: function (key, value) {
        this.map[key] = value;
    },
    putMap: function (key, value) {
        this.map[key] = value.map;
    },
    putMapList: function (key, value) {
        var list = new Array();
        for (var i = 0; i < value.length; i++) {
            list.push(value[i].map);
        }
        this.map[key] = list;
    },
    get: function (key) {
        return this.map[key];
    },
    containsKey: function (key) {
        return key in this.map;
    },
    containsValue: function (value) {
        for (var prop in this.map) {
            if (this.map[prop] == value) return true;
        }
        return false;
    },
    isEmpty: function (key) {
        return (this.size() == 0);
    },
    clear: function () {
        for (var prop in this.map) {
            delete this.map[prop];
        }
    },
    remove: function (key) {
        delete this.map[key];
    },
    keys: function () {
        var keys = new Array();
        for (var prop in this.map) {
            keys.push(prop);
        }
        return keys;
    },
    values: function () {
        var values = new Array();
        for (var prop in this.map) {
            values.push(this.map[prop]);
        }
        return values;
    },
    size: function () {
        var count = 0;
        for (var prop in this.map) {
            count++;
        }
        return count;
    },
    jsonString: function () {
        return JSON.stringify(this.map);
    }
};

/**
 * 오늘 날짜
 */
function getToday(){
	var newDate = new Date();
	var yyyy = newDate.getFullYear();
	var mm = newDate.getMonth()+1;
	var dd = newDate.getDate();
	if( mm < 10 ) { mm = "0" + mm; }	
	if( dd < 10 ) { dd = "0" + dd; }
	return yyyy +"-"+ mm +"-"+ dd;
}


/**
 * 날짜 계산 (금일 기준으로 과거 일자 계산)
 */
function getDateFormat(date, delimiter) {
    var newDate = new Date();
    if( date != null ) { newDate = date; }
    
    var yy = newDate.getFullYear();
    var mm = newDate.getMonth()+1;
    if( mm < 10 ) { mm = "0" + mm; }
    
    var dd = newDate.getDate();
    if( dd < 10 ) { dd = "0" + dd; }
    
    if( delimiter == null ) delimiter = "";
    return yy + delimiter + mm + delimiter + dd;
}

/**
 * 날짜 계산 (금일 기준으로 과거 일자를 설정)
 */
function getDateBefore(befoid, afterid, day) {
	var caledmonth, caledday, caledYear;
 	var loadDt = new Date();
 	var v = new Date(Date.parse(loadDt) - day*1000*60*60*24);
 
	caledYear = v.getFullYear();	
	if( v.getMonth() <= 9 ) { caledmonth = '0'+(v.getMonth()+1); }
	else { 	caledmonth = v.getMonth()+1; }
	
	if( v.getDate() <= 9 ) { 	caledday = '0'+v.getDate(); }
	else { 	caledday = v.getDate(); }

	$("#"+befoid).val(caledYear + '-' + caledmonth + '-' + caledday);
	$("#"+afterid).val(getDateFormat(new Date(),"-")); 
}

/**
 * 날짜 계산 (금월 1일 부터 말일 계산)
 */
function getDateMonth(befoid, afterid) {
	var now = new Date();
	var firstDate, lastDate;

	firstDate = new Date(now.getFullYear(), now.getMonth(),1);
	$("#"+befoid).val(getDateFormat(firstDate, "-"));
	$("#"+afterid).val(getDateFormat(new Date(),"-"));
}

