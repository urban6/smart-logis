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
    <title>물류 공유해 : 창고 대여 완료</title>

    <meta content="user-scalable=no, width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0"
          name="viewport">

    <%-- Reset CSS --%>
    <%--    <link rel="stylesheet" href="/css/reset.css">--%>

    <script src="/assets/libs/jquery/dist/jquery.min.js"></script>

    <%-- Bootstrap 5.0.0 --%>
    <script src="/assets/libs/bootstrap-5.0.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/assets/libs/bootstrap-5.0.0/css/bootstrap.min.css/>">

    <script type="text/javascript">
        $(document).ready(function () {

            $("#btnModal").click();

            $("#completeBtn").click(function () {
                location.href = "/user/home/home";
            });

            $("#inItemBtn").click(function () {
                location.href = "/user/logis/apply";
            });

            var status = "${isStatus}";

            if (status == "P") {
                callPaycoUrl();
            } else {
                // alert("제로페이 결제 예정");
            }
        });


        // 외부가맹점의 주문 관리번호 얻기
        function randomStr() {
            var randomStr = "";

            for (var i = 0; i < 10; i++) {
                randomStr += Math.ceil(Math.random() * 9 + 1);
            }

            randomStr = "TEST" + randomStr;
            console.log(randomStr);
            return randomStr;
        }

        // 주문예약
        function callPaycoUrl() {
            var customerOrderNumber = randomStr();
            var pathUrl = window.location.origin;

            var Params = "customerOrderNumber=" + customerOrderNumber;
            var productKey = "2960903800";
            var orderQuantity = parseInt($("#productQuantity").text());			// 상품 갯수
            Params += "&pathUrl=" + pathUrl;
            Params += "&productKey=" + productKey;
            Params += "&orderQuantity=" + orderQuantity;

            console.log(Params);
            // localhost 로 테스트 시 크로스 도메인 문제로 발생하는 오류
            $.support.cors = true;

            $.ajax({
                type: "POST",
                url: "/user/pay/payco_reserve",
                data: Params,		// JSON 으로 보낼때는 JSON.stringify(customerOrderNumber)   Params
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
            flex-direction: column;
            border: 1px solid lightgrey;
            border-radius: 8px;
            justify-content: center;
            align-items: center;
        }

        .span-paying {
            font-size: 2.5rem;
            font-weight: 800;
        }

    </style>
</head>
<body>
<!-- Button trigger modal -->
<button id="btnModal" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal"
        style="display: none;">
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <h5>
                    택배를 이용해서 물류를 입고하시겠습니까?<br>
                    직접 배송 또는 나중에 배송을 원하시면 취소를 눌러주세요.
                </h5>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button id="inItemBtn" type="button" class="btn btn-primary">입고신청</button>
            </div>
        </div>
    </div>
</div>
<div id="wrap">
    <div class="div-center-box">
        <div style="width:100%; text-align: center;">
            <span class="span-paying">신청 완료</span>
        </div>
        <div style="margin-top: 5%; width:100%; text-align: center;">
            <input id="completeBtn" type="button" class="btn btn-primary" value="메인으로" style="width: 40%;">
        </div>
    </div>
</div>
</body>
</html>
