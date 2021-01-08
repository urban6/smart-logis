<%--
  Created by IntelliJ IDEA.
  User: jeonseungcheol
  Date: 2020/11/24
  Time: 4:00 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kr.co.shovvel.dm.common.Consts" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>물류 공유해 : 창고 신청</title>

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

    <%-- 네이버 지도 --%>
    <script type="text/javascript"
            src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=801jndukm2"></script>

    <%-- Payco Icon --%>
    <script type="text/javascript" src="https://static-bill.nhnent.com/payco/checkout/js/payco.js"
            charset="UTF8"></script>
    <script type="text/javascript" src="https://static-bill.nhnent.com/payco/checkout/js/payco_mobile.js"
            charset="UTF8"></script>

    <%-- 프로그래스바 --%>
    <script src='/js/nprogress.js'></script>
    <link rel='stylesheet' href='/css/nprogress.css'/>

    <c:set var="SUCCESS"><%=Consts.SPACE_PREV_PAY_STATE.SUCCESS%>
    </c:set>
    <c:set var="FAIL"><%=Consts.SPACE_PREV_PAY_STATE.FAIL%>
    </c:set>

    <script type="text/javascript">

        let warehouseList = [];

        $(document).ready(function () {
            $("#btnPay").click(function (key) {
                checkAvailableSpace();
            });

            $("#radioZeropay").click(function (key) {
                alert("신청을 하고 2시간 안에 결제를 해야 합니다.");
            });
        });

        /**
         * 사용할 수 있는 공간을 확인
         */
        function checkAvailableSpace() {
            $.ajax("/user/warehouse/checkAvailableSpace",
                {
                    method: 'POST',
                    data: {
                        "warehouseUid": "${info.warehouseUid}",
                        "startDatetime": "${info.startDatetime}",
                        "endDatetime": "${info.endDatetime}",
                        "spaceSize": "${info.spaceSize}"
                    },
                    dataType: 'JSON'
                }
            ).done(function (data) {
                const result = data.result;
                if (result == ${SUCCESS}) {
                    checkOrder();
                } else {
                    // 결제를 누르기 전에 누가 결제를 해서 원하는 수량을 예약할 수 없는 경우이다.
                    alert("잠시후 다시 시도해주세요.");
                    location.href = "/user/home/home";
                }
            });
        }

        /**
         * 주문예약 Validation check
         */
        function checkOrder() {
            /*
            if ($("input:radio[name=sort]:checked").val() == null) {
                alert("결제방식을 선택하세요.");
            } else {

            }
             */
            // const checkPayMethod = $("input:radio[name=sort]:checked").val();

            const warehouseUid = document.createElement("input");
            warehouseUid.setAttribute("name", "warehouseUid");
            warehouseUid.setAttribute("value", "${info.warehouseUid}");

            const startDatetime = document.createElement("input");
            startDatetime.setAttribute("name", "startDatetime");
            startDatetime.setAttribute("value", "${info.startDatetime}");

            const endDatetime = document.createElement("input");
            endDatetime.setAttribute("name", "endDatetime");
            endDatetime.setAttribute("value", "${info.endDatetime}");

            const inputPayMethod = document.createElement("input");
            inputPayMethod.setAttribute("name", "checkPayMethod");
            inputPayMethod.setAttribute("value", "P");

            const isPay = document.createElement("input");
            isPay.setAttribute("name", "isPay");
            isPay.setAttribute("value", "N");

            const spaceSize = document.createElement("input");
            spaceSize.setAttribute("name", "spaceSize");
            spaceSize.setAttribute("value", "${info.spaceSize}");

            const days = document.createElement("input");
            days.setAttribute("name", "days");
            days.setAttribute("value", "${info.days}");

            const price = document.createElement("input");
            price.setAttribute("name", "price");
            price.setAttribute("value", "${info.price}");

            const form = document.createElement('form');
            form.setAttribute('method', "POST");
            form.setAttribute('action', "/user/warehouse/order");
            form.appendChild(warehouseUid)
            form.appendChild(inputPayMethod);
            form.appendChild(startDatetime);
            form.appendChild(endDatetime);
            form.appendChild(isPay);
            form.appendChild(spaceSize);
            form.appendChild(days);
            form.appendChild(price);
            document.body.appendChild(form);
            form.submit();
        }
    </script>
    <style>
        body {
            background-color: #e6e6e6;
        }

        #wrap {
            width: 950px;
            margin: 0 auto;
            background-color: white;
        }

        /* 화면 너비 0 ~ 768px */
        @media (max-width: 768px) {
            #wrap {
                width: 100%;
            }
        }

        .header {
            height: 6vh;
            width: 100%;
            background-color: #0E2F91;
        }

        .section {
            height: 94vh;
            width: 100%;
            display: flex;
        }

        .div-warehouse-box {
            width: 60%;
            padding-top: 3%;
            padding-left: 3%;
        }

        .div-price-box {
            width: 40%;
            padding-top: 12%;
            padding-right: 3%;
            text-align: right;
        }

        .span-warehouse-name {
            font-size: 2rem;
            font-weight: 700;
        }

        .span-warehouse-address {
            font-size: 1.2rem;
        }

        .div-info {

        }

        .span-pay-price {
            font-weight: 700;
            font-size: 1.0rem;
        }

        .span-price {
            font-weight: 700;
            font-size: 2rem;
            /*color: #d32f2f;*/
            color: #EA0000;
        }

        .span-time-title {
            font-size: 1.2rem;
            font-weight: 550;
        }

        .span-time {
            font-size: 1.2rem;
            font-weight: 600;
        }

        .div-pay-box {
            margin-top: 7%;
            display: grid;
            grid-template-columns: 5fr 5fr;
            justify-content: space-between;
            margin-bottom: 3%;
        }

        label {
            display: flex;
            flex-direction: row;
        }

        /* 결제 버튼 */
        .btn-pay {
            color: white;
            font-weight: 600;
            font-size: 1.2rem;
            width: 70%;
            padding: 5%;
            background-color: #0E2F91;
        }

        .btn-pay:hover {
            color: white;
        }
    </style>
