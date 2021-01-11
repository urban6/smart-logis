<!DOCTYPE html>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html lang="${sessionUser.language}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>물류 공유해</title>
<script src="/scripts/jquery.1.11.2.min.js"></script>
<script src="/scripts/jquery-ui.min.js"></script>
<link rel="stylesheet" href="/styles/style.css">
</head>
<script type="text/javascript">
<!--
	window.history.forward();

	$( document ).ready( function()
	{
		$( this ).contextmenu( function( e )
		{
			return false;
		} );

		//fnKeepAlive();
	} );

	var refreshId = null;

	function fnKeepAlive()
	{
		//console.log("fnKeepAlive()...");
		refreshId = setInterval( function()
		{
			var result = $.ajax( {
				url : "/common/keepAlive" ,
				type : "POST" ,
				async : false ,
				cache : false
			} );

			result.done( function( data )
			{
				console.log( data );
				if ( data == 1 )
				{ //서버 세션 잃어버림
					openAlertModal( "warning" , "<spring:message code="msg.security.sessionmanage.session.lost.text" />" , function()
					{
						fnKeepAliveEnd();
					} );
				}
				else if ( data == 2 )
				{ //유저 강제 종료
					openAlertModal( "warning" , "<spring:message code="msg.security.sessionmanage.session.force.quit.text" />" , function()
					{
						fnKeepAliveEnd();
					} );
				}
			} );

			result.fail( function( xhr, status )
			{
				fnKeepAliveEnd();
			} );

			if ( result !== null )
				result = null;

			clearInterval( refreshId );
			fnKeepAlive();

		} , 30 * 1000 );
	}

	function fnCloseConfirm()
	{
		try
		{
			var prevUrl = document.referrer;
			if ( prevUrl == "" )
				prevUrl = "/";
			var frm = document.frmReturn;
			frm.action = prevUrl;
			frm.method = "post";
			frm.target = "";
			frm.submit();
		}
		catch ( e )
		{

		}
	}
//-->
</script>
<body class="error">
	<form name="frmReturn"></form>
	<tiles:insertAttribute name="body" />
</body>
</html>