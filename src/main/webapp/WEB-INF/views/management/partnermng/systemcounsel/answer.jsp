<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel" %>

<script type="text/javascript" charset="utf-8" src="/scripts/editor-common.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/tinymce/tinymce.min.js"></script>
<script src="/scripts/jquery.form.js"></script>
<script src="/scripts/fileupload.js"></script>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
        $("#btn_cancel").click(function(){
            goCancel();
        });
          
          $("#btn_save").click(function(){
              goSave();
          });
          
        $("#btn_attach").click(function(){
            goAttach();    
        });
        
          init();
    });
    
      function init(){
      }
    
    function goCancel(){
        $("#myForm").attr("action","answerList");
        $("#myForm").submit();
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
        $(".answer").append(html);
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
     
     function goSave() {
         
         tinyMCE.triggerSave();
         
         if(!checkValidation()) {
             return false;
         }

         if(!hasErrorMessage()) {
             openConfirmModal("NOTIFICATION","저장 하시겠습니까?", function() {
                 showLoading();
                var param = new Object();
                param = $("#myForm").serialize();    
                
                 $.ajax({
                    url : "answerAction",
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
        
        if($("#answer_contents").val() == null || $("#answer_contents").val() == "") {
            showErrorMessage("answer_contents", "답변내용을 입력하세요.");
        }
         
        return true;
    }
    
    /* ######## tinyMce 에디터 ######## */
    var tinymceInitOpts = editCommon.getTinymceInitOpts('${sessionScope.SESSION_LANGUAGE_CODE}','.editor','readonly');
    tinymce.init(tinymceInitOpts);
    
    var tinymceInitOpts = editCommon.getTinymceInitOpts('${sessionScope.SESSION_LANGUAGE_CODE}','.answerEditor','');
    tinymce.init(tinymceInitOpts);
    
</script>
<div class="path_area">
    <div class="path">
        <ul class="clearfix">
            <li><a href="javascript://" class="back">제휴사 관리</a></li>
            <li><a href="javascript:goCancel();" class="back">시스템 문의 관리</a></li>
            <li class="last-child">
                <c:if test="${info.answer_yn eq 'Y'}"><span class="this">문의 답변 확인</span></c:if>
                <c:if test="${info.answer_yn ne 'Y'}"><span class="this">문의 답변 작성</span></c:if>
            </li>
        </ul>
    </div>
</div> 
<section id="content" class="w1200">
    <article class="admin_conf">
        <form id="myForm" name="myForm" method="POST"  class="valid_form">    
            <input type="hidden" id="search_partner_clcd" name="search_partner_clcd" value="${systemCounselDomain.search_partner_clcd}">
            <input type="hidden" id="search_partner_sno" name="search_partner_sno" value="${systemCounselDomain.search_partner_sno}">
            <input type="hidden" id="search_answer_yn" name="search_answer_yn" value="${systemCounselDomain.search_answer_yn}">
            <input type="hidden" id="partner_sno" name="partner_sno" value="${systemCounselDomain.userPartnerSno}">
              <input type="hidden" id="system_counsel_sno" name=system_counsel_sno value="${info.system_counsel_sno}">
            
            <br>
            <p class="title">운영자 정보</p>
            <div class="form_table">
                <legend>운영자 등록 정보 입력</legend>
                <fieldset>
                    <table>
                        <colgroup>
                            <col width="180"/>
                            <col/>
                            <col width="180"/>
                            <col/>
                        </colgroup>
                        <tbody>
                        <tr>
                            <th>아이디</th>
                            <td>${info.login_id}</td>
                            <th>소속</th>
                            <td>${info.partner_nm}</td>
                        </tr>
                        <tr>
                            <th>이름</th>
                            <td>${info.user_nm}</td>
                            <th>권한</th>
                            <td>${info.level_title}</td>
                        </tr>
                        <tr>
                            <th>휴대폰번호</th>
                            <td id="userHpNo" colspan="3" ><script>changePhoneFormat('userHpNo', '${info.user_hp_no}')</script></td>
                        </tr>
                        </tbody>
                    </table>
                </fieldset>
            </div>
            
            <br>
            <p class="title">문의내용  <small class="date">  ${info.counsel_date}</small></p>
            <ol>
                <li>제목 :  ${info.counsel_title}</li>
            </ol>
            <div class="form_table">
                <fieldset>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tbody>
                        <tr>
                            <td>
                                <div class="content">
                                   <textarea name="counsel_contents" id="counsel_contents" placeholder="1000자 까지 입력 가능" contenteditable="true" required class="editor">${info.counsel_contents}</textarea>
                                </div>
                                <ul class="img_area clearfix">
                                    <c:if test="${info.counsel_img_file_sno_1 ne null && info.counsel_img_file_sno_1 ne 0   }">
                                        <li>
                                            <img src='${baseContentsUrl}${info.counsel_img_save_nm_1}' onclick='clickImage($(this));'/>
                                        </li>    
                                    </c:if>
                                    <c:if test="${info.counsel_img_file_sno_2 ne null && info.counsel_img_file_sno_2 ne 0   }">
                                        <li>
                                            <img src='${baseContentsUrl}${info.counsel_img_save_nm_2}' onclick='clickImage($(this));'/>
                                        </li>
                                    </c:if>
                                    <c:if test="${info.counsel_img_file_sno_3 ne null && info.counsel_img_file_sno_3 ne 0   }">
                                        <li>
                                            <img src='${baseContentsUrl}${info.counsel_img_save_nm_3}' onclick='clickImage($(this));'/>
                                        </li>
                                    </c:if>
                                </ul>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </fieldset>
            </div>
            <!-- 답변작성 완료 start -->
            <c:if test="${info.answer_yn eq 'Y'}">
            	<br>
                <p class="title">답변완료  <small class="date">  ${info.answer_date}</small></p>
                <div class="form_table">
                    <fieldset>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tbody>
                            <tr>
                                <td>
                                    <div class="content">
                                       <textarea name="answer_contents" id="answer_contents" placeholder="1000자 까지 입력 가능" contenteditable="true" required class="editor">${info.answer_contents}</textarea>
                                    </div>
                                    <ul class="img_area clearfix">
                                        <c:if test="${info.answer_img_file_sno_1 ne null && info.answer_img_file_sno_1 ne 0   }">
                                            <li>
                                                <img src='${baseContentsUrl}${info.answer_img_save_nm_1}' onclick='clickImage($(this));'/>
                                            </li>    
                                        </c:if>
                                        <c:if test="${info.answer_img_file_sno_2 ne null && info.answer_img_file_sno_2 ne 0   }">
                                            <li>
                                                <img src='${baseContentsUrl}${info.answer_img_save_nm_2}'  onclick='clickImage($(this));'/>
                                            </li>    
                                        </c:if>
                                        <c:if test="${info.answer_img_file_sno_3 ne null && info.answer_img_file_sno_3 ne 0   }">
                                            <li>
                                                <img src='${baseContentsUrl}${info.answer_img_save_nm_3}' onclick='clickImage($(this));'/>
                                            </li>    
                                        </c:if>
                                    </ul>
                                </td>
                            </tr>
                            </tbody>
                        </table>
    
                        <div class="btn_area">
                            <div class="center">
                                <button type="button" class="btn_white btn_line_gray w180 mr18"  id="btn_cancel">목록</button>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </c:if>
            <!-- 답변작성 완료 end -->
            <!-- 답변작성 미완료 start -->
            <c:if test="${info.answer_yn eq 'N'}">
                <br>
                <p class="title">답변작성<small class="date"></small></p>
                <div class="form_table">
                <fieldset>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <colgroup>
                            <col width="180"/>
                            <col/>
                        </colgroup>
                        <tbody>
                        <tr>
                            <th>내용</th>
                            <td>
                                <textarea name="answer_contents" id="answer_contents" placeholder="1000자 까지 입력 가능" contenteditable="true"  class="answerEditor"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>이미지 첨부</th>
                            <td>
                                <div class="sel_box">
                                    <button type="button"  class="btn_black" id="btn_attach">이미지첨부</button>
                                    <span>최대 3장까지 첨부 가능</span>
                                    <ul class="img_area clearfix answer" ></ul>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
    
                    <div class="btn_area">
                        <div class="center">
                            <button type="button" class="btn_white btn_line_gray w180 mr18" id="btn_cancel">목록</button>
                            <shovvel:auth auth="${authType}">
                            <c:if test="${info.answer_yn eq 'N'}">
                                <button type="button" class="btn_red w180" id="btn_save">등록</button>
                            </c:if>
                            </shovvel:auth>
                        </div>
                    </div>
                </fieldset>
            </div>
            </c:if>
            <!-- 답변작성 미완료 end -->
        </form>
    </article>
    <form id="uploadForm" name="uploadForm" method="POST" ></form>    
</section>    