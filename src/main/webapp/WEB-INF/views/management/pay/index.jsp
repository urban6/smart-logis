<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>
<%@ include file="common_include.jsp" %>



<link href="../../../share/css/common.css" rel="stylesheet" type="text/css">

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!--
<script src="/share/js/requirejs/require.js"></script>
<script src="/share/js/requirejs/require.config.js"></script>
-->
<script type="text/javascript" src="https://static-bill.nhnent.com/payco/checkout/js/payco.js" charset="UTF-8"></script>

<script type="text/javascript">
$( document ).ready( function(){

	//TODO 체크박스 체크 되어 있을때 +/- 누르면 총액 바뀌게 수정해야함
	$(".btn").click(function(){
		var btnId = $(this).attr("id");
		if(btnId == "btnMinus"){											//상품수량 줄이기
			var quantityNow = $(this).parent().children("p").text();
			if(quantityNow > 0){
				quantityNow -= 1;	
			}else{
				quantityNow = 0;
			}
			$(this).parent().children("p").text(quantityNow);
		}else{																//상품수량 늘리기
			var quantityNow = parseInt($(this).parent().children("p").text());
			if(quantityNow < 999){
				quantityNow += 1;	
			}else{
				quantityNow = 999;
			}
			$(this).parent().children("p").text(quantityNow);
		}
		
		//상품금액, 수량 받아서 곱해서 주문금액에 넣어주기
		var price = $(this).closest("tr").find("#productUnitPrice").text();
		var quantity = $(this).closest("tr").find("#orderQuantity").text();
		var productPaymentPrice = price*quantity;
		$(this).closest("tr").find("#productPaymentPrice").text(productPaymentPrice);

	});
	
	$("input[name='chk']").click(function(){
		var totalOrderAmt = parseInt($("#totalOrderAmt").text());
		var delevertFeeAmt = parseInt($("#deleveryFeeAmt").text());
		var totalPrice = parseInt($("#totalPaymentAmt").text());
		var productPrice = parseInt($(this).closest("tr").find("#productPaymentPrice").text());
		console.log(productPrice);
		
		if($("#productCheck").is(":checked")){
			totalOrderAmt += productPrice; 	
			console.log(totalOrderAmt);
		}else{
			totalOrderAmt -= productPrice;
			console.log(totalOrderAmt);
		}
		$("#totalOrderAmt").text(totalOrderAmt);
		totalPrice = totalOrderAmt + delevertFeeAmt;
		$("#totalPaymentAmt").text(totalPrice);
	});
	
	$("tr").click(function(){
		/* 
	
					
		
		
		$(this).find("input:checkbox").each(function(){
			if(this.checked){
				this.checked=false;
				totalOrderAmt = totalOrderAmt- productPaymentPrice;
				$("#totalOrderAmt").text(totalOrderAmt);
			}else{
				this.checked=true;
				totalOrderAmt = totalOrderAmt+productPaymentPrice;
				$("#totalOrderAmt").text(totalOrderAmt);
			}
			totalPrice = totalOrderAmt + delevertFeeAmt;
			$("#totalPaymentAmt").text(totalPrice);
		});
		 */
	});
/* 	
	// 전체 체크박스 누르면 다 눌림
	$("#checkAll").click(function(){
		if($("#checkAll").is(":checked")){
			$(".chk").prop("checked",true);
		}else{
			$(".chk").prop("checked",false);
		}
	});
	
	// 전체 눌린 상태에서 하나 빼면 전체도 빠짐
	$(".chk").click(function(){
		var checkLength = $("input[name='chk']").length
		if($("input[name='chk']:checked").length == checkLength){
			$("#checkAll").prop("checked",true);
		}else{
			$("#checkAll").prop("checked",false);
		}
	});
		 */
	
})

function totlaPrice(){
	$("input[name='chk']").click(function(){
		var totalOrderAmt = parseInt($("#totalOrderAmt").text());
		var delevertFeeAmt = parseInt($("#deleveryFeeAmt").text());
		var totalPrice = parseInt($("#totalPaymentAmt").text());
		var productPrice = parseInt($(this).closest("tr").find("#productPaymentPrice").text());
		console.log(productPrice);
		
		if($("#productCheck").is(":checked")){
			totalOrderAmt += productPrice; 	
			console.log(totalOrderAmt);
		}else{
			totalOrderAmt -= productPrice;
			console.log(totalOrderAmt);
		}
		$("#totalOrderAmt").text(totalOrderAmt);
		totalPrice = totalOrderAmt + delevertFeeAmt;
		$("#totalPaymentAmt").text(totalPrice);
	});
}

// 주문예약 validation check
function order_chk(){
	
	if($(".payco input:radio[name=sort]:checked").val() == null){
		alert("결제방식을 선택하세요.");		
		return;
	}else{
		if($(".payco input:radio[name=sort]:checked").val() == "payco"){
			callPaycoUrl();
			return;
		}else{
			alert($(".payco input:radio[name=sort]:checked").val());
			return;
		}	
	}
}


