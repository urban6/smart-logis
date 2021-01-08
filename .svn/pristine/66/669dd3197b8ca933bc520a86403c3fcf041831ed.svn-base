<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>

<style type="text/css">
input[type=file]::-webkit-file-upload-button {
	width: 0;
	padding: 0;
	margin: 0;
	-webkit-appearance: none;
	border: none;
	border: 0px;
}

x::-webkit-file-upload-button, input[type=file]:after {
	content: '파일선택';
	left: 100%;
	margin-left: 3px;
	position: sticky;
	-webkit-appearance: button;
	padding: 0px 8px 1px;
	border: 0px;
}
</style>

<script type="text/javascript">
	var boolModify = false;
	$( document ).ready( function()
	{
		fnInit();
	} );

	//init function
	function fnInit()
	{
		$(".spinner-border").hide();
		
		$( "#frmList" ).on( "submit" , function( event )
		{
			if ( boolSubmit == false )
			{
				event.preventDefault();
			}
		} );

		<c:if test='${infoMod eq "A"}'>
		fnReadOnly( "verAppStr" , false );
		fnReadOnly( "verAppCnte" , false );
		</c:if>
		<c:if test='${infoMod eq "M"}'>
		fnDisplayVisible( "spanValidVerAppStr" , false );
		fnDisplayVisible( "spanValidVerAppFileNm" , false );
		</c:if>

		<c:if test='${infoMod eq "A"}'>
		$( "#verAppStr" ).keyup( function()
		{
			console.log( "keyDown : id=" + $( this ) + ", val=" + $( this ).val() + ", valid=" + valid.isNumberDot( $( this ).val() ) );
			if ( !valid.isNumberDot( $( this ).val() ) )
			{
				fnDisplayVisible( "validVerAppStrNumber" , true );
				event.returnValue = false;
			}
			else
			{
				fnDisplayVisible( "validVerAppStrNumber" , false );
				event.returnValue = true;
			}
			var replaceStr = valid.replaceNumberDot( $( this ).val() );
			$( this ).val( replaceStr );
			return event.returnValue;
		} );
		$( "#verAppFileNm" ).change( function()
		{
			var fileName = $( this ).val();
			fileName = fileName.replace( ".APK" , "" ).replace( ".apk" , "" );
			if ( !valid.isFileName( $( this ).val() ) )
			{
				if ( valid.isBrowserIe() )
				{
					// ie 일때 input[type=file] init.
					$( this ).replaceWith( $( this ).clone( true ) );
				}
				else
				{
					//other browser 일때 input[type=file] init.
					$( this ).val( "" );
				}
			}
			else
			{
				fnDisplayVisible( "validVerAppFileNmEmpty" , false );
				fnDisplayVisible( "validVerAppFileNmSpecial" , false );
			}
			// 		fnDisplayVisible( "validVerAppFileNmEmpty" , false );
			// 			var replaceStr = valid.replaceName( $( this ).val() );
			// 			$( this ).val( replaceStr );
		} );
		</c:if>
		<c:if test='${infoMod eq "M"}'>
		$( "#verAppStr" ).keyup( function()
		{
			if ( !valid.isNumberDot( $( this ).val() ) )
			{
				fnDisplayVisible( "validVerAppStrNumber" , true );
				event.returnValue = false;
			}
			else
			{
				fnDisplayVisible( "validVerAppStrNumber" , false );
				event.returnValue = true;
			}

			var replaceStr = valid.replaceNumberDot( $( this ).val() );
			$( this ).val( replaceStr );
			return event.returnValue;
		} );
		$( "#btnInfoRemove" ).click( function()
		{
			$( "#modalSpanRemoveInfoId" ).text( $( "#sid" ).val() );
			fnModalOpen( 'modalRemoveInfo' , true );
		} );
		</c:if>

	}

	function fnList()
	{
		$( "#frmList" ).attr( "action" , "/management/other/version/versionList" );
		$( "#frmList" ).submit();
	}

	function fnCancelList()
	{
		boolSubmit = true;
		fnList();
	}

	<c:if test='${infoMod eq "A"}'>
	function fnProcAdd()
	{
		if ( $( "#verAppStr" ).val().length < 1 )
		{
			fnDisplayVisible( "validVerAppStrRequired" , true );
			return false;
		}
		else
		{
			fnDisplayVisible( "validVerAppStrRequired" , false );
		}

		if ( !valid.isNumberDot( $( "#verAppStr" ).val() ) )
		{
			fnDisplayVisible( "validVerAppStrNumber" , true );
			return false;
		}
		else
		{
			fnDisplayVisible( "validVerAppStrNumber" , false );
		}

		if ( $( "#verAppFileNm" ).val().length < 1 )
		{
			fnDisplayVisible( "validVerAppFileNmEmpty" , true );
			return false;
		}
		else
		{
			fnDisplayVisible( "validVerAppFileNmEmpty" , false );
		}

		if ( !valid.isFileName( $( "#verAppFileNm" ).val() ) )
		{
			fnDisplayVisible( "validVerAppFileNmSpecial" , true );
			return false;
		}
		else
		{
			fnDisplayVisible( "validVerAppFileNmSpecial" , false );
		}

		var param = new FormData( $( "#frmDetail" )[ 0 ] );
		//console.log(JSON.stringify(param));
		$(".spinner-border").show();
		
		$.ajax( {
			url : "versionAppAddAction" ,
			data : param ,
			type : 'POST' ,
			enctype : 'multipart/form-data' ,
			processData : false ,
			contentType : false ,
			cache : false ,
			success : function( data )
			{
				console.log( "add action result=" + data.resultMsg );
				
				$(".spinner-border").hide();
				
				if ( data.resultCode == "success" )
				{
					fnResultMessage( "SUCCESS_LIST" , "frmDetail" , "앱 버전 추가" , "저장되었습니다." );
				}
				else
				{
					fnResultMessage( "Warning" , "frmDetail" , "앱 버전 추가" , data.resultMsg );
				}
			} ,
			error : function( e )
			{
				$(".spinner-border").hide();
				fnErrorMessage( "오류가 발생했습니다." );
				
			} ,
			complete : function()
			{

			}
		} );
	}
	</c:if>
	<c:if test='${infoMod eq "M"}'>
	function fnInfoModify()
	{
		if ( boolModify )
		{
			$( "#verAppStr" ).val( $( "#verAppStrOld" ).val() );
			$( "#verAppCnte" ).val( $( "#verAppCnteOld" ).val() );

			fnReadOnly( "verAppStr" , true );
			fnReadOnly( "verAppCnte" , true );

			fnDisplayVisible( "headerDetailInfo" , true );
			fnDisplayVisible( "headerDetailInfoModify" , false );

			fnDisplayVisible( "verAppFileNmStr" , true );
			fnDisplayVisible( "verAppFileNm" , false );

			fnDisplayVisible( "spanValidVerAppStr" , false );
			fnDisplayVisible( "spanValidVerAppFileNm" , false );

			fnDisplayVisible( "btnAreaInfo" , true );
			fnDisplayVisible( "btnAreaSave" , false );
			fnDisplayVisible( "navHeaderInfo" , true );
			fnDisplayVisible( "navHeaderModify" , false );

			boolModify = false;
		}
		else
		{
			if ( valid.isBrowserIe() )
			{
				// ie 일때 input[type=file] init.
				$( "#verAppFileNm" ).replaceWith( $( "#verAppFileNm" ).clone( true ) );
			}
			else
			{
				//other browser 일때 input[type=file] init.
				$( "#verAppFileNm" ).val( "" );
			}

			fnReadOnly( "verAppStr" , false );
			fnReadOnly( "verAppCnte" , false );

			fnDisplayVisible( "headerDetailInfo" , false );
			fnDisplayVisible( "headerDetailInfoModify" , true );

			fnDisplayVisible( "verAppFileNmStr" , false );
			fnDisplayVisible( "verAppFileNm" , true );

			fnDisplayVisible( "spanValidVerAppStr" , true );
			fnDisplayVisible( "spanValidVerAppFileNm" , true );

			fnDisplayVisible( "btnAreaInfo" , false );
			fnDisplayVisible( "btnAreaSave" , true );
			fnDisplayVisible( "navHeaderInfo" , false );
			fnDisplayVisible( "navHeaderModify" , true );

			boolModify = true;
		}
	}

	function fnProcDelete()
	{
		if ( $( "#verAppStr" ).val().length < 1 )
		{
			fnResultMessage( "Warning" , "frmDetail" , "앱 버전 삭제" , "버전 정보가 없습니다." );
			return false;
		}

		if ( !valid.isNumberDot( $( "#verAppStr" ).val() ) )
		{
			fnResultMessage( "Warning" , "frmDetail" , "앱 버전 삭제" , "버전을 확인하세요." );
			return false;
		}

		var param = new FormData( $( "#frmDetail" )[ 0 ] );
		//console.log(JSON.stringify(param));
		$(".spinner-border").show();
		
		$.ajax( {
			url : "versionAppModifyAction" ,
			data : param ,
			type : 'POST' ,
			enctype : 'multipart/form-data' ,
			processData : false ,
			contentType : false ,
			cache : false ,
			success : function( data )
			{
				console.log( "add action result=" + data.resultMsg );
				$(".spinner-border").hide();
				if ( data.resultCode == "success" )
				{
					fnResultMessage( "SUCCESS_LIST" , "frmDetail" , "앱 버전 수정" , "저장되었습니다." );
				}
				else
				{
					fnResultMessage( "Warning" , "frmDetail" , "앱 버전 수정" , data.resultMsg );
				}
			} ,
			error : function( e )
			{
				$(".spinner-border").hide();
				fnErrorMessage( "오류가 발생했습니다." );
			} ,
			complete : function()
			{

			}
		} );
	}

	function fnProcModify()
	{
		if ( $( "#verAppStr" ).val().length < 1 )
		{
			fnDisplayVisible( "validVerAppStrRequired" , true );
			return false;
		}
		else
		{
			fnDisplayVisible( "validVerAppStrRequired" , false );
		}

		if ( !valid.isNumberDot( $( "#verAppStr" ).val() ) )
		{
			fnDisplayVisible( "validVerAppStrNumber" , true );
			return false;
		}
		else
		{
			fnDisplayVisible( "validVerAppStrNumber" , false );
		}

		// 		if ( $( "#verAppFileNm" ).val().length < 1 )
		// 		{
		// 			fnDisplayVisible( "validVerAppFileNmEmpty" , true );
		// 			return false;
		// 		}
		// 		else
		// 		{
		// 			fnDisplayVisible( "validVerAppFileNmEmpty" , false );
		// 		}

		if ( $( "#verAppFileNm" ).val().length > 0 )
		{
			if ( !valid.isFileName( $( "#verAppFileNm" ).val() ) )
			{
				fnDisplayVisible( "validVerAppFileNmSpecial" , true );
				return false;
			}
			else
			{
				fnDisplayVisible( "validVerAppFileNmSpecial" , false );
			}
		}

		var param = new FormData( $( "#frmDetail" )[ 0 ] );
		//console.log(JSON.stringify(param));
		$(".spinner-border").show();

		$.ajax( {
			url : "versionAppModifyAction" ,
			data : param ,
			type : 'POST' ,
			enctype : 'multipart/form-data' ,
			processData : false ,
			contentType : false ,
			cache : false ,
			success : function( data )
			{
				console.log( "add action result=" + data.resultMsg );
				$(".spinner-border").hide();
				if ( data.resultCode == "success" )
				{
					fnResultMessage( "SUCCESS_LIST" , "frmDetail" , "앱 버전 수정" , "저장되었습니다." );
				}
				else
				{
					fnResultMessage( "Warning" , "frmDetail" , "앱 버전 수정" , data.resultMsg );
				}
			} ,
			error : function( e )
			{
				$(".spinner-border").hide();
				fnErrorMessage( "오류가 발생했습니다." );
			} ,
			complete : function()
			{

			}
		} );
	}

	function fnProcDelete()
	{
		if ( $( "#verAppStr" ).val().length < 1 )
		{
			fnDisplayVisible( "validVerAppStrRequired" , true );
			return false;
		}
		else
		{
			fnDisplayVisible( "validVerAppStrRequired" , false );
		}

		var param = new Object();
		param = $( "#frmDetail" ).serialize();
		$(".spinner-border").show();

		$.ajax( {
			url : "versionAppDeleteAction" ,
			data : param ,
			type : 'POST' ,
			cache : false ,
			success : function( data )
			{
				console.log( "add action result=" + data.resultMsg );
				$(".spinner-border").hide();
				if ( data.resultCode == "success" )
				{
					fnResultMessage( "SUCCESS_LIST" , "frmDetail" , "앱 버전 삭제" , "삭제되었습니다." );
				}
				else
				{
					fnResultMessage( "Warning" , "frmDetail" , "앱 버전 삭제" , data.resultMsg );
				}
			} ,
			error : function( e )
			{
				$(".spinner-border").hide();
				fnErrorMessage( "오류가 발생했습니다." );
			} ,
			complete : function()
			{

			}
		} );
	}
	</c:if>

	// 첨부파일 확장자 확인
	function fnCheckApkFile( obj )
	{
		var fileKind = obj.value.lastIndexOf( '.' );
		var fileName = obj.value.substring( fileKind + 1 , obj.length );
		var fileType = fileName.toLowerCase();

		var checkFileType = [
				'apk' , 'APK'
		];

		if ( checkFileType.indexOf( fileType ) == -1 )
		{
			alert( 'APK 파일만 선택할 수 있습니다.' );
			// 			var parentObj = obj.parentNode
			// 			var node = parentObj.replaceChild( obj.cloneNode( true ) , obj );
			// 			obj.value = "";
			if ( valid.isBrowserIe() )
			{
				// ie 일때 input[type=file] init.
				$( "#verAppFileNm" ).replaceWith( $( "#verAppFileNm" ).clone( true ) );
			}
			else
			{
				//other browser 일때 input[type=file] init.
				$( "#verAppFileNm" ).val( "" );
			}
			return false;
		}
	}
