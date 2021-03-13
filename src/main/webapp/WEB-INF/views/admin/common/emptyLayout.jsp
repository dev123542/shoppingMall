<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
  request.setCharacterEncoding("utf-8");
%>
<head>
<meta charset="utf-8">
<!-- <style type="text/css">
	.admin-body{
		width:100%;
		height:2000px;
	}
</style> -->
</head>
<body>
	<div class="admin-empty-layout">
		<tiles:insertAttribute name="content" />
	</div>

</body>

