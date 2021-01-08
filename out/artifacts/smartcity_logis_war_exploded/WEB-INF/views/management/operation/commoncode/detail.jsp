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
    
	activateNode();
	//버튼 클릭시
	$("#btnModify").click(function() {
		getModifyCommonCodePage('${key}');
	}); 
	$("#btn_delete").click(function() {
		goDelete('${key}');
	});
});
function activateNode() {
	$('#dynatree').dynatree("getTree").activateKey('${key}');
}
function getModifyCommonCodePage(key) {
	var param = new Object();
	param.key=key;
	
 	$.ajax({
       url : "update",
       data : param,
       type : 'POST',
       success : function(data) {
          $("#commoncodeAttribute").html(data);
       },
       error: function(e){
           openAlertModal("",callErrorMsg);
       },
       complete : function() {
		
       }
	}); 
	
}
function goDelete(key) {
	var node = $('#dynatree').dynatree("getActiveNode");
	
	if(!node) {
		// openAlertModal("NOTIFICATION",'<spring:message code="msg.need.select.menu.text"/>');
		openAlertModal("Warning", "메뉴를 선택해 주세요.");
		return;
	}
	
	//자식 노드 존재하면 삭제금지
	if(node.childList != null){
		//openAlertModal("NOTIFICATION",'The group cannot be deleted because of dependencies');
		openAlertModal("Warning", "하위 코드가 존재하여 삭제할 수 없습니다.");
		return;			
	}	

	//openConfirmModal("NOTIFICATION", "Are you sure you want to delete this information?\nAll information associated with it will be deleted", function(){
	  openConfirmModal("NOTIFICATION", "정말 삭제하시겠습니까?\n관련된 모든 정보가 삭제됩니다.", function(){
		var param = new Object();
		param.key=key;
		$.ajax({
	        url : "/management/operation/commoncode/deleteAction.ajax",
	        data : param,
	        type : 'POST',
	        dataType : 'json',
	        async: false,
	        success : function(data) {
				result = data.returnMsg;
				if (result == "SUCCESS") {
					 var node = $('#dynatree').dynatree("getActiveNode");
					 //openAlertModal("Success","Your details have been deleted",function(){
					   openAlertModal("SUCCESS","관련 정보가 삭제되었습니다.",function(){
						 $("#key").val(node.parent.data.key);
						 $("#commoncode").submit(); }
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
	        <span>Code Properties</span>
	      </div>
	      <div class="table type_04">
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
	                  <span>
	                    ${detailCode.up_code_no}
	                  </span>
	                </div>
	              </td>
	            </tr>
	            <tr>
	              <td>
	                <!-- <div class="label"><span>Code</span></div> -->
                    <div class="label"><span>코드</span></div>
	                <div class="value">
	                  <span>
	                   ${detailCode.detail_cd}
	                  </span>
	                </div>
	              </td>
	            </tr>
	            <tr>
	              <td>
	                <!-- <div class="label"><span>Code Name</span></div> -->
                    <div class="label"><span>코드 이름</span></div>
	                <div class="value">
	                  <span>${detailCode.code_name}</span>
	                </div>
	              </td>
	            </tr>
	            <tr>
	              <td>
	                <!-- <div class="label"><span>Description</span></div> -->
                    <div class="label"><span>설명</span></div>
	                <div class="value">
	                  <span>${detailCode.description}</span>
	                </div>
	              </td>
	            </tr>
	          </tbody>
	        </table>
	      </div>
	      <div class="cont_footer">
	        <div class="btn_area">
	         <!--  <button type="button" class="btn type_01">List</button>
	          <button type="button" class="btn type_01">Delete</button> -->
	          <shovvel:auth auth="${authType}">
	          <button type="button" id="btn_delete" class="btn type_01">삭제</button>
	          <button type="button"  id="btnModify" class="btn type_02">수정</button>
	          </shovvel:auth>
	        </div>
	      </div>
</form:form>