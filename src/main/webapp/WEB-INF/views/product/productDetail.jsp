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
<link href="${path}/resources/css/productDetail.css" rel="stylesheet" type="text/css" media="screen"/>
<script src="${path }/resources/js/jquery-1.6.2.min.js"></script> <!-- tab_container JS --> 
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
    
    
</div>	<!-- productDetail -->
</div> <!-- product_container -->
</body>

</html>
