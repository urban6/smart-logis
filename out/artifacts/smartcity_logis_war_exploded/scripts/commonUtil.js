/**
 * @author user 화면이동
 */
function movePage( sUrl, param )
{
	$( "#_bizTempForm" ).remove();
	var sHtml = "";
	sHtml += "<form id=\"_bizTempForm\" action=\"" + sUrl + "\" method=\"post\">";
	sHtml += "</form>";
	$( "body" ).append( sHtml );
	if ( param != null )
	{
		var keys = Object.keys( param );
		for ( var i = 0 ; i < keys.length ; i++ )
		{
			var key = keys[ i ];
			$( "#_bizTempForm" ).append( "<input type=\"hidden\" name=\"" + key + "\"/>" );
			$( "#_bizTempForm input:last" ).val( param[ key ] );
		}
	}
	$( "#_bizTempForm" ).submit();
}

/*
 * function openPopup(sUrl, sName, param, width, height) { window.open("",
 * sName,
 * "toolbar=no,location=no,directories=no,status=no,menubar=no,"+"scrollbars=1,resizable=no,copyhistory=1,width="+width+","+"height="+height+",top=0,left=0","replace");
 * $("#_bizTempForm").remove(); var sHtml = ""; sHtml += "<form
 * id=\"_bizTempForm\" action=\""+sUrl+"\" method=\"post\"
 * target=\""+sName+"\">"; if (param != null) { var keys = Object.keys(param);
 * for (var i=0;i<keys.length;i++) { var key = keys[i]; sHtml += "<input
 * type=\"hidden\" name=\""+key+"\" value=\""+param[key]+"\"/>"; } } sHtml += "</form>";
 * $("body").append(sHtml); $("#_bizTempForm").submit(); }
 */

/**
 * @param obj
 *            동일한 알람 이력의 toast 경우 중복 판별 함수 이미 떠있는 토스트는 중복실행하지않는다.
 */
// var toastArray = new Array();
var toastObjects = new Object();
function toast( obj )
{
	var toastObj = toastObjects[ obj.alarm_hist_no ];
	if ( toastObj != null )
	{
		return;
	}
	else
	{
		toastObj = new Object();
		toastObj.toastLoopCnt = 1;
		toastObjects[ obj.alarm_hist_no ] = toastObj;
	}

	// return;

	/*
	 * if ($.inArray(obj.alarm_hist_no,toastArray) != -1) { return; } else {
	 * toastArray.push(obj.alarm_hist_no); }
	 */
	showToast( obj );
}

/**
 * @param obj
 *            toast 실행 메서드 func_alarm()에서 호출되고, header.jsp에서 10초간격 호출
 */

