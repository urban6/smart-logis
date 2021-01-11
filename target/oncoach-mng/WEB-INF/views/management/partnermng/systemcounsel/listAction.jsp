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
            <col>
            <col style="width: 150px;">
            <col style="width: 150px;">
            <col style="width: 150px;">
            <col style="width: 150px;">
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="tac">No</th>
                <c:if test="${sessionUser.partnerClcd eq '50201010'}">
                <th scope="col">소속</th>
                </c:if>
                <th scope="col">문의 제목</th>
                <th scope="col">문의 일시</th>
                <th scope="col">아이디</th>
                <th scope="col">이름</th>
                <th scope="col">답변상태</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${!empty systemCounselList.lists}">
                <c:forEach items="${systemCounselList.lists}" var="list" varStatus="status">
                          <tr>
                              <td>${systemCounselList.totalCount-((systemCounselList.page-1)*systemCounselList.perPage)-status.index}</td>
                              <c:if test="${sessionUser.partnerClcd eq '50201010'}">
                              <td>${list.partner_nm}</td>
                              </c:if>
                              <td class="text-left"><a href="javascript://" class="link" onclick="goDetail('${list.system_counsel_sno}' ,'${list.answer_yn}');">${list.counsel_title}</a></td>
                              <td>${list.counsel_date}</td>
                              <td>${list.login_id}</td>
                              <td>${list.user_nm}</td>
                            <c:if test="${list.answer_yn eq 'Y'}"><td>완료</td></c:if>
                            <c:if test="${list.answer_yn ne 'Y'}"><td class="text-red">미완료</td></c:if>
                         </tr>
                </c:forEach>
                  </c:if>
                <c:if test="${empty systemCounselList.lists}">
                <tr>
                    <c:if test="${sessionUser.partnerClcd eq '50201010'}">
                        <td colspan="7" class="nodata">내용이 없습니다</td>
                    </c:if>
                    <c:if test="${sessionUser.partnerClcd ne '50201010'}">
                        <td colspan="6" class="nodata">내용이 없습니다</td>
                    </c:if>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>
<div class="pagination">
    <!-- 페이징 start -->
    <shovvel:paging2 is_ajax="true" ajax_method="goPostPage" ajax_url="listAction.ajax" ajax_target="#listTable" active="${systemCounselList.page}"  total_count="${systemCounselList.totalCount}" per_page="${systemCounselList.perPage}" per_size="${systemCounselList.perSize}"/>
    <!-- 페이징 end -->    
</div>
    
    