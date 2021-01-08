<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel" %>
<link href="/dist/css/style.min.css" rel="stylesheet">

<!-- Password change content -->
<div id="modalPasswdChange" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-sm" aria-labelledby="vcenter">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title colorMsgPwd">비밀번호 변경</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <form id="passwdForm" method="post">
                        <input type="hidden" id="userSnoPasswdChange" name="userSno" value="" readonly="readonly"/>
                        <input type="hidden" id="loginIdPasswdChange" name="loginId" value="" readonly="readonly"/>
                        <input type="hidden" id="statusPasswdChange" name="status" value="" readonly="readonly"/>
                        <input type="hidden" id="partnerSnoPasswdChange" name="partnerSno" value=""
                               readonly="readonly"/>
                        <input type="hidden" id="searchTextPasswdChange" name="searchText" value=""
                               readonly="readonly"/>
                        <input type="hidden" id="searchDeptPasswdChange" name="searchDept" value=""
                               readonly="readonly"/>
                        <input type="hidden" id="searchUserLevelPasswdChange" name="searchUserLevel" value=""
                               readonly="readonly"/>
                        <input type="hidden" id="searchStatePasswdChange" name="searchState" value=""
                               readonly="readonly"/>
                        <div class="row">
                            <div class="col-12">
                                <label class="colorMsgPwd" onlick="javascript:fnTest();">현재 비밀번호</label>
                                <div class="form-group">
                                    <input type="password" class="form-control" placeholder="" id="passwdOld"
                                           name="passwdOld" value=""/>
                                </div>
                                <small class="form-text text-muted colorMsgPwd" id="modalCommentPasswdOld">
                                    <code>비밀번호를 다시 입력해주세요.</code>
                                </small>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <label class="colorMsgPwd" onlick="javascript:fnTest();">새 비밀번호</label>
                                <div class="form-group">
                                    <input type="password" class="form-control" placeholder="" id="passwd1"
                                           name="passwd1" value=""/>
                                </div>
                                <small class="form-text text-muted colorMsgPwd" id="modalCommentPasswdLength">6자리
                                    이상</small>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <label class="colorMsgPwd" onlick="javascript:fnTest();">새 비밀번호</label>
                                <div class="form-group">
                                    <input type="password" class="form-control" placeholder="" id="passwd2"
                                           name="passwd2" value=""/>
                                </div>
                                <small class="form-text text-muted colorMsgPwd" id="modalCommentPasswd">
                                    <code>비밀번호가 일치하지 않습니다.</code>
                                </small>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">취소</button>
                <button type=button class="btn btn-primary waves-effect waves-light"
                        onclick="javascript:fnProcPasswdChange();">변 경
                </button>
            </div>
        </div>
    </div>
</div>
<!-- /.modal -->

<!-- Result modal content -->
<div id="modalResult" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
     style="display: none;">
    <div class="modal-dialog" aria-labelledby="vcenter">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <strong><code id="modalSpanResultTitle">결과 확인</code></strong>
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label class="control-label">
                        <span class="d-none" id="modalSpanResultFormId"></span>
                        <span class="d-none" id="modalSpanResultType"></span>
                        <span class="colorMsgPwd" id="modalSpanResultMessage">{resultMessage}</span>
                    </label>
                </div>
            </div>
            <div class="modal-footer">
                <button type=button class="btn btn-primary waves-effect waves-light" id="btnModalClose"
                        onclick="javascript:fnResultSubmit();">확인
                </button>
            </div>
        </div>
    </div>
</div>
<!-- // Result modal content -->
<!-- Error modal content -->
<div id="modalError" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
     style="display: none;">
    <div class="modal-dialog" aria-labelledby="vcenter">
        <div class="modal-content" style="background: #2f323e;">
            <div class="modal-header">
                <h5 class="modal-title">
                    <strong><code id="modalSpanErrorTitle">오류 발생</code></strong>
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label class="control-label">
                        <span id="modalSpanErrorMessage">{errorMessage}</span>
                    </label>
                </div>
            </div>
            <div class="modal-footer">
                <button type=button class="btn btn-primary waves-effect waves-light"
                        onClick="javascript:fnModalOpen( 'modalError', false);">확인
                </button>
            </div>
        </div>
    </div>
