<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="member_id" value="${sessionScope.member }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${path }/resources/css/style.css" />
</head>
<body>
<br><br>
	<c:if test="${empty member_id && member_id == null }">
	    <jsp:forward page="/member/loginForm.do"/>
	</c:if>
	<c:if test="${not empty member_id && member_id != null }">
	    <a href="${path }/member/updateMyInfoForm.do?member_id=${member_id}">내 정보 수정</a>
	    <a href="${path }/order/orderList.do">주문 내역</a>
	    <a href="${path }/cart/myCartList.do">장바구니</a>
	    <a href="${path }/review/myreviewList.do">상품 후기</a>
	</c:if>
</body>
</html>