<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
	<input type="hidden" id="navi2_nm" value="코치 회원가입" />
	<input type="hidden" id="navi1_url_mod" value="../login/login" />

<style type="text/css">
select {display: inline; float: none;}
</style>

    <!-- section : start -->
    <section id="content" class="w1200">
      <article class="membership">
        <p class="title">코치 회원가입</p>
        <ol>
          <li>- 코치코치당뇨 건강코칭 코치로 회원가입하기 위해서는 <span class="c_red">1. 정보 입력 및 2. 서류 등록</span>이 필요합니다.</li>
          <li>- 관리자가 등록한 서류를 검토 후, 프로그램의 사용자  배정을 완료하면 사용자 정보를 확인할 수 있습니다.</li>
        </ol>
        <p class="title_sub">1. 정보입력</p>
        <div class="form_table">
          <form name="regFrm" id="regFrm">
          	<input type="hidden" id="user_email" name="user_email" value="" />
          	<input type="hidden" id="hidden_val" name="hidden_val" />
          	<input type="hidden" id="receive_hp_no" name="receive_hp_no" value="" />
          	
            <fieldset>
            <legend>멤버쉽 가입 정보 입력</legend>
              <p class="p_right desc">*표는 필수 입력 항목입니다.</p>
              <table>
                <colgroup>
                  <col width="230" />
                  <col />
                </colgroup>
                <tbody>
                  <tr>
                    <th>*아이디 (이메일)</th>
                    <td>
                      <input type="text" class="inp_txt w180" id="user_email_1" name="user_email_1" placeholder="아이디를 입력해주세요" autofocus />
					  &nbsp;@&nbsp;
					  <select class="inp_select w180 mr8" id="select_domain">
						<option value="">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
                        <option value="nate.com">nate.com</option>
                        <option value="gmail.com">gmail.com</option>
					  </select>
					  <input type="text" class="inp_txt w180 mr8" name="user_email_2" id="user_email_2" />
					  <a href="javascript:selectCoachIdCheck();" class="btn_black">중복확인</a>
                    </td>
                  </tr>
                  <tr>
                    <th>*비밀번호</th>
                    <td>
                      <input type="password" class="inp_txt w393" id="passwd" name="passwd" placeholder="영문, 숫자 조합으로 8~15자" maxlength="15">
                    </td>
                  </tr>
                  <tr>
                    <th>*비밀번호 확인</th>
                    <td>
                      <input type="password" class="inp_txt w393" id="passwd_check" name="passwd_check" placeholder="영문, 숫자 조합으로 8~15자" maxlength="15">
                    </td>
                  </tr>
                  <tr>
                    <th>*이름</th>
                    <td>
                      <input type="text" class="inp_txt w393" id="user_fnm" name="user_fnm" placeholder="한글 2~30자" maxlength="30">
                    </td>
                  </tr>
                  <tr>
                    <th>*휴대폰 번호</th>
                    <td>
                      <select class="inp_select w126 mr8" id="user_hp_no_1" name="user_hp_no_1">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="015">015</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
					  </select>
					  <input type="text" class="inp_txt w120 mr8" id="user_hp_no_2" name="user_hp_no_2" maxlength="4"/>
					  <input type="text" class="inp_txt w120 mr8" id="user_hp_no_3" name="user_hp_no_3" maxlength="4"/>
					  <a href="javascript:insertSms();" class="btn_black" id="sendCertNo">인증번호 발송</a>
					  <span class="currTime" style="display: none;"><span class="ceriMsg" id="time-min">03</span> : <span class="ceriMsg" id="time-sec">00</span></span>
					  <span class="authOk" style="display: none;">인증이 완료되었습니다.</span>
                    </td>
                  </tr>
                  <tr>
                    <th>*인증번호</th>
                    <td>
                      <input type="text" class="inp_txt w393" id="cert_num" name="cert_num" maxlength="6" readonly="readonly"/>
					  <a href="javascript:selectSmsCertInfo();" class="btn_black" id="checkCert">인증번호 확인</a>
					  <input type="hidden" id="authYn" name="auth_yn" value="" />
                    </td>
                  </tr>
                  <tr>
                    <th>*프로필 사진</th>
                    <td>
                     <div class="file-inp-box">
                       <input type="text" class="inp_txt w393" id="txtfile_01" name="txtfile_01" accept=".jpg,.png" placeholder="파일을 선택해 주세요." readonly>
                       <label for="file_01" class="btn_black img-label">찾아보기</label>
                     </div>
                     <div class="img-file-box w393">
                       <input type="file" class="hid_file" id="file_01" name="file_01" accept=".jpg,.png" onchange="javascript:fileCheck('', this, 'txtfile_01');" >
                       <input type="hidden" id="data_cd2" name="data_cd2" value="COACH_PHOTO" />
                       <ul id="liFileList"></ul>
                     </div>
                      <p class="c_red desc mt6">※ 용량 : 10MB 미만, 파일 확장자 : jpg, png, <br>사용자에게 보여지는 사진입니다. 잘 나온 사진으로 올려주세요.</p>
                    </td>
                  </tr>
                  <tr>
                    <th>*소개</th>
                    <td>
                      <textarea id="user_introduce" name="user_introduce" style="width:670px; height:150px" placeholder="10~100자로 입력해주세요. (한글, 영문, 숫자, 특수문자 가능)" maxlength="100"></textarea>
                    </td>
                  </tr>
                </tbody>
              </table>
              <div class="checkbox">
                <input type="checkbox" class="hid_chk" id="chk_01" name="mng_agree" value="Y" />
                <label for="chk_01" class="icon">코치코치당뇨 건강코칭 코치 신청에 동의합니다.</label>
              </div>
              <div class="btn_area">
                <div class="center">
                  <a href="/" class="btn_white btn_line_gray w180 mr18">로그인 화면으로</a>
                  <a href="javascript:goRegisterRecommend();" class="btn_red w180">코치 회원가입 완료</a>
                </div>
              </div>
            </fieldset>
          </form>
        </div>
      </article>
    </section>
    <!-- section : end -->