</div>
<!-- // Error modal content -->


<!-- Loading content -->
<div id="loading" class="loading d-none">
    <div class="spinner-border float-center" role="status">
        <span class="sr-only">Loading...</span>
    </div>
</div>
<!-- // Loading content -->

<style type="text/css">
    .loading {
        position: absolute;
        top: 50%;
        left: 50%;
        z-index: 99;
    }

    .colorMsgPwd {
        color: #FFFFFF;
    }

    .colorMsgPwdLogin {
        color: #000000;
    }
</style>

<script type="text/javascript">
    var boolSubmit = false;

    $(document).ready(function () {
        $("#passwdOld").keyup(function () {
            $("#modalCommentPasswdOld").addClass("d-none");
        });

        $("#passwd1").keyup(function () {
            if (valid.minLen($(this).val(), 6)) {
                $("#modalCommentPasswdLength").removeClass("d-none");
            } else {
                $("#modalCommentPasswdLength").addClass("d-none");
            }
        });

        $("#passwd1").change(function () {
            console.log("change valid=" + valid.minLen($(this).val(), 6));
            if (valid.minLen($(this).val(), 6)) {
                $("#modalCommentPasswdLength").removeClass("d-none");
            } else {
                $("#modalCommentPasswdLength").addClass("d-none");
            }
        });

        $("#passwd2").keyup(function () {
            console.log("valid=" + valid.isEquals($("#passwd1").val(), $("#passwd2").val()));
            if (valid.isEquals($("#passwd1").val(), $("#passwd2").val())) {
                $("#modalCommentPasswd").addClass("d-none");
            } else {
                $("#modalCommentPasswd").removeClass("d-none");
            }
        });

        $("#passwd2").change(function () {
            console.log("change valid=" + valid.isEquals($("#passwd1").val(), $("#passwd2").val()));
            if (valid.isEquals($("#passwd1").val(), $("#passwd2").val())) {
                $("#modalCommentPasswd").addClass("d-none");
            } else {
                $("#modalCommentPasswd").removeClass("d-none");
            }
        });
    });

    function fnModalOpen(modalId, boolOpen) {
        if (boolOpen) {
            $('div#' + modalId).modal();
        } else {
            $('div#' + modalId).modal('hide');
        }
    }

    function fnResultMessage(message) {
        fnResultMessage("", $(form).attr("id"), "결과", message);
    }

    function fnResultMessage(returnType, message) {
        fnResultMessage(returnType, $(form).attr("id"), "결과", message);
    }

    function fnResultMessage(returnType, form, message) {
        fnResultMessage(returnType, $(form).attr("id"), "결과", message);
    }

    function fnResultMessage(returnType, formId, title, message) {
        boolSubmit = false;

        console.log("type=" + returnType + "\tformId=" + formId + "\ttitle=" + title + "\tmessage=" + message);
        $("#modalSpanResultType").text(returnType);
        $("#modalSpanResultFormId").text(formId);
        $("#modalSpanResultTitle").text(title);
        $('#modalSpanResultMessage').text(message);
        $('div#modalResult').modal();
    }

    function fnErrorMessage(errorMessage) {
        $('#modalSpanErrorMessage').text(errorMessage);
        $('div#modalError').modal();
    }

    function fnErrorMessageTitle(errorTitle, errorMessage) {
        if (errorTitle != null && typeof errorTitle != 'undefined' && errorTitle != "" && errorTitle != "") {
            $('#modalSpanErrorTitle').text(errorTitle);
        }
        $('#modalSpanErrorMessage').text(errorMessage);
        $('div#modalError').modal();
    }

    function fnResultSubmit() {
        var resultType = $("#modalSpanResultType").text();
        var formId = $("#modalSpanResultFormId").text();

        console.log("type=" + resultType);

        fnModalOpen('modalResult', false);

        boolSubmit = true;

        if (resultType == "SUCCESS_LIST") {
            fnList();
        } else if (resultType == "SUCCESS_REFRESH") {
            if (formId != "") {
                $("#" + formId).attr("action", "");
                $("#" + formId).submit();
            }
        } else if (resultType == "SUCCESS_MAIN") {
            if (formId != "") {
                $("#" + formId).attr("action", "/");
                $("#" + formId).submit();
            }
        } else if (resultType == "SUCCESS_LIST_AJAX") {
            fnList();
        } else if (resultType == "SUCCESS_LOGIN_PWD") {
            $("#id").val("");
            $("#password").val("");
        } else if (resultType == "CANCEL_AJAX") {
            fnList();
        }

    }

    function fnInitPasswordPopup() {
        $("#passwdOld").val("");
        $("#passwd1").val("");
        $("#passwd2").val("");

        fnDisplayVisible("modalCommentPasswdOld", false);
        fnDisplayVisible("modalCommentPasswdLength", false);
        fnDisplayVisible("modalCommentPasswd", false);
    }

    function fnProcPasswdChange() {
        if (valid.minLen($("#passwdOld").val(), 6)) {
            $("#modalCommentPasswdOld").removeClass("d-none");
            return false;
        }

        if (valid.minLen($("#passwd1").val(), 6)) {
            $("#modalCommentPasswdLength").removeClass("d-none");
            return false;
        }

        if (!valid.isEquals($("#passwd1").val(), $("#passwd2").val())) {
            $("#modalCommentPasswd").removeClass("d-none");
            return false;
        }

        var userSno = $("#userSno").val();
        var loginId = $("#loginId").val();
        var boolLogin = false;
        if (loginId == "" || typeof loginId == 'undefined') {
            loginId = $("#id").val();
            boolLogin = true;
        }

        if (userSno != "" && typeof userSno != 'undefined') {
            boolLogin = false;
        }

        $("#userSnoPasswdChange").val($("#userSno").val());
        $("#loginIdPasswdChange").val(loginId);
        $("#statusPasswdChange").val($("#status").val());
        $("#partnerSnoPasswdChange").val($("#partnerSno").val());
        $("#searchTextPasswdChange").val($("#searchText").val());
        $("#searchDeptPasswdChange").val($("#searchDept").val());
        $("#searchUserLevelPasswdChange").val($("#searchUserLevel").val());
        $("#searchStatePasswdChange").val($("#searchState").val());

        var param = new Object();
        param = $("#passwdForm").serialize();

        $.ajax({
            url: "/management/operation/usermanage/changePasswdAction",
            data: param,
            type: 'POST',
            dataType: 'json',
            success: function (data) {
                if (data.resultMsg == "succ") {
                    fnModalOpen('modalPasswdChange', false);

                    if (boolLogin)
                        fnResultMessage("SUCCESS_LOGIN_PWD", "loginForm", "비밀번호 변경", "비밀번호가 변경되었습니다.");
                    else
                        fnResultMessage("SUCCESS_REFRESH", "detailForm", "비밀번호 변경", "비밀번호가 변경되었습니다.");
                } else if (data.resultMsg == "notMatch") {
                    $("#modalCommentPasswdOld").removeClass("d-none");
                } else if (data.resultMsg == "notMatchNew") {
                    $("#modalCommentPasswd").removeClass("d-none");
                } else {
                    fnResultMessage("Warning", "detailForm", "비밀번호 변경", data.resultMsg);
                }

            },
            error: function (e) {
                fnErrorMessage("Error! " + e);
            },
            complete: function () {

            }
        });
    }

    function fnLoading(display) {
        if (display) {
            $('#loading').removeClass("d-none");
        } else {
            $('#loading').addClass("d-none");
        }
    }

    function fnToastrPopup(type, title, message) {
        console.log("[" + type + "][" + title + "]" + message);
        // 검사실 대기 목록 추가
        // 매니저 호출 (임시 막음)
        // else if ( type == "CallManager" )
        if (type == "CallManager") {
            toastr.error(message, title, {
                positionClass: 'toastr toast-top-right',
                containerId: 'toast-top-right',
                "closeButton": true
            });
        }
    }
</script>