//외부가맹점의 주문 관리번호 얻기
function randomStr(){
	
	var randomStr = "";
	
	for(var i=0;i<10;i++){
		randomStr += Math.ceil(Math.random() * 9 + 1);
	}
	
	randomStr = "TEST" + randomStr;
	console.log(randomStr);
	return randomStr;
}

// 주문예약
function callPaycoUrl(){
	
  	var customerOrderNumber = randomStr();
	
  	var Params ="customerOrderNumber=" + customerOrderNumber;
  	
	
	//check 누른 곳만 productId 와 수량 보냄
	$("input[name='chk']:checked").each(function(){
		//Params = $(this).closest('tr').prop("id");
		Params += "&productKey="+$(this).closest('tr').prop("id");
		Params += "&orderQuantity="+$(this).closest("tr").find("#orderQuantity").text();
	});
	console.log(Params);
    // localhost 로 테스트 시 크로스 도메인 문제로 발생하는 오류 
    $.support.cors = true;

	/* + "&" + $('order_product_delivery_info').serialize() ); */
	$.ajax({
		type: "POST",
		url: "/user/pay/payco_reserve",
		data: Params ,		// JSON 으로 보낼때는 JSON.stringify(customerOrderNumber)   Params
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType:"json",
		success:function(data){
			    console.log(data.linkedHashMap);
			if(data.linkedHashMap.code == '0') {
				//console.log(data.result.reserveOrderNo);
				alert("주문예약 성공! \n결제를 진행해 주세요!");
				$('#order_num').val(data.linkedHashMap.result.reserveOrderNo);
				$('#order_url').val(data.linkedHashMap.result.orderSheetUrl);
				$('#order_sellerOrderReferenceKey').val(customerOrderNumber);
			}else{
				alert("code : " + data.linkedHashMap.code + "\n" + "message : " + data.linkedHashMap.message);
			}
		},
        error: function(request,status,error) {
            //에러코드
            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			return false;
        }
	});
}

// 결제하기
function order(){
	
	var order_Url = $('#order_url').val(); 
	
	if(order_Url == ""){
		alert(" 주문예약이 되어있지 않습니다. \n 주문예약을 먼저 실행 해 주세요.");
		return;
	}
	
	if(true){
		location.href = order_Url;
	}else{
		console.log("open");
		window.open(order_Url, 'popupPayco', 'top=100, left=300, width=727px, height=512px, resizble=yes, scrollbars=yes'); 
	}
}


// 팝업차단시 차단메시지 안뜨고 열리게 하는 방법
function payco_direct_open(){
	
	var Params = "customerOrderNumber="+randomStr();
	window.open("/user/pay/payco_popup?"+Params, 'popupPayco', 'top=100, left=300, width=727px, height=512px, resizble=no, scrollbars=yes');

}

</script>

<style type="text/css">
	#sort {
		width:13px; 
		height:13px; 
		margin:0 0 2px; 
		padding:0; 
		border: 1px solid #FFF; 
		vertical-align:middle;
	}
</style>

<body>

<div id="header">
	<div class="gnb" id="gognb">
		<div class="wrap">
			<ul class="gognb" >
				<li><h3>간편결제(EASYPAY - PAY2)</h3></li>
			</ul>
		</div>
	</div>
</div>
	
