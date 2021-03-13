<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" 	isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%-- <c:set var="product"  value="${productMap.productVO}"  /> --%>
<c:set var="imageList"  value="${productMap.imageList }"  /> 
<%
  request.setCharacterEncoding("UTF-8");
%>  
 
<html>
<head>
	
</head>
<body>
	<h2>상품 리스트</h2>
    <div class="main_book">
	   <c:set  var="product_count" value="0" />
		<h3>베스트셀러</h3>
		<c:forEach var="item" items="${productMap.bestseller }">
		   <c:set  var="product_count" value="${product_count+1 }" />
			<div class="book">
				<a href="${contextPath}/product/productDetail.do?product_no=${item.product_no }">
					<%-- <img class="link" src="${contextPath}/resources/image/1px.gif">  --%>
					
					 상품이미지
				</a> 
					<img width="121" height="154" 
					     src="${contextPath}/thumbnails.do?product_no=${item.product_no}&fileName=${item.file_name}">
	
				<div class="title">${item.product_name }</div>
				<div class="price">
			  	   <fmt:formatNumber  value="${item.sale_price}" type="number" var="sale_price" />
			          ${sale_price}원
				</div>
			</div>
		   <c:if test="${product_count==15   }">
	         <div class="book">
	           <font size=20> <a href="#">more</a></font>
	         </div>
	     </c:if>
	  </c:forEach>
	</div>

   
</body>
</html>
