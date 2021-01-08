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
          
        $("#btn_add").click(function(){
             goAdd();
           });
        
        $('#search_partner_clcd').on('change', function(){
            console.log("Debug", $(this).val());            
            var param = "partner_clcd=" + $(this).val();    
            var selectValue = $(this).val();
            
            if(selectValue == ""){
                $("#search_partner_sno").find("option:eq(0)").prop("selected", true);
                $('#search_partner_sno').attr( 'disabled', true );
            }
            else{
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
                           if(list[i].com_cd == '${systemCounselDomain.search_partner_sno}' ){
                                rtn += '<option value="' + list[i].com_cd + '" selected>' + list[i].cd_nm + '</option>';
                           }else{
                               rtn += '<option value="' + list[i].com_cd + '">' + list[i].cd_nm + '</option>';
                           }
                       }
                       $('#search_partner_sno').html(rtn);
                       $('#search_partner_sno').removeAttr('disabled');
                    },
                    error : function(e){
                        openAlertModal("",callErrorMsg);
                    },
                    complete : function() {}
                });
            }
        });
        
          init();
        goSearch();
    });
    
    function init(){
    }
     
    function goSearch(){
        
        $("#page").val("1");
        fnValidation();
        
        var param = new Object();
        param = $("#myForm").serialize();
         
        $.ajax({
            url :  "listAction",
            data : param,
            type : 'POST',            
            success : function(data) {
               $("#listTable").html(data);
            },
            error: function(e){
                openAlertModal("",callErrorMsg);
            },
            complete : function() {
                
            }
        }); 
    }
    
    function goAdd(){
        $("#myForm").attr("action","add");
        $("#myForm").submit();
    }
    
    function goDetail( system_counsel_sno, answer_yn ){
        if(answer_yn == "N"){
            $("#system_counsel_sno").val(system_counsel_sno);
            $("#myForm").attr("action","modify");
            $("#myForm").submit();
        }else{
            $("#system_counsel_sno").val(system_counsel_sno);
            $("#myForm").attr("action","detail");
            $("#myForm").submit();
        }
    }
    
       function fnValidation(){
    }
    
</script>
<div class="path_area">
    <div class="path">
        <ul class="clearfix">
            <li><a href="javascript://" class="back">운영자 관리</a></li>
            <li class="last-child"><span class="this">시스템 문의 등록</span></li>
        </ul>
    </div>
</div>
<section id="content" class="w1200">
    <article class="admin_conf_list">
        <div class="form_table pr122">
            <form id="myForm" name="myForm" method="POST">
                <input type="hidden" id="orderBy" name="orderBy" value="" /> 
                <input type="hidden" id="sortClass" name="sortClass" value="" /> 
                <input type="hidden" id="system_counsel_sno" name="system_counsel_sno"> 
                <input type="hidden" id="titleName" name="titleName" value="${titleName}" />
                
                <c:if test="${sessionUser.partnerClcd ne '50201010'}">
                    <input type="hidden" id="search_partner_clcd" name="search_partner_clcd" value="${sessionUser.partnerClcd}"> 
                    <input type="hidden" id="search_partner_sno" name="search_partner_sno" value="${sessionUser.partnerSno}"> 
                </c:if>
        
                <legend>검색 조건 정보 입력</legend>
                <fieldset>
                    <table>
                        <colgroup>
                            <c:if test="${sessionUser.partnerClcd eq '50201010'}">
                            <col style="width:15%">
                            <col style="width:35%">
                            </c:if>
                            <col style="width:15%">
                            <col>
                        </colgroup>    
                        <tbody>
                            <tr>
                                <c:if test="${sessionUser.partnerClcd eq '50201010'}">
                                <th>소속</th>
                                <td>
                                    <select class="inp_select whalf" id="search_partner_clcd" name="search_partner_clcd">
                                        <option value="">전체</option>
                                        <c:forEach items="${partnerClcdList}" var="partnerClcd" varStatus="status">
                                        <c:if test="${partnerClcd.com_cd ne '50201010'}">
                                            <option value="${partnerClcd.com_cd}" <c:if test="${systemCounselDomain.search_partner_clcd eq  'N' }"> selected</c:if>>${partnerClcd.cd_nm}</option>
                                        </c:if>
                                        </c:forEach>
                                    </select>    
                                    <select class="inp_select whalf" id="search_partner_sno" name="search_partner_sno" disabled="disabled">
                                        <option value="">소속 전체</option>
                                    </select>
                                </td>
                                </c:if>
                                <th>답변상태</th>
                                <td>
                                  <span class="rdobox">
                                    <input type="radio" name="search_answer_yn" id="search_answer_yn_all" value="" checked="">
                                    <label for="search_answer_yn_all">전체</label>
                                  </span>
                                  <span class="rdobox">
                                    <input type="radio" name="search_answer_yn" id="search_answer_yn_n" value="N" <c:if test="${systemCounselDomain.search_answer_yn eq  'N' }">checked</c:if>>
                                    <label for="search_answer_yn_n">미완료</label>
                                  </span>
                                  <span class="rdobox">
                                    <input type="radio" name="search_answer_yn" id="search_answer_yn_y" value="Y" <c:if test="${systemCounselDomain.search_answer_yn eq  'Y' }">checked</c:if>>
                                    <label for="search_answer_yn_y">완료</label>
                                  </span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <a href="javascript://"  class="btn_search line1" id="btn_search">검색</a>
                </fieldset>
            </form>
        </div>
        <div id="listTable"></div>
        <div class="btnPosition btnRight">
            <shovvel:auth auth="${authType}">
            <a href="javascript://"  class="btn_black" id="btn_add">등록</a>
            </shovvel:auth>
        </div>
    </article>
</section>
