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
    <link rel="stylesheet" href="/css/reset.css">
    <%-- Bootstrap core CSS --%>
    <link rel="stylesheet" href="/assets/libs/bootstrap-4.5.3/css/bootstrap.min.css">
    <%-- Calendar --%>
    <link rel="stylesheet" href="/assets/libs/datepicker/bootstrap-datepicker.css">
    <%-- Material Design Bootstrap CSS --%>
    <link rel="stylesheet" href="<c:url value='/js/core.min.js'/>">
    <%-- Custom CSS --%>
    <link rel="stylesheet" href="/css/content_logis.css">
    <%-- FontAwesome --%>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">

    <%--  Bootstrap 5.0 --%>
    <link rel="stylesheet" href="/assets/libs/bootstrap-5.0.0/css/bootstrap.min.css">

    <%-- JQuery, Bootstrap JS  --%>
    <script src="/js/jquery-3.5.1.min.js"></script>
    <script src="/assets/libs/bootstrap-4.5.3/js/bootstrap.min.js"></script>

    <script src="/assets/libs/datepicker/bootstrap-datepicker.js"></script>
    <script src="/assets/libs/datepicker/bootstrap-datepicker.ko.min.js"></script>

    <%-- 우편번호 --%>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


    <c:set var="SUCCESS"><%=Consts.LOGIS_APPLY_RESULT.SUCCESS%>
    </c:set>
    <c:set var="FAIL"><%=Consts.LOGIS_APPLY_RESULT.FAIL%>
    </c:set>

    <script type="text/javascript">
        $(document).ready(function () {
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

            $("#btnAddItem").show();
            addInputItem(true);

            // 신청하기
            $('#btnToWhseApply').click(function (key) {
                if (validate()) {
                    payOrder();
                }
            });

            // 물품 추가 버튼
            $("#btnAddItem").click(function (key) {
                addInputItem(false);
            });

            $("#wishDeliveryDatetime").on("propertychange change keyup paste input", function () {
                /*
                var currentVal = $(this).val();
                if(currentVal == oldVal) {
                    return;
                }

                oldVal = currentVal;
                 */
                console.log("changed");
            });
        });

        $(function () {
            $("#Date").datepicker({});
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

        /**
         * 입력 받은 데이터 검증
         */
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
                        "wishDeliveryDatetime": $("#datePicker").val(),
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
            }).fail(function (e) {
                alert("잠시 후 다시 시도해 주세요.");
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

        $(function () {
            $('#datePicker').datepicker({
                format: "yyyy-mm-dd",	// 데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
                startDate: '0d',	// 달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
                // endDate: '+10d',	// 달력에서 선택 할 수 있는 가장 느린 날짜. 이후로 선택 불가 ( d : 일 m : 달 y : 년 w : 주)
                autoclose: true,	// 사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
                calendarWeeks: false, // 캘린더 옆에 몇 주차인지 보여주는 옵션 기본값 false 보여주려면 true
                clearBtn: false, // 날짜 선택한 값 초기화 해주는 버튼 보여주는 옵션 기본값 false 보여주려면 true
                // daysOfWeekDisabled: [0, 6],	// 선택 불가능한 요일 설정 0 : 일요일 ~ 6 : 토요일
                disableTouchKeyboard: false,	// 모 바일에서 플러그인 작동 여부 기본값 false 가 작동 true가 작동 안함.
                immediateUpdates: false,	// 사용자가 보는 화면으로 바로바로 날짜를 변경할지 여부 기본값 :false
                templates: {
                    leftArrow: '&laquo;',
                    rightArrow: '&raquo;'
                },
                showWeekDays: true,// 위에 요일 보여주는 옵션 기본값 : true
                todayHighlight: true,	// 오늘 날짜에 하이라이팅 기능 기본값 :false
                toggleActive: true,	// 이미 선택된 날짜 선택하면 기본값 : false인경우 그대로 유지 true인 경우 날짜 삭제
                weekStart: 0,// 달력 시작 요일 선택하는 것 기본값은 0인 일요일
                language: "ko"	// 달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
            }).on("changeDate", function(e) {
                searchWarehouse();
            });
        });

        function searchWarehouse() {
            $.ajax("/user/logis/searhLentalWarehouse",
                {
                     method: 'POST',
                     data: {
                         "date": $("#datePicker").val()
                     },
                     dataType: 'JSON'
                }
            ).done(function (data) {
                const list = data.warehouseList;
                if (list.length > 0){
                    list.forEach(element => {
                        console.log(element);
                        $("#toWhseSelect *").remove();
                        $("#toWhseSelect").append(
                            '<option value="' + element.warehousePostcode + ',' + element.warehouseAddress + ',' + element.orderInfoUid + '">' +
                            element.warehouseName + '(대여기간:' + element.startDatetime + ' ~ ' + element.endDatetime + ')' +
                            '</option>'
                        );
                        $("#toWhseSelect").attr("disabled", false);
                    });
                } else {
                    $("#toWhseSelect *").remove();
                    $("#toWhseSelect").attr("disabled", true);
                }
            }).fail(function () {
                $("#toWhseSelect *").remove();
                $("#toWhseSelect").attr("disabled", true);
            });
        }
    </script>
    <style>
        body {
            background-color: white;
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

        h4 {
            font-weight: 600;
            text-align: center;
            font-size: 2.4em;
            margin-bottom: 5%;
            margin-top: 5%;
        }

        table {
            width: 100%;
        }

        table, th {
            padding: 10px 10px 16px 20px;
        }

        thead {
            display: table-header-group;
        }

        td {
            padding: 10px 10px;
        }

        label {
            /*font-size: large;*/
        }

        .button-type-1 {
            margin-left: 2%;
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
            margin-bottom: 50px;
        }

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
    <%-- 탭에 대한 콘텐츠 --%>
    <div class="tab-content">
        <%-- 공유 창고 --%>
        <div id="toWarehouse" class="container tab-pane active">
            <form>
                <div class="form-group col-12 mt-4">
                    <h3>예약 정보</h3>
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
                               autocomplete="chrome-off" value="${userInfo.postcode}">
                        <input id="btnReqSenderAddr" name="btnReqSenderAddr" type="button"
                               class="btn btn-primary button-type-1" value="우편번호 찾기" onclick="requestAddress('send')">
                    </div>
                </div>
                <div class="form-group col-12">
                    <input type="text" class="form-control" id="toWhseSenderAddress" placeholder="주소"
                           autocomplete="chrome-off" value="${userInfo.address}">
                </div>
                <div class="form-group col-12">
                    <input type="text" class="form-control" id="toWhseSenderDetailAddress" placeholder="상세주소"
                           value="${userInfo.detailAddress}">
                </div>
                <div class="form-group col-12 mt-4">
                    <h3>물류 정보</h3>
                </div>
                <div class="btn-group" role="group" style="margin-left: 15px"
                     aria-label="Basic radio toggle button group">
                    <input type="radio" class="btn-check" name="toWhseInfoType" id="radioPalette" autocomplete="off"
                           checked value="0">
                    <label class="btn btn-outline-primary"
                           style="border-bottom-left-radius: 4px; border-top-left-radius: 4px;" for="radioPalette">팔렛트
                        배송</label>
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
                <div id="itemContainer" class="form-group col-12">
                    <%-- 새로운 물품 추가 --%>
                    <input type="button" id="btnAddItem" name="bntAddItem" class="btn btn-primary"
                           value="물품 추가하기"/>
                </div>
                <div class="form-group col-12">
                    <label for="wishDeliveryDatetime">희망 배송 날짜<i class="fas fa-asterisk i-size-1"></i></label>
                    <label id="commentDate">
                        <i class="fas fa-exclamation-circle mr-1" style="color: #8b62ff;"></i>창고 대여 기간으로 설정해 주세요.
                    </label>
                    <input class="form-control mr-3" type="datetime-local" value=""
                           id="wishDeliveryDatetime" max="9999-12-31" style="display: none;">
                    <input type="text" id="datePicker" class="form-control">
                </div>
                <div class="form-group col-12">
                    <label for="toWhseSelect">보낼 창고선택<i class="fas fa-asterisk i-size-1"></i></label>
                    <label id="comment"><i class="fas fa-exclamation-circle mr-1" style="color: #8b62ff;"></i>희망 배송 날짜를
                        먼저 입력해 주세요.</label>
                    <select class="form-select" id="toWhseSelect" disabled>
<%--                        <c:forEach var="data" items="${warehouseNameList}">--%>
<%--                            <option value="${data.warehousePostcode},${data.warehouseAddress},${data.orderInfoUid}">${data.warehouseName}--%>
<%--                                (대여기간: ${data.startDatetime} ~ ${data.endDatetime})--%>
<%--                            </option>--%>
<%--                        </c:forEach>--%>
                    </select>
                </div>
                <input id="btnToWhseApply" type="button" class="btn btn-primary input-apply" value="신청하기">
            </form>
        </div>
    </div>
</div>
</body>
</html>