<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kr.co.shovvel.dm.common.Consts" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=0.9, user-scalable=no">
    <title>SMART GIMHAE</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/superslides.css">
    <script src="/js/jquery.min.js"></script>

    <script src="/js/all.js" type="text/javascript"></script>
    <script src="/javascripts/jquery.easing.1.3.js"></script>
    <script src="/javascripts/jquery.animate-enhanced.min.js"></script>
    <script src="/javascripts/hammer.min.js"></script>
    <script src="/javascripts/jquery.superslides.js" type="text/javascript" charset="utf-8"></script>

    <%-- SHA-256 --%>
    <script type="text/javascript" src="<c:url value='/js/core.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/sha256.min.js'/>"></script>

    <c:set var="SUCCESS"><%=Consts.LOGIN_RESULT.SUCCESS%>
    </c:set>
    <c:set var="FAIL_ACCOUNT"><%=Consts.LOGIN_RESULT.FAIL_ACCOUNT%>
    </c:set>
    <c:set var="FAIL_PASSWORD"><%=Consts.LOGIN_RESULT.FAIL_PASSWORD%>
    </c:set>
    <c:set var="FAIL_PARAM"><%=Consts.LOGIN_RESULT.FAIL_PARAM%>
    </c:set>

    <script type="text/javascript">
        $(document).ready(function () {
            // 로그인
            $("#btnLogin").click(function () {
                sendLogin();
            });

            $("#password").keydown(function (key) {
                if (key.keyCode == 13) {
                    sendLogin();
                }
            });

            // 회원가입
            $("#btnSignUp").click(function () {
                movePage("POST", "/user/signUp/signUp");
            });
        });

        /**
         * 로그인 처리
         */
        function sendLogin() {
            if (!validate()) {
                return;
            }

            const sha256Password = CryptoJS.SHA256($("#password").val()).toString();

            $.ajax({
                url: '/user/login/loginAction',
                type: 'POST',
                data: {
                    "loginId": $("#id").val(),
                    "passwd": sha256Password
                },
                dataType: 'json',
                success: function (data) {
                    if (data.result == "${SUCCESS}") {
                        movePage("POST", "/user/home/home");
                    } else if (data.result == "${FAIL_PARAM}") {
                        alert("아이디 또는 비밀번호를 다시 확인해주세요.");
                    }
                },
                error: function (data) {
                }
            });
        }

        // 아이디, 비밀번호 공백 체크
        function validate() {
            if ($("#id").val() === "") {
                alert("아이디를 입력해주세요.");
                $("#id").focus();
                return false;
            }

            if ($("#password").val() === "") {
                alert("비밀번호를 입력해주세요.");
                $("#password").focus();
                return false;
            }

            return true;
        }

        function movePage(method, action) {
            const form = document.createElement('form');
            form.setAttribute('method', method);
            form.setAttribute('action', action);
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</head>
<body>
<div class="intro">
    <img src="/images/logo.png" alt=""><br>
    김해시 스마트시티 챌린지 사업으로 추진하는<br>기업간 유휴 창고를 공유하고 물류를 공동 배송하는 서비스 입니다.<br>
    <form>
        <input id="id" type="text" placeholder="ID"><br>
        <input id="password" type="password" placeholder="Password" autocomplete="off"><br>
    </form>
    <div id="btnLogin" class="login">로그인</div>
    <br>
    <a href="#">이용안내</a><a href="/user/signUp/signUp">회원가입</a>
</div>
<div class="embs">
    <img src="/images/emb.png" alt=""> <img src="/images/emb2.png" alt="">
</div>
<footer>
    Copyright ⓒ 2021 <span>Gimhae City</span>, All Rights Reserved.
</footer>
</body>
</html>
