<%--
  Created by IntelliJ IDEA.
  User: jeonseungcheol
  Date: 2020/10/16
  Time: 3:56 오후
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
    <title>물류 공유해 : 회원가입</title>

    <meta content="user-scalable=no, width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0"
          name="viewport">

    <%-- Reset CSS --%>
    <link rel="stylesheet" href="/css/reset.css">

    <%-- Bootstrap, JQuery Library --%>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <script src="/assets/libs/jquery/dist/jquery.min.js"></script>
    <script src="/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>

    <%-- SHA-256 --%>
    <script type="text/javascript" src="<c:url value='/js/core.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/sha256.min.js'/>"></script>

    <%-- 우편번호 --%>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <link rel="stylesheet" href="<c:url value='/css/content_logis.css'/>"/>

    <c:set var="SUCCESS"><%=Consts.SIGN_UP.SUCCESS%>
    </c:set>
    <c:set var="FAIL"><%=Consts.SIGN_UP.FAIL%>
    </c:set>
    <c:set var="CERT_FAIL"><%=Consts.SIGN_UP.CERT_FAIL%>
    </c:set>
    <c:set var="DUPLICATED"><%=Consts.SIGN_UP.DUPLICATED%>
    </c:set>

    <script>
        $(document).on("keyup", "phoneNumber", function () {
            $(this).val($(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/, "$1-$2-$3").replace("--", "-"));
        });

        $(document).ready(function () {
            // 가입하기 버튼 클릭
            $("#btnSignUp").click(function (key) {
                if (validate()) {
                    sendSignUp();
                }
            });

            $("#btnRequestAddress").click(function () {
                requestAddress();
            });

            $("#postcode").click(function () {
                requestAddress();
            });
        });

        /**
         * 입력 데이터 검증
         */
        function validate() {
            const idRegExp = /^[a-z]+[a-z0-9]{5,19}$/g; // 아이디 정규식
            const passwordRegExp = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/; // 비밀번호 정규식
            const phoneNumberRegExp = /^[0-9]{11}$/;

            const id = document.getElementById("id"); // 아이디
            const password = document.getElementById("password"); // 비밀번호
            const password2 = document.getElementById("password2"); // 비밀번호 확인
            const managerName = document.getElementById("managerName"); // 관리자명
            const phoneNumber = document.getElementById("phoneNumber"); // 연락처
            const companyName = document.getElementById("companyName"); // 회사명

            // 주소
            const postcode = document.getElementById("postcode"); // 우편번호
            const address = document.getElementById("address"); // 주소

            // ----------------- 아이디 -----------------

            if (!checkRegExp(idRegExp, id, "아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.")) {
                // 아이디 창으로 화면 스크롤
                $("#id").focus();
                const scrollPosition = $("#id").offset().top;
                scrollToPosition(scrollPosition);
                return false;
            }

            // ----------------- 비밀번호 -----------------

            /* 테스트 때문에 주석했음. 다시 풀어야 함
            if (!checkRegExp(passwordRegExp, password, "8~16자리 영문 대 소문자, 숫자, 특수문자를 사용하세요.")) {
                return false;
            }
            */

            if (password.value !== password2.value) {
                alert("비밀번호가 다릅니다. 다시 확인해 주세요.");
                password2.value = "";
                password2.focus();
                return false;
            }

            // ----------------- 관리자명 -----------------

            if (managerName.value === "") {
                alert("관리자명을 입력해주세요.");
                managerName.focus();
                return false;
            }

            // ----------------- 연락처 -----------------

            if (!checkRegExp(phoneNumberRegExp, phoneNumber, "휴대폰번호를 정확히 입력해 주세요.")) {
                return false;
            }

            // ----------------- 회사명 -----------------

            if (companyName.value === "") {
                alert("회사명을 입력해주세요.");
                companyName.focus();
                return false;
            }

            // ----------------- 회사주소 -----------------

            if (postcode.value === "" || address.value === "") {
                alert("주소를 입력해주세요.");
                return false;
            }

            return true;
        }

        /**
         * 회원가입 요청
         */
        function sendSignUp() {
            let logisUser = {};
            logisUser.loginId = $("#id").val();

            const sha256Password = CryptoJS.SHA256($("#password").val()).toString();
            logisUser.passwd = sha256Password;
            logisUser.managerName = $("#managerName").val();
            logisUser.phoneNumber = $("#phoneNumber").val();
            logisUser.companyName = $("#companyName").val();
            logisUser.postcode = $("#postcode").val();
            logisUser.address = $("#address").val() + " " + $("#detailAddress").val();

            $.ajax("/user/signUp/signUpAction",
                {
                    method: 'POST',
                    data: logisUser,
                    dataType: 'JSON'
                }
            ).done(function (data) {
                if (data.result == "${SUCCESS}") {
                    alert("회원가입이 완료되었습니다.");
                    history.back();
                } else if (data.result == "${FAIL}") {
                    alert("회원가입에 실패하였습니다.");
                } else if (data.result == "${CERT_FAIL}") {
                    alert("인증번호를 다시 확인해주세요.");
                } else if (data.result == "${DUPLICATED}") {
                    alert("이미 가입된 아이디입니다.");

                    // 아이디 창으로 화면 스크롤
                    $("#id").focus();
                    const scrollPosition = $("#id").offset().top;
                    scrollToPosition(scrollPosition);
                }
            });
        }

        /**
         * 특정 위치로 화면 이동 ex) $("#id").offset().top
         */
        function scrollToPosition(position) {
            $("body").animate({
                scrollTop: position
            }, 300);
        }

        // 다음 우편번호 API 팝업
        function requestAddress() {
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
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById("address").value = addr;

                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("detailAddress").focus();
                }
            }).open();
        }

        /**
         *
         * @param regExp  - 정규식
         * @param what    - 비교 할 태그
         * @param message - 알림 메시지
         * @returns {boolean}
         */
        function checkRegExp(regExp, what, message) {
            if (regExp.test(what.value)) {
                return true;
            }
            alert(message);
            what.value = "";
            what.focus();
            return false;
        }

    </script>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            overflow: auto;
            scroll-behavior: smooth;
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

        #header {
            width: 100%;
            height: 150px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        #container {
            width: 100%;
            padding: 5%;
            height: 100%;
        }

        #content {
            display: flex;
            flex-direction: column;
        }

        #footer {
            height: 100px;
        }

        body {
            overflow: auto;
            scroll-behavior: smooth;
            /*background-color: #fafafa;*/
            background-color: #f0f0f0;
        }

        #wrap {
            width: 550px;
            margin: 0 auto;
            background-color: white;
        }

        /* 화면 너비 0 ~ 768px */
        @media (max-width: 768px) {
            #wrap {
                width: 100%;
            }
        }

        .span-input-title {
            font-weight: bolder;
        }

        .span-input-guide {
            font-size: small;
            color: grey;
        }

        input::placeholder {
            font-size: medium;
        }

        h1 {
            display: flex;
        }

        .span-signup-title {
            font-size: 2.5rem;
            font-weight: 700;
        }

    </style>
