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

            // 빌린 창고 조회하기
            $("#warehouseSearch").click(function (key) {
                movePage("POST", "/user/warehouse/search");
            });
            
            // 빌려준 창고 조회하기
            $("#RentWarehouseSearch").click(function (key) {
                movePage("POST", "/user/warehouse/rentSearch");
            });

            // 관리자 메인 페이지
            $("#adminIndex").click(function (key) {
                movePage("POST", "/order/index");
            });

            // 내 창고 대여하기
            $("#warehouseLend").click(function (key) {
                movePage("POST", "/user/warehouse/lend");
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
        body {
            background: url('/images/BG_2.png') no-repeat 50% 50% fixed;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }

        #wrap {
            width: 100%;
            margin: 0 auto;
            max-height: 100vh;
        }

        .header {
            height: 7vh;
            display: flex;
            flex-direction: row;
        }

        .section {
            width: 100%;
            height: 80vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .footer {
            height: 13vh;
        }

        .half-box {
            float: left;
            width: 90%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            align-self: center;
            text-align: center;
        }

        /* 769 ~ 부터 div의 가로 크기가 50% 으로 변경*/
        @media (min-width: 769px) {
            .half-box {
                width: 50%;
                height: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
            }
        }

        .btn-container {
            display: flex;
            flex-direction: column;
            width: 49.9%;
            height: 40%;
            justify-content: space-between;
        }

        .btn-logis-menu {
            width: 100%;
            height: 45%;
            display: flex;
            flex-direction: row;
            cursor: pointer;
            border-radius: 4px;
            background-color: white;
        }

        .btn-warehouse-menu {
            width: 100%;
            height: 30%;
            display: flex;
            flex-direction: row;
            cursor: pointer;
            border-radius: 4px;
            background-color: white;
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
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #39539c;
            border-radius: 4px 0 0 4px;
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
            padding-right: 2%;
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
        <div class="topTitle" style="display: none;">
            <div class="title"><a href="/user/home/home">물류 공유해</a></div>
        </div>
        <div class="topNav" style="display: none;">
            <%-- 상단 메뉴는 미구현 상태 --%>
            <a href="#logout">로그아웃</a>
            <a href="#info">내 정보</a>
        </div>
    </div>
    <div class="section">
        <div class="half-box">
            <div class="btn-container">
                <div id="warehouseSearch" class="btn-warehouse-menu">
                    <div class="div-icon">
                        <img src="/images/warehouse_icon.png" style="width: 50%; height: 50%;">
                    </div>
                    <div class="div-text">
                        <span class="span-title">내가 빌린 창고 조회</span>
                    </div>
                </div>
                <div id="RentWarehouseSearch" class="btn-warehouse-menu">
                    <div class="div-icon">
                        <img src="/images/warehouse_icon.png" style="width: 50%; height: 50%;">
                    </div>
                    <div class="div-text">
                        <span class="span-title">내가 빌려준 창고 조회</span>
                    </div>
                </div>
                <div id="warehouseApply" class="btn-warehouse-menu">
                    <div class="div-icon">
                        <img src="/images/warehouse_icon.png" style="width: 50%; height: 50%;">
                    </div>
                    <div class="div-text">
                        <span class="span-title">창고 대여</span>
                    </div>
                </div>
                <div id="warehouseLend" class="btn-warehouse-menu">
                    <div class="div-icon">
                        <img src="/images/warehouse_icon.png" style="width: 50%; height: 50%;">
                    </div>
                    <div class="div-text">
                        <span class="span-title">창고 등록</span>
                    </div>
                </div>
            </div>
            <div class="btn-container ml-4">
                <!--  관리자 메인 페이지 -->
                <div id="adminIndex" class="btn-logis-menu">
                    <div class="div-icon">
                        <img src="/images/truck_icon.png" style="width: 50%; height: 50%;">
                    </div>
                    <div class="div-text">
                        <span class="span-title">관리자 페이지</span>
                    </div>
                </div>
                <div id="logisApply" class="btn-logis-menu">
                    <div class="div-icon">
                        <img src="/images/truck_icon.png" style="width: 50%; height: 50%;">
                    </div>
                    <div class="div-text">
                        <span class="span-title">물류 배송신청</span>
                    </div>
                </div>
                <div id="logisSearch" class="btn-logis-menu">
                    <div class="div-icon">
                        <img src="/images/truck_icon.png" style="width: 50%; height: 50%;">
                    </div>
                    <div class="div-text">
                        <span class="span-title">물류 신청내역</span>
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
