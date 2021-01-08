<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="kr.co.shovvel.dm.domain.logis.order.OrderDTO" %>
<%	

	OrderDTO orderDTO = (OrderDTO)request.getAttribute("orderDTO");
	
	if (orderDTO == null) {
		
		orderDTO = new OrderDTO();

	}
	
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>주문 상세 내역</title>

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
        <h4 style="font-weight: 400; text-align: center; font-size: 2.0em; margin-bottom: 5%">주문 상세 내역</h4>
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
                        <strong class="form-title">주문번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.orderUid}"/></span>
                    </td>                    
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">주문자ID</strong>
                    </td>
                    <td colspan="3">
                        <span class="form-value"><c:out value="${orderDTO.loginId}"/></span>
                    </td>
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">가맹점주문번호</strong>
                    </td>
                    <td colspan="3">
                        <span class="form-value"><c:out value="${orderDTO.sellerOrderReferenceKey}"/></span>
                    </td>
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">가맹점ID</strong>
                    </td>
                    <td colspan="3">
                        <span class="form-value"><c:out value="${orderDTO.cpid}"/></span>
                    </td>
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">상품ID</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.productId}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">주문수량</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.orderQuantity}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">가맹점상품키</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.sellerOrderProductReferenceKey}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">상품노출순번</strong>
                    </td>
                    <td>
                        <span class="form-value"><fmt:formatNumber value="${orderDTO.sortOrdering}" type="number"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">주문일시</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.orderDate}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">주문상품번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.orderProductNo}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">주문상태코드</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.orderProductStatusCode}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">주문상태</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.orderProductStatusName}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">승인번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.approvalUid}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제완료URL</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.orderReturnUrl}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">가맹점주문번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.orderNo}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">주문채널</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.orderChannel}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">주문금액</strong>
                    </td>
                    <td>
                        <span class="form-value"><fmt:formatNumber value="${orderDTO.totalOrderAmt}" type="number"/>원</span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제금액</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.totalPaymentAmt}"/>원</span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제여부</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.paymentCompletionYn}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">주문인증키</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.orderCertifyKey}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.paymentTradeNo}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제수단코드</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.paymentMethodCode}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제수단</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.paymentMethodName}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제일시</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.tradeYmdt}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">원천사승인번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.pgAdmissionNo}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">원천사승인일시</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.pgAdmissionYmdt}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">취소여부</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.isCancel}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">환불가능금액</strong>
                    </td>
                    <td>
                        <span class="form-value"><fmt:formatNumber value="${orderDTO.totalCancelPossibleAmt}" type="number"/>원</span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">비고</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${orderDTO.cancelMemo}"/></span>
                    </td>                 
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
