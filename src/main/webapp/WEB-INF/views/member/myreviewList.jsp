<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${path }/resources/css/style.css" />
<script type="text/javascript" src="${path }/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
//상품 후기 관련 제이쿼리        
$(document).ready(function(){
	 
	  // 후기 수정 팝업창
     $('#updateReview').on('click', function(){
    	 console.log("눌림");
	     $('.review-dimm').addClass('on');
     });
     
     // 후기 수정창 닫힘 버튼
      $('.review-close').on('click', function(){
   	   $('.rating a').removeClass('on');
          $("#review_star").val('');
          $('.prv-img > img').remove();
          $('#file-item').css('display', 'none');
          $('.review_txt').val('');
   	   $('.review-dimm').removeClass('on');
     }); 

     // input file 실행
      $('.file-label').click(function (e) {
       e.preventDefault();
       $('#review_file').click();
     }); 
     
     
     // 후기 작성 별점
      $( ".rating a" ).click(function() {
          $(this).parent().children("a").removeClass("on");
          $(this).addClass("on").prevAll("a").addClass("on");
          var starRate = $(this).attr('id');
          $("#review_star").val(starRate);
              return false;
      });
       
 });       
   
	// 후기 사진 등록 썸네일
	function setThumbnail(event){
		var reader = new FileReader();
			
		reader.onload = function(event){
	 		var li = document.getElementById("file-item");
			var img = document.createElement("img");
			
			img.setAttribute("src", event.target.result);
	 		li.style.display = "block";
			document.querySelector(".prv-img").appendChild(img);
		};
		
		reader.readAsDataURL(event.target.files[0]);
	}
	
	// 썸네일 이미지 지우기
	function deleteThumbnail(){
		var li = document.getElementById("file-item");
		var img = document.querySelector(".prv-img > img");
		img.remove();
		li.style.display = "none";
	}  
	
	// 삭제 버튼 눌렀을 때
	function deleteReview(product_no){
		if(confirm("정말 삭제하시겠습니까?") == true){
			location.href="${path}/review/deleteReview?product_no="+product_no;
		}else{
			return;
		}
	}
</script>
<style type="text/css">
	.empty-list{
		padding: 80px 0;
	    border-bottom: 1px solid #d4d4d4;
	    text-align: center;
	    line-height: 24px;
	}
