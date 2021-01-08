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
    <title>물류 공유해 : 창고 대여 조회</title>

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
            addRowHandlers();
            console.log("${infoList}");
        });

        function addRowHandlers() {
            const table = document.getElementById("list");
            const rows = table.getElementsByTagName("tr");
            for (let i = 0; i < rows.length; i++) {
                const currentRow = table.rows[i];
                const createClickHandler = function (row) {
                    return function () {
                        const cell = row.getElementsByTagName("p")[0];
                        const id = cell.innerHTML;

                        console.log(id);

                        const logisOrderUid = document.createElement("input");
                        logisOrderUid.setAttribute("name", "orderInfoUid");
                        logisOrderUid.setAttribute("value", id);

                        const form = document.createElement('form');
                        form.setAttribute('method', 'POST');
                        form.setAttribute('action', '/user/warehouse/searchDetail');
                        form.appendChild(logisOrderUid);
                        document.body.appendChild(form);
                        form.submit();
                    };
                };
                currentRow.onclick = createClickHandler(currentRow);
            }
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
            width: 1080px;
            background-color: white;
            margin: 0 auto;
        }

        /* 화면 너비 0 ~ 768px */
        @media (max-width: 768px) {
            #wrap {
                /*width: 100%;*/
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
        }

        .form-table {
            margin-top: 4%;
            margin-bottom: 56px;
        }

        .table-top {
            padding: 18px 30px 15px;
            border-top: 4px solid #00876c;
            background: #f2f2f2;
        }

        table {
            padding: 10px 10px 16px 20px;
        }

        thead {
            display: table-header-group;
        }

        td {
            cursor: pointer;
            padding: 30px 5px;
            border-bottom: 1px solid #ebebeb;
            text-align: center;
        }

        th {
            text-align: center;
        }

        .form-title {
            font-size: 1.0em;
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

        p {
            margin: 0;
        }
    </style>
</head>
<body>
<div class="header">
    <span class="header-title">내 창고 조회</span>
</div>
<div id="wrap">
    <div class="section">
        <div class="form-table">
        	<p>예약 리스트</p>
            <table id="list">
                <colgroup>
                    <col style="width: 5%">
                    <col style="width: 20%">
                    <col style="width: 30%">
                    <col style="width: 15%">
                    <col style="width: 15%">
                </colgroup>
                <thead>
                <tr>
                    <th scope="row" colspan="1" class="pl-0 pr-0">
                        <div class="table-top" style="border-left: 1px solid lightgrey;">
                            <strong class="form-title">No</strong>
                        </div>
                    </th>
                    <th scope="row" colspan="1" class="pl-0 pr-0">
                        <div class="table-top">
                            <strong class="form-title">대여 기업</strong>
                        </div>
                    </th>
                    <th scope="row" colspan="1" class="pl-0 pr-0">
                        <div class="table-top">
                            <strong class="form-title">대여기간</strong>
                        </div>
                    </th>
                    <th scope="row" colspan="1" class="pl-0 pr-0">
                        <div class="table-top">
                            <strong class="form-title">금액</strong>
                        </div>
                    </th>
                    <th scope="row" colspan="1" class="pl-0 pr-0">
                        <div class="table-top">
                            <strong class="form-title">상태</strong>
                        </div>
                    </th>
                </tr>
                </thead>
                
                <tbody>
                <c:forEach var="data" items="${infoList}">
                    <tr>
                        <td>
                            <p><c:out value="${data.orderInfoUid}"/></p>
                        </td>
                        <td>
                            <p><c:out value="${data.warehouseName}"/></p>
                        </td>

                        <td>
                            <p style="white-space: pre-line"><c:out value="${data.startTime} ~ ${data.endTime}"/></p>
                        </td>

                        <td>
                            <p><c:out value="${data.price}원"/></p>
                        </td>

                        <td>
                            <c:choose>
                                <c:when test="${data.status == 0}">
                                    <p>결제대기</p>
                                </c:when>

                                <c:when test="${data.status == 1}">
                                    <p>결제완료</p>
                                </c:when>

                                <c:when test="${data.status == 2}">
                                    <p>상품인수</p>
                                </c:when>

                                <c:when test="${data.status == 6}">
                                    <p>기간만료</p>
                                </c:when>
                            </c:choose>
                        </td>
                    </tr>

                </c:forEach>
                </tbody>
            </table>
            <br>
            <p>과거 리스트</p>
            <table id="list">
                <colgroup>
                    <col style="width: 5%">
                    <col style="width: 20%">
                    <col style="width: 30%">
                    <col style="width: 15%">
                    <col style="width: 15%">
                </colgroup>
                <thead>
                <tr>
                    <th scope="row" colspan="1" class="pl-0 pr-0">
                        <div class="table-top" style="border-left: 1px solid lightgrey;">
                            <strong class="form-title">No</strong>
                        </div>
                    </th>
                    <th scope="row" colspan="1" class="pl-0 pr-0">
                        <div class="table-top">
                            <strong class="form-title">대여 기업</strong>
                        </div>
                    </th>
                    <th scope="row" colspan="1" class="pl-0 pr-0">
                        <div class="table-top">
                            <strong class="form-title">대여기간</strong>
                        </div>
                    </th>
                    <th scope="row" colspan="1" class="pl-0 pr-0">
                        <div class="table-top">
                            <strong class="form-title">금액</strong>
                        </div>
                    </th>
                    <th scope="row" colspan="1" class="pl-0 pr-0">
                        <div class="table-top">
                            <strong class="form-title">상태</strong>
                        </div>
                    </th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="dataBefore" items="${infoListBefore}">
                    <tr>
                        <td>
                            <p><c:out value="${dataBefore.orderInfoUid}"/></p>
                        </td>
                        <td>
                            <p><c:out value="${dataBefore.warehouseName}"/></p>
                        </td>

                        <td>
                            <p style="white-space: pre-line"><c:out value="${dataBefore.startTime} ~ ${dataBefore.endTime}"/></p>
                        </td>

                        <td>
                            <p><c:out value="${dataBefore.price}원"/></p>
                        </td>

                        <td>
                            <c:choose>
                                <c:when test="${dataBefore.status == 0}">
                                    <p>결제대기</p>
                                </c:when>

                                <c:when test="${dataBefore.status == 1}">
                                    <p>결제완료</p>
                                </c:when>

                                <c:when test="${dataBefore.status == 2}">
                                    <p>상품인수</p>
                                </c:when>

                                <c:when test="${dataBefore.status == 6}">
                                    <p>기간만료</p>
                                </c:when>
                            </c:choose>
                        </td>
                    </tr>

                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>