function showToast( obj )
{
	// console.log(toastObjects[obj.alarm_hist_no].toastLoopCnt);
	// console.log(obj.alarm_hist_no+" : "+obj.alarm_no);
	// if (obj.alarm_hist_no == "7") debugger;

	// 우선순위필요
	var title = obj.toast_title; //
	var msg = obj.toast_msg;//

	var shortCutFunction = obj.t_type;
	var positionClass = obj.t_position;

	var addClear = truefalse( obj.t_butt_clear );
	// var repeatDuration = obj.t_repeat_duration * 1000; //반복 간격 타임
	var repeatDuration = obj.t_repeat_duration // 반복 간격 타임
	var repeatCnt = obj.t_repeat;
	toastr.options = {
		// "test" :"TEST" ,
		"closeButton" : truefalse( obj.t_butt_close ) ,
		"debug" : false ,
		"newestOnTop" : true ,
		"progressBar" : truefalse( obj.t_butt_bar ) ,
		"positionClass" : "toast-top-right" ,
		"preventDuplicates" : truefalse( obj.t_butt_noduplicate ) ,
		/*
		 * "onclick": function(){ console.log("====================onclick")
		 * console.log(obj); if(obj.t_butt_close=='Y'){ tabToDismiss=false
		 * toastr.options.tapToDismiss = tapToDismiss; } },
		 */
		"showDuration" : "300" ,
		"hideDuration" : "1000" ,
		"timeOut" : parseInt( obj.t_timeout ) ,
		"extendedTimeOut" : "1000" ,
		"showEasing" : "swing" ,
		"hideEasing" : "linear" ,
		"showMethod" : obj.t_show_type ,
		"hideMethod" : obj.t_hide_type ,
		"closeOnHover" : false ,
		"tapToDismiss" : false ,
		"closeHtml :" : '<button type="button">&times;</button>' ,
		"onCloseClick" : function()
		{
			// console.log("====================onCloSEclick")
			// console.log(obj);
			var param = new Object();
			param.alarm_hist_no = obj.alarm_hist_no;
			$.ajax( {
				url : "/management/operation/alarmmanage/alarmToastDelete.ajax" ,
				data : param ,
				type : 'POST' ,
				dataType : 'json' ,
				async : false ,
				success : function( data )
				{
				} ,
				error : function( e )
				{
					openAlertModal( "" , callErrorMsg );
				} ,
				complete : function()
				{

				}
			} );
		} ,
		"onHidden" : function( bTimeout )
		{
			// console.log("================ONHIDDEN,
			// repeatDuration="+repeatDuration);
			// console.log(obj);
			// console.log(toastr.options);
			// console.log(bTimeout);
			// console.log(repeatDuration)
			if ( bTimeout == true )
			{ // bTimeout = true는 시간지나서꺼지는것. //bTimeout = false 사용자가 끄는거
				if ( repeatCnt == 0 )
				{
					setTimeout( function()
					{
						// if(bTimeout==true){
						// console.log("bTimeout=true");
						// console.log(obj);
						showToast( obj );
						// bTimeout=false;
						// }
					} , repeatDuration ); // 5000ms(5초)가 경과하면 이 함수가 실행합니다.
				}
				else
				{
					// console.log("$$$$$$$$$$$$$$$$$$$$$$$====================");
					// console.log("alarm_hist_no : "+obj.alarm_hist_no+" ,
					// repeatCnt : "+ repeatCnt+", toastLoopCnt :
					// "+toastObjects[obj.alarm_hist_no].toastLoopCnt);
					if ( toastObjects[ obj.alarm_hist_no ].toastLoopCnt < repeatCnt )
					{
						setTimeout( function()
						{
							showToast( obj );
							toastObjects[ obj.alarm_hist_no ].toastLoopCnt++;
						} , repeatDuration )
					}
					var param = new Object();

					param.alarm_hist_no = obj.alarm_hist_no;
					$.ajax( {
						url : "/management/operation/alarmmanage/alarmToastDelete.ajax" ,
						data : param ,
						type : 'POST' ,
						dataType : 'json' ,
						async : false ,
						success : function( data )
						{

						} ,
						error : function( e )
						{
							openAlertModal( "" , callErrorMsg );
						} ,
						complete : function()
						{

						}
					} );
				}
			}
		}

	};

	if ( parseInt( obj.t_timeout ) > 0 )
	{
		toastr.options.timeOut = addClear ? 0 : parseInt( obj.t_timeout );
	}
	if ( addClear )
	{
		var tapToDismiss = true;
		if ( obj.t_butt_close == "Y" )
		{
			tapToDismiss = false;
		}
		toastr.options.tapToDismiss = tapToDismiss;
	}

	var $toast = toastr[ shortCutFunction ]( msg , title ); // Wire up an event
	// handler to a
	// button in the
	// toast, if it
	// exists
	$toastlast = $toast;

	if ( typeof $toast === 'undefined' )
	{
		return;
	}
}
/*
 * var getMessageWithClearButton = function (msg) { msg = msg ? msg : 'Clear
 * itself?'; msg += '<br /><br /><button type="button" class="btn clear">Yes</button>';
 * return msg; }
 */

/**
 * @param customOptions
 *            Screen Flash Effect <<Usage >> flashEffect({"color": "green",
 *            "repeat": 20, "fadeDuration": 100, "showDuration":100});
 *            flashEffect({"color": "rgba(255,0,0,0.5)", "repeat": 3});
 */
