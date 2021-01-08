
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>
<link rel="stylesheet" href="/styles/dynatree/ui.dynatree.css">



<script type="text/javascript" src="/js/custom.util.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/dynaTree/jquery.dynatree.js"></script>
<script type="text/javascript">
	//Ajax로 첫 화면의 데이터 호출
	$( document ).ready( function()
	{
		$( "#defExpandAll" ).click( function()
		{
			$( "#defMenuTree" ).dynatree( "getRoot" ).visit( function( node )
			{
				node.expand( true );
			} );
			return false;
		} );

		$( "#authExpandAll" ).click( function()
		{
			$( "#authMenuTree" ).dynatree( "getRoot" ).visit( function( node )
			{
				node.expand( true );
			} );
			return false;
		} );

		$( "#defCollapseAll" ).click( function()
		{
			$( "#defMenuTree" ).dynatree( "getRoot" ).visit( function( node )
			{
				node.expand( false );
			} );
			return false;
		} );

		$( "#authCollapseAll" ).click( function()
		{
			$( "#authMenuTree" ).dynatree( "getRoot" ).visit( function( node )
			{
				node.expand( false );
			} );
			return false;
		} );

		$( "#btn_list" ).click( function()
		{
			goList();
		} );

		$( "#btn_mod" ).click( function()
		{
			goModify();
		} );

		$( "#btn_delete" ).click( function()
		{
			fnRemove();
		} );

		fnInit();
	} );

	//value setting
	function fnInit()
	{
		//radio 버튼 체크 (lock_type)
		/*
			if("${userLevel.lock_type}" == "M"){
				$("input[name=lock_type][value=${userLevel.lock_type}]").prop("checked",true);
				$("#lock_time").hide();
			} else if("${userLevel.lock_type}" == "T"){
				$("input[name=lock_type][value=${userLevel.lock_type}]").prop("checked",true);
		  		$("#lock_time").show();
			}
		 */
		//최초 tree load
		//var pkgName = $("#pkgName").multipleSelect('getSelects');
		getMenuTree(/* pkgName[0] */);

		$( "#defMenuTree" ).dynatree( "getRoot" ).visit( function( node )
		{
			node.expand( true );
		} );

		$( "#authMenuTree" ).dynatree( "getRoot" ).visit( function( node )
		{
			node.expand( true );
		} );
	}

	//user Level Manage getMenuTree
	function getMenuTree(/* pkgName */)
	{
		var param = new Object();
		//param.pkgName = pkgName;
		param.levelId = "${userLevel.level_id}";

		// Initialize the tree inside the <div>element.
		// The tree structure is read from the contained <ul> tag.
		$( "#defMenuTree" ).dynatree( {
			initAjax : {
				type : "post" ,
				data : param ,
				dataType : "json" ,
				async : false ,
				url : "getMenuTree"
			} ,
			clickFolderMode : 3 , //1:활성화 , 2:확장, 3:활성화 및 확장
			minExpandLevel : 2 , //루트가 축소되지 암음 value=1
			debugLevel : 0
		// 0:quiet, 1:normal, 2:debug
		} );

		// Initialize the tree inside the <div>element.
		// The tree structure is read from the contained <ul> tag.
		$( "#authMenuTree" ).dynatree( {
			initAjax : {
				type : "post" ,
				data : param ,
				dataType : "json" ,
				async : false ,
				url : "getAuthMenuTree"
			} ,
			clickFolderMode : 3 , //1:활성화 , 2:확장, 3:활성화 및 확장
			minExpandLevel : 2 , //루트가 축소되지 암음 value=1
			debugLevel : 0
		// 0:quiet, 1:normal, 2:debug
		} );
		$( "#defMenuTree" ).dynatree( "getTree" ).reload();
		$( "#authMenuTree" ).dynatree( "getTree" ).reload();
		//$("#authMenuTree").find(".dynatree-node").addClass("dynatree-exp-el")
		$( ".dynatree-folder > .dynatree-connector" ).removeClass( "dynatree-connector" ).addClass( "dynatree-expander" );
	}

	//user group Manage goList
	function goList()
	{
		$( "#menu" ).attr( "action" , "/management/operation/userlevel/list" );
		$( "#menu" ).submit();
	}

	function fnRemove()
	{

		openConfirmModal( "NOTIFICATION" , "Are you sure you want to delete this information?" , function()
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
					console.log( data );
					if ( data.resultMsg == "succ" )
					{
						// openAlertModal("Success","Your details have been deleted",goList);
						openAlertModal( "SUCCESS" , "관련 정보가 삭제되었습니다." , goList );
					}
					else if ( data.resultMsg == "fail" )
					{
						//openAlertModal("Warning","Please delete the users belonging to the level first");
						openAlertModal( "Warning" , "해당 레벨에 속한 사용자들을 먼저 삭제해 주세요." );
					}
					else
					{
						openAlertModal( "Warning" , data.resultMsg );
					}
				} ,
				error : function( e )
				{
					openAlertModal( callErrorMsg );
				} ,
				complete : function()
				{

				}
			} );
		} );
	}

	function goModifyLevelDup()
	{
		fnDisplayVisible( "modalFailConfirmAddFail" , true );
		fnConfirmFailMessage( "권한 추가 확인" , "권한명이 이미 사용중입니다." );
	}

	function fnConfirmFailMessage( title, message )
	{
		$( '#modalFailTextConfirmTitle' ).text( title );
		$( '#modalFailSpanConfirmMessage' ).text( message );
		fnModalOpen( 'modalFailConfirm' , true );
	}

	function goModifyLevelStart()
	{
		<c:set var="infoMod" value="A" />

		fnDisplayVisible( "modalConfirmAdd" , true );
		fnConfirmMessage( "권한 추가 확인" , "권한 추가 하시겠습니까?" );
	}

	function fnConfirmMessage( title, message )
	{
		$( '#modalTextConfirmTitle' ).text( title );
		$( '#modalSpanConfirmMessage' ).text( message );
		fnModalOpen( 'modalConfirm' , true );
	}

	function fnProcAdd()
	{

		$( "#menu" ).attr( "action" , "/management/operation/userlevel/addAction" );
		$( "#menu" ).submit();
	}

	function goModifyLevel()
	{

		if ( $( "#new_menu_name" ).val().trim().length < 1 )
		{
			//fnErrorMessage( "권한명을 확인하세요." );
			fnDisplayVisible( "modalFailConfirmAddFail" , true );
			fnConfirmFailMessage( "권한명 확인" , "권한명을 확인하세요." );
			return false;
		}
		if ( $( "#new_menu_path" ).val().trim().length < 1 )
		{
			//fnErrorMessage( "권한 설명을 확인하세요." );
			fnDisplayVisible( "modalFailConfirmAddFail" , true );
			fnConfirmFailMessage( "권한 설명 확인" , "권한 설명을 확인하세요.." );
			return false;
		}
		if ( $( "input[name='chk_use']:checked" ).length < 1 )
		{
			//fnErrorMessage( "접근 가능 메뉴를 선택해주세요." );
			fnDisplayVisible( "modalFailConfirmAddFail" , true );
			fnConfirmFailMessage( "접근 메뉴 확인" , "접근 가능 메뉴를 선택해주세요." );
			return false;
		}

		var param = new Object();
		param = $( "#menu" ).serialize();

		$.ajax( {
			url : "dupLevelTitle" ,
			data : param ,
			type : 'POST' ,
			dataType : 'json' ,
			success : function( data )
			{
				if ( data.resultMsg == "succ" )
				{
					goModifyLevelStart();
				}
				else
				{
					goModifyLevelDup();
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

	function fnValid()
	{

		// 계정 추가인 경우
		if ( $( "#new_menu_name" ).val().trim().length < 1 )
		{
			fnErrorMessage( "권한명을 확인하세요." );
			return false;
		}
		if ( $( "#new_menu_path" ).val().trim().length < 1 )
		{
			fnErrorMessage( "권한 설명을 확인하세요." );
			return false;
		}
		if ( $( "input[name='chk_use']:checked" ).length < 1 )
		{
			fnErrorMessage( "접근 가능 메뉴를 선택해주세요." );
			return false;
		}

		return true;

	}
</script>

<link rel="stylesheet" type="text/css" href="/assets/libs/nestable/nestable.css">
<link href="/dist/css/style.min.css" rel="stylesheet">


<!-- ============================================================== -->
<!-- Bread crumb and right sidebar toggle -->
<!-- ============================================================== -->
<div class="page-breadcrumb border-bottom">

	<form id="menu" name="menu" commandName="menu" method="post" action="/management/operation/userlevel/list">


		<div class="row">
			<div class="col-lg-3 col-md-4 col-xs-12 align-self-center">
				<h5 class="font-medium text-uppercase mb-0">권한 추가</h5>
			</div>
			<div class="col-lg-9 col-md-8 col-xs-12 align-self-center">

				<nav aria-label="breadcrumb" class="mt-2 float-md-right float-left">
					<ol class="breadcrumb mb-0 justify-content-end p-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item ">시스템 관리</li>
						<li class="breadcrumb-item ">권한 관리</li>
						<li class="breadcrumb-item active" aria-current="page">권한 추가</li>

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
	<div class="col-lg-12 col-md-12">


		<div class="card" style="flex-direction: row">
			<div class="card-body" style="width: 30%">
				<h4 class="card-title">권한 명</h4>
				<div class="myadmin-dd-empty dd" id="nestable">
					<ol class="dd-list">
						<li class="dd-item" data-id="0">
							<%-- <div class="dd-handle">${list.leveltitle}</div> --%>
							<input type="text" class="form-control" id="new_menu_name" name="new_menu_name"  placeholder="권한 명" />
						</li>
					</ol>
				</div>
			</div>
			<div class="card-body" style="width: 70%">
				<h4 class="card-title">설 명</h4>
				<div class="myadmin-dd-empty dd" id="nestable2">
					<ol class="dd-list">
						<li class="dd-item dd3-item" data-id="0">
							<%-- <div class="dd-handle">${list.description}</div> --%>
							<input type="text" class="form-control" id="new_menu_path" name="new_menu_path"   placeholder="권한 설명" />
						</li>
					</ol>
				</div>
			</div>
		</div>
				
				<!-- 
		<div class="card" style="flex-direction: row">
			<div class="card-body" style="width: 30%">
				<h4 class="card-title">
					권한 명
					<span style="color: red; padding: 0 7px;">*</span>
				</h4>
				<div class="myadmin-dd-empty dd" id="nestable">
					<ol class="dd-list">
						<li class="dd-item" data-id="0">
								<input type="text" style="width: 100%; border: 0;" id="new_menu_name" name="new_menu_name" placeholder="권한 명" />
								<small id="name" class="form-text text-muted">권한 명이 중복됩니다.</small>
						</li>
					</ol>
				</div>
			</div>
			<div class="card-body" style="width: 50%">
				<h4 class="card-title">설 명</h4>
				<div class="myadmin-dd-empty dd" id="nestable2">
					<ol class="dd-list">
						<li class="dd-item dd3-item" data-id="0">
								<input type="text" style="width: 80%; border: 0;" id="new_menu_path" name="new_menu_path" placeholder="권한 설명" />
						</li>
					</ol>
				</div>
			</div>
		</div>
 -->


		<div class="card" style="flex-direction: row">
			<div class="card-body" style="width: 30%">
				<h4 class="card-title">접근 가능 메뉴 명</h4>
				<div class="myadmin-dd dd" id="nestable">
					<ol class="dd-list">
						<c:forEach items="${menuList}" var="menu1Depth" varStatus="status1Depth">
							<li class="dd-item" data-id="${menu1Depth.CHILDREN}">
								<div class="dd-handle">
									<div class="input-group mb-12">
										<input type="text" class="form-control" style="border: none;" id="menu_name" name="menu_name" readonly="readonly" value="${menu1Depth.MENU_NAME}" />
										<div class="input-group-append" style="padding: 10px 0 0 16px;">

											<input dir="rtl" type="checkbox" style="float: right;" id="chk_use" name="chk_use" value="${menu1Depth.MENU_ID}">

										</div>
									</div>
								</div>
								<c:if test="${fn:length(menu1Depth.CHILDREN) ne 0}">
									<ol class="dd-list">
										<c:forEach items="${menu1Depth.CHILDREN}" var="menu2Depth" varStatus="status2Depth">
											<li class="dd-item" data-id="${menu1Depth.CHILDREN}">
												<div class="dd-handle">
													<div class="input-group mb-12">
														<input type="text" class="form-control" style="border: none;" id="menu_name" name="menu_name" readonly="readonly" value="${menu2Depth.MENU_NAME}" />
														<div class="input-group-append" style="padding: 10px 0 0 16px;">

															<input dir="rtl" type="checkbox" style="float: right;" id="chk_use" name="chk_use" value="${menu2Depth.MENU_ID}">

														</div>
													</div>
												</div>
											</li>
										</c:forEach>
									</ol>
								</c:if>
							</li>


						</c:forEach>
					</ol>
				</div>
			</div>

			<div class="card-body" style="width: 70%">
				<h4 class="card-title">URL</h4>
				<div class="myadmin-dd dd" id="nestable2">
					<ol class="dd-list">
						<c:forEach items="${menuList}" var="menu1Depth" varStatus="status1Depth">
							<li class="dd-item" data-id="3">
								<div class="dd-handle">
									<div class="input-group mb-12">
										<input type="text" class="form-control" style="border: none;" id="menu_name" name="menu_name" readonly="readonly" value="${menu1Depth.MENU_PATH}" />
									</div>
								</div>
								<c:if test="${fn:length(menu1Depth.CHILDREN) ne 0}">
									<c:forEach items="${menu1Depth.CHILDREN}" var="menu2Depth" varStatus="status2Depth">
										<li class="dd-item" data-id="4">
											<div class="dd-handle">
												<div class="input-group mb-12">
													<input type="text" class="form-control" style="border: none;" id="tmp_menu_path" name="tmp_menu_path" readonly="readonly" value="${menu2Depth.MENU_PATH}" />
												</div>
											</div>
										</li>
									</c:forEach>
								</c:if>
							</li>
						</c:forEach>
					</ol>
				</div>
			</div>
		</div>


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
					<c:if test='${infoMod eq "F"}'>
						<div class="modal-footer" id="modalConfirmAddFail">
							<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">확인</button>
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



		<div id="modalFailConfirm" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
			<div class="modal-dialog" aria-labelledby="vcenter">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modalFailTextConfirmTitle"></h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label class="control-label">
								<span id="modalFailSpanConfirmMessage">{confirmMessage}</span>
							</label>
						</div>
					</div>
					<div class="modal-footer" id="modalFailConfirmAddFail">
						<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>




		</form>

		<div class="card" style="background: none; "> <!-- float:right 버튼 위치 변경 ksh -->
			<div class="card-body" style="padding: 0;">
				<button class="btn waves-effect waves-light btn-secondary float-left" onclick="goList()">취소</button> <!-- float-left 버튼 위치 변경 ksh -->
				<button class="btn waves-effect waves-light btn-primary float-right" onclick="goModifyLevel()">권한 추가</button> <!-- float-left 버튼 위치 변경 ksh -->


			</div>
		</div>

		<!-- ============================================================== -->
		<!-- End PAge Content -->
		<!-- ============================================================== -->

		<!-- modal popup : start -->
		<%@include file="/WEB-INF/template/modalPopup.jsp"%>
		<!-- modal popup : end -->

	</div>