</head>
<body>
<div class="header">
    <span class="header-title">회원가입</span>
</div>
<div id="wrap">
    <div id="container">
        <div id="content">
            <span class="span-input-title">아이디</span>
            <div class="input-group input-group-lg mt-2 mb-5">
                <input id="id" name="id" type="text" class="form-control input-lg input-box"
                       placeholder="아이디"
                       aria-label="id"
                       value=""/>
            </div>

            <span class="span-input-title">비밀번호</span>
            <div class="input-group input-group-lg mt-2 mb-2">
                <input id="password" name="password" type="password" class="form-control input-lg input-box"
                       placeholder="비밀번호 입력"
                       aria-label="password"
                       value=""/>
            </div>

            <div class="input-group input-group-lg mb-2">
                <input id="password2" name="password2" type="password" class="form-control input-lg input-box"
                       placeholder="비밀번호 재확인 입력"
                       aria-label="password2"
                       value=""/>
            </div>

            <span class="span-input-guide mb-5">8~16자리 영문 대 소문자, 숫자, 특수문자를 사용하세요.</span>

            <span class="span-input-title">관리자명</span>
            <div class="input-group input-group-lg mt-2 mb-5">
                <input id="managerName" name="managerName" type="text" class="form-control input-lg input-box"
                       placeholder="성함"
                       aria-label="managerName"
                       value=""/>
            </div>

            <span class="span-input-title">연락처</span>
            <div class="input-group input-group-lg mt-2 mb-5">
                <input id="phoneNumber" name="phoneNumber" type="number" class="form-control input-lg input-box"
                       placeholder="- 를 빼고 입력해주세요"
                       aria-label="managerName"
                       value=""/>
            </div>

            <span class="span-input-title">회사명</span>
            <div class="input-group input-group-lg mt-2 mb-5">
                <input id="companyName" name="companyName" type="text" class="form-control input-lg input-box"
                       placeholder="회사명"
                       aria-label="companyName"
                       value=""/>
            </div>

            <span class="span-input-title">회사 주소</span>
            <div class="input-group input-group-lg mt-2 mb-2">
                <input id="postcode" name="postcode" type="text" class="form-control input-lg input-box"
                       placeholder="우편번호"
                       aria-label="postcode" value="" readonly/>


                <button id="btnRequestAddress" type="button" class="btn btn-logis-primary ml-1"
                        style="border-radius: 0 6px 6px 0; border: 0; font-size: large;">우편번호 찾기
                </button>
            </div>
            <div class="input-group input-group-lg mb-2">
                <input id="address" name="address" type="text" class="form-control input-lg input-box" placeholder="주소"
                       aria-label="address" value="" readonly/>
            </div>
            <div class="input-group input-group-lg mb-2">
                <input id="detailAddress" name="detailAddress" type="text" class="form-control input-lg input-box"
                       placeholder="상세주소"
                       aria-label="detailAddress"
                       value=""/>
            </div>

            <button id="btnSignUp" type="button" class="btn btn-logis-primary mt-3 mb-5"
                    style="border: 0;  font-size: x-large; padding: 3%">가입하기
            </button>
        </div>
    </div>
    <div id="footer">

    </div>
</div>

</body>
</html>