var alarm_sound_playing = false;
var alarm_flash_playing = false;
var fadeInInterval = null;
var fadeOutInterval = null;
function flashEffect( customOptions, alarmHistNo )
{
	alarm_flash_playing = true;
	var defaultOptions = {
		"repeat" : 1 ,
		"color" : "#ff0000" ,
		"fadeDuration" : 300 ,
		"showDuration" : 300 ,
		"width" : 50
	};

	var options = $.extend( defaultOptions , customOptions );
	// console.log("flash===============")
	// console.log(options)
	/*
	 * if(fadeInInterval != null){ clearTimeout(fadeInInterval);
	 * clearTimeout(fadeOutInterval); } $("._soFlashEffectDiv").remove();
	 */
	stopFlash();
	// console.log(options);
	var sHtml = "";
	sHtml += "<div class=\"_soFlashEffectDiv\" style=\"width:100%;height:" + options.width
			+ "px;top:0px;left:0px;z-index:99999;position:absolute;display:none;background: -webkit-linear-gradient(top, " + options.color + " 0%,rgba(0,0,0,0) 100%);\"></div>";
	sHtml += "<div class=\"_soFlashEffectDiv\" style=\"width:100%;height:" + options.width + "px;top:calc(100% - " + options.width
			+ "px);left:0px;z-index:99999;position:absolute;display:none;background: -webkit-linear-gradient(bottom, " + options.color + " 0%,rgba(0,0,0,0) 100%);\"></div>";
	sHtml += "<div class=\"_soFlashEffectDiv\" style=\"width:" + options.width
			+ "px;height:100%;top:0px;left:0px;z-index:99999;position:absolute;display:none;background: -webkit-linear-gradient(left, " + options.color
			+ " 0%,rgba(0,0,0,0) 100%);\"></div>";
	sHtml += "<div class=\"_soFlashEffectDiv\" style=\"width:" + options.width + "px;height:100%;top:0px;left:calc(100% - " + options.width
			+ "px);z-index:99999;position:absolute;display:none;background: -webkit-linear-gradient(right, " + options.color + " 0%,rgba(0,0,0,0) 100%);\"></div>";

	$( "body" ).prepend( sHtml );
	var sWidth = $( "._soFlashEffectDiv:eq(2)" ).css( "width" );

	$( "._soFlashEffectDiv" ).css( "top" , $( "body" ).scrollTop() + "px" );
	$( "._soFlashEffectDiv:eq(1)" ).css( "top" , "calc(100% + " + ( $( "body" ).scrollTop() ) + "px - " + sWidth + ")" );

	var fadeDuration = options.fadeDuration;
	var showDuration = options.showDuration;
	var timeout = fadeDuration + showDuration;
	var alarmObj = getAlarmObj( alarmHistNo );
	var now_time = new Date().getTime();
	console.log( "========================" )
	console.log( timeout );

	var repeat = options.repeat;
	if ( repeat != 0 )
	{
		if ( now_time < alarmObj.flash_play_time )
		{
			$( "._soFlashEffectDiv" ).fadeIn( fadeDuration );
			setTimeout( function()
			{
				$( "._soFlashEffectDiv" ).fadeOut( fadeDuration );
			} , timeout );
		}
	}
	else
	{
		$( "._soFlashEffectDiv" ).fadeIn( fadeDuration );
		setTimeout( function()
		{
			$( "._soFlashEffectDiv" ).fadeOut( fadeDuration );
		} , timeout );
	}

	fadeInInterval = setInterval( function()
	{
		var now_time = new Date().getTime();
		var alarmObj = getAlarmObj( alarmHistNo );
		// console.log("========StartFlash");
		// console.log("now_time : "+now_time+", flash_play_time :
		// "+alarmObj.flash_play_time);
		if ( repeat > 1 && now_time < alarmObj.flash_play_time )
		{
			console.log( "######################1 : " + repeat );
			$( "._soFlashEffectDiv" ).fadeIn( fadeDuration );
			repeat--;
		}
		else if ( repeat == 0 )
		{
			$( "._soFlashEffectDiv" ).fadeIn( fadeDuration );
		}
		else
		{
			clearTimeout( fadeInInterval );
			clearTimeout( fadeOutInterval );
			alarm_flash_playing = false;
			// console.log("===================================================================================================")
			// debugger;
			nextAlarm( alarmHistNo );// 다음 alarm 호출
			// console.log("========StopFlash");
		}
	} , timeout * 2 );

	setTimeout( function()
	{
		$( "._soFlashEffectDiv" ).fadeOut( fadeDuration );
		fadeOutInterval = setInterval( function()
		{
			$( "._soFlashEffectDiv" ).fadeOut( fadeDuration );
		} , timeout * 2 );
	} , timeout );
}

