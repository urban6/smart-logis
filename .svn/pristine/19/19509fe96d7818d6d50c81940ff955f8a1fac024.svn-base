<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel" %>

<script type="text/javascript" charset="utf-8" src="/scripts/js/paging.js"></script>
<script type="text/javascript">
//Ajax로 첫 화면의 데이터 호출
//화면 먼저 보이고 데이터를 불러야 사용자가 덜 답답해 함
$(document).ready(function(){
	activateNode();
 	
	$("#selectPerPage").on("change",function(){
		setPerPage($("#selectPerPage").val());
	});
	
	
	$("#btn_add").click(function() {
		
		var sel_upper_com_cd = '${upper_com_cd}';	// 왼쪽트리에서 선택한 그룹코드
		console.log("sel_upper_com_cd="+sel_upper_com_cd);
		
		if(sel_upper_com_cd == "" || sel_upper_com_cd == "00000000"){
			//alert("코드를 입력할 그룹을 선택하세요.");
			openAlertModal("Warning", "코드를 입력할 그룹을 선택하세요");
			return;
		}else{
			openModal('#popup_01');
		}		
	});
});

function setPerPage(perPage) {
    $("#page").val("1"); 
    $("#perPage").val(perPage); //실제 setting.
    $("#selectPageSize").text(perPage + '<spring:message code="label.common.list.line.text"/>'); //화면에 Display.
    
    goSearch();
}

function goSearch(){
	// console.log("goSearch=================")
	var node = $("#dynatree").dynatree("getActiveNode");
    //console.log(node);
    getViewCommonCodeDetail(node);
}

function activateNode() {
	$('#dynatree').dynatree("getTree").activateKey('${key}');
}

function goPostPage(target,url,page,perPage,perSize,key) {
	//console.log("goPostPage="+key);
	var upper_com_cd = '${upper_com_cd}';
	var com_cd  = '${com_cd}';
	//console.log("upper_com_cd="+upper_com_cd+", com_cd="+com_cd);
		
	var param = '';
	
	param+="page="+page;
	
	if(perPage!=null) param+="&perPage="+perPage;
	
	if(perSize!=null) param+="&perSize="+perSize;
	
	if(key!=null) param+="&key="+key;
	
	if(upper_com_cd == '999999'){
		param+="&upper_com_cd="+com_cd;
	}else{
		param+="&upper_com_cd="+upper_com_cd;
	}
	
	var myparam = $("#myForm").serialize();
	
	param+="&"+myparam;
	$.post(url, param, function(data) {
		$(target).html(data);
	});
}