</script>

<!-- ============================================================== -->
<!-- Bread crumb and right sidebar toggle -->
<!-- ============================================================== -->
<div class="page-breadcrumb border-bottom">
	<div class="row">
		<div class="col-lg-3 col-md-4 col-xs-12 align-self-center">
			<c:if test='${infoMod eq "A"}'>
				<h5 class="font-medium text-uppercase mb-0">새 버전 등록</h5>
			</c:if>
			<c:if test='${infoMod eq "M"}'>
				<h5 class="font-medium text-uppercase mb-0" id="headerDetailInfo">상세 정보</h5>
				<h5 class="font-medium text-uppercase mb-0 d-none" id="headerDetailInfoModify">정보 수정</h5>
			</c:if>
		</div>
		<div class="col-lg-9 col-md-8 col-xs-12 align-self-center">
			<nav aria-label="breadcrumb" class="mt-2 float-md-right float-left">
				<ol class="breadcrumb mb-0 justify-content-end p-0">
					<li class="breadcrumb-item">Home</li>
					<li class="breadcrumb-item">시스템 관리</li>
					<li class="breadcrumb-item">앱 버전 관리</li>
					<c:if test='${infoMod eq "A"}'>
						<li class="breadcrumb-item" aria-current="page">새 버전 추가</li>
					</c:if>
					<c:if test='${infoMod eq "M"}'>
						<li class="breadcrumb-item" aria-current="page" id="navHeaderInfo">상세 정보</li>
						<li class="breadcrumb-item d-none" aria-current="page" id="navHeaderModify">정보 수정</li>
					</c:if>
				</ol>
			</nav>
		</div>
	</div>
