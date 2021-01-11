<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>물류 공유해</title>
</head>

<body>
	<form name="frm"></form>
	<script type="text/javascript">
		document.frm.action="<%=request.getContextPath()%>/user/login/login";
		document.frm.target = "_parent";
		document.frm.method = "post";
		document.frm.submit();
	</script>
</body>


</html>