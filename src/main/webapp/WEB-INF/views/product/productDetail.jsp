<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" 	isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="product" value="${productMap.productVO}" />
<%-- <c:set var="imageList" value="${productMap.imageList }" /> --%>
<%
     //치환 변수 선언합니다.
      //pageContext.setAttribute("crcn", "\r\n"); //개행문자
      pageContext.setAttribute("crcn" , "\n"); //Ajax로 변경 시 개행 문자 
      pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<html>

<head>
<link href="${path}/resources/css/style.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/productDetail.css" rel="stylesheet" type="text/css" media="screen"/>
<script src="${path }/resources/js/jquery-3.5.1.min.js"></script>
<!--<script src="${path }/resources/js/jquery-1.6.2.min.js"></script>  tab_container JS --> 
<script src="${path }/resources/js/tabs.js"></script> <!-- tab_container JS --> 
<script type="text/javascript">
        function add_cart(product_no) {
        	if(${member != null}){
	            $.ajax({
	                type: "post",
	                url: "${path}/cart/addProductInCart.do",
	                data: {
	                    product_no:product_no
	                },
	                success : function(data, textStatus) {
	    				if(data.trim()=='add_success'){
	    					imagePopup('open');	
	    				}else if(data.trim()=='already_existed'){
	    					alert("이미 카트에 등록된 상품입니다.");	
	    				}
	    			},
	                error: function(data, textStatus) {
	                    alert("에러가 발생했습니다. 관리자에게 문의하여 주세요." + data);
	                },
	                complete: function(data, textStatus) {
	                    //alert("작업을완료 했습니다");
	                }
	            }); //end ajax	
        	}else {
        		alert("쇼핑몰 회원만 이용가능합니다. 로그인 후 이용해주세요.");
        		location.href = "${path }/member/loginForm.do";
        	}
        }

        function imagePopup(type) {
            if (type == 'open') {
                jQuery('#layer').attr('style', 'visibility:visible');
                jQuery('#layer').height(jQuery(document).height());
            } else if (type == 'close') {
                jQuery('#layer').attr('style', 'visibility:hidden');
            }
        }

      /*   function fn_order_each_product(product_no, product_name, sales_price, file_name) {
            var _isLogOn = document.getElementById("isLogOn");
            var isLogOn = _isLogOn.value;

            if (isLogOn == "false" || isLogOn == '') {
                alert("로그인 후 주문이 가능합니다!!!");
            }


            var total_price, final_total_price;
            var order_product_qty = document.getElementById("order_product_qty");

            var formObj = document.createElement("form");
            var i_product_no = document.createElement("input");
            var i_product_title = document.createElement("input");
            var i_product_sales_price = document.createElement("input");
            var i_fileName = document.createElement("input");
            var i_order_product_qty = document.createElement("input");

            i_product_no.name = "product_no";
            i_product_title.name = "product_title";
            i_product_sales_price.name = "product_sales_price";
            i_fileName.name = "product_fileName";
            i_order_product_qty.name = "order_product_qty";

            i_product_no.value = product_no;
            i_order_product_qty.value = order_product_qty.value;
            i_product_title.value = product_title;
            i_product_sales_price.value = product_sales_price;
            i_fileName.value = fileName;

            formObj.appendChild(i_product_no);
            formObj.appendChild(i_product_title);
            formObj.appendChild(i_product_sales_price);
            formObj.appendChild(i_fileName);
            formObj.appendChild(i_order_product_qty);

            document.body.appendChild(formObj);
            formObj.method = "post";
            formObj.action = "${path}/order/orderEachGoods.do";
            formObj.submit();
        } */

        
	 // 상품 후기 관련 제이쿼리        
	 $(document).ready(function(){
		 
		  // 후기 작성 팝업창
	      $('.write-review').on('click', function(){
	            $('.review-dimm').addClass('on');
	      });
	      
	      // 후기 작성 닫힘 버튼
	       $('.review-close').on('click', function(){
	    	   $('.rating a').removeClass('on');
	           $("#review_star").val('');
	           $('.prv-img > img').remove();
	           $('#file-item').css('display', 'none');
	           $('.review-txt').val('');
	    	   $('.review-dimm').removeClass('on');
	      }); 
	
	      // input file
	       $('.file-label').click(function (e) {
	        e.preventDefault();
	        $('#review-file').click();
	      }); 
	      
	      // 후기를 눌렀을 때
	       $('.review-top').on('click', function(e){
	
	        e.preventDefault();
	
	        var reviewBottom = $(this).next('#review-bottom');
	        var li = $(this).parents('.review-list-item');
	        var prv = $(this).find('.p-prv');
	
	        if(reviewBottom.css('display') == 'none'){
	          reviewBottom.css('display', 'block');
	          li.css('background', '#f5f5f5');
	          prv.css('opacity', '0');
	
	        } else{
	          reviewBottom.css('display', 'none');
	          li.css('background', 'none');
	          prv.css('opacity', '1');
	        }
	        
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
      
</script>
<style>
        #layer {
            z-index: 2;
            position: absolute;
            top: 0px;
            left: 0px;
            width: 100%;
            font:10px
        }

        #popup {
            z-index: 3;
            position: fixed;
            text-align: center;
            left: 50%;
            top: 45%;
            width: 300px;
            height: 200px;
            background-color: #fff;
            border: 3px solid #87cb42;
            font:10px
        }

        #close {
            z-index: 4;
            float: right;
        }

		/* tab */
		#tab_container_wrap .tabs{
			  margin-top: 80px;
			  margin-bottom: 30px;
			  display: -webkit-box;
			  display: -ms-flexbox;
			  display: flex;
			  -webkit-box-orient: horizontal;
			  -webkit-box-direction: normal;
			      -ms-flex-flow: row nowrap;
			          flex-flow: row nowrap;
			  -webkit-box-pack: space-evenly;
			      -ms-flex-pack: space-evenly;
			          justify-content: space-evenly;
			  position: relative;
			  border: 1px solid #bcb8b9;
			  border-right:0;
		}
		
		#tab_container_wrap ul.tabs .tab-01 a{
			color: #fff;
		}
		#tab_container_wrap ul.tabs .tab-01{
			background: #002157;
		}
		#tab_container_wrap ul.tabs li:nth-child(-n+5){
			border-right: 1px solid #bcb8b9;
		}
		
		#tab_container_wrap ul.tabs li{
		    width: 299px;
		    height: 42px;
		    text-align: center;
		    line-height: 40px;
		}
		
		.tab_content ul.tabs .tabs-02 a,
		.tab_content ul.tabs .tabs-03 a,
		.tab_content ul.tabs .tabs-04 a,
		.tab_content ul.tabs .tabs-05 a{
			color: #fff;
		}
		.tab_content ul.tabs .tabs-02,
		.tab_content ul.tabs .tabs-03,
		.tab_content ul.tabs .tabs-04,
		.tab_content ul.tabs .tabs-05{
			background: #002157;
		}
		
		.service_information_img{
			text-align:center;
		}
