<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>
	<input type="hidden" id="navi2_nm" value="정보 변경" />
	<input type="hidden" id="navi1_url_mod" value="./edit_coach" />
	
    <!-- section : start -->
    <section id="content" class="w1200">
      <article class="membership">
        <p class="title"></p>
        <ol>
          <li>- 변경하고자 하는 정보만 입력하시면 됩니다.</li>
          <li>- 아이디(이메일)과 이름은 <span class="c_red">변경 불가</span>합니다</li>
        </ol>
        <p class="title_sub"></p>
        <div class="form_table">
          <form id="editFrm" name="editFrm">
            <input type="hidden" id="user_sno" name="user_sno" value="<c:out value="${selectCoachDetail.user_sno}" />">
            <fieldset>
            <legend>멤버쉽 정보 수정 입력</legend>
              <p class="p_right desc">*표는 필수 입력 항목입니다.</p>
              <table>
                <colgroup>
                  <col width="230" />
                  <col />
                </colgroup>
                <tbody>
                  <tr>
                    <th>아이디 (이메일)</th>
                    <td><c:out value="${selectCoachDetail.login_id}" /></td>
                  </tr>
                  <tr>
                    <th>* 현재 비밀번호</th>
                    <td>
                      <input type="password" class="inp_txt w393" id="passwd_org" name="passwd_org" placeholder="영문, 숫자 조합으로 8~15자" maxlength="15">
                    </td>
                  </tr>
                  <tr>
                    <th>새 비밀번호</th>
                    <td>
                      <input type="password" class="inp_txt w393" id="passwd" name="passwd" placeholder="영문, 숫자 조합으로 8~15자" maxlength="15">
                    </td>
                  </tr>
                  <tr>
                    <th>새 비밀번호 확인</th>
                    <td>
                      <input type="password" class="inp_txt w393" id="passwd_check" name="passwd_check" placeholder="영문, 숫자 조합으로 8~15자" maxlength="15">
                    </td>
                  </tr>
                  <tr>
                    <th>이름</th>
                    <td><c:out value="${selectCoachDetail.user_fnm}" /></td>
                  </tr>
                  <tr>
                    <th>*프로필 사진</th>
                    <td>
                      <input type="text" class="inp_txt w250" id="txtfile_01" name="txtfile_01" value="<c:out value="${selectFileProfile.file_nm}" />" placeholder="파일을 선택해 주세요." readonly>
                      <label for="file_01" class="btn_black img-label">찾아보기</label>
                      <input type="file" class="hid_file" id="file_01" name="file_01" accept=".jpg,.png" onchange="javascript:fileCheck('', this, 'txtfile_01');" >
                      <input type="hidden" id="data_cd2" name="data_cd2" value="COACH_PHOTO" />
                      <input type="hidden" id="hasFile" name="hasFile" value="N" />
                      <p class="c_red desc mt6">※ 용량 : 10MB 미만, 파일 확장자 : jpg, png</p>
                    </td>
                  </tr>
                  <tr>
                    <th>*소개</th>
                    <td>
                      <textarea id="user_introduce" name="user_introduce" style="width:670px; height:150px" placeholder="10~100자로 입력해주세요. (한글, 영문, 숫자, 특수문자 가능)" maxlength="100"><c:out value="${selectCoachDetail.user_introduce}" /></textarea>
                    </td>
                  </tr>
                </tbody>
              </table>
              <div class="btn_area">
                <div class="center">
                  <a href="javascript:goCoaching();" class="btn_white btn_line_gray w180 mr18">1:1코칭 화면으로</a>
                  <a href="javascript:goUpdateRecommend();" class="btn_red w180">코치 정보변경 완료</a>
                </div>
              </div>
            </fieldset>
          </form>
        </div>
      </article>
    </section>
    <!-- section : end -->
    <form id="sendFrm" name="sendFrm"></form>

<script type="text/javascript">
$(function(){
	$frmObj = $("#editFrm");
	
	$("#navigationArea li").eq(0).find("a").text("내정보");
	$("#navigationArea li").eq(0).find("a").attr("href", "./edit_coach");

	// jquery validation
	initValdate($frmObj);
	
	// define to rules
	addValidateRules();
});

// 1:1코칭 이동
function goCoaching() {
	$("#sendFrm").attr("action","../coaching/coaching");
	$("#sendFrm").submit();
}

