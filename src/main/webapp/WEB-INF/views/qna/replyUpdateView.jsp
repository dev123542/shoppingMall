<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>게시판</title>
</head>
<script type="text/javascript">
$(document).ready(function(){
	var formObj = $("form[name='updateForm']");
	
	$(".cancel_btn").on("click", function(){
		location.href = "${path }/qna/readView?bno=${replyUpdate.bno}"
			   + "&page=${scri.page}"
			   + "&perPageNum=${scri.perPageNum}"
			   + "&searchType=${scri.searchType}"
			   + "&keyword=${scri.keyword}";
	})
	
})

</script>
<body>

<div id="root">
<header>
<h1> 게시판</h1>
</header>
<hr />
	 
<div>
	<%@include file="nav.jsp" %>
</div>
<hr />

<section id="container">
	<form name="updateForm" role="form" method="post" action="${path }/qna/replyUpdate">
		<input type="hidden" name="bno" value="${replyUpdate.bno}" readonly="readonly"/>
		<input type="hidden" id="rno" name="rno" value="${replyUpdate.rno}" />
		<input type="hidden" id="page" name="page" value="${scri.page}"> 
		<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
		<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
		<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
		<table>
			<tbody>
				<tr>
					<td>
						<label for="content">댓글 내용</label><input type="text" id="content" name="content" value="${replyUpdate.content}"/>
							</td>
						</tr>	
						
					</tbody>			
				</table>
				<div>
					<button type="submit" class="update_btn">저장</button>
					<button type="button" class="cancel_btn">취소</button>
				</div>
			</form>
</section>
<hr />
</div>
</body>
</html>