<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>

<style>
@media screen and (max-width:800px) { /*  style 안에 모두 넣어주세요 ksh 07-30 */
	#searchState {
		display: none;
	}
}
</style>

<!-- ============================================================== -->
<!-- Bread crumb and right sidebar toggle -->
<!-- ============================================================== -->
<div id="navList" class="page-breadcrumb border-bottom">
	<div class="row">
		<div class="col-lg-3 col-md-4 col-xs-12 align-self-center">
			<h5 class="font-medium text-uppercase mb-0">
				사용자 관리 (
				<span id="userListCount">0</span>
				명)
			</h5>
		</div>
		<div class="col-lg-9 col-md-8 col-xs-12 align-self-center">
			<nav aria-label="breadcrumb" class="mt-2 float-md-right float-left">
				<ol class="breadcrumb mb-0 justify-content-end p-0">
					<li class="breadcrumb-item">Home</li>
					<li class="breadcrumb-item active" aria-current="page">시스템 관리</li>
					<li class="breadcrumb-item active" aria-current="page">사용자 관리</li>
				</ol>
			</nav>
		</div>
	</div>
</div>
<div id="navAdd" class="page-breadcrumb border-bottom d-none">
	<div class="row">
		<div class="col-lg-3 col-md-4 col-xs-12 align-self-center">
			<h5 class="font-medium text-uppercase mb-0">계정 추가</h5>
		</div>
		<div class="col-lg-9 col-md-8 col-xs-12 align-self-center">
			<nav aria-label="breadcrumb" class="mt-2 float-md-right float-left">
				<ol class="breadcrumb mb-0 justify-content-end p-0">
					<li class="breadcrumb-item">Home</li>
					<li class="breadcrumb-item">시스템 관리</li>
					<li class="breadcrumb-item">사용자 관리</li>
					<li class="breadcrumb-item active" aria-current="page">계정 추가</li>
				</ol>
			</nav>
		</div>
	</div>
</div>
<div id="navInfo" class="page-breadcrumb border-bottom d-none">
	<div class="row">
		<div class="col-lg-3 col-md-4 col-xs-12 align-self-center">
			<h5 class="font-medium text-uppercase mb-0" id="navTitleInfo">상세 정보</h5>
			<h5 class="font-medium text-uppercase mb-0 d-none" id="navTitleModify">정보 수정</h5>
		</div>
		<div class="col-lg-9 col-md-8 col-xs-12 align-self-center">
			<nav aria-label="breadcrumb" class="mt-2 float-md-right float-left">
				<ol class="breadcrumb mb-0 justify-content-end p-0">
					<li class="breadcrumb-item">Home</li>
					<li class="breadcrumb-item">시스템 관리</li>
					<li class="breadcrumb-item">사용자 관리</li>
					<li class="breadcrumb-item active" aria-current="page" id="navSubtitleInfo">상세 정보</li>
					<li class="breadcrumb-item active d-none" aria-current="page" id="navSubtitleModify">정보 수정</li>
				</ol>
			</nav>
		</div>
	</div>
</div>
<!-- ============================================================== -->
<!-- End Bread crumb and right sidebar toggle -->
<!-- ============================================================== -->

<!-- ============================================================== -->
<!-- Container fluid  -->
<!-- ============================================================== -->
<div id="containerList" class="page-content container-fluid">
	<!-- ============================================================== -->
	<!-- Start Page Content -->
	<!-- ============================================================== -->
	<div class="row">
		<!-- Column -->
		<div class="col-md-12">
			<div class="card">
				<form id="frmList" name="frmList" method="POST">
					<input type="hidden" id="page" name="page" value="1" readonly="readonly" />
					<input type="hidden" id="perPage" name="perPage" value="${searchVal.perPage}" readonly="readonly" />
					<input type="hidden" id="perSize" name="perSize" value="${searchVal.perSize}" readonly="readonly" />
					<input type="hidden" id="orderbyClause" name="orderbyClause" value="${searchVal.orderbyClause}" readonly="readonly" />
					<input type="hidden" id="orderBy" name="orderBy" value="${searchVal.orderBy}" readonly="readonly" />
					<input type="hidden" id="searchState" name="searchState" value="N" readonly="readonly" />
					
					<div class="card-body">
						<div class="d-flex no-block align-items-center mb-4">
							<div class="">
								<div class="input-group">
									<input type="hidden" id="search1st" name="search1st" readonly="readonly" />
									<%-- <select class="select2 form-control" id="searchState" name="searchState" onChange="javascript:fnChangeSearch('S');" style="margin: 0 15px 0 0; width: 120px;">
										<c:set var="chk" value="" />
										<c:set var="chk" value="" />
										<c:if test='${searchVal.searchState eq "N" or searchVal.searchState eq ""}'>
											<c:set var="chk">selected="selected"</c:set>
										</c:if>
										<option value="N" ${chk}>정상 계정</option>
										<c:set var="chk" value="" />
										<c:if test='${searchVal.searchState eq "Y"}'>
											<c:set var="chk">selected="selected"</c:set>
										</c:if>
										<option value="Y" ${chk}>삭제 계정</option>
									</select> --%>
									<select class="select2 form-control" id="searchUserLevel" name="searchUserLevel" onChange="javascript:fnChangeSearch('L');" style="margin: 0 15px 0 0; width: 120px;">
										<option value="">권한</option>
										<c:forEach items="${listUserLevel}" var="list" varStatus="status">
											<c:set var="chk" value="" />
											<c:if test='${list.levelId eq searchVal.searchUserLevel}'>
												<c:set var="chk">selected="selected"</c:set>
											</c:if>
											<option value="${list.levelId}" ${chk}>${list.levelTitle}</option>
										</c:forEach>
									</select>
									<select class="form-control" id="searchDept" name="searchDept" onChange="javascript:fnChangeSearch('D');" style="width: 120px;">
										<option value="">부서</option>
										<c:forEach items="${listDept}" var="list" varStatus="status">
											<c:if test='${list.dept eq info.dept}'>
												<c:set var="chk">selected="selected"</c:set>
											</c:if>
											<option value="${list.dept}" ${chk}>${list.deptNm}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="btn-group ml-auto">
								<input type="text" class="form-control" placeholder="이름" id="searchText" name="searchText" value="${searchVal.searchText}" />
								<a href="javascript:goSearch();" class="active">
									<i class="fa fa-search"></i>
								</a>
								</input>
							</div>
						</div>
						<div id="userListTable" class="table-responsive" style="text-align: center;">
							<table class="table table-hover table-striped table-bordered border nowrap display">
								<thead>
									<tr>
										<th>
											<span class="text-muted">사원번호</span>
										</th>
										<th>
											<span class="text-muted">이름</span>
										</th>
										<th>
											<span class="text-muted">생년월일</span>
										</th>
										<th>
											<span class="text-muted">권한</span>
										</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="btn-group" style="margin: -35px 0 0 15px; float: right;">
							<!--  margin: -35px 0 0 15px; 페이징과 버튼 같은 높이 ksh pdf 20 -->
							<button type="button" class="btn waves-effect waves-light btn-primary" onclick="javascript:goAdd();">계정 추가</button>
						</div>
					</div>
				</form>
				<form id="frmDetail" name="frmDetail" method="POST">
					<input type="hidden" id="userSno" name="userSno" value="" readonly="readonly" />
					<input type="hidden" id="loginId" name="loginId" value="" readonly="readonly" />
					<input type="hidden" id="partnerSno" name="partnerSno" value="" readonly="readonly" />
				</form>
			</div>
		</div>
	</div>
	<!-- ============================================================== -->
	<!-- End PAge Content -->
	<!-- ============================================================== -->