/**
 *
 * sound 실행 메서드
 */
var soundCnt = 0;
function sound( customOptions, alarmHistNo )
{
	console.log( sound );
	alarm_sound_playing = true;
	var defaultOptions = {
		"loop" : 0 ,
		"volume" : 1 ,
		"showDuration" : 1
	};
	/*
	 * if ($("#myAudio").length > 0) { var interval =
	 * $("#myAudio").data("interval"); clearInterval(interval);
	 * $("#myAudio").remove(); }
	 */
	stopSound();

	var options = $.extend( defaultOptions , customOptions );

	// var duration = options.loopDuration * 1000;
	var duration = options.loopDuration;
	console.log( "duration : " + duration + ", loop : " + options.loop );

	var sHtml = "";
	// sHtml += "<audio id=\"myAudio"+soundCnt+"\"
	// src=\"/file/download/"+options.fileNo+"\" autoplay></audio>";
	sHtml += "<audio id=\"myAudio\" src=\"/file/download/" + options.fileNo + "\" ></audio>";
	// console.log("second="+(new Date()).getSeconds());

	$( "body" ).append( sHtml );
	var audio = document.getElementById( "myAudio" );
	// console.log(audio)

	var now_time = new Date().getTime();
	var alarmObj = getAlarmObj( alarmHistNo );

	audio.volume = options.volume / 10;

	if ( options.loop != 0 )
	{
		if ( now_time < alarmObj.sound_play_time )
		{
			audio.play();
		}
	}
	else
	{
		audio.play();
	}
	var loopCnt = 1;

	// sound 반복
	// console.log(options.loop);
	audio.onloadeddata = function()
	{
		var length = audio.duration;
		// console.log("반복 duration : "+duration)
		// console.log("audio 재생시간 : "+options.playTime);
		// console.log(" interval :"+((options.playTime * 1000) + duration))
		// console.log("audio 재생시간 : "+length);
		var interval = setInterval( function()
		{
			console.log( ( options.playTime * 1000 ) + duration );
			// console.log("audio.id="+audio.id+", audio.ended="+audio.ended+",
			// interval="+interval+", loopCnt="+loopCnt);
			console.log( "ended  ???????" )
			if ( audio.ended )
			{
				console.log( "end yes" )
				var now_time = new Date().getTime();
				var alarmObj = getAlarmObj( alarmHistNo );
				// console.log("=========StartSound");
				// console.log("now_time : "+now_time+" , sound_play_time :
				// "+alarmObj.sound_play_time+",
				// loopCnt<options.loop="+(loopCnt<options.loop)+",
				// now_time<alarmObj.sound_play_time="+(now_time<alarmObj.sound_play_time));
				if ( options.loop == 0 || ( loopCnt < options.loop && now_time < alarmObj.sound_play_time ) )
				{
					// console.log("second="+(new Date()).getSeconds());
					audio.play();
					loopCnt++;
				}
				else
				{
					clearInterval( interval );
					// $("#myAudio"+soundCnt).remove();
					audio.remove();
					alarm_sound_playing = false;
					// console.log("===================================================================================================")
					// debugger;
					nextAlarm( alarmHistNo );// //////////////////
					// console.log("============StopSound");
				}
			}// audio end
		} , ( options.playTime * 1000 ) + duration );
		$( "#myAudio" ).data( "interval" , interval );
	};
}

// 알람 종료 여부 판별
function is_alarm_playing()
{
	if ( alarm_sound_playing || alarm_flash_playing ) // sound, flash 중 하나라도
		// play중이면 true
		return true;
	else
		// sound, flash 둘다 play끝났으면 false
		return false;
}

// alarmHistNo로 alarm객체 가져오기
function getAlarmObj( alarmHistNo )
{
	for ( var i = 0 ; i < alarm_stack.length ; i++ )
	{
		var alarm = alarm_stack[ i ];
		if ( alarm.alarm_hist_no == alarmHistNo )
		{
			// console.log(alarm)
			return alarm;
		}
	}
}

