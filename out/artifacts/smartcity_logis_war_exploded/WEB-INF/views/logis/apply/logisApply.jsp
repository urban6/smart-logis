<%--
  Created by IntelliJ IDEA.
  User: jeonseungcheol
  Date: 2020/11/05
  Time: 10:01 오전
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
    <title>물류 공유해 : 물류 신청</title>

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

    <%-- 우편번호 --%>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <%-- Payco Icon --%>
    <script type="text/javascript" src="https://static-bill.nhnent.com/payco/checkout/js/payco.js"
            charset="UTF8"></script>
    <script type="text/javascript" src="https://static-bill.nhnent.com/payco/checkout/js/payco_mobile.js"
            charset="UTF8"></script>

    <c:set var="SUCCESS"><%=Consts.LOGIS_APPLY_RESULT.SUCCESS%>
    </c:set>
    <c:set var="FAIL"><%=Consts.LOGIS_APPLY_RESULT.FAIL%>
    </c:set>

    <script type="text/javascript">
        $(document).ready(function () {

            $("#btnAddItem").hide();
            addInputItem(true);

            // 대여중인 창고가 없을 경우, 라디오 버튼 비활성화
            <c:if test="${warehouseNameList.size() eq 0}">
            $("#fromWarehouse").attr('disabled', true);
            $("#toWarehouse").attr('disabled', true);
            </c:if>

            $("#btnReqSenderAddr").click(function () {
                requestSenderAddress();
            });

            $("#btnReqReceiverAddr").click(function () {
                requestReceiverAddress();
            });

            $("#btnCancel").click(function () {
                history.back();
            });

            $("#btnApply").click(function () {
                requestApply();
            });

            // 보내는분 > 배송지 선택 > 라디오 버튼 이벤트
            $("input:radio[name=sendAddressType]").click(function (key) {
                const sendType = $("input:radio[name=sendAddressType]:checked").val();

                // 보내는 장소가 일반 장소(= 창고X) 일 때
                if (sendType === "0") {
                    $("#trSenderNormalAddress").show();
                    $("#trSenderWarehouseAddress").hide();
                    $("#toWarehouse").attr('disabled', false);

                    // 일반 배송일 경우, 물품 입력창을 1개만 보여준다.
                    $("#btnAddItem").hide();
                    $('.btnRemove').trigger("click");
                } else {
                    // 보내는 장소가 창고일 때
                    $("#trSenderNormalAddress").hide();
                    $("#trSenderWarehouseAddress").show();
                    $("#toWarehouse").attr('disabled', true);
                    $("#btnAddItem").show();
                }
            });

            // 받는분 > 배송지 선택 > 라디오 버튼 이벤트
            $("input:radio[name=receiveAddressType]").click(function (key) {
                const receiveType = $("input:radio[name=receiveAddressType]:checked").val();

                // 받는 장소가 일반 장소(= 창고X) 일 때
                if (receiveType === "0") {
                    $("#trReceiverNormalAddress").show();
                    $("#trReceiverWarehouseAddress").hide();
                    $("#fromWarehouse").attr('disabled', false);

                    // 일반 배송일 경우, 물품 입력창을 1개만 보여준다.
                    $("#btnAddItem").hide();
                    $('.btnRemove').trigger("click");
                } else {
                    // 받는 장소가 창고일 때
                    $("#trReceiverNormalAddress").hide();
                    $("#trReceiverWarehouseAddress").show();
                    $("#fromWarehouse").attr('disabled', true);
                    $("#btnAddItem").show();
                }
            });

            // 물품 추가 버튼
            $("#btnAddItem").click(function (key) {
                addInputItem(false);
            });
        });

        // 택배 신청하기
        function requestApply() {
            if (validate()) {
                checkOrder();
            }
        }

        function validate() {
            // 보내는 사람 데이터 확인
            const senderName = document.getElementById("senderName");

            const senderPhone1 = document.getElementById("senderPhone1");
            const senderPhone2 = document.getElementById("senderPhone2");
            const senderPhone3 = document.getElementById("senderPhone3");

            const senderPostcode = document.getElementById("senderPostcode");
            const senderAddress = document.getElementById("senderAddress");

            // 받는 사람 데이터 확인
            const receiverName = document.getElementById("receiverName");

            const receiverPhone1 = document.getElementById("receiverPhone1");
            const receiverPhone2 = document.getElementById("receiverPhone2");
            const receiverPhone3 = document.getElementById("receiverPhone3");

            const receiverPostcode = document.getElementById("receiverPostcode");
            const receiverAddress = document.getElementById("receiverAddress");

            // ---------------------- 보내는 사람 데이터 입력 확인 ----------------------
            if (senderName.value === "") {
                alert("보내는 분의 이름을 입력해주세요.");
                senderName.focus();
                return false;
            }

            if (senderPhone1.value === "") {
                alert("휴대폰 번호를 확인해주세요.");
                senderPhone1.focus();
                return false;
            }

            if (senderPhone2.value === "") {
                alert("휴대폰 번호를 확인해주세요.");
                senderPhone2.focus();
                return false;
            }

            if (senderPhone3.value === "") {
                alert("휴대폰 번호를 확인해주세요.");
                senderPhone3.focus();
                return false;
            }

            const sendType = $("input:radio[name=sendAddressType]:checked").val();
            if (sendType === "0") {
                if (senderPostcode.value === "" || senderAddress.value === "") {
                    alert("주소를 입력해주세요.");
                    senderPostcode.focus();
                    return false;
                }
            }

            // ---------------------- 받는 사람 데이터 입력 확인 ----------------------

            if (receiverName.value === "") {
                alert("보내는 분의 이름을 입력해주세요.");
                receiverName.focus();
                return false;
            }

            if (receiverPhone1.value === "") {
                alert("휴대폰 번호를 확인해주세요.");
                receiverPhone1.focus();
                return false;
            }

            if (receiverPhone2.value === "") {
                alert("휴대폰 번호를 확인해주세요.");
                receiverPhone2.focus();
                return false;
            }

            if (receiverPhone3.value === "") {
                alert("휴대폰 번호를 확인해주세요.");
                receiverPhone3.focus();
                return false;
            }

            const receiveType = $("input:radio[name=receiveAddressType]:checked").val();
            if (receiveType === "0") {
                if (receiverPostcode.value === "" || receiverAddress.value === "") {
                    alert("주소를 입력해주세요.");
                    receiverPostcode.focus();
                    return false;
                }
            }

            return true;
        }

        // 다음 우편번호 API 팝업
        function requestSenderAddress() {
            new daum.Postcode({
                oncomplete: function (data) {
                    let addr = ''; // 주소 변수

                    // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('senderPostcode').value = data.zonecode;
                    document.getElementById("senderAddress").value = addr;

                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("senderDetailAddress").focus();
                }
            }).open();
        }

        // 다음 우편번호 API 팝업
        function requestReceiverAddress() {
            new daum.Postcode({
                oncomplete: function (data) {
                    let addr = ''; // 주소 변수

                    // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('receiverPostcode').value = data.zonecode;
                    document.getElementById("receiverAddress").value = addr;

                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("receiverDetailAddress").focus();
                }
            }).open();
        }

        /**
         * 동적으로 아이템 입력값을 만든다.
         * 처음에 생성도니 input 태크는 삭제 버틑을 추가하지 않음
         */
        function addInputItem(isFirst) {
            if (!isFirst) {
                $("#itemContainer").append(
                    '<div style="display: flex; flex-direction: row;">' +
                    '<input type="text" class="form-control input-lg input-name mt-2" name="itemInfo">' +
                    '<input type="button" class="btn btnRemove mt-2" value="삭제"><br>' +
                    '</div>'
                );

                $('.btnRemove').on('click', function () {
                    $(this).prev().remove();
                    $(this).next().remove();
                    $(this).remove();
                });
            } else {
                $("#itemContainer").append(
                    '<div style="display: flex; flex-direction: row;">' +
                    '<input type="text" class="form-control input-lg input-name mt-2" name="itemInfo" placeholder="ex) 전자제품">' +
                    '</div>'
                );
            }
        }

        // 주문예약 validation check
        function checkOrder() {
            /*
            if ($("input:radio[name=sort]:checked").val() == null) {
                alert("결제방식을 선택하세요.");
                return;
            }
            */
            const sendType = $("input:radio[name=sendAddressType]:checked").val();
            const receiveType = $("input:radio[name=receiveAddressType]:checked").val();

            if (sendType === "1") {
                const address = $("#sendWarehouse").val();
                const arr = address.split(",");

                $("#senderPostcode").val(arr[0]);
                $("#senderAddress").val(arr[1]);
                $("#senderDetailAddress").val('');
            }

            if (receiveType === "2") {
                const address = $("#receiveWarehouse").val();
                const arr = address.split(",");

                $("#receiverPostcode").val(arr[0]);
                $("#receiverAddress").val(arr[1]);
                $("#receiverDetailAddress").val('');
            }

            const inputPayMethod = document.createElement("input");
            inputPayMethod.setAttribute("name", "checkPayMethod");
            inputPayMethod.setAttribute("value", 'P');

            const form = document.getElementById("logisReservation");
            form.appendChild(inputPayMethod);
            form.submit();
        }
    </script>
    <style>
        body {
            background-color: white;
        }

        #wrap {
            width: 720px;
            height: 93vh;
            background-color: white;
            margin: 0 auto;
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
            background-color: #0E2F91;
        }

        .section {
            width: 100%;
            height: 93vh;
        }

        h4 {
            font-weight: 600;
            text-align: center;
            font-size: 2.4em;
            margin-bottom: 5%;
            margin-top: 5%;
        }

        .table-top {
            /*padding: 18px 30px 15px 0;*/
            padding: 18px 30px 15px;
            border-top: 4px solid #0E2F91;
            border-bottom: 1px solid lightgrey;
            margin-bottom: 15px;
            background: #fafafa;
        }

        table {
            width: 100%;
        }

        table, th {
            padding: 10px 10px 16px 20px;
        }

        .tr-border-top {
            border-top: 1px solid lightgrey;
        }

        thead {
            display: table-header-group;
        }

        td {
            padding: 10px 10px;
        }

        .form-table {
            margin-bottom: 56px;
        }

        .form-table-wrap {
            display: flex;
            align-items: center;
        }

        label {
            font-size: large;
        }

        .input-type-1, .input-type-1:read-only {
            margin-top: 2%;
            background-color: white;
        }

        .button-type-1 {
            margin-top: 2%;
            margin-left: 2%;
        }

        .form-title {
            font-size: 1.3em;
        }

        .div-result {
            border-top: 1px solid lightgrey;
            margin-top: 5%;
            padding: 5% 0 10% 0;
            margin-bottom: 5%;
            display: flex;
            justify-content: space-between;
        }

        .input-name {
            width: 60%;
        }

        .input-phone {
            width: 30%;
        }

        .input-address {
            width: 90%;
        }

        .input-postcode {
            width: 40%;
        }

        .div-pay-box {
            margin-top: 7%;
            display: grid;
            grid-template-columns: 5fr 5fr;
            justify-content: space-between;
            margin-bottom: 3%;
        }

        .div-send-type-box {
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
            width: 45%;
            background-color: #0E2F91;
        }

        .btn-cancel {
            font-weight: 600;
            font-size: 1.2rem;
            width: 45%;
        }

        .btnRemove {
            background-color: #0E2F91;
            color: white;
            margin-left: 2%;
        }
    </style>
