/**
 * 요청주신 로딩에대한 설정 부분과 팝업 열기, 닫기 부분에 대한 메서드들을 모아두었습니다. 이를 사용하기 위해서는
 *
 * /js/jquery-(버전).js /js/jquery.blockUI.js /js/jquery.bpopup.min.js 3가지 js 파일이
 * 필수로 선로딩 필요합니다.
 */
var $body = $( "body" );

// 로딩 콜백 설정
var fixConfig = {
	onBlock : function()
	{
		$body.addClass( "fix" );
	} ,
	onUnblock : function()
	{
		$body.removeClass( "fix" );
	}
}

// 로딩 기본 스타일 설정
if ( $.blockUI )
{
	$.blockUI.defaults.css.border = 'none';
	$.blockUI.defaults.css.backgroundColor = 'transparent';
	$.blockUI.defaults.message = '<div class="block-loading"><div class="spinner"></div></div>';
}

/**
 * 팝업 생성 후 띄우기 위한 함수
 *
 * @param title :
 *            팝업의 제목값을 받습니다.
 * @param content :
 *            팝업 내 내용값을 받습니다.
 * @param isConfirm :
 *            컨펌형태 여부 입니다.
 * @param funcConfirm :
 *            확인버튼에대한 액션이 추가로 필요할경우 function 을 넘겨주세요.
 * @param isBig :
 *            1200px의 팝업을 띄울지에 대한 여부 없을 시 디폴트는 팝업 닫힘입니다.
 *
 * isConfirm 값을 넘기지 않을시 [확인] 1가지 버튼만 노출합니다. true 를 넘겨주시면 confirm 형태의 [취소, 확인]
 * 2가지 노출합니다.
 */
function doOpenPopup( title, content, isConfirm, funcConfirm, isBig )
{
	var makeElem;
	var clsPopSize = ( isBig ) ? "w1200" : "w380";

	var btnElem = ( isConfirm ) ? '<button class="btn_white btn_line_gray mr8" onClick="doClosePopup(this);">취소</button>\n' + '<button class="btn_red btn_ok">확인</button>\n'
			: '<button class="btn_red btn_ok">확인</button>\n'

	makeElem = '<div class="popup ' + clsPopSize + '">\n' + '    <div class="p_header">\n' + '        <p class="title">' + title + '</p>\n'
			+ '        <a href="javascript:;" class="btn_close" onClick="doClosePopup(this);"><em>닫기</em></a>\n' + '    </div>\n' + '    <div class="p_body min">\n'
			+ '        <p class="comment center">' + content + '</p>\n' + '        <div class="p_btns">\n' + '            <div class="center">' + btnElem + '</div>\n'
			+ '        </div>\n' + '    </div>\n' + '</div>'

	var $popup = $( makeElem );

	$popup.find( ".p_btns .btn_ok" ).on( "click" , function()
	{
		doClosePopup( this )
	} );
	// 4번째 인자인 확인버튼에 대한 function 이 있다면 이벤트 추가
	if ( isConfirm && funcConfirm && typeof funcConfirm === 'function' )
	{
		$popup.find( ".p_btns .btn_ok" ).on( "click" , funcConfirm );
	}

	$body.append( $popup );
	$popup.bPopup();
}

/**
 * 팝업을 닫는 함수이며 내부적으로 호출됩니다.
 *
 * @param el
 */
function doClosePopup( el )
{
	$( el ).closest( ".popup" ).bPopup().close();
	$body.find( ".popup" ).remove();
}

/**
 * 로딩화면을 띄우는 함수
 *
 * @param $el :
 *            로딩시킬 영역이 필요한경우 jquery 객체로 전달 전달하지 않으면 body기준으로 생성됩니다.
 */
function doShowLoading( $el )
{
	var $target = ( $el ) ? $el : $body;
	var makeConfig = ( $el ) ? {} : fixConfig;

	$target.block( makeConfig );
}

/**
 * 띄웠던 로딩화면을 숨기는 함수
 *
 * @param $el :
 *            기존에 띄울때 넘긴 jquery 객체가 있다면 같은 객체를 넘겨줘야 닫혀집니다.
 */
function doHideLoading( $el )
{
	var $target = ( $el ) ? $el : $body;
	$target.unblock();
}

/**
 * Display object (true : visible, false : invisible)
 */
function fnReadOnly( objId, boolReadonly )
{
	console.log( objId + "[" + boolReadonly + "]" );
	$( "#" + objId ).attr( "readOnly" , boolReadonly );
}

/**
 * Display object (true : visible, false : invisible)
 */