<script type="text/javascript">
$(function(){
	$frmObj = $("#regFrm");
	
	$("#navigationArea").show();
	$("#navigationArea li").eq(0).find("a").text("로그인");
	$("#navigationArea li").eq(0).find("a").attr("href", "../login/login");
	
	// jquery validation
	initValdate($frmObj);
	
	// define to rules
	addValidateRules();
	
	$("#select_domain").change(function(){
		$("#user_email_2").val($(this).val());
		var $target = $("#user_email_2");
		if($target.val() == ""){
            $target.attr("readonly", false);
		}else{
            $target.attr("readonly", true);
		}
		// 중복확인 필드 초기화
        $("#hidden_val").val("");
	});

    $("#user_email_1").keyup(function(){
        // 중복확인 필드 초기화
        $("#hidden_val").val("");
    });
});

// 아이디 중복 확인
function selectCoachIdCheck(){
	$("#user_email").val($("#user_email_1").val() + "@" + $("#user_email_2").val());
	
	$.ajax({
		type : "POST",
		url :  "./selectCoachIdCheck",
		cache : false,
		data : $frmObj.serialize(),
		dataType: "json",
		success : function(data){			
			alert(data.rtnMsg);
			if (data.rtnFlag){
			   $('#hidden_val').val("Y");
			}			
		},
		error : function(request,status,error){
			//alert("Server Connection Failure");
		}
	});	
}

// 인증번호 처리를 위한 전역변수
var timer, interval, minutes, seconds;
var check = false;

function setAuthTime (){
	timer = 180;
	clearInterval(interval);
	interval = setInterval("decrementTime()", 1000);
	$('#cert_num').val("");
//	document.getElementById('cert_num').readOnly=false;
}

// 시간 카운트
function decrementTime(){
	minutes = parseInt(timer / 60 % 60, 10);
	seconds = parseInt(timer % 60, 10);

	minutes = minutes < 10 ? "0" + minutes : minutes;
	seconds = seconds < 10 ? "0" + seconds : seconds;

	$('#time-min').text(minutes);
	$('#time-sec').text(seconds);

	if(timer > 0) {
		--timer;
		check=true;
	}else{
		clearInterval(interval);
		$('#time-min').text("00");
		$('#time-sec').text("00");
		$(".currTime").hide();
		if("Y" != $("#authYn").val()){
			$("#sendCertNo").show();
			alert('인증번호 유효시간이 만료되었습니다.');
			document.getElementById('cert_num').readOnly=false;
		}else{
			document.getElementById('cert_num').readOnly=true;
		}
	}
}

// 인증번호 발송
function insertSms(){
	if ($("#user_hp_no_2").val() == "") {
		alert("휴대폰 번호를 입력해주세요.");
		$("#user_hp_no_2").focus();
		return false;
	}
	if ($("#user_hp_no_3").val() == "") {
		alert("휴대폰 번호를 입력해주세요.");
		$("#user_hp_no_3").focus();
		return false;
	}
	
	$("#cert_num").val("");
	
	$.ajax({
		type : "POST",
		url :  "./insertSms",
		cache : false,
		data : $frmObj.serialize(),
		dataType: "json",
		success : function(data){			
			// CODE : F01 : 시스템 오류
			// CODE : F02 : 휴대폰 입력 오류
			// CODE : S00 : 발송성공
			if(data.rtnCode == "S00" ){
				setAuthTime();
				alert(data.rtnMsg);
				$("#receive_hp_no").val($("#user_hp_no_1").val()+$("#user_hp_no_2").val()+$("#user_hp_no_3").val());
				$(".currTime").show();
				$("#sendCertNo").hide();
				$("#cert_num").focus();
		        $("#cert_num").attr("readonly",false);
			}else if(data.rtnCode == "F01"){
				alert("시스템오류입니다. 잠시 후 다시 시도해주세요.");
				return false;
			}else if(data.rtnCode == "F02"){
				alert("휴대폰번호를 올바르게 입력해주세요.");
				return false;
			}
		},
		error : function(request,status,error){
			//alert("Server Connection Failure");
		}
	});	
}

