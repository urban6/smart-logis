<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<%@ page import="kr.co.shovvel.dm.domain.logis.order.WarehouseDTO" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>창고 신청 내역 조회</title>

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

    <%-- ProgressBar Library  --%>
    <script src="<c:url value='/js/nprogress.js'/>"></script>
    <link rel='stylesheet' href="<c:url value='/css/nprogress.css'/>"/>

    <script type="text/javascript">

        $(document).ready(function () {

            setFirstDate();

            // 조회 버튼 클릭 이벤트
            $("#btnSearch").click(function (key) {

                if (compareDate()) {

                    // 아이디 입력 시 유효성 검사
                    if ($("#keyword").val() == "" || $("#keyword").val() == null) {
                        $("#keyword").focus();
                        alert("아이디를 입력해 주시기 바랍니다.");
                        return false;
                    }

                    getWarehouseList();

                } else {
                    // getWarehouseList();
                }
            });

        });

        /**
         * 최초 접속 시 설정되는 날짜 설정
         */
        function setFirstDate() {

            const now = new Date();

            let year = now.getFullYear();
            let month = now.getMonth() + 1; // 1월이 0으로 되기때문에 +1을 함
            let date = now.getDate();
            let endDate = now.getDate() + 1;

            month = month >= 10 ? month : "0" + month;
            date = date >= 10 ? date : "0" + date;
            endDate = endDate >= 10 ? endDate : "0" + endDate;

            document.getElementById('startDate').value = year + "-" + month + "-" + date;
            document.getElementById('endDate').value = year + "-" + month + "-" + (endDate);

        }

        /**
         * 신청일자 선택 시 유효성 검사
         */
        function compareDate() {

            // 시작일자
            const startDate = $("#startDate").val();
            const startDateArr = startDate.split('-');

            // 종료일자
            const endDate = $("#endDate").val();
            const endDateArr = endDate.split('-');

            for (let i = 0; i < startDateArr.length; i++) {

                if (startDateArr[i].length === 0) {

                    alert("조회일자를 정확히 입력해 주시기 바랍니다.");

                    $("#startDate").focus();

                    return false;

                }
            }

            for (let i = 0; i < endDateArr.length; i++) {

                if (endDateArr[i].length === 0) {

                    alert("조회일자를 정확히 입력해 주시기 바랍니다.");

                    $("#endDate").focus();

                    return false;

                }
            }

            const start = new Date(startDateArr[0], parseInt(startDateArr[1]) - 1, startDateArr[2]);
            const end = new Date(endDateArr[0], parseInt(endDateArr[1]) - 1, endDateArr[2]);

            if (start.getTime() > end.getTime()) {

                alert("시작일자와 종료일자를 확인해 주시기 바랍니다.");

                $("#startDate").focus();

                return false;

            }

            return true;

        }

        function getWarehouseList() {

            NProgress.start();

            $.ajax("/order/WarehouseList",

                {

                    method: 'POST',
                    data: {

                        'startDate': $("#startDate").val(),
                        'endDate': $("#endDate").val(),
                        'keyword': $("#keyword").val()

                    },

                    dataType: 'JSON'
                }
            ).done(function (data) {

                console.log(data.list);

                list = data.list;

                let warehouseStr = '<ol>';

                if (list.length === 0) {
                    warehouseStr += '<div style="text-align: center; padding: 5%"><span class="span-empty">조회된 데이터가 없습니다.</span></div>';
                }

                $.each(list, function (i) {

                    warehouseStr +=
                        '<li class="warehouse">' +
                        '<article>' +
                        '<div class="description">' +
                        '<h1>' + list[i].companyUid + '</h1>' +
                        '<loginid>' +
                        '<span class="span-loginid">' + list[i].loginId + '</span>' +
                        '</loginid>' +
                        '</div>' +
                        '<div class="requestdate">' +
                        '<div><span class="span-requestdate">' + list[i].startTime + ' ~ ' + list[i].endTime + '</span></div>' +
                        '<div class="price">' + toNumberFormat(list[i].price) + '원</div>' +
                        '<input type="button" class="btn btn-logis-primary" style="width: 30%" value="상세보기"/>' +
                        '</div>' +
                        '</article>' +
                        '</li>';

                });

                warehouseStr += '</ol>';

                $("#list").empty();
                $("#list").append(warehouseStr);

                // 상세보기 버튼 클릭 이벤트
                $("#list").find('input').click(function (data) {

                    let index = $(this).parents("li").index();

                    getWarehouseDetail(list[index].orderInfoUid);

                });

            }).always(function () {

                NProgress.done();

            });

        }

        // 숫자 천단위 쉼표 처리
        function toNumberFormat(x) {

            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

        }

        /**
         * 주문 상세 내역 호출
         * */
        function getWarehouseDetail(uid) {

            const orderInfoUid = document.createElement('input');

            orderInfoUid.setAttribute("name", "orderInfoUid");
            orderInfoUid.setAttribute("value", uid);

            const form = document.createElement('form');

            form.setAttribute('method', 'POST');
            form.setAttribute('action', '/order/WarehouseDetail');

            form.appendChild(orderInfoUid);

            document.body.appendChild(form);

            form.submit();

        }

        /* 한글 입력 방지 */
        function nonPressKor(obj) {

            // 방향키, Backspace, Delete, Tab 키에 대한 예외
            if (event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37
                || event.keyCode == 39 || event.keyCode == 46) return;

            obj.value = obj.value.replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi, '');

        }

    </script>
    <style>
        body {
            background-color: white;
        }

        #wrap {
            width: 950px;
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
            height: 93vh;
            width: 100%;
        }

        .div-search-box {
            width: 100%;
            margin-top: 2%;
            border-radius: 4px;
            border: 1px solid lightgrey;
            padding: 5px;

            display: flex;
            flex-direction: row;
            justify-content: space-around;

        }

        .div-date-box {
            width: 50%;
            display: flex;
            flex-direction: row;
            justify-content: center;
        }

        .div-space-box {
            width: 15%;
        }

        .div-confirm-box {
            width: 10%;
            display: flex;
            align-items: center;
        }

        .div-date {
            width: 49.9%;
        }

        .label-title {
            font-weight: 550;
            margin-left: 1%;
        }

        .div-sort-box {
            margin-top: 2%;
            display: flex;
        }

        .div-list {
            margin-top: 2%;
        }

        .warehouse {
            margin-bottom: 1%;
        }

        .description {
            width: 60%;
            padding: 3%;
            background-color: #f5f4f0;
            border-radius: 6px 0 0 6px;
        }

        .requestdate {
            width: 40%;
            padding: 1.5%;
            text-align: right;
        }

        article {
            display: flex;
            border: 1px solid lightgrey;
            border-radius: 6px;
            padding: 3px;
        }

        .btn-filter {
            border: 1px solid lightgrey;
            background-color: #0E2F91;
            padding: 10px 40px;
            color: white;
        }

        .btn-filter:hover {
            color: lightgrey;
        }

        h1 {
            font-weight: 600;
            font-size: 1.8rem;
        }

        .price {
            font-weight: 550;
            font-size: 1.8rem;
            color: #b7000f;
        }

        .span-loginid {
            font-size: 1.1rem;
        }

        .span-empty {
            font-size: 1.5rem;
            font-weight: 550;
        }

        .span-requestdate {
            font-size: 1.2rem;
            font-weight: 700;
        }
    </style>
</head>
<body>
<div class="header">
</div>
<div id="wrap">
    <div class="section">
        <div class="div-search-box">
            <div class="div-date-box">
                <div class="div-date">
                    <div class="form-group mr-3">
                        <label for="startDate" class="col-form-label label-title">시작일자</label>
                        <input class="form-control" type="date" id="startDate" max="9999-12-31">
                    </div>
                </div>
                <div class="div-date mr-3">
                    <div class="form-group">
                        <label for="endDate" class="col-form-label label-title">종료일자</label>
                        <input class="form-control" type="date" id="endDate" max="9999-12-31">
                    </div>
                </div>
            </div>
            <div class="div-space-box">
                <div class="form-group">
                    <div style="width: 120%">
                        <label for="keyword" class="col-form-label label-title">아이디</label>
                        <input class="form-control" type="text" id="keyword" maxlength="20"
                               onkeydown="nonPressKor(this);">
                    </div>
                </div>
            </div>
            <div class="div-confirm-box">
                <input id="btnSearch" type="submit" class="btn btn-logis-primary"
                       style="width: 100%" value="조회">
            </div>
        </div>
        <div id="list" class="div-list">
        </div>
    </div>
</div>
</body>
</html>        