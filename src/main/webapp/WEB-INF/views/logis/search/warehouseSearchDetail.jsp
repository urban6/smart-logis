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
            height: 92vh;
        }

        table {
            width: 100%;
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
                        <strong class="form-title">창고 공유 기업</strong>
                    </td>
                    <td colspan="3">
                        <span class="form-value"><c:out value="${info.warehouseName}"/></span>
                    </td>
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1">
                        <strong class="form-title">위치</strong>
                    </td>
                    <td colspan="3">
                        <span class="form-value"><c:out value="${info.warehouseAddress}"/></span>
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
                                <span class="form-value">접수완료</span>
                            </c:when>

                            <c:when test="${info.status == 1}">
                                <span class="form-value">결제완료</span>
                            </c:when>

                            <c:when test="${info.status == 6}">
                                <span class="form-value">기간만료</span>
                            </c:when>
                        </c:choose>
                    </td>
                </tr>
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
    </div>
</div>
</body>
</html>
