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
<script src="/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="/assets/extra-libs/toastr/dist/build/toastr.min.js"></script>

<c:if test='${infoMod eq "M" and info.status eq "N" }'>
	<c:set var="infoMod" value="MD" />
</c:if>

<script type="text/javascript">
	var boolModify = false;

	$( document ).ready( function()
	{
		fnInit();
		<c:if test='${infoMod eq "M"}'>
		<c:if test='${info eq null}'>
		fnResultMessage( "SUCCESS_LIST" , "detailForm" , "정보 없음" , "정보가 없습니다." );
		</c:if>
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

		//radio 버튼 체크 (status)
		/* $("input[name=status][value=${userManage.status}]").prop("checked",true); */
		<c:if test='${infoMod eq "A"}'>
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

		</c:if>
		<c:if test='${infoMod eq "M"}'>
		fnDisplayVisible( "spanValidSid" , false );
		fnDisplayVisible( "spanValidUserFnm" , false );
		fnDisplayVisible( "spanValidBrdy" , false );
		fnDisplayVisible( "spanValidUserLevel" , false );

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
		</c:if>
		<c:if test='${infoMod eq "MD"}'>
		fnDisplayVisible( "spanValidSid" , false );
		fnDisplayVisible( "spanValidUserFnm" , false );
		fnDisplayVisible( "spanValidBrdy" , false );
		fnDisplayVisible( "spanValidUserLevel" , false );

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

		fnDisplayVisible( "btnInfoRestore" , true );
		fnDisplayVisible( "btnInfoRestore" , true );

		$( "#modalCommentPasswdOld" ).addClass( "d-none" );
		$( "#modalCommentPasswd" ).addClass( "d-none" );
		</c:if>
		<c:if test='${infoMod eq "I"}'>
		fnDisplayVisible( "spanValidSid" , false );
		fnDisplayVisible( "spanValidUserFnm" , false );
		fnDisplayVisible( "spanValidBrdy" , false );
		fnDisplayVisible( "spanValidUserLevel" , false );

		fnDisplayVisible( "btnAreaSave" , false );

		fnDisplayVisible( "levelTitle" , true );
		fnDisplayVisible( "levelTitl" , false );
		</c:if>
	}

	//user manage goList
	function fnList()
	{
		$( "#userSno" ).val( "" );
		$( "#loginId" ).val( "" );
		$( "#partnerSno" ).val( "" );

		$( "#detailForm" ).attr( "action" , "/management/operation/usermanage/list" );
		$( "#detailForm" ).submit();
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

		// 계정 추가인 경우
		if ( callType == "A" )
		{
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

	<c:if test='${infoMod eq "A"}'>

	function fnInfoAdd()
	{
		if ( fnValid( "A" ) )
		{
			fnDisplayVisible( "modalConfirmAdd" , true );
			fnProcAdd();
			// 			fnConfirmMessage( "계정 추가 확인" , "계정 추가 하시겠습니까?" );
		}
	}

	//user manage add
	function fnProcAdd()
	{
		if ( fnValid( "A" ) )
		{
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

				}
			} );
		}
	}
	</c:if>

	<c:if test='${infoMod eq "M"}'>
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

			fnDisplayVisible( "levelTitle" , false );
			fnDisplayVisible( "levelTitl" , true );
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
						fnResultMessage( "SUCCESS_REFRESH" , "detailForm" , "계정 수정" , "계정 수정 되었습니다." );
					}
					else
					{
						fnResultMessage( "Warning" , "detailForm" , "계정 수정" , data.resultMsg );
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

	//user manage remove
	function fnRemove()
	{
		fnDisplayVisible( "modalConfirmModify" , false );
		fnDisplayVisible( "modalConfirmRemove" , true );
		fnDisplayVisible( "modalConfirmPasswdInit" , false );

		fnConfirmMessage( "계정 삭제 확인" , "계정 삭제 하시겠습니까?" );
	}

	function fnProcRemove()
	{
		var param = new Object();
		param = $( "#detailForm" ).serialize();

		$.ajax( {
			url : "removeAction" ,
			data : param ,
			type : 'POST' ,
			dataType : 'json' ,
			success : function( data )
			{
				if ( data.resultMsg == "succ" )
				{
					toastr.success( '계정이 삭제 되었습니다.' , '삭제 완료' );
					// 					fnResultMessage( "SUCCESS_LIST" , "detailForm" , "계정 삭제" , "관련 정보가 삭제되었습니다." );
				}
				else
				{
					fnResultMessage( "Warning" , "detailForm" , "계정 삭제" , data.resultMsg );
				}

				fnModalOpen();
				fnModalOpen( 'modalRemoveInfo' , false );
				fnModalOpen( 'modalRemoveInfo' , false );
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

	function fnProcPasswdInit()
	{
		var param = new Object();
		param = $( "#detailForm" ).serialize();

		$.ajax( {
			url : "initPasswdAction" ,
			data : param ,
			type : 'POST' ,
			dataType : 'json' ,
			success : function( data )
			{
				if ( data.resultMsg == "succ" )
				{
					// 					fnResultMessage( "SUCCESS_REFRESH" , "detailForm" , "비밀번호 초기화" , "비밀번호 초기화 되었습니다." );
					toastr.success( '비밀번호가 초기화 되었습니다.' , '초기화 완료' );
				}
				else
				{
					fnResultMessage( "Warning" , "detailForm" , data.resultMsg );
				}

				fnModalOpen( 'modalPasswdInit' , false );
			} ,
			error : function( e )
			{
				fnModalOpen( 'modalPasswdInit' , false );

				fnErrorMessage( "Error! " + e );
			} ,
			complete : function()
			{

			}
		} );
	}

	/**
	If cancel then object's value is rollback.
	 */
	function fnCancelValue( objId )
	{
		$( "#" + objId ).val( $( "#" + objId + "Old" ).val() );
	}
	</c:if>

	<c:if test='${infoMod eq "MD"}'>
	function fnProcRestore()
	{
		var param = new Object();
		param = $( "#detailForm" ).serialize();

		$.ajax( {
			url : "restoreAction" ,
			data : param ,
			type : 'POST' ,
			dataType : 'json' ,
			success : function( data )
			{
				if ( data.resultMsg == "succ" )
				{
					fnResultMessage( "SUCCESS_LIST" , "detailForm" , "계정 복구" , "계정이 복구 되었습니다." );
				}
				else
				{
					fnResultMessage( "Warning" , "detailForm" , "계정 복구" , data.resultMsg );
				}

				fnModalOpen( 'modalRestore' , false );
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
	</c:if>

	<c:if test='${infoMod eq "A" or infoMod eq "M"}'>
	/**
	If change level then target's value is changed value.
	 */
	function fnChangeLevel( value )
	{
		fnDisplayVisible( "validMessageUserLevel" , false );
		<c:if test='${infoMod eq "A"}'>
		$( "#levelId" ).val( value );
		</c:if>
		<c:if test='${infoMod eq "M"}'>
		if ( boolModify )
			$( "#levelId" ).val( value );
		</c:if>
	}
	</c:if>

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
		<c:if test='${infoMod eq "A"}'>
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
		</c:if>
		<c:if test='${infoMod eq "M"}'>
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
		</c:if>

		<c:if test='${infoMod eq "MD"}'>
		$( "#btnInfoRestore" ).click( function()
		{
			$( "#modalSpanRestoreTarget" ).text( $( "#userFnm" ).val() );
			fnModalOpen( 'modalRestore' , true );
		} );
		</c:if>
	} );
</script>
<div class="page-breadcrumb border-bottom">
	<div class="row">
		<div class="col-lg-3 col-md-4 col-xs-12 align-self-center">
			<h5 class="font-medium text-uppercase mb-0">계정 추가</h5>
		</div>
		<div class="col-lg-9 col-md-8 col-xs-12 align-self-center">
			<nav aria-label="breadcrumb" class="mt-2 float-md-right float-left">
				<ol class="breadcrumb mb-0 justify-content-end p-0">
					<li class="breadcrumb-item">Home</li>
					<li class="breadcrumb-item">회원 관리</li>
					<li class="breadcrumb-item">회원 목록</li>
					<li class="breadcrumb-item active" aria-current="page" id="navSubtitleInfo">상세 정보</li>
					<li class="breadcrumb-item active d-none" aria-current="page" id="navSubtitleModify">정보 수정</li>
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
						<c:if test='${infoMod eq "A"}'>
							<c:set var="partnerSno" value="0" />
						</c:if>
						<c:if test='${infoMod eq "I" or infoMod eq "M"}'>
							<c:set var="partnerSno" value="${info.partnerSno}" />
						</c:if>
						<input type="hidden" id="userSno" name="userSno" value="${info.userSno}" readonly="readonly" />
						<input type="hidden" id="loginId" name="loginId" value="${info.loginId}" readonly="readonly" />
						<input type="hidden" id="status" name="status" value="${info.status}" readonly="readonly" />
						<input type="hidden" id="partnerSno" name="partnerSno" value="${partnerSno}" readonly="readonly" />
						<input type="hidden" id="searchText" name="searchText" value="${searchVal.searchText}" readonly="readonly" />
						<input type="hidden" id="searchDept" name="searchDept" value="${searchVal.searchDept}" readonly="readonly" />
						<input type="hidden" id="searchUserLevel" name="searchUserLevel" value="${searchVal.searchUserLevel}" readonly="readonly" />
						<input type="hidden" id="searchState" name="searchState" value="${searchVal.searchState}" readonly="readonly" />

						<div class="form-body">
							<div class="row">
								<div class="col-md-4">
									<label onlick="javascript:fnTest();">사원번호</label>
									<c:if test='${infoMod eq "A"}'>
										<span id="spanValidSid" style="color: red;">*</span>
									</c:if>
									<div class="form-group">
										<input type="text" class="form-control" placeholder="" maxlength="10" id="sid" name="sid" value="${info.sid}" readonly="readonly" />
										<c:if test='${infoMod eq "A"}'>
											<small class="form-text text-muted" style="opacity: 0.4;">영문과 숫자만 입력 가능</small>
										</c:if>
									</div>
								</div>
								<div class="col-md-4">
									<label> 비밀번호 </label>
									<c:if test='${infoMod eq "M"}'>
										<button type="reset" class="btn btn-primary" id="btnPasswdInit" style="float: right; margin: -6px 0 0; background: none; border: none; text-decoration: underline; color: #2cabe3; font-size: 15px">비밀번호 초기화</button>
									</c:if>
									<div class="form-group">
										<input type="password" class="form-control" placeholder="**********" id="pwd" name="pwd" value="" readonly="readonly" />
										<c:if test='${infoMod eq "A"}'>
											<small class="form-text text-muted" style="opacity: 0.4;">초기 비밀번호는 생년월일로 자동 설정</small>
										</c:if>
									</div>
								</div>
								<div class="col-md-4">
									<label>이름 </label>
									<c:if test='${infoMod eq "A"}'>
										<span id="spanValidUserFnm" style="color: red;">*</span>
									</c:if>
									<div class="form-group">
										<input type="text" class="form-control" placeholder="" maxlength="20" id="userFnm" name="userFnm" value="${info.userFnm}" readonly="readonly" />
										<c:if test='${infoMod eq "A"}'>
											<small class="form-text text-muted" style="opacity: 0.4;">한글 및 영문 20자 이내 입력 가능</small>
										</c:if>
									</div>
								</div>
							</div>
						</div>
						<div class="form-body">
							<div class="row">
								<div class="col-md-4">
									<label>
										생년월일
										<span id="spanValidBrdy" style="color: red;">*</span>
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
										<span id="spanValidUserLevel" style="color: red;">*</span>
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
								<div class="col-md-4 d-none">
									<label>부서 </label>
									<div class="form-group">
										<input type="hidden" class="form-control" placeholder="" id="dept" name="dept" value="${info.dept}" readonly="readonly" />
										<input type="hidden" class="form-control" placeholder="" id="deptOld" name="deptOld" value="${info.dept}" readonly="readonly" />
										<input type="text" class="form-control" placeholder="" id="deptNm" name="deptNm" value="${info.deptNm}" readonly="readonly" />
										<input type="hidden" class="form-control" placeholder="" id="deptNmOld" name="deptNmOld" value="${info.deptNm}" readonly="readonly" />
										<select class="select2 form-control" id="deptList" name="deptList" onChange="javascript:fnChangeDept();">
											<option value="">부서</option>
											<c:forEach items="${listDept}" var="list" varStatus="status">
												<c:if test='${list.dept eq info.dept}'>
													<c:set var="chk">selected="selected"</c:set>
												</c:if>
												<option value="${list.dept}" ${chk}>${list.deptNm}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row" id="btnAreaInfo" style="padding: 0 0 1.57rem;">
						<div class="col-6 float-left">
							<div class="text-left " style="padding: 0 1.57rem;">
								<c:if test='${infoMod eq "I" or infoMod eq "M" or infoMod eq "MD"}'>
									<button class="btn waves-effect waves-light btn-secondary" onclick="javascript:boolSubmit=true;fnList();">목록</button>
								</c:if>
								<%-- <c:if test='${infoMod eq "A"}'>
									<button class="btn waves-effect waves-light btn-secondary" style="margin-right: 0.3rem;" onclick="javascript:fnCancelList();">취소</button>
									<button class="btn waves-effect waves-light btn-primary"   onclick="javascript:fnInfoAdd();">계정 추가</button>
								</c:if> --%>
							</div>
						</div>
						<div class="col-6 float-right">
							<div class="text-left float-right" style="padding: 0 1.57rem;">
								<%-- <c:if test='${infoMod eq "I" or infoMod eq "M" or infoMod eq "MD"}'>
									<button class="btn waves-effect waves-light btn-secondary" onclick="javascript:boolSubmit=true;fnList();">목록</button>
								</c:if> --%>
								<c:if test='${infoMod eq "A"}'>
									<button class="btn waves-effect waves-light btn-secondary" style="margin-right: 0.3rem;" onclick="javascript:fnCancelList();">취소</button>
									<button class="btn waves-effect waves-light btn-primary" onclick="javascript:fnInfoAdd();">계정 추가</button>
								</c:if>
							</div>
						</div>
						<div class="col-12">
							<div class="text-right " style="padding: 0 1.57rem;">
								<c:if test='${infoMod eq "M"}'>
									<button class="btn waves-effect waves-light btn-primary" style="margin: -59px 0 0;" onclick="javascript:fnInfoModify();">정보 수정</button>
								</c:if>
								<%-- <c:if test='${infoMod eq "MD"}'>
									<button class="btn btn-primary" id="btnInfoRestore">계정 복구</button>
								</c:if> --%>
							</div>
						</div>
						<div class="col-6 float-left">
							<div class="text-left " style="padding: 0 1.57rem;">
								<%-- <c:if test='${infoMod eq "M"}'>
									<button class="btn waves-effect waves-light btn-primary" onclick="javascript:fnInfoModify();">정보 수정</button>
								</c:if> --%>
								<c:if test='${infoMod eq "MD"}'>
									<button class="btn btn-primary" id="btnInfoRestore">계정 복구</button>
								</c:if>
							</div>
						</div>
					</div>
					<div class="row" id="btnAreaSave" style="padding: 24px;">
						<%-- <div class="col-6">
							<div class="text-left">
								<c:if test='${infoMod eq "M"}'>
									<button class="btn waves-effect waves-light btn-secondary" onclick="javascript:fnInfoModify();">취 소</button>
									<button class="btn waves-effect waves-light btn-primary" onclick="javascript:fnInfoSave();">저장</button>
								</c:if>
							</div>
						</div> --%>
						<div class="col-6">
							<div class="text-right float-left">
								<c:if test='${infoMod eq "M"}'>
									<button class="btn btn-primary" id="btnInfoRemove" style="float: right; margin: 7px 0 0; background: none; border: none; text-decoration: underline; color: red; font-size: 16px; padding: 0;">계정 삭제</button>
								</c:if>
							</div>
						</div>
						<div class="col-6">
							<div class="text-left float-right">
								<c:if test='${infoMod eq "M"}'>
									<button class="btn waves-effect waves-light btn-secondary" onclick="javascript:fnInfoModify();">취 소</button>
									<button class="btn waves-effect waves-light btn-primary" onclick="javascript:fnInfoSave();">저장</button>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- //board -->
		<c:if test='${infoMod eq "M"}'>
			<!-- Remove content -->
			<div id="modalRemoveInfo" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" aria-labelledby="vcenter">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">계정 삭제</h4>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<div class="form-group">
								<label class="control-label">
									<span id="modalSpanRemoveInfoId">{ID}</span>
									를 삭제 하시겠습니까?
								</label>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary waves-effect waves-light" onClick="javascript:fnProcRemove();">확인</button>
						</div>
					</div>
				</div>
			</div>
			<!-- /.modal -->
			<!-- Init password modal content -->
			<div id="modalPasswdInit" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" aria-labelledby="vcenter">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">비밀번호 초기화</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<div class="form-group">
								<label class="control-label">
									<span id="modalSpanPasswdInitTarget">{Name}</span>
									계정의 비밀번호를 초기화 하시겠습니까?
								</label>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary waves-effect waves-light" onClick="javascript:fnProcPasswdInit();">초기화</button>
						</div>
					</div>
				</div>
			</div>
			<!-- /.modal -->
		</c:if>

		<c:if test='${infoMod eq "MD"}'>
			<!-- Init password modal content -->
			<div id="modalRestore" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" aria-labelledby="vcenter">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">계정 복구</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<div class="form-group">
								<label class="control-label">
									<span id="modalSpanRestoreTarget">{Name}</span>
									계정을 복구 하시겠습니까?
								</label>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary waves-effect waves-light" onClick="javascript:fnProcRestore();">확인</button>
						</div>
					</div>
				</div>
			</div>
			<!-- /.modal -->
		</c:if>
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
					<c:if test='${infoMod eq "A"}'>
						<div class="modal-footer" id="modalConfirmAdd">
							<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">취소</button>
							<button type=button class="btn btn-primary waves-effect waves-light" data-dismiss="modal" onclick="javascript:fnProcAdd();">확인</button>
						</div>
					</c:if>
					<c:if test='${infoMod eq "M"}'>
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
					</c:if>
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

<c:if test='${infoMod eq "A" or infoMod eq "M"}'>
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
</c:if>