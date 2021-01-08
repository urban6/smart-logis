// TESTCODE 생성
$(document).ready(function() {
	var pathname = $(location).attr('pathname');
	
	// alert(pathname == '/management/login/login');
	
	switch(pathname) {
		//dm-management/src/main/webapp/WEB-INF/views/management/login/login.jsp
		case '/management/login/login' : fnLogin(); break;
		
		//dm-management/src/main/webapp/WEB-INF/views/management/manager/manager_regstration.jsp
		case '/management/manager/manager_regstration' : manager_regstration(); break;
		
		//ver3_server_oncoach_mng/src/main/webapp/WEB-INF/views/management/program/program_regstration.jsp
		case '/management/program/program_regstration' : program_regstration(); break;
		
		//ver3_server_oncoach_mng/src/main/webapp/WEB-INF/views/management/mission/mission_registration.jsp
		case '/management/mission/mission_registration' : mission_registration(); break;
		
		//ver3_server_oncoach_mng/src/main/webapp/WEB-INF/views/management/mission/card_registration.jsp
		case '/management/mission/card_registration' : card_registration(); break;
	}
	
});  

function fnLogin() {
	setTimeout(function() {
		$("#id").val("admin");
		$("#password").val("1");
		login();
	}, 500);
}

function manager_regstration() {
	$("#mng_nm").val("testName");
	$("#mng_id").val("testId");
	$("#mng_pwd").val("testPassword1");
	$("#mng_pwd_check").val("testPassword1");
	$("#mng_belong").val("testMng_belong");
	$("#mng_mobile_2").val("1234");
	$("#mng_mobile_3").val("5678");
}

function program_regstration() {
	// $("#rdo_03").prop('checked', true);
	//div_OnOff("2",'div_date');
	$("#rdo_01").prop('checked', true);
	$("#prg_cate").val("1");
	$("#prg_title").val("프로그램 등록 기능테스트 프로그램명");
	$("#prg_cont").val("프로그램 등록 기능테스트 제목");
	div_OnOff("0",'div_date');
}

function mission_registration() {
	$("#mis_class").val("5");
	$("#mis_title").val("미션 등록 기능테스트 제목");
	$("#mis_tag").val("미션 등록 기능테스트 테그 스트레스");
}

function card_registration() {
	$("#crd_title").val("미션카드 테스트 제목");
	$("#crd_cont").val("미션카드 테스트 내용 상세");
	$("#que_title").val("미션카드 테스트 질문");
	$("#que_cont").val("미션카드 테스트 질문 상세");
	$("#crd_msg").val("미션카드 테스트 자동 피드백");
	$("input:radio[name='ans_type']:radio[value='G']").prop('checked', true); // 전체
	$("#crd_btn").val("미션카드 테스트 버튼레이블");
	
	if ("Q01" == $("#crd_cd").val()) {
		$("input:radio[name='que_type']:radio[value='M']").prop('checked', true); // 단일/다중	> 다중
		for(var i = 1; i <=10; i++) {
			$("#opt_star" + i).val(i);
			$("#opt_text" + i).val("선택 옵션 텍스트 " + i);
			$("#opt_point" + i).val(2 * i);
			$("#opt_feed" + i).val("피드백 텍스트 " + i);
		}
		
	} else if ("Q03" == $("#crd_cd").val()) {
		$("#opt_feed1").val("OX 퀴즈 피드백 텍스트 O");
		$("#opt_point1").val("100");
		$("#opt_feed2").val("OX 퀴즈 피드백 텍스트 X");
		$("#opt_point2").val("60");
	
	} else if ("M02" == $("#crd_cd").val()) {
		$("input:radio[name='img_location']:radio[value='B']").prop('checked', true); // 이미지 노출 위치 > 내용 하단
		
	} else if ("M04" == $("#crd_cd").val()) {
		$("input:radio[name='img_location']:radio[value='B']").prop('checked', true); // 이미지 노출 위치 > 내용 하단
		$("input:radio[name='ans_type']:radio[value='FC']").prop('checked', true); // 커뮤니티 글 목록
		
	} else if ("M05" == $("#crd_cd").val()) {
		$("#ans_type").val("WM");
		$("#ans_cont").prop('disabled', false);
		$("#ans_cont").val(8000);
	}
}