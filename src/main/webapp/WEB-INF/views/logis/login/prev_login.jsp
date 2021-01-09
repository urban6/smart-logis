<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kr.co.shovvel.dm.common.Consts" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>물류 공유해 : 로그인</title>

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
            $("#btnLogin").click(function () {
                sendLogin();
            });

            $("#password").keydown(function(key){
                if(key.keyCode==13){
                    sendLogin();
                }
            });

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
    <style type="text/css">
        body {
            background: url('/images/BG_1.png') no-repeat 50% 50% fixed;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }

        #wrap {
            width: 500px;
            margin: 0 auto;
            max-height: 100vh;
        }

        /* 화면 너비 0 ~ 768px */
        @media (max-width: 768px) {
            #wrap {
                width: 100%;
            }
        }

        /* 화면 너비 769px ~ */
        @media (min-width: 769px) {
            #wrap {
                width: 500px;
            }
        }

        .header {
            width: 100%;
            height: 8vh;
        }

        .section {
            width: 100%;
            height: 82vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .input-text {
            background-color: rgba(255, 255, 255, 0.4);
            border-radius: 4px;
            border: 2px solid white;
            color: white;
        }

        .input-text::placeholder {
            color: white;
            border-radius: 4px;
        }

        .footer {
            width: 100%;
            height: 10vh;
            display: flex;
            flex-direction: row;
            justify-content: space-around;
        }

        .span-title {
            font-weight: 700;
            font-size: 2.5rem;
            color: white;
        }

        .div-divider {
            margin: 2.4rem 0;
            width: 100%;
            height: 2px;
            background-color: white;
        }

        .btn-login {
            border: 2px solid white;
            color: lightgrey;
            font-size: 1.2rem;
        }

        .btn-login:hover {
            color: white;
        }

        p {
            color: white;
            font-size: 1.2rem;
            margin: 0;
        }

        a {
            color: white;
            font-size: 1.2rem;
        }

        .div-center-box {
            display: flex;
            flex-direction: column;
            margin-top: 10%;
            align-self: center;
            width: 60%;
            text-align: center;
        }

        .div-logo-box {
            width: 100%;
            height: 10vh;
            display: flex;
            flex-direction: row;
            justify-content: space-around;
        }

        .span-footer-title {
            color: white;
        }
    </style>
</head>

<body>
<div id="wrap">
    <div class="header"></div>
    <div class="section">
        <div class="div-center-box">
            <span class="span-title">물류 공유해</span>
        </div>
        <div style="display: flex; flex-direction: column;">
            <form style="padding: 5%">
                <p>
                    김해시 스마트시티 챌린지 사업으로 추진하는 기업 간 유휴 창고를 공유하고 물류를 공동 배송하는 서비스 입니다.
                </p>

                <div class="input-group input-group-lg mb-2 mt-4">
                    <input id="id" type="text" class="form-control input-lg input-text" placeholder="ID"
                           style="padding: 1.6rem 1rem"
                           aria-label="id"
                           value=""
                           aria-describedby="basic-addon1">
                </div>
                <div class="input-group input-group-lg mb-2">
                    <input id="password" type="password" class="form-control input-lg input-text" placeholder="Password"
                           style="padding: 1.6rem 1rem"
                           aria-label="password"
                           value=""
                           aria-describedby="basic-addon1">
                </div>

                <div class="div-divider"></div>

                <input id="btnLogin" class="btn btn-login" value="로그인" type="button"
                       style="width: 100%; height: 5.5vh; margin-bottom: 1%;">

                <div class="mt-2">
                    <a href="javascript: movePage('POST', '/user/signUp/signUp')" style="float: right">회원가입</a>
                </div>
            </form>
        </div>
        <div class="div-logo-box">
            <img src="/images/ml_main_logo.jpg" class="mt-5" style="width: 40%"/>
            <img src="/images/gimhae_main_logo.jpg" class="mt-5" style="width: 40%"/>
        </div>
    </div>
    <div class="footer">
    </div>
</div>
</body>
</html>

