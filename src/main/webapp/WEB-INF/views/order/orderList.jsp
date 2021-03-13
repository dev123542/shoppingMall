<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 내역</title>
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
</style>
</head>
<body>

	<section id="content">
	 	<div class="comple-wrap">
			 <ul class="orderList">
				  <c:forEach items="${orderList}" var="orderList">
					  <li>
						  <div>
							   <p><span>주문번호</span><a href="${contextPath }/order/orderView.do?n=${orderList.order_no}">${orderList.order_no}</a></p>
							   <p><span>수령인</span>${orderList.orderRec}</p>
							   <p><span>주소</span>(${orderList.member_add1}) ${orderList.member_add2} ${orderList.member_add3}</p>
							   <p><span>가격</span><fmt:formatNumber pattern="###,###,###" value="${orderList.total_goods_price}" /> 원</p>
							   <p><span>결제일</span><fmt:formatDate pattern="yyyy-MM-dd" value="${orderList.order_date}"/></p>
							   <p><span>배송상태</span>${orderList.status }</p>
						  </div>
					  </li>
				  </c:forEach>
			 </ul>
			 
	 	</div>

	</section>
</body>
</html>