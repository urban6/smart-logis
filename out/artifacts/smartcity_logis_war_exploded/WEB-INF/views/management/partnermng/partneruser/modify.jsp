<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel" %>

<script type="text/javascript">

	//Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
		$("#btn_save").click(function(){
			goSave();
		});
		
		$("#btn_del").click(function(){
			goDelete();
		});

		$("#btn_cancel").click(function(){
			goCancel();
		});
		
		$("#btn_attach").click(function(){
			goAttach();
		});
	 	
	 	$('#btnResetPwd').on('click', function(){
	 		openConfirmModal("NOTIFICATION","비밀번호를 초기화하시겠습니까?<br>등록된 휴대폰 번호로 임시 비밀번호가 발송됩니다", function() {
				console.log("Debug", "비밀번호 초기화 처리");	//초기화 비밀번호 패턴 확인 후 개발 추가
				showLoading();
				$.ajax({
                    url : "resetPassword",
                     type : 'POST',
                     data : $("#myForm").serialize(),
                     dataType : 'json',
                    success : function(data) {
                        var returnObj = data.result;
                        if(returnObj.result =="OK"){
                            openAlertModal("비밀번호 초기화", "임시 비밀번호가 발송되었습니다.");
                        } else {
                            openAlertModal("", returnObj.message);
                        }
                    },
                    error: function(e){
                        openAlertModal("",callErrorMsg);
                    },
                    complete : function() {
                        hideLoading();
                    }
                });
	 		});
	 	});
    	
		init();
    });
    
    function init(){
    	$("#user_hp_no").numeric();
    }
    
    function goCancel(){
    	$("#myForm").attr("action", "/management/partnermng/partneruser/list");
		$("#myForm").submit();
	}
    
 	function goSave() {
 		if(!checkValidation()) {
 			return false;
 		}
 		if(!hasErrorMessage()) { 		
 			openConfirmModal("NOTIFICATION","수정 하시겠습니까?", function() {
 				showLoading();
		    	var param = new Object();
		    	param = $("#myForm").serialize();	
		    	
		 		$.ajax({
		            url : "modifyAction",
		            data : param,
		            type : 'POST',
		            dataType : 'json',
		            success : function(data) {
		            	console.log(data.result.result);
	        			var returnObj = data.result;
	        			
		            	if(returnObj.result =="OK"){
		            		goCancel();
		            	} else {
		            		openAlertModal("", returnObj.message);
		            	}
		            },
		            error: function(e){
		            	openAlertModal("",callErrorMsg);
		            },
		            complete : function() {
		            	hideLoading();
					}
				});
 			});
 		}
 	}
 	
 	function goDelete() {
 		openConfirmModal("NOTIFICATION","선택한 운영자 정보를 삭제하시겠습니까?", function() {
			showLoading();
	    	var param = new Object();
	    	param = $("#myForm").serialize();	
	    	
	 		$.ajax({
	            url : "removeAction",
	            data : param,
	            type : 'POST',
	            dataType : 'json',
	            success : function(data) {
	            	console.log(data.result.result);
        			var returnObj = data.result;
        			
	            	if(returnObj.result =="OK"){
	            		goCancel();
	            	} else {
	            		openAlertModal("", returnObj.message);
	            	}
	            },
	            error: function(e){
	            	openAlertModal("",callErrorMsg);
	            },
	            complete : function() {
	            	hideLoading();
				}
			});
		});
 	}
 	
 	function checkValidation() {
 		hideErrorMessage();
 		var num_check = /[^0-9]/;
 		
 		if($("#user_fnm").val() == null || $("#user_fnm").val() == "") {
			showErrorMessage("user_fnm", "이름을 입력하세요.");
		}
		
		if($("#user_hp_no").val() == null || $("#user_hp_no").val() == "") {
			showErrorMessage("user_hp_no", "휴대폰 번호를 입력하세요.");
		} else if(num_check.test($("#user_hp_no").val())) {
	    	showErrorMessage("user_hp_no", "휴대폰번호는 숫자만 허용됩니다.");
	    }
		
 		return true;
 	}
    
    function goAttach(){
    	$("#uploadForm").children().remove();
    	if($("#img_file_sno").val() == '0' || $("#img_file_sno").val() == "" ){
    		var actionNm = '/management/file/fileUpload/userFilePath';
    		var target = "#attachFile"
    	 	    	
    	    var innerHtml =  '<input type=\"file\"  id=\"attachFile\" name=\"attachFile\" style=\"display:none\">';
    	    $("#uploadForm").append(innerHtml);
    		$(target).click();

        	$(target).on('change', function(){
    			$("#uploadForm").attr("action",actionNm);
    			setAjaxFileData('uploadForm', $("#uploadForm"), uploadSucc, uplaodFail );
    		});
    	}
    }
    
    function uploadSucc(result){
    	var html = "<li><a href='#' onclick='deleteImageAction($(this));' class='btn_rmv'>×</a>";
    	html += "<img src='${baseContentsUrl}"+result.file_save_nm +"\' id='img' /></li>";
    	
  		$(".img_area").append(html);
  		$("#img_file_sno").val(result.file_sno);
    	$('#btn_attach').attr("disabled", "true");
    }
    
    function uplaodFail(resultMsg ){
    	openAlertModal("", resultMsg.resultMsg);
	}
    
    function deleteImageAction(obj){
    	obj.parent('li').remove();
    	$("#img_file_sno").val(0);
    	$('#btn_attach').attr("disabled", "false");
    }

