<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>

<c:set var="wsTypeCallAll" value="callAll" />

<script type="text/javascript">
	var duplicatedTabMsg = "<spring:message code='msg.common.duplicated.newtab' />";

	$( document ).ready( function()
	{
		console.log( "${titleName}" )
		var userLevel = "${sessionUser.userLevel}";
		var userLevelArray = userLevel.split( " " );
		if ( userLevelArray.length == 1 )
		{
			$( "#userLevelSpan1" ).text( userLevelArray[ 0 ] );
		}
		else if ( userLevelArray.length == 2 )
		{
			$( "#userLevelSpan1" ).text( userLevelArray[ 0 ] );
			$( "#userLevelSpan2" ).text( userLevelArray[ 1 ] );
		}
		$( ".connect" ).attr( "style" , "visibility: hidden" );
		//	 	alert( "loginResult1 : ${loginResult}" );

		if ( "${loginResult}" != "undefined" && "${loginResult}" != "" )
		{
			var loginResult = "${loginResult}";
			alert( loginResult );
			if ( loginResult == "800" )
			{
				var str = "passwdExpiration";
				openPasswordChangeModal( str );
			}
			else if ( loginResult == "700" )
			{
				openAlertModal( "" , '<spring:message code="msg.login.failed.expired.account.noti" arguments="${dueDay}"/>' , function()
				{
				} );
			}
		}

		$( window ).scroll( function()
		{
			//console.log("==========scroll");
			if ( $( "._soFlashEffectDiv" ).length > 0 )
			{
				var sWidth = $( "._soFlashEffectDiv:eq(2)" ).css( "width" );
				$( "._soFlashEffectDiv" ).css( "top" , $( "body" ).scrollTop() + "px" );
				$( "._soFlashEffectDiv:eq(1)" ).css( "top" , "calc(100% + " + ( $( "body" ).scrollTop() ) + "px - " + sWidth + ")" );
			}
		} );

		var recentPageWidth;
		var maxRPW = 850;
		var minLength = 2;

		for ( var rp = 0 ; rp < minLength ; rp++ )
		{
			recentPageWidth = $( "#recentPageList" ).width();
			if ( recentPageWidth > maxRPW )
			{
				$( "#recentPageList li" ).eq( $( "#recentPageList li" ).length - 1 ).remove();
			}
		}
	} );

	/**
	 * 화면 이동 함수
	 */
	function fnRedirect( url )
	{
		//console.log("-->"+url);
		$( "#myForm" ).attr( "action" , url );
		$( "#myForm" ).attr( "method" , "post" );
		$( "#myForm" ).attr( "target" , "_parent" );
		$( "#myForm" ).submit();
	}

	/**
	 * 로그 아웃 함수
	 */
	function fnLogOutOk()
	{
		boolSubmit = true;
		fnCloseWindowAll(); //먼저 창을 닫아야 한다.
		$( "#myForm" ).attr( "action" , "/management/login/logoutAction" );
		$( "#myForm" ).submit();
	}

	function goUserInfo()
	{
		// 		if ( $( "#userInfoPopup" ).html() != "" )
		// 		{
		// 			$( "#userInfoPopup" ).html( "" );
		// 		}

		// 		var param = new Object();
		// 		param.userSno = "${sessionUser.userSno}";

		// 		$.ajax( {
		// 			url : '/management/operation/usermanage/userInfo' ,
		// 			type : 'POST' ,
		// 			data : param ,
		// 			success : function( data )
		// 			{
		// 				$( "#userInfoPopup" ).append( data );
		// 			} ,
		// 			complete : function()
		// 			{
		// 				openModal( '#userInfoPopup' );
		// 				//popupPosition('#userInfoPopup');
		// 			}
		// 		} );
		boolSubmit = true;
		$( "#myForm" ).attr( "action" , "/management/operation/usermanage/userInfo" );
		$( "#myForm" ).submit();

	}

	function goUserCreate()
	{
		var frm = makeform( "/management/operation/usermanage/add" );
		frm.submit();
	}

	function about()
	{
		var frm = makeform( "/management/help/information/list" );
		frm.submit();
	}

	function changePassword()
	{

		if ( $.trim( $( "#current_password" ).val() ) == "" )
		{
			// 현재 비밀번호를 입력해 주세요.
			showMessage( '<spring:message code="msg.change.password.current_password.msg" />' );
			$( "#current_password" ).focus();
			return;
		}
		else if ( $.trim( $( "#new_password1" ).val() ) == "" )
		{
			// 새 비밀번호를 입력해 주세요.
			showMessage( '<spring:message code="msg.change.password.new_password1.msg" />' );
			$( "#new_password1" ).focus();
			return;
		}
		else if ( $.trim( $( "#new_password2" ).val() ) == "" )
		{
			// 새 비밀번호 확인을 입력해 주세요.
			showMessage( '<spring:message code="msg.change.password.new_password2.msg" />' );
			$( "#new_password2" ).focus();
			return;
		}
		else if ( $.trim( $( "#new_password1" ).val() ) != $.trim( $( "#new_password2" ).val() ) )
		{
			// 새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.
			showMessage( '<spring:message code="msg.change.password.new_password.not_equal.msg" />' );
			$( "#new_password1" ).focus();
			$( "#new_password1" ).val( "" );
			$( "#new_password2" ).val( "" );
			return;
		}
		else if ( $.trim( $( "#new_password1" ).val() ) == $.trim( $( "#current_password" ).val() ) )
		{
			// 현재 비밀번호와 다른 비밀번호를 입력해 주세요.
			showMessage( '<spring:message code="msg.change.password.other_passwd.msg" />' );
			$( "#new_password1" ).focus();
			$( "#new_password1" ).val( "" );
			$( "#new_password2" ).val( "" );
			return;
		}
		else if ( ( $( "#new_password1" ).val().length < 5 ) || ( $( "#new_password1" ).val().length > 12 ) )
		{
			showMessage( '<spring:message code="msg.change.password.check_length.msg" />' );
			$( "#new_password1" ).val( "" );
			$( "#new_password2" ).val( "" );
			$( "#new_password1" ).focus();
			return;
		}
		else if ( !isValidPasswd( $( "#new_password1" ).val() ) )
		{
			showMessage( '<spring:message code="msg.security.usermanage.check_character.valid.password" />' );
			$( "#new_password1" ).val( "" );
			$( "#new_password2" ).val( "" );
			$( "#new_password1" ).focus();
			return;
		}
		/* else if(!isValidAlphaOrNum($("#new_password1").val())){
			// Please enter Password (alphabet+numbers).
			showMessage('<spring:message code="msg.security.usermanage.check_character.password" />');
			$("#new_password1").focus();
			$("#new_password1").val("");
			$("#new_password2").val("");
			return;
		} */
		// 		else
		// 		{
		// 			var rsaPublicKeyModulus = $( "#rsaPublicKeyModulus" ).val();
		// 			var rsaPublicKeyExponent = $( "#rsaPublicKeyExponent" ).val();
		// 			console.log( "rsaPublicKeyModulus : " + rsaPublicKeyModulus );
		// 			console.log( "rsaPublicKeyExponent : " + rsaPublicKeyExponent );
		// 			var rsa = new RSAKey();
		// 			rsa.setPublic( rsaPublicKeyModulus , rsaPublicKeyExponent );
		// 			var param = new Object();
		// 			param.current_password = rsa.encrypt( $( "#current_password" ).val() );
		// 			param.new_password = rsa.encrypt( $( "#new_password1" ).val() );
		// 			$.ajax( {
		// 				url : '/management/login/changePasswordAction' ,
		// 				type : 'POST' ,
		// 				data : param ,
		// 				dataType : 'json' ,
		// 				success : function( data )
		// 				{
		// 					if ( data.result == "-1" )
		// 					{
		// 						showMessage( '<spring:message code="msg.change.password.wrong_passwd.msg" />' );
		// 					}
		// 					else if ( data.result == "1" )
		// 					{
		// 						closeModal();
		// 						openAlertModal( "" , '<spring:message code="msg.change.password.change_complete.msg" />' , function()
		// 						{
		// 						} );
		// 					}
		// 				} ,
		// 				error : function( e )
		// 				{
		// 					if ( typeof e.reponseText == "undefined" )
		// 					{
		// 						showMessage( '<spring:message code="msg.login.error.webserver"/>' );
		// 					}
		// 					else
		// 					{
		// 						alert( e.reponseText );
		// 					}
		// 				} ,
		// 				complete : function()
		// 				{
		// 					$( "#current_password" ).val( "" );
		// 					$( "#new_password1" ).val( "" );
		// 					$( "#new_password2" ).val( "" );
		// 				}
		// 			} );
		// 		}
	}

	function showMessage( message )
	{
		$( "#infoMsg" ).removeClass( "hide" );
		$( "#infoMsg" ).addClass( "show" );
		$( "#infoMsg" ).text( message );
	}

	function fnMovePageMain( url )
	{
		if ( url == "" )
			return false;

		boolSubmit = true;

		$( "#myForm" ).attr( "action" , url );
		$( "#myForm" ).attr( "method" , "post" );
		$( "#myForm" ).attr( "target" , "" );
		$( "#myForm" ).submit();
	}

	function fnUserInfo()
	{
		goUserInfo();
	}

	function openSocketResponseCallAll( socketType, jsonObj )
	{
		try
		{
		//	alert("socketType  "+socketType);
			writeLog( socketType , JSON.stringify( jsonObj ) );
		}
		catch ( error )
		{
			console.log( "error=" + error );
		}
	}

	setSocketUrl( "${wsTypeCallAll}" , "${wsUrlSendAll}" );
	openSocket( "${wsTypeCallAll}" );

	function fnResponseCallAll( socketType, jsonObj )
	{
		var title = "";
		var message = "";
		var boolToastr = false;

		// 		alert( "fnResponseCallAll=" + jsonObj.resultCode + "/" + jsonObj.resultType );
		if ( jsonObj.resultType == "conncect" )
		{
			openSocketResponseCallAll( socketType , jsonObj );
		}
 
		if ( boolToastr )
		{
			console.log( "title=" + title );
			console.log( "message=" + message );
			fnToastrPopup( jsonObj.resultType , title , message );
		}
	}
