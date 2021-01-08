<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel" %>

<script type="text/javascript" charset="utf-8" src="/scripts/editor-common.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/tinymce/tinymce.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/fileupload.js"></script>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
		$("#btn_save").click(function(){
			goSave();
		});

		$("#btn_cancel").click(function(){
			goCancel();
		});
		
		$("#btn_attach").click(function(){
			goAttach();	
		});
		
		init();
    });
    
    function init(){
    	//편집을 위한 화면 초기설정
    }
    
    function goCancel(){
    	$("#myForm").attr("action","list");
		$("#myForm").submit();
	}
    
 	function goSave() {
 		
 		tinyMCE.triggerSave();
 		
 		if(!checkValidation()) {
 			return false;
 		}

 		if(!hasErrorMessage()) {
 			openConfirmModal('문의 등록', '저장하시겠습니까?', function() {		
 				showLoading();
		    	var param = new Object();
		    	param = $("#myForm").serialize();	
		    	
		 		$.ajax({
		            url : "addAction",
		            data : param,
		            type : 'POST',
		            dataType : 'json',
		            success : function(data) {
		            	console.log(data.result.result);
	        			var returnObj = data.result;
	        			
		            	if(returnObj.result =="OK"){
		            		goCancel();
		            	} else {
		            		openAlertModal("Warning", returnObj.message);
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
 	
    function checkValidation(){
    	
    	hideErrorMessage();	
    	
		if($("#counsel_title").val() == null || $("#counsel_title").val() == "") {
			showErrorMessage("counsel_title", "제목을 입력하세요.");
		}
 		
		if($("#counsel_contents").val() == null || $("#counsel_contents").val() == "") {
			showErrorMessage("counsel_contents", "내용을 입력하세요.");
		}
 		
    	return true;
	}
    
    function goAttach(){
    	
    	$("#uploadForm").children().remove();
    	if( $("input[name=attach_file_list]").length < 3 ){
    		var actionNm = '/management/file/fileUpload/systemCounselPath';
    		var target = "#attachFile"
                   
            var innerHtml =  '<input type=\"file\"  id=\"attachFile\" name=\"attachFile\" style=\"display:none\">';
            $("#uploadForm").append(innerHtml);
    		$(target).click();

            $(target).on('change', function(){
           		if (/(\.png|\.jpg)$/i.test($(target).val()) == false) { 
           			openAlertModal("","이미지는 png, jpg 형식만 등록 가능합니다."); 
           			return false;
           		} 	
           		
           		$("#uploadForm").attr("action",actionNm);
           		setAjaxFileData('uploadForm', $("#uploadForm"), uploadSucc, uplaodFail );
           });
        }
     }
     
    function uploadSucc(result){
        var html = "<li><a href='javascript:void(0);' onclick='deleteImageAction($(this));' class='btn_rmv'>×</a>";
        html += "<input type=\"hidden\" name=\"attach_file_list\" value=\""+result.file_sno+"\">";
        html += "<img src='${baseContentsUrl}"+result.file_save_nm +"\' onclick='clickImage($(this));' /></li>";
        $(".img_area").append(html);
     }
     
     function uplaodFail(resultMsg ){
        openAlertModal("Warning", resultMsg.resultMsg);
    }
     
     function deleteImageAction(obj){
         obj.parent('li').remove();
     }
     
     function clickImage(obj){
     	var src = obj.attr("src");
     	window.open(src,"_target");
     }
    
    /* ######## tinyMce 에디터 ######## */
    var tinymceInitOpts = editCommon.getTinymceInitOpts('${sessionScope.SESSION_LANGUAGE_CODE}','.editor','');
    tinymce.init(tinymceInitOpts);
	
 	
</script>

<div class="path_area">
	<div class="path">
		<ul class="clearfix">
			<li><a href="javascript://" class="back">운영자 관리</a></li>
			<li><a href="javascript:goCancel();" class="back">시스템 문의 등록</a></li>
			<li class="last-child"><span class="this">문의 등록</span></li>
		</ul>
	</div>
</div>
<section id="content" class="w1200">
	<article class="admin_conf">
		<form id="myForm" name="myForm" method="POST" class="valid_form">	
			<input type="hidden" id="search_partner_clcd" name="search_partner_clcd" value="${systemCounselDomain.search_partner_clcd}">
			<input type="hidden" id="search_partner_sno" name="search_partner_sno" value="${systemCounselDomain.search_partner_sno}">
			<input type="hidden" id="search_answer_yn" name="search_answer_yn" value="${systemCounselDomain.search_answer_yn}">
			<input type="hidden" id="partner_sno" name="partner_sno" value="${systemCounselDomain.userPartnerSno}">
		
			<ol>
    			<li>코치코치당뇨 관리자에 문의하실 내용을 작성해주세요.</li>
			</ol>
			
			<div class="form_table">
				<legend>문의 정보 입력</legend>
				<fieldset>
					<table>
						<colgroup>
				            <col style="width:230px;">
				            <col width="*">
			          	</colgroup>
			          	<tbody>
							<tr>
								<th>제목<span class="require">*</span></th>
								<td>
									<input type="text" class="inp_txt w540" id="counsel_title" name="counsel_title" placeholder="" maxlength="100"/>
				                </td>
				            </tr>
							<tr>
								<th>내용<span class="require">*</span></th>
								<td>
									<textarea name="counsel_contents" id="counsel_contents" placeholder="1000자 까지 입력 가능" contenteditable="true" required class="editor"></textarea>
				                </td>
				            </tr>
							<tr>
								<th>이미지첨부</th>
								<td>
	                                <button type="button"  class="btn_black" id="btn_attach">이미지첨부</button>
									<span>최대 3장까지 첨부 가능</span>
									<ul class="img_area clearfix" ></ul>
				                </td>
				            </tr>
				            
						</tbody>
		    		</table>
	    		</fieldset>
			</div>
			<div class="btn_area">
				<div class="center">
					<button type="button" class="btn_white btn_line_gray w180 mr18" id="btn_cancel">취소</button>
					<button type="button" class="btn_red w180" id="btn_save">등록</button>
				</div>
			</div>		
		</form>
	</article>
	<form id="uploadForm" name="uploadForm" method="POST" ></form>	
</section>	
		
