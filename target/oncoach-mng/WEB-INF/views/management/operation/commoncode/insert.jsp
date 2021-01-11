<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel" %>

<script type="text/javascript">

//Ajax로 첫 화면의 데이터 호출
//화면 먼저 보이고 데이터를 불러야 사용자가 덜 답답해 함
$(document).ready(function(){
	//버튼 클릭시
	$("#btn_add").click(function() {
		goInsert();
	});
});

function goInsert() {
	var node = $('#dynatree').dynatree("getActiveNode");
	
	$("#up_code_no").val(node.data.key);
	if($("#detail_cd").val() == "") {
		// openAlertModal('Please enter code');
		openAlertModal("Warning","코드를 입력해 주세요.");
		$("#detail_cd").focus();
		return;
	}
	if($("#code_name").val() == "") {
		//openAlertModal('Please enter code name');
		openAlertModal("Warning","코드 이름을 입력해 주세요.");
		$("#code_name").focus();
		return;
	}
	var param = $("#commoncode").serialize();
	
	$.ajax({
        url : "/management/operation/commoncode/insertAction.ajax",
        data : param,
        type : 'POST',
        dataType : 'json',
        async: false,
        success : function(data) {
			result = data.returnMsg;
			if (result == "SUCCESS") {
				// openAlertModal("SUCCESS","Your details have been saved",function(){
        		openAlertModal("SUCCESS","입력한 정보가 저장되었습니다.",function(){
					$("#commoncode").submit();} 
				); // index로 다시 이동
			}else{
				openAlertModal("Warning",data.resultMsg);
			}
        },
        error: function(e){
        	openAlertModal("",callErrorMsg);
        },
        complete : function() {

        }
	}); 
	
	
	
	
	
}
</script>

<form:form name="commoncode" commandName="commoncode" method="post" action="/management/operation/commoncode/index">
              <input type="hidden" id="key" name="key" value="${key}" />
               <input type="hidden" id="up_code_no" name="up_code_no" value=""/>
               <input type="hidden" id="folder_yn" name="folder_yn" value="${folder_yn}" />
		  <div class="cont_title">
            <span>Code Properties</span>
          </div>
          <div class="table type_04 edit">
            <table>
              <colgroup>
                <col>
              </colgroup>
              <tbody>
              	<tr>
              	  <td>
            		<!-- <div class="label"><span>Code Type</span></div> -->
            		<div class="label"><span>코드 유형</span></div>
                  	<div class="value">
                    <c:if test="${folder_yn eq 'Y'}"><span>Group</span></c:if>
                    <c:if test="${folder_yn eq 'N'}"><span>Code</span></c:if>
                    </div>
                  </td>
              	</tr>
                <tr>
                  <td>
                    <!-- <div class="label"><span>Code</span></div> -->
                    <div class="label"><span>코드</span></div>
                    <div class="value rflex">
                      <div class="input type_02">
                      	<input type="text" id="input_detail_cd" name="input_detail_cd" placeholder="Code" />
                      </div>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>
                    <!-- <div class="label"><span>Code Name</span></div> -->
                    <div class="label"><span>코드 이름</span></div>
                    <div class="value rflex">
                      <div class="input type_02">
                        <input type="text" id="code_name" name="code_name" placeholder="Code Name" />
                      </div>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>
                    <!-- <div class="label"><span>Description</span></div> -->
                    <div class="label"><span>설명</span></div>
                    <div class="value rflex">
                      <div class="textarea type_02">
                        <textarea name="description" id="description" placeholder="Description" rows="6"></textarea>
                      </div>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <div class="cont_footer">
            <div class="btn_area">
              <button type="button" class="btn type_01">취소</button>
              <shovvel:auth auth="${authType}">
              <button type="button" id="btn_add" class="btn type_02">저장</button>
              </shovvel:auth>
            </div>
          </div>
</form:form> 