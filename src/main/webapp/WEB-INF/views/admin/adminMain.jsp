<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- <c:if test="${empty sessionScope.member && sessionScope.member == null }"> --%>
		<h1>main 입니다~!!!!</h1>
		<a href="${path }/member/loginForm.do">회원관리</a>
		<a href="${path }/member/signUpForm.do">상품관리</a>
<%-- 	</c:if> --%>
</body>
</html>