//validate Rules
function addValidateRules() {
	// 현재 비밀번호 확인
	$.validator.addMethod("selectEqPasswdOrg", function(value, element, params) {
		var isValid = false;

		var formData = new FormData($frmObj);
		formData.append("passwd", $("#passwd_org").val()); // 비밀번호
		
		$.ajax({
			url: "./selectEqPasswdOrg",
			type: "post",
			dataType: "json",
			async : false,
			// contentType: "application/json; charset=utf-8",
			cache: false,
			data: $frmObj.serialize(),
			success : function(data){
				if ($("#user_sno").val() == data.rtnSno) {
					isValid = true;
				}
			},
			error : function(request,status,error){
				//alert("Server Connection Failure");
			}
		});
		return isValid;
	}, "현재 비밀번호가 일치하지 않습니다. 다시 입력해주세요.");

	// 새 비밀번호
	$.validator.addMethod("passwordCheck", function(value, element) {
		return this.optional(element) ||  /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/.test(value);
	}, "비밀번호는 영문, 숫자 특수문자 조합으로 8~15자 입니다."); 

	// 새 비밀번호 확인
	$.validator.addMethod("isEqualPasswd", function(value, element, params) {
		return $(params).val() == value;
	}, "비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
	
	// 비밀번호
	$("#passwd_org").rules("add",{required: true, selectEqPasswdOrg: true, messages:{required:"현재 비밀번호를 입력해주세요."}});
	$("#passwd").rules("add",{minlength: 8, maxlength: 15, passwordCheck: true
							, messages:{minlength: "비밀번호는 영문, 숫자 특수문자 조합으로 8~15자 입니다.", maxlength: "비밀번호는 영문, 숫자 특수문자 조합으로 8~15자 입니다."}});
	
	$("#passwd_check").rules("add",{isEqualPasswd: "#passwd"});

	// 소개
	$("#user_introduce").rules("add",{required: true, messages:{required:"자기소개를 입력해주세요."}});
	
	// 썸네일
	$.validator.addMethod("cstRequired", function(value, element, params) {
		return $("#txtfile_01").val() != "";
	}, "프로필 사진을 등록해주세요.");
	
	$("#file_01").rules("add",{cstRequired : true, accept : false, extension: "png,jpe?g,gif", maxsize: Math.pow(1024, 2)*10
							, messages:{extension: "jpg, png 파일만 업로드 할 수 있습니다.", maxsize:"10MB까지 업로드 가능합니다."}});

}

//코치 정보 수정
function goUpdateRecommend() {
	
	if ($("#file_01").val().length > 0) {
		$("#hasFile").val("Y");
	} else {
		$("#hasFile").val("N");
	}
	
	// validation call
	$frmObj.attr("action","./updateCoach");
	$frmObj.attr("method", "post");
	$frmObj.attr("accept-charset", "utf-8");
	$frmObj.attr("enctype", "multipart/form-data");
	$frmObj.submit();
}

function fnBeforSubmit() {

	$frmObj.attr("accept-charset", "utf-8");
	$frmObj.attr("enctype", "multipart/form-data");	
	
	var formData = new FormData($frmObj);
	formData.append("user_sno", $("#user_sno").val()); // 사용자 일련번호
	formData.append("passwd", $("#passwd").val()); // 비밀번호
	formData.append("hasFile", $("#hasFile").val()); // 첨부파일 여부
	formData.append("file_01", $("#file_01")[0].files[0]); // 첨부파일 정보
	formData.append("data_cd2", $("#data_cd2").val()); // 데이터 코드 (대분류)
	formData.append("user_introduce", $("#user_introduce").val()); // 비밀번호
	
	$.ajax({
	    url : "./updateCoach",
	    type : 'POST',
	    dataType : "json",
	    data : formData,
		async : false,
		cache : false,
		contentType : false, // tell jQuery not to process the data
		processData : false, // tell jQuery not to set contentType
	    success : function(data) {
       		alert("코치 정보가 변경되었습니다.");
       		window.location.reload();
	    },
	    error: function(request,status,error){
	     	var err = JSON.parse(request.responseText);
				alert(err.errorMsg.localizedMessage);
	    },
	    complete : function() {
	    }
	});
	
	return false;
}
</script>