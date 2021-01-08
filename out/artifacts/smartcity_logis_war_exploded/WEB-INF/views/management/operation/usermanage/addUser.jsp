<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>
<!-- <link rel="stylesheet" type="text/css" href="/assets/libs/nestable/nestable.css"> -->
<!-- <link href="/dist/css/style.min.css" rel="stylesheet"> -->

<!-- This Page CSS -->
<!-- <link rel="stylesheet" type="text/css" href="/assets/libs/pickadate/lib/themes/default.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="/assets/libs/pickadate/lib/themes/default.date.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="/assets/libs/pickadate/lib/themes/default.time.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="/assets/extra-libs/toastr/dist/build/toastr.min.css"> -->
<!-- <script src="/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script> -->
<!-- <script src="/assets/extra-libs/toastr/dist/build/toastr.min.js"></script> -->

<!-- ============================================================== -->
<!-- Container fluid  -->
<!-- ============================================================== -->
<form name="addForm" id="addForm" commandName="addForm" method="post">
	<!-- ============================================================== -->
	<!-- Start Page Content -->
	<!-- ============================================================== -->
	<div class="row">
		<div class="col-sm-12 col-md-12">
			<div class="card">
				<div class="card-body">
					<c:set var="partnerSno" value="0" />
					<input type="hidden" id="userSnoAdd" name="userSno" value="" readonly="readonly" />
					<input type="hidden" id="loginIdAdd" name="loginId" value="" readonly="readonly" />
					<input type="hidden" id="statusAdd" name="status" value="" readonly="readonly" />
					<input type="hidden" id="partnerSnoAdd" name="partnerSno" value="" readonly="readonly" />

					<div class="form-body">
						<div class="row">
							<div class="col-md-4">
								<label onlick="javascript:fnTest();">사원번호</label>
								<span id="spanValidSid" style="color: red;">*</span>
								<div class="form-group">
									<input type="text" class="form-control" maxlength="10" id="sidAdd" name="sid" value="" readonly="readonly" />
								</div>
								<small class="form-text text-muted">영문과 숫자만 입력 가능</small>
							</div>
							<div class="col-md-4">
								<label>비밀번호</label>
								<div class="form-group">
									<input type="password" class="form-control" placeholder="**********" id="pwdAdd" name="pwd" value="" readonly="readonly" />
								</div>
								<small class="form-text text-muted">초기 비밀번호는 생년월일로 자동 설정</small>
							</div>
							<div class="col-md-4">
								<label>이름 </label>
								<span id="spanValidUserFnm" style="color: red;">*</span>
								<div class="form-group">
									<input type="text" class="form-control" maxlength="20" id="userFnmAdd" name="userFnm" value="" readonly="readonly" />
								</div>
								<small class="form-text text-muted">한글 및 영문 20자 이내 입력 가능</small>
							</div>
						</div>
					</div>
					<div class="form-body">
						<div class="row">
							<div class="col-md-4">
								<label>
									생년월일
									<span style="color: red;">*</span>
								</label>
								<div class="form-group">
									<div class="input-group">
										<input type="hidden" class="form-control" id="brdyAdd" name="brdy" value="" readonly="readonly" />
										<input type="text" class="form-control pickadate-change-format" placeholder="년도 /월/일" id="brdyStrAdd" name="brdyStr" value="" readonly="readonly" onChange="javascript:fnChangeBrdy();" />
										<div class="input-group-prepend" id="btnBrdyStrAdd">
											<span class="input-group-text" onclick="javascript:$('#brdyStrAdd').click();">
												<span class="ti-calendar"></span>
											</span>
										</div>
									</div>
								</div>
								<small class="form-text text-muted">필수 입력값입니다.</small>
							</div>
							<div class="col-md-4">
								<label>
									권한
									<span style="color: red;">*</span>
								</label>
								<div class="form-group">
									<input type="text d-none" class="form-control" id="levelTitleAdd" name="levelTitle" value="" readonly="readonly" />
									<input type="hidden" class="form-control" id="levelIdAdd" name="levelId" value="" readonly="readonly" />

									<select class="form-control" id="levelTitlAdd" name="levelTitl" onchange="javascript:fnChangeLevel( this.value );">
										<option value="">권한 선택</option>
										<c:set var="isLevelChecked" />
										<c:forEach items="${listUserLevel}" var="userLevel" varStatus="status">
											<option value="${userLevel.levelId}" ${isLevelChecked}>${userLevel.levelTitle}</option>
										</c:forEach>
									</select>
								</div>
								<small class="form-text text-muted">필수 입력값입니다.</small>
							</div>
						</div>
					</div>
				</div>
				<div class="row" style="padding: 0 0 1.57rem;">
					<div class="col-6">
						<div class="text-left" style="padding: 0 1.57rem;">
							<button class="btn waves-effect waves-light btn-primary" style="margin-right: 1rem;" onclick="javascript:fnInfoAdd();">계정 추가</button>
							<button class="btn waves-effect waves-light btn-secondary" onclick="javascript:fnCancelList();">취소</button>
						</div>
					</div>
					<div class="col-6">
						<div class="text-right" style="padding: 0 1.57rem;"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- //board -->
	<!-- Result content -->
	<div id="modalConfirm" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog" aria-labelledby="vcenter">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalTextConfirmTitle"></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label class="control-label">
							<span id="modalSpanConfirmMessage">{confirmMessage}</span>
						</label>
					</div>
				</div>
				<div class="modal-footer" id="modalConfirmAdd">
					<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">취소</button>
					<button type=button class="btn btn-primary waves-effect waves-light" data-dismiss="modal" onclick="javascript:fnProcAdd();">확인</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /.modal -->
