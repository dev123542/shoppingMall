<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="productList" value="${productMap.productList}" />
<c:set var="modelList" value="${productMap.modelList}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Dashboard">
  <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
  <title>상품 관리</title>
  <script src="${contextPath }/resources/lib/jquery/jquery.min.js"></script>
  <script type="text/javascript">
  	$(document).ready(function(){
  		
	  	// 전체 선택
  		$("#ck_all").click(function(){
			if($("#ck_all").prop("checked")){
				$("input[type=checkbox]").prop("checked",true);
			}else{
				$("input[type=checkbox]").prop("checked",false);
			}
		});
	  	
	  	
  		/* $("input[id='search_option']").click(function(){
			 
		    var product_name=$('#product_name').val();
		    var product_sort=$('input:radio[name=product_sort]:checked').val();
		    var cate_parent=$('#select1').val();
		    var origin_price=$('#select2').val();
		
	
		    $('#container').load('${contextPath}/admin/product/productList.do' , 
		        { product_name : product_name, cate_parent : cate_parent, origin_price : origin_price, 
		          product_sort : product_sort
		        });  
		   }); */
  	});
  	
  	// 상품 정보 추가/수정
  	function addNewModel(product_no,cate_code){
		var popupX = (window.screen.width/2)-300;
		var popupY= (window.screen.height/2)-225;
		window.open('${contextPath}/admin/product/addNewModelForm.do?product_no='+product_no+'&cate_code='+cate_code, '모델 추가하기',
				'product_sort=, height=450, width=600, left='+ popupX + ', top='+ popupY);
		
	}
  </script>
  <style type="text/css">
  	img{
  		width:130px;
  	}
  	#frm_search > table > tbody> tr > td{
    	padding: 3px 6px;
    }
  </style>
</head>

<body>
  <section id="container" style="background: #fff;">
    
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper" style="background: #fff;">
        <div style="display: flex; justify-content: space-between; justify-content: space-between; align-items: center;">
          <h3><i class="fa fa-angle-right"></i> 상품 목록</h3>
        </div>

         <div class="col-md-12 mt">
          <div class="searchForm-wrap" style="margin-bottom: 6%;">
              <form action="${contextPath }/admin/product/productList.do" method="post" id="frm_search" style="width: 70%; margin: 0 auto;">
                <table style="margin: 0 auto;">
                  <tr>
                    <td colspan="2">상품명&nbsp;&nbsp;</td>
                    <td colspan="5"  class="pleft">
                      <input type="text" name="product_name" placeholder="상품이름을 입력하세요" id="product_name" class="form-control"/>				
                     </td>
                  </tr>
                  
                  <tr>
                    <td colspan="2">상품구분&nbsp;&nbsp;</td>
                    <td colspan="5"  class="pleft">
                      <input type="radio" value="all" name="product_sort" checked >전체
                      <input type="radio" value="신상품" name="product_sort" >신상품
                      <input type="radio" value="베스트" name="product_sort" >베스트
                      <input type="radio" value="잇백" name="product_sort" >잇백
                      <input type="radio" value="할인" name="product_sort" >할인
                      <input type="radio" value="품절" name="product_sort" >품절
                     </td>
                  </tr>
                  
                  <tr>
                    <td colspan="2">상품분류&nbsp;&nbsp;</td>
                    <td colspan="5"  class="pleft" style="display: flex;">
                      <select name="cate_parent" id="select1" class="form-control"> 
                        <option value= "" selected>--대분류 선택--</option>
                        <option value="100">래더백(100)</option>
                        <option value="200" >트렌드백(200)</option>
                        <option value="300" >에코백(300)</option>
                        <option value="400" >지갑(400)</option>
                        <option value="500">신발(500)</option>
                        <option value="600">가방악세사리(600)</option>
                        <option value="700">악세사리(700)</option>
                      </select>
                      
                      <select id="select2" name="origin_price"  class="form-control">
                        <option value="">--가격분류 선택--</option>
                        <option value="desc">가격 높은순</option>
                        <option value="asc">가격 낮은순</option>
                      </select>
                      
                     </td>
                  </tr>
                  <tr>
                    <td colspan="7" style="text-align: center;">