// 알람제거
function alarm_remove( alarmHistNo, fnCallback )
{
	var bExist = false;
	for ( var i = 0 ; i < alarm_stack.length ; i++ )
	{
		var alarm = alarm_stack[ i ];
		if ( alarm.alarm_hist_no == alarmHistNo )
		{
			bExist = true;
			alarm_stack.splice( i , 1 );
			console.log( "alarm remove" );
			var param = new Object();

			param.alarm_hist_no = alarmHistNo
			$.ajax( {
				url : "/management/operation/alarmmanage/alarmRemove.ajax" ,
				data : param ,
				type : 'POST' ,
				dataType : 'json' ,
				async : false ,
				success : function( data )
				{
					if ( data.returnMsg == "SUCCESS" )
					{
						if ( fnCallback != null )
						{
							fnCallback.call( data );
						}
					}
					else
					{
						openAlertModal( data.resultMsg );
					}
				} ,
				error : function( e )
				{
					openAlertModal( "" , callErrorMsg );
				} ,
				complete : function()
				{

				}
			} );

		}
	}
	if ( !bExist )
	{
		if ( fnCallback != null )
		{
			fnCallback.call();
		}
	}
}
// next알람 호출 메서드
function nextAlarm( alarmHistNo, fnCallback )
{
	// 알람종료안했으면 리턴
	if ( is_alarm_playing() )
	{
		// console.log("is_alarm_playing() true ")
		return;
	}

	alarm_remove( alarmHistNo , fnCallback );

	// console.log("is_alarm_playing() false ");
	// console.log("alarm_stack : ");
	// console.log(alarm_stack);
	var new_array = new Array();
	var goAlarm = null;

	// 알람종료하면
	for ( var i = 0 ; i < alarm_stack.length ; i++ )
	{
		// console.log("========알람종료======================")
		var alarm = alarm_stack[ i ];
		// var afterAlarm = alarm_stack[i+1];
		var now_time = new Date().getTime();
		var preview_ref_val = null;
		if ( goAlarm != null )
		{
			preview_ref_val = goAlarm.ref_val;
		}
		// console.log("alarm.alarm_hist_no : "+alarm.alarm_hist_no);
		// console.log("now_time : "+now_time);
		// console.log("alarm.total_timeout : " + alarm.total_timeout);
		// console.log("alarm.end_time : "+alarm.end_time);
		// console.log("goAlarm : "+goAlarm);
		// console.log("preview_ref_val : "+preview_ref_val);
		if ( alarm.total_timeout == 0 || alarm.end_time > now_time )
		{ // 다음으로재생될알람(next alarm)의 종료시간이 현재시간보다 크면 다음으로재생될알람의 재생될시간이남아있다.
			// console.log("alarm.end_time > now_time true");
			new_array.push( alarm );
			if ( preview_ref_val == null || alarm.ref_val > preview_ref_val )
			{
				// console.log("####true")
				goAlarm = alarm;
			}
			// console.log("goAlarm");
			// console.log(goAlarm.alarm_hist_no);
		}
		/*
		 * else{//종료된알람이므로 alarm_stack에서 삭제 alarm_stack.splice(i,1); break; }
		 */
	}
	if ( goAlarm != null )
	{
		func_alarm( goAlarm.alarm_hist_no );
	}
	alarm_stack = new_array;
}

// 알람 우선순위 변수
var alarm_prior_order = null;
// 알람 스택 배열 변수
var alarm_stack = new Array();

// alarm_stack에 중복으로 put 금지
function is_exist( alarmHistObj )
{
	for ( var i = 0 ; i < alarm_stack.length ; i++ )
	{
		// console.log("alarm_stack[i]_alarm_hist_no :
		// "+alarm_stack[i].alarm_hist_no+", alarmHistObj.alarm_hist_no :
		// "+alarmHistObj.alarm_hist_no);
		if ( alarm_stack[ i ].alarm_hist_no == alarmHistObj.alarm_hist_no )
		{
			return true;
		}
	}
	return false;
}

