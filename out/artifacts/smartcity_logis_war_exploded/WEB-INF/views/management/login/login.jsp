<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel" %>
<%@ page import="kr.co.shovvel.dm.common.Consts" %>

<head>

    <!-- <link rel="shortcut icon" href="/image/SNUH_favicon.png"> -->

    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <!-- content="width=device-width, initial-scale=1" ksh 0730 -->
    <meta name="Author" content="">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <title>모두 고고해</title>

    <link rel="icon" type="image/png" sizes="16x16" href="/image/SNUH_favicon.png">

    <!-- Custom CSS -->
    <link href="/dist/css/style.min_login.css" rel="stylesheet">
    <link href="/assets/extra-libs/toastr/dist/build/toastr.min.css" rel="stylesheet">

    <script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="/js/jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>
    <script type="text/javascript" src="/js/ui.js"></script>

    <script type="text/javascript" src="/js/jquery.validate.min.js"></script>
    <!-- <script type="text/javascript" src="/js/form.validate.editor.js"></script> -->
    <script type="text/javascript" src="/js/jquery.bpopup.min.js"></script>
    <script type="text/javascript" src="/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/js/custom.util.js"></script>

    <!-- shovvel 추가 -->
    <script type="text/javascript" src="/jss/commonUtilHCF.js"></script>
    <script type="text/javascript" src="/jss/stringUtil.js"></script>
    <script type="text/javascript" src="/jss/jquery.form.js"></script>
    <script type="text/javascript" src="/jss/fileupload.js"></script>
    <script type="text/javascript" src="/jss/stringFormat.js"></script>
    <script type="text/javascript" src="/jss/jquery.alphanumeric.js"></script>

    <!--     <script type="text/javascript" charset="utf-8" src="/scripts/rsa/jsbn.js"></script> -->
    <!-- 	<script type="text/javascript" charset="utf-8" src="/scripts/rsa/rsa.js"></script> -->
    <!-- 	<script type="text/javascript" charset="utf-8" src="/scripts/rsa/prng4.js"></script> -->
    <!-- 	<script type="text/javascript" charset="utf-8" src="/scripts/rsa/rng.js"></script> -->
    <script type="text/javascript" charset="utf-8" src="/scripts/js/goMenuPage.js"></script>

    <!-- jQuery template -->
    <!-- <script src="http://code.jquery.com/jquery-latest.min.js"></script> -->
    <!-- <script src="http://ajax.microsoft.com/ajax/jquery.templates/beta1/jquery.tmpl.js"></script> -->
    <script type="text/javascript" charset="utf-8" src="/scripts/jquery.tmpl.js"></script>

    <c:set var="SUCCESS"><%=Consts.LOGIN_RESULT.SUCCESS%>
    </c:set>
    <c:set var="FAIL_ACCOUNT"><%=Consts.LOGIN_RESULT.FAIL_ACCOUNT%>
    </c:set>
    <c:set var="FAIL_PASSWORD"><%=Consts.LOGIN_RESULT.FAIL_PASSWORD%>
    </c:set>
    <c:set var="FAIL_PARAM"><%=Consts.LOGIN_RESULT.FAIL_PARAM%>
    </c:set>

    <script type="text/javascript">
        function cacheLoginInfo() {
            var storeId = $("#storedId").prop('checked');

            setCookie("soLoginUserSno", "", 0);
            if (storeId) {
                setCookie("soLoginUserSno", $("#id").val(), 999);
            }
        }

        function setCookie(cname, cvalue, exdays) {
            var d = new Date();
            d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
            var expires = "expires=" + d.toUTCString();
            document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
        }

        function getCookie(cname) {
            var name = cname + "=";
            var ca = document.cookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) == ' ') {
                    c = c.substring(1);
                }
                if (c.indexOf(name) == 0) {
                    return c.substring(name.length, c.length);
                }
            }
            return "";
        }

        function redirectPage(code, level, startMenu) {
            $('<form></form>', {
                name: "frmMenuHandle"
            }).appendTo($('body'));

            var frm = makeform(startMenu);
            frm.submit();
        }

        var boolSubmit = true;
        $(document).ready(function () {
            console.log("boolSubmit=" + boolSubmit);

            $("form").on("submit", function (event) {
                if (boolSubmit == false) {
                    event.preventDefault();
                }
            });

            $("#btnLogin").click(function (key) {
                sendLogin();
            });

            $("#btnJoin").click(function () {
                sendJoin();
            });

            $("#id").keydown(function (key) {
                if (key.keyCode == 13) {
                    fnIdPasswodKeyDown();
                }
            });

            $("#password").keydown(function (key) {
                if (key.keyCode == 13) {
                    fnIdPasswodKeyDown();
                }
            });

            $("#loginPassError").hide();

            $("#btn_search_id").on('click', function () {
                onModal("findId");
            });

            $("#btn_reset_password").on('click', function () {
                onModal("resetPassword");
            });

            init();
        });

        function fnIdPasswodKeyDown() {
            if ($("#id").val().trim().length > 0 && $("#password").val().trim().length > 0) {
                sendLogin();
            } else if ($("#id").val().trim().length == 0)
                $("#id").focus();
            else if ($("#id").val().trim().length > 0)
                $("#password").focus();
            else if ($("#password").val().trim().length == 0)
                $("#password").focus();

        }

        function init() {
            var soLoginUserSno = getCookie("soLoginUserSno");
            if (!isEmpty(soLoginUserSno)) {
                $("#storedId").prop('checked', true);
                $("label.icon").addClass("on");
                $("#id").val(soLoginUserSno);
            } else {
                $("#storedId").prop('checked', false);
                $("label.icon").removeClass("on");
                $("#id").val("");
            }
        }

        // 인증번호 처리를 위한 전역변수
        var timer, interval, minutes, seconds;
        var check = false;

        function setAuthTime() {
            timer = 180;
            clearInterval(interval);
            interval = setInterval("decrementTime()", 1000);
            $('#certCode').val("");
        }

        // 시간 카운트
        function decrementTime() {
            minutes = parseInt(timer / 60 % 60, 10);
            seconds = parseInt(timer % 60, 10);

            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;

            $('#time-min').text(minutes);
            $('#time-sec').text(seconds);

            if (timer > 0) {
                check = true;
                --timer;
            } else {
                check = false;
                clearInterval(interval);
                $('#time-min').text("00");
                $('#time-sec').text("00");
                $("#certCode").hide();
                $('#certCode').val("");
                $("#certCode").attr("readonly", false);
                $(".currTime").hide();
                alert('인증번호 유효시간이 만료되었습니다.');
                $("#id").attr("readonly", false);
                $("#password").attr("readonly", false);
                $(".btn_login").text("로그인");
            }
        }

        function sendLogin(no) {
            if (!validate()) {
                return;
            }

            $.ajax({
                // url : '/management/login/loginAction' ,
                url: '/management/login/taxiLoginAction',
                type: 'POST',
                data: {
                    "loginId": $("#id").val(),
                    "password": $("#password").val()
                },
                dataType: 'json',
                success: function (data) {
                    console.log("data=" + data.result + "||${SUCCESS}");

                    if (data.result == "${SUCCESS}") {
                        // cacheLoginInfo();
                        // redirectPage( data.result , data.level , data.startMenu );
                        // movePage("POST", "/management/map/map");
                        movePage("POST", "/user/home/home");
                    } else if (data.result == "${FAIL_ACCOUNT}") {
                        // 계정 없음
                        fnErrorMessage("사원번호를 확인하세요.");
                    } else if (data.result == "${FAIL_PASSWORD}") {
                        // 비밀번호 오류
                        fnErrorMessage("비밀번호를 확인하세요.");
                    } else if (data.result == "${FAIL_PARAM}") {
                        // 입력 값 오류
                        fnErrorMessage("입력 값을 확인하세요.");
                    } else if (data.result == 880) {
                        fnInitPasswordPopup();

                        //alert("초기 입력");
                        $(".colorMsgPwd").addClass("colorMsgPwdLogin");
                        $(".colorMsgPwd").removeClass("colorMsgPwd");
                        fnModalOpen('modalPasswdChange', true);

                    }
                },
                error: function (data) {
                    onModal("serverError");
                }
            });
        }

        /**
         * 화면을 이동한다.
         * @param method - GET, POST
         * @param action - 화면 경로
         */
        function movePage(method, action) {
            const form = document.createElement('form');
            form.setAttribute('method', method);
            form.setAttribute('action', action);
            document.body.appendChild(form);
            form.submit();
        }

        function sendJoin() {
            console.log("1111");
            //redirectPage("/management/map/map");
            /* $.ajax({
                url : "/management/login/join_ok" ,
                type : 'POST' ,
                data : {
                    "loginId" : $( "#id" ).val() ,
                    "password" : $( "#password" ).val()
                } ,
                dataType : 'json' ,
                success : function( data )
                {
                    console.log("!!!!");
                    redirectPage("/management/login/join");
                }
            }); */
            $.ajax({
                url: '/management/map/map',
                type: 'POST',
                data: {
                    "loginId": $("#id").val(),
                    "password": $("#password").val()
                },
                dataType: 'json',
                success: function (data) {
                    console.log("data=" + data.result + "||${SUCCESS}");
                    redirectPage("/management/login/join");

                },
                error: function (data) {
                    redirectPage("/management/login/join");
                }
            });
        }

        function validate(element) {

            if (element == null) { // login validate

                if ($("#id").val() == "") {
                    onModal("checkId");
                    $("#id").focus();
                    return false;
                }
                if ($("#password").val() == "") {
                    onModal("checkPassword");
                    $("#password").focus();
                    return false;
                }

            } else { // popup validate

                var $popup = $(element).closest(".popup");
                var isCompare = false;
                var valid = true;

                $popup.find("p.text-red").remove();
                $popup.find("input").each(function (index) {

                    if ($(this).hasClass("inp_pwd")) {
                        isCompare = true;
                        return;
                    }

                    if ($(this).hasClass("inp_name")) {
                        if ($(this).val() == "") {
                            showErrorMessage("이름을 입력해주세요.", $(this).parent());
                            valid = false;
                            return valid;
                        }
                    }

                    if ($(this).hasClass("inp_num")) {
                        //var letterNumber = /^[0-9a-zA-Z]+$/;
                        var regex = new RegExp("^[0-9]{10,11}$");
                        if (!$(this).val().match(regex)) {
                            showErrorMessage("휴대폰 번호를 형식에 맞게 입력하세요.", $(this).parent());
                            valid = false;
                            return valid;
                        }
                    }
                });

                if (isCompare) {
                    var strongRegex = new RegExp("^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,15})");
                    if ($popup.find("input:eq(0)").val() == "" || !$popup.find("input:eq(0)").val().match(strongRegex)) {
                        showErrorMessage("비밀번호는 영문, 숫자, 특수문자 조합으로 8~15자로 입력해 주셔야 합니다.", $popup.find("input:eq(0)").parent());
                        return false;
                    }

                    if ($popup.find("input:eq(1)").val() == "") {
                        showErrorMessage("비밀번호는를 다시 입력해주세요.", $popup.find("input:eq(1)").parent());
                        return false;
                    }

                    if ($popup.find("input:eq(0)").val() != $popup.find("input:eq(1)").val()) {
                        showErrorMessage("비밀번호는가 일치하지 않습니다.", $popup.find("input:eq(1)").parent());
                        return false;
                    }
                }

                return valid;
            }

            return true;
        }

        function onModal(modalCode) {

            var data = {
                "modalCode": modalCode
            };
            var isAlert = false;

            switch (modalCode) {
                case "serverError" :
                    data.title = "서버 오류";
                    data.comment = "잠시 후 다시 시도해 주세요.";
                    isAlert = true;
                    break;

                case "checkInputData" :
                    data.title = "사용자 정보 확인";
                    data.comment = "등록되지 않은 아이디이거나,<br>아이디 또는 비밀번호를 잘못 입력하셨습니다.";
                    isAlert = true;
                    break;

                case "checkId" :
                    data.title = "아이디 확인";
                    data.comment = "아이디를 입력해주세요.";
                    isAlert = true;
                    break;

                case "checkPassword" :
                    data.title = "비밀번호 확인";
                    data.comment = "비밀번호를 입력해주세요.";
                    isAlert = true;
                    break;

                case "failCertCode" :
                    data.title = "인증번호 오류";
                    data.comment = "인증번호가 잘못 입력되었습니다.";
                    isAlert = true;
                    break;

                case "certTimeOver" :
                    data.title = "인증번호 입력";
                    data.comment = "인증번호 입력시간을 초과하였습니다.";
                    isAlert = true;
                    break;

                case "sendSMSId" :
                    data.title = "아이디 발송";
                    data.comment = "등록하신 휴대폰 번호로 아이디를 발송하였습니다.";
                    isAlert = true;
                    break;

                case "sendSMSTempPassword" :
                    data.title = "임시 비밀번호 발송";
                    data.comment = "등록하신 휴대폰 번호로 임시 비밀번호를 발송하였습니다.";
                    isAlert = true;
                    break;

                case "findId" :
                    data.title = "아이디 찾기";
                    data.comment = "회원정보에 등록한 이름과 휴대폰 번호를 입력하시면 \n등록하신 휴대폰번호로 아이디가 전송됩니다.";
                    break;

                case "resetPassword" :
                    data.title = "비밀번호 재설정";
                    data.comment = "회원정보에 등록한 이름과 휴대폰 번호를 입력하시면 \n등록하신 휴대폰번호로 임시 비밀번호가 전송됩니다.";
                    break;

                case "initPassword" :
                    data.title = "비밀번호 재설정";
                    data.comment = "새로 사용하실 비밀번호를 입력해 주세요.";
                    break;
            }

            if (isAlert) {
                doOpenPopup(data.title, data.comment, false);
                return;
            }

            $popup = $('#popup_modal_template').tmpl(data);
            $popup.find("input.inp_num").numeric();

            $("body").append($popup);
            $popup.bPopup();
        }

        function onModalButtonClick(popup, modalCode) {

            if (!validate(popup)) {
                return;
            }

            var $popup = $(popup).closest(".popup");

            switch (modalCode) {
                case "findId" :
                    var param = {
                        username: $popup.find("#username").val(),
                        phonenumber: $popup.find("#phonenumber").val()
                    };

                    $.ajax({
                        url: "/management/login/findUserIdAction",
                        type: "POST",
                        data: param,
                        dataType: "json",
                        success: function (data) {
                            if (data.result == "SUCCESS") {
                                onModal("sendSMSId");
                                doClosePopup(popup);
                            } else {
                                showErrorMessage("입력하신 내용과 일치하는 회원정보가 없습니다.다시 확인 후 입력해 주세요.", $popup.find(".form_table"));
                                return;
                            }
                        },
                        error: function () {
                            onModal("serverError");
                        }
                    });

                    break;

                case "resetPassword" :
                    var param = {
                        username: $popup.find("#username").val(),
                        phonenumber: $popup.find("#phonenumber").val()
                    };

                    $.ajax({
                        url: "/management/login/resetPasswordAction",
                        type: "POST",
                        data: param,
                        dataType: "json",
                        success: function (data) {
                            if (data.result == "SUCCESS") {
                                onModal("sendSMSTempPassword");
                                doClosePopup(popup);
                            } else {
                                showErrorMessage("입력하신 내용과 일치하는 회원정보가 없습니다.다시 확인 후 입력해 주세요.", $popup.find(".form_table"));
                                return;
                            }
                        },
                        error: function () {
                            onModal("serverError");
                        }
                    });
                    break;

                case "initPassword" :
                    var param = {
                        current_password: $("#password").val(),
                        new_password: $popup.find("input:eq(0)").val(),
                        new_confirm_password: $popup.find("input:eq(1)").val()
                    };

                    $.ajax({
                        url: "/management/login/changeInitialPasswordAction",
                        type: "POST",
                        data: param,
                        dataType: "json",
                        success: function (data) {
                            if (data.result == "succ") {
                                $("#password").val($popup.find("input:eq(0)").val());
                                login();
                            } else {
                                onModal("serverError");
                            }
                        },
                        error: function () {
                            onModal("serverError");
                        }
                    });

                    break;
            }
        }

        function showErrorMessage(message, target) {
            $("<p></p>", {
                "class": "text-red",
                text: message
            }).appendTo(target);
        }

        function fnProcPasswdInit() {

            if ($("#loginId").val().trim() == "") {
                fnErrorMessage("입력 값을 확인하세요.");
                return;
            }
            var param = {
                loginId: $("#loginId").val()
            };
            $("#loginPassError").hide();
            $.ajax({
                url: "/management/login/resetPasswordAction",
                type: "POST",
                data: param,
                dataType: "json",
                success: function (data) {
                    if (data.result == "SUCCESS") {
                        toastr.success('비밀번호가 생년월일 6자리로 설정 되었습니다.', '비밀번호 초기화 완료');
                        $("#loginform").fadeIn();
                        $("#recoverform").slideUp();
                    } else {
                        $("#loginPassError").show();
                    }
                },
                error: function () {
                    fnErrorMessage("serverError");
                }
            });
        }

        function fnMoveAdminLogin() {
            $("#loginId").val("");
            $("#loginform").slideDown();
            $("#recoverform").fadeOut();
        }
    </script>
    <style type="text/css">
        .label-color-black {
            color: #313131;
        }
    </style>
