<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>


<link href="/assets/extra-libs/datatables.net-bs4/css/dataTables.bootstrap4.css" rel="stylesheet">
<link href="/dist/css/style.min.css" rel="stylesheet">

<script type="text/javascript">
	//Ajax로 첫 화면의 데이터 호출
	$( document ).ready( function()
	{

		$( "#btn_add" ).click( function()
		{
			goAdd();
		} );

		$( "#btn_search" ).click( function()
		{
			goSearch( $( "#levelId" ).val() );
		} );

		fnInit();
	} );

	//init function
	function fnInit()
	{
		if ( "${searchVal.s_levelId}" != "" )
		{
			$( "#levelId" ).val( "${searchVal.s_levelId}" );
		}

		goSearch( $( "#levelId" ).val() );
	}

	function onSearch( paramValue )
	{
		//$("#page").val("1")
		goSearch( paramValue );
	}

	//user Level Manage search
	function goSearch( paramValue )
	{

		$( "#page" ).val( paramValue );
		var param = new Object();
		param.levelId = paramValue;
		param.page = paramValue;
		//param = $( "#frmDetail" ).serialize();

		$.ajax( {
			url : "listAction" ,
			data : param ,
			type : 'POST' ,
			success : function( data )
			{
				$( "#userLevelTable" ).html( data );
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

	//user Level Manage  goAdd
	function goAdd()
	{
		$( "#myForm" ).attr( "action" , "/management/operation/userlevel/add" );
		$( "#myForm" ).submit();
	}

	//user Level Manage goDetail
	function goDetail( level_id )
	{

		$( "#level_id" ).val( level_id );
		$( "#frmDetail" ).attr( "action" , "/management/operation/userlevel/detail" );
		$( "#frmDetail" ).submit();
	}

	//exportAtion
	function fnExcel()
	{
		if ( $( "#userLevelTable tbody .nodata" ).length > 0 )
		{
			// openAlertModal("warning","<spring:message code="msg.common.excel.download.alarm" />");
			openAlertModal( "Warning" , "데이터가 존재하지 않습니다.\n 검색 조건을 다시 확인하세요." );
			return;
		}

		var param = new Object();
		param = $( "#myForm" ).serialize();
		$.download( 'exportAction.xls' , param , 'post' );
	}

	function changeTrColor( trObj, oldColor, newColor )
	{
		trObj.style.backgroundColor = newColor;
		trObj.onmouseout = function()
		{
			trObj.style.backgroundColor = oldColor;
		}
	}

	function clickTrEvent( trObj )
	{
		alert( trObj.id );
	}

	function goAdd()
	{
		$( "#myForm" ).attr( "action" , "/management/operation/userlevel/add" );
		$( "#myForm" ).submit();
	}
	
</script>
<form id="myForm" name="myForm" method="POST" action="javascript:onSearch();"></form>

<form id="frmDetail" name="frmDetail" method="POST">
	<input type="hidden" id="level_id" name="level_id" readonly="readonly" />
	<input type="hidden" id="page" name="page" value="1"  readonly="readonly" />
</form>

<!-- ============================================================== -->
<!-- Bread crumb and right sidebar toggle -->
<!-- ============================================================== -->
<div class="page-breadcrumb border-bottom">
	<div class="row">
		<div class="col-lg-3 col-md-4 col-xs-12 align-self-center">
			<h5 class="font-medium text-uppercase mb-0">권한 관리</h5>
		</div>
		<div class="col-lg-9 col-md-8 col-xs-12 align-self-center">

			<nav aria-label="breadcrumb" class="mt-2 float-md-right float-left">
				<ol class="breadcrumb mb-0 justify-content-end p-0">
					<li class="breadcrumb-item">Home</li>
					<li class="breadcrumb-item">시스템 관리</li>
					<li class="breadcrumb-item active" aria-current="page">권한 관리</li>
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
		<!-- Column -->
		<div class="col-lg-12"> <!--  col-md-1 삭제  ksh pdf에 항목 없음 -->
			<div class="card">
				<div class="card-body">
					<!-- <div class="d-flex no-block align-items-center mb-4">
						<h4 class="card-title">관리자 권한 목록</h4>
						<div class="btn-group">
							<button type="button" class="btn waves-effect waves-light btn-primary" onclick="goAdd() " style="margin:0 0 11px 10px;">권한 추가</button>
						</div>
					</div> -->






					<div id="userLevelTable" class="table-responsive" >
						<table class="table table-bordered nowrap display">
							<thead>
								<tr>
									<th>
										<span class="text-muted">No.</span>
									</th>
									<th>
										<span class="text-muted">등급</span>
									</th>
									<th>
										<span class="text-muted">설명</span>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr onclick="javascript:goDetail()">
									<td>1</td>
									<td>ADMIN</td>
									<td>2222</td>
								</tr>
							</tbody>
						</table>
					</div>


					<!--
					<div class="table-responsive">
						<table id="file_export" class="table table-bordered nowrap display">
							<thead>
								<tr>
									<th>
										<span class="text-muted">No.</span>
									</th>
									<th>
										<span class="text-muted">등급</span>
									</th>
									<th>
										<span class="text-muted">설명</span>
									</th>
								</tr>
							</thead>


							 <tbody>


							 <tbody>
									<tr onclick="javascript:goDetail()">
										<td>1</td>
										<td>admin</td>
										<td>2222</td>
									</tr>
								</tbody>

							<div id="userLevelTable" class="table-responsive">
								<tr class="text-muted" onClick="javascript:goDetail();">
									<td>1</td>
									<td>ADMIN</td>
									<td>스마트검진 관리자 웹 최고 등급, 모든 페이지 접근 가능</td>
								</tr>
								<tr class="text-muted">
									<td>2</td>
									<td>STAFF</td>
									<td>회원 관리와 검사실 정보 등록 및 관리를 제외한 모든 메뉴 접근 가능</td>
								</tr>
								<tr class="text-muted">
									<td>3</td>
									<td>GUEST</td>
									<td>검사실 및 수진자 메뉴에만 접근 가능</td>
								</tr>

								</div>
							</tbody>







						</table>
					</div>

					 -->

					<div class="btn-group float-right" style="margin-top:-35px;"> <!-- margin-top:-35px; 페이징과 버튼 같은 높이에 ksh pdf 26-->
						<button type="button" class="btn waves-effect waves-light btn-primary" onclick="goAdd() ">권한 추가</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ============================================================== -->
	<!-- End PAge Content -->
	<!-- ============================================================== -->
</div>
<!-- Create Modal -->
<div class="modal fade" id="createmodel" tabindex="-1" role="dialog" aria-labelledby="createModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="createModalLabel">
					<i class="ti-marker-alt mr-2"></i>
					{} 의 비밀번호를 초기화 하시겠습니까?
				</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				<button onclick="" class="btn btn-success">
					<i class="ti-save"></i>
					확인
				</button>
			</div>
		</div>
	</div>
</div>

<!-- // Create Modal -->