</head>
<body>
<div class="header">

</div>
<div id="wrap">
    <div class="section">
        <div class="div-warehouse-box">
            <div class="div-info">
                <div>
                    <span class="span-warehouse-name">${info.warehouseName}</span>
                </div>
                <div>
                    <span class="span-warehouse-address">${info.warehouseAddress}</span>
                </div>
                <div id="map" style="width: 90%; height: 400px; margin-top: 2%"></div>
                <script>
                    const mapOptions = {
                        center: new naver.maps.LatLng(${info.lat}, ${info.lng}),
                        zoom: 16
                    };

                    const map = new naver.maps.Map('map', mapOptions);

                    const marker = new naver.maps.Marker({
                        position: new naver.maps.LatLng(${info.lat}, ${info.lng}),
                        map: map
                    });
                </script>
            </div>
        </div>

        <div class="div-price-box">
            <%-- 기간 --%>
            <div style="margin-top: 5%; margin-bottom: 2%">
                <span class="span-time-title">시작: </span><span class="span-time">${info.startDatetime}</span>
            </div>
            <div style="margin-bottom: 2%">
                <span class="span-time-title">종료: </span><span class="span-time">${info.endDatetime}</span>
            </div>
            <div style="margin-top: 5%;">
                <span style="font-size: 1.5rem; font-weight: 700;">${info.price}원  &times; ${info.spaceSize}개 &times; ${info.days}일</span>
            </div>
            <%-- 가격 --%>
            <div style="margin-top: 15%; margin-bottom: 15%">
                <span class="span-pay-price">총 결제 금액</span>
                <br>
                <span class="span-price">${info.price * info.spaceSize * info.days}원</span>
            </div>

            <div class="div-pay-box-margin" style="display: none;">
                <h5>결제 방법</h5>
                <div class="div-pay-box">
                    <div>
                        <label for="payZero">
                            <input class="input-radio" type="radio" value="Z" name="sort" id="payZero"
                                   style="width: 1.1em; height: 1.1em; margin-right: 5%">
                            <img src="/images/zeropay.png" height="14"/>
                        </label>
                    </div>

                    <label for="payco">
                        <input class="input-radio" type="radio" value="P" name="sort" id="payco"
                               style="width: 1.1em; height: 1.1em; margin-right: 5%">
                        <script type="text/javascript">
                            Payco.Button.register({
                                SELLER_KEY: "S0FSJE",
                                ORDER_METHOD: "EASYPAY", // 주문유형
                                BUTTON_TYPE: "A1", // 버튺타입 선택 (A1,A2)
                                DISPLAY_PROMOTION: "Y", // 이벤트 문구 출력 여부
                                DISPLAY_ELEMENT_ID: "payco_type1", // 노출될 element id
                                "": ""
                            });
                        </script>
                        <div id="payco_type1"></div>
                    </label>
                </div>
            </div>

            <input id="btnPay" type="button" class="btn btn-pay" value="간편결제"/>
        </div>
    </div>
</div>
</body>
</html>
