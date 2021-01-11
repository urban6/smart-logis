<%--
  Created by IntelliJ IDEA.
  User: jeonseungcheol
  Date: 2020/11/25
  Time: 4:37 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>물류 공유해 : 결제</title>

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

    <%-- Popper --%>
    <!-- Development version -->
    <script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>

    <%-- JQuery, Bootstrap JS  --%>
    <script src="<c:url value='/js/jquery-3.5.1.min.js'/>"></script>
    <script src="<c:url value ='/assets/libs/bootstrap-4.5.3/js/bootstrap.min.js'/>"></script>

    <script src='/js/nprogress.js'></script>
    <link rel='stylesheet' href='/css/nprogress.css'/>

    <script type="text/javascript">
        $(document).ready(function () {
            const type = "${type}";
            if (type == "warehouse") {
                const status = "${isStatus}";
                if (status == "P") {
                    warehouseCallPaycoUrl();
                }

            } else if(type == "logis") {
                const status = "${isStatus}";
                if (status == "P") {
                    logisCallPaycoUrl();
                }
            }

        });

        // 외부가맹점의 주문 관리번호 얻기
        function randomWarehouseStr() {
            let randomStr = "";

            for (let i = 0; i < 10; i++) {
                randomStr += Math.ceil(Math.random() * 9 + 1);
            }

            randomStr = "WAREHOUSE@" + ${userUid} +"@" + randomStr;
            console.log(randomStr);
            return randomStr;
        }

        // 외부가맹점의 주문 관리번호 얻기
        function randomStr() {
            let randomStr = "";

            for (let i = 0; i < 10; i++) {
                randomStr += Math.ceil(Math.random() * 9 + 1);
            }

            randomStr = "LOGIS@" + ${userUid} +"@" + randomStr;
            console.log(randomStr);
            return randomStr;
        }

        // 주문예약
        function logisCallPaycoUrl() {
            const customerOrderNumber = randomStr();
            const pathUrl = window.location.origin;

            let Params = "customerOrderNumber=" + customerOrderNumber;
            // const productKey = "2960903800";
            // const orderQuantity = parseInt(${quantity}); // 상품 갯수

            let productKey = [];
            productKey.push("5");
            productKey.push("6");

            let orderQuantity = [];
            orderQuantity.push("${boxCount}");
            orderQuantity.push("${paletteCount}");

            // Params += "&pathUrl=" + pathUrl;
            // Params += "&productKey=" + productKey;
            // Params += "&orderQuantity=" + orderQuantity;
            // console.log(Params);

            // localhost 로 테스트 시 크로스 도메인 문제로 발생하는 오류
            $.support.cors = true;
            jQuery.ajaxSettings.traditional = true;

            $.ajax("/user/pay/payco_reserve",
                {
                    method: 'POST',
                    data: {
                        "customerOrderNumber": customerOrderNumber,
                        "pathUrl": pathUrl,
                        "productKey": productKey,
                        "orderQuantity": orderQuantity
                    },
                    dataType: 'JSON'
                    // contentType: 'application/json',
                }
            ).done(function (data) {
                console.log(data.linkedHashMap);
                if (data.linkedHashMap.code == '0') {
                    console.log(data);
                    var order_Url = (data.linkedHashMap.result.orderSheetUrl);
                    location.href = order_Url;
                } else {
                    alert("code : " + data.linkedHashMap.code + "\n" + "message : " + data.linkedHashMap.message);
                }
            }).fail(function (request, status, error) {
                //에러코드
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                return false;
            });
        }

        // 주문예약 reserve_test -> test 빼야함
        function warehouseCallPaycoUrl() {
            const customerOrderNumber = randomWarehouseStr();
            const pathUrl = window.location.origin;
            const orderQuantity = parseInt("${quantity}"); // 상품 갯수
            // localhost 로 테스트 시 크로스 도메인 문제로 발생하는 오류
            $.support.cors = true;
            jQuery.ajaxSettings.traditional = true;
            $.ajax("/user/pay/payco_reserve",
                {
                    method: 'POST',
                    data: {
                        "customerOrderNumber": customerOrderNumber,
                        "pathUrl": pathUrl,
                        "productKey": "${productKey}",
                        "orderQuantity": orderQuantity
                    },
                    dataType: 'JSON'
                    // contentType: 'application/json',
                }
            ).done(function (data) {
                console.log(data.linkedHashMap);
                if (data.linkedHashMap.code == '0') {
                    console.log(data);
                    var order_Url = (data.linkedHashMap.result.orderSheetUrl);
                    location.href = order_Url;
                } else {
                    alert("code : " + data.linkedHashMap.code + "\n" + "message : " + data.linkedHashMap.message);
                }
            }).fail(function (request, status, error) {
                //에러코드
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                return false;
            });
        }

    </script>
    <style>
        body {
            background-color: white;
        }

        #wrap {
            width: 720px;
            margin: 0 auto;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .div-center-box {
            display: flex;
            width: 60%;
            height: 40vh;
            border: 1px solid lightgrey;
            border-radius: 8px;
            justify-content: center;
            align-items: center;
        }

        .span-paying {
            font-size: 2rem;
            font-weight: 700;
        }

    </style>
</head>
<body>
<div id="wrap">
    <div class="div-center-box">
        <span class="span-paying">결제 진행중</span>
    </div>
</div>
</body>
</html>
