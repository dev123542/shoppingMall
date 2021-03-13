<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>ShoppingMall</title>
	
	
</head>
<body>
<br><br>
<div id="contentWrapper">
<div id="contentWrap">
	<div id="content">
		<div id="main">
		
			<div class="swiper-container banner inbox">
	            <div class="swiper-wrapper banner__wrap">
	                <div class="swiper-slide">
	                    <div class="main001">
	                        <a href="${path }/"><img src="${path }/resources/image/main_banner_01.jpg"></a><!--배너 1-->
	                    </div>
	                </div> <!--//.swiper-slide 1-->
	                <div class="swiper-slide">
	                    <div class="main002">
	                        <a href="${path }/"><img src="${path }/resources/image/main_banner_02.jpg"></a><!--배너 2-->
	                    </div>
	                </div> <!--//.swiper-slide 2-->
	                <div class="swiper-slide">
	                    <div class="main003">
	                        <a href="${path }/"><img src="${path }/resources/image/main_banner_03.jpg"></a><!--배너 3-->
	                    </div>
	                </div> <!--//.swiper-slide 3-->
	                <div class="swiper-slide">
	                    <div class="main004">
	                          <a href="${path }/"><img src="${path }/resources/image/main_banner_04.jpg"></a><!--배너 4-->
	                    </div>
	                </div> <!--//.swiper-slide 4-->
					<div class="swiper-slide">
	                    <div class="main005">
	                          <a href="${path }/"><img src="${path }/resources/image/main_banner_05.jpg"></a><!--배너 5-->
	                    </div>
	                </div> <!--//.swiper-slide 5-->
	            </div> <!--//.banner__wrap-->
	            
	            <!-- image direction area -->
	            <div class="swiper-pagination"></div> <!-- Add Pagination -->
	            <div class="swiper-button-prev"></div> <!-- Add Arrows -->
	            <div class="swiper-button-next"></div> <!-- Add Arrows -->
	        </div> <!-- //.swiper-container  //-->
					
			<!-- Swiper JS -->
			<script src="${path }/resources/js/swiper.min.js"></script>
			<script src="${path }/resources/js/swiper.esm.bundle.js"></script>
			<script src="${path }/resources/js/swiper.esm.browser.bundle.min.js"></script>
			<!-- Initialize Swiper -->
			<script src="${path }/resources/js/myswiper.js"></script>
			
			
			
			<!-- css 안겹치게 클래스명 변경 -->	
			<!-- ============ 메인갤러리 밑 3X1 배너 ============ -->
			<div class="small_banner inbox">
				<div>
	       			<ul class="small_banner__wrap">
						<li class="sbn_01">
							<a href="${path }/"><img src="${path }/resources/image/group01-banner01.jpg" alt="배너1"></a>
							<dl>
								<dt class="tit">PHOTO REVIEW</dt>
								<dd class="txt">고객님들의 정성스러운 상품후기</dd>
							</dl>
						</li>
						<li class="sbn_02">
							<a href="${path }/"> <img src="${path }/resources/image/group01-banner02.jpg" alt="배너2"></a>
							<dl>
								<dt class="tit">BAG CHARM</dt>
								<dd class="txt">가방을 돋보이게 하는 참장식</dd>
							</dl>
						</li>
						<li class="sbn_03">
							<a href="${path }/"><img src="${path }/resources/image/group01-banner03.jpg" alt="배너3"></a>
							<dl>
								<dt class="tit">후즈백 특별세일</dt>
								<dd class="txt">최대80% ~ 한정수량 득템찬스 </dd>
							</dl>
						</li>
					</ul>
				</div>
			</div>
			<!-- ============ 메인갤러리 밑 3X1 배너:END ============ -->

			<br><br>
			<!-- ============ 메인상품목록 ============ -->
			 <div id="SMS_main_prd_display" class="SMS_main_prd_display inbox" >
			   <c:set  var="product_count" value="0" />
			   <br><br>
			   <div class="prd-title">
					<div class="tx"> 
						<div class="tit"><span>NEW ARRIVALS</span></div>
						<div class="line"></div>
					</div>
					<div class="sub">매일 새로운 신상품</div>
				</div>
				<br><br>
				
				<div class="SMS_main_display_prd"  style="margin: 0 auto; width: 890px;">
					<ul class="cb_clear">
					<c:forEach var="item" items="${productList}">
						   <c:set  var="product_count" value="${product_count+1 }" />
								
							<li class="SMS_float_left">
								<ul class="SMS_relative">
									<li class="SMS_main_display_thumnail">
									<a href="${path}/product/productDetail.do?product_no=${item.product_no }">
										<img class="MS_prod_img_s" 
										src="${path}/thumbnails.do?product_no=${item.product_no}&fileName=${item.product_image}" alt="상품 섬네일"> 
									</a>
									</li>
									
								<li class="SMS_main_display_name">${item.product_name }</li>
									<li class="SMS_main_display_price">
										<span class="new_discount_icon red">
											<%-- <img src="${path }/resources/image/pro_discount_2.gif"> --%>
											<c:if test="${item.product_sort == '신상품'}">NEW ${item.discount_rate}%</c:if>
										</span>
										<span class="new_discount_icon blue">
											<%-- <img src="${path }/resources/image/pro_discount_2.gif"> --%>
											<c:if test="${item.product_sort == '베스트'}">BEST</c:if>
										</span>
										<span class="new_discount_icon green">
											<%-- <img src="${path }/resources/image/pro_discount_2.gif"> --%>
											<c:if test="${item.product_sort == '잇백'}">ITBAG</c:if>
										</span>
										
										
						              	<fmt:formatNumber value="${item.origin_price }" type="number" var="origin_price" />
						              	<c:if test="${item.sale_price != 0 }">
											<span class="SMS_main_display_sales_p strike">
												${origin_price }원
											</span>
								            <fmt:formatNumber value="${item.sale_price }" type="number" var="sale_price" />
								            <span class="SMS_main_display_discount_p">
								                ${sale_price }원
								            </span>
										</c:if>
										<c:if test="${item.sale_price == 0 }">
											<span class="SMS_main_display_discount_p">
								                ${origin_price }원
								            </span>
										</c:if>	 
						              </li>
						              
								</ul>
							</li>
							
						<%-- <c:if test="${product_count==15  }">
					         <div class="p_count">
					           <font size=20> <a href="#">more</a></font>
					         </div>
					    </c:if> --%>
					        
				  	</c:forEach>
				  	</ul>
			   	</div><!-- #SMS_main_display_prd -->
			</div><!-- #main_product end -->
			<!-- ============ 메인상품목록 끝 ============ -->
			
	
		</div><!-- #main end -->
	</div><!-- #content end -->
</div><!-- #contentWrap end -->
 </div><!-- #contentWrapper end -->
<br><br>
</body>
</html>