<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.xml.ws.Response"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="com.fasterxml.jackson.core.type.TypeReference" %>
<%@ page import="com.fasterxml.jackson.databind.node.ArrayNode"%>
<%@ page import="com.fasterxml.jackson.databind.JsonNode"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="kr.co.shovvel.dm.controller.management.pay.PaycoUtil" %>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.net.URLEncoder"%>
<%@ include file="common_include.jsp" %>


	
	<html>
		<head>
			<title>간편결제 PAY2</title>
		</head>
		<script type="text/javascript">
		$( document ).ready( function(){
			//결제를 진행하는 url
			var returnUrl = window.location.href.replace('return_ok','payco_return');
			console.log(returnUrl);
			var param = "returnUrl="+returnUrl;
			param=param.replace(/&/gi,"%26");
			
			$.ajax({
				type: "POST",
				url: "/user/pay/payco_update_returnUrl",
				data: param,
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType:"json",
				success:function(data){
					console.log(data);
					if(data.linkedHashMap.code == '0') {
						console.log("변경되었습니다.");
					} else {
						alert("code:"+data.linkedHashMap.code+"\n"+"message:"+data.linkedHashMap.message);
					}
				},
		        error: function(request,status,error) {
		            //에러코드
		            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					return false;
		        }
			});
			$("#returnUrlbtn").click(function(){
				location.href=returnUrl;
			});
		})
			
			
		</script>
		<body>		
			결제대기
			<button id="returnUrlbtn">결제 완료</button>
		</body>
	</html>										