//사용하지 않음 .. 추후 팝업 조건이 변경 된 경우 적용 가능성있음
function goDelete(key) {
	var node = $('#dynatree').dynatree("getActiveNode");
	
	if(!node) {
		//openAlertModal("NOTIFICATION",'<spring:message code="msg.need.select.menu.text"/>');
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
					openAlertModal("Warning",data.resultMsg);
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

function fnSave(){
	if($("#com_cd").val() == "") {
		openAlertModal("Warning", "코드를 입력해 주세요.");
		$("#com_cd").focus();
		return;
	}
	if($("#cd_nm").val() == "") {
		openAlertModal("Warning", "코드 이름을 입력해 주세요.");
		$("#cd_nm").focus();
		return;
	}
	
	//var param = $("#commoncode").serialize();
	var param = new Object();
	param.upper_com_cd = $("#upper_com_cd").val();
	param.com_cd  = $("#com_cd").val();
	param.cd_nm   = $("#cd_nm").val();
	param.cd_desc = $("#cd_desc").val();
	
	$.ajax({
        url : "/management/operation/commoncode/insertAction.ajax",
        data : param,
        type : 'POST',
        dataType : 'json',
        async: false,
        success : function(data) {
        	var returnObj = data.result;
        	if(returnObj.result =="OK") {			
				openAlertModal("SUCCESS", "입력한 정보가 저장되었습니다.");
				$("#commoncode").submit();				
			}else{
				openAlertModal("Warning", returnObj.message);
			}
        },
        error: function(e){
        	openAlertModal("",callErrorMsg);
        },
        complete : function() {

        }
	});
}

function goDetail(index){
	//console.log("index="+index);
		
  	var list_upper_com_cd = $("input[name = list_upper_com_cd]:eq(" + index + ")").val();
  	var list_upper_cd_nm = $("input[name = list_upper_cd_nm]:eq(" + index + ")").val();
  	var list_com_cd = $("input[name = list_com_cd]:eq(" + index + ")").val();
  	var list_cd_nm = $("input[name = list_cd_nm]:eq(" + index + ")").val();
  	var list_cd_desc = $("input[name = list_cd_desc]:eq(" + index + ")").val();
	
	$("#span_detail_group_code").text(list_upper_cd_nm);
	$("#span_detail_com_cd").text(list_com_cd);
	
	$("#detail_group_code").val(list_upper_com_cd);
	$("#detail_com_cd").val(list_com_cd);	
	$("#detail_cd_nm").val(list_cd_nm);
	$("#detail_cd_desc").val(list_cd_desc);
	
	openModal('#popup_02');
}

function fnDelete(){
	var param = new Object();
	
	param.com_cd  = $("#detail_com_cd").val();
	
	$.ajax({
        url : "/management/operation/commoncode/deleteAction.ajax",
        data : param,
        type : 'POST',
        dataType : 'json',
        async: false,
        success : function(data) {
        	var returnObj = data.result;
        	if(returnObj.result =="OK") {			
        		openAlertModal("SUCCESS", "관련 정보가 삭제되었습니다.");
				$("#commoncode").submit();				
			}else{
				openAlertModal("Warning", returnObj.message);
			}
        },
        error: function(e){
        	openAlertModal("",callErrorMsg);
        },
        complete : function() {

        }
	});
}

function fnUpdate() {
	var node = $('#dynatree').dynatree("getActiveNode");
	
	if($("#detail_cd_nm").val() == "") {
		alert("Please enter code name");
		$("#detail_cd_nm").focus();
		
		return;
	}
		
	//openConfirmModal("NOTIFICATION",'<spring:message code="msg.common.save" />',function(){	
		var param = new Object();
		
		param.upper_com_cd = $("#detail_group_code").val();
		param.com_cd  = $("#detail_com_cd").val();
		param.cd_nm   = $("#detail_cd_nm").val();
		param.cd_desc = $("#detail_cd_desc").val();
		
		$.ajax({
	        url : "/management/operation/commoncode/updateAction.ajax",
	        data : param,
	        type : 'POST',
	        dataType : 'json',
	        async: false,
	        success : function(data) {
	        	var returnObj = data.result;
	        	if(returnObj.result =="OK") {			
	        		openAlertModal("SUCCESS", "변경사항이 저장되었습니다.");
					$("#commoncode").submit();				
				}else{
					openAlertModal("Warning", returnObj.message);
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

<form:form name="commoncode" commandName="commoncode" method="post" action="/management/operation/commoncode/index">
	<input type="hidden" id="key" name="key" value="${key}"/>
	<input type="hidden" id="upper_com_cd" name="upper_com_cd" value="${upper_com_cd}"/>
	<input type="hidden" id="upper_cd_nm" name="upper_cd_nm" value="${upper_cd_nm}"/>
	<div class="result type_02">
		<div class="left_cont">
	       <!-- <h2>Code List</h2> -->
	       <h2>코드 목록</h2>
     	</div>
	</div>
          	
	<div class="table type_01 link y_scroll">
		<div class="thead">
			<table>
               <colgroup>
                 <col style="width:50px;">
                 <col style="width:21%;">
                 <col style="width:13%;">
                 <col width="*">
                 <col width="*">
               </colgroup>
               <thead>
               <!-- 
                 <tr>
                   <th scope="col" class="tac">No</th>
                   <th scope="col">Group Code</th>
                   <th scope="col">Code</th>
                   <th scope="col">Code Name</th>
                   <th scope="col">cd_desc</th>
                 </tr>
                 -->
                <tr>
                   <th scope="col" class="tac">No</th>
                   <th scope="col">그룹 이름</th>
                   <th scope="col">코드</th>
                   <th scope="col">코드 이름</th>
                   <th scope="col">설명</th>
                 </tr>
               </thead>
			</table>
		</div>
		<div class="tbody code">
              <table>
                <colgroup>
                  <col style="width:50px;">
                  <col style="width:21%;">
                  <col style="width:13%;">
                  <col width="*">
                  <col width="*">
                </colgroup>
                <tbody>
                	<c:forEach items="${detailCodeList.lists}" var="code" varStatus="status">
				  		<tr onClick='javascript:goDetail("${status.index}");'>
				  		  <!--<td class="tac">${((detailCodeList.page-1)*detailCodeList.perPage)+status.count}</td>-->			
				  		  <td class="tac">${detailCodeList.totalCount-((detailCodeList.page-1)*detailCodeList.perPage)-status.index}</td>
					      <td>${code.upper_cd_nm}</td>
					      <td>${code.com_cd}</td>
					      <td>${code.cd_nm}</td>
					      <td class="tooltip">${code.cd_desc}</td>
				  		</tr>
				  		<input type="hidden" id="list_upper_com_cd" name="list_upper_com_cd" value="${code.upper_com_cd}"/>
				  		<input type="hidden" id="list_upper_cd_nm" name="list_upper_cd_nm" value="${code.upper_cd_nm}"/>
				  		<input type="hidden" id="list_com_cd" name="list_com_cd" value="${code.com_cd}"/>
				  		<input type="hidden" id="list_cd_nm" name="list_cd_nm" value="${code.cd_nm}"/>
				  		<input type="hidden" id="list_cd_desc" name="list_cd_desc" value="${code.cd_desc}"/>
				  	</c:forEach>
                </tbody>
              </table>
		</div>
	</div>
		
	  
	
	<div class="cont_footer type_01">
	  <!-- 페이징 start -->
	  <shovvel:paging is_ajax="true" ajax_method="goPostPage" ajax_url="detailListCommonCodeAction.ajax" ajax_target="#commoncodeAttribute" active="${detailCodeList.page}"  total_count="${detailCodeList.totalCount}" per_page="${detailCodeList.perPage}" per_size="${detailCodeList.perSize}"/>
	  <!-- 페이징 end -->
	  <div class="btn_area">
	    <!-- <button type="button" class="btn type_01">Delete</button> -->
	    <shovvel:auth auth="${authType}">
	    <button type="button" class="btn type_01 primary" id="btn_add">추가</button>
	    </shovvel:auth>
	  </div>
	</div>
	
  <section id="popup_01" class="popup m">
    <div class="pop_wrap">
      <div class="pop_head">
        <h1>공통 코드 등록</h1>
        <button class="btn close" onclick="closeModal(this)" type="button"></button>
      </div>
      <div class="pop_cont board">
        <div class="table type_01 detail">
            <table>
              <colgroup>
              	<col style="width:30%">
              	<col width="*">
              </colgroup>
              <tbody>
                <tr>
                  <!-- <th scope="row">Group Code</th> -->
                  <th scope="row">그룹 이름</th>
                  <td>${upper_cd_nm}</td>
                </tr>
                <tr>
                  <!-- <th scope="row">Code</th> -->
                  <th scope="row"><em>코드</em></th>
                  	<td>
                  		<div class="input type_01">
                  			<input type="text" id="com_cd" name="com_cd" value="" />
                  		</div>
                  	</td>
                </tr>
                <tr>
                  <!-- <th scope="row"><em>Code Name</em></th> -->
                  <th scope="row"><em>코드 이름</em></th>
                  <td>
                    <div class="input type_01">
                      <input type="text" id="cd_nm" name="cd_nm" value="" placeholder="Code Name">
                    </div>
                  </td>
                </tr>
                <tr>
                  <!-- <th scope="row" class="imp">cd_desc</th> -->
                  <th scope="row" class="imp">설명</th>
                  <td>
                    <div class="textarea type_01"><textarea name="cd_desc" id="cd_desc" cols="30" rows="3"></textarea></div>
                  </td>
                </tr>
              </tbody>
            </table>
        </div>
        <div class="btn_area">
          <button type="button" class="btn type_01" onclick="closeModal(this)">취소</button>
          <button type="button" class="btn type_01 primary" onclick="fnSave()">저장</button>
        </div>
      </div>
    </div> <!--// .pop_wrap -->
  </section>
  
  <section id="popup_02" class="popup m">
    <div class="pop_wrap">
      <div class="pop_head">
        <h1>공통 코드 수정</h1>
        <button class="btn close" onclick="closeModal(this)" type="button"></button>
      </div>
      <div class="pop_cont board">
          <div class="table type_01 detail">
            <table>
              <colgroup>
                <col style="width:150px">
                <col style="width:*">
              </colgroup>
              <tbody>
                <tr>
                  <!-- <th scope="row">Group Code</th> -->
                  <th scope="row">그룹 코드</th>
                  <td>
                  	<span id="span_detail_group_code"></span>
                  	<input type="hidden" id="detail_group_code" name="detail_group_code" value=""/>
                  </td>                  
                </tr>
                <tr>
                  <!-- <th scope="row">Code</th> -->
                  <th scope="row">코드</th>
                  <td>
                  	<span id="span_detail_com_cd"></span>
                  	<input type="hidden" id="detail_com_cd" name="detail_com_cd" value=""/>
                  </td>
                </tr>
                <tr>
                  <!-- <th scope="row"><em>Code Name</em></th> -->
                  <th scope="row"><em>코드 이름</em></th>
                  <td>
                    <div class="input type_01">
                      <input type="text" id="detail_cd_nm" name="detail_cd_nm" value="" placeholder="Code Name">
                    </div>
                  </td>
                </tr>
                <tr>
                  <!-- <th scope="row" class="imp">cd_desc</th> -->
                  <th scope="row" class="imp">설명</th>
                  <td>
                    <div class="textarea type_01"><textarea name="detail_cd_desc" id="detail_cd_desc" cols="30" rows="3"></textarea></div>
                  </td>
                </tr>
              </tbody>
            </table>
        </div>
        <div class="btn_area">
          <button type="button" class="btn type_01" onclick="closeModal(this)">취소</button>
          <shovvel:auth auth="${authType}">
          <button type="button" class="btn type_01" onclick="fnDelete()">삭제</button>
          <button type="button" class="btn type_01 primary" onclick="fnUpdate()">저장</button>
          </shovvel:auth>
        </div>
      </div>
    </div> <!--// .pop_wrap -->
  </section>
</form:form>