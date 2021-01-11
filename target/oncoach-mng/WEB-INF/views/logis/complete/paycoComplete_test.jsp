<%--
  Created by IntelliJ IDEA.
  User: jeonseungcheol
  Date: 2020/11/25
  Time: 4:37 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>물류 공유해 : 결제</title>

    <meta content="user-scalable=no, width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0"
          name="viewport">

    <%-- Reset CSS --%>
    <%--    <link rel="stylesheet" href="/css/reset.css">--%>

    <%-- Bootstrap, JQuery Library --%>
    <script src="/assets/libs/jquery/dist/jquery.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>

    <%--    <link rel="stylesheet" href="/css/content_logis.css">--%>

    <script src='/js/nprogress.js'></script>
    <link rel='stylesheet' href='/css/nprogress.css'/>

    <script type="text/javascript">
    var orderNo ="";
	var orderCertifyKey ="";orderCertifyKey
	var cancelTotalAmt ="";
	var reserveOrderNo ="";
	var sellerOrderReferenceKey ="";
	var approvalCode ="";
	var totalCancelPossibleAmt="";
        $(document).ready(function () {
            // actionType();

            $("#btnHome").click(function (key) {
                location.href = "/user/warehouse/paycoTest";
            });
            
            $.ajax({
    			type: "POST",
    			url: "/user/pay/getApproval",
    			data: {
    				
    			},
    			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    			dataType:"json",
    			success:function(data){
    				console.log(data.approvalInfo);
    				orderNo =data.approvalInfo.orderNo;
    				orderCertifyKey =data.approvalInfo.orderCertifyKey;
    		    	cancelTotalAmt =data.approvalInfo.totalPaymentAmt;
    		    	reserveOrderNo =data.approvalInfo.reserveOrderNo;
    		    	sellerOrderReferenceKey =data.approvalInfo.sellerOrderReferenceKey;
    		    	approvalCode=data.approvalInfo.approvalCode;
    		    	totalCancelPossibleAmt=data.approvalInfo.totalCancelPossibleAmt;
    		    	
    			},
    	        error: function(request,status,error) {
    	            //에러코드
    	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    	            return false;
    	        }
    		});
        });

        function cancel_order_all_test(){
    		// 선택박스 필수 옵션을 체크 함
    		if( orderNo	== null)	{ alert( '주문 번호를 입력해주세요. '+ approvalCode); 		return false; }
    		if( orderCertifyKey == null)	{ alert( '주문 인증 Key를 입력해주세요. '+ approvalCode ); 	return false; }
    		if(cancelTotalAmt ==null)	{ alert( '취소할 총 금액을 입력해주세요. ' + approvalCode); 	return false; }

    	    // 선택박스 필수 옵션을 체크 함
    	    var Params = "cancelType=ALL"
    				   + "&orderNo="
    				   + orderNo
    				   + "&orderCertifyKey="
    		   		   + orderCertifyKey
    				   + "&cancelTotalAmt="
    				   + cancelTotalAmt
    				   +"&totalCancelPossibleAmt="
    				   +totalCancelPossibleAmt;
    				      
    		// localhost 로 테스트 시 크로스 도메인 문제로 발생하는 오류
    	    $.support.cors = true;
    		
    		/* + "&" + $('order_product_delivery_info').serialize() ); */
    		$.ajax({
    			type: "POST",
    			url: "/user/pay/payco_cancel",
    			data: Params,
    			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    			dataType:"json",
    			success:function(data){
    				console.log(data);
    				if(data.code == '0') {
    					alert("주문이 정상적으로 취소되었습니다.\n( 주문취소번호 : "+data.result.cancelTradeSeq+" )");
    					$("#totalCancelPossibleAmt_all").val(data.result.remainCancelPossibleAmt);
    				} else {
    					alert("code:"+data.code+"\n"+"message:"+data.message);
    				}
    			},
    	        error: function(request,status,error) {
    	            //에러코드
    	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    	            return false;
    	        }
    		});
    	}
    	
    	function receipt_go(){
    		
    		if(orderNo==null){
    			alert("주문번호를 입력해주세요.");		
    			return;
    		}
    		
    		var orderurl = "https://alpha-bill.payco.com/outseller/receipt/"+orderNo+"?receiptKind="+$(".payco input:radio[name=receipt]:checked").val();
    		alert(orderurl);
    		window.open(orderurl, 'receipt_pop','scrollbars=yes');
    	}	
    	
    	function verifyPayment() {
    		// 선택박스 필수 옵션을 체크 함
    		if( reserveOrderNo == null) 			{	alert( 'PAYCO 주문예약번호를 입력해주세요.' );     				return false;	}
    		if(sellerOrderReferenceKey == null )	{   alert( '외부가맹점에서 발급하는 주문연동키를 입력해주세요.' );	return false;	}

    		// 전송 파라미터
    		var Params = "reserveOrderNo="
    			   		+ reserveOrderNo
    			   		+ "&sellerOrderReferenceKey="
    			   		+ sellerOrderReferenceKey;

    		// localhost 로 테스트 시 크로스 도메인 문제로 발생하는 오류
    	    $.support.cors = true;
    		
    	    $.ajax({
    			type: "POST",
    			url: "/user/pay/payco_verifyPayment",
    			data: Params,
    			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    			dataType:"json",
    			success:function(data){
    				$("#show_verifyPayment").html('<pre style="background-color: #f5deb3">' + JSON.stringify(data,null,'\t') + '</pre>');
    			},
    	        error: function(request,status,error) {
    	            //에러코드
    	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    				return false;
    	        }
    		});

    	}
    </script>
    <style>
        body {
            background-color: #999999;
        }

        #wrap {
            width: 720px;
            margin: 0 auto;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .div-center-box {
            display: flex;
            width: 60%;
            height: 20vh;
            flex-direction: column;
            background-color: white;
            align-items: center;
            justify-content: space-between;
        }

        .span-paying {
            font-size: 2.5rem;
            font-weight: 800;
        }

        .btn-main {
            width: 100%;
            border: 0;
            border-radius: 0;
            background-color: #0E2F91;
            color: white;
            padding: 0.9rem;
        }

        .btn-main:hover {
            color: black;
        }

        .div-complete-box {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            text-align: center;
            height: 80%;
        }
    </style>
