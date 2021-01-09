<%--
  Created by IntelliJ IDEA.
  User: jeonseungcheol
  Date: 2020/11/05
  Time: 10:01 오전
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>물류 공유해 : 창고 상세조회</title>

    <meta content="user-scalable=no, width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0"
          name="viewport">

    <%-- Reset CSS --%>
    <link rel="stylesheet" href="/css/reset.css">

    <%-- Bootstrap, JQuery Library --%>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <script src="/assets/libs/jquery/dist/jquery.min.js"></script>
    <script src="/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
			$("#btnCancel").click(function(){
				payCancel();
			});
        });
function payCancel(){
        	
     $.ajax({
      type: "POST",
      url: "/user/pay/getApproval",
      data: {
     	 "orderInfoUid":"${info.orderInfoUid}"
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
         //결제 취소
         cancel_order_all(orderNo,orderCertifyKey,cancelTotalAmt,totalCancelPossibleAmt,sellerOrderReferenceKey);
      },
      error: function(request,status,error) {
            //에러코드
        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        return false;
      }
   });
}
        
        function cancel_order_all(orderNo,orderCertifyKey,cancelTotalAmt,totalCancelPossibleAmt){
            var Params = "cancelType=ALL"
                    + "&orderNo="
                    + orderNo
                    + "&orderCertifyKey="
                       + orderCertifyKey
                    + "&cancelTotalAmt="
                    + cancelTotalAmt
                    +"&totalCancelPossibleAmt="
                    +totalCancelPossibleAmt
                    +"&sellerOrderReferenceKey="
                    +sellerOrderReferenceKey;
                       
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
    </script>
    <style>
        @font-face {
            font-family: 'gimhae-font-regular';
            src: url('../../../../fonts/GimhaeGayaR.ttf');
        }

        body {
            font-family: 'gimhae-font-regular', serif !important;
        }

        #wrap {
            width: 720px;
            background-color: white;
            margin: 0 auto;
        }

        /* 화면 너비 0 ~ 768px */
        @media (max-width: 768px) {
            #wrap {
                width: 100%;
            }
        }

        .header {
            height: 7vh;
            width: 100%;
            background: url('/images/BG_3.png');
            display: table;
            align-content: center;
            justify-content: center;
        }

        .header-title {
            color: white;
            font-size: 1.5rem;
            text-align: center;
            display: table-cell;
            vertical-align: middle;
        }

        .section {
            width: 95%;
            margin: 0 auto;
            
        }

        table {
            width: 100%;
            padding: 10px 10px 16px 20px;
        }

        table, th {
            
        }
		.table-top {
            padding: 18px 30px 15px;
            border-top: 4px solid #00876c;
            background: #f2f2f2;
        }
        .table-top {
            /*padding: 18px 30px 15px 0;*/
            padding: 18px 30px 15px;
            border-top: 4px solid #00876c;
            border-bottom: 1px solid lightgrey;
            background: #f2f2f2;
            text-align: center;
            border-right: 1px solid lightgrey;
        }
        thead {
            display: table-header-group;
        }

        td {
            padding: 2% 2% 2% 2%;
            border: 1px solid #e3e3e3;
            font-size: small;
        }

        .form-table {
            margin-top: 4%;
            margin-bottom: 56px;
        }

        label {
            font-size: large;
        }

        .form-title {
            font-size: 1.3em;
        }

        .form-value {
            font-size: 1.2em;
        }

        .div-result {
            border-top: 1px solid lightgrey;
            margin-top: 5%;
            padding: 2% 0 0 2%;
            margin-bottom: 5%;
        }

        .div-lightgray {
            background-color: #f2f2f2;
        }

        p {
            margin: 0;
        }
    </style>
</head>
<body>
<div class="header">
    <span class="header-title">창고 상세 조회</span>
