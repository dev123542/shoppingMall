<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 상세 내역</title>
<style type="text/css">
	#content{height:800px;}
	section#content ul li { border:5px solid #eee; padding:10px 20px; width: 600px; margin:0 auto 10px; }
 	section#content .orderList span { font-size:20px; font-weight:bold; display:inline-block; width:90px; margin-right:10px; }
 	.homeBtn{
 		text-align:center;
 		margin-top:20px;
 	}
 	.comple-wrap{
 		margin-top:40px;
 	}
 	
 	 .orderInfo { border:5px solid #eee; padding:10px 20px; margin:20px 0;}
	 .orderInfo span { font-size:20px; font-weight:bold; display:inline-block; width:90px; }
	 
	 .orderView li { margin-bottom:20px; padding-bottom:20px; border-bottom:1px solid #999; }
	 .orderView li::after { content:""; display:block; clear:both; }
	 
	 .thumb { float:left; width:200px; }
	 .thumb img { width:200px; height:200px; }
	 .gdsInfo { float:right; width:calc(100% - 220px); line-height:2; }
	 .gdsInfo span { font-size:20px; font-weight:bold; display:inline-block; width:100px; margin-right:10px; }
</style>
</head>
<body>

	<section id="content">
	 	<ul class="orderView">
		  <c:forEach items="${orderView}" var="orderView">     
			  <li>
			   <div class="thumb">
			    	<img src="${contextPath }/thumbnails.do?product_no=${orderView.product_no}&fileName=${orderView.product_image}"/>
<%-- 			    	<img src="${orderView.gdsThumbImg}" /> --%>
			   </div>
			   <div class="gdsInfo">
			    <p>
				     <span>상품명</span>${orderView.product_name }<br />
				     <span>개당 가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.origin_price}" /> 원<br />
				     <span>구입 수량</span>${orderView.cartStock} 개<br />
				     <span>최종 가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.total_goods_price}" /> 원                  
<%-- 				     <span>최종 가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.origin_price * orderView.cartStock}" /> 원                   --%>
			    </p>
			   </div>
			  </li>     
		  </c:forEach>
	   </ul>

	</section>
</body>
</html>