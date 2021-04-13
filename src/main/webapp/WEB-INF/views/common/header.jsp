<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="member_id" value="${sessionScope.member }" />
<%
  request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- <title><tiles:insertAttribute name="header" /></title> --%>
</head>
<body>
<!-- <div class="body__container"> -->
    <div class="header_container">   
        <div class="topgnb inbox">
            <ul class="topgnb__left">
                <li><a href=""><span class="txt_big">★</span>FAVORITE</a></li>
                <li><a href="">NOTICE</a></li>
                <li><a href="">EVENT</a></li>
                <li><a href="">SHOW ROOM</a></li>
                <li><a href="">PHOTO REVIEW</a></li>
                <li><a href="${path }/qna/list.do">Q&amp;A</a></li>
            </ul>
            <c:if test="${empty sessionScope.member && sessionScope.member == null && empty sessionScope.admin && sessionScope.admin == null }">
	            <ul class="topgnb__right">
	                <li><a href="${path }/member/loginForm.do">LOGIN</a></li>
	                <li><a href="${path }/member/signUpForm.do">JOIN</a></li>
	                <li><a href="${path }/cart/myCartList.do">CART</a></li>
	                <li><a href="${path }/member/loginForm.do">MY PAGE</a></li>
	                <li><a href="">ORDER</a></li>
	            </ul>
            </c:if>
            <c:if test="${not empty sessionScope.member && sessionScope.member != null }">
				<ul class="topgnb__right">
	                <li><a href="${path }/member/logout.do">LOGOUT</a></li>
	                <%-- <li><a href="${path }/member/updateMyInfoForm.do?member_id=${member_id}">MODIFY</a></li> --%>
	                <li><a href="${path }/cart/myCartList.do">CART</a></li>
	                <li><a href="${path }/member/myPageForm.do">MY PAGE</a></li>
	                <li><a href="">ORDER</a></li>
	            </ul>
			</c:if>
        </div>
      
        <div class="top inbox">
            <header id="top" class="header">
                <h1 class="top__logo"><a href="${path }/">THEBAG</a></h1>
            </header>
            <div class="top__form">
                <form action="" method="post" name="search">
                    <input name="search" class="input" value="" onkeydown="" onclick=""/>
                    <a href="">
                        <svg width="20" height="20">
                            <g><path class="search_svg" d="M19.7,17.3l-3.9-3.9c-0.2-0.2-0.4-0.2-0.6-0.2h-0.6c1.1-1.4,1.7-3.1,1.7-5c0-4.5-3.6-8.1-8.1-8.1S0,3.6,0,8.1
                                    s3.6,8.1,8.1,8.1c1.9,0,3.6-0.6,5-1.7v0.6c0,0.2,0.1,0.5,0.2,0.6l3.9,3.9c0.3,0.3,0.9,0.3,1.3,0l1.1-1.1
                                    C20.1,18.2,20.1,17.6,19.7,17.3z M8.1,13.1c-2.7,0-5-2.2-5-5s2.2-5,5-5s5,2.2,5,5S10.9,13.1,8.1,13.1z"/></g>
                        </svg>
                    </a>
                </form>				
            </div>
        </div>  <!-- //top -->
        <div class="gnb inbox">
            <nav id="gnb" class="nav">
                <ul>
                	<%-- <li><a href="${path }/product/newProductList.do?sort=order">NEW</a></li>
                    <li><a href="${path }/product/newProductList.do?sort=sellcnt">BEST</a></li> --%>
                    <%-- <li><a href="${path }/product/newProductList.do?sort=new">NEW</a></li>
                    <li><a href="${path }/product/newProductList.do?sort=best">BEST</a></li>
                    <li><a href="${path }/product/newProductList.do?sort=itbag">IT BAG</a></li> --%>
                   <%--  <li><a href="${path }/product/newProductList.do?sort=100">LEATHER BAG</a></li> --%>
                    
                    
                    
                <ul class="gnb__ul">
                <!-- 테스트 -->
<%--                 <li class="dep01"><a href="${path }/product/newProductList.do?s=new">NEW</a></li>
                <li class="dep01"><a href="${path }/product/newProductList.do?sort=best">BEST</a></li>
                <li class="dep01"><a href="${path }/product/newProductList.do?sort=itbag" >IT BAG</a></li>
                <li><a href="${path }/product/newProductList.do?sort=100">LEATHER BAG</a>
                <li class="dep02"><a href="${path }/product/newProductList.do?sort=100&cate_name=토트백">토트백</a></li>
                <li class="dep02"><a href="${path}/product/newProductList.do?sort=100&cate_name=숄더백">숄더백</a></li>
                <li class="dep01"><a href="${path }/product/newProductList.do?sort=200" >TREAD BAG</a>
                <li class="dep02"><a href="${path }/product/newProductList.do?sort=200&cate_name=토트백">토트백</a></li> --%>
                
                
                
                <!-- 원본 -->
                    <li class="dep01"><a href="${path }/product/newProductList.do?s=new">NEW</a></li>
