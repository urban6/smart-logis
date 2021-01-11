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
    <title>물류 공유해 : 창고 대여</title>

    <meta content="user-scalable=no, width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0"
          name="viewport">

    <%-- Reset CSS --%>
    <link rel="stylesheet" href="/css/reset.css">
    <%-- Bootstrap core CSS --%>
    <link rel="stylesheet" href="/assets/libs/bootstrap-4.5.3/css/bootstrap.min.css">
    <%-- Material Design Bootstrap CSS --%>
    <link rel="stylesheet" href="/js/core.min.js">
    <%-- Custom CSS --%>
    <link rel="stylesheet" href="/css/content_logis.css">

    <%-- Popper --%>
    <!-- Development version -->
    <script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>

    <%-- JQuery, Bootstrap JS  --%>
    <script src="/js/jquery-3.5.1.min.js"></script>
    <script src="/assets/libs/bootstrap-4.5.3/js/bootstrap.min.js"></script>

    <%-- 네이버 지도 --%>
    <script type="text/javascript"
            src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=snsxvn7i8m&submodules=geocoder"></script>

    <%-- ProgressBar Library  --%>
    <script src="/js/nprogress.js"></script>
    <link rel='stylesheet' href="/css/nprogress.css"/>
</head>

<script type="text/javascript">

    let usableList = [];
    let unusableList = [];

    $(document).ready(function () {
        // alert("${companyAddress}");

        // 처음 로딩될 때, 오늘 날짜로 설정
        setFirstDate();

        // getCompanyLocation();

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

    function getCompanyLocation() {
        let location;

        naver.maps.Service.geocode({
            query: "서울 영등포구 문래북로 116 1404호"
        }, function (status, response) {
            if (status === naver.maps.Service.Status.ERROR) {
                // return alert('주소를 정확히 입력해주세요.');
            }

            if (response.v2.meta.totalCount === 0) {
                // return alert('주소를 입력해주세요.');
            }

            location = response.v2.addresses[0];
            // position = new naver.maps.LatLng(item.y,item.x);
            // map.setCenter(position);
        });

        return location;
    }

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

            let warehouseStr = '<div><span class="span-palette-comment">(단위 팔레트)<span></div><ol>';

            if (list.length === 0) {
                warehouseStr += '<div style="text-align: center; padding: 5%"><span class="span-empty">죄송합니다. 검색하신 기준에 맞는 창고가 없습니다.</span></div>';
            }
            $.each(list, function (i) {
                let warehouseMarker = new naver.maps.Marker({
                    position: new naver.maps.LatLng(list[i].lat, list[i].lng),
                    map: map
                });


                naver.maps.Event.addListener(warehouseMarker, "click", function (e) {
                    var infoWindow = new naver.maps.InfoWindow({
                        //anchorSkew: true
                        borderWidth: 0,
                        disableAnchor: true,
                        backgroundColor: 'transparent'
                    });
                    infoWindow.setContent([
                        '<div style="padding:0px;min-width:35px;line-height:150% max-height:30px;">',
                        '<div class="btn btn-primary btn-sm text-center mb-2" id="locationConfirm">' + list[i].warehouseName + '</div>',
                        '</div>'
                    ].join('\n'));
                    if (infoWindow.getMap()) {
                        infoWindow.close();
                    } else {
                        infoWindow.open(map, warehouseMarker);
                    }
                });

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
                        '<div><span class="span-space-count">대여 가능 공간: ' + list[i].availableSpace + '</span></div>' +
                        '<div><span class="span-price">' + numberWithCommas(list[i].price) + '원 / 일</span></div>' +
                        '<div class="emphasisPrice">' + numberWithCommas(totalPrice) + '원</div>' +
                        '<input type="button" class="btn btn-select" value="선택"/>' +
                        '</div></article></li>';
                } else {
                    warehouseStr += '<li class="warehouse">' +
                        '<article>' +
                        '<div class="no-description">' +
                        '<h5>' + list[i].warehouseName + '</h5>' +
                        '<address>' +
                        '<span class="span-address">' + list[i].warehouseAddress + '</span>' +
                        '</address>' +
                        '</div>' +
                        '<div class="price">' +
                        '<div><span class="span-no-space-count">대여 가능 공간: 0</span></div>' +
                        '<div><span class="span-price">' + numberWithCommas(list[i].price) + '원 / 일</span></div>' +
                        '<div class="unusableEmphasisPrice">' + numberWithCommas(totalPrice) + '원</div>' +
                        '<input type="button" class="btn btn-cant-select" value="선택" disabled/>' +
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
            res = list.filter(item >= item.warehouseName.includes(filter));
        }

        let warehouseStr = '<div><span class="span-palette-comment">(단위 팔레트)<span></div><ol>';

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
                    '<div><span class="span-space-count">대여 가능 공간: ' + res[i].availableSpace + '</span></div>' +
                    '<div><span class="span-price">' + numberWithCommas(res[i].price) + '원 / 일</span></div>' +
                    '<div class="emphasisPrice">' + numberWithCommas(totalPrice) + '원</div>' +
                    '<input type="button" class="btn btn-select" value="선택"/>' +
                    '</div></article></li>';
            } else {
                warehouseStr += '<li class="warehouse">' +
                    '<article>' +
                    '<div class="no-description">' +
                    '<h5>' + res[i].warehouseName + '</h5>' +
                    '<address>' +
                    '<span class="span-address">' + res[i].warehouseAddress + '</span>' +
                    '</address>' +
                    '</div>' +
                    '<div class="price">' +
                    '<div><span class="span-no-space-count">대여 가능 공간: 0</span></div>' +
                    '<div><span class="span-price">' + numberWithCommas(res[i].price) + '원 / 일</span></div>' +
                    '<div class="unusableEmphasisPrice">' + numberWithCommas(totalPrice) + '원</div>' +
                    '<input type="button" class="btn btn-cant-select" value="선택" disabled/>' +
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
        width: 100%;
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
        height: 93vh;
        width: 100%;
    }

    .div-search-box {
        width: 950px;
        margin: 0 auto;
        padding: 5px;
    }

    .btn-search {
        background-color: #d74a23;
        color: white;
        width: 100%;
    }

    .form-search-box {
        width: 100%;
        display: flex;
        flex-direction: row;
        justify-content: space-around;
    }

    .div-date-box {
        width: 60%;
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
        width: 950px;
        margin: 2% auto;
    }

    .warehouse {
        margin-bottom: 1%;
    }

    .description {
        width: 75%;
        padding: 2% 3%;
        background-color: #e6e6e6;
        border-left: 7px solid #E93D00;
    }

    .no-description {
        width: 75%;
        padding: 2% 3%;
        background-color: #e6e6e6;
        border-left: 7px solid #b4b4b4;
    }

    .price {
        width: 25%;
        padding: 1% 1.5%;
        text-align: right;
        background-color: #e6e6e6;
    }

    article {
        display: flex;
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

    .span-space-count {
        font-size: 1.1rem;
        font-weight: 550;
        color: black;
    }

    .span-no-space-count {
        font-size: 1.1rem;
        font-weight: 550;
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

    .btn-select {
        background-color: #E93D00;
        color: white;
        width: 40%;
        font-size: 1rem;
        padding-top: 3px;
        padding-bottom: 3px;
        border-radius: 0;
    }

    .btn-cant-select {
        background-color: #c3c3c3;
        color: white;
        width: 40%;
        font-size: 1rem;
        padding-top: 3px;
        padding-bottom: 3px;
        border-radius: 0;
    }

    .btn-cant-select:hover {
        color: white;
    }

    .map-container {
        width: 950px;
        background-color: #39539c;
        margin: 0 auto;
    }

    .map {
        width: 100%;
        height: 400px;
        margin: 0 auto;
    }

    .span-palette-comment {
        display: flex;
        flex-direction: column-reverse;
        justify-content: right;
        align-items: flex-end;
    }
</style>
</head>
<body>
<div class="header">
    <span class="header-title">창고 대여</span>
</div>
<div id="wrap">
    <%--    <div class="section">--%>
    <div class="div-search-box">
        <form class="form-search-box" action="/user/warehouse/searchAction" method="post">
            <%-- 예약 날짜 선택 --%>
            <div class="div-date-box">
                <div class="div-date">
                    <div class="form-group mr-3">
                        <label for="inputStartDate" class="col-form-label label-title">시작 날짜</label>
                        <input class="form-control" type="date" value="" id="inputStartDate" max="9999-12-31">
                    </div>
                </div>
                <div class="div-date mr-3">
                    <div class="form-group">
                        <label for="inputEndDate" class="col-form-label label-title">종료 날짜</label>
                        <input class="form-control" type="date" value="" id="inputEndDate" max="9999-12-31">
                    </div>
                </div>
                <div class="div-date">
                    <div class="form-group">
                        <label for="inputEndDate" class="col-form-label label-title">지역</label>
                        <select class="form-control" id="selectLocation">
                            <option>김해</option>
                        </select>
                        <input class="form-control d-none" type="time" value="" id="inputTime" step="3600000"
                               min="16:00" max="23:00">
                    </div>
                </div>
            </div>
            <div class="div-space-box">
                <div class="form-group" style="display:flex; flex-direction: row;">
                    <div style="width: 100%">
                        <label for="inputSpaceSize" class="col-form-label label-title">대여 공간 수</label>
                        <div style="width: 100%; display: table; align-content: center; justify-content: center;">
                            <input class="form-control" type="number" value="1" id="inputSpaceSize" min="1" max="100">
                            <span style="text-align: center; display: table-cell; vertical-align: middle;">팔레트</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="div-confirm-box">
                <input id="btnSearch" type="button" class="btn btn-search" value="검색">
            </div>
        </form>
    </div>

    <%-- 필더링 박스 --%>
    <div class="div-sort-box" style="display: none;">
        <div class="dropdown mr-2">
            <%-- <button class="btn btn-filter dropdown-toggle" type="button" id="dropdownMenu" data-toggle="dropdown"--%>
            <%--         aria-haspopup="true" aria-expanded="false">--%>
            <%--       창고명--%>
            <%-- </button>--%>
            <div class="dropdown-menu" aria-labelledby="dropdownMenu">
                <button class="dropdown-item" type="button">전체</button>
                <c:forEach var="data" items="${warehouseNameList}">
                    <button class="dropdown-item" type="button">${data.warehouseName}</button>
                </c:forEach>
            </div>
        </div>
    </div>

    <%-- 지도 --%>
    <div class="map-container">
        <div id="map" class="map"></div>
    </div>

    <script>
        // TODO - 마커 개발 시작
        //        https://navermaps.github.io/maps.js.ncp/docs/tutorial-5-marker-html-icon.example.html
        const mapOptions = {
            center: new naver.maps.LatLng(35.2173121, 128.8275913),
            zoom: 16
        };

        const map = new naver.maps.Map('map', mapOptions);

        const companyMarker = new naver.maps.Marker({
            position: new naver.maps.LatLng(35.2173121, 128.8275913),
            map: map,
            icon: {url: '/images/my_location_marker.png'}
        });


        naver.maps.Service.geocode({
            query: "${companyAddress}"
        }, function (status, response) {
            if (status === naver.maps.Service.Status.ERROR) {
                // return alert('주소를 정확히 입력해주세요.');
            }
            if (response.v2.meta.totalCount === 0) {
                // return alert('주소를 입력해주세요.');
            }

            const loc = response.v2.addresses[0];
            position = new naver.maps.LatLng(loc.y, loc.x);
            map.setCenter(position);

            // 내 위치에 마커 찍고, 정보 창도 추가
            companyMarker.setPosition(position);
        });

    </script>
    <div class="section">
        <%-- 창고 검색 목록 --%>
        <div id="list" class="div-list">
        </div>
    </div>
</div>

</body>
</html>
		

        