</head>
<body>
<div class="header">
</div>
<div id="wrap">
    <div class="section">
        <h4>물류 예약하기</h4>
        <form id="logisReservation" name="logisReservation" method="post" action="/user/logis/order">
            <div class="form-table">
                <table>
                    <colgroup>
                        <col style="width: 25%">
                        <col style="width: 75%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="row" colspan="2" class="pl-0 pr-0">
                            <div class="table-top">
                                <strong class="form-title">보내는 분</strong>
                            </div>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th scope="row">
                            <label>배송지 선택</label>
                        </th>
                        <td>
                            <div class="div-send-type-box">
                                <label for="fromNormal">
                                    <input class="input-radio" type="radio" value="0" name="sendAddressType"
                                           id="fromNormal"
                                           style="width: 1.1em; height: 1.1em; margin-right: 5%; align-self: center;"
                                           checked>
                                    일반 배송
                                </label>
                                <label for="fromWarehouse">
                                    <input class="input-radio" type="radio" value="1" name="sendAddressType"
                                           id="fromWarehouse"
                                           style="width: 1.1em; height: 1.1em; margin-right: 5%; align-self: center;">
                                    공유 창고에서 배송
                                </label>
                            </div>
                        </td>
                    </tr>
                    <tr id="trSenderName">
                        <th scope="row">
                            <label for="senderName">이름</label>
                        </th>
                        <td>
                            <input class="form-control input-lg input-name" type="text" id="senderName"
                                   name="senderName"
                                   value="테스형" maxlength="30">
                        </td>
                    </tr>
                    <tr id="trSenderPhone">
                        <th scope="row">
                            <label>연락처</label>
                        </th>
                        <td>
                            <ul>
                                <li style="display: list-item">
                                    <div class="form-table-wrap mb-2">
                                        <input class="form-control input-lg input-phone" type="tel" id="senderPhone1"
                                               name="senderPhone1" maxlength="4" value="010"
                                               oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');">
                                        <span style="margin-left: 1%; margin-right: 1%">-</span>
                                        <input class="form-control input-lg input-phone" type="tel" id="senderPhone2"
                                               name="senderPhone2" maxlength="4" value="1000"
                                               oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');">
                                        <span style="margin-left: 1%; margin-right: 1%">-</span>
                                        <input class="form-control input-lg input-phone" type="tel" id="senderPhone3"
                                               name="senderPhone3" maxlength="4" value="0000"
                                               oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');">
                                    </div>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    <tr id="trSenderNormalAddress" class="tr-border-top">
                        <th scope="row">
                            <label>주소</label>
                        </th>
                        <td>
                            <div class="form-table-wrap">
                                <input class="form-control input-lg input-type-1 input-postcode" type="text"
                                       id="senderPostcode"
                                       name="senderPostcode"
                                       value="07293" maxlength="30" readonly>

                                <input id="btnReqSenderAddr" name="btnReqSenderAddr" type="button"
                                       class="btn btn-logis-primary button-type-1" value="우편번호 찾기">
                            </div>
                            <div class="form-table-wrap">
                                <input class="form-control input-lg input-type-1 input-address" type="text"
                                       id="senderAddress"
                                       name="senderAddress"
                                       value="서울 영등포구 문래동3가 46" readonly>
                            </div>
                            <div class="form-table-wrap">
                                <input class="form-control input-lg input-type-1 input-address" type="text"
                                       id="senderDetailAddress"
                                       name="senderDetailAddress"
                                       value="1404호">
                            </div>
                        </td>
                    </tr>
                    <tr id="trSenderWarehouseAddress" class="tr-border-top" style="display: none;">
                        <th scope="row">
                            <label>창고 목록</label>
                        </th>
                        <td>
                            <div class="form-table-wrap">
                                <select class="form-control" id="sendWarehouse"
                                        style="width: 50%; margin-right: 2%">
                                    <c:forEach var="data" items="${warehouseNameList}">
                                        <option value="${data.warehousePostcode},${data.warehouseAddress}">${data.warehouseName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <%-- 받는 분 --%>
            <div class="form-table">
                <table>
                    <colgroup>
                        <col style="width: 25%">
                        <col style="width: 75%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="row" colspan="2" class="pl-0 pr-0">
                            <div class="table-top">
                                <strong class="form-title">받는 분</strong>
                            </div>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th scope="row">
                            <label>배송지 선택</label>
                        </th>
                        <td>
                            <div class="div-send-type-box">
                                <label for="toNormal">
                                    <input class="input-radio" type="radio" value="0" name="receiveAddressType"
                                           id="toNormal"
                                           style="width: 1.1em; height: 1.1em; margin-right: 5%; align-self: center;"
                                           checked>
                                    일반 배송
                                </label>
                                <label for="toWarehouse">
                                    <input class="input-radio" type="radio" value="1" name="receiveAddressType"
                                           id="toWarehouse"
                                           style="width: 1.1em; height: 1.1em; margin-right: 5%; align-self: center;">
                                    공유 창고로 배송
                                </label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <label for="senderName">이름</label>
                        </th>
                        <td>
                            <input class="form-control input-lg input-name" type="text" id="receiverName"
                                   name="receiverName" maxlength="30" value="테스터">
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <label>연락처</label>
                        <td>
                            <ul>
                                <li style="display: list-item">
                                    <div class="form-table-wrap mb-2">
                                        <input class="form-control input-lg input-phone" type="tel" id="receiverPhone1"
                                               name="receiverPhone1" maxlength="4" value="010"
                                               oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');">
                                        <span style="margin-left: 1%; margin-right: 1%;">-</span>
                                        <input class="form-control input-lg input-phone" type="tel" id="receiverPhone2"
                                               name="receiverPhone2" maxlength="4" value="0000"
                                               oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');">
                                        <span style="margin-left: 1%; margin-right: 1%">-</span>
                                        <input class="form-control input-lg  input-phone" type="tel" id="receiverPhone3"
                                               name="receiverPhone3" maxlength="4" value="1001"
                                               oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');">
                                    </div>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    <tr id="trReceiverNormalAddress" class="tr-border-top">
                        <th scope="row">
                            <label>주소</label>
                        </th>
                        <td>
                            <div class="form-table-wrap">
                                <input class="form-control input-lg input-type-1 input-postcode" type="text"
                                       id="receiverPostcode"
                                       name="receiverPostcode" value="07299" maxlength="30" readonly>

                                <input id="btnReqReceiverAddr" name="btnReqReceiverAddr" type="button"
                                       class="btn btn-logis-primary button-type-1" value="우편번호 찾기">
                            </div>
                            <div class="form-table-wrap">
                                <input class="form-control input-lg input-type-1 input-address" type="text"
                                       id="receiverAddress"
                                       name="receiverAddress" value="서울 영등포구 문래동3가 55-20" readonly>
                            </div>
                            <div class="form-table-wrap">
                                <input class="form-control input-lg input-type-1 input-address" type="text"
                                       id="receiverDetailAddress"
                                       name="receiverDetailAddress" value="303호">
                            </div>
                        </td>
                    </tr>
                    <tr id="trReceiverWarehouseAddress" class="tr-border-top" style="display: none;">
                        <th scope="row">
                            <label>창고 목록</label>
                        </th>
                        <td>
                            <div class="form-table-wrap">
                                <select class="form-control" id="receiveWarehouse"
                                        style="width: 50%; margin-right: 2%">
                                    <c:forEach var="data" items="${warehouseNameList}">
                                        <option value="${data.warehousePostcode},${data.warehouseAddress}">${data.warehouseName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <%-- 배송 선택 --%>
            <div class="form-table">
                <table>
                    <colgroup>
                        <col style="width: 25%">
                        <col style="width: 75%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="row" colspan="2" class="pl-0 pr-0">
                            <div class="table-top">
                                <strong class="form-title">상세 정보</strong>
                            </div>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <%-- 몇 톤을 실을 것 인지 --%>
                    <%-- 예상 가격 --%>
                    <tr>
                        <th scope="row">
                            <label>중량</label>
                        <td>
                            <div class="form-table-wrap">
                                <select class="form-control" id="weight" name="weight"
                                        style="width: 30%; margin-right: 2%">
                                    <option value="0.5">0.5</option>
                                    <option value="1">1</option>
                                    <option value="1.5">1.5</option>
                                    <option value="2">2</option>
                                    <option value="2.5">2.5</option>
                                </select>

                                <label>톤</label>
                            </div>
                        </td>
                    </tr>
                    <tr style="display: none;">
                        <th scope="row">
                            <label>결제방법</label>
                        </th>
                        <td>
                            <div class="div-pay-box">
                                <label for="payZero">
                                    <input class="input-radio" type="radio" value="Z" name="sort" id="payZero"
                                           style="width: 1.1em; height: 1.1em; margin-right: 5%">
                                    <img src="/images/zeropay.png" height="14"/>
                                </label>
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
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <label>물품 설명</label>
                        </th>
                        <td>
                            <div id="itemContainer" class="form-group">
                                <%-- 여기 --%>
                                <input type="button" id="btnAddItem" name="bntAddItem" class="btn btn-logis-primary"
                                       value="추가하기"/>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <%-- 하단에서 택배를 신청하고 취소할 수 있는 버튼 --%>
            <div class="div-result">
                <input id="btnCancel" type="button" class="btn btn-logis-outline-primary btn-cancel" value="취소하기"
                       style="width: 45%">
                <input id="btnApply" type="button" class="btn btn-pay" value="간편결제">
            </div>
        </form>
    </div>
</div>
</body>
</html>