</script>

<!-- header -->
<!-- ============================================================== -->
<!-- Topbar header - style you can find in pages.scss -->
<!-- ============================================================== -->
<header class="topbar">

<!-- <link rel="shortcut icon"  href="/image/SNUH_favicon.png"> -->
<link rel="icon" type="image/png" sizes="16x16" href="/image/SNUH_favicon.png">

	<form id="myForm" name="myForm" method="POST"></form>
	<nav class="navbar top-navbar navbar-expand-md navbar-toggleable-sm navbar-light">
		<!-- ============================================================== -->
		<!-- Logo -->
		<!-- ============================================================== -->
		<div class="navbar-header">
			<!-- This is for the sidebar toggle which is visible on mobile only -->
			<a class="nav-toggler waves-effect waves-light d-block d-md-none" href="javascript:void(0)">
				<i class="ti-menu ti-close"></i>
			</a>
			<a class="navbar-brand d-block d-md-none" href="/" style="text-align:center;"> <!--  style="text-align:center;" ksh 08-05 -->
				<!-- Logo icon -->
				<b class="logo-icon" style="margin:0"> <!-- style="margin:0" ksh 08-05 -->
					<!-- Dark Logo icon -->
					<!-- 로고 변경 부분 -->
					<img src="/image/snuh_main_img.png" alt="homepage" class="dark-logo" />   <!-- /snuh_main_img.png ksh 08-05 -->
					<!-- Light Logo icon -->
					 <img src="/image/snuh_main_img.png" alt="homepage" class=""  style="width:70%"/>  <!-- /snuh_main_img.png /  class 삭제 /  style="width:70%" ksh 08-05 -->
				</b>
			</a>
			<div class="d-none d-md-block text-center">
				<a class="sidebartoggler waves-effect waves-light d-flex align-items-center side-start" href="javascript:void(0)" data-sidebartype="mini-sidebar">
					<i class="mdi mdi-menu"></i>
					<!-- ============================================================== -->
					<!-- Logo image -->
					<!-- ============================================================== -->
					<span class="navigation-text">
						<img src="/image/snuh_main_img.png" alt="homepage" class=""  style="width:70%"/> <!-- /snuh_main_img.png / style="width:70% ksh 08-05 -->
					</span>
				</a>
			</div>
			<!-- ============================================================== -->
			<!-- End Logo -->
			<!-- ============================================================== -->
			<!-- ============================================================== -->
			<!-- Toggle which is visible on mobile only -->
			<!-- ============================================================== -->
			<a class="topbartoggler d-block d-md-none waves-effect waves-light" href="javascript:void(0)" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<i class="ti-more"></i>
			</a>
		</div>
		<!-- ============================================================== -->
		<!-- End Logo -->
		<!-- ============================================================== -->
		<div class="navbar-collapse collapse" id="navbarSupportedContent">
			<!-- ============================================================== -->
			<!-- toggle and nav items -->
			<!-- ============================================================== -->
			<ul class="navbar-nav float-left mr-auto d-none d-md-block">
				<li class="nav-item nav-link border-right" style="padding-left:20px;padding-top: 10px; color: #ffffff; font-weight: 600;">모두 고고해 사용자 웹</li><!-- style="padding-left:20px" ksh 08-01  -->
			</ul>
			<!-- ============================================================== -->
			<!-- Right side toggle and nav items -->
			<!-- ============================================================== -->
			<ul class="navbar-nav float-right">
				<!-- ============================================================== -->
				<!-- User profile and search -->
				<!-- ============================================================== -->
				<c:if test="${sessionUser.loginId ne null}">
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle waves-effect waves-dark pro-pic" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"  style="line-height: 62px"><!-- style="line-height: 62px" ksh 08-01  -->
							<!-- <img src="/assets/images/users/1.jpg" alt="user" class="rounded" width="36"> -->
							<span class="ml-2 user-text font-medium">${sessionUser.userFnm}</span>
							<span class="fas fa-angle-down ml-2 user-text"></span>
						</a>
						<div class="dropdown-menu dropdown-menu-right user-dd animated mt-0">
							<div class="d-flex no-block align-items-center p-3 mb-2 border-bottom">
								<!-- <div class="">
									<img src="/assets/images/users/1.jpg" alt="user" class="rounded" width="80">
								</div> -->
								<div class="ml-2">
									<h4 class="mb-0">${sessionUser.userFnm}</h4>
									<p class=" mb-0 text-muted">${sessionUser.loginId}</p>
								</div>
								<button type="button" class="btn waves-effect waves-light btn-outline-light" style="margin-left: 55px" onClick="javascript:fnUserInfo();">
									<span class="text-muted">회원정보</span>
								</button>
								<!-- </div> -->
							</div>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="javascript:fnLogOutOk()">
								<i class="fa fa-power-off mr-1 ml-1"></i>
								로그아웃
							</a>
						</div>
					</li>
				</c:if>
				<!-- ============================================================== -->
				<!-- User profile and search -->
				<!-- ============================================================== -->
			</ul>
		</div>
	</nav>