</style>   
</head>
<body>
<div class="product_container">
<div class="productDetail inbox">
    <div class="flex_right">
        <!-- 나중에 수정 -->
        <a href=""><img src="" alt="">WHOSBAG</a> &gt;
        <a href="">LEATHER BAG</a> &gt;
        <a href="">TOTE - ${product.product_no}</a>
    </div>
    <div class="product_wrap">
    <div class="product_wrap_01">
        <figure>
            <img alt="상품이미지" src="${path}/thumbnails.do?product_no=${product.product_no}&fileName=${product.product_image}">
        </figure>
    </div>
    
    <div class="product_wrap_02">
        <h3 class="tit-prd">${product.product_name } [${product.product_color } COLOR] </h3>
        <!-- 베스트 이미지 등.. 넣기 -->
        <h2 class="tit-icons"><span class="MK-product-icons"><img src="" class="MK-product-icon-2"></span></h2>
        <div class="SMS_table_opt1">
            <!-- 판매가격, 적립금 -->
            <dl class="SMS_price cb_clear">
                <dt>PRICE</dt>
                <dd>
                    <span class="SMS_main_display_sales_p strike">${product.origin_price }</span>
                    <span class="SMS_main_display_discount_p">${product.sale_price }</span>
                </dd>
            </dl>
            <!-- 포인트 자리 -->
            <!--  <dl class="SMS_reserve 22 cb_clear">
                <dt>POINT</dt>
                <dd>
                    1% </dd>
            </dl> -->
        </div>
    

        <div class="SMS_table_opt4">
            <!-- 기본 옵션 (기본) -->
            <div class="opt-wrap">
                <div class="SMS_optcountbox">
                    <dl class="SMS_optcount cb_clear">
                        <!-- 기본옵션 -->
                        <dt>COLOR</dt>
                        <dd>
                            <!-- <select id="optionlist_0" name="optionlist[]" class="vo_value_list" onchange="priceCalculate(this);" mandatory="Y"> -->
                            <select name="product_color" class="form-control">
                                <option value="상품색상">색상을 선택하세요</option>
                                <option value="${product_color }">${product.product_color }</option>
                                <!-- <option value="머드">머드</option>
                                <option value="카멜">카멜</option>
                                <option value="브라운">브라운</option>
                                <option value="블랙">블랙</option>
                                <option value="아이보리">아이보리</option>
                                <option value="베이지">베이지</option>
                                <option value="카키">카키</option>
                                <option value="네이비">네이비</option>
                                <option value="그레이">그레이</option>
                                <option value="그린">그린</option>
                                <option value="옐로우">옐로우</option>
                                <option value="오렌지">오렌지</option>
                                <option value="화이트">화이트</option>
                                <option value="스카이">스카이</option>
                                <option value="라벤더">라벤더</option>
                                <option value="핑크">핑크</option>
                                <option value="올리브">올리브</option>
                                <option value="차콜">차콜</option>
                                <option value="와인">와인</option>
                                <option value="코발트블루">코발트블루</option>
                                <option value="타프베이지">타프베이지</option>
                                <option value="실버">실버</option> -->
                            </select>
                        </dd>
                    </dl>
                </div>
            </div>
        </div>

        <div class="SMS_table_opt4">
            <div class="opt-wrap">
                <dl class="SMS_quantity cb_clear">
                    <dt>QUANTITY</dt>
                    <dd>
                        <div class="opt-btns">
                            <!-- 수량 증가, 감소 -->
                            <a href="javascript:CountChange('down');">-</a>
                            <input type="text" id="product_amount" name="amount" value="1" size="4" >
                            <a href="javascript:CountChange('up');">+</a>
                        </div>
                    </dd>
                </dl>
            </div>
        </div>

        <div class="SMS_table_opt3">
	        <!-- 옵션적용가격 -->
	            <dt></dt>
	            <%-- <dd><span class="tit_txt">전체 상품 가격 : </span><span class="total_price"><span id="price_text">${product.sale_price }</span></span>원</dd> --%>
	            <dd><span class="tit_txt">전체 상품 가격 : </span><span class="total_price">
	            <fmt:formatNumber value="${product.sale_price}" pattern="###,###,###"/></span>원</dd>
	        </dl>
        </div>
            
         <div class="prd-btns">