</style>
</head>
<body>
  <section class="my-review" style="max-width:1200px; margin:0 auto;">
    <div class="my-review-container">
      <div class="title-wrap">
        <h3 class="title">후기</h3>
      </div>
      <!-- 후기 목록 -->
      <div class="written-review">
        <ul class="review-list">
        <c:if test="${empty reviewList }">
       		<div class="empty-list">작성한 후기가 없습니다</div>
        </c:if>
        <c:forEach items="${reviewList }" var="review">
          <li class="review-item">
            <div class="reviews">
              <div class="product-row">
                <div class="in-td col1">
                  <div class="info-box">
                    <a href="${path }/product/productDetail.do?product_no=${review.product_no}" class="info">
                      <div class="image-box">
                        <div class="image-in">
                          <img src="${path }/thumbnails.do?product_no=${review.product_no}&fileName=${review.productResult.product_image}" alt="후기 상품 이미지" class="p-prv p-load">
                        </div>
                      </div>
                      <span class="product">${review.productResult.product_name }</span>
                      <p class="product-color">${review.productResult.product_color }</p>
                    </a>
                  </div>
                  <!-- 별점 -->
                  <div class="review-rating-box">
                    <div class="review-rating">
                    <c:set var="star"  value="${review.review_star }" />
                     <c:choose>
                     	<c:when test="${star eq 5 }">
                      		<a href="#" id="5">★★★★★</a>
                      	</c:when>
                      	<c:when test="${star eq 4 }">
                      		<a href="#" id="4">★★★★</a>
                      	</c:when>
                      	<c:when test="${star eq 3 }">
                      		<a href="#" id="3">★★★</a>
                      	</c:when>
                      	<c:when test="${star eq 2 }">
                      		<a href="#" id="2">★★</a>
                      	</c:when>
                      	<c:when test="${star eq 1 }">
                      		<a href="#" id="1">★</a>
                      	</c:when>
                      	<c:otherwise>
                      		<a href="#" style="color: #ccc;">★★★★★</a>
                      	</c:otherwise>
                     </c:choose>  
                    </div>
                  </div>
                  <!-- 내용 -->
                  <ul>
                    <div class="txt-full">
                      <div class="txt-in">
                        <p>${review.review_txt }</p>
                      </div>
                    </div>
                  </ul>
                  <c:if test="${not empty review.review_file }">
	                  <ul class="review-image">
	                    <li>
	                      <div class="image-box">
	                        <div class="image-in">
	                          <img src="${path }/reviewImage?product_no=${review.product_no}&review_file=${review.review_file}" alt="후기 이미지" class="p-load p-prv">
	                        </div>
	                      </div>
	                    </li>
	                  </ul>
                  </c:if>
                </div>
                <!-- col1 end -->
                <div class="in-td col2">
                <fmt:formatDate value="${review.reg_date }" pattern="yyyy.MM.dd" var="reg_date"/>
                  <p>${reg_date }</p>
                </div>
                <div class="in-td col3">
                  <button type="button" class="btn-wr" id="updateReview">수정</button>
                  <button type="button" class="btn-wr" onclick="deleteReview(${review.product_no})">삭제</button>
                </div>
              </div>
            </div>
          </li>
        <%-- </c:forEach> --%>
        </ul>
      </div>
    </div>
    
    <!------------------------------------
                 후기 작성 레이어 팝업            
      ------------------------------------->
    <form action="${path }/review/updateReview" method="post" enctype="multipart/form-data" id="reviewForm">
    <input type="hidden" name="product_no" value="${review.product_no }" />
    
    <div class="review-dimm">
      <section class="review">
      <div class="review-title">
          <h3>후기 작성</h3>
          <button type="button" class="review-close">
              <span>창닫기</span>
          </button>
      </div>  
      <!-- 상품 -->
      <div class="review-product-area">
          <div class="review-product">
            <div class="review-box">
              <div class="review-img-box">
                <div class="review-img">
                  <img src="${path}/thumbnails.do?product_no=${review.product_no}&fileName=${review.productResult.product_image}" alt="후기 작성 상품 이미지" />
                </div>
              </div>
              <div class="review-product-info">
                <strong>${review.productResult.product_name }</strong>
                <span>${review.productResult.product_color }</span>
              </div>
            </div>
          </div>
      </div>

	  <!-- 별점 -->
      <div class="rating-box">
        <strong>상품은 어떠셨나요?</strong>
        <div class="rating">
		  <a href="#" id="1">★</a>
          <a href="#" id="2">★</a>
          <a href="#" id="3">★</a>
          <a href="#" id="4">★</a>
          <a href="#" id="5">★</a>
          <input type="hidden" id="review_star" name="review_star" value="0" />
        </div>


      </div>

      <!-- 사진 첨부 -->
      <div class="review-file-box">
        <div class="input-file">
          <!-- 사진 미리보기 처음엔 ul이 없다가 사진을 올리면 나타나고 x버튼을 누르면 사진 삭제 처리하기 -->
          <ul class="file-list">
            <li id="file-item">
              <span class="prv-box">
                <span class="prv-img"></span>
              </span>
<%--               <span class="prv-box old">
                <span class="prv-box old">
                	<img src="${path }/reviewImage?product_no=${review.product_no}&review_file=${review.review_file}" alt=""/>
                </span>
              </span> --%>
              <button type="button" class="prv-remove" onclick="deleteThumbnail()">삭제</button>
            </li>
          </ul>
          <div class="input-file-box">
            <label for="review_file" class="file-label">사진첨부</label>
            <input type="file" name="review_file" id="review_file" accept="image/*" onchange="setThumbnail(event)"  />
          </div>
        </div>
      </div>

      <!-- 후기 내용 -->
      <div class="review-txt-box">
        <textarea name="review_txt" class="review_txt" cols="80" rows="6" placeholder="최소 15자 이상 작성 해 주세요.">${review.review_txt }</textarea>
      </div>

      <!-- 후기 안내 -->
      <div class="review-info-box">
        <p>
          <span>
            품질, 배송, 문의 응대 등 상품의 구매 경험을 알려주세요.
          </span>
          상품과 무관한 사진 및 욕설/비속어가 포함된 후기는 고지 없이 삭제될 수 있습니다.<br />
          구매하신 상품을 직접 촬영한 사진만 후기 등록 및 마일리지 지급이 가능합니다.<br />
          해당 사유들로 인해 고지없이 리뷰 및 사진이 삭제되는 경우, 지급 마일리지 일부 또는 전액이 회수될 수 있습니다.<br />
          상품 반품/취소 시, 리뷰 삭제 및 지급 마일리지가 회수 됩니다.
		</p>
      </div>
      
      <button type="submit" class="review-button">수정하기</button>
      </section>
    </div>
  </form>
  </c:forEach>
  <!-- review form end -->  
  </section>
</body>
</html>