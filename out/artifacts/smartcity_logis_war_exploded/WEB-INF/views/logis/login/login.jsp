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
            // 로그인 버튼 클릭
            $("#btnLogin").click(function () {
                sendLogin();
            });

            // 회원가입 버튼 클릭
            $("#btnSignUp").click(function () {
                movePage("POST", "/user/signUp/signUp"); // 회원가입 화면 이동
            });

        });

        /**
         * 로그인 처리
         */
        function sendLogin() {
            if (!validate()) {
                return;
            }

            $.ajax({
                url: '/user/login/loginAction',
                type: 'POST',
                data: {
                    "loginId": $("#id").val(),
                    "passwd": $("#password").val()
                },
                dataType: 'json',
                success: function (data) {
                    console.log("data=" + data.result + "|| ${SUCCESS}");

                    if (data.result == "${SUCCESS}") {
                        // redirectPage( data.result , data.level , data.startMenu );
                        // movePage("POST", "/management/map/map");
                        movePage("POST", "/user/home/home");
                    } else if (data.result == "${FAIL_PARAM}") {
                        // 입력 값 오류
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

        /**
         * 화면 이동
         */
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
            background-color: white;
        }

        #wrap {
            width: 500px;
            margin: 0 auto;
            max-height: 100vh;
            background-color: white;
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
            border: 1px solid lightgrey;
            border-radius: 8px;
        }

        .btn-text {
            font-size: 1.3rem;
            font-weight: 500;
        }

        .footer {
            width: 100%;
            height: 10vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .span-title {
            font-weight: 800;
            font-size: 3rem;
        }

        .input-text {
            border: 1px solid #0E2F91;
        }
    </style>
</head>

<body>
<div id="wrap">
    <div class="header"></div>
    <div class="section">
        <!-- 로고 -->

        <div style="align-self: center; width: 60%; text-align: center;">
            <span class="span-title">물류 공유해</span>
        </div>
        <img src="/images/logo@2x.png" class="mb-5"
             style="align-self: center; width: 60%; display: none;" alt=""/>

        <div style="display: flex; flex-direction: column;">
            <form style="padding: 5%">
                <div class="input-group input-group-lg mb-2 mt-5">
                    <input id="id" type="text" class="form-control input-lg input-text" placeholder="아이디"
                           aria-label="id"
                           value="superadmin"
                           aria-describedby="basic-addon1">
                </div>
                <div class="input-group input-group-lg mb-2">
                    <input id="password" type="password" class="form-control input-lg input-text" placeholder="비밀번호"
                           aria-label="password"
                           value="123456"
                           aria-describedby="basic-addon1">
                </div>

                <input id="btnLogin" class="btn btn-logis-primary btn-text" value="로그인" type="button"
                       style="width: 100%; height: 5.5vh; margin-bottom: 1%;">
                <input id="btnSignUp" class="btn btn-logis-outline-primary btn-text" value="회원가입" type="button"
                       style="width: 100%; height: 5.5vh;">
            </form>
        </div>

    </div>
    <div class="footer">
        <img src="/images/gimhae_logo@2x.png" class="mb-5"
             style="width: 80px; align-self: center; display: none;" alt=""/>
    </div>
</div>
</body>
</html>