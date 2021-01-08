<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel" %>

<script type="text/javascript" charset="utf-8" src="/scripts/editor-common.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/tinymce/tinymce.min.js"></script>

<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
          $("#btn_cancel").click(function(){
              goList();
          });
        
          init();
    });
    
      function init(){
      }
    
    function goList(){
        $("#myForm").attr("action","list");
        $("#myForm").submit();
    }
    
    function clickImage(obj){
        var src = obj.attr("src");
        window.open(src,"_target");
    }
    
    /* ######## tinyMce 에디터 ######## */
    var tinymceInitOpts = editCommon.getTinymceInitOpts('${sessionScope.SESSION_LANGUAGE_CODE}','.editor','readonly');
    tinymce.init(tinymceInitOpts);
    
</script> 
<!-- section : start -->
<section id="content" class="w1200">
    <article class="admin_conf">
        <form id="myForm" name="myForm" method="POST">    
            <input type="hidden" id="searchType" name=searchType value="${info.searchType}">
              <input type="hidden" id="searchKey" name=searchKey value="${info.searchKey}">
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

            <br>
            <p class="title">답변완료  <small class="date">  ${info.answer_date}</small></p>
            <div class="form_table">
                <fieldset>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tbody>
                        <tr>
                            <td>
                                <div class="content">
                                    <textarea name="counsel_contents" id="counsel_contents" placeholder="1000자 까지 입력 가능" contenteditable="true" required class="editor">${info.answer_contents}</textarea>
                                </div>
                                <ul class="img_area clearfix">
                                    <c:if test="${info.answer_img_file_sno_1 ne null && info.answer_img_file_sno_1 ne 0   }">
                                        <li>
                                            <img src='${baseContentsUrl}${info.answer_img_save_nm_1}' onclick='clickImage($(this));'/>
                                        </li>    
                                    </c:if>
                                    <c:if test="${info.answer_img_file_sno_2 ne null && info.answer_img_file_sno_2 ne 0   }">
                                        <li>
                                            <img src='${baseContentsUrl}${info.answer_img_save_nm_2}' onclick='clickImage($(this));'/>
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

        </form>
    </article>
</section>
<!-- section : end -->