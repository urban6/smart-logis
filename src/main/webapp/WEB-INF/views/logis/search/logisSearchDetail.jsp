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
    <title>물류 공유해 : 택배 상세조회</title>

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
            // 물류 신청하기
            $("#btnCancel").click(function (key) {
                // const status = ${info.status};
                if (${info.status} === 0) {
                    alert("취소 가능");
                }
            });

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
            width: 100%;
            height: 92vh;
            padding-top: 5%;
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

        p {
            margin: 0;
        }

        .form-table {
            margin-top: 2%;
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
            margin-top: 3%;
            padding: 2% 0 0 2%;
            margin-bottom: 3%;
        }

        .div-lightgray {
            background-color: #f2f2f2;
        }

        .span-sub-title {
            font-size: 2.0rem;
        }
    </style>
</head>
<body>
<div class="header">
    <span class="header-title">물류 배송 상세 조회</span>
</div>
<div id="wrap">
    <div class="section">
        <div>
            <span class="span-sub-title">기본정보</span>
        </div>
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
                    <td class="div-lightgray">
                        <strong class="form-title">보내는분</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${info.senderName}"/></span>
                    </td>
                    <td class="div-lightgray">
                        <strong class="form-title">발송날짜</strong>
                    </td>
                    <td>
                        <strong class="form-value">
                            <c:choose>
                                <c:when test="${not empty info.startTime}">
                                    <p><c:out value="${info.startTime}"/></p>
                                </c:when>

                                <c:when test="${empty info.startTime}">
                                    <p>-</p>
                                </c:when>
                            </c:choose>
                        </strong>
                    </td>
                </tr>
                <tr>
                    <td class="div-lightgray">
                        <strong class="form-title">받는분</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${info.receiverName}"/></span>
                    </td>
                    <td class="div-lightgray">
                        <strong class="form-title">수신날짜</strong>
                    </td>
                    <td>
                        <strong class="form-value">
                            <c:choose>
                                <c:when test="${not empty info.arriveTime}">
                                    <p><c:out value="${info.arriveTime}"/></p>
                                </c:when>

                                <c:when test="${empty info.arriveTime}">
                                    <p>-</p>
                                </c:when>
                            </c:choose>
                        </strong>
                    </td>
                </tr>
                <tr>
                    <td class="div-lightgray" colspan="1"><strong class="form-title">받는분 주소</strong></td>
                    <td colspan="3"><strong class="form-value"><c:out value="${info.receiverAddress}"/></strong></td>
                </tr>
                <tr>
                    <td class="div-lightgray">
                        <strong class="form-title">결재금액</strong>
                    </td>
                    <td>
                        <span class="form-value"><c:out value="${info.price}"/>원</span>
                    </td>
                    <td class="div-lightgray">
                        <strong class="form-title">상태</strong>
                    </td>
                    <td>
                        <strong class="form-value">
                            <c:choose>
                                <c:when test="${info.status == 0}">
                                    <p>접수완료</p>
                                </c:when>

                                <c:when test="${info.status == 1}">
                                    <p>결제완료</p>
                                </c:when>

                                <c:when test="${info.status == 2}">
                                    <p>담당자 배정완료</p>
                                </c:when>

                                <c:when test="${info.status == 3}">
                                    <p>상품인수</p>
                                </c:when>

                                <c:when test="${info.status == 4}">
                                    <p>배송시작</p>
                                </c:when>

                                <c:when test="${info.status == 5}">
                                    <p>배송완료</p>
                                </c:when>
                            </c:choose>
                        </strong>
                    </td>
                </tr>
                </tbody>
            </table>
            <%-- 하단에서 택배를 신청하고 취소할 수 있는 버튼 --%>
            <div class="div-result">
                <c:if test="${info.status == 0}">
                    <input id="btnCancel" type="button" class="btn btn-outline-danger" value="취소하기"
                           style="width: 45%; float:right;">
                </c:if>
            </div>
            <div>
                <span class="span-sub-title">상태정보</span>
            </div>
        </div>
    </div>
</div>
</body>
</html>
