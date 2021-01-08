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
        
        init();
    });
    
    function init(){
    	$("input.onlynum").numeric();
		
        if("${info.partner_clcd}" == "50201020"){
      		$('.css_ins').show();
      		$('.css_hp').hide();
        }else{
      		$('.css_ins').hide();
      		$('.css_hp').show();
        }
    }
    
    function goCancel(){
        $("#myForm").attr("action", "/management/partnermng/partner/list");
        $("#myForm").submit();
    }
    

    function goSave() {
        if(!checkValidation()) {
            return false;
        }

        if($('#partner_clcd').val() == '50201020'){
            $('#partner_medical_no').val('');
            $('#partner_coaching_use_yn').val('N');
            if($('#partnerCoachingUseYn').prop('checked')) {
                $('#partner_coaching_use_yn').val('Y');
            }
            
            $('#partner_community_use_yn').val('N');
            if($('#partnerCommunityUseYn').prop('checked')) {
                $('#partner_community_use_yn').val('Y');
            }
        } else {
            $('#partner_corp_no').val('');
            $('#partner_coaching_use_yn').val('N');
            $('#partner_community_use_yn').val('N');
        }
        
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
    
    function goDelete() {
        openConfirmModal("NOTIFICATION","삭제 하시겠습니까?", function() {
                showLoading();
            var param = new Object();
            param.partner_sno = $('#partner_sno').val();    
            
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

        $("input.inp_txt, input.txtDate").each(function (index) {
 	 		var text = $(this).val();
			var title = $(this).closest('td').prevAll('th:visible').eq(0).text().replace("*", "");
			var isRequired = ($(this).closest('td').prevAll('th:visible').eq(0).find('span.require').length > 0);
			
			if (text.length > 0) {
				if ($(this).hasClass("onlynum")) {
					var maxLength = $(this).attr('maxLength');

					if ($(this).attr('type') == "tel" && !(text.length >= maxLength - 1 && text.length <= maxLength)) {
						showErrorMessage($(this).attr('id'), title + "를 확인해 주세요.");
					} else if(text.length != maxLength) {
						showErrorMessage($(this).attr('id'), title + "를 확인해 주세요.");
					}
					
					if (!/^[0-9]+$/.test(text)) {
						showErrorMessage($(this).attr('id'), title + "는 숫자만 허용됩니다.");
					}

				} else {
					if ($(this).attr('type') == "email" && !isValidEmail(text)) {
						showErrorMessage($(this).attr('id'), title + "를 확인해 주세요.");
					}
				}
			} 

			if (isRequired && (text == null || text == "")) {
				showErrorMessage($(this).attr('id'), title + "를 입력하세요.");
			}
						
 	 	});

		return ($("#myForm").find("label.error:visible").length == 0);	

    }
    
</script>
    <div class="path_area">
        <div class="path">
            <ul class="clearfix">
                <li><a href="#" class="back">제휴사 관리</a></li>
                <li><span class="this">파트너사 관리</span></li>
                <li class="last-child"><span class="this">파트너사 수정</span></li>
            </ul>
        </div>
    </div>
    <!-- section : start -->
    <section id="content" class="w1200">

        <article class="admin_conf">
            <form id="myForm" name="myForm" method="POST" class="valid_form">
		        <input type="hidden" id=partner_sno name="partner_sno" value="${info.partner_sno}">
		        <input type="hidden" id=partner_clcd name="partner_clcd" value="${info.partner_clcd}">
		        <input type="hidden" id="partner_coaching_use_yn" name="partner_coaching_use_yn" value="${info.partner_coaching_use_yn}"/>
		        <input type="hidden" id="partner_community_use_yn" name="partner_community_use_yn" value="${info.partner_community_use_yn}"/>
		        <input type="hidden" id=search_partner_clcd name="search_partner_clcd" value="${partnerDomain.search_partner_clcd}">
		        <input type="hidden" id=search_partner_nm name="search_partner_nm" value="${partnerDomain.search_partner_nm}">
                <p class="title css_ins">보험사 정보</p>
                <p class="title css_hp">병원 정보</p>
                <ol>
                    <li>전화번호와 홈페이지 정보는 앱 보험사 카드에 노출되는 정보입니다.</li>
                </ol>
                <div class="form_table">
                    <legend>보험사 등록 정보 입력</legend>
                    <fieldset>
                        <table>
                            <colgroup>
                                <col width="230"/>
                                <col/>
                                <col width="230"/>
                                <col/>
                            </colgroup>
                            <tbody>
                            <tr>
                                <th class="css_ins">상호<span class="require">*</span></th>
                                <th class="css_hp">요양기관명<span class="require">*</span></th>
                                <td>
                                    <input type="text" class="inp_txt wfull" id="partner_nm" name="partner_nm" maxlength="100" value="${info.partner_nm }">
                                </td>
                                <th>대표자<span class="require">*</span></th>
                                <td>
                                    <input type="text" class="inp_txt wfull" id="partner_rep_nm" name="partner_rep_nm" maxlength="20" value="${info.partner_rep_nm }">
                                </td>
                            </tr>
                            <tr>
                                <th class="css_ins">법인등록번호<span class="require">*</span></th>
                                <td class="css_ins">
                                    <input type="text" class="inp_txt wfull onlynum" id="partner_corp_no" name="partner_corp_no" maxlength="10" value="${info.partner_corp_no }">
                                </td>
                                <th class="css_hp">요양기관번호<span class="require">*</span></th>
                                <td class="css_hp">
                                    <input type="text" class="inp_txt wfull onlynum" id="partner_medical_no" name="partner_medical_no" placeholder="건강보험공단 관리번호 8자리" maxlength="8" value="${info.partner_medical_no }">
                                </td>
                                <th>전화번호<span class="require">*</span></th>
                                <td>
                                    <input type="tel" class="inp_txt wfull onlynum" id="partner_tel_no" name="partner_tel_no" maxlength="11" placeholder="'-'없이 숫자만 입력" value="${info.partner_tel_no }">
                                </td>
                            </tr>
                            <tr>
                                <th>사업자등록번호<span class="require">*</span></th>
                                <td>
                                    <input type="text" class="inp_txt wfull onlynum" id="partner_business_no" name="partner_business_no" maxlength="13" value="${info.partner_business_no }">
                                </td>
                                <th>FAX</th>
                                <td>
                                    <input type="text" class="inp_txt wfull onlynum" id="partner_fax_no" name="partner_fax_no" maxlength="11" value="${info.partner_fax_no }">
                                </td>
                            </tr>
                            <tr>
                                <th>종별<span class="require">*</span></th>
                                <td>
		                            <select class="inp_select w185" id="partner_business_clcd" name="partner_business_clcd">
		                                <c:forEach items="${cmbTypeList}" var="cmb" varStatus="status">
		                                    <option value="${cmb.com_cd}" ${info.partner_business_clcd eq cmb.com_cd ? 'selected="selected"' : ''}>${cmb.cd_nm}</option>
		                                </c:forEach>
		                            </select>
                                </td>
                                <th>이메일주소</th>
                                <td>
                                    <input type="email" class="inp_txt wfull" id="partner_email" name="partner_email" maxlength="100" value="${info.partner_email }">
                                </td>
                            </tr>
                            <tr>
                                <th>홈페이지</th>
                                <td colspan="3">
                                    <input type="url" class="inp_txt wfull" id="partner_home_page" name="partner_home_page" maxlength="255" value="${info.partner_home_page }">
                                </td>
                            </tr>
                            <tr>
                                <th class="css_ins">본사소재지<span class="require">*</span></th>
                                <th class="css_hp">주소<span class="require">*</span></th>
                                <td colspan="3">
                                    <input type="text" class="inp_txt wfull" id="partner_addr" name="partner_addr" maxlength="255" value="${info.partner_addr }">
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </fieldset>
                </div>


                <p class="title">담당자 정보</p>
                <div class="form_table">
                    <legend>담당자 등록 정보 입력</legend>
                    <fieldset>
                        <table>
                            <colgroup>
                                <col width="230"/>
                                <col/>
                                <col width="230"/>
                                <col/>
                            </colgroup>
                            <tbody>
                            <tr>
                                <th>이름<span class="require">*</span></th>
                                <td>
                                    <input type="text" class="inp_txt wfull" id="partner_user_nm" name="partner_user_nm" maxlength="20" value="${info.partner_user_nm }">
                                </td>
                                <th>전화번호<span class="require">*</span></th>
                                <td>
                                    <input type="tel" class="inp_txt wfull onlynum" id="partner_user_tel_no" name="partner_user_tel_no" placeholder="‘-’없이 숫자만 입력" maxlength="11" value="${info.partner_user_tel_no }">
                                </td>
                            </tr>
                            <tr>
                                <th>이메일 주소<span class="require">*</span></th>
                                <td>
                                    <input type="email" class="inp_txt wfull" id="partner_user_email" name="partner_user_email" maxlength="100" value="${info.partner_user_email }">
                                </td>
                                <th>휴대폰 번호<span class="require">*</span></th>
                                <td>
                                    <input type="tel" class="inp_txt wfull onlynum" id="partner_user_hp_no" name="partner_user_hp_no" placeholder="‘-’없이 숫자만 입력" maxlength="11" value="${info.partner_user_hp_no }">
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </fieldset>
                </div>


                <p class="title css_ins">코치코치당뇨 서비스 이용</p>
                <div class="form_table css_ins">
                    <legend>서비스 이용정보 입력</legend>
                    <fieldset>
                        <table>
                            <colgroup>
                                <col width="230"/>
                                <col/>
                                <col width="230"/>
                                <col/>
                            </colgroup>
                            <tbody>
                            <tr>
                                <th>건강코칭</th>
                                <td>
                                    <span class="checkbox">
                                    <input type="checkbox" class="hid_chk" id="partnerCoachingUseYn" ${info.partner_coaching_use_yn eq 'Y' ? 'checked="checked"' : ''}>
                                    <label for="partnerCoachingUseYn" class="icon">
                                        <span class="ml5">제공</span>
                                    </label>
                                  </span>
                                </td>
                                <th>커뮤니티</th>
                                <td>
                                    <span class="checkbox">
                                    <input type="checkbox" class="hid_chk" id="partnerCommunityUseYn" ${info.partner_community_use_yn eq 'Y' ? 'checked="checked"' : ''}>
                                    <label for="partnerCommunityUseYn" class="icon">
                                        <span class="ml5">제공</span>
                                    </label>
                                  </span>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </fieldset>
                </div>


                <p class="title">제휴계약 정보</p>
                <div class="form_table">
                    <fieldset>
                        <table>
                            <colgroup>
                                <col width="230"/>
                                <col/>
                                <col width="230"/>
                                <col/>
                            </colgroup>
                            <tbody>
                            <tr>
                                <th>체결일자<span class="require">*</span></th>
                                <td>
                                    <label class="date_picker ws2">
                                        <input type="text" class="txtDate" id="partner_contract_ins_dd" name="partner_contract_ins_dd" placeholder="날짜 선택" title="날짜를 선택해주세요."
                                               readonly="" value="${info.partner_contract_ins_dd }">
                                        <span class="btn_picker">달력</span>
                                    </label>
                                </td>
                                <th>파트너 코드</th>
                                <td>${info.partner_cd }</td>
                            </tr>
                            <tr>
                                <th>갱신일자</th>
                                <td>
                                    <label class="date_picker ws2">
                                        <input type="text" class="txtDate" id="partner_contract_upd_dd" name="partner_contract_upd_dd" placeholder="날짜 선택" title="날짜를 선택해주세요."
                                               readonly="" value="${info.partner_contract_upd_dd }">
                                        <span class="btn_picker">달력</span>
                                    </label>
                                </td>
                                <th>해지일자</th>
                                <td>
                                    <label class="date_picker ws2">
                                        <input type="text" class="txtDate" id="partner_contract_end_dd" name="partner_contract_end_dd" placeholder="날짜 선택" title="날짜를 선택해주세요."
                                               readonly="" value="${info.partner_contract_end_dd }">
                                        <span class="btn_picker">달력</span>
                                    </label>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <div class="btn_area">
                            <div class="center">
                                <button type="button" class="btn_white btn_line_gray w180 mr18" id="btn_cancel">목록</button>
                                <shovvel:auth auth="${authType}">
                                <button type="button" class="btn_black w180 mr18" id="btn_del">삭제</button>
                                <button type="button" class="btn_red w180" id="btn_save">수정</button>
                                </shovvel:auth>
                            </div>
                        </div>
                    </fieldset>
                </div>

            </form>
        </article>
    </section>
    <!-- section : end -->
