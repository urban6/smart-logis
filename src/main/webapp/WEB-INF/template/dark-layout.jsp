<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html dir="ltr" lang="ko">
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>모두 고고해</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="">
		<link rel="icon" type="image/png" sizes="16x16" href="/image/SNUH_favicon.png">
		<!-- Favicon icon
		<link rel="icon" type="image/png" sizes="16x16" href="/assets/images/favicon.png">
		<link href="/assets/libs/chartist/dist/chartist.min.css" rel="stylesheet"> -->
		<!-- c3 CSS -->
		<link href="/assets/libs/morris.js/morris.css" rel="stylesheet">
		<link href="/assets/extra-libs/c3/c3.min.css" rel="stylesheet">
		<!-- Custom CSS -->
		<link href="/assets/libs/fullcalendar/dist/fullcalendar.min.css" rel="stylesheet" />
		<link href="/assets/extra-libs/calendar/calendar.css" rel="stylesheet" />
		<link href="/assets/extra-libs/toastr/dist/build/toastr.min.css" rel="stylesheet">
		<!-- needed css -->
		<link href="/assets/libs/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
		 <link href="/dist/css/style.min.css" rel="stylesheet"> 
		<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<script type="text/javascript" src="/js/jquery-3.5.1.min.js"></script>
		<script type="text/javascript" src="/js/jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>
		<script type="text/javascript" src="/js/ui.js"></script>
		<script type="text/javascript" src="/js/jquery.validate.min.js"></script>
		<script type="text/javascript" src="/js/jquery.bpopup.min.js"></script>
		<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
		<script type="text/javascript" src="/js/custom.util.js"></script>
		
		<!-- shovvel 추가 -->
		<script type="text/javascript" src="/jss/commonUtilHCF.js"></script>
		<script type="text/javascript" src="/jss/stringUtil.js"></script>
		<script type="text/javascript" src="/jss/jquery.form.js"></script>
		<script type="text/javascript" src="/jss/fileupload.js"></script>
		<script type="text/javascript" src="/jss/stringFormat.js"></script>
		<script type="text/javascript" src="/jss/jquery.alphanumeric.js"></script>

		<%--<link type="text/css" rel="stylesheet" href="/css/content_mng.css" />--%>
		<script type="text/javascript" src="/js/mng/jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>
		<script type="text/javascript" src="/js/mng/jquery.bpopup.min.js"></script>

		<%--<script type="text/javascript" src="/js/mng/ui.js"></script>--%>
		<script type="text/javascript" src="/scripts/unit.js"></script>

		<%--<link type="text/css" rel="stylesheet" href="/styles/debug.css" />--%>
		<script type="text/javascript" src="/js/mng/common.js"></script>
		<script type="text/javascript" charset="utf-8" src="/scripts/jquery.alphanumeric.js"></script>
		<script src="/scripts/datetimepicker.moment.js"></script>
		<script src="/scripts/datetimepicker.js"></script>
		<script src="/scripts/jquery.simplemodal.js"></script>

		<!-- popup -->
		<script src="/scripts/openPop.js"></script>
		<%--<script src="/scripts/modal.js"></script>--%>

		<!-- 공통작성 -->
		<script src="/scripts/ui_common.js"></script>
		<script src="/scripts/stringUtil.js"></script>
		<script src="/scripts/commonUtil.js"></script>
		<script src="/scripts/commonUtilHCF.js"></script>

		<script src="/scripts/custom/local.storage.js"></script>
		<script src="/scripts/custom/open.window.js"></script>
		<script src="/scripts/modal.js"></script>

		<script type="text/javascript" src="/scripts/additional-methods.min.js"></script>
		<script type="text/javascript" src="/scripts/tinymce/tinymce.min.js"></script>

		<script type="text/javascript">
			window.history.forward();

			$(document).ready(function() {
				/* $(this).contextmenu(function(e) {
					return false;
				}); */

		  		$(document).ajaxError(function(e, x){
		  			if(x.status == 501){
						location.replace("/common/noSession");
					}
		  		});

		//		fnKeepAlive();
			});

			var refreshId = null;

			function fnKeepAlive(){
				// console.log("fnKeepAlive()...");
			 	refreshId = setInterval(function() {
			 		var result =
				 		$.ajax({
				 			url : "/common/keepAlive",
				 			type : "POST",
				 			async : false,
				 			cache : false
				 		});

			 		result.done(function(data) {
			 			// console.log(data);
			 			if (data == 1) { //서버 세션 잃어버림
			 				$.modal.close();
			 				openAlertModal( "warning","<spring:message code="msg.common.nosesion" />",function(){
				 				fnKeepAliveEnd();
			 				});
			 			} else if (data == 2) { //유저 강제 종료
			 				$.modal.close();
			 				openAlertModal( "warning","<spring:message code="msg.common.nosesion" />",function(){
				 				fnKeepAliveEnd();
			 				});
			 			} else if (data == 3) { //유저 레벨이 변경됨 -> 강제종료
			 				location.replace("/common/noSession"); //root 이동
			 			}
			 		});

				 	result.fail(function(xhr, status) {
						fnKeepAliveEnd();
			 		});

			 		if (result !== null) result = null;

			 		clearInterval(refreshId);
			 		fnKeepAlive();

				}, 60 * 1000);
			}

			function fnKeepAliveEnd() {
				clearInterval(refreshId);
				//fnCloseWindowAll(); //모든 팝업 닫기
				location.replace("/"); //root 이동
			}

			// show loading
			function showLoading() {
				$("#divLoading").removeClass("hide");
			}

			// hide loading
			function hideLoading() {
				$("#divLoading").addClass("hide");
			}

			//오류 메세지 호출 : 공통
			var callErrorMsg = '<spring:message code="msg.common.error" />';
		</script>
    <div class="chat-windows"></div>
	<!-- ============================================================== -->
	<!-- All Jquery -->
	<!-- ============================================================== -->
	<script src="/assets/libs/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap tether Core JavaScript -->
	<script src="/assets/libs/popper.js/dist/umd/popper.min.js"></script>
	<script src="/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- apps -->
	<script src="/dist/js/app.min.js"></script>
	<script src="/dist/js/app.init.dark.js"></script>
	<script src="/dist/js/app-style-switcher.js"></script>
	<!-- slimscrollbar scrollbar JavaScript -->
	<script src="/assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
	<script src="/assets/extra-libs/sparkline/sparkline.js"></script>
	<!--Wave Effects -->
	<script src="/dist/js/waves.js"></script>
	<!--Menu sidebar -->
	<script src="/dist/js/sidebarmenu.js"></script>
	<!--Custom JavaScript -->
	<script src="/dist/js/custom.js"></script>
	<!-- This Page JS
	<script src="/assets/libs/chartist/dist/chartist.min.js"></script>
	-->
	<script src="/assets/extra-libs/c3/d3.min.js"></script>
	<script src="/assets/extra-libs/c3/c3.min.js"></script>
	<script src="/assets/libs/raphael/raphael.min.js"></script>
	<script src="/assets/libs/morris.js/morris.min.js"></script>
<!-- 	<script src="/dist/js/pages/dashboards/dashboard1.js"></script> -->
	<script src="/assets/libs/moment/min/moment.min.js"></script>
	<script src="/assets/libs/fullcalendar/dist/fullcalendar.min.js"></script>
	<script src="/dist/js/pages/calendar/cal-init.js"></script>
	<script src="/assets/extra-libs/toastr/dist/build/toastr.min.js"></script>

	</head>
	<body>

		<div class="preloader">
			<div class="lds-ripple">
				<div class="lds-pos"></div>
				<div class="lds-pos"></div>
			</div>
		</div>

		<div id="main-wrapper">
			<tiles:insertAttribute name="header"/>
			<div class="page-wrapper">
				<tiles:insertAttribute name="body" />
			</div>
		</div>

	</body>
</html>