<%-- 			<a href="${path }/order/orderMain.do?product_no=${product.product_no}&product_name=${product.product_name }&sale_price=${product.sale_price}&fileName=${product.fileName}', '${product.product_color }"> --%>
			<a href="${path }/order/orderMain.do">
				<img class="smp-btn-cart tb_tagManagerCart" src="${path }/resources/image/btn_h46_order.gif" alt="주문하기" title="주문하기" /></a>
			<a id="cartBtn" href="javascript:add_cart('${product.product_no }')">
				<img class="smp-btn-cart tb_tagManagerCart" src="${path }/resources/image/btn_h46_cart_add.gif" alt="장바구니 담기" title="장바구니 담기" /></a>
		 </div>
		
    	</div> <!-- SMS_table_opt4 -->
</div> <!--product_container -->


<section class="login_banner">
    <div class="login_banner_box">
        <ul>
            <li><a href="${path }/"><img src="${path }/resources/image/join_members_01.jpg" title="신규회원" /></a></li>
            <li><a href="${path }/"><img src="${path }/resources/image/join_members_02.jpg" title="추천인" /></a></li>
            <li><a href="${path }/"><img src="${path }/resources/image/join_members_03.jpg" title="회원구매" /></a></li>
            <li><a href="${path }/"><img src="${path }/resources/image/join_members_04.jpg" title="1회이상구매" /></a></li>
            <li><a href="${path }/"><img src="${path }/resources/image/join_members_05.jpg" title="구매후" /></a></li>
            <li><a href="${path }/"><img src="${path }/resources/image/join_members_06.jpg" title="회원이벤트1" /></a></li>
            <li><a href="${path }/"><img src="${path }/resources/image/join_members_07.jpg" title="회원이벤트2" /></a></li>
            <li><a href="${path }/"><img src="${path }/resources/image/join_members_08.jpg" title="회원이벤트3" /></a></li>
        </ul>
    </div>
