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
  <title>회원 목록</title>
</head>

<body>
  <section id="container" style="background: #fff;">
    
     <!--main content start-->
    <section id="main-content">
      <section class="wrapper site-min-height" style="background: #fff;">
        <h3><i class="fa fa-angle-right"></i> 회원 목록</h3>
        
        <div style="margin-bottom:40px;">
          <form action="${contextPath }/admin/membmer/memberList.do" method="post" id="frm_search">
            <table style="margin:0 auto;">
              <thead>
                <tr>
                  <th colspan="5" style="text-align: center; font-size: 20px; padding:17px 2px; width:70%;">회원 검색</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td colspan="2"  style="padding:5px 2px;">회원 이름</td>
                  <td colspan="5" style="padding:5px 2px;">
                    <input type="text" name="member_name" placeholder="회원 이름을 입력하세요" id="member_name" class="form-control" />				
                   </td>
                </tr>
                
                <tr>
                  <td colspan="2"  style="padding:5px 2px;">회원 분류</td>
                  <td colspan="5" class="pleft"  style="padding:5px 2px; display: flex;"> 
                    
                    <select id="order_total_buy" name="order_total_buy" class="form-control">
                      <option value="" selected>-- 총 결제금액 분류 선택 --</option>
                      <option value="total_buy_desc">결제금액 많은 순</option>
                      <option value="total_buy_asc">결제금액 적은 순</option>
                    </select>
                    
                    <select id="order_total_order" name="order_total_order" class="form-control">
                      <option value="" selected>-- 총 결제횟수 분류 선택 --</option>
                      <option value="total_order_desc">결제횟수 많은 순</option>
                      <option value="total_order_asc">결제횟수 적은 순</option>
                    </select>
                    
                  
                   </td>
                </tr>
                <tr>
                  <td colspan="7" style="text-align: center; padding:14px 2px;">
                    <input type="button" value="검색" class="btn btn-primary" />&nbsp;&nbsp;
                    <input type="reset" value="초기화" class="btn btn-warning"/>
                  </td>
                </tr>

              </tbody>
            </table>
          </form>
        </div>
        
        <!-- /col-md-12 -->
        <div class="col-md-12 mt">
            <div class="">
              <table class="table table-hover" style="border-top:1px solid; border-bottom:1px solid; text-align: center;">
                <thead>
                  <tr>
                    <!-- <th>#</th> -->
                    <th style="text-align: center;">회원 아이디</th>
                    <th style="text-align: center;">회원 이름</th>
                    <th style="text-align: center;">회원 이메일</th>
                    <th style="text-align: center;">회원 전화번호</th>
                    <th style="text-align: center;">총 결제 금액</th>
                    <th style="text-align: center;">총 결제 횟수</th>
                    <th style="text-align: center;">회원 가입일</th>
                  </tr>
                </thead>
                <tbody>
                <c:forEach items="${list }" var="list">
                	<c:url var="link" value="selectMember.do">
                		<c:param name="member_id" value="${list.member_id }" />
                	</c:url>
                  <tr>
                    <td><a href="${link }" style="text-decoration:underline;">${list.member_id }</a></td>
                    <td>${list.member_name }</td>
                    <td>${list.email }</td>
                    <td>${list.phone }</td>
                    <td>100,000원</td>
                    <td>2회</td>
                    <td>${list.member_credate }</td>
                  </tr>
                </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
      
      <%-- </section>
		<ul style="list-style:none; display:flex; justify-content: space-between;">
			<c:if test="${pagevo.prev }">
				<li><a href="boardList.do?page=${pagevo.startPage -1 }">이전</a></li>
			</c:if>
			
			<c:forEach begin="${pagevo.startPage }" end="${pagevo.endPage }" var="idx">
				<li><a href="boardList.do?page=${idx }"><c:url value="${idx }" /></a></li>
			</c:forEach>
			
			<c:if test="${pagevo.next && pagevo.endPage > 0 }">
				<li><a href="boardList.do?page=${pagevo.endPage +1 }">다음</a></li>
			</c:if>
		</ul>
    </section> --%>
    <!--main content end-->
  </section>
</body>
</html>