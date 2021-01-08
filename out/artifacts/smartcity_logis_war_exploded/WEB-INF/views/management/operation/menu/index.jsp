<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>

<script type="text/javascript">
	var language = '${language}';

	$( document ).ready( function()
	{
		/* // package 에 해당하는 트리만 그린다.
		$("select[id='package_id']").multipleSelect({
		     single: true
		    ,selectAll: false
		    ,multiple: false
			,multipleWidth: 150
		    ,width: "100px"
		    ,onClick: function(view) {
		 	   $('#menuAttribute').empty();
		 	   reloadMenuTree(view.value);
		      }
		});
		 */
		// loadMenuTree();
	} );

	//메뉴 그룹 등록
	function fnAddMenuGroup()
	{

		var node = $( '#dynatree' ).dynatree( "getActiveNode" );
		if ( !node )
		{
			// openAlertModal("",'<spring:message code="msg.need.select.menu.text"/>');
			// alert('<spring:message code="msg.need.select.menu.text"/>');
			openAlertModal( "Warning" , "메뉴를 선택해 주세요." );
			return;
		}

		if ( !node.data.isFolder )
		{
			// openAlertModal("",'<spring:message code="msg.not.menu_group.text"/>');
			//alert('<spring:message code="msg.not.menu_group.text"/>');
			openAlertModal( "Warning" , "해당 메뉴에는 메뉴 그룹을 추가할 수 없습니다." )
			return;
		}

		//그룹 2deth까지 등록가능. 그외 그룹 1depth까지 등록가능.
		/* console.log($('#package_id').val());
		   if($('#package_id').val() =="DM"){
			   	if(node.data.depth  < 2 ){
			    	goInsertMenuPage("Y", node.data.key , $('#package_id').val());
			    }else{
		    		openAlertModal("",'<spring:message code="msg.limit.two.depth.menu_group.text"/>');
					return;
			    }
		    }else{ */
		if ( node.data.depth < 1 )
		{
			goInsertMenuPage( "Y" , node.data.key );
		}
		else
		{
			//openAlertModal("",'<spring:message code="msg.limit.one.depth.menu_group.text"/>');
			//alert('<spring:message code="msg.limit.one.depth.menu_group.text"/>');
			openAlertModal( "Warning" , "1 depth의 메뉴 그룹에만 등록할 수 있습니다." );
			return;
		}
		// }

		node.expand( true );
	}

	//메뉴 등록
	function fnAddMenu()
	{
		var node = $( '#dynatree' ).dynatree( "getActiveNode" );
		if ( !node )
		{
			//openAlertModal("",'<spring:message code="msg.need.select.menu.text"/>');
			//alert('<spring:message code="msg.need.select.menu.text"/>');
			openAlertModal( "Warning" , "메뉴를 선택해 주세요." );
			return;
		}

		if ( !node.data.isFolder )
		{
			//openAlertModal("",'<spring:message code="msg.not.menu.text"/>');
			//alert('<spring:message code="msg.not.menu.text"/>');
			openAlertModal( "Warning" , "해당 메뉴에는 메뉴를 추가할 수 없습니다." );
			return;
		}

		goInsertMenuPage( "N" , node.data.key );
		node.expand( true );
	}

	function goInsertMenuPage( is_folder, menu_id )
	{
		var param = new Object();
		param.is_folder = is_folder;
		param.menu_id = menu_id;
		//param.pkg_name  = pkg_name;

		//param = JSON.stringify(param);
		console.log( param );
		$.ajax( {
			url : "insert" ,
			data : param ,
			type : 'POST' ,
			success : function( data )
			{
				$( "#menuAttribute" ).html( data );
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

	function getViewMenuPage( node_id )
	{
		console.log( node_id );
		if ( node_id == "0" )
		{
			$( '#menuAttribute' ).empty();
			return;
		}

		var param = new Object();
		param.menu_id = node_id;

		/* $.post('detailMenuAction.ajax', param, function(data) {
			alert(data);
			$('#menuAttribute').empty();
			$('#menuAttribute').html(data);
		}); */
		$.ajax( {
			url : "detailMenuAction" ,
			data : param ,
			type : 'POST' ,
			success : function( data )
			{
				$( '#menuAttribute' ).empty();
				$( "#menuAttribute" ).html( data );
			} ,
			error : function( e )
			{
				openAlertModal( "" , callErrorMsg );
			} ,
			complete : function()
			{

			}
		} );

		$( '#dynatree' ).dynatree( "getTree" ).activateKey( node_id );

	}

	function redirectPage( code, level )
	{
		$( '<form></form>' , {
			name : "frmMenuHandle"
		} ).appendTo( $( 'body' ) );
		var frm = makeform( "/management/dashboard/dashboard" );
		frm.submit();
	}
</script>

<link rel="stylesheet" type="text/css" href="/assets/libs/nestable/nestable.css">
<link href="/dist/css/style.min.css" rel="stylesheet">
<style>

.dd-item>button {
	color : #ffff;
 	left : -20px; 
    display: block;
    position: absolute;
    cursor: pointer;
    float: left;
    width: 25px;
    height: 20px;
    margin: 5px 0;
    padding: 0;
    text-indent: 100%;
    white-space: nowrap;
    overflow: hidden;
    border: 0;
    background: transparent;
    font-size: 12px;
    line-height: 1;
    text-align: center;
    font-weight: bold;
}

.dd-item>button:before {
    content: '+';
/*     left : -20px; */
    display: block;
    position: absolute;
    width: 100%;
    text-align: center;
    text-indent: 0;
}

.dd-item>button[data-action="collapse"]:before {
    content: '-';
}
</style>
<!-- ============================================================== -->
<!-- Bread crumb and right sidebar toggle -->
<!-- ============================================================== -->
<div class="page-breadcrumb border-bottom">
	<div class="row">
		<div class="col-lg-3 col-md-4 col-xs-12 align-self-center">
			<h5 class="font-medium text-uppercase mb-0">메뉴 관리</h5>
		</div>
		<div class="col-lg-9 col-md-8 col-xs-12 align-self-center">
			<nav aria-label="breadcrumb" class="mt-2 float-md-right float-left">
				<ol class="breadcrumb mb-0 justify-content-end p-0">
					<li class="breadcrumb-item">Home</li>
					<li class="breadcrumb-item">시스템 관리</li>
					<li class="breadcrumb-item active" aria-current="page">메뉴 관리</li>
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
		<div class="col-lg-12 col-xs-4">
			<!-- <div class="card" style="flex-direction: row">
				<form method="post" action="/management/operation/menu/detailMenuAction">
					<div class="card-body row">
						<h4 class="card-title" style="padding:8px 10px 0;">관리자웹 전체 메뉴 목록</h4>
						<div class="myadmin-dd-empty dd" id="nestable2">
							<button class="btn waves-effect waves-light btn-primary" type="submit">메뉴 수정</button>
						</div>
					</div>
				</form>
			</div> -->
			<div class="card" style="flex-direction: row">
				<shovvel:menuListView menuList="${menuList}" menuHtmlTitle="메뉴 명" menuHtmlTarget="nestable">BodyContent</shovvel:menuListView>
			</div>
			<form method="post" action="/management/operation/menu/detailMenuAction">
				<div class="myadmin-dd-empty dd float-right" id="nestable2">
					<button class="btn waves-effect waves-light btn-primary" type="submit">메뉴 수정</button>
				</div>
			</form>
		</div>
	</div>

	<!-- ============================================================== -->
	<!-- End PAge Content -->
	<!-- ============================================================== -->
	<!-- ============================================================== -->
	<!-- Right sidebar -->
	<!-- ============================================================== -->
	<!-- .right-sidebar -->
	<!-- ============================================================== -->
	<!-- End Right sidebar -->
	<!-- ============================================================== -->
</div>

<!-- ============================================================== -->
<!-- End Container fluid  -->
<!-- ============================================================== -->
<script src="/assets/libs/nestable/jquery.nestable.js"></script>
<script>
	$( function()
	{
		// Nestable
		var updateOutput = function( e )
		{
			var list = e.length ? e : $( e.target ) , output = list.data( 'output' );
			if ( window.JSON )
			{
				output.val( window.JSON.stringify( list.nestable( 'serialize' ) ) ); //, null, 2));
			}
			else
			{
				output.val( 'JSON browser support required for this demo.' );
			}
		};

		$( '#nestable' ).nestable( {
			group : 1
		} ).on( 'change' , updateOutput );

		$( '#nestable2' ).nestable( {
			group : 1
		} ).on( 'change' , updateOutput );

		updateOutput( $( '#nestable' ).data( 'output' , $( '#nestable-output' ) ) );
		updateOutput( $( '#nestable2' ).data( 'output' , $( '#nestable2-output' ) ) );

		$( '#nestable-menu' ).on( 'click' , function( e )
		{
			var target = $( e.target ) , action = target.data( 'action' );
			if ( action === 'expand-all' )
			{
				$( '.dd' ).nestable( 'expandAll' );
			}
			if ( action === 'collapse-all' )
			{
				$( '.dd' ).nestable( 'collapseAll' );
			}
		} );

		$( '#nestable-menu' ).nestable();
	} );
</script>
