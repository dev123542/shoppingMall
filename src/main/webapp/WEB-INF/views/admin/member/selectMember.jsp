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
  <title>회원 상세 보기</title>
</head>

<body>
  <section id="container" style="background: #fff;">
    
     <!--main content start-->
    <section id="main-content">
      <section class="wrapper site-min-height" style="background: #fff;">
        <h3><i class="fa fa-angle-right"></i> 회원 상세 정보</h3>
        
        <!-- /col-md-12 -->
          <div class="col-md-12 mt">
            <!-- <div class="content-panel"> -->
            <div class="">
              <table class="table table-hover" style="border-top:1px solid; border-bottom:1px solid; text-align: center;">
                <!-- <h4><i class="fa fa-angle-right"></i>회원 목록</h4> -->
                <!-- <hr> -->
                <thead>
                  <tr>
                    <!-- <th>#</th> -->
                    <th style="text-align: center;">회원 아이디</th>
                    <th style="text-align: center;">임시 카테고리</th>
                    <th style="text-align: center;">임시 카테고리</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>${membervo.member_id }</td>
                    <td>임시 카테고리</td>
                    <td>임시 카테고리</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
      </section>
    </section>
    <!--main content end-->
  </section>
</body>
</html>