</head>

<body>
<div class="main-wrapper">
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>

    <div class="auth-wrapper d-flex no-block justify-content-center align-items-center"
         style="background: url(/assets/images/background/login_image.jpg) no-repeat center center; background-size: cover;">
        <div class="auth-box" style="position: relative;margin:15% 0;">
            <div id="loginform">
                <div class="logo">
						<span class="db">
							<img src="/image/snuh_main_img_main.png" alt="logo" style="padding-top: 3px;"/>
						</span>

                </div>
                <!-- Form -->
                <div class="row">
                    <div class="col-12">

                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1">
										<i class="ti-user"></i>
									</span>
                            </div>
                            <!-- <input type="text" id="id" class="form-control form-control-lg" placeholder="사원번호" aria-label="id" aria-describedby="basic-addon1" value="superadmin"> -->
                            <input type="text" id="id" class="form-control form-control-lg" placeholder="사원번호"
                                   aria-label="id" aria-describedby="basic-addon1" value="" style="background: none"/>
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon2">
										<i class="ti-pencil"></i>
									</span>
                            </div>
                            <!-- <input type="password" id="password" class="form-control form-control-lg" placeholder="비밀번호" aria-label="Password" aria-describedby="basic-addon1" value="Password1!"> -->
                            <input type="password" id="password" class="form-control form-control-lg" placeholder="비밀번호"
                                   aria-label="Password" aria-describedby="basic-addon1" value="123456"
                                   style="background: none">
                        </div>
                        <div class="form-group row">
                            <div class="col-md-12">
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" name="storedId" id="storedId">
                                    <label class="custom-control-label label-color-black" for="storedId">사원번호 저장</label>
                                    <a href="javascript:void(0)" id="to-recover" class="text-dark float-right">
                                        <i class="fa fa-lock mr-1"></i>
                                        비밀번호 찾기
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="form-group text-center">
                            <div class="col-xs-12 pb-3">
                                <button id="btnLogin" class="btn btn-block btn-lg btn-primary">Log In</button>
                            </div>

                            <div class="col-xs-12 pb-3">
                                <button id="btnJoin" class="btn btn-block btn-lg btn-primary">Join</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <div id="recoverform">
                <div class="logo">
						<span class="db">
							<img src="/image/snuh_main_img_main.png" alt="logo" style="padding-top: 3px;"/>
						</span>
                    <h5 class="font-medium mb-3">서울대학교병원 강남센터 관리자웹</h5>
                </div>
                <!-- Form -->
                <div class="row">
                    <div class="col-12">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1">
										<i class="ti-user"></i>
									</span>
                            </div>
                            <!-- <input type="text" id="loginId" name="loginId" class="form-control form-control-lg" placeholder="사원번호" aria-label="loginId" aria-describedby="basic-addon1" value="superadmin" style="background: none"> -->

                            <input type="text" id="loginId" name="loginId" class="form-control form-control-lg"
                                   placeholder="사원번호" aria-label="loginId" aria-describedby="basic-addon1"
                                   style="background: none">
                            <!-- <input type="text" id="id" class="form-control form-control-lg" placeholder="아이디" aria-label="id" aria-describedby="basic-addon1" value=""> -->
                        </div>
                        <div class="row" id="loginPassError">
                            <div class="col-xs-12 pb-3"></div>
                            <label class="label-color-black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;입력하신 사원번호를 찾을 수
                                없습니다.</label>
                        </div>
                        <div class="text-center">
                            <div class="col-xs-12 pb-3">
                                <button class="btn btn-lg btn-secondary" onclick="fnMoveAdminLogin()">취소</button>
                                <button class="btn btn-danger btn-lg btn-primary" onclick="fnProcPasswdInit()">비밀번호
                                    초기화
                                </button>
                            </div>
                            <label class="label-color-black">회원가입은 관리자에게 문의해주시기 바랍니다.</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="loginPassModel" tabindex="-1" role="dialog" aria-labelledby="createModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="createModalLabel">
                    <i class="ti-marker-alt mr-2"></i>
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>
<script src="/assets/libs/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap tether Core JavaScript -->
<script src="/assets/libs/popper.js/dist/umd/popper.min.js"></script>
<script src="/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="/assets/extra-libs/toastr/dist/build/toastr.min.js"></script>
<script src="/assets/extra-libs/toastr/toastr-init.js"></script>
<script>
    $('[data-toggle="tooltip"]').tooltip();
    $(".preloader").fadeOut();
    // ==============================================================
    // Login and Recover Password
    // ==============================================================
    $('#to-recover').on("click", function () {
        $("#recoverform").fadeIn();
        $("#loginform").slideUp();
    });
</script>

<!-- modal popup : start -->
<%@include file="/WEB-INF/template/modalPopup.jsp" %>
<!-- modal popup : end -->
</body>