</div>
<div id="wrap">
    <div class="section">
        <div class="form-table">
        	<h5>예약 정보</h5>
            <table>
                <colgroup>
                    <col style="width: 25%">
                    <col style="width: 25%">
                    <col style="width: 25%">
                    <col style="width: 25%">
                </colgroup>
                <thead>
                </thead>
                <tbody>
                <tr>
                    <td class="div-lightgray">
                        <strong class="form-title">번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${info.orderInfoUid}"/></span>
                    </td>
                    <td class="div-lightgray">
                        <strong class="form-title">접수날짜</strong>
                    </td>
                    <td>
                        <strong class="form-value">
                            <c:out value="${info.requestTime}"/>
                        </strong>
                    </td>
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">창고 대여 기업</strong>
                    </td>
                    <td colspan="3">
                        <span class="form-value"><c:out value="${info.companyName}"/></span>
                    </td>
                </tr>
                <tr>
                    <td class="div-lightgray">
                        <strong class="form-title">담당자</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${info.managerName}"/></span>
                    </td>
                    <td class="div-lightgray">
                        <strong class="form-title">전화번호</strong>
                    </td>
                    <td>
                        <strong class="form-value">
                            <c:out value="${info.phoneNumber}"/>
                        </strong>
                    </td>
                </tr>
                
                <tr>
                    <td class="div-lightgray">
                        <strong class="form-title">대여기간</strong>
                    </td>
                    <td colspan="3">
                        <span class="form-value"><c:out value="${info.startTime} ~ ${info.endTime}"/></span>
                    </td>
                </tr>
                <tr>
                    <td class="div-lightgray">
                        <strong class="form-title">결제금액</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${info.price}"/>원</span>
                    </td>
                    <td class="div-lightgray">
                        <strong class="form-title">상태</strong>
                    </td>
                    <td>
                        <c:choose>
                            	<c:when test="${info.status == 0}">
                                    <p>결제대기</p>
                                </c:when>
                                <c:when test="${info.status == 1}">
                                    <p>결제완료</p>
                                </c:when>

                                <c:when test="${info.status == 2}">
                                    <p>상품인수</p>
                                </c:when>
                                <c:when test="${info.status == 3}">
                                    <p>입고</p>
                                </c:when>
                                <c:when test="${info.status == 4}">
                                    <p>부분 출고</p>
                                </c:when>
                                <c:when test="${info.status == 5}">
                                    <p>출고</p>
                                </c:when>
                                <c:when test="${info.status == 6}">
                                    <p>기간만료</p>
                                </c:when>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <td class="div-lightgray">
                        <strong class="form-title">결제방법</strong>
                    </td>
                    <td>
                        <c:choose>
                            	<c:when test="${info.payType == 'P'}">
                                    <p>간편결제</p>
                                </c:when>
                                <c:when test="${info.payType == 'Z'}">
                                    <p>제로페이</p>
                                </c:when>
                        </c:choose>
                    </td>
                    <td class="div-lightgray">
                        <strong class="form-title">공간크기</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${info.size}"/>개</span>
                    </td>
                </tr>
                </tbody>
            </table>
            <%-- 하단에서 택배를 신청하고 취소할 수 있는 버튼 --%>
            <div class="div-result" >
                    <input id="btnCancel" type="button" class="btn btn-outline-danger" value="취소하기"
                           style="width: 45%; float:right;">
            </div>
        </div>
        
        
    </div>
</div>
<div class="section">
        	<h5>물품 정보</h5>
        	<table id="list">
                <colgroup>
                    <col style="width: 15%">
                    <col style="width: 20%">
                    <col style="width: 15%">
                    <col style="width: 15%">
                    <col style="width: 10%">
                </colgroup>
                <thead>
                <tr>
                    <th scope="row" colspan="1" class="pl-0 pr-0">
                        <div class="table-top" style="border-left: 1px solid lightgrey;">
                            <strong class="form-title">위치 No</strong>
                        </div>
                    </th>
                    <th scope="row" colspan="1" class="pl-0 pr-0">
                        <div class="table-top">
                            <strong class="form-title">상품정보</strong>
                        </div>
                    </th>
                    <th scope="row" colspan="1" class="pl-0 pr-0">
                        <div class="table-top">
                            <strong class="form-title">입고날짜</strong>
                        </div>
                    </th>
                    <th scope="row" colspan="1" class="pl-0 pr-0">
                        <div class="table-top">
                            <strong class="form-title">출고날짜</strong>
                        </div>
                    </th>
                    <th scope="row" colspan="1" class="pl-0 pr-0">
                        <div class="table-top">
                            <strong class="form-title">상태</strong>
                        </div>
                    </th>
                    <th scope="row" colspan="1" class="pl-0 pr-0">
                        <div class="table-top">
                            <strong class="form-title">RFID번호</strong>
                        </div>
                    </th>
                </tr>
                </thead>
                
                <tbody>
                <c:forEach var="data" items="${itemList}">
                    <tr>
                        <td>
                            <p><c:out value="${data.spaceName}"/></p>
                        </td>
                        <td>
                            <p><c:out value="${data.itemInfo}"/></p>
                        </td>

                        <td>
                            <p style="white-space: pre-line"><c:out value="${data.inDate}"/></p>
                        </td>
                        <td>
                            <p style="white-space: pre-line"><c:out value="${data.outDate}"/></p>
                        </td>
                        
                        <td>
                            <c:choose>
                                <c:when test="${data.state == 0}">
                                    <p>입고전</p>
                                </c:when>

                                <c:when test="${data.state == 1}">
                                    <p>입고</p>
                                </c:when>
                                <c:when test="${data.state == 2}">
                                    <p>출고</p>
                                </c:when>
                                <c:otherwise>
                                	<p>기타</p>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <p><c:out value="${data.rfidUid}"/></p>
                        </td>
                        
                    </tr>

                </c:forEach>
                </tbody>
            </table>
            <%-- 하단에서 택배를 신청하고 취소할 수 있는 버튼 --%>
            <div class="div-result" style="display: none;">
                <c:if test="${info.status < 1}">
                    <input id="btnCancel" type="button" class="btn btn-outline-danger" value="취소하기"
                           style="width: 45%; float:right;">
                </c:if>
            </div>
        </div>
</body>
</html>
