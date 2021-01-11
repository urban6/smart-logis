<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel" %>
<script type="text/javascript" charset="utf-8" src="/scripts/ui_common.js"></script>
<script type="text/javascript">

    //Ajax로 첫 화면의 데이터 호출
    $(document).ready(function() {
    	sortIinit();
    });

    //sortIinit function
    function sortIinit(){
    	sortClass($("#sortClass").val());
    }

    //페이지당 보여줄 갯수 선택
    function setPerPage(perPage) {
        $("#page").val("1");
        $("#perPage").val(perPage); //실제 setting.
        $("#selectPageSize").text(perPage + '<spring:message code="label.common.list.line.text"/>'); //화면에 Display.
        //console.log("listAction__setPerPage");
        goSearch();
    }

</script>
<%-- <shovvel:perPageControl totalCount="${loginHistList.totalCount}" perPage="${loginHistList.perPage}" page="${loginHistList.page}"><spring:message code="label.common.perpage.normal.text" /></shovvel:perPageControl> --%>
<div class="table_list pt50">
	<table>
		<colgroup>
			<col style="width: *">
			<col style="width: *">
			<col style="width: *">
			<col style="width: 14%">
			<col style="width: 14%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">사용자 ID</th>
				<th scope="col" class="sort" id="D.LEVEL_TITLE" onClick="listSort(this)">사용자 레벨</th>
				<th scope="col" class="sort" id="B.USER_FNM" onClick="listSort(this)">사용자 이름</th>
				<th scope="col" class="sort" id="A.LOGIN_DATE" onClick="listSort(this)">로그인 시간</th>
				<th scope="col" class="sort" id="A.LOGOUT_DATE" onClick="listSort(this)">로그아웃 시간</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${!empty loginHistList.lists}">
				<c:forEach items="${loginHistList.lists}" var="list" varStatus="status">
					<tr>
						<td><span title="${list.login_id}">${list.login_id}</span></td>
						<td><span title="${list.level_title}">${list.level_title}</span></td>
						<td><span title="${list.user_fnm}">${list.user_fnm}</span></td>
						<td>${list.login_date}</td>
						<td>${list.logout_date}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty loginHistList.lists}">
				<tr>
					<td class="nodata" id="nodata" colspan="5"
						style="text-align: center;"><spring:message
							code="label.empty.list" /></td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>
<div class="pagination">
	<!-- 페이징 start -->
	<shovvel:paging2 is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#loginHistTable" active="${loginHistList.page}"  total_count="${loginHistList.totalCount}" per_page="${loginHistList.perPage}" per_size="${loginHistList.perSize}"/>
	<!-- 페이징 end -->
</div>