/**
 *
 * @param alarmHistNo
 *            알람실행메서드 toast, flash, sound 사용여부에 따라 메서드를 호출한다
 *            so_alarm_hist(알람이력테이블)에 insert하면서 각 화면에서 func_alarm()호출
 *
 */
var current_alarm_hist_no;
function func_alarm( alarmHistNo )
{
	alert( "func_alarm" );
	if ( alarmHistNo != null )
	{
		/*
		 * if (is_exist({"alarm_hist_no": ""+alarmHistNo})) { return; }
		 */
		var param = new Object();
		param.alarm_hist_no = alarmHistNo;
		$.ajax( {
			url : "/management/operation/alarmmanage/alarmSelect.ajax" ,
			data : param ,
			type : 'POST' ,
			dataType : 'json' ,
			async : false ,
			success : function( data )
			{
				console.log( data.alarm );
				if ( data.alarm == null )
				{
					return;
				}
				if ( !is_exist( data.alarm ) && !( data.alarm.effect_yn == "N" && data.alarm.sound_yn == "N" ) )
				{
					// 시간계산 - audio재생해야 audio재생시간알수있음
					// var soundPlayTime = 현재시간 + sound_playTime(data.alarm);
					// var flashTimeout = 현재시간 +(data.alarm.e_fade_duration +
					// data.alarm.e_show_duration) * data.alarm.e_repeat * 2;
					// data.alarm.soundPlayTime=soundPlayTime;
					// data.alarm.flshTimeout = flashTimeout;
					// alarm_stack.push(data.alarm);
					// console.log(data.alarm)
					var soundPlayTime = 0;
					var flashPlayTime = 0;
					var total_timeout = null;
					console.log( data.alarm.s_play_time );
					console.log( ( parseFloat( data.alarm.s_play_time ) * 1000 ) );
					// var soundPlayTime = ( (parseFloat(data.alarm.s_play_time)
					// * 1000) * parseInt(data.alarm.s_loop) ) + (
					// (parseInt(data.alarm.s_loop_duration) * 1000) *
					// (parseInt(data.alarm.s_loop)-1) );
					var soundPlayTime = ( ( parseFloat( data.alarm.s_play_time ) * 1000 ) * parseInt( data.alarm.s_loop ) )
							+ ( ( parseInt( data.alarm.s_loop_duration ) ) * ( parseInt( data.alarm.s_loop ) - 1 ) );
					console.log( soundPlayTime );
					var flashPlayTime = ( parseInt( data.alarm.e_fade_duration ) + parseInt( data.alarm.e_show_duration ) ) * 2 * parseInt( data.alarm.e_repeat );

					// console.log("soundPlayTime : "+soundPlayTime+",
					// flashTimeout : "+flashPlayTime);

					if ( data.alarm.effect_yn == "Y" && data.alarm.sound_yn == "Y" )
					{
						if ( parseInt( data.alarm.s_loop ) > 0 && parseInt( data.alarm.e_repeat ) > 0 )
						{ // sound와 effect 둘다 무한반복이 아닌경우
							/*
							 * soundPlayTime =
							 * parseFloat(data.alarm.s_play_time) * 1000 *
							 * parseInt(data.alarm.s_loop)
							 * +(parseInt(data.alarm.s_loop_duration) * 1000);
							 * flashPlayTime =
							 * (parseInt(data.alarm.e_fade_duration) +
							 * parseInt(data.alarm.e_show_duration)) *
							 * parseInt(data.alarm.e_repeat) * 2;
							 */
							if ( soundPlayTime > flashPlayTime )
							{
								total_timeout = soundPlayTime;
							}
							else
							{
								total_timeout = flashPlayTime;
							}
						}
						else
						{ // 둘중에 하나라도 무한반복 이거나 둘다 무한반복인경우
							total_timeout = 0;
						}
					}
					else if ( data.alarm.effect_yn == "N" && data.alarm.sound_yn == "Y" )
					{
						if ( parseInt( data.alarm.s_loop ) > 0 )
						{ // sound
							/*
							 * total_timeout =
							 * parseFloat(data.alarm.s_play_time) * 1000 *
							 * parseInt(data.alarm.s_loop)
							 * +(parseInt(data.alarm.s_loop_duration) * 1000);
							 */
							total_timeout = soundPlayTime;
						}
						else if ( parseInt( data.alarm.s_loop ) == 0 )
						{ // sound 무한반복인경우
							total_timeout = 0;
						}
					}
					else if ( data.alarm.effect_yn == "Y" && data.alarm.sound_yn == "N" )
					{
						if ( parseInt( data.alarm.e_repeat ) > 0 )
						{ // effect
							total_timeout = flashPlayTime;
							/*
							 * total_timeout =
							 * (parseInt(data.alarm.e_fade_duration) +
							 * parseInt(data.alarm.e_show_duration)) *
							 * parseInt(data.alarm.e_repeat) * 2;
							 */
						}
						else if ( parseInt( data.alarm.e_repeat ) == 0 )
						{ // flash무한반복인경우
							total_timeout = 0;
						}
					}
					var currentTime = new Date();
					var startTime = currentTime.getTime();
					var endTime;
					data.alarm.total_timeout = total_timeout; // sound ||
					// flash의 play시간
					data.alarm.start_time = startTime; // 현재시간
					if ( total_timeout != null )
					{
						endTime = data.alarm.start_time + total_timeout;
					}
					data.alarm.end_time = endTime; // 끝나는시간 = 현재시간 +
					// total_timeout;

					data.alarm.sound_play_time = startTime + soundPlayTime; // sound
					// 끝나는시간
					console.log( "=========================" )
					console.log( data.alarm.sound_play_time );
					console.log( new Date( data.alarm.sound_play_time ) );
					data.alarm.flash_play_time = startTime + flashPlayTime; // flash
					// 끝나는시간

					alarm_stack.push( data.alarm );
					// console.log(alarm_stack);
				}

				// console.log("alarm_stack : "+alarm_stack);

				if ( !is_alarm_playing() )
				{
					alarm_prior_order = 0;
				}
				// console.log("alarm_prior_order : "+alarm_prior_order+",
				// data.alarm.ref_val : " +data.alarm.ref_val);
				// 우선순위가 큰게들어오면 덮어쓰기
				if ( alarm_prior_order <= data.alarm.ref_val )
				{
					current_alarm_hist_no = data.alarm.alarm_hist_no;
					alarm_prior_order = data.alarm.ref_val;
					if ( data.alarm.effect_yn == "Y" )
					{
						// flash 우선순위
						// console.log("=======effect_yn : Y")
						// console.log(data.alarm);
						var alarmHistNo = data.alarm.alarm_hist_no;
						var repeat = parseInt( data.alarm.e_repeat );
						var color = data.alarm.e_color;
						var fadeDuration = parseInt( data.alarm.e_fade_duration );
						var showDuration = parseInt( data.alarm.e_show_duration );
						var width = parseInt( data.alarm.e_width );
						var customOptions = {
							"repeat" : repeat ,
							"color" : color ,
							"fadeDuration" : fadeDuration ,
							"showDuration" : showDuration ,
							"width" : width
						}
						flashEffect( customOptions , alarmHistNo );
					}
					else
					{
						stopFlash();
					}

					if ( data.alarm.sound_yn == "Y" )
					{
						// console.log("=======sound_yn : Y")
						var alarmHistNo = data.alarm.alarm_hist_no;
						var fileNo = data.alarm.s_file_no;
						var volume = parseInt( data.alarm.s_volume );
						var loop = parseInt( data.alarm.s_loop );
						var loopDuration = parseInt( data.alarm.s_loop_duration );
						var playTime = parseFloat( data.alarm.s_play_time );
						var customOptions = {
							"fileNo" : fileNo ,
							"volume" : volume ,
							"loop" : loop ,
							"loopDuration" : loopDuration ,
							"playTime" : playTime
						}
						sound( customOptions , alarmHistNo );
					}
					else
					{
						stopSound();
					}
					// 같은 우선순위 알람이 들어온경우
				}
				else if ( alarm_prior_order == data.alarm.ref_val )
				{

				}
				/*
				 * if(data.alarm.toast_yn=="Y"){ toast(data.alarm); }
				 */
			} ,
			error : function( e )
			{
				openAlertModal( "" , callErrorMsg );
			} ,
			complete : function()
			{

			}
		} );
	}
}