</form>

<script type="text/javascript">
	var boolModify = false;

	$( document ).ready( function()
	{
		fnInit();
	} );

	//value setting
	function fnInit()
	{
		$( "#detailForm" ).on( "submit" , function( event )
		{
			if ( boolSubmit == false )
			{
				event.preventDefault();
			}
		} );

		fnDisplayVisible( "validMessageBrdy" , false );
		fnDisplayVisible( "validMessageUserLevel" , false );

		//radio 버튼 체크 (status)
		$( "#passwd" ).val( "" );

		fnReadOnly( "sid" , false );
		fnReadOnly( "userFnm" , false );

		fnDisplayVisible( "brdyTitle" , false );
		fnDisplayVisible( "brdyStr" , true );
		fnDisplayVisible( "btnBrdyStr" , true );

		fnDisplayVisible( "deptNm" , false );
		fnDisplayVisible( "levelTitle" , false );
		fnDisplayVisible( "levelTitl" , true );
		fnDisplayVisible( "deptList" , true );

		// 		fnDateFormat( "brdy" );
	}

	function fnCancelList()
	{
		boolSubmit = true;
		fnList();
	}

	function fnValid()
	{
		console.log( "sid length=" + $( "#sid" ).val().length );
		console.log( "brdy length=" + $( "#brdy" ).val().length );
		console.log( "levelId length=" + $( "#levelId" ).val().length );

		if ( $( "#sid" ).val().length < 1 )
		{
			fnErrorMessage( "사원번호를 확인하세요." );
			return false;
		}

		if ( $( "#userFnm" ).val().length < 1 )
		{
			fnErrorMessage( "이름을 확인하세요." );
			return false;
		}
		//공통 (계정 추가/수정)
		if ( $( "#brdy" ).val().length < 1 )
		{
			fnDisplayVisible( "validMessageBrdy" , true );
			fnErrorMessage( "생년월일을 확인하세요." );
			return false;
		}
		if ( $( "#levelId" ).val().length < 1 )
		{
			fnDisplayVisible( "validMessageUserLevel" , true );
			fnErrorMessage( "권한을 선택하세요." );
			return false;
		}

		return true;
	}

	function fnInfoAdd()
	{
		fnDisplayVisible( "modalConfirmAdd" , true );
		fnProcAdd();
	}

	//user manage add
	function fnProcAdd()
	{
		boolModify = false;
		fnLoading( true );

		var boolValid = fnValid();

		if ( boolValid )
		{
			boolModify = true;
			var param = new Object();
			param = $( "#detailForm" ).serialize();

			$.ajax( {
				url : "addAction" ,
				data : param ,
				type : 'POST' ,
				dataType : 'json' ,
				success : function( data )
				{
					fnModalOpen( 'modalConfirm' , false );

					console.log( "addAction result : " + data.resultMsg );

					if ( data.resultMsg == "succ" )
					{
						toastr.success( '입력하신 계정이 추가되었습니다.' , '추가 완료' );
						// 						fnResultMessage( "SUCCESS_LIST" , "detailForm" , "추가 완료" , "입력하신 계정이 추가되었습니다." );
					}
					else if ( data.resultMsg == "alreadyExists" )
					{

						fnResultMessage( "ALREADY_EXISTS" , "detailForm" , "계정 추가" , "이미 사원번호가 존재합니다." );
					}
					else
					{
						fnResultMessage( "Warning" , "detailForm" , "계정 추가" , data.resultMsg );
					}
				} ,
				error : function( e )
				{
					fnErrorMessage( "Error! " + e );
				} ,
				complete : function()
				{
					fnLoading( false );
				}
			} );
		}
		else
		{
			fnLoading( false );
		}
	}

	/**
	If change level then target's value is changed value.
	 */
	function fnChangeLevel( value )
	{
		fnDisplayVisible( "validMessageUserLevel" , false );
		$( "#levelId" ).val( value );
	}

	function fnChangeBrdy()
	{
		fnDisplayVisible( "validMessageBrdy" , false );
		$( "#brdy" ).val( $( "input[name=brdyStr_submit]" ).val() );
	}

	function fnConfirmMessage( title, message )
	{
		$( '#modalTextConfirmTitle' ).text( title );
		$( '#modalSpanConfirmMessage' ).text( message );
		fnModalOpen( 'modalConfirm' , true );
	}

	function fnDateFormat( dateObjId )
	{
		console.log( "fnDateFormat=" + dateObjId );

		$( "#" + dateObjId ).datepicker( {
			dateFormat : 'yy월 mm년 dd일' ,
			showMonthAfterYear : true ,
			changeYear : true ,
			yearSuffix : "년" ,
			changeMonth : false ,
			maxDate : "+0M" ,
			monthNamesShort : [
					'1' , '2' , '3' , '4' , '5' , '6' , '7' , '8' , '9' , '10' , '11' , '12'
			] //달력의 월 부분 텍스트
			,
			monthNames : [
					'1월' , '2월' , '3월' , '4월' , '5월' , '6월' , '7월' , '8월' , '9월' , '10월' , '11월' , '12월'
			] //달력의 월 부분 Tooltip 텍스트
			,
			monthSuffix : "월" ,
			dayNamesMin : [
					'일' , '월' , '화' , '수' , '목' , '금' , '토'
			] //달력의 요일 부분 텍스트
			,
			dayNames : [
					'일요일' , '월요일' , '화요일' , '수요일' , '목요일' , '금요일' , '토요일'
			] ,
			//달력의 요일 부분 Tooltip 텍스트
			currentText : '오늘 날짜' ,
			closeText : '닫기' ,
		} );
	}

	$( function()
	{
		$( "#sid" ).change( function()
		{
			var replaceStr = valid.replaceAlphaNumber( $( this ).val() );
			$( this ).val( replaceStr );
		} );
		$( "#userFnm" ).change( function()
		{
			var replaceStr = valid.replaceName( $( this ).val() );
			$( this ).val( replaceStr );
		} );
	} );
</script>

<!-- This Page JS -->
<!-- <script src="/assets/libs/pickadate/lib/compressed/picker.js"></script> -->
<!-- <script src="/assets/libs/pickadate/lib/compressed/picker.date.js"></script> -->
<!-- <script src="/assets/libs/pickadate/lib/compressed/picker.time.js"></script> -->
<!-- <script src="/assets/libs/pickadate/lib/compressed/legacy.js"></script> -->
<!-- <script src="/assets/libs/moment/moment.js"></script> -->
<!-- <script src="/assets/libs/daterangepicker/daterangepicker.js"></script> -->


<script type="text/javascript">
	// 	var datePickerYear = new Date().getYear() + 1900;
	// 	var datePickerMonth = new Date().getMonth();
	// 	var datePickerDay = new Date().getDate();

	// 	$( '#brdyStr' ).pickadate( {
	// 		format : 'yyyy년 mm월 dd일' ,
	// 		formatSubmit : 'yyyy-mm-dd' ,
	// 		clear : '' ,
	// 		today : '' ,
	// 		selectYears : 100 ,
	// 		max : [
	// 				datePickerYear , datePickerMonth , datePickerDay
	// 		]
	// 	} );
</script>
