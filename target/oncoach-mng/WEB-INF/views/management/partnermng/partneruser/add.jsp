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

		$("#btn_cancel").click(function(){
			goCancel();
		});
		

		$('#partner_clcd').on('change', function(){
			if("${sessionUser.partnerClcd}" == "50201010"){
				var selectedPartnerClcd = $(this).children('option:selected').val();
				
				$('#partner_sno').html("");
				$('#level_id').html("");
				
				if(selectedPartnerClcd == "") {
					
					$('#partner_sno').html('<option value="">소속 전체</option>');
					$('#partner_sno').attr('disabled', true);
					
					$('#level_id').html('<option value="">전체</option>');
					$('#level_id').attr('disabled', true);
					
					return ;
				}
				
				var param = new Object();
				param.partner_clcd = selectedPartnerClcd;
				param.level_clcd = $('#level_clcd').val();
				
				$.ajax({
			        url : "/management/partnermng/partneruser/listPartner",
			        data : param,
		 	        type : 'POST',
		 	        dataType : 'json',
			        success : function(data) {
			           
			        	var partnerList = data.partnerList;
						var rtn = '';
						if(selectedPartnerClcd != "50201010") {
								rtn += '<option value="">' + $('#partner_clcd option:selected').text() + ' 선택</option>';  
						}		           
						for(var i = 0;i<partnerList.length;i++) {
								rtn += '<option value="' + partnerList[i].com_cd + '">' + partnerList[i].cd_nm + '</option>';
						}
						$('#partner_sno').html(rtn);
						$('#partner_sno').attr('disabled', false);
						
						var levelList = data.levelList;
						rtn = '';
						for(var i = 0; i < levelList.length; i++) {
							rtn += '<option value="' + levelList[i].com_cd + '">' + levelList[i].cd_nm + '</option>';
						}
						$('#level_id').html(rtn);
						$('#level_id').attr('disabled', false);
			        },
			        error : function(e){
			            openAlertModal("",callErrorMsg);
			        },
			        complete : function() {}
				});
			}else{
				getLevelList();				
			}
		});

	 	$('#btnChkID').on('click', function(){
	 		selectDuplID();
	 	});

    	$('#login_id').on('change', function(){
    		$('#loginIdCheckYn').val("N");
    	});
    	
    	$("#btn_attach").click(function(){
			goAttach();
		});
    	
		init();
    });
	
	//제휴사 전용_권한목록만 조회
	function getLevelList(){		
		$.ajax({
	        url : "/management/partnermng/partneruser/listPartner",
	        data : $('#myForm').serialize(),
 	        type : 'POST',
 	        dataType : 'json',
	        success : function(data) {				
				var levelList = data.levelList;
				rtn = '';
				for(var i = 0; i < levelList.length; i++) {
					rtn += '<option value="' + levelList[i].com_cd + '">' + levelList[i].cd_nm + '</option>';
				}
				$('#level_id').html(rtn);
				$('#level_id').attr('disabled', false);
	        },
	        error : function(e){
	            openAlertModal("",callErrorMsg);
	        },
	        complete : function() {}
		});
		
	}
    
    function init(){
    	$('#partner_sno').html('<option value="">소속 전체</option>');
		$('#level_id').html('<option value="">전체</option>');
		$('#partner_clcd').trigger('change');
		$("#user_hp_no").numeric();
    }
    
    function goCancel(){
    	$("#myForm").attr("action", "/management/partnermng/partneruser/list");
		$("#myForm").submit();
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
    
 	function goSave() {
 		if(!checkValidation()) {
 			return false;
 		}
 		if(!hasErrorMessage()) { 			
 			openConfirmModal('운영자 등록', '저장하시겠습니까?', function() {				
	 			showLoading();
	 			var param = new Object();
		    	param = $("#myForm").serialize();	
		        
	 			$.ajax({
	 	            url : "addAction",
	 	            data : param,
	 	            type : 'POST',
	 	            dataType : 'json',
	 	            success : function(data) {            	
	 	            	var returnObj = data.result;

		            	if(returnObj.result =="OK"){
		            		goCancel();
		            	} else {
		            		openAlertModal("운영자 등록", returnObj.message);
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
 	
 	function selectDuplID(){		
 		hideErrorMessage("login_id");
 		if($("#login_id").val() == null || $("#login_id").val() == "") {
			showErrorMessage("login_id", "아이디를 입력하세요.");
			return false;
		}
 		
 		$('#loginIdCheckYn').val("N");
 		hideErrorMessage("loginIdCheckYn");
 		
 		showLoading();
		$.ajax({
	        url : "selectPartnerUserbyID",
	        data : $('#myForm').serialize(),
 	        type : 'POST',
 	        dataType : 'json',
	        success : function(data) {
	        	if(data.rs > 0){
	        		$('#loginIdCheckYn').val("N");	        		
	        		openAlertModal('중복 확인', '이미 사용중인 아이디입니다.');
	        	}else{
	        		$('#loginIdCheckYn').val("Y");
	        		openAlertModal('중복 확인', '사용 가능한 아이디입니다.');
	        	}
	        },
	        error : function(e){
	            openAlertModal("",callErrorMsg);
	        },
	        complete : function() {
	        	hideLoading();
	        }
		});
 	} 	
 	
 	function checkValidation()
 	{
 		hideErrorMessage();	
 		
 		var num_check = /[^0-9]/;// 숫자만 가능
 		
		if($("#partner_sno").val() == null || $("#partner_sno").val() == "") {
			showErrorMessage("partner_sno", "소속을 선택하세요.");
		}
		
		if($("#level_id").val() == null || $("#level_id").val() == "") {
			showErrorMessage("level_id", "권한을 선택하세요.");
		}
		
		if($("#login_id").val() == null || $("#login_id").val() == "") {
			showErrorMessage("login_id", "아이디를 입력하세요.");
		} else {
			if($("#loginIdCheckYn").val() == null || $("#loginIdCheckYn").val() == "" || $("#loginIdCheckYn").val() != "Y") {
				showErrorMessage("loginIdCheckYn", "아이디 중복체크를 해주세요.");
			}
		}
		
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
 	
</script>
    <div class="path_area">
        <div class="path">
            <ul class="clearfix">
                <li><a href="#" class="back">운영자 관리</a></li>
                <li><span class="this">운영자 등록</span></li>
                <li class="last-child"><span class="this">운영자 등록</span></li>
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
			<input type="hidden" id="level_clcd" name="level_clcd" value="${partnerUserDomain.level_clcd}" />
			<input type="hidden" id="img_file_sno" name="img_file_sno" value="0">
		
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
								<th>소속<span class="require">*</span></th>
								<td>
								<c:if test="${sessionUser.partnerClcd eq '50201010' }">
									<select class="inp_select w185 mr4" id="partner_clcd" name="partner_clcd">
										<option value="">전체</option>
										<c:forEach items="${partnerClcdList}" var="partnerClcd" varStatus="status">
										<c:if test="${partnerClcd.com_cd ne '50201010'}">
											<option value="${partnerClcd.com_cd}">${partnerClcd.cd_nm}</option>
										</c:if>
										</c:forEach>
									</select>
									<select class="inp_select w185" id="partner_sno" name="partner_sno" disabled="disabled">
									</select>
								</c:if>
								<c:if test="${sessionUser.partnerClcd ne '50201010' }">
									<input type="hidden" id="partner_clcd" name="partner_clcd" value="${partnerInfo.partner_clcd }" />
									<input type="hidden" id="partner_sno" name="partner_sno" value="${partnerInfo.partner_sno }" />
									${partnerInfo.partner_txt }
								</c:if>
		                		</td>
				            </tr>
							<tr>
								<th>권한<span class="require">*</span></th>
								<td>
									<select class="inp_select w185" id="level_id" name="level_id" disabled="disabled">
									</select>
				                </td>
				            </tr>
							<tr>
								<th>아이디<span class="require">*</span></th>
								<td>
									<input type="text" class="inp_txt w185" id="login_id" name="login_id" placeholder="영문 또는 영문, 숫자 조합 5~12자" maxlength="12"/>
									<a href="javascript://" class="btn_black" id="btnChkID">중복확인</a>
									<input type="hidden" id="loginIdCheckYn" name="loginIdCheckYn" value="N"/>
				                </td>
				            </tr>
							<tr>
								<th>이름<span class="require">*</span></th>
								<td>
									<input type="text" class="inp_txt w185" id="user_fnm" name="user_fnm" placeholder="한글, 영문, 숫자 모두 사용 가능, 최소 1~20자" maxlength="20"/>
									<span>커뮤니티에 글/댓글 등록 시 이름도 함께 노출됩니다.</span>								
				                </td>
				            </tr>
							<tr>
								<th>휴대폰 번호<span class="require">*</span></th>
								<td>
									<input type="tel" class="inp_txt w185" id="user_hp_no" name="user_hp_no" placeholder=" ‘-’없이 숫자만 입력" maxlength="13"/>
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
							        <button type="button" class="btn_black" id="btn_attach">이미지 첨부</button>
							        <ul class="img_area clearfix" ></ul>
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
					<button type="button" class="btn_red w180" id="btn_save">저장</button>
				</div>
			</div>		
		</form>
	</article>
	<form id="uploadForm" name="uploadForm" method="POST" ></form>	
</section>