function fnAlarmClear( alarmHistNo, fnCallback )
{
	// console.log("current_alarm_hist_no : "+current_alarm_hist_no+",
	// alarmHistNo : "+alarmHistNo);
	if ( current_alarm_hist_no == alarmHistNo )
	{
		// console.log("current_alarm_hist_no==alarmHistNo : true")

		stopSound();
		alarm_sound_playing = false;
		stopFlash();
		alarm_flash_playing = false;
		nextAlarm( alarmHistNo , fnCallback );
	}
	else
	{
		alarm_remove( alarmHistNo , fnCallback );
	}

}

// sound stop메서드
function stopSound()
{
	if ( $( "#myAudio" ).length > 0 )
	{
		var interval = $( "#myAudio" ).data( "interval" );
		clearInterval( interval );
		$( "#myAudio" ).remove();
	}
}

// flash stop메서드
function stopFlash()
{
	if ( fadeInInterval != null )
	{
		clearTimeout( fadeInInterval );
		clearTimeout( fadeOutInterval );
	}
	$( "._soFlashEffectDiv" ).remove();
}

// Y/N을 ture/fasle로 변환 메서드
function truefalse( value )
{
	if ( value == "Y" )
	{
		return true;
	}
	else if ( value == "N" )
	{
		return false;
	}

}

