<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="kr.co.shovvel.dm.domain.logis.order.LogisDTO" %>
<%	

	LogisDTO logisDTO = (LogisDTO)request.getAttribute("logisDTO");
	
	if (logisDTO == null) {
		
		logisDTO = new LogisDTO();

	}
	
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>물류 신청 상세 내역</title>

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

        });
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
            width: 100%;
            height: 8vh;
            padding-top: 5%;
        }

        .section {
            width: 95%;
            margin: 0 auto;
            height: 92vh;
        }

        table {
            width: 110%;
            margin: auto;
        }

        table, th {
            padding: 10px 10px 16px 20px;
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
<div id="wrap">
    <div class="header">
    </div>
    <div class="section">
        <h4 style="font-weight: 400; text-align: center; font-size: 2.0em; margin-bottom: 5%">물류 신청 상세 내역</h4>
        <div class="form-table">
            <table>
                <colgroup>
                    <col style="width: 20%">
                    <col style="width: 30%">
                    <col style="width: 20%">
                    <col style="width: 30%">
                </colgroup>
                <thead>
                </thead>
                <tbody>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">물류신청번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.logisOrderUid}"/></span>
                    </td>                    
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">신청자ID</strong>
                    </td>
                    <td colspan="3">
                        <span class="form-value"><c:out value="${logisDTO.loginId}"/></span>
                    </td>
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">발송인명</strong>
                    </td>
                    <td colspan="3">
                        <span class="form-value"><c:out value="${logisDTO.senderName}"/></span>
                    </td>
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">발송인연락처</strong>
                    </td>
                    <td colspan="3">
                        <span class="form-value"><c:out value="${logisDTO.senderPhone}"/></span>
                    </td>
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">발송지우편번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.senderPostcode}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">발송지주소</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.senderAddress}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">수취인명</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.receiverName}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">수취인연락처</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.receiverPhone}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">배송지우편번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.receiverPostcode}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">배송지주소</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.receiverAddress}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">출발일시</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.startTime}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">도착일시</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.arriveTime}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">배송물류수량</strong>
                    </td>
                    <td>
                        <span class="form-value"><fmt:formatNumber value="${logisDTO.boxCount}" type="number"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">배송팔레트수량</strong>
                    </td>
                    <td>
                        <span class="form-value"><fmt:formatNumber value="${logisDTO.paletteCount}" type="number"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">희망수령일시</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.wishDeliveryDatetime}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">신청일시</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.requestTime}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">처리상태</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.status}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">가격</strong>
                    </td>
                    <td>
                        <span class="form-value"><fmt:formatNumber value="${logisDTO.price}" type="number"/>원</span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제여부</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.isPay}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제수단구분</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.payType}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">배송구분</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.logisType}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">제품구분</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.itemInfo}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">배송차량번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.logisNumber}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">가맹점주문번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.sellerOrderReferenceKey}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">승인번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.approvalUid}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제완료URL</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.orderReturnUrl}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">가맹점주문번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.orderNo}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">주문채널</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.orderChannel}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">주문금액</strong>
                    </td>
                    <td>
                        <span class="form-value"><fmt:formatNumber value="${logisDTO.totalOrderAmt}" type="number"/>원</span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제금액</strong>
                    </td>
                    <td>
                        <span class="form-value"><fmt:formatNumber value="${logisDTO.totalPaymentAmt}" type="number"/>원</span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제여부</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.paymentCompletionYn}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">주문인증키</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.orderCertifyKey}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.paymentTradeNo}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제수단코드</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.paymentMethodCode}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제수단</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.paymentMethodName}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제일시</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.tradeYmdt}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">원천사승인번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.pgAdmissionNo}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">원천사승인일시</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.pgAdmissionYmdt}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">취소여부</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.isCancel}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">환불가능금액</strong>
                    </td>
                    <td>
                        <span class="form-value"><fmt:formatNumber value="${logisDTO.totalCancelPossibleAmt}" type="number"/>원</span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">비고</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${logisDTO.cancelMemo}"/></span>
                    </td>                 
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