<div id="container" class="clearfix">
	<div class="main_fix_wrap easyPay_wrap">
		<table cellspacing="0" cellpadding="0" class="tbl_std">
			<colgroup>
				<col width="5%">
				<col width="9%">
				<col width="51%">
				<col width="10%">
				<col width="10%">
				<col width="15%">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" id="checkAll"></th>
					<th colspan="2" class="fst left">상품정보</th>
					<th>수량</th>
					<th>상품금액</th>
					<th>주문금액</th>
				</tr>
			</thead>
			<tbody>
				 <c:forEach items="${productInfo}" var="product" varStatus="status1Depth">
					<tr id="${ product.sellerOrderProductReferenceKey}" value="1">
						<td>
							<input type="checkbox" class="chk" name="chk" id="productCheck">
							<input type="hidden" name="productId" value="${product.productId }">
						</td>
						<td class="fst">
							<img src="${product.productInfoUrl }" alt="" width="80" height="80">
						</td>
						<td class="left">
							<p id="productName">${product.productName }</p>
							<p>${product.option }</p>
						</td>
						<td class="">
							<p id="orderQuantity" name="orderQuantity">1</p>
							<div class="btn btn-primary btn-sm" id="btnMinus">-</div>
							<div class="btn btn-primary btn-sm" id="btnPlus">+</div>
							
						</td>
						<td>
							<span id="productUnitPrice">${product.productPaymentAmt } </span><span>원</span>
						</td>
						<td class="bg_sum txt_sum text_bold"><span  id="productPaymentPrice">${product.productPaymentAmt } </span><span>원</span></td>
					</tr>
				
				</c:forEach>
				
				
				
				<tr>
					<td class="fst left" colspan="4">
						
					</td>
					<td colspan="2" class="bg_total left">
						<ul class="total_wrap">
							<li><p>총상품금액</p><strong><span id="totalOrderAmt">0</span><span>원</span></strong></li>
							<li><p>배송비</p><strong><span id="deleveryFeeAmt">0</span><span>원</span></strong></li>
							<li><p>결제금액</p><strong><span class="point" id="totalPaymentAmt">0</span><span>원</span></strong></li>
						</ul>
					</td>
				</tr>
				
			</tbody>
		</table>

		<div style="height:30px;"></div>
		<table cellspacing="0" cellpadding="0" class="save_point_wrap">
			<colgroup>
				<col width="78%">
				<col width="22%">
			</colgroup>
			
			<tbody>
				<tr>
					<td>
						<!-- s:안내 -->
						<table cellspacing="0" cellpadding="0" class="save_point">
							<colgroup>
								<col width="20%">
								<col width="80%">
							</colgroup>
							<tbody>
								<tr>
									<th class="underline">결제방식</th>
									<td class="left underline"> 
										<div class="payco" style="text-align: left;">
											<span><input type="radio"  value="신용카드 결제" name="sort" id="sort"><label for="pay01">신용카드 결제</label></span>
											<span style= "margin-left: 3px;"><input type="radio"  value="가상 계좌" name="sort" id="sort"><label for="pay02">가상 계좌</label></span>	
											<span style= "margin-left: 3px;"><input type="radio"  value="휴대폰 결제" name="sort" id="sort"><label for="pay03">휴대폰 결제</label></span>	
											<span style= "margin-left: 3px;"><input type="radio"  value="payco" name="sort" id="sort" checked="checked"></span><span id="payco_btn_type_A1" style="padding-left: 3px;"></span>	
										</div>
									</td>
								</tr>
	
								<!-- PAYCO 안내 -->
								<tr id="div_toastpay" class="pay_detail"
									style="height: 148px">
									<th>PAYCO</th>
									<td class="left">
										<ul>
											<li><font color="red"><strong>PAYCO 간편결제 안내</strong></font></li>
											<li>PAYCO는 온/오프라인 쇼핑은 물론 송금, 멤버십 적립까지 가능한 통합 서비스입니다.</li>
											<li>- 지원카드: 모든 국내 신용/체크카드</li>
										</ul>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
		<table align="center" style="margin-top:50px;" >
			<tr>
				<td style="padding:30px; border:solid 1px;" valign="Top">
					<div class="easyPay_div">주문예약, 결제하기 분리</div>
					<div class="easyPay_div"><button type="button" class="btn easyPay_btn"  onclick="order_chk();" >주문예약실행</button> </div>
					<div class="easyPay_div">
						<ul>
							<li style="margin:20px 0;">
								<em>가맹점 주문번호 </em>
								<input type="text" class="form-control input_text" name="order_sellerOrderReferenceKey" id="order_sellerOrderReferenceKey" value=""  >
							</li>
							<li style="margin:20px 0;">
								<em>예약주문번호 </em>
								<input type="text" class="form-control input_text" name="order_num" id="order_num" value=""  >
							</li>
							<li>
								<em>주문창URL </em>
								<input type="text" class="form-control input_text" name="order_url" id="order_url" value=""  >
							</li>
						</ul>
					</div>	
					<div class="easyPay_div"><button type="button" class="btn easyPay_btn"  onclick="order();" >결제하기( PC-팝업, MOBILE-리다이렉트 )</button> </div>
				</td>
				<td width="50" style="padding:10px;">
				</td>
				<td style="padding:30px; border:solid 1px;" valign="Top">
					<div class="easyPay_div">팝업차단시 차단메시지 안뜨고 열리게 하는 방법 </div>
					<div class="easyPay_div"><button type="button" class="btn easyPay_btn"  onclick="payco_direct_open();" >결제하기(팝업차단 후 클릭)</button> </div>
				</td>
			</tr>
		</table>
	</div>
	<div style="height:100px"></div>
</div>
	
<script type="text/javascript">
	  Payco.Button.register({
		SELLER_KEY:'S0FSJE',
		ORDER_METHOD:"EASYPAY",
		/* ORDER_METHOD:"CHECKOUT", */
		BUTTON_TYPE:"A1",
		BUTTON_HANDLER:order,
		DISPLAY_PROMOTION:"Y",
		DISPLAY_ELEMENT_ID:"payco_btn_type_A1",
		"":""
	  });
	  
	  
</script>
</body>

