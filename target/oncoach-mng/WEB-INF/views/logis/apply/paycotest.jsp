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
    <title>물류 공유해 : 창고 예약</title>

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
            src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=snsxvn7i8m"></script>

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
                    // checkOrder();
                    //orderAction();
                	movePayPage("P", "1");
                } else {
                    // 결제를 누르기 전에 누가 결제를 해서 원하는 수량을 예약할 수 없는 경우이다.
                    alert("잠시후 다시 시도해주세요.");
                    location.href = "/user/home/home";
                }
            });
        }

        function orderAction() {
            $.ajax("/user/warehouse/order",
                {
                     method: 'POST',
                     data: {
                         "warehouseUid": Number("${info.warehouseUid}"),
                         "startTime": "${info.startDatetime}",
                         "endTime": "${info.endDatetime}",
                         "size": Number("${info.spaceSize}"),
                         "dayPrice": Number("${info.price}"),
                         "days": Number("${info.days}")
                     },
                     dataType: 'JSON'
                }
            ).done(function (data) {
                const result = data.result;
               
                if (result) {
                    movePayPage(data.payType, data.quantity);
                }
            });
        }

        function movePayPage(payType, quantity) {

            const inputPayType = document.createElement("input");
            inputPayType.setAttribute("name", "payType");
            inputPayType.setAttribute("value", payType);

            const inputQuantity = document.createElement("input");
            inputQuantity.setAttribute("name", "quantity");
            inputQuantity.setAttribute("value", quantity);

            const form = document.createElement('form');
            form.setAttribute('method', 'POST');
            form.setAttribute('action', '/user/warehouse/paying_test');
            document.body.appendChild(form);
            form.appendChild(inputPayType);
            form.appendChild(inputQuantity);
            form.submit();
        }

        /**
         * 주문예약 Validation check
         */
        function checkOrder() {

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
            form.setAttribute('action', "/user/warehouse/order2");
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
            background-color: white;
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
            background: url('/images/BG_4.png');
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

        .div-warehouse {
            background-color: #39539c;
        }

        .div-warehouse-container {
            width: 950px;
            margin: 0 auto;
            padding-top: 1.1rem;
            padding-bottom: 1.1rem;
            color: white;
        }

        .section {
            width: 950px;
            margin: 0 auto;
            height: 93vh;
            display: flex;
        }

        .div-warehouse-box {
            width: 100%;
        }

        .div-price-box {
            width: 40%;
            text-align: right;
            height: 600px;

            display: flex;
            flex-direction: column;
            align-content: space-around;
        }

        .div-time-box {
            width: 100%;
            display: flex;
            flex-direction: column;
            margin-top: 1.2rem;
        }

        .span-warehouse-name {
            font-size: 1.6rem;
            font-weight: 700;
        }

        .span-warehouse-address {
            font-size: 1rem;
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
            text-align: left;
            padding-left: 20px;
            letter-spacing: 2px;
        }

        .span-time {
            border: 1px solid lightgrey;
            text-align: left;
            margin-left: 20px;
            padding: 5px 10px;
        }

        label {
            display: flex;
            flex-direction: row;
        }

        .div-pay-box {
            width: 100%;
            height: 30%;
            display: flex;
            flex-direction: column-reverse;
            justify-content: right;
            align-items: flex-end;
        }

        /* 결제 버튼 */
        .btn-pay {
            color: white;
            font-weight: 600;
            font-size: 1.2rem;
            width: 70%;
            padding: 0.8rem;
            border-radius: 0;
            background-color: #E93D00;
            cursor: pointer;
        }

        .btn-pay:hover {
            color: black;
        }
        
        .fotter{
        	position: absolute;
		    bottom: 0px;
		    text-align: center;
		    margin-left: 15%;
        }
    </style>
</head>
<body>
<div class="header">
    <span class="header-title">창고 예약</span>
</div>
<div id="wrap">
    <div class="div-warehouse">
        <div class="div-warehouse-container">
            <div>
                <span class="span-warehouse-name">${info.warehouseName}</span>
            </div>
            <div>
                <span class="span-warehouse-address">${info.warehouseAddress}</span>
            </div>
        </div>
    </div>
    <div class="section">
        <div class="div-warehouse-box">
            <div>
                <div id="map" style="width: 100%; height: 600px;"></div>
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
            <div style="width: 100%; height: 70%;">
                <div class="div-time-box">
                    <span class="span-time-title">시작 날짜, 시간</span>
                    <span class="span-time">${info.startDatetime}</span>
                </div>
                <div class="div-time-box">
                    <span class="span-time-title">종료 날짜, 시간</span>
                    <span class="span-time">${info.endDatetime}</span>
                </div>
                <div class="div-time-box">
                    <span class="span-time-title">신청수량</span>
                    <span class="span-time">${info.price}원  &times; ${info.spaceSize}개 &times; ${info.days}일</span>
                     
                </div>
            </div>
            <div class="div-pay-box">
                <input id="btnPay" type="button" class="btn btn-pay" value="간편결제"/>
                <%-- 가격 --%>
                <div style="margin-bottom: 5%">
                    <span class="span-pay-price">총 결제 금액</span>
                    <br>
                    <span class="span-price">${info.price * info.spaceSize * info.days}원</span>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="footer">
		<div id="payInformation">
    		<span class="float-left text-left">
    			상호 : 주식회사 셔블<br>
    			대표이사 : 홍성범 <br> 
    			주소:서울특별시 영등포구 경인로 775, 4동 4층 403호(문래동3가, 에이스하이테크시티) <br>
    			TEL : 02-6309-1035<br>
    			사업자번호 : 767-88-01513	
    		</span>
    	</div>
</div>
</body>
</html>
