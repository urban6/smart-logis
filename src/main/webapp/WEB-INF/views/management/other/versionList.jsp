<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>

<script type="text/javascript">
	$( document ).ready( function()
	{
		fnInit();
	} );

	//init function
	function fnInit()
	{
		$( "#frmList" ).on( "submit" , function( event )
		{
			if ( boolSubmit == false )
			{
				event.preventDefault();
			}
		} );

		goSearch( 1 );
	}

	//search 1 page set
	function onSearch( page )
	{
		goSearch( page );
	}

	//user manage search
	function goSearch( page )
	{
		$( "#page" ).val( page );

		fnLoading( true );

		var param = new Object();
		param = $( "#frmList" ).serialize();
		//console.log(JSON.stringify(param));

		$.ajax( {
			url : "versionListAction" ,
			data : param ,
			type : 'POST' ,
			cache : false ,
			success : function( data )
			{
				fnLoading( false );

				$( "#verAppListTable" ).html( data );
			} ,
			error : function( e )
			{
				fnErrorMessage( "오류가 발생했습니다." );
			} ,
			complete : function()
			{

			}
		} );
	}

	function fnList()
	{
		$( "#verAppListTable" ).html( "" );

		goSearch( 1 );
	}

	function fnAdd()
	{
		boolSubmit = true;
		$( "#frmList" ).attr( "action" , "/management/other/version/versionAdd" );
		$( "#frmList" ).submit();
	}

	function fnInfo( verNum, verNo, verType, verStr )
	{
		$( "#verAppNum" ).val( verNum );
		$( "#verAppNo" ).val( verNo );
		$( "#verAppType" ).val( verType );
		$( "#verAppStr" ).val( verStr );

		boolSubmit = true;
		$( "#frmList" ).attr( "action" , "/management/other/version/versionDetail" );
		$( "#frmList" ).submit();

		$( "#verAppNum" ).val( "" );
		$( "#verAppNo" ).val( "" );
		$( "#verAppType" ).val( "" );
		$( "#verAppStr" ).val( "" );
	}

	function fnDownloadApkFile( url )
	{
		boolSubmit = true;
		var actionB = $( "#frmList" ).attr( "action" );
		$( "#frmList" ).attr( "target" , "_blank" );
		$( "#frmList" ).attr( "action" , encodeURI( url ) );
		$( "#frmList" ).submit();

		$( "#frmList" ).attr( "target" , "_self" );
		$( "#frmList" ).attr( "action" , actionB );
	}
</script>

<!-- ============================================================== -->
<!-- Bread crumb and right sidebar toggle -->
<!-- ============================================================== -->
<div class="page-breadcrumb border-bottom">
	<div class="row">
		<div class="col-lg-3 col-md-4 col-xs-12 align-self-center">
			<h5 class="font-medium text-uppercase mb-0">앱 버전 관리</h5>
		</div>
		<div class="col-lg-9 col-md-8 col-xs-12 align-self-center">
			<nav aria-label="breadcrumb" class="mt-2 float-md-right float-left">
				<ol class="breadcrumb mb-0 justify-content-end p-0">
					<li class="breadcrumb-item">Home</li>
					<li class="breadcrumb-item">시스템 관리</li>
					<li class="breadcrumb-item" aria-current="page">앱 버전 관리</li>
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
					<form name="frmList" id="frmList" commandName="frmList" method="post" action="/management/other/version/verApplList">
						<input type="hidden" id="verAppNum" name="verAppNum" value="0" readonly="readonly" />
						<input type="hidden" id="verAppNo" name="verAppNo" value="0" readonly="readonly" />
						<input type="hidden" id="verAppType" name="verAppType" value="0" readonly="readonly" />
						<input type="hidden" id="verAppStr" name="verAppStr" value="0" readonly="readonly" />
					</form>
					<div id="verAppListTable" class="tab-content">
						<table id="verAppTable" class="table table-striped table-hover border dataTable display" role="grid">
							<thead>
								<tr>
									<th>
										<span class="text-muted">버전</span>
									</th>
									<th>
										<span class="text-muted">등록일</span>
									</th>
									<th>
										<span class="text-muted">파일명</span>
									</th>
									<th>
										<span class="text-muted">설 명</span>
									</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
					<div class="row">
						<div class="col-12 " style="margin: 0 0 1rem">
							<button class="btn waves-effect waves-light btn-primary float-right" onclick="javascript:fnAdd();" style="margin: 0 0 0 1rem">새 버전 등록</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- row -->
	</div>
	<!-- ============================================================== -->
	<!-- End PAge Content -->
	<!-- ============================================================== -->
</div>
<!-- ============================================================== -->
<!-- End Container fluid  -->
<!-- ============================================================== -->
