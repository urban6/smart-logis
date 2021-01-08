<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link rel="stylesheet" href="/styles/dynatree/ui.dynatree.css">

<script type="text/javascript" charset="utf-8" src="/scripts/js/sortColumn.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/paging.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/selectBox.js"></script>

<!-- <link rel="stylesheet" href="/styles/tree/ui.dynatree.css">  -->
<script type="text/javascript" charset="utf-8" src="/scripts/dynaTree/jquery.dynatree.js"></script>
<style>
.dynatree-exp-el .dynatree-title {
    font-size: 15px;
    font-weight: 400;
}
</style>

    
<script type="text/javascript">

$(document).ready(function() {
   loadMenuTree();
   
   //$("#dynatree").dynatree("getTree").activateKey('999999');
});

//트리 타이틀 클릭시 이벤트 처리
$(document).on("click", ".dynatree-title", function(){
	var node = $("#dynatree").dynatree("getActiveNode");
	$(".dynatree-folder > .dynatree-connector").removeClass("dynatree-connector").addClass("dynatree-expander")
	$("#page").val("1");
	getViewCommonCodeDetail(node);
});


function loadMenuTree(){
	var param = new Object();
	
	$("#dynatree").dynatree({
 		initAjax: {
 			type : "post",
 			data : param, 
 			dataType : "json",
 			async: false,
 			url: "/management/operation/commoncode/getCommonCodeTree.json"
 		},
 		debugLevel: 0,
 		autoFocus: false,
		clickFolderMode: 1,
		minExpandLevel: 2,
/*  	    onClick: function(node) {
				getViewCommonCodeDetail(node.data.key);
 	    },  */
		/* onClick : function(node){
			console.log("=========================")
			$(".dynatree-folder > .dynatree-connector").removeClass("dynatree-connector").addClass("dynatree-expander");
 	    }, */
		onDblClick: function(node) {
			console.log(node);
			if(node.data.isFolder) {
				node.toggleExpand();
			}
		},
		onExpand: function(flag, dtnode){
			console.log("==========================");
			if(flag==true){
				$(".dynatree-folder > .dynatree-connector").removeClass("dynatree-connector").addClass("dynatree-expander");
			}
		}
	});
	$(".dynatree-folder > .dynatree-connector").removeClass("dynatree-connector").addClass("dynatree-expander");
	
	if('${key}' != ''){		
		$("#dynatree").dynatree("getTree").activateKey('${key}');
		var node = $("#dynatree").dynatree("getActiveNode");
		node.expand(true);
		getViewCommonCodeDetail(node);
	}else{		
		$("#dynatree").dynatree("getTree").activateKey('00000000');
		var node = $("#dynatree").dynatree("getActiveNode");
		node.expand(true);
		getViewCommonCodeDetail(node);
	}
     
}
 
//COMMON CODE 그룹 등록
function fnAddCommonCodeGroup(){
	var node = $('#dynatree').dynatree("getActiveNode");
	
	if(!node) {
		// openAlertModal("",'<spring:message code="msg.need.select.menu.text"/>');
		 openAlertModal("Warning", "메뉴를 선택해 주세요.");
		return;
	}
	
	if(node.data.isFolder==false){
		//openAlertModal("",'The menu group could not be added.');
		openAlertModal("Warning", "해당 메뉴 그룹은 추가될 수 없습니다.");
		return;
	}

	goInsertCommonCodePage(node.data.key,"Y");
    node.expand(true);    
}

//COMMON CODE 등록
function fnAddCommonCode(){
	var node = $('#dynatree').dynatree("getActiveNode");
	if(!node) {
		 // openAlertModal("",'<spring:message code="msg.need.select.menu.text"/>');
		 openAlertModal("Warning", "메뉴를 선택해 주세요.");
		return;
	}
	
	if(node.data.isFolder==false){
		// openAlertModal("",'The menu can only be added to menu group.');
		openAlertModal("Warning", "메뉴는 메뉴 그룹에만 추가될 수 있습니다.");
		return;
	}
	
	goInsertCommonCodePage(node.data.key,"N");
    node.expand(true);
}

