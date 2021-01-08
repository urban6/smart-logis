<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel" %>

<script type="text/javascript" charset="utf-8" src="/scripts/js/paging.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/sortColumn.js"></script>
	<input type="hidden" id="navi2_nm" value="관리자 등록" />
	<input type="hidden" id="navi1_url_mod" value="./list" />

<script>
	$(document).ready(function() {
    	$("#navigationArea li").eq(0).find("a").text("관리자 관리");
    	$("#navigationArea li").eq(0).find("a").attr("href", "./list");
		
		$("#btn_search").click(function(){
			goSearch();
		});
		
		$("#btn_excel").click(function(){
 			fnExcel();
   		}); 
		
		$("#btn_add").click(function(){
 			goAdd();
   		});
		
		$('#search_partner_clcd').on('change', function(){
			var param = new Object();
			param.partner_clcd = $(this).val();
			
			$.ajax({
		        url : "/management/partnermng/partneruser/listPartner",
		        data : param,
	 	        type : 'POST',
	 	        dataType : 'json',
		        success : function(data) {
		           var list = data.partnerList;		           
		           var rtn = '';
		           		rtn += '<option value="">소속 전체</option>';
		           for(var i = 0;i<list.length;i++){
		           		rtn += '<option value="' + list[i].com_cd + '">' + list[i].cd_nm + '</option>';
		           }
		           $('#search_partner_sno').html(rtn);
					
		           if(list.length < 1){
						$('#search_partner_sno').attr('disabled', true);
				   }else{
			           $('#search_partner_sno').attr('disabled', false);
				   }
		        },
		        error : function(e){
		            openAlertModal("",callErrorMsg);
		        },
		        complete : function() {}
			});
		});
		
		init();
		goSearch();
	});    

	function init(){
		$('#search_partner_clcd').val("${partnerAdminDomain.search_partner_clcd}");
		$('#search_partner_clcd').trigger('change');
	}
	
	function goSearch(){
		$("#page").val("1");
		
		var param = new Object();
		param = $("#myForm").serialize();
		
		$.ajax({
	        url : "listAction",
	        data : param,
 	        type : 'POST',
	        success : function(data) {
	           $("#listTable").html(data);
	        },
	        error : function(e){
	            openAlertModal("",callErrorMsg);
	        },
	        complete : function() {
	        	
	        }
		});
	}
	
	function goAdd(){
		$("#myForm").attr("action","/management/partnermng/partneradmin/add");
		$("#myForm").submit();
	}
	
	function goDetail(seq){
		$("#user_sno").val(seq);
		$("#myForm").attr("action", "/management/partnermng/partneradmin/modify");
		$("#myForm").submit();
	}
	
	//exportAction
	function fnExcel(){
		if($("#nodata").hasClass("nodata") === true) {
			openAlertModal("","<spring:message code="msg.common.excel.download.alarm" />");
			return;
		}
   
		var param = new Object();
		param = $("#myForm").serialize();	
		
		$.download('exportAction.xls', param, 'post');
	}

</script>
<section id="content" class="w1200">
	<article class="admin_conf_list">
		<div class="form_table pr122">
			<form id="myForm" name="myForm" method="POST" action="javascript:goSearch();">
				<input type="hidden" id="user_sno" name="user_sno" value="" />
	
				<legend>검색 조건 정보 입력</legend>
				<fieldset>
					<table>
						<colgroup>
							<col style="width:15%">
							<col style="width:35%">
							<col style="width:15%">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th>소속</th>
								<td>
									<select class="inp_select whalf" id="search_partner_clcd" name="search_partner_clcd">
										<option value="">전체</option>
										<c:forEach items="${partnerClcdList}" var="cmb" varStatus="status">
										<c:if test="${cmb.com_cd ne '50201010'}">
											<option value="${cmb.com_cd}">${cmb.cd_nm}</option>
										</c:if>
										</c:forEach>
									</select>
									<select class="inp_select whalf" id="search_partner_sno" name="search_partner_sno">
										<option value="">소속 전체</option>
									</select>
								</td>
								<th>관리자 정보</th>
								<td>
									<select class="inp_select w120" id="search_type" name="search_type">
										<option value="login_id" ${partnerAdminDomain.search_type eq 'login_id' ? 'selected="selected"' : ''}>아이디</option>
										<option value="user_fnm" ${partnerAdminDomain.search_type eq 'user_fnm' ? 'selected="selected"' : ''}>이름</option>
									</select>
									<input type="text" class="inp_txt w200" id="search_text" name="search_text" value="${partnerAdminDomain.search_text}">
								</td>
							</tr>
						</tbody>
					</table>
					<a href="#" class="btn_search line1" id="btn_search">검색</a>
				</fieldset>
			</form>
		</div>
		<div id="listTable"></div>
		<div class="btnPosition btnRight">
			<shovvel:auth auth="${authType}">
			<a href="javascript://" class="btn_black" id="btn_add"><em>등록</em></a>
			</shovvel:auth>
		</div>
	</article>
</section>
