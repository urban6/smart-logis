<%--
  Created by IntelliJ IDEA.
  User: jeonseungcheol
  Date: 2020/11/04
  Time: 2:23 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>물류 공유해 : 메인</title>

    <meta content="user-scalable=no, width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0"
          name="viewport">

    <%-- Reset CSS --%>
    <link rel="stylesheet" href="<c:url value='/css/reset.css'/>">
    <%-- Bootstrap core CSS --%>
    <link rel="stylesheet" href="<c:url value ='/assets/libs/bootstrap-4.5.3/css/bootstrap.min.css'/>">
    <%-- Material Design Bootstrap CSS --%>
    <link rel="stylesheet" href="<c:url value='/js/core.min.js'/>">
    <%-- Custom CSS --%>
    <link rel="stylesheet" href="<c:url value='/css/content_logis.css'/>">

    <%-- JQuery, Bootstrap JS  --%>
    <script src="<c:url value='/js/jquery-3.5.1.min.js'/>"></script>
    <script src="<c:url value ='/assets/libs/bootstrap-4.5.3/js/bootstrap.min.js'/>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            // 창고 신청하기
            $("#warehouseApply").click(function (key) {
                movePage("POST", "/user/warehouse/apply");
            });

            // 창고 조회하기
            $("#warehouseSearch").click(function (key) {
                movePage("POST", "/user/warehouse/search");
            });

            // 물류 신청하기
            $("#logisApply").click(function (key) {
                movePage("POST", "/user/logis/apply");
            });

            // 물류 조회하기
            $("#logisSearch").click(function (key) {
                movePage("POST", "/user/logis/search");
            });
        });

        function movePage(method, action) {
            const form = document.createElement('form');
            form.setAttribute('method', method);
            form.setAttribute('action', action);
            document.body.appendChild(form);
            form.submit();
        }
    </script>

    <style>
        #wrap {
            width: 100%;
            margin: 0 auto;
            max-height: 100vh;
            background-color: white;
        }

        .header {
            height: 7vh;
            background-color: #0E2F91;
            display: flex;
            flex-direction: row;
        }

        .section {
            height: 80vh;
        }

        .footer {
            height: 13vh;
            background-color: #f9f9f9;
        }

        .half-box {
            float: left;
            width: 100%;
            height: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            border-bottom: 1px solid lightgrey;
        }

        /* 769 ~ 부터 div의 가로 크기가 50% 으로 변경*/
        @media (min-width: 769px) {
            .half-box {
                width: 49.99999%;
                height: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
                border-right: 1px solid lightgrey;
                border-bottom: 1px solid lightgrey;
            }
        }

        .btn-container {
            display: flex;
            flex-direction: column;
            width: 50%;
            height: 40%;
            justify-content: space-between;
        }

        .btn-item {
            width: 100%;
            height: 40%;
            display: flex;
            flex-direction: row;
            cursor: pointer;
            box-shadow: 2px 2px 2px 2px #f5f5f5;
            border-radius: 8px;
        }

        .span-title {
            display: table-cell;
            vertical-align: middle;
            text-align: center;
            font-size: 1.8rem;
            font-weight: 550;
            color: #5D6CAA;
        }

        .div-icon {
            width: 30%;
            border-right: 4px solid #E6E6E6;
            margin: 3% 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .div-text {
            width: 70%;
            height: 100%;
            display: table;
        }

        /* 상단 네비게이션 */
        .topNav {
            width: 50%;
            overflow: hidden;
            background-color: #0E2F91;
            height: 100%;
            margin-right: 2%;
            display: flex;
            flex-direction: row-reverse;
        }

        .topNav a {
            float: right;
            color: #f2f2f2;
            text-align: center;
            padding: 2% 2%;
            height: 100%;
            text-decoration: none;
            font-size: 1.2rem;
        }

        .topNav a:hover {
            background-color: #FFF;
            color: #0E2F91;
        }

        .topTitle {
            width: 50%;
            overflow: hidden;
            background-color: #0E2F91;
            height: 100%;
            display: flex;
            justify-content: left;
            align-self: center;
        }

        .title {
            width: 40%;
            display: flex;
            justify-content: left;
            align-self: center;
        }

        .title a {
            float: left;
            color: #f2f2f2;
            text-align: center;
            height: 100%;
            margin-left: 32px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.8rem;
        }
    </style>
</head>
<body>
<div id="wrap">
    <div class="header">
        <div class="topTitle">
            <div class="title"><a href="/user/home/home">물류 공유해</a></div>
        </div>
        <div class="topNav">
            <%-- 상단 메뉴는 미구현 상태 --%>
            <a href="#logout">로그아웃</a>
            <a href="#info">내 정보</a>
        </div>
    </div>
    <div class="section">
        <div class="half-box" style="background-color: #FFFFFF">
            <div class="btn-container">
                <div id="warehouseApply" class="btn-item">
                    <div class="div-icon">
                        <img src="/images/warehouse_icon.png">
                    </div>
                    <div class="div-text">
                        <span class="span-title">창고 신청하기</span>
                    </div>
                </div>
                <div id="warehouseSearch" class="btn-item">
                    <div class="div-icon">
                        <img src="/images/warehouse_search_icon.png">
                    </div>
                    <div class="div-text">
                        <span class="span-title">창고 조회하기</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="half-box" style="background-color: #FFFFFF">
            <div class="btn-container">
                <div id="logisApply" class="btn-item">
                    <div class="div-icon">
                        <img src="/images/logis_icon.png" width="70">
                    </div>
                    <div class="div-text">
                        <span class="span-title">물류 신청하기</span>
                    </div>
                </div>
                <div id="logisSearch" class="btn-item">
                    <div class="div-icon">
                        <img src="/images/logis_search_icon.png" width="70">
                    </div>
                    <div class="div-text">
                        <span class="span-title">물류 조회하기</span>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="footer">
    </div>
</div>

</body>
</html>