function goInsertCommonCodePage(key,folderYn) {
	var param = new Object();
	param.key = key;
	param.folder_yn=folderYn;
 	$.ajax({
        url : "insert",
        data : param,
        type : 'POST',
        success : function(data) {
           $("#commoncodeAttribute").html(data);
        },
        error: function(e){
            openAlertModal("",callErrorMsg);
        },
        complete : function() {
			
        }
	}); 

}

function getViewCommonCodeDetail(node) {
	if(node.data.com_cd == "") {
		return ;
	}
	console.log("node.data.upper_com_cd="+node.data.upper_com_cd+", node.data.com_cd="+node.data.com_cd);
	
	var param = new Object();	
    param.key = node.data.key;
    if(node.data.isFolder==true){
    	param.folder_yn = "Y";
    	param.upper_com_cd = node.data.com_cd;
        param.com_cd = node.data.com_cd;
        param.upper_cd_nm = node.data.cd_nm;
    }else{
    	param.folder_yn = "N";
    	param.upper_com_cd = node.data.upper_com_cd;
        param.com_cd = node.data.com_cd;
        param.upper_cd_nm = node.data.cd_nm;
    }
    
   	param.page = 1;
   	param.perPage = 10;
   	if ($("#page").length > 0) {
       	param.page = $("#page").val();
   	}
   	if ($("#perPage").length > 0) {
       	param.perPage = $("#perPage").val();
   	}
   	if (param.page < 1) {
   		param.page = 1;
   	}
   	$.post('detailListCommonCodeAction.ajax', param, function(data) {
		$('#commoncodeAttribute').empty();
		$('#commoncodeAttribute').html(data);
	});	
}

/**
 * 트리 열기
 */
function expandAll() {
	$('#dynatree').dynatree("getRoot").visit(function(node){
		node.expand(true);
		//$(".dynatree-folder > .dynatree-connector").removeClass("dynatree-connector").addClass("dynatree-expander");
	});
}

/**
 * 트리 닫기
 */
function collapseAll() {
	$('#dynatree').dynatree("getRoot").visit(function(node){
		node.expand(false);
	});
}


</script>
</head>
<body>
<%-- <input type="text" id="page" name="page" value="${searchVal.page}" />
			<input type="text" id="perPage" name="perPage" value="${searchVal.perPage}"/> --%>
<form id="myForm" name="myForm" method="post">
<div class="content">
  <div class="cont_wrap">
  	<h1 class="h1">공통 코드 관리</h1>
      <p class="path"><span>DM Management</span><span>정보 관리</span><strong>공통 코드 관리</strong></p>
      
    <div class="layout type_01">
    
      <!-- treemenu -->		
      <div class="cont_box cell tree_area box">
      	<div class="result type_02">
          <div class="left_cont">
            <!-- <h2>Code Hierarchy</h2> -->
          	<h2>코드 속성 트리</h2>
          </div>
          <div class="right_cont">
            <div class="line">
              <button class="btn icon" type="button" title="Unfold" id="btnExpandAll" onclick="javascript:expandAll();" >
                <i class="unfold"></i><span>Unfold</span>
              </button>
              <button class="btn icon" type="button" title="Fold" id="btnCollapseAll" onclick="javascript:collapseAll();" >
                <i class="fold"></i><span>Fold</span>
              </button>
            </div>
          </div>  
        </div>
        <div class="load hide"><span><div class="loading type_01"></div></span></div>
        <div class="search_message hide"><span>등록된 메뉴가 없습니다.</span></div>
        <div class="boxContent">
           <div class="menuTree" id="dynatree">
           </div>
        </div>
              
      </div>
      <!-- //treemenu --> 
      
      <!-- register board -->
      <div class="cont_box cell box">
	    <div id="commoncodeAttribute">
	    	<input type="hidden" id="page" name="page" value="${searchVal.page}" />
			<input type="hidden" id="perPage" name="perPage" value="${searchVal.perPage}"/>
			<div class="scroll" id="loading">
				<div class="loading"><span class="loading-inner"></span></div>
			</div>
	    </div>
	  </div>
	  <!-- register board -->
	  
      
    </div>

      
  </div>
</div>
</form>

</body>
<input type="hidden" id="treeKey" name="treeKey">
<input type="hidden" id="groupKey" name="groupKey">