</script>
    <div class="path_area">
        <div class="path">
            <ul class="clearfix">
                <li><a href="#" class="back">운영자 관리</a></li>
                <li><span class="this">운영자 등록</span></li>
                <li class="last-child"><span class="this">운영자 수정</span></li>
            </ul>
        </div>
    </div>
<section id="content" class="w1200">
	<article class="admin_conf">
	<form id="myForm" name="myForm" method="POST" class="valid_form">
		<input type="hidden" id="search_partner_clcd" name="search_partner_clcd" value="${partnerUserDomain.search_partner_clcd}">
		<input type="hidden" id="search_partner_sno" name="search_partner_sno" value="${partnerUserDomain.search_partner_sno}">
		<input type="hidden" id="search_type" name="search_type" value="${partnerUserDomain.search_type}">
		<input type="hidden" id="search_text" name="search_text" value="${partnerUserDomain.search_text}">
		<input type="hidden" id="img_file_sno" name="img_file_sno" value="${info.img_file_sno }">
		<input type="hidden" id="user_sno" name="user_sno" value="${info.user_sno }">
		
		<p class="title"><span class="require">※</span>필수입력</p>
			<ol>
    			<li>등록 완료시 입력하신 휴대폰 번호로 임시 비밀번호가 발송됩니다.</li>
			</ol>

			<div class="form_table">
				<legend>운영자 등록 정보 입력</legend>
				<fieldset>
					<table>
						<colgroup>
				            <col style="width:230px;">
				            <col width="*">
			          	</colgroup>
	          			<tbody>
							<tr>
								<th>소속</th>
								<td>${info.partner_nm }</td>
				            </tr>
							<tr>
								<th>권한</th>
								<td>${info.level_title }</td>
				            </tr>
							<tr>
								<th>아이디</th>
								<td>${info.login_id }</td>
				            </tr>					
							<tr>
								<th>비밀번호</th>
								<td><button type="button" class="btn_black" id="btnResetPwd">비밀번호 초기화</button></td>
				            </tr>		
							<tr>
								<th>이름<span class="require">*</span></th>
								<td>
									<input type="text" class="inp_txt w185" id="user_fnm" name="user_fnm" placeholder="한글, 영문, 숫자 모두 사용 가능, 최소 1~20자" maxlength="20" value="${info.user_fnm }"/>
									<span>커뮤니티에 글/댓글 등록 시 이름도 함께 노출됩니다.</span>
				                </td>
				            </tr>
							<tr>
								<th>휴대폰번호<span class="require">*</span></th>
								<td>
									<input type="tel" class="inp_txt w185" id="user_hp_no" name="user_hp_no" placeholder=" ‘-’없이 숫자만 입력" maxlength="13" value="${info.user_hp_no }"/>
				                </td>
				            </tr>
	        			</tbody>
	    			</table>
	    		</fieldset>
	    	</div>
	    	<p class="title"><span class="require">※</span>선택입력</p>
			<ol>
				<li>커뮤니티에 글/댓글을 등록하고자 하신다면, 프로필 사진을 등록해주세요. 담당자가 로그인 후 내정보에서 직접 등록하실 수도 있습니다.</li>
			</ol>

			<div class="form_table">
				<fieldset>
					<table>
						<colgroup>
				            <col style="width:230px;">
				            <col width="*">
			          	</colgroup>
	          			<tbody>
							<tr>
								<th>프로필 사진</th>
								<td>
									<div class="input type_01 m">
								        <a href="#" class="btn_black" id="btn_attach" <c:if test="${info.img_file_sno ne 0 && info.img_file_sno ne '' }">disabled="disabled"</c:if> >이미지 첨부</a>
								        <ul class="img_area clearfix" >
								        	<c:if test="${info.img_file_sno ne 0 && info.img_file_sno ne '' }">
								        	<li>
								        		<a href="#" class="btn_rmv" onclick='deleteImageAction($(this));'>&times;</a>
								        		<img src='${baseContentsUrl}${info.file_save_nm}' id='img' />
								        	</li>
											</c:if>
								        </ul>
				             	  	</div>
                                </td>
				            </tr>
				        </tbody>
	    			</table>
	    		</fieldset>
	    	</div>
	    	
	    	<div class="btn_area">
				<div class="center">
					<button type="button" class="btn_white btn_line_gray w180 mr18" id="btn_cancel">목록</button>					
					<button type="button" class="btn_black w180 mr18" id="btn_del">삭제</button>
					<button type="button" class="btn_red w180" id="btn_save">수정</button>		
				</div>
			</div>	
		</form>
	</article>
	<form id="uploadForm" name="uploadForm" method="POST"></form>	
</section>