</section> <!-- .login_banner -->


<!-- <h3 id="01" class="tit-detail cb_clear">
    <img class="tapover" src="/design/whosbag/smartpc/defalut_img/detail_tap01_over.gif" alt="detail prdoduct - 상품상세정보" title="detail prdoduct - 상품상세정보" onclick="location.href='#01'">
    <img class="tapnormal" src="/design/whosbag/smartpc/defalut_img/detail_tap02.gif" alt="detail prdoduct - 배송,교환,반품안내" title="detail prdoduct - 배송,교환,반품안내" onclick="location.href='#02'">
    <img class="tapnormal" src="/design/whosbag/smartpc/defalut_img/detail_tap03.gif" alt="relation product - 코디상품" title="relation product - 코디상품" onclick="location.href='#03'">
    <img class="tapnormal" src="/design/whosbag/smartpc/defalut_img/detail_tap04.gif" alt="detail prdoduct - 상품후기" title="detail prdoduct - 상품후기" onclick="location.href='#04'">
    <img class="tapnormal" src="/design/whosbag/smartpc/defalut_img/detail_tap05.gif" alt="detail prdoduct - Q&amp;A" title="detail prdoduct - Q&amp;A" onclick="location.href='#05'">
</h3>
 -->        
        <!-- 내용 들어 가는 곳 -->
	<div id="tab_container_wrap">
		<ul class="tabs">
			<li class="tab-01"><a href="#tab1" >상품상세정보</a></li>
			<li><a href="#tab2">배송,교환,반품안내</a></li>
			<!-- <li><a href="#tab3">다른상품</a></li> -->
			<li><a href="#tab4">상품후기</a></li>
			<li><a href="#tab5">Q&amp;A</a></li>
		</ul>
		<div class="detailinfo">
			<div class="tab_content" id="tab1">
				<!-- <h4>상품상세정보</h4> -->				
				<%-- <p>${fn:replace(product.product_image,crcn,br)}</p> --%>
				
				<!--  since2004.jpg 경로 찾기 -->
				<%-- <c:forEach var="image" items="${imageList }"> --%>
					<div style="text-align:center;">
						${product.product_content }
					</div>
					<%-- <img src="${path}/download?product_no=${product.product_no}&fileName=${image.file_name}"> --%>
					<%-- <img alt="상품이미지" src="${path}/thumbnails.do?product_no=${product.product_no}&fileName=${product.product_image}"> --%>
				<%-- </c:forEach> --%>
			</div>
			<div class="tab_content" id="tab2">
				<ul class="tabs">
					<li><a href="#tab1">상품상세정보</a></li>
					<li class="tabs-02"><a href="#tab2">배송,교환,반품안내</a></li>
					<!-- <li><a href="#tab3">다른상품</a></li> -->
					<li><a href="#tab4">상품후기</a></li>
					<li><a href="#tab5">Q&amp;A</a></li>
				</ul>
				<div class="service_information">
					<div class="service_information_img">
						<img src="${path }/resources/image/whosbagnotice.jpg" alt="배송안내이미지" />
					</div>
				</div>
				
				<!-- <h4>배송,교환,반품안내</h4> -->
				 <%-- <p>${fn:replace(product.product_writer_intro,crcn,br) }</p>  --%>
			</div>
			<%-- <div class="tab_content" id="tab3">
				<ul class="tabs">
						<li><a href="#tab1">상품상세정보</a></li>
						<li><a href="#tab2">배송,교환,반품안내</a></li>
						<li class="tabs-03"><a href="#tab3">다른상품</a></li>
						<li><a href="#tab4">상품후기</a></li>
						<li><a href="#tab5">Q&amp;A</a></li>
				</ul>
				<!-- <h4>코디상품</h4> -->
				<p>${fn:replace(product.product_contents_order,crcn,br)}</p> 
			</div>  --%>
			<div class="tab_content" id="tab4">
				<ul class="tabs">
						<li><a href="#tab1">상품상세정보</a></li>
						<li><a href="#tab2">배송,교환,반품안내</a></li>
						<!-- <li><a href="#tab3">다른상품</a></li> -->
						<li class="tabs-04"><a href="#tab4">상품후기</a></li>
						<li><a href="#tab5">Q&amp;A</a></li>
				</ul>
				
				<!-- 후기 목록 -->
				  <section class="review-container">
				    <div class="review-wrap">
				      <div class="write-review-box"> 
