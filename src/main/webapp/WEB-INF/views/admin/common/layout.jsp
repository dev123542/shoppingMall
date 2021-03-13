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
<title><tiles:insertAttribute name="title" /></title>
<link href="${contextPath}/resources/css/style.css" rel="stylesheet" type="text/css" media="screen">
<!-- Favicons -->
<link href="${contextPath }/resources/img/favicon.png" rel="icon">
<link href="${contextPath }/resources/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Bootstrap core CSS -->
<link href="${contextPath }/resources/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!--external css-->
<link href="${contextPath }/resources/lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="${contextPath }/resources/css/zabuto_calendar.css">
<link rel="stylesheet" type="text/css" href="${contextPath }/resources/lib/gritter/css/jquery.gritter.css" />
<!-- Custom styles for this template -->
<link href="${contextPath }/resources/css/style2.css" rel="stylesheet">
<link href="${contextPath }/resources/css/style-responsive.css" rel="stylesheet">
<script src="${contextPath }/resources/lib/chart-master/Chart.js"></script>
<style type="text/css">
	.admin-body{
		width:100%;
		height:2000px;
	}
</style>
</head>
<body>
	<div class="admin-layout">
		<div class="admin-layout-wrap">
			 <header class="admin-header">
				<tiles:insertAttribute name="header" />
			</header>
			<aside>
				<tiles:insertAttribute name="side" />
			</aside>
			<article class="admin-body">
				<tiles:insertAttribute name="body" />
			</article>
			<footer class="admin-footer">
				<tiles:insertAttribute name="footer" />
			</footer>  
		</div>
	</div>

<!-- js placed at the end of the document so the pages load faster -->
  <script src="${contextPath }/resources/lib/jquery/jquery.min.js"></script>

  <script src="${contextPath }/resources/lib/bootstrap/js/bootstrap.min.js"></script>
  <script class="include" type="text/javascript" src="${contextPath }/resources/lib/jquery.dcjqaccordion.2.7.js"></script>
  <script src="${contextPath }/resources/lib/jquery.scrollTo.min.js"></script>
  <script src="${contextPath }/resources/lib/jquery.nicescroll.js" type="text/javascript"></script>
  <script src="${contextPath }/resources/lib/jquery.sparkline.js"></script>
  <!--common script for all pages-->
  <script src="${contextPath }/resources/lib/common-scripts.js"></script>
  <script type="text/javascript" src="${contextPath }/resources/lib/gritter/js/jquery.gritter.js"></script>
  <script type="text/javascript" src="${contextPath }/resources/lib/gritter-conf.js"></script>
  <!--script for this page-->
  <script src="${contextPath }/resources/lib/sparkline-chart.js"></script>
  <script src="${contextPath }/resources/lib/zabuto_calendar.js"></script>
</body>

