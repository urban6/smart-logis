<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- datetime, date, time -->
<script type="text/javascript" charset="utf-8" src="/scripts/js/paging.js"></script>
<script type="text/javascript" charset="utf-8" src="/scripts/js/sortColumn.js"></script>
<input type="hidden" id="navi2_nm" value="접근 이력 관리" />
<input type="hidden" id="navi1_url_mod" value="./list" />

<script type="text/javascript">
	//Ajax로 첫 화면의 데이터 호출
	$( document ).ready( function()
	{
		$( "#navigationArea li" ).eq( 0 ).find( "a" ).text( "관리자 관리" );
		$( "#navigationArea li" ).eq( 0 ).find( "a" ).attr( "href" , "./list" );

		$( "#btn_search" ).click( function()
		{
			onSearch();

		} );

		$( "#searchType" ).change( function()
		{
			if ( $( this ).val() == "" )
			{
				$( "#searchText" ).val( "" );
				$( "#searchText" ).attr( "disabled" , true );
			}
			else
			{
				$( "#searchText" ).attr( "disabled" , false );
			}
		} );

		$( "#searchText" ).keyup( function()
		{
			if ( event.keyCode == 13 )
			{
				onSearch();
			}
		} )

		fnInit();
	} );

	//init function
	function fnInit()
	{
		//최초 리스트 1달전 날짜로 셋팅
		var now = new Date();
		var year = now.getFullYear();
		var mon = ( now.getMonth() + 1 ) > 9 ? '' + ( now.getMonth() + 1 ) : '0' + ( now.getMonth() + 1 );
		var day = now.getDate() > 9 ? '' + now.getDate() : '0' + now.getDate();
		var hour = now.getHours() > 9 ? '' + now.getHours() : '0' + now.getHours();
		var minutes = now.getMinutes() > 9 ? '' + now.getMinutes() : '0' + now.getMinutes();

		var nowmon = now.getMonth() + 1;
		var strNowmon = nowmon > 9 ? '' + nowmon : '0' + nowmon;

		// 1월 처리
		if ( nowmon == 1 )
		{
			year = year - 1;
			mon = '12';
		}
		// 2월 처리
		if ( nowmon == 2 && now.getDate() > 28 )
		{
			mon = '03';
			day = '01';
		}
		// 4, 6, 9, 11달 30일 처리
		if ( day == '31' && ( nowmon == 4 || nowmon == 6 || nowmon == 9 || nowmon == 11 ) )
		{
			day = '30';
		}
		var chan_val = year + '-' + mon + '-' + day + ' ' + hour + ':' + minutes;

		console.log( chan_val );
		$( "#startDate" ).val( year + '-' + mon + '-' + day + " 00:00" );
		$( "#endDate" ).val( year + '-' + strNowmon + '-' + day + " 23:59" );

		$( "#searchText" ).attr( "disabled" , true );

		goSearch();
	}

	function onSearch()
	{
		$( "#page" ).val( "1" );
		goSearch();
	}

	//oprationHist search
	function goSearch()
	{
		if ( $( "#searchType" ).val() != "" && $( "#searchText" ).val() == "" )
		{
			openAlertModal( "Warning" , "키워드를 입력해 주세요." );
			return false;
		}

		//날짜 체크
		if ( $( "#startDate" ).val() > $( "#endDate" ).val() )
		{
			openAlertModal( "Warning" , "마지막 날짜는 시작 날짜 이후로 입력해 주세요." );
			return;
		}

		fnLoading( true );

		var param = new Object();
		param = $( "#myForm" ).serialize();
		//console.log("goSearch()\n"+JSON.stringify(param));

		$.ajax( {
			url : "listAction" ,
			data : param ,
			type : 'POST' ,
			cache : false ,
			success : function( data )
			{
				$( "#loginHistTable" ).html( data );
			} ,
			error : function( e )
			{
				openAlertModal( "" , callErrorMsg );
			} ,
			complete : function()
			{
			}
		} );
	}

	//loading...
	function fnShowLoading()
	{
		var loadImage = '<div class="loading"><span class="loading-inner"></span></div>';

		$( ".data" ).children().remove();
		$( ".data" ).append( loadImage );
	}

	//exportAction
	function fnExcel()
	{
		if ( $( "#nodata" ).hasClass( "nodata" ) === true )
		{
			openAlertModal( "Warning" , "데이터가 존재하지 않습니다. 검색 조건을 다시 확인하세요." );
			return;
		}

		//날짜 체크
		if ( $( "#startDate" ).val() > $( "#endDate" ).val() )
		{
			openAlertModal( "Warning" , "마지막 날짜는 시작 날짜 이후로 입력해 주세요." );
			return;
		}

		var param = new Object();
		param = $( "#myForm" ).serialize();

		$.download( 'exportAction.xls' , param , 'post' );
	}
</script>

<section id="content" class="w1200">
	<article class="admin_conf_list">
		<div class="form_table pr122">
			<form id="myForm" name="myForm" method="POST" action="javascript:onSearch();">
				<input type="hidden" id="orderBy" name="orderBy" value="" />
				<input type="hidden" id="sortClass" name="sortClass" value="" />
				<input type="hidden" id="titleName" name="titleName" value="${titleName}" />

				<legend>검색 조건 정보 입력</legend>
				<fieldset>
					<table>
						<colgroup>
							<col style="width: 15%">
							<col style="width: 35%">
							<col style="width: 15%">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th>사용자 그룹명</th>
								<td>
									<select id="levelId" name="levelId" class="inp_select whalf">
										<option value="">All</option>
										<c:forEach items="${listUserLevel}" var="userLevel" varStatus="status">
											<option value="${userLevel.ID}">${userLevel.NAME}</option>
										</c:forEach>
									</select>
								</td>
								<th>검색 조건</th>
								<td>
									<select id="searchType" name="searchType" class="inp_select w120">
										<option value="">All</option>
										<option value="userSno">사용자 ID</option>
										<option value="userFnm">사용자 이름</option>
									</select>
									<input type="text" id="searchText" name="searchText" class="inp_txt w130" value="" placeholder="<spring:message code="label.fault.alarmconfig.search.keyword.text" />">
								</td>
							</tr>
							<tr>
								<th>기간</th>
								<td>
									<input type='text' id="startDate" name="startDate" value="" class="inp_txt w130">
									<input type='text' id="endDate" name="endDate" value="" class="inp_txt w130">

								</td>
								<th></th>
								<td></td>
							</tr>
						</tbody>
					</table>
					<a href="#" class="btn_search line1" id="btn_search">검색</a>
				</fieldset>
			</form>
		</div>
		<div id="loginHistTable"></div>
	</article>
</section>