<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>

<script src="/assets/extra-libs/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="/dist/js/pages/datatable/datatable-advanced.init.js"></script>
<link href="/assets/extra-libs/datatables.net-bs4/css/dataTables.bootstrap4.css" rel="stylesheet">

<table class="table table-bordered table-hover table-striped nowrap display" table id="setting_defaults">
	<thead>
		<tr>
			<th class="sorting_asc text-white" aria-controls="setting_defaults" aria-sort="ascending">
				<span class="text-muted">No.</span>
			</th>
			<th class="sorting_asc text-white" aria-controls="setting_defaults" aria-sort="ascending">
				<span class="text-muted">등급</span>
			</th>
			<th>
				<span class="text-muted">설명</span>
			</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${!empty userTotList.lists}">
			<c:forEach items="${userTotList.lists}" var="list" varStatus="idx">
				<tr onClick='javascript:goDetail("${list.levelId}");'>
					<td style="text-align:right;padding-right:2%;">
						<span class="text-muted" title="${list.levelId}">${list.levelId}</span>
					</td>
					<td>
						<span class="text-muted" title="${list.leveltitle}">${list.leveltitle}</span>
					</td>
					<td>
						<span class="text-muted" title="${list.description}">${list.description}</span>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty userTotList}">
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

<c:if test="${!empty userTotList}">

	<div class="dataTables_wrapper">
		<!-- 페이징 start -->
		<shovvel:paging is_ajax="true" ajax_method="goSearch" ajax_url="" ajax_target="" active="${searchVal.page}" total_count="${userLevelList.totalCount}" per_page="${userLevelList.perPage}" per_size="${searchVal.perSize}" />
		<!-- 페이징 end -->
	</div>
	
</c:if>

<script>
	// css 수정
	$( document ).ready( function() {     
	      $("#setting_defaults_wrapper").removeClass('container-fluid');
	});
</script>