<!--				        <div class="write-review" onclick="write()">후기 쓰기</div>-->
 				        <a href="#" class="write-review">후기 쓰기</a>
 				        <a href="javascript:" onClick="javascript:imagePopup('close');"> </a>
				      </div>
				
				      <!-- 후기 -->
				      <div class="review-list-box">
				        <ul class="review-list">
				          <li class="review-list-item">
				            <!-- 후기 한 줄 컨테이너 -->
				            <div class="review-box">
				              <!-- 바로 보여지는 글 부분 -->
				              <div class="review-top">
				                <a href="#" class="review-top-inner">
				                  <div class="review-top-info">
				                    <!-- 별점 -->
				                    <span class="cell-rating">
				                      <span class="rating">
				                        <span class="rating-item">
				                        <!-- 별 하나를 반복해서? -->
				                          <span id="1">★</span>
					                      <span id="2">★</span>
					                      <span id="3">★</span>
					                      <span id="4">★</span>
					                      <span id="5">★</span>	
				                        </span>
				                      </span>
				                    </span>
				                    <!-- 작성 회원 아이디 -->
				                    <span class="cell-reviewer">
				                      <span>회원</span>
				                    </span>
				                    <!-- 작성일 -->
				                    <div class="cell-date">
				                      <span>2021.03.03</span>
				                    </div>
				                  </div>
				                  <p class="review-title">
				                    <span class="review-area">너무 좋아요</span>
				                    <span class="photo-prv">
				                      <span class="photo-box">
				                        <span class="photo">
				                          <img src="${path }/resources/image/group01-banner02.jpg" alt="" class="p-load p-prv" />
				                        </span>
				                      </span>
				                    </span>
				                  </p>
				                </a>
				              </div>
				              <!-- review-top end -->
				    
				              <!-- 후기를 누르면 자세히 나오는 내용 -->
				              <div id="review-bottom">
				                <div class="review-detail">
				                  <ul class="review-detail-list">
				                    <li class="review-detail-item">
				                      <div class="detail-photo-box">
				                        <div class="photo">
				                          <img src="${path }/resources/image/group01-banner02.jpg" alt="" class="p-load p-prv" />
				                        </div>
				                      </div>
				                    </li>
				                  </ul>
				                </div>
				              </div>
				              <!-- review-bottom end -->
				            </div>
				          </li>
				    
				          <!-- 2 -->
				          <li class="review-list-item">
				            <!-- 후기 한 줄 컨테이너 -->
				            <div class="review-box">
				              <!-- 바로 보여지는 글 부분 -->
				              <div class="review-top">
				                <a href="#" class="review-top-inner">
				                  <div class="review-top-info">
				                    <!-- 별점 -->
				                    <span class="cell-rating">
				                      <span class="rating">
				                        <span class="rating-item">
					                        <span id="1">★</span>
						                    <span id="2">★</span>
						                    <span id="3">★</span>
						                    <span id="4">★</span>
						                    <span id="5">★</span>
					                    </span>
				                      </span>
				                    </span>
				                    <!-- 작성 회원 아이디 -->
				                    <span class="cell-reviewer">
				                      <span>회원</span>
				                    </span>
				                    <!-- 작성일 -->
				                    <div class="cell-date">
				                      <span>2021.03.03</span>
				                    </div>
				                  </div>
				                  <p class="review-title">
				                    <span class="review-area">너무 좋아요</span>
				                    <span class="photo-prv">
				                      <span class="photo-box">
				                        <span class="photo">
				                          <img src="${path }/resources/image/group01-banner01.jpg" alt="" class="p-load p-prv" />
				                        </span>
				                      </span>
				                    </span>
				                  </p>
				                </a>
				              </div>
				              <!-- review-top end -->
				    
				              <!-- 후기를 누르면 자세히 나오는 내용 -->
				              <div id="review-bottom">
				                <div class="review-detail">
				                  <ul class="review-detail-list">
				                    <li class="review-detail-item">
				                      <div class="detail-photo-box">
				                        <div class="photo">
				                          <img src="${path }/resources/image/group01-banner01.jpg" alt="" class="p-load p-prv" />
				                        </div>
				                      </div>
				                    </li>
				                  </ul>
				                </div>
				              </div>
				              <!-- review-bottom end -->
				            </div>
				          </li>
				    
				        </ul>
				      </div>
				      <!-- review-list-box end -->
				    </div>
				  </section>
				  <!-- review section end -->
				
				<!-- paging start -->
         	<%-- <div class="SMS_list_paging"> 
	          <ul class="paging">
	          	<c:if test="${pageMaker.prev }">
	            	<li class="first"><a href="newProductList.do${pageMaker.makeQuery(pageMaker.startPage - 1) }"><img src="${path }/resources/image/paging_first.gif" alt="맨 처음 페이지 화살표"></a></li>
	            </c:if>
	            <c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage }" >
 	            	<li><a href="newProductList.do${pageMaker.makeQuery(idx) }&s=${s}&sort=${sort}">${idx }</a></li>
 	            	<li><a href="newProductList.do${pageMaker.makeQuery(idx) }&sort=${sort}">${idx }</a></li>
	            </c:forEach>
	            <!-- <li class="now"><a href="/shop/shopbrand.html?type=P&amp;xcode=036&amp;sort=&amp;page=2">2</a></li> -->
	            <c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
	            	<li class="last"><a href="newProductList.do${pageMaker.makeQuery(pageMaker.endPage + 1) }"><img src="${path }/resources/image/paging_end.gif" alt="마지막 페이지 화살표"></a></li>
	          	</c:if>
	          </ul>
	       </div> --%>
	 <!-- paging end -->
				
				
				<!-- <h4>상품후기</h4> -->
				 <%-- <p>${fn:replace(product.product_publisher_comment ,crcn,br)}</p> --%> 
			</div>
			<div class="tab_content" id="tab5">
				<ul class="tabs">
						<li><a href="#tab1">상품상세정보</a></li>
						<li><a href="#tab2">배송,교환,반품안내</a></li>
						<!-- <li><a href="#tab3">다른상품</a></li> -->
						<li><a href="#tab4">상품후기</a></li>
						<li class="tabs-05"><a href="#tab5">Q&amp;A</a></li>
				</ul>
				
				<!-- <h4>Q&amp;A</h4> -->
				<%-- <p>${fn:replace(product.product_recommendation,crcn,br) }</p> --%>
			</div>
		</div>
	</div>
	
	<div class="clear"></div>
	<div id="layer" style="visibility: hidden">
		<div id="popup">
			<!-- 팝업창 닫기 버튼 -->
			<a href="javascript:" onClick="javascript:imagePopup('close');"> 
				<img src="${path}/resources/image/close.png" id="close" />
			</a><br /> <font size="10px" id="contents">장바구니에 담았습니다.</font><br>
			<form action="${path }/cart/myCartList.do" >				
				<a href="${path }/cart/myCartList.do">
				<input type="submit" value="장바구니 보기"></a>
			</form>
		</div>		       
        <input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>
    </div>
    
    <!-- 상품 후기 작성 팝업 -->
    <form action="${path }/product/writeReview" method="post" enctype="multipart/form-data">
    <input type="hidden" name="product_no" value="${product.product_no }" />
    
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
                  <img src="${path}/thumbnails.do?product_no=${product.product_no}&fileName=${product.product_image}" alt="후기 작성 상품 이미지" />
                </div>
              </div>
              <div class="review-product-info">
                <strong>${product.product_name }</strong>
                <span>${product.product_color }</span>
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
          <input type="hidden" id="review_star" name="review_star" value="" />
        </div>


      </div>

      <!-- 사진첨부 -->
      <div class="review-file-box">
        <div class="input-file">
          <!-- 사진 미리보기 처음엔 ul이 없다가 사진을 올리면 나타나고 x버튼을 누르면 사진 삭제 처리하기 -->
          <ul class="file-list">
            <li id="file-item">
              <span class="prv-box">
                <span class="prv-img"></span>
              </span>
              <button type="button" class="prv-remove" onclick="deleteThumbnail()">삭제</button>
            </li>
          </ul>
          <div class="input-file-box">
            <label for="" class="file-label">사진첨부</label>
            <input type="file" name="review-file" id="review-file" accept="image/*" onchange="setThumbnail(event)"  />
          </div>
        </div>
      </div>

      <!-- 후기 내용 -->
      <div class="review-txt-box">
        <textarea name="review-txt" class="review-txt" cols="80" rows="6" placeholder="최소 15자 이상 작성 해 주세요."></textarea>
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
      
      <button type="button" class="review-button">작성하기</button>
      </section>
    </div>
  </form>
  <!-- review form end -->  
    
</div>	<!-- productDetail -->
</div> <!-- product_container -->
</body>

</html>