/**
 * @param sSelector
 *            object 로딩 후 호출 이걸 호출 안하면 User Agent Stylesheet 가 적용되어 아이콘이 이상하게
 *            보인다.
 */
function onLoadSvgObject( sSelector, fnOnLoad )
{
	$( sSelector ).each( function()
	{
		$( this )[ 0 ].onload = function()
		{
			if ( $( this )[ 0 ].contentDocument.body != null )
			{
				$( this )[ 0 ].contentDocument.body.style.margin = "0px";
				if ( fnOnLoad != null )
				{
					fnOnLoad.call( this , $( this ) );
				}
			}
		};
	} );
}

/**
 * @param url
 * @param param
 * @param idx
 *            iframe Submit
 */
function iframeSubmit( url, param )
{
	var idx = $( "iframe" ).length;
	var iframeId = "commonIframe" + idx;
	var iframeSelector = "#" + iframeId;
	var formId = "commonForm" + idx;
	var formSelector = "#" + formId;
	$( iframeSelector ).remove();
	$( formSelector ).remove();
	$( "body" ).append( "<iframe id=\"" + iframeId + "\" name=\"" + iframeId + "\" style=\"display:none;\"></iframe>" );
	$( "body" ).append( "<form id=\"" + formId + "\" name=\"" + formId + "\" style=\"display:none;\"></form>" );
	var keys = Object.keys( param );
	for ( var i = 0 ; i < keys.length ; i++ )
	{
		var keyName = keys[ i ];
		var keyValue = param[ keyName ];
		if ( keyName != null && keyName != "" && keyValue != null && keyValue != "" )
		{
			$( formSelector ).append( "<input type=\"hidden\" name=\"" + keyName + "\" value=\"" + keyValue + "\"/>" );
		}
	}
	$( formSelector ).attr( "method" , "post" );
	$( formSelector ).attr( "target" , iframeId );
	$( formSelector ).attr( "action" , url );
	$( formSelector ).submit();
}

function showErrorMessage( el, errorMessage )
{
	$( "#" + el ).parent( "div" ).next( "span.alert" ).remove();
	// $("#" + el).parent("div").addClass("error"); // 테두리
	$( "#" + el ).parent().after( "<span class=\"alert\">" + errorMessage + "</span>" );
}

function hideErrorMessage( el )
{
	// $("#" + el).parent("div").removeClass("error"); // 테두리
	$( "#" + el ).parent( "div" ).next( "span.alert" ).remove();
}

/*
 * function hasErrorMessage(el) { if($("#" +
 * el).parent("div").next("span.alert").length > 0) { return true; } else {
 * return false; } }
 */
function hasErrorMessage()
{
	if ( $( "span.alert" ).length > 0 )
	{
		return true;
	}
	else
	{
		return false;
	}
}
