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
    <link rel="stylesheet" href="/css/reset.css">

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

    <link rel="stylesheet" href="/css/content_logis.css">

    <script src='/js/nprogress.js'></script>
    <link rel='stylesheet' href='/css/nprogress.css'/>

    <script type="text/javascript">
        $(document).ready(function () {
            const status = "${isStatus}";
            if (status == "P") {
                callPaycoUrl();
            }
        });

        // 외부가맹점의 주문 관리번호 얻기
        function randomStr() {
            let randomStr = "";

            for (let i = 0; i < 10; i++) {
                randomStr += Math.ceil(Math.random() * 9 + 1);
            }

            randomStr = "LOGIS@" + ${userUid} + "@" +  randomStr;
            console.log(randomStr);
            return randomStr;
        }

        // 주문예약
        function callPaycoUrl() {
            const customerOrderNumber = randomStr();
            const pathUrl = window.location.origin;

            let Params = "customerOrderNumber=" + customerOrderNumber;
            const productKey = "2960903800";
            const orderQuantity = parseInt("${quantity}"); // 상품 갯수
            console.log("[CHECK] = "+ orderQuantity);

            Params += "&pathUrl=" + pathUrl;
            Params += "&productKey=" + productKey;
            Params += "&orderQuantity=" + orderQuantity;

            console.log(Params);
            // localhost 로 테스트 시 크로스 도메인 문제로 발생하는 오류
            $.support.cors = true;

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

            /*$.ajax({
                type: "POST",
                url: "/user/pay/payco_reserve",
                data: {
                    "customerOrderNumber": customerOrderNumber,
                    "pathUrl": pathUrl,
                    "productKey": productKey,
                    "orderQuantity": orderQuantity
                },		// JSON 으로 보낼때는 JSON.stringify(customerOrderNumber)   Params
                contentType: "application/json; charset=UTF-8",
                dataType: "json",
                success: function (data) {
                    console.log(data.linkedHashMap);
                    if (data.linkedHashMap.code == '0') {
                        console.log(data);
                        var order_Url = (data.linkedHashMap.result.orderSheetUrl);
                        location.href = order_Url;
                    } else {
                        alert("code : " + data.linkedHashMap.code + "\n" + "message : " + data.linkedHashMap.message);
                    }
                },
                error: function (request, status, error) {
                    //에러코드
                    alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                    return false;
                }
            });*/
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
