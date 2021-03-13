<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<head>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>게시판</title>
</head>
<script type="text/javascript">
$(document).ready(function(){
	var formObj = $("form[name='updateForm']");
	
	$(".cancel_btn").on("click", function(){
		location.href = "${path }/qna/readView?bno=${replyDelete.bno}"
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
	<form name="updateForm" role="form" method="post" action="${path }/qna/replyDelete">
		<input type="hidden" name="bno" value="${replyDelete.bno}" readonly="readonly"/>
		<input type="hidden" id="rno" name="rno" value="${replyDelete.rno}" />
		<input type="hidden" id="page" name="page" value="${scri.page}"> 
		<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
		<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
		<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
					
				<div>
					<p>삭제 하시겠습니까?</p>
					<button type="submit" class="delete_btn">예 삭제합니다.</button>
					<button type="button" class="cancel_btn">아니오. 삭제하지 않습니다.</button>
				</div>
			</form>
		</section>
		<hr />
	</div>
</body>
</html>