<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="error_area">
	<div class="head">
		<div class="logo">
			<span class="hidden">물류 공유해</span>
		</div>
		<div class="tit">물류 공유해</div>
	</div>
	<div class="cont">
		<div class="tit">Exception</div>
		<div class="docu">${errorMsg}</div>
	</div>
	<div class="foot">
		<a href="javascript:fnCloseConfirm();" class="btn type_01 primary">OK</a>
	</div>
</div>