</head>
<body>
<div id="wrap" style="background-color:white;">
    <div class="div-center-box">
        <div class="div-complete-box">
            <span class="span-paying">결제 완료</span>
        </div>
        <div style="width:100%; height: 20%; text-align: end;">
            <input id="btnHome" type="button" class="btn btn-main" value="메인으로">
        </div>
        
        <span class="input-group-btn " style="position:absolute; top:10%;">
			<button id="order_cancel_all__btn" class="btn btn-primary" type="button" onclick="cancel_order_all_test();">
				결제 취소
			</button>
			<br>
			<li style="margin:20px 0;">
						<em>결제수단</em>
						<div class="input-group">
							<span style= "margin-right: 3px;"><input type="radio"  value="cash" name="receipt"> <label for="pay01">현금영수증</label></span>
							<span style= "margin-right: 3px;"><input type="radio"  value="online" name="receipt"><label for="pay02">온라인영수증</label></span>	
							<span style= "margin-right: 3px;"><input type="radio"  value="card" name="receipt" checked><label for="pay03">신용카드매출전표</label></span>	
							<span class="input-group-btn">
								<button id="order_mile_cancel_btn" class="btn btn-primary" type="button" onclick="receipt_go();">GO</button>
							</span>
						</div>
					</li>
			<br>
			<span class="glyphicon glyphicon-menu-down" aria-hidden="true">결제 상세 조회</span>
				<ul style="border-bottom:none;">
					<li style="margin:20px 0;">
						<div class="input-group">
							<span class="input-group-btn">
								<button id="verifyPayment_btn" class="btn btn-primary" type="button" onclick="verifyPayment();">결제 상세 조회</button>
							</span>
						</div>
					</li>
				<li><div id="show_verifyPayment" ></div></li>
				</ul>
		</span>
    </div>
</div>
</body>
</html>
