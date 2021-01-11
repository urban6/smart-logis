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
    <title>물류 공유해 : 물류 조회</title>

    <meta content="user-scalable=no, width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0"
          name="viewport">

    <%-- Reset CSS --%>
    <%--    <link rel="stylesheet" href="/css/reset.css">--%>
    <%--  Bootstrap 5.0 CSS--%>
    <link rel="stylesheet" href="<c:url value='/assets/libs/bootstrap-5.0.0/css/bootstrap.min.css'/>">

    <%-- JQuery, Bootstrap JS  --%>
    <script src="<c:url value='/js/jquery-3.5.1.min.js'/>"></script>
    <script src="<c:url value ='/assets/libs/bootstrap-5.0.0/js/bootstrap.min.js'/>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            addRowHandlers();
        });

        function addRowHandlers() {
            const table = document.getElementById("list");
            const rows = table.getElementsByTagName("tr");
            for (let i = 0; i < rows.length; i++) {
                const currentRow = table.rows[i];
                const createClickHandler = function (row) {
                    return function () {
                        const cell = row.getElementsByTagName("th")[0];
                        const id = cell.innerHTML;

                        if (Number(id) > 0) {
                            const logisOrderUid = document.createElement("input");
                            logisOrderUid.setAttribute("name", "logisOrderUid");
                            logisOrderUid.setAttribute("value", id);

                            const form = document.createElement('form');
                            form.setAttribute('method', 'POST');
                            form.setAttribute('action', '/user/logis/searchDetail');
                            form.appendChild(logisOrderUid);
                            document.body.appendChild(form);
                            form.submit();
                        }
                    };
                };
                currentRow.onclick = createClickHandler(currentRow);
            }
        }
    </script>
    <style>
        body {

        }

        #wrap {
            width: 900px;
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
            background: url('/images/bg_header.png');
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
            padding-top: 3%;
            padding-bottom: 5%;
        }

        .form-table {
            margin-bottom: 56px;
        }

        .table-top {
            /*padding: 18px 30px 15px 0;*/
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
        }

        td {
            padding: 30px 10px;
            border-bottom: 1px solid #ebebeb;
            text-align: center;
        }

        th {
            text-align: center;
        }

        p {
            margin: 0;
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
    </style>
</head>
<body>
<div class="header">
    <span class="header-title">물류 배송 신청 목록</span>
</div>

<div id="wrap">
    <div class="section">
        <table id="list" class="table table-hover">
            <colgroup>
                <col style="width: 10%">
                <col style="width: 20%">
                <col style="width: 20%">
                <col style="width: 20%">
                <col style="width: 10%">
            </colgroup>
            <thead>
            <tr>
                <th scope="col" class="p-3">접수번호</th>
                <th scope="col" class="p-3">신청일</th>
                <th scope="col" class="p-3">배송상태</th>
                <th scope="col" class="p-3">처리일시</th>
                <th scope="col" class="p-3">받는분</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="data" items="${infoList}">
                <tr>
                    <th scope="row" class="p-3"><c:out value="${data.logisOrderUid}"/></th>
                    <td><c:out value="${data.requestTime}"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${data.status == 0}">
                                접수완료
                            </c:when>

                            <c:when test="${data.status == 1}">
                                결제완료
                            </c:when>

                            <c:when test="${data.status == 2}">
                                담당자 배정완료
                            </c:when>

                            <c:when test="${data.status == 3}">
                                상품인수
                            </c:when>

                            <c:when test="${data.status == 4}">
                                배송시작
                            </c:when>

                            <c:when test="${data.status == 5}">
                                배송완료
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty data.arriveTime}">
                                <p><c:out value="${data.arriveTime}"/></p>
                            </c:when>

                            <c:when test="${empty data.arriveTime}">
                                <p>-</p>
                            </c:when>
                        </c:choose>
                    </td>
                    <td><c:out value="${data.receiverName}"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
