<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common_include.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0.5,maximum-scale=2.0,user-scalable=yes">
<title>간편결제(pay2) 테스트페이지</title>
<script type="text/javascript" src="https://static-bill.nhnent.com/payco/checkout/js/payco.js" charset="UTF-8"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script type="text/javascript">

function order(){
    
	var customerOrderNumber = randomStr();
	
	var Params = {"customerOrderNumber":customerOrderNumber};

    // localhost 로 테스트 시 크로스 도메인 문제로 발생하는 오류
    $.support.cors = true;

	/* + "&" + $('order_product_delivery_info').serialize() ); */
	$.ajax({
		type: "POST",
		url: "/user/pay/payco_reserve",
		data: Params,		// JSON 으로 보낼때는 JSON.stringify(customerOrderNumber)
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType:"json",
		success:function(data){
			console.log(data.linkedHashMap);
			if(data.linkedHashMap.code == '0') {
				//console.log(data.result.reserveOrderNo);
				document.location.href = data.linkedHashMap.result.orderSheetUrl;
				//window.open(data.result.orderSheetUrl, 'popupPayco', 'top=100, left=300, width=727px, height=512px, resizble=no, scrollbars=yes'); 
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
}

//외부가맹점의 주문 관리번호 얻기
function randomStr(){
	
	var randomStr = "";
	
	for(var i=0;i<10;i++){
		randomStr += Math.ceil(Math.random() * 9 + 1);
	}
	
	randomStr = "TEST" + randomStr;
	
	return randomStr;
}

</script>
</head>
<body onLoad="order()"></body>
</html>