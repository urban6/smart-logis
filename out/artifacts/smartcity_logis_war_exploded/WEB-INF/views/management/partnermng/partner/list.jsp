<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript" charset="utf-8" src="/scripts/js/paging.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/sortColumn.js"></script>

<script>
	
	$(document).ready(function() {
		$("#btn_search").click(function(){
			goSearch();
		});
		
		$("#btn_excel").click(function(){
 			fnExcel();
   		}); 
		
		$("#btn_add").click(function(){
			goAdd();	
   		});
		
		init();
		goSearch();
	});    

	function init(){
		
	}
	
	function goSearch(){
		$("#page").val("1");
		
		var param = new Object();
		param = $("#myForm").serialize();
		console.log(JSON.stringify(param));
		
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
		$("#myForm").attr("action","/management/partnermng/partner/add");
		$("#myForm").submit();
	}
	
	function goDetail(seq){
		$("#partner_sno").val(seq);
		$("#myForm").attr("action", "/management/partnermng/partner/modify");
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
<div class="path_area">
    <div class="path">
        <ul class="clearfix">
            <li><a href="#" class="back">제휴사 관리</a></li>
            <li class="last-child"><span class="this">파트너사 관리</span></li>
        </ul>
    </div>
</div>
<!-- section : start -->
<section id="content" class="w1200">
    <article class="admin_conf_list">
        <!-- form_table : start -->
        <div class="form_table pr122">
            <form id="myForm" name="myForm" method="POST">
			<input type="hidden" id="partner_sno" name="partner_sno" value="" />

                <legend>검색 조건 정보 입력</legend>
                <fieldset>
                    <table>
                        <colgroup>
                            <col style="width:12%">
                            <col style="width:35%">
                            <col style="width:12%">
                            <col style="width:43%">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th>구분</th>
                            <td>
                                <select class="inp_select whalf" id="search_partner_clcd" name="search_partner_clcd">
                                    <option value="">전체</option>
                                    <c:forEach items="${partnerClcdList}" var="cmb" varStatus="status">
                                        <c:if test="${cmb.com_cd ne '50201010'}">
                                        <option value="${cmb.com_cd}" ${partnerDomain.search_partner_clcd eq cmb.com_cd ? 'selected="selected"' : ''}>${cmb.cd_nm}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </td>
                            <th>파트너사</th>
                            <td>
                                <input type="text" class="inp_txt w250"  id="search_partner_nm" name="search_partner_nm" value="${partnerDomain.search_partner_nm}"/>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <a href="#" class="btn_search line1" id="btn_search">검색</a>
                </fieldset>
            </form>
        </div>
        <!-- form_table : end -->
        <div id="listTable"></div>
        
        <div class="btnPosition btnRight">
            <shovvel:auth auth="${authType}">
            <a href="#" class="btn_black" id="btn_add"><em>등록</em></a>
            </shovvel:auth>
        </div>
    </article>
</section>
<!-- section : end -->