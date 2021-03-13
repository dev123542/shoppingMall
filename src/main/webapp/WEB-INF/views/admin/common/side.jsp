<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Dashboard">
  <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
  <title></title>
</head>

<body>
<!--   <section id="container"> -->
    
        <!--sidebar start-->
    <aside>
      <div id="sidebar" class="nav-collapse ">
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">
<%--           <li class="mt">
             <a href="${contextPath }/admin/main.do"> 
             <a  class="active" href="${contextPath }/admin/adminMain.do"> 
              <i class="fa fa-dashboard"></i>
              <span>메인</span>
              </a>
          </li> --%>
          <li class="sub-menu">
           <!--  <a  class="active" href="javascript:;"> -->
            <a href="javascript:;">
              <i class="fa fa-desktop"></i>
              <span>회원</span>
              </a>
            <ul class="sub">
              <li><a href="${contextPath }/admin/member/memberList.do">회원 목록</a></li>
              <li><a href="${contextPath }/admin/member/memberActivity.do">회원 활동 정보</a></li>
              <li><a href="${contextPath }/admin/member/memberChart.do">회원활동 통계</a></li>
            </ul>
          </li>
          <li class="sub-menu">
            <a href="javascript:;">
              <i class="fa fa-cogs"></i>
              <span>상품</span>
              </a>
            <ul class="sub">
              <li><a href="${contextPath }/admin/product/productList.do">상품 관리</a></li>
              <li><a href="${contextPath }/admin/product/addNewProductForm.do">상품 등록</a></li>
              <li><a href="${contextPath }/admin/order/adminOrderList.do">주문/배송 관리</a></li>
<!--               <li class="active"><a href="order.html">주문/배송 관리</a></li> -->
            </ul>
          </li>
        </ul>
        <!-- sidebar menu end-->
      </div>
    </aside>
    <!--sidebar end-->
    
      
<!--   </section> -->
</body>
</html>