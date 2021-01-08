<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="kr.co.shovvel.dm.domain.logis.order.WarehouseDTO" %>
<%	

	WarehouseDTO warehouseDTO = (WarehouseDTO)request.getAttribute("warehouseDTO");
	
	if (warehouseDTO == null) {
		
		warehouseDTO = new WarehouseDTO();

	}
	
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>창고 신청 상세 내역</title>

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
        <h4 style="font-weight: 400; text-align: center; font-size: 2.0em; margin-bottom: 5%">창고 신청 상세 내역</h4>
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
                        <strong class="form-title">창고신청번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.orderInfoUid}"/></span>
                    </td>                    
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">신청자ID</strong>
                    </td>
                    <td colspan="3">
                        <span class="form-value"><c:out value="${warehouseDTO.loginId}"/></span>
                    </td>
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">업체고유번호</strong>
                    </td>
                    <td colspan="3">
                        <span class="form-value"><c:out value="${warehouseDTO.companyUid}"/></span>
                    </td>
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">대여규격</strong>
                    </td>
                    <td colspan="3">
                        <span class="form-value"><fmt:formatNumber value="${warehouseDTO.size}" type="number"/></span>
                    </td>
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">처리상태</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.status}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">시작일시</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.startTime}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">종료일시</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.endTime}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">신청일시</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.requestTime}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">가격</strong>
                    </td>
                    <td>
                        <span class="form-value"><fmt:formatNumber value="${warehouseDTO.price}" type="number"/>원</span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제수단구분</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.payType}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제여부</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.isPay}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">가맹점주문번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.sellerOrderReferenceKey}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">창고번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.warehouseUid}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">승인번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.approvalUid}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제완료URL</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.orderReturnUrl}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">가맹점주문번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.orderNo}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">주문채널</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.orderChannel}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">주문금액</strong>
                    </td>
                    <td>
                        <span class="form-value"><fmt:formatNumber value="${warehouseDTO.totalOrderAmt}" type="number"/>원</span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제금액</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.totalPaymentAmt}"/>원</span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제여부</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.paymentCompletionYn}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">주문인증키</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.orderCertifyKey}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.paymentTradeNo}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제수단코드</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.paymentMethodCode}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제수단</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.paymentMethodName}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">결제일시</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.tradeYmdt}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">원천사승인번호</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.pgAdmissionNo}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">원천사승인일시</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.pgAdmissionYmdt}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">취소여부</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.isCancel}"/></span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">환불가능금액</strong>
                    </td>
                    <td>
                        <span class="form-value"><fmt:formatNumber value="${warehouseDTO.totalCancelPossibleAmt}" type="number"/>원</span>
                    </td>                 
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">비고</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${warehouseDTO.cancelMemo}"/></span>
                    </td>                 
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