</div>
<!-- ============================================================== -->
<!-- End Container fluid  -->
<!-- ============================================================== -->

<!-- ============================================================== -->
<!-- Container fluid  -->
<!-- ============================================================== -->
<div id="containerAdd" class="page-content container-fluid d-none">
	<form name="addForm" id="addForm" commandName="addForm" method="post">
		<!-- ============================================================== -->
		<!-- Start Page Content -->
		<!-- ============================================================== -->
		<div class="row">
			<div class="col-sm-12 col-md-12">
				<div class="card">
					<div class="card-body">
						<input type="hidden" id="userSnoAdd" name="userSno" value="" readonly="readonly" />
						<input type="hidden" id="loginIdAdd" name="loginId" value="" readonly="readonly" />
						<input type="hidden" id="statusAdd" name="status" value="" readonly="readonly" />
						<input type="hidden" id="partnerSnoAdd" name="partnerSno" value="0" readonly="readonly" />

						<div class="form-body">
							<div class="row mb-5">
								<div class="col-md-4">
									<label onlick="javascript:fnTest();">사원번호</label>
									<span id="spanValidSid" style="color: red;">*</span>
									<div class="form-group">
										<input type="text" class="form-control" maxlength="10" id="sidAdd" name="sid" value="" />
									</div>
									<small class="form-text text-muted">영문과 숫자만 입력 가능</small>
								</div>
								<div class="col-md-4">
									<label>비밀번호</label>
									<div class="form-group">
										<input type="password" class="form-control" placeholder="**********" id="pwdAdd" name="pwd" value="" readonly="readonly" />
									</div>
									<small class="form-text text-muted">초기 비밀번호는 생년월일로 자동 설정</small>
								</div>
								<div class="col-md-4">
									<label>이름 </label>
									<span id="spanValidUserFnm" style="color: red;">*</span>
									<div class="form-group">
										<input type="text" class="form-control" maxlength="20" id="userFnmAdd" name="userFnm" value="" />
									</div>
									<small class="form-text text-muted">한글 및 영문 20자 이내 입력 가능</small>
								</div>
							</div>
						</div>
						<div class="form-body">
							<div class="row">
								<div class="col-md-4">
									<label>
										생년월일
										<span style="color: red;">*</span>
									</label>
									<div class="form-group">
										<div class="input-group">
											<input type="hidden" class="form-control" id="brdyAdd" name="brdy" value="" readonly="readonly" />
											<input type="text" class="form-control pickadate-change-format" placeholder="년도 /월/일" id="brdyStrAdd" name="brdyStrAdd" value="" readonly="readonly" onChange="javascript:fnChangeBrdy('Add');" />
											<div class="input-group-prepend" id="btnBrdyStrAdd">
												<span class="input-group-text" onclick="javascript:$('#brdyStrAdd').click();">
													<span class="ti-calendar"></span>
												</span>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<label>
										권한
										<span style="color: red;">*</span>
									</label>
									<div class="form-group">
										<input type="text" class="form-control d-none" id="levelTitleAdd" name="levelTitle" value="" readonly="readonly" />
										<input type="hidden" class="form-control" id="levelIdAdd" name="levelId" value="" readonly="readonly" />

										<select class="form-control" id="levelTitlAdd" name="levelTitl" onchange="javascript:fnChangeLevel( 'Add', this.value );">
											<option value="">권한 선택</option>
											<c:set var="isLevelChecked" />
											<c:forEach items="${listUserLevel}" var="userLevel" varStatus="status">
												<option value="${userLevel.levelId}" ${isLevelChecked}>${userLevel.levelTitle}</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="col-md-4">
									<label>
										부서
										<span style="color: red;">*</span>
									</label>
									<div class="form-group">
										<input type="hidden" class="form-control" placeholder="" id="deptAdd" name="dept" value="${info.dept}" readonly="readonly" />
										<input type="hidden" class="form-control" placeholder="" id="deptOldAdd" name="deptOld" value="${info.dept}" readonly="readonly" />
										<input type="text" class="form-control d-none" placeholder="" id="Add" name="deptNm" value="${info.deptNm}" readonly="readonly" />
										<input type="hidden" class="form-control" placeholder="" id="deptNmOldAdd" name="deptNmOld" value="${info.deptNm}" readonly="readonly" />
										<select class="form-control d-none" id="deptListAdd" name="deptList" onChange="javascript:fnChangeDept('Add');">
											<option value="">부서</option>
											<c:forEach items="${listDept}" var="list" varStatus="status">
												<c:if test='${list.dept eq info.dept}'>
													<c:set var="chk">selected="selected"</c:set>
												</c:if>
												<option value="${list.dept}" ${chk}>${list.deptNm}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row" style="padding: 0 1.57rem 1.54rem;">
						<div class="col-12">
							<div class="text-left float-left">
								<button class="btn waves-effect waves-light btn-secondary" onclick="javascript:fnCancelList();">취소</button>
							</div>
							<div class="text-left float-right">
								<button class="btn waves-effect waves-light btn-primary" onclick="javascript:fnProcAdd();">계정 추가</button>
							</div>
						</div>
						<div class="col-6">
							<div class="text-right" style="padding: 0 1.57rem;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- //board -->
	</form>
