<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>

<link href="/assets/libs/tablesaw/dist/tablesaw.css" rel="stylesheet"> <!-- ksh 07-30 -->
<script src="/assets/libs/tablesaw/dist/tablesaw.jquery.js"></script> <!-- ksh 07-30 -->
<script src="/assets/libs/tablesaw/dist/tablesaw-init.js"></script> <!-- ksh 07-30 -->

<c:set var="sorting" value="sorting" />
<c:choose>
	<c:when test='${searchVal.orderBy == "ASC"}'>
		<c:set var="sorting" value="sorting_asc" />
	</c:when>
	<c:when test='${searchVal.orderBy == "DESC"}'>
		<c:set var="sorting" value="sorting_desc" />
	</c:when>
	<c:otherwise>
		<c:set var="sorting" value="sorting" />
	</c:otherwise>
</c:choose>
<table id="setting_defaults" class="table table-hover table-striped table-bordered border nowrap display dataTable"  data-tablesaw-mode="columntoggle">  <!-- data-tablesaw-mode="columntoggle"  ksh 07-30 -->
	<thead>
		<tr>
			<th id="th_search_sid" class="${sorting} text-white" onClick="javascript:fnSearchOrderBy( 'search', 'sid' );">
				<span class="text-muted">사원번호</span>
			</th>
			<th style="color: white;">
				<span class="text-muted">이름</span>
			</th>
			<th style="color: white;">
				<span class="text-muted">생년월일</span>
			</th>
			<th data-tablesaw-priority="4" style="color: white;"> <!-- data-tablesaw-priority="4"  ksh 07-30 -->
				<span class="text-muted">권한</span>
			</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${!empty userManageList.lists}">
			<c:forEach items="${userManageList.lists}" var="list" varStatus="status">
				<tr onClick='javascript:goDetail("${list.userSno}", "${list.loginId}", "${list.partnerSno}");'>
					<td>
						<span class="text-muted" title="${list.loginId}">${list.loginId}</span>
					</td>
					<td>
						<span class="text-muted" title="${list.userFnm}">${list.userFnm}</span>
					</td>
					<td>
						<span class="text-muted" title="${list.levelTitle}">${list.brdyStr}</span>
					</td>
					<td>
						<span class="text-muted" title="${list.levelTitle}">${list.levelTitle}</span>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty userManageList.lists}">
			<tr>
				<td colspan="5" id="nodata" class="nodata">
					<span class="text-muted">
						<spring:message code="label.empty.list" />
					</span>
				</td>
			</tr>
		</c:if>
	</tbody>
</table>

<c:if test='${userManageList.totalCount > 0 }'>
	<div class="dataTables_wrapper">
		<!-- 페이징 start -->
		<shovvel:paging is_ajax="true" ajax_method="goSearch" ajax_url="" ajax_target="" active="${searchVal.page}" total_count="${userManageList.totalCount}" per_page="${userManageList.perPage}" per_size="${searchVal.perSize}" />
		<!-- 페이징 end -->
	</div>
</c:if>

<!-- <script src="/assets/extra-libs/datatables.net/js/jquery.dataTables.min.js"></script> -->
<!-- <script src="/dist/js/pages/datatable/datatable-advanced.init.js"></script> -->
<link href="/assets/extra-libs/datatables.net-bs4/css/dataTables.bootstrap4.css" rel="stylesheet">

<script type="text/javascript">
	$( "#userListCount" ).text( "${userManageList.totalCount}" );
</script>