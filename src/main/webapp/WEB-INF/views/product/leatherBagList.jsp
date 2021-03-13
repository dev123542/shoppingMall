<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" 	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>leatherBag</title>
  <script src="${contextPath }/resources/lib/jquery/jquery.min.js"></script>
  <script type="text/javascript">
  	// 인기, 신상품, 낮은가격, 높은 가격 정렬
  	 function sendsort(event){
   		if(event == 'sellcnt'){
  			location.href='newProductList.do?sort=sellcnt';
  		}
		if(event == 'order'){
			location.href='newProductList.do?sort=order';
  		}
		if(event == 'price'){
			location.href='newProductList.do?sort=price';
  		}
		if(event == 'price2'){
			location.href='newProductList.do?sort=price2';
  		} 
  	}
  	
  </script>
</head>
<body>
  <div id="contentWrapper" style="padding-top: 51px;">
    <div id="contentWrap">
      <div id="content">
        <div id="SMS_product_container">
	      	<div class="SMS_list_topModule01">
				<div class="SMS_title_image"><img src="${contextPath }/resources/image/CODE027.gif"></div>
	      	</div><!-- .prd-class-hd -->
        
	      	<div class="SMS_prd_subcate_box">
	         <div class="SMS_prd_subcate">
	          <dl class="class-list cb_clear">
	            <dt class="title"><img src="${contextPath }/resources/image/list_sub_catename.gif"></dt>
	            <dd>
	              <ul class="cb_clear">
		             <li>
		             	<a href="" class="b">
		              		<img src="${contextPath }/resources/image/sub_title_front_ico.gif"> TOTE <span class="normal">(60)</span>
		              	</a>
		             </li>
	              </ul>
	            </dd>
	          </dl><!-- .class-list -->
	        </div>
        
	    	<!-- total sort -->
		 	<div class="ttl-sort">
	          <div class="SMP-container">
	            <div class="total-sort-container cb_clear">
	              <dl class="total cb_clear">
	                <dt>CATEGORY total items : </dt>
	                <dd> ${total}</dd>
	              </dl>
	              <dl class="sort cb_clear">
	                <dt class="blind">검색결과 정렬</dt>
	                 <dd>	
	                  <a href="javascript:sendsort('sellcnt')"><span>인기상품</span></a>
	                 </dd>                    
	                <dd>
	                  <a href="javascript:sendsort('order');"><span class="on">신상품</span></a>
	                </dd>                       
	                <dd>
	                  <a href="javascript:sendsort('price')"><span>낮은가격</span></a>
	                </dd>                       
	                <dd>
	                  <a href="javascript:sendsort('price2')"><span>높은가격</span></a>
	                </dd>
	              </dl>
	            </div>
	          </div>
	     </div>

		<!-- product list start -->
		 <div id="SMS_prd_container">
	        <div class="item_container cb_clear">
	        <c:forEach var="list" items="${productList }">
	          <div class="item_list">
	            <ul>
	              <li class="thumb">
	                <a href="">
	                  <img class="MS_prod_img_s" src="${contextPath }/thumbnails.do?product_no=${list.product_no}&fileName=${list.product_image}" alt="상품 섬네일">
	                </a>
	              </li>
	              <li class="pname">
	              	${list.product_name }<br/>
	              	${list.product_color }
	              </li>
	              <c:if test="${list.sale_price != 0 }">
		              <li class="icons"> 
		                <span class="MK-product-icons"><img src="${contextPath }/resources/image/pro_discount_2.gif" class="MK-product-icon-2"></span>											
		              </li>
	              </c:if>
	              <c:if test="${list.product_sort == '베스트' }">
		              <li class="icons"> 
		                <span class="MK-product-icons"><img src="${contextPath }/resources/image/best.png" class="MK-product-icon-2"></span>											
		              </li>
	              </c:if>
	              <li>
	              	<fmt:formatNumber value="${list.origin_price }" type="number" var="origin_price" />
	              	<c:if test="${list.sale_price != 0 }">
						<span class="price-strike">
							${origin_price }원
						</span>
			            <fmt:formatNumber value="${list.sale_price }" type="number" var="sale_price" />
			            <span class="price">
			                ${sale_price }원
			            </span>
					</c:if>
					<c:if test="${list.sale_price == 0 }">
						<span class="price">
			                ${origin_price }원
			            </span>
					</c:if>	 
	              </li>
	            </ul>	
	          </div>
	          </c:forEach>
	        </div>
	        <!-- product list end -->
          
         	<!-- paging start -->
         	<div class="SMS_list_paging"> 
	          <ul class="paging">
	          	<c:if test="${pageMaker.prev }">
	            	<li class="first"><a href="newProductList.do${pageMaker.makeQuery(pageMaker.startPage - 1) }"><img src="${contextPath }/resources/image/paging_first.gif" alt="맨 처음 페이지 화살표"></a></li>
	            </c:if>
	            <c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage }" >
	            	<li><a href="newProductList.do${pageMaker.makeQuery(idx) }&sort=${sort}">${idx }</a></li>
	            </c:forEach>
	            <!-- <li class="now"><a href="/shop/shopbrand.html?type=P&amp;xcode=036&amp;sort=&amp;page=2">2</a></li> -->
	            <c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
	            	<li class="last"><a href="newProductList.do${pageMaker.makeQuery(pageMaker.endPage + 1) }"><img src="${contextPath }/resources/image/paging_end.gif" alt="마지막 페이지 화살표"></a></li>
	          	</c:if>
	          </ul>
	       </div>
	       <!-- paging end -->
         </div>
        </div>
      </div>
    	<!-- SMS_product_container end -->
    </div>
   </div>
  </div>
</body>
</html>
