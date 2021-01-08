<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel" %>

<script>
	$(document).ready(function(){
		if($("#nodata").hasClass("nodata") === true) {
			openAlertModal("${titleName }","검색 결과가 없습니다.");
			return;
		}
	});
	
	function setPerPage(perPage) {
	    $("#page").val("1");
	    $("#perPage").val(perPage); //실제 setting.
	    $("#selectPageSize").text(perPage + '<spring:message code="label.common.list.line.text"/>'); //화면에 Display.
	
	    goSearch();
	}
	
</script>

<!-- board-top -->
<%-- <shovvel:perPageControl totalCount="${partnerAdminList.totalCount}" perPage="${partnerAdminList.perPage}" page="${partnerAdminList.page}" excel="Y"><spring:message code="label.common.perpage.normal.text" /></shovvel:perPageControl> --%>		
<!-- //board-top -->

<div class="table_list pt20">
	<table>
		<colgroup>
				<col style="width: 70px;">
				<col style="width: 200px;">
				<col style="width: 200px;">
				<col>
				<col style="width: 200px;">
				<col style="width: 200px;">
				<col style="width: 200px;">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">No.</th>
				<th scope="col">소속</th>
				<th scope="col">권한</th>
				<th scope="col">아이디</th>
				<th scope="col">이름</th>
				<th scope="col">휴대폰 번호</th>
				<th scope="col">등록일자</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${!empty partnerAdminList.lists}">
				<c:forEach items="${partnerAdminList.lists}" var="list" varStatus="status">
  						<tr>
  							<td>${partnerAdminList.totalCount-((partnerAdminList.page-1)*partnerAdminList.perPage)-status.index}</td>
  							<td>${list.partner_nm}</td>
  							<td>${list.level_title}</td>
							<td class="text-left"><a href="javascript://" class="link" onclick="goDetail('${list.user_sno}');">${list.login_id}</a></td>
							<td class="text-left">${list.user_fnm}</td>
							<td id="userSno_${list.user_sno}"><script>changePhoneFormat('userSno_${list.user_sno}', '${list.user_hp_no}')</script></td>
							<td>${list.ins_dt }</td>
                 		</tr>
				</c:forEach>
  				</c:if>
    			<c:if test="${empty partnerAdminList.lists}">
				<tr>
					<td id="nodata" colspan="7" class="nodata">내용이 없습니다</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>
<div class="pagination">
	<!-- 페이징 start -->
	<shovvel:paging2 is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#listTable" active="${partnerAdminList.page}"  total_count="${partnerAdminList.totalCount}" per_page="${partnerAdminList.perPage}" per_size="${partnerAdminList.perSize}"/>
	<!-- 페이징 end -->    
</div>
	