// 인증번호 확인
function selectSmsCertInfo(){
	$.ajax({
		type : "POST",
		url :  "./selectSmsCertInfo",
		cache : false,
		data : $frmObj.serialize(),
		dataType: "json",
		success : function(data){			
			if (data.rtnNo == 1) {
				alert("인증에 성공하였습니다.");
				$("#authYn").val("Y");
				$("#user_hp_no_1").attr("readonly",true);
				$("#user_hp_no_2").attr("readonly",true);
				$("#user_hp_no_3").attr("readonly",true);
				$("#cert_num").attr("readonly",true);
				$("#checkCert").hide();
				$(".currTime").hide();
				$(".authOk").show();
		    }else if(data.rtnNo < 0 ){
		        alert("인증번호 6자리를 입력해주세요.");
		        return false;
			}else{
				alert("입력하신 인증번호가 일치하지 않습니다.");
		        return false;
			}
		},
		error : function(request,status,error){
			//alert("Server Connection Failure");
		}
	});
}

//validate Rules
function addValidateRules() {

	// 중복확인
	$.validator.addMethod("validCoachIdCheck", function(value, element) {
		return $('#hidden_val').val() == "Y";
	}, "이메일 중복확인을 확인해주세요.");
	
	// 비밀번호
	$.validator.addMethod("passwordCheck", function(value, element) {
		return this.optional(element) ||  /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/.test(value);
	}, "비밀번호는 영문, 숫자 특수문자 조합으로 8~15자 입니다."); 

	// 비밀번호 확인
	$.validator.addMethod("isEqualPasswd", function(value, element, params) {
		return $(params).val() == value;
	}, "비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
	
	// 아이디
	$("#user_email_1").rules("add",{required: true, validCoachIdCheck: true, messages:{required:"이메일을 입력해주세요."}});
	$("#user_email_2").rules("add",{required: true, messages:{required:"이메일 형식을 다시 확인해주세요."}});
	
	// 비밀번호
	$("#passwd").rules("add",{required: true, minlength: 8, maxlength: 15, passwordCheck: true
							, messages:{required:"비밀번호를 입력해주세요.", minlength: "비밀번호는 영문, 숫자 특수문자 조합으로 8~15자 입니다.", maxlength: "비밀번호는 영문, 숫자 특수문자 조합으로 8~15자 입니다."}});
	$("#passwd_check").rules("add",{required: true, isEqualPasswd: "#passwd", messages:{required:"비밀번호 확인을 입력해주세요."}});

	// 이름
	$("#user_fnm").rules("add",{required: true, minlength: 2, messages:{required:"이름을 입력해주세요.", minlength:"이름은 한글 2~30자 입니다."}});
	
	// 휴대폰 번호
	$("#user_hp_no_2").rules("add",{required: true, range: [0, 9999], messages:{required:"휴대폰 번호를 입력해주세요.", range:"휴대폰 번호를 올바르게 입력해주세요."}});
	$("#user_hp_no_3").rules("add",{required: true, range: [0, 9999], messages:{required:"휴대폰 번호를 입력해주세요.", range:"휴대폰 번호를 올바르게 입력해주세요."}});
	$("#authYn").rules("add",{required: true, messages:{required:"휴대폰 본인인증을 해주세요."}});
	
	// 소개
	$("#user_introduce").rules("add",{required: true, messages:{required:"자기소개를 입력해주세요."}});
	
	// 썸네일
	$.validator.addMethod("cPostRequired", $.validator.methods.required, "프로필 사진을 등록해주세요.");
	$("#file_01").rules("add",{cPostRequired : true, accept : false, extension: "png,jpe?g,gif", maxsize: Math.pow(1024, 2)*10
							, messages:{extension: "jpg, png 파일만 업로드 할 수 있습니다.", maxsize:"10MB까지 업로드 가능합니다."}});
	
	// 동의
	$("#chk_01").rules("add",{required: true, messages:{required:"코치코치당뇨 건강코칭 코치 신청에 동의해주세요."}});
}

//코치 등록
function goRegisterRecommend() {
	$frmObj.attr("action","./insertCoach");
	$frmObj.attr("method", "post");
	$frmObj.attr("accept-charset", "utf-8");
	$frmObj.attr("enctype", "multipart/form-data");
	$frmObj.submit();
}
</script>