</div>
<!-- ============================================================== -->
<!-- End Container fluid  -->
<!-- ============================================================== -->

<!-- ============================================================== -->
<!-- Container fluid  -->
<!-- ============================================================== -->
<div id="containerInfo" class="page-content container-fluid d-none">

	<form name="modifyForm" id="modifyForm" commandName="modifyForm" method="post">
		<!-- ============================================================== -->
		<!-- Start Page Content -->
		<!-- ============================================================== -->
		<div class="row">
			<div class="col-sm-12 col-md-12">
				<div class="card">
					<div class="card-body">
						<input type="hidden" id="userSnoModify" name="userSno" value="" readonly="readonly" />
						<input type="hidden" id="loginIdModify" name="loginId" value="" readonly="readonly" />
						<input type="hidden" id="statusModify" name="status" value="" readonly="readonly" />
						<input type="hidden" id="partnerSnoModify" name="partnerSno" value="" readonly="readonly" />

						<div class="form-body">
							<div class="row mb-4">
								<!-- mb-4 : 아래 여백 추가 ksh -->
								<div class="col-md-4">
									<label onlick="javascript:fnTest();">사원번호</label>
									<div class="form-group">
										<input type="text" class="form-control" maxlength="10" id="sidModify" name="sid" value="" readonly="readonly" />
									</div>
								</div>
								<div class="col-md-4">
									<label> 비밀번호 </label>
									<span id="btnPasswdInitModify" style="float: right; text-decoration: underline; color: #707cd2; cursor: pointer;">비밀번호 초기화</span>
									<div class="form-group">
										<input type="password" class="form-control" placeholder="**********" id="pwdModify" name="pwd" value="" readonly="readonly" />
									</div>
								</div>
								<div class="col-md-4">
									<label>이름 </label>
									<div class="form-group">
										<input type="text" class="form-control" maxlength="20" id="userFnmModify" name="userFnm" value="" readonly="readonly" />
									</div>
								</div>
							</div>
						</div>
						<div class="form-body">
							<div class="row">
								<div class="col-md-4">
									<label>
										생년월일
										<span id="spanValidBrdy" style="color: red;">*</span>
									</label>
									<div class="form-group">
										<div class="input-group">
											<input type="hidden" class="form-control" id="brdyModify" name="brdy" value="" readonly="readonly" />
											<input type="text" class="form-control pickadate-change-format d-none" id="brdyTitleModify" name="brdyTitle" value="" readonly="readonly" />
											<input type="text" class="form-control pickadate-change-format" placeholder="년도 /월/일" id="brdyStrModify" name="brdyStrModify" value="" readonly="readonly" onChange="javascript:fnChangeBrdy('Modify');" />
											<input type="hidden" class="form-control" id="brdyModifyOld" name="brdyOld" value="" readonly="readonly" />
											<div class="input-group-prepend" id="btnBrdyStr">
												<span class="input-group-text" onclick="javascript:$('#brdyStrModify').click();">
													<span class="ti-calendar"></span>
												</span>
											</div>
										</div>
									</div>
									<small class="form-text text-muted" id="validMessageBrdyModify">필수 입력값입니다.</small>
								</div>
								<div class="col-md-4">
									<label>
										권한
										<span id="spanValidUserLevel" style="color: red;">*</span>
									</label>
									<div class="form-group">
										<input type="text" class="form-control" id="levelTitleModify" name="levelTitle" value="" readonly="readonly" />
										<input type="hidden" class="form-control d-none" id="levelTitleModifyOld" name="levelTitleOld" value="" readonly="readonly" />
										<input type="hidden" class="form-control" id="levelIdModify" name="levelId" value="" readonly="readonly" />
										<input type="hidden" class="form-control" id="levelIdModifyOld" name="levelIdOld" value="" readonly="readonly" />

										<select class="form-control" id="levelTitlModify" name="levelTitl" onchange="javascript:fnChangeLevel('Modify', this.value );">
											<option value="" selected="selected">권한 선택</option>
											<c:set var="isLevelChecked" />
											<c:forEach items="${listUserLevel}" var="userLevel" varStatus="status">
												<option value="${userLevel.levelId}">${userLevel.levelTitle}</option>
											</c:forEach>
										</select>
									</div>
									<small class="form-text text-muted" id="validMessageUserLevelModify">필수 입력값입니다.</small>
								</div>
								<div class="col-md-4">
									<label>
										부서
										<span id="spanValidUserDept" style="color: red;">*</span>
									</label>
									<div class="form-group">
										<input type="hidden" class="form-control" placeholder="" id="deptModify" name="dept" value="${info.dept}" readonly="readonly" />
										<input type="hidden" class="form-control" placeholder="" id="deptOldModify" name="deptOld" value="${info.dept}" readonly="readonly" />
										<input type="text" class="form-control" placeholder="" id="deptNmModify" name="deptNm" value="${info.deptNm}" readonly="readonly" />
										<input type="hidden" class="form-control" placeholder="" id="deptNmOldModify" name="deptNmOld" value="${info.deptNm}" readonly="readonly" />
										<select class="form-control d-none" id="deptListModify" name="deptList" onChange="javascript:fnChangeDept('Modify');">
											<option value="">부서</option>
											<c:forEach items="${listDept}" var="list" varStatus="status">
												<c:if test='${list.dept eq info.dept}'>
													<c:set var="chk">selected="selected"</c:set>
												</c:if>
												<option value="${list.dept}" ${chk}>${list.deptNm}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row d-none" id="btnAreaInfoModify" style="padding: 0 0 1.57rem;">
						<div class="col-6">
							<div class="text-left" style="padding: 0 1.57rem;">
								<button class="btn waves-effect waves-light btn-secondary" onclick="javascript:fnList();">목록</button>
							</div>
						</div>
						<div class="col-6">
							<div class="text-right" style="padding: 0 1.57rem;">
								<button class="btn waves-effect waves-light btn-primary" id="btnInfoModify" onclick="javascript:fnInfoModify();">정보 수정</button>
								<button class="btn btn-primary" id="btnInfoRestore">계정 복구</button>
							</div>
						</div>
					</div>
					<div class="row d-none" id="btnAreaSaveModify" style="padding: 24px;">
						<div class="col-6">
							<div class="text-left">
								<button class="btn waves-effect waves-light btn-secondary" onclick="javascript:fnInfoModify();">취 소</button>
							</div>
						</div>
						<div class="col-6">
							<div class="text-right">
								<button class="btn btn-primary" id="btnInfoRemove" style="color: red; background: none; border: none; text-decoration: underline;">계정 삭제</button>
								<button class="btn waves-effect waves-light btn-primary" onclick="javascript:fnInfoSave();">저장</button>
							</div>
						</div>
						<!-- <div class="col-6">
							<div class="text-right">
								<button class="btn btn-primary" id="btnInfoRemove">계정 11삭제</button>
							</div>
						</div> -->
					</div>
				</div>
			</div>
		</div>
		<!-- //board -->

		<!-- Remove content -->
		<div id="modalRemoveInfo" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
			<div class="modal-dialog" aria-labelledby="vcenter">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">계정 삭제</h4>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label class="control-label">
								<span id="modalSpanRemoveInfoId">{ID}</span>
								를 삭제 하시겠습니까?
							</label>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary waves-effect waves-light" onClick="javascript:fnProcRemove();">확인</button>
					</div>
				</div>
			</div>
		</div>
		<!-- /.modal -->
		<!-- Init password modal content -->
		<div id="modalPasswdInit" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
			<div class="modal-dialog" aria-labelledby="vcenter">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">비밀번호 초기화</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label class="control-label">
								<span id="modalSpanPasswdInitTarget">{Name}</span>
								계정의 비밀번호를 초기화 하시겠습니까?
							</label>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary waves-effect waves-light" onClick="javascript:fnProcPasswdInit();">초기화</button>
					</div>
				</div>
			</div>
		</div>
		<!-- /.modal -->

		<!-- Init password modal content -->
		<div id="modalRestore" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
			<div class="modal-dialog" aria-labelledby="vcenter">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">계정 복구</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label class="control-label">
								<span id="modalSpanRestoreTarget">{Name}</span>
								계정을 복구 하시겠습니까?
							</label>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary waves-effect waves-light" onClick="javascript:fnProcRestore();">확인</button>
					</div>
				</div>
			</div>
		</div>
		<!-- /.modal -->

		<!-- Result content -->
		<div id="modalConfirm" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
			<div class="modal-dialog" aria-labelledby="vcenter">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modalTextConfirmTitle"></h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label class="control-label">
								<span id="modalSpanConfirmMessage">{confirmMessage}</span>
							</label>
						</div>
					</div>
					<div class="modal-footer" id="modalConfirmAdd">
						<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">취소</button>
						<button type=button class="btn btn-primary waves-effect waves-light" data-dismiss="modal" onclick="javascript:fnProcAdd();">확인</button>
					</div>
					<div class="modal-footer" id="modalConfirmModify">
						<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal" onClick="javascript:fnInfoModify();">취소</button>
						<button type=button class="btn btn-primary waves-effect waves-light" data-dismiss="modal" onclick="javascript:fnProcModify();">저장</button>
					</div>
					<div class="modal-footer" id="modalConfirmRemove">
						<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal" onClick="javascript:fnInfoModify();">취소</button>
						<button type=button class="btn btn-primary waves-effect waves-light" data-dismiss="modal" onclick="javascript:fnProcRemove();">확인</button>
					</div>
					<div class="modal-footer" id="modalConfirmPasswdInit">
						<button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal" onClick="javascript:fnInfoModify();">취소</button>
						<button type=button class="btn btn-primary waves-effect waves-light" data-dismiss="modal" onclick="javascript:fnProcPasswdInit();">초기화</button>
					</div>
				</div>
			</div>
		</div>
		<!-- /.modal -->
	</form>
