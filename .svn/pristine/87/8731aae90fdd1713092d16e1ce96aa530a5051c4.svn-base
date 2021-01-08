<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>
<link rel="stylesheet" type="text/css" href="/assets/libs/nestable/nestable.css">
<link href="/dist/css/style.min.css" rel="stylesheet">

<!-- This Page CSS -->
<link rel="stylesheet" type="text/css" href="/assets/libs/pickadate/lib/themes/default.css">
<link rel="stylesheet" type="text/css" href="/assets/libs/pickadate/lib/themes/default.date.css">
<link rel="stylesheet" type="text/css" href="/assets/libs/pickadate/lib/themes/default.time.css">
<link rel="stylesheet" type="text/css" href="/assets/extra-libs/toastr/dist/build/toastr.min.css">

<script type="text/javascript">
	var boolModify = false;

	$( document ).ready( function()
	{
		fnInit();
		<c:if test='${info eq null}'>
		fnResultMessage( "SUCCESS_MAIN" , "detailForm" , "정보 없음" , "정보가 없습니다." );
		</c:if>
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
		fnDisplayVisible( "validMessageDept" , false );

		fnDisplayVisible( "spanValidSid" , false );
		fnDisplayVisible( "spanValidUserFnm" , false );
		fnDisplayVisible( "spanValidBrdy" , false );
		fnDisplayVisible( "spanValidUserLevel" , false );
		fnDisplayVisible( "spanValidDept" , false );

		fnDisplayVisible( "btnAreaSave" , false );

		fnDisplayVisible( "brdyTitle" , true );
		fnDisplayVisible( "brdyStr" , false );
		fnDisplayVisible( "btnBrdyStr" , false );

		fnDisplayVisible( "levelTitle" , true );
		fnDisplayVisible( "levelTitl" , false );
		fnDisplayVisible( "deptList" , false );

		fnDisplayVisible( "modalConfirmModify" , false );
		fnDisplayVisible( "modalConfirmRemove" , false );
		fnDisplayVisible( "modalConfirmPasswdInit" , false );

		$( "#modalCommentPasswdOld" ).addClass( "d-none" );
		$( "#modalCommentPasswdLength" ).addClass( "d-none" );
		$( "#modalCommentPasswd" ).addClass( "d-none" );

		$( "#brdyStr" ).click( function()
		{
			if ( boolModify )
			{
				fnDateFormat( "brdy" );
			}
		} );
	}

	function fnCancelList()
	{
		boolSubmit = true;
		fnList();
	}

	function fnValid( callType )
	{
		console.log( "sid length=" + $( "#sid" ).val().length );
		console.log( "brdy length=" + $( "#brdy" ).val().length );
		console.log( "levelId length=" + $( "#levelId" ).val().length );

		//공통 (회원 추가/수정)
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
		if ( $( "#dept" ).val().length < 1 )
		{
			fnDisplayVisible( "validMessageDept" , true );
			fnErrorMessage( "부서를 선택하세요." );
			return false;
		}

		return true;
	}

	//user manage goModify
	function fnInfoModify()
	{
		$( "#levelTitl" ).val( $( "#levelIdOld" ).val() );
		$( "#passwd" ).val( "" );

		if ( boolModify )
		{
			$( "#levelId" ).val( $( "#levelIdOld" ).val() );

			fnCancelValue( "brdy" );
			fnCancelValue( "dept" );
			fnCancelValue( "levelTitle" );

			fnCancelValue( "dept" );
			fnCancelValue( "deptNm" );

			fnReadOnly( "dept" , true );

			fnDisplayVisible( "navSubtitleInfo" , true );
			fnDisplayVisible( "navSubtitleModify" , false );

			fnDisplayVisible( "spanValidSid" , false );
			fnDisplayVisible( "spanValidUserFnm" , false );
			fnDisplayVisible( "spanValidBrdy" , false );
			fnDisplayVisible( "spanValidUserLevel" , false );
			fnDisplayVisible( "spanValidDept" , false );

			fnDisplayVisible( "brdyTitle" , true );
			fnDisplayVisible( "brdyStr" , false );
			fnDisplayVisible( "btnBrdyStr" , false );

			fnDisplayVisible( "levelTitle" , true );
			fnDisplayVisible( "levelTitl" , false );
			fnDisplayVisible( "deptList" , false );
			fnDisplayVisible( "deptNm" , true );

			fnDisplayVisible( "btnPasswdInit" , true );
			fnDisplayVisible( "btnAreaInfo" , true );
			fnDisplayVisible( "btnAreaSave" , false );

			boolModify = false;
		}
		else
		{
			$( "#deptList" ).val( $( "#deptOld" ).val() );

			fnReadOnly( "passwd" , false );

			fnDisplayVisible( "navSubtitleInfo" , false );
			fnDisplayVisible( "navSubtitleModify" , true );

			fnDisplayVisible( "brdyTitle" , false );
			fnDisplayVisible( "brdyStr" , true );
			fnDisplayVisible( "btnBrdyStr" , true );

			fnDisplayVisible( "spanValidBrdy" , true );
			fnDisplayVisible( "spanValidUserLevel" , true );
			fnDisplayVisible( "spanValidDept" , true );

			fnDisplayVisible( "levelTitle" , true );
			fnDisplayVisible( "levelTitl" , false );
			fnDisplayVisible( "deptList" , true );
			fnDisplayVisible( "deptNm" , false );

			fnDisplayVisible( "btnPasswdInit" , false );
			fnDisplayVisible( "btnAreaInfo" , false );
			fnDisplayVisible( "btnAreaSave" , true );

			boolModify = true;
		}
	}

	function fnInfoSave()
	{
		if ( fnValid( "M" ) )
		{
			fnDisplayVisible( "modalConfirmModify" , true );
			fnDisplayVisible( "modalConfirmRemove" , false );
			fnDisplayVisible( "modalConfirmPasswdInit" , false );

			fnConfirmMessage( "정보 수정" , "입력하신 정보를 저장하시겠습니까?" );
		}
	}

	//user manage remove
	function fnProcModify()
	{
		if ( fnValid( "M" ) )
		{
			var param = new Object();
			param = $( "#detailForm" ).serialize();

			$.ajax( {
				url : "modifyAction" ,
				data : param ,
				type : 'POST' ,
				dataType : 'json' ,
				success : function( data )
				{
					fnModalOpen( 'modalConfirm' , false );

					console.log( "modifyAction result : " + data.resultMsg );

					if ( data.resultMsg == "succ" )
					{
						fnResultMessage( "SUCCESS_REFRESH" , "detailForm" , "회원 수정" , "회원 수정 되었습니다." );
					}
					else
					{
						fnResultMessage( "Warning" , "detailForm" , "회원 수정" , data.resultMsg );
					}
				} ,
				error : function( e )
				{
					fnErrorMessage( "Error! " + e );
				} ,
				complete : function()
				{

				}
			} );
		}
	}

	/**
	If cancel then object's value is rollback.
	 */
	function fnCancelValue( objId )
	{
		$( "#" + objId ).val( $( "#" + objId + "Old" ).val() );
	}

	/**
	If change level then target's value is changed value.
	 */
	function fnChangeLevel( value )
	{
		fnDisplayVisible( "validMessageUserLevel" , false );
		if ( boolModify )
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

	function fnChangeDept()
	{
		$( "#dept" ).val( $( "#deptList option:selected" ).val() );
		$( "#deptNm" ).val( $( "#deptList option:selected" ).text() );
	}

	$( function()
	{
		$( "#btnInfoRemove" ).click( function()
		{
			$( "#modalSpanRemoveInfoId" ).text( $( "#sid" ).val() );
			fnModalOpen( 'modalRemoveInfo' , true );
		} );

		$( "#btnPasswdInit" ).click( function()
		{
			$( "#modalSpanPasswdInitTarget" ).text( $( "#userFnm" ).val() );
			fnModalOpen( 'modalPasswdInit' , true );
		} );

		$( "#pwd" ).click( function()
		{
			fnInitPasswordPopup();

			if ( boolModify && "${sessionScope.sessionUser.loginId}" == $( "#loginId" ).val() )
			{
				fnModalOpen( 'modalPasswdChange' , true );
			}
		} );
	} );
</script>
<div class="page-breadcrumb border-bottom">
	<div class="row">
		<div class="col-lg-3 col-md-4 col-xs-12 align-self-center">
			<h5 class="font-medium text-uppercase mb-0">메인화면</h5>
		</div>
		<div class="col-lg-9 col-md-8 col-xs-12 align-self-center">
			<nav aria-label="breadcrumb" class="mt-2 float-md-right float-left">
				<ol class="breadcrumb mb-0 justify-content-end p-0">
					<li class="breadcrumb-item">Home</li>
					<li class="breadcrumb-item active" aria-current="page" id="navSubtitleInfo">회원 정보</li>
					<li class="breadcrumb-item active d-none" aria-current="page" id="navSubtitleModify">회원 정보 수정</li>
				</ol>
			</nav>
		</div>
	</div>
</div>
<!-- ============================================================== -->
<!-- End Bread crumb and right sidebar toggle -->
<!-- ============================================================== -->

<form name="detailForm" id="detailForm" commandName="detailForm" method="post">
	<!-- ============================================================== -->
	<!-- Container fluid  -->
	<!-- ============================================================== -->
	<div class="page-content container-fluid">
		<!-- ============================================================== -->
		<!-- Start Page Content -->
		<!-- ============================================================== -->
		<div class="row">
			<div class="col-sm-12 col-md-12">
				<div class="card">
					<div class="card-body">
						<c:set var="partnerSno" value="${info.partnerSno}" />
						<input type="hidden" id="userSno" name="userSno" value="${info.userSno}" readonly="readonly" />
						<input type="hidden" id="loginId" name="loginId" value="${info.loginId}" readonly="readonly" />
						<input type="hidden" id="status" name="status" value="${info.status}" readonly="readonly" />
						<input type="hidden" id="partnerSno" name="partnerSno" value="${partnerSno}" readonly="readonly" />
						<input type="hidden" id="searchText" name="searchText" value="${searchVal.searchText}" readonly="readonly" />
						<input type="hidden" id="searchDept" name="searchDept" value="${searchVal.searchDept}" readonly="readonly" />
						<input type="hidden" id="searchUserLevel" name="searchUserLevel" value="${searchVal.searchUserLevel}" readonly="readonly" />
						<input type="hidden" id="searchState" name="searchState" value="${searchVal.searchState}" readonly="readonly" />

						<div class="form-body mb-4"> <!-- mb-4 // ksh 07-30  -->
							<div class="row">
								<div class="col-md-4">
									<label onlick="javascript:fnTest();">사원번호</label>
									<div class="form-group">
										<input type="text" class="form-control" placeholder="" maxlength="10" id="sid" name="sid" value="${info.sid}" readonly="readonly" />
									</div>
								</div>
								<div class="col-md-4">
									<label> 비밀번호 </label>
									<div class="form-group">
										<input type="password" class="form-control" placeholder="**********" id="pwd" name="pwd" value="" readonly="readonly" />
									</div>
								</div>
								<div class="col-md-4">
									<label>이름 </label>
									<div class="form-group">
										<input type="text" class="form-control" placeholder="" maxlength="20" id="userFnm" name="userFnm" value="${info.userFnm}" readonly="readonly" />
									</div>
								</div>
							</div>
						</div>
						<div class="form-body">
							<div class="row">
								<div class="col-md-4">
									<label>
										생년월일
										<span style="color: red;" id="spanValidBrdy">*</span>
									</label>
									<div class="form-group">
										<div class="input-group">
											<input type="hidden" class="form-control" id="brdy" name="brdy" value="${info.brdy}" readonly="readonly" />
											<input type="text" class="form-control pickadate-change-format" id="brdyTitle" name="brdyTitle" value="${info.brdyStr}" readonly="readonly" />
											<input type="text" class="form-control pickadate-change-format" placeholder="년도 /월/일" id="brdyStr" name="brdyStr" value="${info.brdyStr}" readonly="readonly" onChange="javascript:fnChangeBrdy();" />
											<input type="hidden" class="form-control" placeholder="" id="brdyOld" name="brdyOld" value="${info.brdy}" readonly="readonly" />
											<div class="input-group-prepend" id="btnBrdyStr">
												<span class="input-group-text" onclick="javascript:$('#brdyStr').click();">
													<span class="ti-calendar"></span>
												</span>
											</div>
										</div>
									</div>
									<small class="form-text text-muted" id="validMessageBrdy">필수 입력값입니다.</small>
								</div>
								<div class="col-md-4">
									<label>
										권한
										<span style="color: red;" id="spanValidUserLevel">*</span>
									</label>
									<div class="form-group">
										<input type="text" class="form-control" placeholder="" id="levelTitle" name="levelTitle" value="${info.levelTitle}" readonly="readonly" />
										<input type="hidden" class="form-control" placeholder="" id="levelTitleOld" name="levelTitleOld" value="${info.levelTitle}" readonly="readonly" />
										<input type="hidden" class="form-control" placeholder="" id="levelId" name="levelId" value="${info.levelId}" readonly="readonly" />
										<input type="hidden" class="form-control" placeholder="" id="levelIdOld" name="levelIdOld" value="${info.levelId}" readonly="readonly" />

										<select class="form-control" id="levelTitl" name="levelTitl" onchange="javascript:fnChangeLevel( this.value );">
											<option value="">권한 선택</option>
											<c:set var="isLevelChecked" />
											<c:forEach items="${listUserLevel}" var="userLevel" varStatus="status">
												<c:if test='${info.levelId eq userLevel.levelId}'>
													<c:set var="isLevelChecked">checked="checked"</c:set>
												</c:if>
												<option value="${userLevel.levelId}" ${isLevelChecked}>${userLevel.levelTitle}</option>
											</c:forEach>
										</select>
									</div>
									<small class="form-text text-muted" id="validMessageUserLevel">필수 입력값입니다.</small>
								</div>
								<div class="col-md-4">
									<label>
										부서
										<span style="color: red;" id="spanValidDept">*</span>
									</label>
									<div class="form-group">
										<input type="hidden" class="form-control" placeholder="" id="dept" name="dept" value="${info.dept}" readonly="readonly" />
										<input type="hidden" class="form-control" placeholder="" id="deptOld" name="deptOld" value="${info.dept}" readonly="readonly" />
										<input type="text" class="form-control" placeholder="" id="deptNm" name="deptNm" value="${info.deptNm}" readonly="readonly" />
										<input type="hidden" class="form-control" placeholder="" id="deptNmOld" name="deptNmOld" value="${info.deptNm}" readonly="readonly" />
										<select class="form-control" id="deptList" name="deptList" onChange="javascript:fnChangeDept();">
											<option value="">부서</option>
											<c:forEach items="${listDept}" var="list" varStatus="status">
												<c:if test='${list.dept eq info.dept}'>
													<c:set var="chk">selected="selected"</c:set>
												</c:if>
												<option value="${list.dept}" ${chk}>${list.deptNm}</option>
											</c:forEach>
										</select>
									</div>
									<small class="form-text text-muted" id="validMessageDept">필수 입력값입니다.</small>
								</div>
							</div>
						</div>
					</div>
					<div class="card-body" id="btnAreaInfo"> <!-- card-body  // ksh 07-30  -->
						<div class="row"> <!-- row  // ksh 07-30  -->
							<div class="col-12"> <!-- col-12  // ksh 07-30  -->
								<button class="btn waves-effect waves-light btn-primary float-right" onclick="javascript:fnInfoModify();">정보 수정</button> <!-- float-right  // ksh 07-30  -->
							</div>
						</div>
					</div>
					<div class="card-body row" id="btnAreaSave">  <!-- card-body  // ksh 07-30  -->
						<div class="col-12">
							<div class="text-left">
								<button class="btn waves-effect waves-light btn-secondary" onclick="javascript:fnInfoModify();">취 소</button> <!-- 이 줄이랑 아래 줄이랑 위치 변경float-right  // ksh 07-30  -->
								<button class="btn waves-effect waves-light btn-primary float-right" onclick="javascript:fnInfoSave();">저 장</button> <!-- float-right  // ksh 07-30  -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

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
					<div class="modal-footer" id="modalConfirmModify">
						<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal" onClick="javascript:fnInfoModify();">취소</button>
						<button type=button class="btn btn-primary waves-effect waves-light" data-dismiss="modal" onclick="javascript:fnProcModify();">저장</button>
					</div>
					<div class="modal-footer" id="modalConfirmRemove">
						<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal" onClick="javascript:fnInfoModify();">취소</button>
						<button type=button class="btn btn-primary waves-effect waves-light" data-dismiss="modal" onclick="javascript:fnProcRemove();">확인</button>
					</div>
					<div class="modal-footer" id="modalConfirmPasswdInit">
						<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal" onClick="javascript:fnInfoModify();">취소</button>
						<button type=button class="btn btn-primary waves-effect waves-light" data-dismiss="modal" onclick="javascript:fnProcPasswdInit();">초기화</button>
					</div>
				</div>
			</div>
		</div>
		<!-- /.modal -->
	</div>
</form>

<!-- This Page JS -->
<script src="/assets/libs/pickadate/lib/compressed/picker.js"></script>
<script src="/assets/libs/pickadate/lib/compressed/picker.date.js"></script>
<script src="/assets/libs/pickadate/lib/compressed/picker.time.js"></script>
<script src="/assets/libs/pickadate/lib/compressed/legacy.js"></script>
<script src="/assets/libs/moment/moment.js"></script>
<script src="/assets/libs/daterangepicker/daterangepicker.js"></script>

<script type="text/javascript">
	var datePickerYear = new Date().getYear() + 1900;
	var datePickerMonth = new Date().getMonth();
	var datePickerDay = new Date().getDate();

	$( '#brdyStr' ).pickadate( {
		format : 'yyyy년 mm월 dd일' ,
		formatSubmit : 'yyyy-mm-dd' ,
		clear : '' ,
		today : '' ,
		selectYears : 100 ,
		max : [
				datePickerYear , datePickerMonth , datePickerDay
		]
	} );
</script>