</header>
<!-- ============================================================== -->
<!-- End Topbar header -->
<!-- ============================================================== -->
<!-- ============================================================== -->
<!-- Left Sidebar - style you can find in sidebar.scss  -->
<!-- ============================================================== -->
<aside class="material left-sidebar" data-sidebarbg="skin5">
	<!-- Sidebar scroll-->
	<div class="scroll-sidebar">
		<!-- Sidebar navigation-->
		<nav class="sidebar-nav">
			<ul id="sidebarnav" class="in">
				<c:forEach items="${listAuthorizationMenu}" var="menu1Depth" varStatus="status1Depth">
					<li class="sidebar-item">
						<c:if test="${menu1Depth.isFolder eq 'Y'}">
							<a class="sidebar-link has-arrow waves-effect waves-dark" href="#" aria-expanded="false">
								<i class="${menu1Depth.imgPath}"></i>
								<span class="hide-menu">${menu1Depth.menuName}</span>
							</a>
						</c:if>
						<c:if test="${menu1Depth.isFolder eq 'N'}">
							<a class="sidebar-link waves-effect waves-dark sidebar-link" href="javascript:fnMovePageMain('${menu1Depth.menuPath}');" aria-expanded="false">
								<i class="${menu1Depth.imgPath}"></i>
								<span class="hide-menu">${menu1Depth.menuName}</span>
							</a>
						</c:if>
						<c:if test="${fn:length(menu1Depth.children) ne 0}">
							<ul aria-expanded="false" class="collapse  first-level" id="upMenu_${menu1Depth.menuId}">
								<c:forEach items="${menu1Depth.children}" var="menu2Depth" varStatus="status2Depth">
									<li class="sidebar-item">
										<a href="javascript:fnMovePageMain('${menu2Depth.menuPath}');" class="sidebar-link">
											<i class="mdi mdi-adjust"></i>
											<span class="hide-menu">
												<c:set var="arrayMenupath" value="${fn:split(menu2Depth.menuPath, '/')}" />
												<c:set var="menuPathLength" value="${fn:length(arrayMenupath)}" />
												${menu2Depth.menuName}
												<c:if test='${menuPathLength ne 0}'>
													<c:set var="menuPath">
														<span id="count_${arrayMenupath[menuPathLength-1]}">
																													${arrayMenupath[menuPathLength-1]}
														</span>
													</c:set>
												</c:if>
												<%-- ${menuPath} --%>
											</span>
										</a>
									</li>
									<c:if test='${menu2Depth.menuPath eq nowPagePath}'>
										<script type="text/javascript">
											$( "#upMenu_${menu1Depth.menuId}" ).addClass( "in" );
										</script>
									</c:if>
								</c:forEach>
							</ul>
						</c:if>
					</li>
				</c:forEach>
				<div class="devider"></div>
			</ul>
		</nav>
		<!-- End Sidebar navigation -->
		<div class="row d-none">
			<!-- 		<div> -->
			<%-- 			<button type="button" onclick="openSocket('${wsType}');">Open</button> --%>
						<button type="button" onclick='sendPushMsg("${wsType}", "{\"connectType\":\"connectExrm\"}");'>Send connected info</button>
			<%-- 			<button type="button" onclick="closeSocket('${wsType}');">Close</button> --%>
			<!-- 		</div> -->
			<!-- 		Server responses get written here -->
			<div id="${wsTypeCallAll}Log" class="col-12 d-none" style="color: #333333; background-color: #ffffff;"></div>
		</div>
	</div>
	<!-- End Sidebar scroll-->
</aside>
<section id="userInfoPopup" class="popup ml"></section>
<!-- //header -->

<!-- modal popup : start -->
<%@include file="/WEB-INF/template/modalPopup.jsp"%>
<!-- modal popup : end -->
