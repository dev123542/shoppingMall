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
<meta name="viewport" content="width=device-width">
<!-- 파비콘 추가 -->
<link href="${contextPath}/resources/img/favicon.png" rel="icon">
<link href="${contextPath}/resources/css/style.css" rel="stylesheet" type="text/css" media="screen">
<link href="${contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" media="screen">
<link href="${contextPath}/resources/css/main2.css" rel="stylesheet" type="text/css" media="screen">
<link href="${contextPath}/resources/css/swiper.min.css" rel="stylesheet" >
<script src="${contextPath}/resources/js/jquery-1.6.2.min.js" type="text/javascript"></script>
<script src="${contextPath}/resources/js/tabs.js" type="text/javascript"></script>
<title><tiles:insertAttribute name="title" /></title>

</head>
<body>
	<div id="outer_wrap">
		<div id="wrap">
			<header>
				<tiles:insertAttribute name="header" />
			</header>
			<div class="clear"></div>
			<article>
				<tiles:insertAttribute name="body" />
			</article>
			<div class="clear"></div>
			<footer>
				<tiles:insertAttribute name="footer" />
			</footer>
		</div>
	</div>
</body>

