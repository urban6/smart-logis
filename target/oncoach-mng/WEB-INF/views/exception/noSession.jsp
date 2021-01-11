<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<div class="error">
	<div class="info">
		<header>
			<h1>물류 공유해</h1>
			<span>
				<spring:message code="label.common.err.subject" />
			</span>
		</header>
		<h2>You have been signed out</h2>
		<%-- <p><spring:message code="label.common.err.not.found"/></p> --%>
		<button href="#" onclick="javascript:fnCloseConfirm();">
			<spring:message code="label.common.ok" />
		</button>
	</div>
</div>