<!--                       <input type="button" value="검색" id="search_option" class="btn btn-primary"/>&nbsp;&nbsp; -->
                      <input type="submit" value="검색" id="search_option" class="btn btn-primary"/>&nbsp;&nbsp;
                      <input type="reset" value="초기화" class="btn btn-warning"/>
                    </td>
                  </tr>
                  
                </table>
              </form>
            </div>
          
          <div>
            <table class="table table-hover t-center" style="border-top:1px solid; border-bottom:1px solid; text-align: center;">
              <thead style="background: #000; color:#fff;">
                <tr>
                  <!-- <th>#</th> -->
                  <th style="text-align: center;">전체 선택&nbsp;<input type="checkbox" id="ck_all" /></th>
                  <th style="text-align: center;">상품 번호</th>
                  <th style="text-align: center;">상품 대분류 코드</th>
                  <th style="text-align: center;">상품 구분</th>
                  <th style="text-align: center;">상품명</th>
                  <th style="text-align: center;">판매가</th>
                  <th class="col-md-3" style="text-align: center;">상품 정보</th>
                  <th style="text-align: center;">정보 추가</th>
                </tr>
              </thead>
              <tbody>
              <c:choose>
	              <c:when test="${not empty productList }">
		              <c:forEach var="product" items="${productList }" varStatus="status">
		                <tr>
		                  <td style="vertical-align: middle;"><input type="checkbox" name="checkRow" value="${product.product_no}" /></td>
		                  <td style="vertical-align: middle;">${product.product_no }</td>
		                  <td style="vertical-align: middle;">${product.categoryResult.cate_code }</td>
		                  <td style="vertical-align: middle;">${product.product_sort }</td>
		                  <td style="vertical-align: middle;">
		                  	<img src="${contextPath }/thumbnails.do?product_no=${product.product_no}&fileName=${product.product_image}" alt="상품 썸네일 이미지" />
		                  	<div>
			                  	${product.product_name }
		                  	</div>
		                  </td>
		                  <td style="vertical-align: middle;">
		                  	<fmt:formatNumber value="${product.origin_price }" type="number" var="origin_price" />
		                  	${origin_price }원
		                  </td>
		                  <td style="vertical-align: middle;">
		                  	<c:choose>
		                  		<c:when test="${empty product.cate_name && empty product.product_color && empty modelList }">
		                  			<p>등록된 정보가 없습니다</p>
		                  		</c:when>
			                  	<c:otherwise>
			                  		<c:if test="${not empty product.cate_name && not empty product.product_color}">
			                  			<ul style="margin:0;">
			                  				<li>
			                  					<ul>
			                  						<li>[${product.cate_name }/</li>
			                  						<li>${product.product_color }]</li>
			                  						
			                  						<c:forEach var="model" items="${modelList }">
				                  						<c:if test="${not empty modelList && model.product_no == product.product_no}">
					                  						<li>
					                  							<ul>
					                  								<li>[${model.cate_name }/</li>
					                  								<li>${model.product_color }]</li>
					                  							</ul>
					                  						</li>
				                  						</c:if>
			                  						</c:forEach>
			                  					</ul>
			                  				</li>
			                  			</ul>
			                  		</c:if>
			                  	</c:otherwise>		
		                  	</c:choose>
				          </td>
		                  <td style="vertical-align: middle;"><button type="button" class="btn btn-primary" onclick="addNewModel('${product.product_no}','${product.categoryResult.cate_code }')">추가</button></td>
		                </tr>
		              </c:forEach>
	              	</c:when>
	              <c:otherwise>
	              	<tr>
	              		<td>없음</td>
	              		<td>없음</td>
	              		<td>없음</td>
	              		<td>없음</td>
	              		<td>없음</td>
	              		<td>없음</td>
	              		<td>없음</td>
	              		<td>없음</td>
	              	</tr>
	              </c:otherwise>
              </c:choose>	
              </tbody>
            </table>
          </div>
        </div>
        
       <!-- paging start -->
         	<div class="center-block" style="text-align: center;" > 
	          <ul  class="pagination">
	          	<c:if test="${pageMaker.prev }">
	            	<li class="prev"><a href="productList.do${pageMaker.makeAdminSearch(pageMaker.startPage - 1) }">이전</a></li>
	            </c:if>
	            <c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage }" >
	            	<li><a href="productList.do${pageMaker.makeAdminSearch(idx) }">${idx }</a></li>
	            </c:forEach>
	            <!-- <li class="now"><a href="/shop/shopbrand.html?type=P&amp;xcode=036&amp;sort=&amp;page=2">2</a></li> -->
	            <c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
	            	<li class="next"><a href="productList.do${pageMaker.makeAdminSearch(pageMaker.endPage + 1) }">다음</a></li>
	          	</c:if>
	          </ul>
	       </div>
<%--          	<div class="center-block" style="text-align: center;" > 
	          <ul  class="pagination">
	          	<c:if test="${pageMaker.prev }">
	            	<li class="prev"><a href="productList.do${pageMaker.makeQuery(pageMaker.startPage - 1) }">이전</a></li>
	            </c:if>
	            <c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage }" >
	            	<li><a href="productList.do${pageMaker.makeQuery(idx) }">${idx }</a></li>
	            </c:forEach>
	            <!-- <li class="now"><a href="/shop/shopbrand.html?type=P&amp;xcode=036&amp;sort=&amp;page=2">2</a></li> -->
	            <c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
	            	<li class="next"><a href="productList.do${pageMaker.makeQuery(pageMaker.endPage + 1) }">다음</a></li>
	          	</c:if>
	          </ul>
	       </div> --%>
	       <!-- paging end -->
        
      </section>
    </section>
      
  </section>
</body>
</html>