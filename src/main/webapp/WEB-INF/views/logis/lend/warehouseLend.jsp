<%--
  Created by IntelliJ IDEA.
  User: jeonseungcheol
  Date: 2020/12/10
  Time: 10:30 오전
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
    <title>물류 공유해 : 내 창고 공유하기</title>

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

    <script type="text/javascript">
        $(document).ready(function () {
            $("#inputSearchAddr").click(function (key) {
                searchAddress();
            });

            $("#btnCancel").click(function (key) {
                history.back();
            });

            $("#btnLendApply").click(function (key) {
                // 데이터 검증
                if (validate()) {
                    const result = confirm("관리자의 승인이 필요하기 때문에 일정 기간이 소요될 수 있습니다.");
                    if (result) {
                        requestApply();
                    }
                }
            });
        });

        function validate() {
            // replace(/ /gi, '') 공백 제거

            // 창고명
            if ($("#warehouseName").val().trim() == "") {
                alert("창고명을 입력해주세요.");
                $("#warehouseName").focus();
                return false;
            }

            // 회사명
            if ($("#companyName").val().trim() == "") {
                alert("회사명을 입력해주세요.");
                $("#companyName").focus();
                return false;
            }

            // 휴대폰 번호 1 = 010, 2 = 0000, 3 = 0000
            if ($("#phone1").val().trim() == "") {
                alert("연락처를 입력해주세요.");
                $("#phone1").focus();
                return false;
            }

            if ($("#phone2").val().trim() == "") {
                alert("연락처를 입력해주세요.");
                $("#phone2").focus();
                return false;
            }

            if ($("#phone3").val().trim() == "") {
                alert("연락처를 입력해주세요.");
                $("#phone3").focus();
                return false;
            }

            // 주소
            if ($("#address").val().trim() == "") {
                alert("주소를 입력해주세요.");
                return false;
            }

            // 창고 크기
            if ($("#warehouseSize").val().trim() == "") {
                alert("창고 크기를 입력해주세요.");
                $("#warehouseSize").focus();
                return false;
            }

            // 공간 당 가격
            if ($("#spacePrice").val().trim() == "") {
                alert("가격을 입력해주세요.");
                $("#spacePrice").focus();
                return false;
            }

            return true;
        }

        /**
         * 내 창고 대여 신청
         */
        function requestApply() {
            const phone = $("#phone1").val() + $("#phone2").val() + $("#phone3").val();
            const address = $("#address").val() + " " + $("#detailAddress").val();

            $.ajax("/user/warehouse/lendAction",
                {
                     method: 'POST',
                     data: {
                         "warehouseName": $("#warehouseName").val().trim(),
                         "companyName": $("#companyName").val().trim(),
                         "phoneNumber": phone.trim(),
                         "warehouseAddress": address.trim(),
                         "warehousePostcode": $("#postcode").val().trim(),
                         "warehouseSize": $("#warehouseSize").val().trim(),
                         "spacePrice": $("#spacePrice").val().trim()
                     },
                     dataType: 'JSON'
                }
            ).done(function (data) {
                const result = data.result;
                if (result == 0) {
                    alert("내 창고 대여 신청이 완료되었습니다.");
                    movePage("POST" , "/user/home/home");
                } else {
                    alert("잠시 후 다시 신청해주세요.");
                }
            });
        }

        function movePage(method, action) {
            const form = document.createElement('form');
            form.setAttribute('method', method);
            form.setAttribute('action', action);
            document.body.appendChild(form);
            form.submit();
        }

        /**
         * 다음 우편번호 API 팝업
         */
        function searchAddress() {
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
                    $("#postcode").val(data.zonecode);
                    $("#address").val(addr);

                    // 커서를 상세주소 필드로 이동한다.
                    $("#detailAddress").val('');
                    $("#detailAddress").focus();
                }
            }).open();
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
            background: url('/images/BG_3.png');
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

        label {
            display: flex;
            flex-direction: row;
        }

        .btn-lend {
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

        .span-size-comment {
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
<div class="header">
    <span class="header-title">내 창고 공유 신청</span>
</div>
<div id="wrap">
    <div class="section">
        <form id="formLend" name="formLend" method="post" action="/user/warehouse/lendAction">
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
                                <strong class="form-title">기본 정보</strong>
                            </div>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th scope="row">
                            <label for="warehouseName">창고명</label>
                        </th>
                        <td>
                            <input class="form-control input-lg input-name" type="text" id="warehouseName"
                                   name="warehouseName"
                                   placeholder=""
                                   value="" maxlength="20">
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <label for="companyName">회사명</label>
                        </th>
                        <td>
                            <input class="form-control input-lg input-name" type="text" id="companyName"
                                   name="companyName"
                                   placeholder=""
                                   value="" maxlength="20">
                        </td>
                    </tr>
                    <tr id="trPhone">
                        <th scope="row">
                            <label>연락처</label>
                        </th>
                        <td>
                            <ul>
                                <li style="display: list-item">
                                    <div class="form-table-wrap mb-2">
                                        <input class="form-control input-lg input-phone" type="tel" id="phone1"
                                               name="phone1" maxlength="4" value=""
                                               oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');">
                                        <span style="margin-left: 1%; margin-right: 1%">-</span>
                                        <input class="form-control input-lg input-phone" type="tel" id="phone2"
                                               name="phone2" maxlength="4" value=""
                                               oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');">
                                        <span style="margin-left: 1%; margin-right: 1%">-</span>
                                        <input class="form-control input-lg input-phone" type="tel" id="phone3"
                                               name="phone3" maxlength="4" value=""
                                               oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');">
                                    </div>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    <tr class="tr-border-top">
                        <th scope="row">
                            <label>주소</label>
                        </th>
                        <td>
                            <div class="form-table-wrap">
                                <input class="form-control input-lg input-type-1 input-postcode" type="text"
                                       id="postcode"
                                       name="postcode"
                                       value="" maxlength="30" readonly>

                                <input id="inputSearchAddr" name="inputSearchAddr" type="button"
                                       class="btn btn-logis-primary button-type-1" value="우편번호 찾기">
                            </div>
                            <div class="form-table-wrap">
                                <input class="form-control input-lg input-type-1 input-address" type="text"
                                       id="address"
                                       name="address"
                                       value="" readonly>
                            </div>
                            <div class="form-table-wrap">
                                <input class="form-control input-lg input-type-1 input-address" type="text"
                                       id="detailAddress"
                                       name="detailAddress"
                                       value="">
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

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
                                <strong class="form-title">창고 정보</strong>
                            </div>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th scope="row">
                            <label for="warehouseSize">창고 크기</label>
                        </th>
                        <td>
                            <input class="form-control input-lg input-name mb-2" type="number" id="warehouseSize"
                                   name="warehouseSize"
                                   placeholder=""
                                   value="" maxlength="20">
                            <span class="span-size-comment">창고 크기는 창고에 들어갈 수 있는 팔레트의 수입니다.</span>
                            <br>
                            <span class="span-size-comment">(팔레트 규격: T11형 1,100mm*1,100mm)</span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <label for="spacePrice">공간 당 가격</label>
                        </th>
                        <td>
                            <input class="form-control input-lg input-name mb-2" type="number" id="spacePrice"
                                   name="spacePrice"
                                   placeholder=""
                                   value="" maxlength="20">
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <label for="spacePrice">특이사항</label>
                        </th>
                        <td>
                            <input class="form-control input-lg input-name mb-2" type="text" id="spacePrice"
                                   name="spacePrice"
                                   placeholder=""
                                   value="" maxlength="20">
                                   <span class="span-size-comment">ex) 높이 2m , 냉장, 방범완비 등</span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">
                            <label for="spacePrice">사진 (선택사항)</label>
                        </th>
                        <td>
                            <input class="form-control input-lg input-name mb-2" type="file" id="spacePrice"
                                   name="spacePrice"
                                   placeholder=""
                                   value="" maxlength="20">
                        </td>
                    </tr>
                    
                    </tbody>
                </table>
            </div>

            <%-- 하단에서 택배를 신청하고 취소할 수 있는 버튼 --%>
            <div class="div-result">
                <input id="btnCancel" type="button" class="btn btn-logis-outline-primary btn-cancel" value="취소"
                       style="width: 45%">
                <input id="btnLendApply" type="button" class="btn btn-lend" value="신청">
            </div>
        </form>
    </div>
</div>
</body>
</html>
