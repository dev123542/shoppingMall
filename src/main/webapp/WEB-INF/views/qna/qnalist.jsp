<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
</head>
<body>
<div id="root">
	<hr />
	 
	<nav>
	  홈 - 글 작성
	</nav>
	<hr />
	
	<section id="container">
			<form role="form" method="post" action="${path }/qna/write.do">
				<table>
					<tr><th>번호</th><th>제목</th><th>작성자</th><th>등록일</th></tr>
					
					<c:forEach items="${qnalist}" var = "list">
						<tr>
							<td><c:out value="${list.bno}" /></td>
							<td>
								<a href="${path }/qna/readView?bno=${list.bno}"><c:out value="${list.title}" /></a>
							</td>
							<td><c:out value="${list.writer}" /></td>
							<td><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd"/></td>
						</tr>
					</c:forEach>
					
				</table>
			</form>
	</section>
	<hr />
</div>
</body>
</html>