function fnDisplayVisible( objId, boolVisible )
{
	console.log( objId + "[" + boolVisible + "]" );
	if ( boolVisible )
	{
		// $( "#" + objId ).css( "display" , "block" );
		$( "#" + objId ).removeClass( "d-none" );
	}
	else
	{
		// $( "#" + objId ).css( "display" , "none" );
		$( "#" + objId ).addClass( "d-none" );
	}
}

/**
 * Confirm modal popup visible.
 *
 * @param title :
 *            제목
 * @param message :
 *            메시지
 * @returns
 */
function fnConfirmMessage( title, message )
{
	$( '#modalTextConfirmTitle' ).text( title );
	$( '#modalSpanConfirmMessage' ).text( message );
	$( 'div#modalConfirm' ).modal();
}

var valid = {
	// 최소 자리수 체크
	minLen : function( str, length )
	{
		// console.log( "str[" + str.length + "] minLen[" + length + "]" + (
		// str.length < length ) );
		if ( length > 0 )
		{
			if ( str.length < length )
			{
				console.log( "최소 입력 자리수는 " + length + "자리 입니다." );
				return true;
			}
			else
			{
				return false;
			}
		}
		else
		{
			console.log( "요청 자리수 [" + length + "] 확인하세요." );
			return true;
		}
	} ,
	// 최대 자리수 체크
	maxLen : function( str, length )
	{
		if ( length > 0 )
		{
			if ( str.length > length )
			{
				console.log( "최대 입력 자리수는 " + length + "자리 입니다." );
				return true;
			}
			else
				return false;
		}
		else
		{
			console.log( "요청 자리수 [" + length + "] 확인하세요." );
			return true;
		}
	} ,
	// 브라우저(IE) 확인
	isBrowserIe : function()
	{
		var agent = navigator.userAgent.toLowerCase();
		if ( ( navigator.appName == 'Netscape' && navigator.userAgent.search( 'Trident' ) != -1 ) || ( agent.indexOf( "msie" ) != -1 ) )
		{
			// ie 일때 input[type=file] init.
			return true;
		}
		else
		{
			// other browser 일때 input[type=file] init.
			return false;
		}
	} ,
	// 같은지 확인
	isEquals : function( str, targetStr )
	{
		// console.log( "str=" + str + "\ntargetStr=" + targetStr + "[" + str
		// === targetStr + "/" + str == targetStr + "]" );
		if ( str === targetStr )
		{
			return true;
		}
		else if ( str == targetStr )
		{
			return true;
		}
		else
		{
			return false;
		}
	} ,
	// 영문으로 구성 되어있는지 체크
	// lowUp (L : 소문자 , U : 대문자)
	isAlpha : function( str, lowUp )
	{
		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\" ]/gi;

		if ( regExp.test( str ) )
			return false;

		regExp = /[가-힣ㄱ-ㅎㅏ-ㅣ]/gi;
		if ( regExp.test( str ) )
			return false;

		regExp = /[a-zA-Z]/gi;
		if ( regExp.test( str ) )
		{
			if ( lowUp == "L" )
			{
				regExp = /[a-z]/gi;
				if ( regExp.test( str ) )
					return true;
				else
					return false;
			}
			else if ( lowUp == "U" )
			{
				regExp = /[A-Z]/gi;
				if ( regExp.test( str ) )
					return true;
				else
					return false;
			}
			else
				return true;
		}
		else
			return false;
	} ,
	// 숫자로 구성 되어있는지 체크
	isNumber : function( str )
	{
		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\" ]/gi;

		if ( regExp.test( str ) )
			return false;

		regExp = /[가-힣ㄱ-ㅎㅏ-ㅣ]/gi;
		if ( regExp.test( str ) )
			return false;

		regExp = /[0-9]/gi;
		if ( regExp.test( str ) )
			return true;
		else
			return false;
	} ,
	// 숫자와 특수문자 . 로 구성 되어있는지 체크
	isNumberDot : function( str )
	{
		var regExp = /[\{\}\[\]\/?,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\" ]/gi;

		if ( regExp.test( str ) )
			return false;

		regExp = /[가-힣ㄱ-ㅎㅏ-ㅣ]/gi;
		if ( regExp.test( str ) )
			return false;

		regExp = /[0-9.]/gi;
		if ( regExp.test( str ) )
			return true;
		else
			return false;
	} ,
	// 영문과 숫자로 구성 되어있는지 체크
	isAlphaNumber : function( str )
	{
		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\" ]/gi;

		if ( regExp.test( str ) )
			return false;

		regExp = /[가-힣ㄱ-ㅎㅏ-ㅣ]/gi;
		if ( regExp.test( str ) )
			return false;

		regExp = /[a-zA-Z0-9]/gi;
		if ( regExp.test( str ) )
			return true;
		else
			return false;
	} ,
	// 파일명 체크
	isFileName : function( str )
	{
		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\+<>@\#$%&\\\=\(\'\" ]/gi;

		if ( regExp.test( str ) )
			return true;
		else
			return false;
	} ,
	// 영문만 남도록 변환
	// lowUp (L : 소문자 , U : 대문자)
	replaceAlpha : function( str, lowUp )
	{
		console.log( "before=" + str );
		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\" ]/gi;

		if ( regExp.test( str ) )
		{
			str = str.replace( regExp , "" );
		}

		regExp = /[가-힣ㄱ-ㅎㅏ-ㅣ]/gi;
		if ( regExp.test( str ) )
		{
			str = str.replace( regExp , "" );
		}

		regExp = /[0-9]/gi;
		if ( regExp.test( str ) )
		{
			str = str.replace( regExp , "" );
		}

		if ( lowUp == "L" )
		{
			regExp = /[A-Z]/gi;
			if ( regExp.test( str ) )
				str = str.replace( regExp , "" );
		}
		else if ( lowUp == "U" )
		{
			regExp = /[a-z]/gi;
			if ( regExp.test( str ) )
				str = str.replace( regExp , "" );
		}

		console.log( "change=" + str );
		return str;
	} ,
	// 숫자만 남도록 변환
	replaceNumber : function( str )
	{
		console.log( "before=" + str );
		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\" ]/gi;

		if ( regExp.test( str ) )
		{
			str = str.replace( regExp , "" );
		}

		regExp = /[가-힣ㄱ-ㅎㅏ-ㅣ]/gi;
		if ( regExp.test( str ) )
		{
			str = str.replace( regExp , "" );
		}

		regExp = /[a-zA-Z]/gi;
		if ( regExp.test( str ) )
		{
			str = str.replace( regExp , "" );
		}

		console.log( "change=" + str );
		return str;
	} ,
	// 숫자와 특수문자 . 만 남도록 변환
	replaceNumberDot : function( str )
	{
		console.log( "before=" + str );
		var regExp = /[\{\}\[\]\/?,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\" ]/gi;

		if ( regExp.test( str ) )
		{
			str = str.replace( regExp , "" );
		}

		regExp = /[가-힣ㄱ-ㅎㅏ-ㅣ]/gi;
		if ( regExp.test( str ) )
		{
			str = str.replace( regExp , "" );
		}

		regExp = /[a-zA-Z]/gi;
		if ( regExp.test( str ) )
		{
			str = str.replace( regExp , "" );
		}

		console.log( "change=" + str );
		return str;
	} ,
	// 영문과 숫자만 남도록 변환
	replaceAlphaNumber : function( str )
	{
		console.log( "before=" + str );
		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\" ]/gi;

		if ( regExp.test( str ) )
		{
			str = str.replace( regExp , "" );
		}

		regExp = /[가-힣ㄱ-ㅎㅏ-ㅣ]/gi;
		if ( regExp.test( str ) )
		{
			str = str.replace( regExp , "" );
		}

		console.log( "change=" + str );
		return str;
	} ,
	// 영문과 숫자와 특수문자 . 만 남도록 변환
	replaceAlphaNumberDot : function( str )
	{
		console.log( "before=" + str );
		var regExp = /[\{\}\[\]\/?,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\" ]/gi;

		if ( regExp.test( str ) )
		{
			str = str.replace( regExp , "" );
		}

		regExp = /[가-힣ㄱ-ㅎㅏ-ㅣ]/gi;
		if ( regExp.test( str ) )
		{
			str = str.replace( regExp , "" );
		}

		console.log( "change=" + str );
		return str;
	} ,
	// 영문과 숫자와 한글만 남도록 변환
	replaceAlphaNumberHangul : function( str )
	{
		console.log( "before=" + str );
		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\" ]/gi;

		if ( regExp.test( str ) )
		{
			str = str.replace( regExp , "" );
		}

		console.log( "change=" + str );
		return str;
	} ,
	// 영문과 숫자와 한글, 특수문자 . 만 남도록 변환
	replaceName : function( str )
	{
		console.log( "before=" + str );
		var regExp = /[\{\}\[\]\/?,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;

		if ( regExp.test( str ) )
		{
			str = str.replace( regExp , "" );
		}
		str = str.trim();

		console.log( "change=" + str );
		return str;
	}
}

function isEmpty( str )
{
	if ( typeof str === 'undefined' )
		return true;
	else if ( str === "" )
		return true;
	else
		return false;
}

function isNumber( str )
{
	var regExp = /[0-9]/gi;
	if ( regExp.test( str ) )
		return true;
	else

		return false;
}

function getEmptyStr( str )
{
	if ( str == null || str.toLowerCase() == "null" )
		return "";
	else if ( typeof str == "undefiend" )
		return "";
	else
		return str;
}

function setStringToInt( str, targetId, targetType )
{
	var value = str;
	var type = "";

	if ( !isEmpty( targetType ) )
	{
		type = targetType;
		if ( type == "val" )
		{
			$( "#" + targetId ).val( value );
		}
		else if ( type == "text" )
		{
			$( "#" + targetId ).text( value );
		}
		else if ( type == "html" )
		{
			$( "#" + targetId ).html( value );
		}
	}
	else
	{
		if ( $( "#" + targetId ).type() == "input" )
		{
			$( "#" + targetId ).val( value );
		}
		else if ( $( "#" + targetId ).type() == "span" )
		{
			$( "#" + targetId ).text( value );
		}
		else if ( $( "#" + targetId ).type() == "div" )
		{
			$( "#" + targetId ).html( value );
		}
	}
}

var wsCallAll;

var urlCallAll;
var boolWsNotUse = false;
function setSocket( socketType, ws )
{
	if ( boolWsNotUse )
		return false;
	if ( socketType == "callAll" )
	{
		urlCallAll = ws;
	}

	writeLog( socketType , "setSocket()" );
}

function getSocket( socketType )
{

	if ( boolWsNotUse )
		return false;
	var ws;
	if ( socketType == "callAll" )
	{
		ws = wsCallAll;
	}

	return ws;
}

function setSocketUrl( socketType, url )
{
	if ( boolWsNotUse )
		return false;
	if ( socketType == "callAll" )
	{
		urlCallAll = url;
	}
}

function getSocketUrl( socketType )
{
	if ( boolWsNotUse )
		return false;
	var wsUrl;
	if ( socketType == "callAll" )
	{
		wsUrl = urlCallAll;
	}

	return wsUrl;
}

function openSocket( socketType )
{
	if ( boolWsNotUse )
		return false;
	var ws = getSocket( socketType );

	if ( ws !== undefined && ws.readyState !== WebSocket.CLOSED )
	{
		console.log( "WebSocket is already opened." );
		alert( "WebSocket is already opened." );
		return;
	}

	openSocketUrl( socketType );
}

function openSocketUrl( socketType )
{
	if ( boolWsNotUse )
		return false;
	var ws = getSocket( socketType );
	var wsUrl = getSocketUrl( socketType );

	if ( wsUrl == undefined || wsUrl == "" )
	{
		console.log( "연결할 Url을 확인하세요." );
		return false;
	}

	// 웹소켓 객체 만드는 코드
	ws = new WebSocket( wsUrl );

	ws.onopen = function( event )
	{
		if ( event.data === undefined )
			return;
	};
	ws.onmessage = function( event )
	{
		// console.log( "onmessage [" + socketType + "]" + event.data );
		writeResponse( socketType , event.data );
	};
	ws.onclose = function( event )
	{
		// console.log( "onclose [" + socketType + "]" + event.data );
		writeLog( socketType , "Connection closed" );
	}

	setSocket( socketType , ws );
}

function sendPushMsg( socketType, sendMsg )
{
	if ( boolWsNotUse )
		return false;
	var ws = getSocket( socketType );

	if ( ws === undefined || ws.readyState === WebSocket.CLOSED )
	{
		console.log( "WebSocket is null or closed." );
		alert( "WebSocket is null or closed." );
		return;
	}

	writeLog( socketType , sendMsg );
	ws.send( sendMsg );
}

function closeSocket( socketType )
{
	if ( boolWsNotUse )
		return false;
	var ws = getSocket( socketType );

	if ( ws === undefined || ws.readyState === WebSocket.CLOSED )
	{
		console.log( "WebSocket is null or closed." );
		alert( "WebSocket is null or closed." );
		return;
	}

	ws.close();
}

function writeLog( socketType, text )
{
	if ( boolWsNotUse )
		return false;
	// console.log( "writeLog=[" + socketType + "]" + text );
	$( "#" + socketType + "Log" ).html( text + "<br>" + $( "#" + socketType + "Log" ).html() );
}

function writeResponse( socketType, text )
{
	if ( boolWsNotUse )
		return false;
	// console.log( "writeResponse [" + socketType + "]" + text );
	writeLog( socketType , text );
	try
	{
		var jsonObj = JSON.parse( text );

		if ( socketType == "callAll" )
		{
			fnResponseCallAll( socketType , jsonObj );
		}
		else if ( jsonObj.resultCode == "success" )
		{
			if ( jsonObj.resultType == "connect" )
			{
				openSocketResponse( socketType , jsonObj );
			}
		}
	}
	catch ( error )
	{

	}
}