</div>
<!-- ============================================================== -->
<!-- End Bread crumb and right sidebar toggle -->
<!-- ============================================================== -->
<!-- ============================================================== -->
<!-- Container fluid  -->
<!-- ============================================================== -->
<div class="page-content container-fluid">
	<!-- ============================================================== -->
	<!-- Start Page Content -->
	<!-- ============================================================== -->
	<div class="row">
		<div class="col-md-12">
			<div class="card">
				<div class="card-body">
					<form name="frmList" id="frmList" commandName="frmList" method="post" action="/management/other/version/versionList"></form>
					<div class="row">
						<div class="col-4"></div>
						<div class="col-2"></div>
						<div class="col-6">
							<div class="text-right" style="margin-bottom: -23px;">${info.verAppRegDtTime}</div>
						</div>
					</div>
					<div class="form-body">
						<form name="frmDetail" id="frmDetail" method="post" enctype="multipart/form-data" action="/management/other/version/versionDetail">
							<c:set var="verAppNum" value="0" />
							<c:set var="verAppNo" value="0" />
							<c:if test='${infoMod eq "M"}'>
								<c:set var="verAppNum" value="${info.verAppNum}" />
								<c:set var="verAppNo" value="${info.verAppNo}" />
							</c:if>
							<input type="hidden" class="form-control" maxlength="10" id="verAppNum" name="verAppNum" value="${verAppNum}" readonly="readonly" />
							<input type="hidden" class="form-control" maxlength="10" id="verAppNo" name="verAppNo" value="${verAppNo}" readonly="readonly" />
							<div class="row">
								<div class="col-md-4">
									<label onlick="javascript:fnTest();">버전</label>
									<span id="spanValidVerAppStr" style="color: red;">*</span>
									<div class="form-group">
										<input type="text" class="form-control" maxlength="10" id="verAppStr" name="verAppStr" value="${info.verAppStr}" readonly="readonly" />
										<input type="text" class="form-control d-none" maxlength="10" id="verAppStrOld" name="verAppStrOld" value="${info.verAppStr}" readonly="readonly" />
									</div>
									<small class="form-text text-muted d-none" id="validVerAppStrNumber">숫자만 입력할 수 있습니다.</small>
									<small class="form-text text-muted d-none" id="validVerAppStrRequired">필수 입력값입니다.</small>
								</div>
								<div class="col-md-8">
									<label> 파일 </label>
									<span id="spanValidVerAppFileNm" style="color: red;">*</span>
									<c:if test='${infoMod eq "A"}'>
										<div class="form-group">
											<input type="text" class="form-control d-none" id="verAppFileNmStr" name="verAppFileNmStr" value="${info.verAppFileNm}" readonly="readonly" />
											<input type="text" class="form-control d-none" id="verAppFileNmStrOld" name="verAppFileNmStrOld" value="${info.verAppFileNm}" readonly="readonly" />
											<input type="file" class="form-control" accept=".apk,application/vnd.android.package-archive" id="verAppFileNm" name="verAppFileNm" value="" onChange="javascript:fnCheckApkFile(this);" />
										</div>
									</c:if>
									<c:if test='${infoMod eq "M"}'>
										<div class="form-group">
											<input type="text" class="form-control" id="verAppFileNmStr" name="verAppFileNmStr" value="${info.verAppFileNm}" readonly="readonly" />
											<input type="text" class="form-control d-none" id="verAppFileNmStrOld" name="verAppFileNmStrOld" value="${info.verAppFileNm}" readonly="readonly" />
											<input type="file" class="form-control d-none" accept="application/vnd.android.package-archive" id="verAppFileNm" name="verAppFileNm" value="" onChange="javascript:fnCheckApkFile(this);" />
										</div>
									</c:if>
									<small class="form-text text-muted d-none" id="validVerAppFileNmEmpty">파일을 선택해주십시오.</small>
									<small class="form-text text-muted d-none" id="validVerAppFileNmSpecial">파일명에 특수문자를 포함할 수 없습니다.</small>
								</div>
								<div class="col-md-12">
									<label>설명</label>
									<div class="form-group">
										<textarea class="form-control" style="background: #363946;" rows="3" id="verAppCnte" name="verAppCnte" readonly="readonly">${info.verAppCnte}</textarea>
										<textarea class="form-control d-none" rows="3" id="verAppCnteOld" name="verAppCnteOld">${info.verAppCnte}</textarea>
									</div>
									<small class="form-text text-muted d-none" id="validVerAppCnteLimited">한글 및 영문 20자 이내 입력 가능</small>
								</div>
							</div>
						</form>
					</div>
					<div class="row" id="btnAreaInfo">
						<div class="col-12 float-left">
							<div class="text-left">
								<c:if test='${infoMod eq "A"}'>
									<button class="btn waves-effect waves-light btn-secondary" onclick="javascript:fnCancelList();">취소</button>
									<button class="btn waves-effect waves-light btn-primary float-right" onclick="javascript:fnProcAdd();">등록</button>
								</c:if>
								<c:if test='${infoMod eq "I" or infoMod eq "M"}'>
									<button class="btn waves-effect waves-light btn-secondary" onclick="javascript:boolSubmit=true;fnList();">목록</button>
								</c:if>
							</div>
						</div>
						<div class="col-6 float-right">
							<div class="text-left float-right"></div>
						</div>
						<div class="col-12 float-right">
							<div class="text-right float-right">
								<c:if test='${infoMod eq "M"}'>
									<button class="btn waves-effect waves-light btn-primary" style="margin-top: -58px" onclick="javascript:fnInfoModify();">정보 수정</button>
								</c:if>
							</div>
						</div>
					</div>
					<div class="row d-none" id="btnAreaSave">
						<c:if test='${infoMod eq "M"}'>
							<div class="col-12">
								<div class="text-right">
									<!-- <button class="btn waves-effect waves-light btn-primary" id="btnInfoRemove" onclick="javascript:fnProcDelete();">버전 삭제</button> -->
									<!-- <button class="btn btn-primary" id="btnInfoRemove" onclick="javascript:fnProcDelete();" style="color: red; background: none; border: none; text-decoration: underline; padding: 1rem 0 1rem;">버전 삭제</button> -->
								</div>
							</div>
							<div class="col-12">
								<div class="text-left">
									<button class="btn waves-effect waves-light btn-secondary float-left" onclick="javascript:fnInfoModify();">취 소</button>
									<button class="btn waves-effect waves-light btn-primary float-right" onclick="javascript:fnProcModify();">저 장</button>
									<button class="btn btn-primary float-right" id="btnInfoRemove" onclick="javascript:fnProcDelete();" style="color: red; background: none; border: none; text-decoration: underline;">버전 삭제</button>
									<!-- padding: 1rem 0 1rem; 삭제해주세요 ksh 0730 -->
								</div>
							</div>
						</c:if>
					</div>
				</div>
			</div>
			
			<div class="spinner-border" role="status" style="display:block;width:30px;height:30px;margin:-15px 0 0 -15px;top:75%;left:50%;position:absolute;z-index:999;">
		   	 	<span class="sr-only" style="/* width:65%; margin:0 0 20px 65px */">Loading...</span>
	         </div>
	         
		</div>
	</div>
	<!-- row -->
</div>
<!-- ============================================================== -->
<!-- End Container fluid  -->
<!-- ============================================================== -->
