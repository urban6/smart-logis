<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/shovvel.tld" prefix="shovvel"%>
<%@ page import="kr.co.shovvel.dm.common.Consts"%>



<body>
	<div class="main-wrapper">
		<div class="preloader">
			<div class="lds-ripple">
				<div class="lds-pos"></div>
				<div class="lds-pos"></div>
			</div>
		</div>

		<div class="auth-wrapper d-flex no-block justify-content-center align-items-center" style="background: url(/assets/images/background/login_image.jpg) no-repeat center center; background-size: cover;">
			<div class="auth-box" style="position: relative;margin:15% 0;">
				<div id="loginform">
					<!-- <div class="logo">
						<span class="db">
							<img src="/image/snuh_main_img_main.png" alt="logo" style="padding-top: 3px;"/>
						</span>
						
					</div> -->
					<!-- Form -->
					<div class="row">
						<div class="col-12">

							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1">
										<i class="ti-user"></i>
									</span>
								</div>
								<!-- <input type="text" id="id" class="form-control form-control-lg" placeholder="사원번호" aria-label="id" aria-describedby="basic-addon1" value="superadmin"> -->
								<input type="text" id="id" class="form-control form-control-lg" placeholder="사원번호" aria-label="id" aria-describedby="basic-addon1" value="" style="background: none" />
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon2">
										<i class="ti-pencil"></i>
									</span>
								</div>
								<!-- <input type="password" id="password" class="form-control form-control-lg" placeholder="비밀번호" aria-label="Password" aria-describedby="basic-addon1" value="Password1!"> -->
								<input type="password" id="password" class="form-control form-control-lg" placeholder="비밀번호" aria-label="Password" aria-describedby="basic-addon1" value="123456" style="background: none">
							</div>
							<div class="form-group row">
								<div class="col-md-12">
									<div class="custom-control custom-checkbox">
										<input type="checkbox" class="custom-control-input" name="storedId" id="storedId">
										<label class="custom-control-label label-color-black" for="storedId">사원번호 저장</label>
										<a href="javascript:void(0)" id="to-recover" class="text-dark float-right">
											<i class="fa fa-lock mr-1"></i>
											XXXXX
										</a>
									</div>
								</div>
							</div>
							<div class="form-group text-center">
								<div class="col-xs-12 pb-3">
									<button id="btnLogin" class="btn btn-block btn-lg btn-primary">Log In</button>
								</div>
								<div class="col-xs-12 pb-3">
									<button id="btnJoin" class="btn btn-block btn-lg btn-primary">Join</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="recoverform">
					<div class="logo">
						<span class="db">
							<img src="/image/snuh_main_img_main.png" alt="logo"  style="padding-top: 3px;"/>
						</span>
						<h5 class="font-medium mb-3">서울대학교병원 강남센터 관리자웹</h5>
					</div>
					<!-- Form -->
					<div class="row">
						<div class="col-12">
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1">
										<i class="ti-user"></i>
									</span>
								</div>
								<!-- <input type="text" id="loginId" name="loginId" class="form-control form-control-lg" placeholder="사원번호" aria-label="loginId" aria-describedby="basic-addon1" value="superadmin" style="background: none"> -->

								<input type="text" id="loginId" name="loginId" class="form-control form-control-lg" placeholder="사원번호" aria-label="loginId" aria-describedby="basic-addon1" style="background: none">
								<!-- <input type="text" id="id" class="form-control form-control-lg" placeholder="아이디" aria-label="id" aria-describedby="basic-addon1" value=""> -->
							</div>
							<div class="row" id="loginPassError">
								<div class="col-xs-12 pb-3"></div>
								<label class="label-color-black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;입력하신 사원번호를 찾을 수 없습니다.</label>
							</div>
							<div class="text-center">
								<div class="col-xs-12 pb-3">
									<button class="btn btn-lg btn-secondary" onclick="fnMoveAdminLogin()">취소</button>
									<button class="btn btn-danger btn-lg btn-primary" onclick="fnProcPasswdInit()">비밀번호 초기화</button>
								</div>
								<label class="label-color-black">회원가입은 관리자에게 문의해주시기 바랍니다.</label>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="loginPassModel" tabindex="-1" role="dialog" aria-labelledby="createModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="createModalLabel">
						<i class="ti-marker-alt mr-2"></i>
					</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>
	<script src="/assets/libs/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap tether Core JavaScript -->
	<script src="/assets/libs/popper.js/dist/umd/popper.min.js"></script>
	<script src="/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
	<script src="/assets/extra-libs/toastr/dist/build/toastr.min.js"></script>
	<script src="/assets/extra-libs/toastr/toastr-init.js"></script>
	<script>
		$( '[data-toggle="tooltip"]' ).tooltip();
		$( ".preloader" ).fadeOut();
		// ==============================================================
		// Login and Recover Password
		// ==============================================================
		$( '#to-recover' ).on( "click" , function()
		{
			$( "#recoverform" ).fadeIn();
			$( "#loginform" ).slideUp();
		} );
	</script>

	<!-- modal popup : start -->
	<%@include file="/WEB-INF/template/modalPopup.jsp"%>
	<!-- modal popup : end -->
</body>