<%--
  Created by IntelliJ IDEA.
  User: jeonseungcheol
  Date: 2020/11/25
  Time: 4:37 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>물류 공유해 : 결제</title>

    <meta content="user-scalable=no, width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0"
          name="viewport">

    <%-- Reset CSS --%>
    <%--    <link rel="stylesheet" href="/css/reset.css">--%>

    <%-- Bootstrap, JQuery Library --%>
    <script src="/assets/libs/jquery/dist/jquery.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>

    <%--    <link rel="stylesheet" href="/css/content_logis.css">--%>

    <script src='/js/nprogress.js'></script>
    <link rel='stylesheet' href='/css/nprogress.css'/>

    <script type="text/javascript">
        $(document).ready(function () {
            actionType();

            $("#btnHome").click(function (key) {
                location.href = "/user/home/home";
            });
        });

        function actionType() {
            $.ajax("/user/pay/type",
                {
                    method: 'POST',
                    data: {},
                    dataType: 'JSON'
                }
            ).done(function (data) {
                const type = data.type;
                if (type == "warehouse") {
                    actionPayWarehouseComplete();
                } else if (type == "logis") {
                    actionPayLogisComplete();
                }
            });

        }

        /**
         * [택배] 결제 이후 데이터 변경
         */
        function actionPayLogisComplete() {
            $.ajax("/user/logis/actionPayUpdate",
                {
                    method: 'POST',
                    data: {
                        "salesUid": "${param.sellerOrderReferenceKey}"
                    },
                    dataType: 'JSON'
                }
            ).done(function (data) {

            });
        }

        /**
         * [창고] 결제 이후 데이터 변경
         */
        function actionPayWarehouseComplete() {
            $.ajax("/user/warehouse/actionPayUpdate",
                {
                    method: 'POST',
                    data: {
                        "salesUid": "${param.sellerOrderReferenceKey}"
                    },
                    dataType: 'JSON'
                }
            ).done(function (data) {

            });
        }
    </script>
    <style>
        body {
            background-color: #999999;
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
            height: 20vh;
            flex-direction: column;
            background-color: white;
            align-items: center;
            justify-content: space-between;
        }

        .span-paying {
            font-size: 2.5rem;
            font-weight: 800;
        }

        .btn-main {
            width: 100%;
            border: 0;
            border-radius: 0;
            background-color: #0E2F91;
            color: white;
            padding: 0.9rem;
        }

        .btn-main:hover {
            color: black;
        }

        .div-complete-box {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            text-align: center;
            height: 80%;
        }
    </style>
</head>
<body>
<div id="wrap">
    <div class="div-center-box">
        <div class="div-complete-box">
            <span class="span-paying">결제 완료</span>
        </div>
        <div style="width:100%; height: 20%; text-align: end;">
            <input id="btnHome" type="button" class="btn btn-main" value="메인으로">
        </div>
    </div>
</div>
</body>
</html>
