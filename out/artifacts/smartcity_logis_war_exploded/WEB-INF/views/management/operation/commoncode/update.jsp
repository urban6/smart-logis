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
	
	$('#dynatree').dynatree("getTree").activateKey('${key}');
	
	//버튼 클릭시
	$("#btn_goDetail").click(function() {
		var node = $('#dynatree').dynatree("getActiveNode");
		getViewCommonCodeDetail(node);
	});	
	
	$("#btn_update").click(function() {
		goUpdate();
	});
	
	 
});

function goUpdate() {
	var node = $('#dynatree').dynatree("getActiveNode");
	
	if($("#code_name").val() == "") {
		//openAlertModal("","Please enter code name");
		openAlertModal("Warning","코드 이름을 입력해 주세요.");
		$("#code_name").focus();
		return;
	}
	$("#up_code_no").val(node.parent.data.key);
		
	openConfirmModal("NOTIFICATION",'<spring:message code="msg.common.save" />',function(){	
		var param = $("#commoncode").serialize();
		$.ajax({
	        url : "/management/operation/commoncode/updateAction.ajax",
	        data : param,
	        type : 'POST',
	        dataType : 'json',
	        async: false,
	        success : function(data) {
			result = data.returnMsg;
			if (result == "SUCCESS") {
					 var node = $('#dynatree').dynatree("getActiveNode");
					 //openAlertModal("Success","Your details have been deleted",function(){
					 openAlertModal("SUCCESS", "관련 정보가 삭제되었습니다.",function(){
						//$("#key").val(data.menu.group_cd+":"+data.menu.input_detail_cd);
						$("#commoncode").submit(); 
						} 
					);   // index로 다시 이동
				}else{
					openAlertModal(data.resultMsg);
				}
	        },
	        error: function(e){
	        	openAlertModal("",callErrorMsg);
	        },
	        complete : function() {
	        }
		});
	});   
}

 
</script>
<form:form name="commoncode" commandName="commoncode" method="post" action="/management/operation/commoncode/index">
		 <input type="hidden" id="detail_cd" name="detail_cd" value="${detailCode.detail_cd}" /> 
		 <input type="hidden" id="up_code_no" name="up_code_no" value=""/>
		 <input type="hidden" id="key" name="key" value="${key}"/>
		  <div class="cont_title">
            <span>Menu Properties</span>
          </div>
          <div class="table type_04 edit">
            <table>
              <colgroup>
                <col>
              </colgroup>
              <tbody>
                <tr>
                  <td>
                    <!-- <div class="label"><span>Group Code</span></div> -->
                    <div class="label"><span>그룹 코드</span></div>
                    <div class="value">
                        <span>${detailCode.up_code_no}</span>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>
                    <!-- <div class="label"><span>Code</span></div> -->
                    <div class="label"><span>코드</span></div>
                    <div class="value rflex">
                      <div class="input type_02">
                        <input type="text" id="input_detail_cd" name="input_detail_cd" value="${detailCode.detail_cd}"  placeholder="Detail Code" />
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
                        <input type="text" id="code_name" name="code_name" value="${detailCode.code_name}"  placeholder="Code Name" />
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
                        <textarea name="description" id="description" placeholder="Description" rows="6">${detailCode.description}</textarea>
                      </div>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <div class="cont_footer">
            <div class="btn_area">
              <button type="button" id="btn_goDetail" class="btn type_01">취소</button>
              <button type="button" id="btn_update" class="btn type_02">저장</button>
            </div>
          </div>
</form:form>