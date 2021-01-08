<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel" %>

<script>
	$(document).ready(function(){
			
	});
	
	function setPerPage(perPage) {
	    $("#page").val("1");
	    $("#perPage").val(perPage); //실제 setting.
	    $("#selectPageSize").text(perPage + '<spring:message code="label.common.list.line.text"/>'); //화면에 Display.
	
	    goSearch();
	}
	
</script>

<!-- board-top -->
<%-- <shovvel:perPageControl totalCount="${partnerUserList.totalCount}" perPage="${partnerUserList.perPage}" page="${partnerUserList.page}" excel="Y"><spring:message code="label.common.perpage.normal.text" /></shovvel:perPageControl> --%>		
<!-- //board-top -->

<div class="table_list pt20">
	<table>
		<colgroup>
				<col style="width: 70px;">
				<c:if test="${sessionUser.partnerClcd eq '50201010'}">
				<col style="width: 200px;">
				</c:if>
				<col style="width: 200px;">
				<col>
				<col style="width: 200px;">
				<col style="width: 200px;">
				<col style="width: 200px;">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">No.</th>
				<c:if test="${sessionUser.partnerClcd eq '50201010'}">
				<th scope="col">소속</th>
				</c:if>
				<th scope="col">권한</th>
				<th scope="col">아이디</th>
				<th scope="col">이름</th>
				<th scope="col">휴대폰 번호</th>
				<th scope="col">등록일자</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${!empty partnerUserList.lists}">
				<c:forEach items="${partnerUserList.lists}" var="list" varStatus="status">
  						<tr>
  							<td>${partnerUserList.totalCount-((partnerUserList.page-1)*partnerUserList.perPage)-status.index}</td>
  							<c:if test="${sessionUser.partnerClcd eq '50201010'}">
  							<td>${list.partner_nm}</td>
  							</c:if>
  							<td>${list.level_title}</td>
							<td class="text-left"><a href="javascript://" class="link" onclick="goDetail('${list.user_sno}');">${list.login_id}</a></td>
							<td class="text-left">${list.user_fnm}</td>
							<td id="userSno_${list.user_sno}"><script>changePhoneFormat('userSno_${list.user_sno}', '${list.user_hp_no}')</script></td>
							<td>${list.ins_dt }</td>
                 		</tr>
				</c:forEach>
  				</c:if>
    			<c:if test="${empty partnerUserList.lists}">
				<tr>
					<c:if test="${sessionUser.partnerClcd eq '50201010'}">
					<td id="nodata" colspan="7" class="nodata">내용이 없습니다</td>
					</c:if>
					<c:if test="${sessionUser.partnerClcd ne '50201010'}">
					<td id="nodata" colspan="6" class="nodata">내용이 없습니다</td>
					</c:if>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>
<div class="pagination">
	<!-- 페이징 start -->
	<shovvel:paging2 is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#listTable" active="${partnerUserList.page}"  total_count="${partnerUserList.totalCount}" per_page="${partnerUserList.perPage}" per_size="${partnerUserList.perSize}"/>
	<!-- 페이징 end -->    
</div>
	