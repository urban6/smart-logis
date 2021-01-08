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

<!-- table_list : start -->
<div class="table_list pt20">
    <table>
        <colgroup>
            <col style="width: 70px;">
            <col style="width: 200px;">
            <col>
            <col style="width: 200px;">
            <col style="width: 200px;">
        </colgroup>
        <thead>
        <tr>
            <th>No.</th>
            <th>구분</th>
            <th>파트너사</th>
            <th>계약체결 일자</th>
            <th>계약해지 일자</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${!empty partnerList.lists}">
            <c:forEach items="${partnerList.lists}" var="list" varStatus="status">
            <tr>
                <td>${partnerList.totalCount-((partnerList.page-1)*partnerList.perPage)-status.index}</td>
                <td>${list.partner_clnm}</td>
                <td class="text-left"><a href="javascript://" class="link" onclick="goDetail('${list.partner_sno}');">${list.partner_nm}</a></td>
                <td>${list.partner_contract_ins_dd}</td>
                <td>${list.partner_contract_end_dd}</td>
            </tr>
        </c:forEach>
        </c:if>
        <c:if test="${empty partnerList.lists}">
        <tr>
            <td id="nodata" colspan="5" class="nodata">내용이 없습니다</td>
        </tr>
        </c:if>
        </tbody>
    </table>
</div>
<!-- table_list : end -->
<div class="pagination">
<!-- 페이징 start -->
<shovvel:paging2 is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#listTable" active="${partnerList.page}"  total_count="${partnerList.totalCount}" per_page="${partnerList.perPage}" per_size="${partnerList.perSize}"/>
<!-- 페이징 end -->   
</div>
	