</div>
<!-- ============================================================== -->
<!-- End Container fluid  -->
<!-- ============================================================== -->

<script type="text/javascript">
	var boolModify = false;
	var orderByClickId = "";
	var orderByClickCount = 0;

	$( document ).ready( function()
	{
		fnInit();
	} );

	//init function
	function fnInit()
	{
		$( "form" ).on( "submit" , function( event )
		{
			if ( boolSubmit == false )
			{
				event.preventDefault();
			}
		} );

		$( "#searchText" ).keydown( function( key )
		{
			if ( key.keyCode == 13 )
			{
				onSearch( 1 );
			}
		} );

		$( "#search1st" ).val( "1ST" );

		var datePickerYear = new Date().getYear() + 1900;
		var datePickerMonth = new Date().getMonth();
		var datePickerDay = new Date().getDate();

		// Add user
		$( "#sidAdd" ).change( function()
		{
			var replaceStr = valid.replaceAlphaNumber( $( this ).val() );
			$( this ).val( replaceStr );
		} );
		$( "#userFnmAdd" ).change( function()
		{
			var replaceStr = valid.replaceName( $( this ).val() );
			$( this ).val( replaceStr );
		} );
		$( '#brdyStrAdd' ).pickadate( {
			format : 'yyyy년 mm월 dd일' ,
			formatSubmit : 'yyyy-mm-dd' ,
			clear : '' ,
			today : '' ,
			selectYears : 100 ,
			max : [
					datePickerYear , datePickerMonth , datePickerDay
			]
		} );

		//Modify user (Info, Modify, Delete, Restore)
		$( "#sidModify" ).change( function()
		{
			var replaceStr = valid.replaceAlphaNumber( $( this ).val() );
			$( this ).val( replaceStr );
		} );
		$( "#userFnmModify" ).change( function()
		{
			var replaceStr = valid.replaceName( $( this ).val() );
			$( this ).val( replaceStr );
		} );
		$( '#brdyStrModify' ).pickadate( {
			format : 'yyyy년 mm월 dd일' ,
			formatSubmit : 'yyyy-mm-dd' ,
			clear : '' ,
			today : '' ,
			selectYears : 100 ,
			max : [
					datePickerYear , datePickerMonth , datePickerDay
			]
		} );
		$( "#btnInfoRemove" ).click( function()
		{
			$( "#modalSpanRemoveInfoId" ).text( $( "#sidModify" ).val() );
			fnModalOpen( 'modalRemoveInfo' , true );
		} );
		$( "#btnPasswdInitModify" ).click( function()
		{
			$( "#modalSpanPasswdInitTarget" ).text( $( "#userFnmModify" ).val() );
			fnModalOpen( 'modalPasswdInit' , true );
		} );
		$( "#btnInfoRestore" ).click( function()
		{
			$( "#modalSpanRestoreTarget" ).text( $( "#userFnmModify" ).val() );
			fnModalOpen( 'modalRestore' , true );
		} );

		onSearch( 1 );
	}

	//search 1 page set
	function onSearch( page )
	{
		goSearch( page );
	}

	//user manage search
	function goSearch( page )
	{
		

		if( page == undefined ){
			
			page = 1;			
			
		}
		
		fnLoading( true );

		$( "#page" ).val( page );

		var param = new Object();
		param = $( "#frmList" ).serialize();
		//console.log(JSON.stringify(param));

		// 		console.log( "searchState=" + $( "#searchState" ).val() );
		// 		console.log( JSON.stringify( param ) );

		$.ajax( {
			url : "listAction" ,
			data : param ,
			type : 'POST' ,
			cache : false ,
			success : function( data )
			{
				fnDisplayVisible( "navList" , true );
				fnDisplayVisible( "navAdd" , false );
				fnDisplayVisible( "navInfo" , false );

				$( "#userListTable" ).html( data );
			} ,
			error : function( e )
			{
				openAlertModal( "" , callErrorMsg );
			} ,
			complete : function()
			{
				fnLoading( false );

				boolSubmit = false;
			}
		} );

		$( "#search1st" ).val( "" );
	}

	function fnSearchOrderBy( type, target )
	{
		if ( orderByClickId != target )
		{
			orderByClickCount = 0;
		}
		orderByClickCount++;

		if ( orderByClickCount % 2 == 1 )
		{
			$( "#th_" + type + "_" + target ).removeClass( "sorting" );
			$( "#th_" + type + "_" + target ).removeClass( "sorting_asc" );
			$( "#th_" + type + "_" + target ).addClass( "sorting_desc" );
		}
		else if ( orderByClickCount % 2 == 0 )
		{
			$( "#th_" + type + "_" + target ).removeClass( "sorting" );
			$( "#th_" + type + "_" + target ).removeClass( "sorting_desc" );
			$( "#th_" + type + "_" + target ).addClass( "sorting_asc" );
		}
		else
		{
			$( "#th_" + type + "_" + target ).removeClass( "sorting_asc" );
			$( "#th_" + type + "_" + target ).removeClass( "sorting_desc" );
			$( "#th_" + type + "_" + target ).addClass( "sorting" );
		}

		if ( $( "#th_" + type + "_" + target ).hasClass( "sorting_asc" ) )
		{
			$( "#orderbyClause" ).val( target.toUpperCase() );
			$( "#orderBy" ).val( "ASC" );
		}
		if ( $( "#th_" + type + "_" + target ).hasClass( "sorting_desc" ) )
		{
			$( "#orderbyClause" ).val( target.toUpperCase() );
			$( "#orderBy" ).val( "DESC" );
		}
		if ( $( "#th_" + type + "_" + target ).hasClass( "sorting" ) )
		{
			$( "#orderbyClause" ).val( "" );
			$( "#orderBy" ).val( "" );
		}

		goSearch( 1 );

		orderByClickId = target;
	}

	function fnList()
	{
		fnDisplayVisible( "navList" , true );
		fnDisplayVisible( "navAdd" , false );
		fnDisplayVisible( "navInfo" , false );

		fnDisplayVisible( "containerList" , true );
		fnDisplayVisible( "containerAdd" , false );
		fnDisplayVisible( "containerInfo" , false );

		fnInitAdd();
		fnInitModify();

		goSearch( $( "#page" ).val() );
	}

	function fnCancelList()
	{
		fnList();
	}

	function fnInitAdd()
	{
		$( "#sidAdd" ).val( "" );
		$( "#pwdAdd" ).val( "" );
		$( "#userFnmAdd" ).val( "" );
		$( "#brdyStrAdd" ).val( "" );
		$( "#levelTitleAdd" ).val( "" );
		$( "#levelIdAdd" ).val( "" );
		$( "#levelTitlAdd" ).val( "" );
		$( "#deptAdd" ).val( "" );
		$( "#deptOldAdd" ).val( "" );
		$( "#deptNmAdd" ).val( "" );
		$( "#deptNmOldAdd" ).val( "" );
		$( "#deptListAdd" ).val( "" );

		fnDisplayVisible( "deptNmAdd" , false );
		fnDisplayVisible( "deptListAdd" , true );
	}

	function fnInitModify()
	{
		$( "#sidModify" ).val( "" );
		$( "#userFnmModify" ).val( "" );
		$( "#brdyModify" ).val( "" );
		$( "#brdyTitleModify" ).val( "" );
		$( "#brdyStrModify" ).val( "" );
		$( "#brdyModifyOld" ).val( "" );
		$( "#levelTitleModify" ).val( "" );
		$( "#levelTitleModifyOld" ).val( "" );
		$( "#levelIdModify" ).val( "" );
		$( "#levelIdModifyOld" ).val( "" );

		$( "#deptModify" ).val( "" );
		$( "#deptOldModify" ).val( "" );
		$( "#deptNmModify" ).val( "" );
		$( "#deptNmOldModify" ).val( "" );
		$( "#deptListModify" ).val( "" );

		fnDisplayVisible( "brdyTitleModify" , true );
		fnDisplayVisible( "brdyStrModify" , false );
		fnDisplayVisible( "levelTitleModify" , true );
		fnDisplayVisible( "levelTitlModify" , false );
		fnDisplayVisible( "deptNmModify" , true );
		fnDisplayVisible( "deptListModify" , false );

		fnDisplayVisible( "validMessageBrdyModify" , false );
		fnDisplayVisible( "validMessageUserLevelModify" , false );

		fnDisplayVisible( "btnAreaInfoModify" , true );
		fnDisplayVisible( "btnAreaSaveModify" , false );
	}

	//user Manage goDetail
	function goDetail( userSno, loginId, partnerSno )
	{
		boolModify = false;

		$( "#userSnoModify" ).val( userSno );
		$( "#loginIdModify" ).val( loginId );
		$( "#partnerSnoModify" ).val( partnerSno );

		fnInitModify();

		fnLoading( true );

		var param = new Object();
		// 		param = $( "#frmList" ).serialize();
		param.userSno = userSno;
		param.loginId = loginId;
		param.partnerSno = partnerSno;
		//console.log(JSON.stringify(param));

		// 		console.log( JSON.stringify( param ) );

		$.ajax( {
			url : "detailAction" ,
			data : param ,
			type : 'POST' ,
			dataType : 'json' ,
			cache : false ,
			success : function( data )
			{

				console.log( "detail result : " + data.resultMsg );

				if ( data.resultMsg == "succ" )
				{
					// 값 설정
					$( "#sidModify" ).val( data.info.sid );
					$( "#userFnmModify" ).val( data.info.userFnm );
					$( "#brdyModify" ).val( data.info.brdy );
					$( "#brdyTitleModify" ).val( data.info.brdyStr );
					$( "#brdyStrModify" ).val( data.info.brdyStr );
					$( "#brdyModifyOld" ).val( data.info.brdy );
					$( "#levelTitleModify" ).val( data.info.levelTitle );
					$( "#levelTitleModifyOld" ).val( data.info.levelTitle );
					$( "#levelIdModify" ).val( data.info.levelId );
					$( "#levelIdModifyOld" ).val( data.info.levelId );
					$( "#deptModify" ).val( data.info.dept );
					$( "#deptOldModify" ).val( data.info.dept );
					$( "#deptNmModify" ).val( data.info.deptNm );
					$( "#deptNmOldModify" ).val( data.info.deptNm );
					$( "#deptListModify" ).val( data.info.dept );

					var boolView = true;

					if ( boolView )
					{
						if ( data.info.status == "N" )
						{
							fnDisplayVisible( "btnPasswdInitModify" , false );

							fnDisplayVisible( "btnInfoModify" , false );
							fnDisplayVisible( "btnInfoRestore" , true );
						}
						else
						{
							fnDisplayVisible( "btnPasswdInitModify" , true );

							fnDisplayVisible( "btnInfoModify" , true );
							fnDisplayVisible( "btnInfoRestore" , false );
							fnDisplayVisible( "btnInfoRemove" , true );
						}
					}
					else
					{
						fnDisplayVisible( "btnPasswdInitModify" , false );

						fnDisplayVisible( "btnInfoModify" , false );
						fnDisplayVisible( "btnInfoRestore" , false );
						fnDisplayVisible( "btnInfoRemove" , false );
					}
					fnDisplayVisible( "btnAreaInfoModify" , true );
					fnDisplayVisible( "btnAreaSaveModify" , false );

					fnDisplayVisible( "navList" , false );
					fnDisplayVisible( "navAdd" , false );
					fnDisplayVisible( "navInfo" , true );

					fnDisplayVisible( "containerList" , false );
					fnDisplayVisible( "containerAdd" , false );
					fnDisplayVisible( "containerInfo" , true );
				}
				else
				{
					fnResultMessage( "Warning" , "frmList" , "회원 목록" , "회원 목록이 없습니다." );
				}
			} ,
			error : function( e )
			{
				openAlertModal( "" , callErrorMsg );
			} ,
			complete : function()
			{
				fnLoading( false );
			}
		} );

	}

	//user Manage goAdd
	function goAdd()
	{
		fnInitAdd();

		fnDisplayVisible( "navList" , false );
		fnDisplayVisible( "navAdd" , true );
		fnDisplayVisible( "navInfo" , false );

		fnDisplayVisible( "containerList" , false );
		fnDisplayVisible( "containerAdd" , true );
		fnDisplayVisible( "containerInfo" , false );

	}

	function changeTrColor( trObj, oldColor, newColor )
	{
		trObj.style.backgroundColor = newColor;
		trObj.onmouseout = function()
		{
			trObj.style.backgroundColor = oldColor;
		}
	}

	function clickTrEvent( trObj )
	{
		alert( trObj.id );
	}

	function fnChangeSearch( type )
	{
		orderByClickId = "";
		$( "#orderbyClause" ).val( "" );
		$( "#orderBy" ).val( "" );

		if ( type == "S" )
			onSearch( '1' );
		if ( type == "L" )
			onSearch( '1' );
		if ( type == "D" )
			onSearch( '1' );
	}

	//user manage goModify
	function fnInfoModify()
	{
		$( "#levelTitlModify" ).val( $( "#levelIdModifyOld" ).val() );
		$( "#passwdModify" ).val( "" );

		console.log( "boolModify=" + boolModify );

		if ( boolModify )
		{
			$( "#levelIdModify" ).val( $( "#levelIdModifyOld" ).val() );
			$( "#deptListModify" ).val( $( "#deptOldModify" ).val() );

			fnCancelValue( "brdyModify" );
			fnCancelValue( "levelTitleModify" );

			fnDisplayVisible( "navTitleInfo" , true );
			fnDisplayVisible( "navSubtitleInfo" , true );
			fnDisplayVisible( "navTitleModify" , false );
			fnDisplayVisible( "navSubtitleModify" , false );

			fnDisplayVisible( "spanValidSidModify" , false );
			fnDisplayVisible( "spanValidUserFnmModify" , false );
			fnDisplayVisible( "spanValidBrdyModify" , false );
			fnDisplayVisible( "spanValidUserLevelModify" , false );
			fnDisplayVisible( "spanValidUserDeptModify" , false );

			fnDisplayVisible( "brdyTitleModify" , true );
			fnDisplayVisible( "brdyStrModify" , false );
			fnDisplayVisible( "btnBrdyStrModify" , false );

			fnDisplayVisible( "levelTitleModify" , true );
			fnDisplayVisible( "levelTitlModify" , false );

			fnDisplayVisible( "deptNmModify" , true );
			fnDisplayVisible( "deptListModify" , false );

			fnDisplayVisible( "btnPasswdInitModify" , true );
			fnDisplayVisible( "btnAreaInfoModify" , true );
			fnDisplayVisible( "btnAreaSaveModify" , false );

			boolModify = false;
		}
		else
		{
			fnReadOnly( "passwdModify" , false );

			fnDisplayVisible( "navTitleInfo" , false );
			fnDisplayVisible( "navSubtitleInfo" , false );
			fnDisplayVisible( "navTitleModify" , true );
			fnDisplayVisible( "navSubtitleModify" , true );

			fnDisplayVisible( "brdyTitleModify" , false );
			fnDisplayVisible( "brdyStrModify" , true );
			fnDisplayVisible( "btnBrdyStrModify" , true );

			fnDisplayVisible( "spanValidBrdyModify" , true );
			fnDisplayVisible( "spanValidUserLevelModify" , true );
			fnDisplayVisible( "spanValidUserDeptModify" , true );

			fnDisplayVisible( "levelTitleModify" , false );
			fnDisplayVisible( "levelTitlModify" , true );

			fnDisplayVisible( "deptNmModify" , false );
			fnDisplayVisible( "deptListModify" , true );

			fnDisplayVisible( "btnPasswdInitModify" , false );
			fnDisplayVisible( "btnAreaInfoModify" , false );
			fnDisplayVisible( "btnAreaSaveModify" , true );

			boolModify = true;
		}
	}

	function fnInfoSave()
	{
		if ( fnValid( "M" ) )
		{
			fnDisplayVisible( "modalConfirmAdd" , false );
			fnDisplayVisible( "modalConfirmModify" , true );
			fnDisplayVisible( "modalConfirmRemove" , false );
			fnDisplayVisible( "modalConfirmPasswdInit" , false );

			fnConfirmMessage( "정보 수정" , "입력하신 정보를 저장하시겠습니까?" );
		}
	}

	//user manage remove
	function fnProcModify()
	{
		if ( fnValid( "M" ) )
		{
			$( "#statusModify" ).val( "Y" );

			var param = new Object();
			param = $( "#modifyForm" ).serialize();

			$.ajax( {
				url : "modifyAction" ,
				data : param ,
				type : 'POST' ,
				dataType : 'json' ,
				success : function( data )
				{
					fnModalOpen( 'modalConfirm' , false );

					console.log( "modifyAction result : " + data.resultMsg );

					if ( data.resultMsg == "succ" )
					{
						fnResultMessage( "SUCCESS_LIST_AJAX" , "modifyForm" , "계정 수정" , "계정 수정 되었습니다." );
					}
					else
					{
						fnResultMessage( "Warning" , "modifyForm" , "계정 수정" , data.resultMsg );
					}
				} ,
				error : function( e )
				{
					fnErrorMessage( "Error! " + e );
				} ,
				complete : function()
				{

				}
			} );
		}
	}

	//user manage remove
	function fnRemove()
	{
		fnDisplayVisible( "modalConfirmModify" , false );
		fnDisplayVisible( "modalConfirmRemove" , true );
		fnDisplayVisible( "modalConfirmPasswdInit" , false );

		fnConfirmMessage( "계정 삭제 확인" , "계정 삭제 하시겠습니까?" );
	}

	function fnProcRemove()
	{
		$( "#statusModify" ).val( "Y" );

		var param = new Object();
		param = $( "#modifyForm" ).serialize();

		$.ajax( {
			url : "removeAction" ,
			data : param ,
			type : 'POST' ,
			dataType : 'json' ,
			success : function( data )
			{
				if ( data.resultMsg == "succ" )
				{
					// 					toastr.success( '계정이 삭제 되었습니다.' , '삭제 완료' );
					fnResultMessage( "SUCCESS_LIST_AJAX" , "modifyForm" , "계정 삭제" , "관련 정보가 삭제되었습니다." );
				}
				else
				{
					fnResultMessage( "Warning" , "modifyForm" , "계정 삭제" , data.resultMsg );
				}

				fnModalOpen();
				fnModalOpen( 'modalRemoveInfo' , false );
				fnModalOpen( 'modalRemoveInfo' , false );
			} ,
			error : function( e )
			{
				fnErrorMessage( "Error! " + e );
			} ,
			complete : function()
			{

			}
		} );
	}

	function fnProcPasswdInit()
	{
		$( "#statusModify" ).val( "Y" );

		var param = new Object();
		param = $( "#modifyForm" ).serialize();

		$.ajax( {
			url : "initPasswdAction" ,
			data : param ,
			type : 'POST' ,
			dataType : 'json' ,
			success : function( data )
			{
				if ( data.resultMsg == "succ" )
				{
					fnResultMessage( "SUCCESS_LIST_AJAX" , "modifyForm" , "비밀번호 초기화" , "비밀번호 초기화 되었습니다." );
					// 					toastr.success( '비밀번호가 초기화 되었습니다.' , '초기화 완료' );
				}
				else
				{
					fnResultMessage( "Warning" , "modifyForm" , data.resultMsg );
				}

				fnModalOpen( 'modalPasswdInit' , false );
			} ,
			error : function( e )
			{
				fnModalOpen( 'modalPasswdInit' , false );

				fnErrorMessage( "Error! " + e );
			} ,
			complete : function()
			{

			}
		} );
	}

	/**
	If cancel then object's value is rollback.
	 */
	function fnCancelValue( objId )
	{
		$( "#" + objId ).val( $( "#" + objId + "Old" ).val() );
	}

	function fnProcRestore()
	{
		$( "#statusModify" ).val( "N" );

		var param = new Object();
		param = $( "#modifyForm" ).serialize();

		$.ajax( {
			url : "restoreAction" ,
			data : param ,
			type : 'POST' ,
			dataType : 'json' ,
			success : function( data )
			{
				if ( data.resultMsg == "succ" )
				{
					fnResultMessage( "SUCCESS_LIST" , "modifyForm" , "계정 복구" , "계정이 복구 되었습니다." );
				}
				else
				{
					fnResultMessage( "Warning" , "modifyForm" , "계정 복구" , data.resultMsg );
				}

				fnModalOpen( 'modalRestore' , false );
			} ,
			error : function( e )
			{
				fnErrorMessage( "Error! " + e );
			} ,
			complete : function()
			{

			}
		} );
	}

	function fnChangeLevel( callType, value )
	{
		fnDisplayVisible( "validMessageUserLevel" + callType , false );
		if ( callType == "Add" )
			$( "#levelId" + callType ).val( value );
		if ( boolModify )
			$( "#levelId" + callType ).val( value );
	}

	function fnChangeBrdy( callType )
	{
		fnDisplayVisible( "validMessageBrdy" + callType , false );
		$( "#brdy" + callType ).val( $( "input[name=brdyStr" + callType + "_submit]" ).val() );
	}

	function fnConfirmMessage( title, message )
	{
		$( '#modalTextConfirmTitle' ).text( title );
		$( '#modalSpanConfirmMessage' ).text( message );
		fnModalOpen( 'modalConfirm' , true );
	}

	function fnValid( callType )
	{
		// 계정 추가인 경우
		if ( callType == "A" )
		{
			console.log( "sid length=" + $( "#sidAdd" ).val().length );
			console.log( "brdy length=" + $( "#brdyAdd" ).val().length );
			console.log( "levelId length=" + $( "#levelIdAdd" ).val().length );

			if ( $( "#sidAdd" ).val().length < 1 )
			{
				fnErrorMessage( "사원번호를 확인하세요." );
				return false;
			}

			if ( $( "#userFnmAdd" ).val().length < 1 )
			{
				fnErrorMessage( "이름을 확인하세요." );
				return false;
			}
			if ( $( "#brdyAdd" ).val().length < 1 )
			{
				fnErrorMessage( "생년월일을 확인하세요." );
				return false;
			}
			if ( $( "#levelIdAdd" ).val().length < 1 )
			{
				fnErrorMessage( "권한을 선택하세요." );
				return false;
			}
			if ( $( "#deptAdd" ).val().length < 1 )
			{
				fnErrorMessage( "부서를 선택하세요." );
				return false;
			}
		}
		// 계정 수정인 경우
		else if ( callType == "M" )
		{
			console.log( "sid length=" + $( "#sidModify" ).val().length );
			console.log( "brdy length=" + $( "#brdyModify" ).val().length );
			console.log( "levelId length=" + $( "#levelIdModify" ).val().length );

			if ( $( "#userFnmModify" ).val().length < 1 )
			{
				fnErrorMessage( "이름을 확인하세요." );
				return false;
			}
			if ( $( "#brdyModify" ).val().length < 1 )
			{
				fnErrorMessage( "생년월일을 확인하세요." );
				return false;
			}
			if ( $( "#levelIdModify" ).val() == "999" || $( "#levelIdModify" ).val().length < 1 )
			{
				fnErrorMessage( "권한을 선택하세요." );
				return false;
			}
			if ( $( "#deptModify" ).val().length < 1 )
			{
				fnErrorMessage( "부서를 선택하세요." );
				return false;
			}
		}
		else
		{
			return false;
		}

		return true;
	}

	//user manage add
	function fnProcAdd()
	{
		boolModify = false;
		fnLoading( true );

		var boolValid = fnValid( "A" );

		if ( boolValid )
		{

			boolModify = true;
			var param = new Object();
			param = $( "#addForm" ).serialize();

			$.ajax( {
				url : "addAction" ,
				data : param ,
				type : 'POST' ,
				dataType : 'json' ,
				success : function( data )
				{
					fnModalOpen( 'modalConfirm' , false );

					console.log( "addAction result : " + data.resultMsg );

					if ( data.resultMsg == "succ" )
					{
						fnResultMessage( "SUCCESS_LIST_AJAX" , "addForm" , "계정 추가" , "입력하신 계정이 추가되었습니다." );
					}
					else if ( data.resultMsg == "alreadyExists" )
					{

						fnResultMessage( "ALREADY_EXISTS" , "addForm" , "계정 추가" , "이미 사원번호가 존재합니다." );
					}
					else
					{
						fnResultMessage( "Warning" , "addForm" , "계정 추가" , data.resultMsg );
					}
				} ,
				error : function( e )
				{
					fnErrorMessage( "Error! " + e );
				} ,
				complete : function()
				{
					fnLoading( false );
				}
			} );
		}
		else
		{
			fnLoading( false );
		}
	}

	function fnChangeDept( type )
	{
		$( "#dept" + type ).val( $( "#deptList" + type + " option:selected" ).val() );
		$( "#deptNm" + type ).val( $( "#deptList" + type + " option:selected" ).text() );
	}
</script>

<!-- <link href="/dist/css/style.min.css" rel="stylesheet"> -->
<!-- <script type="text/javascript" charset="utf-8" src="/scripts/js/paging.js"></script> -->
<!-- <script type="text/javascript" charset="utf-8" src="/scripts/js/sortColumn.js"></script> -->

<!-- <script src="https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script> -->
<!-- <script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script> -->
<!-- <script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script> -->
<!-- <script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js"></script> -->


<!-- pickadate -->
<link rel="stylesheet" type="text/css" href="/assets/libs/pickadate/lib/themes/default.css">
<link rel="stylesheet" type="text/css" href="/assets/libs/pickadate/lib/themes/default.date.css">
<link rel="stylesheet" type="text/css" href="/assets/libs/pickadate/lib/themes/default.time.css">

<script src="/assets/libs/pickadate/lib/compressed/picker.js"></script>
<script src="/assets/libs/pickadate/lib/compressed/picker.date.js"></script>
<script src="/assets/libs/pickadate/lib/compressed/picker.time.js"></script>
<script src="/assets/libs/pickadate/lib/compressed/legacy.js"></script>
<script src="/assets/libs/moment/moment.js"></script>
<script src="/assets/libs/daterangepicker/daterangepicker.js"></script>