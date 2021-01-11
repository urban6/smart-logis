<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="error">
	<div class="info">
		<header>
			<h1>물류 공유해</h1>
			<span>
				<spring:message code="label.common.err.subject" />
			</span>
		</header>
		<h2>Exception</h2>
		<p>JSTL Exception</p>
		<button href="#" onclick="javascript:fnCloseConfirm();">
			<spring:message code="label.common.ok" />
		</button>
	</div>
</div>
