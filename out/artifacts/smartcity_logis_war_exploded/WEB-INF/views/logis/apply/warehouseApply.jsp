<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: jeonseungcheol
  Date: 2020/11/05
  Time: 10:01 오전
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

    <%-- ProgressBar Library  --%>
    <script src="<c:url value='/js/nprogress.js'/>"></script>
    <link rel='stylesheet' href="<c:url value='/css/nprogress.css'/>"/>

    <script type="text/javascript">

        let usableList = [];
        let unusableList = [];

        $(document).ready(function () {
            // 처음 로딩될 때, 오늘 날짜로 설정
            setFirstDate();

            // 결과 필터링 [회사 별로]
            $("body").on('click', '.dropdown-menu button', function (data) {
                $("#dropdownMenu").html($(this).text());
                warehouseNameFilter($(this).text());
            });

            // 검색 버튼 클릭 이벤트
            $("#btnSearch").click(function (key) {
                if (compareDate()) {
                    if (Number($("#inputSpaceSize").val()) < 1) {
                        $("#inputSpaceSize").focus();
                        alert("최소 1개 이상의 대여 공간 수를 입력해주세요.");
                        return;
                    }

                    if (Number($("#inputSpaceSize").val()) > 52) {
                        $("#inputSpaceSize").focus();
                        alert("이용 가능한 최대 수량을 넘었습니다.");
                        return;
                    }

                    getWarehouseList();
                }
                // 날짜를 제대로 선택했는지 확인하고 창고 데이터를 조회한다.
            });
        });

        /**
         * 최초에 예약 날짜를 설정한다.
         */
        function setFirstDate() {
            const now = new Date();
            let year = now.getFullYear();
            let month = now.getMonth() + 1;    //1월이 0으로 되기때문에 +1을 함.
            let date = now.getDate();
            let endDate = now.getDate() + 1;

            month = month >= 10 ? month : "0" + month;
            date = date >= 10 ? date : "0" + date;
            endDate = endDate >= 10 ? endDate : "0" + endDate;

            document.getElementById('inputStartDate').value = year + "-" + month + "-" + date;
            document.getElementById('inputEndDate').value = year + "-" + month + "-" + (endDate);

            let hour = now.getHours() + 1;

            // 기본 시간 설정
            const time = document.getElementById("inputTime");
            time.value = hour + ":00";
            time.addEventListener("input", function () {
                const hour = time.value.slice(0, 2);
                time.value = hour + ":00";
            }, false);
        }

        /**
         * 날짜를 비교한다.
         */
        function compareDate() {
            // 대여 시작 날짜
            const startDate = $("#inputStartDate").val();
            const startDateArr = startDate.split('-');

            // 대여 종료 날짜
            const endDate = $("#inputEndDate").val();
            const endDateArr = endDate.split('-');

            for (let i = 0; i < startDateArr.length; i++) {
                if (startDateArr[i].length === 0) {
                    alert("날짜를 제대로 입력해주세요.");
                    $("#inputStartDate").focus();
                    return false;
                }
            }

            for (let i = 0; i < endDateArr.length; i++) {
                if (endDateArr[i].length === 0) {
                    alert("날짜를 제대로 입력해주세요.");
                    $("#inputEndDate").focus();
                    return false;
                }
            }

            const start = new Date(startDateArr[0], parseInt(startDateArr[1]) - 1, startDateArr[2]);
            const end = new Date(endDateArr[0], parseInt(endDateArr[1]) - 1, endDateArr[2]);

            if (start.getTime() > end.getTime()) {
                alert("시작 날짜와 종료 날짜를 확인해주세요.");
                $("#inputEndDate").focus();
                return false;
            }

            return true;
        }

        /**
         * 사용자가 선택한 옵션에 맞는 창고를 조회한다.
         */
        function getWarehouseList() {
            NProgress.start();
            $.ajax("/user/warehouse/searchAction",
                {
                    method: 'POST',
                    data: {
                        'startDatetime': $("#inputStartDate").val() + " " + $("#inputTime").val(),
                        'endDatetime': $("#inputEndDate").val() + " " + $("#inputTime").val(),
                        'spaceSize': $("#inputSpaceSize").val()
                    },
                    dataType: 'JSON'
                }
            ).done(function (data) {
                console.log(data.list);

                list = data.list;

                let warehouseStr = '<ol>';

                if (list.length === 0) {
                    warehouseStr += '<div style="text-align: center; padding: 5%"><span class="span-empty">죄송합니다. 검색하신 기준에 맞는 창고가 없습니다.</span></div>';
                }

                $.each(list, function (i) {
                    const totalPrice = list[i].price * list[i].days * list[i].spaceSize;

                    if (list[i].canUse == true && list[i].availableSpace >= list[i].spaceSize) {
                        warehouseStr += '<li class="warehouse">' +
                            '<article>' +
                            '<div class="description">' +
                            '<h5>' + list[i].warehouseName + '</h5>' +
                            '<address>' +
                            '<span class="span-address">' + list[i].warehouseAddress + '</span>' +
                            '</address>' +
                            '</div>' +
                            '<div class="price">' +
                            '<div><span class="span-price">' + numberWithCommas(list[i].price) + '원 / 일</span></div>' +
                            '<div class="emphasisPrice">' + numberWithCommas(totalPrice) + '원</div>' +
                            '<input type="button" class="btn btn-logis-primary" style="width: 60%" value="선택"/>' +
                            '</div></article></li>';
                    } else {
                        warehouseStr += '<li class="warehouse">' +
                            '<article>' +
                            '<div class="description">' +
                            '<h5>' + list[i].warehouseName + '</h5>' +
                            '<address>' +
                            '<span class="span-address">' + list[i].warehouseAddress + '</span>' +
                            '</address>' +
                            '</div>' +
                            '<div class="price">' +
                            '<div><span class="span-price">' + numberWithCommas(list[i].price) + '원 / 일</span></div>' +
                            '<div class="unusableEmphasisPrice">' + numberWithCommas(totalPrice) + '원</div>' +
                            '<input type="button" class="btn btn-logis-primary" style="width: 60%" value="선택" disabled/>' +
                            '</div></article></li>';
                    }
                });

                warehouseStr += '</ol>';

                $("#list").empty();
                $("#list").append(warehouseStr);

                // 대기중인 승객 클릭 이벤트
                $("#list").find('input').click(function (data) {
                    let index = $(this).parents("li").index();
                    moveDetailPage(list[index].warehouseUid, list[index].startDatetime, list[index].endDatetime, list[index].spaceSize);
                });
            }).always(function () {
                // Complete
                NProgress.done();
            });
        }

        function numberWithCommas(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }

        /**
         * 창고 상세 화면으로 이동한다.
         */
        function moveDetailPage(uid, start, end, size) {
            const warehouseUid = document.createElement('input');
            warehouseUid.setAttribute("name", "warehouseUid");
            warehouseUid.setAttribute("value", uid);

            const startDatetime = document.createElement('input');
            startDatetime.setAttribute("name", "startDatetime");
            startDatetime.setAttribute("value", start);

            const endDatetime = document.createElement('input');
            endDatetime.setAttribute("name", "endDatetime");
            endDatetime.setAttribute("value", end);

            const spaceSize = document.createElement('input');
            spaceSize.setAttribute("name", "spaceSize");
            spaceSize.setAttribute("value", size);

            const form = document.createElement('form');
            form.setAttribute('method', 'POST');
            form.setAttribute('action', '/user/warehouse/applyDetail');
            form.appendChild(warehouseUid);
            form.appendChild(startDatetime);
            form.appendChild(endDatetime);
            form.appendChild(spaceSize);
            document.body.appendChild(form);
            form.submit();
        }

        function warehouseNameFilter(filter) {
            let res = [];

            if (filter === "전체") {
                res = list;
            } else {
                res = list.filter(item => item.warehouseName.includes(filter));
            }

            let warehouseStr = '<ol>';

            if (res.length === 0) {
                warehouseStr += '<div style="text-align: center; padding: 5%"><span class="span-empty">죄송합니다. 검색하신 기준에 맞는 창고가 없습니다.</span></div>';
            }

            $.each(res, function (i) {
                const totalPrice = res[i].price * res[i].days * res[i].spaceSize;

                if (res[i].canUse == true) {
                    warehouseStr += '<li class="warehouse">' +
                        '<article>' +
                        '<div class="description">' +
                        '<h5>' + res[i].warehouseName + '</h5>' +
                        '<address>' +
                        '<span class="span-address">' + res[i].warehouseAddress + '</span>' +
                        '</address>' +
                        '</div>' +
                        '<div class="price">' +
                        '<div><span class="span-price">' + numberWithCommas(res[i].price) + '원 / 일</span></div>' +
                        '<div class="emphasisPrice">' + numberWithCommas(totalPrice) + '원</div>' +
                        '<input type="button" class="btn btn-logis-primary" style="width: 60%" value="선택"/>' +
                        '</div></article></li>';
                } else {
                    warehouseStr += '<li class="warehouse">' +
                        '<article>' +
                        '<div class="description">' +
                        '<h5>' + res[i].warehouseName + '</h5>' +
                        '<address>' +
                        '<span class="span-address">' + res[i].warehouseAddress + '</span>' +
                        '</address>' +
                        '</div>' +
                        '<div class="price">' +
                        '<div><span class="span-price">' + numberWithCommas(res[i].price) + '원 / 일</span></div>' +
                        '<div class="unusableEmphasisPrice">' + numberWithCommas(totalPrice) + '원</div>' +
                        '<input type="button" class="btn btn-logis-primary" style="width: 60%" value="선택" disabled/>' +
                        '</div></article></li>';
                }
            });

            warehouseStr += '</ol>';

            $("#list").empty();
            $("#list").append(warehouseStr);

            // 대기중인 승객 클릭 이벤트
            $("#list").find('input').click(function (data) {
                let index = $(this).parents("li").index();
                moveDetailPage(res[index].warehouseUid, res[index].startDatetime, res[index].endDatetime, res[index].spaceSize);
            });
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
        }

        .form-search-box {
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
            width: 75%;
            padding: 3%;
            background-color: #f5f4f0;
            border-radius: 6px 0 0 6px;
        }

        .price {
            width: 25%;
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

        h5 {
            font-weight: 600;
            font-size: 1.8rem;
        }

        .emphasisPrice {
            font-weight: 550;
            font-size: 1.8rem;
            color: #b7000f;
        }

        .unusableEmphasisPrice {
            font-weight: 550;
            font-size: 1.8rem;
            color: #c3c3c3;
        }

        .span-address {
            font-size: 1.1rem;
        }

        .span-empty {
            font-size: 1.5rem;
            font-weight: 550;
        }

        .span-price {
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
            <form class="form-search-box" action="/user/warehouse/searchAction" method="post">
                <%-- 예약 날짜 선택 --%>
                <div class="div-date-box">
                    <div class="div-date">
                        <div class="form-group mr-3">
                            <label for="inputStartDate" class="col-form-label label-title">예약시작 날짜</label>
                            <input class="form-control" type="date" value="" id="inputStartDate" max="9999-12-31">
                        </div>
                    </div>
                    <div class="div-date mr-3">
                        <div class="form-group">
                            <label for="inputEndDate" class="col-form-label label-title">예약종료 날짜</label>
                            <input class="form-control" type="date" value="" id="inputEndDate" max="9999-12-31">
                        </div>
                    </div>
                    <div class="div-date">
                        <div class="form-group">
                            <label for="inputEndDate" class="col-form-label label-title">시간</label>
                            <input class="form-control" type="time" value="" id="inputTime" step="3600000" min="16:00"
                                   max="23:00">
                        </div>
                    </div>
                </div>
                <div class="div-space-box">
                    <div class="form-group">
                        <div style="width: 100%">
                            <label for="inputSpaceSize" class="col-form-label label-title">대여 공간 수</label>
                            <input class="form-control" type="number" value="1" id="inputSpaceSize" min="1" max="100">
                        </div>
                    </div>
                </div>
                <div class="div-confirm-box">
                    <input id="btnSearch" type="button" class="btn btn-logis-primary" style="width: 100%" value="검색">
                </div>
            </form>
        </div>

        <%-- 필더링 박스 --%>
        <div class="div-sort-box">
            <div class="dropdown mr-2">
                <%--                <input class="btn btn-filter dropdown-toggle" type="button" id="dropdownMenu" data-toggle="dropdown"--%>
                <%--                       aria-haspopup="true" aria-expanded="false" value="창고명">--%>
                <button class="btn btn-filter dropdown-toggle" type="button" id="dropdownMenu" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                    창고명
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenu">
                    <button class="dropdown-item" type="button">전체</button>
                    <c:forEach var="data" items="${warehouseNameList}">
                        <button class="dropdown-item" type="button">${data.warehouseName}</button>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div id="list" class="div-list">
        </div>
    </div>
</div>

</body>
</html>
		

        