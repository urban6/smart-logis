<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
	.dd-handle input::-webkit-input-placeholder {color:#333 !important} /* 신규 메뉴 명 글자색 ksh 07-26*/
</style>

<script type="text/javascript">
	//화면 먼저 보이고 데이터를 불러야 사용자가 덜 답답해 함
	$( document ).ready( function()
	{
		$( "#menu" ).on( "submit" , function( event )
		{
			if ( boolSubmit == false )
			{
				event.preventDefault();
			}
		} );

		// Nestable
		var updateOutput = function( e )
		{
			var list = e.length ? e : $( e.target ) , output = list.data( 'output' );

			console.log( "output=" + list.nestable( 'serialize' ) );
			console.log( "output=" + JSON.stringify( list.nestable( 'serialize' ) ) );

			if ( window.JSON )
			{
				output.val( window.JSON.stringify( list.nestable( 'serialize' ) ) );

				var moveMenuHtml = fnMoveMenu( JSON.stringify( list.nestable( 'serialize' ) ) );

				$( "#divMenuHtml" ).html( moveMenuHtml );
			}
			else
			{
				output.val( 'JSON browser support required for this demo.' );
			}
		};

		$( '#nestable' ).nestable( {
			group : 1 ,
			maxDepth : 2
		} ).on( 'change' , updateOutput );

		updateOutput( $( '#nestable' ).data( 'output' , $( '#nestable-output' ) ) );

		$( "#menuNameNew" ).keydown( function()
		{
			if ( $( this ).val().trim().length > 0 )
			{
				var replaceStr = valid.replaceName( $( this ).val() );
				$( this ).val( replaceStr );
			}
			else
			{
				fnDisplayVisible( "validMessageMenuNameNew" , false );
			}
		} );

		fnDisplayVisible( "validMessageMenuNameNew" , false );
	} );

	function getModifyMenuPage( node_id )
	{
		if ( node_id == "0" )
		{
			$( '#menuAttribute' ).empty();
			return;
		}

		var param = new Object();
		param.menu_id = node_id;
		$.ajax( {
			url : "getMenuAction" ,
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
</script>
<link rel="stylesheet" type="text/css" href="/assets/libs/nestable/nestable.css">
<link href="/dist/css/style.min.css" rel="stylesheet">
<form id="menu" name="menu" commandName="menu" method="post" action="/management/operation/menu/index">
	<input type="hidden" id="menuIdDelete" name="menuIdDelete" readOnly="readonly" />
	<input type="hidden" id="menuNameDelete" name="menuNameDelete" readonly="readonly" />

	<!-- ============================================================== -->
	<!-- Bread crumb and right sidebar toggle -->
	<!-- ============================================================== -->
	<div class="page-breadcrumb border-bottom">
		<div class="row">
			<div class="col-lg-3 col-md-4 col-xs-12 align-self-center">
				<h5 class="font-medium text-uppercase mb-0">메뉴 수정</h5>
			</div>
			<div class="col-lg-9 col-md-8 col-xs-12 align-self-center">

				<nav aria-label="breadcrumb" class="mt-2 float-md-right float-left">
					<ol class="breadcrumb mb-0 justify-content-end p-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item">시스템 관리</li>
						<li class="breadcrumb-item">메뉴 관리</li>
						<li class="breadcrumb-item active" aria-current="page">메뉴 수정</li>
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
			<div class="col-lg-12">
				<div class="card" style="flex-direction: row">
					<div class="card-body" style="width: 30%">
						<h4 class="card-title">
							신규 메뉴명
							<span style="color: red">*</span>
						</h4>
						<div class="myadmin-dd dd">
							<ol class="dd-list">
								<li class="dd-item" data-id="0">
									<div class="dd-handle">
										<input type="text" class="form-control" style="width: 100%; border: 0; background:#d9d9d9;color:#000;" id="menuNameNew" name="menuNameNew" placeholder="<spring:message code="label.security.menu.menu_name.text"/>" /> <!-- background:#d9d9d9;color:#000; 배경 글자색 수정 ksh 07-26-->
									</div>
								</li>
							</ol>
						</div>
						<small class="form-text text-muted d-none" id="validMessageMenuNameNew">필수 입력값입니다.</small>
					</div>
					<div class="card-body" style="width: 50%">
						<h4 class="card-title">URL</h4>
						<div class="myadmin-dd dd">
							<ol class="dd-list">
								<li class="dd-item" data-id="0">
									<div class="dd-handle">
										<input type="text" class="form-control" style="width: 100%; border: 0; background:#d9d9d9;color:#000;" id="menuPathNew" name="menuPathNew" placeholder="<spring:message code="label.security.menu.link_path.text"/>" /> <!-- background:#d9d9d9;color:#000; 배경 글자색 수정 ksh 07-26-->
									</div>
								</li>
							</ol>
						</div>
					</div>
					<div class="card-body" style="width: 20%">
						<!-- 						<h4 class="card-title"></h4> -->
						<div class="myadmin-dd dd" style="padding: 2.5rem 0 0; float: right;">
							<button class="btn waves-effect waves-light btn-success" onclick="javascript:fnAddMenu();">메뉴 추가</button>
						</div>
					</div>
				</div>				
				<div class="card" style="flex-direction: row"> <!-- 신규메뉴 명 위치 변경 ksh 07-26-->
					<shovvel:menuListEdit menuList="${menuList}" menuHtmlTitle="메뉴 명" menuHtmlTarget="nestable">BodyContent</shovvel:menuListEdit> <!-- 신규메뉴 명 위치 변경 ksh 07-26-->
				</div>	<!-- 신규메뉴 명 위치 변경 ksh 07-26-->
<!-- 				<div class="row" style="background: none;">padding 삭제해주세요 ksh 0730 -->
<!-- 					<div class="col-12" style="padding:2.5rem 1.2rem 1rem 2.9rem"> style="padding:2.5rem 1.2rem 1rem 2.9rem" 버튼 위치 변경 ksh 0730 -->
<!-- 						<button class="btn waves-effect waves-light btn-primary"  type="submit" >저장</button> -->
<!-- 						<button class="btn waves-effect waves-light btn-secondary" onclick="javascript:fnCancel();">취소</button> -->
<!-- 						<button class="btn waves-effect waves-light btn-primary float-right" onclick="javascript:fnModifyMenu();">저장</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
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
						삭제하시겠습니까?
					</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					<button onclick="javascript:delete_menu()" class="btn btn-success">
						<i class="ti-save"></i>
						확인
					</button>
				</div>
			</div>
		</div>
	</div>
</form>
<script src="/dist/js/custom.min.js"></script>
<script src="/assets/libs/nestable/jquery.nestable.js"></script>
<script>
	$( function()
	{
	} );

	function fnCancel()
	{
		boolSubmit = true;
		fnMenuUrl();
	}

	function fnMoveMenu( jsonStr )
	{
		var result = "";
		var parsedJson = JSON.parse( jsonStr );
		menuIndex = 0;
		result = fnMoveMenuJson( 0 , 0 , parsedJson );
		return result;
	}

	var menuIndex = 0;
	function fnMoveMenuJson( level, upperMenu, jsonObjList )
	{
		var result = "";
		var objIdx = upperMenu;

		$( jsonObjList )
				.each(
						function( index )
						{
							objIdx++;
							var menuUpper = this.upper;
							var menuId = this.id;
							var menuName = this.name;
							var menuDepth = level; //this.depth;
							var menuOrder = this.order;
							var menuPath = this.path;

							result += "<div class=\"row d-none\">";
							result += "<div class=\"col-1\">" + menuIndex + "</div>";
							result += "<div class=\"col-4\">" + menuName + "</div>";
							result += "<input type=\"hidden\" id=\"menuUpperId_" + menuId + "\" name=\"menuList[" + menuIndex + "].upMenuId\" value=\"" +  upperMenu + "\" size=\"4\" readOnly=\"readOnly\"/>";
							result += "<input type=\"hidden\" id=\"menuId_" + menuId + "\" name=\"menuList[" + menuIndex + "].menuId\" value=\"" + menuId + "\" size=\"4\" readOnly=\"readOnly\"/>";
							result += "<input type=\"hidden\" id=\"depth_" + menuId + "\" name=\"menuList[" + menuIndex + "].depth\" value=\"" + menuDepth + "\" size=\"4\" readOnly=\"readOnly\"/>";
							result += "<input type=\"hidden\" id=\"displayOrder_" + menuId + "\" name=\"menuList[" + menuIndex + "].displayOrder\" value=\"" + objIdx + "\" size=\"4\" readOnly=\"readOnly\"/>";
							result += "<input type=\"hidden\" id=\"menuName_" + menuId + "\" name=\"menuList[" + menuIndex + "].menuName\" value=\"" + menuName + "\" readOnly=\"readOnly\"/>";
							result += "<input type=\"hidden\" id=\"menuPath_" + menuId + "\" name=\"menuList[" + menuIndex + "].menuPath\" value=\"" + menuPath + "\" readOnly=\"readOnly\"/>";
							// 							result += "&nbsp;&nbsp;";

							if ( typeof this.children == "object" )
							{
								result += "<input type=\"hidden\" id=\"isFolder_" + menuId + "\" name=\"menuList[" + menuIndex + "].isFolder\" value=\"Y\" readOnly=\"readOnly\"/>";
								result += "<br>";
								result += "</div>";

								menuIndex++;

								var childrenList = JSON.parse( JSON.stringify( this.children ) );
								result += fnMoveMenuJson( level + 1 , menuId , childrenList );
								result += "</div>";
							}
							else
							{
								result += "<input type=\"hidden\" id=\"isFolder_" + menuId + "\" name=\"menuList[" + menuIndex + "].isFolder\" value=\"N\" readOnly=\"readOnly\"/>";
								result += "<br>";
								result += "</div>";

								menuIndex++;
							}
							console.log( menuName + "\n" );
						} );

		return result;
	}

	function fnDelete( id )
	{

		var param = new Object();
		param.menuId = id;

		$.ajax( {
			url : "/management/operation/menu/deleteAction" ,
			data : param ,
			type : 'POST' ,
			dataType : 'json' ,
			async : false ,
			success : function( data )
			{
				result = data.returnMsg;
				if ( result == "SUCCESS" )
				{
					fnResultMessage( "SUCCESS_REFRESH" , "menu" , "메뉴 삭제" , "메뉴가 삭제되었습니다." );
					fnUrl();
				}
				else
				{
					fnResultMessage( "Warning" , "menu" , "메뉴 삭제 실패" , data.resultMsg );
				}
			} ,
			error : function( e )
			{
				fnErrorMessage( callErrorMsg );
			} ,
			complete : function()
			{

			}
		} );
	}

	function fnUrl()
	{
		$( "#menu" ).attr( "action" , "/management/operation/menu/index" );
		$( "#menu" ).submit();

	}

	function fnAddMenu()
	{
		if ( valid.minLen( $( "#menuNameNew" ).val() , 2 ) )
		{
			fnDisplayVisible( "validMessageMenuNameNew" , true );
			fnResultMessage( "" , "menu" , "메뉴 추가 오류" , "메뉴명을 확인하세요." );
			return false;
		}

		var param = new Object();
		param.menuNameNew = $( "#menuNameNew" ).val();
		param.menuPathNew = $( "#menuPathNew" ).val();

		$.ajax( {
			url : "/management/operation/menu/addMenu" ,
			data : param ,
			type : 'POST' ,
			dataType : 'json' ,
			async : false ,
			success : function( data )
			{
				result = data.returnMsg;
				if ( result == "SUCCESS" )
				{
					fnResultMessage( "SUCCESS_REFRESH" , "menu" , "메뉴 추가" , "메뉴가 추가되었습니다." );
				}
				else
				{
					fnResultMessage( "Warning" , "menu" , "메뉴 추가 실패" , data.resultMsg );
				}
			} ,
			error : function( e )
			{
				fnErrorMessage( callErrorMsg );
			} ,
			complete : function()
			{

			}
		} );

	}

	function fnModifyMenu()
	{
		var param = new Object();
		param = $( "#menu" ).serialize();
		// 		param = $( "#menu" );

		// 		console.log( "modify=" + JSON.stringify(param) );
		// 		console.log( "modify=" + $( "#menu" ) );

		// 		return false;

		$.ajax( {
			url : "modifyAction" ,
			data : param ,
			type : 'POST' ,
			dataType : 'json' ,
			success : function( data )
			{
				if ( data.returnMsg == "SUCCESS" )
				{
					fnResultMessage( "SUCCESS_REFRESH" , "menu" , "메뉴 수정" , "메뉴가 수정되었습니다." );
				}
				else
				{
					fnResultMessage( "Warning" , "menu" , "메뉴 수정" , data.resultMsg );
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
		// 		$( "#menu" ).attr( "action" , "/management/operation/menu/modifyAction" );
		// 		$( "#menu" ).attr( "method" , "post" );
		// 		$( "#menu" ).attr( "accept-charset" , "utf-8" );
		// 		$( "#menu" ).attr( "enctype" , "multipart/form-data" );
		// 		$( "#menu" ).submit();

	}

	function fnChangeValue( type, upMenuId, menuId )
	{
		if ( type == "Name" )
		{
			console.log( "[" + upMenuId + "_" + menuId + "]" );
			console.log( "이전내용 : " + $( "#menuName_" + menuId ).val() );
			console.log( "수정내용 : " + $( "#menuNameOld_" + upMenuId + "_" + menuId ).val() );
			$( "#menuName_" + menuId ).val( $( "#menuNameOld_" + upMenuId + "_" + menuId ).val() );
		}
		else if ( type == "Path" )
		{
			$( "#menuPath_" + menuId ).val( $( "#menuPathOld_" + upMenuId + "_" + menuId ).val() );
		}
	}
</script>

