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
	init();
	$('#dynatree').dynatree("getTree").activateKey('${menu.menu_id}');
	
	//버튼 클릭시
	$("#btn_goDetail").click(function() {
		getViewMenuPage('${menu.menu_id}');
	});	
	$("#btn_update").click(function() {
		goUpdate();
	});
});

function init() {
	var tmp_is_folder = "${menu.is_folder}";

	if(tmp_is_folder != "") {
		if(tmp_is_folder == "Y") {
			$("#is_folder_Y").attr("checked", "Y");
		} else
			$("#is_folder_N").attr("checked", "N");
	} else {
		var param_is_folder = "${is_folder}";
		
		if(param_is_folder == "Y") {
			$("#is_folder_Y").attr("checked", "Y");
		} else
			$("#is_folder_N").attr("checked", "N");
	}
	
	$("#tmp_menu_path").val( "${menu.menu_path}" );
	
	var popup_yn = "${menu.popup_yn}";
	if(popup_yn == "Y") {	
		$("#c_popup_yn").attr("checked", true);
	} else {
		$("#c_popup_yn").attr("checked", false);
	}
}

function goUpdate() {
	if($("#menu_name").val() == "") {
		//openAlertModal('<spring:message code="NotEmpty.menu.menu_name"/>');
		// alert('<spring:message code="NotEmpty.menu.menu_name"/>');
		openAlertModal("Warning","메뉴 이름을 입력해 주세요.");
		$("#menu_name").focus();
		return;
	}

	if($("#c_popup_yn").is(":checked")) {
		$("#popup_yn").val("Y");
	} else {
		$("#popup_yn").val("N");
	}
	
	//openConfirmModal("",'<spring:message code="msg.common.save" />',function(){	
		$("#menu_path").val($("#tmp_menu_path").val());
		var param = $("#menu").serialize();
		
		$.ajax({
	        url : "/management/operation/menu/updateAction.ajax",
	        data : param,
	        type : 'POST',
	        dataType : 'json',
	        async: false,
	        success : function(data) {
				result = data.returnMsg;
				if (result == "SUCCESS") {
					//openAlertModal("Success","Your changes have been saved",function(){ $("#menu").submit(); } );  // index로 다시 이동
					//alert("Your changes have been saved.");
					openAlertModal("SUCCESS", "변경사항이 저장되었습니다.");
					$("#menu").submit();
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
	//});
}
</script>

<form:form name="menu" commandName="menu" method="post" action="/management/operation/menu/index">
	<input type="hidden" id="menu_id" name="menu_id" value="${menu.menu_id}" />
	<input type="hidden" id="up_menu_id" name="up_menu_id" value="${menu.up_menu_id}" />
	<input type="hidden" id="depth" name="depth" value="${menu.depth}" />
	<input type="hidden" id="display_order" name="display_order" value="${menu.display_order}" />
	<input type="hidden" id="is_folder" name="is_folder" value="${menu.is_folder}" />
	<input type="hidden" id="menu_path" name="menu_path" value="${menu.menu_path}" />
	<input type="hidden" id="popup_yn" name="popup_yn" value="${menu.popup_yn}" />
	<input type="hidden" id="pkg_name" name="pkg_name" value="${menu.pkg_name}" />
		  
	<div class="result type_02">
		<div class="left_cont">
			<!-- <h2>Menu Properties</h2>-->
				<h2>메뉴 속성 세부 정보</h2>
		</div>
	</div>

	<div class="table type_01 detail">
		<table>
			<colgroup>
				<col style="width: 230px">
				<col style="width: *">
			</colgroup>
			<tbody>
				<tr>
					<!-- <th scope="row">Menu Type</th> -->
						<th scope="row">메뉴 타입</th>
					<td>
						<div class="input type_01">
							<c:if test="${menu.is_folder eq 'Y'}">
								<span>Group</span>
							</c:if>
							<c:if test="${menu.is_folder eq 'N'}">
								<span>Menu</span>
							</c:if>
						</div>
					</td>
				</tr>
				<tr>
					<!-- <th scope="row">Name</th> -->
						<th scope="row">이름</th>
					<td>
						<div class="input type_01">
							<input type="text" id="menu_name" name="menu_name" value="${menu.menu_name}"
								placeholder="<spring:message code="label.security.menu.menu_name.text"/>" />
						</div>
					</td>
				</tr>
				<tr>
					<!-- <th scope="row">Menu Path</th> -->
						<th scope="row">링크 Path</th>
					<td>
						<div class="input type_01">
							<input type="text" id="tmp_menu_path" name="tmp_menu_path" value="${menu.menu_path}"
								placeholder="<spring:message code="label.security.menu.link_path.text"/>" />
						</div>
					</td>
				</tr>
				<tr>
					<!-- <th scope="row">Description</th> -->
						<th scope="row">설명</th>
					<td>
						<div class="textarea type_01">
							<textarea id="description" name="description" placeholder="<spring:message code="label.security.menu.description.text"/>"
								rows="6">${menu.description}</textarea>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="btn_area type_01">
		<button type="button" class="btn type_01" id="btn_goDetail">취소</button>
		<button type="button" class="btn type_01 primary" id="btn_update">저장</button>
	</div>
</form:form>