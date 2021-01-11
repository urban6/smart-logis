<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>

<link href="/assets/libs/tablesaw/dist/tablesaw.css" rel="stylesheet"> <!-- ksh 07-30  -->
<script src="/assets/libs/tablesaw/dist/tablesaw.jquery.js"></script> <!-- ksh 07-30  -->
<script src="/assets/libs/tablesaw/dist/tablesaw-init.js"></script> <!-- ksh 07-30  -->
<table id="verAppTable" class="table table-striped table-hover border dataTable table-bordered display" role="grid"  data-tablesaw-mode="columntoggle"> <!--  data-tablesaw-mode="columntoggle ksh 07-30  -->
	<thead>
		<tr>
			<th style="width: 10%"><!--  style="width: 10%" ksh 07-31 -->
				<span class="text-muted">버전</span>
			</th>
			<th style="width: 15%"><!--  style="width: 15%" ksh 07-31 -->
				<span class="text-muted">등록일</span>
			</th>
			<th style="width: 25%" data-tablesaw-priority="4" > <!-- style="width: 25%" ksh 07-31  -->
				<span class="text-muted">파일명</span>
			</th>
			<th style="width: 50%"><!--  style="width: 50%" ksh 07-31 -->
				<span class="text-muted">설 명</span>
			</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="item" items="${verAppList.lists}" varStatus="idx">
			<tr onClick="javascript:fnInfo( '${item.verAppNum}', '${item.verAppNo}', '${item.verAppType}', '${item.verAppStr}' );">
				<td style="text-align: right; padding-right: 1%;">
					<span class="text-muted">${item.verAppStr} </span>
				</td>
				<td style="text-align: center;">
					<span class="text-muted">${item.verAppRegDt} </span>
				</td>
				<%-- 				<td onClick="javascript:event.cancelBubble =true;fnDownloadApkFile('/app/version/${item.verAppType}/${item.verAppFileSize}/${item.verAppNo}/${item.verAppNum}/apkDownload/${item.verAppStr}/${item.verAppFileNm}');"> --%>
				<%-- 					<span class="text-muted"> ${item.verAppFileNm} </span> --%>
				<!-- 				</td> -->
				<td>
					<span class="text-muted" style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 90%;word-wrap: normal;display: inline-block;">${item.verAppFileNm}</span> <!-- style 모두 추가해주세요 ksh 0731-->
				</td>
				<td>
					<span class="text-muted">${item.verAppCnte}</span>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<c:if test="${verAppList.totalCount > verAppList.perPage} }">
	<div class="dataTables_wrapper">
		<!-- 페이징 start -->
		<shovvel:paging is_ajax="true" ajax_method="goSearch" ajax_url="" ajax_target="" active="${verAppList.page}" total_count="${verAppList.totalCount}" per_page="${verAppList.perPage}" per_size="${verAppList.perSize}" />
		<!-- 페이징 end -->
	</div>
</c:if>