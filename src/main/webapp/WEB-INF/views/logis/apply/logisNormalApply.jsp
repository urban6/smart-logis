<%--
  Created by IntelliJ IDEA.
  User: jeonseungcheol
  Date: 2020/11/05
  Time: 10:01 오전
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
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
<%--    <link rel="stylesheet" href="<c:url value='/css/reset.css'/>">--%>
    <%-- Bootstrap core CSS --%>
    <link rel="stylesheet" href="<c:url value ='/assets/libs/bootstrap-4.5.3/css/bootstrap.min.css'/>">
    <%-- Material Design Bootstrap CSS --%>
    <link rel="stylesheet" href="<c:url value='/js/core.min.js'/>">
    <%-- Custom CSS --%>
<%--    <link rel="stylesheet" href="<c:url value='/css/content_logis.css'/>">--%>
    <%-- FontAwesome --%>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">

    <%--  Bootstrap 5.0 --%>
    <link rel="stylesheet" href="<c:url value='/assets/libs/bootstrap-5.0.0/css/bootstrap.min.css'/>">

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

            // 대여중인 창고가 없을 경우, 창고를 먼저 빌려라는 알림창이 떠야한다.

            // 회원정보 자동완성
            $('input[name=toWhseUserInfo]').click(function () {
                const value = $(this).val();
                if (value == 0) {
                    $("#toWhseSenderName").val("${userInfo.managerName}");
                    $("#toWhseSenderPhone").val("${userInfo.phoneNumber}");
                    $("#toWhseSenderPostcode").val("${userInfo.postcode}");
                    $("#toWhseSenderAddress").val("${userInfo.address}");
                    $("#toWhseSenderDetailAddress").val("${userInfo.detailAddress}");
                } else {
                    $("#toWhseSenderName").val("");
                    $("#toWhseSenderPhone").val("");
                    $("#toWhseSenderPostcode").val("");
                    $("#toWhseSenderAddress").val("");
                    $("#toWhseSenderDetailAddress").val("");
                }
            });

            // 배송 물품 타입 설정
            $('input[name=toWhseInfoType]').click(function () {
                const value = $(this).val();
                if (value == 0) {
                    // 팔렛트를 보낼 때
                    $("#containerPalette").css("display", "block");
                    $("#containerBox").css("display", "none");
                    $("#toWhseBoxCount").val('');
                } else {
                    // 박스를 보낼 때
                    $("#containerPalette").css("display", "none");
                    $("#containerBox").css("display", "block");
                    $("#toWhsePaletteCount").val('');
                }
            });

            // $("#btnAddItem").hide();
            // addInputItem(true);

            // 신청하기
            $('#btnToWhseApply').click(function (key) {
                if(validate()) {
                    payOrder();
                }
            });

            // 대여중인 창고가 없을 경우, 라디오 버튼 비활성화
            <c:if test="${warehouseNameList.size() eq 0}">
            $("#fromWarehouse").attr('disabled', true);
            $("#toWarehouse").attr('disabled', true);
            </c:if>

            $("#btnReqSenderAddr").click(function () {
                requestAddress("send");
            });

            $("#btnReqReceiverAddr").click(function () {
                requestAddress("receive");
            });

            $("#btnCancel").click(function () {
                history.back();
            });

            // 신청 또는 결제 버튼
            $("#btnApply").click(function () {
                requestApply();
            });

            // 묶음 배송 경고
            $("#selectBundle").change(function (key) {
                const value = $("#selectBundle option:selected").val();
                if (value == "B") {
                    alert("공유 배송 이용자가 충분하지 않을 경우, 배송 지연이 있을 수도 있습니다.");
                }
            });

            // 보내는분 > 배송지 선택 > 라디오 버튼 이벤트
            $("input:radio[name=sendAddressType]").click(function (key) {
                const sendType = $("input:radio[name=sendAddressType]:checked").val();

                // 보내는 장소가 일반 장소(= 창고X) 일 때
                if (sendType === "0") {
                    $("#trSenderNormalAddress").show();
                    $("#trSenderWarehouseAddress").hide();
                    $("#toWarehouse").attr('disabled', false);

                    $("#trSelectBundle").show();

                    // 일반 배송일 경우, 물품 입력창을 1개만 보여준다.
                    $("#btnAddItem").hide();
                    $('.btnRemove').trigger("click");

                    $("#btnApply").val('신청하기');
                } else {
                    // 보내는 장소가 창고일 때
                    $("#trSenderNormalAddress").hide();
                    $("#trSenderWarehouseAddress").show();
                    $("#toWarehouse").attr('disabled', true);
                    $("#btnAddItem").show();

                    $("#trSelectBundle").hide();

                    $("#btnApply").val('신청하기');
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

                    $("#trSelectBundle").show();

                    // 일반 배송일 경우, 물품 입력창을 1개만 보여준다.
                    $("#btnAddItem").hide();
                    $('.btnRemove').trigger("click");

                    $("#btnApply").val('신청하기');
                } else {
                    // 받는 장소가 창고일 때
                    $("#trReceiverNormalAddress").hide();
                    $("#trReceiverWarehouseAddress").show();
                    $("#fromWarehouse").attr('disabled', true);
                    $("#btnAddItem").show();

                    $("#trSelectBundle").hide();

                    // 신청 버튼을 결제 버튼으로 변경한다.
                    $("#btnApply").val('간편결제');
                }
            });

            // 물품 추가 버튼
            $("#btnAddItem").click(function (key) {
                addInputItem(false);
            });

            $('#inputSenderName').focusout(function () {
                if ($(this).val().length == 0) {
                    $(this).removeClass('is-valid');
                    $(this).addClass('is-invalid');
                } else {
                    $(this).removeClass('is-invalid');
                    $(this).addClass('is-valid');
                }
            });

            $('#senderPhone').focusout(function () {
                /*let num = $(this).val();
                $(this).val(num.replace(/[^0-9]/g, ''));*/
            });
        });

        /**
         * 숫자만 입력 가능
         */
        function specialCharRemove(obj) {
            const value = obj.value;
            const pattern = /[^(0-9)]/gi;
            if (pattern.test(value)) {
                obj.value = value.replace(pattern, "");
            }
        }

        function validate() {
            if ($('#toWhseSenderName').val() == "") {
                alert("담당자를 입력해주세요.");
                $('#toWhseSenderName').focus();
                return false;
            }

            if ($('#toWhseSenderPhone').val() == "") {
                alert("연락처를 입력해주세요.");
                $('#toWhseSenderPhone').focus();
                return false;
            }

            if ($('#toWhseSenderPostcode').val() == "" || $('#toWhseSenderAddress').val() == "") {
                alert("주소를 입력해주세요.");
                return false;
            }

            const itemType = $('input:radio[name=toWhseInfoType]:checked').val();
            if (itemType == "0") { // 팔렛트 배송
                if ($('#toWhsePaletteCount').val() == "") {
                    alert("팔렛트 수를 입력해주세요.");
                    $('#toWhsePaletteCount').focus();
                    return false;
                }
            } else {
                // 박스 배송
                if ($('#toWhseBoxCount').val() == "") {
                    alert("박스 수를 입력해주세요.");
                    $('#toWhseBoxCount').focus();
                    return false;
                }
            }

            return true;
        }

        // 택배 신청하기
        function requestApply() {
            if (validate()) {
                // 받는 곳이 창고일 경우, 결제 화면으로 이동한다.
                const receiveType = $("input:radio[name=receiveAddressType]:checked").val();
                if (receiveType == "1") {
                    payOrder();
                } else {
                    // 나머지는 신청만 한다.
                    order();
                }
            }
        }

        /**
         * 입력 받은 데이터 검증
         */
        function validate_prev() {
            // ---------------------- 보내는 사람 데이터 입력 확인 [ 이름, 연락처, 받는 타입(0:일반 배송, 1:창고에서 배송)----------------------
            if ($("#senderName").val() == "") {
                alert("보내는 분의 이름을 입력해주세요.");
                $("#senderName").focus();
                return false;
            }

            if ($("#senderPhone1").val() == "" || $("#senderPhone2").val() == "" || $("#senderPhone3").val() == "") {
                alert("휴대폰 번호를 확인해주세요.");
                return false;
            }

            const sendType = $("input:radio[name=sendAddressType]:checked").val();
            if (sendType === "0") {
                if ($("#senderPostcode").val() == "" || $("#senderAddress").val() == "") {
                    alert("주소를 입력해주세요.");
                    return false;
                }
            }

            // ---------------------- 받는 사람 데이터 입력 확인 [ 이름, 연락처, 받는 타입(0:일반 배송, 1:창고로 배송)----------------------

            if ($("#receiverName").val() == "") {
                alert("보내는 분의 이름을 입력해주세요.");
                $("#receiverName").focus();
                return false;
            }

            if ($("#receiverPhone1").val() == "" || $("#receiverPhone2").val() == "" || $("#receiverPhone3").val() == "") {
                alert("휴대폰 번호를 확인해주세요.");
                return false;
            }

            const receiveType = $("input:radio[name=receiveAddressType]:checked").val();
            if (receiveType === "0") {
                if ($("#receiverPostcode").val() == "" || $("#receiverAddress").val() == "") {
                    alert("주소를 입력해주세요.");
                    return false;
                }
            }

            // 물품 정보 입력 여부
            if ($("input[name=itemInfo]").val() == "") {
                alert("물품 정보를 입력해주세요.");
                $("input[name=itemInfo]").focus();
                return false;
            }

            return true;
        }

        /**
         * 주소 검색
         * type -  [send: 보내는 주소, receive: 받는 주소]
         */
        function requestAddress(type) {
            new daum.Postcode({
                oncomplete: function (data) {
                    let addr = ''; // 주소 변수

                    // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 보내는 분 주소 입력
                    if (type == "send") {
                        $("#senderPostcode").val(data.zonecode);
                        $("#senderAddress").val(addr);
                        $("#senderDetailAddress").focus();
                    } else if (type == "receive") { // 받는 분 주소
                        $("#receiverPostcode").val(data.zonecode);
                        $("#receiverAddress").val(addr);
                        $("#receiverDetailAddress").focus();
                    }
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
                    '<input type="text" class="form-control mt-2" name="itemInfo">' +
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
                    '<input type="text" class="form-control" name="itemInfo" placeholder="ex) 전자제품">' +
                    '</div>'
                );
            }
        }

        /**
         * 창고로 배송할 때 사용
         */
        function payOrder() {

            // 출발지 주소 설정
            let senderAddress;
            if ($("#senderDetailAddress").val() == "") {
                senderAddress = $("#toWhseSenderAddress").val();
            } else {
                senderAddress = $("#toWhseSenderAddress").val() + ' ' + $("#toWhseSenderDetailAddress").val();
            }

            // 도착지[창고] 주소 설정
            const address = $("#toWhseSelect").val();
            const arr = address.split(",");
            let receiverPostcode = arr[0];
            let receiverAddress = arr[1];
            let warehouseOrderUid = arr[2];

            // 물품 정보
            let itemInfo = "";
            const length = $("input[name=itemInfo]").length;
            for (let i = 0; i < length; i++) {
                itemInfo += $("input[name=itemInfo]").eq(i).val();
                itemInfo += ",";
            }
            itemInfo = itemInfo.slice(0, -1);

            $.ajax("/user/logis/payOrder",
                {
                    method: 'POST',
                    data: {
                        "senderName": $("#toWhseSenderName").val(),
                        "senderPhone": $("#toWhseSenderPhone").val(),
                        "senderAddress": senderAddress,
                        "senderPostcode": $("#toWhseSenderPostcode").val(),
                        "receiverName": $("#toWhseSenderName").val(),
                        "receiverPhone": $("#toWhseSenderPhone").val(),
                        "receiverAddress": receiverAddress,
                        "receiverPostcode": receiverPostcode,
                        "boxCount": Number($("#toWhseBoxCount").val()),
                        "paletteCount": Number($("#toWhsePaletteCount").val()),
                        "wishDeliveryDatetime": $("#wishDeliveryDatetime").val(),
                        "itemInfo": itemInfo,
                        "warehouseOrderUid": warehouseOrderUid
                    },
                    dataType: 'JSON'
                }
            ).done(function (data) {
                const result = data.result;
                if (result) {
                    movePayPage(data.isStatus, data.boxCount, data.paletteCount);
                }
            });
        }

        /**
         * 창고로 배송할 때 사용
         * Deprecated
         */
        function payOrder_prev() {
            // 보내는 분 연락처, 주소 설정
            const senderPhone = $("#senderPhone1").val() + $("#senderPhone2").val() + $("#senderPhone3").val();
            const senderAddress = $("#senderAddress").val() + " " + $("#senderDetailAddress").val();

            // 받는 분 연락처 주소 설정
            const receiverPhone = $("#receiverPhone1").val() + $("#receiverPhone2").val() + $("#receiverPhone3").val();

            const address = $("#receiveWarehouse").val();
            const arr = address.split(",");
            $("#receiverPostcode").val(arr[0]);
            $("#receiverAddress").val(arr[1]);
            $("#receiverDetailAddress").val('');

            // 물품 정보
            let itemInfo = "";
            const length = $("input[name=itemInfo]").length;
            for (let i = 0; i < length; i++) {
                itemInfo += $("input[name=itemInfo]").eq(i).val();
                itemInfo += ",";
            }
            itemInfo = itemInfo.slice(0, -1);

            // 시작
            $.ajax("/user/logis/payOrder",
                {
                    method: 'POST',
                    data: {
                        "senderName": $("#senderName").val(),
                        "senderPhone": senderPhone,
                        "senderAddress": senderAddress,
                        "senderPostcode": $("#senderPostcode").val(),
                        "receiverName": $("#receiverName").val(),
                        "receiverPhone": receiverPhone,
                        "receiverAddress": $("#receiverAddress").val(),
                        "receiverPostcode": $("#receiverPostcode").val(),
                        "boxCount": Number($("#boxCount").val()),
                        "paletteCount": Number($("#paletteCount").val()),
                        "wishDeliveryDatetime": $("#wishDeliveryDatetime").val(),
                        "itemInfo": itemInfo
                    },
                    dataType: 'JSON'
                }
            ).done(function (data) {
                const result = data.result;
                if (result) {
                    movePayPage(data.isStatus, data.boxCount, data.paletteCount);
                }
            });
        }

        function order() {
            // 배송 타입 설정
            let logisType = 0;

            // 연락처
            const senderPhone = $("#senderPhone1").val() + $("#senderPhone2").val() + $("#senderPhone3").val();
            const receiverPhone = $("#receiverPhone1").val() + $("#receiverPhone2").val() + $("#receiverPhone3").val();

            // 창고에서 일반 배송지로 보내는 경우에만
            // sendWarehouse에 있는 데이터 중에서 전달 받은 창고 주소와 우편번호를 설정한다.
            if ($("input:radio[name=sendAddressType]:checked").val() == "1") {
                const address = $("#sendWarehouse").val();
                const arr = address.split(",");
                $("#senderPostcode").val(arr[0]);
                $("#senderAddress").val(arr[1]);
                $("#senderDetailAddress").val('');

                logisType = 2;
            }

            // 묶음 배송 여부 확인
            const bundle = $("#selectBundle option:selected").val();

            // 주소
            const senderAddress = ($("#senderAddress").val() + " " + $("#senderDetailAddress").val()).trim();
            const receiverAddress = ($("#receiverAddress").val() + " " + $("#receiverDetailAddress").val()).trim();

            // 물품 정보
            let itemInfo = "";
            const length = $("input[name=itemInfo]").length;
            for (let i = 0; i < length; i++) {
                itemInfo += $("input[name=itemInfo]").eq(i).val();
                itemInfo += ",";
            }
            itemInfo = itemInfo.slice(0, -1);

            $.ajax("/user/logis/order",
                {
                    method: 'POST',
                    data: {
                        "senderName": $("#senderName").val(),
                        "senderPhone": senderPhone,
                        "senderAddress": senderAddress,
                        "senderPostcode": $("#senderPostcode").val(),
                        "receiverName": $("#receiverName").val(),
                        "receiverPhone": receiverPhone,
                        "receiverAddress": receiverAddress,
                        "receiverPostcode": $("#receiverPostcode").val(),
                        "boxCount": Number($("#boxCount").val()),
                        "paletteCount": Number($("#paletteCount").val()),
                        "wishDeliveryDatetime": $("#wishDeliveryDatetime").val(),
                        "bundle": bundle,
                        "logisType": logisType,
                        "itemInfo": itemInfo
                    },
                    dataType: 'JSON'
                }
            ).done(function (data) {
                if (data.result) {
                    alert("택배 신청이 완료되었습니다.");

                    const form = document.createElement('form');
                    form.setAttribute('method', 'POST');
                    form.setAttribute('action', '/user/home/home');
                    document.body.appendChild(form);
                    form.submit();
                }
            });
        }

        function movePayPage(isStatus, boxCount, paletteCount) {
            const inputIsStatus = document.createElement("input");
            inputIsStatus.setAttribute("name", "isStatus");
            inputIsStatus.setAttribute("value", isStatus);

            const inputBox = document.createElement("input");
            inputBox.setAttribute("name", "boxCount");
            inputBox.setAttribute("value", Number(boxCount));

            const inputPalette = document.createElement("input");
            inputPalette.setAttribute("name", "paletteCount");
            inputPalette.setAttribute("value", Number(paletteCount));

            const form = document.createElement('form');
            form.setAttribute('method', 'POST');
            form.setAttribute('action', '/user/logis/paying');
            document.body.appendChild(form);
            form.appendChild(inputIsStatus);
            form.appendChild(inputBox);
            form.appendChild(inputPalette);
            form.submit();
        }
    </script>
    <style>
        body {
            background-color: white;
        }

        #wrap {
            width: 800px;
            height: 93vh;
            background-color: white;
            margin: 0 auto;
            margin-top: 1500px;
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
            height: 93vh;
            padding-top: 5%;
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
            background: #D2EAFF;
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
            /*font-size: large;*/
        }

        .input-type-1, .input-type-1:read-only {
            margin-top: 2%;
            background-color: white;
        }

        .button-type-1 {
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

        .div-horizon-box {
            display: flex;
            flex-direction: row;
        }

        .input-name {
            width: 60%;
        }

        label {
            display: flex;
            flex-direction: row;
        }

        .btnRemove {
            background-color: #0E2F91;
            color: white;
            margin-left: 2%;
        }

        /* 탭 관련 CSS */
        .content {
            padding-top: 30px;
            width: 700px;
            height: auto;
            margin: 0 auto;
        }

        .nav-pills .nav-link {
            font-weight: bold;
            padding-top: 13px;
            text-align: center;
            background: #343436;
            color: #fff;
            border-radius: 8px;
            height: 100px;
        }

        .nav-pills .nav-link.active {
            background: #fff;
            color: #000;
            border-radius: 8px;
        }

        .tab-content {
            position: absolute;
            width: 700px;
            height: auto;
            /*margin-top: -50px;*/
            background: #fff;
            color: #000;
            border-radius: 0 0 8px 8px;
            z-index: 1000;
            box-shadow: 0px 10px 10px rgba(0, 0, 0, 0.4);
            padding: 30px;
            margin-bottom: 200px;
        }

        /*.tab-content .input-apply {*/
        /*    width: 120px;*/
        /*    margin: 0 auto;*/
        /*    float: right;*/
        /*}*/

        .input-apply {
            width: 150px;
            margin-right: 15px;
            float: right;
        }


        .i-size-1 {
            color: #8b62ff;
            font-size: 0.5rem;
        }

    </style>
</head>
<body>
<div class="header">
    <span class="header-title">물류 배송 예약하기</span>
</div>
<div class="content">
    <div class="tab-content">
        <div id="toWarehouse" class="container tab-pane active">
            <form>
                <div class="form-group col-12 mt-4">
                    <h3>보내는 분</h3>
                </div>
                <div class="form-group form-check-inline col-12" style="padding-left: 15px;">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="toWhseUserInfo" id="defaultInfo" value="0"
                               checked>
                        <label class="form-check-label" for="defaultInfo">기존정보</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="toWhseUserInfo" id="newInfo" value="1">
                        <label class="form-check-label" for="newInfo">신규정보</label>
                    </div>
                </div>
                <div class="form-group col-12">
                    <label for="toWhseSenderName">담당자<i class="fas fa-asterisk i-size-1"></i></label>
                    <input type="text" class="form-control" id="toWhseSenderName"
                           placeholder="담당자" value="${userInfo.managerName}">
                </div>
                <div class="form-group col-12">
                    <label for="toWhseSenderPhone">연락처<i class="fas fa-asterisk i-size-1"></i></label>
                    <input type="tel" class="form-control" id="toWhseSenderPhone" onkeyup='specialCharRemove(this)'
                           placeholder="- 를 빼고 입력해주세요." value="${userInfo.phoneNumber}">
                </div>
                <div class="form-group col-12">
                    <label for="toWhseSenderPostcode">주소<i class="fas fa-asterisk i-size-1"></i></label>
                    <div class="div-horizon-box">
                        <input type="text" class="form-control" id="toWhseSenderPostcode" placeholder="우편번호"
                               autocomplete="chrome-off" value="${userInfo.postcode}" readonly>
                        <input id="btnReqSenderAddr" name="btnReqSenderAddr" type="button"
                               class="btn btn-primary button-type-1" value="우편번호 찾기">
                    </div>
                </div>
                <div class="form-group col-12">
                    <input type="text" class="form-control" id="toWhseSenderAddress" placeholder="주소"
                           autocomplete="chrome-off" value="${userInfo.address}" readonly>
                </div>
                <div class="form-group col-12">
                    <input type="text" class="form-control" id="toWhseSenderDetailAddress" placeholder="상세주소"
                           value="${userInfo.detailAddress}">
                </div>

                <div class="form-group col-12">
                    <label for="toWhseSelect">보낼 창고선택<i class="fas fa-asterisk i-size-1"></i></label>
                    <select class="form-select" id="toWhseSelect">
                        <c:forEach var="data" items="${warehouseNameList}">
                            <option value="${data.warehousePostcode},${data.warehouseAddress},${data.orderInfoUid}">${data.warehouseName}
                                (대여기간: ${data.startDatetime} ~ ${data.endDatetime})
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group col-12 mt-5">
                    <h3>받는 분</h3>
                </div>
                <div class="form-group col-12">
                    <label for="receiverName">이름<i class="fas fa-asterisk i-size-1"></i></label>
                    <input type="text" class="form-control" id="receiverName"
                           placeholder="이름">
                </div>
                <div class="form-group col-12">
                    <label for="receiverPhone">연락처<i class="fas fa-asterisk i-size-1"></i></label>
                    <input type="tel" class="form-control" id="receiverPhone" onkeyup='specialCharRemove(this)'
                           placeholder="- 를 빼고 입력해주세요.">
                </div>
                <div class="form-group col-12">
                    <label for="receiverPostcode">주소<i class="fas fa-asterisk i-size-1"></i></label>
                    <div class="div-horizon-box">
                        <input type="text" class="form-control" id="receiverPostcode" placeholder="우편번호"
                               autocomplete="chrome-off" readonly>
                        <input id="btnReqReceiverAddr" name="btnReqReceiverAddr" type="button"
                               class="btn btn-primary button-type-1" value="우편번호 찾기">
                    </div>
                </div>
                <div class="form-group col-12">
                    <input type="text" class="form-control" id="receiverAddress" placeholder="주소"
                           autocomplete="chrome-off" readonly>
                </div>
                <div class="form-group col-12">
                    <input type="text" class="form-control" id="receiverDetailAddress" placeholder="상세주소">
                </div>
                <div class="form-group col-12 mt-5">
                    <h3>물류 정보</h3>
                </div>
                <div class="btn-group" role="group" style="margin-left: 15px"
                     aria-label="Basic radio toggle button group">
                    <input type="radio" class="btn-check" name="toWhseInfoType" id="radioPalette" autocomplete="off"
                           checked value="0">
                    <label class="btn btn-outline-primary" style="border-bottom-left-radius: 4px; border-top-left-radius: 4px;" for="radioPalette">팔렛트 배송</label>
                    <input type="radio" class="btn-check" name="toWhseInfoType" id="radioBox" autocomplete="off"
                           value="1">
                    <label class="btn btn-outline-primary" for="radioBox">박스 배송</label>
                </div>
                <div id="containerPalette" class="form-group col-12">
                    <label for="toWhsePaletteCount">팔레트 개수<i class="fas fa-asterisk i-size-1"></i></label>
                    <input type="number" class="form-control" id="toWhsePaletteCount" placeholder="">
                </div>
                <div id="containerBox" class="form-group col-12" style="display: none;">
                    <label for="toWhseBoxCount">박스 개수<i class="fas fa-asterisk i-size-1"></i></label>
                    <input type="number" class="form-control" id="toWhseBoxCount" placeholder="">
                </div>
                <div class="form-group col-12">
                    <label for="wishDeliveryDatetime">희망 배송 날짜<i class="fas fa-asterisk i-size-1"></i></label>
                    <input class="form-control mr-3" type="datetime-local" value=""
                           id="wishDeliveryDatetime" max="9999-12-31">
                </div>
                <div id="itemContainer" class="form-group col-12">
                    <label for="wishDeliveryDatetime">물품정보<i class="fas fa-asterisk i-size-1"></i></label>
                    <input type="text" class="form-control" name="itemInfo" placeholder="ex) 전자제품">
                </div>
                <input id="btnToWhseApply" type="button" class="btn btn-primary input-apply" value="신청하기">
            </form>
        </div>
    </div>
</div>
</body>
</html>