<%--                     <li class="dep01"><a href="${path }/product/newProductList.do?sort=new">NEW</a></li> --%>
                    <li class="dep01"><a href="${path }/product/newProductList.do?sort=best">BEST</a></li>
                    <li class="dep01"><a href="${path }/product/newProductList.do?sort=itbag" >IT BAG</a></li>
                    <li class="dep01"><a href="${path }/product/newProductList.do?sort=100">LEATHER BAG</a>
<%--                     <li><a href="${path }/product/leatherBagList.do?sort=order">LEATHER BAG</a> --%>
                        <ul class="sub">
                        <!-- 테스트용 -->
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=100&cate_name=토트백">토트백</a></li>
                            <%-- <li class="dep02"><a href="${path}/product/productDetail.do?product_no=1">토트백</a></li> --%>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=100&cate_name=숄더백">숄더백</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=100&cate_name=크로스백">크로스백</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=100&cate_name=모터백">모터백</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=100&cate_name=백팩">백팩</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=100&cate_name=패브릭백">패브릭</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=100&cate_name=클러치백">클러치</a></li>
                        </ul>
                    </li>
                    <li class="dep01"><a href="${path }/product/newProductList.do?sort=200" >TREAD BAG</a>
                        <ul class="sub">
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=200&cate_name=토트백">토트백</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=200&cate_name=숄더백">숄더백</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=200&cate_name=크로스백">크로스백</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=200&cate_name=모터백">모터백</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=200&cate_name=백팩">백팩</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=200&cate_name=패브릭백">패브릭</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=200&cate_name=여행 가방">여행가방</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=200&cate_name=클러치백">클러치</a></li>
                        </ul>
                    </li>
                    <li class="dep01"><a href="${path }/product/newProductList.do?sort=300" >ECO BAG</a>
                        <ul class="sub">
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=300&cate_name=토트백">토트백</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=300&cate_name=숄더백">숄더백</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=300&cate_name=크로스백">크로스백</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=300&cate_name=투웨이백">투웨이백</a></li>
                        </ul>
                    </li>
                    <li class="dep01"><a href="${path }/product/newProductList.do?sort=400" >WALLET</a>
                        <ul class="sub">
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=400&cate_name=지갑">지갑</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=400&cate_name=멀티지갑">멀티지갑</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=400&cate_name=커버케이스">커버케이스</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=400&cate_name=카드지갑">카드지갑</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=400&cate_name=동전지갑">동전지갑</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=400&cate_name=파우치">파우치</a></li>
                        </ul>
                    </li>
                    <li class="dep01"><a href="${path }/product/newProductList.do?sort=500" >SHOES</a>
                        <ul class="sub">
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=500&cate_name=플랫">플랫</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=500&cate_name=구두">구두</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=500&cate_name=로퍼">로퍼</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=500&cate_name=스니커즈">스니커즈</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=500&cate_name=부츠">부츠</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=500&cate_name=샌들">샌들</a></li>
                        </ul>
                    </li>
                    <li class="dep01"><a href="${path }/product/newProductList.do?sort=600" >BAG ACC</a>
                        <ul class="sub">
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=600&cate_name=참장식">참장식</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=600&cate_name=스트랩">스트랩</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=600&cate_name=트윌리">트윌리</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=600&cate_name=왁스">왁스</a></li>
                        </ul>
                    </li>
                    <li class="dep01"><a href="${path }/product/newProductList.do?sort=700" >ACCESSORY</a>
                        <ul class="sub">
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=700&cate_name=스카프">스카프</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=700&cate_name=양말">양말</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=700&cate_name=모자">모자</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=700&cate_name=벨트">벨트</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=700&cate_name=안경">안경</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=700&cate_name=시계">시계</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=700&cate_name=목걸이">목걸이</a></li>
                            <li class="dep02"><a href="${path }/product/newProductList.do?sort=700&cate_name=타투">타투</a></li>
                        </ul>
                    </li>

                </ul>
                <div class="sub_bg"></div>
                    
                    
                    
                    
                </ul>
            </nav>
        </div> <!-- //gnb -->
    </div>
<!-- </div> -->
</body>
</html>